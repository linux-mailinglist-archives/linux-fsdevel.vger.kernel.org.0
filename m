Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3913477E44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbhLPVHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241567AbhLPVHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AFFC061747;
        Thu, 16 Dec 2021 13:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lIhC+u6Nk/VRoSD3IDEbgSu4q9cz/2FSHvcgz8mkQPg=; b=g6p/FtWQQQCkCi4goZMEnOUl0V
        35vyTQnxUP5+9+3NY5r1E8n4dCppjXvVdQ30CkH/ZlAUxaTIBaTgpAJOXDdsUZgf+n8TXk3yplokg
        WE5zyBg4HRgAlUCBvJ23YKQSXogkStGhZdKBnjn4KNH8hfuQhpiCIKeDXtetQtnF4poUYtbjRikZ8
        8VJ2I0ZdLfGjLJHlrJwt87tBrfiKwqcuR/QraPUDS+DMMlTw1CggFUHESTR7KfOM5wS/3cWiRdoBH
        L6/OsDaESosCCL1chaY8/Kqkjpoj8YJwgpKpTr0ZZeyg1uSgQ2Z9/jDh+FyCWXeyjurvXynpgWw3B
        ypfQGemA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyC-00Fx4A-Cb; Thu, 16 Dec 2021 21:07:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 13/25] iomap: Convert readahead and readpage to use a folio
Date:   Thu, 16 Dec 2021 21:07:03 +0000
Message-Id: <20211216210715.3801857-14-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Handle folios of arbitrary size instead of working in PAGE_SIZE units.
readahead_folio() decreases the page refcount for you, so this is not
quite a mechanical change.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 53 +++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2ebea02780b8..ad89c20cb741 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -188,8 +188,8 @@ static void iomap_read_end_io(struct bio *bio)
 }
 
 struct iomap_readpage_ctx {
-	struct page		*cur_page;
-	bool			cur_page_in_bio;
+	struct folio		*cur_folio;
+	bool			cur_folio_in_bio;
 	struct bio		*bio;
 	struct readahead_control *rac;
 };
@@ -252,8 +252,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos + offset;
 	loff_t length = iomap_length(iter) - offset;
-	struct page *page = ctx->cur_page;
-	struct folio *folio = page_folio(page);
+	struct folio *folio = ctx->cur_folio;
 	struct iomap_page *iop;
 	loff_t orig_pos = pos;
 	size_t poff, plen;
@@ -274,7 +273,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		goto done;
 	}
 
-	ctx->cur_page_in_bio = true;
+	ctx->cur_folio_in_bio = true;
 	if (iop)
 		atomic_add(plen, &iop->read_bytes_pending);
 
@@ -282,7 +281,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	if (!ctx->bio ||
 	    bio_end_sector(ctx->bio) != sector ||
 	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
-		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
+		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
@@ -321,30 +320,31 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 int
 iomap_readpage(struct page *page, const struct iomap_ops *ops)
 {
+	struct folio *folio = page_folio(page);
 	struct iomap_iter iter = {
-		.inode		= page->mapping->host,
-		.pos		= page_offset(page),
-		.len		= PAGE_SIZE,
+		.inode		= folio->mapping->host,
+		.pos		= folio_pos(folio),
+		.len		= folio_size(folio),
 	};
 	struct iomap_readpage_ctx ctx = {
-		.cur_page	= page,
+		.cur_folio	= folio,
 	};
 	int ret;
 
-	trace_iomap_readpage(page->mapping->host, 1);
+	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.processed = iomap_readpage_iter(&iter, &ctx, 0);
 
 	if (ret < 0)
-		SetPageError(page);
+		folio_set_error(folio);
 
 	if (ctx.bio) {
 		submit_bio(ctx.bio);
-		WARN_ON_ONCE(!ctx.cur_page_in_bio);
+		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
 	} else {
-		WARN_ON_ONCE(ctx.cur_page_in_bio);
-		unlock_page(page);
+		WARN_ON_ONCE(ctx.cur_folio_in_bio);
+		folio_unlock(folio);
 	}
 
 	/*
@@ -363,15 +363,15 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
 	loff_t done, ret;
 
 	for (done = 0; done < length; done += ret) {
-		if (ctx->cur_page && offset_in_page(iter->pos + done) == 0) {
-			if (!ctx->cur_page_in_bio)
-				unlock_page(ctx->cur_page);
-			put_page(ctx->cur_page);
-			ctx->cur_page = NULL;
+		if (ctx->cur_folio &&
+		    offset_in_folio(ctx->cur_folio, iter->pos + done) == 0) {
+			if (!ctx->cur_folio_in_bio)
+				folio_unlock(ctx->cur_folio);
+			ctx->cur_folio = NULL;
 		}
-		if (!ctx->cur_page) {
-			ctx->cur_page = readahead_page(ctx->rac);
-			ctx->cur_page_in_bio = false;
+		if (!ctx->cur_folio) {
+			ctx->cur_folio = readahead_folio(ctx->rac);
+			ctx->cur_folio_in_bio = false;
 		}
 		ret = iomap_readpage_iter(iter, ctx, done);
 		if (ret <= 0)
@@ -414,10 +414,9 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 
 	if (ctx.bio)
 		submit_bio(ctx.bio);
-	if (ctx.cur_page) {
-		if (!ctx.cur_page_in_bio)
-			unlock_page(ctx.cur_page);
-		put_page(ctx.cur_page);
+	if (ctx.cur_folio) {
+		if (!ctx.cur_folio_in_bio)
+			folio_unlock(ctx.cur_folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
-- 
2.33.0

