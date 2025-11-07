Return-Path: <linux-fsdevel+bounces-67409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B5DC3E70B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 05:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D571188A5E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 04:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6FC25CC74;
	Fri,  7 Nov 2025 04:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eh147owS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A71E5205;
	Fri,  7 Nov 2025 04:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762489240; cv=none; b=ZvLZ/1e3I8D35/Fk5crgSTiN3ogAozQ8A8dJa5oiRYRsYvqefMtPYK/iF9JsTVA3oyHyTox85s5aqebWjeSDXa63cEMNPe9eewcvNE5heqr+62v6s5XUjQmWwuKEELYc5Yb18+rd6mm9OncOB7NIAigVo1eLCmw4ZFbRUo6z7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762489240; c=relaxed/simple;
	bh=ClMjTuO8m+qGYTF99gai8zRYpEMz8d+n7I8+JWoo4OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ph54sVuH2XxRHvAFm5ECc+cCdsUaGOhAXemypxldYzI6UuP8AJhJp9ntqFRs2ob7GFuH3dcUTTH0KoZIPWTvkW2xTV4n7dtAlEFVYxZJb+CrY+o5kjbuBumkpq6dhcEyBAeCoFBiPjNpBGMgtSMrvAYCllzOmuE93LzCURYc8Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eh147owS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7DEC116C6;
	Fri,  7 Nov 2025 04:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762489240;
	bh=ClMjTuO8m+qGYTF99gai8zRYpEMz8d+n7I8+JWoo4OU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eh147owSGuUYobLskWyhN6dPCJwsy93T7T3CqmwDglhaVzkdcBqwjvABAUi4GWT34
	 LCsdr2EwD4Hz7OGm5BhzvIzkY/Ztu8iGDgg1GBjXz7cmJ7IaRjYapmNF+XFYcHAjzg
	 fq3MQUhxWiCS36Grsaib78l/HmEuJ7TY/M/7/2s64RNQgaSE2FeTViriZjbhu/u2qv
	 vM/I3gY4UOisNIK1o41lVSOlaiYt7Fq8+C55qohB/n1mpm5ph5JNly2Hoain/OimHo
	 2Q82NczM3L5K1Uk2ENnChEfObr+zfOg3S7ib/MQmZOWyUInaPo2tp1Ocw6B1LDGvWh
	 OG+QBocATan6Q==
Date: Thu, 6 Nov 2025 20:18:59 -0800
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
Subject: Re: [PATCH 8/9] blk-crypto: use on-stack skciphers for fallback
 en/decryption
Message-ID: <20251107041859.GD47797@sol>
References: <20251031093517.1603379-1-hch@lst.de>
 <20251031093517.1603379-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031093517.1603379-9-hch@lst.de>

On Fri, Oct 31, 2025 at 10:34:38AM +0100, Christoph Hellwig wrote:
> Allocating a skcipher dynamically can deadlock or cause unexpected
> I/O failures when called from writeback context.  Sidestep the
> allocation by using on-stack skciphers, similar to what the non
> blk-crypto fscrypt already does.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

It might be worth leaving a note in the commit message that this also
drops the incomplete support for asynchronous algorithms.  ("Incomplete"
in the sense that they could be used, but only synchronously.)

Also note that with asynchronous algorithms no being longer supported,
the code can actually be simplified further because the
DECLARE_CRYPTO_WAIT(wait) objects are no longer necessary.  The sequence
of crypto_sync_skcipher calls that is used should be similar to what
fscrypt_crypt_data_unit() does.

That could be done in a separate patch if you want, though.

> +void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
> +{
> +	struct bio_crypt_ctx *bc = src_bio->bi_crypt_context;
> +	struct blk_crypto_keyslot *slot;
> +	blk_status_t status;
> +
> +	if (!blk_crypto_fallback_bio_valid(src_bio))
> +		return;
> +
> +	status = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
> +					bc->bc_key, &slot);
> +	if (status == BLK_STS_OK) {
> +		status = __blk_crypto_fallback_encrypt_bio(src_bio,
> +			blk_crypto_fallback_tfm(slot));
> +		blk_crypto_put_keyslot(slot);
> +	}
> +	if (status != BLK_STS_OK) {
> +		src_bio->bi_status = status;
> +		bio_endio(src_bio);
> +		return;
> +	}

Unnecessary return statement above.

>  /*
>   * The crypto API fallback's main decryption routine.
>   * Decrypts input bio in place, and calls bio_endio on the bio.
>   */
> -static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
> +static blk_status_t __blk_crypto_fallback_decrypt_bio(struct bio *bio,
> +		struct bio_crypt_ctx *bc, struct bvec_iter iter,
> +		struct crypto_sync_skcipher *tfm)

Comment above needs to be updated, since this function no longer calls
bio_endio().

- Eric

