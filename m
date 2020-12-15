Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525352DACEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 13:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgLOMQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 07:16:28 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:22820 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728902AbgLOMQZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:16:25 -0500
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="102420203"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Dec 2020 20:15:00 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id F15564CE546D;
        Tue, 15 Dec 2020 20:14:54 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 15 Dec 2020 20:14:54 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 15 Dec 2020 20:14:32 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <song@kernel.org>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH v3 4/9] mm, fsdax: Refactor memory-failure handler for dax mapping
Date:   Tue, 15 Dec 2020 20:14:09 +0800
Message-ID: <20201215121414.253660-5-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: F15564CE546D.AF425
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current memory_failure_dev_pagemap() can only handle single-mapped
dax page for fsdax mode.  The dax page could be mapped by multiple files
and offsets if we let reflink feature & fsdax mode work together.  So,
we refactor current implementation to support handle memory failure on
each file and offset.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/dax.c            |  24 +++++-----
 include/linux/dax.h |   5 +-
 include/linux/mm.h  |   9 ++++
 mm/memory-failure.c | 112 +++++++++++++++++++++++++++++++++-----------
 4 files changed, 108 insertions(+), 42 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5b47834f2e1b..1c17c4605bc0 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -379,14 +379,17 @@ static struct page *dax_busy_page(void *entry)
 }
 
 /*
- * dax_lock_mapping_entry - Lock the DAX entry corresponding to a page
- * @page: The page whose entry we want to lock
+ * dax_lock - Lock the DAX entry corresponding to a page
+ * @mapping: The file whose entry we want to lock
+ * @index:   The offset where the DAX entry located in
+ * @pfnp:    Page frame number of the locked entry
  *
  * Context: Process context.
  * Return: A cookie to pass to dax_unlock_page() or 0 if the entry could
  * not be locked.
  */
-dax_entry_t dax_lock_page(struct page *page)
+dax_entry_t dax_lock(struct address_space *mapping, unsigned long index,
+		unsigned long *pfnp)
 {
 	XA_STATE(xas, NULL, 0);
 	void *entry;
@@ -394,8 +397,6 @@ dax_entry_t dax_lock_page(struct page *page)
 	/* Ensure page->mapping isn't freed while we look at it */
 	rcu_read_lock();
 	for (;;) {
-		struct address_space *mapping = READ_ONCE(page->mapping);
-
 		entry = NULL;
 		if (!mapping || !dax_mapping(mapping))
 			break;
@@ -413,11 +414,7 @@ dax_entry_t dax_lock_page(struct page *page)
 
 		xas.xa = &mapping->i_pages;
 		xas_lock_irq(&xas);
-		if (mapping != page->mapping) {
-			xas_unlock_irq(&xas);
-			continue;
-		}
-		xas_set(&xas, page->index);
+		xas_set(&xas, index);
 		entry = xas_load(&xas);
 		if (dax_is_locked(entry)) {
 			rcu_read_unlock();
@@ -427,16 +424,17 @@ dax_entry_t dax_lock_page(struct page *page)
 		}
 		dax_lock_entry(&xas, entry);
 		xas_unlock_irq(&xas);
+		*pfnp = dax_to_pfn(entry);
 		break;
 	}
 	rcu_read_unlock();
 	return (dax_entry_t)entry;
 }
 
