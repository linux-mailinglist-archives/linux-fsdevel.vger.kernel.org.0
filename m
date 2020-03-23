Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5AD18FF0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 21:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgCWUXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 16:23:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgCWUXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ykZ7IuC8advQejUJ0lOkRVAnnG5oVVkFQ9dbVDPkTN8=; b=sybOeWeiTrkmw1qiW786U7mK5L
        Myre1Zl/ePlzyA9y6wyEzWqxZFL9JL76EBnfU5uaFs43nfh9nKKwx/SNKtof1+zw4RAz/qc2r1Ai4
        g7e01QA0ej9GIFOpZbUvvjeF8xhZxlHRLlqRk8z6Bd6wMY23J0NFdQZS+bkJ9YU4Yo/kbVNW1lp8a
        rm5A4g+juf0RuDivldfrwVj5jJZmcnbf0eGecxHHejiyGSEkZj0wwziSTQb2JISxbI3ebBSxFUqlQ
        c+SRmziYTFEpbGZv8fK5bUnafUAIl3eTk/SBYZvTMJgnZsJKZ97uvQgRK9+wntRcA8Vjviw5ybh2o
        MwKioJRg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGTbB-0003VH-Ps; Mon, 23 Mar 2020 20:23:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        William Kucharski <william.kucharski@oracle.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v10 13/25] mm: Add page_cache_readahead_unbounded
Date:   Mon, 23 Mar 2020 13:22:47 -0700
Message-Id: <20200323202259.13363-14-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200323202259.13363-1-willy@infradead.org>
References: <20200323202259.13363-1-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Tested-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/verity.c        | 35 ++-------------------
 fs/f2fs/data.c          |  2 +-
 fs/f2fs/f2fs.h          |  3 --
 fs/f2fs/verity.c        | 35 ++-------------------
 include/linux/pagemap.h |  3 ++
 mm/readahead.c          | 68 ++++++++++++++++++++++++++++-------------
 6 files changed, 55 insertions(+), 91 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index dc5ec724d889..dec1244dd062 100644
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
+			page_cache_readahead_unbounded(inode->i_mapping, NULL,
+					index, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dbde309349d0..adc4766782e1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2148,7 +2148,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
  * use ->readpage() or do the necessary surgery to decouple ->readpages()
  * from read-ahead.
  */
-int f2fs_mpage_readpages(struct address_space *mapping,
+static int f2fs_mpage_readpages(struct address_space *mapping,
 			struct list_head *pages, struct page *page,
 			unsigned nr_pages, bool is_readahead)
 {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3e727a6af08e..d59b715d7870 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3369,9 +3369,6 @@ int f2fs_reserve_new_block(struct dnode_of_data *dn);
 int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index);
 int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from);
 int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index);
-int f2fs_mpage_readpages(struct address_space *mapping,
-			struct list_head *pages, struct page *page,
-			unsigned nr_pages, bool is_readahead);
 struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
 			int op_flags, bool for_write);
 struct page *f2fs_find_data_page(struct inode *inode, pgoff_t index);
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index d7d430a6f130..865c9fb774fb 100644
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
+			page_cache_readahead_unbounded(inode->i_mapping, NULL,
+					index, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 89fd6a62bfa5..84e1bd68fda4 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -619,6 +619,9 @@ void page_cache_sync_readahead(struct address_space *, struct file_ra_state *,
 void page_cache_async_readahead(struct address_space *, struct file_ra_state *,
 		struct file *, struct page *, pgoff_t index,
 		unsigned long req_count);
+void page_cache_readahead_unbounded(struct address_space *, struct file *,
+		pgoff_t index, unsigned long nr_to_read,
+		unsigned long lookahead_count);
 
 /*
  * Like add_to_page_cache_locked, but used to add newly allocated pages:
diff --git a/mm/readahead.c b/mm/readahead.c
index 998fdd23c0b1..ae231a5312cb 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -156,37 +156,34 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 		rac->_index++;
 }
 
-/*
- * __do_page_cache_readahead() actually reads a chunk of disk.  It allocates
- * the pages first, then submits them for I/O. This avoids the very bad
- * behaviour which would occur if page allocations are causing VM writeback.
- * We really don't want to intermingle reads and writes like that.
+/**
+ * page_cache_readahead_unbounded - Start unchecked readahead.
+ * @mapping: File address space.
+ * @file: This instance of the open file; used for authentication.
+ * @index: First page index to read.
+ * @nr_to_read: The number of pages to read.
+ * @lookahead_size: Where to start the next readahead.
+ *
+ * This function is for filesystems to call when they want to start
+ * readahead beyond a file's stated i_size.  This is almost certainly
+ * not the function you want to call.  Use page_cache_async_readahead()
+ * or page_cache_sync_readahead() instead.
+ *
+ * Context: File is referenced by caller.  Mutexes may be held by caller.
+ * May sleep, but will not reenter filesystem to reclaim memory.
  */
-void __do_page_cache_readahead(struct address_space *mapping,
-		struct file *filp, pgoff_t index, unsigned long nr_to_read,
+void page_cache_readahead_unbounded(struct address_space *mapping,
+		struct file *file, pgoff_t index, unsigned long nr_to_read,
 		unsigned long lookahead_size)
 {
-	struct inode *inode = mapping->host;
 	LIST_HEAD(page_pool);
-	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	struct readahead_control rac = {
 		.mapping = mapping,
-		.file = filp,
+		.file = file,
 		._index = index,
 	};
 	unsigned long i;
-	pgoff_t end_index;	/* The last page we want to read */
-
-	if (isize == 0)
-		return;
-
-	end_index = (isize - 1) >> PAGE_SHIFT;
-	if (index > end_index)
-		return;
-	/* Don't read past the page containing the last byte of the file */
-	if (nr_to_read > end_index - index)
-		nr_to_read = end_index - index + 1;
 
 	/*
 	 * Preallocate as many pages as we will need.
@@ -230,6 +227,35 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 */
 	read_pages(&rac, &page_pool, false);
 }
+EXPORT_SYMBOL_GPL(page_cache_readahead_unbounded);
+
+/*
+ * __do_page_cache_readahead() actually reads a chunk of disk.  It allocates
+ * the pages first, then submits them for I/O. This avoids the very bad
+ * behaviour which would occur if page allocations are causing VM writeback.
+ * We really don't want to intermingle reads and writes like that.
+ */
+void __do_page_cache_readahead(struct address_space *mapping,
+		struct file *file, pgoff_t index, unsigned long nr_to_read,
+		unsigned long lookahead_size)
+{
+	struct inode *inode = mapping->host;
+	loff_t isize = i_size_read(inode);
+	pgoff_t end_index;	/* The last page we want to read */
+
+	if (isize == 0)
+		return;
+
+	end_index = (isize - 1) >> PAGE_SHIFT;
+	if (index > end_index)
+		return;
+	/* Don't read past the page containing the last byte of the file */
+	if (nr_to_read > end_index - index)
+		nr_to_read = end_index - index + 1;
+
+	page_cache_readahead_unbounded(mapping, file, index, nr_to_read,
+			lookahead_size);
+}
 
 /*
  * Chunk the readahead into 2 megabyte units, so that we don't pin too much
-- 
2.25.1

