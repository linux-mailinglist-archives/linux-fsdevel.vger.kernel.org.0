Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFCE3DB55F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 10:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbhG3IxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 04:53:20 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34380 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230456AbhG3IxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:53:16 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AhUy3rqvwCgHy7sUIg/O1Lj+O7skDStV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZEguCMc5wx+ZJheo7q90cW7IE80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HARO5fBODZsl/d8kPFltJ15ONJdqhSLJnKB0FmsMCS2mKFOudl7N6Z0K3Av4vj?=
 =?us-ascii?q?80s=3D?=
X-IronPort-AV: E=Sophos;i="5.84,281,1620662400"; 
   d="scan'208";a="112070602"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Jul 2021 16:53:11 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id C6EAB4D0D4A4;
        Fri, 30 Jul 2021 16:53:10 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 30 Jul 2021 16:53:10 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 30 Jul 2021 16:53:10 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 30 Jul 2021 16:53:08 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <djwong@kernel.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>
Subject: [PATCH v6 5/9] mm: Introduce mf_dax_kill_procs() for fsdax case
Date:   Fri, 30 Jul 2021 16:52:41 +0800
Message-ID: <20210730085245.3069812-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210730085245.3069812-1-ruansy.fnst@fujitsu.com>
References: <20210730085245.3069812-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C6EAB4D0D4A4.A4077
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is called at the end of RMAP routine, i.e. filesystem
recovery function.  The difference between mf_generic_kill_procs() is,
mf_dax_kill_procs() accepts file mapping and offset instead of struct
page.  It is because that different file mappings and offsets may share
the same page in fsdax mode.  So, it is called when filesystem RMAP
results are found.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c            | 45 ++++++++++++++++++++++++-------
 include/linux/dax.h | 16 ++++++++++++
 include/linux/mm.h  | 10 +++++++
 mm/memory-failure.c | 64 +++++++++++++++++++++++++++++++++------------
 4 files changed, 109 insertions(+), 26 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index da41f9363568..dce6307a12eb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -389,6 +389,41 @@ static struct page *dax_busy_page(void *entry)
 	return NULL;
 }
 
+/**
+ * dax_load_pfn - Load pfn of the DAX entry corresponding to a page
+ * @mapping:	The file whose entry we want to load
+ * @index:	offset where the DAX entry located in
+ *
+ * Return:	pfn number of the DAX entry
+ */
+unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index)
+{
+	XA_STATE(xas, &mapping->i_pages, index);
+	void *entry;
+	unsigned long pfn;
+
+	rcu_read_lock();
+	for (;;) {
+		xas_lock_irq(&xas);
+		entry = xas_load(&xas);
+		if (dax_is_locked(entry)) {
+			rcu_read_unlock();
+			wait_entry_unlocked(&xas, entry);
+			rcu_read_lock();
+			continue;
+		}
+
+		if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
+			pfn = 0;
+		else
+			pfn = dax_to_pfn(entry);
+		xas_unlock_irq(&xas);
+		break;
+	}
+	rcu_read_unlock();
+	return pfn;
+}
+
 /*
  * dax_lock_mapping_entry - Lock the DAX entry corresponding to a page
  * @page: The page whose entry we want to lock
@@ -790,16 +825,6 @@ static void *dax_insert_entry(struct xa_state *xas,
 	return entry;
 }
 
-static inline
-unsigned long pgoff_address(pgoff_t pgoff, struct vm_area_struct *vma)
-{
-	unsigned long address;
-
-	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
-	return address;
-}
-
 /* Walk all mappings of a given index of a file and writeprotect them */
 static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 		unsigned long pfn)
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 6f4b5c97ceb0..359e809516b8 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -165,6 +165,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
 struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
+unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
 #else
@@ -206,6 +207,12 @@ static inline int dax_writeback_mapping_range(struct address_space *mapping,
 	return -EOPNOTSUPP;
 }
 
+static inline unsigned long dax_load_pfn(struct address_space *mapping,
+		unsigned long index)
+{
+	return 0;
+}
+
 static inline dax_entry_t dax_lock_page(struct page *page)
 {
 	if (IS_DAX(page->mapping->host))
@@ -259,6 +266,15 @@ static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
 }
