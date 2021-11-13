Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9054B44F243
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Nov 2021 10:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbhKMJJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Nov 2021 04:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhKMJJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Nov 2021 04:09:22 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B5BC061766;
        Sat, 13 Nov 2021 01:06:30 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so8862221pjb.5;
        Sat, 13 Nov 2021 01:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ti0cvMiudaMlWyE0UacHKfn2iPDthSO6EZEOM/OpGwQ=;
        b=hS+m6lnpdvQyCYfJTZKfrzf8fr5d+e3QOm9Dyg5dmRjqTDSh/5t6KwPHmiuqY1zR5E
         /unP7kFCgYItPqll3ERZ4SGMGAufRXS5jU1yvGei2+dikxIbi3zrW1kCehIZEd8OA9kG
         9RrLT9zYYmY2zrV/YFUZuF1YQ8TF4yl+x47cawqpVlOCOz0hRXqvqb5x0WzaOJlpfjJ2
         HCsiqnwJsoWp4yABx2riHeynS39jD+hgSDUKYaD47Hc72IbOiXpD/rMS4o9VC7oNNtDr
         HjuK339rCSc1aV6NEWdYKCu4Wjzx+vP3HR/7Q2ybh/10Fu4z4+P11YKryDFRaQDtoM11
         QO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ti0cvMiudaMlWyE0UacHKfn2iPDthSO6EZEOM/OpGwQ=;
        b=RqCG1Nq+FxTawtehmJJk1BEjpGNWhi4k9HINK6EV7c3lLAo16ClrlRZxMwNPdJZMjs
         /9fbzmzKKoAy6hh08e8ycrXDyyRcCYCXq+O+uOIidMAnHDAobx1qelWUQ3Dv+jHNuEr0
         4xBjaOlGeQtSQetO+QQSJlZDNkbN4rJ4uvCNW739PXgoo2FUOLmnoSDj/UZaZAHEfewe
         Z0xTxgkKmTH0HUPsjH85M7b8aQm/YcCtJEqrV6puCLAFXCH0PVPhKT6YqajhXQc+BIuZ
         b1+R21WN9heACKM+tACuwP2AX5ceyh05LK3jYzDCY373XZm2V2dc58vKXUK76GUogsPH
         CWzg==
X-Gm-Message-State: AOAM530NkWy6JERVeH7cTFAZ1r+u83hm6w1x6OPrMQ9Hke/a7R+8rEP9
        tuahi6QpXMFu2uk9On/hmF0=
X-Google-Smtp-Source: ABdhPJz3Nbxb49EeTyGcFSjrKp150UJIi5Lt8b2N1uUhtxkitKRCcy1FZCUysy0F+ZwHrzoIxASnXA==
X-Received: by 2002:a17:903:285:b0:142:7a83:6dd2 with SMTP id j5-20020a170903028500b001427a836dd2mr15534754plr.59.1636794389225;
        Sat, 13 Nov 2021 01:06:29 -0800 (PST)
Received: from hibiki.localdomain ([2400:2410:93a3:bc00:c35d:e29e:99a3:5fd9])
        by smtp.googlemail.com with ESMTPSA id b18sm9824940pfl.24.2021.11.13.01.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 01:06:28 -0800 (PST)
From:   Akira Kawata <akirakawata1@gmail.com>
Cc:     akirakawata1@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Date:   Sat, 13 Nov 2021 18:06:18 +0900
Message-Id: <20211113090618.40463-1-akirakawata1@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=197921

As pointed out in the discussion of buglink, we cannot calculate AT_PHDR
as the sum of load_addr and exec->e_phoff. This patch fixes the bug by
calculating the address of program headers from PT_LOADs.

Signed-off-by: Akira Kawata <akirakawata1@gmail.com>
---
 fs/binfmt_elf.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 950bc177238a..998f44c7bb21 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -171,7 +171,7 @@ static int padzero(unsigned long elf_bss)
 static int
 create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 		unsigned long load_addr, unsigned long interp_load_addr,
-		unsigned long e_entry)
+		unsigned long e_entry, unsigned long phdr_addr)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long p = bprm->p;
@@ -256,7 +256,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
 	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
 	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
-	NEW_AUX_ENT(AT_PHDR, load_addr + exec->e_phoff);
+	NEW_AUX_ENT(AT_PHDR, phdr_addr);
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
@@ -820,7 +820,7 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 static int load_elf_binary(struct linux_binprm *bprm)
 {
 	struct file *interpreter = NULL; /* to shut gcc up */
- 	unsigned long load_addr = 0, load_bias = 0;
+	unsigned long load_addr = 0, load_bias = 0, phdr_addr = 0;
 	int load_addr_set = 0;
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
@@ -1153,6 +1153,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				reloc_func_desc = load_bias;
 			}
 		}
+
+		if (elf_ppnt->p_offset <= elf_ex->e_phoff &&
+		    elf_ex->e_phoff < elf_ppnt->p_offset + elf_ppnt->p_filesz) {
+			phdr_addr = elf_ex->e_phoff - elf_ppnt->p_offset +
+				    elf_ppnt->p_vaddr;
+		}
+
 		k = elf_ppnt->p_vaddr;
 		if ((elf_ppnt->p_flags & PF_X) && k < start_code)
 			start_code = k;
@@ -1188,6 +1195,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	}
 
 	e_entry = elf_ex->e_entry + load_bias;
+	phdr_addr += load_bias;
 	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
@@ -1251,8 +1259,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out;
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
 
-	retval = create_elf_tables(bprm, elf_ex,
-			  load_addr, interp_load_addr, e_entry);
+	retval = create_elf_tables(bprm, elf_ex, load_addr, interp_load_addr,
+				   e_entry, phdr_addr);
 	if (retval < 0)
 		goto out;
 
-- 
2.33.1

