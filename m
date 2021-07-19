Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C730B3CD2AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 12:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhGSKHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbhGSKHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA9BC061574;
        Mon, 19 Jul 2021 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/QU5WiIVBl1o3n6OtSKZLy5AvZdsxnl/xG+R5mpsDr8=; b=BJZdsh5vBwPPScfEpV2ez02Dct
        oaHzv9/DDX4ahKzXm/NUU/hjp9clzfK+sVhx7UbrtJOl610okwZPrpYJjuqNBoJ59t9UCNX/R6d5J
        Z8AP5rOKKA0ZN8qpXFTHJKEXbPo2pBQU6IQoS48lsSiKXH0ck8BZG+yPBAqn+YWNXX9j9O0r3ZExc
        /oj2Hjbo9JhUt9y1v/YS/3smCmfcQqtZPgGDxp6EhJWItKIdUPmjRbWAnTeCTz8XM3fBzPVIftd9D
        tyzHi/E8Pn4EJ6NA923cLruZmncxVzjcsrieYs/20sbWHP8JJSbO+X8dOxQGFeNr2DMGPRktC02o+
        QyoUbsqw==;
Received: from [2001:4bb8:193:7660:d2a4:8d57:2e55:21d0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5QkV-006kzJ-4k; Mon, 19 Jul 2021 10:44:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 09/27] iomap: switch readahead and readpage to use iomap_iter
Date:   Mon, 19 Jul 2021 12:35:02 +0200
Message-Id: <20210719103520.495450-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719103520.495450-1-hch@lst.de>
References: <20210719103520.495450-1-hch@lst.de>
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
 fs/iomap/buffered-io.c | 79 +++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 43 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8c26cf7cbd72b0..3b18cafa72bec6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -234,11 +234,12 @@ static inline bool iomap_block_needs_zeroing(struct inode *inode,
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
 	bool same_page = false, is_contig = false;
@@ -248,17 +249,17 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 	if (iomap->type == IOMAP_INLINE) {
 		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, page, iomap);
+		iomap_read_inline_data(iter->inode, page, iomap);
 		return PAGE_SIZE;
 	}
 
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
@@ -317,23 +318,23 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
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
@@ -352,15 +353,14 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
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
@@ -370,8 +370,7 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
 			ctx->cur_page = readahead_page(ctx->rac);
 			ctx->cur_page_in_bio = false;
 		}
-		ret = iomap_readpage_actor(inode, pos + done, length - done,
-				ctx, iomap, srcmap);
+		ret = iomap_readpage_iter(iter, ctx, done);
 	}
 
 	return done;
@@ -394,25 +393,19 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
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

