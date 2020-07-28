Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62F42310FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 19:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbgG1RcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 13:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732017AbgG1RcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:32:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ECCC0619D2;
        Tue, 28 Jul 2020 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ymwyLR6E9FBcV6Ft90yQ2Cyth/yiRVXdOd0/9Ew87Fw=; b=Ws68dMdVOQtjwvOo89K8dy9a3M
        slVMe+G2IHm2vd5YSdeiUe3K13mJ0IOo8oW1Izu1e1SDovm96RTePzrbNsAVzKHaN3wfCkO+1dhP/
        tl153zNybYGgZRgOF6a5mfkqEqhBpUoY/t7WQEJlQy6XrfdcWodSyWSJzatJobKilIM3futKlQY8s
        ByfxfFeoPY+CMVlOkBVN6+THCTiW9z7rDJBcuPCrAGM+SuEwd6mJMcKYxsX9jDWebskWVY0lQWmpY
        XtDEEIf5+Ru+57JJ9jgHmataTmnvy8aK+9r/jM/6LUmHkdZkYdUF0bNL6CZm+DRg216eRYwlA3L5f
        zTAWTIRw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0TSd-0001tN-G0; Tue, 28 Jul 2020 17:32:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] iomap: Convert readahead to iomap_iter
Date:   Tue, 28 Jul 2020 18:32:15 +0100
Message-Id: <20200728173216.7184-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200728173216.7184-1-willy@infradead.org>
References: <20200728173216.7184-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This approach removes at least two indirect function calls from the
readahead path.  Previous call chain (indirect function calls marked *):

xfs_vm_readahead
  iomap_readahead
    iomap_apply
      xfs_read_iomap_begin [*]
      iomap_readahead_actor [*]
        iomap_readpage_actor

New call chain:

xfs_vm_readahead
  xfs_iomap_next_read
  iomi_advance
  iomap_readahead
    iomap_readpage_actor

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 82 ++++++++++++++----------------------------
 fs/xfs/xfs_aops.c      |  9 ++++-
 fs/xfs/xfs_iomap.c     | 15 ++++++++
 fs/xfs/xfs_iomap.h     |  2 ++
 fs/zonefs/super.c      | 20 ++++++++++-
 include/linux/iomap.h  | 10 +++++-
 6 files changed, 79 insertions(+), 59 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..fff23ed6a682 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -206,13 +206,6 @@ iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-struct iomap_readpage_ctx {
-	struct page		*cur_page;
-	bool			cur_page_in_bio;
-	struct bio		*bio;
-	struct readahead_control *rac;
-};
-
 static void
 iomap_read_inline_data(struct inode *inode, struct page *page,
 		struct iomap *iomap)
@@ -369,35 +362,10 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readpage);
 
-static loff_t
-iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
-{
-	struct iomap_readpage_ctx *ctx = data;
-	loff_t done, ret;
-
-	for (done = 0; done < length; done += ret) {
-		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
-			if (!ctx->cur_page_in_bio)
-				unlock_page(ctx->cur_page);
-			put_page(ctx->cur_page);
-			ctx->cur_page = NULL;
-		}
-		if (!ctx->cur_page) {
-			ctx->cur_page = readahead_page(ctx->rac);
-			ctx->cur_page_in_bio = false;
-		}
-		ret = iomap_readpage_actor(inode, pos + done, length - done,
-				ctx, iomap, srcmap);
-	}
-
-	return done;
-}
-
 /**
  * iomap_readahead - Attempt to read pages from a file.
+ * @iomi: The iomap iterator for this operation.
  * @rac: Describes the pages to be read.
- * @ops: The operations vector for the filesystem.
  *
  * This function is for filesystems to call to implement their readahead
  * address_space operation.
@@ -409,35 +377,37 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
  * function is called with memalloc_nofs set, so allocations will not cause
  * the filesystem to be reentered.
  */
