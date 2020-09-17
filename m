Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5E926E931
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 00:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgIQW45 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 18:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgIQW44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:56:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D2AC06174A;
        Thu, 17 Sep 2020 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sKL/iWIcj7kseW56eZGIbOn0qPY+XDTbdfqR4zUQiv0=; b=m4WIwEzpF3pzAH8AOsbTv9/H2W
        SEhCFUUEY/+1Mh71FJkb99Ph/DL5OyylHBDOEXBlo0eNz2ocoCL7BwssqAzcXjZMy1TOW8RWyo/5b
        Huu45Fi5JmlJBgM+obba4IWeHHRasZlFWE4SCeGUomrMhJwVfwkR68bTbiteJAgUFLjB/wdaY41ub
        6YCgFO7dyayMBvVqEj6SzgNPTM9UKnEO6WrFCYcPxUp5ITQFP1l7wzUHYvtLrQff5mXbX1WBO4U30
        yCcfqm9M6PE3PqMkFLNatvDktKKnDKYKRuCIUI9AIiJLHSo2qb3vy5uTKHc476peEMDH3+GSJxLNP
        WAvdIDkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ2pi-0006uF-Kx; Thu, 17 Sep 2020 22:56:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org
Subject: [PATCH 16/13] iomap: Make readpage synchronous
Date:   Thu, 17 Sep 2020 23:56:47 +0100
Message-Id: <20200917225647.26481-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917225647.26481-1-willy@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917225647.26481-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A synchronous readpage lets us report the actual errno instead of
ineffectively setting PageError.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 64 +++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 13b56d656337..aec95996bd4b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -146,9 +146,6 @@ void iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	unsigned long flags;
 	unsigned int i;
 
-	if (PageError(page))
-		return;
-
 	if (!iop) {
 		SetPageUptodate(page);
 		return;
@@ -167,32 +164,41 @@ void iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
 }
 
-static void
-iomap_read_page_end_io(struct bio_vec *bvec, int error)
+struct iomap_sync_end {
+	blk_status_t status;
+	struct completion done;
+};
+
+static void iomap_read_page_end_io(struct bio_vec *bvec,
+		struct iomap_sync_end *end, bool error)
 {
 	struct page *page = bvec->bv_page;
 	struct iomap_page *iop = to_iomap_page(page);
 
-	if (unlikely(error)) {
-		ClearPageUptodate(page);
-		SetPageError(page);
-	} else {
+	if (!error)
 		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
-	}
 
-	if (!iop || atomic_dec_and_test(&iop->read_count))
-		unlock_page(page);
+	if (!iop || atomic_dec_and_test(&iop->read_count)) {
+		if (end)
+			complete(&end->done);
+		else
+			unlock_page(page);
+	}
 }
 
 static void
 iomap_read_end_io(struct bio *bio)
 {
-	int error = blk_status_to_errno(bio->bi_status);
+	struct iomap_sync_end *end = bio->bi_private;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
+	/* Capture the first error */
+	if (end && end->status == BLK_STS_OK)
+		end->status = bio->bi_status;
+
 	bio_for_each_segment_all(bvec, bio, iter_all)
-		iomap_read_page_end_io(bvec, error);
+		iomap_read_page_end_io(bvec, end, bio->bi_status != BLK_STS_OK);
 	bio_put(bio);
 }
 
@@ -201,6 +207,7 @@ struct iomap_readpage_ctx {
 	bool			cur_page_in_bio;
 	struct bio		*bio;
 	struct readahead_control *rac;
+	struct iomap_sync_end	*end;
 };
 
 static void
@@ -307,6 +314,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			ctx->bio->bi_opf |= REQ_RAHEAD;
 		ctx->bio->bi_iter.bi_sector = sector;
 		bio_set_dev(ctx->bio, iomap->bdev);
+		ctx->bio->bi_private = ctx->end;
 		ctx->bio->bi_end_io = iomap_read_end_io;
 	}
 
@@ -324,22 +332,25 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 int
 iomap_readpage(struct page *page, const struct iomap_ops *ops)
 {
-	struct iomap_readpage_ctx ctx = { .cur_page = page };
+	struct iomap_sync_end end;
+	struct iomap_readpage_ctx ctx = { .cur_page = page, .end = &end, };
 	struct inode *inode = page->mapping->host;
 	unsigned poff;
 	loff_t ret;
 
 	trace_iomap_readpage(page->mapping->host, 1);
 
+	end.status = BLK_STS_OK;
+	init_completion(&end.done);
+
 	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
 		ret = iomap_apply(inode, page_offset(page) + poff,
 				PAGE_SIZE - poff, 0, ops, &ctx,
 				iomap_readpage_actor);
-		if (ret <= 0) {
-			WARN_ON_ONCE(ret == 0);
-			SetPageError(page);
+		if (WARN_ON_ONCE(ret == 0))
+			ret = -EIO;
+		if (ret < 0)
 			break;
-		}
 	}
 
 	if (ctx.bio) {
@@ -347,15 +358,16 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 		WARN_ON_ONCE(!ctx.cur_page_in_bio);
 	} else {
 		WARN_ON_ONCE(ctx.cur_page_in_bio);
-		unlock_page(page);
+		complete(&end.done);
 	}
 
-	/*
-	 * Just like mpage_readahead and block_read_full_page we always
-	 * return 0 and just mark the page as PageError on errors.  This
-	 * should be cleaned up all through the stack eventually.
-	 */
-	return 0;
+	wait_for_completion(&end.done);
+	if (ret >= 0)
+		ret = blk_status_to_errno(end.status);
+	if (ret == 0)
+		return AOP_UPDATED_PAGE;
+	unlock_page(page);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_readpage);
 
-- 
2.28.0

