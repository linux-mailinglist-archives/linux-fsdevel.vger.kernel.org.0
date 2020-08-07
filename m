Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635F723EDD9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 15:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHGNNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 09:13:52 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10729 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726217AbgHGNNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:13:51 -0400
X-IronPort-AV: E=Sophos;i="5.75,445,1589212800"; 
   d="scan'208";a="97774909"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Aug 2020 21:13:42 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 349484CE38A0;
        Fri,  7 Aug 2020 21:13:40 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 7 Aug 2020 21:13:42 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 7 Aug 2020 21:13:40 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 5/8] fsdax: replace mmap entry in case of CoW
Date:   Fri, 7 Aug 2020 21:13:33 +0800
Message-ID: <20200807131336.318774-6-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
References: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 349484CE38A0.AAB17
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
 fs/dax.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 65553e3f7602..28b8e23b11ac 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -766,6 +766,9 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
 	return 0;
 }
 
+#define DAX_IF_DIRTY		(1ULL << 0)
+#define DAX_IF_COW		(1ULL << 1)
+
 /*
  * By this point grab_mapping_entry() has ensured that we have a locked entry
  * of the appropriate size so we don't have to worry about downgrading PMDs to
@@ -776,14 +779,16 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
 static void *dax_insert_entry(struct xa_state *xas,
 		struct address_space *mapping, struct vm_fault *vmf,
 		pgoff_t bdoff, void *entry, pfn_t pfn, unsigned long flags,
-		bool dirty)
+		bool insert_flags)
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
@@ -795,7 +800,7 @@ static void *dax_insert_entry(struct xa_state *xas,
 
 	xas_reset(xas);
 	xas_lock_irq(xas);
-	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
+	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
@@ -819,6 +824,9 @@ static void *dax_insert_entry(struct xa_state *xas,
 	if (dirty)
 		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
 
+	if (cow)
+		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
+
 	xas_unlock_irq(xas);
 	return entry;
 }
@@ -1366,6 +1374,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	void *entry;
 	pfn_t pfn;
 	void *kaddr;
+	unsigned long insert_flags = 0;
 
 	trace_dax_pte_fault(inode, vmf, ret);
 	/*
@@ -1491,8 +1500,10 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 		goto finish_iomap;
 	case IOMAP_UNWRITTEN:
-		if (write && iomap.flags & IOMAP_F_SHARED)
+		if (write && (iomap.flags & IOMAP_F_SHARED)) {
+			insert_flags |= DAX_IF_COW;
 			goto cow;
+		}
 		fallthrough;
 	case IOMAP_HOLE:
 		if (!write) {
@@ -1602,6 +1613,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	int error;
 	pfn_t pfn;
 	void *kaddr;
+	unsigned long insert_flags = 0;
 
 	/*
 	 * Check whether offset isn't beyond end of file now. Caller is
@@ -1717,14 +1729,17 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		result = vmf_insert_pfn_pmd(vmf, pfn, write);
 		break;
 	case IOMAP_UNWRITTEN:
-		if (write && iomap.flags & IOMAP_F_SHARED)
+		if (write && (iomap.flags & IOMAP_F_SHARED)) {
+			insert_flags |= DAX_IF_COW;
 			goto cow;
+		}
 		fallthrough;
 	case IOMAP_HOLE:
-		if (WARN_ON_ONCE(write))
+		if (!write) {
+			result = dax_pmd_load_hole(&xas, vmf, &iomap, &entry);
 			break;
-		result = dax_pmd_load_hole(&xas, vmf, &iomap, &entry);
-		break;
+		}
+		fallthrough;
 	default:
 		WARN_ON_ONCE(1);
 		break;
-- 
2.27.0



