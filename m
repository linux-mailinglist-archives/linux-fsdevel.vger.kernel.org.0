Return-Path: <linux-fsdevel+bounces-67408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A6BC3E695
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 05:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A97188B2A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 04:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2BB2877F6;
	Fri,  7 Nov 2025 04:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpYpUgEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEE01991D2;
	Fri,  7 Nov 2025 04:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762488480; cv=none; b=eZPdfFiUp8uknBzsNgNTYspfUGHtLfmTWMviyiBmjxvh7PvJXmudi2pLIUfegdw0oDyVAIpXJ0Dg7pUW/bb5t9AAIdV4qku83FOIZxconWbbSjm/u8zQzdgm0wyN0cE6WqQ2NJXsh7CmaIjuq/Yoroik6N9pz317uhXgre48cNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762488480; c=relaxed/simple;
	bh=7R612qBUPvSWvCwpdWHa4cwpfUnAwNhOskr7iKaQgSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcAuUXi3cK4r9ZKzSEO+FzbFeMBmqZW7qabfKxXWaM5W2la/TrLHIqfoWE1O9wGJmydSoQgY4jlSIVJmrnLldGgic1UMl7iwXYZktWH4j3j6J4Edpbm1wf0qs1eHNXzZHfYHFX0+ibmSdp4iuEWEIkqSwWfhwBqlbE80HJX8q8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpYpUgEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CA7C116C6;
	Fri,  7 Nov 2025 04:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762488480;
	bh=7R612qBUPvSWvCwpdWHa4cwpfUnAwNhOskr7iKaQgSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpYpUgEtsszxOvLdFNToRe2bHvEuDrJFWRXKOTWQGtEjhVgxH85oRQ2qbpBV+AK85
	 Cim/1w4+e3AfDCVYhUWQii6U7F6+Tm69/EkXTjnG+YpS3BU2o5CHAdeDU3MhzqcrqA
	 cHuKAO91oUjZ/DaFFFnNhDOy/sdYwKUsL/CG5Bbn9lf+VlcVWFj2D0ZdhNujjnmp+S
	 e8rsgfO3ETObBv9oO/PRtKTMoYIoYTyTYfYg9tBbD6TTFJNW+FLfSBLPzxQS0WXmyg
	 7O3XiVyup0QcPwElB0a2whqgj4KPcExfyp+9Y2pSn9y90ylVN2O5/8Yv6merKBLglS
	 ZOSLRD5E52c+w==
Date: Thu, 6 Nov 2025 20:06:19 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 5/9] fscrypt: keep multiple bios in flight in
 fscrypt_zeroout_range_inline_crypt
Message-ID: <20251107040619.GC47797@sol>
References: <20251031093517.1603379-1-hch@lst.de>
 <20251031093517.1603379-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031093517.1603379-6-hch@lst.de>

On Fri, Oct 31, 2025 at 10:34:35AM +0100, Christoph Hellwig wrote:
> This should slightly improve performance for large zeroing operations,
> but more importantly prepares for blk-crypto refactoring that requires
> all fscrypt users to call submit_bio directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/crypto/bio.c | 84 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 53 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index 68b0424d879a..e59d342b4240 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -47,49 +47,71 @@ bool fscrypt_decrypt_bio(struct bio *bio)
>  }
>  EXPORT_SYMBOL(fscrypt_decrypt_bio);
>  
> +struct fscrypt_zero_done {
> +	atomic_t		pending;
> +	blk_status_t		status;
> +	struct completion	done;
> +};
> +
> +static void fscrypt_zeroout_range_done(struct fscrypt_zero_done *done)
> +{
> +	if (atomic_dec_and_test(&done->pending))
> +		complete(&done->done);
> +}
> +
> +static void fscrypt_zeroout_range_end_io(struct bio *bio)
> +{
> +	struct fscrypt_zero_done *done = bio->bi_private;
> +
> +	if (bio->bi_status)
> +		cmpxchg(&done->status, 0, bio->bi_status);
> +	fscrypt_zeroout_range_done(done);
> +	bio_put(bio);
> +}
> +
>  static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
>  					      pgoff_t lblk, sector_t sector,
>  					      unsigned int len)
>  {
>  	const unsigned int blockbits = inode->i_blkbits;
>  	const unsigned int blocks_per_page = 1 << (PAGE_SHIFT - blockbits);
> -	struct bio *bio;
> -	int ret, err = 0;
> -	int num_pages = 0;
> +	struct fscrypt_zero_done done = {};
>  
> -	/* This always succeeds since __GFP_DIRECT_RECLAIM is set. */
> -	bio = bio_alloc(inode->i_sb->s_bdev, BIO_MAX_VECS, REQ_OP_WRITE,
> -			GFP_NOFS);
> +	atomic_set(&done.pending, 1);
> +	init_completion(&done.done);

This could use:

	struct fscrypt_zero_done done = {
		.pending = ATOMIC_INIT(1),
		.done = COMPLETION_INITIALIZER_ONSTACK(done.done),
	};

Either way:

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

