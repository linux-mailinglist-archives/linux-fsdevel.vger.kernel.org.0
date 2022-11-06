Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D261DFF7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Nov 2022 03:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKFCRR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Nov 2022 22:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKFCRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Nov 2022 22:17:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC16B49C;
        Sat,  5 Nov 2022 19:17:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 187-20020a1c02c4000000b003cf9c3f3b80so111860wmc.0;
        Sat, 05 Nov 2022 19:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WJCZv+8vYrA6RPPfdvCCnm9LeIEleEMO64R1XMnFwfM=;
        b=Zymhvzpp7tNPl0BLFM5aitMHwFIF4sRgTskdXUktwrZY4f0eTCTQsgdJvLchAsTpJL
         yBVteMUAEoMyCvVaON8vZi1FRfylOZ/JHYdAlIwLzNaeo9oEcxJiMuaum6muxLWVv3GW
         nC1P23FMzc1DQhGgZs0lVLwTj0Njn89dUYaRrOIv81xkOv5h4+BjepJywRryI+Gjgi0c
         b7HSv4NvRx/D1yQmWjbsH/nJQ+kbKPORDPF2f+4V4uZry/yVLDFLvQyw475h6zvf40rz
         r3U4tLymhusdeBSvXCt40sbBQXHC1c5P8r/zsC8R9cpX9Pzoxp782S0UFRyG4ocrfOsK
         CZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJCZv+8vYrA6RPPfdvCCnm9LeIEleEMO64R1XMnFwfM=;
        b=USADpBm7tVoODIh91aT/hxoWf3h6XMdNRH3vrDN1xxHaARbegPkRI+kSSsj9WleEUY
         gax0UpoQ2sVLkNYz5jIWwmOfIgrFsxoVpEQuu6O+s/c+XB2B4KvQf6kfk5C8JkBH4DdB
         CvUhjsenE4r6DtyVkkWUx8nnz/LZzLpy/5Wb700ReIhfYOHax4Jhnsls5if7QFFgBreZ
         j0+v1NnJX3G/Xlc5MOD0sxG/VNUDknbyPzhkwaBvNDhhdbrTWThqauGGuwgF2QR9AlH3
         gEzjXrPKUmfvl4t/vGm9hmbIKjiD8Pe0PJ2Xt6kdxpUfovJVm/XVsiRTzn5jwsbLRZPm
         y7MQ==
X-Gm-Message-State: ACrzQf0YXE6gJTJswu1GPAO5Q5jeAZ7pLgkNUAkBfUB/JyIAYN4opYzZ
        l8Q/ju36DZ1vPZ+rZJeC0yQFHKKJpkPaJ7d2
X-Google-Smtp-Source: AMsMyM6fUQVd4OrdOgV2leHWeiC3n6G1tcdTR0kohH0PwI46eVBbyIJfNSRdnzG1HrcuRYZjXzEYzQ==
X-Received: by 2002:a1c:acc5:0:b0:3c6:eebf:feee with SMTP id v188-20020a1cacc5000000b003c6eebffeeemr28836514wme.122.1667701033417;
        Sat, 05 Nov 2022 19:17:13 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:8a0:7280:5801:9441:3dce:686c:bfc7])
        by smtp.gmail.com with ESMTPSA id q5-20020adf9dc5000000b002364835caacsm3395230wre.112.2022.11.05.19.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 19:17:12 -0700 (PDT)
From:   Pedro Falcato <pedro.falcato@gmail.com>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-mm@kvack.org
Cc:     sam@gentoo.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Rich Felker <dalias@libc.org>
Subject: [PATCH] fs/binfmt_elf: Fix memsz > filesz handling
Date:   Sun,  6 Nov 2022 02:16:57 +0000
Message-Id: <20221106021657.1145519-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The old code for ELF interpreter loading could only handle
1 memsz > filesz segment. This is incorrect, as evidenced
by the elf program loading code, which could handle multiple
such segments.

This patch fixes memsz > filesz handling for elf interpreters
and refactors interpreter/program BSS clearing into a common
codepath.

