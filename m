Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DC718FF4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 21:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCWUXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 16:23:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCWUXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DcQHOlgwNqeEPN3fiAW/rNxfySxuJVhOd+sF/+JeQ6E=; b=TPybKGkTlLYjObv6dPcawhPHLm
        RCByjj/hE7TkPru+cXnpw/Ez0mfGPUyiOwAzcH9xWgftIj9QABRpbFkbBMXgsaQjG959xgTmnBfW0
        CXLy7eljwHojUJRAA9lMX//CykIsqgQVVHaP8SKOxFCJmVXoLE4EaStMc1H3zvk+9NoSGNaZSWkng
        /4ntS/huqrVKoEi51RWPz0U1a0bvMTmCsm/ZDVgddtOV5ZnRpXj/3XB332HzsZ6L9tCe1SBvyEPrY
        ZpvUzn8SNbHPQKWaU52mPoMTbQrCCv9cvb4r8ogKVeGD9DfAQgsS9XaDdjNbrEPbX6lMgCyE1FuSb
        0MbqwdWw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGTbC-0003WB-7j; Mon, 23 Mar 2020 20:23:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v10 25/25] iomap: Convert from readpages to readahead
Date:   Mon, 23 Mar 2020 13:22:59 -0700
Message-Id: <20200323202259.13363-26-willy@infradead.org>
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

Use the new readahead operation in iomap.  Convert XFS and ZoneFS to
use it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 fs/iomap/buffered-io.c | 90 +++++++++++++++---------------------------
 fs/iomap/trace.h       |  2 +-
 fs/xfs/xfs_aops.c      | 13 +++---
 fs/zonefs/super.c      |  7 ++--
 include/linux/iomap.h  |  3 +-
 5 files changed, 41 insertions(+), 74 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e7928678564f..1734d79acc0a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -214,9 +214,8 @@ iomap_read_end_io(struct bio *bio)
 struct iomap_readpage_ctx {
 	struct page		*cur_page;
 	bool			cur_page_in_bio;
-	bool			is_readahead;
 	struct bio		*bio;
-	struct list_head	*pages;
+	struct readahead_control *rac;
 };
 
 static void
@@ -307,11 +306,11 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		if (ctx->bio)
 			submit_bio(ctx->bio);
 
-		if (ctx->is_readahead) /* same as readahead_gfp_mask */
+		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
 		ctx->bio = bio_alloc(gfp, min(BIO_MAX_PAGES, nr_vecs));
 		ctx->bio->bi_opf = REQ_OP_READ;
-		if (ctx->is_readahead)
+		if (ctx->rac)
 			ctx->bio->bi_opf |= REQ_RAHEAD;
 		ctx->bio->bi_iter.bi_sector = sector;
 		bio_set_dev(ctx->bio, iomap->bdev);
@@ -367,36 +366,8 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readpage);
 
-static struct page *
-iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
-		loff_t length, loff_t *done)
-{
-	while (!list_empty(pages)) {
-		struct page *page = lru_to_page(pages);
-
-		if (page_offset(page) >= (u64)pos + length)
-			break;
-
-		list_del(&page->lru);
-		if (!add_to_page_cache_lru(page, inode->i_mapping, page->index,
-				GFP_NOFS))
-			return page;
-
-		/*
-		 * If we already have a page in the page cache at index we are
-		 * done.  Upper layers don't care if it is uptodate after the
-		 * readpages call itself as every page gets checked again once
-		 * actually needed.
-		 */
-		*done += PAGE_SIZE;
-		put_page(page);
-	}
-
-	return NULL;
-}
-
 static loff_t
-iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
+iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
 		void *data, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct iomap_readpage_ctx *ctx = data;
@@ -410,10 +381,7 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 			ctx->cur_page = NULL;
 		}
 		if (!ctx->cur_page) {
-			ctx->cur_page = iomap_next_page(inode, ctx->pages,
-					pos, length, &done);
-			if (!ctx->cur_page)
-				break;
+			ctx->cur_page = readahead_page(ctx->rac);
 			ctx->cur_page_in_bio = false;
 		}
 		ret = iomap_readpage_actor(inode, pos + done, length - done,
@@ -423,32 +391,43 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 	return done;
 }
 
