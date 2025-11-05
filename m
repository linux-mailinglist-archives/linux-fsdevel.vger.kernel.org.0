Return-Path: <linux-fsdevel+bounces-67223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB7DC38314
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 23:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03C724E2F9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1C72F2918;
	Wed,  5 Nov 2025 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acI3zIo2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738D2F1FCB;
	Wed,  5 Nov 2025 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381570; cv=none; b=bDkMTnRq4b1aJjIaEOtdpgEGc3+lhqSQR9E69v3eQm6uurpxJLNNhQgHrXNpcHPIYsx2Wnjy837dt5Au8qUtrrekhPNOQBoSrv+KuPWjLgIql60NKX9iCaoA5G/t7criQeZoN45mgIkxAT/UVAf0xSYub43jgqbuMDb1Orl/9rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381570; c=relaxed/simple;
	bh=nZWFLMMcN0r7NF99uRGN2VpEzlMzOHQomJBjdwJyJIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMsfbyD2idfTIHHsl5QL2YOaKXzzup4FLjkzL4lFN1HOjMQwAXFtTBF06vmM+oZ3edvA1kVZ3QNta8P3LUMW4v1ApswiL5w9/cilXxVpOeo+19PARH8KodLEwrA3vHbAmhZ/mNkrlQsZ0S/YPqEPgjpIPMIF9JWiFwdKPrXNMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acI3zIo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6B9C4CEF5;
	Wed,  5 Nov 2025 22:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762381568;
	bh=nZWFLMMcN0r7NF99uRGN2VpEzlMzOHQomJBjdwJyJIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=acI3zIo2OwN6nBPgpZ4YUKbDU4H6qE1A5zA8baFx6cLPsIx6OesXiWfIsFpji/3id
	 TfKH9BstNA2Osk2nEX3oVLMaryFd69V6AMpnrZKNK0kBZylCDOSxyK2qyOMumyXPLJ
	 9+1TFydaMuMFntK8x0SgpZu9RG3o+Eh6JWfHbtb0Wpj8TWzVGqfzvqrW551KwnbjiR
	 i5qvlIRuauovhYIapYeBMMcmOxq0mG07TR+P0FU4Ln5DDo2QM6Y5Pe0q16auQimqDr
	 5cPW+WV9od/up9Mw/KO0Px00/zuONBV9BdA1ksTvwDzhsshm+AqBBWExRlXvLWxJTX
	 JpluseRnFX4og==
Date: Wed, 5 Nov 2025 14:26:07 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/6] xfs: look up cow fork extent earlier for buffered
 iomap_begin
Message-ID: <20251105222607.GH196370@frogsfrogsfrogs>
References: <20251016190303.53881-1-bfoster@redhat.com>
 <20251016190303.53881-5-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016190303.53881-5-bfoster@redhat.com>

On Thu, Oct 16, 2025 at 03:03:01PM -0400, Brian Foster wrote:
> To further isolate the need for flushing for zero range, we need to
> know whether a hole in the data fork is fronted by blocks in the COW
> fork or not. COW fork lookup currently occurs further down in the
> function, after the zero range case is handled.
> 
> As a preparation step, lift the COW fork extent lookup to earlier in
> the function, at the same time as the data fork lookup. Only the
> lookup logic is lifted. The COW fork branch/reporting logic remains
> as is to avoid any observable behavior change from an iomap
> reporting perspective.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Looks fine to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c | 46 +++++++++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index b84c94558cc9..ba5697d8b8fd 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1753,14 +1753,29 @@ xfs_buffered_write_iomap_begin(
>  		goto out_unlock;
>  
>  	/*
> -	 * Search the data fork first to look up our source mapping.  We
> -	 * always need the data fork map, as we have to return it to the
> -	 * iomap code so that the higher level write code can read data in to
> -	 * perform read-modify-write cycles for unaligned writes.
> +	 * Search the data fork first to look up our source mapping. We always
> +	 * need the data fork map, as we have to return it to the iomap code so
> +	 * that the higher level write code can read data in to perform
> +	 * read-modify-write cycles for unaligned writes.
> +	 *
> +	 * Then search the COW fork extent list even if we did not find a data
> +	 * fork extent. This serves two purposes: first this implements the
> +	 * speculative preallocation using cowextsize, so that we also unshare
> +	 * block adjacent to shared blocks instead of just the shared blocks
> +	 * themselves. Second the lookup in the extent list is generally faster
> +	 * than going out to the shared extent tree.
>  	 */
>  	eof = !xfs_iext_lookup_extent(ip, &ip->i_df, offset_fsb, &icur, &imap);
>  	if (eof)
>  		imap.br_startoff = end_fsb; /* fake hole until the end */
> +	if (xfs_is_cow_inode(ip)) {
> +		if (!ip->i_cowfp) {
> +			ASSERT(!xfs_is_reflink_inode(ip));
> +			xfs_ifork_init_cow(ip);
> +		}
> +		cow_eof = !xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb,
> +				&ccur, &cmap);
> +	}
>  
>  	/* We never need to allocate blocks for unsharing a hole. */
>  	if ((flags & IOMAP_UNSHARE) && imap.br_startoff > offset_fsb) {
> @@ -1827,24 +1842,13 @@ xfs_buffered_write_iomap_begin(
>  	}
>  
>  	/*
> -	 * Search the COW fork extent list even if we did not find a data fork
> -	 * extent.  This serves two purposes: first this implements the
> -	 * speculative preallocation using cowextsize, so that we also unshare
> -	 * block adjacent to shared blocks instead of just the shared blocks
> -	 * themselves.  Second the lookup in the extent list is generally faster
> -	 * than going out to the shared extent tree.
> +	 * Now that we've handled any operation specific special cases, at this
> +	 * point we can report a COW mapping if found.
>  	 */
> -	if (xfs_is_cow_inode(ip)) {
> -		if (!ip->i_cowfp) {
> -			ASSERT(!xfs_is_reflink_inode(ip));
> -			xfs_ifork_init_cow(ip);
> -		}
> -		cow_eof = !xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb,
> -				&ccur, &cmap);
> -		if (!cow_eof && cmap.br_startoff <= offset_fsb) {
> -			trace_xfs_reflink_cow_found(ip, &cmap);
> -			goto found_cow;
> -		}
> +	if (xfs_is_cow_inode(ip) &&
> +	    !cow_eof && cmap.br_startoff <= offset_fsb) {
> +		trace_xfs_reflink_cow_found(ip, &cmap);
> +		goto found_cow;
>  	}
>  
>  	if (imap.br_startoff <= offset_fsb) {
> -- 
> 2.51.0
> 
> 