This bug was uncovered on builds of ppc64le musl libc with
llvm lld 15.0.0, since ppc64 does not allocate file space
for its .plt.

Cc: Rich Felker <dalias@libc.org>
Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 fs/binfmt_elf.c | 170 ++++++++++++++++--------------------------------
 1 file changed, 56 insertions(+), 114 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 6a11025e585..ca2961d80fa 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -109,25 +109,6 @@ static struct linux_binfmt elf_format = {
 
 #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
 
-static int set_brk(unsigned long start, unsigned long end, int prot)
-{
-	start = ELF_PAGEALIGN(start);
-	end = ELF_PAGEALIGN(end);
-	if (end > start) {
-		/*
-		 * Map the last of the bss segment.
-		 * If the header is requesting these pages to be
-		 * executable, honour that (ppc32 needs this).
-		 */
-		int error = vm_brk_flags(start, end - start,
-				prot & PROT_EXEC ? VM_EXEC : 0);
-		if (error)
-			return error;
-	}
-	current->mm->start_brk = current->mm->brk = end;
-	return 0;
-}
-
 /* We need to explicitly zero any fractional pages
    after the data section (i.e. bss).  This would
    contain the junk from the file that should not
@@ -584,6 +565,41 @@ static inline int make_prot(u32 p_flags, struct arch_elf_state *arch_state,
 	return arch_elf_adjust_prot(prot, arch_state, has_interp, is_interp);
 }
 
+static int zero_bss(unsigned long start, unsigned long end, int prot)
+{
+	/*
+	 * First pad the last page from the file up to
+	 * the page boundary, and zero it from elf_bss up to the end of the page.
+	 */
+	if (padzero(start))
+		return -EFAULT;
+
+	/*
+	 * Next, align both the file and mem bss up to the page size,
+	 * since this is where elf_bss was just zeroed up to, and where
+	 * last_bss will end after the vm_brk_flags() below.
+	 */
+
+	start = ELF_PAGEALIGN(start);
+	end = ELF_PAGEALIGN(end);
+
+	/* Finally, if there is still more bss to allocate, do it. */
+
+	return (end > start ? vm_brk_flags(start, end - start,
+		prot & PROT_EXEC ? VM_EXEC : 0) : 0);
+}
+
+static int set_brk(unsigned long start, unsigned long end, int prot)
+{
+	int error = zero_bss(start, end, prot);
+
+	if (error < 0)
+		return error;
+
+	current->mm->start_brk = current->mm->brk = ELF_PAGEALIGN(end);
+	return 0;
+}
+
 /* This is much more generalized than the library routine read function,
    so we keep this separate.  Technically the library read function
    is only provided so that we can read a.out libraries that have
@@ -597,8 +613,6 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	struct elf_phdr *eppnt;
 	unsigned long load_addr = 0;
 	int load_addr_set = 0;
-	unsigned long last_bss = 0, elf_bss = 0;
-	int bss_prot = 0;
 	unsigned long error = ~0UL;
 	unsigned long total_size;
 	int i;
@@ -662,50 +676,21 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 				goto out;
 			}
 
-			/*
-			 * Find the end of the file mapping for this phdr, and
-			 * keep track of the largest address we see for this.
-			 */
-			k = load_addr + eppnt->p_vaddr + eppnt->p_filesz;
-			if (k > elf_bss)
-				elf_bss = k;
+			if (eppnt->p_memsz > eppnt->p_filesz) {
+				/*
+				 * Handle BSS zeroing and mapping
+				 */
+				unsigned long start = load_addr + vaddr + eppnt->p_filesz;
+				unsigned long end = load_addr + vaddr + eppnt->p_memsz;
 
-			/*
-			 * Do the same thing for the memory mapping - between
-			 * elf_bss and last_bss is the bss section.
-			 */
-			k = load_addr + eppnt->p_vaddr + eppnt->p_memsz;
-			if (k > last_bss) {
-				last_bss = k;
-				bss_prot = elf_prot;
+				error = zero_bss(start, end, elf_prot);
+
+				if (error < 0)
+					goto out;
 			}
 		}
 	}
 
