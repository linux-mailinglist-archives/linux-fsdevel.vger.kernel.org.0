Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C7466C379
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 16:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjAPPUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 10:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjAPPU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:20:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA9D23860;
        Mon, 16 Jan 2023 07:14:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB0C03779C;
        Mon, 16 Jan 2023 15:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673882095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pqGwttxejQI2xY9pRwgR6wKeyZ+4KuIfFsUDuwT42gU=;
        b=JFwosX9NeYM+m6aYqpT36IdWEdnnroduVHlP6mCD3sXMVw3g7XV99qo/YTqkXB4N2Il6Y9
        HHYu03gOamRVjrp5X4RCP7gDnjxqmBsM8GR+TwKGrdFAVHh/i+AkOJMJBOhHCnu56IfOdq
        2P6pc3caQdYPmttjY+7yvFfVpkqwABE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673882095;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pqGwttxejQI2xY9pRwgR6wKeyZ+4KuIfFsUDuwT42gU=;
        b=cxJGYDP+f4VAQFIjAVsCxobpMJDB3oCcogwJF0Val9Hzh+50GMox5oDHGmkkMtXyV3HhsO
        mFD9oDr7h0dR98CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB6D1138FA;
        Mon, 16 Jan 2023 15:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WTGkNe9pxWP2AgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 16 Jan 2023 15:14:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 66683A06AD; Mon, 16 Jan 2023 16:14:55 +0100 (CET)
Date:   Mon, 16 Jan 2023 16:14:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, djwong@kernel.org, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org,
        p.raghav@samsung.com, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 01/24] fs: unify locking semantics for fs freeze / thaw
Message-ID: <20230116151455.lsggdn64jecwh36o@quack3>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114003409.1168311-2-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 13-01-23 16:33:46, Luis Chamberlain wrote:
> Right now freeze_super()  and thaw_super() are called with
> different locking contexts. To expand on this is messy, so
> just unify the requirement to require grabbing an active
> reference and keep the superblock locked.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

The cleanup is nice but now freeze_super() does not increment s_active
anymore so nothing prevents the superblock from being torn down while it is
frozen. This is a behavioral change that needs documenting in the changelog
if nothing else but I think it may be actually problematic if the
filesystem's ->put_super method gets called on frozen filesystem. So I
think we may need to also block attempts to unmount frozen filesystem -
actually GFS2 needs this as well [1].

								Honza

[1] lore.kernel.org/r/20221129230736.3462830-1-agruenba@redhat.com