-void dax_unlock_page(struct page *page, dax_entry_t cookie)
+void dax_unlock(struct address_space *mapping, unsigned long index,
+		dax_entry_t cookie)
 {
-	struct address_space *mapping = page->mapping;
-	XA_STATE(xas, &mapping->i_pages, page->index);
+	XA_STATE(xas, &mapping->i_pages, index);
 
 	if (S_ISCHR(mapping->host->i_mode))
 		return;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b52f084aa643..b24675af1de8 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -150,8 +150,9 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
 struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
-dax_entry_t dax_lock_page(struct page *page);
-void dax_unlock_page(struct page *page, dax_entry_t cookie);
+dax_entry_t dax_lock(struct address_space *mapping, unsigned long index, unsigned long *pfnp);
+void dax_unlock(struct address_space *mapping, unsigned long index,
+		dax_entry_t cookie);
 #else
 static inline bool bdev_dax_supported(struct block_device *bdev,
 		int blocksize)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d3fb4e..db3059a1853e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1141,6 +1141,14 @@ static inline bool is_device_private_page(const struct page *page)
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
@@ -3030,6 +3038,7 @@ enum mf_flags {
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
 };
+extern int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags);
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5d880d4eb9a2..03a4f4c1b803 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -120,6 +120,9 @@ static int hwpoison_filter_dev(struct page *p)
 	if (PageSlab(p))
 		return -EINVAL;
 
+	if (is_device_fsdax_page(p))
+		return 0;
+
 	mapping = page_mapping(p);
 	if (mapping == NULL || mapping->host == NULL)
 		return -EINVAL;
@@ -290,9 +293,8 @@ void shake_page(struct page *p, int access)
 EXPORT_SYMBOL_GPL(shake_page);
 
 static unsigned long dev_pagemap_mapping_shift(struct page *page,
-		struct vm_area_struct *vma)
+		struct vm_area_struct *vma, unsigned long address)
 {
-	unsigned long address = vma_address(page, vma);
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -333,8 +335,8 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
  */
 static void add_to_kill(struct task_struct *tsk, struct page *p,
-		       struct vm_area_struct *vma,
-		       struct list_head *to_kill)
+			struct address_space *mapping, pgoff_t pgoff,
+			struct vm_area_struct *vma, struct list_head *to_kill)
 {
 	struct to_kill *tk;
 
@@ -345,9 +347,12 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	}
 
 	tk->addr = page_address_in_vma(p, vma);
