Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4191471EB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 00:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhLLX0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 18:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhLLX0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 18:26:07 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88692C06173F;
        Sun, 12 Dec 2021 15:26:07 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 200so4190594pgg.3;
        Sun, 12 Dec 2021 15:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gnz/TM9XA4aQ7WsKnqv951zvpXQKVHgY3IrgIsMRO/M=;
        b=K+3uziOOeOKh/d37q+FvFgJS/NbGFKy96MApTETuZ91AhV8+L7an2t8wjFlZefAvz0
         XQrxESyN0BW8wkmHCKyQZ36DLuiqwtJ5jZk9hvpmIx0elvC32hSOAwmQWoRbx6oD4kAk
         PDzddS4PvnMNcrZzpNfYJ5xfmSalSGVXVLKup18NdYR7spA3XhV1TssfYYorBH6AaC2+
         Cuj79klRsGUu65iCZHkzUrHyYdTia+DC9lJrkXKhwrxtC4hxUxBIhydzRZoHSvY/0cbV
         G94MgqNJz2PZ8EDgw5vDLjrEjpz6N7Ax5jHJaVflHob65HrtzvQxUX13wN8GrNVC1fM2
         3lRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gnz/TM9XA4aQ7WsKnqv951zvpXQKVHgY3IrgIsMRO/M=;
        b=PP3rAPOSb6HMQvJy34hdsqKUCqgpI4Edim3Sl6kTsrfqMUW2GWzC0f75con9m9bXWd
         uNhMSfifsI6uPTRtKwIinDMbUg3U0RPe1EvRf7dg64Wjfx4ym9+mZcwIBHpEnE13cKb0
         DrcEUuPxZpTuMKw9Gv2wuR6ZIbmjexZQzvFwlTHp/mYokKFZCh7AKG9tWPrxVd5Hta38
         vD/3ngAsrgxPzfELu97ipBullmhl1MgbjIGXjMYgLfSPzc4ULRznIQGUDGqeDfY47f6P
         nXlsc/dT+zOSAjI/HgNGWiAwFNFJjlJ2RlN6LNDyHQRAvdDwZDjdiwtUzNcKGaFdGboO
         PR9w==
X-Gm-Message-State: AOAM533CgpzV8eHh5O/n37kVmWCpA4dsfegYTX7Wv/o1B0ZxSt/8sD3i
        DkaPiSF+OG8Dy66UMTuvJns=
X-Google-Smtp-Source: ABdhPJyhvvVw0VGUM335WCYGq2rSABmUhc3rGgu2XW5SThzTd8lU1W4o5G19nZVHX6zuxDvNztfcfQ==
X-Received: by 2002:a63:3446:: with SMTP id b67mr43321464pga.424.1639351567052;
        Sun, 12 Dec 2021 15:26:07 -0800 (PST)
Received: from hibiki.localdomain ([2400:2410:93a3:bc00:c35d:e29e:99a3:5fd9])
        by smtp.googlemail.com with ESMTPSA id j7sm5281813pjf.41.2021.12.12.15.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 15:26:06 -0800 (PST)
From:   Akira Kawata <akirakawata1@gmail.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     akirakawata1@gmail.com, kernel test robot <lkp@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Date:   Mon, 13 Dec 2021 08:24:11 +0900
Message-Id: <20211212232414.1402199-2-akirakawata1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211212232414.1402199-1-akirakawata1@gmail.com>
References: <20211212232414.1402199-1-akirakawata1@gmail.com>
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
2.34.1

