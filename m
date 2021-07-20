Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05983CFA9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 15:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbhGTMwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 08:52:39 -0400
Received: from verein.lst.de ([213.95.11.211]:55157 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238738AbhGTMrB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:47:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6EA406736F; Tue, 20 Jul 2021 15:26:44 +0200 (CEST)
Date:   Tue, 20 Jul 2021 15:26:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: simplify iomap_readpage_actor
Message-ID: <20210720132644.GA11913@lst.de>
References: <20210720084320.184877-1-hch@lst.de> <YPbBLCphExqjig1O@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPbBLCphExqjig1O@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 01:27:24PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 20, 2021 at 10:43:19AM +0200, Christoph Hellwig wrote:
> > Now that the outstanding reads are counted in bytes, there is no need
> > to use the low-level __bio_try_merge_page API, we can switch back to
> > always using bio_add_page and simply iomap_readpage_actor again.
> 
> I don't think this quite works.  You need to check the return value
> from bio_add_page(), otherwise you can be in a situation where you try
> to add a page to the last bvec and it's not contiguous, so it fails.

Indeed.  While bio_full covers the number of vectors, if we run out of
bytes in bi_size this won't work.

I think we can do this version, but I haven't tested it yet:

---
From 4198cd5805d45f83c9029743ad5d0ce774a4e0f8 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 12 Jul 2021 11:00:58 +0200
Subject: iomap: simplify iomap_readpage_actor

Now that the outstanding reads are counted in bytes, there is no need
to use the low-level __bio_try_merge_page API, we can switch back to
always using bio_add_page and simply iomap_readpage_actor again.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438becd9..712b6513a0c449 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -241,7 +241,6 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	struct iomap_readpage_ctx *ctx = data;
 	struct page *page = ctx->cur_page;
 	struct iomap_page *iop;
-	bool same_page = false, is_contig = false;
 	loff_t orig_pos = pos;
 	unsigned poff, plen;
 	sector_t sector;
@@ -268,16 +267,10 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	if (iop)
 		atomic_add(plen, &iop->read_bytes_pending);
 
-	/* Try to merge into a previous segment if we can */
 	sector = iomap_sector(iomap, pos);
-	if (ctx->bio && bio_end_sector(ctx->bio) == sector) {
-		if (__bio_try_merge_page(ctx->bio, page, plen, poff,
-				&same_page))
-			goto done;
-		is_contig = true;
-	}
-
-	if (!is_contig || bio_full(ctx->bio, plen)) {
+	if (!ctx->bio ||
+	    bio_end_sector(ctx->bio) != sector ||
+	    bio_add_page(ctx->bio, page, plen, poff) != plen) {
 		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
@@ -301,9 +294,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		ctx->bio->bi_iter.bi_sector = sector;
 		bio_set_dev(ctx->bio, iomap->bdev);
 		ctx->bio->bi_end_io = iomap_read_end_io;
+		__bio_add_page(ctx->bio, page, plen, poff);
 	}
-
-	bio_add_page(ctx->bio, page, plen, poff);
 done:
 	/*
 	 * Move the caller beyond our range so that it keeps making progress.
-- 
2.30.2

