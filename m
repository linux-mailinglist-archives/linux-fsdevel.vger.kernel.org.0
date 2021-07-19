Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20E43CEF37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389485AbhGSVfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383720AbhGSSJV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:09:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F121FC061768;
        Mon, 19 Jul 2021 11:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=B4GO5lZHCwERDoxVSozl+ecfyg8sQE9L0PPr0tQ3uNs=; b=YUtfKtGGO+1qS9G9NUA7cCljyY
        P+yGCtnVQAS5iqFAFSfi4NmLIvjEFSYt1EsO7+yKWrP5VyO5xiMa2CFYqOWRm4x4+2jFLDgwFRyaw
        vfIULujqVgTrxrkNMNGl/Qt9P22/v+qgjrp7RsjeQu0lpZt03IsvtvZXDzwhQyokSPRU6UULpCvD1
        9H72o/qzP6K9ZOjQNL1WAXuU1S40SiDWe6+jLoeuJRSUDj+fT0CirfZC7S1CgybTXjyTGuXBT3/4e
        AywVvAE7bLWUvhGZw5vgVAkCN63fAoDmU7KDZtISYqJO2m+8EMbvV1Hcs8m/TdF70EOevUf1+EsGj
        WVvvUDHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YIx-007M0t-EG; Mon, 19 Jul 2021 18:48:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v15 11/17] iomap: Convert readahead and readpage to use a folio
Date:   Mon, 19 Jul 2021 19:39:55 +0100
Message-Id: <20210719184001.1750630-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210719184001.1750630-1-willy@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Handle folios of arbitrary size instead of working in PAGE_SIZE units.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 61 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ee33a4e7b946..dfb2eec520bd 100644
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
@@ -228,8 +228,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap, struct iomap *srcmap)
 {
 	struct iomap_readpage_ctx *ctx = data;
-	struct page *page = ctx->cur_page;
-	struct folio *folio = page_folio(page);
+	struct folio *folio = ctx->cur_folio;
 	struct iomap_page *iop;
 	bool same_page = false, is_contig = false;
 	loff_t orig_pos = pos;
@@ -238,7 +237,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 	if (iomap->type == IOMAP_INLINE) {
 		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, page, iomap);
+		iomap_read_inline_data(inode, &folio->page, iomap);
 		return PAGE_SIZE;
 	}
 
@@ -254,7 +253,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		goto done;
 	}
 
-	ctx->cur_page_in_bio = true;
+	ctx->cur_folio_in_bio = true;
 	if (iop)
 		atomic_add(plen, &iop->read_bytes_pending);
 
@@ -268,7 +267,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	}
 
 	if (!is_contig || bio_full(ctx->bio, plen)) {
-		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
+		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
@@ -307,30 +306,31 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 int
 iomap_readpage(struct page *page, const struct iomap_ops *ops)
 {
-	struct iomap_readpage_ctx ctx = { .cur_page = page };
-	struct inode *inode = page->mapping->host;
-	unsigned poff;
+	struct folio *folio = page_folio(page);
+	struct iomap_readpage_ctx ctx = { .cur_folio = folio };
+	struct inode *inode = folio->mapping->host;
+	size_t poff;
 	loff_t ret;
+	size_t len = folio_size(folio);
 
-	trace_iomap_readpage(page->mapping->host, 1);
+	trace_iomap_readpage(inode, 1);
 
-	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
-		ret = iomap_apply(inode, page_offset(page) + poff,
-				PAGE_SIZE - poff, 0, ops, &ctx,
-				iomap_readpage_actor);
+	for (poff = 0; poff < len; poff += ret) {
+		ret = iomap_apply(inode, folio_pos(folio) + poff, len - poff,
+				0, ops, &ctx, iomap_readpage_actor);
 		if (ret <= 0) {
 			WARN_ON_ONCE(ret == 0);
-			SetPageError(page);
+			folio_set_error(folio);
 			break;
 		}
 	}
 
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
@@ -350,15 +350,15 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
 	loff_t done, ret;
 
 	for (done = 0; done < length; done += ret) {
-		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
-			if (!ctx->cur_page_in_bio)
-				unlock_page(ctx->cur_page);
-			put_page(ctx->cur_page);
-			ctx->cur_page = NULL;
+		if (ctx->cur_folio &&
+		    offset_in_folio(ctx->cur_folio, pos + done) == 0) {
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
 		ret = iomap_readpage_actor(inode, pos + done, length - done,
 				ctx, iomap, srcmap);
@@ -406,10 +406,9 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 
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
2.30.2

