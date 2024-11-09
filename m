Return-Path: <linux-fsdevel+bounces-34137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F54B9C29A2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 04:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A06284885
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 03:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C04086A;
	Sat,  9 Nov 2024 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghCot6NO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8D17FE
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731121584; cv=none; b=GZMc9gN3aCQ6s5PtnaX0r+2txapqcQ3NZf035a+9Ft/ZHBWQEjaIAHLYa7rO+iNwt/RVQcwgHK6kFuHJ39yqH7bIT/TOGgG7x3kTI6spYxgkVnqgT761j15M8oHuy29jfT9O/Qjl6CyylWddRJAetpMSM9yGxGvOT+dt13qSqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731121584; c=relaxed/simple;
	bh=A9vsRFUDFVF6LyStfxjWxG/m9uJSPqtKvnsJWsjBSzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCAbsVLgFFV2PSAvxXOQGhlz+nNz0o6dK3ZBxHwMyCvOhUypA48FeUgn9ynEcpJyHGpm7WTfeqaViq6QLVqV2GxuJFk2gdg+3p7nYtWwbZidxisROkHxa6EdkB0GY2VS7arUDnAG6jzYoqGL1yenRpdSrND1/Y2NTAqLpMy4c4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghCot6NO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC1AC4CECD;
	Sat,  9 Nov 2024 03:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731121583;
	bh=A9vsRFUDFVF6LyStfxjWxG/m9uJSPqtKvnsJWsjBSzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ghCot6NO9f6yvcc8teCnix8YEVnoGGT1kdvDbBG2YuHbxXa9Lrskd44SsKk3oMCtJ
	 mqBomzj2S4g5Z3Fwzsh9kKO246t64f7A+7Pq7PlTaFMTq949wjf64K3Y/g+ByHyOqs
	 sgLfcZD9wxSH/pPqbL2aHyeAe58ARf2luB+vU7QhdIkBa2QoGXUDGxQBTutHDRY/9A
	 iCpplDuZPLH9oBNd2PfTbeKbLmfPUWtvaNsTalsFLDlo8ck1Z7pvDul8UrV+Hno2EE
	 qfOmSPP4A87McCYmGW9Z+GMrZz1cz0KDZrC1TH1zcAbjD8ovuA6h5qnSjHJ4qEHQdl
	 wvTkA15b9/SgQ==
Date: Fri, 8 Nov 2024 19:06:23 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iomap: warn on zero range of a post-eof folio
Message-ID: <20241109030623.GD9421@frogsfrogsfrogs>
References: <20241108124246.198489-1-bfoster@redhat.com>
 <20241108124246.198489-5-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108124246.198489-5-bfoster@redhat.com>

On Fri, Nov 08, 2024 at 07:42:46AM -0500, Brian Foster wrote:
> iomap_zero_range() uses buffered writes for manual zeroing, no
> longer updates i_size for such writes, but is still explicitly
> called for post-eof ranges. The historical use case for this is
> zeroing post-eof speculative preallocation on extending writes from
> XFS. However, XFS also recently changed to convert all post-eof
> delalloc mappings to unwritten in the iomap_begin() handler, which
> means it now never expects manual zeroing of post-eof mappings. In
> other words, all post-eof mappings should be reported as holes or
> unwritten.
> 
> This is a subtle dependency that can be hard to detect if violated
> because associated codepaths are likely to update i_size after folio
> locks are dropped, but before writeback happens to occur. For
> example, if XFS reverts back to some form of manual zeroing of
> post-eof blocks on write extension, writeback of those zeroed folios
> will now race with the presumed i_size update from the subsequent
> buffered write.
> 
> Since iomap_zero_range() can't correctly zero post-eof mappings
> beyond EOF without updating i_size, warn if this ever occurs. This
> serves as minimal indication that if this use case is reintroduced
> by a filesystem, iomap_zero_range() might need to reconsider i_size
> updates for write extending use cases.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7f40234a301e..e18830e4809b 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1354,6 +1354,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  {
>  	loff_t pos = iter->pos;
>  	loff_t length = iomap_length(iter);
> +	loff_t isize = iter->inode->i_size;
>  	loff_t written = 0;
>  
>  	do {
> @@ -1369,6 +1370,8 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		if (iter->iomap.flags & IOMAP_F_STALE)
>  			break;
>  
> +		/* warn about zeroing folios beyond eof that won't write back */
> +		WARN_ON_ONCE(folio_pos(folio) > isize);

		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size));?

No need to have the extra local variable for something that shouldn't
ever happen.  Do you need i_size_read for correctness here?

--D

>  		offset = offset_in_folio(folio, pos);
>  		if (bytes > folio_size(folio) - offset)
>  			bytes = folio_size(folio) - offset;
> -- 
> 2.47.0
> 
> 

