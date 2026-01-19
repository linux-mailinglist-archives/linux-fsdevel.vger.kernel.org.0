Return-Path: <linux-fsdevel+bounces-74510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C625D3B4E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FD703020999
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECBE32D0E6;
	Mon, 19 Jan 2026 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGwF65TA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860F82EAD0D;
	Mon, 19 Jan 2026 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844601; cv=none; b=B9aGVXUyRNM0CJk7vX/3KqJ31imXJPmyGLP+mDz8vhLonzPwA39nTRdNMQj7nX/E7uASTrOlp3vklsO/dIZQyVxDoWNPIoSBUF/HL1zNjIdys7ZP8CjPpEFEA9Av8n/JfgpnKD8IX++EEsxvz/9+IWrjHwzGNtMxxQtn96J+oNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844601; c=relaxed/simple;
	bh=cdGIOFFRvnJlxGn9hpb0uGv6wfMUu6FzeqR6WDnLUp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgLvf72hEvDIOjNoUImYwPgtUFrj7FGunpYy4fjNabD5CbnAAKGZQMizlwEPRAo3hX0H8xG14oNrLYEmnSF3kvJlyv1msJJA21zTnzIQPxPSWxka2aSHltWiswJUWl6KnCgxwKTVfennZvSVziz4UvCrfeHeNUx7wQHrjEIHUbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGwF65TA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AB4C116C6;
	Mon, 19 Jan 2026 17:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768844601;
	bh=cdGIOFFRvnJlxGn9hpb0uGv6wfMUu6FzeqR6WDnLUp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MGwF65TA3gitDjhoZnbKDkEA2sh1RCYXQ5D791luNBaSbqKWcxX/jv1dNla0PpTXI
	 nylKKrYDr9hB6F6pCbC0GaSTcDNkZZchpXRO4sDb148KMZB/u6TshbUmF1wj5qJGqM
	 VcKMcyAGXXkRFupsV5Di4KEHUCHjXxR/QH5BqiMBkDkRPNeDmhLYryD3x5bAPJU+qk
	 IJfGfEpKBU+uQdxu2deEEOmM0nK+IzhrV4DEJLYPS5Jos0sQReuiYPHIJAXPpQYGmV
	 LrsqY2ubZyuYrFE0NHP5FCsRaOzUyOL2egpFrW6CH/1B4XdMi8Pnz+QY2M39xWvEMZ
	 pBXWgocItyD5Q==
Date: Mon, 19 Jan 2026 09:43:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/14] iomap: simplify iomap_dio_bio_iter
Message-ID: <20260119174320.GB15551@frogsfrogsfrogs>
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119074425.4005867-8-hch@lst.de>

On Mon, Jan 19, 2026 at 08:44:14AM +0100, Christoph Hellwig wrote:
> Use iov_iter_count to check if we need to continue as that just reads
> a field in the iov_iter, and only use bio_iov_vecs_to_alloc to calculate
> the actual number of vectors to allocate for the bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

/me is satisfied that bio_iov_vecs_to_alloc -> iov_iter_count is a
reasonable enough substitution.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 867c0ac6df8f..de03bc7cf4ed 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -312,7 +312,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	blk_opf_t bio_opf = REQ_SYNC | REQ_IDLE;
>  	struct bio *bio;
>  	bool need_zeroout = false;
> -	int nr_pages, ret = 0;
> +	int ret = 0;
>  	u64 copied = 0;
>  	size_t orig_count;
>  	unsigned int alignment;
> @@ -440,7 +440,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  			goto out;
>  	}
>  
> -	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
>  	do {
>  		size_t n;
>  
> @@ -453,7 +452,9 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
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
> @@ -495,16 +496,14 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
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

