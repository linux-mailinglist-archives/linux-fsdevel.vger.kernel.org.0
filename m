Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E28C298633
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 05:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422270AbgJZElh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 00:41:37 -0400
Received: from casper.infradead.org ([90.155.50.34]:60070 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421493AbgJZElg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 00:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=e4FXtqfuCUGViBP5Rkju2Ey7iwc/YYNQDs91qQkDRLc=; b=NBdVZ0Ima1mHOQuNzV/DpcWYz/
        8lYx9OlJF0IZgo0p68XInbUT9vxN1gcZI9zu3O/1hcU35DvrqGQoREmihU2H/keME/NeAEWFLSN4d
        3bpqt0mMTbkE7xy/O8DBfktx47FU9YzzVI9b7fVz+KceZBFNPNM/TFhzpZ88L1cvXOjDSHPpLSgE5
        G6d2XcExIMZPrNKCGES2wSHzfNMPMhj6I5mSuUK5D8DS0K3syuo6oqZmHXT+4AfnYfpiWH+OGi2E4
        r3Q9wR3LBRItMmOiFQDoo98066pMXHqfWYNvbJFqklGpHbJgNZTJB/voJDQ4YBO2KrVR3FAI2uSV5
        IUzQHBJg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWttb-0006aA-Ll; Mon, 26 Oct 2020 04:14:11 +0000
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
Subject: [PATCH v3 07/12] mm: Add an 'end' parameter to pagevec_lookup_entries
Date:   Mon, 26 Oct 2020 04:14:03 +0000
Message-Id: <20201026041408.25230-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026041408.25230-1-willy@infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simplifies the callers and uses the existing functionality
in find_get_entries().  We can also drop the final argument of
truncate_exceptional_pvec_entries() and simplify the logic in that
function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagevec.h |  5 ++---
 mm/swap.c               |  8 ++++----
 mm/truncate.c           | 41 ++++++++++-------------------------------
 3 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 081d934eda64..4b245592262c 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -26,9 +26,8 @@ struct pagevec {
 void __pagevec_release(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
-				struct address_space *mapping,
-				pgoff_t start, unsigned nr_entries,
-				pgoff_t *indices);
+		struct address_space *mapping, pgoff_t start, pgoff_t end,
+		unsigned nr_entries, pgoff_t *indices);
 void pagevec_remove_exceptionals(struct pagevec *pvec);
 unsigned pagevec_lookup_range(struct pagevec *pvec,
 			      struct address_space *mapping,
diff --git a/mm/swap.c b/mm/swap.c
index 9b0836cda971..d4d0c54d6ec9 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1075,6 +1075,7 @@ void __pagevec_lru_add(struct pagevec *pvec)
  * @pvec:	Where the resulting entries are placed
  * @mapping:	The address_space to search
  * @start:	The starting entry index
+ * @end:	The highest index to return (inclusive).
  * @nr_entries:	The maximum number of pages
  * @indices:	The cache indices corresponding to the entries in @pvec
  *
@@ -1095,11 +1096,10 @@ void __pagevec_lru_add(struct pagevec *pvec)
  * found.
  */
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
-				struct address_space *mapping,
-				pgoff_t start, unsigned nr_entries,
-				pgoff_t *indices)
+		struct address_space *mapping, pgoff_t start, pgoff_t end,
+		unsigned nr_entries, pgoff_t *indices)
 {
-	pvec->nr = find_get_entries(mapping, start, ULONG_MAX, nr_entries,
+	pvec->nr = find_get_entries(mapping, start, end, nr_entries,
 				    pvec->pages, indices);
 	return pagevec_count(pvec);
 }
diff --git a/mm/truncate.c b/mm/truncate.c
index 3c6b6d5a0046..ec43312f4756 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -57,11 +57,10 @@ static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
  * exceptional entries similar to what pagevec_remove_exceptionals does.
  */
 static void truncate_exceptional_pvec_entries(struct address_space *mapping,
-				struct pagevec *pvec, pgoff_t *indices,
-				pgoff_t end)
+				struct pagevec *pvec, pgoff_t *indices)
 {
 	int i, j;
-	bool dax, lock;
+	bool dax;
 
 	/* Handled by shmem itself */
 	if (shmem_mapping(mapping))
@@ -75,8 +74,7 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 		return;
 
 	dax = dax_mapping(mapping);
-	lock = !dax && indices[j] < end;
-	if (lock)
+	if (!dax)
 		xa_lock_irq(&mapping->i_pages);
 
 	for (i = j; i < pagevec_count(pvec); i++) {
@@ -88,9 +86,6 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 			continue;
 		}
 
-		if (index >= end)
-			continue;
-
 		if (unlikely(dax)) {
 			dax_delete_mapping_entry(mapping, index);
 			continue;
@@ -99,7 +94,7 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 		__clear_shadow_entry(mapping, index, page);
 	}
 
-	if (lock)
+	if (!dax)
 		xa_unlock_irq(&mapping->i_pages);
 	pvec->nr = j;
 }
@@ -329,7 +324,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	while (index < end && find_lock_entries(mapping, index, end - 1,
 			&pvec, indices)) {
 		index = indices[pagevec_count(&pvec) - 1] + 1;
-		truncate_exceptional_pvec_entries(mapping, &pvec, indices, end);
+		truncate_exceptional_pvec_entries(mapping, &pvec, indices);
 		for (i = 0; i < pagevec_count(&pvec); i++)
 			truncate_cleanup_page(mapping, pvec.pages[i]);
 		delete_from_page_cache_batch(mapping, &pvec);
@@ -381,8 +376,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	index = start;
 	for ( ; ; ) {
 		cond_resched();
-		if (!pagevec_lookup_entries(&pvec, mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE), indices)) {
+		if (!pagevec_lookup_entries(&pvec, mapping, index, end - 1,
+				PAGEVEC_SIZE, indices)) {
 			/* If all gone from start onwards, we're done */
 			if (index == start)
 				break;
@@ -390,23 +385,12 @@ void truncate_inode_pages_range(struct address_space *mapping,
 			index = start;
 			continue;
 		}
-		if (index == start && indices[0] >= end) {
-			/* All gone out of hole to be punched, we're done */
-			pagevec_remove_exceptionals(&pvec);
-			pagevec_release(&pvec);
-			break;
-		}
 
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
-			if (index >= end) {
-				/* Restart punch to make sure all gone */
-				index = start - 1;
-				break;
-			}
 
 			if (xa_is_value(page))
 				continue;
@@ -417,7 +401,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 			truncate_inode_page(mapping, page);
 			unlock_page(page);
 		}
-		truncate_exceptional_pvec_entries(mapping, &pvec, indices, end);
+		truncate_exceptional_pvec_entries(mapping, &pvec, indices);
 		pagevec_release(&pvec);
 		index++;
 	}
@@ -513,8 +497,6 @@ unsigned long __invalidate_mapping_pages(struct address_space *mapping,
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
-			if (index > end)
-				break;
 
 			if (xa_is_value(page)) {
 				invalidate_exceptional_entry(mapping, index,
@@ -650,16 +632,13 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (index <= end && pagevec_lookup_entries(&pvec, mapping, index,
-			min(end - index, (pgoff_t)PAGEVEC_SIZE - 1) + 1,
-			indices)) {
+	while (pagevec_lookup_entries(&pvec, mapping, index, end,
+			PAGEVEC_SIZE, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
 			/* We rely upon deletion not changing page->index */
 			index = indices[i];
-			if (index > end)
-				break;
 
 			if (xa_is_value(page)) {
 				if (!invalidate_exceptional_entry2(mapping,
-- 
2.28.0

