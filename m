Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEDD23EDE8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgHGNON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 09:14:13 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10729 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726400AbgHGNON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:14:13 -0400
X-IronPort-AV: E=Sophos;i="5.75,445,1589212800"; 
   d="scan'208";a="97774912"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Aug 2020 21:13:42 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 3D9444CE34F4;
        Fri,  7 Aug 2020 21:13:38 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 7 Aug 2020 21:13:40 +0800
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 7 Aug 2020 21:13:40 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 7 Aug 2020 21:13:38 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH 2/8] fsdax, mm: track files sharing dax page for memory-failure
Date:   Fri, 7 Aug 2020 21:13:30 +0800
Message-ID: <20200807131336.318774-3-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
References: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3D9444CE34F4.AE25B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When memory-failure occurs on a pmem device which contains a filesystem,
we need to find out which files are in using, and then notify processes
that are using these files to handle the error.

The design of the track method is as follow:
1. dax_assocaite_entry() associates the owner's info to this page
- For non-reflink case:
  page->mapping,->index stores the file's mapping, offset in file.
    A dax page is not shared by other files. dax_associate_entry() is
    called only once.  So, use page->mapping,->index to store the
    owner's info.
- For reflink case:
  page->mapping,->index stores the block device, offset in device.
    A dax page is shared more than once.  So, dax_assocaite_entry()
    will be called more than once.  We introduce page->zone_device_data
    as reflink counter, to indicate that this page is shared and how
    many owners now is using this page. The page->mapping,->index is
    used to store the block_device of the fs and page offset of this
    device.

2. dax_lock_page() calls query interface to lock each dax entry
- For non-reflink case:
  owner's info is stored in page->mapping,->index.
    So, It is easy to lock its dax entry.
- For reflink case:
  owner's info is obtained by calling get_shared_files(), which is
  implemented by FS.
    The FS context could be found in block_device that stored by
    page->mapping.  Then lock the dax entries of the owners.

In memory-failure(), since owners list has been obtained in
dax_lock_page(), just iterate the list and handle the error.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/dax.c            | 111 +++++++++++++++++++++++++++--------
 include/linux/dax.h |   6 +-
 include/linux/mm.h  |   8 +++
 mm/memory-failure.c | 138 +++++++++++++++++++++++++++-----------------
 4 files changed, 183 insertions(+), 80 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 11b16729b86f..47380f75ef38 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -329,7 +329,7 @@ static unsigned long dax_end_pfn(void *entry)
  * offsets.
  */
 static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address)
+		struct vm_fault *vmf, pgoff_t offset)
 {
 	unsigned long size = dax_entry_size(entry), pfn, index;
 	int i = 0;
@@ -337,13 +337,27 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
 
-	index = linear_page_index(vma, address & ~(size - 1));
+	index = linear_page_index(vmf->vma, vmf->address & ~(size - 1));
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		WARN_ON_ONCE(page->mapping);
-		page->mapping = mapping;
-		page->index = index + i++;
+		BUG_ON(!page->mapping && IS_FSDAX_SHARED(page));
+
+		/* Use zone_device_data as reflink counter here.
+		 * If one page is associated for the first time, then use the
+		 * ->mapping,->index as normal.  For the second time it is
+		 * assocated, we store the block_device that this page belongs
+		 * to in ->mapping and the offset within this block_device in
+		 * ->index, and increase the reflink counter.
+		 */
+		if (!page->mapping) {
+			page->mapping = mapping;
+			page->index = index + i++;
+		} else {
+			page->mapping = (struct address_space *)mapping->host->i_sb->s_bdev;
+			page->index = offset;
+			page->zone_device_data++;
+		}
 	}
 }
 
@@ -359,9 +373,12 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 		struct page *page = pfn_to_page(pfn);
 
 		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
