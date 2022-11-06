Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5369861E08C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Nov 2022 07:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiKFGoj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Nov 2022 01:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKFGoi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Nov 2022 01:44:38 -0500
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EA0627D;
        Sat,  5 Nov 2022 23:44:37 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id l2so8420287pld.13;
        Sat, 05 Nov 2022 23:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=albpaZd/W7/PPwS07aGM8eNZ3IHl+SmYaKFhbidGQmI=;
        b=LrB73Rn/LVfkRAE0P99yREETJp2rHgL3n6B6hJFDQNcOFH6WaI7GkLw+alPceOeHvT
         c7nQYBFnvKTXyknL7SIUm4n/yiE8IYFiX9CDruWPTbYp2Mj6ONHCxz3yxuCsk+4R9eV5
         0n5Qd+tllOrky6MnEpryYj0uG1bO7Mb+5EN/gUPYOCg9Db/0YPMVik1xMjVphl2qPBXl
         JS1OYQ60W7IKZijwBUe8owBs3+PHo1Ct8zwPyGoBDeXriadWfzN5+G/tEhNJkzG1KD1u
         7r+57cl7cdhDyU1uP6EJaKSFnfoSiMKHhbGbN/oPXpGfOVO6qSmFCTnGAIeS2n0zyg80
         9Mpg==
X-Gm-Message-State: ACrzQf2iZWjU6oGgrmn7fL39ri/cb1sUsY8/OUFXOLbV++qOGTCP3501
        Rfqnq7Ybz5JDdtudpIdbJg4=
X-Google-Smtp-Source: AMsMyM5nuHxzZeRNTf8GcGTRzfgy/kxEZ90P7tWKYSh2R9Xli2gwkWhkJd4NUEqTAGStd5jeFRaN9Q==
X-Received: by 2002:a17:902:8211:b0:172:f722:8402 with SMTP id x17-20020a170902821100b00172f7228402mr602399pln.122.1667717076342;
        Sat, 05 Nov 2022 23:44:36 -0700 (PDT)
