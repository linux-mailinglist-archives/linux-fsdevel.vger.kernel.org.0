Return-Path: <linux-fsdevel+bounces-30392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E598AA2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 18:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B306EB276D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAA4198E71;
	Mon, 30 Sep 2024 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShtfjIX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF30198A11;
	Mon, 30 Sep 2024 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714643; cv=none; b=MNdODqIlNIz/W54vZtR1V6pRVe7dBrPN1s3rbNgJS4zjFt5i3LsMuOzMqckP8Zu9T12p4pz3wBx9IHPKeUuCqU8KEqDpkYC/UreCMuPIOCyh0avhXNmLBtB56JTxgN0HpkpN98OA7aQn6yAWv9V0nbDiYsO2hzI91jAv2SrjFy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714643; c=relaxed/simple;
	bh=bFXOXQ1TF7W0CQeTukrsGmu7OTPgBwCEu49cEtiIzuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPr7hWQOtIAec2CQsxJ/Eqjk79FtuViMM8tT4rHXC+oQ7cglfXfT1Xkl9IN3NNYteURXHOQ2C1Jgc5rMt907zlBAYeZfvvYp0fKgfonYtwe8qzV0EXCNpQK9gQYKY0Bm6JHI7W/ZqdzCwyAIm4AewwlGwqwyG/c5SNAea5RFI/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShtfjIX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ECBC4CEC7;
	Mon, 30 Sep 2024 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727714643;
	bh=bFXOXQ1TF7W0CQeTukrsGmu7OTPgBwCEu49cEtiIzuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShtfjIX7l1uh+/QvyhlbC3tMk6FinTDkPO2GtiGYYADQeGtWN1Ovupmd4+UM8V+3i
	 xlzH8zCaEIxoIav4SU6VNUXJP87djn9RHAKOVL5nveNFq7h1whXGdcViSVw8s5NmVI
	 23OLr495q9oRLX9ZodmR/m0CR32D91TRhNW2c5+FndZ7rYoIztE3Av+9hGJuc4gZe4
	 FIKXjzBAJP28oAdi8krf1wDGE8EffkAw1pLOewkXMJilRO1CPfD9+wdmcE2rGbuxeD
	 +FnekWotSEb2urbIEOUgIQqnqGXr/VSTSo2PonTcSb891WN4CQKmgcUIOy74awhBOX
	 zEXi0/+k81NHQ==
Date: Mon, 30 Sep 2024 09:44:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, martin.petersen@oracle.com,
	catherine.hoang@oracle.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v6 4/7] xfs: Support FS_XFLAG_ATOMICWRITES
Message-ID: <20240930164402.GR21853@frogsfrogsfrogs>
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-5-john.g.garry@oracle.com>
 <20240930160349.GN21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930160349.GN21853@frogsfrogsfrogs>

