Return-Path: <linux-fsdevel+bounces-27028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE39A95DDC6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 14:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390831F22356
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 12:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C0C1714B5;
	Sat, 24 Aug 2024 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ipq3b85N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA13BB21;
	Sat, 24 Aug 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724501500; cv=none; b=V/D4QCBTEKWg0cR5YPoj3/wHrUtJSMgdz1A1JRawHO5x3ZHBj5KKdt5P+ef+p3/K5ytsKUGcT2deeNkCbb4Jmw/RnUe0pzv5Vq5NADp5uoW++MKqMNoNy/zmSGh396PRWYYL4WKqeHM7uFIJwWo9JXXCuzTEQzkPPmAg9wDwr/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724501500; c=relaxed/simple;
	bh=j+VnjK7W6lkoY9jr4afU1sih/2G3OR63Lz7c72wIDX4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qqm19TRPki6d3JbC16GElDBF6I24qkP3s75jrLKZkU0UrL3BkwZi1v6+aaL3OAUKkOdTdSE2yIrYDP41d1Zkzeu5GwQ/4c42zrE0YYO0or9my5NeNrfnfHzeYAxA+exyx5naFJ+a/YObRs6/t9rkm0Z/p6XyR2uo8ah9vyPzQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ipq3b85N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837BDC32781;
	Sat, 24 Aug 2024 12:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724501500;
	bh=j+VnjK7W6lkoY9jr4afU1sih/2G3OR63Lz7c72wIDX4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ipq3b85NzDydxnG2HqNLlZqYy/alOF5gbsiFyOQszf0+tMgcbYOMEdeSo5BVGaLRW
	 HZQGxdC+0dtV2VVWAN87TKb2LjV5NKdAsjMcsiQL86jnqK6dfDV/SZRprT92A/BTmD
	 jiwOWF6GSVCoetqvY2/HlqEvkXjWhlD0Bg0Ou8u+ZgbPHh9L+JizoUQ+gxQxFw0zUe
	 HgDOpYr9n4w7y/lHFK4BzpPtjmmCuY4GhfiN5dMZ31qeQmVNYspzBdWah62W7Cmxts
	 uP9SsH7X6gchkFt0TCvwJyo0YwroBDI9AE6zZ2PsyflRaRLudrNMTOm57Tm7Cev4UC
	 gGQtUglxSG3Uw==
Message-ID: <9517bd6324bd0125d2b1b38cc0d5dbfe06fc34dd.camel@kernel.org>
Subject: Re: [PATCH v31.0.1 1/1] xfs: introduce new file range commit ioctls
From: Jeff Layton <jlayton@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Sat, 24 Aug 2024 08:11:38 -0400
In-Reply-To: <20240824062927.GU865349@frogsfrogsfrogs>
References: <172437084258.57211.13522832162579952916.stgit@frogsfrogsfrogs>
	 <172437084278.57211.4355071581143024290.stgit@frogsfrogsfrogs>
	 <20240824062927.GU865349@frogsfrogsfrogs>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-23 at 23:29 -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
