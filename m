Return-Path: <linux-fsdevel+bounces-38614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E3CA04E7A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DCA166111
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 00:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CFA1EB39;
	Wed,  8 Jan 2025 00:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD/+Z6YP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AFA1FC3;
	Wed,  8 Jan 2025 00:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297790; cv=none; b=gvXbvN+f4VqPyDtPKwlIOfE0fBBXzrH4OiT7P6ZeUM3JlS/kHksn9m6SU2BRR3EdfyFuMuEshWvseyIN/rf7PsexeYbVtd6yntONKVP1tGAAaiTQ0gzZvnDRGmjpQ0F7JSDtZx0kFlxurEmu1DjXzo37wHVSQkKTMgOkzW6QYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297790; c=relaxed/simple;
	bh=dfumfJ+Yf2MaBAY/D0YUM6gGTdkwuVeYYDBtsWlgBAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BydH4Ke1cTA+rHXMxNp4yYq6AmyrQASjQewx/1EB/N9WjtlawfZo+FjcIXF9lH+r61kp+LyeE/i4SjW7H1W6ZQCzY5F7NB744rnK7ufiQajF+FnjPoqpKtPmd+ClsmSYNTOZM6jONg6Fusw/DQBtDUGe0Mepptz/23P6ktcjegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD/+Z6YP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAF2C4CED6;
	Wed,  8 Jan 2025 00:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736297788;
	bh=dfumfJ+Yf2MaBAY/D0YUM6gGTdkwuVeYYDBtsWlgBAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cD/+Z6YPlr03pE5uHLNAXbnhi14J0/T62nqV+yUjLmrO26xY7Oa/T/Ouqy2MO+GgR
	 7kE33wPeNKKVrI4sgNMBixEx8N1jpFXQqbn7IXGhPw+MUR5B5DTsFOXFCFqRUSW2yQ
	 Pq004vLoaT5SW1swiDT/OHNM977p/MKCOnXwjw+ZodTjMolUp3BJ9PSuOGHT69OIcN
	 T2JbrPc3RF9A1NAQCBhMXLD8T8BiwTwkeOQ5GOVNR7P4SbFK2o0PyvmVRObLXd3Nd+
	 DANybWh4bnxqk3MWVdnD/Utrxg3wp6XbQ0n85oYPqt+v3R0R1gN4UoYFpyZjqsl+AL
	 8GozXM73GBJ1Q==
Date: Tue, 7 Jan 2025 16:56:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 7/7] xfs: Update xfs_get_atomic_write_attr() for large
 atomic writes
Message-ID: <20250108005627.GD1306365@frogsfrogsfrogs>
References: <20250102140411.14617-1-john.g.garry@oracle.com>
 <20250102140411.14617-8-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102140411.14617-8-john.g.garry@oracle.com>

On Thu, Jan 02, 2025 at 02:04:11PM +0000, John Garry wrote:
> Update xfs_get_atomic_write_attr() to take into account that rtvol can
> support atomic writes spanning multiple FS blocks.
> 
> For non-rtvol, we are still limited in min and max by the blocksize.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Pretty straightforward to me.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iops.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 883ec45ae708..02b3f697936b 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -572,18 +572,35 @@ xfs_stat_blksize(
>  	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
>  }
>  
> +/* Returns max atomic write unit for a file, in bytes. */
> +static unsigned int
> +xfs_inode_atomicwrite_max(
> +	struct xfs_inode	*ip)
> +{
> +	struct xfs_mount	*mp = ip->i_mount;
> +
> +	if (XFS_IS_REALTIME_INODE(ip))
> +		return XFS_FSB_TO_B(mp, mp->m_rt_awu_max);
> +
> +	return mp->m_sb.sb_blocksize;
> +}
> +
>  void
>  xfs_get_atomic_write_attr(
>  	struct xfs_inode	*ip,
>  	unsigned int		*unit_min,
>  	unsigned int		*unit_max)
>  {
> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +	unsigned int		awu_max = xfs_inode_atomicwrite_max(ip);
> +
>  	if (!xfs_inode_can_atomicwrite(ip)) {
>  		*unit_min = *unit_max = 0;
>  		return;
>  	}
>  
> -	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
> +	*unit_min = ip->i_mount->m_sb.sb_blocksize;
> +	*unit_max =  min(target->bt_bdev_awu_max, awu_max);
>  }
>  
>  STATIC int
> -- 
> 2.31.1
> 
> 