On Mon, Sep 30, 2024 at 09:03:49AM -0700, Darrick J. Wong wrote:
> On Mon, Sep 30, 2024 at 12:54:35PM +0000, John Garry wrote:
> > Add initial support for new flag FS_XFLAG_ATOMICWRITES.
> > 
> > This flag is a file attribute that mirrors an ondisk inode flag.  Actual
> > support for untorn file writes (for now) depends on both the iflag and the
> > underlying storage devices, which we can only really check at statx and
> > pwritev2() time.  This is the same story as FS_XFLAG_DAX, which signals to
> > the fs that we should try to enable the fsdax IO path on the file (instead
> > of the regular page cache), but applications have to query STAT_ATTR_DAX to
> > find out if they really got that IO path.
> > 
> > Current kernel support for atomic writes is based on HW support (for atomic
> > writes). Since for regular files XFS has no way to specify extent alignment
> > or granularity, atomic write size is limited to the FS block size.
> > 
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  fs/xfs/libxfs/xfs_format.h     | 11 ++++++++--
> >  fs/xfs/libxfs/xfs_inode_buf.c  | 38 ++++++++++++++++++++++++++++++++++
> >  fs/xfs/libxfs/xfs_inode_util.c |  6 ++++++
> >  fs/xfs/libxfs/xfs_sb.c         |  2 ++
> >  fs/xfs/xfs_buf.c               | 15 +++++++++++++-
> >  fs/xfs/xfs_buf.h               |  5 ++++-
> >  fs/xfs/xfs_buf_mem.c           |  2 +-
> >  fs/xfs/xfs_inode.h             |  5 +++++
> >  fs/xfs/xfs_ioctl.c             | 37 +++++++++++++++++++++++++++++++++
> >  fs/xfs/xfs_mount.h             |  2 ++
> >  fs/xfs/xfs_reflink.c           |  4 ++++
> >  fs/xfs/xfs_super.c             |  4 ++++
> >  include/uapi/linux/fs.h        |  1 +
> >  13 files changed, 127 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> > index e1bfee0c3b1a..ed5e5442f0d4 100644
> > --- a/fs/xfs/libxfs/xfs_format.h
> > +++ b/fs/xfs/libxfs/xfs_format.h
> > @@ -352,11 +352,15 @@ xfs_sb_has_compat_feature(
> >  #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
> >  #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
> >  #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
> > +#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 31)	/* atomicwrites enabled */
> > +
> >  #define XFS_SB_FEAT_RO_COMPAT_ALL \
> >  		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
> >  		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
> >  		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
> > -		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
> > +		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
> > +		 XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
> > +
> >  #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
> >  static inline bool
> >  xfs_sb_has_ro_compat_feature(
> > @@ -1093,16 +1097,19 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
> >  #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
> >  #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
> >  #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
> > +#define XFS_DIFLAG2_ATOMICWRITES_BIT 5	/* atomic writes permitted */
> >  
> >  #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
> >  #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
> >  #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
> >  #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
> >  #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
> > +#define XFS_DIFLAG2_ATOMICWRITES	(1 << XFS_DIFLAG2_ATOMICWRITES_BIT)
> >  
> >  #define XFS_DIFLAG2_ANY \
> >  	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
> > -	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
> > +	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | \
> > +	 XFS_DIFLAG2_ATOMICWRITES)
> >  
> >  static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
> >  {
> > diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
> > index 79babeac9d75..1e852cdd1d6f 100644
> > --- a/fs/xfs/libxfs/xfs_inode_buf.c
> > +++ b/fs/xfs/libxfs/xfs_inode_buf.c
> > @@ -483,6 +483,36 @@ xfs_dinode_verify_nrext64(
> >  	return NULL;
> >  }
> >  
> > +static xfs_failaddr_t
> > +xfs_inode_validate_atomicwrites(
> > +	struct xfs_mount	*mp,
> > +	uint32_t		cowextsize,
> > +	uint16_t		mode,
> > +	int64_t			flags2)
> > +{
> > +	/* superblock rocompat feature flag */
> > +	if (!xfs_has_atomicwrites(mp))
> > +		return __this_address;
> > +
> > +	/* Only regular files and directories */
> > +	if (!S_ISREG(mode) && !(S_ISDIR(mode)))
> > +		return __this_address;
> > +
> > +	/* COW extsize disallowed */
> > +	if (flags2 & XFS_DIFLAG2_COWEXTSIZE)
> > +		return __this_address;
> > +
> > +	/* cowextsize must be zero */
> > +	if (cowextsize)
> > +		return __this_address;
> > +
> > +	/* reflink is disallowed */
> > +	if (flags2 & XFS_DIFLAG2_REFLINK)
> > +		return __this_address;
> 
> If we're only allowing atomic writes that are 1 fsblock or less, then
> copy on write will work correctly because CoWs are always done with
> fsblock granularity.  The ioend remap is also committed atomically.
> 
> IOWs, it's forcealign that isn't compatible with reflink and you can
> drop this incompatibility.

Also, why do you need to check cowextsize?  I thought cowextsize==0 is a
requirement of forcealign (because everything is keyed off extsize) and
is not something that atomicwrites itself requires?

Same applies to xfs_ioctl_setattr_atomicwrites.

--D

> > +
> > +	return NULL;
> > +}
> > +
> >  xfs_failaddr_t
> >  xfs_dinode_verify(
> >  	struct xfs_mount	*mp,
> > @@ -663,6 +693,14 @@ xfs_dinode_verify(
> >  	    !xfs_has_bigtime(mp))
> >  		return __this_address;
> >  
> > +	if (flags2 & XFS_DIFLAG2_ATOMICWRITES) {
> > +		fa = xfs_inode_validate_atomicwrites(mp,
> > +				be32_to_cpu(dip->di_cowextsize),
> 
> Technically speaking, the space used by di_cowextsize isn't defined on
> !reflink filesystems.  The contents are supposed to be zero, but nobody
> actually checks that, so you might want to special case this:
> 
> 		fa = xfs_inode_validate_atomicwrites(mp,
> 				xfs_has_reflink(mp) ?
> 					be32_to_cpu(dip->di_cowextsize) : 0,
> 				mode, flags2);
> 
> (inasmuch as this code is getting ugly and maybe you want to use a
> temporary variable)
> 
> > +				mode, flags2);
> > +		if (fa)
> > +			return fa;
> > +	}
> > +
> >  	return NULL;
> >  }
> >  
> > diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
> > index cc38e1c3c3e1..e59e98783bf7 100644
> > --- a/fs/xfs/libxfs/xfs_inode_util.c
> > +++ b/fs/xfs/libxfs/xfs_inode_util.c
> > @@ -80,6 +80,8 @@ xfs_flags2diflags2(
> >  		di_flags2 |= XFS_DIFLAG2_DAX;
> >  	if (xflags & FS_XFLAG_COWEXTSIZE)
> >  		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
> > +	if (xflags & FS_XFLAG_ATOMICWRITES)
> > +		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
> >  
> >  	return di_flags2;
> >  }
> > @@ -126,6 +128,8 @@ xfs_ip2xflags(
> >  			flags |= FS_XFLAG_DAX;
> >  		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
> >  			flags |= FS_XFLAG_COWEXTSIZE;
> > +		if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
> > +			flags |= FS_XFLAG_ATOMICWRITES;
> >  	}
> >  
> >  	if (xfs_inode_has_attr_fork(ip))
> > @@ -224,6 +228,8 @@ xfs_inode_inherit_flags2(
> >  	}
> >  	if (pip->i_diflags2 & XFS_DIFLAG2_DAX)
> >  		ip->i_diflags2 |= XFS_DIFLAG2_DAX;
> > +	if (pip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
> > +		ip->i_diflags2 |= XFS_DIFLAG2_ATOMICWRITES;
> >  
> >  	/* Don't let invalid cowextsize hints propagate. */
> >  	failaddr = xfs_inode_validate_cowextsize(ip->i_mount, ip->i_cowextsize,
> > diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
> > index d95409f3cba6..dd819561d0a5 100644
> > --- a/fs/xfs/libxfs/xfs_sb.c
> > +++ b/fs/xfs/libxfs/xfs_sb.c
> > @@ -164,6 +164,8 @@ xfs_sb_version_to_features(
> >  		features |= XFS_FEAT_REFLINK;
> >  	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
> >  		features |= XFS_FEAT_INOBTCNT;
> > +	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
> > +		features |= XFS_FEAT_ATOMICWRITES;
> >  	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
> >  		features |= XFS_FEAT_FTYPE;
> >  	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
> > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > index aa4dbda7b536..44bee3e2b2bb 100644
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -2060,6 +2060,8 @@ int
> >  xfs_init_buftarg(
> >  	struct xfs_buftarg		*btp,
> >  	size_t				logical_sectorsize,
> > +	unsigned int			awu_min,
> > +	unsigned int			awu_max,
> >  	const char			*descr)
> >  {
> >  	/* Set up device logical sector size mask */
> > @@ -2086,6 +2088,9 @@ xfs_init_buftarg(
> >  	btp->bt_shrinker->scan_objects = xfs_buftarg_shrink_scan;
> >  	btp->bt_shrinker->private_data = btp;
> >  	shrinker_register(btp->bt_shrinker);
> > +
> > +	btp->bt_bdev_awu_min = awu_min;
> > +	btp->bt_bdev_awu_max = awu_max;
> >  	return 0;
> >  
> >  out_destroy_io_count:
> > @@ -2102,6 +2107,7 @@ xfs_alloc_buftarg(
> >  {
> >  	struct xfs_buftarg	*btp;
> >  	const struct dax_holder_operations *ops = NULL;
> > +	unsigned int awu_min = 0, awu_max = 0;
> >  
> >  #if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
> >  	ops = &xfs_dax_holder_operations;
> > @@ -2115,6 +2121,13 @@ xfs_alloc_buftarg(
> >  	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
> >  					    mp, ops);
> >  
> > +	if (bdev_can_atomic_write(btp->bt_bdev)) {
> > +		struct request_queue *q = bdev_get_queue(btp->bt_bdev);
> > +
> > +		awu_min = queue_atomic_write_unit_min_bytes(q);
> > +		awu_max = queue_atomic_write_unit_max_bytes(q);
> > +	}
> > +
> >  	/*
> >  	 * When allocating the buftargs we have not yet read the super block and
> >  	 * thus don't know the file system sector size yet.
> > @@ -2122,7 +2135,7 @@ xfs_alloc_buftarg(
> >  	if (xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev)))
> >  		goto error_free;
> >  	if (xfs_init_buftarg(btp, bdev_logical_block_size(btp->bt_bdev),
> > -			mp->m_super->s_id))
> > +			awu_min, awu_max, mp->m_super->s_id))
> >  		goto error_free;
> 
> Rather than passing this into the constructor and making the xmbuf code
> pass zeroes, why not set the awu values here in xfs_alloc_buftarg just
> before returning btp?
> 
> 	if (bdev_can_atomic_write(btp->bt_bdev)) {
> 		struct request_queue *q = bdev_get_queue(btp->bt_bdev);
> 
> 		btp->bt_bdev_awu_min = queue_atomic_write_unit_min_bytes(q);
> 		btp->bt_bdev_awu_max = queue_atomic_write_unit_max_bytes(q);
> 	}
> 
> 
> --D
> 
> >  	return btp;
> > diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
> > index 209a389f2abc..b813cb60a8f3 100644
> > --- a/fs/xfs/xfs_buf.h
> > +++ b/fs/xfs/xfs_buf.h
> > @@ -124,6 +124,9 @@ struct xfs_buftarg {
> >  	struct percpu_counter	bt_io_count;
> >  	struct ratelimit_state	bt_ioerror_rl;
> >  
> > +	/* Atomic write unit values */
> > +	unsigned int		bt_bdev_awu_min, bt_bdev_awu_max;
> > +
> >  	/* built-in cache, if we're not using the perag one */
> >  	struct xfs_buf_cache	bt_cache[];
> >  };
> > @@ -393,7 +396,7 @@ bool xfs_verify_magic16(struct xfs_buf *bp, __be16 dmagic);
> >  
> >  /* for xfs_buf_mem.c only: */
> >  int xfs_init_buftarg(struct xfs_buftarg *btp, size_t logical_sectorsize,
> > -		const char *descr);
> > +		unsigned int awu_min, unsigned int awu_max, const char *descr);
> >  void xfs_destroy_buftarg(struct xfs_buftarg *btp);
> >  
> >  #endif	/* __XFS_BUF_H__ */
> > diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
> > index 07bebbfb16ee..722d75f89767 100644
> > --- a/fs/xfs/xfs_buf_mem.c
> > +++ b/fs/xfs/xfs_buf_mem.c
> > @@ -93,7 +93,7 @@ xmbuf_alloc(
> >  	btp->bt_meta_sectorsize = XMBUF_BLOCKSIZE;
> >  	btp->bt_meta_sectormask = XMBUF_BLOCKSIZE - 1;
> >  
> > -	error = xfs_init_buftarg(btp, XMBUF_BLOCKSIZE, descr);
> > +	error = xfs_init_buftarg(btp, XMBUF_BLOCKSIZE, 0, 0, descr);
> >  	if (error)
> >  		goto out_bcache;
> >  
> > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > index 97ed912306fd..1c62ee294a5a 100644
> > --- a/fs/xfs/xfs_inode.h
> > +++ b/fs/xfs/xfs_inode.h
> > @@ -327,6 +327,11 @@ static inline bool xfs_inode_has_bigrtalloc(struct xfs_inode *ip)
> >  	(XFS_IS_REALTIME_INODE(ip) ? \
> >  		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
> >  
> > +static inline bool xfs_inode_has_atomicwrites(struct xfs_inode *ip)
> > +{
> > +	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
> > +}
> > +
> >  /*
> >   * In-core inode flags.
> >   */
> > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > index a20d426ef021..81872c32dcb2 100644
> > --- a/fs/xfs/xfs_ioctl.c
> > +++ b/fs/xfs/xfs_ioctl.c
> > @@ -469,6 +469,36 @@ xfs_fileattr_get(
> >  	return 0;
> >  }
> >  
> > +static int
> > +xfs_ioctl_setattr_atomicwrites(
> > +	struct xfs_inode	*ip,
> > +	struct fileattr		*fa)
> > +{
> > +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> > +	struct xfs_mount	*mp = ip->i_mount;
> > +	struct xfs_sb		*sbp = &mp->m_sb;
> > +
> > +	if (!xfs_has_atomicwrites(mp))
> > +		return -EINVAL;
> > +
> > +	if (target->bt_bdev_awu_min > sbp->sb_blocksize)
> > +		return -EINVAL;
> > +
> > +	if (target->bt_bdev_awu_max < sbp->sb_blocksize)
> > +		return -EINVAL;
> > +
> > +	if (xfs_is_reflink_inode(ip))
> > +		return -EINVAL;
> > +
> > +	if (fa->fsx_xflags & FS_XFLAG_COWEXTSIZE)
> > +		return -EINVAL;
> > +
> > +	if (fa->fsx_cowextsize)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> >  static int
> >  xfs_ioctl_setattr_xflags(
> >  	struct xfs_trans	*tp,
> > @@ -478,6 +508,7 @@ xfs_ioctl_setattr_xflags(
> >  	struct xfs_mount	*mp = ip->i_mount;
> >  	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
> >  	uint64_t		i_flags2;
> > +	int			error;
> >  
> >  	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
> >  		/* Can't change realtime flag if any extents are allocated. */
> > @@ -512,6 +543,12 @@ xfs_ioctl_setattr_xflags(
> >  	if (i_flags2 && !xfs_has_v3inodes(mp))
> >  		return -EINVAL;
> >  
> > +	if (fa->fsx_xflags & FS_XFLAG_ATOMICWRITES) {
> > +		error = xfs_ioctl_setattr_atomicwrites(ip, fa);
> > +		if (error)
> > +			return error;
> > +	}
> > +
> >  	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
> >  	ip->i_diflags2 = i_flags2;
> >  
> > diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> > index 96496f39f551..6ac6518a2ef3 100644
> > --- a/fs/xfs/xfs_mount.h
> > +++ b/fs/xfs/xfs_mount.h
> > @@ -298,6 +298,7 @@ typedef struct xfs_mount {
> >  #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
> >  #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
> >  #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
> > +#define XFS_FEAT_ATOMICWRITES	(1ULL << 28)	/* atomic writes support */
> >  
> >  /* Mount features */
> >  #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
> > @@ -384,6 +385,7 @@ __XFS_ADD_V4_FEAT(projid32, PROJID32)
> >  __XFS_HAS_V4_FEAT(v3inodes, V3INODES)
> >  __XFS_HAS_V4_FEAT(crc, CRC)
> >  __XFS_HAS_V4_FEAT(pquotino, PQUOTINO)
> > +__XFS_HAS_FEAT(atomicwrites, ATOMICWRITES)
> >  
> >  /*
> >   * Mount features
> > diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> > index 6fde6ec8092f..6679b12a56c9 100644
> > --- a/fs/xfs/xfs_reflink.c
> > +++ b/fs/xfs/xfs_reflink.c
> > @@ -1471,6 +1471,10 @@ xfs_reflink_remap_prep(
> >  	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
> >  		goto out_unlock;
> >  
> > +	/* Don't reflink atomic write inodes */
> > +	if (xfs_inode_has_atomicwrites(src) || xfs_inode_has_atomicwrites(dest))
> > +		goto out_unlock;
> > +
> >  	/* Don't share DAX file data with non-DAX file. */
> >  	if (IS_DAX(inode_in) != IS_DAX(inode_out))
> >  		goto out_unlock;
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index fbb3a1594c0d..97c1d9493cdb 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -1733,6 +1733,10 @@ xfs_fs_fill_super(
> >  		mp->m_features &= ~XFS_FEAT_DISCARD;
> >  	}
> >  
> > +	if (xfs_has_atomicwrites(mp))
> > +		xfs_warn(mp,
> > +	"EXPERIMENTAL atomicwrites feature in use. Use at your own risk!");
> > +
> >  	if (xfs_has_reflink(mp)) {
> >  		if (mp->m_sb.sb_rblocks) {
> >  			xfs_alert(mp,
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 753971770733..e813217e0fe4 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -158,6 +158,7 @@ struct fsxattr {
> >  #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
> >  #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
> >  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
> > +#define FS_XFLAG_ATOMICWRITES	0x00020000	/* atomic writes enabled */
> >  #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
> >  
> >  /* the read-only stuff doesn't really belong here, but any other place is
> > -- 
> > 2.31.1
> > 
> > 
> 

