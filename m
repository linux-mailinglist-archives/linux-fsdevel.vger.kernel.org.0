Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A4C2DC667
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgLPSZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgLPSZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCCDC0619D2;
        Wed, 16 Dec 2020 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hJJpZniMODn0WymmDf4Q6ePoCmmJmVMEtNeXgNGd/Es=; b=QuMkGpWb9FzQ0x5jeJbt0+QvEp
        uUlujQ9FhhhOgIat/85yFWZmnRKmG85I+9P50Om1bCIOc5pA37UlvD32CZ7+SNvzFmnV0w4UCt1gP
        Part5fmRaELWWVWQ6r3dmTZurtxfMW3MvhdMtECE1swr4giyugQ23Ye465wRzAYX2m8FrLiiWa7ii
        B0tU+riFzp6CEF0/HfFGd3GTi0AYHb2zxhwdT1gGYBHngO/77XkrdzmNWpQxIQRo6L6WuRT7boarm
        xtuKrgMKgaOAk4e7HYiWVUHrqPVqklBKgthYxBsGCgbQWQ8+EnMaYl2bh13lRXzOnQ+4o0xKypH8Q
        bLMkMIzw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSh-00078V-7u; Wed, 16 Dec 2020 18:23:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/25] fs: Change page refcount rules for readahead
Date:   Wed, 16 Dec 2020 18:23:29 +0000
Message-Id: <20201216182335.27227-20-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This brings ->readahead into line with ->readpage for the refcount on
struct page.  It simplifies the various filesystems which implement
readahead and will reduce the number of atomic operations on the page
refcount in the future.  This change is combined with the conversion of
readahead to use the struct folio in order to make unconverted filesystems
fail to compile.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/porting.rst |  8 ++++
 Documentation/filesystems/vfs.rst     | 17 ++++-----
 fs/btrfs/extent_io.c                  | 13 +++----
 fs/erofs/data.c                       |  9 ++---
 fs/erofs/zdata.c                      |  5 ++-
 fs/ext4/readpage.c                    | 11 ++----
 fs/f2fs/data.c                        |  9 +----
 fs/fuse/file.c                        |  4 +-
 fs/iomap/buffered-io.c                |  4 +-
 fs/mpage.c                            |  3 +-
 include/linux/pagemap.h               | 55 +++++++++++++--------------
 mm/readahead.c                        | 18 ++++-----
 12 files changed, 72 insertions(+), 84 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 867036aa90b8..0580f69a5e8f 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -865,3 +865,11 @@ no matter what.  Everything is handled by the caller.
 
 clone_private_mount() returns a longterm mount now, so the proper destructor of
 its result is kern_unmount() or kern_unmount_array().
+
+---
+
+**mandatory**
+
+->readahead() has changed the reference count on struct page so that
+the filesystem *does not* drop a reference.  This is in line with how
+->readpage works but different from how ->readpages used to work.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index ca52c82e5bb5..5ac42b93225c 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -784,15 +784,14 @@ cache in your filesystem.  The following members are defined:
 
 ``readahead``
 	Called by the VM to read pages associated with the address_space
-	object.  The pages are consecutive in the page cache and are
-	locked.  The implementation should decrement the page refcount
-	after starting I/O on each page.  Usually the page will be
-	unlocked by the I/O completion handler.  If the filesystem decides
-	to stop attempting I/O before reaching the end of the readahead
-	window, it can simply return.  The caller will decrement the page
-	refcount and unlock the remaining pages for you.  Set PageUptodate
-	if the I/O completes successfully.  Setting PageError on any page
-	will be ignored; simply unlock the page if an I/O error occurs.
+	object.  The pages are consecutive in the page cache and
+	are locked.  Usually the page will be unlocked by the I/O
+	completion handler.  If the filesystem decides to stop attempting
+	I/O before reaching the end of the readahead window, it can
+	simply return.	The caller will unlock the remaining pages
+	for you.  Set PageUptodate if the I/O completes successfully.
+	Setting PageError on any page will be ignored; simply unlock
+	the page if an I/O error occurs.
 
 ``readpages``
 	called by the VM to read pages associated with the address_space
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 42936a83a91b..02665daa6172 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3399,22 +3399,21 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	return ret;
 }
 
