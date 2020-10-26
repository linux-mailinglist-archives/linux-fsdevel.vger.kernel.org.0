Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE2329862F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 05:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422260AbgJZEla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 00:41:30 -0400
Received: from casper.infradead.org ([90.155.50.34]:60050 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421493AbgJZEla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 00:41:30 -0400
X-Greylist: delayed 1638 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 00:41:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=D4HUkF63j7GrFkU84geEXagljZ4wF1EtZdc5p5/p3pw=; b=EGs1p8sFgOKa6qgZad9xlY0Cju
        i1oJNd/8uuYAxaImSQmGz4DGuVqT09wW762qsH/nnroe2ZS0R1o26nrzOdp2FVfx0VHNWzG/8TlRm
        jwXNvNwf+Xe6k88yOc5VJ6DpiuZZdSJz1zVVzZvaQfxSVH8V8ZVeFfo4QSDQVwPjuSlUdB+skjl7U
        dIw0m+gE/vDoQz03YAYSi0TIc/dV1zgAEeFTak4YvqwZTzww0ZpUm1dxlUCQuyDD9YY2S1kpQG7OY
        WA8lbigI6x04OVb29uo675bCb7Yt+3yKRDBV3RQWa0/1XOTbTD03ESIHQKtDDtXsFBtrvj0uDXmCN
        eDr4RiRA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWttb-0006a3-8x; Mon, 26 Oct 2020 04:14:11 +0000
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
Subject: [PATCH v3 05/12] mm: Add and use find_lock_entries
Date:   Mon, 26 Oct 2020 04:14:01 +0000
Message-Id: <20201026041408.25230-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026041408.25230-1-willy@infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have three functions (shmem_undo_range(), truncate_inode_pages_range()
and invalidate_mapping_pages()) which want exactly this function,
so add it to filemap.c.  Before this patch, shmem_undo_range() would
split any compound page which overlaps either end of the range being
punched in both the first and second loops through the address space.
After this patch, that functionality is left for the second loop, which
is arguably more appropriate since the first loop is supposed to run
through all the pages quickly, and splitting a page can sleep.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/filemap.c  | 57 ++++++++++++++++++++++++++++++++
 mm/internal.h |  2 ++
 mm/shmem.c    | 22 +++----------
 mm/truncate.c | 91 +++++++--------------------------------------------
 4 files changed, 75 insertions(+), 97 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3a55d258d9f2..9a33d1b8cef6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1952,6 +1952,63 @@ unsigned find_get_entries(struct address_space *mapping,
 	return ret;
 }
 
+/**
+ * find_lock_entries - Find a batch of pagecache entries.
+ * @mapping:	The address_space to search.
+ * @start:	The starting page cache index.
+ * @end:	The final page index (inclusive).
+ * @pvec:	Where the resulting entries are placed.
+ * @indices:	The cache indices of the entries in @pvec.
+ *
+ * find_lock_entries() will return a batch of entries from @mapping.
+ * Swap, shadow and DAX entries are included.  Pages are returned
+ * locked and with an incremented refcount.  Pages which are locked by
+ * somebody else or under writeback are skipped.  Only the head page of
+ * a THP is returned.  Pages which are partially outside the range are
+ * not returned.
+ *
+ * The entries have ascending indexes.  The indices may not be consecutive
+ * due to not-present entries, THP pages, pages which could not be locked
+ * or pages under writeback.
+ *
+ * Return: The number of entries which were found.
+ */
+unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices)
+{
+	XA_STATE(xas, &mapping->i_pages, start);
+	struct page *page;
+
+	rcu_read_lock();
+	while ((page = xas_find_get_entry(&xas, end, XA_PRESENT))) {
+		if (!xa_is_value(page)) {
+			if (page->index < start)
+				goto put;
+			VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
+			if (page->index + thp_nr_pages(page) - 1 > end)
+				goto put;
+			if (!trylock_page(page))
+				goto put;
+			if (page->mapping != mapping || PageWriteback(page))
+				goto unlock;
+		}
+		indices[pvec->nr] = xas.xa_index;
+		if (!pagevec_add(pvec, page))
+			break;
+		goto next;
+unlock:
+		unlock_page(page);
+put:
+		put_page(page);
+next:
+		if (!xa_is_value(page) && PageTransHuge(page))
+			xas_set(&xas, page->index + thp_nr_pages(page));
+	}
+	rcu_read_unlock();
+
+	return pagevec_count(pvec);
+}
+
 /**
  * find_get_pages_range - gang pagecache lookup
  * @mapping:	The address_space to search
diff --git a/mm/internal.h b/mm/internal.h
index c43ccdddb0f6..8d79f4d21eaf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -62,6 +62,8 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 
 struct page *find_get_entry(struct address_space *mapping, pgoff_t index);
 struct page *find_lock_entry(struct address_space *mapping, pgoff_t index);
+unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
 
 /**
  * page_evictable - test whether a page is evictable
diff --git a/mm/shmem.c b/mm/shmem.c
index 726cede653f5..ef34271cad2d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -907,12 +907,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (index < end) {
-		pvec.nr = find_get_entries(mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE),
-			pvec.pages, indices);
-		if (!pvec.nr)
-			break;
+	while (index < end && find_lock_entries(mapping, index, end - 1,
+			&pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
@@ -927,18 +923,10 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 								index, page);
 				continue;
 			}
+			index += thp_nr_pages(page) - 1;
 
-			VM_BUG_ON_PAGE(page_to_pgoff(page) != index, page);
-
-			if (!trylock_page(page))
-				continue;
-
-			if ((!unfalloc || !PageUptodate(page)) &&
-			    page_mapping(page) == mapping) {
-				VM_BUG_ON_PAGE(PageWriteback(page), page);
-				if (shmem_punch_compound(page, start, end))
-					truncate_inode_page(mapping, page);
-			}
+			if (!unfalloc || !PageUptodate(page))
+				truncate_inode_page(mapping, page);
 			unlock_page(page);
 		}
 		pagevec_remove_exceptionals(&pvec);
diff --git a/mm/truncate.c b/mm/truncate.c
index 18cec39a9f53..3c6b6d5a0046 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -326,51 +326,19 @@ void truncate_inode_pages_range(struct address_space *mapping,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (index < end && pagevec_lookup_entries(&pvec, mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE),
-			indices)) {
-		/*
-		 * Pagevec array has exceptional entries and we may also fail
-		 * to lock some pages. So we store pages that can be deleted
-		 * in a new pagevec.
-		 */
-		struct pagevec locked_pvec;
-
-		pagevec_init(&locked_pvec);
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
-
-			/* We rely upon deletion not changing page->index */
-			index = indices[i];
-			if (index >= end)
-				break;
-
-			if (xa_is_value(page))
-				continue;
-
-			if (!trylock_page(page))
-				continue;
-			WARN_ON(page_to_index(page) != index);
-			if (PageWriteback(page)) {
-				unlock_page(page);
-				continue;
-			}
-			if (page->mapping != mapping) {
-				unlock_page(page);
-				continue;
-			}
-			pagevec_add(&locked_pvec, page);
-		}
-		for (i = 0; i < pagevec_count(&locked_pvec); i++)
-			truncate_cleanup_page(mapping, locked_pvec.pages[i]);
-		delete_from_page_cache_batch(mapping, &locked_pvec);
-		for (i = 0; i < pagevec_count(&locked_pvec); i++)
-			unlock_page(locked_pvec.pages[i]);
+	while (index < end && find_lock_entries(mapping, index, end - 1,
+			&pvec, indices)) {
+		index = indices[pagevec_count(&pvec) - 1] + 1;
 		truncate_exceptional_pvec_entries(mapping, &pvec, indices, end);
+		for (i = 0; i < pagevec_count(&pvec); i++)
+			truncate_cleanup_page(mapping, pvec.pages[i]);
+		delete_from_page_cache_batch(mapping, &pvec);
+		for (i = 0; i < pagevec_count(&pvec); i++)
+			unlock_page(pvec.pages[i]);
 		pagevec_release(&pvec);
 		cond_resched();
-		index++;
 	}
