Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56BC1B9AB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 10:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgD0Isv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 04:48:51 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3131 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726883AbgD0Isr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:48:47 -0400
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="90547667"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Apr 2020 16:48:38 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 5ACCE50A9991;
        Mon, 27 Apr 2020 16:37:54 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 27 Apr 2020 16:48:34 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 16:48:36 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 5/8] fs/dax: replace mmap entry in case of CoW
Date:   Mon, 27 Apr 2020 16:47:47 +0800
Message-ID: <20200427084750.136031-6-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5ACCE50A9991.AF0B6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We replace the existing entry to the newly allocated one
in case of CoW. Also, we mark the entry as PAGECACHE_TAG_TOWRITE
so writeback marks this entry as writeprotected. This
helps us snapshots so new write pagefaults after snapshots
trigger a CoW.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/dax.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 13a6a1d3c3b3..12096edb2569 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -835,6 +835,9 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
 	return 0;
 }
 
+#define DAX_IF_DIRTY		(1ULL << 0)
+#define DAX_IF_COW		(1ULL << 1)
+
 /*
  * By this point grab_mapping_entry() has ensured that we have a locked entry
  * of the appropriate size so we don't have to worry about downgrading PMDs to
@@ -844,14 +847,17 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
  */
 static void *dax_insert_entry(struct xa_state *xas,
 		struct address_space *mapping, struct vm_fault *vmf,
-		void *entry, pfn_t pfn, unsigned long flags, bool dirty)
+		void *entry, pfn_t pfn, unsigned long flags,
+		unsigned int insert_flags)
 {
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
@@ -863,7 +869,7 @@ static void *dax_insert_entry(struct xa_state *xas,
 
 	xas_reset(xas);
 	xas_lock_irq(xas);
-	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
+	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, xas->xa_index, false);
@@ -887,6 +893,9 @@ static void *dax_insert_entry(struct xa_state *xas,
 	if (dirty)
 		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
 
+	if (cow)
+		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
+
 	xas_unlock_irq(xas);
 	return entry;
 }
@@ -1430,6 +1439,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	void *entry;
 	pfn_t pfn;
 	void *kaddr;
+	unsigned long insert_flags = 0;
 
 	trace_dax_pte_fault(inode, vmf, ret);
 	/*
@@ -1522,8 +1532,10 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		if (error < 0)
 			goto error_finish_iomap;
 
-		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
-						 0, write && !sync);
+		if (write && !sync)
+			insert_flags |= DAX_IF_DIRTY;
+		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn, 0,
+					 insert_flags);
 
 		if (srcmap.type != IOMAP_HOLE) {
 			error = dax_copy_edges(pos, PAGE_SIZE, &srcmap, kaddr,
@@ -1555,8 +1567,10 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 		goto finish_iomap;
 	case IOMAP_UNWRITTEN:
-		if (srcmap.type != IOMAP_HOLE)
+		if (srcmap.type != IOMAP_HOLE) {
+			insert_flags |= DAX_IF_COW;
 			goto cow;
+		}
 		/*FALLTHRU*/
 	case IOMAP_HOLE:
 		if (!write) {
@@ -1614,7 +1628,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 
 	pfn = page_to_pfn_t(zero_page);
 	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-			DAX_PMD | DAX_ZERO_PAGE, false);
+			DAX_PMD | DAX_ZERO_PAGE, 0);
 
 	if (arch_needs_pgtable_deposit()) {
 		pgtable = pte_alloc_one(vma->vm_mm);
@@ -1666,6 +1680,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	int error;
 	pfn_t pfn;
 	void *kaddr;
+	unsigned long insert_flags = 0;
 
 	/*
 	 * Check whether offset isn't beyond end of file now. Caller is
@@ -1753,8 +1768,10 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		if (error < 0)
 			goto finish_iomap;
 
+		if (write && !sync)
+			insert_flags |= DAX_IF_DIRTY;
 		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
-						DAX_PMD, write && !sync);
+						DAX_PMD, insert_flags);
 
 		if (srcmap.type != IOMAP_HOLE) {
 			error = dax_copy_edges(pos, PMD_SIZE, &srcmap, kaddr,
@@ -1781,8 +1798,10 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		result = vmf_insert_pfn_pmd(vmf, pfn, write);
 		break;
 	case IOMAP_UNWRITTEN:
-		if (srcmap.type != IOMAP_HOLE)
+		if (srcmap.type != IOMAP_HOLE) {
+			insert_flags |= DAX_IF_COW;
 			goto cow;
+		}
 		/*FALLTHRU*/
 	case IOMAP_HOLE:
 		if (WARN_ON_ONCE(write))
-- 
2.26.2



