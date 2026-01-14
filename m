Return-Path: <linux-fsdevel+bounces-73843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DB3D21A94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 23:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56BDC300AFD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641F938B986;
	Wed, 14 Jan 2026 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYN1whVE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8F8357717;
	Wed, 14 Jan 2026 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431190; cv=none; b=hE/4/qHqXVxKX8JqxjteoU8e2lzQYyRgBD/hC/s6P3XzwPf434fW2W9eHu6rSsJlPO35BKUrx4X+uGRqLct4IhBWdDAeKFO7FdL+C87IYps5i1jyc7+Wz7FE2SfQvHGNZklbF2W+f0IcwDCJ29c/3lz5guUghW10wURMA/iIwME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431190; c=relaxed/simple;
	bh=D6cWMLCFZeYG7UPck1IPGCPG+no2dqQfeInh8wTtbrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNveejymWEEx7Q0zDLNbphIJmLDNpYbILYJE2qqX3pEmJFt8QzwRRrH0MHLLQE/WkyabEgVNL4fCjYjjJrP7EmBjW/83nzogcCVmFi+VyRBWdhdC8DEk7dukQpXYlwABy7GiCO1AiGexftTxwkyF1w6CHmlfi11ph5jztQ9kJWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYN1whVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD3EC4CEF7;
	Wed, 14 Jan 2026 22:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768431189;
	bh=D6cWMLCFZeYG7UPck1IPGCPG+no2dqQfeInh8wTtbrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYN1whVEo6d7lnaGmd7EOD5pO+6NGupcI9heFEfvdq49e4PA6cLCPs381k/lDDCxQ
	 7PlE95FuoCXhZVAjHCZKChbl3uDIANLQwb2Ki9CFJA03LVrCGuiK0QZzcGh29eTc00
	 CfUBqrCTj2mnV3iE0bmjlsQyZxK1XG5rDSLy601nWKdQAso1oueBKQmzIXpoIxhpdw
	 +vM3R5Nm7jRe43bd40zdS/BzwUCv9hDY2HNKTDcrSBHOPY3kOeAAi9ayncqO1VBOe3
	 H0dQeSXOTRkOzaB3BPvAkc4k/XX7JV255faWZZ761Ixt948Hn188MZHb0JvCP+jPe5
	 uEVamrISOzoyQ==
Date: Wed, 14 Jan 2026 14:53:07 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/14] iomap: split out the per-bio logic from
 iomap_dio_bio_iter
Message-ID: <20260114225307.GM15551@frogsfrogsfrogs>
References: <20260114074145.3396036-1-hch@lst.de>
 <20260114074145.3396036-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114074145.3396036-9-hch@lst.de>

