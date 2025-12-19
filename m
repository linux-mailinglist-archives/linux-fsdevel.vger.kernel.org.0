Return-Path: <linux-fsdevel+bounces-71775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77269CD1B6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 21:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44F973062E73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 20:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223C433A6FC;
	Fri, 19 Dec 2025 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXDgBPio"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7555D1E5B60;
	Fri, 19 Dec 2025 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766174928; cv=none; b=GDmFZ8DvQ/1I4L1g29wIvYM6mTJb94/yfC0Oq8Uf/6DnAtn2nwG6UaFRD093eSbcZauVsyfRIv6IiIj8u5kCeWow7uP7rc9dTPC0VQV2ZsgFg/YwzuueB1zoZrO2TZrukQtE8giH+5tBei7c/4HFeK2SaI8NIYzmdXzf2sN3Xnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766174928; c=relaxed/simple;
	bh=UjzynyCjJ/VSj0BmSwxBShSTJWm5qXf0tbN7JAJC3Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSTvBMsL4ZnMo37YUH+fE4+SDb3p0VevO7KktUfnaahVlmJCC1ZnU0Dwwlzjerx4iC0NZsDGSk1KbbESDDLrKuQbxmB3rwZUgeLd+KIXDdlVKAKHVLptJHv6KgkFHiUFvbaRFqHmy3gxy7LFjMoP4t9X76VpkM0DFHpmw5MoWDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXDgBPio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B9CC4CEF1;
	Fri, 19 Dec 2025 20:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766174927;
	bh=UjzynyCjJ/VSj0BmSwxBShSTJWm5qXf0tbN7JAJC3Go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXDgBPiodVg/xLJxTOdN3pyDDOa5fw0oS54keyNCWVX7U1TKZikuedg6TBom01bFs
	 t87/Tgcc58KSOleqNq/NUxO+UJB5DhTteqJ6OWWgHdi0d71ag/XYCVXN0S1ixRSyt6
	 LrenK/EZtXpWOtPAqAsKxvvS7uh5uL0P1TM/nVMltLENEdJ3dC612inrsafYgGloDg
	 3R3xR3KNCPK8rMQhUw40ukbD+rXreZ6wewtLIaiWQGGgMtfvlTMiNdylqaBkCxecpA
	 Tz6R1XNFt3sCFtkE5busp/XV1+RsWPfV0/fCnzkGekipknvzqdbl5RqwvBK6Ci+ylu
	 TR64N+FfIOK6g==
Date: Fri, 19 Dec 2025 12:08:37 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 5/9] blk-crypto: optimize bio splitting in
 blk_crypto_fallback_encrypt_bio
Message-ID: <20251219200837.GF1602@sol>
References: <20251217060740.923397-1-hch@lst.de>
 <20251217060740.923397-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217060740.923397-6-hch@lst.de>

On Wed, Dec 17, 2025 at 07:06:48AM +0100, Christoph Hellwig wrote:
> +		if (++enc_idx == enc_bio->bi_max_vecs) {
> +			/*
> +			 * For each additional encrypted bio submitted,
> +			 * increment the source bio's remaining count.  Each
> +			 * encrypted bio's completion handler calls bio_endio on
> +			 * the source bio, so this keeps the source bio from
> +			 * completing until the last encrypted bio does.
> +			 */
> +			bio_inc_remaining(src_bio);
> +			submit_bio(enc_bio);
> +			goto new_bio;
> +		}

Actually I think using bi_max_vecs is broken.

This code assumes that bi_max_vecs matches the nr_segs that was passed
to bio_alloc_bioset().

That assumption is incorrect, though.  If nr_segs > 0 && nr_segs <
BIO_INLINE_VECS, bio_alloc_bioset() sets bi_max_vecs to BIO_INLINE_VECS.
BIO_INLINE_VECS is 4.

I think blk_crypto_alloc_enc_bio() will need to return a nr_enc_pages
value.  That value will need to be used above as well as at
out_free_enc_bio, instead of bi_max_vecs.

- Eric

