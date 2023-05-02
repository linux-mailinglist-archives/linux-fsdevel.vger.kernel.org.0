Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160AF6F4751
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 17:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjEBPfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbjEBPfX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 11:35:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3BAF1;
        Tue,  2 May 2023 08:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32FC7625F2;
        Tue,  2 May 2023 15:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83418C433EF;
        Tue,  2 May 2023 15:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683041717;
        bh=dwkIo35PZyRTeCi0f5JIELwBuxoFCXZ4/5mAw3GK8Ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HgGzMeQXHrvEeEMEZZIjrRPqmeCmIITpfE34ek8Tvj4488KZEfJ41GcQDrop9HIEQ
         4utZT89T8pmWgkB55/jjzFS0u0X4zXumBgpYG3bfP+0Du5Ki35AOsopWG+xNbauq3C
         GGNTTLZ15hJOyZCakEGtnJEwpG1DYlMHPk1enbuH5SoW4daszaKjqVRybbS6/LDv0u
         KjimnB6vTp+JKfJKncOaCheltb7hHTi1jJliE9u9/IBtMiWxsAldZo5n6LzyoDZuD6
         qxFf4IElQF78GNiiK4sbxCKhRer8HMfdACXCbAlvxOdxYzKUBEeU7NxestwrJpE8Ui
         w2imSwsunC/Fw==
Date:   Tue, 2 May 2023 08:35:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Baokun Li <libaokun1@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Zhang Yi <yi.zhang@redhat.com>,
        yangerkun <yangerkun@huawei.com>
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <20230502153516.GA15376@frogsfrogsfrogs>
References: <ZEpcCOCNDhdMHQyY@ovpn-8-26.pek2.redhat.com>
 <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com>
 <fb127775-bbe4-eb50-4b9d-45a8e0e26ae7@huawei.com>
 <ZEtd6qZOgRxYnNq9@mit.edu>
 <ZEyL/sjVeW88XpIn@ovpn-8-24.pek2.redhat.com>
 <20230429044038.GA7561@lst.de>
 <ZEym2Yf1Ud1p+L3R@ovpn-8-24.pek2.redhat.com>
 <20230501044744.GA20056@lst.de>
 <ZFBf/CXN2ktVYL/N@ovpn-8-16.pek2.redhat.com>
 <20230502013557.GH2155823@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502013557.GH2155823@dread.disaster.area>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 02, 2023 at 11:35:57AM +1000, Dave Chinner wrote:
> On Tue, May 02, 2023 at 08:57:32AM +0800, Ming Lei wrote:
> > On Mon, May 01, 2023 at 06:47:44AM +0200, Christoph Hellwig wrote:
> > > On Sat, Apr 29, 2023 at 01:10:49PM +0800, Ming Lei wrote:
> > > > Not sure if it is needed for non s_bdev
> > > 
> > > So you don't want to work this at all for btrfs?  Or the XFS log device,
> > > or ..
> > 
> > Basically FS can provide one generic API of shutdown_filesystem() which
> > shutdown FS generically, meantime calls each fs's ->shutdown() for
> > dealing with fs specific shutdown.
> > 
> > If there isn't superblock attached for one bdev, can you explain a bit what
> > filesystem code can do? Same with block layer bdev.
> > 
> > The current bio->bi_status together disk_live()(maybe bdev_live() is
> > needed) should be enough for FS code to handle non s_bdev.
> 
> maybe necessary for btrfs, but not for XFS....
> > 
> > > 
> > > > , because FS is over stackable device
> > > > directly. Stackable device has its own logic for handling underlying disks dead
> > > > or deleted, then decide if its own disk needs to be deleted, such as, it is
> > > > fine for raid1 to work from user viewpoint if one underlying disk is deleted.
> > > 
> > > We still need to propagate the even that device has been removed upwards.
> > > Right now some file systems (especially XFS) are good at just propagating
> > > it from an I/O error.  And explicity call would be much better.
> > 
> > It depends on the above question about how FS code handle non s_bdev
> > deletion/dead.
> 
> as XFS doesn't treat the individual devices differently. A
> failure on an external log device is just as fatal as a failure on
> a single device filesystem with an internal log. ext4 is 
> going to consider external journal device removal as fatal, too.
> 
> As for removal of realtime devices on XFS, all the user data has
> gone away, so the filesystem will largely be useless for users and
> applications.  At this point, we'll probably want to shut down the
> filesystem because we've had an unknown amount of user data loss and
> so silently continuing on as if nothing happened is not the right
> thing to do.
> 
> So as long as we can attach the superblock to each block device that
> the filesystem opens (regardless of where sb->s_bdev points), device
> removal calling sb_force_shutdown(sb, SB_SHUTDOWN_DEVICE_DEAD) will
> do what we need. If we need anything different in future, then we
> can worry about how to do that in the future.

