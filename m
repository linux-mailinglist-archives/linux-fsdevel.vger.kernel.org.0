Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB91C7331FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 15:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343928AbjFPNSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 09:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjFPNSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:18:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D649B2D6B;
        Fri, 16 Jun 2023 06:18:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 535FA22073;
        Fri, 16 Jun 2023 13:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686921491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e0g3IskJ90MqJ7jyQPtvFlK6V0xkWAxZdAAtagklYic=;
        b=cl8cyTrXG0a9BuZMxWK4FGY5QzjLUyfQwmAl4tRt+00GNpE6neGl3lApkkyFkVyCosO/LB
        3viI4QX9o5v9yonJBJEQhwk3wKCoyEcofJ34ZSVgJjrhiVIXqVPFnjYt5g+3TJfr0cNWLh
        wUsZN7AW3TFraa8QuIALYWa1pPenDSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686921491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e0g3IskJ90MqJ7jyQPtvFlK6V0xkWAxZdAAtagklYic=;
        b=okFz0axy0FGbp36fFxdLYF2ySdp0LQxVqG3UcLZbVEwyG3CcQmZ4na7ZdmHWLaCm2ppuF/
        1DgKq9t/EwT2HrCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B540138E8;
        Fri, 16 Jun 2023 13:18:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id quNmDhNhjGQ7QgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 13:18:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A220FA0755; Fri, 16 Jun 2023 15:18:10 +0200 (CEST)
Date:   Fri, 16 Jun 2023 15:18:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     mcgrof@kernel.org, jack@suse.cz, hch@infradead.org,
        ruansy.fnst@fujitsu.com, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230616131810.b2dj3vsrugee2dfb@quack3>
References: <168688010689.860947.1788875898367401950.stgit@frogsfrogsfrogs>
 <168688011268.860947.290191757543068705.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168688011268.860947.290191757543068705.stgit@frogsfrogsfrogs>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 15-06-23 18:48:32, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Userspace can freeze a filesystem using the FIFREEZE ioctl or by
