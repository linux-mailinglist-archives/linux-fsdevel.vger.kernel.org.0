Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA92D486DBD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 00:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245544AbiAFXZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 18:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245535AbiAFXZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:25:59 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0D9C061245;
        Thu,  6 Jan 2022 15:25:58 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id s1so3914762pga.5;
        Thu, 06 Jan 2022 15:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9uYrwWK0qBU1uAlortCuyQVlYSe40KP7ZL9ruA6NNYE=;
        b=nfe6tXWYry+Eo4w8cY6aZn3NANeXr84y0uc7Uz69kCikhQZm1Bt0huLuJ3tPzBj5Ma
         buyHJWR7Bzmrpmxl1KtsyMw4gk58MAvnd7djbOs/AtCAwdvMUryLosS/kHOB0JnAq+MK
         +WLnVrQVYDxp+VqM9UahWS9wr56D5kcq0xEGJQfzvucbTbDSPY/hK79ek1hglbCVlg8s
         oCQM5QkcVd3sMleuNJ2rBSidEbSdl0A0Mkkrv6qqDdH2smxZWO//lGaMKPF8rUOEpDrU
         B7ATHUuUNmmzrWxFShzGYw1al3GS0BaO3syys5lPl2OX3n5m+3d/ibWnBsu1DOYnkpIy
         mPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9uYrwWK0qBU1uAlortCuyQVlYSe40KP7ZL9ruA6NNYE=;
        b=1caNxRYWkn6/cOfzd4AVe7fX6IeP4KIF/buHjNhxibq8zM5QB6kVxF0siV08Xl9nCr
         iGDrzfoUpk4RFVSlvy+Uu51AlukDNfER4bAVBo75nzjlhikf3wHDP/IgYpnc7qhTetLt
         V1LPXK2i0/F9W2FFTCk05yq/dLd+M3kTSwcfHAMUSSDWMfGcAC0FS5fOBohgEJyNS5Oa
         zVX3Inn/T3k+Fr+BaDVS3X6GUjjnnhfV8RYsxa7Z1/QmNsSOzcF845nXZXFVNYjVyqlk
         zu91sqAXdJyYdD6Vttx1f785Mxv9sRuk77zhSKRP4EpCvMvRr4m8hK3YfeO8KurBNvnW
         +jJw==
X-Gm-Message-State: AOAM532Q+l8NCVPQQB0jUKKm65GwkgOTy149keWFsMCeSSJsgEXxZe0V
        wjw4y3XNtgWVMwAPObcgdVo=
X-Google-Smtp-Source: ABdhPJzPdwqHQGbRleQTgGDUxZt7G6IwauON4hx9kpPLah5ngHBxE3SUECIu1ayvVqaU9cpestjBMw==
X-Received: by 2002:aa7:8896:0:b0:4bb:38e3:28eb with SMTP id z22-20020aa78896000000b004bb38e328ebmr62051917pfe.24.1641511558377;
        Thu, 06 Jan 2022 15:25:58 -0800 (PST)
Received: from goshun.usen.ad.jp (113x33x71x97.ap113.ftth.ucom.ne.jp. [113.33.71.97])
        by smtp.gmail.com with ESMTPSA id r13sm2937078pga.29.2022.01.06.15.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:25:58 -0800 (PST)
From:   Akira Kawata <akirakawata1@gmail.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     akirakawata1@gmail.com, kernel test robot <lkp@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 RESEND 1/2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Date:   Fri,  7 Jan 2022 08:25:12 +0900
Message-Id: <20220106232513.143014-2-akirakawata1@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106232513.143014-1-akirakawata1@gmail.com>
References: <20220106232513.143014-1-akirakawata1@gmail.com>
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
---
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
 
-- 
2.25.1

