Return-Path: <linux-fsdevel+bounces-25161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4968E9497EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3944282269
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858E913AD20;
	Tue,  6 Aug 2024 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNQTucUN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26367580C;
	Tue,  6 Aug 2024 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970928; cv=none; b=AjQKMoTxk/D25ZDhp94qk8iCCcKWmzd+j3iC0UDvabtelwBEBEKkjHHNmz5PUn7emCaOIwZ9JSWibXLNlQ3hRx8bkaEiZHI43I7O+xGhD5EHsnrn2zNza1P0556PigGZ7oxHpFS6qHLwCwLqLOwr07L9p0Oabe2pXxZJ7FRi2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970928; c=relaxed/simple;
	bh=b3o6esxW7wVryzQ6jNxLFPjNMBZvRF0ZIVC6Zl5cDok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHLZwzP1FVsauajH0pgO5/QrWhmV1wnghrl0f3+I4BH1qyBBPndoZ8bO970ucYv1KM3grJqwChTXyxw0IU3BJ5IYoVHkCC3AgjJBj8ha3b3JA6V3RcOW6Sp2EKg7Mlt48mc3CrTDitiroJ0iN1IsNU5vYm2cF/Fqo3dj1yKnrrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNQTucUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B685C4AF0D;
	Tue,  6 Aug 2024 19:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722970927;
	bh=b3o6esxW7wVryzQ6jNxLFPjNMBZvRF0ZIVC6Zl5cDok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNQTucUNxm9oZI56VdSvufxtHBlvBBhWOcZ5bgk+pq3zvTwf9uOK6t0pOT+tMQKy3
	 xiuf498vkA9BrEw0RTjEacUZUGLHA+4fG19Rtqv/xIfUGxzlu82IXpB1LJWbXxxaRb
	 mc5/rmW3dDG3W29m5loG10proLu/7sGuacr4qx8q44+usH5clMX6FaH/Yd/3hv1z+7
	 Tp1RmsEku6vZU+/XM8OqguSlgcpELYB9ZMFqAJh/9mwMoLkuhgi2gRDlkkxlLrKAdW
	 LNeDzJc6V0YbeEAugKCv0gF943+VplaXVnIJnJkYnOJTzHdGg5fF6w+BN3wsPg7ny3
	 jar5L/HGLshQg==
Date: Tue, 6 Aug 2024 12:02:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 07/14] xfs: Introduce FORCEALIGN inode flag
Message-ID: <20240806190206.GJ623936@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-8-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801163057.3981192-8-john.g.garry@oracle.com>

On Thu, Aug 01, 2024 at 04:30:50PM +0000, John Garry wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> Add a new inode flag to require that all file data extent mappings must
> be aligned (both the file offset range and the allocated space itself)
> to the extent size hint.  Having a separate COW extent size hint is no
> longer allowed.
> 
> The goal here is to enable sysadmins and users to mandate that all space
> mappings in a file must have a startoff/blockcount that are aligned to
> (say) a 2MB alignment and that the startblock/blockcount will follow the
> same alignment.
> 
> Allocated space will be aligned to start of the AG, and not necessarily
> aligned with disk blocks. The upcoming atomic writes feature will rely and
> forcealign and will also require allocated space will also be aligned to
> disk blocks.
> 
> reflink will not be supported for forcealign yet, so disallow a mount under
> this condition. This is because we have the limitation of pageache
> writeback not knowing how to writeback an entire allocation unut, so
> reject a mount with relink.
> 
> RT vol will not be supported for forcealign yet, so disallow a mount under
> this condition. It will be possible to support RT vol and forcealign in
> future. For this, the inode extsize must be a multiple of rtextsize - this
> is enforced already in xfs_ioctl_setattr_check_extsize() and
> xfs_inode_validate_extsize().
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Co-developed-by: John Garry <john.g.garry@oracle.com>
> [jpg: many changes from orig, including forcealign inode verification
>  rework, ioctl setattr rework disallow reflink a forcealign inode,
>  disallow mount for forcealign + reflink or rt]
> Signed-off-by: John Garry <john.g.garry@oracle.com>

This patch looks ready to me but as I'm the original author I cannot add
a RVB tag.  Someone else needs to add that -- frankly, John is the best
candidate because he grabbed my patch into his tree and actually
modified it to do what he wants, which means he's the most familiar with
it.

--D

