Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74A5298632
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 05:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422268AbgJZElf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 00:41:35 -0400
Received: from casper.infradead.org ([90.155.50.34]:60060 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421493AbgJZElf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 00:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DLWB4TNbNLy+vkO6OI9SCJlRakguX3c3DViMXWpue3Y=; b=YP8CA8T0rij4qO56RnbwxvhtfQ
        Ot5Cy3FbS062Jt0im9h7XCoMlLQkxBkqf4IWbY+x8qNyVKsWQhEytO4Q+86JuHwy9CnyUtck2xTBi
        SZ5C7nI+T9ysi5m+qSddHtAdsSEGvQNKqLaAowWFBxboDf3PgY8mREObTilfMMNhYV5vVrarkqX/g
        lPtWTaSjQjUkABJZx9Jo69qy+ExvRgnzOanbG3AZ1KkSrAKBQ52HdqIHfEOjSQ5lDCqwzVKsZW+d9
        1clJATtpMkWPRXo+cRNEMhuvJSS2+YAQu8+9Tw1bxPPubxcaVpI3CDjH+cSb/v7oJe9SxOpuiuRjR
        B/tZX1CA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWttb-0006a6-Eu; Mon, 26 Oct 2020 04:14:11 +0000
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
Subject: [PATCH v3 06/12] mm: Add an 'end' parameter to find_get_entries
Date:   Mon, 26 Oct 2020 04:14:02 +0000
Message-Id: <20201026041408.25230-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026041408.25230-1-willy@infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This simplifies the callers and leads to a more efficient implementation
since the XArray has this functionality already.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagemap.h |  4 ++--
 mm/filemap.c            |  9 +++++----
 mm/shmem.c              | 10 ++--------
 mm/swap.c               |  2 +-
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 5f3e829c91fd..5b425f666bc5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -450,8 +450,8 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 }
 
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
-			  unsigned int nr_entries, struct page **entries,
-			  pgoff_t *indices);
+		pgoff_t end, unsigned int nr_entries, struct page **entries,
+		pgoff_t *indices);
 unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 			pgoff_t end, unsigned int nr_pages,
 			struct page **pages);
diff --git a/mm/filemap.c b/mm/filemap.c
index 9a33d1b8cef6..6ed2422426d2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1897,6 +1897,7 @@ static inline struct page *xas_find_get_entry(struct xa_state *xas,
  * find_get_entries - gang pagecache lookup
  * @mapping:	The address_space to search
  * @start:	The starting page cache index
+ * @end:	The final page index (inclusive).
  * @nr_entries:	The maximum number of entries
  * @entries:	Where the resulting entries are placed
  * @indices:	The cache indices corresponding to the entries in @entries
@@ -1920,9 +1921,9 @@ static inline struct page *xas_find_get_entry(struct xa_state *xas,
  *
  * Return: the number of pages and shadow entries which were found.
  */
-unsigned find_get_entries(struct address_space *mapping,
-			  pgoff_t start, unsigned int nr_entries,
-			  struct page **entries, pgoff_t *indices)
+unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, unsigned int nr_entries, struct page **entries,
+		pgoff_t *indices)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct page *page;
@@ -1932,7 +1933,7 @@ unsigned find_get_entries(struct address_space *mapping,
 		return 0;
 
 	rcu_read_lock();
-	while ((page = xas_find_get_entry(&xas, ULONG_MAX, XA_PRESENT))) {
+	while ((page = xas_find_get_entry(&xas, end, XA_PRESENT))) {
 		/*
 		 * Terminate early on finding a THP, to allow the caller to
 		 * handle it all at once; but continue if this is hugetlbfs.
diff --git a/mm/shmem.c b/mm/shmem.c
index ef34271cad2d..27b93b738ea0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -913,8 +913,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			struct page *page = pvec.pages[i];
 
 			index = indices[i];
-			if (index >= end)
-				break;
 
 			if (xa_is_value(page)) {
 				if (unfalloc)
@@ -967,9 +965,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	while (index < end) {
 		cond_resched();
 
-		pvec.nr = find_get_entries(mapping, index,
-				min(end - index, (pgoff_t)PAGEVEC_SIZE),
-				pvec.pages, indices);
+		pvec.nr = find_get_entries(mapping, index, end - 1,
+				PAGEVEC_SIZE, pvec.pages, indices);
 		if (!pvec.nr) {
 			/* If all gone or hole-punch or unfalloc, we're done */
 			if (index == start || end != -1)
@@ -982,9 +979,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			struct page *page = pvec.pages[i];
 
 			index = indices[i];
-			if (index >= end)
-				break;
-
 			if (xa_is_value(page)) {
 				if (unfalloc)
 					continue;
diff --git a/mm/swap.c b/mm/swap.c
index 47a47681c86b..9b0836cda971 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1099,7 +1099,7 @@ unsigned pagevec_lookup_entries(struct pagevec *pvec,
 				pgoff_t start, unsigned nr_entries,
 				pgoff_t *indices)
 {
-	pvec->nr = find_get_entries(mapping, start, nr_entries,
+	pvec->nr = find_get_entries(mapping, start, ULONG_MAX, nr_entries,
 				    pvec->pages, indices);
 	return pagevec_count(pvec);
 }
-- 
2.28.0

