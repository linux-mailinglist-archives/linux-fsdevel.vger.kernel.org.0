Return-Path: <linux-fsdevel+bounces-67056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCBBC33AFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 02:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 995E44EAD62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 01:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D472245014;
	Wed,  5 Nov 2025 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz/sN3G+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC823D7F3
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306814; cv=none; b=F6KS2h+vpxn/1/7kfB9h+hDECYv+QuspkTlVHb4IJeWaZ7WKczcGjvmxlxRqtoBKK4MDxNKN2Pnhvhi+r0bwYqTKqeBnNe9UFqcyzZaBhXyz4gfU0TYS0IAioJ1vJAa9P6qwqf5gFxF0HFVicRNuckduSljKAwgaZP0Ets3/FfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306814; c=relaxed/simple;
	bh=3GNiPVHAuz1E/hSuPsWoS0mBx+uzaFGf40qslctuffg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRtme1ZlCA6mfVSWkGN5hEkRdaabPZqdEZGNtonhxcM5d5Or2CDvC2ntaIupdNbIbHLIXwlBbnqQsbH3Rt04tbSXWJgwvhX1uNQ6JDPc47RrDAR8Bg2JIF5wQEy+H9MiF1l5xTW/KlpMWFS+gl+U4sYi0tOWK6JyBTSBEr1bR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz/sN3G+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6170C116D0;
	Wed,  5 Nov 2025 01:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762306811;
	bh=3GNiPVHAuz1E/hSuPsWoS0mBx+uzaFGf40qslctuffg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pz/sN3G+qPvkC8L2HzAE3g4sd8NtYmyxC/aNfcGHhNaNIaA9ibVYx0nW86xCZ5ZU2
	 mhP1MBhcg/XBq3A6giP5YaEdrSu0cDXHqq+347IGTpY40aZVH4vUy8PCiOHfOYC1lg
	 /1fT8knaLH1QV1jZtnxfYl9o5ocW6xYB7/AmvouzlfKBHzJdMspMGTjWN0h+RtI+4k
	 zK1EXoY2K0vImwESSO++ovZQLXP8R4GUgYKTgFOgBS+pptARzmIaYVEbEIq2ajQoiM
	 MNpGFelW20EPyze9Me1iIm3S5jKfHHMIpyBtqrsF+O+BYpmeaiIPg8qqYiVMEK/Zg0
	 niWmMJoaaytBQ==
Date: Tue, 4 Nov 2025 17:40:11 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 5/8] iomap: simplify when reads can be skipped for
 writes
Message-ID: <20251105014011.GF196362@frogsfrogsfrogs>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
 <20251104205119.1600045-6-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104205119.1600045-6-joannelkoong@gmail.com>

On Tue, Nov 04, 2025 at 12:51:16PM -0800, Joanne Koong wrote:
> Currently, the logic for skipping the read range for a write is
> 
> if (!(iter->flags & IOMAP_UNSHARE) &&
>     (from <= poff || from >= poff + plen) &&
>     (to <= poff || to >= poff + plen))
> 
> which breaks down to skipping the read if any of these are true:
> a) from <= poff && to <= poff
> b) from <= poff && to >= poff + plen
> c) from >= poff + plen && to <= poff
> d) from >= poff + plen && to >= poff + plen
> 
> This can be simplified to
> if (!(iter->flags & IOMAP_UNSHARE) && from <= poff && to >= poff + plen)
> 
> from the following reasoning:
> 
> a) from <= poff && to <= poff
> This reduces to 'to <= poff' since it is guaranteed that 'from <= to'
> (since to = from + len). It is not possible for 'from <= to' to be true
> here because we only reach here if plen > 0 (thanks to the preceding 'if
> (plen == 0)' check that would break us out of the loop). If 'to <=
> poff', plen would have to be 0 since poff and plen get adjusted in
> lockstep for uptodate blocks. This means we can eliminate this check.
> 
> c) from >= poff + plen && to <= poff
> This is not possible since 'from <= to' and 'plen > 0'. We can eliminate
> this check.
> 
> d) from >= poff + plen && to >= poff + plen
> This reduces to 'from >= poff + plen' since 'from <= to'.
> It is not possible for 'from >= poff + plen' to be true here. We only
> reach here if plen > 0 and for writes, poff and plen will always be
> block-aligned, which means poff <= from < poff + plen. We can eliminate
> this check.
> 
> The only valid check is b) from <= poff && to >= poff + plen.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Heh yeah, makes sense to me
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 0f14d2a91f49..c02d33bff3d0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -752,9 +752,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
>  		if (plen == 0)
>  			break;
>  
> -		if (!(iter->flags & IOMAP_UNSHARE) &&
> -		    (from <= poff || from >= poff + plen) &&
> -		    (to <= poff || to >= poff + plen))
> +		/*
> +		 * If the read range will be entirely overwritten by the write,
> +		 * we can skip having to zero/read it in.
> +		 */
> +		if (!(iter->flags & IOMAP_UNSHARE) && from <= poff &&
> +		    to >= poff + plen)
>  			continue;
>  
>  		if (iomap_block_needs_zeroing(iter, block_start)) {
> -- 
> 2.47.3
> 
> 

