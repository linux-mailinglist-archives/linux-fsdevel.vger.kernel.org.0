Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EFC3746DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 19:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbhEERcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240309AbhEERU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:20:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3420C08EB0B;
        Wed,  5 May 2021 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=brBdjD9Ppp8PG9BGHTyvbw5Kp5eFerXmwRmOz/JrsJg=; b=pNjdDwCoxaD83ZkEc3xjyKioDw
        dB79Od/hIu1fSRyYZrCzYz3xBHw3G/nCOmAFbUoo35lwRJOojXLtI9CAksjbaIeaG8my0pLmg3M+2
        j+9C+VMHnG4vGvoJx5jQVIi6FjpYbK/1sUR5rH6Ct3sM0ftDdnMhrKdfFxuZRaebKj8wRPgj4j36Z
        n8i8dNOb9vkrjto6n0QpzPF5vMwNfgJVqjBNMJ6R3V6WnzObDOlqGjHKgJVAQ3V2WXvqXgyk8L1IN
        2evghG03alUSS93NsIQ0w1rX3LTOexnUfAOfoiLLrP0K6ztrdkA4PxT4XkvV5sOEbF/htqGxdDXwQ
        +odTwbVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKYp-000bMv-2B; Wed, 05 May 2021 16:41:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 73/96] mm/lru: Add folio_lru and folio_is_file_lru
Date:   Wed,  5 May 2021 16:06:05 +0100
Message-Id: <20210505150628.111735-74-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert page_lru() to call folio_lru() and convert page_is_file_lru()
to call folio_is_file_lru().  All pages on the LRUs are folios (because
tail pages use the space for the LRU list as compound_head), so all
callers can be converted.

Saves 637 bytes of kernel text; no functions grow.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm_inline.h | 44 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 355ea1ee32bd..c03b12ea0b7b 100644
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
@@ -57,28 +62,33 @@ static __always_inline void __clear_page_lru_flags(struct page *page)
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
-- 
2.30.2

