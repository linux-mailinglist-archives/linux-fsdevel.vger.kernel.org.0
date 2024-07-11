Return-Path: <linux-fsdevel+bounces-23536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5D592DEAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 05:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A7B282590
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 03:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F70812E63;
	Thu, 11 Jul 2024 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrZH12qj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E38F72;
	Thu, 11 Jul 2024 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720666800; cv=none; b=By9iebPUUaeoPooq+iZoKDWlkxFl7GR0CnvOZJwIThPN++Tw8ay/3a2ldb4MW7DWlUZ0V+0EAsQby/Mcm4tDHMaUTK/XBXiVVFJC6itBHV0Tfqt9whv8RMlns13EN4YCcJJw7jzfEq8ZubNpdlTZyxoN6F4BnDAk8SYoWkuKdwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720666800; c=relaxed/simple;
	bh=7yV6ztomz0VjM21DjSjPupJHoekXhSUsxyQissouC8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIL/OcQ5cRPeLz71ub4oexlj/qhpWYZM9+GyJj3+gFRNa8giTng/AFipjL4Lc+Cn11bD8qSmoaEGBL3RCw5d8GPACJ2/MJceyGbPPD7cl8Q+snJDomjRoddu3AFzdtNh53Vuexk4cuB88Pp4BA91KaXfr9E1SswNBNyVzry2gtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrZH12qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648ABC32782;
	Thu, 11 Jul 2024 02:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720666799;
	bh=7yV6ztomz0VjM21DjSjPupJHoekXhSUsxyQissouC8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrZH12qj8RK98aIbXKNd1JxzAGmhyee9Z4m00yyKcjvoXB8iSlO/nNwBLS8YQStx6
	 +MivF5dojseL+q8KHAQlrxlSBBVwpgJ8RVjV57y83cpbi7yhVdQKfpqC9VgMDnGh7V
	 vrS5gYMVTh0jWtgS2ARPrPSdsNr2mChI7f7AkDzUnfX70hOUSyZoZY4/kq54gzWE1u
	 hLjUu2ydYgX9KZ7BnQ3IMvh/CZ4mqmVpoC5Nex1Qno9nrJGQe10NKlL/SUNq4GMEnM
	 1GwEdje9w62uFyyysrF36gkJo/2ak9FuHEvdoXnptxp8FjuC/n1zsX0lxgR3dvhl4e
	 iyDXIaDOkPolQ==
Date: Wed, 10 Jul 2024 19:59:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
Message-ID: <20240711025958.GJ612460@frogsfrogsfrogs>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-8-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705162450.3481169-8-john.g.garry@oracle.com>

