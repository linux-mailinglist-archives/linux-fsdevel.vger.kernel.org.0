Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658D934126E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 02:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhCSBxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 21:53:34 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41496 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231478AbhCSBxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:53:15 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AfCu0V6h0K9yO7Te67He+RwhhZnBQXjoji2hD?=
 =?us-ascii?q?6mlwRA09T+WzkceykPMHkSLlkTp5YgBFpfmsGomlBUnd+5l8/JULMd6ZMTXOlW?=
 =?us-ascii?q?O0IOhZg7fK7DHtFib3/OwY9YoIScJDIfLqC1wSt6fHyS2ZN/pl/9Wd6qCvgo7l?=
 =?us-ascii?q?vhJQZCVncbtp4Qs8KivzKDwUeCB8CZA0FIWR66N8zlLORV0scs+5CnMZNtKzxe?=
 =?us-ascii?q?HjqZSOW347Li9iwAyPoBft07TiDiWfty10bxp/hZsk7kjJ+jaU2pme?=
X-IronPort-AV: E=Sophos;i="5.81,259,1610380800"; 
   d="scan'208";a="105876690"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Mar 2021 09:53:12 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 893404CEA875;
        Fri, 19 Mar 2021 09:53:07 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 19 Mar 2021 09:53:08 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 19 Mar 2021 09:53:07 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v3 05/10] fsdax: Replace mmap entry in case of CoW
Date:   Fri, 19 Mar 2021 09:52:32 +0800
Message-ID: <20210319015237.993880-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 893404CEA875.A0D80
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
---
 fs/dax.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 181aad97136a..cfe513eb111e 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -722,6 +722,9 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
 	return 0;
 }
 
+#define DAX_IF_DIRTY		(1 << 0)
+#define DAX_IF_COW		(1 << 1)
+
 /*
  * By this point grab_mapping_entry() has ensured that we have a locked entry
  * of the appropriate size so we don't have to worry about downgrading PMDs to
@@ -729,16 +732,19 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
  * already in the tree, we will skip the insertion and just dirty the PMD as
  * appropriate.
  */
-static void *dax_insert_entry(struct xa_state *xas,
-		struct address_space *mapping, struct vm_fault *vmf,
-		void *entry, pfn_t pfn, unsigned long flags, bool dirty)
+static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
+		void *entry, pfn_t pfn, unsigned long flags,
+		unsigned int insert_flags)
 {
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	void *new_entry = dax_make_entry(pfn, flags);
+	bool dirty = insert_flags & DAX_IF_DIRTY;
+	bool cow = insert_flags & DAX_IF_COW;
 
 	if (dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 
-	if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
+	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
 		unsigned long index = xas->xa_index;
 		/* we are replacing a zero page with block mapping */
 		if (dax_is_pmd_entry(entry))
@@ -750,7 +756,7 @@ static void *dax_insert_entry(struct xa_state *xas,
 
 	xas_reset(xas);
 	xas_lock_irq(xas);
-	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
+	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
@@ -774,6 +780,9 @@ static void *dax_insert_entry(struct xa_state *xas,
 	if (dirty)
 		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
 
+	if (cow)
+		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
+
 	xas_unlock_irq(xas);
 	return entry;
 }
@@ -1098,8 +1107,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
 	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
 	vm_fault_t ret;
 
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-			DAX_ZERO_PAGE, false);
+	*entry = dax_insert_entry(xas, vmf, *entry, pfn, DAX_ZERO_PAGE, 0);
 
 	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
 	trace_dax_load_hole(inode, vmf, ret);
@@ -1126,8 +1134,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		goto fallback;
 
 	pfn = page_to_pfn_t(zero_page);
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-			DAX_PMD | DAX_ZERO_PAGE, false);
+	*entry = dax_insert_entry(xas, vmf, *entry, pfn,
+				  DAX_PMD | DAX_ZERO_PAGE, 0);
 
 	if (arch_needs_pgtable_deposit()) {
 		pgtable = pte_alloc_one(vma->vm_mm);
@@ -1431,6 +1439,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
 	loff_t pos = (loff_t)xas->xa_offset << PAGE_SHIFT;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool sync = dax_fault_is_synchronous(flags, vmf->vma, iomap);
+	unsigned int insert_flags = 0;
 	int err = 0;
 	pfn_t pfn;
 	void *kaddr;
@@ -1453,8 +1462,14 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
 	if (err)
 		return dax_fault_return(err);
 
-	entry = dax_insert_entry(xas, mapping, vmf, entry, pfn, 0,
-				 write && !sync);
+	if (write) {
+		if (!sync)
+			insert_flags |= DAX_IF_DIRTY;
+		if (iomap->flags & IOMAP_F_SHARED)
+			insert_flags |= DAX_IF_COW;
+	}
+
+	entry = dax_insert_entry(xas, vmf, entry, pfn, 0, insert_flags);
 
 	if (write && srcmap->addr != iomap->addr) {
 		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr, false);
-- 
2.30.1



