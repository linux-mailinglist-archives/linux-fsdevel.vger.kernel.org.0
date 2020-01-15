Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1FC13B7CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 03:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAOCir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 21:38:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgAOCiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PRoqLhrRH4BnTdkixdoRzZi7DfWCHB3Ltn+7kcJoJps=; b=c62oU1P5kyulzPUR27bmrlSZ3L
        BOKaU55ftPQBDOzW4uogO2RB7v0onuVA8nMCzviM6o2uQpcNrPeckLHwGRB1P9E0woBrwC2AApQSv
        r8iQMPRe9BUzL2nDL65axUEbHqru5/qdh+HVbJAFeGOWWh9Attq0WYyPIy77v48NAoPacDOHIeBoc
        fOL1l44jbcKxhwSKBM2tvXW77mpzHYu7h0JQorsTzWWE4/ISjo1NT0k9WRxzgsXzxw9mmN4nuCN4P
        Q+AP1QZr4xc+62or1r0GTgxm53lL22oGCjQnWG315W/DZ7Mz/qsEqjz0vQ0w7CeHoVTI+Tp6gH4Nt
        XGuvaygw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irYZy-0008Av-6T; Wed, 15 Jan 2020 02:38:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: [PATCH v2 6/9] iomap,xfs: Convert from readpages to readahead
Date:   Tue, 14 Jan 2020 18:38:40 -0800
Message-Id: <20200115023843.31325-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115023843.31325-1-willy@infradead.org>
References: <20200115023843.31325-1-willy@infradead.org>
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
 fs/iomap/buffered-io.c | 72 +++++++++---------------------------------
 fs/iomap/trace.h       |  2 +-
 fs/xfs/xfs_aops.c      | 10 +++---
 include/linux/iomap.h  |  2 +-
 4 files changed, 22 insertions(+), 64 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 828444e14d09..a835b99f281f 100644
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

