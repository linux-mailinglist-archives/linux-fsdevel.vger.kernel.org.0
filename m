Return-Path: <linux-fsdevel+bounces-58363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB07B2D476
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 09:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC894E0462
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 07:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EAF2D24A4;
	Wed, 20 Aug 2025 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzzzrcQB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F86535336A;
	Wed, 20 Aug 2025 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673521; cv=none; b=p2zcj2Pxdyoz7Jv1w4tD7yIwTweIY4+UPf7p7rfpa7Ky6jyGZ9KjXNTck4Qp+t5Rx9mWiH+dorPC8cN/ELmtGS3eU1aAA/lMsUIR3K+mJB+GrhQvlRUlApXYjXg3j5xaeb89dOETKteYk2mhbDeBd9rF5LTeFmFepf5JJIcoY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673521; c=relaxed/simple;
	bh=KEYfh4PJvrgBa95LZ3pjvfb1K6WI8Uw2nKvoJM+W9wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Km9Kv/z9ReXN3StHTnxsi5Cxz1RMPzXpicEH31IZl9bn4o2e+kyQCR86XNZQukftu7b55Bw6rCVlNMlzSPY4Vz06pzu8uLoOVwACmik+U0WniI1UDmAPpDlLQ2bHP7a6eHr+Dahu1COzzWQgxrLvCQEpXoAdnoenMzJU9+2Ksww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzzzrcQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90982C116D0;
	Wed, 20 Aug 2025 07:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755673518;
	bh=KEYfh4PJvrgBa95LZ3pjvfb1K6WI8Uw2nKvoJM+W9wA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CzzzrcQBbIqpX8uzZUPojwM27IwtbuODyEFkaXtqm3CvsTzQjS/cTMWmRwqoQK1Cm
	 Vzd3d05YKv5t1XAfzguWakulffRfdLLlaYtQ0mVYcSuO91zJO/+mVuCJc+Rgvt+oZb
	 2i/2/u8PVZ2sDgaVRvCA7GpUdQ7QRarjTHJlccMBcZRIsbLUSmWir5m7XoTjpOEE7c
	 0cmD11R7vghvZt4KE/a+Pq1ladn/8SaaT9o6loaMQ28YmaJZeKB2JGD0htPn2sNFW6
	 QEiQXzhUDVPzr5WpSwE63n7eMPb6vSOYlxgIm+13Xfj0u2zor4rwpr7j4D5XxIMKmR
	 Cbq6MmMlXwZ+Q==
Message-ID: <d07a4397-1648-4264-8a30-74a2ea3da165@kernel.org>
Date: Wed, 20 Aug 2025 16:02:31 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/8] block: check for valid bio while splitting
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 hch@lst.de, martin.petersen@oracle.com, djwong@kernel.org,
 linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
 Keith Busch <kbusch@kernel.org>
References: <20250819164922.640964-1-kbusch@meta.com>
 <20250819164922.640964-2-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250819164922.640964-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/25 1:49 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We're already iterating every segment, so check these for a valid IO at
