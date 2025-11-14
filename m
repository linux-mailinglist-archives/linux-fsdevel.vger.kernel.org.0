Return-Path: <linux-fsdevel+bounces-68423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCE6C5B707
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 06:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D02033540C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 05:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744222D8793;
	Fri, 14 Nov 2025 05:57:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0712741C9;
	Fri, 14 Nov 2025 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763099851; cv=none; b=ZIrqp+y3tjybCEuXpkTJxWIf5eIhoN6U8h+laqA+jswKwWsRreawi94yuk+TdyyNxu8tL3c2i6vIJrW6SAfep62fq9TAWEYWJSA6+XgoL5E6vEoMHSnefkGn/z4tdPnS3JZY3aGR5WGnPm9P4RtX+VT8B52h4dFc8/EcSJeiyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763099851; c=relaxed/simple;
	bh=9nxDSYC8NPRikGBpa3yjzlBqsOjwoK4nYnXo8yu8GGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVocMfxzNkOTKqtOkeUywdiBDH9Mzbphpfqay1lN+MTPXXXcyjYn13KrwZxAR5vwiFWyfvr4t2f9PT1hxIaA5eygRptdRCj5PCm4QR67AkjVV9KXr4M3Atcw5ByCib2vjaWN0j4Il+RcjsMF3EBeIDZTsqcZT54i39yDFjtIEGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DD2B227A88; Fri, 14 Nov 2025 06:57:25 +0100 (CET)
Date: Fri, 14 Nov 2025 06:57:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 8/9] blk-crypto: use on-stack skciphers for fallback
 en/decryption
Message-ID: <20251114055725.GC27241@lst.de>
References: <20251031093517.1603379-1-hch@lst.de> <20251031093517.1603379-9-hch@lst.de> <20251114003200.GB30712@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114003200.GB30712@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 13, 2025 at 04:32:00PM -0800, Eric Biggers wrote:
> >   */
> > -void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
> 
> The above comment needs to be updated too.  Maybe leave the static
> function __blk_crypto_fallback_encrypt_bio() uncommented, and write an
> updated comment for the global function
> blk_crypto_fallback_encrypt_bio().  Maybe something like this:

Make sense.

> > +	struct bio *bio = f_ctx->bio;
> > +	struct bio_crypt_ctx *bc = &f_ctx->crypt_ctx;
> > +	struct blk_crypto_keyslot *slot;
> > +	blk_status_t status;
> > +
> > +	status = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
> > +					bc->bc_key, &slot);
> > +	if (status == BLK_STS_OK) {
> > +		status = __blk_crypto_fallback_decrypt_bio(f_ctx->bio,
> > +				&f_ctx->crypt_ctx, f_ctx->crypt_iter,
> > +				blk_crypto_fallback_tfm(slot));
> > +		blk_crypto_put_keyslot(slot);
> > +	}
> 
> This is referencing f_ctx->bio and f_ctx->crypt_ctx when they were
> already loaded into local variables.  Either the local variables should
> be used, or they should be removed and the fields always used.

Yeah, I actually noticed that myself after sending out the series.


