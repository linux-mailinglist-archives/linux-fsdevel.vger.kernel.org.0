Return-Path: <linux-fsdevel+bounces-68411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10EC5AC76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 01:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2DAAF34278C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 00:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB1621E097;
	Fri, 14 Nov 2025 00:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP0qAHiU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C74A02;
	Fri, 14 Nov 2025 00:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080324; cv=none; b=ok2+ENj+HJnJ/TW5ogqF4iS+3PQr5h/gA8YJ0frQ6qUELw1YhoHSvMmHsAUblYoqO61EiTiBW4yZ7aWyVahvjRphR7c1RfjPI4oVp1xWRtj4BDYOAt9r302TzxGjsKK09l7QpksVuf4gew8i/aTA58BFfAXnAmxnbTGDQCPgrSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080324; c=relaxed/simple;
	bh=vemPluv3EUqZUNat690foFoJUo/d3oWc4vaEnI0MUEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2llhORy5ZnMzGCcOBFZHTaYQ8UUwEFIT9w9R48Z6rB1vOxg3ar8ThJ38+C1CVBz2PftVXXgEU6H3VApRYM1RcIDzxpG7p/PxqO6BwFAUxGbinU0AW/wGmkYDbwtbTkZWXwrePsSOlhPt1zcollgZO+IGiU3QoW+Vw6eZ7O09uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP0qAHiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B98AC113D0;
	Fri, 14 Nov 2025 00:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763080324;
	bh=vemPluv3EUqZUNat690foFoJUo/d3oWc4vaEnI0MUEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KP0qAHiUTfvg82EUnli/odRGIciIEcjFYmZUzQexNdVA/5gAIohyW6j/AzMB9zrmj
	 117jmLDggBYNn8zEE+BaK4vo6rs6OyAjzjHJHBZx/IAVkZFY5MYkSvGEu+hLvpohsw
	 gwPcLNnhPyctAy2m3vNOhAcnvEjeRPsJQ7vDTk8epfrFeDrnYezTvbJfZgEBRHLMjk
	 N5JgyKdrArKKBx5924sGy4qw5H4xQ6d/h8G/kKEWFXp2ZCHBhJ4A5iyY5BQR6EzLHE
	 Lj3ey+F+QJARs5elpbplC/IXhGXjzcEO955WmprLLox+kOZfAcu8XcOQ2Vu5wBzNjO
	 bFkaxs/VDo7iA==
Date: Thu, 13 Nov 2025 16:32:00 -0800
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
Message-ID: <20251114003200.GB30712@quark>
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

skcipher => skcipher request

> @@ -238,12 +223,12 @@ static void blk_crypto_dun_to_iv(const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
>   * encryption, encrypts the input bio using crypto API and submits the bounce
>   * bio.
>   */
> -void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)

The above comment needs to be updated too.  Maybe leave the static
function __blk_crypto_fallback_encrypt_bio() uncommented, and write an
updated comment for the global function
blk_crypto_fallback_encrypt_bio().  Maybe something like this:

/*
 * blk-crypto-fallback's encryption routine.  Encrypts the source bio's data
 * into a sequence of bounce bios (usually 1, but there can be multiple if there
 * are more than BIO_MAX_VECS pages).  Submits the bounce bios, then completes
 * the source bio once all the bounce bios are done.  This takes ownership of
 * the source bio, i.e. the caller mustn't continue with submission.
 */

But really that ought to go in the previous commit, not this one.

> +static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
> +{
> +	struct bio_fallback_crypt_ctx *f_ctx =
> +		container_of(work, struct bio_fallback_crypt_ctx, work);
> +	struct bio *bio = f_ctx->bio;
> +	struct bio_crypt_ctx *bc = &f_ctx->crypt_ctx;
> +	struct blk_crypto_keyslot *slot;
> +	blk_status_t status;
> +
> +	status = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
> +					bc->bc_key, &slot);
> +	if (status == BLK_STS_OK) {
> +		status = __blk_crypto_fallback_decrypt_bio(f_ctx->bio,
> +				&f_ctx->crypt_ctx, f_ctx->crypt_iter,
> +				blk_crypto_fallback_tfm(slot));
> +		blk_crypto_put_keyslot(slot);
> +	}

This is referencing f_ctx->bio and f_ctx->crypt_ctx when they were
already loaded into local variables.  Either the local variables should
be used, or they should be removed and the fields always used.

- Eric