> the same time.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-map.c        |  2 +-
>  block/blk-merge.c      | 20 ++++++++++++++++----
>  include/linux/bio.h    |  4 ++--
>  include/linux/blkdev.h | 13 +++++++++++++
>  4 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 23e5d5ebe59ec..c5da9d37deee9 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -443,7 +443,7 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
>  	int ret;
>  
>  	/* check that the data layout matches the hardware restrictions */
> -	ret = bio_split_rw_at(bio, lim, &nr_segs, max_bytes);
> +	ret = bio_split_drv_at(bio, lim, &nr_segs, max_bytes);
>  	if (ret) {
>  		/* if we would have to split the bio, copy instead */
>  		if (ret > 0)
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 70d704615be52..a0d8364983000 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -279,25 +279,29 @@ static unsigned int bio_split_alignment(struct bio *bio,
>  }
>  
>  /**
> - * bio_split_rw_at - check if and where to split a read/write bio
> + * bio_split_io_at - check if and where to split a read/write bio
>   * @bio:  [in] bio to be split
>   * @lim:  [in] queue limits to split based on
>   * @segs: [out] number of segments in the bio with the first half of the sectors
>   * @max_bytes: [in] maximum number of bytes per bio
> + * @len_align: [in] length alignment for each vector
>   *
>   * Find out if @bio needs to be split to fit the queue limits in @lim and a
>   * maximum size of @max_bytes.  Returns a negative error number if @bio can't be
>   * split, 0 if the bio doesn't have to be split, or a positive sector offset if
>   * @bio needs to be split.
>   */
> -int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
> -		unsigned *segs, unsigned max_bytes)
> +int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
> +		unsigned *segs, unsigned max_bytes, unsigned len_align)
>  {
>  	struct bio_vec bv, bvprv, *bvprvp = NULL;
>  	struct bvec_iter iter;
>  	unsigned nsegs = 0, bytes = 0;
>  
>  	bio_for_each_bvec(bv, bio, iter) {
> +		if (bv.bv_offset & lim->dma_alignment || bv.bv_len & len_align)

Shouldn't this be:

		if (bv.bv_offset & len_align || bv.bv_len & len_align)

?

> +			return -EINVAL;
> +
>  		/*
>  		 * If the queue doesn't support SG gaps and adding this
>  		 * offset would create a gap, disallow it.
> @@ -339,8 +343,16 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>  	 * Individual bvecs might not be logical block aligned. Round down the
>  	 * split size so that each bio is properly block size aligned, even if
>  	 * we do not use the full hardware limits.
> +	 *
> +	 * Misuse may submit a bio that can't be split into a valid io. There
> +	 * may either be too many discontiguous vectors for the max segments
> +	 * limit, or contain virtual boundary gaps without having a valid block
> +	 * sized split. Catch that condition by checking for a zero byte
> +	 * result.
>  	 */
>  	bytes = ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
> +	if (!bytes)
> +		return -EINVAL;
>  
>  	/*
>  	 * Bio splitting may cause subtle trouble such as hang when doing sync
> @@ -350,7 +362,7 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>  	bio_clear_polled(bio);
>  	return bytes >> SECTOR_SHIFT;
>  }
> -EXPORT_SYMBOL_GPL(bio_split_rw_at);
> +EXPORT_SYMBOL_GPL(bio_split_io_at);
>  
>  struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
>  		unsigned *nr_segs)
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 46ffac5caab78..519a1d59805f8 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -322,8 +322,8 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
>  void bio_trim(struct bio *bio, sector_t offset, sector_t size);
>  extern struct bio *bio_split(struct bio *bio, int sectors,
>  			     gfp_t gfp, struct bio_set *bs);
> -int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
> -		unsigned *segs, unsigned max_bytes);
> +int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
> +		unsigned *segs, unsigned max_bytes, unsigned len_align);
>  
>  /**
>   * bio_next_split - get next @sectors from a bio, splitting if necessary
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 95886b404b16b..7f83ad2df5425 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1869,6 +1869,19 @@ bdev_atomic_write_unit_max_bytes(struct block_device *bdev)
>  	return queue_atomic_write_unit_max_bytes(bdev_get_queue(bdev));
>  }
>  
> +static inline int bio_split_rw_at(struct bio *bio,
> +		const struct queue_limits *lim,
> +		unsigned *segs, unsigned max_bytes)
> +{
> +	return bio_split_io_at(bio, lim, segs, max_bytes, lim->dma_alignment);
> +}
> +
> +static inline int bio_split_drv_at(struct bio *bio,
> +		const struct queue_limits *lim,
> +		unsigned *segs, unsigned max_bytes)
> +{
> +	return bio_split_io_at(bio, lim, segs, max_bytes, 0);
> +}
>  #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
>  
>  #endif /* _LINUX_BLKDEV_H */


-- 
Damien Le Moal
Western Digital Research

