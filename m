Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6751A66C675
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 17:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjAPQUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 11:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjAPQUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:20:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F72C298DB;
        Mon, 16 Jan 2023 08:10:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 460183787D;
        Mon, 16 Jan 2023 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673885448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hMJYEMaBIkuGunCS1tswoaVbyAM76GcgnbLuoUFTPTA=;
        b=ZKNLDNby5BmgmLlbXRlWtQ0xDtUxkhcAAf7WRlcZqdpxPfmPnLtkkjoZr09ljAfsbv55oT
        qFj9/4WjamEiQll5Wru0F+ITA+a3108X3p0BukhVZLTK8loWcwi8wjGaYH9bcOjPtOSh+/
        Eyl179qiUBhEgrVA/z5aMFnqA3I9YKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673885448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hMJYEMaBIkuGunCS1tswoaVbyAM76GcgnbLuoUFTPTA=;
        b=NSsLu2YvT98HkDAoIGk1uE7k1Tuad3P/G/UMAsQxrESsxHJhdgU+dKgpQNRxCsDnUDPD4g
        Gr4mNJKV4hFbZ0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36783138FE;
        Mon, 16 Jan 2023 16:10:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R+MXDQh3xWMgJAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 16 Jan 2023 16:10:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C4CA5A06AD; Mon, 16 Jan 2023 17:10:47 +0100 (CET)
Date:   Mon, 16 Jan 2023 17:10:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, djwong@kernel.org, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org,
        p.raghav@samsung.com, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 03/24] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230116161047.ozjkneiduspxs24k@quack3>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114003409.1168311-4-mcgrof@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 13-01-23 16:33:48, Luis Chamberlain wrote:
> Userspace can initiate a freeze call using ioctls. If the kernel decides
> to freeze a filesystem later it must be able to distinguish if userspace
> had initiated the freeze, so that it does not unfreeze it later
> automatically on resume.
> 
> Likewise if the kernel is initiating a freeze on its own it should *not*
> fail to freeze a filesystem if a user had already frozen it on our behalf.
> This same concept applies to thawing, even if its not possible for
> userspace to beat the kernel in thawing a filesystem. This logic however
> has never applied to userspace freezing and thawing, two consecutive
> userspace freeze calls will results in only the first one succeeding, so
> we must retain the same behaviour in userspace.
> 
> This doesn't implement yet kernel initiated filesystem freeze calls,
> this will be done in subsequent calls. This change should introduce
> no functional changes, it just extends the definitions of a frozen
> filesystem to account for future kernel initiated filesystem freeze
> and let's us keep record of when userpace initiated it so the kernel
> can respect a userspace initiated freeze upon kernel initiated freeze
> and its respective thaw cycle.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

