Return-Path: <linux-fsdevel+bounces-40678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B388A26684
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 23:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A843A5380
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D316420FAAC;
	Mon,  3 Feb 2025 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7x6KyiT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335391FF7CA;
	Mon,  3 Feb 2025 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621408; cv=none; b=pYsyUthr/OkdiXsgNmaFr4lNlzjLx1bbyTvhviq0KcOnrv98mQHyNWWzqufkDKuLv1NhDRVOzW18B8aUwA+WJsX0UUtzZogb9wWymMvGszOYGEPHgnzN+EgnJMJu2eLu6mTtQ4KA+RyRuHVr6Jp9Lqt6SdAch9+zVeK5vTlzUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621408; c=relaxed/simple;
	bh=mqFpvJjKwVeqq/IjhOln09reBd810z3+5V1DfVdlH0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck7hfqk4U0pE143Zn0TxI2k1At/VFdNTTebjUJSxjRaHX4yR5oo+goGgEiyIJBgLHO0YuXevQ5g8Dmh2WqGxm2gueXsoTWQ5pPNQdOCydrkZFZgTU3hSHjqRpXF5CAWqz325QyBlH7d/Nzyz0MjFKrUo+8BzCCDtKb1MAYRRbAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7x6KyiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D48C4CED2;
	Mon,  3 Feb 2025 22:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738621407;
	bh=mqFpvJjKwVeqq/IjhOln09reBd810z3+5V1DfVdlH0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7x6KyiT7YSzDaTNVMICVCBNH/uNVkcjStAE+I2XKmV2lUyhHsUhfE3Fd3QItlIIA
	 kwlnbElvvkdsSL0f3GWSdMAKa2+8kHLEBqP9ev6WLgwZ+OQU9lEm/ZWMnwtNX+PNt/
	 BZFdgCcjVH4xosgRlQSrco+nGrimuvVEBO4gtmE8K8QYRkZXSgjnJmGXq70tO8eglA
	 9xW0WyRxNgPIKOoQwD4X5oatjFlKmbZ8PXM0HvQCoCNoZ2udXm+QhcyC07gdczy9ZT
	 ZyvN40rtHu/ZvD9dKTgO64DR/vbegbzCrwDB4KBnil15FvtzyhLQSmRCPaXF+EMDGB
	 v4IlIGGrzPg4w==
Date: Mon, 3 Feb 2025 14:23:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/7] iomap: add bioset in iomap_read_folio_ops for
 filesystems to use own bioset
Message-ID: <20250203222326.GE134507@frogsfrogsfrogs>
References: <20250203094322.1809766-1-hch@lst.de>
 <20250203094322.1809766-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203094322.1809766-4-hch@lst.de>

On Mon, Feb 03, 2025 at 10:43:07AM +0100, Christoph Hellwig wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Allocate the bio from the bioset provided in iomap_read_folio_ops.
> If no bioset is provided, fs_bio_set is used which is the standard
> bioset for filesystems.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

I feel like I've seen this patch and the last one floating around for
quite a while; would you and/or Goldwyn like to merge it for 6.15?

--D

> [hch: factor out two helpers]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 51 ++++++++++++++++++++++++++++--------------
>  include/linux/iomap.h  |  6 +++++
>  2 files changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 804527dcc9ba..eaffa23eb8e4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -364,6 +364,39 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
>  		pos >= i_size_read(iter->inode);
>  }
>  
> +static struct bio_set *iomap_read_bio_set(struct iomap_readpage_ctx *ctx)
> +{
> +	if (ctx->ops && ctx->ops->bio_set)
> +		return ctx->ops->bio_set;
> +	return &fs_bio_set;
> +}
> +
> +static struct bio *iomap_read_alloc_bio(const struct iomap_iter *iter,
> +		struct iomap_readpage_ctx *ctx, loff_t length)
> +{
> +	unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
> +	struct block_device *bdev = iter->iomap.bdev;
> +	struct bio_set *bio_set = iomap_read_bio_set(ctx);
> +	gfp_t gfp = mapping_gfp_constraint(iter->inode->i_mapping, GFP_KERNEL);
> +	gfp_t orig_gfp = gfp;
> +	struct bio *bio;
> +
> +	if (ctx->rac) /* same as readahead_gfp_mask */
> +		gfp |= __GFP_NORETRY | __GFP_NOWARN;
> +
> +	bio = bio_alloc_bioset(bdev, bio_max_segs(nr_vecs), REQ_OP_READ, gfp,
> +			bio_set);
> +
> +	/*
> +	 * If the bio_alloc fails, try it again for a single page to avoid
> +	 * having to deal with partial page reads.  This emulates what
> +	 * do_mpage_read_folio does.
> +	 */
> +	if (!bio)
> +		bio = bio_alloc_bioset(bdev, 1, REQ_OP_READ, orig_gfp, bio_set);
> +	return bio;
> +}
> +
>  static void iomap_read_submit_bio(const struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx)
>  {
> @@ -411,27 +444,11 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  	if (!ctx->bio ||
>  	    bio_end_sector(ctx->bio) != sector ||
>  	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
> -		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
> -		gfp_t orig_gfp = gfp;
> -		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
> -
>  		if (ctx->bio)
>  			iomap_read_submit_bio(iter, ctx);
>  
>  		ctx->bio_start_pos = offset;
> -		if (ctx->rac) /* same as readahead_gfp_mask */
> -			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> -				     REQ_OP_READ, gfp);
> -		/*
> -		 * If the bio_alloc fails, try it again for a single page to
> -		 * avoid having to deal with partial page reads.  This emulates
> -		 * what do_mpage_read_folio does.
> -		 */
> -		if (!ctx->bio) {
> -			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
> -					     orig_gfp);
> -		}
> +		ctx->bio = iomap_read_alloc_bio(iter, ctx, length);
>  		if (ctx->rac)
>  			ctx->bio->bi_opf |= REQ_RAHEAD;
>  		ctx->bio->bi_iter.bi_sector = sector;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 2930861d1ef1..304be88ecd23 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -311,6 +311,12 @@ struct iomap_read_folio_ops {
>  	 */
>  	void (*submit_io)(struct inode *inode, struct bio *bio,
>  			  loff_t file_offset);
> +
> +	/*
> +	 * Optional, allows filesystem to specify own bio_set, so new bio's
> +	 * can be allocated from the provided bio_set.
> +	 */
> +	struct bio_set *bio_set;
>  };
>  
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
> -- 
> 2.45.2
> 
> 

