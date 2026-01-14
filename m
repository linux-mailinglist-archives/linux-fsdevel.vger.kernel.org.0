Return-Path: <linux-fsdevel+bounces-73841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFBED21A85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 23:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CA9430321D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D11E326D76;
	Wed, 14 Jan 2026 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Frtu++b7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26C3570B5;
	Wed, 14 Jan 2026 22:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431084; cv=none; b=IQ09rr882ZYTZxJBTUzEI3nj6BNHpW4Zz2CWcCadSlsJb7KqF2w+DKMn5nl2yIKSfwWiFCiptQWdRdyyxORpV0GxRixaXAxkjfpSfMSSS4BqjtValiyuQxAx/dEZcNGgnBggkFolxR/7gJ5MWh88jlJzKYWR012iZvZ5q2A58FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431084; c=relaxed/simple;
	bh=OTQcvC5QOKg2dM9Eb5MLUnNT5D5bNgLD+5Wp/6fZIoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYnCxRuDxnSly2IwmqNdL/w/rLdpNbh/ZhyvVxFPTsvtJA4WDhVK4Q2kteqyl0nB1M/J3o8AHjzM5NQOKG/xBjku7H9z6n+3zELGmuy20xHfedUeDaZT8UvVJpTU8TwRrzbkE5ICflvCBvczooeym8DC3h0/zFS1Ai3P9o5Atug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Frtu++b7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC38C4CEF7;
	Wed, 14 Jan 2026 22:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768431084;
	bh=OTQcvC5QOKg2dM9Eb5MLUnNT5D5bNgLD+5Wp/6fZIoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Frtu++b73hUs8hMopCDmeY+6Hbv03oPJy6s6IKYV+v1EI5DqMruIcjtlujhUDgww7
	 3rh9erffqMXSkV5Sj081I7R9q1Up6rU3zWY3bDoSwbCui9ptXq72AGPTq5ype7jfDy
	 0+zOdf+rAvEpvoCSzth0HnRC1DleXHJ5G6wvixJFWp6dEBU0dUzjoDAWqB7oCLCWmY
	 3Rw56e6uepAtTYUjCvxWKxJx8GwnxWnM4lbt18OHcWcAj2zbwZ86qBlhm2kzNVLUqx
	 Q2b0jqvVdSsbnf5AXHQ6IP5CS1qKFw9mYW0ztU0HCKHSbQkK3z3GE++/o0vJCA4TE3
	 E69WsY6V6xD/A==
Date: Wed, 14 Jan 2026 14:51:23 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/14] iomap: simplify iomap_dio_bio_iter
Message-ID: <20260114225123.GL15551@frogsfrogsfrogs>
References: <20260114074145.3396036-1-hch@lst.de>
 <20260114074145.3396036-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114074145.3396036-8-hch@lst.de>

On Wed, Jan 14, 2026 at 08:41:05AM +0100, Christoph Hellwig wrote:
> Use iov_iter_count to check if we need to continue as that just reads
> a field in the iov_iter, and only use bio_iov_vecs_to_alloc to calculate
> the actual number of vectors to allocate for the bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Huh, interesting.  bio_iov_vecs_to_alloc returns 0 if the iov_iter is of
type bvec, so I guess we'd only run the loop body once before, and with
zero pages?  Hrmm, that doesn't seem right.

Does that mean that we could always construct a bio for the entire bvec?
Or does that just mean that directio doesn't get called with a bvec
iterator?

Or, basic question: what the heck is a bvec?  A bio_vec?  So perhaps
iomap_dio_bio_iter can't be called with a bio_vec because we're
constructing a bio, not dealing with an existing one?

<have the cold meds kicked in yet?>

--D

> ---
>  fs/iomap/direct-io.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 6ec4940e019c..1acdab7cf5f1 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -311,7 +311,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	blk_opf_t bio_opf = REQ_SYNC | REQ_IDLE;
>  	struct bio *bio;
>  	bool need_zeroout = false;
> -	int nr_pages, ret = 0;
> +	int ret = 0;
>  	u64 copied = 0;
>  	size_t orig_count;
>  	unsigned int alignment;
> @@ -439,7 +439,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  			goto out;
>  	}
>  
> -	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
>  	do {
>  		size_t n;
>  
> @@ -452,7 +451,9 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  			goto out;
>  		}
>  
> -		bio = iomap_dio_alloc_bio(iter, dio, nr_pages, bio_opf);
> +		bio = iomap_dio_alloc_bio(iter, dio,
> +				bio_iov_vecs_to_alloc(dio->submit.iter,
> +						BIO_MAX_VECS), bio_opf);
>  		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>  					  GFP_KERNEL);
>  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
> @@ -494,16 +495,14 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  		dio->size += n;
>  		copied += n;
>  
> -		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
> -						 BIO_MAX_VECS);
>  		/*
>  		 * We can only poll for single bio I/Os.
>  		 */
> -		if (nr_pages)
> +		if (iov_iter_count(dio->submit.iter))
>  			dio->iocb->ki_flags &= ~IOCB_HIPRI;
>  		iomap_dio_submit_bio(iter, dio, bio, pos);
>  		pos += n;
> -	} while (nr_pages);
> +	} while (iov_iter_count(dio->submit.iter));
>  
>  	/*
>  	 * We need to zeroout the tail of a sub-block write if the extent type
> -- 
> 2.47.3
> 
> 

