Return-Path: <linux-fsdevel+bounces-42799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF61AA48DDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 02:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AEB3AD365
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 01:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C56170A11;
	Fri, 28 Feb 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hfxz/fhl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672012CD8B;
	Fri, 28 Feb 2025 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705594; cv=none; b=ez1ahH5PUyGaJ2q/ENYQYAqnHKnYywsAMwUy6N5ED8Qav8csN9onkURyYl4Bj/Ma3Sr4G+337LDuRn5zUMsFPj8nOTswKubG7HFLnsLgkmddTX/HQWHT0obGUmWoI5eM2rqFQzwUvExFndQWBNfIaI81cZX8aKHS/+fvg7UKHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705594; c=relaxed/simple;
	bh=L7rzvAK4ZsO18KdhwI2mq+fLPlS79rz99ySKhQL2HMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKFWuqg2SgORBXxDk0sah98YOwhRtOEv4LrsjkNkwYXiy+ot+gRM2f6a5wCUxrD/pqlvZM+z5g8j9Zt18h26WGMEktGyJcRPinj7eY+WaGSULmWaRgEH6xbOu4c57T3ccY2ziHxDpkU2zNvv0jvypnt8ORBhvGefOrXfSG3rQ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hfxz/fhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051BAC4CEDD;
	Fri, 28 Feb 2025 01:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740705594;
	bh=L7rzvAK4ZsO18KdhwI2mq+fLPlS79rz99ySKhQL2HMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hfxz/fhlwbt7WB4j8TljNoWbGBjmlyprBUtVkIAGqRhG6WMwyoGXSW2ED3D+zWW/D
	 kzWls41CPOxtM9bcm1qYt/h8Ems5oM1Cwc6CavTvCDUlCxumv6D220UVFiM0XHn9fK
	 LUltJrhBDeU0F5WSCi6OKQPLzv3ISfyrW3UFsbVRFhOoBuh/7oZV/OexpjChD4DMN+
	 drLtZSQtJrXGmo7t5e0SqPYRmOwJIDViMSOSMbYWkxHqa00cFyHpW5Zs76vZvyzmkv
	 /p6slceBln/kquY0DotMkHgUMA+A89Ao/Z/wtsKLlizUtPr/09IZd9UiwkRjBRMH9K
	 4/vAvDlgHsbuA==
Date: Thu, 27 Feb 2025 17:19:53 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 01/12] xfs: Pass flags to xfs_reflink_allocate_cow()
Message-ID: <20250228011953.GF1124788@frogsfrogsfrogs>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
 <20250227180813.1553404-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227180813.1553404-2-john.g.garry@oracle.com>

On Thu, Feb 27, 2025 at 06:08:02PM +0000, John Garry wrote:
> In future we will want more boolean options for xfs_reflink_allocate_cow(),
> so just prepare for this by passing a flags arg for @convert_now.
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks decent,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c   |  7 +++++--
>  fs/xfs/xfs_reflink.c | 10 ++++++----
>  fs/xfs/xfs_reflink.h |  7 ++++++-
>  3 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index d61460309a78..edfc038bf728 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -810,6 +810,7 @@ xfs_direct_write_iomap_begin(
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
>  	int			nimaps = 1, error = 0;
> +	unsigned int		reflink_flags = 0;
>  	bool			shared = false;
>  	u16			iomap_flags = 0;
>  	unsigned int		lockmode;
> @@ -820,6 +821,9 @@ xfs_direct_write_iomap_begin(
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
>  
> +	if (flags & IOMAP_DIRECT || IS_DAX(inode))
> +		reflink_flags |= XFS_REFLINK_CONVERT;
> +
>  	/*
>  	 * Writes that span EOF might trigger an IO size update on completion,
>  	 * so consider them to be dirty for the purposes of O_DSYNC even if
> @@ -864,8 +868,7 @@ xfs_direct_write_iomap_begin(
>  
>  		/* may drop and re-acquire the ilock */
>  		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> -				&lockmode,
> -				(flags & IOMAP_DIRECT) || IS_DAX(inode));
> +				&lockmode, reflink_flags);
>  		if (error)
>  			goto out_unlock;
>  		if (shared)
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 59f7fc16eb80..0eb2670fc6fb 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -435,7 +435,7 @@ xfs_reflink_fill_cow_hole(
>  	struct xfs_bmbt_irec	*cmap,
>  	bool			*shared,
>  	uint			*lockmode,
> -	bool			convert_now)
> +	unsigned int		flags)
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
>  	struct xfs_trans	*tp;
> @@ -488,7 +488,8 @@ xfs_reflink_fill_cow_hole(
>  		return error;
>  
>  convert:
> -	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
> +	return xfs_reflink_convert_unwritten(ip, imap, cmap,
> +			flags & XFS_REFLINK_CONVERT);
>  
>  out_trans_cancel:
>  	xfs_trans_cancel(tp);
> @@ -566,10 +567,11 @@ xfs_reflink_allocate_cow(
>  	struct xfs_bmbt_irec	*cmap,
>  	bool			*shared,
>  	uint			*lockmode,
> -	bool			convert_now)
> +	unsigned int		flags)
>  {
>  	int			error;
>  	bool			found;
> +	bool			convert_now = flags & XFS_REFLINK_CONVERT;
>  
>  	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	if (!ip->i_cowfp) {
> @@ -592,7 +594,7 @@ xfs_reflink_allocate_cow(
>  	 */
>  	if (cmap->br_startoff > imap->br_startoff)
>  		return xfs_reflink_fill_cow_hole(ip, imap, cmap, shared,
> -				lockmode, convert_now);
> +				lockmode, flags);
>  
>  	/*
>  	 * CoW fork has a delalloc reservation. Replace it with a real extent.
> diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
> index cc4e92278279..cdbd73d58822 100644
> --- a/fs/xfs/xfs_reflink.h
> +++ b/fs/xfs/xfs_reflink.h
> @@ -6,6 +6,11 @@
>  #ifndef __XFS_REFLINK_H
>  #define __XFS_REFLINK_H 1
>  
> +/*
> + * Flags for xfs_reflink_allocate_cow()
> + */
> +#define XFS_REFLINK_CONVERT	(1u << 0) /* convert unwritten extents now */
> +
>  /*
>   * Check whether it is safe to free COW fork blocks from an inode. It is unsafe
>   * to do so when an inode has dirty cache or I/O in-flight, even if no shared
> @@ -32,7 +37,7 @@ int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
>  
>  int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
>  		struct xfs_bmbt_irec *cmap, bool *shared, uint *lockmode,
> -		bool convert_now);
> +		unsigned int flags);
>  extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
>  		xfs_off_t count);
>  
> -- 
> 2.31.1
> 