-		WARN_ON_ONCE(page->mapping && page->mapping != mapping);
-		page->mapping = NULL;
-		page->index = 0;
+		if (!IS_FSDAX_SHARED(page)) {
+			page->mapping = NULL;
+			page->index = 0;
+		} else {
+			page->zone_device_data--;
+		}
 	}
 }
 
@@ -386,7 +403,7 @@ static struct page *dax_busy_page(void *entry)
  * Return: A cookie to pass to dax_unlock_page() or 0 if the entry could
  * not be locked.
  */
-dax_entry_t dax_lock_page(struct page *page)
+void _dax_lock_page(struct page *page, struct shared_files *sfp)
 {
 	XA_STATE(xas, NULL, 0);
 	void *entry;
@@ -394,7 +411,7 @@ dax_entry_t dax_lock_page(struct page *page)
 	/* Ensure page->mapping isn't freed while we look at it */
 	rcu_read_lock();
 	for (;;) {
-		struct address_space *mapping = READ_ONCE(page->mapping);
+		struct address_space *mapping = READ_ONCE(sfp->mapping);
 
 		entry = NULL;
 		if (!mapping || !dax_mapping(mapping))
@@ -413,11 +430,11 @@ dax_entry_t dax_lock_page(struct page *page)
 
 		xas.xa = &mapping->i_pages;
 		xas_lock_irq(&xas);
-		if (mapping != page->mapping) {
+		if (mapping != sfp->mapping) {
 			xas_unlock_irq(&xas);
 			continue;
 		}
-		xas_set(&xas, page->index);
+		xas_set(&xas, sfp->index);
 		entry = xas_load(&xas);
 		if (dax_is_locked(entry)) {
 			rcu_read_unlock();
@@ -430,18 +447,61 @@ dax_entry_t dax_lock_page(struct page *page)
 		break;
 	}
 	rcu_read_unlock();
-	return (dax_entry_t)entry;
+	sfp->cookie = (dax_entry_t)entry;
+}
+
+int dax_lock_page(struct page *page, struct list_head *shared_files)
+{
+	struct shared_files *sfp;
+
+	if (IS_FSDAX_SHARED(page)) {
+		struct block_device *bdev = (struct block_device *)page->mapping;
+
+		bdev->bd_super->s_op->get_shared_files(bdev->bd_super,
+						page->index, shared_files);
+		list_for_each_entry(sfp, shared_files, list) {
+			_dax_lock_page(page, sfp);
+			if (!sfp->cookie)
+				return 1;
+		}
+	} else {
+		sfp = kmalloc(sizeof(*sfp), GFP_KERNEL);
+		sfp->mapping = page->mapping;
+		sfp->index = page->index;
+		list_add(&sfp->list, shared_files);
+		_dax_lock_page(page, sfp);
+		if (!sfp->cookie)
+			return 1;
+	}
+	return 0;
 }
 
-void dax_unlock_page(struct page *page, dax_entry_t cookie)
+void _dax_unlock_page(struct page *page, struct shared_files *sfp)
 {
-	struct address_space *mapping = page->mapping;
-	XA_STATE(xas, &mapping->i_pages, page->index);
+	struct address_space *mapping = sfp->mapping;
 
+	XA_STATE(xas, &mapping->i_pages, sfp->index);
 	if (S_ISCHR(mapping->host->i_mode))
 		return;
 
-	dax_unlock_entry(&xas, (void *)cookie);
+	dax_unlock_entry(&xas, (void *)sfp->cookie);
+}
+
+void dax_unlock_page(struct page *page, struct list_head *shared_files)
+{
+	struct shared_files *sfp, *next;
+
+	if (IS_FSDAX_SHARED(page)) {
+		list_for_each_entry_safe(sfp, next, shared_files, list) {
+			if (!sfp->cookie)
+				_dax_unlock_page(page, sfp);
+			kfree(sfp);
+		}
+	} else {
+		if (!sfp->cookie)
+			_dax_unlock_page(page, sfp);
+		kfree(sfp);
+	}
 }
 
 /*
@@ -715,7 +775,8 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
  */
 static void *dax_insert_entry(struct xa_state *xas,
 		struct address_space *mapping, struct vm_fault *vmf,
-		void *entry, pfn_t pfn, unsigned long flags, bool dirty)
+		pgoff_t bdoff, void *entry, pfn_t pfn, unsigned long flags,
+		bool dirty)
 {
 	void *new_entry = dax_make_entry(pfn, flags);
 
@@ -738,7 +799,7 @@ static void *dax_insert_entry(struct xa_state *xas,
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
+		dax_associate_entry(new_entry, mapping, vmf, bdoff);
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -1030,7 +1091,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
 	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
 	vm_fault_t ret;
 
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
+	*entry = dax_insert_entry(xas, mapping, vmf, 0, *entry, pfn,
 			DAX_ZERO_PAGE, false);
 
 	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
@@ -1337,8 +1398,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		if (error < 0)
 			goto error_finish_iomap;
 
-		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
-						 0, write && !sync);
+		entry = dax_insert_entry(&xas, mapping, vmf, iomap.addr, entry,
+					 pfn, 0, write && !sync);
 
 		/*
 		 * If we are doing synchronous page fault and inode needs fsync,
@@ -1418,7 +1479,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		goto fallback;
 
 	pfn = page_to_pfn_t(zero_page);
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
+	*entry = dax_insert_entry(xas, mapping, vmf, 0, *entry, pfn,
 			DAX_PMD | DAX_ZERO_PAGE, false);
 
 	if (arch_needs_pgtable_deposit()) {
@@ -1555,8 +1616,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		if (error < 0)
 			goto finish_iomap;
 
-		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
-						DAX_PMD, write && !sync);
+		entry = dax_insert_entry(&xas, mapping, vmf, iomap.addr, entry,
+					 pfn, DAX_PMD, write && !sync);
 
 		/*
 		 * If we are doing synchronous page fault and inode needs fsync,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 0a85e321d6b4..d6d9f4b721bc 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -8,7 +8,7 @@
 
 /* Flag for synchronous flush */
 #define DAXDEV_F_SYNC (1UL << 0)
-
+#define IS_FSDAX_SHARED(p) ((unsigned long)p->zone_device_data != 0)
 typedef unsigned long dax_entry_t;
 
 struct iomap_ops;
@@ -148,8 +148,8 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 		struct dax_device *dax_dev, struct writeback_control *wbc);
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
-dax_entry_t dax_lock_page(struct page *page);
-void dax_unlock_page(struct page *page, dax_entry_t cookie);
+int dax_lock_page(struct page *page, struct list_head *shared_files);
+void dax_unlock_page(struct page *page, struct list_head *shared_files);
 #else
 static inline bool bdev_dax_supported(struct block_device *bdev,
 		int blocksize)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc7b87310c10..bffccc34f1a1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1115,6 +1115,14 @@ static inline bool is_device_private_page(const struct page *page)
 		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
 }
 
