Return-Path: <linux-fsdevel+bounces-26506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A437E95A385
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2E81F22625
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2956F1B252D;
	Wed, 21 Aug 2024 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLSK+wUk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72313E022;
	Wed, 21 Aug 2024 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260055; cv=none; b=b5lS+/lHrjqsgHx1v3hqcvQiVnW4iOiokGDh5xYvAGXQ23BFFhMPIoc9hxTk07qVNPpyMEd4zlj11FEywL85bMol4Usr9KbQH79QV8CHnG4n0YE5xFsGsW+SumGKERRa2qlYf0DG4CuIjwULMejQELukP2ejaYBtb0xOHfGce3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260055; c=relaxed/simple;
	bh=X/FMGS6nNVkr3M3pYfKLWM17aTsCYXsmDksgz5f3XuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQeGBQGah5tyxAVnv3AH4OzbeaVSsi8Ie/sAJr8wIK6nBgLqUQKp/hKNbma518X88xY9nAZw9y5U+Rvezm4X5ShNaosclT56GjH75Zo+EQKEQkbkX8Hs98s2YBgFRHOOluXM5Znz7xYdNT4mDIPoRZv1ZvPeTdDmzA2qFLfjjVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLSK+wUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1BDC32781;
	Wed, 21 Aug 2024 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724260055;
	bh=X/FMGS6nNVkr3M3pYfKLWM17aTsCYXsmDksgz5f3XuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLSK+wUkm5n616pqcCxUSGMp6A66Ggsm8ifOOu+lqqg/MeclUTge25abqieRl1vHu
	 4AdGLQX5YBjCKBC3jGD2viFU0AugnN1JPxMYw4P1I1HimjYRejYLL1aosAQkDUhfVf
	 C6c/JQVnoWsjpZISFnnWwpS8P6P7Elrk6KI7w9kYS/1Xn9tnOHekAsq2zNYl7PH8Sr
	 jA4BNe84b0vNFOvjpSWG1BmgEwyTXW2n8A4kylHKG2nf4NaV3rGusUu0qB6itKNCQV
	 QxpGIU+uf62zz/TiNuenEnChl3P3aRt9x4Q56P5I04KEmZJ1bGVX65vwbmbLk9NqRo
	 2UKl4ejchMqHw==
Date: Wed, 21 Aug 2024 10:07:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, chandan.babu@oracle.com, dchinner@redhat.com,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	kbusch@kernel.org
Subject: Re: [PATCH v5 4/7] xfs: Support FS_XFLAG_ATOMICWRITES for forcealign
Message-ID: <20240821170734.GJ865349@frogsfrogsfrogs>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817094800.776408-5-john.g.garry@oracle.com>

