Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C68B4D1642
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 12:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346408AbiCHLaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 06:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346045AbiCHLaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:30:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81DA37A85;
        Tue,  8 Mar 2022 03:29:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FFF6B81868;
        Tue,  8 Mar 2022 11:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37F2C340EC;
        Tue,  8 Mar 2022 11:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646738960;
        bh=/ZE7KoA/CEZ9Cv7O8oC7vdpXC4AHqtlt9/5UjASb5C4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ioqBWh4cSnOzOuU/9i+dFIwPdadEchN5jfsV5HRU/gWchDvncPXRTmAmSzVJXdw5O
         RoLFK2P19uEyhLKCfnixFaexLkC+Aydq48DpprBuvJQD4nBAFziEHmpdQSmlr4PIv0
         +VtEcq0JXvhDGfSj2qVlfSiZ3vqlTVaTjl2WPyCCtgjkLGzx5bMQoTDpswmK/NcK6d
         5AQdd+yq25X0/zaixvd5ZjqiBPm5aDu4We+yervOrsFRD1P18uNk9m2Q5dWmJgJZYf
         +BpmyvP4E1BewqQdsRwWdJ46umflBSh0rzaNrw7wwvZ6jhmqsXcIkSnTP2KYAn6aLb
         /4td00AFAKcfw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH RFC v3 2/3] x86/sgx: Export sgx_encl_page_alloc()
Date:   Tue,  8 Mar 2022 13:28:32 +0200
Message-Id: <20220308112833.262805-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220308112833.262805-1-jarkko@kernel.org>
References: <20220308112833.262805-1-jarkko@kernel.org>
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

