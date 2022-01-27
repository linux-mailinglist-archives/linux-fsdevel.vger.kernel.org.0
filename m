Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC12149E2AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 13:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbiA0MmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 07:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241382AbiA0MmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:42:06 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19B8C06174A;
        Thu, 27 Jan 2022 04:42:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so7436792pju.2;
        Thu, 27 Jan 2022 04:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iqi3lBVf+uaBkRIvQ16oY2EMA/KLN24v0OYA9daSmGM=;
        b=hIHTRqfZGtRmmbe3zGKxBV/yOlJtRteGQnSy+5NIWxIp9AasPD1vvZB97LoIGsIDQc
         8KLgUob8fav1Z2/WpNLYRQjnosgaAs3ydKlxir/Xi7b0XH6/e+7XtZP0q8KoN0wDdwJD
         t3Ayoh7QDuRWqiMv0MPOMD0OPAfkXZJYL+PpIPQl/quq0ealNHTJun1tbbrMJbvC6ZOo
         FrRV1ZxHp0vBNn5wEx4TqHuoHwNSrndBxbqNcpah94Dp2RgsB8iCoAnSMWLpllcZX2hJ
         RKWibYa50mbLu0s1vOlf38E4zqCr87CQ/3dcrOMBvOBq5QeeCbFPRh3QhxLe8bYn7noj
         FDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iqi3lBVf+uaBkRIvQ16oY2EMA/KLN24v0OYA9daSmGM=;
        b=3+Cuz+T3m6DvY23S9hc+uvMUwWJzOMywiu8IFSFAqvZcUMSSIF7PuNfW8I7/8AxAQL
         3jE7IVC1JWa3Ti2w2isifdF35KTe3sy7EncaBkLAXLLO9Cfz/NhUAzHyYxYCcp9upewl
         BWKuZ4qRBBAH5HJ4HOXkKp8lald83P2jIvdq99+bW5HLR9Uir6PuNtzisZ5KQdktkxFx
         gIwGV6IFb8bGnckaR8r7F+PUtO0X5DZ+fPWkdOg99wJRtjkS1Z8v5TJ95qVLRCA2sJwj
         lau+ok2wlbwroWQ4iUnqSCjzv98Ow046yf5T4XQ8nyyaLsk3Qzoo3mmswR9mu6ohtPu+
         qmEQ==
X-Gm-Message-State: AOAM531NZFWy0JEFeIt2IPVCqsyIzYejUzVmW4a0QbAb2JLuL/S93fY5
        cIpvXXJGVSZWmpuMQppwOps=
X-Google-Smtp-Source: ABdhPJwukzDWSol7dDsWgIrzDEWgR22ezRZ04Kmn+TUWXtXAFRigDgBhu2UDR7ujUvYrsXGZ9YyiPw==
X-Received: by 2002:a17:902:db0b:: with SMTP id m11mr3206717plx.104.1643287325364;
        Thu, 27 Jan 2022 04:42:05 -0800 (PST)
Received: from localhost.localdomain ([2400:2410:93a3:bc00:d205:ec9:b1c6:b9ee])
        by smtp.gmail.com with ESMTPSA id m38sm19071298pgl.64.2022.01.27.04.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 04:42:04 -0800 (PST)
From:   Akira Kawata <akirakawata1@gmail.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     akirakawata1@gmail.com, kernel test robot <lkp@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Date:   Thu, 27 Jan 2022 21:40:16 +0900
Message-Id: <20220127124014.338760-2-akirakawata1@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127124014.338760-1-akirakawata1@gmail.com>
References: <20220127124014.338760-1-akirakawata1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=197921

As pointed out in the discussion of buglink, we cannot calculate AT_PHDR
as the sum of load_addr and exec->e_phoff.

: The AT_PHDR of ELF auxiliary vectors should point to the memory address
: of program header. But binfmt_elf.c calculates this address as follows:
:
: NEW_AUX_ENT(AT_PHDR, load_addr + exec->e_phoff);
:
: which is wrong since e_phoff is the file offset of program header and
: load_addr is the memory base address from PT_LOAD entry.
:
: The ld.so uses AT_PHDR as the memory address of program header. In normal
: case, since the e_phoff is usually 64 and in the first PT_LOAD region, it
: is the correct program header address.
:
: But if the address of program header isn't equal to the first PT_LOAD
: address + e_phoff (e.g.  Put the program header in other non-consecutive
: PT_LOAD region), ld.so will try to read program header from wrong address
: then crash or use incorrect program header.

This is because exec->e_phoff
is the offset of PHDRs in the file and the address of PHDRs in the
memory may differ from it. This patch fixes the bug by calculating the
address of program headers from PT_LOADs directly.

Signed-off-by: Akira Kawata <akirakawata1@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 0a25b8049b74..d120ab03795f 100644
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
@@ -1168,6 +1168,17 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				reloc_func_desc = load_bias;
 			}
 		}
+
+		/*
+		 * Figure out which segment in the file contains the Program
+		 * Header table, and map to the associated memory address.
+		 */
+		if (elf_ppnt->p_offset <= elf_ex->e_phoff &&
+		    elf_ex->e_phoff < elf_ppnt->p_offset + elf_ppnt->p_filesz) {
+			phdr_addr = elf_ex->e_phoff - elf_ppnt->p_offset +
+				    elf_ppnt->p_vaddr;
+		}
+
 		k = elf_ppnt->p_vaddr;
 		if ((elf_ppnt->p_flags & PF_X) && k < start_code)
 			start_code = k;
@@ -1203,6 +1214,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	}
 
 	e_entry = elf_ex->e_entry + load_bias;
+	phdr_addr += load_bias;
 	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
@@ -1266,8 +1278,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
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

