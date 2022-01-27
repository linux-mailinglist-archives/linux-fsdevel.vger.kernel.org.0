Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947A149E2E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 13:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbiA0M4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 07:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiA0M4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:56:48 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE3FC061714;
        Thu, 27 Jan 2022 04:56:48 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id v74so2573274pfc.1;
        Thu, 27 Jan 2022 04:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bN3bUFRZXrk//hUp6oGC5VwqyBMF+T+sfn+CobUILhA=;
        b=XN7Xa3VoAP9PYd0VgWsdh+L87Ah3nZTSXjX7XpfTyEu4Qb4p0EJJ7shQqkj3NZY2Tc
         UGAneYSgYSZB1c4+LSfDtycBmLVeYIcq0X61jsMsHk3zv2k7qG2SE4c4psC/9DAQpDng
         RgvYlDdxGk1W4fXQ1ptpTbnswLamRid6rUMWZ+2qWZptsHi5Dy/sta1AqV7+P/p0y3F0
         VlAmX+9bPC55dwcbr81N1PgsJ/XTsgHnV9eHpsp/gB2LzZFIXlHl+R/ZV9jXc9FPlARj
         FYNZ+0uDCMGPyz1BoY4gaPEF+3pykJX2Uby7xp4nix8LdUzbLhaAHJlvqoJ6cDn1R2KM
         fZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bN3bUFRZXrk//hUp6oGC5VwqyBMF+T+sfn+CobUILhA=;
        b=LAuKat37UBrNnBp2FN4SfVPV1x2X4Kipze5sn8m0tB9zC2IU3ZgjJr57cQ8uKCMlFM
         S1RZlw+VGrPE1r8tdxOwX4ym40ueXt1BfxkWuE9K0a6Uj2dI1Wi1UbKVVVTB0C6qm7hb
         dYk+WrgV9aIEZTU2EHtE1CZ7t+3zWf32ean5PU1wUwp80WKfjp3qxnqPVr5deLaFwv+k
         jWmr+N2S/YYhCB1BfkyNgVY8vvS4rAJxxly/jRhplPJYyAetMrOdoIuuUQK17V0/26eY
         /UIDtHrih9c6VnejHxNJ5WRWL/lv/Ae6Fc/R2dRiIvaq1+1zkUkBVmyw0JSrRwLHVDzx
         ge3g==
X-Gm-Message-State: AOAM5333Luz9MlDrW5eqOsY0p8dbs9wix1SRKVfpX/OCDIEGfN2Rf5MJ
        zWYH7x2MAvPPYrbjeCiv8rlxY5PwtAvJ41E5
X-Google-Smtp-Source: ABdhPJwniT4/NwPUyBYhUkZCDwZIc1OaOvjz4dtioHI8nfv9ZIMlCwICvZjJgJwscUkJY/BU+lLACA==
X-Received: by 2002:a63:96:: with SMTP id 144mr2652343pga.383.1643288207807;
        Thu, 27 Jan 2022 04:56:47 -0800 (PST)
Received: from gmail.com ([2400:2410:93a3:bc00:d205:ec9:b1c6:b9ee])
        by smtp.gmail.com with ESMTPSA id 20sm18937021pgz.59.2022.01.27.04.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 04:56:47 -0800 (PST)
Date:   Thu, 27 Jan 2022 21:56:43 +0900
From:   Akira Kawata <akirakawata1@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        lukas.bulwahn@gmail.com, kernel test robot <lkp@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Message-ID: <20220127125643.cifk2ihnbnxo5wcl@gmail.com>
References: <20211212232414.1402199-1-akirakawata1@gmail.com>
 <20211212232414.1402199-2-akirakawata1@gmail.com>
 <202201261955.F86F391@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201261955.F86F391@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 09:01:30PM -0800, Kees Cook wrote:
