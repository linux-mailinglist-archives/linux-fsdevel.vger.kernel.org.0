Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E641D5AC1FF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Sep 2022 04:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIDCQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 22:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIDCQN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 22:16:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC29F481DE
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Sep 2022 19:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662257772; x=1693793772;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XECMJ3rDr2QuKr70k+HRef4UN7pYK04Pd7WfZFPApLY=;
  b=UTnLRktnw7mCkJHMPNLErcSBZwnpk8mNQmU8xK92MceGxp0nMr3fpx8A
   J10C3MSuBXie0rWA1rKgOq/FUoHRdPIZpBA3nScXg0i240YBhDUYiYmeH
   1yFt41O2ZpODipKiDsI6UBEbk1KABeEXGuYSUNBrBpxcVlG4Tu6QYXS2B
   02vpYSPT1nem27FKxEJv0ETeKZF4mK4TMzWVeEIgDKcqhIClc7oWpVVZ/
   jUn45inYSMkcPa2w/bfZc9K3ddr5umXHLKKWrMvclNjaWuafjfh2ShCtR
   hoLgj9g+SwF3aOgkxtVyvjHSTiEgsvNPkEpCIKX1DSSgNpP7n/RDG+Ja3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="360158682"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="360158682"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:16:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="646515349"
Received: from pg4-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.132.198])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:16:12 -0700
Subject: [PATCH 02/13] fsdax: Use page_maybe_dma_pinned() for DAX vs DMA
 collisions
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Date:   Sat, 03 Sep 2022 19:16:12 -0700
Message-ID: <166225777193.2351842.16365701080007152185.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pin_user_pages() + page_maybe_dma_pinned() infrastructure is a
framework for tackling the kernel's struggles with gup+DMA.

DAX presents a unique flavor of the gup+DMA problem since pinned pages
are identical to physical filesystem blocks. Unlike the page-cache case,
a mapping of a file can not be truncated while DMA is in-flight because
the DMA must complete before the filesystem block is reclaimed.

DAX has a homegrown solution to this problem based on watching the
page->_refcount go idle. Beyond being awkward to catch that idle transition
in put_page(), it is overkill when only the page_maybe_dma_pinned()
transition needs to be captured.

Move the wakeup of filesystem-DAX truncate paths
({ext4,xfs,fuse_dax}_break_layouts()) to unpin_user_pages() with a new
wakeup_fsdax_pin_waiters() helper, and use !page_maybe_dma_pinned() as
the wake condition.

Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c           |    4 ++--
 fs/ext4/inode.c    |    7 +++----
 fs/fuse/dax.c      |    6 +++---
 fs/xfs/xfs_file.c  |    6 +++---
 include/linux/mm.h |   28 ++++++++++++++++++++++++++++
 mm/gup.c           |    6 ++++--
 6 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 0f22f7b46de0..aceb587bc27e 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -395,7 +395,7 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
+		WARN_ON_ONCE(trunc && page_maybe_dma_pinned(page));
 		if (dax_mapping_is_cow(page->mapping)) {
 			/* keep the CoW flag if this page is still shared */
 			if (page->index-- > 0)
@@ -414,7 +414,7 @@ static struct page *dax_pinned_page(void *entry)
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		if (page_ref_count(page) > 1)
+		if (page_maybe_dma_pinned(page))
 			return page;
 	}
 	return NULL;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bf49bf506965..5e68e64f155a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3961,10 +3961,9 @@ int ext4_break_layouts(struct inode *inode)
 		if (!page)
 			return 0;
 
-		error = ___wait_var_event(&page->_refcount,
-				atomic_read(&page->_refcount) == 1,
-				TASK_INTERRUPTIBLE, 0, 0,
-				ext4_wait_dax_page(inode));
+		error = ___wait_var_event(page, !page_maybe_dma_pinned(page),
+					  TASK_INTERRUPTIBLE, 0, 0,
+					  ext4_wait_dax_page(inode));
 	} while (error == 0);
 
 	return error;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index e0b846f16bc5..6419ca420c42 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -676,9 +676,9 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, fuse_wait_dax_page(inode));
+	return ___wait_var_event(page, !page_maybe_dma_pinned(page),
+				 TASK_INTERRUPTIBLE, 0, 0,
+				 fuse_wait_dax_page(inode));
 }
 
 /* dmap_end == 0 leads to unmapping of whole file */
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 954bb6e83796..dbffb9481b71 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -827,9 +827,9 @@ xfs_break_dax_layouts(
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, xfs_wait_dax_page(inode));
+	return ___wait_var_event(page, !page_maybe_dma_pinned(page),
+				 TASK_INTERRUPTIBLE, 0, 0,
+				 xfs_wait_dax_page(inode));
 }
 
 int
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3bedc449c14d..557d5447ebec 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1517,6 +1517,34 @@ static inline bool page_maybe_dma_pinned(struct page *page)
 	return folio_maybe_dma_pinned(page_folio(page));
 }
 
+#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
+/*
+ * Unlike typical file backed pages that support truncating a page from
+ * a file while it is under active DMA, DAX pages need to hold off
+ * truncate operations until transient page pins are released.
+ *
+ * The filesystem (via dax_layout_pinned_page()) takes steps to make
+ * sure that any observation of the !page_maybe_dma_pinned() state is
+ * stable until the truncation completes.
+ */
+static inline void wakeup_fsdax_pin_waiters(struct folio *folio)
+{
+	struct page *page = &folio->page;
+
+	if (!folio_is_zone_device(folio))
+		return;
+	if (page->pgmap->type != MEMORY_DEVICE_FS_DAX)
+		return;
+	if (folio_maybe_dma_pinned(folio))
+		return;
+	wake_up_var(page);
+}
+#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
+static inline void wakeup_fsdax_pin_waiters(struct folio *folio)
+{
+}
+#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
+
 /*
  * This should most likely only be called during fork() to see whether we
  * should break the cow immediately for an anon page on the src mm.
diff --git a/mm/gup.c b/mm/gup.c
index 732825157430..499c46296fda 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -177,8 +177,10 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 			refs *= GUP_PIN_COUNTING_BIAS;
 	}
 
-	if (!put_devmap_managed_page_refs(&folio->page, refs))
-		folio_put_refs(folio, refs);
+	folio_put_refs(folio, refs);
+
+	if (flags & FOLL_PIN)
+		wakeup_fsdax_pin_waiters(folio);
 }
 
 /**

