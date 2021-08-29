Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8363FAB61
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 14:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhH2M0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 08:26:40 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:57118 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235255AbhH2M0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 08:26:36 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A41nuca+3DiieefykfdBuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,361,1620662400"; 
   d="scan'208";a="113656447"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Aug 2021 20:25:37 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 354584D0D4A1;
        Sun, 29 Aug 2021 20:25:36 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 29 Aug 2021 20:25:30 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 29 Aug 2021 20:25:29 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <djwong@kernel.org>, <hch@lst.de>, <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH v8 3/7] fsdax: Replace mmap entry in case of CoW
Date:   Sun, 29 Aug 2021 20:25:13 +0800
Message-ID: <20210829122517.1648171-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com>
References: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 354584D0D4A1.A13A8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We replace the existing entry to the newly allocated one in case of CoW.
Also, we mark the entry as PAGECACHE_TAG_TOWRITE so writeback marks this
entry as writeprotected.  This helps us snapshots so new write
pagefaults after snapshots trigger a CoW.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c | 73 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 792116b14782..f4acb79cb811 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -734,6 +734,23 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
 	return 0;
 }
 
+/*
+ * MAP_SYNC on a dax mapping guarantees dirty metadata is
+ * flushed on write-faults (non-cow), but not read-faults.
+ */
+static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
+		struct vm_area_struct *vma)
+{
+	return (iter->flags & IOMAP_WRITE) && (vma->vm_flags & VM_SYNC)
+		&& (iter->iomap.flags & IOMAP_F_DIRTY);
+}
+
+static bool dax_fault_is_cow(const struct iomap_iter *iter)
+{
+	return (iter->flags & IOMAP_WRITE)
+		&& (iter->iomap.flags & IOMAP_F_SHARED);
+}
+
 /*
  * By this point grab_mapping_entry() has ensured that we have a locked entry
  * of the appropriate size so we don't have to worry about downgrading PMDs to
@@ -741,16 +758,19 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
  * already in the tree, we will skip the insertion and just dirty the PMD as
  * appropriate.
  */
-static void *dax_insert_entry(struct xa_state *xas,
-		struct address_space *mapping, struct vm_fault *vmf,
-		void *entry, pfn_t pfn, unsigned long flags, bool dirty)
+static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
+		const struct iomap_iter *iter, void *entry, pfn_t pfn,
+		unsigned long flags)
 {
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	void *new_entry = dax_make_entry(pfn, flags);
+	bool dirty = !dax_fault_is_synchronous(iter, vmf->vma);
+	bool cow = dax_fault_is_cow(iter);
 
 	if (dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 
-	if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
+	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
 		unsigned long index = xas->xa_index;
 		/* we are replacing a zero page with block mapping */
 		if (dax_is_pmd_entry(entry))
@@ -762,7 +782,7 @@ static void *dax_insert_entry(struct xa_state *xas,
 
 	xas_reset(xas);
 	xas_lock_irq(xas);
-	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
+	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
@@ -786,6 +806,9 @@ static void *dax_insert_entry(struct xa_state *xas,
 	if (dirty)
 		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
 
+	if (cow)
+		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
+
 	xas_unlock_irq(xas);
 	return entry;
 }
@@ -1111,17 +1134,15 @@ static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
  * If this page is ever written to we will re-fault and change the mapping to
  * point to real DAX storage instead.
  */
-static vm_fault_t dax_load_hole(struct xa_state *xas,
-		struct address_space *mapping, void **entry,
-		struct vm_fault *vmf)
+static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
+		const struct iomap_iter *iter, void **entry)
 {
-	struct inode *inode = mapping->host;
+	struct inode *inode = iter->inode;
 	unsigned long vaddr = vmf->address;
 	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
 	vm_fault_t ret;
 
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-			DAX_ZERO_PAGE, false);
+	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
 
 	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
 	trace_dax_load_hole(inode, vmf, ret);
@@ -1130,7 +1151,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
 
 #ifdef CONFIG_FS_DAX_PMD
 static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
-		const struct iomap *iomap, void **entry)
+		const struct iomap_iter *iter, void **entry)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	unsigned long pmd_addr = vmf->address & PMD_MASK;
@@ -1148,8 +1169,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		goto fallback;
 
 	pfn = page_to_pfn_t(zero_page);
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-			DAX_PMD | DAX_ZERO_PAGE, false);
+	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
+				  DAX_PMD | DAX_ZERO_PAGE);
 
 	if (arch_needs_pgtable_deposit()) {
 		pgtable = pte_alloc_one(vma->vm_mm);
@@ -1381,17 +1402,6 @@ static vm_fault_t dax_fault_return(int error)
 	return vmf_error(error);
 }
 
-/*
- * MAP_SYNC on a dax mapping guarantees dirty metadata is
- * flushed on write-faults (non-cow), but not read-faults.
- */
-static bool dax_fault_is_synchronous(unsigned long flags,
-		struct vm_area_struct *vma, const struct iomap *iomap)
-{
-	return (flags & IOMAP_WRITE) && (vma->vm_flags & VM_SYNC)
-		&& (iomap->flags & IOMAP_F_DIRTY);
-}
-
 /*
  * When handling a synchronous page fault and the inode need a fsync, we can
  * insert the PTE/PMD into page tables only after that fsync happened. Skip
@@ -1452,13 +1462,11 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 		const struct iomap_iter *iter, pfn_t *pfnp,
 		struct xa_state *xas, void **entry, bool pmd)
 {
-	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	const struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = &iter->srcmap;
 	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
-	bool write = vmf->flags & FAULT_FLAG_WRITE;
-	bool sync = dax_fault_is_synchronous(iter->flags, vmf->vma, iomap);
+	bool write = iter->flags & IOMAP_WRITE;
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
 	int err = 0;
 	pfn_t pfn;
@@ -1471,8 +1479,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	if (!write &&
 	    (iomap->type == IOMAP_UNWRITTEN || iomap->type == IOMAP_HOLE)) {
 		if (!pmd)
-			return dax_load_hole(xas, mapping, entry, vmf);
-		return dax_pmd_load_hole(xas, vmf, iomap, entry);
+			return dax_load_hole(xas, vmf, iter, entry);
+		return dax_pmd_load_hole(xas, vmf, iter, entry);
 	}
 
 	if (iomap->type != IOMAP_MAPPED && !(iomap->flags & IOMAP_F_SHARED)) {
@@ -1484,8 +1492,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	if (err)
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn, entry_flags,
-				  write && !sync);
+	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, entry_flags);
 
 	if (write &&
 	    srcmap->addr != IOMAP_HOLE && srcmap->addr != iomap->addr) {
@@ -1494,7 +1501,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 			return dax_fault_return(err);
 	}
 
-	if (sync)
+	if (dax_fault_is_synchronous(iter, vmf->vma))
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
 	/* insert PMD pfn */
-- 
2.32.0