-int
-iomap_readpages(struct address_space *mapping, struct list_head *pages,
-		unsigned nr_pages, const struct iomap_ops *ops)
+/**
+ * iomap_readahead - Attempt to read pages from a file.
+ * @rac: Describes the pages to be read.
+ * @ops: The operations vector for the filesystem.
+ *
+ * This function is for filesystems to call to implement their readahead
+ * address_space operation.
+ *
+ * Context: The @ops callbacks may submit I/O (eg to read the addresses of
+ * blocks from disc), and may wait for it.  The caller may be trying to
+ * access a different page, and so sleeping excessively should be avoided.
+ * It may allocate memory, but should avoid costly allocations.  This
+ * function is called with memalloc_nofs set, so allocations will not cause
+ * the filesystem to be reentered.
+ */
+void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 {
+	struct inode *inode = rac->mapping->host;
+	loff_t pos = readahead_pos(rac);
+	loff_t length = readahead_length(rac);
 	struct iomap_readpage_ctx ctx = {
-		.pages		= pages,
-		.is_readahead	= true,
+		.rac	= rac,
 	};
-	loff_t pos = page_offset(list_entry(pages->prev, struct page, lru));
-	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
-	loff_t length = last - pos + PAGE_SIZE, ret = 0;
 
-	trace_iomap_readpages(mapping->host, nr_pages);
+	trace_iomap_readahead(inode, readahead_count(rac));
 
 	while (length > 0) {
-		ret = iomap_apply(mapping->host, pos, length, 0, ops,
-				&ctx, iomap_readpages_actor);
+		loff_t ret = iomap_apply(inode, pos, length, 0, ops,
+				&ctx, iomap_readahead_actor);
 		if (ret <= 0) {
 			WARN_ON_ONCE(ret == 0);
-			goto done;
+			break;
 		}
 		pos += ret;
 		length -= ret;
 	}
-	ret = 0;
-done:
+
 	if (ctx.bio)
 		submit_bio(ctx.bio);
 	if (ctx.cur_page) {
@@ -456,15 +435,8 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
 			unlock_page(ctx.cur_page);
 		put_page(ctx.cur_page);
 	}
-
-	/*
-	 * Check that we didn't lose a page due to the arcance calling
-	 * conventions..
-	 */
-	WARN_ON_ONCE(!ret && !list_empty(ctx.pages));
-	return ret;
 }
-EXPORT_SYMBOL_GPL(iomap_readpages);
+EXPORT_SYMBOL_GPL(iomap_readahead);
 
 /*
  * iomap_is_partially_uptodate checks whether blocks within a page are
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 4df19c66f597..5693a39d52fb 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -39,7 +39,7 @@ DEFINE_EVENT(iomap_readpage_class, name,	\
 	TP_PROTO(struct inode *inode, int nr_pages), \
 	TP_ARGS(inode, nr_pages))
 DEFINE_READPAGE_EVENT(iomap_readpage);
-DEFINE_READPAGE_EVENT(iomap_readpages);
+DEFINE_READPAGE_EVENT(iomap_readahead);
 
 DECLARE_EVENT_CLASS(iomap_range_class,
 	TP_PROTO(struct inode *inode, unsigned long off, unsigned int len),
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 9d9cebf18726..1fd4fb7a607c 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -621,14 +621,11 @@ xfs_vm_readpage(
 	return iomap_readpage(page, &xfs_read_iomap_ops);
 }
 
-STATIC int
-xfs_vm_readpages(
-	struct file		*unused,
-	struct address_space	*mapping,
-	struct list_head	*pages,
-	unsigned		nr_pages)
+STATIC void
+xfs_vm_readahead(
+	struct readahead_control	*rac)
 {
-	return iomap_readpages(mapping, pages, nr_pages, &xfs_read_iomap_ops);
+	iomap_readahead(rac, &xfs_read_iomap_ops);
 }
 
 static int
@@ -644,7 +641,7 @@ xfs_iomap_swapfile_activate(
 
 const struct address_space_operations xfs_address_space_operations = {
 	.readpage		= xfs_vm_readpage,
-	.readpages		= xfs_vm_readpages,
+	.readahead		= xfs_vm_readahead,
 	.writepage		= xfs_vm_writepage,
 	.writepages		= xfs_vm_writepages,
 	.set_page_dirty		= iomap_set_page_dirty,
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 69aee3dfb660..546aee6283c8 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -78,10 +78,9 @@ static int zonefs_readpage(struct file *unused, struct page *page)
 	return iomap_readpage(page, &zonefs_iomap_ops);
 }
 
-static int zonefs_readpages(struct file *unused, struct address_space *mapping,
-			    struct list_head *pages, unsigned int nr_pages)
+static void zonefs_readahead(struct readahead_control *rac)
 {
-	return iomap_readpages(mapping, pages, nr_pages, &zonefs_iomap_ops);
+	iomap_readahead(rac, &zonefs_iomap_ops);
 }
 
 /*
@@ -128,7 +127,7 @@ static int zonefs_writepages(struct address_space *mapping,
 
 static const struct address_space_operations zonefs_file_aops = {
 	.readpage		= zonefs_readpage,
-	.readpages		= zonefs_readpages,
+	.readahead		= zonefs_readahead,
 	.writepage		= zonefs_writepage,
 	.writepages		= zonefs_writepages,
 	.set_page_dirty		= iomap_set_page_dirty,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..bc20bd04c2a2 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -155,8 +155,7 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
-int iomap_readpages(struct address_space *mapping, struct list_head *pages,
-		unsigned nr_pages, const struct iomap_ops *ops);
+void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 int iomap_set_page_dirty(struct page *page);
 int iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count);
-- 
2.25.1

