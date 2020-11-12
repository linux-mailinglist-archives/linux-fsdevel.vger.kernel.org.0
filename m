Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007EB2B1042
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgKLV0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgKLV0t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:26:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A62C0613D1;
        Thu, 12 Nov 2020 13:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5OIezjcHLj22SXZWV7/dBe4YY1i3XFT69VqGISdM+r0=; b=bPUApHYocKNrU5GqwIQnYCMlhO
        mDe4dnD2N6Oj5DZ+MZO27jFmp50UQz3Ft0FF41chnTnlHRvhgecYHzKuNzjJtODTE07Ut+ko4t1wD
        mbJaP/l+5mTZ6gcTQ4IRwr2QPdNiN3xx7F4RQHN92D1l/gOrwxZXU9+/fNbdQdTSlrLtOFSZ/uvMJ
        /KZl2VVxw9+OBLwZhNgBILKMDT95+5Ux/DwU9nG9bfyhbqnNXSFcCW4GQORQPesO5h8Z5CVHO+rl7
        KJfAlq3SCFKRnvcFUaQRkLgq0TvnKgEvElWebZCaMDw/HaCCTxWyAJUwJ9zhOvQNaWap3V9YGQ3Cd
        kC3bvWAg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7D-0007Gk-Fx; Thu, 12 Nov 2020 21:26:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 09/16] mm: Add and use find_lock_entries
Date:   Thu, 12 Nov 2020 21:26:34 +0000
Message-Id: <20201112212641.27837-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
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
 mm/internal.h |  3 ++
 mm/shmem.c    | 22 +++----------
 mm/truncate.c | 91 +++++++--------------------------------------------
 4 files changed, 76 insertions(+), 97 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ef7411ea3f91..f18c5074865d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1925,6 +1925,63 @@ unsigned find_get_entries(struct address_space *mapping,
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
+	while ((page = find_get_entry(&xas, end, XA_PRESENT))) {
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
index 93880d460e12..3547fed59d51 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -60,6 +60,9 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 	force_page_cache_ra(&ractl, &file->f_ra, nr_to_read);
 }
 
+unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
+
 /**
  * page_evictable - test whether a page is evictable
  * @page: the page to test
diff --git a/mm/shmem.c b/mm/shmem.c
index 6afea99a0dc0..a4aa762a55f8 100644
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
index 960edf5803ca..eefd62898db1 100644
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
@@ -539,9 +507,7 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
 	int i;
 
 	pagevec_init(&pvec);
-	while (index <= end && pagevec_lookup_entries(&pvec, mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE - 1) + 1,
-			indices)) {
+	while (find_lock_entries(mapping, index, end, &pvec, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
@@ -555,39 +521,7 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
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
@@ -601,9 +535,6 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
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

