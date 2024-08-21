Return-Path: <linux-fsdevel+bounces-26504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A8495A34D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42F3283A94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEF31B1D7B;
	Wed, 21 Aug 2024 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtHVJU0H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC919995D;
	Wed, 21 Aug 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259485; cv=none; b=ehqPIcA10sdYvxJwvt20OqYahoV/DuBZAXJohxq4lvrUoRcKNWxDviMGtalVRi7OdbDeq8IVjzXjZIbFtaW9CO0wVyVTa5eDLquLpsICxiUq/S9Z9SA0qGtZoYgPeGO2TJMt72R3eCXwz+e7FPfsTGBJ3l03pu2zdEtFTQaCxIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259485; c=relaxed/simple;
	bh=n+AxqqbskxJ534zPXzBpn7AEArHbo5EMD8JRMZ7PwWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubzV3ytwTNyDbnaG08v6GLSN4lKTXAT1LyBiA/lE/mOlOC8nmvOiHizvQiGLcrs/L2ApfIGPyjoeNPurayf385zx5j01mvlTJEh8SDh0InkHFPMcREzuzPdM7F7vt4D2dkeRyUg2kxTXAzw0i2+H9sVol+zYil8qFXKYx7i1JR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtHVJU0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1168C32781;
	Wed, 21 Aug 2024 16:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724259484;
	bh=n+AxqqbskxJ534zPXzBpn7AEArHbo5EMD8JRMZ7PwWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtHVJU0HB8FbQJF5vXuxlvJcU15vi1xoi0eCzDwJk4Pv4rq4jBAtmRnUOL7RTBb8A
	 8mclzmfYSR/ZofYGHaQQmbRN37suKKxj5CFNuldjmPB8byFkHRLEOy5hllTDAI45GE
	 qb4LucFK7xIoCXRsqJF4vmB/SToSsj/THuFRpvTvsdJTvfLf51K8kCq9maQUyTzmnZ
	 1inmn1KVtmEhrkXEDpWdAzNLnVY57CruInPa+uDrTElD9KuuTKWcgEE4QbabUHTqhB
	 N4MWk2KELJaVzB5luysOUKL/4/wrs+GFF6jekAmxWV/qbK977mTbfLHuMUNAlqf4qB
	 T8nZN2HIerk8Q==
Date: Wed, 21 Aug 2024 09:58:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, chandan.babu@oracle.com, dchinner@redhat.com,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	kbusch@kernel.org
Subject: Re: [PATCH v5 3/7] fs: iomap: Atomic write support
Message-ID: <20240821165803.GI865349@frogsfrogsfrogs>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817094800.776408-4-john.g.garry@oracle.com>

