Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD5B39AF7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 03:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhFDBUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 21:20:48 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45492 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229959AbhFDBUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:20:44 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AzEBVIKP+X+K9zsBcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.83,246,1616428800"; 
   d="scan'208";a="109209790"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Jun 2021 09:18:54 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id D97724C36A1E;
        Fri,  4 Jun 2021 09:18:53 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 4 Jun 2021 09:18:54 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 4 Jun 2021 09:18:53 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>, <rgoldwyn@suse.de>
Subject: [PATCH v4 04/10] mm, fsdax: Refactor memory-failure handler for dax mapping
Date:   Fri, 4 Jun 2021 09:18:38 +0800
Message-ID: <20210604011844.1756145-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604011844.1756145-1-ruansy.fnst@fujitsu.com>
References: <20210604011844.1756145-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: D97724C36A1E.A43F3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current memory_failure_dev_pagemap() can only handle single-mapped
dax page for fsdax mode.  The dax page could be mapped by multiple files
and offsets if we let reflink feature & fsdax mode work together.  So,
we refactor current implementation to support handle memory failure on
each file and offset.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c            |  21 ++++++++
 include/linux/dax.h |   1 +
 include/linux/mm.h  |   9 ++++
 mm/memory-failure.c | 114 ++++++++++++++++++++++++++++----------------
 4 files changed, 105 insertions(+), 40 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 62352cbcf0f4..58faca85455a 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -389,6 +389,27 @@ static struct page *dax_busy_page(void *entry)
 	return NULL;
 }
 
+/*
+ * dax_load_pfn - Load pfn of the DAX entry corresponding to a page
+ * @mapping: The file whose entry we want to load
+ * @index:   The offset where the DAX entry located in
+ *
+ * Return:   pfn of the DAX entry
+ */
+unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index)
+{
+	XA_STATE(xas, &mapping->i_pages, index);
+	void *entry;
+	unsigned long pfn;
+
+	xas_lock_irq(&xas);
+	entry = xas_load(&xas);
+	pfn = dax_to_pfn(entry);
+	xas_unlock_irq(&xas);
+
+	return pfn;
+}
+
 /*
  * dax_lock_mapping_entry - Lock the DAX entry corresponding to a page
  * @page: The page whose entry we want to lock
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 1ce343a960ab..6e758daa5004 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -158,6 +158,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
 struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
+unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
 #else
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c274f75efcf9..2b7527e93c77 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1187,6 +1187,14 @@ static inline bool is_device_private_page(const struct page *page)
 		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
 }
 
+static inline bool is_device_fsdax_page(const struct page *page)
+{
+	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
+		IS_ENABLED(CONFIG_FS_DAX) &&
+		is_zone_device_page(page) &&
+		page->pgmap->type == MEMORY_DEVICE_FS_DAX;
+}
+
 static inline bool is_pci_p2pdma_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
@@ -3078,6 +3086,7 @@ enum mf_flags {
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
 };
+int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index, int flags);
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 85ad98c00fd9..4377e727d478 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -56,6 +56,7 @@
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
 #include <linux/page-isolation.h>
+#include <linux/dax.h>
 #include "internal.h"
 #include "ras/ras_event.h"
 
@@ -120,6 +121,13 @@ static int hwpoison_filter_dev(struct page *p)
 	if (PageSlab(p))
 		return -EINVAL;
 
+	if (pfn_valid(page_to_pfn(p))) {
+		if (is_device_fsdax_page(p))
+			return 0;
+		else
+			return -EINVAL;
+	}
+
 	mapping = page_mapping(p);
 	if (mapping == NULL || mapping->host == NULL)
 		return -EINVAL;
@@ -290,10 +298,9 @@ void shake_page(struct page *p, int access)
 }
 EXPORT_SYMBOL_GPL(shake_page);
 
-static unsigned long dev_pagemap_mapping_shift(struct page *page,
-		struct vm_area_struct *vma)
+static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
+					       unsigned long address)
 {
-	unsigned long address = vma_address(page, vma);
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -333,9 +340,8 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
  * Schedule a process for later kill.
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
  */
-static void add_to_kill(struct task_struct *tsk, struct page *p,
-		       struct vm_area_struct *vma,
-		       struct list_head *to_kill)
+static void add_to_kill(struct task_struct *tsk, struct page *p, pgoff_t pgoff,
+			struct vm_area_struct *vma, struct list_head *to_kill)
 {
 	struct to_kill *tk;
 
@@ -346,9 +352,12 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	}
 
 	tk->addr = page_address_in_vma(p, vma);
-	if (is_zone_device_page(p))
-		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
-	else
+	if (is_zone_device_page(p)) {
+		if (is_device_fsdax_page(p))
+			tk->addr = vma->vm_start +
+					((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+		tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);
+	} else
 		tk->size_shift = page_shift(compound_head(p));
 
 	/*
@@ -496,7 +505,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, 0, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -506,24 +515,19 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
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
@@ -532,7 +536,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			 * to be informed of all such data corruptions.
 			 */
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, pgoff, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -551,7 +555,8 @@ static void collect_procs(struct page *page, struct list_head *tokill,
 	if (PageAnon(page))
 		collect_procs_anon(page, tokill, force_early);
 	else
-		collect_procs_file(page, tokill, force_early);
+		collect_procs_file(page, page_mapping(page), page_to_pgoff(page),
+				   tokill, force_early);
 }
 
 static const char *action_name[] = {
@@ -1218,6 +1223,51 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
 	return 0;
 }
 
+static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
+		struct address_space *mapping, pgoff_t index, int flags)
+{
+	struct to_kill *tk;
+	unsigned long size = 0;
+	loff_t start;
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
+		start = (index << PAGE_SHIFT) & ~(size - 1);
+		unmap_mapping_range(mapping, start, size, 0);
+	}
+
+	kill_procs(to_kill, flags & MF_MUST_KILL, false, pfn, flags);
+}
+
+int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index, int flags)
+{
+	LIST_HEAD(to_kill);
+	/* load the pfn of the dax mapping file */
+	unsigned long pfn = dax_load_pfn(mapping, index);
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
+	unmap_and_kill(&to_kill, pfn, mapping, index, flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
+
 static int memory_failure_hugetlb(unsigned long pfn, int flags)
 {
 	struct page *p = pfn_to_page(pfn);
@@ -1298,12 +1348,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		struct dev_pagemap *pgmap)
 {
 	struct page *page = pfn_to_page(pfn);
-	const bool unmap_success = true;
-	unsigned long size = 0;
-	struct to_kill *tk;
-	LIST_HEAD(tokill);
+	LIST_HEAD(to_kill);
 	int rc = -EBUSY;
-	loff_t start;
 	dax_entry_t cookie;
 
 	if (flags & MF_COUNT_INCREASED)
@@ -1355,22 +1401,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	 * SIGBUS (i.e. MF_MUST_KILL)
 	 */
 	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
-	collect_procs(page, &tokill, flags & MF_ACTION_REQUIRED);
+	collect_procs_file(page, page->mapping, page->index, &to_kill,
+			   flags & MF_ACTION_REQUIRED);
 
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
-		unmap_mapping_range(page->mapping, start, size, 0);
-	}
-	kill_procs(&tokill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
+	unmap_and_kill(&to_kill, pfn, page->mapping, page->index, flags);
 	rc = 0;
 unlock:
 	dax_unlock_page(page, cookie);
-- 
2.31.1



