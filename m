Return-Path: <linux-fsdevel+bounces-66540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F4CC22E29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 02:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E294188B6E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 01:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736FA24BBEC;
	Fri, 31 Oct 2025 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaCbcenp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131642AA9;
	Fri, 31 Oct 2025 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874502; cv=none; b=Bcl+bzdYCMu54diq/AKl66oZ/MHBS1LeJQa6FbvlBCjYHAkdfQ/KpKU3JK3VuufvCVEOzvWa/eBJ3zSws4QqmeRb+/SP7NjYnYyOw0Yx+k2qTlQuJPrLc1SI+R3+0i0gZk/4ji9hCT9n4/HUYHcToinMblOKLc6r3OwGazYNn9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874502; c=relaxed/simple;
	bh=IFjM2k2z4EJ/Xc3r/firS/GpbsJuWO/1U3he6GWdGDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HahzLW0lXZZNTxQ5x5EI89sQvxdCDwvqiMWqoKBYw235tZ0uX3tYoFJxl42umG2fMt0hr9tfZPaqCWBR3WmAhnZFS08q361Nkz83wJh0E6pzONw3VDtdJkyfgbJnBuaYCZz+ueTXPH3Rh9pNeh5uwiq3uRV0pDoajIriUu5viGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaCbcenp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4569DC4CEFD;
	Fri, 31 Oct 2025 01:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761874502;
	bh=IFjM2k2z4EJ/Xc3r/firS/GpbsJuWO/1U3he6GWdGDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iaCbcenpt7ROb5XZJF8aQ7X0JEak/koOc24LMpxRILcO7Jtpb2+nHDiraX9fLryUR
	 lSaQTdiCAJzz9i8kiM4AJ25H5cWHPQnJtcTr0NvXoULiqx+P9U77aCTubLSB2a9GVn
	 9Ns2QH2RWOPprXrIE2qn/hmqtCgMMK7L5/VNgwiqRyUC22huk5DIWa3Pk+yypZ+7Lk
	 E7nLAUKtKuAarAMvZbUp35gZogKB9oBaF61GeDN3GOfQRNJqvBhL6q0rhNRws0gQoC
	 boA34mTpFVT0rGy+jJNxtvqXpCXh3jwzQAK06V9bcJ2NhBi0bta1XA88P4URaLLL2G
	 qyk7DSsCFnNCA==
Date: Thu, 30 Oct 2025 21:34:57 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-efi@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: fms extension (Was: [PATCH] fs/pipe: stop duplicating union
 pipe_index declaration)
Message-ID: <20251031013457.GA2650519@ax162>
References: <20251029-redezeit-reitz-1fa3f3b4e171@brauner>
 <20251029173828.GA1669504@ax162>
 <20251029-wobei-rezept-bd53e76bb05b@brauner>
 <CAHk-=wjGcos7LACF0J40x-Dwf4beOYj+mhptD+xcLte1RG91Ug@mail.gmail.com>
 <20251030-zuruf-linken-d20795719609@brauner>
 <20251029233057.GA3441561@ax162>
 <20251030-meerjungfrau-getrocknet-7b46eacc215d@brauner>
 <CAMj1kXHP14_F1xUYHfUzvtoNJjPEQM9yLaoKQX=v4j3-YyAn=A@mail.gmail.com>
 <20251030172918.GA417112@ax162>
 <20251030-zukunft-reduzieren-323e5f33dca6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-zukunft-reduzieren-323e5f33dca6@brauner>

On Thu, Oct 30, 2025 at 09:16:02PM +0100, Christian Brauner wrote:
> On Thu, Oct 30, 2025 at 10:29:18AM -0700, Nathan Chancellor wrote:
> > There are several other places in the kernel that blow away
> > KBUILD_CFLAGS like this that will need the same fix (I went off of
> > searching for -std=gnu11, as that was needed in many places to fix GCC
> > 15). It is possible that we might want to take the opportunity to unify
> > these flags into something like KBUILD_DIALECT_CFLAGS but for now, I
> > just bothered with adding the flags in the existing places.
> 
> That should hopefully do it. Can you update the shared branch with that
> and then tell me when I can repull?