> ---
>  fs/xfs/libxfs/xfs_format.h     |  6 ++++-
>  fs/xfs/libxfs/xfs_inode_buf.c  | 46 ++++++++++++++++++++++++++++++++++
>  fs/xfs/libxfs/xfs_inode_buf.h  |  3 +++
>  fs/xfs/libxfs/xfs_inode_util.c | 14 +++++++++++
>  fs/xfs/libxfs/xfs_sb.c         |  2 ++
>  fs/xfs/xfs_inode.h             |  8 +++++-
>  fs/xfs/xfs_ioctl.c             | 46 ++++++++++++++++++++++++++++++++--
>  fs/xfs/xfs_mount.h             |  2 ++
>  fs/xfs/xfs_reflink.c           |  5 ++--
>  fs/xfs/xfs_super.c             | 18 +++++++++++++
>  include/uapi/linux/fs.h        |  2 ++
>  11 files changed, 146 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> index e1bfee0c3b1a..95f5259c4255 100644
> --- a/fs/xfs/libxfs/xfs_format.h
> +++ b/fs/xfs/libxfs/xfs_format.h
> @@ -352,6 +352,7 @@ xfs_sb_has_compat_feature(
>  #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
>  #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>  #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
> +#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
>  #define XFS_SB_FEAT_RO_COMPAT_ALL \
>  		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
>  		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
> @@ -1093,16 +1094,19 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
>  #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
>  #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
>  #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
> +/* data extent mappings for regular files must be aligned to extent size hint */
> +#define XFS_DIFLAG2_FORCEALIGN_BIT 5
>  
>  #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
>  #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
>  #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
>  #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
>  #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
> +#define XFS_DIFLAG2_FORCEALIGN	(1 << XFS_DIFLAG2_FORCEALIGN_BIT)
>  
>  #define XFS_DIFLAG2_ANY \
>  	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
> -	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
> +	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN)
>  
>  static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
>  {
> diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
> index 513b50da6215..1c59891fa9e2 100644
> --- a/fs/xfs/libxfs/xfs_inode_buf.c
> +++ b/fs/xfs/libxfs/xfs_inode_buf.c
> @@ -657,6 +657,15 @@ xfs_dinode_verify(
>  	    !xfs_has_bigtime(mp))
>  		return __this_address;
>  
> +	if (flags2 & XFS_DIFLAG2_FORCEALIGN) {
> +		fa = xfs_inode_validate_forcealign(mp,
> +				be32_to_cpu(dip->di_extsize),
> +				be32_to_cpu(dip->di_cowextsize),
> +				mode, flags, flags2);
> +		if (fa)
> +			return fa;
> +	}
> +
>  	return NULL;
>  }
>  
> @@ -824,3 +833,40 @@ xfs_inode_validate_cowextsize(
>  
>  	return NULL;
>  }
> +
> +/* Validate the forcealign inode flag */
> +xfs_failaddr_t
> +xfs_inode_validate_forcealign(
> +	struct xfs_mount	*mp,
> +	uint32_t		extsize,
> +	uint32_t		cowextsize,
> +	uint16_t		mode,
> +	uint16_t		flags,
> +	uint64_t		flags2)
> +{
> +	/* superblock rocompat feature flag */
> +	if (!xfs_has_forcealign(mp))
> +		return __this_address;
> +
> +	/* Only regular files and directories */
> +	if (!S_ISDIR(mode) && !S_ISREG(mode))
> +		return __this_address;
> +
> +	/* We require EXTSIZE or EXTSZINHERIT */
> +	if (!(flags & (XFS_DIFLAG_EXTSIZE | XFS_DIFLAG_EXTSZINHERIT)))
> +		return __this_address;
> +
> +	/* We require a non-zero extsize */
> +	if (!extsize)
> +		return __this_address;
> +
> +	/* COW extsize disallowed */
> +	if (flags2 & XFS_DIFLAG2_COWEXTSIZE)
> +		return __this_address;
> +
> +	/* cowextsize must be zero */
> +	if (cowextsize)
> +		return __this_address;
> +
> +	return NULL;
> +}
> diff --git a/fs/xfs/libxfs/xfs_inode_buf.h b/fs/xfs/libxfs/xfs_inode_buf.h
> index 585ed5a110af..b8b65287b037 100644
> --- a/fs/xfs/libxfs/xfs_inode_buf.h
> +++ b/fs/xfs/libxfs/xfs_inode_buf.h
> @@ -33,6 +33,9 @@ xfs_failaddr_t xfs_inode_validate_extsize(struct xfs_mount *mp,
>  xfs_failaddr_t xfs_inode_validate_cowextsize(struct xfs_mount *mp,
>  		uint32_t cowextsize, uint16_t mode, uint16_t flags,
>  		uint64_t flags2);
> +xfs_failaddr_t xfs_inode_validate_forcealign(struct xfs_mount *mp,
> +		uint32_t extsize, uint32_t cowextsize, uint16_t mode,
> +		uint16_t flags, uint64_t flags2);
>  
>  static inline uint64_t xfs_inode_encode_bigtime(struct timespec64 tv)
>  {
> diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
> index 032333289113..b264939d8855 100644
> --- a/fs/xfs/libxfs/xfs_inode_util.c
> +++ b/fs/xfs/libxfs/xfs_inode_util.c
> @@ -80,6 +80,8 @@ xfs_flags2diflags2(
>  		di_flags2 |= XFS_DIFLAG2_DAX;
>  	if (xflags & FS_XFLAG_COWEXTSIZE)
>  		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
> +	if (xflags & FS_XFLAG_FORCEALIGN)
> +		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
>  
>  	return di_flags2;
>  }
> @@ -126,6 +128,8 @@ xfs_ip2xflags(
>  			flags |= FS_XFLAG_DAX;
>  		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
>  			flags |= FS_XFLAG_COWEXTSIZE;
> +		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
> +			flags |= FS_XFLAG_FORCEALIGN;
>  	}
>  
>  	if (xfs_inode_has_attr_fork(ip))
> @@ -224,6 +228,8 @@ xfs_inode_inherit_flags2(
>  	}
>  	if (pip->i_diflags2 & XFS_DIFLAG2_DAX)
>  		ip->i_diflags2 |= XFS_DIFLAG2_DAX;
> +	if (pip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
> +		ip->i_diflags2 |= XFS_DIFLAG2_FORCEALIGN;
>  
>  	/* Don't let invalid cowextsize hints propagate. */
>  	failaddr = xfs_inode_validate_cowextsize(ip->i_mount, ip->i_cowextsize,
> @@ -232,6 +238,14 @@ xfs_inode_inherit_flags2(
>  		ip->i_diflags2 &= ~XFS_DIFLAG2_COWEXTSIZE;
>  		ip->i_cowextsize = 0;
>  	}
> +	if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN) {
> +		failaddr = xfs_inode_validate_forcealign(ip->i_mount,
> +				ip->i_extsize, ip->i_cowextsize,
> +				VFS_I(ip)->i_mode, ip->i_diflags,
> +				ip->i_diflags2);
> +		if (failaddr)
> +			ip->i_diflags2 &= ~XFS_DIFLAG2_FORCEALIGN;
> +	}
>  }
>  
>  /*
> diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
> index 6b56f0f6d4c1..e56911553edd 100644
> --- a/fs/xfs/libxfs/xfs_sb.c
> +++ b/fs/xfs/libxfs/xfs_sb.c
> @@ -164,6 +164,8 @@ xfs_sb_version_to_features(
>  		features |= XFS_FEAT_REFLINK;
>  	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
>  		features |= XFS_FEAT_INOBTCNT;
> +	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
> +		features |= XFS_FEAT_FORCEALIGN;
>  	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
>  		features |= XFS_FEAT_FTYPE;
>  	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index bf0f4f8b9e64..3e7664ec4d6c 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -312,7 +312,13 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
>  
>  static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
>  {
> -	return false;
> +	if (!(ip->i_diflags & XFS_DIFLAG_EXTSIZE))
> +		return false;
> +	if (ip->i_extsize <= 1)
> +		return false;
> +	if (xfs_is_cow_inode(ip))
> +		return false;
> +	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
>  }
>  
>  /*
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 4e933db75b12..7a6757a4d2bd 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -469,6 +469,39 @@ xfs_fileattr_get(
>  	return 0;
>  }
>  
> +/*
> + * Forcealign requires a non-zero extent size hint and a zero cow
> + * extent size hint.
> + */
> +static int
> +xfs_ioctl_setattr_forcealign(
> +	struct xfs_inode	*ip,
> +	struct fileattr		*fa)
> +{
> +	struct xfs_mount	*mp = ip->i_mount;
> +
> +	if (!xfs_has_forcealign(mp))
> +		return -EINVAL;
> +
> +	if (xfs_is_reflink_inode(ip))
> +		return -EINVAL;
> +
> +	if (!(fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
> +				FS_XFLAG_EXTSZINHERIT)))
> +		return -EINVAL;
> +
> +	if (fa->fsx_xflags & FS_XFLAG_COWEXTSIZE)
> +		return -EINVAL;
> +
> +	if (!fa->fsx_extsize)
> +		return -EINVAL;
> +
> +	if (fa->fsx_cowextsize)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int
>  xfs_ioctl_setattr_xflags(
>  	struct xfs_trans	*tp,
> @@ -477,10 +510,13 @@ xfs_ioctl_setattr_xflags(
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
>  	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
> +	bool			forcealign = fa->fsx_xflags & FS_XFLAG_FORCEALIGN;
>  	uint64_t		i_flags2;
> +	int			error;
>  
> -	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
> -		/* Can't change realtime flag if any extents are allocated. */
> +	/* Can't change RT or forcealign flags if any extents are allocated. */
> +	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
> +	    forcealign != xfs_inode_has_forcealign(ip)) {
>  		if (ip->i_df.if_nextents || ip->i_delayed_blks)
>  			return -EINVAL;
>  	}
> @@ -501,6 +537,12 @@ xfs_ioctl_setattr_xflags(
>  	if (i_flags2 && !xfs_has_v3inodes(mp))
>  		return -EINVAL;
>  
> +	if (forcealign) {
> +		error = xfs_ioctl_setattr_forcealign(ip, fa);
> +		if (error)
> +			return error;
> +	}
> +
>  	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
>  	ip->i_diflags2 = i_flags2;
>  
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index d0567dfbc036..30228fea908d 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -299,6 +299,7 @@ typedef struct xfs_mount {
>  #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
>  #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
>  #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
> +#define XFS_FEAT_FORCEALIGN	(1ULL << 28)	/* aligned file data extents */
>  
>  /* Mount features */
>  #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
> @@ -385,6 +386,7 @@ __XFS_ADD_V4_FEAT(projid32, PROJID32)
>  __XFS_HAS_V4_FEAT(v3inodes, V3INODES)
>  __XFS_HAS_V4_FEAT(crc, CRC)
>  __XFS_HAS_V4_FEAT(pquotino, PQUOTINO)
> +__XFS_HAS_FEAT(forcealign, FORCEALIGN)
>  
>  /*
>   * Mount features
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 6fde6ec8092f..a836bfec7878 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1467,8 +1467,9 @@ xfs_reflink_remap_prep(
>  
>  	/* Check file eligibility and prepare for block sharing. */
>  	ret = -EINVAL;
> -	/* Don't reflink realtime inodes */
> -	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
> +	/* Don't reflink realtime or forcealign inodes */
> +	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest) ||
> +	    xfs_inode_has_forcealign(src) || xfs_inode_has_forcealign(dest))
>  		goto out_unlock;
>  
>  	/* Don't share DAX file data with non-DAX file. */
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 27e9f749c4c7..b52a01b50387 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1729,12 +1729,30 @@ xfs_fs_fill_super(
>  			goto out_filestream_unmount;
>  		}
>  
> +		if (xfs_has_forcealign(mp)) {
> +			xfs_alert(mp,
> +	"reflink not compatible with forcealign!");
> +			error = -EINVAL;
> +			goto out_filestream_unmount;
> +		}
> +
>  		if (xfs_globals.always_cow) {
>  			xfs_info(mp, "using DEBUG-only always_cow mode.");
>  			mp->m_always_cow = true;
>  		}
>  	}
>  
> +	if (xfs_has_forcealign(mp)) {
> +		if (xfs_has_realtime(mp)) {
> +			xfs_alert(mp,
> +		"forcealign not supported for realtime device!");
> +			error = -EINVAL;
> +			goto out_filestream_unmount;
> +		}
> +		xfs_warn(mp,
> +"EXPERIMENTAL forced data extent alignment feature in use. Use at your own risk!");
> +	}
> +
>  	if (xfs_has_rmapbt(mp) && mp->m_sb.sb_rblocks) {
>  		xfs_alert(mp,
>  	"reverse mapping btree not compatible with realtime device!");
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 753971770733..f55d650f904a 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -158,6 +158,8 @@ struct fsxattr {
>  #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
>  #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
>  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
> +/* data extent mappings for regular files must be aligned to extent size hint */
> +#define FS_XFLAG_FORCEALIGN	0x00020000
>  #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
>  
>  /* the read-only stuff doesn't really belong here, but any other place is
> -- 
> 2.31.1
> 
> 

