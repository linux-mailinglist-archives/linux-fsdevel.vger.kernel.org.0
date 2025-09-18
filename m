Return-Path: <linux-fsdevel+bounces-62181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A42BB873C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 00:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516E07C8134
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 22:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020442FBDFF;
	Thu, 18 Sep 2025 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LypBu7KJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8998BEE;
	Thu, 18 Sep 2025 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234692; cv=none; b=Kphw2IR58hjGk+tcO6zXAgCGXBCMzKK1x+x1/O6+++zDELg6rKh5BcW6m/pTjQUyfcxB7uYqbU6aJqUW4rowr4az5PaQq/M4fT3XbhOSIU4kTbudQ3OUni6utp7XvlYR1JFSl3noRTjXkaqATaaY9bHHUkl9uVN6WJWSxuXJs70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234692; c=relaxed/simple;
	bh=cXNx/gAH9f1jvWsTEILCAoIU9qzvSQeAIYdhjVNy1wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsbcVtBWLvHPL6TGqpgnQUMOmo2qS5y5zrFneikigWWVsGWqPTyS2CounYfCkpNRYcZUcTD1eT133xl7YMcjrTlAD821RCrYemW1shnfPJxQP492P+ShQqKMV9hlcKa04jaxSLEvm1Y6/OVQI1ih1x3XoRP0ydHx580xcu76nkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LypBu7KJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA15C4CEE7;
	Thu, 18 Sep 2025 22:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758234691;
	bh=cXNx/gAH9f1jvWsTEILCAoIU9qzvSQeAIYdhjVNy1wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LypBu7KJ1IBDKjeIUbjdI3SK/Y4AyNrpYKhIHA141RTlm2dRSu1x+BuCmDBBLgegj
	 EPLpB0r/Lsjiye3geNky7YxNx5ctV8SngLN0o+InfY4QX12C2Ei9sU/YDXGdMHY65s
	 VTdmmzWwOQDt+y5ND5YP7Q4AT7hGCGd36bmhR8PPjS6GtUcuiplxdRdZ9EALRUc9Vr
	 M3ZXOBP50E9G+/iWVRaWDuPZdIG/NZzMrbWnUmKKYx+iFipqMuQx04lXuCiPqS7O9k
	 UsJh4uJE4n5RPDADtS0D5rcAfm7PkoOJjFHjK2cb55GneqkwR54lRT3KqEYy4mibE7
	 0gaoKSLR4iGvQ==
Date: Thu, 18 Sep 2025 15:31:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 11/15] iomap: move buffered io bio logic into new file
Message-ID: <20250918223131.GZ1587915@frogsfrogsfrogs>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-12-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916234425.1274735-12-joannelkoong@gmail.com>

On Tue, Sep 16, 2025 at 04:44:21PM -0700, Joanne Koong wrote:
> Move bio logic in the buffered io code into its own file and remove
> CONFIG_BLOCK gating for iomap read/readahead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

