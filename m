Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70961AD281
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgDPWBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 18:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728514AbgDPWBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:01:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC991C061A41
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oWl7Bo+ZEaJmJs40/6QIbxDCr3XNJEbNu8oUFCyylaw=; b=UjgshzLWD6XOwcQJ2LId6BtF7t
        5mjUSYxKkR4ttgJnfS/25G9NB2QvKCJLmIpRGumGQtqFnzNvYN4qE1j7jx8gcmP3BXyAmMuBeVUTr
        oIteSof19xd2GacVOzIcpo948rKp6XLyhbEDC0gXZKacwhQWr6oofLaVb3R16JbjedtMnpa3S835T
        oE650iorAyRie2Gif2bAVvkIBzAFGzLr/I0XS9hqbeGNN02W0VIs0VIQ5NDlV4hUgvfDfJZjrMaJl
        NRMBczwCpNvjVeCV04HhnZN8R/Tn9JQ4Bk6dABaXbm28339bxOlTBgQDCN23D4JRo7vx1SwrsfGmu
        PBbJvkJg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPCZg-0003Ul-NW; Thu, 16 Apr 2020 22:01:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v3 10/11] mm: Use clear_bit_unlock_is_negative_byte for PageWriteback
Date:   Thu, 16 Apr 2020 15:01:29 -0700
Message-Id: <20200416220130.13343-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200416220130.13343-1-willy@infradead.org>
References: <20200416220130.13343-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

We can use clear_bit_unlock_is_negative_byte() for writeback as well as
the lock bit.  wake_up_page() then has no more callers and can be removed.

Given the other code being executed between the clear and the test,
this is not going to be as dramatic a win as it was for PageLocked,
but symmetry between the two is nice and lets us remove some code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/page-flags.h |  2 +-
 mm/filemap.c               | 12 ++----------
 mm/page-writeback.c        | 37 ++++++++++++++++++++-----------------
 3 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index af7c0ff5f517..96c7d220c8cf 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -545,7 +545,7 @@ static __always_inline void SetPageUptodate(struct page *page)
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
 
-int test_clear_page_writeback(struct page *page);
+bool __clear_page_writeback(struct page *page);
 int __test_set_page_writeback(struct page *page, bool keep_write);
 
 #define test_set_page_writeback(page)			\
diff --git a/mm/filemap.c b/mm/filemap.c
index 401b24d980ba..c704d333d3bf 100644
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
@@ -1293,9 +1286,8 @@ void end_page_writeback(struct page *page)
 		rotate_reclaimable_page(page);
 	}
 
-	test_clear_page_writeback(page);
-	smp_mb__after_atomic();
-	wake_up_page(page, PG_writeback);
+	if (__clear_page_writeback(page))
+		wake_up_page_bit(page, PG_writeback);
 }
 EXPORT_SYMBOL(end_page_writeback);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ebaf0d8263a6..d019d86fc21f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -595,7 +595,7 @@ static void wb_domain_writeout_inc(struct wb_domain *dom,
 
 /*
  * Increment @wb's writeout completion count and the global writeout
- * completion count. Called from test_clear_page_writeback().
+ * completion count.
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
 
 	if (WARN_ON(!PageWriteback(page))) {
 		dump_page(page, "!writeback");
@@ -2731,16 +2738,14 @@ int test_clear_page_writeback(struct page *page)
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
@@ -2749,7 +2754,7 @@ int test_clear_page_writeback(struct page *page)
 
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 	} else {
-		ret = TestClearPageWriteback(page);
+		ret = clear_writeback_bit(page);
 	}
 	/*
 	 * NOTE: Page might be free now! Writeback doesn't hold a page
@@ -2757,11 +2762,9 @@ int test_clear_page_writeback(struct page *page)
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