This is slightly ugly but it should work and I don't have a better solution
so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c       |  4 ++--
>  fs/f2fs/gc.c       |  4 ++--
>  fs/gfs2/glops.c    |  2 +-
>  fs/gfs2/super.c    |  2 +-
>  fs/gfs2/sys.c      |  4 ++--
>  fs/gfs2/util.c     |  2 +-
>  fs/ioctl.c         |  4 ++--
>  fs/super.c         | 31 ++++++++++++++++++++++++++-----
>  include/linux/fs.h | 16 ++++++++++++++--
>  9 files changed, 51 insertions(+), 18 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 8fd3a7991c02..668ebf2015bf 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -250,7 +250,7 @@ int freeze_bdev(struct block_device *bdev)
>  	if (sb->s_op->freeze_super)
>  		error = sb->s_op->freeze_super(sb);
>  	else
> -		error = freeze_super(sb);
> +		error = freeze_super(sb, true);
>  	deactivate_locked_super(sb);
>  
>  	if (error) {
> @@ -295,7 +295,7 @@ int thaw_bdev(struct block_device *bdev)
>  	if (sb->s_op->thaw_super)
>  		error = sb->s_op->thaw_super(sb);
>  	else
> -		error = thaw_super(sb);
> +		error = thaw_super(sb, true);
>  	if (error)
>  		bdev->bd_fsfreeze_count++;
>  	else
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 4c681fe487ee..8eac3042786b 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2141,7 +2141,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  
>  	if (!get_active_super(sbi->sb->s_bdev))
>  		return -ENOTTY;
> -	freeze_super(sbi->sb);
> +	freeze_super(sbi->sb, true);
>  
>  	f2fs_down_write(&sbi->gc_lock);
>  	f2fs_down_write(&sbi->cp_global_sem);
> @@ -2194,7 +2194,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>  	f2fs_up_write(&sbi->cp_global_sem);
>  	f2fs_up_write(&sbi->gc_lock);
>  	/* We use the same active reference from freeze */
> -	thaw_super(sbi->sb);
> +	thaw_super(sbi->sb, true);
>  	deactivate_locked_super(sbi->sb);
>  	return err;
>  }
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index 081422644ec5..62a7e0693efa 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -574,7 +574,7 @@ static int freeze_go_sync(struct gfs2_glock *gl)
>  	if (gl->gl_state == LM_ST_SHARED && !gfs2_withdrawn(sdp) &&
>  	    !test_bit(SDF_NORECOVERY, &sdp->sd_flags)) {
>  		atomic_set(&sdp->sd_freeze_state, SFS_STARTING_FREEZE);
> -		error = freeze_super(sdp->sd_vfs);
> +		error = freeze_super(sdp->sd_vfs, true);
>  		if (error) {
>  			fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n",
>  				error);
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 48df7b276b64..9c55b8042aa4 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -672,7 +672,7 @@ void gfs2_freeze_func(struct work_struct *work)
>  		gfs2_assert_withdraw(sdp, 0);
>  	} else {
>  		atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
> -		error = thaw_super(sb);
> +		error = thaw_super(sb, true);
>  		if (error) {
>  			fs_info(sdp, "GFS2: couldn't thaw filesystem: %d\n",
>  				error);
> diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
> index b98be03d0d1e..69514294215b 100644
> --- a/fs/gfs2/sys.c
> +++ b/fs/gfs2/sys.c
> @@ -167,10 +167,10 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
>  
>  	switch (n) {
>  	case 0:
> -		error = thaw_super(sdp->sd_vfs);
> +		error = thaw_super(sdp->sd_vfs, true);
>  		break;
>  	case 1:
> -		error = freeze_super(sdp->sd_vfs);
> +		error = freeze_super(sdp->sd_vfs, true);
>  		break;
>  	default:
>  		deactivate_locked_super(sb);
> diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
> index 3a0cd5e9ad84..be9705d618ec 100644
> --- a/fs/gfs2/util.c
> +++ b/fs/gfs2/util.c
> @@ -191,7 +191,7 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
>  		/* Make sure gfs2_unfreeze works if partially-frozen */
>  		flush_work(&sdp->sd_freeze_work);
>  		atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
> -		thaw_super(sdp->sd_vfs);
> +		thaw_super(sdp->sd_vfs, true);
>  	} else {
>  		wait_on_bit(&i_gl->gl_flags, GLF_DEMOTE,
>  			    TASK_UNINTERRUPTIBLE);
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 3d2536e1ea58..0ac1622785ad 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -401,7 +401,7 @@ static int ioctl_fsfreeze(struct file *filp)
>  	/* Freeze */
>  	if (sb->s_op->freeze_super)
>  		ret = sb->s_op->freeze_super(sb);
> -	ret = freeze_super(sb);
> +	ret = freeze_super(sb, true);
>  
>  	deactivate_locked_super(sb);
>  
> @@ -418,7 +418,7 @@ static int ioctl_fsthaw(struct file *filp)
>  	/* Thaw */
>  	if (sb->s_op->thaw_super)
>  		return sb->s_op->thaw_super(sb);
> -	return thaw_super(sb);
> +	return thaw_super(sb, true);
>  }
>  
>  static int ioctl_file_dedupe_range(struct file *file,
> diff --git a/fs/super.c b/fs/super.c
> index fdcf5a87af0a..0d6b4de8da88 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1004,7 +1004,7 @@ static void do_thaw_all_callback(struct super_block *sb)
>  		return;
>  	if (sb->s_root && sb->s_flags & SB_BORN) {
>  		emergency_thaw_bdev(sb);
> -		thaw_super(sb);
> +		thaw_super(sb, true);
>  	}
>  	deactivate_locked_super(sb);
>  }
> @@ -1614,6 +1614,8 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
>  /**
>   * freeze_super - lock the filesystem and force it into a consistent state
>   * @sb: the super to lock
> + * @usercall: whether or not userspace initiated this via an ioctl or if it
> + * 	was a kernel freeze
>   *
>   * Syncs the super to make sure the filesystem is consistent and calls the fs's
>   * freeze_fs.  Subsequent calls to this without first thawing the fs will return
> @@ -1644,11 +1646,14 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
>   *
>   * sb->s_writers.frozen is protected by sb->s_umount.
>   */
> -int freeze_super(struct super_block *sb)
> +int freeze_super(struct super_block *sb, bool usercall)
>  {
>  	int ret;
>  
> -	if (sb->s_writers.frozen != SB_UNFROZEN)
> +	if (!usercall && sb_is_frozen(sb))
> +		return 0;
> +
> +	if (!sb_is_unfrozen(sb))
>  		return -EBUSY;
>  
>  	if (!(sb->s_flags & SB_BORN))
> @@ -1657,6 +1662,7 @@ int freeze_super(struct super_block *sb)
>  	if (sb_rdonly(sb)) {
>  		/* Nothing to do really... */
>  		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
> +		sb->s_writers.frozen_by_user = usercall;
>  		return 0;
>  	}
>  
> @@ -1674,6 +1680,7 @@ int freeze_super(struct super_block *sb)
>  	ret = sync_filesystem(sb);
>  	if (ret) {
>  		sb->s_writers.frozen = SB_UNFROZEN;
> +		sb->s_writers.frozen_by_user = false;
>  		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
>  		wake_up(&sb->s_writers.wait_unfrozen);
>  		return ret;
> @@ -1699,6 +1706,7 @@ int freeze_super(struct super_block *sb)
>  	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
>  	 */
>  	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
> +	sb->s_writers.frozen_by_user = usercall;
>  	lockdep_sb_freeze_release(sb);
>  	return 0;
>  }
> @@ -1707,18 +1715,30 @@ EXPORT_SYMBOL(freeze_super);
>  /**
>   * thaw_super -- unlock filesystem
>   * @sb: the super to thaw
> + * @usercall: whether or not userspace initiated this thaw or if it was the
> + * 	kernel which initiated it
>   *
>   * Unlocks the filesystem and marks it writeable again after freeze_super().
>   */
> -int thaw_super(struct super_block *sb)
> +int thaw_super(struct super_block *sb, bool usercall)
>  {
>  	int error;
>  
> -	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
> +	if (!usercall) {
> +		/*
> +		 * If userspace initiated the freeze don't let the kernel
> +		 * thaw it on return from a kernel initiated freeze.
> +		 */
> +		if (sb_is_unfrozen(sb) || sb_is_frozen_by_user(sb))
> +			return 0;
> +	}
> +
> +	if (!sb_is_frozen(sb))
>  		return -EINVAL;
>  
>  	if (sb_rdonly(sb)) {
>  		sb->s_writers.frozen = SB_UNFROZEN;
> +		sb->s_writers.frozen_by_user = false;
>  		goto out;
>  	}
>  
> @@ -1735,6 +1755,7 @@ int thaw_super(struct super_block *sb)
>  	}
>  
>  	sb->s_writers.frozen = SB_UNFROZEN;
> +	sb->s_writers.frozen_by_user = false;
>  	sb_freeze_unlock(sb, SB_FREEZE_FS);
>  out:
>  	wake_up(&sb->s_writers.wait_unfrozen);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c0cab61f9f9a..3b2586de4364 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1129,6 +1129,7 @@ enum {
>  
>  struct sb_writers {
>  	int				frozen;		/* Is sb frozen? */
> +	bool				frozen_by_user;	/* User freeze? */
>  	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
>  	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
>  };
> @@ -1615,6 +1616,17 @@ static inline bool sb_is_frozen(struct super_block *sb)
>  	return sb->s_writers.frozen == SB_FREEZE_COMPLETE;
>  }
>  
> +/**
> + * sb_is_frozen_by_user - was the superblock frozen by userspace?
> + * @sb: the super to check
> + *
> + * Returns true if the super is frozen by userspace, such as an ioctl.
> + */
> +static inline bool sb_is_frozen_by_user(struct super_block *sb)
> +{
> +	return sb_is_frozen(sb) && sb->s_writers.frozen_by_user;
> +}
> +
>  /**
>   * sb_is_unfrozen - is superblock unfrozen
>   * @sb: the super to check
> @@ -2292,8 +2304,8 @@ extern int unregister_filesystem(struct file_system_type *);
>  extern int vfs_statfs(const struct path *, struct kstatfs *);
>  extern int user_statfs(const char __user *, struct kstatfs *);
>  extern int fd_statfs(int, struct kstatfs *);
> -extern int freeze_super(struct super_block *super);
> -extern int thaw_super(struct super_block *super);
> +extern int freeze_super(struct super_block *super, bool usercall);
> +extern int thaw_super(struct super_block *super, bool usercall);
>  extern __printf(2, 3)
>  int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
>  extern int super_setup_bdi(struct super_block *sb);
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