-static inline void contiguous_readpages(struct page *pages[], int nr_pages,
+static inline void contiguous_readpages(struct folio **folios, int nr_pages,
 					     u64 start, u64 end,
 					     struct extent_map **em_cached,
 					     struct bio **bio,
 					     unsigned long *bio_flags,
 					     u64 *prev_em_start)
 {
-	struct btrfs_inode *inode = BTRFS_I(pages[0]->mapping->host);
+	struct btrfs_inode *inode = BTRFS_I(folios[0]->page.mapping->host);
 	int index;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	for (index = 0; index < nr_pages; index++) {
-		btrfs_do_readpage(pages[index], em_cached, bio, bio_flags,
-				  REQ_RAHEAD, prev_em_start);
-		put_page(pages[index]);
+		btrfs_do_readpage(&folios[index]->page, em_cached, bio,
+				bio_flags, REQ_RAHEAD, prev_em_start);
 	}
 }
 
@@ -4430,12 +4429,12 @@ void extent_readahead(struct readahead_control *rac)
 {
 	struct bio *bio = NULL;
 	unsigned long bio_flags = 0;
-	struct page *pagepool[16];
+	struct folio *pagepool[16];
 	struct extent_map *em_cached = NULL;
 	u64 prev_em_start = (u64)-1;
 	int nr;
 
-	while ((nr = readahead_page_batch(rac, pagepool))) {
+	while ((nr = readahead_folio_batch(rac, pagepool))) {
 		u64 contig_start = readahead_pos(rac);
 		u64 contig_end = contig_start + readahead_batch_length(rac);
 
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index ea4f693bee22..ba6deef9a4cc 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -201,9 +201,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 			flush_dcache_page(page);
 
 			SetPageUptodate(page);
-			/* TODO: could we unlock the page earlier? */
 			unlock_page(ipage);
-			put_page(ipage);
 
 			/* imply err = 0, see erofs_map_blocks */
 			goto has_updated;
@@ -284,12 +282,13 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
 {
 	erofs_off_t last_block;
 	struct bio *bio = NULL;
-	struct page *page;
+	struct folio *folio;
 
 	trace_erofs_readpages(rac->mapping->host, readahead_index(rac),
 			readahead_count(rac), true);
 
-	while ((page = readahead_page(rac))) {
+	while ((folio = readahead_folio(rac))) {
+		struct page *page = &folio->page;
 		prefetchw(&page->flags);
 
 		bio = erofs_read_raw_page(bio, rac->mapping, page, &last_block,
@@ -303,8 +302,6 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
 
 			bio = NULL;
 		}
-
-		put_page(page);
 	}
 
 	/* the rare case (end in gaps) */
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6cb356c4217b..f83ddf5fd1b1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1336,6 +1336,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *page, *head = NULL;
+	struct folio *folio;
 	LIST_HEAD(pagepool);
 
 	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
@@ -1343,7 +1344,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
-	while ((page = readahead_page(rac))) {
+	while ((folio = readahead_folio(rac))) {
+		page = &folio->page;
 		prefetchw(&page->flags);
 
 		/*
@@ -1369,7 +1371,6 @@ static void z_erofs_readahead(struct readahead_control *rac)
 			erofs_err(inode->i_sb,
 				  "readahead error at page %lu @ nid %llu",
 				  page->index, EROFS_I(inode)->nid);
-		put_page(page);
 	}
 
 	(void)z_erofs_collector_end(&f.clt);
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index f014c5e473a9..6f5724d80a01 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -252,7 +252,7 @@ int ext4_mpage_readpages(struct inode *inode,
 		unsigned first_hole = blocks_per_page;
 
 		if (rac) {
-			page = readahead_page(rac);
+			page = &readahead_folio(rac)->page;
 			prefetchw(&page->flags);
 		}
 
@@ -307,7 +307,7 @@ int ext4_mpage_readpages(struct inode *inode,
 					zero_user_segment(page, 0,
 							  PAGE_SIZE);
 					unlock_page(page);
-					goto next_page;
+					continue;
 				}
 			}
 			if ((map.m_flags & EXT4_MAP_MAPPED) == 0) {
@@ -345,7 +345,7 @@ int ext4_mpage_readpages(struct inode *inode,
 					goto set_error_page;
 				SetPageUptodate(page);
 				unlock_page(page);
-				goto next_page;
+				continue;
 			}
 		} else if (fully_mapped) {
 			SetPageMappedToDisk(page);
@@ -394,7 +394,7 @@ int ext4_mpage_readpages(struct inode *inode,
 			bio = NULL;
 		} else
 			last_block_in_bio = blocks[blocks_per_page - 1];
-		goto next_page;
+		continue;
 	confused:
 		if (bio) {
 			submit_bio(bio);
@@ -404,9 +404,6 @@ int ext4_mpage_readpages(struct inode *inode,
 			block_read_full_page(page, ext4_get_block);
 		else
 			unlock_page(page);
-	next_page:
-		if (rac)
-			put_page(page);
 	}
 	if (bio)
 		submit_bio(bio);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index aa34d620bec9..2397bfd1a88d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2389,10 +2389,10 @@ static int f2fs_mpage_readpages(struct inode *inode,
 
 	for (; nr_pages; nr_pages--) {
 		if (rac) {
-			page = readahead_page(rac);
+			page = &readahead_folio(rac)->page;
 			prefetchw(&page->flags);
 			if (drop_ra) {
-				f2fs_put_page(page, 1);
+				unlock_page(page);
 				continue;
 			}
 		}
@@ -2438,11 +2438,6 @@ static int f2fs_mpage_readpages(struct inode *inode,
 		}
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 next_page:
-#endif
-		if (rac)
-			put_page(page);
-
-#ifdef CONFIG_F2FS_FS_COMPRESSION
 		if (f2fs_compressed_file(inode)) {
 			/* last page */
 			if (nr_pages == 1 && !f2fs_cluster_is_empty(&cc)) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8cccecb55fb8..c4645a54e932 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -911,7 +911,6 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		else
 			SetPageError(page);
 		unlock_page(page);
-		put_page(page);
 	}
 	if (ia->ff)
 		fuse_file_put(ia->ff, false, false);
@@ -980,7 +979,8 @@ static void fuse_readahead(struct readahead_control *rac)
 		if (!ia)
 			return;
 		ap = &ia->ap;
-		nr_pages = __readahead_batch(rac, ap->pages, nr_pages);
+		nr_pages = __readahead_batch(rac, (struct folio **)ap->pages,
+						nr_pages);
 		for (i = 0; i < nr_pages; i++) {
 			fuse_wait_on_page_writeback(inode,
 						    readahead_index(rac) + i);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 16a1e82e3aeb..ef650573ab9e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -361,11 +361,10 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
 		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
 			if (!ctx->cur_page_in_bio)
 				unlock_page(ctx->cur_page);
-			put_page(ctx->cur_page);
 			ctx->cur_page = NULL;
 		}
 		if (!ctx->cur_page) {
-			ctx->cur_page = readahead_page(ctx->rac);
+			ctx->cur_page = &readahead_folio(ctx->rac)->page;
 			ctx->cur_page_in_bio = false;
 		}
 		ret = iomap_readpage_actor(inode, pos + done, length - done,
@@ -417,7 +416,6 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	if (ctx.cur_page) {
 		if (!ctx.cur_page_in_bio)
 			unlock_page(ctx.cur_page);
-		put_page(ctx.cur_page);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
diff --git a/fs/mpage.c b/fs/mpage.c
index 830e6cc2a9e7..58b7e15d85c1 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -384,12 +384,11 @@ void mpage_readahead(struct readahead_control *rac, get_block_t get_block)
 		.is_readahead = true,
 	};
 
-	while ((page = readahead_page(rac))) {
+	while ((page = &readahead_folio(rac)->page)) {
 		prefetchw(&page->flags);
 		args.page = page;
 		args.nr_pages = readahead_count(rac);
 		args.bio = do_mpage_readpage(&args);
-		put_page(page);
 	}
 	if (args.bio)
 		mpage_bio_submit(REQ_OP_READ, REQ_RAHEAD, args.bio);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 81ff21289722..30123ae18ee1 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -849,8 +849,8 @@ static inline int add_to_page_cache_lru(struct page *page,
  * struct readahead_control - Describes a readahead request.
  *
  * A readahead request is for consecutive pages.  Filesystems which
- * implement the ->readahead method should call readahead_page() or
- * readahead_page_batch() in a loop and attempt to start I/O against
+ * implement the ->readahead method should call readahead_folio() or
+ * readahead_folio_batch() in a loop and attempt to start I/O against
  * each page in the request.
  *
  * Most of the fields in this struct are private and should be accessed
@@ -931,17 +931,16 @@ void page_cache_async_readahead(struct address_space *mapping,
 }
 
 /**
- * readahead_page - Get the next page to read.
+ * readahead_folio - Get the next folio to read.
  * @rac: The current readahead request.
  *
- * Context: The page is locked and has an elevated refcount.  The caller
- * should decreases the refcount once the page has been submitted for I/O
- * and unlock the page once all I/O to that page has completed.
- * Return: A pointer to the next page, or %NULL if we are done.
+ * Context: The folio is locked.  The caller should unlock the folio once
+ * all I/O to that folio has completed.
+ * Return: A pointer to the next folio, or %NULL if we are done.
  */
-static inline struct page *readahead_page(struct readahead_control *rac)
+static inline struct folio *readahead_folio(struct readahead_control *rac)
 {
-	struct page *page;
+	struct folio *folio;
 
 	BUG_ON(rac->_batch_count > rac->_nr_pages);
 	rac->_nr_pages -= rac->_batch_count;
@@ -952,19 +951,19 @@ static inline struct page *readahead_page(struct readahead_control *rac)
 		return NULL;
 	}
 
-	page = xa_load(&rac->mapping->i_pages, rac->_index);
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	rac->_batch_count = thp_nr_pages(page);
+	folio = xa_load(&rac->mapping->i_pages, rac->_index);
+	VM_BUG_ON_PAGE(!FolioLocked(folio), &folio->page);
+	rac->_batch_count = folio_nr_pages(folio);
 
-	return page;
+	return folio;
 }
 
 static inline unsigned int __readahead_batch(struct readahead_control *rac,
-		struct page **array, unsigned int array_sz)
+		struct folio **array, unsigned int array_sz)
 {
 	unsigned int i = 0;
 	XA_STATE(xas, &rac->mapping->i_pages, 0);
-	struct page *page;
+	struct folio *folio;
 
 	BUG_ON(rac->_batch_count > rac->_nr_pages);
 	rac->_nr_pages -= rac->_batch_count;
@@ -973,13 +972,12 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 
 	xas_set(&xas, rac->_index);
 	rcu_read_lock();
-	xas_for_each(&xas, page, rac->_index + rac->_nr_pages - 1) {
-		if (xas_retry(&xas, page))
+	xas_for_each(&xas, folio, rac->_index + rac->_nr_pages - 1) {
+		if (xas_retry(&xas, folio))
 			continue;
-		VM_BUG_ON_PAGE(!PageLocked(page), page);
-		VM_BUG_ON_PAGE(PageTail(page), page);
-		array[i++] = page;
-		rac->_batch_count += thp_nr_pages(page);
+		VM_BUG_ON_PAGE(!FolioLocked(folio), &folio->page);
+		array[i++] = folio;
+		rac->_batch_count += folio_nr_pages(folio);
 
 		/*
 		 * The page cache isn't using multi-index entries yet,
@@ -987,7 +985,7 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 		 * next index.  This can be removed once the page cache
 		 * is converted.
 		 */
-		if (PageHead(page))
+		if (FolioHead(folio))
 			xas_set(&xas, rac->_index + rac->_batch_count);
 
 		if (i == array_sz)
@@ -999,17 +997,16 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 }
 
 /**
- * readahead_page_batch - Get a batch of pages to read.
+ * readahead_folio_batch - Get a batch of folios to read.
  * @rac: The current readahead request.
- * @array: An array of pointers to struct page.
+ * @array: An array of pointers to struct folio.
  *
- * Context: The pages are locked and have an elevated refcount.  The caller
- * should decreases the refcount once the page has been submitted for I/O
- * and unlock the page once all I/O to that page has completed.
- * Return: The number of pages placed in the array.  0 indicates the request
+ * Context: The folios are locked.  The caller should unlock the folio
+ * once all I/O to that folio has completed.
+ * Return: The number of folios placed in the array.  0 indicates the request
  * is complete.
  */
-#define readahead_page_batch(rac, array)				\
+#define readahead_folio_batch(rac, array)				\
 	__readahead_batch(rac, array, ARRAY_SIZE(array))
 
 /**
diff --git a/mm/readahead.c b/mm/readahead.c
index d7a5424e3d0d..b2d78984e406 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -118,7 +118,7 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 		bool skip_page)
 {
 	const struct address_space_operations *aops = rac->mapping->a_ops;
-	struct page *page;
+	struct folio *folio;
 	struct blk_plug plug;
 
 	if (!readahead_count(rac))
@@ -128,11 +128,9 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 
 	if (aops->readahead) {
 		aops->readahead(rac);
-		/* Clean up the remaining pages */
-		while ((page = readahead_page(rac))) {
-			unlock_page(page);
-			put_page(page);
-		}
+		/* Clean up the remaining folios */
+		while ((folio = readahead_folio(rac)))
+			unlock_folio(folio);
 	} else if (aops->readpages) {
 		aops->readpages(rac->file, rac->mapping, pages,
 				readahead_count(rac));
@@ -141,10 +139,8 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 		rac->_index += rac->_nr_pages;
 		rac->_nr_pages = 0;
 	} else {
-		while ((page = readahead_page(rac))) {
-			aops->readpage(rac->file, page);
-			put_page(page);
-		}
+		while ((folio = readahead_folio(rac)))
+			aops->readpage(rac->file, &folio->page);
 	}
 
 	blk_finish_plug(&plug);
@@ -224,6 +220,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			put_page(page);
 			read_pages(ractl, &page_pool, true);
 			continue;
+		} else {
+			put_page(page);
 		}
 		if (i == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
-- 
2.29.2

