Return-Path: <linux-fsdevel+bounces-10062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B448476AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D04D1F297C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D056214AD34;
	Fri,  2 Feb 2024 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ40Wdul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339745FDD3;
	Fri,  2 Feb 2024 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896346; cv=none; b=PqB4NYthybuui40yawjkOi+cUaFQcXNGz8b70tFKLEArb/515aj3Buv4xIlVzVs61UNSuHiIHt/VWN8+FlxSqJ+iyMidpGGz1qRz0ZKUNcm+YYwiiWWfCXk8+GtAZVAVV47J//Ta0n22FRpF0wEWrndqMKk/NFsWQPBUEjuz66M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896346; c=relaxed/simple;
	bh=R6VBE6d+9PGFhuWM+57QO56VT6fb44s1bWN7QDL/4Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIVmkhnS5wtw7/9wMaucGn1hbXagruy3zfRIfF5VVpalJh1gyITHN7XReXYd7swtTf0TLOjG/zSTKUhn0t0nSqOGCDpiD97gCVzykm1sK400bZS1FOdNavE9wEQz1nFa8Mi/VJl9/SGdAQb5uzZvdsOkZ2wFtCinIlOBGse6DtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ40Wdul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DFCC433F1;
	Fri,  2 Feb 2024 17:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706896345;
	bh=R6VBE6d+9PGFhuWM+57QO56VT6fb44s1bWN7QDL/4Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZ40WdulE1qTAxwOMB/HztxeLEXHvRwuU3kKLoQgZEJv2Tce38kfjJf/b57GQzoTd
	 DoL5MTeN28C/7RVedERsc/fyH7qoPG5kbhgJqC2oRIkgJCcCD9iDbgSXLHsa1REPIt
	 kmGHzWeJCauLH7Fk7V/balUQkVhoN8jfZqPeYXEvgF6J0LOXJvYYP/MHJvurcD/fI4
	 ghVqYGofOOFyqX5lQw8avCWWVkgCSPzVHLEpvua9r2eKg54Xdy2136wWuY5umsAe4g
	 VpSGz7+yfyH+8h9NfZGcVjkXMwbeXIE+uv0P4r/DL/T6JoToJ6yQN1vH832r3pDsqX
	 NHZf/vVXTZCPw==
Date: Fri, 2 Feb 2024 09:52:25 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH 3/6] fs: xfs: Support FS_XFLAG_ATOMICWRITES for rtvol
Message-ID: <20240202175225.GH6184@frogsfrogsfrogs>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124142645.9334-4-john.g.garry@oracle.com>

