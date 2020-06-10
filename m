Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4088E1F5C8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgFJUOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbgFJUNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A60C0085C4;
        Wed, 10 Jun 2020 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=idZKdA+QYZwMV+ZxoObzC46KdDw/yL2GIOrIWkTdIjI=; b=gzslWAeUZmmexSew2yt137OmdW
        SShvLXnxZK86Ft60vuDRgPt0P8y4I//kQLT5EG7MFMSQgA3iucbKNx2juCELExXL6vasD4C+IDXCh
        3X6q8ZmXRGOfgaTTh/q7ltSxC5RQKBNf48oSlJEViO4tanp/94VI27uxgj3cgI2XQbn6+Bu1TNKv4
        spLvOhlXgjdXxukuXE5Qyb/PnT6EOYftHFGn4VW5aYrSK0EREMv6eEp+U6s/Su88Ba+RgDBRkWwqr
        4fgxb+B6dG8U/o0cmnzAmlTwAXDlaPtv4fKPh8GsRo2fFKGeWE/4gdQVFFmVrWHvJicmlL5sqTid3
        slY27qOQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76b-0003Y5-6e; Wed, 10 Jun 2020 20:13:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 47/51] mm: Make page_cache_readahead_unbounded take a readahead_control
Date:   Wed, 10 Jun 2020 13:13:41 -0700
Message-Id: <20200610201345.13273-48-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Define it in the callers instead of in page_cache_readahead_unbounded().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/verity.c        |  4 ++--
 fs/f2fs/verity.c        |  4 ++--
 include/linux/pagemap.h |  5 ++---
 mm/readahead.c          | 26 ++++++++++++--------------
 4 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index dec1244dd062..fe2e541543da 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -346,6 +346,7 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
 {
+	DEFINE_READAHEAD(rac, NULL, inode->i_mapping, index);
 	struct page *page;
 
 	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
@@ -355,8 +356,7 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 		if (page)
 			put_page(page);
 		else if (num_ra_pages > 1)
-			page_cache_readahead_unbounded(inode->i_mapping, NULL,
-					index, num_ra_pages, 0);
+			page_cache_readahead_unbounded(&rac, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 865c9fb774fb..707a94745472 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -226,6 +226,7 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
 {
+	DEFINE_READAHEAD(rac, NULL, inode->i_mapping, index);
 	struct page *page;
 
 	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
@@ -235,8 +236,7 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 		if (page)
 			put_page(page);
 		else if (num_ra_pages > 1)
-			page_cache_readahead_unbounded(inode->i_mapping, NULL,
-					index, num_ra_pages, 0);
+			page_cache_readahead_unbounded(&rac, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 77c20da5ae99..f36714473b1e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -715,9 +715,8 @@ void page_cache_sync_readahead(struct address_space *, struct file_ra_state *,
 void page_cache_async_readahead(struct address_space *, struct file_ra_state *,
 		struct file *, struct page *, pgoff_t index,
 		unsigned long req_count);
-void page_cache_readahead_unbounded(struct address_space *, struct file *,
-		pgoff_t index, unsigned long nr_to_read,
-		unsigned long lookahead_count);
+void page_cache_readahead_unbounded(struct readahead_control *,
+		unsigned long nr_to_read, unsigned long lookahead_count);
 
 /*
  * Like add_to_page_cache_locked, but used to add newly allocated pages:
diff --git a/mm/readahead.c b/mm/readahead.c
index 2126a2754e22..62da2d4beed1 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -159,9 +159,7 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 
 /**
  * page_cache_readahead_unbounded - Start unchecked readahead.
- * @mapping: File address space.
- * @file: This instance of the open file; used for authentication.
- * @index: First page index to read.
+ * @rac: Readahead control.
  * @nr_to_read: The number of pages to read.
  * @lookahead_size: Where to start the next readahead.
  *
@@ -173,13 +171,13 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
  * Context: File is referenced by caller.  Mutexes may be held by caller.
  * May sleep, but will not reenter filesystem to reclaim memory.
  */
-void page_cache_readahead_unbounded(struct address_space *mapping,
-		struct file *file, pgoff_t index, unsigned long nr_to_read,
-		unsigned long lookahead_size)
+void page_cache_readahead_unbounded(struct readahead_control *rac,
+		unsigned long nr_to_read, unsigned long lookahead_size)
 {
+	struct address_space *mapping = rac->mapping;
+	unsigned long index = readahead_index(rac);
 	LIST_HEAD(page_pool);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	DEFINE_READAHEAD(rac, file, mapping, index);
 	unsigned long i;
 
 	/*
@@ -200,7 +198,7 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 	for (i = 0; i < nr_to_read; i++) {
 		struct page *page = xa_load(&mapping->i_pages, index + i);
 
-		BUG_ON(index + i != rac._index + rac._nr_pages);
+		BUG_ON(index + i != rac->_index + rac->_nr_pages);
 
 		if (page && !xa_is_value(page)) {
 			/*
@@ -211,7 +209,7 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 			 * have a stable reference to this page, and it's
 			 * not worth getting one just for that.
 			 */
-			read_pages(&rac, &page_pool, true);
+			read_pages(rac, &page_pool, true);
 			continue;
 		}
 
@@ -224,12 +222,12 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 		} else if (add_to_page_cache_lru(page, mapping, index + i,
 					gfp_mask) < 0) {
 			put_page(page);
-			read_pages(&rac, &page_pool, true);
+			read_pages(rac, &page_pool, true);
 			continue;
 		}
 		if (i == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
-		rac._nr_pages++;
+		rac->_nr_pages++;
 	}
 
 	/*
@@ -237,7 +235,7 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 	 * uptodate then the caller will launch readpage again, and
 	 * will then handle the error.
 	 */
-	read_pages(&rac, &page_pool, false);
+	read_pages(rac, &page_pool, false);
 	memalloc_nofs_restore(nofs);
 }
 EXPORT_SYMBOL_GPL(page_cache_readahead_unbounded);
@@ -252,6 +250,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		struct file *file, pgoff_t index, unsigned long nr_to_read,
 		unsigned long lookahead_size)
 {
+	DEFINE_READAHEAD(rac, file, mapping, index);
 	struct inode *inode = mapping->host;
 	loff_t isize = i_size_read(inode);
 	pgoff_t end_index;	/* The last page we want to read */
@@ -266,8 +265,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	if (nr_to_read > end_index - index)
 		nr_to_read = end_index - index + 1;
 
-	page_cache_readahead_unbounded(mapping, file, index, nr_to_read,
-			lookahead_size);
+	page_cache_readahead_unbounded(&rac, nr_to_read, lookahead_size);
 }
 
 /*
-- 
2.26.2

