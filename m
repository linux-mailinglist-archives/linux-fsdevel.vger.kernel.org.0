Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835F1459CCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 08:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhKWHhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 02:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbhKWHhb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 02:37:31 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8A1C061574;
        Mon, 22 Nov 2021 23:34:24 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id m24so16301334pls.10;
        Mon, 22 Nov 2021 23:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mNOFlAZbq9k+Mu/JTHbCIh5dzjFIh42+nN9c/Feohs=;
        b=l0JBdqgCRB1aHsIneMfPrpWXDEhQ4wIH3TEB86TGCpfTxpM/WJ2LUeWmGM8ZC3/mw5
         nl1zVETIxotOP4EQsjM+XWJC+520/1SVXPCddeICLzT373fVkL/7Lofg6QV+TP8Xv3k2
         9zII7uO7WZJMD5P89jL9FxHV/g0iLmBBfbMVfBmhuuXnaAQqQn+5XSZ6AnR7kjs6tfI2
         aY74XaRl1oDjHZE9tNFrbZm/SYPhYH7rXF+fEVECRStNw1s+OdLpfh+jg1Ln5mykFEVO
         DuZlf6K1BtF/XgdCHyOED6GM+3SnMl9Lei8OWIaKhJyz44jncGXP138U2hXRNb4Mr/cu
         WNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mNOFlAZbq9k+Mu/JTHbCIh5dzjFIh42+nN9c/Feohs=;
        b=xfAclm147ku3c9b/1ewKodXw1FC8iP19Map7Tr4z9pPzKCnyhi4FtQ6tw6l65gpzI/
         mz1RPhAF9agXX8WZPM52B1soEAg8LSriU11tJPT79E7F/7qCIyK7jXhLWjfIIg4a4PG5
         Bw5/4KAV1bYPXyre+QHfUD9zqIX3e+Pep54ZNkANkya18H2wnU13aFBWOCvZIPrS2aaI
         k1kg76zCI1lD/xA3PGwwSOLd2RgP5W2Xoj28avvjQFIZlGkd+KE46NY3QcbvivQkS0mK
         FKdXfFRMGs+F9HSIp+/GcIqDxiDMD1ZbI/7MWCH1Li9vr8OXW+JA0YoChVhkkz8xJWJv
         LAfg==
X-Gm-Message-State: AOAM531TQ+J3P966hEwFVOnOaSF8Jsksi+3MF1a/Ic3mxyQCBl8pY1Jx
        xfG4/C/UaQ2M8LfXr1bcVK8=
X-Google-Smtp-Source: ABdhPJw5z4WJquUdWT1YiAZ4TL3ixYctETOA9h8mQB/W8qMyd0B3QBMfNjz9HLZi1D4oazMvtapCdg==
X-Received: by 2002:a17:90b:3144:: with SMTP id ip4mr418708pjb.153.1637652864053;
        Mon, 22 Nov 2021 23:34:24 -0800 (PST)
Received: from nikka.usen.ad.jp (113x33x71x97.ap113.ftth.ucom.ne.jp. [113.33.71.97])
        by smtp.googlemail.com with ESMTPSA id q10sm957627pjd.0.2021.11.22.23.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 23:34:23 -0800 (PST)
From:   Akira Kawata <akirakawata1@gmail.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org
Cc:     akirakawata1@gmail.com, Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Date:   Tue, 23 Nov 2021 16:31:59 +0900
Message-Id: <20211123073157.198689-1-akirakawata1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=197921

As pointed out in the discussion of buglink, we cannot calculate AT_PHDR
as the sum of load_addr and exec->e_phoff. This is because exec->e_phoff
is the offset of PHDRs in the file and the address of PHDRs in the
memory may differ from it. This patch fixes the bug by calculating the
address of program headers from PT_LOADs directly.

Signed-off-by: Akira Kawata <akirakawata1@gmail.com>
---
Changes in v2:
- Remove unused load_addr from create_elf_tables.
- Improve the commit message.

 fs/binfmt_elf.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f8c7f26f1fbb..af8313e36665 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -170,8 +170,8 @@ static int padzero(unsigned long elf_bss)
 
 static int
 create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
-		unsigned long load_addr, unsigned long interp_load_addr,
-		unsigned long e_entry)
+		unsigned long interp_load_addr,
+		unsigned long e_entry, unsigned long phdr_addr)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long p = bprm->p;
@@ -257,7 +257,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
 	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
 	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
-	NEW_AUX_ENT(AT_PHDR, load_addr + exec->e_phoff);
+	NEW_AUX_ENT(AT_PHDR, phdr_addr);
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
@@ -823,7 +823,7 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 static int load_elf_binary(struct linux_binprm *bprm)
 {
 	struct file *interpreter = NULL; /* to shut gcc up */
- 	unsigned long load_addr = 0, load_bias = 0;
+	unsigned long load_addr = 0, load_bias = 0, phdr_addr = 0;
 	int load_addr_set = 0;
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
@@ -1169,6 +1169,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
@@ -1204,6 +1211,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	}
 
 	e_entry = elf_ex->e_entry + load_bias;
+	phdr_addr += load_bias;
 	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
@@ -1267,8 +1275,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out;
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
 
-	retval = create_elf_tables(bprm, elf_ex,
-			  load_addr, interp_load_addr, e_entry);
+	retval = create_elf_tables(bprm, elf_ex, interp_load_addr,
+				   e_entry, phdr_addr);
 	if (retval < 0)
 		goto out;
 
-- 
2.25.1

