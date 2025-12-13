Return-Path: <linux-fsdevel+bounces-71229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4222CBA2B9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 02:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A77B2300EDFF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 01:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E1B214204;
	Sat, 13 Dec 2025 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT5GVKv2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264E155326;
	Sat, 13 Dec 2025 01:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765590408; cv=none; b=hKBDEHjlNXlJicTv5GNlG1ULHp6Vj1Xq0JdcM2OQSvACxwX0SOG0KsogP6CkH6bz6ZlsyOFkH7sKPsbI52pXLc5o8Qd0K2MmS4CA018JYVE6t1zR/uVKKA8AU7+SGVa2o7BllVps4h0VnuNmjISqNFYaCf10fQqOucZrNIN9xv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765590408; c=relaxed/simple;
	bh=cq2jqSwHOBkBnsupwq+q/lJGv1DhYNFx9N3b6Y8YSYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i52D+AZn4y/irzZmcpJb+7rWw80iPiVgyYdHwLvRYDUJQj3Y3R/oDjRcBaADtG/BR+foOwgXgRA96Pm7InDjUa4gYONn5YXM7O09MCJepETwrmUtelEy3Zr5vKqrLiWPiL2Pt5W+U8Sbv00oU5UsiB/ROMKRcTxUXgU2OIbLqCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT5GVKv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA5CC4CEF1;
	Sat, 13 Dec 2025 01:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765590405;
	bh=cq2jqSwHOBkBnsupwq+q/lJGv1DhYNFx9N3b6Y8YSYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WT5GVKv2eu9cpbUOIG88QiVPHd/5qdm6Z/7CR34kiiXqWxvPqRbfBB7kTcyoZngL+
	 /d8jCURIlbnqgcuvyTaReLnABncTaLiqQj1xmChtInpnevlxtRSfBussKWDGKn/kiM
	 XoxqV5WcRNYnoCFp0IRV80G6FydaRMSOOD0FEtDsL5/wjtUnViUBjB4gSnS8XQpoJ9
	 AqJ7RAwZrBp86XcsZjxBs1EpSn6dyfeeLEaB8MV/W/1VUau6XOVx58cTG49674HFwX
	 q4carvZxqKa86XcNr4dXOuF73FjCvepB3Db4zq8RukT7MbiyH6CGl95cDAJeAPeZpr
	 DFf7DGzrPdrVw==
Date: Fri, 12 Dec 2025 17:46:43 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 9/9] blk-crypto: handle the fallback above the block layer
Message-ID: <20251213014643.GG2696@quark>
References: <20251210152343.3666103-1-hch@lst.de>
 <20251210152343.3666103-10-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210152343.3666103-10-hch@lst.de>

On Wed, Dec 10, 2025 at 04:23:38PM +0100, Christoph Hellwig wrote:
> +To submit a bio that uses inline encryption, users must call
> +``blk_crypto_submit_bio()`` instead of the usual ``submit_bio()``.  This will
> +submit the bio to the underlying driver if it supports inline crypto, or else
> +call the blk-crypto fallback routines before submitting normal bios to the
> +underlying drivers.

Maybe worth mentioning that submit_bio() still works if
blk-crypto-fallback support isn't needed?  I think device-mapper relies
on that when using targets with DM_TARGET_PASSES_CRYPTO on block devices
with hardware inline encryption support.  The original submitter uses
blk_crypto_submit_bio(), but the device-mapper layer doesn't, which is
okay because the fallback (if needed) would have been done already.

> +/**
> + * blk_crypto_submit_bio - Submit a bio using inline encryption

"bio using inline encryption" => "bio that may have a crypto context"
(or "bio that may be using inline encryption")

> + * @bio: bio to submit
> + *
> + * If @bio has not crypto context, or the crypt context attached to @bio is

not => no

Besides these documentation issues it looks okay though.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

