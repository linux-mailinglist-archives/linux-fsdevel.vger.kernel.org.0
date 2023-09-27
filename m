Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C0E7AF97A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 06:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjI0EfN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 00:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjI0EeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:34:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7915FF5
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 20:42:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c3f97f2239so91738445ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 20:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695786145; x=1696390945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1S2QHXg38kETw2Vrnc3ITAH/+VCqfp/XhwxJe7fVnI=;
        b=k0E+QxA4OV8E5mylkojffngpwkYwv8qFWaHbI/u9tlv2Eui5TWOn7AGnT2TVhC/Oju
         D8aSUUT7g7I3iyZNtsHfMNqOQb90FVcHzcDKep/BaUWwF3V8IRyAEo/RgKhxhvvPxzAT
         aBRvTqi//8cZF9+LD42mrDAUkPuwbZKsRGspY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695786145; x=1696390945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1S2QHXg38kETw2Vrnc3ITAH/+VCqfp/XhwxJe7fVnI=;
        b=PM9qsqmPJqA4HGe0L5vOGbc4LRHjF5W7m27lFCkmXAcKxDziR+qDV18e/y9ZeizXd9
         vLzv3AHo0j7pR4ZhoH85u1sIhRnsQqQHZ405xrBHPx4FJTTe6nYpICozLXPjyCqrOI8F
         ue5JI1c1mioaqOUe7m6/catAzs2tjRDpFzNlR8ovvd7NmGTVB1LUWM6kITa4DgNESID2
         r/aVEX4qFXEuQDq+UjDmEgVUnXTlItgFWuFgE8c1noWShGpJOPXmuHSAcSdhCfKDrzMi
         AcWVz0lrFtQSqTPfRPJ4iRd7HktdUlZYaBjCq6abBMQ91vLc4P518KuWRfDZm+jejsJ0
         y3hA==
X-Gm-Message-State: AOJu0YxqbeRIY16mYKSY/2OJqUJ/vl4507jnddTV3n/9CWUc7bmsYuL+
        pPO+L8SyNKvDWibEi9cd1wr6hQ==
X-Google-Smtp-Source: AGHT+IFe7SiLGGQxcesMYUTekhGYP9tx7X00nTSSjxQpTyzG+5pYTZ/MtjR/GtWHi7oYLAWe7SLIfQ==
X-Received: by 2002:a17:902:db0a:b0:1c6:2dbb:e5fa with SMTP id m10-20020a170902db0a00b001c62dbbe5famr755412plx.44.1695786145303;
        Tue, 26 Sep 2023 20:42:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz19-20020a170902ef9300b001c3bc7b8816sm11900661plb.284.2023.09.26.20.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:42:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sebastian Ott <sebott@redhat.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/4] binfmt_elf: Support segments with 0 filesz and misaligned starts
Date:   Tue, 26 Sep 2023 20:42:18 -0700
Message-Id: <20230927034223.986157-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927033634.make.602-kees@kernel.org>
References: <20230927033634.make.602-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8056; i=keescook@chromium.org;
 h=from:subject; bh=17HFsxzRR6qjNPl2OqeDyONMEClWu0Ld8l5K3CgB/PI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlE6Sd9ky4C5SoI1ZcjBN8kT+abWcWJ1uQcH9Lv
 1XdD+58PfSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZROknQAKCRCJcvTf3G3A
 JoKdEACLlARnwXh8gO+l0ringMMre5I4XKiCn1NVJQv/JS/kN/l3wYxfL7OoFGJto2s+6iml7nK
 peWKblSMEhaNZAO8qfqYUyi/ZpP3RBKGBcBlze989hvAGAq75DOpEdN8PoeowwFXFUbACsQcX8Q
 OtIJfFZIiP6qNwdHVe2tudNOTtW5glJyjdBoEm8Bs0tLgHa+H8PDBqU2e+SCFQQzYLktWLPY1DQ
 Rt1+dVHxoom31wssNi01Pm2Fwna3qyPOWL8xB162Mq+0lTRlxBsLJJEfDYn3xdeVPLs3l+5xGYB
 u+DgPFiv2QGDibshSWyYSvsaCmG5jLBuIbV37VJPE9rnj/DM7N/PHGkV2EMgUzNuHcPtUfr414T
 jM5KuTByaqkRJia081X3TfoAawDH9SPSRrs8fAKq1ErKhi81NdP2bljkE7VknEsJ4FfLBb0rhts
 ciyyJj4tpRVZek8NF6AxjqZrIvV0XSK8OO3qntjbUkVGX6p+XCrW8peffqsynyr2eV0D8Io0EQg
 YZ3nGO5w1nG6RxWJYAP51wZZ74RhpWRfOxDkqOxu7XG345mE0IJgdel6mb87HZhY+i7W/TmcfVl
 5rlv5Ll1/Vne3C9HV5g3tHhcOdIzX0C2TpVOSyEa4z4b/2ru9eR7hJdsF7O6potoe4OVwkXAkxr zsu/qJWtB/3bjDQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Implement a helper elf_load() that wraps elf_map() and performs all