+static inline bool is_device_fsdax_page(const struct page *page)
+{
+	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
+		IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
+		is_zone_device_page(page) &&
+		page->pgmap->type == MEMORY_DEVICE_FS_DAX;
+}
+
 static inline bool is_pci_p2pdma_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 47b8ccb1fb9b..53cc65821c99 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -93,9 +93,13 @@ static int hwpoison_filter_dev(struct page *p)
 	if (PageSlab(p))
 		return -EINVAL;
 
-	mapping = page_mapping(p);
-	if (mapping == NULL || mapping->host == NULL)
-		return -EINVAL;
+	if (is_device_fsdax_page(p) & IS_FSDAX_SHARED(p))
+		dev = ((struct block_device *)p->mapping)->s_dev;
+	else {
+		mapping = page_mapping(p);
+		if (mapping == NULL || mapping->host == NULL)
+			return -EINVAL;
+	}
 
 	dev = mapping->host->i_sb->s_dev;
 	if (hwpoison_filter_dev_major != ~0U &&
@@ -263,9 +267,8 @@ void shake_page(struct page *p, int access)
 EXPORT_SYMBOL_GPL(shake_page);
 
 static unsigned long dev_pagemap_mapping_shift(struct page *page,
-		struct vm_area_struct *vma)
+		struct vm_area_struct *vma, unsigned long address)
 {
-	unsigned long address = vma_address(page, vma);
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -306,8 +309,8 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
  */
 static void add_to_kill(struct task_struct *tsk, struct page *p,
-		       struct vm_area_struct *vma,
-		       struct list_head *to_kill)
+		       struct address_space *mapping, pgoff_t offset,
+		       struct vm_area_struct *vma, struct list_head *to_kill)
 {
 	struct to_kill *tk;
 
@@ -317,12 +320,18 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 		return;
 	}
 
