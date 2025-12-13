Return-Path: <linux-fsdevel+bounces-71223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CEFCBA20D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 01:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF48430028BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 00:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199262253EF;
	Sat, 13 Dec 2025 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy13q5bU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7BA1DF748;
	Sat, 13 Dec 2025 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765586916; cv=none; b=f6ckyPcS3Tfj9rVFDovCarq7dSyvZ+cY2g4+sALGTcm1bV915ZZEN2m+WIMPtUDSo0yXLeprMFOMHgwCaKe2+ivI+cLDuqeEbMeF6S40yZHQTQKaarJFT+ddA1tK+Wrj/4DFSvd78zPyJo1+aFy1CHeVHirxB/z6atg8jjl1Pqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765586916; c=relaxed/simple;
	bh=NzqfbLwI1xuhyHsO+gYxVrYLQ/J2wmY7uKQ3JIg23kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHAxYxWxncUoHxR0fRHEUR8Xz09P8C57mdohGTDMxJHKLxn81hD5TEtJhvJWmSe0A7OZ0pQVTqbCsMBGgkyke+0NX0f4CBtK6uMYy0kBkExfYb7HeON9m3yYopqpZ6gALIZQtWi/EbI/okDLQQQo9aCdvbl67H9Fs3SwW3xgIvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy13q5bU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99493C4CEF1;
	Sat, 13 Dec 2025 00:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765586915;
	bh=NzqfbLwI1xuhyHsO+gYxVrYLQ/J2wmY7uKQ3JIg23kI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iy13q5bUkuFm1oUwv1yYA490Otwa/XIeZJVDBtr2c91aLuLmkgzuA2VXl8qwjNeQQ
	 c+imNgFxmh0ygG3uUMC+7IQhBTA1JsCad46345R4dOMFNsglZtaeRhiGlk03kaSjwb
	 5QC8u5wkU1WqI9P38Sye0ZYsPBV8cyuLRY/ht9RraQbg6ZWv4JYFAvHC7yKnKzPmff
	 3QRhEsk32r/B5z/d7IDHYmy9+oti2t1cUUSDz/qt4MOFGD11j9U9Q9nXAFU0HjhThF
	 SubFvhiT3C9+6cmdbtp0Icz8zqhAUZuTqRqjWibsWCo0QAz5C/z5HhdAgjLaj15QB9
	 nkJifKstoek9w==
Date: Fri, 12 Dec 2025 16:48:33 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 4/9] blk-crypto: submit the encrypted bio in
 blk_crypto_fallback_bio_prep
Message-ID: <20251213004833.GB2696@quark>
References: <20251210152343.3666103-1-hch@lst.de>
 <20251210152343.3666103-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210152343.3666103-5-hch@lst.de>

On Wed, Dec 10, 2025 at 04:23:33PM +0100, Christoph Hellwig wrote:
> @@ -502,8 +495,10 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
> 	if (!__blk_crypto_cfg_supported(blk_crypto_fallback_profile,
> 					&bc->bc_key->crypto_cfg)) {
> 		bio->bi_status = BLK_STS_NOTSUPP;
> 		return false;
> 	}

The above is missing a call to bio_endio().

> + * In either case, this function will make the submitted bio look like a regular
> + * bio (i.e. as if no encryption context was ever specified) for the purposes of
> + * the rest of the stack except for blk-integrity (blk-integrity and blk-crypto
> + * are not currently supported together).

Maybe "submitted bio" => "submitted bio(s)", considering that there can
be multiple.  Or put this information in the preceding paragraphs that
describe the WRITE and READ cases.

Otherwise this patch looks good.  I'm not 100% sure the split case still
works correctly, but it's not really important because the next patch in
the series rewrites it anyway.

- Eric