On Fri, Jul 05, 2024 at 04:24:44PM +0000, John Garry wrote:
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
> Currently RT is not be supported for forcealign, so reject a mount under
> that condition. In future, it should be possible to support forcealign for
> RT. In this case, the extent size hint will need to be aligned with
> rtextsize, so add inode verification for that now.
> 
> reflink link will not be supported for forcealign. This is because we have
> the limitation of pageache writeback not knowing how to writeback an
> entire allocation unut, so reject a mount with relink.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Co-developed-by: John Garry <john.g.garry@oracle.com>
> [jpg: many changes from orig, including forcealign inode verification
>  rework, disallow RT and forcealign mount, ioctl setattr rework,
>  disallow reflink a forcealign inode]
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_format.h    |  6 +++-
>  fs/xfs/libxfs/xfs_inode_buf.c | 55 +++++++++++++++++++++++++++++++++++
>  fs/xfs/libxfs/xfs_inode_buf.h |  3 ++
>  fs/xfs/libxfs/xfs_sb.c        |  2 ++
>  fs/xfs/xfs_inode.c            | 13 +++++++++
>  fs/xfs/xfs_inode.h            | 20 ++++++++++++-
>  fs/xfs/xfs_ioctl.c            | 51 ++++++++++++++++++++++++++++++--
>  fs/xfs/xfs_mount.h            |  2 ++
>  fs/xfs/xfs_reflink.c          |  5 ++--
>  fs/xfs/xfs_reflink.h          | 10 -------
>  fs/xfs/xfs_super.c            | 11 +++++++
>  include/uapi/linux/fs.h       |  2 ++
>  12 files changed, 164 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> index 61f51becff4f..b48cd75d34a6 100644
> --- a/fs/xfs/libxfs/xfs_format.h
> +++ b/fs/xfs/libxfs/xfs_format.h
> @@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
>  #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
>  #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>  #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
> +#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
>  #define XFS_SB_FEAT_RO_COMPAT_ALL \
>  		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
>  		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
> @@ -1094,16 +1095,19 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
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
> index 513b50da6215..5c61a1d1bb2b 100644
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
> @@ -824,3 +833,49 @@ xfs_inode_validate_cowextsize(
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
> +	bool			rt =  flags & XFS_DIFLAG_REALTIME;
> +
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
> +	/* Reflink'ed disallowed */
> +	if (flags2 & XFS_DIFLAG2_REFLINK)
> +		return __this_address;

Hmm.  If we don't support reflink + forcealign ATM, then shouldn't the
superblock verifier or xfs_fs_fill_super fail the mount so that old
kernels won't abruptly emit EFSCORRUPTED errors if a future kernel adds
support for forcealign'd cow and starts writing out files with both
iflags set?

That said, if the bs>ps patchset lands, then I think forcealign cow is
a simple matter of setting the min folio order to the forcealign size
and making sure that we always write out entire folios if any of the
blocks cached by the folio is shared.  Direct writes to forcealigned
shared files probably has to be aligned to the forcealign size or fall
back to buffered writes for cow.

--D

> +
> +	/* COW extsize disallowed */
> +	if (flags2 & XFS_DIFLAG2_COWEXTSIZE)
> +		return __this_address;
> +
> +	if (cowextsize)
> +		return __this_address;
> +
> +	/* extsize must be a multiple of sb_rextsize for RT */
> +	if (rt && mp->m_sb.sb_rextsize && extsize % mp->m_sb.sb_rextsize)
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
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index a4e3cd8971fc..caffd4c75179 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -609,6 +609,8 @@ xfs_ip2xflags(
>  			flags |= FS_XFLAG_DAX;
>  		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
>  			flags |= FS_XFLAG_COWEXTSIZE;
> +		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
> +			flags |= FS_XFLAG_FORCEALIGN;
>  	}
>  
>  	if (xfs_inode_has_attr_fork(ip))
> @@ -738,6 +740,8 @@ xfs_inode_inherit_flags2(
>  	}
>  	if (pip->i_diflags2 & XFS_DIFLAG2_DAX)
>  		ip->i_diflags2 |= XFS_DIFLAG2_DAX;
> +	if (pip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
> +		ip->i_diflags2 |= XFS_DIFLAG2_FORCEALIGN;
>  
>  	/* Don't let invalid cowextsize hints propagate. */
>  	failaddr = xfs_inode_validate_cowextsize(ip->i_mount, ip->i_cowextsize,
> @@ -746,6 +750,15 @@ xfs_inode_inherit_flags2(
>  		ip->i_diflags2 &= ~XFS_DIFLAG2_COWEXTSIZE;
>  		ip->i_cowextsize = 0;
>  	}
> +
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
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 42f999c1106c..536e646dd055 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -301,6 +301,16 @@ static inline bool xfs_inode_has_cow_data(struct xfs_inode *ip)
>  	return ip->i_cowfp && ip->i_cowfp->if_bytes;
>  }
>  
> +static inline bool xfs_is_always_cow_inode(struct xfs_inode *ip)
> +{
> +	return ip->i_mount->m_always_cow && xfs_has_reflink(ip->i_mount);
> +}
> +
> +static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
> +{
> +	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
> +}
> +
>  static inline bool xfs_inode_has_bigtime(struct xfs_inode *ip)
>  {
>  	return ip->i_diflags2 & XFS_DIFLAG2_BIGTIME;
> @@ -313,7 +323,15 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
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
> +	if (ip->i_diflags & XFS_DIFLAG_REALTIME)
> +		return false;
> +	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
>  }
>  
>  /*
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index f0117188f302..771ef3954f4e 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -525,10 +525,48 @@ xfs_flags2diflags2(
>  		di_flags2 |= XFS_DIFLAG2_DAX;
>  	if (xflags & FS_XFLAG_COWEXTSIZE)
>  		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
> +	if (xflags & FS_XFLAG_FORCEALIGN)
> +		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
>  
>  	return di_flags2;
>  }
>  
> +/*
> + * Forcealign requires a non-zero extent size hint and a zero cow
> + * extent size hint.  Don't allow set for RT files yet.
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
> +	if (fa->fsx_xflags & FS_XFLAG_REALTIME)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int
>  xfs_ioctl_setattr_xflags(
>  	struct xfs_trans	*tp,
> @@ -537,10 +575,13 @@ xfs_ioctl_setattr_xflags(
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
> @@ -561,6 +602,12 @@ xfs_ioctl_setattr_xflags(
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
> index 265a2a418bc7..8da293e8bfa2 100644
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
> diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
> index 65c5dfe17ecf..fb55e4ce49fa 100644
> --- a/fs/xfs/xfs_reflink.h
> +++ b/fs/xfs/xfs_reflink.h
> @@ -6,16 +6,6 @@
>  #ifndef __XFS_REFLINK_H
>  #define __XFS_REFLINK_H 1
>  
> -static inline bool xfs_is_always_cow_inode(struct xfs_inode *ip)
> -{
> -	return ip->i_mount->m_always_cow && xfs_has_reflink(ip->i_mount);
> -}
> -
> -static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
> -{
> -	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
> -}
> -
>  extern int xfs_reflink_trim_around_shared(struct xfs_inode *ip,
>  		struct xfs_bmbt_irec *irec, bool *shared);
>  int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 27e9f749c4c7..4f0c77f38de1 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1721,6 +1721,17 @@ xfs_fs_fill_super(
>  		mp->m_features &= ~XFS_FEAT_DISCARD;
>  	}
>  
> +	if (xfs_has_forcealign(mp)) {
> +		if (xfs_has_realtime(mp)) {
> +			xfs_alert(mp,
> +	"forcealign not compatible with realtime device!");
> +			error = -EINVAL;
> +			goto out_filestream_unmount;
> +		}
> +		xfs_warn(mp,
> +"EXPERIMENTAL forced data extent alignment feature in use. Use at your own risk!");
> +	}
> +
>  	if (xfs_has_reflink(mp)) {
>  		if (mp->m_sb.sb_rblocks) {
>  			xfs_alert(mp,
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 45e4e64fd664..8af304c0e29a 100644
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

