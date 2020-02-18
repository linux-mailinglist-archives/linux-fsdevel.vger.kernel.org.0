Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E531630A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 20:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBRTyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 14:54:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0fbPHabH5rtRjpop0nvOgXSZPwl/5hzmmLwctoYuLtg=; b=O1En3UG2/SWLTrMtnpJrjjgjSj
        eDzVzRDQGtNtvubDjDkjRGIJMAo2/GoMR9u4cwrm8+0raSMb0Dy9hL/V3FpFf/NmyWWubRiI9r+hm
        MvOlhqGPP2nSWK8OHRdeyCeOjeD1HWTFC623D5HCt0pjipMPDmuypyH+NFt9zlecrKxRdrer+o3u3
        pi3Enpw1YLfghmY62DGTbp2PLvGeLps7dpV1mZuLhZpmvdT2mfnn1muQ0TCMLV4/avuAAjtPVLxIY
        Zyl5nqtrsKk/bKNP/w3WTu5SkxFkRP5G2N41SHaU+CoUG3Z05IW3gfMCxRt4E82CyQ0E1TCT81pxh
        cxgZHRXg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j48wW-0003Wd-Ia; Tue, 18 Feb 2020 19:54:04 +0000
Date:   Tue, 18 Feb 2020 11:54:04 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 09/19] mm: Add page_cache_readahead_limit
Message-ID: <20200218195404.GD24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-16-willy@infradead.org>
 <20200218063110.GO10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218063110.GO10776@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:31:10PM +1100, Dave Chinner wrote:
> On Mon, Feb 17, 2020 at 10:45:56AM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > ext4 and f2fs have duplicated the guts of the readahead code so
> > they can read past i_size.  Instead, separate out the guts of the
> > readahead code so they can call it directly.
> 
> Gross and nasty (hosting non-stale data beyond EOF in the page
> cache, that is).

I thought you meant sneaking changes into the VFS (that were rejected) by
copying VFS code and modifying it ...

> > +/**
> > + * page_cache_readahead_limit - Start readahead beyond a file's i_size.
> > + * @mapping: File address space.
> > + * @file: This instance of the open file; used for authentication.
> > + * @offset: First page index to read.
> > + * @end_index: The maximum page index to read.
> > + * @nr_to_read: The number of pages to read.
> > + * @lookahead_size: Where to start the next readahead.
> > + *
> > + * This function is for filesystems to call when they want to start
> > + * readahead potentially beyond a file's stated i_size.  If you want
> > + * to start readahead on a normal file, you probably want to call
> > + * page_cache_async_readahead() or page_cache_sync_readahead() instead.
> > + *
> > + * Context: File is referenced by caller.  Mutexes may be held by caller.
> > + * May sleep, but will not reenter filesystem to reclaim memory.
> >   */
> > -void __do_page_cache_readahead(struct address_space *mapping,
> > -		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
> > -		unsigned long lookahead_size)
> > +void page_cache_readahead_limit(struct address_space *mapping,
> 
> ... I don't think the function name conveys it's purpose. It's
> really a ranged readahead that ignores where i_size lies. i.e
> 
> 	page_cache_readahead_range(mapping, start, end, nr_to_read)
> 
> seems like a better API to me, and then you can drop the "start
> readahead beyond i_size" comments and replace it with "Range is not
> limited by the inode's i_size and hence can be used to read data
> stored beyond EOF into the page cache."

I'm concerned that calling it 'range' implies "I want to read between
start and end" rather than "I want to read nr_to_read at start, oh but
don't go past end".

Maybe the right way to do this is have the three callers cap nr_to_read.
Well, the one caller ... after all, f2fs and ext4 have no desire to
cap the length.  Then we can call it page_cache_readahead_exceed() or
page_cache_readahead_dangerous() or something else like that to make it
clear that you shouldn't be calling it.

> Also: "This is almost certainly not the function you want to call.
> Use page_cache_async_readahead or page_cache_sync_readahead()
> instead."

+1 to that ;-)

Here's what I currently have:

From d202dda7a92566496fe9e233ee7855fb560324ce Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Mon, 10 Feb 2020 18:31:15 -0500
Subject: [PATCH] mm: Add page_cache_readahead_exceed

ext4 and f2fs have duplicated the guts of the readahead code so
they can read past i_size.  Instead, separate out the guts of the
readahead code so they can call it directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/verity.c        | 35 ++--------------------
 fs/f2fs/verity.c        | 35 ++--------------------
 include/linux/pagemap.h |  3 ++
 mm/readahead.c          | 66 ++++++++++++++++++++++++++++-------------
 4 files changed, 52 insertions(+), 87 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index dc5ec724d889..172ebf860014 100644
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
+			page_cache_readahead_exceed(inode->i_mapping, NULL,
+					index, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index d7d430a6f130..f240ad087162 100644
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
+			page_cache_readahead_exceed(inode->i_mapping, NULL,
+					index, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
 	return page;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 48c3bca57df6..1f7964d2b8ca 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -623,6 +623,9 @@ void page_cache_sync_readahead(struct address_space *, struct file_ra_state *,
 void page_cache_async_readahead(struct address_space *, struct file_ra_state *,
 		struct file *, struct page *, pgoff_t index,
 		unsigned long req_count);
+void page_cache_readahead_exceed(struct address_space *, struct file *,
+		pgoff_t index, unsigned long nr_to_read,
+		unsigned long lookahead_count);
 
 /*
  * Like add_to_page_cache_locked, but used to add newly allocated pages:
diff --git a/mm/readahead.c b/mm/readahead.c
index 9dd431fa16c9..cad26287ad8b 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -142,45 +142,43 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages)
 	blk_finish_plug(&plug);
 }
 
-/*
- * __do_page_cache_readahead() actually reads a chunk of disk.  It allocates
- * the pages first, then submits them for I/O. This avoids the very bad
- * behaviour which would occur if page allocations are causing VM writeback.
- * We really don't want to intermingle reads and writes like that.
+/**
+ * page_cache_readahead_exceed - Start unchecked readahead.
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
+void page_cache_readahead_exceed(struct address_space *mapping,
+		struct file *file, pgoff_t index, unsigned long nr_to_read,
 		unsigned long lookahead_size)
 {
-	struct inode *inode = mapping->host;
-	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	unsigned long i;
-	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	bool use_list = mapping->a_ops->readpages;
 	struct readahead_control rac = {
 		.mapping = mapping,
-		.file = filp,
+		.file = file,
 		._start = index,
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
 	for (i = 0; i < nr_to_read; i++) {
-		struct page *page;
-
-		if (index > end_index)
-			break;
+		struct page *page = xa_load(&mapping->i_pages, index);
 
-		page = xa_load(&mapping->i_pages, index);
 		if (page && !xa_is_value(page)) {
 			/*
 			 * Page already present?  Kick off the current batch
@@ -225,6 +223,32 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		read_pages(&rac, &page_pool);
 	BUG_ON(!list_empty(&page_pool));
 }
+EXPORT_SYMBOL_GPL(page_cache_readahead_exceed);
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
+	pgoff_t end_index;
+
+	if (isize == 0)
+		return;
+
+	end_index = (isize - 1) >> PAGE_SHIFT;
+	if (end_index < index + nr_to_read)
+		nr_to_read = end_index - index;
+
+	page_cache_readahead_exceed(mapping, file, index, nr_to_read,
+			lookahead_size);
+}
 
 /*
  * Chunk the readahead into 2 megabyte units, so that we don't pin too much
-- 
2.25.0

