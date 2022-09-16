Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4175D5BA549
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 05:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiIPDgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 23:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiIPDfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:35:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D033347;
        Thu, 15 Sep 2022 20:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663299345; x=1694835345;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3aJv8sV5UvVLt6I9GPcQ4FOyHFWHfylczL3dCRbOmfY=;
  b=WW1oUihip05VkMLLJgE9sG2dsN+Wi8THIJJLjtsQjHGK3dtBcdTsuO7t
   7EErkKr0RuasJaXWdUq9lRk0OG4VPPdVPJqtZW87UaZhvpVouSljYmoVv
   iDBCJHGfNwGf/IhjCmVjFeEqznUmA6NkBa44jScVfrkNXR860+ZQcPNDp
   YbtHMP+zSbT5bagpsdpV9Ay+iTjOlTy3/1EMpjOpZIl7KstOSlngMX2Cy
   qxyLhqyxxB0H97l8oYp1SobMQzOyYynPkvX9K+qWsOk7T/2YY5JMf61/J
   eQ2T0DM0+D2x6X2dD9DvjwEvaWvkK9GUlc0vjWNTWfknfae5KDB0ffb1t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="299726128"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="299726128"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:35:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="792961875"
Received: from colinlix-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.29.52])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:35:44 -0700
Subject: [PATCH v2 06/18] fsdax: Rework dax_layout_busy_page() to
 dax_zap_mappings()
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Date:   Thu, 15 Sep 2022 20:35:44 -0700
Message-ID: <166329934448.2786261.3862047806587561874.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for moving the truncate vs DAX-busy-page detection from
detecting _refcount == 1 to _refcount == 0, change the busy page
tracking to take refernces at dax_insert_entry(), drop references at
dax_zap_mappings() time, and finally clean out the entries at
dax_delete_mapping_entries().

This approach will rely on all paths that call truncate_inode_pages() to
first call dax_zap_mappings(). This mirrors the zapped state of pages
after unmap_mapping_range(), but since DAX pages do not maintain
_mapcount this DAX specific flow is introduced. This approach helps
address the immediate _refcount problem, but continues to kick the "DAX
without pages?" question down the road.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c            |   82 ++++++++++++++++++++++++++++++++++++---------------
 fs/ext4/inode.c     |    2 +
 fs/fuse/dax.c       |    4 +-
 fs/xfs/xfs_file.c   |    2 +
 fs/xfs/xfs_inode.c  |    4 +-
 include/linux/dax.h |   11 ++++---
 6 files changed, 71 insertions(+), 34 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 76bad1c095c0..616bac4b7df3 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -74,11 +74,12 @@ fs_initcall(init_dax_wait_table);
  * and EMPTY bits aren't set the entry is a normal DAX entry with a filesystem
  * block allocation.
  */
-#define DAX_SHIFT	(4)
+#define DAX_SHIFT	(5)
 #define DAX_LOCKED	(1UL << 0)
 #define DAX_PMD		(1UL << 1)
 #define DAX_ZERO_PAGE	(1UL << 2)
 #define DAX_EMPTY	(1UL << 3)
+#define DAX_ZAP		(1UL << 4)
 
 static unsigned long dax_to_pfn(void *entry)
 {
@@ -95,6 +96,11 @@ static bool dax_is_locked(void *entry)
 	return xa_to_value(entry) & DAX_LOCKED;
 }
 
+static bool dax_is_zapped(void *entry)
+{
+	return xa_to_value(entry) & DAX_ZAP;
+}
+
 static unsigned int dax_entry_order(void *entry)
 {
 	if (xa_to_value(entry) & DAX_PMD)
@@ -380,6 +386,7 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 			WARN_ON_ONCE(page->mapping);
 			page->mapping = mapping;
 			page->index = index + i++;
+			page_ref_inc(page);
 		}
 	}
 }
@@ -395,31 +402,20 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		WARN_ON_ONCE(trunc && !dax_page_idle(page));
 		if (dax_mapping_is_cow(page->mapping)) {
 			/* keep the CoW flag if this page is still shared */
 			if (page->index-- > 0)
 				continue;
-		} else
+		} else {
+			WARN_ON_ONCE(trunc && !dax_is_zapped(entry));
+			WARN_ON_ONCE(trunc && !dax_page_idle(page));
 			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
+		}
 		page->mapping = NULL;
 		page->index = 0;
 	}
 }
 
-static struct page *dax_busy_page(void *entry)
-{
-	unsigned long pfn;
-
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		if (!dax_page_idle(page))
-			return page;
-	}
-	return NULL;
-}
-
 /*
  * dax_lock_page - Lock the DAX entry corresponding to a page
  * @page: The page whose entry we want to lock
@@ -664,8 +660,46 @@ static void *grab_mapping_entry(struct xa_state *xas,
 	return xa_mk_internal(VM_FAULT_FALLBACK);
 }
 
+static void *dax_zap_entry(struct xa_state *xas, void *entry)
+{
+	unsigned long v = xa_to_value(entry);
+
+	return xas_store(xas, xa_mk_value(v | DAX_ZAP));
+}
+
+/**
+ * Return NULL if the entry is zapped and all pages in the entry are
+ * idle, otherwise return the non-idle page in the entry
+ */
+static struct page *dax_zap_pages(struct xa_state *xas, void *entry)
+{
+	struct page *ret = NULL;
+	unsigned long pfn;
+	bool zap;
+
+	if (!dax_entry_size(entry))
+		return NULL;
+
+	zap = !dax_is_zapped(entry);
+
+	for_each_mapped_pfn(entry, pfn) {
+		struct page *page = pfn_to_page(pfn);
+
+		if (zap)
+			page_ref_dec(page);
+
+		if (!ret && !dax_page_idle(page))
+			ret = page;
+	}
+
+	if (zap)
+		dax_zap_entry(xas, entry);
+
+	return ret;
+}
+
 /**
- * dax_layout_busy_page_range - find first pinned page in @mapping
+ * dax_zap_mappings_range - find first pinned page in @mapping
  * @mapping: address space to scan for a page with ref count > 1
  * @start: Starting offset. Page containing 'start' is included.
  * @end: End offset. Page containing 'end' is included. If 'end' is LLONG_MAX,
@@ -682,8 +716,8 @@ static void *grab_mapping_entry(struct xa_state *xas,
  * to be able to run unmap_mapping_range() and subsequently not race
  * mapping_mapped() becoming true.
  */
