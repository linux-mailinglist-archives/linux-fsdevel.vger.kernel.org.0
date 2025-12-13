Return-Path: <linux-fsdevel+bounces-71225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB77ECBA249
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 02:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A7E430AB47F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 01:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E471220698;
	Sat, 13 Dec 2025 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScSjBmoL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7F632;
	Sat, 13 Dec 2025 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765587660; cv=none; b=EjXQLXqePh/LRsB2lJ0joGH3cJruBn2cTHIsu17UoSXoW/l3Sk7uxEEK+78Nr1xjUe1FjAjrAq31twZtzwmwFKxfdbBYWsjL9muR1BuPhr+Z8kh/BqZGtz2NSmNiNAlkjkY32yCC46grvPll0GNNXr0Eg/KqZ9hFhA2B4za1rWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765587660; c=relaxed/simple;
	bh=tSfct7v5HRhXFGP/33m9419gRyJ4Q6NxhNaKQ084ODc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t22/GJZBWbaDgn78fEjsEGSIz4lyu9LzXPlSVIIoP6XF8EF4rG8t01QC7XZsx5oWc/DVLj1fo8G9WOb0K+It12ietV1CHS6o9fZqxcVHbrAXlFu0NL6wI74hmsbqkPj7TtxeqvAp4BM/LUZ8ajdgYfM5sJ54mCkZm73g8aJs3po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScSjBmoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7B0C4CEF1;
	Sat, 13 Dec 2025 01:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765587660;
	bh=tSfct7v5HRhXFGP/33m9419gRyJ4Q6NxhNaKQ084ODc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ScSjBmoLZf8jsQ5jizlzYJE8sLBU2ROvEoLcTVIIkpymGqfwSMP38H444ZsZaaD5v
	 lfUIuLqadmGZejrolYgoOO92Jp/xZWbXD5d2f8cdba5uunVFIlAZgT9FIsG5bedMDZ
	 Mojw/juXsCTWFQPpsb3BIupNoqLFgkcjqgjAdbv/3pL6SPYmm35jYkM1dxI80QF3+x
	 RNaIMC7EDWS/VCfi5SxVYxNmsAlmDSVv73UHfhY/XySIG3y4PwIhRI0GJ88f27imip
	 tj9/WdIzg8bHtwDjvr/KGKBrhnxMknA3WUbw41BiCe1Sp4pl76DSVRJTHAIbd/LkZe
	 mKXEZUhg1kCAw==
Date: Fri, 12 Dec 2025 17:00:58 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 6/9] blk-crypto: use on-stack skcipher requests for
 fallback en/decryption
Message-ID: <20251213010058.GD2696@quark>
References: <20251210152343.3666103-1-hch@lst.de>
 <20251210152343.3666103-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210152343.3666103-7-hch@lst.de>

On Wed, Dec 10, 2025 at 04:23:35PM +0100, Christoph Hellwig wrote:
> Allocating a skcipher request dynamically can deadlock or cause
> unexpected I/O failures when called from writeback context.  Avoid the
> allocation entirely by using on-stack skciphers, similar to what the
> non-blk-crypto fscrypt path already does.
> 
> This drops the incomplete support for asynchronous algorithms, which
> previously could be used, but only synchronously.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-crypto-fallback.c | 178 ++++++++++++++++--------------------
>  1 file changed, 79 insertions(+), 99 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