>=20
> This patch introduces two more new ioctls to manage atomic updates to
> file contents -- XFS_IOC_START_COMMIT and XFS_IOC_COMMIT_RANGE.  The
> commit mechanism here is exactly the same as what XFS_IOC_EXCHANGE_RANGE
> does, but with the additional requirement that file2 cannot have changed
> since some sampling point.  The start-commit ioctl performs the sampling
> of file attributes.
>=20
> Note: This patch currently samples i_ctime during START_COMMIT and
> checks that it hasn't changed during COMMIT_RANGE.  This isn't entirely
> safe in kernels prior to 6.12 because ctime only had coarse grained
> granularity and very fast updates could collide with a COMMIT_RANGE.
> With the multi-granularity ctime introduced by Jeff Layton, it's now
> possible to update ctime such that this does not happen.
>=20
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_fs.h |   26 +++++++++
>  fs/xfs/xfs_exchrange.c |  143 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/xfs/xfs_exchrange.h |   16 +++++
>  fs/xfs/xfs_ioctl.c     |    4 +
>  fs/xfs/xfs_trace.h     |   57 +++++++++++++++++++
>  5 files changed, 243 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
> index 454b63ef72016..c85c8077fac39 100644
> --- a/fs/xfs/libxfs/xfs_fs.h
> +++ b/fs/xfs/libxfs/xfs_fs.h
> @@ -825,6 +825,30 @@ struct xfs_exchange_range {
>  	__u64		flags;		/* see XFS_EXCHANGE_RANGE_* below */
>  };
> =20
> +/*
> + * Using the same definition of file2 as struct xfs_exchange_range, comm=
it the
> + * contents of file1 into file2 if file2 has the same inode number, mtim=
e, and
> + * ctime as the arguments provided to the call.  The old contents of fil=
e2 will
> + * be moved to file1.
> + *
> + * Returns -EBUSY if there isn't an exact match for the file2 fields.
> + *
> + * Filesystems must be able to restart and complete the operation even a=
fter
> + * the system goes down.
> + */
> +struct xfs_commit_range {
> +	__s32		file1_fd;
> +	__u32		pad;		/* must be zeroes */
> +	__u64		file1_offset;	/* file1 offset, bytes */
> +	__u64		file2_offset;	/* file2 offset, bytes */
> +	__u64		length;		/* bytes to exchange */
> +
> +	__u64		flags;		/* see XFS_EXCHANGE_RANGE_* below */
> +
> +	/* opaque file2 metadata for freshness checks */
> +	__u64		file2_freshness[6];
> +};
> +
>  /*
>   * Exchange file data all the way to the ends of both files, and then ex=
change
>   * the file sizes.  This flag can be used to replace a file's contents w=
ith a
> @@ -997,6 +1021,8 @@ struct xfs_getparents_by_handle {
>  #define XFS_IOC_BULKSTAT	     _IOR ('X', 127, struct xfs_bulkstat_req)
>  #define XFS_IOC_INUMBERS	     _IOR ('X', 128, struct xfs_inumbers_req)
>  #define XFS_IOC_EXCHANGE_RANGE	     _IOW ('X', 129, struct xfs_exchange_=
range)
> +#define XFS_IOC_START_COMMIT	     _IOR ('X', 130, struct xfs_commit_rang=
e)
> +#define XFS_IOC_COMMIT_RANGE	     _IOW ('X', 131, struct xfs_commit_rang=
e)
>  /*	XFS_IOC_GETFSUUID ---------- deprecated 140	 */
> =20
> =20
> diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
> index c8a655c92c92f..d0889190ab7ff 100644
> --- a/fs/xfs/xfs_exchrange.c
> +++ b/fs/xfs/xfs_exchrange.c
> @@ -72,6 +72,34 @@ xfs_exchrange_estimate(
>  	return error;
>  }
> =20
> +/*
> + * Check that file2's metadata agree with the snapshot that we took for =
the
> + * range commit request.
> + *
> + * This should be called after the filesystem has locked /all/ inode met=
adata
> + * against modification.
> + */
> +STATIC int
> +xfs_exchrange_check_freshness(
> +	const struct xfs_exchrange	*fxr,
> +	struct xfs_inode		*ip2)
> +{
> +	struct inode			*inode2 =3D VFS_I(ip2);
> +	struct timespec64		ctime =3D inode_get_ctime(inode2);
> +	struct timespec64		mtime =3D inode_get_mtime(inode2);
> +
> +	trace_xfs_exchrange_freshness(fxr, ip2);
> +
> +	/* Check that file2 hasn't otherwise been modified. */
> +	if (fxr->file2_ino !=3D ip2->i_ino ||
> +	    fxr->file2_gen !=3D inode2->i_generation ||
> +	    !timespec64_equal(&fxr->file2_ctime, &ctime) ||
> +	    !timespec64_equal(&fxr->file2_mtime, &mtime))
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
>  #define QRETRY_IP1	(0x1)
>  #define QRETRY_IP2	(0x2)
> =20
> @@ -607,6 +635,12 @@ xfs_exchrange_prep(
>  	if (error || fxr->length =3D=3D 0)
>  		return error;
> =20
> +	if (fxr->flags & __XFS_EXCHANGE_RANGE_CHECK_FRESH2) {
> +		error =3D xfs_exchrange_check_freshness(fxr, ip2);
> +		if (error)
> +			return error;
> +	}
> +
>  	/* Attach dquots to both inodes before changing block maps. */
>  	error =3D xfs_qm_dqattach(ip2);
>  	if (error)
> @@ -719,7 +753,8 @@ xfs_exchange_range(
>  	if (fxr->file1->f_path.mnt !=3D fxr->file2->f_path.mnt)
>  		return -EXDEV;
> =20
> -	if (fxr->flags & ~XFS_EXCHANGE_RANGE_ALL_FLAGS)
> +	if (fxr->flags & ~(XFS_EXCHANGE_RANGE_ALL_FLAGS |
> +			 __XFS_EXCHANGE_RANGE_CHECK_FRESH2))
>  		return -EINVAL;
> =20
>  	/* Userspace requests only honored for regular files. */
> @@ -802,3 +837,109 @@ xfs_ioc_exchange_range(
>  	fdput(file1);
>  	return error;
>  }
> +
> +/* Opaque freshness blob for XFS_IOC_COMMIT_RANGE */
> +struct xfs_commit_range_fresh {
> +	xfs_fsid_t	fsid;		/* m_fixedfsid */
> +	__u64		file2_ino;	/* inode number */
> +	__s64		file2_mtime;	/* modification time */
> +	__s64		file2_ctime;	/* change time */
> +	__s32		file2_mtime_nsec; /* mod time, nsec */
> +	__s32		file2_ctime_nsec; /* change time, nsec */
> +	__u32		file2_gen;	/* inode generation */
> +	__u32		magic;		/* zero */
> +};
> +#define XCR_FRESH_MAGIC	0x444F524B	/* DORK */
> +
> +/* Set up a commitrange operation by sampling file2's write-related attr=
s */
> +long
> +xfs_ioc_start_commit(
> +	struct file			*file,
> +	struct xfs_commit_range __user	*argp)
> +{
> +	struct xfs_commit_range		args =3D { };
> +	struct timespec64		ts;
> +	struct xfs_commit_range_fresh	*kern_f;
> +	struct xfs_commit_range_fresh	__user *user_f;
> +	struct inode			*inode2 =3D file_inode(file);
> +	struct xfs_inode		*ip2 =3D XFS_I(inode2);
> +	const unsigned int		lockflags =3D XFS_IOLOCK_SHARED |
> +						    XFS_MMAPLOCK_SHARED |
> +						    XFS_ILOCK_SHARED;
> +
> +	BUILD_BUG_ON(sizeof(struct xfs_commit_range_fresh) !=3D
> +		     sizeof(args.file2_freshness));
> +
> +	kern_f =3D (struct xfs_commit_range_fresh *)&args.file2_freshness;
> +
> +	memcpy(&kern_f->fsid, ip2->i_mount->m_fixedfsid, sizeof(xfs_fsid_t));
> +
> +	xfs_ilock(ip2, lockflags);
> +	ts =3D inode_get_ctime(inode2);
> +	kern_f->file2_ctime		=3D ts.tv_sec;
> +	kern_f->file2_ctime_nsec	=3D ts.tv_nsec;
> +	ts =3D inode_get_mtime(inode2);
> +	kern_f->file2_mtime		=3D ts.tv_sec;
> +	kern_f->file2_mtime_nsec	=3D ts.tv_nsec;
> +	kern_f->file2_ino		=3D ip2->i_ino;
> +	kern_f->file2_gen		=3D inode2->i_generation;
> +	kern_f->magic			=3D XCR_FRESH_MAGIC;
> +	xfs_iunlock(ip2, lockflags);
> +
> +	user_f =3D (struct xfs_commit_range_fresh __user *)&argp->file2_freshne=
ss;
> +	if (copy_to_user(user_f, kern_f, sizeof(*kern_f)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +/*
> + * Exchange file1 and file2 contents if file2 has not been written since=
 the
> + * start commit operation.
> + */
> +long
> +xfs_ioc_commit_range(
> +	struct file			*file,
> +	struct xfs_commit_range __user	*argp)
> +{
> +	struct xfs_exchrange		fxr =3D {
> +		.file2			=3D file,
> +	};
> +	struct xfs_commit_range		args;
> +	struct xfs_commit_range_fresh	*kern_f;
> +	struct xfs_inode		*ip2 =3D XFS_I(file_inode(file));
> +	struct xfs_mount		*mp =3D ip2->i_mount;
> +	struct fd			file1;
> +	int				error;
> +
> +	kern_f =3D (struct xfs_commit_range_fresh *)&args.file2_freshness;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +	if (args.flags & ~XFS_EXCHANGE_RANGE_ALL_FLAGS)
> +		return -EINVAL;
> +	if (kern_f->magic !=3D XCR_FRESH_MAGIC)
> +		return -EBUSY;
> +	if (memcmp(&kern_f->fsid, mp->m_fixedfsid, sizeof(xfs_fsid_t)))
> +		return -EBUSY;
> +
> +	fxr.file1_offset	=3D args.file1_offset;
> +	fxr.file2_offset	=3D args.file2_offset;
> +	fxr.length		=3D args.length;
> +	fxr.flags		=3D args.flags | __XFS_EXCHANGE_RANGE_CHECK_FRESH2;
> +	fxr.file2_ino		=3D kern_f->file2_ino;
> +	fxr.file2_gen		=3D kern_f->file2_gen;
> +	fxr.file2_mtime.tv_sec	=3D kern_f->file2_mtime;
> +	fxr.file2_mtime.tv_nsec	=3D kern_f->file2_mtime_nsec;
> +	fxr.file2_ctime.tv_sec	=3D kern_f->file2_ctime;
> +	fxr.file2_ctime.tv_nsec	=3D kern_f->file2_ctime_nsec;
> +
> +	file1 =3D fdget(args.file1_fd);
> +	if (!file1.file)
> +		return -EBADF;
> +	fxr.file1 =3D file1.file;
> +
> +	error =3D xfs_exchange_range(&fxr);
> +	fdput(file1);
> +	return error;
> +}
> diff --git a/fs/xfs/xfs_exchrange.h b/fs/xfs/xfs_exchrange.h
> index 039abcca546e8..bc1298aba806b 100644
> --- a/fs/xfs/xfs_exchrange.h
> +++ b/fs/xfs/xfs_exchrange.h
> @@ -10,8 +10,12 @@
>  #define __XFS_EXCHANGE_RANGE_UPD_CMTIME1	(1ULL << 63)
>  #define __XFS_EXCHANGE_RANGE_UPD_CMTIME2	(1ULL << 62)
> =20
> +/* Freshness check required */
> +#define __XFS_EXCHANGE_RANGE_CHECK_FRESH2	(1ULL << 61)
> +
>  #define XFS_EXCHANGE_RANGE_PRIV_FLAGS	(__XFS_EXCHANGE_RANGE_UPD_CMTIME1 =
| \
> -					 __XFS_EXCHANGE_RANGE_UPD_CMTIME2)
> +					 __XFS_EXCHANGE_RANGE_UPD_CMTIME2 | \
> +					 __XFS_EXCHANGE_RANGE_CHECK_FRESH2)
> =20
>  struct xfs_exchrange {
>  	struct file		*file1;
> @@ -22,10 +26,20 @@ struct xfs_exchrange {
>  	u64			length;
> =20
>  	u64			flags;	/* XFS_EXCHANGE_RANGE flags */
> +
> +	/* file2 metadata for freshness checks */
> +	u64			file2_ino;
> +	struct timespec64	file2_mtime;
> +	struct timespec64	file2_ctime;
> +	u32			file2_gen;
>  };
> =20
>  long xfs_ioc_exchange_range(struct file *file,
>  		struct xfs_exchange_range __user *argp);
> +long xfs_ioc_start_commit(struct file *file,
> +		struct xfs_commit_range __user *argp);
> +long xfs_ioc_commit_range(struct file *file,
> +		struct xfs_commit_range __user	*argp);
> =20
>  struct xfs_exchmaps_req;
> =20
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 6b13666d4e963..90b3ee21e7fe6 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1518,6 +1518,10 @@ xfs_file_ioctl(
> =20
>  	case XFS_IOC_EXCHANGE_RANGE:
>  		return xfs_ioc_exchange_range(filp, arg);
> +	case XFS_IOC_START_COMMIT:
> +		return xfs_ioc_start_commit(filp, arg);
> +	case XFS_IOC_COMMIT_RANGE:
> +		return xfs_ioc_commit_range(filp, arg);
> =20
>  	default:
>  		return -ENOTTY;
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 180ce697305a9..4cf0fa71ba9ce 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -4926,7 +4926,8 @@ DEFINE_INODE_ERROR_EVENT(xfs_exchrange_error);
>  	{ XFS_EXCHANGE_RANGE_DRY_RUN,		"DRY_RUN" }, \
>  	{ XFS_EXCHANGE_RANGE_FILE1_WRITTEN,	"F1_WRITTEN" }, \
>  	{ __XFS_EXCHANGE_RANGE_UPD_CMTIME1,	"CMTIME1" }, \
> -	{ __XFS_EXCHANGE_RANGE_UPD_CMTIME2,	"CMTIME2" }
> +	{ __XFS_EXCHANGE_RANGE_UPD_CMTIME2,	"CMTIME2" }, \
> +	{ __XFS_EXCHANGE_RANGE_CHECK_FRESH2,	"FRESH2" }
> =20
>  /* file exchange-range tracepoint class */
>  DECLARE_EVENT_CLASS(xfs_exchrange_class,
> @@ -4986,6 +4987,60 @@ DEFINE_EXCHRANGE_EVENT(xfs_exchrange_prep);
>  DEFINE_EXCHRANGE_EVENT(xfs_exchrange_flush);
>  DEFINE_EXCHRANGE_EVENT(xfs_exchrange_mappings);
> =20
> +TRACE_EVENT(xfs_exchrange_freshness,
> +	TP_PROTO(const struct xfs_exchrange *fxr, struct xfs_inode *ip2),
> +	TP_ARGS(fxr, ip2),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(xfs_ino_t, ip2_ino)
> +		__field(long long, ip2_mtime)
> +		__field(long long, ip2_ctime)
> +		__field(int, ip2_mtime_nsec)
> +		__field(int, ip2_ctime_nsec)
> +
> +		__field(xfs_ino_t, file2_ino)
> +		__field(long long, file2_mtime)
> +		__field(long long, file2_ctime)
> +		__field(int, file2_mtime_nsec)
> +		__field(int, file2_ctime_nsec)
> +	),
> +	TP_fast_assign(
> +		struct timespec64	ts64;
> +		struct inode		*inode2 =3D VFS_I(ip2);
> +
> +		__entry->dev =3D inode2->i_sb->s_dev;
> +		__entry->ip2_ino =3D ip2->i_ino;
> +
> +		ts64 =3D inode_get_ctime(inode2);
> +		__entry->ip2_ctime =3D ts64.tv_sec;
> +		__entry->ip2_ctime_nsec =3D ts64.tv_nsec;
> +
> +		ts64 =3D inode_get_mtime(inode2);
> +		__entry->ip2_mtime =3D ts64.tv_sec;
> +		__entry->ip2_mtime_nsec =3D ts64.tv_nsec;
> +
> +		__entry->file2_ino =3D fxr->file2_ino;
> +		__entry->file2_mtime =3D fxr->file2_mtime.tv_sec;
> +		__entry->file2_ctime =3D fxr->file2_ctime.tv_sec;
> +		__entry->file2_mtime_nsec =3D fxr->file2_mtime.tv_nsec;
> +		__entry->file2_ctime_nsec =3D fxr->file2_ctime.tv_nsec;
> +	),
> +	TP_printk("dev %d:%d "
> +		  "ino 0x%llx mtime %lld:%d ctime %lld:%d -> "
> +		  "file 0x%llx mtime %lld:%d ctime %lld:%d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->ip2_ino,
> +		  __entry->ip2_mtime,
> +		  __entry->ip2_mtime_nsec,
> +		  __entry->ip2_ctime,
> +		  __entry->ip2_ctime_nsec,
> +		  __entry->file2_ino,
> +		  __entry->file2_mtime,
> +		  __entry->file2_mtime_nsec,
> +		  __entry->file2_ctime,
> +		  __entry->file2_ctime_nsec)
> +);
> +
>  TRACE_EVENT(xfs_exchmaps_overhead,
>  	TP_PROTO(struct xfs_mount *mp, unsigned long long bmbt_blocks,
>  		 unsigned long long rmapbt_blocks),

Acked-by: Jeff Layton <jlayton@kernel.org>