-	tk->addr = page_address_in_vma(p, vma);
-	if (is_zone_device_page(p))
-		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
-	else
-		tk->size_shift = page_shift(compound_head(p));
-
+	if (is_device_fsdax_page(p)) {
+		tk->addr = vma->vm_start +
+				((offset - vma->vm_pgoff) << PAGE_SHIFT);
+		tk->size_shift = dev_pagemap_mapping_shift(p, vma, tk->addr);
+	} else {
+		tk->addr = page_address_in_vma(p, vma);
+		if (is_zone_device_page(p)) {
+			tk->size_shift = dev_pagemap_mapping_shift(p, vma,
+							vma_address(p, vma));
+		} else
+			tk->size_shift = page_shift(compound_head(p));
+	}
 	/*
 	 * Send SIGKILL if "tk->addr == -EFAULT". Also, as
 	 * "tk->size_shift" is always non-zero for !is_zone_device_page(),
@@ -468,33 +477,26 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, NULL, 0, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
 	page_unlock_anon_vma_read(av);
 }
 
-/*
- * Collect processes when the error hit a file mapped page.
- */
-static void collect_procs_file(struct page *page, struct list_head *to_kill,
-				int force_early)
+static void collect_procs_file_one(struct page *page, struct list_head *to_kill,
+		struct address_space *mapping, pgoff_t pgoff, bool force_early)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
-	struct address_space *mapping = page->mapping;
 
 	i_mmap_lock_read(mapping);
 	read_lock(&tasklist_lock);
 	for_each_process(tsk) {
-		pgoff_t pgoff = page_to_pgoff(page);
 		struct task_struct *t = task_early_kill(tsk, force_early);
-
 		if (!t)
 			continue;
-		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff,
-				      pgoff) {
+		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
 			/*
 			 * Send early kill signal to tasks where a vma covers
 			 * the page but the corrupted page is not necessarily
@@ -502,19 +504,39 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			 * Assume applications who requested early kill want
 			 * to be informed of all such data corruptions.
 			 */
-			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+			if (vma->vm_mm == t->mm) {
+				add_to_kill(t, page, mapping, pgoff, vma,
+					    to_kill);
+			}
 		}
 	}
 	read_unlock(&tasklist_lock);
 	i_mmap_unlock_read(mapping);
 }
 
