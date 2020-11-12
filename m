Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7E2B104A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgKLV1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbgKLV1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:27:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A70C0613D1;
        Thu, 12 Nov 2020 13:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6XcAZ7OySglgZ9lx2gp5OHTvPB4mDq/mtcuSzOM0Egk=; b=YKIYxP9A/8LSWex39mvvG1NzQ0
        Dca/uL4ewu2LDJxHpxWAl1Vc2lFbqodOz3eugS6t1VbAYlDfvsd6l17xAHTm0e4iY7ncvGG5v2saB
        5PVjINN5fQIrk+1K7EYTisH7+y3CF9xr9jYNSj2WgS7xVW1/Sqrh2h2IyC80ujwCxNn23Bjk0dZGe
        4m6+bSd7MC17OG1oZMtgTO2hKWvgCsLZtzC3RrWNllPPWjDlG2VmUcT+hlNNyeHuzB8HDY1Qt6cyQ
        8FaswTkekpge4YtPyw0L0SflKpX9o9sItkpHQaYPvrpOrd3w7kSgfaSzJ+rWARP7NEEx2Iy6/+Y46
        kUR9sNWA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7B-0007GV-Rg; Thu, 12 Nov 2020 21:26:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 06/16] mm/filemap: Add helper for finding pages
Date:   Thu, 12 Nov 2020 21:26:31 +0000
Message-Id: <20201112212641.27837-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a lot of common code in find_get_entries(),
find_get_pages_range() and find_get_pages_range_tag().  Factor out
find_get_entry() which simplifies all three functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/filemap.c | 98 +++++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 55 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 53073281f027..e0d9cfa2ae90 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1829,6 +1829,43 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 }
 EXPORT_SYMBOL(pagecache_get_page);
 
+static inline struct page *find_get_entry(struct xa_state *xas, pgoff_t max,
+		xa_mark_t mark)
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
@@ -1868,42 +1905,21 @@ unsigned find_get_entries(struct address_space *mapping,
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
+	while ((page = find_get_entry(&xas, ULONG_MAX, XA_PRESENT))) {
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
@@ -1942,30 +1958,16 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 		return 0;
 
 	rcu_read_lock();
-	xas_for_each(&xas, page, end) {
-		if (xas_retry(&xas, page))
-			continue;
+	while ((page = find_get_entry(&xas, end, XA_PRESENT))) {
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
@@ -2065,9 +2067,7 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 		return 0;
 
 	rcu_read_lock();
-	xas_for_each_marked(&xas, page, end, tag) {
-		if (xas_retry(&xas, page))
-			continue;
+	while ((page = find_get_entry(&xas, end, tag))) {
 		/*
 		 * Shadow entries should never be tagged, but this iteration
 		 * is lockless so there is a window for page reclaim to evict
@@ -2076,23 +2076,11 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
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

