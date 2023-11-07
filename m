Return-Path: <linux-fsdevel+bounces-2199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 550857E31F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 01:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD14B20B1A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 00:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F309819;
	Tue,  7 Nov 2023 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eBaWV8MO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE2B7F9
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 00:04:22 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1C3183
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 16:04:21 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b2e4107f47so3585328b6e.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 16:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699315460; x=1699920260; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0HO/wA9PqUNYiMdOQK9wuMf/On/ruAp85W0UZdzlNes=;
        b=eBaWV8MOdiwZc05KX4oEicS0CI0JGlcguQcgQXFx4AgMjd1N4+0EXA9DaeRCuPvcbu
         Nf5QgmIRUFExCeGqwDrVOO+75mqNWkZiJpkyzgMvf4Hma+3OS1VdWqwn5PiXJ1JuUznO
         e0prcGuDfmkmW2/wrn42ge/kJbItAP35as7VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699315460; x=1699920260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HO/wA9PqUNYiMdOQK9wuMf/On/ruAp85W0UZdzlNes=;
        b=P/DrjPxyS/FXQbxFS85piQOXfJ6uPv4vV40zXX8UY1wt/RXrR2fYPy7OydkI+Yp90l
         XHy31RaxKvoMWUH1cbq5++C2BRBuZA31o9Q/F+8OmETx24Kv2BaRbDbhu8KW8I78Lhtt
         Zy4hTMTH3NaghKE4VPP4OhSp3bMcHh7U64RTAEc3CD+J66z9bdJZruUXkT363hmE45LA
         Bpp/6Vf//eecnvii+OkXN/YyDIM3OIKH6qp/zcu+xKbV9cYIEAs09pGIRf4oYAlJxJtm
         qI8zkfsFUsG/xb5kM70uR0jZDEDtGCH0hkR+YzTn9INVKqnAIIlViskTiAqZKsl4OtyJ
         mpSA==
X-Gm-Message-State: AOJu0YzQSaIYMYUnKT/oFKqHKHav8+FVxdvPDAKRiB8rVT2f6jYFKYtO
	XCvrisvV+Ri7YhiV/cjv7JYZlsV+vRo7UJOWDvuStg==
X-Google-Smtp-Source: AGHT+IGDvCB17KWTyiFx8FaXAeEJc0ByauOL7iWEfL8vBMxv+JBAAYxbbDgTQnUUhZieLx7gpEEKmw==
X-Received: by 2002:a54:418f:0:b0:3b2:d9d8:4039 with SMTP id 15-20020a54418f000000b003b2d9d84039mr34224764oiy.24.1699315460292;
        Mon, 06 Nov 2023 16:04:20 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y40-20020a056a00182800b006be0fb89ac3sm6111825pfa.30.2023.11.06.16.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 16:04:19 -0800 (PST)
Date: Mon, 6 Nov 2023 16:04:18 -0800
From: Kees Cook <keescook@chromium.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Sebastian Ott <sebott@redhat.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Pedro Falcato <pedro.falcato@gmail.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH AUTOSEL 6.6 05/13] binfmt_elf: Support segments with 0
 filesz and misaligned starts
Message-ID: <202311061603.CBBBC6408@keescook>
References: <20231106231435.3734790-1-sashal@kernel.org>
 <20231106231435.3734790-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106231435.3734790-5-sashal@kernel.org>

Please drop this from -stable -- it's part of a larger refactoring that
shouldn't be backported without explicit effort/testing.

-Kees

