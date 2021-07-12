Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1F93C42BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhGLEQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhGLEQ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:16:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CA3C0613DD;
        Sun, 11 Jul 2021 21:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zn0/iCwWsCo/2/euB0DWs9Af4dwcp6xc3SXNP5raYIY=; b=qvMszYn3wWbvfWsbeO7YjzUbjU
        QQXVrLfH4G4kza1uEDQKjDnq56YCH513G8Ibp8fHquber0Ut2TBlLItaPwsByf88aGfbpjLplBuqN
        eRN30aTxmmIZUyA+Iw1EvWyF089ogJs65CktBSNt+TWbEztc68WlVkMF2Uh12/j584ttGPi+MbjWW
        fYvMm+kBm1sYdNvTEqF635GETvcua47Ge7wcPtoYymOJw53sYGi5/RYu59c3K9kJty69ShqTgNKn8
        GGuv3vvpTXm0egUZOqgFk1TKZKFYV+bXdYjVHkGOdymKwoLVbYi6ZVPV0G8BLoWVvPhxaD95rechH
        26zL3cKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nJH-00GrPq-3h; Mon, 12 Jul 2021 04:12:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v13 125/137] mm/filemap: Return only head pages from find_get_entries
Date:   Mon, 12 Jul 2021 04:06:49 +0100
Message-Id: <20210712030701.4000097-126-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers now expect head (and base) pages, and can handle multiple
head pages in a single batch, so make find_get_entries() behave that way.
Also take the opportunity to make it use the pagevec infrastructure
instead of open-coding how pvecs behave.  This has the side-effect of
being able to append to a pagevec with existing contents, although we
don't make use of that functionality anywhere yet.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagemap.h |  2 --
 mm/filemap.c            | 40 ++++++++++------------------------------
 mm/internal.h           |  2 ++
 3 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e7539da390d2..90935f231419 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -502,8 +502,6 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 	return head + (index & (thp_nr_pages(head) - 1));
 }
 
-unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 82f985f61224..aaed0396db28 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1955,49 +1955,29 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
  * the mapping.  The entries are placed in @pvec.  find_get_entries()
  * takes a reference on any actual pages it returns.
  *
- * The search returns a group of mapping-contiguous page cache entries
- * with ascending indexes.  There may be holes in the indices due to
- * not-present pages.
+ * The entries have ascending indexes.  The indices may not be consecutive
+ * due to not-present entries or THPs.
  *
  * Any shadow entries of evicted pages, or swap entries from
  * shmem/tmpfs, are included in the returned array.
  *
- * If it finds a Transparent Huge Page, head or tail, find_get_entries()
- * stops at that page: the caller is likely to have a better way to handle
- * the compound page as a whole, and then skip its extent, than repeatedly
- * calling find_get_entries() to return all its tails.
- *
- * Return: the number of pages and shadow entries which were found.
+ * Return: The number of entries which were found.
  */
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
-	struct page *page;
-	unsigned int ret = 0;
-	unsigned nr_entries = PAGEVEC_SIZE;
+	struct folio *folio;
 
 	rcu_read_lock();
-	while ((page = &find_get_entry(&xas, end, XA_PRESENT)->page)) {
-		/*
-		 * Terminate early on finding a THP, to allow the caller to
-		 * handle it all at once; but continue if this is hugetlbfs.
-		 */
-		if (!xa_is_value(page) && PageTransHuge(page) &&
-				!PageHuge(page)) {
-			page = find_subpage(page, xas.xa_index);
-			nr_entries = ret + 1;
-		}
-
-		indices[ret] = xas.xa_index;
-		pvec->pages[ret] = page;
-		if (++ret == nr_entries)
+	while ((folio = find_get_entry(&xas, end, XA_PRESENT)) != NULL) {
+		indices[pvec->nr] = xas.xa_index;
+		if (!pagevec_add(pvec, &folio->page))
 			break;
 	}
 	rcu_read_unlock();
 
-	pvec->nr = ret;
-	return ret;
+	return pagevec_count(pvec);
 }
 
 /**
@@ -2016,8 +1996,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
  * not returned.
  *
  * The entries have ascending indexes.  The indices may not be consecutive
- * due to not-present entries, THP pages, pages which could not be locked
- * or pages under writeback.
+ * due to not-present entries, THPs, pages which could not be locked or
+ * pages under writeback.
  *
  * Return: The number of entries which were found.
  */
diff --git a/mm/internal.h b/mm/internal.h
index 4730e9267bfc..65314d4380d0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -70,6 +70,8 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
+unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end);
 
 /**
-- 
2.30.2

