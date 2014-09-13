@echo off

REM IF "%1"=="" ECHO MyVar is NOT defined 
REM IF "%1"=="" exit /b

if "%1"=="" (
    ECHO MyVar is NOT defined 
	exit /b
) else (
    
@echo Creating package called %1 

REM - Generate the package called the typed input
sencha -sdk ext generate package -type code %1

REM - Copy the build script example into the created package
cd packages
copy exampleBuild.gradle %1\build.gradle
cd %1
cd .sencha/package

REM - Copy the start of the prepend into a temp file
echo package.framework=ext>temp.txt

REM - Add the config file onto the temp file
type sencha.cfg>>temp.txt

REM - Delete the config file
del sencha.cfg

REM - So that you can copy the contents of temp file to the configs old location
rename temp.txt sencha.cfg

cd ../..

REM - Removing folders that we don't need for code based files
RD /Q /S docs
RD /Q /S examples
RD /Q /S licenses
RD /Q /S overrides
RD /Q /S resources
RD /Q /S sass
del del /Q Readme.md
cd src
del /Q Readme.md
cd ..

sencha package build
cd ../..
)
PAUSE