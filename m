Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBC77B2A00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 02:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjI2Avn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 20:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjI2Avl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:51:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06F6139
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 17:51:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c736b00639so11267035ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 17:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695948699; x=1696553499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zAa4dlDzV3ROUKICn+wMYA02M0QPbIAkOWeP+0WwmYg=;
        b=TAZhZ0senhzRFGWdAae18VQJeBKbNtb/8BK+3kCuDQ3m+sWGUmntjju5BqOUM68JKm
         T/r/qJzQgDz+uv3CEitCjpi12sQHwYjfYwdhZQijSH7rAa5y8/1QWOPesij0qyeDOB8s
         k6l6CpOEG+KxMp6YBsIqnQfjTZ8a06XTygAeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695948699; x=1696553499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAa4dlDzV3ROUKICn+wMYA02M0QPbIAkOWeP+0WwmYg=;
        b=wu8Iu2yjB2EogM3aV661D3OYiwM9EzMf5aSrG4V9rdEctJPxAm/sCcMzttYrx9mSVm
         kEOIf5fI6nuDbS0mIPtaV/p0OnWkHIGaS6LG36psVBrdi/qaVc9SbWXGMeLvQ25Pcyjp
         kTHLaq/FFFoR3jDFgnwyrw4iE2TcokbnAbr7nwT8YSZT6lrRkBfDHMLqLSV7Kss+4sFD
         G3ZzoHUJwiCZX08rAxksxlLWXz33UC06qmcg+Vr3sUTKF8eY2AdzJnw7fr/2OUMXOrwT
         eKUJgKLOC9pvmrKV9b/8DnfcLiySd6GPAfxYI0G3OHyxe0Qyt8GOGDB58kQzDeJzaaeZ
         s1bw==
X-Gm-Message-State: AOJu0YxK6kW5TrSn7+Mn6qz/UrOIUMJDbu78pGTx109zgQ4uJLcLyC6v
        mJhKsyHcF256jkeQP0mowOqWKg==
X-Google-Smtp-Source: AGHT+IHcWFs2TkSx+f0Jkn2x8NP6yZWHGkFhN2wwgs8oryhOp2AFBuTUWcH3Jbs0ZAENfsB6t4fwMw==
X-Received: by 2002:a17:903:25d4:b0:1b9:e972:134d with SMTP id jc20-20020a17090325d400b001b9e972134dmr2381625plb.3.1695948699370;
        Thu, 28 Sep 2023 17:51:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902e31400b001c60ba709b7sm10434668plc.125.2023.09.28.17.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:51:38 -0700 (PDT)
Date:   Thu, 28 Sep 2023 17:51:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Sebastian Ott <sebott@redhat.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 3/4] binfmt_elf: Provide prot bits as context for
 padzero() errors
Message-ID: <202309281750.FA45C0DBB@keescook>
References: <20230927033634.make.602-kees@kernel.org>
 <20230927034223.986157-3-keescook@chromium.org>
 <87y1gr8j51.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1gr8j51.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:18:34PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > Errors with padzero() should be caught unless we're expecting a
> > pathological (non-writable) segment. Report -EFAULT only when PROT_WRITE
> > is present.
> >
> > Additionally add some more documentation to padzero(), elf_map(), and
> > elf_load().
> 
> I wonder if this might be easier to just perform the PROT_WRITE
> test in elf_load, and to completely skip padzero of PROT_WRITE
> is not present. 

Yeah, actually, after moving load_elf_library() to elf_load(), there's
only 1 caller of padzero... :P

I'll work on that.

-Kees

> 
> Eric
> 
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Suggested-by: Eric Biederman <ebiederm@xmission.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  fs/binfmt_elf.c | 33 +++++++++++++++++++++++----------
> >  1 file changed, 23 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 0214d5a949fc..b939cfe3215c 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -110,19 +110,21 @@ static struct linux_binfmt elf_format = {
> >  
> >  #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
> >  
> > -/* We need to explicitly zero any fractional pages
> > -   after the data section (i.e. bss).  This would
> > -   contain the junk from the file that should not
> > -   be in memory
> > +/*
> > + * We need to explicitly zero any trailing portion of the page that follows
> > + * p_filesz when it ends before the page ends (e.g. bss), otherwise this
> > + * memory will contain the junk from the file that should not be present.
> >   */
> > -static int padzero(unsigned long elf_bss)
> > +static int padzero(unsigned long address, int prot)
> >  {
> >  	unsigned long nbyte;
> >  
> > -	nbyte = ELF_PAGEOFFSET(elf_bss);
> > +	nbyte = ELF_PAGEOFFSET(address);
> >  	if (nbyte) {
> >  		nbyte = ELF_MIN_ALIGN - nbyte;
> > -		if (clear_user((void __user *) elf_bss, nbyte))
> > +		/* Only report errors when the segment is writable. */
> > +		if (clear_user((void __user *)address, nbyte) &&
> > +		    prot & PROT_WRITE)
> >  			return -EFAULT;
> >  	}
> >  	return 0;
> > @@ -348,6 +350,11 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Map "eppnt->p_filesz" bytes from "filep" offset "eppnt->p_offset"
> > + * into memory at "addr". (Note that p_filesz is rounded up to the
> > + * next page, so any extra bytes from the file must be wiped.)
> > + */
> >  static unsigned long elf_map(struct file *filep, unsigned long addr,
> >  		const struct elf_phdr *eppnt, int prot, int type,
> >  		unsigned long total_size)
> > @@ -387,6 +394,11 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
> >  	return(map_addr);
> >  }
> >  
> > +/*
> > + * Map "eppnt->p_filesz" bytes from "filep" offset "eppnt->p_offset"
> > + * into memory at "addr". Memory from "p_filesz" through "p_memsz"
> > + * rounded up to the next page is zeroed.
> > + */
> >  static unsigned long elf_load(struct file *filep, unsigned long addr,
> >  		const struct elf_phdr *eppnt, int prot, int type,
> >  		unsigned long total_size)
> > @@ -405,7 +417,8 @@ static unsigned long elf_load(struct file *filep, unsigned long addr,
> >  				eppnt->p_memsz;
> >  
> >  			/* Zero the end of the last mapped page */
> > -			padzero(zero_start);
> > +			if (padzero(zero_start, prot))
> > +				return -EFAULT;
> >  		}
> >  	} else {
> >  		map_addr = zero_start = ELF_PAGESTART(addr);
> > @@ -712,7 +725,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
> >  	 * the file up to the page boundary, and zero it from elf_bss
> >  	 * up to the end of the page.
> >  	 */
> > -	if (padzero(elf_bss)) {
> > +	if (padzero(elf_bss, bss_prot)) {
> >  		error = -EFAULT;
> >  		goto out;
> >  	}
> > @@ -1407,7 +1420,7 @@ static int load_elf_library(struct file *file)
> >  		goto out_free_ph;
> >  
> >  	elf_bss = eppnt->p_vaddr + eppnt->p_filesz;
> > -	if (padzero(elf_bss)) {
> > +	if (padzero(elf_bss, PROT_WRITE)) {
> >  		error = -EFAULT;
> >  		goto out_free_ph;
> >  	}

-- 
Kees Cook
