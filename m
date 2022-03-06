Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56854CE91B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 06:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiCFFeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 00:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiCFFeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 00:34:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080B03EB94;
        Sat,  5 Mar 2022 21:33:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DD16B80DF2;
        Sun,  6 Mar 2022 05:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AD2C340F6;
        Sun,  6 Mar 2022 05:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646544791;
        bh=fYelMDSbRkCmySORRYGtRxueIY8qkKKul1PQnCLAH7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZAMFDdzpbgA0U5lhYWfExCEKBLwd01PyByv18S/fV3M4av7Un4kAWupgJzcsihqj
         4HLqWF0AJdq76fyFRzZEBkUwPlq30bAbVAL3F/DVPx4lnWRIkK2SfXQo+CMUpVJbTn
         F/A2FHthGckJ0uCUdM0WlHn2Qi6tZ2eO/Ay2xPiVqAcLtM2wC5D9hh07K6atOgKBqY
         /g07YZOkIW9nXsbaEyJM0BYJvphPV1/7/xVz8calOm2tTVs/JZWkoyDVCRTmXTT3jg
         FCfbcZtTpQq/z61In+09wsMv+M/dJLdActsoEDlFKc4bQ0wmedMX5Gr9Z0dk5BYL9s
         f2Yz11oTiqj6Q==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-mm@kvack.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Alexey Gladkov <legion@kernel.org>,
        zhangyiru <zhangyiru3@huawei.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        linux-mips@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, codalist@coda.cs.cmu.edu,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 2/3] x86/sgx: Export sgx_encl_page_alloc()
Date:   Sun,  6 Mar 2022 07:32:06 +0200
Message-Id: <20220306053211.135762-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220306053211.135762-1-jarkko@kernel.org>
References: <20220306053211.135762-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 89aeed798ffb..79e39bd99c09 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -914,6 +914,44 @@ int sgx_encl_test_and_clear_young(struct mm_struct *mm,
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