On Wed, Jan 14, 2026 at 08:41:06AM +0100, Christoph Hellwig wrote:
> Factor out a separate helper that builds and submits a single bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks like a reasonable straightforward hoist,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 111 +++++++++++++++++++++++--------------------
>  1 file changed, 59 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 1acdab7cf5f1..63374ba83b55 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -301,6 +301,56 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  	return 0;
>  }
>  
> +static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
> +		struct iomap_dio *dio, loff_t pos, unsigned int alignment,
> +		blk_opf_t op)
> +{
> +	struct bio *bio;
> +	ssize_t ret;
> +
> +	bio = iomap_dio_alloc_bio(iter, dio,
> +			bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS),
> +			op);
> +	fscrypt_set_bio_crypt_ctx(bio, iter->inode,
> +			pos >> iter->inode->i_blkbits, GFP_KERNEL);
> +	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
> +	bio->bi_write_hint = iter->inode->i_write_hint;
> +	bio->bi_ioprio = dio->iocb->ki_ioprio;
> +	bio->bi_private = dio;
> +	bio->bi_end_io = iomap_dio_bio_end_io;
> +
> +	ret = bio_iov_iter_get_pages(bio, dio->submit.iter, alignment - 1);
> +	if (unlikely(ret))
> +		goto out_put_bio;
> +	ret = bio->bi_iter.bi_size;
> +
> +	/*
> +	 * An atomic write bio must cover the complete length.  If it doesn't,
> +	 * error out.
> +	 */
> +	if ((op & REQ_ATOMIC) && WARN_ON_ONCE(ret != iomap_length(iter))) {
> +		ret = -EINVAL;
> +		goto out_put_bio;
> +	}
> +
> +	if (dio->flags & IOMAP_DIO_WRITE)
> +		task_io_account_write(ret);
> +	else if (dio->flags & IOMAP_DIO_DIRTY)
> +		bio_set_pages_dirty(bio);
> +
> +	/*
> +	 * We can only poll for single bio I/Os.
> +	 */
> +	if (iov_iter_count(dio->submit.iter))
> +		dio->iocb->ki_flags &= ~IOCB_HIPRI;
> +	iomap_dio_submit_bio(iter, dio, bio, pos);
> +	return ret;
> +
> +out_put_bio:
> +	bio_put(bio);
> +	return ret;
> +}
> +
>  static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  {
>  	const struct iomap *iomap = &iter->iomap;
> @@ -309,12 +359,11 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	const loff_t length = iomap_length(iter);
>  	loff_t pos = iter->pos;
>  	blk_opf_t bio_opf = REQ_SYNC | REQ_IDLE;
> -	struct bio *bio;
>  	bool need_zeroout = false;
> -	int ret = 0;
>  	u64 copied = 0;
>  	size_t orig_count;
>  	unsigned int alignment;
> +	ssize_t ret = 0;
>  
>  	/*
>  	 * File systems that write out of place and always allocate new blocks
> @@ -440,68 +489,27 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	}
>  
>  	do {
> -		size_t n;
> -
>  		/*
>  		 * If completions already occurred and reported errors, give up now and
>  		 * don't bother submitting more bios.
>  		 */
> -		if (unlikely(data_race(dio->error))) {
> -			ret = 0;
> +		if (unlikely(data_race(dio->error)))
>  			goto out;
> -		}
>  
> -		bio = iomap_dio_alloc_bio(iter, dio,
> -				bio_iov_vecs_to_alloc(dio->submit.iter,
> -						BIO_MAX_VECS), bio_opf);
> -		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> -					  GFP_KERNEL);
> -		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
> -		bio->bi_write_hint = inode->i_write_hint;
> -		bio->bi_ioprio = dio->iocb->ki_ioprio;
> -		bio->bi_private = dio;
> -		bio->bi_end_io = iomap_dio_bio_end_io;
> -
> -		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
> -					     alignment - 1);
> -		if (unlikely(ret)) {
> +		ret = iomap_dio_bio_iter_one(iter, dio, pos, alignment, bio_opf);
> +		if (unlikely(ret < 0)) {
>  			/*
>  			 * We have to stop part way through an IO. We must fall
>  			 * through to the sub-block tail zeroing here, otherwise
>  			 * this short IO may expose stale data in the tail of
>  			 * the block we haven't written data to.
>  			 */
> -			bio_put(bio);
> -			goto zero_tail;
> -		}
> -
> -		n = bio->bi_iter.bi_size;
> -		if (WARN_ON_ONCE((bio_opf & REQ_ATOMIC) && n != length)) {
> -			/*
> -			 * An atomic write bio must cover the complete length,
> -			 * which it doesn't, so error. We may need to zero out
> -			 * the tail (complete FS block), similar to when
> -			 * bio_iov_iter_get_pages() returns an error, above.
> -			 */
> -			ret = -EINVAL;
> -			bio_put(bio);
> -			goto zero_tail;
> +			break;
>  		}
> -		if (dio->flags & IOMAP_DIO_WRITE)
> -			task_io_account_write(n);
> -		else if (dio->flags & IOMAP_DIO_DIRTY)
> -			bio_set_pages_dirty(bio);
> -
> -		dio->size += n;
> -		copied += n;
> -
> -		/*
> -		 * We can only poll for single bio I/Os.
> -		 */
> -		if (iov_iter_count(dio->submit.iter))
> -			dio->iocb->ki_flags &= ~IOCB_HIPRI;
> -		iomap_dio_submit_bio(iter, dio, bio, pos);
> -		pos += n;
> +		dio->size += ret;
> +		copied += ret;
> +		pos += ret;
> +		ret = 0;
>  	} while (iov_iter_count(dio->submit.iter));
>  
>  	/*
> @@ -510,7 +518,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	 * the block tail in the latter case, we can expose stale data via mmap
>  	 * reads of the EOF block.
>  	 */
> -zero_tail:
>  	if (need_zeroout ||
>  	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
>  		/* zero out from the end of the write to the end of the block */
> -- 
> 2.47.3
> 
> 

