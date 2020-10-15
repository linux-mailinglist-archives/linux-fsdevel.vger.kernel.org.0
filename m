Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA1428EF7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 11:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388843AbgJOJmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388795AbgJOJmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:42:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A349C061755;
        Thu, 15 Oct 2020 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5ZNMyaMGLyh0iAzgchZNWKe2QHg2PouniT97lm2hLjc=; b=UbzTDpbCdU/uUj0rHetupp4L8v
        PaUluuLxr8LZvOCbK9ck4YLDi3+zPB/hmdH1KgeWEQy8Co2xXtMtUhhVl9GuJYbtbnLeCYd76TNBS
        HZdz95qNkGmkZVezmYCzg8HJhkMbKqv1Xzk2iHdAGnB93fydw7f720JSiZsLwGL22D4bQXb6udDfh
        PL01QS5q/vOm7rs0lz6hK4oIgOO7vvQYNc16v1alatMUt6a+VXectLz3GydJeK3X0T3ZVV1HjE6ii
        B2gLxhncLeJgIGpvtuBsx546BEOgs/6FT1ows1Phr2vQszB8BnyKkzc5Y6LhzlbR7Y0dCe+NH+Dss
        rHuYJitg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSzlr-0005i9-5C; Thu, 15 Oct 2020 09:42:03 +0000
Date:   Thu, 15 Oct 2020 10:42:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 16/16] iomap: Make readpage synchronous
Message-ID: <20201015094203.GA21420@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009143104.22673-17-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static void iomap_read_page_end_io(struct bio_vec *bvec,
> +		struct completion *done, bool error)

I really don't like the parameters here.  Part of the problem is
that ctx is only assigned to bi_private conditionally, which can
easily be fixed.  The other part is the strange bool error when
we can just pass on bi_stats.  See the patch at the end of what
I'd do intead.

> @@ -318,15 +325,17 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
>  
>  	trace_iomap_readpage(page->mapping->host, 1);
>  
> +	ctx.status = BLK_STS_OK;

This should move into the initializer for ctx.  Or we could just drop
it given that BLK_STS_OK is and must always be 0.

>  	} else {
>  		WARN_ON_ONCE(ctx.cur_page_in_bio);
> -		unlock_page(page);
> +		complete(&ctx.done);
>  	}
>  
> +	wait_for_completion(&ctx.done);

I don't think we need the complete / wait_for_completion dance in
this case.

> +	if (ret >= 0)
> +		ret = blk_status_to_errno(ctx.status);
> +	if (ret == 0)
> +		return AOP_UPDATED_PAGE;
> +	unlock_page(page);
> +	return ret;

Nipick, but I'd rather have a goto out_unlock for both error case
and have the AOP_UPDATED_PAGE for the normal path straight in line.

Here is an untested patch with my suggestions:


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 887bf871ca9bba..81d34725565d7e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -162,33 +162,34 @@ static void iomap_set_range_uptodate(struct page *page, unsigned off,
 	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
 }
 
-static void iomap_read_page_end_io(struct bio_vec *bvec,
-		struct completion *done, bool error)
+struct iomap_readpage_ctx {
+	struct page		*cur_page;
+	bool			cur_page_in_bio;
+	blk_status_t		status;
+	struct bio		*bio;
+	struct readahead_control *rac;
+	struct completion	done;
+};
+
+static void
+iomap_read_page_end_io(struct iomap_readpage_ctx *ctx, struct bio_vec *bvec,
+		blk_status_t status)
 {
 	struct page *page = bvec->bv_page;
 	struct iomap_page *iop = to_iomap_page(page);
 
-	if (!error)
+	if (status == BLK_STS_OK)
 		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
 
 	if (!iop ||
 	    atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending)) {
-		if (done)
-			complete(done);
-		else
+		if (ctx->rac)
 			unlock_page(page);
+		else
+			complete(&ctx->done);
 	}
 }
 
-struct iomap_readpage_ctx {
-	struct page		*cur_page;
-	bool			cur_page_in_bio;
-	blk_status_t		status;
-	struct bio		*bio;
-	struct readahead_control *rac;
-	struct completion	done;
-};
-
 static void
 iomap_read_end_io(struct bio *bio)
 {
@@ -197,12 +198,11 @@ iomap_read_end_io(struct bio *bio)
 	struct bvec_iter_all iter_all;
 
 	/* Capture the first error */
-	if (ctx && ctx->status == BLK_STS_OK)
+	if (ctx->status == BLK_STS_OK)
 		ctx->status = bio->bi_status;
 
 	bio_for_each_segment_all(bvec, bio, iter_all)
-		iomap_read_page_end_io(bvec, ctx ? &ctx->done : NULL,
-				bio->bi_status != BLK_STS_OK);
+		iomap_read_page_end_io(ctx, bvec, bio->bi_status);
 	bio_put(bio);
 }
 
@@ -297,8 +297,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		ctx->bio->bi_opf = REQ_OP_READ;
 		if (ctx->rac)
 			ctx->bio->bi_opf |= REQ_RAHEAD;
-		else
-			ctx->bio->bi_private = ctx;
+		ctx->bio->bi_private = ctx;
 		ctx->bio->bi_iter.bi_sector = sector;
 		bio_set_dev(ctx->bio, iomap->bdev);
 		ctx->bio->bi_end_io = iomap_read_end_io;
@@ -318,14 +317,16 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 int
 iomap_readpage(struct page *page, const struct iomap_ops *ops)
 {
-	struct iomap_readpage_ctx ctx = { .cur_page = page };
+	struct iomap_readpage_ctx ctx = {
+		.cur_page	= page,
+		.status		= BLK_STS_OK,
+	};
 	struct inode *inode = page->mapping->host;
 	unsigned poff;
 	loff_t ret;
 
 	trace_iomap_readpage(page->mapping->host, 1);
 
-	ctx.status = BLK_STS_OK;
 	init_completion(&ctx.done);
 
 	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
@@ -340,17 +341,16 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 
 	if (ctx.bio) {
 		submit_bio(ctx.bio);
-		WARN_ON_ONCE(!ctx.cur_page_in_bio);
-	} else {
-		WARN_ON_ONCE(ctx.cur_page_in_bio);
-		complete(&ctx.done);
+		wait_for_completion(&ctx.done);
 	}
 
-	wait_for_completion(&ctx.done);
-	if (ret >= 0)
-		ret = blk_status_to_errno(ctx.status);
-	if (ret == 0)
-		return AOP_UPDATED_PAGE;
+	if (ret < 0)
+		goto out_unlock;
+	ret = blk_status_to_errno(ctx.status);
+	if (ret < 0)
+		goto out_unlock;
+	return AOP_UPDATED_PAGE;
+out_unlock:
 	unlock_page(page);
 	return ret;
 }
