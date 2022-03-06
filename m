Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F1E4CE91E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 06:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiCFFeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 00:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiCFFeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 00:34:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F013E5F5;
        Sat,  5 Mar 2022 21:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D77486117B;
        Sun,  6 Mar 2022 05:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC34DC340EF;
        Sun,  6 Mar 2022 05:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646544798;
        bh=1QleQuXD9sbYe+LmMXGxObgEQXN9PMHkgqkds+kRlTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=br5rY6M8UUvmHms71AlgV5lsODOmGXw50MS4+I7V3fElgLb1vTu6qkTPjqi9p/dbq
         4yNZe7DQNlbD0VSvppQYCxnMI0UN8amuBXXfmZMqztoZCCA9IC5Nd5svIFTZMuuKUs
         uvus/R1Z//ZKIJWKCAdh7lkXI29aKiUZm+8QTv6ORJ1FzJWbmN0xsZJ9okwsiG65HU
         Q5NDUSii2Syt8UHh4JyJBS0siKxrhe0QxfBPhS7eXwugtFzSn/NqmWIfTYAc2e3AU7
         SjgecmBC1M7G8Cl8UthVLZ2xk8evtzDlzNhm3mEz66egcGd+rub4wBzjX4nQkRJ5HJ
         wGLon7vKnOtQA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-mm@kvack.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        zhangyiru <zhangyiru3@huawei.com>, linux-mips@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        codalist@coda.cs.cmu.edu, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 3/3] x86/sgx: Implement EAUG population with MAP_POPULATE
Date:   Sun,  6 Mar 2022 07:32:07 +0200
Message-Id: <20220306053211.135762-4-jarkko@kernel.org>
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

With SGX1 an enclave needs to be created with its maximum memory demands
pre-allocated. Pages cannot be added to an enclave after it is initialized.
SGX2 introduces a new function, ENCLS[EAUG] for adding pages to an
initialized enclave.

Add support for dynamically adding pages to an initialized enclave with
mmap() by populating pages with EAUG. Use f_ops->populate() callback to
achieve this behaviour.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/driver.c | 129 +++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index aa9b8b868867..0e97e7476076 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -9,6 +9,7 @@
 #include <asm/traps.h>
 #include "driver.h"
 #include "encl.h"
+#include "encls.h"
 
 u64 sgx_attributes_reserved_mask;
 u64 sgx_xfrm_reserved_mask = ~0x3;
@@ -101,6 +102,133 @@ static int sgx_mmap(struct file *file, struct vm_area_struct *vma)
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
+static int sgx_populate(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned long length = vma->vm_end - vma->vm_start;
+	struct sgx_encl *encl = file->private_data;
+	unsigned long start = encl->base - vma->vm_start;
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
@@ -133,6 +261,7 @@ static const struct file_operations sgx_encl_fops = {
 	.compat_ioctl		= sgx_compat_ioctl,
 #endif
 	.mmap			= sgx_mmap,
+	.populate		= sgx_populate,
 	.get_unmapped_area	= sgx_get_unmapped_area,
 };
 
-- 
2.35.1

