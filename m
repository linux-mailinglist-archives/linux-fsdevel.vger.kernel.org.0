Return-Path: <linux-fsdevel+bounces-46496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E5CA8A411
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E59B188E330
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9228B4F0;
	Tue, 15 Apr 2025 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv804O+v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06D52DFA36;
	Tue, 15 Apr 2025 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734361; cv=none; b=R091C1l2OTz2KrLqT89VZQppkS2SBieby48rQBRFo8J226erB/HQj2NaxgRJeN9ZHABgxzA1lLM9K97EQ63NDFDVvUDqqglwuXLXsE6zRCecqyTKO+MRvvXMmwDjo85J9/ucKUIhl3ZveqU3SnKP2f+1BA5RyiBa0gsZULDVKa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734361; c=relaxed/simple;
	bh=DD4GUf8VvuzvbL4+3b0xOhTk0IxS3V/vcDCvRItAwGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqnJDj8O9/wXWW1+0HPN51hk69pgzw9PbPMIzvNvuyiDp7p3Q7lLBjXFPWrsJSXkLq24Jw9S4S8UvgSRrPl5Fx44coRfn0jTVrST1Zyr5hB7T25l6mBYfA4/dT6WT4u4ZUAw4+PEuG5bPBTU+zcZi5Aq4wdoJw37p/ftte4H1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv804O+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF53C4CEEC;
	Tue, 15 Apr 2025 16:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744734361;
	bh=DD4GUf8VvuzvbL4+3b0xOhTk0IxS3V/vcDCvRItAwGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hv804O+v/qiVhc2TUYzuGSw9wdClIFlnMVPF76N6L2bveIc7ZSZx2yuF+7OS5M/oF
	 8ehv5h7iefLWywO3rgvdBQNWZgryH314YYhFY7AcF6A9jJICJgje+zM12BxApVRNTp
	 GbKuFNziP1DlwYwA8PMhybcoNtsG4UKugQsBnTc/RHJc+YV1ZBB5ZkLPg+YmRuLBzl
	 Y3BAlpDHTGlGalzLjdtlwYCtkCvn8Ol9LyvLndTRiQRbBlOavCnVPA+XWfsaYeWh1W
	 QO3X/zc10jJ6KdaW6wX97eOTovIWx7UX7ihnjquYT/74XjP4nnI2H0ZWwr2mOUHPdq
	 ZuimZKS9cxkIA==
Date: Tue, 15 Apr 2025 09:26:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v7 13/14] xfs: update atomic write limits
Message-ID: <20250415162600.GQ25675@frogsfrogsfrogs>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-14-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415121425.4146847-14-john.g.garry@oracle.com>

On Tue, Apr 15, 2025 at 12:14:24PM +0000, John Garry wrote:
> Update the limits returned from xfs_get_atomic_write_{min, max, max_opt)().
> 
> No reflink support always means no CoW-based atomic writes.
> 
> For updating xfs_get_atomic_write_min(), we support blocksize only and that
> depends on HW or reflink support.
> 
> For updating xfs_get_atomic_write_max(), for no reflink, we are limited to
> blocksize but only if HW support. Otherwise we are limited to combined
> limit in mp->m_atomic_write_unit_max.
> 
> For updating xfs_get_atomic_write_max_opt(), ultimately we are limited by
> the bdev atomic write limit. If xfs_get_atomic_write_max() does not report
>  > 1x blocksize, then just continue to report 0 as before.
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> [djwong: update comments in the helper functions]

Same here, there should be a
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

after this comment.

--D

> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c |  2 +-
>  fs/xfs/xfs_iops.c | 53 +++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 81a377f65aa3..d1ddbc4a98c3 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1557,7 +1557,7 @@ xfs_file_open(
>  	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
>  		return -EIO;
>  	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
> -	if (xfs_inode_can_hw_atomicwrite(XFS_I(inode)))
> +	if (xfs_get_atomic_write_min(XFS_I(inode)))
>  		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
>  	return generic_file_open(inode, file);
>  }
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 3b5aa39dbfe9..183524d06bc3 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -605,27 +605,68 @@ unsigned int
>  xfs_get_atomic_write_min(
>  	struct xfs_inode	*ip)
>  {
> -	if (!xfs_inode_can_hw_atomicwrite(ip))
> -		return 0;
> +	struct xfs_mount	*mp = ip->i_mount;
> +
> +	/*
> +	 * If we can complete an atomic write via atomic out of place writes,
> +	 * then advertise a minimum size of one fsblock.  Without this
> +	 * mechanism, we can only guarantee atomic writes up to a single LBA.
> +	 *
> +	 * If out of place writes are not available, we can guarantee an atomic
> +	 * write of exactly one single fsblock if the bdev will make that
> +	 * guarantee for us.
> +	 */
> +	if (xfs_inode_can_hw_atomicwrite(ip) || xfs_has_reflink(mp))
> +		return mp->m_sb.sb_blocksize;
>  
> -	return ip->i_mount->m_sb.sb_blocksize;
> +	return 0;
>  }
>  
>  unsigned int
>  xfs_get_atomic_write_max(
>  	struct xfs_inode	*ip)
>  {
> -	if (!xfs_inode_can_hw_atomicwrite(ip))
> +	struct xfs_mount	*mp = ip->i_mount;
> +
> +	/*
> +	 * If out of place writes are not available, we can guarantee an atomic
> +	 * write of exactly one single fsblock if the bdev will make that
> +	 * guarantee for us.
> +	 */
> +	if (!xfs_has_reflink(mp)) {
> +		if (xfs_inode_can_hw_atomicwrite(ip))
> +			return mp->m_sb.sb_blocksize;
>  		return 0;
> +	}
>  
> -	return ip->i_mount->m_sb.sb_blocksize;
> +	/*
> +	 * If we can complete an atomic write via atomic out of place writes,
> +	 * then advertise a maximum size of whatever we can complete through
> +	 * that means.  Hardware support is reported via max_opt, not here.
> +	 */
> +	if (XFS_IS_REALTIME_INODE(ip))
> +		return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_RTG].awu_max);
> +	return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_AG].awu_max);
>  }
>  
>  unsigned int
>  xfs_get_atomic_write_max_opt(
>  	struct xfs_inode	*ip)
>  {
> -	return 0;
> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +	unsigned int		awu_max = xfs_get_atomic_write_max(ip);
> +
> +	/* if the max is 1x block, then just keep behaviour that opt is 0 */
> +	if (awu_max <= ip->i_mount->m_sb.sb_blocksize)
> +		return 0;
> +
> +	/*
> +	 * Advertise the maximum size of an atomic write that we can tell the
> +	 * block device to perform for us.  In general the bdev limit will be
> +	 * less than our out of place write limit, but we don't want to exceed
> +	 * the awu_max.
> +	 */
> +	return min(awu_max, target->bt_bdev_awu_max);
>  }
>  
>  static void
> -- 
> 2.31.1
> 
> 