+static inline unsigned long pgoff_address(pgoff_t pgoff,
+		struct vm_area_struct *vma)
+{
+	unsigned long address;
+
+	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
+	return address;
+}
 
 #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
 void hmem_register_device(int target_nid, struct resource *r);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..530aaf7a6eb2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1190,6 +1190,14 @@ static inline bool is_device_private_page(const struct page *page)
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
@@ -3113,6 +3121,8 @@ enum mf_flags {
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
 };
+extern int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
+			     int flags);
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ab3eda335acd..520664c405fc 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -134,6 +134,12 @@ static int hwpoison_filter_dev(struct page *p)
 	if (PageSlab(p))
 		return -EINVAL;
 
+	if (pfn_valid(page_to_pfn(p))) {
+		if (is_device_fsdax_page(p))
+			return 0;
+	} else
+		return -EINVAL;
+
 	mapping = page_mapping(p);
 	if (mapping == NULL || mapping->host == NULL)
 		return -EINVAL;
@@ -304,10 +310,9 @@ void shake_page(struct page *p, int access)
 }
 EXPORT_SYMBOL_GPL(shake_page);
 
-static unsigned long dev_pagemap_mapping_shift(struct page *page,
+static unsigned long dev_pagemap_mapping_shift(unsigned long address,
 		struct vm_area_struct *vma)
 {
-	unsigned long address = vma_address(page, vma);
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -347,7 +352,7 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
  * Schedule a process for later kill.
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
  */
-static void add_to_kill(struct task_struct *tsk, struct page *p,
+static void add_to_kill(struct task_struct *tsk, struct page *p, pgoff_t pgoff,
 		       struct vm_area_struct *vma,
 		       struct list_head *to_kill)
 {
@@ -360,9 +365,14 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	}
 
 	tk->addr = page_address_in_vma(p, vma);
-	if (is_zone_device_page(p))
-		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
-	else
+	if (is_zone_device_page(p)) {
+		/* Since page->mapping is no more used for fsdax, we should
+		 * calculate the address in a fsdax way.
+		 */
+		if (is_device_fsdax_page(p))
+			tk->addr = pgoff_address(pgoff, vma);
+		tk->size_shift = dev_pagemap_mapping_shift(tk->addr, vma);
+	} else
 		tk->size_shift = page_shift(compound_head(p));
 
 	/*
@@ -510,7 +520,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, 0, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -520,24 +530,20 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
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
 
 		if (!t)
 			continue;
-		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff,
-				      pgoff) {
+		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
 			/*
 			 * Send early kill signal to tasks where a vma covers
 			 * the page but the corrupted page is not necessarily
@@ -546,7 +552,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			 * to be informed of all such data corruptions.
 			 */
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, pgoff, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -565,7 +571,8 @@ static void collect_procs(struct page *page, struct list_head *tokill,
 	if (PageAnon(page))
 		collect_procs_anon(page, tokill, force_early);
 	else
-		collect_procs_file(page, tokill, force_early);
+		collect_procs_file(page, page->mapping, page->index, tokill,
+				   force_early);
 }
 
 struct hwp_walk {
@@ -1477,6 +1484,31 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags)
 	return 0;
 }
 
+int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index, int flags)
+{
+	LIST_HEAD(to_kill);
+	/* load the pfn of the dax mapping file */
+	unsigned long pfn = dax_load_pfn(mapping, index);
+
+	/* the failure pfn may not actually be mmapped, so no need to
+	 * unmap and kill procs */
+	if (!pfn)
+		return 0;
+
+	/*
+	 * Unlike System-RAM there is no possibility to swap in a
+	 * different physical page at a given virtual address, so all
+	 * userspace consumption of ZONE_DEVICE memory necessitates
+	 * SIGBUS (i.e. MF_MUST_KILL)
+	 */
+	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
+	collect_procs_file(pfn_to_page(pfn), mapping, index, &to_kill, true);
+
+	unmap_and_kill(&to_kill, pfn, mapping, index, flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
+
 static int memory_failure_hugetlb(unsigned long pfn, int flags)
 {
 	struct page *p = pfn_to_page(pfn);
-- 
2.32.0



