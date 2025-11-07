Return-Path: <linux-fsdevel+bounces-67430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFCDC3FDAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 13:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 688B04E5BBD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 12:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33060327215;
	Fri,  7 Nov 2025 12:10:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72993271E0;
	Fri,  7 Nov 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517434; cv=none; b=q+s3LNHmgSlkrHwn/lTzHdLIsgNjHvVtz/3GIJz8Fge/Cp+oKkbXW6+hkKc6yvY/nl5cXwmAkS0Y2yVoetx+Nx14bbPUtj9yz3hyv0/Z39ObWrxh+Ke47v31sXvdGyFuI5nmUx1y/yqCT+eyP+TEFTa8AfhBNg96Ih80RnANuio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517434; c=relaxed/simple;
	bh=cNNTx2hw6L/xlWugAEbpQp7Ivb/Peq01s5cFF4sMjSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RE/OzXVhu9kFKVige0ZmhmbxJAVckmu1Ry8D9yDTWpVY62GANTggXB3D0hfEu5aDXvTnqyP4d2IuBao0Ngc6bh4nr12b1QjXXWc5fFuKM3XsOmUMySrul4z2A5PCKc7GnsrIST1cRqHOoFs+IviGuHlW8t51Bd5riLaSfo4Kkuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A1F41227AAE; Fri,  7 Nov 2025 13:10:27 +0100 (CET)
Date: Fri, 7 Nov 2025 13:10:27 +0100
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
Subject: Re: [PATCH 7/9] blk-crypto: handle the fallback above the block
 layer
Message-ID: <20251107121027.GE30551@lst.de>
References: <20251031093517.1603379-1-hch@lst.de> <20251031093517.1603379-8-hch@lst.de> <20251107044213.GE47797@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107044213.GE47797@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 08:42:13PM -0800, Eric Biggers wrote:
> So, the new model is that if you have a bio that might have a
> bio_crypt_ctx, you always have to use blk_crypto_submit_bio() instead of
> submit_bio()?

In general yes.

> 
> It looks like usually yes, but not always, because submit_bio() still
> works with hardware inline encryption.

It has to, as that is the interface into the block layer that is used
by blk_crypto_submit_bio.  But the intent is that all submissions go
through blk_crypto_submit_bio first.

> However, it also skips the
> bio_crypt_check_alignment() check that was done before; now it happens
> only in __blk_crypto_submit_bio().  So that creates an ambiguity about
> whether that usage is allowed (if, hypothetically, a caller doesn't need
> blk-crypto-fallback support).
> 
> Maybe the alignment check should be done both in submit_bio_noacct()
> after verifying blk_crypto_config_supported_natively(), and in
> __blk_crypto_submit_bio() after deciding to use the fallback?  Those
> cases are exclusive, so the check would still happen just once per bio.

We could do that.  Or I lift the checking into the core bio splitting
code at least for the hardware case to reduce the overhead.  I'll see
what works out better.

> Either way, the kerneldoc needs to be improved to accurately document
> what blk_crypto_submit_bio() does, when it should be called, and how it
> differs from submit_bio().  This also deserves a mention in the "API
> presented to users of the block layer" section of
> Documentation/block/inline-encryption.rst.

Ok.


