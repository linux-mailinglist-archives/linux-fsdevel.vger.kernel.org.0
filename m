Return-Path: <linux-fsdevel+bounces-73848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8526D21B23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 00:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDDE33044875
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D264B38E5C1;
	Wed, 14 Jan 2026 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuiEJrl/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056135505B;
	Wed, 14 Jan 2026 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431586; cv=none; b=cGRvg1Rp35rU9RENzSV5JLKHvdt8WFss5kLdajjW170dEQ913Gt/CTKXpVQ2Wdd2jvijAmDWv/JEBoZmR5CaBwn7laWKZXMlYxUA5tgXx3KnqVHPScSqM/W0+EpKGkccxzCjddtOAbrrgnq3ExbLvORmL/uorX1TjKQ3Fo6znfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431586; c=relaxed/simple;
	bh=aJHfGzglx7DLvolxkYQlpNPkyOlW72olO2USzFCqUDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX7iLg6hLU5v2CtC/6bZvO/WNJuyP+3DEMKaSYzbfzTMIvavp1f4LZBZZhseroXOYZVze5KI3Ky7/zfqFWm9PzxG3jv4VA9P/Xutk1xX6tqlAQRDX2HUUDS7w01oZvwBNXUf7+7tZJ4Fsr2D+DiST+jlnlT3bs6EuM30tYKY4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuiEJrl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50932C4CEF7;
	Wed, 14 Jan 2026 22:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768431585;
	bh=aJHfGzglx7DLvolxkYQlpNPkyOlW72olO2USzFCqUDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CuiEJrl/YXw9Mze4T1zWymFCw40R/Zut5rDuZHmJ/O5Upho1cgD/OIx9tTcmjFSQ6
	 NkOIchFGxVfjrtzBZTodWflLH4rxG1B+VXLc5xtNWTWIrFz/lBGamCgWTJrzt7sjIS
	 zXHSa9ytZILxyAsHvio3N3pTfqflkzKOEOUBYCGfCIagRFmLZtRbo6ncDEr1lgXK8Y
	 7pzsdBcTR/J4sN+9S15uEexZNRykSwYdERFIL2Y15P4BEREW/w68S+LIlF+r5opcWZ
	 OyNjt+NWi2U3GuR7xMTvaVdtEZIVDmn5nANiObDEnHfgoit9REbD1voTMVJaLNPuo/
	 WZEbF35/HkyrA==
Date: Wed, 14 Jan 2026 14:59:44 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/14] iomap: add a flag to bounce buffer direct I/O
Message-ID: <20260114225944.GR15551@frogsfrogsfrogs>
References: <20260114074145.3396036-1-hch@lst.de>
 <20260114074145.3396036-14-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114074145.3396036-14-hch@lst.de>

On Wed, Jan 14, 2026 at 08:41:11AM +0100, Christoph Hellwig wrote:
> Add a new flag that request bounce buffering for direct I/O.  This is
> needed to provide the stable pages requirement requested by devices
> that need to calculate checksums or parity over the data and allows
> file systems to properly work with things like T10 protection
> information.  The implementation just calls out to the new bio bounce
> buffering helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This seems pretty sensible, assuming bio_iov_iter_bounce does what I
think it does (sets up the bio with the bounce buffer pages instead of
the user-backed pages for a zero-copy IO) right?

If so, then

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c  | 30 ++++++++++++++++++++----------
>  include/linux/iomap.h |  9 +++++++++
>  2 files changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 3f552245ecc2..83fef3210e2b 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -214,7 +214,11 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
>  {
>  	struct iomap_dio *dio = bio->bi_private;
>  
> -	if (dio->flags & IOMAP_DIO_USER_BACKED) {
> +	if (dio->flags & IOMAP_DIO_BOUNCE) {
> +		bio_iov_iter_unbounce(bio, !!dio->error,
> +				dio->flags & IOMAP_DIO_USER_BACKED);
> +		bio_put(bio);
> +	} else if (dio->flags & IOMAP_DIO_USER_BACKED) {
>  		bio_check_pages_dirty(bio);
>  	} else {
>  		bio_release_pages(bio, false);
> @@ -300,12 +304,16 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>  		struct iomap_dio *dio, loff_t pos, unsigned int alignment,
>  		blk_opf_t op)
>  {
> +	unsigned int nr_vecs;
>  	struct bio *bio;
>  	ssize_t ret;
>  
> -	bio = iomap_dio_alloc_bio(iter, dio,
> -			bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS),
> -			op);
> +	if (dio->flags & IOMAP_DIO_BOUNCE)
> +		nr_vecs = bio_iov_bounce_nr_vecs(dio->submit.iter, op);
> +	else
> +		nr_vecs = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
> +
> +	bio = iomap_dio_alloc_bio(iter, dio, nr_vecs, op);
>  	fscrypt_set_bio_crypt_ctx(bio, iter->inode,
>  			pos >> iter->inode->i_blkbits, GFP_KERNEL);
>  	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
> @@ -314,7 +322,11 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>  	bio->bi_private = dio;
>  	bio->bi_end_io = iomap_dio_bio_end_io;
>  
> -	ret = bio_iov_iter_get_pages(bio, dio->submit.iter, alignment - 1);
> +	if (dio->flags & IOMAP_DIO_BOUNCE)
> +		ret = bio_iov_iter_bounce(bio, dio->submit.iter);
> +	else
> +		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
> +					     alignment - 1);
>  	if (unlikely(ret))
>  		goto out_put_bio;
>  	ret = bio->bi_iter.bi_size;
> @@ -330,7 +342,8 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>  
>  	if (dio->flags & IOMAP_DIO_WRITE)
>  		task_io_account_write(ret);
> -	else if (dio->flags & IOMAP_DIO_USER_BACKED)
> +	else if ((dio->flags & IOMAP_DIO_USER_BACKED) &&
> +		 !(dio->flags & IOMAP_DIO_BOUNCE))
>  		bio_set_pages_dirty(bio);
>  
>  	/*
> @@ -659,7 +672,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	dio->i_size = i_size_read(inode);
>  	dio->dops = dops;
>  	dio->error = 0;
> -	dio->flags = 0;
> +	dio->flags = dio_flags & (IOMAP_DIO_FSBLOCK_ALIGNED | IOMAP_DIO_BOUNCE);
>  	dio->done_before = done_before;
>  
>  	dio->submit.iter = iter;
> @@ -668,9 +681,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iomi.flags |= IOMAP_NOWAIT;
>  
> -	if (dio_flags & IOMAP_DIO_FSBLOCK_ALIGNED)
> -		dio->flags |= IOMAP_DIO_FSBLOCK_ALIGNED;
> -
>  	if (iov_iter_rw(iter) == READ) {
>  		if (iomi.pos >= dio->i_size)
>  			goto out_free_dio;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 6bb941707d12..ea79ca9c2d6b 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -566,6 +566,15 @@ struct iomap_dio_ops {
>   */
>  #define IOMAP_DIO_FSBLOCK_ALIGNED	(1 << 3)
>  
> +/*
> + * Bounce buffer instead of using zero copy access.
> + *
> + * This is needed if the device needs stable data to checksum or generate
> + * parity.  The file system must hook into the I/O submission and offload
> + * completions to user context for reads when this is set.
> + */
> +#define IOMAP_DIO_BOUNCE		(1 << 4)
> +
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags, void *private, size_t done_before);
> -- 
> 2.47.3
> 
> 