On Sat, Aug 17, 2024 at 09:47:56AM +0000, John Garry wrote:
> Support direct I/O atomic writes by producing a single bio with REQ_ATOMIC
> flag set.
> 
> We rely on the FS to guarantee extent alignment, such that an atomic write
> should never straddle two or more extents. The FS should also check for
> validity of an atomic write length/alignment.
> 
> For each iter, data is appended to the single bio. That bio is allocated
> on the first iter.
> 
> If that total bio data does not match the expected total, then error and
> do not submit the bio as we cannot tolerate a partial write.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/iomap/direct-io.c  | 122 +++++++++++++++++++++++++++++++++++-------
>  fs/iomap/trace.h      |   3 +-
>  include/linux/iomap.h |   1 +
>  3 files changed, 106 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f3b43d223a46..72f28d53ab03 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -37,6 +37,7 @@ struct iomap_dio {
>  	int			error;
>  	size_t			done_before;
>  	bool			wait_for_completion;
> +	struct bio		*atomic_bio;
>  
>  	union {
>  		/* used during submission and for synchronous completion: */
> @@ -61,6 +62,24 @@ static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
>  	return bio_alloc(iter->iomap.bdev, nr_vecs, opf, GFP_KERNEL);
>  }
>  
> +static struct bio *iomap_dio_alloc_bio_data(const struct iomap_iter *iter,
> +		struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf,
> +		loff_t pos)
> +{
> +	struct bio *bio = iomap_dio_alloc_bio(iter, dio, nr_vecs, opf);
> +	struct inode *inode = iter->inode;
> +
> +	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> +				  GFP_KERNEL);
> +	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
> +	bio->bi_write_hint = inode->i_write_hint;
> +	bio->bi_ioprio = dio->iocb->ki_ioprio;
> +	bio->bi_private = dio;
> +	bio->bi_end_io = iomap_dio_bio_end_io;
> +
> +	return bio;
> +}
> +
>  static void iomap_dio_submit_bio(const struct iomap_iter *iter,
>  		struct iomap_dio *dio, struct bio *bio, loff_t pos)
>  {
> @@ -256,7 +275,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>   * clearing the WRITE_THROUGH flag in the dio request.
>   */
>  static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> -		const struct iomap *iomap, bool use_fua)
> +		const struct iomap *iomap, bool use_fua, bool atomic)
>  {
>  	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
>  
> @@ -268,6 +287,8 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  		opflags |= REQ_FUA;
>  	else
>  		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
> +	if (atomic)
> +		opflags |= REQ_ATOMIC;
>  
>  	return opflags;
>  }
> @@ -275,21 +296,23 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		struct iomap_dio *dio)
>  {
> +	bool atomic = dio->iocb->ki_flags & IOCB_ATOMIC;
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
>  	unsigned int fs_block_size = i_blocksize(inode), pad;
> +	struct iov_iter *i = dio->submit.iter;

If you're going to pull this out into a convenience variable, please do
that as a separate patch so that the actual untorn write additions don't
get mixed in.

>  	loff_t length = iomap_length(iter);
>  	loff_t pos = iter->pos;
>  	blk_opf_t bio_opf;
>  	struct bio *bio;
>  	bool need_zeroout = false;
>  	bool use_fua = false;
> -	int nr_pages, ret = 0;
> +	int nr_pages, orig_nr_pages, ret = 0;
>  	size_t copied = 0;
>  	size_t orig_count;
>  
>  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> -	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> +	    !bdev_iter_is_aligned(iomap->bdev, i))
>  		return -EINVAL;
>  
>  	if (iomap->type == IOMAP_UNWRITTEN) {
> @@ -322,15 +345,35 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  			dio->flags &= ~IOMAP_DIO_CALLER_COMP;
>  	}
>  
> +	if (dio->atomic_bio) {
> +		/*
> +		 * These should not fail, but check just in case.
> +		 * Caller takes care of freeing the bio.
> +		 */
> +		if (iter->iomap.bdev != dio->atomic_bio->bi_bdev) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (dio->atomic_bio->bi_iter.bi_sector +
> +		    (dio->atomic_bio->bi_iter.bi_size >> SECTOR_SHIFT) !=

Hmm, so I guess you stash an untorn write bio in the iomap_dio so that
multiple iomap_dio_bio_iter can try to combine a mixed mapping into a
single contiguous untorn write that can be completed all at once?
I suppose that works as long as the iomap->type is the same across all
the _iter calls, but I think that needs explicit checking here.

> +			iomap_sector(iomap, pos)) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	} else if (atomic) {
> +		orig_nr_pages = bio_iov_vecs_to_alloc(i, BIO_MAX_VECS);
> +	}
> +
>  	/*
>  	 * Save the original count and trim the iter to just the extent we
>  	 * are operating on right now.  The iter will be re-expanded once
>  	 * we are done.
>  	 */
> -	orig_count = iov_iter_count(dio->submit.iter);
> -	iov_iter_truncate(dio->submit.iter, length);
> +	orig_count = iov_iter_count(i);
> +	iov_iter_truncate(i, length);
>  
> -	if (!iov_iter_count(dio->submit.iter))
> +	if (!iov_iter_count(i))
>  		goto out;
>  
>  	/*
> @@ -365,27 +408,46 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	 * can set up the page vector appropriately for a ZONE_APPEND
>  	 * operation.
>  	 */
> -	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
> +	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
> +
> +	if (atomic) {
> +		size_t orig_atomic_size;
> +
> +		if (!dio->atomic_bio) {
> +			dio->atomic_bio = iomap_dio_alloc_bio_data(iter,
> +					dio, orig_nr_pages, bio_opf, pos);
> +		}
> +		orig_atomic_size = dio->atomic_bio->bi_iter.bi_size;
> +
> +		/*
> +		 * In case of error, caller takes care of freeing the bio. The
> +		 * smallest size of atomic write is i_node size, so no need for

What is "i_node size"?  Are you referring to i_blocksize?

> +		 * tail zeroing out.
> +		 */
> +		ret = bio_iov_iter_get_pages(dio->atomic_bio, i);
> +		if (!ret) {
> +			copied = dio->atomic_bio->bi_iter.bi_size -
> +				orig_atomic_size;
> +		}
>  
> -	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
> +		dio->size += copied;
> +		goto out;
> +	}
> +
> +	nr_pages = bio_iov_vecs_to_alloc(i, BIO_MAX_VECS);
>  	do {
>  		size_t n;
>  		if (dio->error) {
> -			iov_iter_revert(dio->submit.iter, copied);
> +			iov_iter_revert(i, copied);
>  			copied = ret = 0;
>  			goto out;
>  		}
>  
> -		bio = iomap_dio_alloc_bio(iter, dio, nr_pages, bio_opf);
> +		bio = iomap_dio_alloc_bio_data(iter, dio, nr_pages, bio_opf, pos);
>  		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>  					  GFP_KERNEL);
> -		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
> -		bio->bi_write_hint = inode->i_write_hint;
> -		bio->bi_ioprio = dio->iocb->ki_ioprio;
> -		bio->bi_private = dio;
> -		bio->bi_end_io = iomap_dio_bio_end_io;

