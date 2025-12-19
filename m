Return-Path: <linux-fsdevel+bounces-71772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20819CD1AF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 20:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D344C30919B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 19:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450C534AB03;
	Fri, 19 Dec 2025 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvg/Uj0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940282DA771;
	Fri, 19 Dec 2025 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766173810; cv=none; b=fm/o4CUkp5ps+h6NbQ4zTkClGtxuvq74daFMdn491T6IR2VdowzxJiEbzVCHi4Gbq+io0XkGmIEhC9ZiPDGSJGAG0PYsL7Bk2O0vwC8bMlws3MqLUIZkPcBoV2fqTzQfuzmP0nIRXqtBWwoaFVuMo40pj5PM6DoZ5i+wko1afEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766173810; c=relaxed/simple;
	bh=p/Lj5R/ekJsBxTPangkKoOHbleRdeB3QGPOR8xCJBXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhiR81snmo24FjWt1OqVoWNY8MZLpQi9iivR5C63qv1uQT09tsbMI0zwTjBV/LQazTq6iE3rFFjsZ8SZdX4rB3ytwWybNVnsL+StXhsZlUFAOx1k4XNulAeDP/n8Ora9NZBukvwwrayCqM1MtgNPwhHgZNsxR8Wq+65ddyZp+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvg/Uj0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFB6C4CEF1;
	Fri, 19 Dec 2025 19:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766173810;
	bh=p/Lj5R/ekJsBxTPangkKoOHbleRdeB3QGPOR8xCJBXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yvg/Uj0L8jfUrelm88orw7y/l/z/UsQ0x/go2XTknOJqTG2Qa1vLNbv5ngPUtYE8H
	 uwfLkx1jLSRAiAkDLsYqi3NuFMCuWkUkS8n5eQ69nTKRHfeqdL2KEAxqj91j2hrtQa
	 jOT9bKb//S1tjo8zsIPvbOv08wKVDhx7IV9vCJdfHakepw2V1nyNj/Rev8svGou6aC
	 OM87/0bbWnixb+eYLlx6vOxDeMEe9WYerfOTG7mSub9hR81r6p6NYr4y/cve8uxmV6
	 eDdcyGLmGYnECDm1surYu7KvOsuQbgL2kB76TuvwPOi32VBqlhCEGOwBu9hvfxgITc
	 j/2zbX/zh2DRw==
Date: Fri, 19 Dec 2025 11:50:00 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 3/9] blk-crypto: add a bio_crypt_ctx() helper
Message-ID: <20251219195000.GC1602@sol>
References: <20251217060740.923397-1-hch@lst.de>
 <20251217060740.923397-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217060740.923397-4-hch@lst.de>

On Wed, Dec 17, 2025 at 07:06:46AM +0100, Christoph Hellwig wrote:
> This returns the bio_crypt_ctx if CONFIG_BLK_INLINE_ENCRYPTION is enabled
> and a crypto context is attached to the bio, else NULL.
> 
> The use case is to allow safely dereferencing the context in common code
> without needed #ifdef CONFIG_BLK_INLINE_ENCRYPTION.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/blk-crypto.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