+
 	if (partial_start) {
 		struct page *page = find_lock_page(mapping, start - 1);
 		if (page) {
@@ -539,9 +507,7 @@ unsigned long __invalidate_mapping_pages(struct address_space *mapping,
 	int i;
 
 	pagevec_init(&pvec);
-	while (index <= end && pagevec_lookup_entries(&pvec, mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE - 1) + 1,
-			indices)) {
+	while (find_lock_entries(mapping, index, end, &pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
@@ -555,39 +521,7 @@ unsigned long __invalidate_mapping_pages(struct address_space *mapping,
 							     page);
 				continue;
 			}
-
-			if (!trylock_page(page))
-				continue;
-
-			WARN_ON(page_to_index(page) != index);
-
-			/* Middle of THP: skip */
-			if (PageTransTail(page)) {
-				unlock_page(page);
-				continue;
-			} else if (PageTransHuge(page)) {
-				index += HPAGE_PMD_NR - 1;
-				i += HPAGE_PMD_NR - 1;
-				/*
-				 * 'end' is in the middle of THP. Don't
-				 * invalidate the page as the part outside of
-				 * 'end' could be still useful.
-				 */
-				if (index > end) {
-					unlock_page(page);
-					continue;
-				}
-
-				/* Take a pin outside pagevec */
-				get_page(page);
-
-				/*
-				 * Drop extra pins before trying to invalidate
-				 * the huge page.
-				 */
-				pagevec_remove_exceptionals(&pvec);
-				pagevec_release(&pvec);
-			}
+			index += thp_nr_pages(page) - 1;
 
 			ret = invalidate_inode_page(page);
 			unlock_page(page);
@@ -601,9 +535,6 @@ unsigned long __invalidate_mapping_pages(struct address_space *mapping,
 				if (nr_pagevec)
 					(*nr_pagevec)++;
 			}
-
-			if (PageTransHuge(page))
-				put_page(page);
 			count += ret;
 		}
 		pagevec_remove_exceptionals(&pvec);
-- 
2.28.0

