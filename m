Return-Path: <linux-fsdevel+bounces-16816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15E58A328E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7F32836D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 15:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2E014830A;
	Fri, 12 Apr 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrsNdj5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1B1482F0;
	Fri, 12 Apr 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936097; cv=none; b=q1QeP9JgZKXFzP7bjiWCuzOulWt1RXVABGebiqxPrxEBAuqYnwybzw3bfm8RaKUGAJEg02tLQyPtTvIvg8T/BrDq18U8cfKtYjx14gvAXu6HbMLL4UAYzInAKb80FKiLhDqlaD21neNb06La76ySmyyYF2oWFqJ+Xjz26/t4UYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936097; c=relaxed/simple;
	bh=+PLPj96sUpoTTOgdxVYSW3Q/ccb69cbmqY5Wn+NgmOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpo4+lAC+AEI8TH3GX9qsw8TLarnWNg3dKBlDEuokrvpbbKWT1EI6Shvddsj2rs5Fmd2UqENYvODfDQlc14AA8O/6K+ZbdY81xrt9yEMq+Rk4A6yLzVOxOyClYfhR+oWE3Xqc3vzw9nsw/Q/4tSMq+L9D1ca14KBKLdJ1m7sV1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrsNdj5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81960C113CC;
	Fri, 12 Apr 2024 15:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712936096;
	bh=+PLPj96sUpoTTOgdxVYSW3Q/ccb69cbmqY5Wn+NgmOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrsNdj5KaQjFPd3Z3ld4jlJpqwWQwgiSRcS1mnnqjkmpyp5g5A3o1lGY31ZJkYimU
	 lQkYi0TZ7U+C0jjZTMywlYZOvRQ9U2O30Ia1WGrt59UPeqLdYg2gMt0s7TenvC0Jxr
	 Ca2sPiDwkOHXZEy9y2/5iJRZJhn72G+rYEYzioyd1bPuuGghokDljO7DRzxFG41uY+
	 boR1YZNn4aGwaTD5ayK8MCzOSsyIpJkpNzgFuZ98G66N6Ws3tNcWmIceOMBRQB6EA7
	 aycPrzPJ3bC9waU9sl2zcxLauWU6TmCDqzmSs/rSdCixogxk2ms384tD1CQdvBe4aV
	 nPD95Hnz0prbg==
Date: Fri, 12 Apr 2024 08:34:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] iomap: convert iomap_writepages to writeack_iter
Message-ID: <20240412153455.GA11948@frogsfrogsfrogs>
References: <20240412061614.1511629-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412061614.1511629-1-hch@lst.de>

[adding willy to cc just in case he sees something I didn't]

On Fri, Apr 12, 2024 at 08:16:14AM +0200, Christoph Hellwig wrote:
> This removes one indirect function call per folio, and adds type safety
> by not casting through a void pointer.
> 
> Based on a patch by Matthew Wilcox.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks like a straightforward conversion to me...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 4e8e41c8b3c0e4..e09441f4fceb6f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1958,18 +1958,13 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	return error;
>  }
>  
> -static int iomap_do_writepage(struct folio *folio,
> -		struct writeback_control *wbc, void *data)
> -{
> -	return iomap_writepage_map(data, wbc, folio);
> -}
> -
>  int
>  iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>  		struct iomap_writepage_ctx *wpc,
>  		const struct iomap_writeback_ops *ops)
>  {
> -	int			ret;
> +	struct folio *folio = NULL;
> +	int error;
>  
>  	/*
>  	 * Writeback from reclaim context should never happen except in the case
> @@ -1980,8 +1975,9 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>  		return -EIO;
>  
>  	wpc->ops = ops;
> -	ret = write_cache_pages(mapping, wbc, iomap_do_writepage, wpc);
> -	return iomap_submit_ioend(wpc, ret);
> +	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
> +		error = iomap_writepage_map(wpc, wbc, folio);
> +	return iomap_submit_ioend(wpc, error);
>  }
>  EXPORT_SYMBOL_GPL(iomap_writepages);
>  
> -- 
> 2.39.2
> 
> 

