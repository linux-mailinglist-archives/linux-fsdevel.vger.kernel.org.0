Return-Path: <linux-fsdevel+bounces-46506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A659EA8A5C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 19:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80ABA1885188
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F9022CBC4;
	Tue, 15 Apr 2025 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T52SnDaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C6C21E08A;
	Tue, 15 Apr 2025 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738482; cv=none; b=l+G+xLAaqU3/XgfDgvZ+U1RAlvpmsOPq84hmb/fdnru4t8a2LpX71cRKCSPagStSQep0ciU9+e/O2VjlhxPbZzhQxdCEsr0OAWJaNzOtCDFvyxncnMQ5ifUAkVUHC49SY14/IZYX4vKQFILyEmlkoT8urk7vumr877OODXHb3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738482; c=relaxed/simple;
	bh=p9kE5829W/aOyZK7DSEfDCiTLVo2HtGgK+T/Qy5/6SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDODSU6WAxT1UpqIiaB5Sb1AjU/fG5omue7z6Zglf+VlOca8kptpPu5BbtqMhWuW519kDcO8PI07CNa9k9UtQiJY/gvA57veETVTVrdCKhIOzZMoQI86Ttk2ExHN4huxtjlcjVrKJ7KWHd7XLtHWlTTPJ9dfbkiEZFNUasRGtNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T52SnDaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3511C4CEE9;
	Tue, 15 Apr 2025 17:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744738480;
	bh=p9kE5829W/aOyZK7DSEfDCiTLVo2HtGgK+T/Qy5/6SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T52SnDaHYoTYXUo5uEi8VQFVvAh+Af9RcLSolEh1gxTZDum35ckqo15ongZrX3pVx
	 kicDRc2fZvEsgi1xp94YP6UlTTRHovGFzOqm2PqjABl6BdX5cIVbeozjbB7iM8NLpo
	 m8jcWO34ne0CvcHGEV1psZ2bx4LbMap8aIT5ZAH/Izu7DjND4Aomd8gjARMsJLd71B
	 X9MJKVEB5vV8Do/8GaTXd3dXkDRi7QXOG/RJOKtnEOISefd/RJ5g9LyXTvQ+QrQ6Cb
	 wki5OyEjP69bcI1LxnyPyy/Ibd/H3odfz/NwUQKcAA8kmfpJJexMju68rLato9ItAu
	 o8ZqPmf4rPeZQ==
Date: Tue, 15 Apr 2025 10:34:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v7 09/14] xfs: add large atomic writes checks in
 xfs_direct_write_iomap_begin()
Message-ID: <20250415173439.GU25675@frogsfrogsfrogs>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-10-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415121425.4146847-10-john.g.garry@oracle.com>

On Tue, Apr 15, 2025 at 12:14:20PM +0000, John Garry wrote:
> For when large atomic writes (> 1x FS block) are supported, there will be
> various occasions when HW offload may not be possible.
> 
> Such instances include:
> - unaligned extent mapping wrt write length
> - extent mappings which do not cover the full write, e.g. the write spans
>   sparse or mixed-mapping extents
> - the write length is greater than HW offload can support
> 
> In those cases, we need to fallback to the CoW-based atomic write mode. For
> this, report special code -ENOPROTOOPT to inform the caller that HW
> offload-based method is not possible.
> 
> In addition to the occasions mentioned, if the write covers an unallocated
> range, we again judge that we need to rely on the CoW-based method when we
> would need to allocate anything more than 1x block. This is because if we
> allocate less blocks that is required for the write, then again HW
> offload-based method would not be possible. So we are taking a pessimistic
> approach to writes covering unallocated space.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/xfs/xfs_iomap.c | 65 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 63 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 049655ebc3f7..02bb8257ea24 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -798,6 +798,41 @@ imap_spans_range(
>  	return true;
>  }
>  
> +static bool
> +xfs_bmap_hw_atomic_write_possible(
> +	struct xfs_inode	*ip,
> +	struct xfs_bmbt_irec	*imap,
> +	xfs_fileoff_t		offset_fsb,
> +	xfs_fileoff_t		end_fsb)
> +{
> +	struct xfs_mount	*mp = ip->i_mount;
> +	xfs_fsize_t		len = XFS_FSB_TO_B(mp, end_fsb - offset_fsb);
> +
> +	/*
> +	 * atomic writes are required to be naturally aligned for disk blocks,
> +	 * which ensures that we adhere to block layer rules that we won't
> +	 * straddle any boundary or violate write alignment requirement.
> +	 */
> +	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
> +		return false;
> +
> +	/*
> +	 * Spanning multiple extents would mean that multiple BIOs would be
> +	 * issued, and so would lose atomicity required for REQ_ATOMIC-based
> +	 * atomics.
> +	 */
> +	if (!imap_spans_range(imap, offset_fsb, end_fsb))
> +		return false;
> +
> +	/*
> +	 * The ->iomap_begin caller should ensure this, but check anyway.
> +	 */
> +	if (len > xfs_inode_buftarg(ip)->bt_bdev_awu_max)
> +		return false;

This needs to check len against bt_bdev_awu_min so that we don't submit
too-short atomic writes to the hardware.  Let's say that the hardware
minimum is 32k and the fsblock size is 4k.  XFS can perform an out of
place write for 4k-16k writes, but right now we'll just throw invalid
commands at the bdev, and it'll return EINVAL.

/me wonders if statx should grow a atomic_write_unit_min_opt field
too, unless everyone in block layer land is convinced that awu_min will
always match lbasize?  (I probably missed that conversation)

--D

> +
> +	return true;
> +}
> +
>  static int
>  xfs_direct_write_iomap_begin(
>  	struct inode		*inode,
> @@ -812,9 +847,11 @@ xfs_direct_write_iomap_begin(
>  	struct xfs_bmbt_irec	imap, cmap;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
> +	xfs_fileoff_t		orig_end_fsb = end_fsb;
>  	int			nimaps = 1, error = 0;
>  	bool			shared = false;
>  	u16			iomap_flags = 0;
> +	bool			needs_alloc;
>  	unsigned int		lockmode;
>  	u64			seq;
>  
> @@ -875,13 +912,37 @@ xfs_direct_write_iomap_begin(
>  				(flags & IOMAP_DIRECT) || IS_DAX(inode));
>  		if (error)
>  			goto out_unlock;
> -		if (shared)
> +		if (shared) {
> +			if ((flags & IOMAP_ATOMIC) &&
> +			    !xfs_bmap_hw_atomic_write_possible(ip, &cmap,
> +					offset_fsb, end_fsb)) {
> +				error = -ENOPROTOOPT;
> +				goto out_unlock;
> +			}
>  			goto out_found_cow;
> +		}
>  		end_fsb = imap.br_startoff + imap.br_blockcount;
>  		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
>  	}
>  
> -	if (imap_needs_alloc(inode, flags, &imap, nimaps))
> +	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
> +
> +	if (flags & IOMAP_ATOMIC) {
> +		error = -ENOPROTOOPT;
> +		/*
> +		 * If we allocate less than what is required for the write
> +		 * then we may end up with multiple extents, which means that
> +		 * REQ_ATOMIC-based cannot be used, so avoid this possibility.
> +		 */
> +		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
> +			goto out_unlock;
> +
> +		if (!xfs_bmap_hw_atomic_write_possible(ip, &imap, offset_fsb,
> +				orig_end_fsb))
> +			goto out_unlock;
> +	}
> +
> +	if (needs_alloc)
>  		goto allocate_blocks;
>  
>  	/*
> -- 
> 2.31.1
> 
> 

