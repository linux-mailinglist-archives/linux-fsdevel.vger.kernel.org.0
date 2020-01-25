Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7FE1492B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 02:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbgAYBf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 20:35:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbgAYBf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AMBkclhqH1dZvG78KPI2ypTnwNX3NzGNp23aNp57h+A=; b=M98P91uxh4X45gSy4biuVMoTrD
        WpjQT3yChuQiYikPC+1wzJo9Vbtt77BgFcQ19JlhZXeJAQHX3tlW2y8mWYWzv4+y0AAEqmEPK1daX
        9scNE/scgwlM+agukfUecRCinwY1nt2SBughHZ+aqAs7x1wg+LD4vLn0lVikh5EidtXGFTJpDN6tM
        0ur7Pa5GroLCJErg5nXjJ6Yi6IAUf2q/tCyblemMfMljWT0W3gK2h4tXJBK5NE+/tZpw4O37D/PdU
        nVnqbwRG+qdVSBFKAQEWXvI9V1uMi0L8YoXD4mAeC86Yx5YQHUHWQiSwRNJhPoqS/ga4oQnNFbeVh
        zTQBPkJw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivAMd-0006WA-Ip; Sat, 25 Jan 2020 01:35:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 12/12] iomap: Convert from readpages to readahead
Date:   Fri, 24 Jan 2020 17:35:53 -0800
Message-Id: <20200125013553.24899-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200125013553.24899-1-willy@infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new readahead operation in XFS and iomap.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org
---
 fs/iomap/buffered-io.c | 72 +++++++++---------------------------------
 fs/iomap/trace.h       |  2 +-
 fs/xfs/xfs_aops.c      | 10 +++---
 include/linux/iomap.h  |  2 +-
 4 files changed, 22 insertions(+), 64 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1e2f3cc4579b..07aedd359c4b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -216,7 +216,6 @@ struct iomap_readpage_ctx {
 	bool			cur_page_in_bio;
 	bool			is_readahead;
 	struct bio		*bio;
-	struct list_head	*pages;
 };
 
 static void
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
@@ -410,10 +381,8 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 			ctx->cur_page = NULL;
 		}
 		if (!ctx->cur_page) {
-			ctx->cur_page = iomap_next_page(inode, ctx->pages,
-					pos, length, &done);
-			if (!ctx->cur_page)
-				break;
+			ctx->cur_page = readahead_page(inode->i_mapping,
+					pos / PAGE_SIZE);
 			ctx->cur_page_in_bio = false;
 		}
 		ret = iomap_readpage_actor(inode, pos + done, length - done,
@@ -423,48 +392,37 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 	return done;
 }
 
-int
-iomap_readpages(struct address_space *mapping, struct list_head *pages,
+unsigned
+iomap_readahead(struct address_space *mapping, pgoff_t start,
 		unsigned nr_pages, const struct iomap_ops *ops)
 {
 	struct iomap_readpage_ctx ctx = {
-		.pages		= pages,
 		.is_readahead	= true,
 	};
-	loff_t pos = page_offset(list_entry(pages->prev, struct page, lru));
-	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
-	loff_t length = last - pos + PAGE_SIZE, ret = 0;
+	loff_t pos = start * PAGE_SIZE;
+	loff_t length = nr_pages * PAGE_SIZE;
 
-	trace_iomap_readpages(mapping->host, nr_pages);
+	trace_iomap_readahead(mapping->host, nr_pages);
 
 	while (length > 0) {
-		ret = iomap_apply(mapping->host, pos, length, 0, ops,
-				&ctx, iomap_readpages_actor);
+		loff_t ret = iomap_apply(mapping->host, pos, length, 0, ops,
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
-	if (ctx.cur_page) {
-		if (!ctx.cur_page_in_bio)
-			unlock_page(ctx.cur_page);
+	if (ctx.cur_page && ctx.cur_page_in_bio)
 		put_page(ctx.cur_page);
-	}
 
-	/*
-	 * Check that we didn't lose a page due to the arcance calling
-	 * conventions..
-	 */
-	WARN_ON_ONCE(!ret && !list_empty(ctx.pages));
-	return ret;
+	return length / PAGE_SIZE;
 }
-EXPORT_SYMBOL_GPL(iomap_readpages);
+EXPORT_SYMBOL_GPL(iomap_readahead);
 
 /*
  * iomap_is_partially_uptodate checks whether blocks within a page are
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 6dc227b8c47e..d6ba705f938a 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -39,7 +39,7 @@ DEFINE_EVENT(iomap_readpage_class, name,	\
 	TP_PROTO(struct inode *inode, int nr_pages), \
 	TP_ARGS(inode, nr_pages))
 DEFINE_READPAGE_EVENT(iomap_readpage);
-DEFINE_READPAGE_EVENT(iomap_readpages);
+DEFINE_READPAGE_EVENT(iomap_readahead);
 
 DECLARE_EVENT_CLASS(iomap_page_class,
 	TP_PROTO(struct inode *inode, struct page *page, unsigned long off,
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 3a688eb5c5ae..4d9da34e759b 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -621,14 +621,14 @@ xfs_vm_readpage(
 	return iomap_readpage(page, &xfs_read_iomap_ops);
 }
 
-STATIC int
-xfs_vm_readpages(
+STATIC unsigned
+xfs_vm_readahead(
 	struct file		*unused,
 	struct address_space	*mapping,
-	struct list_head	*pages,
+	pgoff_t			start,
 	unsigned		nr_pages)
 {
-	return iomap_readpages(mapping, pages, nr_pages, &xfs_read_iomap_ops);
+	return iomap_readahead(mapping, start, nr_pages, &xfs_read_iomap_ops);
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
index 8b09463dae0d..81c6067e9b61 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -155,7 +155,7 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
-int iomap_readpages(struct address_space *mapping, struct list_head *pages,
+unsigned iomap_readahead(struct address_space *, pgoff_t start,
 		unsigned nr_pages, const struct iomap_ops *ops);
 int iomap_set_page_dirty(struct page *page);
 int iomap_is_partially_uptodate(struct page *page, unsigned long from,
-- 
2.24.1

