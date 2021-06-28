Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550023B5618
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 02:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhF1AFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Jun 2021 20:05:40 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54538 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231876AbhF1AFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Jun 2021 20:05:40 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AsFZRU6yVrBjE/57Jb06LKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.83,304,1616428800"; 
   d="scan'208";a="110256353"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Jun 2021 08:03:10 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 4BA114D0C4CE;
        Mon, 28 Jun 2021 08:03:09 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 28 Jun 2021 08:03:10 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 28 Jun 2021 08:03:09 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>, <rgoldwyn@suse.de>
Subject: [PATCH v5 5/9] mm: Introduce mf_dax_kill_procs() for fsdax case
Date:   Mon, 28 Jun 2021 08:02:14 +0800
Message-ID: <20210628000218.387833-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628000218.387833-1-ruansy.fnst@fujitsu.com>
References: <20210628000218.387833-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4BA114D0C4CE.A47F0
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
 fs/dax.c            | 31 +++++++++++++++--------
 include/linux/dax.h | 10 ++++++++
 include/linux/mm.h  | 10 ++++++++
 mm/memory-failure.c | 60 +++++++++++++++++++++++++++++++++------------
 4 files changed, 85 insertions(+), 26 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 62352cbcf0f4..7c5d8acd6bc5 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -389,6 +389,27 @@ static struct page *dax_busy_page(void *entry)
 	return NULL;
 }

+/*
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
@@ -789,16 +810,6 @@ static void *dax_insert_entry(struct xa_state *xas,
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
index 6f4b5c97ceb0..fc0c80f09b79 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -165,6 +165,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,

 struct page *dax_layout_busy_page(struct address_space *mapping);
 struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
+unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
 #else
@@ -259,6 +260,15 @@ static inline bool dax_mapping(struct address_space *mapping)
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
index 8ae31622deef..3f101caec30e 100644
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
@@ -3081,6 +3089,8 @@ enum mf_flags {
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
 };
+extern int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
+			     int flags);
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 30ce1e653c0a..37ac15b223e0 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -120,6 +120,12 @@ static int hwpoison_filter_dev(struct page *p)
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
@@ -290,10 +296,9 @@ void shake_page(struct page *p, int access)
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
@@ -333,7 +338,7 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
  * Schedule a process for later kill.
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
  */
-static void add_to_kill(struct task_struct *tsk, struct page *p,
+static void add_to_kill(struct task_struct *tsk, struct page *p, pgoff_t pgoff,
 		       struct vm_area_struct *vma,
 		       struct list_head *to_kill)
 {
@@ -346,9 +351,14 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
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
@@ -496,7 +506,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, 0, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -506,24 +516,20 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
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
@@ -532,7 +538,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			 * to be informed of all such data corruptions.
 			 */
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, pgoff, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -551,7 +557,8 @@ static void collect_procs(struct page *page, struct list_head *tokill,
 	if (PageAnon(page))
 		collect_procs_anon(page, tokill, force_early);
 	else
-		collect_procs_file(page, tokill, force_early);
+		collect_procs_file(page, page->mapping, page->index, tokill,
+				   force_early);
 }

 static const char *action_name[] = {
@@ -1297,6 +1304,27 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags)
 	return 0;
 }

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
--
2.32.0



