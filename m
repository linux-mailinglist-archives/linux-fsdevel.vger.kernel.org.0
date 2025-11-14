Return-Path: <linux-fsdevel+bounces-68409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD43C5AC18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 01:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB1223518AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 00:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA692163B2;
	Fri, 14 Nov 2025 00:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fdpqz+vm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3761DE4EF;
	Fri, 14 Nov 2025 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763079738; cv=none; b=n1YF+ykwhJq1TQtkMAwfYHkyz9Eb/6emiNzYrcfip73cYroTPO8rT8+2OvDl5pwy2ixVW6z62SSMslVQIlmKmKI5tBOgqcESeJ//FZhq8W80QHX2PVZUVxQvHzqY9FF+GFK5URquf0zauN2sOXM3ox4HV/n6zC+LpI5yaBCr5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763079738; c=relaxed/simple;
	bh=0GfV0jqFwQWzRF/XGv+/zcvWfkWUsWtCyGdJidvbTgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNGR2T2oouXWgouIx3QxmCWxMRmY2XBGSFlyHmJHf7T+zjvDLcPVO0WQzLB1/5R0R5sjfmW+09EBrodNRXmD7nVP+I9a3+XJ149xJlzM/redPyvaMPEyx57wm93hz5eG2Kb/HvWC2H4BnWubEIG/KF5hJcWpRH7DNO2M21ieRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fdpqz+vm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF29BC4CEF8;
	Fri, 14 Nov 2025 00:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763079734;
	bh=0GfV0jqFwQWzRF/XGv+/zcvWfkWUsWtCyGdJidvbTgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fdpqz+vm7c42sbFTFZOC0iJiffZCDm0CNHUPMw2JPCQbGZNWweg9q00gVnvRjR9ve
	 hnahG3aUd1TZZUohCvCHsjxX4tOBaqlc6iSkso8rmdk3JwDU3KZoShKyR6KFWj6qIM
	 H4KTYacBo9upHTkvzMGyARULRDWWZKXaK3Qxl0zxAt/oz1kFd7Fp+GUN8hLe7a/+P8
	 o9WbUwuRpmePsRMBGakAjGW6fTHJMmJeNu/iRHsFnUIWEMxZT2xSEsgiIDhsyKSRzV
	 rrC/ofvQ9F631xkB8ik0K0j5Oi7/JC7bBbfXfbSy+iX0GHoT5a8ed0PL06sQRznIrj
	 Q9e+qVxD0A6Xw==
Date: Thu, 13 Nov 2025 16:22:10 -0800
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
Subject: Re: [PATCH 6/9] blk-crypto: optimize bio splitting in
 blk_crypto_fallback_encrypt_bio
Message-ID: <20251114002210.GA30712@quark>
References: <20251031093517.1603379-1-hch@lst.de>
 <20251031093517.1603379-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031093517.1603379-7-hch@lst.de>

On Fri, Oct 31, 2025 at 10:34:36AM +0100, Christoph Hellwig wrote:
> The current code in blk_crypto_fallback_encrypt_bio is inefficient and
> prone to deadlocks under memory pressure: It first walks to pass in
> plaintext bio to see how much of it can fit into a single encrypted
> bio using up to BIO_MAX_VEC PAGE_SIZE segments, and then allocates a
> plaintext clone that fits the size, only to allocate another bio for
> the ciphertext later.  While the plaintext clone uses a bioset to avoid
> deadlocks when allocations could fail, the ciphertex one uses bio_kmalloc
> which is a no-go in the file system I/O path.
> 
> Switch blk_crypto_fallback_encrypt_bio to walk the source plaintext bio
> while consuming bi_iter without cloning it, and instead allocate a
> ciphertext bio at the beginning and whenever we fille up the previous
> one.  The existing bio_set for the plaintext clones is reused for the
> ciphertext bios to remove the deadlock risk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-crypto-fallback.c | 162 ++++++++++++++----------------------
>  1 file changed, 63 insertions(+), 99 deletions(-)
> 
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index 86b27f96051a..1f58010fb437 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -152,35 +152,26 @@ static void blk_crypto_fallback_encrypt_endio(struct bio *enc_bio)
>  
>  	src_bio->bi_status = enc_bio->bi_status;

There can now be multiple enc_bios completing for the same src_bio, so
this needs something like:

	if (enc_bio->bi_status)
		cmpxchg(&src_bio->bi_status, 0, enc_bio->bi_status);

> -static struct bio *blk_crypto_fallback_clone_bio(struct bio *bio_src)
> +static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
> +		unsigned int nr_segs)
>  {
> -	unsigned int nr_segs = bio_segments(bio_src);
> -	struct bvec_iter iter;
> -	struct bio_vec bv;
>  	struct bio *bio;
>  
> -	bio = bio_kmalloc(nr_segs, GFP_NOIO);
> -	if (!bio)
> -		return NULL;
> -	bio_init_inline(bio, bio_src->bi_bdev, nr_segs, bio_src->bi_opf);
> +	bio = bio_alloc_bioset(bio_src->bi_bdev, nr_segs, bio_src->bi_opf,
> +			GFP_NOIO, &crypto_bio_split);

Rename crypto_bio_split => enc_bio_set?

> @@ -257,34 +222,22 @@ static void blk_crypto_dun_to_iv(const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
>   */
>  static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
>  {

I don't think this patch makes sense by itself, since it leaves the
bio_ptr argument that is used to return a single enc_bio.  It does get
updated later in the series, but it seems that additional change to how
this function is called should go earlier in the series.

> +	/* Encrypt each page in the origin bio */

Maybe origin => source, so that consistent terminology is used.

> +		if (++enc_idx == enc_bio->bi_max_vecs) {
> +			/*
> +			 * Each encrypted bio will call bio_endio in the
> +			 * completion handler, so ensure the remaining count
> +			 * matches the number of submitted bios.
> +			 */
> +			bio_inc_remaining(src_bio);
> +			submit_bio(enc_bio);

The above comment is a bit confusing and could be made clearer.  When we
get here for the first time for example, we increment remaining from 1
to 2.  It doesn't match the number of bios submitted so far, but rather
is one more than it.  The extra one pairs with the submit_bio() outside
the loop.  Maybe consider the following:

			/*
			 * For each additional encrypted bio submitted,
			 * increment the source bio's remaining count.  Each
			 * encrypted bio's completion handler calls bio_endio on
			 * the source bio, so this keeps the source bio from
			 * completing until the last encrypted bio does.
			 */

> +out_ioerror:
> +	while (enc_idx > 0)
> +		mempool_free(enc_bio->bi_io_vec[enc_idx--].bv_page,
> +			     blk_crypto_bounce_page_pool);
> +	bio_put(enc_bio);
> +	src_bio->bi_status = BLK_STS_IOERR;

This error path doesn't seem correct at all.  It would need to free the
full set of pages in enc_bio, not just the ones initialized so far.  It
would also need to use cmpxchg() to correctly set an error on the
src_bio considering that blk_crypto_fallback_encrypt_endio() be trying
to do it concurrently too, and then call bio_endio() on it.

(It's annoying that encryption errors need to be handled at all.  When I
eventually convert this to use lib/crypto/, the encryption functions are
just going to return void.  But for now this is using the traditional
API, which can fail, so technically errors need to be handled...)

- Eric