> ---
>  block/bdev.c    |  5 ++++-
>  fs/f2fs/gc.c    |  5 +++++
>  fs/gfs2/super.c |  9 +++++++--
>  fs/gfs2/sys.c   |  6 ++++++
>  fs/gfs2/util.c  |  5 +++++
>  fs/ioctl.c      | 12 ++++++++++--
>  fs/super.c      | 51 ++++++++++++++-----------------------------------
>  7 files changed, 51 insertions(+), 42 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index edc110d90df4..8fd3a7991c02 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -251,7 +251,7 @@ int freeze_bdev(struct block_device *bdev)
>  		error = sb->s_op->freeze_super(sb);
>  	else
>  		error = freeze_super(sb);
> -	deactivate_super(sb);
> +	deactivate_locked_super(sb);
>  
>  	if (error) {
>  		bdev->bd_fsfreeze_count--;
> @@ -289,6 +289,8 @@ int thaw_bdev(struct block_device *bdev)
>  	sb = bdev->bd_fsfreeze_sb;
>  	if (!sb)
>  		goto out;
> +	if (!get_active_super(bdev))
> +		goto out;
>  
>  	if (sb->s_op->thaw_super)
>  		error = sb->s_op->thaw_super(sb);
> @@ -298,6 +300,7 @@ int thaw_bdev(struct block_device *bdev)
>  		bdev->bd_fsfreeze_count++;
>  	else
>  		bdev->bd_fsfreeze_sb = NULL;
> +	deactivate_locked_super(sb);
>  out:
>  	mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  	return error;
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 7444c392eab1..4c681fe487ee 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2139,7 +2139,10 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  	if (err)
>  		return err;
>  
> +	if (!get_active_super(sbi->sb->s_bdev))
> +		return -ENOTTY;
>  	freeze_super(sbi->sb);
> +
>  	f2fs_down_write(&sbi->gc_lock);
>  	f2fs_down_write(&sbi->cp_global_sem);
>  
> @@ -2190,6 +2193,8 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  out_err:
>  	f2fs_up_write(&sbi->cp_global_sem);
>  	f2fs_up_write(&sbi->gc_lock);
> +	/* We use the same active reference from freeze */
>  	thaw_super(sbi->sb);
> +	deactivate_locked_super(sbi->sb);
>  	return err;
>  }
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 999cc146d708..48df7b276b64 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -661,7 +661,12 @@ void gfs2_freeze_func(struct work_struct *work)
>  	struct gfs2_sbd *sdp = container_of(work, struct gfs2_sbd, sd_freeze_work);
>  	struct super_block *sb = sdp->sd_vfs;
>  
> -	atomic_inc(&sb->s_active);
> +	if (!get_active_super(sb->s_bdev)) {
> +		fs_info(sdp, "GFS2: couldn't grap super for thaw for filesystem\n");
> +		gfs2_assert_withdraw(sdp, 0);
> +		return;
> +	}
> +
>  	error = gfs2_freeze_lock(sdp, &freeze_gh, 0);
>  	if (error) {
>  		gfs2_assert_withdraw(sdp, 0);
> @@ -675,7 +680,7 @@ void gfs2_freeze_func(struct work_struct *work)
>  		}
>  		gfs2_freeze_unlock(&freeze_gh);
>  	}
> -	deactivate_super(sb);
> +	deactivate_locked_super(sb);
>  	clear_bit_unlock(SDF_FS_FROZEN, &sdp->sd_flags);
>  	wake_up_bit(&sdp->sd_flags, SDF_FS_FROZEN);
>  	return;
> diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
> index d87ea98cf535..d0b80552a678 100644
> --- a/fs/gfs2/sys.c
> +++ b/fs/gfs2/sys.c
> @@ -162,6 +162,9 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	if (!get_active_super(sb->s_bdev))
> +		return -ENOTTY;
> +
>  	switch (n) {
>  	case 0:
>  		error = thaw_super(sdp->sd_vfs);
> @@ -170,9 +173,12 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
>  		error = freeze_super(sdp->sd_vfs);
>  		break;
>  	default:
> +		deactivate_locked_super(sb);
>  		return -EINVAL;
>  	}
>  
> +	deactivate_locked_super(sb);
> +
>  	if (error) {
>  		fs_warn(sdp, "freeze %d error %d\n", n, error);
>  		return error;
> diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
> index 7a6aeffcdf5c..3a0cd5e9ad84 100644
> --- a/fs/gfs2/util.c
> +++ b/fs/gfs2/util.c
> @@ -345,10 +345,15 @@ int gfs2_withdraw(struct gfs2_sbd *sdp)
>  	set_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
>  
>  	if (sdp->sd_args.ar_errors == GFS2_ERRORS_WITHDRAW) {
> +		if (!get_active_super(sb->s_bdev)) {
> +			fs_err(sdp, "could not grab super on withdraw for file system\n");
> +			return -1;
> +		}
>  		fs_err(sdp, "about to withdraw this file system\n");
>  		BUG_ON(sdp->sd_args.ar_debug);
>  
>  		signal_our_withdraw(sdp);
> +		deactivate_locked_super(sb);
>  
>  		kobject_uevent(&sdp->sd_kobj, KOBJ_OFFLINE);
>  
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 80ac36aea913..3d2536e1ea58 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -386,6 +386,7 @@ static int ioctl_fioasync(unsigned int fd, struct file *filp,
>  static int ioctl_fsfreeze(struct file *filp)
>  {
>  	struct super_block *sb = file_inode(filp)->i_sb;
> +	int ret;
>  
>  	if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
> @@ -394,10 +395,17 @@ static int ioctl_fsfreeze(struct file *filp)
>  	if (sb->s_op->freeze_fs == NULL && sb->s_op->freeze_super == NULL)
>  		return -EOPNOTSUPP;
>  
> +	if (!get_active_super(sb->s_bdev))
> +		return -ENOTTY;
> +
>  	/* Freeze */
>  	if (sb->s_op->freeze_super)
> -		return sb->s_op->freeze_super(sb);
> -	return freeze_super(sb);
> +		ret = sb->s_op->freeze_super(sb);
> +	ret = freeze_super(sb);
> +
> +	deactivate_locked_super(sb);
> +
> +	return ret;
>  }
>  
>  static int ioctl_fsthaw(struct file *filp)
> diff --git a/fs/super.c b/fs/super.c
> index 12c08cb20405..a31a41b313f3 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -39,8 +39,6 @@
>  #include <uapi/linux/mount.h>
>  #include "internal.h"
>  
> -static int thaw_super_locked(struct super_block *sb);
> -
>  static LIST_HEAD(super_blocks);
>  static DEFINE_SPINLOCK(sb_lock);
>  
> @@ -830,7 +828,6 @@ struct super_block *get_active_super(struct block_device *bdev)
>  		if (sb->s_bdev == bdev) {
>  			if (!grab_super(sb))
>  				goto restart;
> -			up_write(&sb->s_umount);
>  			return sb;
>  		}
>  	}
> @@ -1003,13 +1000,13 @@ void emergency_remount(void)
>  
>  static void do_thaw_all_callback(struct super_block *sb)
>  {
> -	down_write(&sb->s_umount);
> +	if (!get_active_super(sb->s_bdev))
> +		return;
>  	if (sb->s_root && sb->s_flags & SB_BORN) {
>  		emergency_thaw_bdev(sb);
> -		thaw_super_locked(sb);
> -	} else {
> -		up_write(&sb->s_umount);
> +		thaw_super(sb);
>  	}
> +	deactivate_locked_super(sb);
>  }
>  
>  static void do_thaw_all(struct work_struct *work)
> @@ -1651,22 +1648,15 @@ int freeze_super(struct super_block *sb)
>  {
>  	int ret;
>  
> -	atomic_inc(&sb->s_active);
> -	down_write(&sb->s_umount);
> -	if (sb->s_writers.frozen != SB_UNFROZEN) {
> -		deactivate_locked_super(sb);
> +	if (sb->s_writers.frozen != SB_UNFROZEN)
>  		return -EBUSY;
> -	}
>  
> -	if (!(sb->s_flags & SB_BORN)) {
> -		up_write(&sb->s_umount);
> +	if (!(sb->s_flags & SB_BORN))
>  		return 0;	/* sic - it's "nothing to do" */
> -	}
>  
>  	if (sb_rdonly(sb)) {
>  		/* Nothing to do really... */
>  		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
> -		up_write(&sb->s_umount);
>  		return 0;
>  	}
>  
> @@ -1686,7 +1676,6 @@ int freeze_super(struct super_block *sb)
>  		sb->s_writers.frozen = SB_UNFROZEN;
>  		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
>  		wake_up(&sb->s_writers.wait_unfrozen);
> -		deactivate_locked_super(sb);
>  		return ret;
>  	}
>  
> @@ -1702,7 +1691,6 @@ int freeze_super(struct super_block *sb)
>  			sb->s_writers.frozen = SB_UNFROZEN;
>  			sb_freeze_unlock(sb, SB_FREEZE_FS);
>  			wake_up(&sb->s_writers.wait_unfrozen);
> -			deactivate_locked_super(sb);
>  			return ret;
>  		}
>  	}
> @@ -1712,19 +1700,22 @@ int freeze_super(struct super_block *sb)
>  	 */
>  	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
>  	lockdep_sb_freeze_release(sb);
> -	up_write(&sb->s_umount);
>  	return 0;
>  }
>  EXPORT_SYMBOL(freeze_super);
>  
> -static int thaw_super_locked(struct super_block *sb)
> +/**
> + * thaw_super -- unlock filesystem
> + * @sb: the super to thaw
> + *
> + * Unlocks the filesystem and marks it writeable again after freeze_super().
> + */
> +int thaw_super(struct super_block *sb)
>  {
>  	int error;
>  
> -	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
> -		up_write(&sb->s_umount);
> +	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
>  		return -EINVAL;
> -	}
>  
>  	if (sb_rdonly(sb)) {
>  		sb->s_writers.frozen = SB_UNFROZEN;
> @@ -1739,7 +1730,6 @@ static int thaw_super_locked(struct super_block *sb)
>  			printk(KERN_ERR
>  				"VFS:Filesystem thaw failed\n");
>  			lockdep_sb_freeze_release(sb);
> -			up_write(&sb->s_umount);
>  			return error;
>  		}
>  	}
> @@ -1748,19 +1738,6 @@ static int thaw_super_locked(struct super_block *sb)
>  	sb_freeze_unlock(sb, SB_FREEZE_FS);
>  out:
>  	wake_up(&sb->s_writers.wait_unfrozen);
> -	deactivate_locked_super(sb);
>  	return 0;
>  }
> -
> -/**
> - * thaw_super -- unlock filesystem
> - * @sb: the super to thaw
> - *
> - * Unlocks the filesystem and marks it writeable again after freeze_super().
> - */
> -int thaw_super(struct super_block *sb)
> -{
> -	down_write(&sb->s_umount);
> -	return thaw_super_locked(sb);
> -}
>  EXPORT_SYMBOL(thaw_super);
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
