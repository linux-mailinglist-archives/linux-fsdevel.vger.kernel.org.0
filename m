Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557A23C977B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhGOEeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbhGOEeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:34:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8BEC06175F;
        Wed, 14 Jul 2021 21:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=upWaP5V9owO0LbXy+PsmNxmwvLdkP8m88iqnEAk7sDI=; b=EISnx6UP+xLhpBibPof0Y5UczM
        Z7RKYjkoweLOmRKYpvdhILliTwGyoheUUOIWbEq3N2l9vNSZZRnBj/N5G0RPZ9KUHMEsQDfyiScet
        k3NbqxRIgEIvSr7AI8/uDUkTL/ZLzxd7TYljbvXGUpLrpXHw8YItxUBnnDSGFDa6Um9qhyVPuCn4O
        MGWEeDJIvRAnL4wqSyGU4+FFmXE1ixf2/CtVfjEMWBNv9Bkq/pQBWA+N65dmDTRlgYVza+iVzdjKV
        Q6EAZ0IRjxjqtCtfi98XmFM4TmMGqBUVdFP9DDkFYEBK4D09tQtjDuDq6Z8FDyFTgnHxtmzNJD5t3
        s41xTVyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3t0P-002xb0-Tp; Thu, 15 Jul 2021 04:30:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 067/138] mm/writeback: Add folio_start_writeback()
Date:   Thu, 15 Jul 2021 04:35:53 +0100
Message-Id: <20210715033704.692967-68-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename set_page_writeback() to folio_start_writeback() to match
folio_end_writeback().  Do not bother with wrappers that return void;
callers are perfectly capable of ignoring return values.

Add wrappers for set_page_writeback(), set_page_writeback_keepwrite() and
test_set_page_writeback() for compatibililty with existing filesystems.
The main advantage of this patch is getting the statistics right,
although it does eliminate a couple of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/page-flags.h | 19 +++++++++---------
 mm/folio-compat.c          |  6 ++++++
 mm/page-writeback.c        | 40 ++++++++++++++++++++------------------
 3 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 6f9d1f26b1ef..54c4af35c628 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -655,21 +655,22 @@ static __always_inline void SetPageUptodate(struct page *page)
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
 
-int __test_set_page_writeback(struct page *page, bool keep_write);
+bool __folio_start_writeback(struct folio *folio, bool keep_write);
+bool set_page_writeback(struct page *page);
 
-#define test_set_page_writeback(page)			\
-	__test_set_page_writeback(page, false)
-#define test_set_page_writeback_keepwrite(page)	\
-	__test_set_page_writeback(page, true)
+#define folio_start_writeback(folio)			\
+	__folio_start_writeback(folio, false)
+#define folio_start_writeback_keepwrite(folio)	\
+	__folio_start_writeback(folio, true)
 
-static inline void set_page_writeback(struct page *page)
+static inline void set_page_writeback_keepwrite(struct page *page)
 {
-	test_set_page_writeback(page);
+	folio_start_writeback_keepwrite(page_folio(page));
 }
 
-static inline void set_page_writeback_keepwrite(struct page *page)
+static inline bool test_set_page_writeback(struct page *page)
 {
-	test_set_page_writeback_keepwrite(page);
+	return set_page_writeback(page);
 }
 
 __PAGEFLAG(Head, head, PF_ANY) CLEARPAGEFLAG(Head, head, PF_ANY)
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 2ccd8f213fc4..10ce5582d869 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -71,3 +71,9 @@ void migrate_page_copy(struct page *newpage, struct page *page)
 }
 EXPORT_SYMBOL(migrate_page_copy);
 #endif
+
+bool set_page_writeback(struct page *page)
+{
+	return folio_start_writeback(page_folio(page));
+}
+EXPORT_SYMBOL(set_page_writeback);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 8d5d7921b157..0336273154fb 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2773,21 +2773,23 @@ bool __folio_end_writeback(struct folio *folio)
 	return ret;
 }
 
-int __test_set_page_writeback(struct page *page, bool keep_write)
+bool __folio_start_writeback(struct folio *folio, bool keep_write)
 {
-	struct address_space *mapping = page_mapping(page);
-	int ret, access_ret;
+	long nr = folio_nr_pages(folio);
+	struct address_space *mapping = folio_mapping(folio);
+	bool ret;
+	int access_ret;
 
-	lock_page_memcg(page);
+	folio_memcg_lock(folio);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
-		XA_STATE(xas, &mapping->i_pages, page_index(page));
+		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
 		unsigned long flags;
 
 		xas_lock_irqsave(&xas, flags);
 		xas_load(&xas);
-		ret = TestSetPageWriteback(page);
+		ret = folio_test_set_writeback(folio);
 		if (!ret) {
 			bool on_wblist;
 
@@ -2796,40 +2798,40 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 
 			xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
 			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT)
-				inc_wb_stat(inode_to_wb(inode), WB_WRITEBACK);
+				wb_stat_mod(inode_to_wb(inode), WB_WRITEBACK,
+						nr);
 
 			/*
-			 * We can come through here when swapping anonymous
-			 * pages, so we don't necessarily have an inode to track
-			 * for sync.
+			 * We can come through here when swapping
+			 * anonymous folios, so we don't necessarily
+			 * have an inode to track for sync.
 			 */
 			if (mapping->host && !on_wblist)
 				sb_mark_inode_writeback(mapping->host);
 		}
-		if (!PageDirty(page))
+		if (!folio_test_dirty(folio))
 			xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
 		if (!keep_write)
 			xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
 		xas_unlock_irqrestore(&xas, flags);
 	} else {
-		ret = TestSetPageWriteback(page);
+		ret = folio_test_set_writeback(folio);
 	}
 	if (!ret) {
-		inc_lruvec_page_state(page, NR_WRITEBACK);
-		inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
+		lruvec_stat_mod_folio(folio, NR_WRITEBACK, nr);
+		zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
 	}
-	unlock_page_memcg(page);
-	access_ret = arch_make_page_accessible(page);
+	folio_memcg_unlock(folio);
+	access_ret = arch_make_folio_accessible(folio);
 	/*
 	 * If writeback has been triggered on a page that cannot be made
 	 * accessible, it is too late to recover here.
 	 */
-	VM_BUG_ON_PAGE(access_ret != 0, page);
+	VM_BUG_ON_FOLIO(access_ret != 0, folio);
 
 	return ret;
-
 }
-EXPORT_SYMBOL(__test_set_page_writeback);
+EXPORT_SYMBOL(__folio_start_writeback);
 
 /**
  * folio_wait_writeback - Wait for a folio to finish writeback.
-- 
2.30.2