-	/*
-	 * Now fill out the bss section: first pad the last page from
-	 * the file up to the page boundary, and zero it from elf_bss
-	 * up to the end of the page.
-	 */
-	if (padzero(elf_bss)) {
-		error = -EFAULT;
-		goto out;
-	}
-	/*
-	 * Next, align both the file and mem bss up to the page size,
-	 * since this is where elf_bss was just zeroed up to, and where
-	 * last_bss will end after the vm_brk_flags() below.
-	 */
-	elf_bss = ELF_PAGEALIGN(elf_bss);
-	last_bss = ELF_PAGEALIGN(last_bss);
-	/* Finally, if there is still more bss to allocate, do it. */
-	if (last_bss > elf_bss) {
-		error = vm_brk_flags(elf_bss, last_bss - elf_bss,
-				bss_prot & PROT_EXEC ? VM_EXEC : 0);
-		if (error)
-			goto out;
-	}
-
 	error = load_addr;
 out:
 	return error;
@@ -829,8 +814,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
-	unsigned long elf_bss, elf_brk;
-	int bss_prot = 0;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1020,9 +1003,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				 executable_stack);
 	if (retval < 0)
 		goto out_free_dentry;
-	
-	elf_bss = 0;
-	elf_brk = 0;
 
 	start_code = ~0UL;
 	end_code = 0;
@@ -1041,33 +1021,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
 
-		if (unlikely (elf_brk > elf_bss)) {
-			unsigned long nbyte;
-	            
-			/* There was a PT_LOAD segment with p_memsz > p_filesz
-			   before this one. Map anonymous pages, if needed,
-			   and clear the area.  */
-			retval = set_brk(elf_bss + load_bias,
-					 elf_brk + load_bias,
-					 bss_prot);
-			if (retval)
-				goto out_free_dentry;
-			nbyte = ELF_PAGEOFFSET(elf_bss);
-			if (nbyte) {
-				nbyte = ELF_MIN_ALIGN - nbyte;
-				if (nbyte > elf_brk - elf_bss)
-					nbyte = elf_brk - elf_bss;
-				if (clear_user((void __user *)elf_bss +
-							load_bias, nbyte)) {
-					/*
-					 * This bss-zeroing can fail if the ELF
-					 * file specifies odd protections. So
-					 * we don't check the return value
-					 */
-				}
-			}
-		}
-
 		elf_prot = make_prot(elf_ppnt->p_flags, &arch_state,
 				     !!interpreter, false);
 
@@ -1211,41 +1164,30 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
 
-		if (k > elf_bss)
-			elf_bss = k;
+
+		if (elf_ppnt->p_memsz > elf_ppnt->p_filesz) {
+			unsigned long seg_end = elf_ppnt->p_vaddr +
+					 elf_ppnt->p_memsz + load_bias;
+			retval = set_brk(k + load_bias,
+					 seg_end,
+					 elf_prot);
+			if (retval)
+				goto out_free_dentry;
+		}
+
 		if ((elf_ppnt->p_flags & PF_X) && end_code < k)
 			end_code = k;
 		if (end_data < k)
 			end_data = k;
-		k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
-		if (k > elf_brk) {
-			bss_prot = elf_prot;
-			elf_brk = k;
-		}
 	}
 
 	e_entry = elf_ex->e_entry + load_bias;
 	phdr_addr += load_bias;
-	elf_bss += load_bias;
-	elf_brk += load_bias;
 	start_code += load_bias;
 	end_code += load_bias;
 	start_data += load_bias;
 	end_data += load_bias;
 
-	/* Calling set_brk effectively mmaps the pages that we need
-	 * for the bss and break sections.  We must do this before
-	 * mapping in the interpreter, to make sure it doesn't wind
-	 * up getting placed where the bss needs to go.
-	 */
-	retval = set_brk(elf_bss, elf_brk, bss_prot);
-	if (retval)
-		goto out_free_dentry;
-	if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bss))) {
-		retval = -EFAULT; /* Nobody gets to see this, but.. */
-		goto out_free_dentry;
-	}
-
 	if (interpreter) {
 		elf_entry = load_elf_interp(interp_elf_ex,
 					    interpreter,
-- 
2.38.1

