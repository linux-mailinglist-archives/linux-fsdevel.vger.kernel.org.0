Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE54298634
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 05:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422266AbgJZElj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 00:41:39 -0400
Received: from casper.infradead.org ([90.155.50.34]:60076 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421493AbgJZEli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 00:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kpUczdeKYi1+38xZwHEXixHpdmrDrWMrdTwGd2Ba8x0=; b=YcfZjdNN1aDe/LcHqu+I3/RUD7
        ZB/2qcxmUEd0z/Z+O9YaxXNnWUummKleEY3HmDXPF9Z9OOL/EfnAFqBUH5T9hRUaOQTScouC78Aq3
        xw8jSrszyqXqn+fwCOXxEUMcOyXHpzE8nFgzbwL/2K7eVO4HPakPOm+rnQy6p2csVx+4pPDsObLRm
        OZKyyMBUt4CJHQbpNVhyAGYa00xjzg9iaQ0UP/sx8iI2v8g0Ng5KC4SMhk37oLj49g8y97KRZo4Y9
        keDM8o968FrKmDot2d98jRh6+ozGlQarsJz4VWaUjUssDqRLKqQCDReXLZw7XEU3VvvmQOfpsEwMJ
        prUEKttw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWttd-0006as-1o; Mon, 26 Oct 2020 04:14:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v3 12/12] mm/filemap: Return only head pages from find_get_entries
Date:   Mon, 26 Oct 2020 04:14:08 +0000
Message-Id: <20201026041408.25230-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026041408.25230-1-willy@infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
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
 mm/filemap.c            | 36 ++++++++----------------------------
 mm/internal.h           |  2 ++
 3 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f0bbe29de732..8938c64f418b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -449,8 +449,6 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 	return head + (index & (thp_nr_pages(head) - 1));
 }
 
-unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index e0fa943011d8..a117718ec1a8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1905,49 +1905,29 @@ static inline struct page *xas_find_get_entry(struct xa_state *xas,
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
 	struct page *page;
-	unsigned int ret = 0;
-	unsigned nr_entries = PAGEVEC_SIZE;
 
 	rcu_read_lock();
 	while ((page = xas_find_get_entry(&xas, end, XA_PRESENT))) {
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
+		indices[pvec->nr] = xas.xa_index;
+		if (!pagevec_add(pvec, page))
 			break;
 	}
 	rcu_read_unlock();
 
-	pvec->nr = ret;
-	return ret;
+	return pagevec_count(pvec);
 }
 
 /**
@@ -1966,8 +1946,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
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
index 194572e1ab49..5aca7d7bc57c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -62,6 +62,8 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 
 struct page *find_get_entry(struct address_space *mapping, pgoff_t index);
 struct page *find_lock_entry(struct address_space *mapping, pgoff_t index);
+unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 
-- 
2.28.0