-	if (is_zone_device_page(p))
-		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
-	else
+	if (is_zone_device_page(p)) {
+		if (is_device_fsdax_page(p))
+			tk->addr = vma->vm_start +
+					((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+		tk->size_shift = dev_pagemap_mapping_shift(p, vma, tk->addr);
+	} else
 		tk->size_shift = page_shift(compound_head(p));
 
 	/*
@@ -495,7 +500,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, NULL, 0, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -505,24 +510,19 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 /*
  * Collect processes when the error hit a file mapped page.
  */
-static void collect_procs_file(struct page *page, struct list_head *to_kill,
-				int force_early)
+static void collect_procs_file(struct page *page, struct address_space *mapping,
+		pgoff_t pgoff, struct list_head *to_kill, int force_early)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
-	struct address_space *mapping = page->mapping;
-	pgoff_t pgoff;
 
 	i_mmap_lock_read(mapping);
 	read_lock(&tasklist_lock);
-	pgoff = page_to_pgoff(page);
 	for_each_process(tsk) {
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
@@ -531,7 +531,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			 * to be informed of all such data corruptions.
 			 */
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, mapping, pgoff, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -550,7 +550,8 @@ static void collect_procs(struct page *page, struct list_head *tokill,
 	if (PageAnon(page))
 		collect_procs_anon(page, tokill, force_early);
 	else
-		collect_procs_file(page, tokill, force_early);
+		collect_procs_file(page, page->mapping, page_to_pgoff(page),
+				   tokill, force_early);
 }
 
 static const char *action_name[] = {
@@ -1147,6 +1148,60 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
 	return 0;
 }
 
+int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags)
+{
+	const bool unmap_success = true;
+	unsigned long pfn, size = 0;
+	struct to_kill *tk;
+	LIST_HEAD(to_kill);
+	int rc = -EBUSY;
+	loff_t start;
+	dax_entry_t cookie;
+
+	/*
+	 * Prevent the inode from being freed while we are interrogating
+	 * the address_space, typically this would be handled by
+	 * lock_page(), but dax pages do not use the page lock. This
+	 * also prevents changes to the mapping of this pfn until
+	 * poison signaling is complete.
+	 */
+	cookie = dax_lock(mapping, index, &pfn);
+	if (!cookie)
+		goto unlock;
+
+	/*
+	 * Unlike System-RAM there is no possibility to swap in a
+	 * different physical page at a given virtual address, so all
+	 * userspace consumption of ZONE_DEVICE memory necessitates
+	 * SIGBUS (i.e. MF_MUST_KILL)
+	 */
+	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
+	collect_procs_file(pfn_to_page(pfn), mapping, index, &to_kill,
+			   flags & MF_ACTION_REQUIRED);
+
+	list_for_each_entry(tk, &to_kill, nd)
+		if (tk->size_shift)
+			size = max(size, 1UL << tk->size_shift);
+	if (size) {
+		/*
+		 * Unmap the largest mapping to avoid breaking up
+		 * device-dax mappings which are constant size. The
+		 * actual size of the mapping being torn down is
+		 * communicated in siginfo, see kill_proc()
+		 */
+		start = (index << PAGE_SHIFT) & ~(size - 1);
+		unmap_mapping_range(mapping, start, start + size, 0);
+	}
+
+	kill_procs(&to_kill, flags & MF_MUST_KILL, !unmap_success,
+		   pfn, flags);
+	rc = 0;
+unlock:
+	dax_unlock(mapping, index, cookie);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(mf_dax_mapping_kill_procs);
+
 static int memory_failure_hugetlb(unsigned long pfn, int flags)
 {
 	struct page *p = pfn_to_page(pfn);
@@ -1223,10 +1278,12 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		struct dev_pagemap *pgmap)
 {
 	struct page *page = pfn_to_page(pfn);
+	struct address_space *mapping = page->mapping;
+	pgoff_t index = page->index;
 	const bool unmap_success = true;
-	unsigned long size = 0;
+	unsigned long size = 0, dummy_pfn;
 	struct to_kill *tk;
-	LIST_HEAD(tokill);
+	LIST_HEAD(to_kill);
 	int rc = -EBUSY;
 	loff_t start;
 	dax_entry_t cookie;
@@ -1238,7 +1295,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	 * also prevents changes to the mapping of this pfn until
 	 * poison signaling is complete.
 	 */
-	cookie = dax_lock_page(page);
+	cookie = dax_lock(mapping, index, &dummy_pfn);
 	if (!cookie)
 		goto out;
 
@@ -1268,9 +1325,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	 * SIGBUS (i.e. MF_MUST_KILL)
 	 */
 	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
-	collect_procs(page, &tokill, flags & MF_ACTION_REQUIRED);
+	collect_procs_file(page, mapping, index, &to_kill,
+			   flags & MF_ACTION_REQUIRED);
 
-	list_for_each_entry(tk, &tokill, nd)
+	list_for_each_entry(tk, &to_kill, nd)
 		if (tk->size_shift)
 			size = max(size, 1UL << tk->size_shift);
 	if (size) {
@@ -1280,13 +1338,13 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		 * actual size of the mapping being torn down is
 		 * communicated in siginfo, see kill_proc()
 		 */
-		start = (page->index << PAGE_SHIFT) & ~(size - 1);
-		unmap_mapping_range(page->mapping, start, start + size, 0);
+		start = (index << PAGE_SHIFT) & ~(size - 1);
+		unmap_mapping_range(mapping, start, start + size, 0);
 	}
-	kill_procs(&tokill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
+	kill_procs(&to_kill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
 	rc = 0;
 unlock:
-	dax_unlock_page(page, cookie);
+	dax_unlock(mapping, index, cookie);
 out:
 	/* drop pgmap ref acquired in caller */
 	put_dev_pagemap(pgmap);
-- 
2.29.2



