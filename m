Return-Path: <linux-fsdevel+bounces-74284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FDBD38C6D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 06:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80B1E30319AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 05:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4B2326D46;
	Sat, 17 Jan 2026 05:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmEPMNNa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791C5500962
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 05:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768626191; cv=none; b=JSL7zOgM2Tjl+gx7XYctmljj7e/GGwNyTUBDuSBS0mP1w3uHLZbODuwo2XMHJnqgPsu8sSZtZ3IIDVVGIhBKsIgc70O+K/DrL8wLdVOu/KRaTr+ndY/YbGH1WMchp1Xz453tDxco3fPLoHRrxLsdgesRY2AQ/oc1sfntcAXk7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768626191; c=relaxed/simple;
	bh=lMK1+03dygchTUvtbWLLsfGPoipsd2WzvdjuxKT3CuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZmQvejV8N0JcYaMy90jAUR5aqn0qVv2XiseKJtQlGQ2ux2bKnSDyOTKAfWVseTXDh5nFvSinV9QvoGXmdXluSYK1uGenSE4uya55+pBAhlh3DN4bUqWdZjlo+XWMwcMt3Qyh3M7FTqnpMAV2HsGa5H5Id+WeUtjwSFu6YPIGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmEPMNNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFA6C4CEF7;
	Sat, 17 Jan 2026 05:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768626191;
	bh=lMK1+03dygchTUvtbWLLsfGPoipsd2WzvdjuxKT3CuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmEPMNNa8/+/7DmxOJ2g7kYyHP+/S8pFnIUnBeSyabQaPlMyRdSL/SmClDGNSR1d0
	 VpbYQBZpGqLHv+mK4aRamjzCJErrJHicb74mqwzqrBY3ZnFuGnEs1hEZY+DqVio5v9
	 sCi7HG0s1aEoLv97+nZ5RW2/lm/SvHbWRZQ6ZswjANlTRHLqOB9XW3nEhizGCxiH7Q
	 Ac44tAibQmgrjIwDTqtY9EDkATAKLi4rIvwyEm/GDbyksItyDNtXILq3blz4G8Z33e
	 nlUvOYRAw6pcllu7eNNwrY5JcdkyRq0EqkwMnMwyMWYKFSKqGaNK1n5AIZdynvrAcD
	 /fH9NIXj9roTg==
Date: Fri, 16 Jan 2026 21:03:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	jefflexu@linux.alibaba.com
Subject: Re: [PATCH v1 0/3] fuse: clean up offset and page count calculations
Message-ID: <20260117050310.GE15532@frogsfrogsfrogs>
References: <20260116235606.2205801-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116235606.2205801-1-joannelkoong@gmail.com>

On Fri, Jan 16, 2026 at 03:56:03PM -0800, Joanne Koong wrote:
> This patchset aims to improve code clarity by using standard kernel helper
> macros for common calculations:
>  * DIV_ROUND_UP() for page count calculations
>  * offset_in_folio() for large folio offset calculations
>  * offset_in_page() for page offset calculations
> 
> These helpers improve readability and consistency with patterns used
> elsewhere in the kernel. No functional changes intended.
> 
> This patchset is on top of Jingbo's patch in [1].

As a straight conversion this looks fine to me so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

OTOH I just learned that fuse has a backchannel for fuse servers to
inject pagecache data for a regular file.  That might be kinda nice for
an HSM or something?  Though that would be covered by FUSE_READ.

Hrmm, I wonder how well that interacts with iomap... we don't mark the
folios dirty or update timestamps, so I'm guessing the contents could
disappear at any time if the page cache gets reclaimed?

Weiiiird.....

--D


> Thanks,
> Joanne
> 
> [1] https://lore.kernel.org/linux-fsdevel/20260115023607.77349-1-jefflexu@linux.alibaba.com/
> 
> Joanne Koong (3):
>   fuse: use DIV_ROUND_UP() for page count calculations
>   fuse: use offset_in_folio() for large folio offset calculations
>   fuse: use offset_in_page() for page offset calculations
> 
>  fs/fuse/dev.c     | 14 +++++++-------
>  fs/fuse/file.c    |  2 +-
>  fs/fuse/readdir.c |  8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> -- 
> 2.47.3
> 
> 