-void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
+loff_t iomap_readahead(struct iomap_iter *iomi, struct iomap_readpage_ctx *ctx)
 {
-	struct inode *inode = rac->mapping->host;
-	loff_t pos = readahead_pos(rac);
-	loff_t length = readahead_length(rac);
-	struct iomap_readpage_ctx ctx = {
-		.rac	= rac,
-	};
-
-	trace_iomap_readahead(inode, readahead_count(rac));
+	loff_t done, ret, length = iomap_length(iomi);
 
-	while (length > 0) {
-		loff_t ret = iomap_apply(inode, pos, length, 0, ops,
-				&ctx, iomap_readahead_actor);
-		if (ret <= 0) {
-			WARN_ON_ONCE(ret == 0);
-			break;
+	for (done = 0; done < length; done += ret) {
+		if (ctx->cur_page && offset_in_page(iomi->pos + done) == 0) {
+			if (!ctx->cur_page_in_bio)
+				unlock_page(ctx->cur_page);
+			put_page(ctx->cur_page);
+			ctx->cur_page = NULL;
 		}
-		pos += ret;
-		length -= ret;
+		if (!ctx->cur_page) {
+			ctx->cur_page = readahead_page(ctx->rac);
+			ctx->cur_page_in_bio = false;
+		}
+		ret = iomap_readpage_actor(iomi->inode, iomi->pos + done,
+				length - done, ctx,
+				&iomi->iomap, &iomi->srcmap);
 	}
 
-	if (ctx.bio)
-		submit_bio(ctx.bio);
-	if (ctx.cur_page) {
-		if (!ctx.cur_page_in_bio)
-			unlock_page(ctx.cur_page);
-		put_page(ctx.cur_page);
+	if (iomi->len == done) {
+		if (ctx->bio)
+			submit_bio(ctx->bio);
+		if (ctx->cur_page) {
+			if (!ctx->cur_page_in_bio)
+				unlock_page(ctx->cur_page);
+			put_page(ctx->cur_page);
+		}
 	}
+
+	return done;
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index b35611882ff9..2884752e40e8 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -625,7 +625,14 @@ STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops);
+	IOMAP_ITER(iomi, rac->mapping->host, readahead_pos(rac),
+			readahead_length(rac), 0);
+	struct iomap_readpage_ctx ctx = {
+		.rac = rac,
+	};
+
+	while (iomap_iter(&iomi, xfs_iomap_next_read))
+		iomi.copied = iomap_readahead(&iomi, &ctx);
 }
 
 static int
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 0e3f62cde375..66f2fcaf136e 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1150,6 +1150,21 @@ const struct iomap_ops xfs_read_iomap_ops = {
 	.iomap_begin		= xfs_read_iomap_begin,
 };
 
+int
+xfs_iomap_next_read(
+	const struct iomap_iter *iomi,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	if (iomi->copied < 0)
+		return iomi->copied;
+	if (iomi->copied >= iomi->len)
+		return 0;
+
+	return xfs_read_iomap_begin(iomi->inode, iomi->pos + iomi->copied,
+			iomi->len - iomi->copied, iomi->flags, iomap, srcmap);
+}
+
 static int
 xfs_seek_iomap_begin(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 7d3703556d0e..1b1fa225e938 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -46,4 +46,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 
+int xfs_iomap_next_read(const struct iomap_iter *iomi, struct iomap *iomap,
+		struct iomap *srcmap);
 #endif /* __XFS_IOMAP_H__*/
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 07bc42d62673..4842b85ce36d 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -70,6 +70,17 @@ static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static int zonefs_iomap_next(const struct iomap_iter *iomi,
+		struct iomap *iomap, struct iomap *srcmap)
+{
+	if (iomi->copied < 0)
+		return iomi->copied;
+	if (iomi->copied >= iomi->len)
+		return 0;
+	return zonefs_iomap_begin(iomi->inode, iomi->pos + iomi->copied,
+			iomi->len - iomi->copied, iomi->flags, iomap, srcmap);
+}
+
 static const struct iomap_ops zonefs_iomap_ops = {
 	.iomap_begin	= zonefs_iomap_begin,
 };
@@ -81,7 +92,14 @@ static int zonefs_readpage(struct file *unused, struct page *page)
 
 static void zonefs_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &zonefs_iomap_ops);
+	IOMAP_ITER(iomi, rac->mapping->host, readahead_pos(rac),
+			readahead_length(rac), 0);
+	struct iomap_readpage_ctx ctx = {
+		.rac = rac,
+	};
+
+	while (iomap_iter(&iomi, zonefs_iomap_next))
+		iomi.copied = iomap_readahead(&iomi, &ctx);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index fe58e68ec0c1..dd9bfed85c4f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -212,7 +212,6 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
-void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 int iomap_set_page_dirty(struct page *page);
 int iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count);
@@ -299,6 +298,15 @@ int iomap_writepages(struct address_space *mapping,
 		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
 		const struct iomap_writeback_ops *ops);
 
+struct iomap_readpage_ctx {
+	struct page		*cur_page;
+	bool			cur_page_in_bio;
+	struct bio		*bio;
+	struct readahead_control *rac;
+};
+
+loff_t iomap_readahead(struct iomap_iter *, struct iomap_readpage_ctx *);
+
 /*
  * Flags for direct I/O ->end_io:
  */
-- 
2.27.0

