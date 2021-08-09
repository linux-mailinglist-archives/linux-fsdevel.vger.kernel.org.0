Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5855C3E3FD2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 08:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhHIGYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 02:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhHIGYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:24:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482BDC0613CF;
        Sun,  8 Aug 2021 23:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qwdYCMgr4Eo/JFSTiT6SOAc1ZPJDm8LbyNY4tJJiNew=; b=isJqi0cq+RHnCGkP+f6vNi1rde
        7sOb0X8VPS5lgg2MpZmVtynovLz1/a8kveOk6/zV48hBB8ytLUai2bQfe0JpFfhppSCJKVRu1hlGG
        turMtw7un731Doar1kAUzMWwExS8t9OPfGXQiJwJOkzh3th7rjunYbB4aOFf8QxwVlH4ChtT71yN2
        BSmSHs6W3L7bZfWI9yY87L5V2wjXYbdcxPgp0XBoR5pqOhdvQumO5VeiTGTF/kkIFl9g4qv7oYTd1
        1T24ofJzjO2p6ooPgz/ZDMX2ihHU0qt13LuIgpXVC7i2/ONrcIiuhKJEe0OjwBDa0Ib5pu3xBP47H
        SA/ZVAiQ==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCyfd-00Ah0F-WD; Mon, 09 Aug 2021 06:22:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 12/30] iomap: switch readahead and readpage to use iomap_iter
Date:   Mon,  9 Aug 2021 08:12:26 +0200
Message-Id: <20210809061244.1196573-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809061244.1196573-1-hch@lst.de>
References: <20210809061244.1196573-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch the page cache read functions to use iomap_iter instead of
iomap_apply.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 80 +++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 43 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 26e16cc9d44931..9cda461887afad 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -241,11 +241,12 @@ static inline bool iomap_block_needs_zeroing(struct inode *inode,
 		pos >= i_size_read(inode);
 }
 
-static loff_t
-iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+static loff_t iomap_readpage_iter(struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx, loff_t offset)
 {
-	struct iomap_readpage_ctx *ctx = data;
+	struct iomap *iomap = &iter->iomap;
+	loff_t pos = iter->pos + offset;
+	loff_t length = iomap_length(iter) - offset;
 	struct page *page = ctx->cur_page;
 	struct iomap_page *iop;
 	loff_t orig_pos = pos;
@@ -253,15 +254,16 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	sector_t sector;
 
 	if (iomap->type == IOMAP_INLINE)
-		return min(iomap_read_inline_data(inode, page, iomap), length);
+		return min(iomap_read_inline_data(iter->inode, page, iomap),
+						  length);
 
 	/* zero post-eof blocks as the page may be mapped */
-	iop = iomap_page_create(inode, page);
-	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
+	iop = iomap_page_create(iter->inode, page);
+	iomap_adjust_read_range(iter->inode, iop, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
 
-	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
+	if (iomap_block_needs_zeroing(iter->inode, iomap, pos)) {
 		zero_user(page, poff, plen);
 		iomap_set_range_uptodate(page, poff, plen);
 		goto done;
@@ -313,23 +315,23 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 int
 iomap_readpage(struct page *page, const struct iomap_ops *ops)
 {
-	struct iomap_readpage_ctx ctx = { .cur_page = page };
-	struct inode *inode = page->mapping->host;
-	unsigned poff;
-	loff_t ret;
+	struct iomap_iter iter = {
+		.inode		= page->mapping->host,
+		.pos		= page_offset(page),
+		.len		= PAGE_SIZE,
+	};
+	struct iomap_readpage_ctx ctx = {
+		.cur_page	= page,
+	};
+	int ret;
 
 	trace_iomap_readpage(page->mapping->host, 1);
 
-	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
-		ret = iomap_apply(inode, page_offset(page) + poff,
-				PAGE_SIZE - poff, 0, ops, &ctx,
-				iomap_readpage_actor);
-		if (ret <= 0) {
-			WARN_ON_ONCE(ret == 0);
-			SetPageError(page);
-			break;
-		}
-	}
+	while ((ret = iomap_iter(&iter, ops)) > 0)
+		iter.processed = iomap_readpage_iter(&iter, &ctx, 0);
+
+	if (ret < 0)
+		SetPageError(page);
 
 	if (ctx.bio) {
 		submit_bio(ctx.bio);
@@ -348,15 +350,14 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readpage);
 
-static loff_t
-iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+static loff_t iomap_readahead_iter(struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx)
 {
-	struct iomap_readpage_ctx *ctx = data;
+	loff_t length = iomap_length(iter);
 	loff_t done, ret;
 
 	for (done = 0; done < length; done += ret) {
-		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
+		if (ctx->cur_page && offset_in_page(iter->pos + done) == 0) {
 			if (!ctx->cur_page_in_bio)
 				unlock_page(ctx->cur_page);
 			put_page(ctx->cur_page);
@@ -366,8 +367,7 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
 			ctx->cur_page = readahead_page(ctx->rac);
 			ctx->cur_page_in_bio = false;
 		}
-		ret = iomap_readpage_actor(inode, pos + done, length - done,
-				ctx, iomap, srcmap);
+		ret = iomap_readpage_iter(iter, ctx, done);
 	}
 
 	return done;
@@ -390,25 +390,19 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
  */
 void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 {
-	struct inode *inode = rac->mapping->host;
-	loff_t pos = readahead_pos(rac);
-	size_t length = readahead_length(rac);
+	struct iomap_iter iter = {
+		.inode	= rac->mapping->host,
+		.pos	= readahead_pos(rac),
+		.len	= readahead_length(rac),
+	};
 	struct iomap_readpage_ctx ctx = {
 		.rac	= rac,
 	};
 
-	trace_iomap_readahead(inode, readahead_count(rac));
+	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
-	while (length > 0) {
-		ssize_t ret = iomap_apply(inode, pos, length, 0, ops,
-				&ctx, iomap_readahead_actor);
-		if (ret <= 0) {
-			WARN_ON_ONCE(ret == 0);
-			break;
-		}
-		pos += ret;
-		length -= ret;
-	}
+	while (iomap_iter(&iter, ops) > 0)
+		iter.processed = iomap_readahead_iter(&iter, &ctx);
 
 	if (ctx.bio)
 		submit_bio(ctx.bio);
-- 
2.30.2

