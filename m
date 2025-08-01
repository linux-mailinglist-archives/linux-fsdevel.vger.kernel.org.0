Return-Path: <linux-fsdevel+bounces-56523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FFFB1857E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 18:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0847A1748DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4504B28C84A;
	Fri,  1 Aug 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7Tpr5vU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A5288C37;
	Fri,  1 Aug 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064655; cv=none; b=koCa8dCb7ILV1OcT2wk6HH68DSt1mGlFaatGdTDb8bDG93aQd8dpJxwSO7MMY6iZqEVGWX4S+v9CT0mxrdPWdv54Cdua/jaFOIW8i00QOS9K6IP6syQBq6pZfnfHgo+gEKLbAjh/IAy+BH7R/geQomjeW09z6WHFzDOEWaL4rAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064655; c=relaxed/simple;
	bh=YJUX0fpZN2RLxt3SCQZZyd2sdDmDLe9bwhG+Ls39SMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhX9LEwmaNaz20pv88fXNJyxE1gpqqpGszFE9BheA/Sj5PLZkr8baGJnzo1DzhpXbCkMgWvs+pPwBexGa5zig1CQrl6lQtyIq7354wdKOZwA8yjMijHyhI3kGstA0BvCrHaxndY0fmnv8G+UQOtwgPQ6wNsHOkmuHnzShdDx5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7Tpr5vU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF00BC4CEE7;
	Fri,  1 Aug 2025 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754064655;
	bh=YJUX0fpZN2RLxt3SCQZZyd2sdDmDLe9bwhG+Ls39SMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J7Tpr5vUDIiquy+2FF26DmpbqK2Odv7P6GzUmjQswnMhtto/uOoEKOrxUoBkvFsqm
	 D5aRJWoC9dKnm3OK5pEE0Vs8EtWHRd+zySlXi5Kg10BeSZ0n2rNqIa/fQZ2uCfADgy
	 udSzfDjzuhpLuvFuafbw+CV+OhqXMGd9dLDKSfHa0iQ7nGkIGAutiMVw/tWwK1roCk
	 XtxySqdq5NLSxq57f2OJgFQzjJoGhsRGBq4OWXp29Q/ho0L2GfoQxS9KIgFw6ZQFnZ
	 S5tv6d0CTA+qH1NWB4LUgOZeLK/BgVA4mBv9epduMflvy1KLtCKNP5y9Gui7cAD5V+
	 ZGEEejXJzgI8Q==
Date: Fri, 1 Aug 2025 12:10:53 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/8] lib/iov_iter: remove piecewise bvec length
 checking in iov_iter_aligned_bvec
Message-ID: <aIznDZtTNk96V_5z@kernel.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-5-snitzer@kernel.org>
 <5819d6c5bb194613a14d2dcf05605e701683ba49.camel@kernel.org>
 <aG_SpLuUv4EH7fAb@kbusch-mbp>
 <aG_mbURjwxk3vZlX@kernel.org>
 <aIzcDWJyft7kzGi3@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIzcDWJyft7kzGi3@kbusch-mbp>

On Fri, Aug 01, 2025 at 09:23:57AM -0600, Keith Busch wrote:
> On Thu, Jul 10, 2025 at 12:12:29PM -0400, Mike Snitzer wrote:
> > All said, in practice I haven't had any issues with this patch.  But
> > it could just be I don't have the stars aligned to test the case that
> > might have problems.  If you know of such a case I'd welcome
> > suggestions.
> 
> This is something I threw together that appears to be successful with
> NVMe through raw block direct-io. This will defer catching an invalid io
> vector to much later in the block stack, which should be okay, and
> removes one of the vector walks in the fast path, so that's a bonus.
> 
> While this is testing okay with NVMe so far, I haven't tested any more
> complicated setups yet, and I probably need to get filesystems using
> this relaxed limit too.

Ship it! ;)

Many thanks for this, I'll review closely and circle back!