Received: from localhost ([2601:647:6300:b760:4158:4a1c:f26e:e91])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b00181f8523f60sm2580198plk.225.2022.11.05.23.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 23:44:35 -0700 (PDT)
Date:   Sat, 5 Nov 2022 23:44:34 -0700
From:   Fangrui Song <i@maskray.me>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-mm@kvack.org, sam@gentoo.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, Rich Felker <dalias@libc.org>
Subject: Re: [PATCH] fs/binfmt_elf: Fix memsz > filesz handling
Message-ID: <20221106064434.zrx5wjyzxtjgc2ly@gmail.com>
References: <20221106021657.1145519-1-pedro.falcato@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221106021657.1145519-1-pedro.falcato@gmail.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-11-06, Pedro Falcato wrote:
>The old code for ELF interpreter loading could only handle
>1 memsz > filesz segment. This is incorrect, as evidenced
>by the elf program loading code, which could handle multiple
>such segments.
>
>This patch fixes memsz > filesz handling for elf interpreters
>and refactors interpreter/program BSS clearing into a common
>codepath.
>
>This bug was uncovered on builds of ppc64le musl libc with
>llvm lld 15.0.0, since ppc64 does not allocate file space
>for its .plt.
>
>Cc: Rich Felker <dalias@libc.org>
>Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
>---
> fs/binfmt_elf.c | 170 ++++++++++++++++--------------------------------
> 1 file changed, 56 insertions(+), 114 deletions(-)
>
>diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>index 6a11025e585..ca2961d80fa 100644
>--- a/fs/binfmt_elf.c
>+++ b/fs/binfmt_elf.c
>@@ -109,25 +109,6 @@ static struct linux_binfmt elf_format = {
>
> #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
>
>-static int set_brk(unsigned long start, unsigned long end, int prot)
>-{
>-	start = ELF_PAGEALIGN(start);
>-	end = ELF_PAGEALIGN(end);
>-	if (end > start) {
>-		/*
>-		 * Map the last of the bss segment.
>-		 * If the header is requesting these pages to be
>-		 * executable, honour that (ppc32 needs this).
>-		 */
>-		int error = vm_brk_flags(start, end - start,
>-				prot & PROT_EXEC ? VM_EXEC : 0);
>-		if (error)
>-			return error;
>-	}
>-	current->mm->start_brk = current->mm->brk = end;
>-	return 0;
>-}
>-
> /* We need to explicitly zero any fractional pages
>    after the data section (i.e. bss).  This would
>    contain the junk from the file that should not
>@@ -584,6 +565,41 @@ static inline int make_prot(u32 p_flags, struct arch_elf_state *arch_state,
> 	return arch_elf_adjust_prot(prot, arch_state, has_interp, is_interp);
> }
>
>+static int zero_bss(unsigned long start, unsigned long end, int prot)
>+{
>+	/*
>+	 * First pad the last page from the file up to
>+	 * the page boundary, and zero it from elf_bss up to the end of the page.
>+	 */
>+	if (padzero(start))
>+		return -EFAULT;
>+
>+	/*
>+	 * Next, align both the file and mem bss up to the page size,
>+	 * since this is where elf_bss was just zeroed up to, and where
>+	 * last_bss will end after the vm_brk_flags() below.
>+	 */
>+
>+	start = ELF_PAGEALIGN(start);
>+	end = ELF_PAGEALIGN(end);
>+
>+	/* Finally, if there is still more bss to allocate, do it. */
>+
>+	return (end > start ? vm_brk_flags(start, end - start,
>+		prot & PROT_EXEC ? VM_EXEC : 0) : 0);
>+}
>+
>+static int set_brk(unsigned long start, unsigned long end, int prot)
>+{
>+	int error = zero_bss(start, end, prot);
>+
>+	if (error < 0)
>+		return error;
>+
>+	current->mm->start_brk = current->mm->brk = ELF_PAGEALIGN(end);
>+	return 0;
>+}
>+
> /* This is much more generalized than the library routine read function,
>    so we keep this separate.  Technically the library read function
>    is only provided so that we can read a.out libraries that have
>@@ -597,8 +613,6 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
> 	struct elf_phdr *eppnt;
> 	unsigned long load_addr = 0;
> 	int load_addr_set = 0;
>-	unsigned long last_bss = 0, elf_bss = 0;
>-	int bss_prot = 0;
> 	unsigned long error = ~0UL;
> 	unsigned long total_size;
> 	int i;
>@@ -662,50 +676,21 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
> 				goto out;
> 			}
>
>-			/*
>-			 * Find the end of the file mapping for this phdr, and
>-			 * keep track of the largest address we see for this.
>-			 */
>-			k = load_addr + eppnt->p_vaddr + eppnt->p_filesz;
>-			if (k > elf_bss)
>-				elf_bss = k;
>+			if (eppnt->p_memsz > eppnt->p_filesz) {
>+				/*
>+				 * Handle BSS zeroing and mapping
>+				 */
>+				unsigned long start = load_addr + vaddr + eppnt->p_filesz;
>+				unsigned long end = load_addr + vaddr + eppnt->p_memsz;
>
>-			/*
>-			 * Do the same thing for the memory mapping - between
>-			 * elf_bss and last_bss is the bss section.
>-			 */
>-			k = load_addr + eppnt->p_vaddr + eppnt->p_memsz;
>-			if (k > last_bss) {
>-				last_bss = k;
>-				bss_prot = elf_prot;
>+				error = zero_bss(start, end, elf_prot);
>+
>+				if (error < 0)
>+					goto out;
> 			}
> 		}
> 	}
>
>-	/*
>-	 * Now fill out the bss section: first pad the last page from
>-	 * the file up to the page boundary, and zero it from elf_bss
>-	 * up to the end of the page.
>-	 */
>-	if (padzero(elf_bss)) {
>-		error = -EFAULT;
>-		goto out;
>-	}
>-	/*
>-	 * Next, align both the file and mem bss up to the page size,
>-	 * since this is where elf_bss was just zeroed up to, and where
>-	 * last_bss will end after the vm_brk_flags() below.
>-	 */
>-	elf_bss = ELF_PAGEALIGN(elf_bss);
>-	last_bss = ELF_PAGEALIGN(last_bss);
>-	/* Finally, if there is still more bss to allocate, do it. */
>-	if (last_bss > elf_bss) {
>-		error = vm_brk_flags(elf_bss, last_bss - elf_bss,
>-				bss_prot & PROT_EXEC ? VM_EXEC : 0);
>-		if (error)
>-			goto out;
>-	}
>-
> 	error = load_addr;
> out:
> 	return error;
>@@ -829,8 +814,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
> 	unsigned long error;
> 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
> 	struct elf_phdr *elf_property_phdata = NULL;
>-	unsigned long elf_bss, elf_brk;
>-	int bss_prot = 0;
> 	int retval, i;
> 	unsigned long elf_entry;
> 	unsigned long e_entry;
>@@ -1020,9 +1003,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
> 				 executable_stack);
> 	if (retval < 0)
> 		goto out_free_dentry;
>-	
>-	elf_bss = 0;
>-	elf_brk = 0;
>
> 	start_code = ~0UL;
> 	end_code = 0;
>@@ -1041,33 +1021,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
> 		if (elf_ppnt->p_type != PT_LOAD)
> 			continue;
>
>-		if (unlikely (elf_brk > elf_bss)) {
>-			unsigned long nbyte;
>-	
>-			/* There was a PT_LOAD segment with p_memsz > p_filesz
>-			   before this one. Map anonymous pages, if needed,
>-			   and clear the area.  */
>-			retval = set_brk(elf_bss + load_bias,
>-					 elf_brk + load_bias,
>-					 bss_prot);
>-			if (retval)
>-				goto out_free_dentry;
>-			nbyte = ELF_PAGEOFFSET(elf_bss);
>-			if (nbyte) {
>-				nbyte = ELF_MIN_ALIGN - nbyte;
>-				if (nbyte > elf_brk - elf_bss)
>-					nbyte = elf_brk - elf_bss;
>-				if (clear_user((void __user *)elf_bss +
>-							load_bias, nbyte)) {
>-					/*
>-					 * This bss-zeroing can fail if the ELF
>-					 * file specifies odd protections. So
>-					 * we don't check the return value
>-					 */
>-				}
>-			}
>-		}
>-
> 		elf_prot = make_prot(elf_ppnt->p_flags, &arch_state,
> 				     !!interpreter, false);
>
>@@ -1211,41 +1164,30 @@ static int load_elf_binary(struct linux_binprm *bprm)
>
> 		k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
>
>-		if (k > elf_bss)
>-			elf_bss = k;
>+
>+		if (elf_ppnt->p_memsz > elf_ppnt->p_filesz) {
>+			unsigned long seg_end = elf_ppnt->p_vaddr +
>+					 elf_ppnt->p_memsz + load_bias;
>+			retval = set_brk(k + load_bias,
>+					 seg_end,
>+					 elf_prot);
>+			if (retval)
>+				goto out_free_dentry;
>+		}
>+
> 		if ((elf_ppnt->p_flags & PF_X) && end_code < k)
> 			end_code = k;
> 		if (end_data < k)
> 			end_data = k;
>-		k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
>-		if (k > elf_brk) {
>-			bss_prot = elf_prot;
>-			elf_brk = k;
>-		}
> 	}
>
> 	e_entry = elf_ex->e_entry + load_bias;
> 	phdr_addr += load_bias;
>-	elf_bss += load_bias;
>-	elf_brk += load_bias;
> 	start_code += load_bias;
> 	end_code += load_bias;
> 	start_data += load_bias;
> 	end_data += load_bias;
>
>-	/* Calling set_brk effectively mmaps the pages that we need
>-	 * for the bss and break sections.  We must do this before
>-	 * mapping in the interpreter, to make sure it doesn't wind
>-	 * up getting placed where the bss needs to go.
>-	 */
>-	retval = set_brk(elf_bss, elf_brk, bss_prot);
>-	if (retval)
>-		goto out_free_dentry;
>-	if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bss))) {
>-		retval = -EFAULT; /* Nobody gets to see this, but.. */
>-		goto out_free_dentry;
>-	}
>-
> 	if (interpreter) {
> 		elf_entry = load_elf_interp(interp_elf_ex,
> 					    interpreter,
>-- 
>2.38.1

I have a write-up about the issue: https://maskray.me/blog/2022-11-05-lld-musl-powerpc64
and used a `.section .toc,"aw",@nobits` trick to verify that this patch
makes two RW PT_LOAD (p_filesz < p_memsz) work.

Reviewed-by: Fangrui Song <i@maskray.me>
Tested-by: Fangrui Song <i@maskray.me>
