Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CFB4633B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 12:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbhK3MDO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 07:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhK3MDO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:03:14 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F977C061574;
        Tue, 30 Nov 2021 03:59:55 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v23so15148960pjr.5;
        Tue, 30 Nov 2021 03:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xj8+VoAa5ErdyHBdKdAIopD6fGg/e7bwG6LigikTmEk=;
        b=HjpTUJGQV2CWydG+K8sGVwBWAVgaWqVJF4IsrStsHUr0reZu3Au/oTASZi83B61vu3
         kxAHdsPBcwQnHH75SnWzx0u7CSDI6ojfjr3EoqCtEFu1SAlyJEJTkKSNtMWEYN/1daiE
         fMwxeo609A9pe+OYPk7MdOLJ2iKYphy1KynKVOkp7kHFJ1CDVBYduXwl1SSTddXh1aa2
         98cPVzPtKzLSa+Enailsvx8UkXIMKmVG5l/iqbcEPND45v6NOdzhxzTlvBMzoCm0pxvd
         Wy1qxowe0DUM69hOCiyG2Uh8GGazCcaZhsEPKw/zJuEQSqI29kvH+RQi1FEv9gysxAgA
         UX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xj8+VoAa5ErdyHBdKdAIopD6fGg/e7bwG6LigikTmEk=;
        b=CZNK381FHgTbYyUkqC0TcCamSAmT7YqCY7W3lxDnTXs05YhHEmfDL5rClanN4Fg+gU
         YqounnLcad9hHNEP/etrUOiYIP9T6cmfncbxjQSAgEGB/U2fEADioH1ged0OzuRYXTRI
         jL86XULU4AJ4Wp+EQ4cYxfNQUKQE3foJMoH/7q+nmmoMTgI9XxrlRgpwLuDe2K+CGZKK
         SKOspEjJ0A+94fj1YPwHrpkfSIkcMq5encrM14VS9OBV+CK48IXHPVm4CNSX2yNdqJHt
         YvrsvOzrOkIMAuxUItFa/D4cr1+RBCt8v+pEtUHrFWO+SjbiaBMZm3ZsiOSENFz0m3Vi
         ltKg==
X-Gm-Message-State: AOAM533N7CARwVR4x++IOiRp7uYs51h9txogAKUoar3Qf9LEjA4OPE4W
        4fQKXM3u6B7DcYhjAG9GiJY=
X-Google-Smtp-Source: ABdhPJyqcdXCN+mZ0u1qep/O+jSTSw23lNluUedkVylDa+MsoxKzNigQMJYC++/iAzt5n7+w9C137Q==
X-Received: by 2002:a17:902:b70b:b0:143:74b1:7e3b with SMTP id d11-20020a170902b70b00b0014374b17e3bmr68124338pls.26.1638273594698;
        Tue, 30 Nov 2021 03:59:54 -0800 (PST)
Received: from goshun.usen.ad.jp (113x33x71x97.ap113.ftth.ucom.ne.jp. [113.33.71.97])
        by smtp.gmail.com with ESMTPSA id f4sm22226555pfj.61.2021.11.30.03.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:59:54 -0800 (PST)
From:   Akira Kawata <akirakawata1@gmail.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org
Cc:     akirakawata1@gmail.com, kernel test robot <lkp@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Date:   Tue, 30 Nov 2021 20:59:07 +0900
Message-Id: <20211130115906.414176-1-akirakawata1@gmail.com>
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
Reported-by: kernel test robot <lkp@intel.com>
---
Changes in v3:
- Fix a reported bug from kernel test robot.

Changes in v2:
- Remove unused load_addr from create_elf_tables.
- Improve the commit message.

 fs/binfmt_elf.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index beeb1247b5c4..828e88841cb4 100644
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
@@ -822,7 +822,7 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 static int load_elf_binary(struct linux_binprm *bprm)
 {
 	struct file *interpreter = NULL; /* to shut gcc up */
- 	unsigned long load_addr = 0, load_bias = 0;
+	unsigned long load_addr, load_bias = 0, phdr_addr = 0;
 	int load_addr_set = 0;
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
@@ -1168,6 +1168,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
@@ -1203,6 +1210,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	}
 
 	e_entry = elf_ex->e_entry + load_bias;
+	phdr_addr += load_bias;
 	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
@@ -1266,8 +1274,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out;
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
 
-	retval = create_elf_tables(bprm, elf_ex,
-			  load_addr, interp_load_addr, e_entry);
+	retval = create_elf_tables(bprm, elf_ex, interp_load_addr,
+				   e_entry, phdr_addr);
 	if (retval < 0)
 		goto out;
 

base-commit: 34f255a1e91ab44ff8926cf8294ff9144e62e861
-- 
2.25.1