Shiyang spent a lot of time hooking up pmem failure notifications so
that xfs can kill processes that have pmem in their mapping.  I wonder
if we could reuse some of that infrastructure here?  That MF_MEM_REMOVE
patchset he's been trying to get us to merge would be a good starting
point for building something similar for block devices.  AFAICT it does
the right thing if you hand it a subrange of the dax device or if you
pass it the customary (0, -1ULL) to mean "the entire device".

The block device version of that could be a lot simpler-- imagine if
"echo 0 > /sys/block/fd0/device/delete" resulted in the block layer
first sending us a notification that the device is about to be removed.
We could then flush the fs and try to freeze it.  After the device
actually goes away, the blocy layer would send us a second notification
about DEVICE_DEAD and we could shut down the incore filesystem objects.

I've also been wondering if we should rather hook XFS (and all the other
block filesystems) into the device model as a child "device" of the
bdevs that they attach to.  Suspend and remove events then simply map to
->freeze_fs, like Luis has been talking about.  But I am not
sufficiently familiar with the device model to know if it supports
a device being reachable through multiple paths through the device tree?

--D

> I have attached a quick untested compendium patch to lift the
> shutdown ioctl to the VFS, have if call sb_force_shutdown(sb), plumb
> in sb->s_op->shutdown_fs(sb), hook XFS up to it and then remove the
> XFS ioctl implementation for this functionality. I also included a
> new shutdown reason called "FS_SHUTDOWN_DEVICE_DEAD" so that the
> filesystem knows it's being called because the storage device is
> dead instead of a user/admin asking it to die.
> 
> The code isn't that complex - we'll need to add ext4, f2fs and cifs
> support for the shutdown_fs method, but otherwise there shouldn't be
> much more to it...
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
> 
> fs: add superblock shutdown infrastructure
> 
> From: Dave Chinner <dchinner@redhat.com>
> 
> So we can lift the shutdown ioctl to the VFS and also provide a
> mechanism for block device failure to shut down the filesystem for
> correct error handling.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  Documentation/filesystems/vfs.rst |  5 +++++
>  fs/ioctl.c                        | 27 +++++++++++++++++++++++++++
>  fs/super.c                        | 19 +++++++++++++++++++
>  fs/xfs/libxfs/xfs_fs.h            | 27 +++++++++++++++++++--------
>  fs/xfs/xfs_fsops.c                | 30 +++---------------------------
>  fs/xfs/xfs_ioctl.c                | 12 ------------
>  fs/xfs/xfs_mount.h                |  7 +++++--
>  fs/xfs/xfs_super.c                | 32 ++++++++++++++++++++++++++++++++
>  include/linux/fs.h                | 16 ++++++++++++++++
>  include/uapi/linux/fs.h           | 13 +++++++++++++
>  10 files changed, 139 insertions(+), 49 deletions(-)
> 
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 769be5230210..6e0855cad74a 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -266,6 +266,7 @@ filesystem.  The following members are defined:
>  		int (*unfreeze_fs) (struct super_block *);
>  		int (*statfs) (struct dentry *, struct kstatfs *);
>  		int (*remount_fs) (struct super_block *, int *, char *);
> +		int (*shutdown_fs) (struct super_block *sb, enum sb_shutdown_flags flags);
>  		void (*umount_begin) (struct super_block *);
>  
>  		int (*show_options)(struct seq_file *, struct dentry *);
> @@ -376,6 +377,10 @@ or bottom half).
>  	called when the filesystem is remounted.  This is called with
>  	the kernel lock held
>  
> +``shutdown_fs``
> +	called when the filesystem is to be shut down in response to a admin
> +	command or device failure. Optional.
> +
>  ``umount_begin``
>  	called when the VFS is unmounting a filesystem.
>  
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 5b2481cd4750..4e68b3a15fc1 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -413,6 +413,30 @@ static int ioctl_fsthaw(struct file *filp)
>  	return thaw_super(sb);
>  }
>  
> +static int ioctl_fsshutdown(struct file *filp, u32 __user *argp)
> +{
> +	struct super_block *sb = file_inode(filp)->i_sb;
> +	u32 inflags;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (get_user(inflags, argp))
> +		return -EFAULT;
> +
> +	switch (inflags) {
> +	case FS_SHUTDOWN_SYNC:
> +		return sb_force_shutdown(sb, SB_SHUTDOWN_SYNC);
> +	case FS_SHUTDOWN_METASYNC:
> +		return sb_force_shutdown(sb, SB_SHUTDOWN_METASYNC);
> +	case FS_SHUTDOWN_IMMEDIATE:
> +		return sb_force_shutdown(sb, SB_SHUTDOWN_IMMEDIATE);
> +	default:
> +		break;
> +	}
> +	return -EINVAL;
> +}
> +
>  static int ioctl_file_dedupe_range(struct file *file,
>  				   struct file_dedupe_range __user *argp)
>  {
> @@ -844,6 +868,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
>  	case FS_IOC_FSSETXATTR:
>  		return ioctl_fssetxattr(filp, argp);
>  
> +	case FS_IOC_SHUTDOWN:
> +		return ioctl_fsshutdown(filp, argp);
> +
>  	default:
>  		if (S_ISREG(inode->i_mode))
>  			return file_ioctl(filp, cmd, argp);
> diff --git a/fs/super.c b/fs/super.c
> index 34afe411cf2b..9e9af48e2d38 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1809,3 +1809,22 @@ int sb_init_dio_done_wq(struct super_block *sb)
>  		destroy_workqueue(wq);
>  	return 0;
>  }
> +
> +/**
> + * sb_force_shutdown -- force a shutdown of the given filesystem
> + * @sb: the super to shut down
> + * @flags: shutdown behaviour required
> + *
> + * This locks the superblock and performs a shutdown of the filesystem such that
> + * it no longer will perform any user operations successfully or issue any IO to
> + * the underlying backing store.
> + *
> + * If the filesystem does not support shutdowns, just sync the filesystem and
> + * hope that it generates sufficient IO errors for applications to notice.
> + */
> +int sb_force_shutdown(struct super_block *sb, enum sb_shutdown_reason reason)
> +{
> +	if (!sb->s_op->shutdown_fs)
> +		return sync_filesystem(sb);
> +	return sb->s_op->shutdown_fs(sb, reason);
> +}
> diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
> index 1cfd5bc6520a..533b016681f0 100644
> --- a/fs/xfs/libxfs/xfs_fs.h
> +++ b/fs/xfs/libxfs/xfs_fs.h
> @@ -660,13 +660,6 @@ typedef struct xfs_swapext
>  	struct xfs_bstat sx_stat;	/* stat of target b4 copy */
>  } xfs_swapext_t;
>  
> -/*
> - * Flags for going down operation
> - */
> -#define XFS_FSOP_GOING_FLAGS_DEFAULT		0x0	/* going down */
> -#define XFS_FSOP_GOING_FLAGS_LOGFLUSH		0x1	/* flush log but not data */
> -#define XFS_FSOP_GOING_FLAGS_NOLOGFLUSH		0x2	/* don't flush log nor data */
> -
>  /* metadata scrubbing */
>  struct xfs_scrub_metadata {
>  	__u32 sm_type;		/* What to check? */
> @@ -827,12 +820,30 @@ struct xfs_scrub_metadata {
>  #define XFS_IOC_ATTRLIST_BY_HANDLE   _IOW ('X', 122, struct xfs_fsop_attrlist_handlereq)
>  #define XFS_IOC_ATTRMULTI_BY_HANDLE  _IOW ('X', 123, struct xfs_fsop_attrmulti_handlereq)
>  #define XFS_IOC_FSGEOMETRY_V4	     _IOR ('X', 124, struct xfs_fsop_geom_v4)
> -#define XFS_IOC_GOINGDOWN	     _IOR ('X', 125, uint32_t)
>  #define XFS_IOC_FSGEOMETRY	     _IOR ('X', 126, struct xfs_fsop_geom)
>  #define XFS_IOC_BULKSTAT	     _IOR ('X', 127, struct xfs_bulkstat_req)
>  #define XFS_IOC_INUMBERS	     _IOR ('X', 128, struct xfs_inumbers_req)
>  /*	XFS_IOC_GETFSUUID ---------- deprecated 140	 */
>  
> +#ifndef FS_IOC_SHUTDOWN
> +/*
> + * Flags for going down operation
> + */
> +#define XFS_FSOP_GOING_FLAGS_DEFAULT		0x0	/* going down */
> +#define XFS_FSOP_GOING_FLAGS_LOGFLUSH		0x1	/* flush log but not data */
> +#define XFS_FSOP_GOING_FLAGS_NOLOGFLUSH		0x2	/* don't flush log nor data */
> +
> +#define XFS_IOC_GOINGDOWN	     _IOR ('X', 125, uint32_t)
> +#else /* !FS_IOC_SHUTDOWN */
> +
> +/* Use VFS provided definitions */
> +#define XFS_IOC_GOINGDOWN	     FS_IOC_SHUTDOWN
> +
> +#define XFS_FSOP_GOING_FLAGS_DEFAULT		FS_SHUTDOWN_SYNC
> +#define XFS_FSOP_GOING_FLAGS_LOGFLUSH		FS_SHUTDOWN_METASYNC
> +#define XFS_FSOP_GOING_FLAGS_NOLOGFLUSH		FS_SHUTDOWN_IMMEDIATE
> +
> +#endif /* FS_IOC_SHUTDOWN */
>  
>  #ifndef HAVE_BBMACROS
>  /*
> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> index 13851c0d640b..11bc4270e373 100644
> --- a/fs/xfs/xfs_fsops.c
> +++ b/fs/xfs/xfs_fsops.c
> @@ -466,33 +466,6 @@ xfs_reserve_blocks(
>  	return error;
>  }
>  
> -int
> -xfs_fs_goingdown(
> -	xfs_mount_t	*mp,
> -	uint32_t	inflags)
> -{
> -	switch (inflags) {
> -	case XFS_FSOP_GOING_FLAGS_DEFAULT: {
> -		if (!freeze_bdev(mp->m_super->s_bdev)) {
> -			xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
> -			thaw_bdev(mp->m_super->s_bdev);
> -		}
> -		break;
> -	}
> -	case XFS_FSOP_GOING_FLAGS_LOGFLUSH:
> -		xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
> -		break;
> -	case XFS_FSOP_GOING_FLAGS_NOLOGFLUSH:
> -		xfs_force_shutdown(mp,
> -				SHUTDOWN_FORCE_UMOUNT | SHUTDOWN_LOG_IO_ERROR);
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>  /*
>   * Force a shutdown of the filesystem instantly while keeping the filesystem
>   * consistent. We don't do an unmount here; just shutdown the shop, make sure
> @@ -525,6 +498,9 @@ xfs_do_force_shutdown(
>  	if (flags & SHUTDOWN_FORCE_UMOUNT)
>  		xfs_alert(mp, "User initiated shutdown received.");
>  
> +	if (flags & SHUTDOWN_DEVICE_DEAD)
> +		xfs_alert(mp, "Storage device initiated shutdown received.");
> +
>  	if (xlog_force_shutdown(mp->m_log, flags)) {
>  		tag = XFS_PTAG_SHUTDOWN_LOGERROR;
>  		why = "Log I/O Error";
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 55bb01173cde..695bfc25213d 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -2094,18 +2094,6 @@ xfs_file_ioctl(
>  		return error;
>  	}
>  
> -	case XFS_IOC_GOINGDOWN: {
> -		uint32_t in;
> -
> -		if (!capable(CAP_SYS_ADMIN))
> -			return -EPERM;
> -
> -		if (get_user(in, (uint32_t __user *)arg))
> -			return -EFAULT;
> -
> -		return xfs_fs_goingdown(mp, in);
> -	}
> -
>  	case XFS_IOC_ERROR_INJECTION: {
>  		xfs_error_injection_t in;
>  
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index f3269c0626f0..0b3f829333fe 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -453,13 +453,16 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, uint32_t flags, char *fname,
>  #define SHUTDOWN_LOG_IO_ERROR	(1u << 1) /* write attempt to the log failed */
>  #define SHUTDOWN_FORCE_UMOUNT	(1u << 2) /* shutdown from a forced unmount */
>  #define SHUTDOWN_CORRUPT_INCORE	(1u << 3) /* corrupt in-memory structures */
> -#define SHUTDOWN_CORRUPT_ONDISK	(1u << 4)  /* corrupt metadata on device */
> +#define SHUTDOWN_CORRUPT_ONDISK	(1u << 4) /* corrupt metadata on device */
> +#define SHUTDOWN_DEVICE_DEAD	(1u << 5) /* block device is dead */
>  
>  #define XFS_SHUTDOWN_STRINGS \
>  	{ SHUTDOWN_META_IO_ERROR,	"metadata_io" }, \
>  	{ SHUTDOWN_LOG_IO_ERROR,	"log_io" }, \
>  	{ SHUTDOWN_FORCE_UMOUNT,	"force_umount" }, \
> -	{ SHUTDOWN_CORRUPT_INCORE,	"corruption" }
> +	{ SHUTDOWN_CORRUPT_INCORE,	"corruption" }, \
> +	{ SHUTDOWN_CORRUPT_ONDISK,	"on-disk corruption" }, \
> +	{ SHUTDOWN_DEVICE_DEAD,		"device dead" }
>  
>  /*
>   * Flags for xfs_mountfs
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 4d2e87462ac4..4d62d1cee8dc 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -963,6 +963,37 @@ xfs_fs_unfreeze(
>  	return 0;
>  }
>  
> +static int
> +xfs_fs_shutdown(
> +	struct super_block	*sb,
> +	enum sb_shutdown_reason	reason)
> +{
> +	struct xfs_mount	*mp = XFS_M(sb);
> +
> +	switch (reason) {
> +	case SB_SHUTDOWN_SYNC:
> +		if (!freeze_bdev(sb->s_bdev)) {
> +			xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
> +			thaw_bdev(mp->m_super->s_bdev);
> +		}
> +		break;
> +	case SB_SHUTDOWN_METASYNC:
> +		xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
> +		break;
> +	case SB_SHUTDOWN_IMMEDIATE:
> +		xfs_force_shutdown(mp,
> +				SHUTDOWN_FORCE_UMOUNT | SHUTDOWN_LOG_IO_ERROR);
> +		break;
> +	case SB_SHUTDOWN_DEVICE_DEAD:
> +		xfs_force_shutdown(mp,
> +				SHUTDOWN_DEVICE_DEAD | SHUTDOWN_LOG_IO_ERROR);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * This function fills in xfs_mount_t fields based on mount args.
>   * Note: the superblock _has_ now been read in.
> @@ -1165,6 +1196,7 @@ static const struct super_operations xfs_super_operations = {
>  	.sync_fs		= xfs_fs_sync_fs,
>  	.freeze_fs		= xfs_fs_freeze,
>  	.unfreeze_fs		= xfs_fs_unfreeze,
> +	.shutdown_fs		= xfs_fs_shutdown,
>  	.statfs			= xfs_fs_statfs,
>  	.show_options		= xfs_fs_show_options,
>  	.nr_cached_objects	= xfs_fs_nr_cached_objects,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a2dfbe2fb639..a8f3b39cd976 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1900,6 +1900,21 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
>  					struct file *dst_file, loff_t dst_pos,
>  					loff_t len, unsigned int remap_flags);
>  
> +/*
> + * Shutdown reason - indicate the reason for and/or the actions to take while
> + * processing the shutdown of the filesystem
> + */
> +enum sb_shutdown_reason {
> +	/* user driven shutdowns */
> +	SB_SHUTDOWN_SYNC,	/* sync whole fs before shutdown */
> +	SB_SHUTDOWN_METASYNC,	/* only sync metadata before shutdown */
> +	SB_SHUTDOWN_IMMEDIATE,	/* immediately terminate all operations */
> +
> +	/* internal event driven shutdowns */
> +	SB_SHUTDOWN_DEVICE_DEAD,/* shutdown initiated by device removal */
> +};
> +
> +int sb_force_shutdown(struct super_block *sb, enum sb_shutdown_reason reason);
>  
>  struct super_operations {
>     	struct inode *(*alloc_inode)(struct super_block *sb);
> @@ -1918,6 +1933,7 @@ struct super_operations {
>  	int (*unfreeze_fs) (struct super_block *);
>  	int (*statfs) (struct dentry *, struct kstatfs *);
>  	int (*remount_fs) (struct super_block *, int *, char *);
> +	int (*shutdown_fs) (struct super_block *sb, enum sb_shutdown_reason reason);
>  	void (*umount_begin) (struct super_block *);
>  
>  	int (*show_options)(struct seq_file *, struct dentry *);
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c..ce346944cd3d 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -216,6 +216,19 @@ struct fsxattr {
>  #define FS_IOC_GETFSLABEL		_IOR(0x94, 49, char[FSLABEL_MAX])
>  #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
>  
> +#define FS_IOC_SHUTDOWN			_IOR('X', 125, u32)
> +
> +/*
> + * Flags for FS_IOC_SHUTDOWN operation.
> + *
> + * This ioctl has been lifted from XFS, so the user API must support the first
> + * three types of user driven shutdown. If no shutdown flag value is passed,
> + * we treat it as a "sync the entire filesystem before shutdown" command.
> + */
> +#define FS_SHUTDOWN_SYNC	(0U)	  /* sync entire fs before shutdown */
> +#define FS_SHUTDOWN_METASYNC	(1U << 0) /* sync all metadata before shutdown */
> +#define FS_SHUTDOWN_IMMEDIATE	(1U << 1) /* terminate all operations immediately */
> +
>  /*
>   * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
>   *
