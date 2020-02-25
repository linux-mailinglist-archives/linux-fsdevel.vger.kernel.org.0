Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB55F16F1DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 22:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgBYVsn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 16:48:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgBYVsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XgY8GFf75p3YLN+Hw5vnX8X6TLIf5r8Gr1IURhlR+kg=; b=jxBNUe63XqDPF4hZSb6aYOHSed
        16i4Js+FT3c7Mp1+vXJGpgfe0jkB+Bl34Nh6dq8JH5ulPUVWYIu7ZoBQDcFcybdje1IF0Tw1atGA5
        LzomVASeIkXFNe2sxw7OVMJi5BvKTRhmwLbP6fSaJR3oE6+MKhneYMmkZ5V9TAI4P9pUG6NQpKyeT
        +oSYz6/PFJrFRmIHzFOWangZhpsM5qZdVvhuIUK+HMUqGatGp170Js9grPCySfHC7vTcteHrFt8VZ
        6VDMwyuP7ndyFHCR3RaWo5BhnzUQY9/CznMqBPYiydyM2yg0311XxMcJH38iwFTgZ812lskql8rQ4
        HgZV1P1w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6i4H-0007pf-53; Tue, 25 Feb 2020 21:48:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v8 07/25] mm: Rename various 'offset' parameters to 'index'
Date:   Tue, 25 Feb 2020 13:48:20 -0800
Message-Id: <20200225214838.30017-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225214838.30017-1-willy@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The word 'offset' is used ambiguously to mean 'byte offset within
a page', 'byte offset from the start of the file' and 'page offset
from the start of the file'.  Use 'index' to mean 'page offset
from the start of the file' throughout the readahead code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 86 ++++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 44 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 9d9aa4ffc7d4..8a65d6bd97e0 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -156,7 +156,7 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
  * We really don't want to intermingle reads and writes like that.
  */
 void __do_page_cache_readahead(struct address_space *mapping,
-		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
+		struct file *filp, pgoff_t index, unsigned long nr_to_read,
 		unsigned long lookahead_size)
 {
 	struct inode *inode = mapping->host;
@@ -180,7 +180,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 * Preallocate as many pages as we will need.
 	 */
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
-		pgoff_t page_offset = offset + page_idx;
+		pgoff_t page_offset = index + page_idx;
 
 		if (page_offset > end_index)
 			break;
@@ -219,7 +219,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
  * memory at once.
  */
 void force_page_cache_readahead(struct address_space *mapping,
-		struct file *filp, pgoff_t offset, unsigned long nr_to_read)
+		struct file *filp, pgoff_t index, unsigned long nr_to_read)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	struct file_ra_state *ra = &filp->f_ra;
@@ -239,9 +239,9 @@ void force_page_cache_readahead(struct address_space *mapping,
 
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
-		__do_page_cache_readahead(mapping, filp, offset, this_chunk, 0);
+		__do_page_cache_readahead(mapping, filp, index, this_chunk, 0);
 
-		offset += this_chunk;
+		index += this_chunk;
 		nr_to_read -= this_chunk;
 	}
 }
