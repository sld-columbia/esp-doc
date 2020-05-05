TARGET ?= main
BIB ?= $(TARGET).bib

SRC += $(wildcard ../inc/*.tex)
SRC += $(wildcard *.tex)

FIG += $(wildcard ../fig/*.pdf)
FIG += $(wildcard ../fig/*.png)

TEX_FLAGS += -shell-escape

all: $(TARGET).pdf

$(TARGET).pdf: $(SRC) $(BIB) $(FIG)
	pdflatex $(TEX_FLAGS) $(TARGET)
	@if test -f $(TARGET).aux &&  test `grep citation $(TARGET).aux | wc -l` -ge 1; then bibtex $(TARGET); fi
	pdflatex $(TEX_FLAGS) $(TARGET)
	pdflatex $(TEX_FLAGS) $(TARGET)

clean:
	rm -rf *.aux *.bbl *.blg *.log *.out $(TARGET).pdf *.out _minted* *.toc

.PHONY: all clean
