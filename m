Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316B93A703A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhFNUZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbhFNUZp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:25:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FD9C061767;
        Mon, 14 Jun 2021 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fhM6sGoP6sWwb8+1tf/031yNBWNPdcp8Zm/IvrwCWkc=; b=PdcnKosLr/E3V+QatBs1SDkWz8
        xP5ouuTw/QRNszzdBhSUjsG3L+7Rx8e6CakKAabQYnkyTAHsDyb3J29+ZPl8AP4l+2w2BSVrg3sYO
        s7B6UlHsMt5YCbOqlZkPvsjbDTwdNNEOHeD9QkyIGziD9eRZwodiMBN9RaSJDQsycPB23oZHmWsaw
        MLlsEW9105R4SnK13nx6xujnAyyGVlGSpres6xvLK3vKA4/FoHClXQeWFjqJDbsOFdAAYPXztptcl
        fX/pQeEpPBIOuqc5axVHzUWbD6yltOaU8E0Ysa3OoE2Xabhk5URv/Xl3L//eHeAs5bHKkR7IYS+vY
        A6x/g7Bw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lst6J-005nRu-6C; Mon, 14 Jun 2021 20:22:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Subject: [PATCH v11 11/33] mm/lru: Add folio LRU functions
Date:   Mon, 14 Jun 2021 21:14:13 +0100
Message-Id: <20210614201435.1379188-12-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614201435.1379188-1-willy@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Handle arbitrary-order folios being added to the LRU.  By definition,
all pages being added to the LRU were already head or base pages,
so define page wrappers around folio functions where the original
page functions involved calling compound_head() to manipulate flags,
but define folio wrappers around page functions where there's no need to
call compound_head().  The one thing that does change for those functions
is calling compound_nr() instead of thp_nr_pages(), in order to handle
arbitrary-sized folios.

Saves 783 bytes of kernel text; no functions grow.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h | 85 +++++++++++++++++++++++++++------------
 1 file changed, 59 insertions(+), 26 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 355ea1ee32bd..c9e05631e565 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -6,22 +6,27 @@
 #include <linux/swap.h>
 
 /**
- * page_is_file_lru - should the page be on a file LRU or anon LRU?
- * @page: the page to test
+ * folio_is_file_lru - should the folio be on a file LRU or anon LRU?
+ * @folio: the folio to test
  *
- * Returns 1 if @page is a regular filesystem backed page cache page or a lazily
- * freed anonymous page (e.g. via MADV_FREE).  Returns 0 if @page is a normal
- * anonymous page, a tmpfs page or otherwise ram or swap backed page.  Used by
- * functions that manipulate the LRU lists, to sort a page onto the right LRU
- * list.
+ * Returns 1 if @folio is a regular filesystem backed page cache folio
+ * or a lazily freed anonymous folio (e.g. via MADV_FREE).  Returns 0 if
+ * @folio is a normal anonymous folio, a tmpfs folio or otherwise ram or
+ * swap backed folio.  Used by functions that manipulate the LRU lists,
+ * to sort a folio onto the right LRU list.
  *
  * We would like to get this info without a page flag, but the state
- * needs to survive until the page is last deleted from the LRU, which
+ * needs to survive until the folio is last deleted from the LRU, which
  * could be as far down as __page_cache_release.
  */
+static inline int folio_is_file_lru(struct folio *folio)
+{
+	return !folio_swapbacked(folio);
+}
+
 static inline int page_is_file_lru(struct page *page)
 {
-	return !PageSwapBacked(page);
+	return folio_is_file_lru(page_folio(page));
 }
 
 static __always_inline void update_lru_size(struct lruvec *lruvec,
@@ -42,66 +47,94 @@ static __always_inline void update_lru_size(struct lruvec *lruvec,
  * __clear_page_lru_flags - clear page lru flags before releasing a page
  * @page: the page that was on lru and now has a zero reference
  */
-static __always_inline void __clear_page_lru_flags(struct page *page)
+static __always_inline void __folio_clear_lru_flags(struct folio *folio)
 {
-	VM_BUG_ON_PAGE(!PageLRU(page), page);
+	VM_BUG_ON_FOLIO(!folio_lru(folio), folio);
 
-	__ClearPageLRU(page);
+	__folio_clear_lru_flag(folio);
 
 	/* this shouldn't happen, so leave the flags to bad_page() */
-	if (PageActive(page) && PageUnevictable(page))
+	if (folio_active(folio) && folio_unevictable(folio))
 		return;
 
-	__ClearPageActive(page);
-	__ClearPageUnevictable(page);
+	__folio_clear_active_flag(folio);
+	__folio_clear_unevictable_flag(folio);
+}
+
+static __always_inline void __clear_page_lru_flags(struct page *page)
+{
+	__folio_clear_lru_flags(page_folio(page));
 }
 
 /**
- * page_lru - which LRU list should a page be on?
- * @page: the page to test
+ * folio_lru_list - which LRU list should a folio be on?
+ * @folio: the folio to test
  *
- * Returns the LRU list a page should be on, as an index
+ * Returns the LRU list a folio should be on, as an index
  * into the array of LRU lists.
  */
-static __always_inline enum lru_list page_lru(struct page *page)
+static __always_inline enum lru_list folio_lru_list(struct folio *folio)
 {
 	enum lru_list lru;
 
-	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
+	VM_BUG_ON_FOLIO(folio_active(folio) && folio_unevictable(folio), folio);
 
-	if (PageUnevictable(page))
+	if (folio_unevictable(folio))
 		return LRU_UNEVICTABLE;
 
-	lru = page_is_file_lru(page) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
-	if (PageActive(page))
+	lru = folio_is_file_lru(folio) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
+	if (folio_active(folio))
 		lru += LRU_ACTIVE;
 
 	return lru;
 }
 
+static __always_inline enum lru_list page_lru(struct page *page)
+{
+	return folio_lru_list(page_folio(page));
+}
+
 static __always_inline void add_page_to_lru_list(struct page *page,
 				struct lruvec *lruvec)
 {
 	enum lru_list lru = page_lru(page);
 
-	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
+	update_lru_size(lruvec, lru, page_zonenum(page), compound_nr(page));
 	list_add(&page->lru, &lruvec->lists[lru]);
 }
 
+static __always_inline void folio_add_to_lru_list(struct folio *folio,
+				struct lruvec *lruvec)
+{
+	add_page_to_lru_list(&folio->page, lruvec);
+}
+
 static __always_inline void add_page_to_lru_list_tail(struct page *page,
 				struct lruvec *lruvec)
 {
 	enum lru_list lru = page_lru(page);
 
-	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
+	update_lru_size(lruvec, lru, page_zonenum(page), compound_nr(page));
 	list_add_tail(&page->lru, &lruvec->lists[lru]);
 }
 
+static __always_inline void folio_add_to_lru_list_tail(struct folio *folio,
+				struct lruvec *lruvec)
+{
+	add_page_to_lru_list_tail(&folio->page, lruvec);
+}
+
 static __always_inline void del_page_from_lru_list(struct page *page,
 				struct lruvec *lruvec)
 {
 	list_del(&page->lru);
 	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
-			-thp_nr_pages(page));
+			-compound_nr(page));
+}
+
+static __always_inline void folio_del_from_lru_list(struct folio *folio,
+				struct lruvec *lruvec)
+{
+	del_page_from_lru_list(&folio->page, lruvec);
 }
 #endif
-- 
2.30.2

