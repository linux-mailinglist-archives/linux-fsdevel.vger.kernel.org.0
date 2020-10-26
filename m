Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BF4298635
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 05:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422273AbgJZEll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 00:41:41 -0400
Received: from casper.infradead.org ([90.155.50.34]:60086 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421510AbgJZElk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 00:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RRSaMGClXkysIFfJsu4KHWmeCgAPKYKCtm1cMXLEJ0o=; b=QH09f85pBq7GFer39wr1BLQzn7
        iifWOhtWMlWu2buN18tedzflvnjTqtSHe70Jn9aXBFswbO6sdolkWn/8/sQ+KB//DLkzw5eMG8Zno
        QH/3PCrxtqPo22+Q2IVnnBpF6yidJwccpVDY4qnkK1SkeXfvzi4xO6yVLf1Ac9SEQEZ1lyhNxfuVh
        ndZ/K6pdtcJvjM5oPOcySCTLXVfb05clLySy9QGjVzSNxcyMvgm+RDlebZeBhtEDUgQ89fK4XjZ95
        7LzaoEVGld9eurHp7DU9kYKPYCNeNwaHBze/SSrouPAL1h5XTJ2MpqkaCuKfBqfLv1J1vnz0wPikN
        Xlec8N/g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWtta-0006Zr-SU; Mon, 26 Oct 2020 04:14:10 +0000
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
Subject: [PATCH v3 03/12] mm/filemap: Add helper for finding pages
Date:   Mon, 26 Oct 2020 04:13:59 +0000
Message-Id: <20201026041408.25230-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026041408.25230-1-willy@infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a lot of common code in find_get_entries(),
find_get_pages_range() and find_get_pages_range_tag().  Factor out
xas_find_get_entry() which simplifies all three functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/filemap.c | 98 +++++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 55 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index edde5dc0d28f..00eaed59e797 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1856,6 +1856,43 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 }
 EXPORT_SYMBOL(pagecache_get_page);
 
+static inline struct page *xas_find_get_entry(struct xa_state *xas,
+		pgoff_t max, xa_mark_t mark)
+{
+	struct page *page;
+
+retry:
+	if (mark == XA_PRESENT)
+		page = xas_find(xas, max);
+	else
+		page = xas_find_marked(xas, max, mark);
+
+	if (xas_retry(xas, page))
+		goto retry;
+	/*
+	 * A shadow entry of a recently evicted page, a swap
+	 * entry from shmem/tmpfs or a DAX entry.  Return it
+	 * without attempting to raise page count.
+	 */
+	if (!page || xa_is_value(page))
+		return page;
+
+	if (!page_cache_get_speculative(page))
+		goto reset;
+
+	/* Has the page moved or been split? */
+	if (unlikely(page != xas_reload(xas))) {
+		put_page(page);
+		goto reset;
+	}
+	VM_BUG_ON_PAGE(!thp_contains(page, xas->xa_index), page);
+
+	return page;
+reset:
+	xas_reset(xas);
+	goto retry;
+}
+
 /**
  * find_get_entries - gang pagecache lookup
  * @mapping:	The address_space to search
@@ -1895,42 +1932,21 @@ unsigned find_get_entries(struct address_space *mapping,
 		return 0;
 
 	rcu_read_lock();
-	xas_for_each(&xas, page, ULONG_MAX) {
-		if (xas_retry(&xas, page))
-			continue;
-		/*
-		 * A shadow entry of a recently evicted page, a swap
-		 * entry from shmem/tmpfs or a DAX entry.  Return it
-		 * without attempting to raise page count.
-		 */
-		if (xa_is_value(page))
-			goto export;
-
-		if (!page_cache_get_speculative(page))
-			goto retry;
-
-		/* Has the page moved or been split? */
-		if (unlikely(page != xas_reload(&xas)))
-			goto put_page;
-
+	while ((page = xas_find_get_entry(&xas, ULONG_MAX, XA_PRESENT))) {
 		/*
 		 * Terminate early on finding a THP, to allow the caller to
 		 * handle it all at once; but continue if this is hugetlbfs.
 		 */
-		if (PageTransHuge(page) && !PageHuge(page)) {
+		if (!xa_is_value(page) && PageTransHuge(page) &&
+				!PageHuge(page)) {
 			page = find_subpage(page, xas.xa_index);
 			nr_entries = ret + 1;
 		}
-export:
+
 		indices[ret] = xas.xa_index;
 		entries[ret] = page;
 		if (++ret == nr_entries)
 			break;
-		continue;
-put_page:
-		put_page(page);
-retry:
-		xas_reset(&xas);
 	}
 	rcu_read_unlock();
 	return ret;
@@ -1969,30 +1985,16 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 		return 0;
 
 	rcu_read_lock();
-	xas_for_each(&xas, page, end) {
-		if (xas_retry(&xas, page))
-			continue;
+	while ((page = xas_find_get_entry(&xas, end, XA_PRESENT))) {
 		/* Skip over shadow, swap and DAX entries */
 		if (xa_is_value(page))
 			continue;
 
-		if (!page_cache_get_speculative(page))
-			goto retry;
-
-		/* Has the page moved or been split? */
-		if (unlikely(page != xas_reload(&xas)))
-			goto put_page;
-
 		pages[ret] = find_subpage(page, xas.xa_index);
 		if (++ret == nr_pages) {
 			*start = xas.xa_index + 1;
 			goto out;
 		}
-		continue;
-put_page:
-		put_page(page);
-retry:
-		xas_reset(&xas);
 	}
 
 	/*
@@ -2091,9 +2093,7 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 		return 0;
 
 	rcu_read_lock();
-	xas_for_each_marked(&xas, page, end, tag) {
-		if (xas_retry(&xas, page))
-			continue;
+	while ((page = xas_find_get_entry(&xas, end, tag))) {
 		/*
 		 * Shadow entries should never be tagged, but this iteration
 		 * is lockless so there is a window for page reclaim to evict
@@ -2102,23 +2102,11 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 		if (xa_is_value(page))
 			continue;
 
-		if (!page_cache_get_speculative(page))
-			goto retry;
-
-		/* Has the page moved or been split? */
-		if (unlikely(page != xas_reload(&xas)))
-			goto put_page;
-
 		pages[ret] = page;
 		if (++ret == nr_pages) {
 			*index = page->index + thp_nr_pages(page);
 			goto out;
 		}
-		continue;
-put_page:
-		put_page(page);
-retry:
-		xas_reset(&xas);
 	}
 
 	/*
-- 
2.28.0

