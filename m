Return-Path: <linux-fsdevel+bounces-71773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E50CD1AF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 20:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 273C930319BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 19:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DC834AAE4;
	Fri, 19 Dec 2025 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3ooTp5F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928221ABB1;
	Fri, 19 Dec 2025 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766173863; cv=none; b=fgDf/RZ7aEDRzQg4O+J8zLH8HH7BMHUjPL574QvV6z/LUk5q+3PSaOmmJvwVGN3V/Nths2ohHewpB/FSmkkOqxJtS17O3/MNL/tsuCjVjuCkZbWGBzppdJ3q/sjXm53OM7ccoMMPvIbwRSy+E+oo3/vv3V2BnTfMRBxkci40V+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766173863; c=relaxed/simple;
	bh=yNTZ9QeYhPItcZf5q2eeOukzCOf22H9woPODhRehdE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYE5n08gyKaiTzZIdFkAcAsxkaMomuA6/rcMSeEiHm2fIjBJNJ2+F4EmhD1/KCwhMMVZSz76N9o/0lJ3NFYbp23uoyu+PdNJ1X24pDsFInm0ZQwtnHNGbtULOzdtn4AGyy1quXi7VD1UMgSIVqNZ+i1rNTCypHawJo651Qa4oeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3ooTp5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1841C4CEF1;
	Fri, 19 Dec 2025 19:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766173863;
	bh=yNTZ9QeYhPItcZf5q2eeOukzCOf22H9woPODhRehdE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K3ooTp5FNVyOywQR/rFBnjYZpWiY5dVBUh+Q/4fRurCpNcWsphV98lEOoRMYCNPf7
	 iU6lpN51pYBicMqbogDRumcdIYKTQYA+qMMpV7ODFur/x5KnakXRWmV/rkhueKlJIM
	 KzlGPd4W8ePq8JkzRo5vzrf84vn44ZB++OVRtUMTvc1FlpZTg+0SAAUgSk2pLgRW1S
	 XzVOZP2o3SY4qxn3w2cDw9EwPB/Rm55jvVfKp+TtD4nx4t3gflJ90pdVtesOuiNbOf
	 5goetdJ6rmJaLV17k1qJIaUaVkvyo8GQRLrCj3Eb8cPPdanq52/aLyE/GWv51M+3Cx
	 IZMgprOWRdavQ==
Date: Fri, 19 Dec 2025 11:50:53 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 4/9] blk-crypto: submit the encrypted bio in
 blk_crypto_fallback_bio_prep
Message-ID: <20251219195053.GD1602@sol>
References: <20251217060740.923397-1-hch@lst.de>
 <20251217060740.923397-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217060740.923397-5-hch@lst.de>

On Wed, Dec 17, 2025 at 07:06:47AM +0100, Christoph Hellwig wrote:
> Restructure blk_crypto_fallback_bio_prep so that it always submits the
> encrypted bio instead of passing it back to the caller, which allows
> to simplify the calling conventions for blk_crypto_fallback_bio_prep and
> blk_crypto_bio_prep so that they never have to return a bio, and can
> use a true return value to indicate that the caller should submit the
> bio, and false that the blk-crypto code consumed it.
> 
> The submission is handled by the on-stack bio list in the current
> task_struct by the block layer and does not cause additional stack
> usage or major overhead.  It also prepares for the following optimization
> and fixes for the blk-crypto fallback write path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c            |  2 +-
>  block/blk-crypto-fallback.c | 70 +++++++++++++++++--------------------
>  block/blk-crypto-internal.h | 19 ++++------
>  block/blk-crypto.c          | 53 ++++++++++++++--------------
>  4 files changed, 67 insertions(+), 77 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

