Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30CE5AC1FB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Sep 2022 04:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiIDCQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 22:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIDCQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 22:16:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F189E45F72
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Sep 2022 19:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662257767; x=1693793767;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GVe4dBjvMQpZmNRdpmLWUnxXhArGe+l3tmmLFYYezBs=;
  b=D/AvnE8inyBQD37iVm8hix/Uz1vRJpapsj7//iKz+kb49uFLCzEV3lDi
   fI/+ikA3P19Afp4cdb0ba69UM1RYpXvUBX5x1I7wAHPdrbjwO1aC1/KaF
   UTCwe8IeJ0ADNCYKEdHPIqk4TDXJ273NKsT2PAtgdtfBf1EFyVLONU0ky
   AharUtZ/4EyhgX46HB3xKN4G9lMhmu9w5P/UMf22qWxwWWciSgGcck40h
   igQ7ybcXfAyJbU/L3fu/2O8W1kajde/jdw4ksKyOqTPTk6jMKhIC0gIIC
   wnyPwTLq7c4ynDbqQu9EvGWThUVD8irB8ZvHgB4DVVgGiXFM8QibYYitw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="279219083"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="279219083"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:16:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="702523876"
Received: from pg4-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.132.198])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:16:06 -0700
Subject: [PATCH 01/13] fsdax: Rename "busy page" to "pinned page"
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Date:   Sat, 03 Sep 2022 19:16:05 -0700
Message-ID: <166225776577.2351842.7326849167823619889.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The FSDAX need to hold of truncate is for pages undergoing DMA. Replace
the DAX specific "busy" terminology with the "pinned" term. This is in
preparation from moving FSDAX from watching transitions of
page->_refcount to '1' with observations of page_maybe_dma_pinned()
returning false.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c            |   16 ++++++++--------
 fs/ext4/inode.c     |    2 +-
 fs/fuse/dax.c       |    4 ++--
 fs/xfs/xfs_file.c   |    2 +-
 fs/xfs/xfs_inode.c  |    2 +-
 include/linux/dax.h |   10 ++++++----
 6 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index c440dcef4b1b..0f22f7b46de0 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -407,7 +407,7 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 	}
 }
 
-static struct page *dax_busy_page(void *entry)
+static struct page *dax_pinned_page(void *entry)
 {
 	unsigned long pfn;
 
@@ -665,7 +665,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 }
 
 /**
- * dax_layout_busy_page_range - find first pinned page in @mapping
+ * dax_layout_pinned_page_range - find first pinned page in @mapping
  * @mapping: address space to scan for a page with ref count > 1
  * @start: Starting offset. Page containing 'start' is included.
  * @end: End offset. Page containing 'end' is included. If 'end' is LLONG_MAX,
@@ -682,7 +682,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
  * to be able to run unmap_mapping_range() and subsequently not race
  * mapping_mapped() becoming true.
  */
-struct page *dax_layout_busy_page_range(struct address_space *mapping,
+struct page *dax_layout_pinned_page_range(struct address_space *mapping,
 					loff_t start, loff_t end)
 {
 	void *entry;
@@ -727,7 +727,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 		if (unlikely(dax_is_locked(entry)))
 			entry = get_unlocked_entry(&xas, 0);
 		if (entry)
-			page = dax_busy_page(entry);
+			page = dax_pinned_page(entry);
 		put_unlocked_entry(&xas, entry, WAKE_NEXT);
 		if (page)
 			break;
@@ -742,13 +742,13 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	xas_unlock_irq(&xas);
 	return page;
 }
-EXPORT_SYMBOL_GPL(dax_layout_busy_page_range);
+EXPORT_SYMBOL_GPL(dax_layout_pinned_page_range);
 
-struct page *dax_layout_busy_page(struct address_space *mapping)
+struct page *dax_layout_pinned_page(struct address_space *mapping)
 {
-	return dax_layout_busy_page_range(mapping, 0, LLONG_MAX);
+	return dax_layout_pinned_page_range(mapping, 0, LLONG_MAX);
 }
-EXPORT_SYMBOL_GPL(dax_layout_busy_page);
+EXPORT_SYMBOL_GPL(dax_layout_pinned_page);
 
 static int __dax_invalidate_entry(struct address_space *mapping,
 					  pgoff_t index, bool trunc)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 601214453c3a..bf49bf506965 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3957,7 +3957,7 @@ int ext4_break_layouts(struct inode *inode)
 		return -EINVAL;
 
 	do {
-		page = dax_layout_busy_page(inode->i_mapping);
+		page = dax_layout_pinned_page(inode->i_mapping);
 		if (!page)
 			return 0;
 
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index e23e802a8013..e0b846f16bc5 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -443,7 +443,7 @@ static int fuse_setup_new_dax_mapping(struct inode *inode, loff_t pos,
 
 	/*
 	 * Can't do inline reclaim in fault path. We call
-	 * dax_layout_busy_page() before we free a range. And
+	 * dax_layout_pinned_page() before we free a range. And
 	 * fuse_wait_dax_page() drops mapping->invalidate_lock and requires it.
 	 * In fault path we enter with mapping->invalidate_lock held and can't
 	 * drop it. Also in fault path we hold mapping->invalidate_lock shared
@@ -671,7 +671,7 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 {
 	struct page *page;
 
-	page = dax_layout_busy_page_range(inode->i_mapping, start, end);
+	page = dax_layout_pinned_page_range(inode->i_mapping, start, end);
 	if (!page)
 		return 0;
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index c6c80265c0b2..954bb6e83796 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -822,7 +822,7 @@ xfs_break_dax_layouts(
 
 	ASSERT(xfs_isilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL));
 
-	page = dax_layout_busy_page(inode->i_mapping);
+	page = dax_layout_pinned_page(inode->i_mapping);
 	if (!page)
 		return 0;
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 28493c8e9bb2..9d0bea03501e 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3481,7 +3481,7 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	 * need to unlock & lock the XFS_MMAPLOCK_EXCL which is not suitable
 	 * for this nested lock case.
 	 */
-	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
+	page = dax_layout_pinned_page(VFS_I(ip2)->i_mapping);
 	if (page && page_ref_count(page) != 1) {
 		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index ba985333e26b..54f099166a29 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -157,8 +157,8 @@ static inline void fs_put_dax(struct dax_device *dax_dev, void *holder)
 int dax_writeback_mapping_range(struct address_space *mapping,
 		struct dax_device *dax_dev, struct writeback_control *wbc);
 
-struct page *dax_layout_busy_page(struct address_space *mapping);
-struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
+struct page *dax_layout_pinned_page(struct address_space *mapping);
+struct page *dax_layout_pinned_page_range(struct address_space *mapping, loff_t start, loff_t end);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
 dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
@@ -166,12 +166,14 @@ dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
 void dax_unlock_mapping_entry(struct address_space *mapping,
 		unsigned long index, dax_entry_t cookie);
 #else
-static inline struct page *dax_layout_busy_page(struct address_space *mapping)
+static inline struct page *dax_layout_pinned_page(struct address_space *mapping)
 {
 	return NULL;
 }
 
-static inline struct page *dax_layout_busy_page_range(struct address_space *mapping, pgoff_t start, pgoff_t nr_pages)
+static inline struct page *
+dax_layout_pinned_page_range(struct address_space *mapping, pgoff_t start,
+			     pgoff_t nr_pages)
 {
 	return NULL;
 }

