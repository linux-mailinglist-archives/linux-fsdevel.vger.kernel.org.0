Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2913C4181
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhGLDR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGLDR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:17:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF48EC0613DD;
        Sun, 11 Jul 2021 20:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ze6xRomQ1bUMPrNkH4TWGB0/5VZB9JEhtDWv/M+iJDY=; b=EHiWLpy/tD3SNUGQbT2kre2o13
        GYVUVepVD7I5KMTzl2OVB2Dd4etRDzZUC0PGStFN9EyFD5XRqQL5jIqbYd855Toy1hQAdnftMjSUd
        KZYD3fiGJc0LmX6ucXpFqwbsDVJ4YYLinWlP6/OmezY9BywOrt6xCHg7RkL6WkM00ZZ05Le8pI3TK
        +JgyeaAp2raOB9Z+n2ZYNMS59OulbxRmStEhxEJqNE9985yle9Ux0Y9SzM1z6gMPDj8YRtoDFsOt/
        01bSiiITwriDFcR7luxDLedBU29vq0k9rcyAIV5PDG5KA8+GfZoQxOxPv/homA5wPOA9kJIv/H5Nc
        VK5Q4peA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mOR-00GnBQ-OI; Mon, 12 Jul 2021 03:14:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v13 011/137] mm/lru: Add folio LRU functions
Date:   Mon, 12 Jul 2021 04:04:55 +0100
Message-Id: <20210712030701.4000097-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Howells <dhowells@redhat.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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