of the necessary work to ensure that when "memsz > filesz" the bytes
described by "memsz > filesz" are zeroed.

An outstanding issue is if the first segment has filesz 0, and has a
randomized location. But that is the same as today.

In this change I replaced an open coded padzero() that did not clear
all of the way to the end of the page, with padzero() that does.

I also stopped checking the return of padzero() as there is at least
one known case where testing for failure is the wrong thing to do.
It looks like binfmt_elf_fdpic may have the proper set of tests
for when error handling can be safely completed.

I found a couple of commits in the old history
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git,
that look very interesting in understanding this code.

commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail")
commit c6e2227e4a3e ("[SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c")
commit 5bf3be033f50 ("v2.4.10.1 -> v2.4.10.2")

Looking at commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail"):
>  commit 39b56d902bf35241e7cba6cc30b828ed937175ad
>  Author: Pavel Machek <pavel@ucw.cz>
>  Date:   Wed Feb 9 22:40:30 2005 -0800
>
>     [PATCH] binfmt_elf: clearing bss may fail
>
>     So we discover that Borland's Kylix application builder emits weird elf
>     files which describe a non-writeable bss segment.
>
>     So remove the clear_user() check at the place where we zero out the bss.  I
>     don't _think_ there are any security implications here (plus we've never
>     checked that clear_user() return value, so whoops if it is a problem).
>
>     Signed-off-by: Pavel Machek <pavel@suse.cz>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>

It seems pretty clear that binfmt_elf_fdpic with skipping clear_user() for
non-writable segments and otherwise calling clear_user(), aka padzero(),
and checking it's return code is the right thing to do.

I just skipped the error checking as that avoids breaking things.

And notably, it looks like Borland's Kylix died in 2005 so it might be
safe to just consider read-only segments with memsz > filesz an error.

Reported-by: Sebastian Ott <sebott@redhat.com>
Reported-by: Thomas Weißschuh <linux@weissschuh.net>
Closes: https://lkml.kernel.org/r/20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lore.kernel.org/r/87sf71f123.fsf@email.froward.int.ebiederm.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c | 111 +++++++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 63 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 7b3d2d491407..2a615f476e44 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -110,25 +110,6 @@ static struct linux_binfmt elf_format = {
 
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
@@ -406,6 +387,51 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	return(map_addr);
 }
 
+static unsigned long elf_load(struct file *filep, unsigned long addr,
+		const struct elf_phdr *eppnt, int prot, int type,
+		unsigned long total_size)
+{
+	unsigned long zero_start, zero_end;
+	unsigned long map_addr;
+
+	if (eppnt->p_filesz) {
+		map_addr = elf_map(filep, addr, eppnt, prot, type, total_size);
+		if (BAD_ADDR(map_addr))
+			return map_addr;
+		if (eppnt->p_memsz > eppnt->p_filesz) {
+			zero_start = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+				eppnt->p_filesz;
+			zero_end = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+				eppnt->p_memsz;
+
+			/* Zero the end of the last mapped page */
+			padzero(zero_start);
+		}
+	} else {
+		map_addr = zero_start = ELF_PAGESTART(addr);
+		zero_end = zero_start + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+			eppnt->p_memsz;
+	}
+	if (eppnt->p_memsz > eppnt->p_filesz) {
+		/*
+		 * Map the last of the segment.
+		 * If the header is requesting these pages to be
+		 * executable, honour that (ppc32 needs this).
+		 */
+		int error;
+
+		zero_start = ELF_PAGEALIGN(zero_start);
+		zero_end = ELF_PAGEALIGN(zero_end);
+
+		error = vm_brk_flags(zero_start, zero_end - zero_start,
+				     prot & PROT_EXEC ? VM_EXEC : 0);
+		if (error)
+			map_addr = error;
+	}
+	return map_addr;
+}
+
+
 static unsigned long total_mapping_size(const struct elf_phdr *phdr, int nr)
 {
 	elf_addr_t min_addr = -1;
@@ -829,7 +855,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
 	unsigned long elf_bss, elf_brk;
-	int bss_prot = 0;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1040,33 +1065,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
 
@@ -1162,7 +1160,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			}
 		}
 
-		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
+		error = elf_load(bprm->file, load_bias + vaddr, elf_ppnt,
 				elf_prot, elf_flags, total_size);
 		if (BAD_ADDR(error)) {
 			retval = IS_ERR_VALUE(error) ?
@@ -1217,10 +1215,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (end_data < k)
 			end_data = k;
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
-		if (k > elf_brk) {
-			bss_prot = elf_prot;
+		if (k > elf_brk)
 			elf_brk = k;
-		}
 	}
 
 	e_entry = elf_ex->e_entry + load_bias;
@@ -1232,18 +1228,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
+	current->mm->start_brk = current->mm->brk = ELF_PAGEALIGN(elf_brk);
 
 	if (interpreter) {
 		elf_entry = load_elf_interp(interp_elf_ex,
-- 
2.34.1