-struct page *dax_layout_busy_page_range(struct address_space *mapping,
-					loff_t start, loff_t end)
+struct page *dax_zap_mappings_range(struct address_space *mapping, loff_t start,
+				    loff_t end)
 {
 	void *entry;
 	unsigned int scanned = 0;
@@ -727,7 +761,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 		if (unlikely(dax_is_locked(entry)))
 			entry = get_unlocked_entry(&xas, 0);
 		if (entry)
-			page = dax_busy_page(entry);
+			page = dax_zap_pages(&xas, entry);
 		put_unlocked_entry(&xas, entry, WAKE_NEXT);
 		if (page)
 			break;
@@ -742,13 +776,13 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	xas_unlock_irq(&xas);
 	return page;
 }
-EXPORT_SYMBOL_GPL(dax_layout_busy_page_range);
+EXPORT_SYMBOL_GPL(dax_zap_mappings_range);
 
-struct page *dax_layout_busy_page(struct address_space *mapping)
+struct page *dax_zap_mappings(struct address_space *mapping)
 {
-	return dax_layout_busy_page_range(mapping, 0, LLONG_MAX);
+	return dax_zap_mappings_range(mapping, 0, LLONG_MAX);
 }
-EXPORT_SYMBOL_GPL(dax_layout_busy_page);
+EXPORT_SYMBOL_GPL(dax_zap_mappings);
 
 static int __dax_invalidate_entry(struct address_space *mapping,
 					  pgoff_t index, bool trunc)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 326269ad3961..0ce73af69c49 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3965,7 +3965,7 @@ int ext4_break_layouts(struct inode *inode)
 		return -EINVAL;
 
 	do {
-		page = dax_layout_busy_page(inode->i_mapping);
+		page = dax_zap_mappings(inode->i_mapping);
 		if (!page)
 			return 0;
 
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index ae52ef7dbabe..8cdc9402e8f7 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -443,7 +443,7 @@ static int fuse_setup_new_dax_mapping(struct inode *inode, loff_t pos,
 
 	/*
 	 * Can't do inline reclaim in fault path. We call
-	 * dax_layout_busy_page() before we free a range. And
+	 * dax_zap_mappings() before we free a range. And
 	 * fuse_wait_dax_page() drops mapping->invalidate_lock and requires it.
 	 * In fault path we enter with mapping->invalidate_lock held and can't
 	 * drop it. Also in fault path we hold mapping->invalidate_lock shared
@@ -671,7 +671,7 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 {
 	struct page *page;
 
-	page = dax_layout_busy_page_range(inode->i_mapping, start, end);
+	page = dax_zap_mappings_range(inode->i_mapping, start, end);
 	if (!page)
 		return 0;
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index d3ff692d5546..918ab9130c96 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -823,7 +823,7 @@ xfs_break_dax_layouts(
 
 	ASSERT(xfs_isilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL));
 
-	page = dax_layout_busy_page(inode->i_mapping);
+	page = dax_zap_mappings(inode->i_mapping);
 	if (!page)
 		return 0;
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 72ce1cb72736..9bbc68500cec 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3482,8 +3482,8 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	 * need to unlock & lock the XFS_MMAPLOCK_EXCL which is not suitable
 	 * for this nested lock case.
 	 */
-	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
-	if (page && page_ref_count(page) != 1) {
+	page = dax_zap_mappings(VFS_I(ip2)->i_mapping);
+	if (page) {
 		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
 		goto again;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 04987d14d7e0..f6acb4ed73cb 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -157,8 +157,9 @@ static inline void fs_put_dax(struct dax_device *dax_dev, void *holder)
 int dax_writeback_mapping_range(struct address_space *mapping,
 		struct dax_device *dax_dev, struct writeback_control *wbc);
 
-struct page *dax_layout_busy_page(struct address_space *mapping);
-struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
+struct page *dax_zap_mappings(struct address_space *mapping);
+struct page *dax_zap_mappings_range(struct address_space *mapping, loff_t start,
+				    loff_t end);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
 dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
@@ -166,12 +167,14 @@ dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
 void dax_unlock_mapping_entry(struct address_space *mapping,
 		unsigned long index, dax_entry_t cookie);
 #else
-static inline struct page *dax_layout_busy_page(struct address_space *mapping)
+static inline struct page *dax_zap_mappings(struct address_space *mapping)
 {
 	return NULL;
 }
 
-static inline struct page *dax_layout_busy_page_range(struct address_space *mapping, pgoff_t start, pgoff_t nr_pages)
+static inline struct page *dax_zap_mappings_range(struct address_space *mapping,
+						  pgoff_t start,
+						  pgoff_t nr_pages)
 {
 	return NULL;
 }

