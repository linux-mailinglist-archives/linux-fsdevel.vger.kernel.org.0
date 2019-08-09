Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0658867C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 00:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbfHIW7K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 18:59:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:47931 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730724AbfHIW7I (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:59:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:59:07 -0700
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; 
   d="scan'208";a="374631601"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:59:07 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH v2 17/19] RDMA/umem: Convert to vaddr_[pin|unpin]* operations.
Date:   Fri,  9 Aug 2019 15:58:31 -0700
Message-Id: <20190809225833.6657-18-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809225833.6657-1-ira.weiny@intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In order to properly track the pinning information we need to keep a
vaddr_pin object around.  Store that within the umem object directly.

The vaddr_pin object allows the GUP code to associate any files it pins
with the RDMA file descriptor associated with this GUP.

Furthermore, use the vaddr_pin object to store the owning mm while we
are at it.

No references need to be taken on the owing file as the lifetime of that
object is tied to all the umems being destroyed first.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/infiniband/core/umem.c     | 26 +++++++++++++++++---------
 drivers/infiniband/core/umem_odp.c | 16 ++++++++--------
 include/rdma/ib_umem.h             |  2 +-
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 965cf9dea71a..a9ce3e3816ef 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -54,7 +54,8 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
 
 	for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->sg_nents, 0) {
 		page = sg_page_iter_page(&sg_iter);
-		put_user_pages_dirty_lock(&page, 1, umem->writable && dirty);
+		vaddr_unpin_pages_dirty_lock(&page, 1, &umem->vaddr_pin,
+					     umem->writable && dirty);
 	}
 
 	sg_free_table(&umem->sg_head);
@@ -243,8 +244,15 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 	umem->length     = size;
 	umem->address    = addr;
 	umem->writable   = ib_access_writable(access);
-	umem->owning_mm = mm = current->mm;
-	mmgrab(mm);
+	umem->vaddr_pin.mm = mm = current->mm;
+	mmgrab(umem->vaddr_pin.mm);
+
+	/* No need to get a reference to the core file object here.  The key is
+	 * that sys_file reference is held by the ufile.  Any duplication of
+	 * sys_file by the core will keep references active until all those
+	 * contexts are closed out.  No matter which process hold them open.
+	 */
+	umem->vaddr_pin.f_owner = context->ufile->sys_file;
 
 	if (access & IB_ACCESS_ON_DEMAND) {
 		if (WARN_ON_ONCE(!context->invalidate_range)) {
@@ -292,11 +300,11 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 
 	while (npages) {
 		down_read(&mm->mmap_sem);
-		ret = get_user_pages(cur_base,
+		ret = vaddr_pin_pages(cur_base,
 				     min_t(unsigned long, npages,
 					   PAGE_SIZE / sizeof (struct page *)),
-				     gup_flags | FOLL_LONGTERM,
-				     page_list, NULL);
+				     gup_flags,
+				     page_list, &umem->vaddr_pin);
 		if (ret < 0) {
 			up_read(&mm->mmap_sem);
 			goto umem_release;
@@ -336,7 +344,7 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 	free_page((unsigned long) page_list);
 umem_kfree:
 	if (ret) {
-		mmdrop(umem->owning_mm);
+		mmdrop(umem->vaddr_pin.mm);
 		kfree(umem);
 	}
 	return ret ? ERR_PTR(ret) : umem;
@@ -345,7 +353,7 @@ EXPORT_SYMBOL(ib_umem_get);
 
 static void __ib_umem_release_tail(struct ib_umem *umem)
 {
-	mmdrop(umem->owning_mm);
+	mmdrop(umem->vaddr_pin.mm);
 	if (umem->is_odp)
 		kfree(to_ib_umem_odp(umem));
 	else
@@ -369,7 +377,7 @@ void ib_umem_release(struct ib_umem *umem)
 
 	__ib_umem_release(umem->context->device, umem, 1);
 
-	atomic64_sub(ib_umem_num_pages(umem), &umem->owning_mm->pinned_vm);
+	atomic64_sub(ib_umem_num_pages(umem), &umem->vaddr_pin.mm->pinned_vm);
 	__ib_umem_release_tail(umem);
 }
 EXPORT_SYMBOL(ib_umem_release);
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 2a75c6f8d827..53085896d718 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -278,11 +278,11 @@ static int get_per_mm(struct ib_umem_odp *umem_odp)
 	 */
 	mutex_lock(&ctx->per_mm_list_lock);
 	list_for_each_entry(per_mm, &ctx->per_mm_list, ucontext_list) {
-		if (per_mm->mm == umem_odp->umem.owning_mm)
+		if (per_mm->mm == umem_odp->umem.vaddr_pin.mm)
 			goto found;
 	}
 
-	per_mm = alloc_per_mm(ctx, umem_odp->umem.owning_mm);
+	per_mm = alloc_per_mm(ctx, umem_odp->umem.vaddr_pin.mm);
 	if (IS_ERR(per_mm)) {
 		mutex_unlock(&ctx->per_mm_list_lock);
 		return PTR_ERR(per_mm);
@@ -355,8 +355,8 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root,
 	umem->writable   = root->umem.writable;
 	umem->is_odp = 1;
 	odp_data->per_mm = per_mm;
-	umem->owning_mm  = per_mm->mm;
-	mmgrab(umem->owning_mm);
+	umem->vaddr_pin.mm  = per_mm->mm;
+	mmgrab(umem->vaddr_pin.mm);
 
 	mutex_init(&odp_data->umem_mutex);
 	init_completion(&odp_data->notifier_completion);
@@ -389,7 +389,7 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root,
 out_page_list:
 	vfree(odp_data->page_list);
 out_odp_data:
-	mmdrop(umem->owning_mm);
+	mmdrop(umem->vaddr_pin.mm);
 	kfree(odp_data);
 	return ERR_PTR(ret);
 }
@@ -399,10 +399,10 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 {
 	struct ib_umem *umem = &umem_odp->umem;
 	/*
-	 * NOTE: This must called in a process context where umem->owning_mm
+	 * NOTE: This must called in a process context where umem->vaddr_pin.mm
 	 * == current->mm
 	 */
-	struct mm_struct *mm = umem->owning_mm;
+	struct mm_struct *mm = umem->vaddr_pin.mm;
 	int ret_val;
 
 	umem_odp->page_shift = PAGE_SHIFT;
@@ -581,7 +581,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 			      unsigned long current_seq)
 {
 	struct task_struct *owning_process  = NULL;
-	struct mm_struct *owning_mm = umem_odp->umem.owning_mm;
+	struct mm_struct *owning_mm = umem_odp->umem.vaddr_pin.mm;
 	struct page       **local_page_list = NULL;
 	u64 page_mask, off;
 	int j, k, ret = 0, start_idx, npages = 0;
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 1052d0d62be7..ab677c799e29 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -43,7 +43,6 @@ struct ib_umem_odp;
 
 struct ib_umem {
 	struct ib_ucontext     *context;
-	struct mm_struct       *owning_mm;
 	size_t			length;
 	unsigned long		address;
 	u32 writable : 1;
@@ -52,6 +51,7 @@ struct ib_umem {
 	struct sg_table sg_head;
 	int             nmap;
 	unsigned int    sg_nents;
+	struct vaddr_pin vaddr_pin;
 };
 
 /* Returns the offset of the umem start relative to the first page. */
-- 
2.20.1