I have applied this as commit e066b73bd881 ("kbuild: Add
'-fms-extensions' to areas with dedicated CFLAGS") in the
kbuild-ms-extensions branch. I may solicit acks from architecture
maintainers but I would like to make sure there are no other surprises
before then.

> > diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> > index ffa3536581f6..9d0efed91414 100644
> > --- a/arch/arm64/kernel/vdso32/Makefile
> > +++ b/arch/arm64/kernel/vdso32/Makefile
> > @@ -63,7 +63,7 @@ VDSO_CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> >                 $(filter -Werror,$(KBUILD_CPPFLAGS)) \
> >                 -Werror-implicit-function-declaration \
> >                 -Wno-format-security \
> > -               -std=gnu11
> > +               -std=gnu11 -fms-extensions
> >  VDSO_CFLAGS  += -O2
> >  # Some useful compiler-dependent flags from top-level Makefile
> >  VDSO_CFLAGS += $(call cc32-option,-Wno-pointer-sign)
> > @@ -71,6 +71,7 @@ VDSO_CFLAGS += -fno-strict-overflow
> >  VDSO_CFLAGS += $(call cc32-option,-Werror=strict-prototypes)
> >  VDSO_CFLAGS += -Werror=date-time
> >  VDSO_CFLAGS += $(call cc32-option,-Werror=incompatible-pointer-types)
> > +VDSO_CFLAGS += $(if $(CONFIG_CC_IS_CLANG),-Wno-microsoft-anon-tag)
> >  
> >  # Compile as THUMB2 or ARM. Unwinding via frame-pointers in THUMB2 is
> >  # unreliable.
> > diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> > index d8316f993482..c0cc3ca5da9f 100644
> > --- a/arch/loongarch/vdso/Makefile
> > +++ b/arch/loongarch/vdso/Makefile
> > @@ -19,7 +19,7 @@ ccflags-vdso := \
> >  cflags-vdso := $(ccflags-vdso) \
> >  	-isystem $(shell $(CC) -print-file-name=include) \
> >  	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
> > -	-std=gnu11 -O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
> > +	-std=gnu11 -fms-extensions -O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
> >  	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
> >  	$(call cc-option, -fno-asynchronous-unwind-tables) \
> >  	$(call cc-option, -fno-stack-protector)
> > diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
> > index 17c42d718eb3..f8481e4e9d21 100644
> > --- a/arch/parisc/boot/compressed/Makefile
> > +++ b/arch/parisc/boot/compressed/Makefile
> > @@ -18,7 +18,7 @@ KBUILD_CFLAGS += -fno-PIE -mno-space-regs -mdisable-fpregs -Os
> >  ifndef CONFIG_64BIT
> >  KBUILD_CFLAGS += -mfast-indirect-calls
> >  endif
> > -KBUILD_CFLAGS += -std=gnu11
> > +KBUILD_CFLAGS += -std=gnu11 -fms-extensions
> >  
> >  LDFLAGS_vmlinux := -X -e startup --as-needed -T
> >  $(obj)/vmlinux: $(obj)/vmlinux.lds $(addprefix $(obj)/, $(OBJECTS)) $(LIBGCC) FORCE
> > diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> > index c47b78c1d3e7..f1a4761ebd44 100644
> > --- a/arch/powerpc/boot/Makefile
> > +++ b/arch/powerpc/boot/Makefile
> > @@ -70,7 +70,7 @@ BOOTCPPFLAGS	:= -nostdinc $(LINUXINCLUDE)
> >  BOOTCPPFLAGS	+= -isystem $(shell $(BOOTCC) -print-file-name=include)
> >  
> >  BOOTCFLAGS	:= $(BOOTTARGETFLAGS) \
> > -		   -std=gnu11 \
> > +		   -std=gnu11 -fms-extensions \
> >  		   -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> >  		   -fno-strict-aliasing -O2 \
> >  		   -msoft-float -mno-altivec -mno-vsx \
> > @@ -86,6 +86,7 @@ BOOTARFLAGS	:= -crD
> >  
> >  ifdef CONFIG_CC_IS_CLANG
> >  BOOTCFLAGS += $(CLANG_FLAGS)
> > +BOOTCFLAGS += -Wno-microsoft-anon-tag
> >  BOOTAFLAGS += $(CLANG_FLAGS)
> >  endif
> >  
> > diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> > index b4769241332b..8578361133a4 100644
> > --- a/arch/s390/Makefile
> > +++ b/arch/s390/Makefile
> > @@ -22,7 +22,7 @@ KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
> >  ifndef CONFIG_AS_IS_LLVM
> >  KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
> >  endif
> > -KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack -std=gnu11
> > +KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack -std=gnu11 -fms-extensions
> >  KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
> >  KBUILD_CFLAGS_DECOMPRESSOR += -D__DECOMPRESSOR
> >  KBUILD_CFLAGS_DECOMPRESSOR += -Wno-pointer-sign
> > @@ -35,6 +35,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-membe
> >  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
> >  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
> >  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_CC_NO_ARRAY_BOUNDS),-Wno-array-bounds)
> > +KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_CC_IS_CLANG),-Wno-microsoft-anon-tag)
> >  
> >  UTS_MACHINE	:= s390x
> >  STACK_SIZE	:= $(if $(CONFIG_KASAN),65536,$(if $(CONFIG_KMSAN),65536,16384))
> > diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> > index bd39b36e7bd6..0c196a5b194a 100644
> > --- a/arch/s390/purgatory/Makefile
> > +++ b/arch/s390/purgatory/Makefile
> > @@ -13,7 +13,7 @@ CFLAGS_sha256.o := -D__NO_FORTIFY
> >  $(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
> >  	$(call if_changed_rule,as_o_S)
> >  
> > -KBUILD_CFLAGS := -std=gnu11 -fno-strict-aliasing -Wall -Wstrict-prototypes
> > +KBUILD_CFLAGS := -std=gnu11 -fms-extensions -fno-strict-aliasing -Wall -Wstrict-prototypes
> >  KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
> >  KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
> >  KBUILD_CFLAGS += -Os -m64 -msoft-float -fno-common
> > @@ -21,6 +21,7 @@ KBUILD_CFLAGS += -fno-stack-protector
> >  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
> >  KBUILD_CFLAGS += -D__DISABLE_EXPORTS
> >  KBUILD_CFLAGS += $(CLANG_FLAGS)
> > +KBUILD_CFLAGS += $(if $(CONFIG_CC_IS_CLANG),-Wno-microsoft-anon-tag)
> >  KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
> >  KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
> >  KBUILD_AFLAGS += -D__DISABLE_EXPORTS
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 4db7e4bf69f5..e20e25b8b16c 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -48,7 +48,8 @@ endif
> >  
> >  # How to compile the 16-bit code.  Note we always compile for -march=i386;
> >  # that way we can complain to the user if the CPU is insufficient.
> > -REALMODE_CFLAGS	:= -std=gnu11 -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
> > +REALMODE_CFLAGS	:= -std=gnu11 -fms-extensions -m16 -g -Os \
> > +		   -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
> >  		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
> >  		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
> >  		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)
> > @@ -60,6 +61,7 @@ REALMODE_CFLAGS += $(cc_stack_align4)
> >  REALMODE_CFLAGS += $(CLANG_FLAGS)
> >  ifdef CONFIG_CC_IS_CLANG
> >  REALMODE_CFLAGS += -Wno-gnu
> > +REALMODE_CFLAGS += -Wno-microsoft-anon-tag
> >  endif
> >  export REALMODE_CFLAGS
> >  
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 74657589264d..68f9d7a1683b 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -25,7 +25,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
> >  # avoid errors with '-march=i386', and future flags may depend on the target to
> >  # be valid.
> >  KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
> > -KBUILD_CFLAGS += -std=gnu11
> > +KBUILD_CFLAGS += -std=gnu11 -fms-extensions
> >  KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
> >  KBUILD_CFLAGS += -Wundef
> >  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
> > @@ -36,7 +36,10 @@ KBUILD_CFLAGS += -mno-mmx -mno-sse
> >  KBUILD_CFLAGS += -ffreestanding -fshort-wchar
> >  KBUILD_CFLAGS += -fno-stack-protector
> >  KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
> > -KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
> > +ifdef CONFIG_CC_IS_CLANG
> > +KBUILD_CFLAGS += -Wno-gnu
> > +KBUILD_CFLAGS += -Wno-microsoft-anon-tag
> > +endif
> >  KBUILD_CFLAGS += -Wno-pointer-sign
> >  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
> >  KBUILD_CFLAGS += -D__DISABLE_EXPORTS
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index 94b05e4451dd..7d15a85d579f 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -11,12 +11,12 @@ cflags-y			:= $(KBUILD_CFLAGS)
> >  
> >  cflags-$(CONFIG_X86_32)		:= -march=i386
> >  cflags-$(CONFIG_X86_64)		:= -mcmodel=small
> > -cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -std=gnu11 \
> > +cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -std=gnu11 -fms-extensions \
> >  				   -fPIC -fno-strict-aliasing -mno-red-zone \
> >  				   -mno-mmx -mno-sse -fshort-wchar \
> >  				   -Wno-pointer-sign \
> >  				   $(call cc-disable-warning, address-of-packed-member) \
> > -				   $(call cc-disable-warning, gnu) \
> > +				   $(if $(CONFIG_CC_IS_CLANG),-Wno-gnu -Wno-microsoft-anon-tag) \
> >  				   -fno-asynchronous-unwind-tables \
> >  				   $(CLANG_FLAGS)
> >  

