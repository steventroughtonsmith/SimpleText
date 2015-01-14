#   File:       Makefile
#   Target:     SimpleText
#   Created:    Monday, October 30, 2000 05:02:53 PM
#
#	Adapted	for	https://github.com/ksherlock/mpw
#				by Steven Troughton-Smith
#				Wednesday, January 14, 2015
#

MPW=~/bin/mpw
RINCLUDES=/Applications/MPW-GM/Interfaces\&Libraries/Interfaces/RIncludes

ObjDir=				obj
TypeAndCreator=		-t APPL -c ttxt
Targ=				SimpleText

Sym-cbn=			-sym off

PPCCOptions=	$(Includes) $(Sym-cbn) -proto strict \
				-d TARGET_API_MAC_CARBON=1 \
				-d COMPILING_CARBONLIB=1 \
				-d PM_USE_SESSION_APIS=0

### Source Files ###

SrcFiles=	SimpleText.c \
			AboutBox.c \
			Clipboard.c \
			MovieFile.c \
			PICTFile.c \
			TextFile.c \
			NavigationServicesSupport.c \
			TextDrag.c \
			ThreeDMetafile.c

### Object Files ###

ObjFiles-cbn=	$(SrcFiles:%.c=$(ObjDir)/%.c.o)

### Libraries ###

LibFiles-cbn=	{SharedLibraries}CarbonLib \
				{PPCLibraries}PPCCRuntime.o


### Default Rules ###

$(ObjDir)/%.c.o : %.c
	$(MPW) MrC $< -o $@ $(PPCCOptions)

### Build Rules ###

all: SimpleTextCarbon SimpleTextCarbonRez

SimpleTextCarbon:	$(ObjFiles-cbn)
	$(MPW) PPCLink \
	-o $(Targ) -m main \
	$(ObjFiles-cbn) \
	$(LibFiles-cbn) \
	$(Sym-cbn) \
	-mf -d \
	$(TypeAndCreator)

SimpleTextCarbonRez:
	Rez SimpleText.r Size.r -o $(Targ) -a $(TypeAndCreator) -i $(RINCLUDES)

clean:
	rm -rf $(ObjFiles-cbn) \
	SimpleText

