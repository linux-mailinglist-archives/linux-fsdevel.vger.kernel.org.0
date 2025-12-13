Return-Path: <linux-fsdevel+bounces-71224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B56A7CBA23C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 01:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AB28308182F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 00:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3424D239E9E;
	Sat, 13 Dec 2025 00:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixgUNaM9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6B220698;
	Sat, 13 Dec 2025 00:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765587393; cv=none; b=pfygTuvzDRvncejL90yao+jC+e5ro1Se0nrspyxPIovfjMQT/Kmeso4X73P+LjhVZPgItoK7nn7dsTQjSKowNgh2ZbeUWWCeC9zgx1jhF1fcJhRh9RNvNdEQBGgxtIVC+ZgTDhURbRGETeAy6zL2mDUi5ukgFOSWEiZ13woP7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765587393; c=relaxed/simple;
	bh=/rqtj5tpxhIi7wwiCNSaT39ERDdQDH6+oeUBUGnTgfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU62/SOwr2t8ffAaxwMCPYWopYk+C5Vh4DAGmKss1iVuELFamHhOlbsvlqMVZQ9Ft8rRPlCSphOR/r+ROq4qu/4NpmIHqjJI8B0ps/Fx1LkicQSrQHV3RAyFEhhnd2dPX6yAf5lrxQoBrzRc2HfsodsOAsdDOAHD+NeXAw6+qps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixgUNaM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC112C4CEF1;
	Sat, 13 Dec 2025 00:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765587393;
	bh=/rqtj5tpxhIi7wwiCNSaT39ERDdQDH6+oeUBUGnTgfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixgUNaM9Tf3YS5ZukH9+eXkJMn4TWiPIlZl5l9imzDKnwGYpouWxadzEchEo16vdI
	 Daehdk/lHbIj/4RwqlgCTMM1o3Tkc2sBSOGew8w1Fj+fKPI76kWKyYTKXDj6hdHfqf
	 Th3fIf8lHOI1Bv26xpicWiOhr9/zqBekUGIubL5JSn/6Ix71llhJZKiAl7yyKnHg3r
	 ep4Q+FfwLyiAD5DMGz1LxvvEI2AUYzDPKAzdDnfEq6Sx7gFxrZYweza+TUJMw0GsP4
	 D8dDruy7XKCB6uxIiP6H6TR6wSEs1vPUuQ0g7oJltBeAJIBxVBj+JT0aV7Pf4u4Ij9
	 oHn7TV0CACgww==
Date: Fri, 12 Dec 2025 16:56:31 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 5/9] blk-crypto: optimize bio splitting in
 blk_crypto_fallback_encrypt_bio
Message-ID: <20251213005631.GC2696@quark>
References: <20251210152343.3666103-1-hch@lst.de>
 <20251210152343.3666103-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210152343.3666103-6-hch@lst.de>

On Wed, Dec 10, 2025 at 04:23:34PM +0100, Christoph Hellwig wrote:
> The current code in blk_crypto_fallback_encrypt_bio is inefficient and
> prone to deadlocks under memory pressure: It first walks the passed in
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
>  block/blk-crypto-fallback.c | 164 +++++++++++++++---------------------
>  1 file changed, 66 insertions(+), 98 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

