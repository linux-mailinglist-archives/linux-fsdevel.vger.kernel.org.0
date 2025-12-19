Return-Path: <linux-fsdevel+bounces-71777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E9ACD1B98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 21:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 844E13008D76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 20:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781D333B6F8;
	Fri, 19 Dec 2025 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9F4/Izf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2AF2DC32B;
	Fri, 19 Dec 2025 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766175255; cv=none; b=nCT+auGt8m8abdyRN3kSc7c4/JUevr/O38YoO6Law9Eplc08HEWakj3SOwJSYZ6YoKIOg0ItQo9Z0H3OBpvz/QU/ZJcgjN0qh0/OXN6UPH0ewim2nSfrqDTBmT5IgVxtMteuIoSMgRSv2NpaMgdTxAKEgL4HiXC6VFbjYm4XiBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766175255; c=relaxed/simple;
	bh=2XNp4bBQVdph63eEQfbiLCM/5TcTVyB5CVc9jM1BF1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLHR6djU0v4efJAJg7rrXDvRQIutm5fSU+Qv5+RHxkF44Tri8D/9cKVEIxpU/SCwj/R0tnQz9vKEh0bmSS6qUhwaqjj/p42fyWmsffSyRl5vvZyhNo67W72XMu65Zt33RqzqjtXuTtFuaXoy50iFpJeB9AP53kA+TS4JwYX2eNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9F4/Izf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B30CC4CEF1;
	Fri, 19 Dec 2025 20:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766175255;
	bh=2XNp4bBQVdph63eEQfbiLCM/5TcTVyB5CVc9jM1BF1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9F4/IzfNWwSIphfl8RtpCHKShrwg6f10KTyTgbbI77zdsqgGOjDF6Jq4xmHb8Mgs
	 WNJaoTYP1B6mfhbSL7HVr+AtDbV7xGjj4G6ijgMVFL1nx58xMet2SUiur/oxm0UEay
	 HiZOJ4qund/zgXGMbEOjIy1hAqk+P9wBDQpWUlKU3F2A89lk2rIOt1LwGldzm6Es8F
	 q8CsT/MazhPTvUw8O8pu2pmv6LrsWadAN+sI2kI444hBm+jtRoOotptaLe9B+1jhf3
	 IUGmKj0c9OGQCrwDbY2SWKHjhbUgxH8zLxRRy6kJoyaiTcicGp4annXNvNCNegeJ4u
	 Th5DexKOSlAbg==
Date: Fri, 19 Dec 2025 12:14:06 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 8/9] blk-crypto: optimize data unit alignment checking
Message-ID: <20251219201406.GG1602@sol>
References: <20251217060740.923397-1-hch@lst.de>
 <20251217060740.923397-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217060740.923397-9-hch@lst.de>

On Wed, Dec 17, 2025 at 07:06:51AM +0100, Christoph Hellwig wrote:
> Avoid the relatively high overhead of constructing and walking per-page
> segment bio_vecs for data unit alignment checking by merging the checks
> into existing loops.
> 
> For hardware support crypto, perform the check in bio_split_io_at, which
> already contains a similar alignment check applied for all I/O.  This
> means bio-based drivers that do not call bio_split_to_limits, should they
> ever grow blk-crypto support, need to implement the check themselves,
> just like all other queue limits checks.
> 
> For blk-crypto-fallback do it in the encryption/decryption loops.  This
> means alignment errors for decryption will only be detected after I/O
> has completed, but that seems like a worthwhile trade off.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-crypto-fallback.c | 14 ++++++++++++--
>  block/blk-crypto.c          | 22 ----------------------
>  block/blk-merge.c           |  9 ++++++++-
>  3 files changed, 20 insertions(+), 25 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