On Wed, Jan 24, 2024 at 02:26:42PM +0000, John Garry wrote:
> Add initial support for FS_XFLAG_ATOMICWRITES in rtvol.
> 
> Current kernel support for atomic writes is based on HW support (for atomic
> writes). As such, it is required to ensure extent alignment with
> atomic_write_unit_max so that an atomic write can result in a single
> HW-compliant IO operation.
> 
> rtvol already guarantees extent alignment, so initially add support there.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_format.h |  8 ++++++--
>  fs/xfs/libxfs/xfs_sb.c     |  2 ++
>  fs/xfs/xfs_inode.c         | 22 ++++++++++++++++++++++
>  fs/xfs/xfs_inode.h         |  7 +++++++
>  fs/xfs/xfs_ioctl.c         | 19 +++++++++++++++++--
>  fs/xfs/xfs_mount.h         |  2 ++
>  fs/xfs/xfs_super.c         |  4 ++++
>  7 files changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> index 382ab1e71c0b..79fb0d4adeda 100644
> --- a/fs/xfs/libxfs/xfs_format.h
> +++ b/fs/xfs/libxfs/xfs_format.h
> @@ -353,11 +353,13 @@ xfs_sb_has_compat_feature(
>  #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
>  #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>  #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
> +#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 29)	/* aligned file data extents */

I thought FORCEALIGN was going to signal aligned file data extent
allocations being mandatory?

This flag (AFAICT) simply marks the inode as something that gets
FMODE_CAN_ATOMIC_WRITES, right?

>  #define XFS_SB_FEAT_RO_COMPAT_ALL \
>  		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
>  		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
>  		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
> -		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
> +		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
> +		 XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
>  #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
>  static inline bool
>  xfs_sb_has_ro_compat_feature(
> @@ -1085,16 +1087,18 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
>  #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
>  #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
>  #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
> +#define XFS_DIFLAG2_ATOMICWRITES_BIT 6

Needs a comment here ("files flagged for atomic writes").  Also not sure
why you skipped bit 5, though I'm guessing it's because the forcealign
series is/was using it?

>  #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
>  #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
>  #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
>  #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
>  #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
> +#define XFS_DIFLAG2_ATOMICWRITES	(1 << XFS_DIFLAG2_ATOMICWRITES_BIT)
>  
>  #define XFS_DIFLAG2_ANY \
>  	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
> -	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
> +	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_ATOMICWRITES)
>  
>  static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
>  {
> diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
> index 4a9e8588f4c9..28a98130a56d 100644
> --- a/fs/xfs/libxfs/xfs_sb.c
> +++ b/fs/xfs/libxfs/xfs_sb.c
> @@ -163,6 +163,8 @@ xfs_sb_version_to_features(
>  		features |= XFS_FEAT_REFLINK;
>  	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
>  		features |= XFS_FEAT_INOBTCNT;
> +	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
> +		features |= XFS_FEAT_ATOMICWRITES;
>  	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
>  		features |= XFS_FEAT_FTYPE;
>  	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 1fd94958aa97..0b0f525fd043 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -65,6 +65,26 @@ xfs_get_extsz_hint(
>  	return 0;
>  }
>  
> +/*
> + * helper function to extract extent size

How does that differ from xfs_get_extsz_hint?

> + */
> +xfs_extlen_t
> +xfs_get_extsz(
> +	struct xfs_inode	*ip)
> +{
> +	/*
> +	 * No point in aligning allocations if we need to COW to actually
> +	 * write to them.

What does alwayscow have to do with untorn writes?

> +	 */
> +	if (xfs_is_always_cow_inode(ip))
> +		return 0;
> +
> +	if (XFS_IS_REALTIME_INODE(ip))
> +		return ip->i_mount->m_sb.sb_rextsize;
> +
> +	return 1;
> +}

Does this function exist to return the allocation unit for a given file?
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=djwong-wtf&id=b8ddcef3df8da02ed2c4aacbed1d811e60372006

> +
>  /*
>   * Helper function to extract CoW extent size hint from inode.
>   * Between the extent size hint and the CoW extent size hint, we
> @@ -629,6 +649,8 @@ xfs_ip2xflags(
>  			flags |= FS_XFLAG_DAX;
>  		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
>  			flags |= FS_XFLAG_COWEXTSIZE;
> +		if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
> +			flags |= FS_XFLAG_ATOMICWRITES;
>  	}
>  
>  	if (xfs_inode_has_attr_fork(ip))
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 97f63bacd4c2..0e0a21d9d30f 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -305,6 +305,11 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
>  	return ip->i_diflags2 & XFS_DIFLAG2_NREXT64;
>  }
>  
> +static inline bool xfs_inode_atomicwrites(struct xfs_inode *ip)

I think this predicate wants a verb in its name, the rest of them have
"is" or "has" somewhere:

"xfs_inode_has_atomicwrites"

> +{
> +	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
> +}
> +
>  /*
>   * Return the buftarg used for data allocations on a given inode.
>   */
> @@ -542,7 +547,9 @@ void		xfs_lock_two_inodes(struct xfs_inode *ip0, uint ip0_mode,
>  				struct xfs_inode *ip1, uint ip1_mode);
>  
>  xfs_extlen_t	xfs_get_extsz_hint(struct xfs_inode *ip);
> +xfs_extlen_t	xfs_get_extsz(struct xfs_inode *ip);
>  xfs_extlen_t	xfs_get_cowextsz_hint(struct xfs_inode *ip);
> +xfs_extlen_t	xfs_get_atomicwrites_size(struct xfs_inode *ip);
>  
>  int xfs_init_new_inode(struct mnt_idmap *idmap, struct xfs_trans *tp,
>  		struct xfs_inode *pip, xfs_ino_t ino, umode_t mode,
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index f02b6e558af5..c380a3055be7 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1110,6 +1110,8 @@ xfs_flags2diflags2(
>  		di_flags2 |= XFS_DIFLAG2_DAX;
>  	if (xflags & FS_XFLAG_COWEXTSIZE)
>  		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
> +	if (xflags & FS_XFLAG_ATOMICWRITES)
> +		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
>  
>  	return di_flags2;
>  }
> @@ -1122,10 +1124,12 @@ xfs_ioctl_setattr_xflags(
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
>  	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
> +	bool			atomic_writes = fa->fsx_xflags & FS_XFLAG_ATOMICWRITES;
>  	uint64_t		i_flags2;
>  
> -	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
> -		/* Can't change realtime flag if any extents are allocated. */

Please augment this comment ("Can't change realtime or atomicwrites
flags if any extents are allocated") instead of deleting it.  This is
validation code, the requirements should be spelled out in English.

> +
> +	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
> +	    atomic_writes != xfs_inode_atomicwrites(ip)) {
>  		if (ip->i_df.if_nextents || ip->i_delayed_blks)
>  			return -EINVAL;
>  	}
> @@ -1146,6 +1150,17 @@ xfs_ioctl_setattr_xflags(
>  	if (i_flags2 && !xfs_has_v3inodes(mp))
>  		return -EINVAL;
>  
> +	if (atomic_writes) {
> +		if (!xfs_has_atomicwrites(mp))
> +			return -EINVAL;
> +
> +		if (!rtflag)
> +			return -EINVAL;
> +
> +		if (!is_power_of_2(mp->m_sb.sb_rextsize))
> +			return -EINVAL;

Shouldn't we check sb_rextsize w.r.t. the actual block device queue
limits here?  I keep seeing similar validation logic open-coded
throughout both atomic write patchsets:

	if (l < queue_atomic_write_unit_min_bytes())
		/* fail */
	if (l > queue_atomic_write_unit_max_bytes())
		/* fail */
	if (!is_power_of_2(l))
		/* fail */
	/* ok */

which really should be a common helper somewhere.

		/*
		 * Don't set atomic write if the allocation unit doesn't
		 * align with the device requirements.
		 */
		if (!bdev_validate_atomic_write(<target blockdev>,
				XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize))
			return -EINVAL;

Too bad we have to figure out the target blockdev and file allocation
unit based on the ioctl in-params and can't use the xfs_inode helpers
here.

--D

> +	}
> +
>  	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
>  	ip->i_diflags2 = i_flags2;
>  
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index 503fe3c7edbf..bcd591f52925 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -289,6 +289,7 @@ typedef struct xfs_mount {
>  #define XFS_FEAT_BIGTIME	(1ULL << 24)	/* large timestamps */
>  #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
>  #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
> +#define XFS_FEAT_ATOMICWRITES	(1ULL << 28)	/* atomic writes support */
>  
>  /* Mount features */
>  #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
> @@ -352,6 +353,7 @@ __XFS_HAS_FEAT(inobtcounts, INOBTCNT)
>  __XFS_HAS_FEAT(bigtime, BIGTIME)
>  __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
>  __XFS_HAS_FEAT(large_extent_counts, NREXT64)
> +__XFS_HAS_FEAT(atomicwrites, ATOMICWRITES)
>  
>  /*
>   * Mount features
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index aff20ddd4a9f..263404f683d6 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1696,6 +1696,10 @@ xfs_fs_fill_super(
>  		mp->m_features &= ~XFS_FEAT_DISCARD;
>  	}
>  
> +	if (xfs_has_atomicwrites(mp))
> +		xfs_warn(mp,
> +"EXPERIMENTAL atomic writes feature in use. Use at your own risk!");
> +
>  	if (xfs_has_reflink(mp)) {
>  		if (mp->m_sb.sb_rblocks) {
>  			xfs_alert(mp,
> -- 
> 2.31.1
> 
> 

