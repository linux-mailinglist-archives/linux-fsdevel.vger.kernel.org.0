Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2DAA193EC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 13:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgCZMYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 08:24:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgCZMYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rjxXUPkAV1fsLQ+udp/Q1rC9JBDjjV9DtFAl1poJf40=; b=fozePfDztlOQbzlhERCu3VnHRp
        IHZZQPqbVmbybpSq4Z9r3gpc6jcZATKHMO0uI1vpslmAb2eeck24ecqZO0WR3s1xbLa3OpgbkWl1+
        hre2NDHKPqTTIuLHLS8Mjbhw0a0uzzkqMHQBVyUDgyjgiLbC8wUVH/RoLYCvfFAt0e/p7QTWY8qzz
        X3RvuW7UJpQFKxpWEEU98Fk7EKw0VOz0n6wbKd8QC/6BpHSylMqXZdeMlxWWftv3gSPvS3M6iJGuP
        +1hnMTD0zQm4uyUGGzMEUl0dUn0yiQWsWjeNkzjH2R6ECc48InnSeVQ+DYmyhXd1aX7ZHVxWldGsd
        QJmP5DWg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHRYk-0005P4-7R; Thu, 26 Mar 2020 12:24:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/2] mm: Use clear_bit_unlock_is_negative_byte for PageWriteback
Date:   Thu, 26 Mar 2020 05:24:29 -0700
Message-Id: <20200326122429.20710-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200326122429.20710-1-willy@infradead.org>
References: <20200326122429.20710-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