> suspending the block device; this state persists until userspace thaws
> the filesystem with the FITHAW ioctl or resuming the block device.
> Since commit 18e9e5104fcd ("Introduce freeze_super and thaw_super for
> the fsfreeze ioctl") we only allow the first freeze command to succeed.
> 
> The kernel may decide that it is necessary to freeze a filesystem for
> its own internal purposes, such as suspends in progress, filesystem fsck
> activities, or quiescing a device prior to removal.  Userspace thaw
> commands must never break a kernel freeze, and kernel thaw commands
> shouldn't undo userspace's freeze command.
> 
> Introduce a couple of freeze holder flags and wire it into the
> sb_writers state.  One kernel and one userspace freeze are allowed to
> coexist at the same time; the filesystem will not thaw until both are
> lifted.
> 
> I wonder if the f2fs/gfs2 code should be using a kernel freeze here, but
> for now we'll use FREEZE_HOLDER_USERSPACE to preserve existing
> behaviors.
> 
> Cc: mcgrof@kernel.org
> Cc: jack@suse.cz
> Cc: hch@infradead.org
> Cc: ruansy.fnst@fujitsu.com
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/vfs.rst |    6 ++-
>  block/bdev.c                      |    8 ++--
>  fs/f2fs/gc.c                      |    4 +-
>  fs/gfs2/glops.c                   |    2 -
>  fs/gfs2/super.c                   |    6 +--
>  fs/gfs2/sys.c                     |    4 +-
>  fs/gfs2/util.c                    |    2 -
>  fs/ioctl.c                        |    8 ++--
>  fs/super.c                        |   79 +++++++++++++++++++++++++++++++++----
>  include/linux/fs.h                |   15 +++++--
>  10 files changed, 101 insertions(+), 33 deletions(-)
> 
> 
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 769be5230210..6f7e971edb2d 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -260,9 +260,11 @@ filesystem.  The following members are defined:
>  		void (*evict_inode) (struct inode *);
>  		void (*put_super) (struct super_block *);
>  		int (*sync_fs)(struct super_block *sb, int wait);
> -		int (*freeze_super) (struct super_block *);
> +		int (*freeze_super) (struct super_block *sb,
> +					enum freeze_holder who);
>  		int (*freeze_fs) (struct super_block *);
> -		int (*thaw_super) (struct super_block *);
> +		int (*thaw_super) (struct super_block *sb,
> +					enum freeze_wholder who);
>  		int (*unfreeze_fs) (struct super_block *);
>  		int (*statfs) (struct dentry *, struct kstatfs *);
>  		int (*remount_fs) (struct super_block *, int *, char *);
> diff --git a/block/bdev.c b/block/bdev.c
> index 21c63bfef323..e8032c5beae0 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -248,9 +248,9 @@ int freeze_bdev(struct block_device *bdev)
>  	if (!sb)
>  		goto sync;
>  	if (sb->s_op->freeze_super)
> -		error = sb->s_op->freeze_super(sb);
> +		error = sb->s_op->freeze_super(sb, FREEZE_HOLDER_USERSPACE);
>  	else
> -		error = freeze_super(sb);
> +		error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
>  	deactivate_super(sb);
>  
>  	if (error) {
> @@ -291,9 +291,9 @@ int thaw_bdev(struct block_device *bdev)
>  		goto out;
>  
>  	if (sb->s_op->thaw_super)
> -		error = sb->s_op->thaw_super(sb);
> +		error = sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE);
>  	else
> -		error = thaw_super(sb);
> +		error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
>  	if (error)
>  		bdev->bd_fsfreeze_count++;
>  	else
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 61c5f9d26018..bca4e75c14e0 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2166,7 +2166,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  	if (err)
>  		return err;
>  
> -	freeze_super(sbi->sb);
> +	freeze_super(sbi->sb, FREEZE_HOLDER_USERSPACE);
>  	f2fs_down_write(&sbi->gc_lock);
>  	f2fs_down_write(&sbi->cp_global_sem);
>  
> @@ -2217,6 +2217,6 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  out_err:
>  	f2fs_up_write(&sbi->cp_global_sem);
>  	f2fs_up_write(&sbi->gc_lock);
> -	thaw_super(sbi->sb);
> +	thaw_super(sbi->sb, FREEZE_HOLDER_USERSPACE);
>  	return err;
>  }
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index 01d433ed6ce7..6bffb7609d01 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -584,7 +584,7 @@ static int freeze_go_sync(struct gfs2_glock *gl)
>  	if (gl->gl_state == LM_ST_SHARED && !gfs2_withdrawn(sdp) &&
>  	    !test_bit(SDF_NORECOVERY, &sdp->sd_flags)) {
>  		atomic_set(&sdp->sd_freeze_state, SFS_STARTING_FREEZE);
> -		error = freeze_super(sdp->sd_vfs);
> +		error = freeze_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE);
>  		if (error) {
>  			fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n",
>  				error);
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index a84bf6444bba..3965b00a7503 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -682,7 +682,7 @@ void gfs2_freeze_func(struct work_struct *work)
>  		gfs2_assert_withdraw(sdp, 0);
>  	} else {
>  		atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
> -		error = thaw_super(sb);
> +		error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
>  		if (error) {
>  			fs_info(sdp, "GFS2: couldn't thaw filesystem: %d\n",
>  				error);
> @@ -702,7 +702,7 @@ void gfs2_freeze_func(struct work_struct *work)
>   *
>   */
>  
> -static int gfs2_freeze(struct super_block *sb)
> +static int gfs2_freeze(struct super_block *sb, enum freeze_holder who)
>  {
>  	struct gfs2_sbd *sdp = sb->s_fs_info;
>  	int error;
> @@ -747,7 +747,7 @@ static int gfs2_freeze(struct super_block *sb)
>   *
>   */
>  
> -static int gfs2_unfreeze(struct super_block *sb)
> +static int gfs2_unfreeze(struct super_block *sb, enum freeze_holder who)
>  {
>  	struct gfs2_sbd *sdp = sb->s_fs_info;
>  
> diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
> index 454dc2ff8b5e..9d04a2907869 100644
> --- a/fs/gfs2/sys.c
> +++ b/fs/gfs2/sys.c
> @@ -166,10 +166,10 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
>  
>  	switch (n) {
>  	case 0:
> -		error = thaw_super(sdp->sd_vfs);
> +		error = thaw_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE);
>  		break;
>  	case 1:
> -		error = freeze_super(sdp->sd_vfs);
> +		error = freeze_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE);
>  		break;
>  	default:
>  		return -EINVAL;
> diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
> index 7a6aeffcdf5c..357457b7c5b3 100644
> --- a/fs/gfs2/util.c
> +++ b/fs/gfs2/util.c
> @@ -191,7 +191,7 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
>  		/* Make sure gfs2_unfreeze works if partially-frozen */
>  		flush_work(&sdp->sd_freeze_work);
>  		atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
> -		thaw_super(sdp->sd_vfs);
> +		thaw_super(sdp->sd_vfs, FREEZE_HOLDER_USERSPACE);
>  	} else {
>  		wait_on_bit(&i_gl->gl_flags, GLF_DEMOTE,
>  			    TASK_UNINTERRUPTIBLE);
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 5b2481cd4750..a56cbceedcd1 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -396,8 +396,8 @@ static int ioctl_fsfreeze(struct file *filp)
>  
>  	/* Freeze */
>  	if (sb->s_op->freeze_super)
> -		return sb->s_op->freeze_super(sb);
> -	return freeze_super(sb);
> +		return sb->s_op->freeze_super(sb, FREEZE_HOLDER_USERSPACE);
> +	return freeze_super(sb, FREEZE_HOLDER_USERSPACE);
>  }
>  
>  static int ioctl_fsthaw(struct file *filp)
> @@ -409,8 +409,8 @@ static int ioctl_fsthaw(struct file *filp)
>  
>  	/* Thaw */
>  	if (sb->s_op->thaw_super)
> -		return sb->s_op->thaw_super(sb);
> -	return thaw_super(sb);
> +		return sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE);
> +	return thaw_super(sb, FREEZE_HOLDER_USERSPACE);
>  }
>  
>  static int ioctl_file_dedupe_range(struct file *file,
> diff --git a/fs/super.c b/fs/super.c
> index 34afe411cf2b..81fb67157cba 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -39,7 +39,7 @@
>  #include <uapi/linux/mount.h>
>  #include "internal.h"
>  
> -static int thaw_super_locked(struct super_block *sb);
> +static int thaw_super_locked(struct super_block *sb, enum freeze_holder who);
>  
>  static LIST_HEAD(super_blocks);
>  static DEFINE_SPINLOCK(sb_lock);
> @@ -1027,7 +1027,7 @@ static void do_thaw_all_callback(struct super_block *sb)
>  	down_write(&sb->s_umount);
>  	if (sb->s_root && sb->s_flags & SB_BORN) {
>  		emergency_thaw_bdev(sb);
> -		thaw_super_locked(sb);
> +		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
>  	} else {
>  		up_write(&sb->s_umount);
>  	}
> @@ -1638,11 +1638,22 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
>  /**
>   * freeze_super - lock the filesystem and force it into a consistent state
>   * @sb: the super to lock
> + * @who: context that wants to freeze
>   *
>   * Syncs the super to make sure the filesystem is consistent and calls the fs's
> - * freeze_fs.  Subsequent calls to this without first thawing the fs will return
> + * freeze_fs.  Subsequent calls to this without first thawing the fs may return
>   * -EBUSY.
>   *
> + * @who should be:
> + * * %FREEZE_HOLDER_USERSPACE if userspace wants to freeze the fs;
> + * * %FREEZE_HOLDER_KERNEL if the kernel wants to freeze the fs.
> + *
> + * The @who argument distinguishes between the kernel and userspace trying to
> + * freeze the filesystem.  Although there cannot be multiple kernel freezes or
> + * multiple userspace freezes in effect at any given time, the kernel and
> + * userspace can both hold a filesystem frozen.  The filesystem remains frozen
> + * until there are no kernel or userspace freezes in effect.
> + *
>   * During this function, sb->s_writers.frozen goes through these values:
>   *
>   * SB_UNFROZEN: File system is normal, all writes progress as usual.
> @@ -1668,12 +1679,30 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
>   *
>   * sb->s_writers.frozen is protected by sb->s_umount.
>   */
> -int freeze_super(struct super_block *sb)
> +int freeze_super(struct super_block *sb, enum freeze_holder who)
>  {
>  	int ret;
>  
>  	atomic_inc(&sb->s_active);
>  	down_write(&sb->s_umount);
> +
> +	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
> +		if (sb->s_writers.freeze_holders & who) {
> +			deactivate_locked_super(sb);
> +			return -EBUSY;
> +		}
> +
> +		WARN_ON(sb->s_writers.freeze_holders == 0);
> +
> +		/*
> +		 * Someone else already holds this type of freeze; share the
> +		 * freeze and assign the active ref to the freeze.
> +		 */
> +		sb->s_writers.freeze_holders |= who;
> +		up_write(&sb->s_umount);
> +		return 0;
> +	}
> +
>  	if (sb->s_writers.frozen != SB_UNFROZEN) {
>  		deactivate_locked_super(sb);
>  		return -EBUSY;
> @@ -1686,6 +1715,7 @@ int freeze_super(struct super_block *sb)
>  
>  	if (sb_rdonly(sb)) {
>  		/* Nothing to do really... */
> +		sb->s_writers.freeze_holders |= who;
>  		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
>  		up_write(&sb->s_umount);
>  		return 0;
> @@ -1731,6 +1761,7 @@ int freeze_super(struct super_block *sb)
>  	 * For debugging purposes so that fs can warn if it sees write activity
>  	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
>  	 */
> +	sb->s_writers.freeze_holders |= who;
>  	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
>  	lockdep_sb_freeze_release(sb);
>  	up_write(&sb->s_umount);
> @@ -1738,16 +1769,39 @@ int freeze_super(struct super_block *sb)
>  }
>  EXPORT_SYMBOL(freeze_super);
>  
> -static int thaw_super_locked(struct super_block *sb)
> +/*
> + * Undoes the effect of a freeze_super_locked call.  If the filesystem is
> + * frozen both by userspace and the kernel, a thaw call from either source
> + * removes that state without releasing the other state or unlocking the
> + * filesystem.
> + */
> +static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
>  {
>  	int error;
>  
> -	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
> +	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
> +		if (!(sb->s_writers.freeze_holders & who)) {
> +			up_write(&sb->s_umount);
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * Freeze is shared with someone else.  Release our hold and
> +		 * drop the active ref that freeze_super assigned to the
> +		 * freezer.
> +		 */
> +		if (sb->s_writers.freeze_holders & ~who) {
> +			sb->s_writers.freeze_holders &= ~who;
> +			deactivate_locked_super(sb);
> +			return 0;
> +		}
> +	} else {
>  		up_write(&sb->s_umount);
>  		return -EINVAL;
>  	}
>  
>  	if (sb_rdonly(sb)) {
> +		sb->s_writers.freeze_holders &= ~who;
>  		sb->s_writers.frozen = SB_UNFROZEN;
>  		goto out;
>  	}
> @@ -1765,6 +1819,7 @@ static int thaw_super_locked(struct super_block *sb)
>  		}
>  	}
>  
> +	sb->s_writers.freeze_holders &= ~who;
>  	sb->s_writers.frozen = SB_UNFROZEN;
>  	sb_freeze_unlock(sb, SB_FREEZE_FS);
>  out:
> @@ -1776,13 +1831,19 @@ static int thaw_super_locked(struct super_block *sb)
>  /**
>   * thaw_super -- unlock filesystem
>   * @sb: the super to thaw
> + * @who: context that wants to freeze
>   *
> - * Unlocks the filesystem and marks it writeable again after freeze_super().
> + * Unlocks the filesystem and marks it writeable again after freeze_super()
> + * if there are no remaining freezes on the filesystem.
> + *
> + * @who should be:
> + * * %FREEZE_HOLDER_USERSPACE if userspace wants to thaw the fs;
> + * * %FREEZE_HOLDER_KERNEL if the kernel wants to thaw the fs.
>   */
> -int thaw_super(struct super_block *sb)
> +int thaw_super(struct super_block *sb, enum freeze_holder who)
>  {
>  	down_write(&sb->s_umount);
> -	return thaw_super_locked(sb);
> +	return thaw_super_locked(sb, who);
>  }
>  EXPORT_SYMBOL(thaw_super);
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 133f0640fb24..88bd81a1b980 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1145,7 +1145,8 @@ enum {
>  #define SB_FREEZE_LEVELS (SB_FREEZE_COMPLETE - 1)
>  
>  struct sb_writers {
> -	int				frozen;		/* Is sb frozen? */
> +	unsigned short			frozen;		/* Is sb frozen? */
> +	unsigned short			freeze_holders;	/* Who froze fs? */
>  	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
>  	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
>  };
> @@ -1899,6 +1900,10 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
>  					struct file *dst_file, loff_t dst_pos,
>  					loff_t len, unsigned int remap_flags);
>  
> +enum freeze_holder {
> +	FREEZE_HOLDER_KERNEL	= (1U << 0),
> +	FREEZE_HOLDER_USERSPACE	= (1U << 1),
> +};
>  
>  struct super_operations {
>     	struct inode *(*alloc_inode)(struct super_block *sb);
> @@ -1911,9 +1916,9 @@ struct super_operations {
>  	void (*evict_inode) (struct inode *);
>  	void (*put_super) (struct super_block *);
>  	int (*sync_fs)(struct super_block *sb, int wait);
> -	int (*freeze_super) (struct super_block *);
> +	int (*freeze_super) (struct super_block *, enum freeze_holder who);
>  	int (*freeze_fs) (struct super_block *);
> -	int (*thaw_super) (struct super_block *);
> +	int (*thaw_super) (struct super_block *, enum freeze_holder who);
>  	int (*unfreeze_fs) (struct super_block *);
>  	int (*statfs) (struct dentry *, struct kstatfs *);
>  	int (*remount_fs) (struct super_block *, int *, char *);
> @@ -2286,8 +2291,8 @@ extern int unregister_filesystem(struct file_system_type *);
>  extern int vfs_statfs(const struct path *, struct kstatfs *);
>  extern int user_statfs(const char __user *, struct kstatfs *);
>  extern int fd_statfs(int, struct kstatfs *);
> -extern int freeze_super(struct super_block *super);
> -extern int thaw_super(struct super_block *super);
> +int freeze_super(struct super_block *super, enum freeze_holder who);
> +int thaw_super(struct super_block *super, enum freeze_holder who);
>  extern __printf(2, 3)
>  int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
>  extern int super_setup_bdi(struct super_block *sb);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
