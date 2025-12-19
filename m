Return-Path: <linux-fsdevel+bounces-71779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8840CD1BE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 21:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0CBB30601B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC7B33ADB1;
	Fri, 19 Dec 2025 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvP5AfLE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7041C3BB44;
	Fri, 19 Dec 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766175943; cv=none; b=oKPkbdcAI8kf+ZdIDMceMg0dLCDJaBuJ5RwwKq1jLMg0xTxRZqepIFdpUwU4ldKJB2BPBzUbWNLWbdSsJYm/rjx8zXd7Ky7o10CwpVS/67OBceU91Ap2VppVw96W/0v2F4YPRcLhZiSueJLj+6bfgHvsHoOCeFOHkZi7KZItaDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766175943; c=relaxed/simple;
	bh=SHB1c/Mt35w8ehZ2mu70GI9/3KMFJySg6IrHgEOWOcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTyL8NeV1jz5ct8TD8JHZh4YWKQlx0EWJfHgxcJUOdvkMX82An+lLi+mF9+UATstTy7juzZVzYjLbBq3hjZ/HlWPu2y9bDxJx5tZ3f8pWtwqanbyjdCSgpY54girqgpzKEnkWtKO8OAYhb5KMoBpaD4cvYiS7A1/GqAA2AwvV/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvP5AfLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E027EC4CEF1;
	Fri, 19 Dec 2025 20:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766175943;
	bh=SHB1c/Mt35w8ehZ2mu70GI9/3KMFJySg6IrHgEOWOcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvP5AfLEgSNwHAVtlr0ZfJE17v+bnHhKFSSLSmi8p9/ttWhm6JVOzcyr2CUuh5gKJ
	 Dwh4nQxdHyDx8raqER44nqenFZvYTmTVNBq4TQsaut/nxAqULZ4tVNwwfoq/ad/tyL
	 eSpPL4m5I7KmGPCRm9BRvxk+FoPItO5fqzBdS9sMm3ItGhklmWT43hhp4boYLRJss/
	 ZPndaAce7oG5BP4bKeyC8WV0f9lsX6P/48R/VFru8XAzQcXyIqZVhwzDAkFpRBDdnr
	 VLc3us0Dd3mwK+Z5m4VEMuQFIlH6KwVYWvUNXPRynoQ9nzNr9ymnICeSpC1bsDt0Bv
	 lzQXZ8ubjkI4g==
Date: Fri, 19 Dec 2025 12:25:33 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 7/9] blk-crypto: use mempool_alloc_bulk for encrypted bio
 page allocation
Message-ID: <20251219202533.GA397103@sol>
References: <20251217060740.923397-1-hch@lst.de>
 <20251217060740.923397-8-hch@lst.de>
 <20251219200244.GE1602@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219200244.GE1602@sol>

On Fri, Dec 19, 2025 at 12:02:44PM -0800, Eric Biggers wrote:
> On Wed, Dec 17, 2025 at 07:06:50AM +0100, Christoph Hellwig wrote:
> >  new_bio:
> > -	enc_bio = blk_crypto_alloc_enc_bio(src_bio, nr_segs);
> > +	enc_bio = blk_crypto_alloc_enc_bio(src_bio, nr_segs, &enc_pages);
> >  	enc_idx = 0;
> >  	for (;;) {
> >  		struct bio_vec src_bv =
> >  			bio_iter_iovec(src_bio, src_bio->bi_iter);
> > -		struct page *enc_page;
> > +		struct page *enc_page = enc_pages[enc_idx];
> >  
> > -		enc_page = mempool_alloc(blk_crypto_bounce_page_pool,
> > -				GFP_NOIO);
> >  		__bio_add_page(enc_bio, enc_page, src_bv.bv_len,
> >  				src_bv.bv_offset);
> >  
> > @@ -246,10 +284,8 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
> >  		/* Encrypt each data unit in this page */
> >  		for (j = 0; j < src_bv.bv_len; j += data_unit_size) {
> >  			blk_crypto_dun_to_iv(curr_dun, &iv);
> > -			if (crypto_skcipher_encrypt(ciph_req)) {
> > -				enc_idx++;
> > -				goto out_free_bounce_pages;
> > -			}
> > +			if (crypto_skcipher_encrypt(ciph_req))
> > +				goto out_free_enc_bio;
> >  			bio_crypt_dun_increment(curr_dun, 1);
> >  			src.offset += data_unit_size;
> >  			dst.offset += data_unit_size;
> > @@ -278,9 +314,9 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
> >  	submit_bio(enc_bio);
> >  	return;
> >  
> > -out_free_bounce_pages:
> > -	while (enc_idx > 0)
> > -		mempool_free(enc_bio->bi_io_vec[--enc_idx].bv_page,
> > +out_free_enc_bio:
> > +	for (enc_idx = 0; enc_idx < enc_bio->bi_max_vecs; enc_idx++)
> > +		mempool_free(enc_bio->bi_io_vec[enc_idx].bv_page,
> >  			     blk_crypto_bounce_page_pool);
> >  	bio_put(enc_bio);
> >  	cmpxchg(&src_bio->bi_status, 0, BLK_STS_IOERR);
> 
> The error handling at out_free_enc_bio is still broken, I'm afraid.
> It's not taking into account that some of the pages may have been moved
> into bvecs and some have not.
> 
> I think it needs something like the following:
> 
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index 23e097197450..d6760404b76c 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -272,7 +272,7 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
>  	for (;;) {
>  		struct bio_vec src_bv =
>  			bio_iter_iovec(src_bio, src_bio->bi_iter);
> -		struct page *enc_page = enc_pages[enc_idx];
> +		struct page *enc_page;
>  
>  		if (!IS_ALIGNED(src_bv.bv_len | src_bv.bv_offset,
>  				data_unit_size)) {
> @@ -280,6 +280,7 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
>  			goto out_free_enc_bio;
>  		}
>  
> +		enc_page = enc_pages[enc_idx++];
>  		__bio_add_page(enc_bio, enc_page, src_bv.bv_len,
>  				src_bv.bv_offset);
>  
> @@ -305,7 +306,7 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
>  			break;
>  
>  		nr_segs--;
> -		if (++enc_idx == enc_bio->bi_max_vecs) {
> +		if (enc_idx == enc_bio->bi_max_vecs) {
>  			/*
>  			 * For each additional encrypted bio submitted,
>  			 * increment the source bio's remaining count.  Each
> @@ -323,9 +324,11 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
>  	return;
>  
>  out_free_enc_bio:
> -	for (enc_idx = 0; enc_idx < enc_bio->bi_max_vecs; enc_idx++)
> +	for (j = 0; j < enc_idx; j++)
>  		mempool_free(enc_bio->bi_io_vec[j].bv_page,
>  			     blk_crypto_bounce_page_pool);
> +	for (; j < enc_bio->bi_max_vecs; j++)
> +		mempool_free(enc_pages[j], blk_crypto_bounce_page_pool);
>  	bio_put(enc_bio);
>  	bio_endio(src_bio);
>  }

Also, this shows that the decrement of 'nr_segs' is a bit out-of-place
(as was 'enc_idx').  nr_segs is used only when allocating a bio, so it
could be decremented only when starting a new one:

        submit_bio(enc_bio);
        nr_segs -= nr_enc_pages;                                 
        goto new_bio;                                            

- Eric

