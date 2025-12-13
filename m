Return-Path: <linux-fsdevel+bounces-71226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBB5CBA274
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 02:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB1CF30B0971
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 01:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524DC1DE4DC;
	Sat, 13 Dec 2025 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIpLpSvM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12363B8D68;
	Sat, 13 Dec 2025 01:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765588904; cv=none; b=KK78bc7ZLFebpy9jzuu2GaNSl+r0ShAXlZeVsPWEdbWlfBHBNSc7mFeQaUyvaWgJv+cUwcMW/GeM/kHbidkcnwCu854KJmJr1LvNcCxgKOtWkcz/CKAZcLOzZOEZ7Nit92N8wjU7+0nVIcKUGe9Bj2sqgZ15oGhaqnv+e2rw1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765588904; c=relaxed/simple;
	bh=pM8PslJELS5gsXTSWg5Iw5BUpyL1kOOx5w5IJKptfsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ksi5HU20EPaFvoEM7uUjsAYIVcdy/9Q0NgJifMjKTFTkwTxW2W1hc9i402/e6F15D3Rt4sixX+o6I6XxI72Y8EYMj3Su8fL7XPqlDMd49twyGBOmVicPDM7gK/mdjQSt53N9zzdOeXtmxwDpMCJ7i9J7znETT9M00IsCUmDvxW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIpLpSvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BBAC4CEF1;
	Sat, 13 Dec 2025 01:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765588904;
	bh=pM8PslJELS5gsXTSWg5Iw5BUpyL1kOOx5w5IJKptfsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIpLpSvMVU+CY9aOgdrgkn83sSSdUm0RxPKTWfu4hGz/V89PSeVbvxZb/OlgchSHV
	 pCY6zZHsdkF0YE6RKmIPIPp+yLYXxZ+RwuC0cHQ/Dxzrul7kcqVr1XPNDS85+q5xAJ
	 8joKFAac1SJ2zZ2SJlse9SB7SrGLSGlHvPjNTgTD0fJkUYzpHnQY/6CGrtYn2ZMN6h
	 pBMd+/XdW3vjF6xCqYZBAHZ8sZn1UkRso2phi3iJQK+fqBufHf5tcrciCyC1Wj7bWp
	 QlX/T//eRhgpFb0YqWOzXxvm8h6Hf9tK40/8OO8vSqbEnT+weJH6xJeQwXB9Vq92hp
	 /odGnOz20uE0A==
Date: Fri, 12 Dec 2025 17:21:41 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 7/9] blk-crypto: use mempool_alloc_bulk for encrypted bio
 page allocation
Message-ID: <20251213012141.GE2696@quark>
References: <20251210152343.3666103-1-hch@lst.de>
 <20251210152343.3666103-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210152343.3666103-8-hch@lst.de>

On Wed, Dec 10, 2025 at 04:23:36PM +0100, Christoph Hellwig wrote:
> Calling mempool_alloc in a lot is not safe unless the maximum allocation

lot => loop

> +	/*
> +	 * Try a bulk allocation first.  This could leave random pages in the
> +	 * array unallocated, but we'll fix that up later in mempool_alloc_bulk.
> +	 *
> +	 * Note: alloc_pages_bulk needs the array to be zeroed, as it assumes
> +	 * any non-zero slot already contains a valid allocation.
> +	 */
> +	memset(pages, 0, sizeof(struct page *) * nr_segs);
> +	nr_allocated = alloc_pages_bulk(GFP_KERNEL, nr_segs, pages);
> +	if (nr_allocated < nr_segs)
> +		mempool_alloc_bulk(blk_crypto_bounce_page_pool, (void **)pages,
> +				nr_segs, nr_allocated);

alloc_pages_bulk() is documented to fill in pages sequentially.  So the
"random pages in the array unallocated" part seems misleading.  This
also means that only the remaining portion needs to be passed to
mempool_alloc_bulk(), similar to blk_crypto_fallback_encrypt_endio().

> @@ -210,6 +249,7 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
>  	u64 curr_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
>  	struct scatterlist src, dst;
>  	union blk_crypto_iv iv;
> +	struct page **enc_pages;
>  	unsigned int enc_idx;
>  	struct bio *enc_bio;
>  	unsigned int j;
> @@ -227,15 +267,13 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
>  
>  	/* Encrypt each page in the source bio */
>  new_bio:
> -	enc_bio = blk_crypto_alloc_enc_bio(src_bio, nr_segs);
> +	enc_bio = blk_crypto_alloc_enc_bio(src_bio, nr_segs, &enc_pages);
>  	enc_idx = 0;
>  	for (;;) {
>  		struct bio_vec src_bv =
>  			bio_iter_iovec(src_bio, src_bio->bi_iter);
> -		struct page *enc_page;
> +		struct page *enc_page = enc_pages[enc_idx];
>  
> -		enc_page = mempool_alloc(blk_crypto_bounce_page_pool,
> -				GFP_NOIO);
>  		__bio_add_page(enc_bio, enc_page, src_bv.bv_len,
>  				src_bv.bv_offset);
[...]
> out_free_bounce_pages:
> 	enc_idx++;
> 	while (enc_idx > 0)
> 		mempool_free(enc_bio->bi_io_vec[--enc_idx].bv_page,
> 			     blk_crypto_bounce_page_pool);
> 	bio_put(enc_bio);

This error handling path looks incorrect after this change.  It needs to
free all the pages, not just the ones used so far.

Otherwise this looks good, thanks.

- Eric

