Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D8844798F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbhKHExY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbhKHExJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:53:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FB0C061570;
        Sun,  7 Nov 2021 20:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MSwGyyjT2OJm0b6d3Edmw5CIN5pGSRTORzn8ma//Evg=; b=b0QJFIpClhnpFSpHXXRIQC80Fh
        fbupHNSyuqKh1xIoLHBc4OwtUoGnP/FfYlUSzHadvFEeZLWI4CO2GgiV5LlO83K54MB3FD+QnU+RV
        ugrMYyDm+xKHJMnAk0ZbBSY8doJchhB41gL5BqbIhzKE2ixYi+Ws2cB6Y8NhTPI4mojvFKkqDF1Yb
        b86zXJbZb0Wn/5QGNvSd7DuTfIt4ikrOFhgISw19COwlpll+BWX9HWTzMqvhwyTakGvIHEDMG71TT
        iAkyIp1fB7Ie1aKEuqXrUOLZA/hAaneHUA2G9pLv+vX/+GR9ZHijnQVQiOmqRcHztY4LhyslPaeBm
        g7Kp+NxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwXz-008AOm-RX; Mon, 08 Nov 2021 04:46:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 17/28] iomap: Convert readahead and readpage to use a folio
Date:   Mon,  8 Nov 2021 04:05:40 +0000
Message-Id: <20211108040551.1942823-18-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
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
---
 fs/iomap/buffered-io.c | 53 +++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 96a404f11a3b..b0b402e1779e 100644
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
@@ -243,8 +243,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos + offset;
 	loff_t length = iomap_length(iter) - offset;
-	struct page *page = ctx->cur_page;
-	struct folio *folio = page_folio(page);
+	struct folio *folio = ctx->cur_folio;
 	struct iomap_page *iop;
 	loff_t orig_pos = pos;
 	size_t poff, plen;
@@ -265,7 +264,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		goto done;
 	}
 
-	ctx->cur_page_in_bio = true;
+	ctx->cur_folio_in_bio = true;
 	if (iop)
 		atomic_add(plen, &iop->read_bytes_pending);
 
@@ -273,7 +272,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	if (!ctx->bio ||
 	    bio_end_sector(ctx->bio) != sector ||
 	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
-		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
+		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
@@ -312,30 +311,31 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
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
@@ -354,15 +354,15 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
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
 	}
@@ -403,10 +403,9 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 
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