On Sat, Aug 17, 2024 at 09:47:57AM +0000, John Garry wrote:
> Add initial support for new flag FS_XFLAG_ATOMICWRITES for forcealign
> enabled.
> 
> This flag is a file attribute that mirrors an ondisk inode flag.  Actual
> support for untorn file writes (for now) depends on both the iflag and the
> underlying storage devices, which we can only really check at statx and
> pwritev2() time.  This is the same story as FS_XFLAG_DAX, which signals to
> the fs that we should try to enable the fsdax IO path on the file (instead
> of the regular page cache), but applications have to query STAT_ATTR_DAX to
> find out if they really got that IO path.
> 
> Current kernel support for atomic writes is based on HW support (for atomic
> writes). As such, it is required to ensure extent alignment with
> atomic_write_unit_max so that an atomic write can result in a single
> HW-compliant IO operation.
> 
> rtvol also guarantees extent alignment, but we are basing support initially
> on forcealign, which is not supported for rtvol yet.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_format.h     | 11 +++++--
>  fs/xfs/libxfs/xfs_inode_buf.c  | 52 ++++++++++++++++++++++++++++++++++
>  fs/xfs/libxfs/xfs_inode_util.c |  4 +++
>  fs/xfs/libxfs/xfs_sb.c         |  2 ++
>  fs/xfs/xfs_buf.c               | 15 +++++++++-
>  fs/xfs/xfs_buf.h               |  4 ++-
>  fs/xfs/xfs_buf_mem.c           |  2 +-
>  fs/xfs/xfs_inode.h             |  5 ++++
>  fs/xfs/xfs_ioctl.c             | 52 ++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_mount.h             |  2 ++
>  fs/xfs/xfs_super.c             | 12 ++++++++
>  include/uapi/linux/fs.h        |  1 +
>  12 files changed, 157 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> index 04c6cbc943c2..a9f3389438a6 100644
> --- a/fs/xfs/libxfs/xfs_format.h
> +++ b/fs/xfs/libxfs/xfs_format.h
> @@ -353,12 +353,16 @@ xfs_sb_has_compat_feature(
>  #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>  #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
>  #define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
> +#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 31)	/* atomicwrites enabled */

Do you ever see test failures in xfs/270?

> +
>  #define XFS_SB_FEAT_RO_COMPAT_ALL \
>  		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
>  		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
>  		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
>  		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
> -		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
> +		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN | \
> +		 XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
> +
>  #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
>  static inline bool
>  xfs_sb_has_ro_compat_feature(
> @@ -1097,6 +1101,7 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
>  #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
>  /* data extent mappings for regular files must be aligned to extent size hint */
>  #define XFS_DIFLAG2_FORCEALIGN_BIT 5
> +#define XFS_DIFLAG2_ATOMICWRITES_BIT 6
>  
>  #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
>  #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
> @@ -1104,10 +1109,12 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
>  #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
>  #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
>  #define XFS_DIFLAG2_FORCEALIGN	(1 << XFS_DIFLAG2_FORCEALIGN_BIT)
> +#define XFS_DIFLAG2_ATOMICWRITES	(1 << XFS_DIFLAG2_ATOMICWRITES_BIT)
>  
>  #define XFS_DIFLAG2_ANY \
>  	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
> -	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN)
> +	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_FORCEALIGN | \
> +	 XFS_DIFLAG2_ATOMICWRITES)
>  
>  static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
>  {
> diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
> index 1c59891fa9e2..59933c7df56d 100644
> --- a/fs/xfs/libxfs/xfs_inode_buf.c
> +++ b/fs/xfs/libxfs/xfs_inode_buf.c
> @@ -178,7 +178,10 @@ xfs_inode_from_disk(
>  	struct xfs_inode	*ip,
>  	struct xfs_dinode	*from)
>  {
> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>  	struct inode		*inode = VFS_I(ip);
> +	struct xfs_mount	*mp = ip->i_mount;
> +	struct xfs_sb		*sbp = &mp->m_sb;
>  	int			error;
>  	xfs_failaddr_t		fa;
>  
> @@ -261,6 +264,13 @@ xfs_inode_from_disk(
>  	}
>  	if (xfs_is_reflink_inode(ip))
>  		xfs_ifork_init_cow(ip);
> +
> +	if (xfs_inode_has_atomicwrites(ip)) {
> +		if (sbp->sb_blocksize < target->bt_bdev_awu_min ||
> +		    sbp->sb_blocksize * ip->i_extsize > target->bt_bdev_awu_max)

Can this multiplication trigger integer overflows?

> +			ip->i_diflags2 &= ~XFS_DIFLAG2_ATOMICWRITES;

Ondisk iflag updates must use transactions.

Or you can fail IOCB_ATOMIC writes if XFS_DIFLAG2_ATOMICWRITES is set
but the forcealign blocksize doesn't fit with awu_min/max.

> +	}
> +
>  	return 0;
>  
>  out_destroy_data_fork:
> @@ -483,6 +493,40 @@ xfs_dinode_verify_nrext64(
>  	return NULL;
>  }
>  
> +static xfs_failaddr_t
> +xfs_inode_validate_atomicwrites(
> +	struct xfs_mount	*mp,
> +	uint32_t		extsize,
> +	uint64_t		flags2)
> +{
> +	/* superblock rocompat feature flag */
> +	if (!xfs_has_atomicwrites(mp))
> +		return __this_address;
> +
> +	/*
> +	 * forcealign is required, so rely on sanity checks in
> +	 * xfs_inode_validate_forcealign()
> +	 */
> +	if (!(flags2 & XFS_DIFLAG2_FORCEALIGN))
> +		return __this_address;
> +
> +	if (!is_power_of_2(extsize))
> +		return __this_address;
> +
> +	/* Required to guarantee data block alignment */
> +	if (mp->m_sb.sb_agblocks % extsize)
> +		return __this_address;
> +
> +	/* Requires stripe unit+width be a multiple of extsize */
> +	if (mp->m_dalign && (mp->m_dalign % extsize))
> +		return __this_address;
> +
> +	if (mp->m_swidth && (mp->m_swidth % extsize))

IIRC m_dalign and m_swidth can be set at mount time, which can result in
inode verifiers logging corruption errors if those parameters change.  I
think we should validate these two congruencies when setting
FMODE_CAN_ATOMIC_WRITE.

> +		return __this_address;
> +
> +	return NULL;
> +}
> +
>  xfs_failaddr_t
>  xfs_dinode_verify(
>  	struct xfs_mount	*mp,
> @@ -666,6 +710,14 @@ xfs_dinode_verify(
>  			return fa;
>  	}
>  
> +	if (flags2 & XFS_DIFLAG2_ATOMICWRITES) {
> +		fa = xfs_inode_validate_atomicwrites(mp,
> +				be32_to_cpu(dip->di_extsize),
> +				flags2);
> +		if (fa)
> +			return fa;
> +	}
> +
>  	return NULL;
>  }
>  
> diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
> index b264939d8855..dbd5b16e1844 100644
> --- a/fs/xfs/libxfs/xfs_inode_util.c
> +++ b/fs/xfs/libxfs/xfs_inode_util.c
> @@ -82,6 +82,8 @@ xfs_flags2diflags2(
>  		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
>  	if (xflags & FS_XFLAG_FORCEALIGN)
>  		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
> +	if (xflags & FS_XFLAG_ATOMICWRITES)
> +		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
>  
>  	return di_flags2;
>  }
> @@ -130,6 +132,8 @@ xfs_ip2xflags(
>  			flags |= FS_XFLAG_COWEXTSIZE;
>  		if (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)
>  			flags |= FS_XFLAG_FORCEALIGN;
> +		if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
> +			flags |= FS_XFLAG_ATOMICWRITES;
>  	}
>  
>  	if (xfs_inode_has_attr_fork(ip))
> diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
> index e56911553edd..5de8725bf93a 100644
> --- a/fs/xfs/libxfs/xfs_sb.c
> +++ b/fs/xfs/libxfs/xfs_sb.c
> @@ -166,6 +166,8 @@ xfs_sb_version_to_features(
>  		features |= XFS_FEAT_INOBTCNT;
>  	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
>  		features |= XFS_FEAT_FORCEALIGN;
> +	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
> +		features |= XFS_FEAT_ATOMICWRITES;
>  	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
>  		features |= XFS_FEAT_FTYPE;
>  	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index aa4dbda7b536..44bee3e2b2bb 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -2060,6 +2060,8 @@ int
>  xfs_init_buftarg(
>  	struct xfs_buftarg		*btp,
>  	size_t				logical_sectorsize,
> +	unsigned int			awu_min,
> +	unsigned int			awu_max,
>  	const char			*descr)
>  {
>  	/* Set up device logical sector size mask */
> @@ -2086,6 +2088,9 @@ xfs_init_buftarg(
>  	btp->bt_shrinker->scan_objects = xfs_buftarg_shrink_scan;
>  	btp->bt_shrinker->private_data = btp;
>  	shrinker_register(btp->bt_shrinker);
> +
> +	btp->bt_bdev_awu_min = awu_min;
> +	btp->bt_bdev_awu_max = awu_max;
>  	return 0;
>  
>  out_destroy_io_count:
> @@ -2102,6 +2107,7 @@ xfs_alloc_buftarg(
>  {
>  	struct xfs_buftarg	*btp;
>  	const struct dax_holder_operations *ops = NULL;
> +	unsigned int awu_min = 0, awu_max = 0;
>  
>  #if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
>  	ops = &xfs_dax_holder_operations;
> @@ -2115,6 +2121,13 @@ xfs_alloc_buftarg(
>  	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
>  					    mp, ops);
>  
> +	if (bdev_can_atomic_write(btp->bt_bdev)) {
> +		struct request_queue *q = bdev_get_queue(btp->bt_bdev);
> +
> +		awu_min = queue_atomic_write_unit_min_bytes(q);
> +		awu_max = queue_atomic_write_unit_max_bytes(q);
> +	}
> +
>  	/*
>  	 * When allocating the buftargs we have not yet read the super block and
>  	 * thus don't know the file system sector size yet.
> @@ -2122,7 +2135,7 @@ xfs_alloc_buftarg(
>  	if (xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev)))
>  		goto error_free;
>  	if (xfs_init_buftarg(btp, bdev_logical_block_size(btp->bt_bdev),
> -			mp->m_super->s_id))
> +			awu_min, awu_max, mp->m_super->s_id))
>  		goto error_free;
>  
>  	return btp;
> diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
> index b1580644501f..3bcd8137d739 100644
> --- a/fs/xfs/xfs_buf.h
> +++ b/fs/xfs/xfs_buf.h
> @@ -124,6 +124,8 @@ struct xfs_buftarg {
>  	struct percpu_counter	bt_io_count;
>  	struct ratelimit_state	bt_ioerror_rl;
>  
> +	unsigned int		bt_bdev_awu_min, bt_bdev_awu_max;

Please add a comment here about what these mean.  Not everyone is going
to know what "awu" abbreviates.

> +
>  	/* built-in cache, if we're not using the perag one */
>  	struct xfs_buf_cache	bt_cache[];
>  };
> @@ -393,7 +395,7 @@ bool xfs_verify_magic16(struct xfs_buf *bp, __be16 dmagic);
>  
>  /* for xfs_buf_mem.c only: */
>  int xfs_init_buftarg(struct xfs_buftarg *btp, size_t logical_sectorsize,
> -		const char *descr);
> +		unsigned int awu_min, unsigned int awu_max, const char *descr);
>  void xfs_destroy_buftarg(struct xfs_buftarg *btp);
>  
>  #endif	/* __XFS_BUF_H__ */
> diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
> index 9bb2d24de709..af48a8da2f0f 100644
> --- a/fs/xfs/xfs_buf_mem.c
> +++ b/fs/xfs/xfs_buf_mem.c
> @@ -93,7 +93,7 @@ xmbuf_alloc(
>  	btp->bt_meta_sectorsize = XMBUF_BLOCKSIZE;
>  	btp->bt_meta_sectormask = XMBUF_BLOCKSIZE - 1;
>  
> -	error = xfs_init_buftarg(btp, XMBUF_BLOCKSIZE, descr);
> +	error = xfs_init_buftarg(btp, XMBUF_BLOCKSIZE, 0, 0, descr);
>  	if (error)
>  		goto out_bcache;
>  
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 336124105c47..cfcb67da12cb 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -321,6 +321,11 @@ static inline bool xfs_inode_has_forcealign(struct xfs_inode *ip)
>  	return ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN;
>  }
>  
> +static inline bool xfs_inode_has_atomicwrites(struct xfs_inode *ip)
> +{
> +	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
> +}
> +
>  /*
>   * Decide if this file is a realtime file whose data allocation unit is larger
>   * than a single filesystem block.
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index a68ec68e5b92..7af2837779e8 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -502,6 +502,49 @@ xfs_ioctl_setattr_forcealign(
>  	return 0;
>  }
>  
> +
> +/*
> + * Forcealign requires a power-of-2 extent size hint.
> + */
> +static int
> +xfs_ioctl_setattr_atomicwrites(
> +	struct xfs_inode	*ip,
> +	struct fileattr		*fa)
> +{
> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +	struct xfs_mount	*mp = ip->i_mount;
> +	uint32_t		extsize = XFS_B_TO_FSB(mp, fa->fsx_extsize);
> +	struct xfs_sb		*sbp = &mp->m_sb;
> +
> +	if (!xfs_has_atomicwrites(mp))
> +		return -EINVAL;
> +
> +	if (!(fa->fsx_xflags & FS_XFLAG_FORCEALIGN))
> +		return -EINVAL;
> +
> +	if (!is_power_of_2(extsize))
> +		return -EINVAL;
> +
> +	/* Required to guarantee data block alignment */
> +	if (mp->m_sb.sb_agblocks % extsize)
> +		return -EINVAL;
> +
> +	/* Requires stripe unit+width be a multiple of extsize */
> +	if (mp->m_dalign && (mp->m_dalign % extsize))
> +		return -EINVAL;
> +
> +	if (mp->m_swidth && (mp->m_swidth % extsize))
> +		return -EINVAL;
> +
> +	if (target->bt_bdev_awu_min > sbp->sb_blocksize)
> +		return -EINVAL;
> +
> +	if (target->bt_bdev_awu_max < fa->fsx_extsize)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int
>  xfs_ioctl_setattr_xflags(
>  	struct xfs_trans	*tp,
> @@ -511,9 +554,12 @@ xfs_ioctl_setattr_xflags(
>  	struct xfs_mount	*mp = ip->i_mount;
>  	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
>  	bool			forcealign = fa->fsx_xflags & FS_XFLAG_FORCEALIGN;
> +	bool			atomic_writes;
>  	uint64_t		i_flags2;
>  	int			error;
>  
> +	atomic_writes = fa->fsx_xflags & FS_XFLAG_ATOMICWRITES;
> +
>  	/* Can't change RT or forcealign flags if any extents are allocated. */
>  	if (rtflag != XFS_IS_REALTIME_INODE(ip) ||
>  	    forcealign != xfs_inode_has_forcealign(ip)) {
> @@ -554,6 +600,12 @@ xfs_ioctl_setattr_xflags(
>  			return error;
>  	}
>  
> +	if (atomic_writes) {
> +		error = xfs_ioctl_setattr_atomicwrites(ip, fa);
> +		if (error)
> +			return error;
> +	}
> +
>  	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
>  	ip->i_diflags2 = i_flags2;
>  
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index 30228fea908d..0c5a3ae3cdaf 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -300,6 +300,7 @@ typedef struct xfs_mount {
>  #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
>  #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
>  #define XFS_FEAT_FORCEALIGN	(1ULL << 28)	/* aligned file data extents */
> +#define XFS_FEAT_ATOMICWRITES	(1ULL << 29)	/* atomic writes support */
>  
>  /* Mount features */
>  #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
> @@ -387,6 +388,7 @@ __XFS_HAS_V4_FEAT(v3inodes, V3INODES)
>  __XFS_HAS_V4_FEAT(crc, CRC)
>  __XFS_HAS_V4_FEAT(pquotino, PQUOTINO)
>  __XFS_HAS_FEAT(forcealign, FORCEALIGN)
> +__XFS_HAS_FEAT(atomicwrites, ATOMICWRITES)
>  
>  /*
>   * Mount features
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index b52a01b50387..5352b90b2bb6 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1721,6 +1721,18 @@ xfs_fs_fill_super(
>  		mp->m_features &= ~XFS_FEAT_DISCARD;
>  	}
>  
> +	if (xfs_has_atomicwrites(mp)) {
> +		if (!xfs_has_forcealign(mp)) {
> +			xfs_alert(mp,
> +	"forcealign required for atomicwrites!");

This (atomicwrites && !forcealign) ought to be checked in the superblock
verifier.

--D

> +			error = -EINVAL;
> +			goto out_filestream_unmount;
> +		}
> +
> +		xfs_warn(mp,
> +"EXPERIMENTAL atomicwrites feature in use. Use at your own risk!");
> +	}
> +
>  	if (xfs_has_reflink(mp)) {
>  		if (mp->m_sb.sb_rblocks) {
>  			xfs_alert(mp,
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index f55d650f904a..c416f549e94d 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -160,6 +160,7 @@ struct fsxattr {
>  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
>  /* data extent mappings for regular files must be aligned to extent size hint */
>  #define FS_XFLAG_FORCEALIGN	0x00020000
> +#define FS_XFLAG_ATOMICWRITES	0x00040000	/* atomic writes enabled */
>  #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
>  
>  /* the read-only stuff doesn't really belong here, but any other place is
> -- 
> 2.31.1
> 
> 

