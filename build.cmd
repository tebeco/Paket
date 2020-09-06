@echo off

.paket\paket.exe restore
if errorlevel 1 (
  exit /b %errorlevel%
)

setlocal

set DOTNET_INSTALL_FOLDER=%~dp0.dotnet
set DOTNET_VERSION=3.1.401

powershell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; &([scriptblock]::Create((Invoke-WebRequest -UseBasicParsing 'https://dot.net/v1/dotnet-install.ps1'))) -InstallDir "$($env:DOTNET_INSTALL_FOLDER)" -Version "$($env:DOTNET_VERSION)""
set DOTNET_ROOT=%DOTNET_INSTALL_FOLDER%
set DOTNET_MULTILEVEL_LOOKUP=0
set PATH=%DOTNET_ROOT%;%PATH%

set MSBuild=%~dp0packages\build\RoslynTools.MSBuild\tools\msbuild

packages\build\FAKE\tools\FAKE.exe build.fsx %*

endlocal