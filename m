Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031214E9414
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 13:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbiC1L0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 07:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241123AbiC1LZT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:25:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE08C46;
        Mon, 28 Mar 2022 04:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F0BFB81063;
        Mon, 28 Mar 2022 11:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F441C34110;
        Mon, 28 Mar 2022 11:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648466603;
        bh=uVvsxXcsuV/zpwAblQs5D1i0APRLwni14f7UeSMlovg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOmReTl1Z/0FSv5czi3SumGYxKpoIzPrdIvav+s9Ei+DrSJfsTkXWRIDW4s23nPHh
         5ZF4PQItDatu+1OzIs6b0vwmdrDMrhrNy8OxqZNvcfTs7WnDM5NxiDcHbXCDc2V4EX
         iOjKEkqANO6wDDpjwjkN9NqUzkUSO7E/aOiPZ+LE5FiSP2pikaMsyyCJ0d+IM8RwrN
         fu7meCS4t1wBm8yAsevlfYjXyTZ91AEUdrdEy4sK0CWULb4G7g8svJXuHP2UfSIAQD
         HO1yl3mdQVV+Oqi/suInlQG7zbgydvaeDY5ACcNHZGDhRQ3/DxnZrpvfMldnUath2i
         JP6SR+NrG9Bwg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Akira Kawata <akirakawata1@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.10 12/21] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Date:   Mon, 28 Mar 2022 07:22:45 -0400
Message-Id: <20220328112254.1556286-12-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328112254.1556286-1-sashal@kernel.org>
References: <20220328112254.1556286-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Akira Kawata <akirakawata1@gmail.com>

[ Upstream commit 0da1d5002745cdc721bc018b582a8a9704d56c42 ]

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
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220127124014.338760-2-akirakawata1@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_elf.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 04c4aa7a1df2..ed507d27034b 100644
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
+	unsigned long load_addr, load_bias = 0, phdr_addr = 0;
 	int load_addr_set = 0;
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
@@ -1153,6 +1153,17 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
@@ -1188,6 +1199,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	}
 
 	e_entry = elf_ex->e_entry + load_bias;
+	phdr_addr += load_bias;
 	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
@@ -1251,8 +1263,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
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