> On Mon, Dec 13, 2021 at 08:24:11AM +0900, Akira Kawata wrote:
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=197921
> > 
> > As pointed out in the discussion of buglink, we cannot calculate AT_PHDR
> > as the sum of load_addr and exec->e_phoff.
> > 
> > : The AT_PHDR of ELF auxiliary vectors should point to the memory address
> > : of program header. But binfmt_elf.c calculates this address as follows:
> > :
> > : NEW_AUX_ENT(AT_PHDR, load_addr + exec->e_phoff);
> > :
> > : which is wrong since e_phoff is the file offset of program header and
> > : load_addr is the memory base address from PT_LOAD entry.
> > :
> > : The ld.so uses AT_PHDR as the memory address of program header. In normal
> > : case, since the e_phoff is usually 64 and in the first PT_LOAD region, it
> > : is the correct program header address.
> > :
> > : But if the address of program header isn't equal to the first PT_LOAD
> > : address + e_phoff (e.g.  Put the program header in other non-consecutive
> > : PT_LOAD region), ld.so will try to read program header from wrong address
> > : then crash or use incorrect program header.
> > 
> > This is because exec->e_phoff
> > is the offset of PHDRs in the file and the address of PHDRs in the
> > memory may differ from it. This patch fixes the bug by calculating the
> > address of program headers from PT_LOADs directly.
> > 
> > Signed-off-by: Akira Kawata <akirakawata1@gmail.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  fs/binfmt_elf.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index beeb1247b5c4..828e88841cb4 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -170,8 +170,8 @@ static int padzero(unsigned long elf_bss)
> >  
> >  static int
> >  create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
> > -		unsigned long load_addr, unsigned long interp_load_addr,
> > -		unsigned long e_entry)
> > +		unsigned long interp_load_addr,
> > +		unsigned long e_entry, unsigned long phdr_addr)
> >  {
> >  	struct mm_struct *mm = current->mm;
> >  	unsigned long p = bprm->p;
> > @@ -257,7 +257,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
> >  	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
> >  	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
> >  	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
> > -	NEW_AUX_ENT(AT_PHDR, load_addr + exec->e_phoff);
> > +	NEW_AUX_ENT(AT_PHDR, phdr_addr);
> >  	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
> >  	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
> >  	NEW_AUX_ENT(AT_BASE, interp_load_addr);
> > @@ -822,7 +822,7 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
> >  static int load_elf_binary(struct linux_binprm *bprm)
> >  {
> >  	struct file *interpreter = NULL; /* to shut gcc up */
> > - 	unsigned long load_addr = 0, load_bias = 0;
> > +	unsigned long load_addr, load_bias = 0, phdr_addr = 0;
> >  	int load_addr_set = 0;
> >  	unsigned long error;
> >  	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
> > @@ -1168,6 +1168,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  				reloc_func_desc = load_bias;
> >  			}
> >  		}
> > +
> > +		if (elf_ppnt->p_offset <= elf_ex->e_phoff &&
> > +		    elf_ex->e_phoff < elf_ppnt->p_offset + elf_ppnt->p_filesz) {
> > +			phdr_addr = elf_ex->e_phoff - elf_ppnt->p_offset +
> > +				    elf_ppnt->p_vaddr;
> > +		}
> 
> This chunk could really use a comment above it. Maybe something like:
> 
> /*
>  * Figure out which segment in the file contains the Program
>  * Header table, and map to the associated memory address.
>  */

Thank you. It looks good to me. I made v5 which contains it.

> 
> Some additional thoughts:
> 
> 1) The ELF spec says e_phoff is 0 if there's no program header table.
> 
> The old code would just pass the load_addr as a result. This patch will
> now retain the same result (phdr_addr defaults to 0). I wonder if there
> is a bug in this behavior, though? (To be addressed in a different patch
> if needed...)
>

It is better to return NULL from load_elf_phdrs when e_phoff == 0, I
think.

> 2) This finds any matching segment, not just PT_PHDR, which is good,
> since PT_PHDR isn't strictly required.
> 
> > +
> >  		k = elf_ppnt->p_vaddr;
> >  		if ((elf_ppnt->p_flags & PF_X) && k < start_code)
> >  			start_code = k;
> > @@ -1203,6 +1210,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  	}
> >  
> >  	e_entry = elf_ex->e_entry + load_bias;
> > +	phdr_addr += load_bias;
> >  	elf_bss += load_bias;
> >  	elf_brk += load_bias;
> >  	start_code += load_bias;
> > @@ -1266,8 +1274,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  		goto out;
> >  #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
> >  
> > -	retval = create_elf_tables(bprm, elf_ex,
> > -			  load_addr, interp_load_addr, e_entry);
> > +	retval = create_elf_tables(bprm, elf_ex, interp_load_addr,
> > +				   e_entry, phdr_addr);
> >  	if (retval < 0)
> >  		goto out;
> 
> Looks good!
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> -- 
> Kees Cook

Thank you for your review.

Akira Kawata
