Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8F73D2CD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 21:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhGVSyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 14:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhGVSyW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 14:54:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CA1660EB5;
        Thu, 22 Jul 2021 19:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626982497;
        bh=afHQgsU9EA77bBjM3zlqfDOIyqY+GB2FnMX0Ut033yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NXad0qAwOTcXprN32IhIIwB3GUm7/PSBBwalNZp1oWzamipe+N+udatiL9wRZ4pRq
         Bt/ACLdCTOQL6tiI644Td6EpzCIqrue3XASiXQHeCTqzevqt7vuAUOPRU4ICo3vB7P
         mYXgOr/Z1FSswrXrYb35lqFaGWyQAzDSMRcY8tbmS8/TxRLx0HZodx/zOPcMqKgOc8
         xlxHnwNF0drAnIlWTG8oLLGhYMgcnElLvtpKEXcXov9j2dhvCemoQ+gWIo9+vK5ATo
         oy756KKZZyqhMAJfpXppyDYbU4qHh739viz6T9I+tpOU4ccVIyZkPTnYnAf8oJzyRX
         V5cBzA/SUE/Tg==
Date:   Thu, 22 Jul 2021 12:34:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] iomap: simplify iomap_readpage_actor
Message-ID: <20210722193456.GM559212@magnolia>
References: <20210722054256.932965-1-hch@lst.de>
 <20210722054256.932965-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722054256.932965-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 07:42:55AM +0200, Christoph Hellwig wrote:
> Now that the outstanding reads are counted in bytes, there is no need
> to use the low-level __bio_try_merge_page API, we can switch back to
> always using bio_add_page and simply iomap_readpage_actor again.

s/simply/simplify/ ?

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

With that corrected,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 0597f5c186a33f..7898c1c47370e6 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -245,7 +245,6 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	struct iomap_readpage_ctx *ctx = data;
>  	struct page *page = ctx->cur_page;
>  	struct iomap_page *iop;
> -	bool same_page = false, is_contig = false;
>  	loff_t orig_pos = pos;
>  	unsigned poff, plen;
>  	sector_t sector;
> @@ -269,16 +268,10 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	if (iop)
>  		atomic_add(plen, &iop->read_bytes_pending);
>  
> -	/* Try to merge into a previous segment if we can */
>  	sector = iomap_sector(iomap, pos);
> -	if (ctx->bio && bio_end_sector(ctx->bio) == sector) {
> -		if (__bio_try_merge_page(ctx->bio, page, plen, poff,
> -				&same_page))
> -			goto done;
> -		is_contig = true;
> -	}
> -
> -	if (!is_contig || bio_full(ctx->bio, plen)) {
> +	if (!ctx->bio ||
> +	    bio_end_sector(ctx->bio) != sector ||
> +	    bio_add_page(ctx->bio, page, plen, poff) != plen) {
>  		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
>  		gfp_t orig_gfp = gfp;
>  		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
> @@ -302,9 +295,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		ctx->bio->bi_iter.bi_sector = sector;
>  		bio_set_dev(ctx->bio, iomap->bdev);
>  		ctx->bio->bi_end_io = iomap_read_end_io;
> +		__bio_add_page(ctx->bio, page, plen, poff);
>  	}
> -
> -	bio_add_page(ctx->bio, page, plen, poff);
>  done:
>  	/*
>  	 * Move the caller beyond our range so that it keeps making progress.
> -- 
> 2.30.2
> 