/me wonders how long until we end up doing the same thing with the
directio code but in the meantime it beats #ifdef everywhere

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/Makefile      |  3 +-
>  fs/iomap/bio.c         | 90 ++++++++++++++++++++++++++++++++++++++++++
>  fs/iomap/buffered-io.c | 90 +-----------------------------------------
>  fs/iomap/internal.h    | 12 ++++++
>  4 files changed, 105 insertions(+), 90 deletions(-)
>  create mode 100644 fs/iomap/bio.c
> 
> diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
> index f7e1c8534c46..a572b8808524 100644
> --- a/fs/iomap/Makefile
> +++ b/fs/iomap/Makefile
> @@ -14,5 +14,6 @@ iomap-y				+= trace.o \
>  iomap-$(CONFIG_BLOCK)		+= direct-io.o \
>  				   ioend.o \
>  				   fiemap.o \
> -				   seek.o
> +				   seek.o \
> +				   bio.o
>  iomap-$(CONFIG_SWAP)		+= swapfile.o
> diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> new file mode 100644
> index 000000000000..8a51c9d70268
> --- /dev/null
> +++ b/fs/iomap/bio.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2010 Red Hat, Inc.
> + * Copyright (C) 2016-2023 Christoph Hellwig.
> + */
> +#include <linux/iomap.h>
> +#include <linux/pagemap.h>
> +#include "internal.h"
> +#include "trace.h"
> +
> +static void iomap_read_end_io(struct bio *bio)
> +{
> +	int error = blk_status_to_errno(bio->bi_status);
> +	struct folio_iter fi;
> +
> +	bio_for_each_folio_all(fi, bio)
> +		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
> +	bio_put(bio);
> +}
> +
> +static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
> +{
> +	struct bio *bio = ctx->read_ctx;
> +
> +	if (bio)
> +		submit_bio(bio);
> +}
> +
> +static int iomap_bio_read_folio_range(const struct iomap_iter *iter,
> +		struct iomap_read_folio_ctx *ctx, size_t plen)
> +{
> +	struct folio *folio = ctx->cur_folio;
> +	const struct iomap *iomap = &iter->iomap;
> +	loff_t pos = iter->pos;
> +	size_t poff = offset_in_folio(folio, pos);
> +	loff_t length = iomap_length(iter);
> +	sector_t sector;
> +	struct bio *bio = ctx->read_ctx;
> +
> +	iomap_start_folio_read(folio, plen);
> +
> +	sector = iomap_sector(iomap, pos);
> +	if (!bio || bio_end_sector(bio) != sector ||
> +	    !bio_add_folio(bio, folio, plen, poff)) {
> +		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
> +		gfp_t orig_gfp = gfp;
> +		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
> +
> +		if (bio)
> +			submit_bio(bio);
> +
> +		if (ctx->rac) /* same as readahead_gfp_mask */
> +			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> +		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
> +				     gfp);
> +		/*
> +		 * If the bio_alloc fails, try it again for a single page to
> +		 * avoid having to deal with partial page reads.  This emulates
> +		 * what do_mpage_read_folio does.
> +		 */
> +		if (!bio)
> +			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
> +		if (ctx->rac)
> +			bio->bi_opf |= REQ_RAHEAD;
> +		bio->bi_iter.bi_sector = sector;
> +		bio->bi_end_io = iomap_read_end_io;
> +		bio_add_folio_nofail(bio, folio, plen, poff);
> +		ctx->read_ctx = bio;
> +	}
> +	return 0;
> +}
> +
> +const struct iomap_read_ops iomap_bio_read_ops = {
> +	.read_folio_range = iomap_bio_read_folio_range,
> +	.submit_read = iomap_bio_submit_read,
> +};
> +EXPORT_SYMBOL_GPL(iomap_bio_read_ops);
> +
> +int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
> +		struct folio *folio, loff_t pos, size_t len)
> +{
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	struct bio_vec bvec;
> +	struct bio bio;
> +
> +	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
> +	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
> +	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
> +	return submit_bio_wait(&bio);
> +}
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 667a49cb5ae5..72258b0109ec 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -8,6 +8,7 @@
>  #include <linux/writeback.h>
>  #include <linux/swap.h>
>  #include <linux/migrate.h>
> +#include "internal.h"
>  #include "trace.h"
>  
>  #include "../internal.h"
> @@ -352,74 +353,6 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
>  }
>  EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
>  
> -#ifdef CONFIG_BLOCK
> -static void iomap_read_end_io(struct bio *bio)
> -{
> -	int error = blk_status_to_errno(bio->bi_status);
> -	struct folio_iter fi;
> -
> -	bio_for_each_folio_all(fi, bio)
> -		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
> -	bio_put(bio);
> -}
> -
> -static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
> -{
> -	struct bio *bio = ctx->read_ctx;
> -
> -	if (bio)
> -		submit_bio(bio);
> -}
> -
> -static int iomap_bio_read_folio_range(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx, size_t plen)
> -{
> -	struct folio *folio = ctx->cur_folio;
> -	const struct iomap *iomap = &iter->iomap;
> -	loff_t pos = iter->pos;
> -	size_t poff = offset_in_folio(folio, pos);
> -	loff_t length = iomap_length(iter);
> -	sector_t sector;
> -	struct bio *bio = ctx->read_ctx;
> -
> -	iomap_start_folio_read(folio, plen);
> -
> -	sector = iomap_sector(iomap, pos);
> -	if (!bio || bio_end_sector(bio) != sector ||
> -	    !bio_add_folio(bio, folio, plen, poff)) {
> -		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
> -		gfp_t orig_gfp = gfp;
> -		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
> -
> -		iomap_bio_submit_read(ctx);
> -
> -		if (ctx->rac) /* same as readahead_gfp_mask */
> -			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
> -				     gfp);
> -		/*
> -		 * If the bio_alloc fails, try it again for a single page to
> -		 * avoid having to deal with partial page reads.  This emulates
> -		 * what do_mpage_read_folio does.
> -		 */
> -		if (!bio)
> -			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
> -		if (ctx->rac)
> -			bio->bi_opf |= REQ_RAHEAD;
> -		bio->bi_iter.bi_sector = sector;
> -		bio->bi_end_io = iomap_read_end_io;
> -		bio_add_folio_nofail(bio, folio, plen, poff);
> -		ctx->read_ctx = bio;
> -	}
> -	return 0;
> -}
> -
> -const struct iomap_read_ops iomap_bio_read_ops = {
> -	.read_folio_range	= iomap_bio_read_folio_range,
> -	.submit_read		= iomap_bio_submit_read,
> -};
> -EXPORT_SYMBOL_GPL(iomap_bio_read_ops);
> -
>  /*
>   * Add a bias to ifs->read_bytes_pending to prevent the read on the folio from
>   * being ended prematurely.
> @@ -623,27 +556,6 @@ void iomap_readahead(const struct iomap_ops *ops,
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
>  
> -static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
> -		struct folio *folio, loff_t pos, size_t len)
> -{
> -	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> -	struct bio_vec bvec;
> -	struct bio bio;
> -
> -	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
> -	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
> -	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
> -	return submit_bio_wait(&bio);
> -}
> -#else
> -static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
> -		struct folio *folio, loff_t pos, size_t len)
> -{
> -	WARN_ON_ONCE(1);
> -	return -EIO;
> -}
> -#endif /* CONFIG_BLOCK */
> -
>  /*
>   * iomap_is_partially_uptodate checks whether blocks within a folio are
>   * uptodate or not.
> diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
> index d05cb3aed96e..7ab1033ab4b7 100644
> --- a/fs/iomap/internal.h
> +++ b/fs/iomap/internal.h
> @@ -6,4 +6,16 @@
>  
>  u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
>  
> +#ifdef CONFIG_BLOCK
> +int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
> +		struct folio *folio, loff_t pos, size_t len);
> +#else
> +int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
> +		struct folio *folio, loff_t pos, size_t len)
> +{
> +	WARN_ON_ONCE(1);
> +	return -EIO;
> +}
> +#endif /* CONFIG_BLOCK */
> +
>  #endif /* _IOMAP_INTERNAL_H */
> -- 
> 2.47.3
> 
> 