By moving PG_writeback down into the low bits of the page flags, we can
use clear_bit_unlock_is_negative_byte() for writeback as well as the
lock bit.  wake_up_page() then has no more callers.  Given the other
code being executed between the clear and the test, this is not going
to be as dramatic a win as it was for PageLocked, but symmetry between
the two is nice and lets us remove some code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h |  6 +++---
 mm/filemap.c               | 19 ++++++-------------
 mm/page-writeback.c        | 37 ++++++++++++++++++++-----------------
 3 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 222f6f7b2bb3..96c7d220c8cf 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -103,13 +103,14 @@
  */
 enum pageflags {
 	PG_locked,		/* Page is locked. Don't touch. */
+	PG_writeback,		/* Page is under writeback */
 	PG_referenced,
 	PG_uptodate,
 	PG_dirty,
 	PG_lru,
 	PG_active,
+	PG_waiters,		/* Page has waiters, check its waitqueue */
 	PG_workingset,
-	PG_waiters,		/* Page has waiters, check its waitqueue. Must be bit #7 and in the same byte as "PG_locked" */
 	PG_error,
 	PG_slab,
 	PG_owner_priv_1,	/* Owner use. If pagecache, fs may use*/
@@ -117,7 +118,6 @@ enum pageflags {
 	PG_reserved,
 	PG_private,		/* If pagecache, has fs-private data */
 	PG_private_2,		/* If pagecache, has fs aux data */
-	PG_writeback,		/* Page is under writeback */
 	PG_head,		/* A head page */
 	PG_mappedtodisk,	/* Has blocks allocated on-disk */
 	PG_reclaim,		/* To be reclaimed asap */
@@ -545,7 +545,7 @@ static __always_inline void SetPageUptodate(struct page *page)
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
 
-int test_clear_page_writeback(struct page *page);
+bool __clear_page_writeback(struct page *page);
 int __test_set_page_writeback(struct page *page, bool keep_write);
 
 #define test_set_page_writeback(page)			\
diff --git a/mm/filemap.c b/mm/filemap.c
index 312afbfcb49a..bfe1782a7b98 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1084,13 +1084,6 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
-static void wake_up_page(struct page *page, int bit)
-{
-	if (!PageWaiters(page))
-		return;
-	wake_up_page_bit(page, bit);
-}
-
 /*
  * A choice of three behaviors for wait_on_page_bit_common():
  */
@@ -1266,6 +1259,7 @@ EXPORT_SYMBOL_GPL(add_page_wait_queue);
 void unlock_page(struct page *page)
 {
 	BUILD_BUG_ON(PG_waiters != 7);
+	BUILD_BUG_ON(PG_locked > 7);
 	page = compound_head(page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
@@ -1279,23 +1273,22 @@ EXPORT_SYMBOL(unlock_page);
  */
 void end_page_writeback(struct page *page)
 {
+	BUILD_BUG_ON(PG_writeback > 7);
 	/*
 	 * TestClearPageReclaim could be used here but it is an atomic
 	 * operation and overkill in this particular case. Failing to
 	 * shuffle a page marked for immediate reclaim is too mild to
 	 * justify taking an atomic operation penalty at the end of
-	 * ever page writeback.
+	 * every page writeback.
 	 */
 	if (PageReclaim(page)) {
 		ClearPageReclaim(page);
 		rotate_reclaimable_page(page);
 	}
 
-	if (!test_clear_page_writeback(page))
-		BUG();
-
-	smp_mb__after_atomic();
-	wake_up_page(page, PG_writeback);
+	VM_BUG_ON_PAGE(!PageWriteback(page), page);
+	if (__clear_page_writeback(page))
+		wake_up_page_bit(page, PG_writeback);
 }
 EXPORT_SYMBOL(end_page_writeback);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b7f3d0766a5f..4d675a7b81e6 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -595,7 +595,7 @@ static void wb_domain_writeout_inc(struct wb_domain *dom,
 
 /*
  * Increment @wb's writeout completion count and the global writeout
- * completion count. Called from test_clear_page_writeback().
+ * completion count. Called from __clear_page_writeback().
  */
 static inline void __wb_writeout_inc(struct bdi_writeback *wb)
 {
@@ -2711,12 +2711,19 @@ int clear_page_dirty_for_io(struct page *page)
 }
 EXPORT_SYMBOL(clear_page_dirty_for_io);
 
-int test_clear_page_writeback(struct page *page)
+#define clear_writeback_bit(page)	\
+	clear_bit_unlock_is_negative_byte(PG_writeback, &page->flags)
+
+/*
+ * The return value is whether there are waiters pending, not whether
+ * the flag was set.
+ */
+bool __clear_page_writeback(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
-	int ret;
+	bool ret;
 
 	memcg = lock_page_memcg(page);
 	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
@@ -2726,16 +2733,14 @@ int test_clear_page_writeback(struct page *page)
 		unsigned long flags;
 
 		xa_lock_irqsave(&mapping->i_pages, flags);
-		ret = TestClearPageWriteback(page);
-		if (ret) {
-			__xa_clear_mark(&mapping->i_pages, page_index(page),
+		ret = clear_writeback_bit(page);
+		__xa_clear_mark(&mapping->i_pages, page_index(page),
 						PAGECACHE_TAG_WRITEBACK);
-			if (bdi_cap_account_writeback(bdi)) {
-				struct bdi_writeback *wb = inode_to_wb(inode);
+		if (bdi_cap_account_writeback(bdi)) {
+			struct bdi_writeback *wb = inode_to_wb(inode);
 
-				dec_wb_stat(wb, WB_WRITEBACK);
-				__wb_writeout_inc(wb);
-			}
+			dec_wb_stat(wb, WB_WRITEBACK);
+			__wb_writeout_inc(wb);
 		}
 
 		if (mapping->host && !mapping_tagged(mapping,
@@ -2744,7 +2749,7 @@ int test_clear_page_writeback(struct page *page)
 
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 	} else {
-		ret = TestClearPageWriteback(page);
+		ret = clear_writeback_bit(page);
 	}
 	/*
 	 * NOTE: Page might be free now! Writeback doesn't hold a page
@@ -2752,11 +2757,9 @@ int test_clear_page_writeback(struct page *page)
 	 * the clearing of PG_writeback. The below can only access
 	 * page state that is static across allocation cycles.
 	 */
-	if (ret) {
-		dec_lruvec_state(lruvec, NR_WRITEBACK);
-		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
-		inc_node_page_state(page, NR_WRITTEN);
-	}
+	dec_lruvec_state(lruvec, NR_WRITEBACK);
+	dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
+	inc_node_page_state(page, NR_WRITTEN);
 	__unlock_page_memcg(memcg);
 	return ret;
 }
-- 
2.25.1

