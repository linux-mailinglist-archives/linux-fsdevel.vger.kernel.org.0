Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79CB3582BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 14:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhDHMFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 08:05:06 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24833 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231195AbhDHMFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:05:05 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A5PmxU6DeRQQp96/lHelM55DYdL4zR+YMi2QD?=
 =?us-ascii?q?/UZ3VBBTb4ikh9mj9c5rsSPcpRQwfDUbmd6GMLSdWn+0z/NIyKQYILvKZmfbkU?=
 =?us-ascii?q?SlIIxo5YHhhx3McheVysdzzqFlGpIeNPTVLXxXyfn3+xO5FdFI+qjjzImNif3F?=
 =?us-ascii?q?x3lgCSFGApsQjDtRMQqQHk1oSAQuP/NQe6a03NZNpDarZB0sH6aGL0QCNtKim/?=
 =?us-ascii?q?T70LriYTMjQyUs8RSyi1qTg4LSIly12Qg/Xlp0rYsfzQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,206,1613404800"; 
   d="scan'208";a="106797270"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Apr 2021 20:04:52 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id C4A9D4CEA876;
        Thu,  8 Apr 2021 20:04:47 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 8 Apr 2021 20:04:37 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 8 Apr 2021 20:04:37 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <david@fromorbit.com>, <hch@lst.de>,
        <rgoldwyn@suse.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH v4 2/7] fsdax: Replace mmap entry in case of CoW
Date:   Thu, 8 Apr 2021 20:04:27 +0800
Message-ID: <20210408120432.1063608-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
References: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C4A9D4CEA876.A55FE
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
---
 fs/dax.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index b4fd3813457a..e6c1354b27a8 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -722,6 +722,10 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
 	return 0;
 }
 
+/* DAX Insert Flag for the entry we insert */
+#define DAX_IF_DIRTY		(1 << 0)
+#define DAX_IF_COW		(1 << 1)
+
 /*
  * By this point grab_mapping_entry() has ensured that we have a locked entry
  * of the appropriate size so we don't have to worry about downgrading PMDs to
@@ -729,16 +733,19 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
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
@@ -750,7 +757,7 @@ static void *dax_insert_entry(struct xa_state *xas,
 
 	xas_reset(xas);
 	xas_lock_irq(xas);
-	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
+	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
@@ -774,6 +781,9 @@ static void *dax_insert_entry(struct xa_state *xas,
 	if (dirty)
 		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
 
+	if (cow)
+		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
+
 	xas_unlock_irq(xas);
 	return entry;
 }
@@ -1109,8 +1119,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
 	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
 	vm_fault_t ret;
 
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-			DAX_ZERO_PAGE, false);
+	*entry = dax_insert_entry(xas, vmf, *entry, pfn, DAX_ZERO_PAGE, 0);
 
 	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
 	trace_dax_load_hole(inode, vmf, ret);
@@ -1137,8 +1146,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		goto fallback;
 
 	pfn = page_to_pfn_t(zero_page);
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-			DAX_PMD | DAX_ZERO_PAGE, false);
+	*entry = dax_insert_entry(xas, vmf, *entry, pfn,
+				  DAX_PMD | DAX_ZERO_PAGE, 0);
 
 	if (arch_needs_pgtable_deposit()) {
 		pgtable = pte_alloc_one(vma->vm_mm);
@@ -1444,6 +1453,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool sync = dax_fault_is_synchronous(flags, vmf->vma, iomap);
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
+	unsigned int insert_flags = 0;
 	int err = 0;
 	pfn_t pfn;
 	void *kaddr;
@@ -1466,8 +1476,15 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
 	if (err)
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn, entry_flags,
-				  write && !sync);
+	if (write) {
+		if (!sync)
+			insert_flags |= DAX_IF_DIRTY;
+		if (iomap->flags & IOMAP_F_SHARED)
+			insert_flags |= DAX_IF_COW;
+	}
+
+	*entry = dax_insert_entry(xas, vmf, *entry, pfn, entry_flags,
+				  insert_flags);
 
 	if (write &&
 	    srcmap->addr != IOMAP_HOLE && srcmap->addr != iomap->addr) {
-- 
2.31.0