@@ -322,21 +322,21 @@ static unsigned long get_next_ra_size(struct file_ra_state *ra,
  */
 
 /*
- * Count contiguously cached pages from @offset-1 to @offset-@max,
+ * Count contiguously cached pages from @index-1 to @index-@max,
  * this count is a conservative estimation of
  * 	- length of the sequential read sequence, or
  * 	- thrashing threshold in memory tight systems
  */
 static pgoff_t count_history_pages(struct address_space *mapping,
-				   pgoff_t offset, unsigned long max)
+				   pgoff_t index, unsigned long max)
 {
 	pgoff_t head;
 
 	rcu_read_lock();
-	head = page_cache_prev_miss(mapping, offset - 1, max);
+	head = page_cache_prev_miss(mapping, index - 1, max);
 	rcu_read_unlock();
 
-	return offset - 1 - head;
+	return index - 1 - head;
 }
 
 /*
@@ -344,13 +344,13 @@ static pgoff_t count_history_pages(struct address_space *mapping,
  */
 static int try_context_readahead(struct address_space *mapping,
 				 struct file_ra_state *ra,
-				 pgoff_t offset,
+				 pgoff_t index,
 				 unsigned long req_size,
 				 unsigned long max)
 {
 	pgoff_t size;
 
-	size = count_history_pages(mapping, offset, max);
+	size = count_history_pages(mapping, index, max);
 
 	/*
 	 * not enough history pages:
@@ -363,10 +363,10 @@ static int try_context_readahead(struct address_space *mapping,
 	 * starts from beginning of file:
 	 * it is a strong indication of long-run stream (or whole-file-read)
 	 */
-	if (size >= offset)
+	if (size >= index)
 		size *= 2;
 
-	ra->start = offset;
+	ra->start = index;
 	ra->size = min(size + req_size, max);
 	ra->async_size = 1;
 
@@ -378,13 +378,13 @@ static int try_context_readahead(struct address_space *mapping,
  */
 static void ondemand_readahead(struct address_space *mapping,
 		struct file_ra_state *ra, struct file *filp,
-		bool hit_readahead_marker, pgoff_t offset,
+		bool hit_readahead_marker, pgoff_t index,
 		unsigned long req_size)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages = ra->ra_pages;
 	unsigned long add_pages;
-	pgoff_t prev_offset;
+	pgoff_t prev_index;
 
 	/*
 	 * If the request exceeds the readahead window, allow the read to
@@ -396,15 +396,15 @@ static void ondemand_readahead(struct address_space *mapping,
 	/*
 	 * start of file
 	 */
-	if (!offset)
+	if (!index)
 		goto initial_readahead;
 
 	/*
-	 * It's the expected callback offset, assume sequential access.
+	 * It's the expected callback index, assume sequential access.
 	 * Ramp up sizes, and push forward the readahead window.
 	 */
-	if ((offset == (ra->start + ra->size - ra->async_size) ||
-	     offset == (ra->start + ra->size))) {
+	if ((index == (ra->start + ra->size - ra->async_size) ||
+	     index == (ra->start + ra->size))) {
 		ra->start += ra->size;
 		ra->size = get_next_ra_size(ra, max_pages);
 		ra->async_size = ra->size;
@@ -421,14 +421,14 @@ static void ondemand_readahead(struct address_space *mapping,
 		pgoff_t start;
 
 		rcu_read_lock();
-		start = page_cache_next_miss(mapping, offset + 1, max_pages);
+		start = page_cache_next_miss(mapping, index + 1, max_pages);
 		rcu_read_unlock();
 
-		if (!start || start - offset > max_pages)
+		if (!start || start - index > max_pages)
 			return;
 
 		ra->start = start;
-		ra->size = start - offset;	/* old async_size */
+		ra->size = start - index;	/* old async_size */
 		ra->size += req_size;
 		ra->size = get_next_ra_size(ra, max_pages);
 		ra->async_size = ra->size;
@@ -443,29 +443,29 @@ static void ondemand_readahead(struct address_space *mapping,
 
 	/*
 	 * sequential cache miss
-	 * trivial case: (offset - prev_offset) == 1
-	 * unaligned reads: (offset - prev_offset) == 0
+	 * trivial case: (index - prev_index) == 1
+	 * unaligned reads: (index - prev_index) == 0
 	 */
-	prev_offset = (unsigned long long)ra->prev_pos >> PAGE_SHIFT;
-	if (offset - prev_offset <= 1UL)
+	prev_index = (unsigned long long)ra->prev_pos >> PAGE_SHIFT;
+	if (index - prev_index <= 1UL)
 		goto initial_readahead;
 
 	/*
 	 * Query the page cache and look for the traces(cached history pages)
 	 * that a sequential stream would leave behind.
 	 */
-	if (try_context_readahead(mapping, ra, offset, req_size, max_pages))
+	if (try_context_readahead(mapping, ra, index, req_size, max_pages))
 		goto readit;
 
 	/*
 	 * standalone, small random read
 	 * Read as is, and do not pollute the readahead state.
 	 */
-	__do_page_cache_readahead(mapping, filp, offset, req_size, 0);
+	__do_page_cache_readahead(mapping, filp, index, req_size, 0);
 	return;
 
 initial_readahead:
-	ra->start = offset;
+	ra->start = index;
 	ra->size = get_init_ra_size(req_size, max_pages);
 	ra->async_size = ra->size > req_size ? ra->size - req_size : ra->size;
 
@@ -476,7 +476,7 @@ static void ondemand_readahead(struct address_space *mapping,
 	 * the resulted next readahead window into the current one.
 	 * Take care of maximum IO pages as above.
 	 */
-	if (offset == ra->start && ra->size == ra->async_size) {
+	if (index == ra->start && ra->size == ra->async_size) {
 		add_pages = get_next_ra_size(ra, max_pages);
 		if (ra->size + add_pages <= max_pages) {
 			ra->async_size = add_pages;
@@ -495,9 +495,8 @@ static void ondemand_readahead(struct address_space *mapping,
  * @mapping: address_space which holds the pagecache and I/O vectors
  * @ra: file_ra_state which holds the readahead state
  * @filp: passed on to ->readpage() and ->readpages()
- * @offset: start offset into @mapping, in pagecache page-sized units
- * @req_size: hint: total size of the read which the caller is performing in
- *            pagecache pages
+ * @index: Index of first page to be read.
+ * @req_count: Total number of pages being read by the caller.
  *
  * page_cache_sync_readahead() should be called when a cache miss happened:
  * it will submit the read.  The readahead logic may decide to piggyback more
@@ -506,7 +505,7 @@ static void ondemand_readahead(struct address_space *mapping,
  */
 void page_cache_sync_readahead(struct address_space *mapping,
 			       struct file_ra_state *ra, struct file *filp,
-			       pgoff_t offset, unsigned long req_size)
+			       pgoff_t index, unsigned long req_count)
 {
 	/* no read-ahead */
 	if (!ra->ra_pages)
@@ -517,12 +516,12 @@ void page_cache_sync_readahead(struct address_space *mapping,
 
 	/* be dumb */
 	if (filp && (filp->f_mode & FMODE_RANDOM)) {
-		force_page_cache_readahead(mapping, filp, offset, req_size);
+		force_page_cache_readahead(mapping, filp, index, req_count);
 		return;
 	}
 
 	/* do read-ahead */
-	ondemand_readahead(mapping, ra, filp, false, offset, req_size);
+	ondemand_readahead(mapping, ra, filp, false, index, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_sync_readahead);
 
@@ -531,21 +530,20 @@ EXPORT_SYMBOL_GPL(page_cache_sync_readahead);
  * @mapping: address_space which holds the pagecache and I/O vectors
  * @ra: file_ra_state which holds the readahead state
  * @filp: passed on to ->readpage() and ->readpages()
- * @page: the page at @offset which has the PG_readahead flag set
- * @offset: start offset into @mapping, in pagecache page-sized units
- * @req_size: hint: total size of the read which the caller is performing in
- *            pagecache pages
+ * @page: The page at @index which triggered the readahead call.
+ * @index: Index of first page to be read.
+ * @req_count: Total number of pages being read by the caller.
  *
  * page_cache_async_readahead() should be called when a page is used which
- * has the PG_readahead flag; this is a marker to suggest that the application
+ * is marked as PageReadahead; this is a marker to suggest that the application
  * has used up enough of the readahead window that we should start pulling in
  * more pages.
  */
 void
 page_cache_async_readahead(struct address_space *mapping,
 			   struct file_ra_state *ra, struct file *filp,
-			   struct page *page, pgoff_t offset,
-			   unsigned long req_size)
+			   struct page *page, pgoff_t index,
+			   unsigned long req_count)
 {
 	/* no read-ahead */
 	if (!ra->ra_pages)
@@ -569,7 +567,7 @@ page_cache_async_readahead(struct address_space *mapping,
 		return;
 
 	/* do read-ahead */
-	ondemand_readahead(mapping, ra, filp, true, offset, req_size);
+	ondemand_readahead(mapping, ra, filp, true, index, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_readahead);
 
-- 
2.25.0

