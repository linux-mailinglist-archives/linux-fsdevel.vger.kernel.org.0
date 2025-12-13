Return-Path: <linux-fsdevel+bounces-71228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 280E0CBA28F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 02:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EA0B30B1156
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 01:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAFB19D074;
	Sat, 13 Dec 2025 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmN3miib"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A011862;
	Sat, 13 Dec 2025 01:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765589445; cv=none; b=uWya+F1fpjOSnO8FWwORJdz9Aeuxn4JJNOKQeztKs1eIYlCoyFZYu0dCVepp91CcO4c9whONxyMV5bU0LpIfajSqSKuuw0Lu1dAVbyKsuzRmIdam6Y8YfPpnIbqNFL8Q99gSk0Whe667rZpdLzM2rvFNxu9sPL1RTsIjPWLRZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765589445; c=relaxed/simple;
	bh=S5/Rqw8UA6ndvi7n7Q2Zrz8uh4Yjy2WjPREEyroEFBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4sxw8vpmUyTiQ3dCO1HiVXF396krTuiP45A4M5clgFd+bie3DpYjeuMBdKhNWyITAoOEzaPEBTPYwFrsJIAeHDTh2K8+zyxcoxPZuWTJS6AOen6fjrnMlN8PxxyJ1RPUs0YwB/pOOn/jKUiGxv1UPXJmhTnTnwwJga8lpQNGbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmN3miib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0162C4CEF1;
	Sat, 13 Dec 2025 01:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765589445;
	bh=S5/Rqw8UA6ndvi7n7Q2Zrz8uh4Yjy2WjPREEyroEFBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PmN3miib2Suu6quo+1s8Bhfh1DkBkuVCE6PwZMUCmMHNrQr8LE1jXBoZGVefrPUIM
	 44nS0bF8F9cI4Be5/SB3s7ZPZE3AIMBpLQ26d8tCcvQ1eDCLPUT4KmL+KHeZPQnCKj
	 zchrzQ+bW7o+BvTp8IM/Yck4+doScSvT9zRS7HAP59yWoXLNn1ua0m9nzvLJUI1HP7
	 cPDIC5DzUF6wnUS2ndc7IOnFNU/lnzfbsNlPQHSoDExjCr6Gee1oLrl2wXvIigpD6E
	 OrY+99y62ose/KjFYS5CdYjwYwtxoNNnNVrQ2/RGrsohz2BTTvQ+rCIcABr0mUxJC0
	 6Rqz+68QA5agg==
Date: Fri, 12 Dec 2025 17:30:38 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 8/9] blk-crypto: optimize data unit alignment checking
Message-ID: <20251213013038.GF2696@quark>
References: <20251210152343.3666103-1-hch@lst.de>
 <20251210152343.3666103-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210152343.3666103-9-hch@lst.de>

On Wed, Dec 10, 2025 at 04:23:37PM +0100, Christoph Hellwig wrote:
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 6cea8fb3e968..829ee288065a 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -326,9 +326,16 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  	struct bio_vec bv, bvprv, *bvprvp = NULL;
>  	unsigned nsegs = 0, bytes = 0, gaps = 0;
>  	struct bvec_iter iter;
> +	unsigned len_align_mask = lim->dma_alignment;
> +
> +	if (bio_has_crypt_ctx(bio)) {
> +		struct bio_crypt_ctx *bc = bio->bi_crypt_context;
> +
> +		len_align_mask |= (bc->bc_key->crypto_cfg.data_unit_size - 1);
> +	}

Needs an #ifdef CONFIG_BLK_INLINE_ENCRYPTION, since ->bi_crypt_context
is conditional on it.

>  
>  	bio_for_each_bvec(bv, bio, iter) {
> -		if (bv.bv_offset & lim->dma_alignment)
> +		if (bv.bv_offset & len_align_mask)
>  			return -EINVAL;

As I mentioned on patch 3, I'm confused where the check of bv_len went
here.  Isn't it still needed?

I think this patch is also affected by the issue I mentioned on patch 7,
where the error handling at 'out_free_bounce_pages' is not correct.

The high-level approach seems okay, though.

- Eric