+/*
+ * Collect processes when the error hit a file mapped page.
+ */
+static void collect_procs_file(struct page *page, struct list_head *to_kill,
+		struct list_head *shared_files, int force_early)
+{
+	struct shared_files *sfp;
+
+	if (shared_files)
+		list_for_each_entry(sfp, shared_files, list) {
+			collect_procs_file_one(page, to_kill, sfp->mapping,
+					       sfp->index, force_early);
+		}
+	else
+		collect_procs_file_one(page, to_kill, page->mapping,
+				       page_to_pgoff(page), force_early);
+}
+
 /*
  * Collect the processes who have the corrupted page mapped to kill.
  */
 static void collect_procs(struct page *page, struct list_head *tokill,
-				int force_early)
+		struct list_head *shared_files, int force_early)
 {
 	if (!page->mapping)
 		return;
@@ -522,7 +544,33 @@ static void collect_procs(struct page *page, struct list_head *tokill,
 	if (PageAnon(page))
 		collect_procs_anon(page, tokill, force_early);
 	else
-		collect_procs_file(page, tokill, force_early);
+		collect_procs_file(page, tokill, shared_files, force_early);
+}
+
+static void unmap_mappings_range(struct list_head *to_kill,
+		struct list_head *shared_files)
+{
+	unsigned long size = 0;
+	loff_t start = 0;
+	struct to_kill *tk;
+	struct shared_files *sfp;
+
+	list_for_each_entry(tk, to_kill, nd)
+		if (tk->size_shift)
+			size = max(size, 1UL << tk->size_shift);
+	if (size) {
+		/*
+		 * Unmap the largest mapping to avoid breaking up
+		 * device-dax mappings which are constant size. The
+		 * actual size of the mapping being torn down is
+		 * communicated in siginfo, see kill_proc()
+		 */
+		list_for_each_entry(sfp, shared_files, list) {
+			start = (sfp->index << PAGE_SHIFT) & ~(size - 1);
+			unmap_mapping_range(sfp->mapping, start,
+					    start + size, 0);
+		}
+	}
 }
 
 static const char *action_name[] = {
@@ -1026,7 +1074,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * there's nothing that can be done.
 	 */
 	if (kill)
-		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
+		collect_procs(hpage, &tokill, NULL, flags & MF_ACTION_REQUIRED);
 
 	if (!PageHuge(hpage)) {
 		unmap_success = try_to_unmap(hpage, ttu);
@@ -1181,12 +1229,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 {
 	struct page *page = pfn_to_page(pfn);
 	const bool unmap_success = true;
-	unsigned long size = 0;
-	struct to_kill *tk;
 	LIST_HEAD(tokill);
+	LIST_HEAD(shared_files);
 	int rc = -EBUSY;
-	loff_t start;
-	dax_entry_t cookie;
+	int error = 0;
 
 	/*
 	 * Prevent the inode from being freed while we are interrogating
@@ -1195,9 +1241,9 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	 * also prevents changes to the mapping of this pfn until
 	 * poison signaling is complete.
 	 */
-	cookie = dax_lock_page(page);
-	if (!cookie)
-		goto out;
+	error = dax_lock_page(page, &shared_files);
+	if (error)
+		goto unlock;
 
 	if (hwpoison_filter(page)) {
 		rc = 0;
@@ -1225,26 +1271,14 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	 * SIGBUS (i.e. MF_MUST_KILL)
 	 */
 	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
-	collect_procs(page, &tokill, flags & MF_ACTION_REQUIRED);
+	collect_procs(page, &tokill, &shared_files, flags & MF_ACTION_REQUIRED);
+
+	unmap_mappings_range(&tokill, &shared_files);
 
-	list_for_each_entry(tk, &tokill, nd)
-		if (tk->size_shift)
-			size = max(size, 1UL << tk->size_shift);
-	if (size) {
-		/*
-		 * Unmap the largest mapping to avoid breaking up
-		 * device-dax mappings which are constant size. The
-		 * actual size of the mapping being torn down is
-		 * communicated in siginfo, see kill_proc()
-		 */
-		start = (page->index << PAGE_SHIFT) & ~(size - 1);
-		unmap_mapping_range(page->mapping, start, start + size, 0);
-	}
 	kill_procs(&tokill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
 	rc = 0;
 unlock:
-	dax_unlock_page(page, cookie);
-out:
+	dax_unlock_page(page, &shared_files);
 	/* drop pgmap ref acquired in caller */
 	put_dev_pagemap(pgmap);
 	action_result(pfn, MF_MSG_DAX, rc ? MF_FAILED : MF_RECOVERED);
-- 
2.27.0



