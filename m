Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAA532E0C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhCEE1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCEE1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:27:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5503C061574;
        Thu,  4 Mar 2021 20:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zWeB6aqDwj65PTFEYVpI7YPXR8x4bwFky9HOKv5MiL0=; b=LLWyhqLGjwShJrcyau7YFLyoZm
        JK4v5iTnEt2pgVKNSSpd28WJZebmAJvbBCSpYzRytFLx1A0yVR9j+NtlmCDCHYkRyVVmv6tCxSUwG
        XB4Xvv5fFCXDdDaKVXX4bJE6XQkg3incAQVqkXsgf7CtKHPeE8664Jo/uFpTbXuznhd7CaznfhbPJ
        7YFQw1wO/q31+PBPaFxI0P/lm/tcKF6YQ/Yb41iVJdU9DxonpL/Qw55a0S5lIhev7sE0fW1ioqLm4
        nhWmgAXLaBE/EDICf11R5An6v77/W9FrXeJSgfMljBf7yuYNLM13bkEbUK88X+cP+dz2fAtXDpAdP
        AG+vd6Jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI231-00A4pJ-TB; Fri, 05 Mar 2021 04:26:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 23/25] mm/page-writeback: Convert test_clear_page_writeback to take a folio
Date:   Fri,  5 Mar 2021 04:18:59 +0000
Message-Id: <20210305041901.2396498-24-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The one caller of test_clear_page_writeback() already has a folio,
so rename it to test_clear_folio_writeback() to make it clear that it
operates on the entire folio.  This removes a few calls to compound_head()
but actually grows the function by 49 bytes because it now accounts for
the number of pages in the folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h |  2 +-
 mm/filemap.c               |  2 +-
 mm/page-writeback.c        | 20 ++++++++++----------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 90381858d901..01aa4a71bf14 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -594,7 +594,7 @@ static __always_inline void SetPageUptodate(struct page *page)
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
 
-int test_clear_page_writeback(struct page *page);
+int test_clear_folio_writeback(struct folio *folio);
 int __test_set_page_writeback(struct page *page, bool keep_write);
 
 #define test_set_page_writeback(page)			\
diff --git a/mm/filemap.c b/mm/filemap.c
index e91fa14c86c7..57f46ff2f230 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1446,7 +1446,7 @@ void end_folio_writeback(struct folio *folio)
 	 * reused before the wake_up_folio().
 	 */
 	get_folio(folio);
-	if (!test_clear_page_writeback(&folio->page))
+	if (!test_clear_folio_writeback(folio))
 		BUG();
 
 	smp_mb__after_atomic();
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 6c1b4737c383..fa3411ea4cd3 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -589,7 +589,7 @@ static void wb_domain_writeout_inc(struct wb_domain *dom,
 
 /*
  * Increment @wb's writeout completion count and the global writeout
- * completion count. Called from test_clear_page_writeback().
+ * completion count. Called from test_clear_folio_writeback().
  */
 static inline void __wb_writeout_inc(struct bdi_writeback *wb)
 {
@@ -2719,24 +2719,24 @@ int clear_page_dirty_for_io(struct page *page)
 }
 EXPORT_SYMBOL(clear_page_dirty_for_io);
 
-int test_clear_page_writeback(struct page *page)
+int test_clear_folio_writeback(struct folio *folio)
 {
-	struct address_space *mapping = page_mapping(page);
+	struct address_space *mapping = folio_mapping(folio);
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 	int ret;
 
-	memcg = lock_page_memcg(page);
-	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+	memcg = lock_folio_memcg(folio);
+	lruvec = mem_cgroup_folio_lruvec(folio, folio_pgdat(folio));
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
 		unsigned long flags;
 
 		xa_lock_irqsave(&mapping->i_pages, flags);
-		ret = TestClearPageWriteback(page);
+		ret = TestClearFolioWriteback(folio);
 		if (ret) {
-			__xa_clear_mark(&mapping->i_pages, page_index(page),
+			__xa_clear_mark(&mapping->i_pages, folio_index(folio),
 						PAGECACHE_TAG_WRITEBACK);
 			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
 				struct bdi_writeback *wb = inode_to_wb(inode);
@@ -2752,12 +2752,12 @@ int test_clear_page_writeback(struct page *page)
 
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 	} else {
-		ret = TestClearPageWriteback(page);
+		ret = TestClearFolioWriteback(folio);
 	}
 	if (ret) {
 		dec_lruvec_state(lruvec, NR_WRITEBACK);
-		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
-		inc_node_page_state(page, NR_WRITTEN);
+		dec_zone_folio_stat(folio, NR_ZONE_WRITE_PENDING);
+		inc_node_folio_stat(folio, NR_WRITTEN);
 	}
 	__unlock_page_memcg(memcg);
 	return ret;
-- 
2.30.0