Mike

 
> ---
> diff --git a/block/bio.c b/block/bio.c
> index 92c512e876c8d..634b2031c4829 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1227,13 +1227,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
>  		extraction_flags |= ITER_ALLOW_P2PDMA;
>  
> -	/*
> -	 * Each segment in the iov is required to be a block size multiple.
> -	 * However, we may not be able to get the entire segment if it spans
> -	 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
> -	 * result to ensure the bio's total size is correct. The remainder of
> -	 * the iov data will be picked up in the next bio iteration.
> -	 */
>  	size = iov_iter_extract_pages(iter, &pages,
>  				      UINT_MAX - bio->bi_iter.bi_size,
>  				      nr_pages, extraction_flags, &offset);
> @@ -1241,18 +1234,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  		return size ? size : -EFAULT;
>  
>  	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
> -
> -	if (bio->bi_bdev) {
> -		size_t trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
> -		iov_iter_revert(iter, trim);
> -		size -= trim;
> -	}
> -
> -	if (unlikely(!size)) {
> -		ret = -EFAULT;
> -		goto out;
> -	}
> -
>  	for (left = size, i = 0; left > 0; left -= len, i += num_pages) {
>  		struct page *page = pages[i];
>  		struct folio *folio = page_folio(page);
> @@ -1297,6 +1278,23 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	return ret;
>  }
>  
> +static int bio_align_to_bs(struct bio *bio, struct iov_iter *iter)
> +{
> +	unsigned int mask = bdev_logical_block_size(bio->bi_bdev) - 1;
> +	unsigned int total = bio->bi_iter.bi_size;
> +	size_t trim = total & mask;
> +
> +	if (!trim)
> +	        return 0;
> +
> +	/* FIXME: might be leaking pages */
> +	bio_revert(bio, trim);
> +	iov_iter_revert(iter, trim);
> +	if (total == trim)
> +	        return -EFAULT;
> +	return 0;
> +}
> +
>  /**
>   * bio_iov_iter_get_pages - add user or kernel pages to a bio
>   * @bio: bio to add pages to
> @@ -1327,7 +1325,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	if (iov_iter_is_bvec(iter)) {
>  		bio_iov_bvec_set(bio, iter);
>  		iov_iter_advance(iter, bio->bi_iter.bi_size);
> -		return 0;
> +		return bio_align_to_bs(bio, iter);
>  	}
>  
>  	if (iov_iter_extract_will_pin(iter))
> @@ -1336,6 +1334,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  		ret = __bio_iov_iter_get_pages(bio, iter);
>  	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
>  
> +	ret = bio_align_to_bs(bio, iter);
>  	return bio->bi_vcnt ? 0 : ret;
>  }
>  EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 70d704615be52..a3acfef8eb81d 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -298,6 +298,9 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>  	unsigned nsegs = 0, bytes = 0;
>  
>  	bio_for_each_bvec(bv, bio, iter) {
> +		if (bv.bv_offset & lim->dma_alignment)
> +			return -EFAULT;
> +
>  		/*
>  		 * If the queue doesn't support SG gaps and adding this
>  		 * offset would create a gap, disallow it.
> @@ -341,6 +344,8 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>  	 * we do not use the full hardware limits.
>  	 */
>  	bytes = ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
> +	if (!bytes)
> +		return -EFAULT;
>  
>  	/*
>  	 * Bio splitting may cause subtle trouble such as hang when doing sync
> diff --git a/block/fops.c b/block/fops.c
> index 82451ac8ff25d..820902cf10730 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -38,8 +38,8 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
>  static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
>  				struct iov_iter *iter)
>  {
> -	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
> -		!bdev_iter_is_aligned(bdev, iter);
> +	return (iocb->ki_pos | iov_iter_count(iter)) &
> +			(bdev_logical_block_size(bdev) - 1);
>  }
>  
>  #define DIO_INLINE_BIO_VECS 4
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 46ffac5caab78..d3ddf78d1f35e 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -169,6 +169,22 @@ static inline void bio_advance(struct bio *bio, unsigned int nbytes)
>  
>  #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
>  
> +static inline void bio_revert(struct bio *bio, unsigned int nbytes)
> +{
> +	bio->bi_iter.bi_size -= nbytes;
> +
> +	while (nbytes) {
> +		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> +
> +		if (nbytes < bv->bv_len) {
> +			bv->bv_len -= nbytes;
> +			return;
> +		}
> +		bio->bi_vcnt--;
> +		nbytes -= bv->bv_len;
> +       }
> +}
> +
>  static inline unsigned bio_segments(struct bio *bio)
>  {
>  	unsigned segs = 0;
> --

