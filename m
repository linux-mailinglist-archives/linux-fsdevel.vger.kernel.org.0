Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B426161ACD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 19:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgBQSsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 13:48:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729897AbgBQSqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sD3WK8blKDBvHqnGFtSLkIMu7MQ1pNDfe0fQpuod3eg=; b=TSzeKvD/R0+qInKvOW0Z9NR8FI
        SjS8g/W6kCr1vojCeVDmW/rsDXq0PSrJhA6qfv2MrHnY6nSF+eehaMdOwfrABFEiRW7V1DONZjqJ+
        eAKWCtyr9tFuYqAwK3SgYhmo6IRTF2A5TeGtpJ8gnGJy/UleL1Y37j4hUsVtF5ZKToHYkrPVJUWZR
        oj3SE/bSHSbnLvrjHDb20NaQSmBE7u74peXxwIif6wsYrtMD6NAyV8/vOcmNp8IvOX1/11N3wjzXk
        r8wYKT6vbNZ+ZVJLxjNrrfML3cr/H7us0rQSDgN/ydRJJOQ683Dsp8vzcO66LRDQaRYwDIFaMjsX0
        rjXGVJZQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3lPL-00059T-KR; Mon, 17 Feb 2020 18:46:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v6 07/16] mm: Add page_cache_readahead_limit
Date:   Mon, 17 Feb 2020 10:45:51 -0800
Message-Id: <20200217184613.19668-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217184613.19668-1-willy@infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

ext4 and f2fs have duplicated the guts of the readahead code so
they can read past i_size.  Instead, separate out the guts of the
readahead code so they can call it directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/verity.c        | 35 ++-----------------------------
 fs/f2fs/verity.c        | 35 ++-----------------------------
 include/linux/pagemap.h |  4 ++++
 mm/readahead.c          | 46 +++++++++++++++++++++++++----------------
 4 files changed, 36 insertions(+), 84 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index dc5ec724d889..f6e0bf05933e 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -342,37 +342,6 @@ static int ext4_get_verity_descriptor(struct inode *inode, void *buf,
 	return desc_size;
 }
 
-/*
- * Prefetch some pages from the file's Merkle tree.
- *
- * This is basically a stripped-down version of __do_page_cache_readahead()
- * which works on pages past i_size.
- */
-static void ext4_merkle_tree_readahead(struct address_space *mapping,
-				       pgoff_t start_index, unsigned long count)
-{
-	LIST_HEAD(pages);
-	unsigned int nr_pages = 0;
-	struct page *page;
-	pgoff_t index;
-	struct blk_plug plug;
-
-	for (index = start_index; index < start_index + count; index++) {
-		page = xa_load(&mapping->i_pages, index);
-		if (!page || xa_is_value(page)) {
-			page = __page_cache_alloc(readahead_gfp_mask(mapping));
-			if (!page)
-				break;
-			page->index = index;
-			list_add(&page->lru, &pages);
-			nr_pages++;
-		}
-	}
-	blk_start_plug(&plug);
-	ext4_mpage_readpages(mapping, &pages, NULL, nr_pages, true);
-	blk_finish_plug(&plug);
-}
-
 static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
@@ -386,8 +355,8 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 		if (page)
 			put_page(page);
 		else if (num_ra_pages > 1)
-			ext4_merkle_tree_readahead(inode->i_mapping, index,
-						   num_ra_pages);
+			page_cache_readahead_limit(inode->i_mapping, NULL,
+					index, LONG_MAX, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index d7d430a6f130..71a3e36721fa 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -222,37 +222,6 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
 	return size;
 }
 
