Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DDB4D15E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 12:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346356AbiCHLMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 06:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346384AbiCHLMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:12:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F13745AF7;
        Tue,  8 Mar 2022 03:10:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04FB1B81624;
        Tue,  8 Mar 2022 11:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D959C36AE3;
        Tue,  8 Mar 2022 11:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646737856;
        bh=/ZE7KoA/CEZ9Cv7O8oC7vdpXC4AHqtlt9/5UjASb5C4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rqXAeGfgtHehh/O++trSzt+l6ncC1IiQmQu0xmci6iUm3XBdyzAZOVLYDKqAacvaz
         3NJq3a8t3Hv2lfTBAoxiL2ngCQkG0+H7aM6kKEySXj/i0NQd3W3VkbqE7uTUt6+TF0
         RKPU9XN65F+rNAvreKORb9HHnl5UZYbKBbhRdxJQGlgmWICIwesMOleIVkHK7r44pL
         Rvw4AVbR/MJtFylEFyYGxicn/LakH/xjAa08l1dTMpmYA3Znp+Zf+o62n4ezoXPlwB
         fYhGv47xyTYuQiCG+uT3tgbIZR7YQuHIga1AxLJY+DPy3TgOLB+YK3/TddQdzg7h6j
         XlasGRTyfwO8A==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH RFC v2 2/3] x86/sgx: Export sgx_encl_page_alloc()
Date:   Tue,  8 Mar 2022 13:10:02 +0200
Message-Id: <20220308111003.257351-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220308111003.257351-1-jarkko@kernel.org>
References: <20220308111003.257351-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move sgx_encl_page_alloc() to encl.c and export it so that it can be
used in the implementation for MAP_POPULATE, which requires to allocate
new enclave pages.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/encl.c  | 38 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/encl.h  |  3 +++
 arch/x86/kernel/cpu/sgx/ioctl.c | 38 ---------------------------------
 3 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index f24a41d3ec70..0256918b2c2f 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -913,6 +913,44 @@ int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 	return ret;
 }
 
+struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
+					  unsigned long offset,
+					  u64 secinfo_flags)
+{
+	struct sgx_encl_page *encl_page;
+	unsigned long prot;
+
+	encl_page = kzalloc(sizeof(*encl_page), GFP_KERNEL);
+	if (!encl_page)
+		return ERR_PTR(-ENOMEM);
+
+	encl_page->desc = encl->base + offset;
+	encl_page->encl = encl;
+
+	prot = _calc_vm_trans(secinfo_flags, SGX_SECINFO_R, PROT_READ)  |
+	       _calc_vm_trans(secinfo_flags, SGX_SECINFO_W, PROT_WRITE) |
+	       _calc_vm_trans(secinfo_flags, SGX_SECINFO_X, PROT_EXEC);
+
+	/*
+	 * TCS pages must always RW set for CPU access while the SECINFO
+	 * permissions are *always* zero - the CPU ignores the user provided
+	 * values and silently overwrites them with zero permissions.
+	 */
+	if ((secinfo_flags & SGX_SECINFO_PAGE_TYPE_MASK) == SGX_SECINFO_TCS)
+		prot |= PROT_READ | PROT_WRITE;
+
+	/* Calculate maximum of the VM flags for the page. */
+	encl_page->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
+
+	/*
+	 * At time of allocation, the runtime protection bits are the same
+	 * as the maximum protection bits.
+	 */
+	encl_page->vm_run_prot_bits = encl_page->vm_max_prot_bits;
+
+	return encl_page;
+}
+
 /**
  * sgx_zap_enclave_ptes() - remove PTEs mapping the address from enclave
  * @encl: the enclave
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 1b6ce1da7c92..3df0d3faf3a1 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -113,6 +113,9 @@ int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
 int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 				  struct sgx_encl_page *page);
+struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
+					  unsigned long offset,
+					  u64 secinfo_flags);
 void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
 struct sgx_epc_page *sgx_alloc_va_page(void);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index d8c3c07badb3..3e3ca27a6f72 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -169,44 +169,6 @@ static long sgx_ioc_enclave_create(struct sgx_encl *encl, void __user *arg)
 	return ret;
 }
 
-static struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
-						 unsigned long offset,
-						 u64 secinfo_flags)
-{
-	struct sgx_encl_page *encl_page;
-	unsigned long prot;
-
-	encl_page = kzalloc(sizeof(*encl_page), GFP_KERNEL);
-	if (!encl_page)
-		return ERR_PTR(-ENOMEM);
-
-	encl_page->desc = encl->base + offset;
-	encl_page->encl = encl;
-
-	prot = _calc_vm_trans(secinfo_flags, SGX_SECINFO_R, PROT_READ)  |
-	       _calc_vm_trans(secinfo_flags, SGX_SECINFO_W, PROT_WRITE) |
-	       _calc_vm_trans(secinfo_flags, SGX_SECINFO_X, PROT_EXEC);
-
-	/*
-	 * TCS pages must always RW set for CPU access while the SECINFO
-	 * permissions are *always* zero - the CPU ignores the user provided
-	 * values and silently overwrites them with zero permissions.
-	 */
-	if ((secinfo_flags & SGX_SECINFO_PAGE_TYPE_MASK) == SGX_SECINFO_TCS)
-		prot |= PROT_READ | PROT_WRITE;
-
-	/* Calculate maximum of the VM flags for the page. */
-	encl_page->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
-
-	/*
-	 * At time of allocation, the runtime protection bits are the same
-	 * as the maximum protection bits.
-	 */
-	encl_page->vm_run_prot_bits = encl_page->vm_max_prot_bits;
-
-	return encl_page;
-}
-
 static int sgx_validate_secinfo(struct sgx_secinfo *secinfo)
 {
 	u64 perm = secinfo->flags & SGX_SECINFO_PERMISSION_MASK;
-- 
2.35.1