I see two places (here and iomap_dio_zero) that allocate a bio and
perform some initialization of it.  Can you move the common pieces to
iomap_dio_alloc_bio instead of adding a iomap_dio_alloc_bio_data
variant, and move all that to a separate cleanup patch?

> -		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
> +		ret = bio_iov_iter_get_pages(bio, i);
>  		if (unlikely(ret)) {
>  			/*
>  			 * We have to stop part way through an IO. We must fall
> @@ -408,8 +470,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		dio->size += n;
>  		copied += n;
>  
> -		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
> -						 BIO_MAX_VECS);
> +		nr_pages = bio_iov_vecs_to_alloc(i, BIO_MAX_VECS);
>  		/*
>  		 * We can only poll for single bio I/Os.
>  		 */
> @@ -435,7 +496,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	}
>  out:
>  	/* Undo iter limitation to current extent */
> -	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
> +	iov_iter_reexpand(i, orig_count - copied);
>  	if (copied)
>  		return copied;
>  	return ret;
> @@ -555,6 +616,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	struct blk_plug plug;
>  	struct iomap_dio *dio;
>  	loff_t ret = 0;
> +	size_t orig_count = iov_iter_count(iter);
>  
>  	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
>  
> @@ -580,6 +642,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iomi.flags |= IOMAP_NOWAIT;
>  
> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> +		if (bio_iov_vecs_to_alloc(iter, INT_MAX) > BIO_MAX_VECS)
> +			return ERR_PTR(-EINVAL);
> +		iomi.flags |= IOMAP_ATOMIC;
> +	}
> +	dio->atomic_bio = NULL;
> +
>  	if (iov_iter_rw(iter) == READ) {
>  		/* reads can always complete inline */
>  		dio->flags |= IOMAP_DIO_INLINE_COMP;
> @@ -665,6 +734,21 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		iocb->ki_flags &= ~IOCB_HIPRI;
>  	}
>  
> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> +		if (ret >= 0) {
> +			if (dio->size == orig_count) {
> +				iomap_dio_submit_bio(&iomi, dio,
> +					dio->atomic_bio, iocb->ki_pos);

Does this need to do task_io_account_write like regular direct writes
do?

> +			} else {
> +				if (dio->atomic_bio)
> +					bio_put(dio->atomic_bio);
> +				ret = -EINVAL;
> +			}
> +		} else if (dio->atomic_bio) {
> +			bio_put(dio->atomic_bio);

This ought to null out dio->atomic_bio to prevent accidental UAF.

--D

> +		}
> +	}
> +
>  	blk_finish_plug(&plug);
>  
>  	/*
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 0a991c4ce87d..4118a42cdab0 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>  	{ IOMAP_REPORT,		"REPORT" }, \
>  	{ IOMAP_FAULT,		"FAULT" }, \
>  	{ IOMAP_DIRECT,		"DIRECT" }, \
> -	{ IOMAP_NOWAIT,		"NOWAIT" }
> +	{ IOMAP_NOWAIT,		"NOWAIT" }, \
> +	{ IOMAP_ATOMIC,		"ATOMIC" }
>  
>  #define IOMAP_F_FLAGS_STRINGS \
>  	{ IOMAP_F_NEW,		"NEW" }, \
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 6fc1c858013d..8fd949442262 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -178,6 +178,7 @@ struct iomap_folio_ops {
>  #else
>  #define IOMAP_DAX		0
>  #endif /* CONFIG_FS_DAX */
> +#define IOMAP_ATOMIC		(1 << 9)
>  
>  struct iomap_ops {
>  	/*
> -- 
> 2.31.1
> 
> 