-/*
- * Prefetch some pages from the file's Merkle tree.
- *
- * This is basically a stripped-down version of __do_page_cache_readahead()
- * which works on pages past i_size.
- */
-static void f2fs_merkle_tree_readahead(struct address_space *mapping,
-				       pgoff_t start_index, unsigned long count)
-{
-	LIST_HEAD(pages);
-	unsigned int nr_pages = 0;
-	struct page *page;
-	pgoff_t index;
-	struct blk_plug plug;
-
-	for (index = start_index; index < start_index + count; index++) {
-		page = xa_load(&mapping->i_pages, index);
-		if (!page || xa_is_value(page)) {
-			page = __page_cache_alloc(readahead_gfp_mask(mapping));
-			if (!page)
-				break;
-			page->index = index;
-			list_add(&page->lru, &pages);
-			nr_pages++;
-		}
-	}
-	blk_start_plug(&plug);
-	f2fs_mpage_readpages(mapping, &pages, NULL, nr_pages, true);
-	blk_finish_plug(&plug);
-}
-
 static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
@@ -266,8 +235,8 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 		if (page)
 			put_page(page);
 		else if (num_ra_pages > 1)
-			f2fs_merkle_tree_readahead(inode->i_mapping, index,
-						   num_ra_pages);
+			page_cache_readahead_limit(inode->i_mapping, NULL,
+					index, LONG_MAX, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bd4291f78f41..4f36c06d064d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -389,6 +389,10 @@ extern struct page * read_cache_page_gfp(struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
 extern int read_cache_pages(struct address_space *mapping,
 		struct list_head *pages, filler_t *filler, void *data);
+void page_cache_readahead_limit(struct address_space *mapping,
+		struct file *file, pgoff_t offset, pgoff_t end_index,
+		unsigned long nr_to_read, unsigned long lookahead_size);
+
 
 static inline struct page *read_mapping_page(struct address_space *mapping,
 				pgoff_t index, void *data)
diff --git a/mm/readahead.c b/mm/readahead.c
index 5be7e1cb8666..566693f4e539 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -142,35 +142,21 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages)
 	blk_finish_plug(&plug);
 }
 
-/*
- * __do_page_cache_readahead() actually reads a chunk of disk.  It allocates
- * the pages first, then submits them for I/O. This avoids the very bad
- * behaviour which would occur if page allocations are causing VM writeback.
- * We really don't want to intermingle reads and writes like that.
- */
-void __do_page_cache_readahead(struct address_space *mapping,
-		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
-		unsigned long lookahead_size)
+void page_cache_readahead_limit(struct address_space *mapping,
+		struct file *file, pgoff_t offset, pgoff_t end_index,
+		unsigned long nr_to_read, unsigned long lookahead_size)
 {
-	struct inode *inode = mapping->host;
-	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
-	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	bool use_list = mapping->a_ops->readpages;
 	struct readahead_control rac = {
 		.mapping = mapping,
-		.file = filp,
+		.file = file,
 		._start = offset,
 		._nr_pages = 0,
 	};
 
-	if (isize == 0)
-		return;
-
-	end_index = ((isize - 1) >> PAGE_SHIFT);
-
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
@@ -225,6 +211,30 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		read_pages(&rac, &page_pool);
 	BUG_ON(!list_empty(&page_pool));
 }
+EXPORT_SYMBOL_GPL(page_cache_readahead_limit);
+
+/*
+ * __do_page_cache_readahead() actually reads a chunk of disk.  It allocates
+ * the pages first, then submits them for I/O. This avoids the very bad
+ * behaviour which would occur if page allocations are causing VM writeback.
+ * We really don't want to intermingle reads and writes like that.
+ */
+void __do_page_cache_readahead(struct address_space *mapping,
+		struct file *file, pgoff_t offset, unsigned long nr_to_read,
+		unsigned long lookahead_size)
+{
+	struct inode *inode = mapping->host;
+	unsigned long end_index;	/* The last page we want to read */
+	loff_t isize = i_size_read(inode);
+
+	if (isize == 0)
+		return;
+
+	end_index = ((isize - 1) >> PAGE_SHIFT);
+
+	page_cache_readahead_limit(mapping, file, offset, end_index,
+			nr_to_read, lookahead_size);
+}
 
 /*
  * Chunk the readahead into 2 megabyte units, so that we don't pin too much
-- 
2.25.0