On Mon, Nov 06, 2023 at 06:14:18PM -0500, Sasha Levin wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> [ Upstream commit 585a018627b4d7ed37387211f667916840b5c5ea ]
> 
> Implement a helper elf_load() that wraps elf_map() and performs all
> of the necessary work to ensure that when "memsz > filesz" the bytes
> described by "memsz > filesz" are zeroed.
> 
> An outstanding issue is if the first segment has filesz 0, and has a
> randomized location. But that is the same as today.
> 
> In this change I replaced an open coded padzero() that did not clear
> all of the way to the end of the page, with padzero() that does.
> 
> I also stopped checking the return of padzero() as there is at least
> one known case where testing for failure is the wrong thing to do.
> It looks like binfmt_elf_fdpic may have the proper set of tests
> for when error handling can be safely completed.
> 
> I found a couple of commits in the old history
> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git,
> that look very interesting in understanding this code.
> 
> commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail")
> commit c6e2227e4a3e ("[SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c")
> commit 5bf3be033f50 ("v2.4.10.1 -> v2.4.10.2")
> 
> Looking at commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail"):
> >  commit 39b56d902bf35241e7cba6cc30b828ed937175ad
> >  Author: Pavel Machek <pavel@ucw.cz>
> >  Date:   Wed Feb 9 22:40:30 2005 -0800
> >
> >     [PATCH] binfmt_elf: clearing bss may fail
> >
> >     So we discover that Borland's Kylix application builder emits weird elf
> >     files which describe a non-writeable bss segment.
> >
> >     So remove the clear_user() check at the place where we zero out the bss.  I
> >     don't _think_ there are any security implications here (plus we've never
> >     checked that clear_user() return value, so whoops if it is a problem).
> >
> >     Signed-off-by: Pavel Machek <pavel@suse.cz>
> >     Signed-off-by: Andrew Morton <akpm@osdl.org>
> >     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> It seems pretty clear that binfmt_elf_fdpic with skipping clear_user() for
> non-writable segments and otherwise calling clear_user(), aka padzero(),
> and checking it's return code is the right thing to do.
> 
> I just skipped the error checking as that avoids breaking things.
> 
> And notably, it looks like Borland's Kylix died in 2005 so it might be
> safe to just consider read-only segments with memsz > filesz an error.
> 
> Reported-by: Sebastian Ott <sebott@redhat.com>
> Reported-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Closes: https://lkml.kernel.org/r/20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Link: https://lore.kernel.org/r/87sf71f123.fsf@email.froward.int.ebiederm.org
> Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> Link: https://lore.kernel.org/r/20230929032435.2391507-1-keescook@chromium.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/binfmt_elf.c | 111 +++++++++++++++++++++---------------------------
>  1 file changed, 48 insertions(+), 63 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 7b3d2d4914073..2a615f476e44e 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -110,25 +110,6 @@ static struct linux_binfmt elf_format = {
>  
>  #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
>  
> -static int set_brk(unsigned long start, unsigned long end, int prot)
> -{
> -	start = ELF_PAGEALIGN(start);
> -	end = ELF_PAGEALIGN(end);
> -	if (end > start) {
> -		/*
> -		 * Map the last of the bss segment.
> -		 * If the header is requesting these pages to be
> -		 * executable, honour that (ppc32 needs this).
> -		 */
> -		int error = vm_brk_flags(start, end - start,
> -				prot & PROT_EXEC ? VM_EXEC : 0);
> -		if (error)
> -			return error;
> -	}
> -	current->mm->start_brk = current->mm->brk = end;
> -	return 0;
> -}
> -
>  /* We need to explicitly zero any fractional pages
>     after the data section (i.e. bss).  This would
>     contain the junk from the file that should not
> @@ -406,6 +387,51 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
>  	return(map_addr);
>  }
>  
> +static unsigned long elf_load(struct file *filep, unsigned long addr,
> +		const struct elf_phdr *eppnt, int prot, int type,
> +		unsigned long total_size)
> +{
> +	unsigned long zero_start, zero_end;
> +	unsigned long map_addr;
> +
> +	if (eppnt->p_filesz) {
> +		map_addr = elf_map(filep, addr, eppnt, prot, type, total_size);
> +		if (BAD_ADDR(map_addr))
> +			return map_addr;
> +		if (eppnt->p_memsz > eppnt->p_filesz) {
> +			zero_start = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
> +				eppnt->p_filesz;
> +			zero_end = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
> +				eppnt->p_memsz;
> +
> +			/* Zero the end of the last mapped page */
> +			padzero(zero_start);
> +		}
> +	} else {
> +		map_addr = zero_start = ELF_PAGESTART(addr);
> +		zero_end = zero_start + ELF_PAGEOFFSET(eppnt->p_vaddr) +
> +			eppnt->p_memsz;
> +	}
> +	if (eppnt->p_memsz > eppnt->p_filesz) {
> +		/*
> +		 * Map the last of the segment.
> +		 * If the header is requesting these pages to be
> +		 * executable, honour that (ppc32 needs this).
> +		 */
> +		int error;
> +
> +		zero_start = ELF_PAGEALIGN(zero_start);
> +		zero_end = ELF_PAGEALIGN(zero_end);
> +
> +		error = vm_brk_flags(zero_start, zero_end - zero_start,
> +				     prot & PROT_EXEC ? VM_EXEC : 0);
> +		if (error)
> +			map_addr = error;
> +	}
> +	return map_addr;
> +}
> +
> +
>  static unsigned long total_mapping_size(const struct elf_phdr *phdr, int nr)
>  {
>  	elf_addr_t min_addr = -1;
> @@ -829,7 +855,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
>  	struct elf_phdr *elf_property_phdata = NULL;
>  	unsigned long elf_bss, elf_brk;
> -	int bss_prot = 0;
>  	int retval, i;
>  	unsigned long elf_entry;
>  	unsigned long e_entry;
> @@ -1040,33 +1065,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		if (elf_ppnt->p_type != PT_LOAD)
>  			continue;
>  
> -		if (unlikely (elf_brk > elf_bss)) {
> -			unsigned long nbyte;
> -
> -			/* There was a PT_LOAD segment with p_memsz > p_filesz
> -			   before this one. Map anonymous pages, if needed,
> -			   and clear the area.  */
> -			retval = set_brk(elf_bss + load_bias,
> -					 elf_brk + load_bias,
> -					 bss_prot);
> -			if (retval)
> -				goto out_free_dentry;
> -			nbyte = ELF_PAGEOFFSET(elf_bss);
> -			if (nbyte) {
> -				nbyte = ELF_MIN_ALIGN - nbyte;
> -				if (nbyte > elf_brk - elf_bss)
> -					nbyte = elf_brk - elf_bss;
> -				if (clear_user((void __user *)elf_bss +
> -							load_bias, nbyte)) {
> -					/*
> -					 * This bss-zeroing can fail if the ELF
> -					 * file specifies odd protections. So
> -					 * we don't check the return value
> -					 */
> -				}
> -			}
> -		}
> -
>  		elf_prot = make_prot(elf_ppnt->p_flags, &arch_state,
>  				     !!interpreter, false);
>  
> @@ -1162,7 +1160,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  			}
>  		}
>  
> -		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
> +		error = elf_load(bprm->file, load_bias + vaddr, elf_ppnt,
>  				elf_prot, elf_flags, total_size);
>  		if (BAD_ADDR(error)) {
>  			retval = IS_ERR_VALUE(error) ?
> @@ -1217,10 +1215,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		if (end_data < k)
>  			end_data = k;
>  		k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
> -		if (k > elf_brk) {
> -			bss_prot = elf_prot;
> +		if (k > elf_brk)
>  			elf_brk = k;
> -		}
>  	}
>  
>  	e_entry = elf_ex->e_entry + load_bias;
> @@ -1232,18 +1228,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	start_data += load_bias;
>  	end_data += load_bias;
>  
> -	/* Calling set_brk effectively mmaps the pages that we need
> -	 * for the bss and break sections.  We must do this before
> -	 * mapping in the interpreter, to make sure it doesn't wind
> -	 * up getting placed where the bss needs to go.
> -	 */
> -	retval = set_brk(elf_bss, elf_brk, bss_prot);
> -	if (retval)
> -		goto out_free_dentry;
> -	if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bss))) {
> -		retval = -EFAULT; /* Nobody gets to see this, but.. */
> -		goto out_free_dentry;
> -	}
> +	current->mm->start_brk = current->mm->brk = ELF_PAGEALIGN(elf_brk);
>  
>  	if (interpreter) {
>  		elf_entry = load_elf_interp(interp_elf_ex,
> -- 
> 2.42.0
> 

-- 
Kees Cook

