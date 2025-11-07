Return-Path: <linux-fsdevel+bounces-67411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18632C3E786
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 05:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD453AC79B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 04:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903B529B200;
	Fri,  7 Nov 2025 04:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiIRMAXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC4228C874;
	Fri,  7 Nov 2025 04:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762490635; cv=none; b=Bl81zyZ2kVmXhvn6VaajVI+/7oeTe7+DecpQJsH8g4rT2T3SJ78pPyVd/QBUpIl1vUNOe9INNCWSyaBFqqZZ6tpYIO7uHwWPkOKCa+r2kIofA7NgnBvX4DRsdQO+WSLv4hsejCDc1oratoxVC+qdgZVgL0vjpIgTUnoiE/GSzUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762490635; c=relaxed/simple;
	bh=48FJJQWCuZyY3WICX2hMykSPN/WEL8zhwGPI/xLv9B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+tJJqxzivGdUU5nEQxa5UEE6vwLlXNfnO4qVqUyg4LsWD729p9a0CzPM35i3fJrbSXeZT8phqEEuulExrKy49JLLlZoIyfHgCESxgsGvCPUJARMbg1QXGu1By2CQ5Sn2FUH7GiXJ3l5UU8s0aA+uoOc+gmWG9rsMhOJY8MiNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiIRMAXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F145C4CEF5;
	Fri,  7 Nov 2025 04:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762490634;
	bh=48FJJQWCuZyY3WICX2hMykSPN/WEL8zhwGPI/xLv9B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fiIRMAXAvqw6pJKQ2vhbLQ4u1cx2Pn2MW+mXefXZoqHYT60ATo9zx1lwht6WzqWey
	 a6ElQq4pQmDSvrK8l7DHBcSmgGuUbsvhBaOM8TYqXnXhmuGg3oiPIzFBW9YQ2MnMMK
	 1KMoXNSjjJEoiHo92g2ZjFejMm/2E4GLOJnC5106DNdIpjjZgB9+p0HNs3gLdIPNCV
	 /Ry6f6QtwCbsyYCA9p97Z6DMtBR3qlzplgyFZa9NOV40yRtbEWCk/2AmvHLMhWPXfW
	 ciLTSJtvevAq8S0gqy2Z+HUWfFIveOemVYTUr08UNMCucCtt2y0rn735qRb+z9mm1E
	 y6VE0ioo4c3rw==
Date: Thu, 6 Nov 2025 20:42:13 -0800
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
Subject: Re: [PATCH 7/9] blk-crypto: handle the fallback above the block layer
Message-ID: <20251107044213.GE47797@sol>
References: <20251031093517.1603379-1-hch@lst.de>
 <20251031093517.1603379-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031093517.1603379-8-hch@lst.de>

On Fri, Oct 31, 2025 at 10:34:37AM +0100, Christoph Hellwig wrote:
> diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
> index 58b0c5254a67..ffe815c09696 100644
> --- a/include/linux/blk-crypto.h
> +++ b/include/linux/blk-crypto.h
> @@ -171,6 +171,22 @@ static inline bool bio_has_crypt_ctx(struct bio *bio)
>  
>  #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
>  
> +bool __blk_crypto_submit_bio(struct bio *bio);
> +
> +/**
> + * blk_crypto_submit_bio - Submit a bio using inline encryption
> + * @bio: bio to submit
> + *
> + * If the bio crypt context attached to @bio is supported by the underlying
> + * device's inline encryption hardware, just submit @bio.  Otherwise, try to
> + * perform en/decryption for this bio by falling back to the kernel crypto API.
> + */
> +static inline void blk_crypto_submit_bio(struct bio *bio)
> +{
> +	if (!bio_has_crypt_ctx(bio) || __blk_crypto_submit_bio(bio))
> +		submit_bio(bio);
> +}

So, the new model is that if you have a bio that might have a
bio_crypt_ctx, you always have to use blk_crypto_submit_bio() instead of
submit_bio()?

It looks like usually yes, but not always, because submit_bio() still
works with hardware inline encryption.  However, it also skips the
bio_crypt_check_alignment() check that was done before; now it happens
only in __blk_crypto_submit_bio().  So that creates an ambiguity about
whether that usage is allowed (if, hypothetically, a caller doesn't need
blk-crypto-fallback support).

Maybe the alignment check should be done both in submit_bio_noacct()
after verifying blk_crypto_config_supported_natively(), and in
__blk_crypto_submit_bio() after deciding to use the fallback?  Those
cases are exclusive, so the check would still happen just once per bio.

Either way, the kerneldoc needs to be improved to accurately document
what blk_crypto_submit_bio() does, when it should be called, and how it
differs from submit_bio().  This also deserves a mention in the "API
presented to users of the block layer" section of
Documentation/block/inline-encryption.rst.

(I'll take a closer look at this patch later.  It will take a bit more
time to go through the blk-crypto-fallback implementation.)

- Eric

