Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 745A2139500
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 16:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgAMPhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 10:37:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgAMPhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XzLp8VMemTuCcHOHx3h9ZSjkeqJlb8tYYS2nICefEuM=; b=idavc8Cc/pyoNqz+6SqHd54F6q
        dKO2M2mVSfeeLE708RbcR+IFE5XWFq0q8HyEUhSjwweiy3IIZXX9QNKXKZwMgzIQW/KU2IWavOOfD
        K14AmlaHnSJm9I5bErummNEc6FJgCxWI63FW3c6O7Ofjwl71bVTXQ6foxzRFfUDgO1sQvc9Q2wikF
        /dlrNIsYGq01es9DhIPtAHN2dJ2QDEuq+ILiCUuSIcf2ydL97xJ/JCuwj8a541Yuw7XRUqCoG7wej
        1bfawDu8CNs2pR3+8WJY4Fs91nn0h1NaMWmTWfkNZikGM/KUQKtPoXXBS+glzTzwpBOHnvs842iTp
        QP1uoiOg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir1mr-00076U-7n; Mon, 13 Jan 2020 15:37:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        jlayton@kernel.org, hch@infradead.org
Subject: [PATCH 5/8] iomap,xfs: Convert from readpages to readahead
Date:   Mon, 13 Jan 2020 07:37:43 -0800
Message-Id: <20200113153746.26654-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200113153746.26654-1-willy@infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new readahead operation in XFS and iomap.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 60 +++++++++---------------------------------
 fs/iomap/trace.h       | 18 ++++++-------
 fs/xfs/xfs_aops.c      | 12 ++++-----
 include/linux/iomap.h  |  4 +--
 4 files changed, 29 insertions(+), 65 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 828444e14d09..818fa5bbd643 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/iomap.h>
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 #include <linux/uio.h>
 #include <linux/buffer_head.h>
 #include <linux/dax.h>
@@ -216,7 +217,7 @@ struct iomap_readpage_ctx {
 	bool			cur_page_in_bio;
 	bool			is_readahead;
 	struct bio		*bio;
-	struct list_head	*pages;
+	struct pagevec		*pages;
 };
 
 static void
@@ -337,7 +338,7 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 	unsigned poff;
 	loff_t ret;
 
-	trace_iomap_readpage(page->mapping->host, 1);
+	trace_iomap_readpage(page->mapping->host, (loff_t)PAGE_SIZE);
 
 	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
 		ret = iomap_apply(inode, page_offset(page) + poff,
@@ -367,36 +368,8 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
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
@@ -410,8 +383,7 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 			ctx->cur_page = NULL;
 		}
 		if (!ctx->cur_page) {
-			ctx->cur_page = iomap_next_page(inode, ctx->pages,
-					pos, length, &done);
+			ctx->cur_page = pagevec_next(ctx->pages);
 			if (!ctx->cur_page)
 				break;
 			ctx->cur_page_in_bio = false;
@@ -423,23 +395,22 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 	return done;
 }
 
-int
-iomap_readpages(struct address_space *mapping, struct list_head *pages,
-		unsigned nr_pages, const struct iomap_ops *ops)
+void iomap_readahead(struct address_space *mapping, struct pagevec *pages,
+		pgoff_t index, const struct iomap_ops *ops)
 {
 	struct iomap_readpage_ctx ctx = {
 		.pages		= pages,
 		.is_readahead	= true,
 	};
-	loff_t pos = page_offset(list_entry(pages->prev, struct page, lru));
-	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
+	loff_t pos = (loff_t)index << PAGE_SHIFT;
+	loff_t last = page_offset(pagevec_last(pages));
 	loff_t length = last - pos + PAGE_SIZE, ret = 0;
 
-	trace_iomap_readpages(mapping->host, nr_pages);
+	trace_iomap_readahead(mapping->host, length);
 
 	while (length > 0) {
 		ret = iomap_apply(mapping->host, pos, length, 0, ops,
-				&ctx, iomap_readpages_actor);
+				&ctx, iomap_readahead_actor);
 		if (ret <= 0) {
 			WARN_ON_ONCE(ret == 0);
 			goto done;
@@ -456,15 +427,8 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
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
index 6dc227b8c47e..adbfd9fd4275 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -16,30 +16,30 @@
 struct inode;
 
 DECLARE_EVENT_CLASS(iomap_readpage_class,
-	TP_PROTO(struct inode *inode, int nr_pages),
-	TP_ARGS(inode, nr_pages),
+	TP_PROTO(struct inode *inode, loff_t length),
+	TP_ARGS(inode, length),
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(u64, ino)
-		__field(int, nr_pages)
+		__field(loff_t, length)
 	),
 	TP_fast_assign(
 		__entry->dev = inode->i_sb->s_dev;
 		__entry->ino = inode->i_ino;
-		__entry->nr_pages = nr_pages;
+		__entry->length = length;
 	),
-	TP_printk("dev %d:%d ino 0x%llx nr_pages %d",
+	TP_printk("dev %d:%d ino 0x%llx length %lld",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->ino,
-		  __entry->nr_pages)
+		  __entry->length)
 )
 
 #define DEFINE_READPAGE_EVENT(name)		\
 DEFINE_EVENT(iomap_readpage_class, name,	\
-	TP_PROTO(struct inode *inode, int nr_pages), \
-	TP_ARGS(inode, nr_pages))
+	TP_PROTO(struct inode *inode, loff_t length), \
+	TP_ARGS(inode, length))
 DEFINE_READPAGE_EVENT(iomap_readpage);
-DEFINE_READPAGE_EVENT(iomap_readpages);
+DEFINE_READPAGE_EVENT(iomap_readahead);
 
 DECLARE_EVENT_CLASS(iomap_page_class,
 	TP_PROTO(struct inode *inode, struct page *page, unsigned long off,
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 3a688eb5c5ae..e3db35bcfa34 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -621,14 +621,14 @@ xfs_vm_readpage(
 	return iomap_readpage(page, &xfs_read_iomap_ops);
 }
 
-STATIC int
-xfs_vm_readpages(
+STATIC void
+xfs_vm_readahead(
 	struct file		*unused,
 	struct address_space	*mapping,
-	struct list_head	*pages,
-	unsigned		nr_pages)
+	struct pagevec		*pages,
+	pgoff_t			index)
 {
-	return iomap_readpages(mapping, pages, nr_pages, &xfs_read_iomap_ops);
+	iomap_readahead(mapping, pages, index, &xfs_read_iomap_ops);
 }
 
 static int
@@ -644,7 +644,7 @@ xfs_iomap_swapfile_activate(
 
 const struct address_space_operations xfs_address_space_operations = {
 	.readpage		= xfs_vm_readpage,
-	.readpages		= xfs_vm_readpages,
+	.readahead		= xfs_vm_readahead,
 	.writepage		= xfs_vm_writepage,
 	.writepages		= xfs_vm_writepages,
 	.set_page_dirty		= iomap_set_page_dirty,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..1af1ec0920d8 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -155,8 +155,8 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
-int iomap_readpages(struct address_space *mapping, struct list_head *pages,
-		unsigned nr_pages, const struct iomap_ops *ops);
+void iomap_readahead(struct address_space *mapping, struct pagevec *pages,
+		pgoff_t index, const struct iomap_ops *ops);
 int iomap_set_page_dirty(struct page *page);
 int iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count);
-- 
2.24.1

