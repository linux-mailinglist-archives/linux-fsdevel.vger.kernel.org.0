Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9984D15E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 12:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346405AbiCHLML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 06:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346358AbiCHLME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:12:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C3046654;
        Tue,  8 Mar 2022 03:11:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70A00B817ED;
        Tue,  8 Mar 2022 11:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D486DC340EC;
        Tue,  8 Mar 2022 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646737861;
        bh=Cgl0qA66PzKkXnlxny3eTwo2XWjpLBhZQNxtn6qkKoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CVtFPe97vYFj1FySCYQWFItXlCjdHBBevaQR2H2MDTh3XK+vDmVt//BRtA8eHgtSQ
         sjX3dV+dGnVsmQYynsHa/6CG+cH0iJ2JSz3zSBflrcMfirdI7SyWgZhv0+b1zK8Qtx
         LQYHNrL7tJC94dmVVVh2CnD+25qW+oEDV+a+ghj9X2HmsDMXGQ90hDhpJZ0b6QOBT6
         lp7hj/hCt2UF8R+q8mi8232uYww0mHcsALmH/I0HEEQR9/JhaihoUeYb4yqZzavdE7
         vcolydOfAj/JirilBmcmgMWxom4Fj+/urpSMPIBbrl/KqfGN9mquzr1bqZP6F5GxKm
         93WsFFOMUijxg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH RFC v2 3/3] x86/sgx: Implement EAUG population with MAP_POPULATE
Date:   Tue,  8 Mar 2022 13:10:03 +0200
Message-Id: <20220308111003.257351-4-jarkko@kernel.org>
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

With SGX1 an enclave needs to be created with its maximum memory demands
pre-allocated. Pages cannot be added to an enclave after it is initialized.
SGX2 introduces a new function, ENCLS[EAUG] for adding pages to an
initialized enclave.

Add support for dynamically adding pages to an initialized enclave with
mmap() by populating pages with EAUG. Use f_ops->populate() callback to
achieve this behaviour.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/driver.c | 128 +++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index aa9b8b868867..848938334e8a 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -9,6 +9,7 @@
 #include <asm/traps.h>
 #include "driver.h"
 #include "encl.h"
+#include "encls.h"
 
 u64 sgx_attributes_reserved_mask;
 u64 sgx_xfrm_reserved_mask = ~0x3;
@@ -101,6 +102,132 @@ static int sgx_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int sgx_encl_augment_page(struct sgx_encl *encl, unsigned long offset)
+{
+	struct sgx_pageinfo pginfo = {0};
+	struct sgx_encl_page *encl_page;
+	struct sgx_epc_page *epc_page;
+	struct sgx_va_page *va_page;
+	u64 secinfo_flags;
+	int ret;
+
+	/*
+	 * Ignore internal permission checking for dynamically added pages.
+	 * They matter only for data added during the pre-initialization phase.
+	 * The enclave decides the permissions by the means of EACCEPT,
+	 * EACCEPTCOPY and EMODPE.
+	 */
+	secinfo_flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_X;
+	encl_page = sgx_encl_page_alloc(encl, offset, secinfo_flags);
+	if (IS_ERR(encl_page))
+		return PTR_ERR(encl_page);
+
+	epc_page = sgx_alloc_epc_page(encl_page, true);
+	if (IS_ERR(epc_page)) {
+		ret = PTR_ERR(epc_page);
+		goto err_alloc_epc_page;
+	}
+
+	va_page = sgx_encl_grow(encl);
+	if (IS_ERR(va_page)) {
+		ret = PTR_ERR(va_page);
+		goto err_grow;
+	}
+
+	mutex_lock(&encl->lock);
+
+	/*
+	 * Adding to encl->va_pages must be done under encl->lock.  Ditto for
+	 * deleting (via sgx_encl_shrink()) in the error path.
+	 */
+	if (va_page)
+		list_add(&va_page->list, &encl->va_pages);
+
+	/*
+	 * Insert prior to EADD in case of OOM.  EADD modifies MRENCLAVE, i.e.
+	 * can't be gracefully unwound, while failure on EADD/EXTEND is limited
+	 * to userspace errors (or kernel/hardware bugs).
+	 */
+	ret = xa_insert(&encl->page_array, PFN_DOWN(encl_page->desc),
+			encl_page, GFP_KERNEL);
+
+	/*
+	 * If ret == -EBUSY then page was created in another flow while
+	 * running without encl->lock
+	 */
+	if (ret)
+		goto err_xa_insert;
+
+	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
+	pginfo.addr = encl_page->desc & PAGE_MASK;
+	pginfo.metadata = 0;
+
+	ret = __eaug(&pginfo, sgx_get_epc_virt_addr(epc_page));
+	if (ret)
+		goto err_eaug;
+
+	encl_page->encl = encl;
+	encl_page->epc_page = epc_page;
+	encl_page->type = SGX_PAGE_TYPE_REG;
+	encl->secs_child_cnt++;
+
+	sgx_mark_page_reclaimable(encl_page->epc_page);
+
+	mutex_unlock(&encl->lock);
+
+	return 0;
+
+err_eaug:
+	xa_erase(&encl->page_array, PFN_DOWN(encl_page->desc));
+
+err_xa_insert:
+	sgx_encl_shrink(encl, va_page);
+	mutex_unlock(&encl->lock);
+
+err_grow:
+	sgx_encl_free_epc_page(epc_page);
+
+err_alloc_epc_page:
+	kfree(encl_page);
+
+	return VM_FAULT_SIGBUS;
+}
+
+/*
+ * Add new pages to the enclave sequentially with ENCLS[EAUG]. Note that
+ * sgx_mmap() validates that the given VMA is within the enclave range. Calling
+ * here sgx_encl_may_map() second time would too time consuming.
+ */
+static int sgx_populate(struct file *file, unsigned long start, unsigned long end)
+{
+	struct sgx_encl *encl = file->private_data;
+	unsigned long length = end - start;
+	unsigned long pos;
+	int ret;
+
+	/* EAUG works only for initialized enclaves. */
+	if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
+		return -EINVAL;
+
+	for (pos = 0 ; pos < length; pos += PAGE_SIZE) {
+		if (signal_pending(current)) {
+			if (!pos)
+				ret = -ERESTARTSYS;
+
+			break;
+		}
+
+		if (need_resched())
+			cond_resched();
+
+		ret = sgx_encl_augment_page(encl, start + pos);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static unsigned long sgx_get_unmapped_area(struct file *file,
 					   unsigned long addr,
 					   unsigned long len,
@@ -133,6 +260,7 @@ static const struct file_operations sgx_encl_fops = {
 	.compat_ioctl		= sgx_compat_ioctl,
 #endif
 	.mmap			= sgx_mmap,
+	.populate		= sgx_populate,
 	.get_unmapped_area	= sgx_get_unmapped_area,
 };
 
-- 
2.35.1

