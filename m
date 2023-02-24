Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4046A1530
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 04:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjBXDIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 22:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXDIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:08:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8BB13D67;
        Thu, 23 Feb 2023 19:08:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69656B81B2F;
        Fri, 24 Feb 2023 03:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC8EC433EF;
        Fri, 24 Feb 2023 03:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677208118;
        bh=SKEHNTA6t6YQ9jf91V+8uG02ByTzCTWpiRifPzpshnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cjp8H5SkSXl6Oz1HeLzRWnGv8oJrME4TGiex3o6tXMuLaf3wlfH5RLyDeqpLg0LGv
         VBX1GfIbuS6UOEoKCweMKtKl8ldPecN47CSlJURg6w9VYZBKFl5hYEkQqREIEpoRc/
         9J/jymOubdypv6s0cXcEGoANZola2HicYXw6Spqok23by9xtu76D8kKYY0kXsQi7uU
         89OhW8BxxAA3XnuwsDZsPbhAiQukblUkUCBiUzB9v5aZcln1e0YL23ExWHt06OwQ3C
         ye1wslat5sIsGyHZu3dkD4POX+m3tR5NHA2Mv7z/XRtXhh4/spcsfF6fbFLrDiKSqt
         fMaV9IpE91C5w==
Date:   Thu, 23 Feb 2023 19:08:37 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, song@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, p.raghav@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 05/24] fs: add automatic kernel fs freeze / thaw and
 remove kthread freezing
Message-ID: <Y/gqNaP4mrSMaDJo@magnolia>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114003409.1168311-6-mcgrof@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 13, 2023 at 04:33:50PM -0800, Luis Chamberlain wrote:
> Add support to automatically handle freezing and thawing filesystems
> during the kernel's suspend/resume cycle.
> 
> This is needed so that we properly really stop IO in flight without
> races after userspace has been frozen. Without this we rely on
> kthread freezing and its semantics are loose and error prone.
> For instance, even though a kthread may use try_to_freeze() and end
> up being frozen we have no way of being sure that everything that
> has been spawned asynchronously from it (such as timers) have also
> been stopped as well.
> 
> A long term advantage of also adding filesystem freeze / thawing
> supporting during suspend / hibernation is that long term we may
> be able to eventually drop the kernel's thread freezing completely
> as it was originally added to stop disk IO in flight as we hibernate
> or suspend.

Hooray!

One evil question though --

Say you have dm devices A and B.  Each has a distinct fs on it.
If you mount A and then B and initiate a suspend, that should result in
first B and then A freezing, right?

After resuming, you then change A's dm-table definition to point it
at a loop device backed by a file on B.

What happens now when you initiate a suspend?  B freezes, then A tries
to flush data to the loop-mounted file on B, but it's too late for that.
That sounds like a deadlock?

Though I don't know how much we care about this corner case, since (a)
freezing has been busted on xfs for years and (b) one can think up all
sorts of horrid ouroborous scenarios like:

Change A's dm-table to point to a loop-mounted file on B, and changing B
to point to a loop-mounted file on A.  Then try to write to either
filesystem and see what kind of storm you get.

Anyway, just wondering if you'd thought about that kind of doomsday
scenario that a nutty sysadmin could set up.

The only way I can think of to solve that kind of thing would be to hook
filesystems and loop devices into the device model, make fs "device"
suspend actually freeze, hope the suspend code suspends from the leaves
inward, and hope I actually understand how the device model works (I
don't.)

--D

> This does not remove the superflous freezer calls on all filesystems.
> Each filesystem must remove all the kthread freezer stuff and peg
> the fs_type flags as supporting auto-freezing with the FS_AUTOFREEZE
> flag.
> 
> Subsequent patches remove the kthread freezer usage from each
> filesystem, one at a time to make all this work bisectable.
> Once all filesystems remove the usage of the kthread freezer we
> can remove the FS_AUTOFREEZE flag.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/super.c             | 69 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h     | 14 +++++++++
>  kernel/power/process.c | 15 ++++++++-
>  3 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 2f77fcb6e555..e8af4c8269ad 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1853,3 +1853,72 @@ int thaw_super(struct super_block *sb, bool usercall)
>  	return 0;
>  }
>  EXPORT_SYMBOL(thaw_super);
> +
> +#ifdef CONFIG_PM_SLEEP
> +static bool super_should_freeze(struct super_block *sb)
> +{
> +	if (!(sb->s_type->fs_flags & FS_AUTOFREEZE))
> +		return false;
> +	/*
> +	 * We don't freeze virtual filesystems, we skip those filesystems with
> +	 * no backing device.
> +	 */
> +	if (sb->s_bdi == &noop_backing_dev_info)
> +		return false;
> +
> +	return true;
> +}
> +
> +int fs_suspend_freeze_sb(struct super_block *sb, void *priv)
> +{
> +	int error = 0;
> +
> +	if (!grab_lock_super(sb)) {
> +		pr_err("%s (%s): freezing failed to grab_super()\n",
> +		       sb->s_type->name, sb->s_id);
> +		return -ENOTTY;
> +	}
> +
> +	if (!super_should_freeze(sb))
> +		goto out;
> +
> +	pr_info("%s (%s): freezing\n", sb->s_type->name, sb->s_id);
> +
> +	error = freeze_super(sb, false);
> +	if (!error)
> +		lockdep_sb_freeze_release(sb);
> +	else if (error != -EBUSY)
> +		pr_notice("%s (%s): Unable to freeze, error=%d",
> +			  sb->s_type->name, sb->s_id, error);
> +
> +out:
> +	deactivate_locked_super(sb);
> +	return error;
> +}
> +
> +int fs_suspend_thaw_sb(struct super_block *sb, void *priv)
> +{
> +	int error = 0;
> +
> +	if (!grab_lock_super(sb)) {
> +		pr_err("%s (%s): thawing failed to grab_super()\n",
> +		       sb->s_type->name, sb->s_id);
> +		return -ENOTTY;
> +	}
> +
> +	if (!super_should_freeze(sb))
> +		goto out;
> +
> +	pr_info("%s (%s): thawing\n", sb->s_type->name, sb->s_id);
> +
> +	error = thaw_super(sb, false);
> +	if (error && error != -EBUSY)
> +		pr_notice("%s (%s): Unable to unfreeze, error=%d",
> +			  sb->s_type->name, sb->s_id, error);
> +
> +out:
> +	deactivate_locked_super(sb);
> +	return error;
> +}
> +
> +#endif
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f168e72f6ca1..e5bee359e804 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2231,6 +2231,7 @@ struct file_system_type {
>  #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
>  #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
> +#define FS_AUTOFREEZE           (1<<16)	/*  temporary as we phase kthread freezer out */
>  	int (*init_fs_context)(struct fs_context *);
>  	const struct fs_parameter_spec *parameters;
>  	struct dentry *(*mount) (struct file_system_type *, int,
> @@ -2306,6 +2307,19 @@ extern int user_statfs(const char __user *, struct kstatfs *);
>  extern int fd_statfs(int, struct kstatfs *);
>  extern int freeze_super(struct super_block *super, bool usercall);
>  extern int thaw_super(struct super_block *super, bool usercall);
> +#ifdef CONFIG_PM_SLEEP
> +int fs_suspend_freeze_sb(struct super_block *sb, void *priv);
> +int fs_suspend_thaw_sb(struct super_block *sb, void *priv);
> +#else
> +static inline int fs_suspend_freeze_sb(struct super_block *sb, void *priv)
> +{
> +	return 0;
> +}
> +static inline int fs_suspend_thaw_sb(struct super_block *sb, void *priv)
> +{
> +	return 0;
> +}
> +#endif
>  extern __printf(2, 3)
>  int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
>  extern int super_setup_bdi(struct super_block *sb);
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 6c1c7e566d35..1dd6b0b6b4e5 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -140,6 +140,16 @@ int freeze_processes(void)
>  
>  	BUG_ON(in_atomic());
>  
> +	pr_info("Freezing filesystems ... ");
> +	error = iterate_supers_reverse_excl(fs_suspend_freeze_sb, NULL);
> +	if (error) {
> +		pr_cont("failed\n");
> +		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
> +		thaw_processes();
> +		return error;
> +	}
> +	pr_cont("done.\n");
> +
>  	/*
>  	 * Now that the whole userspace is frozen we need to disable
>  	 * the OOM killer to disallow any further interference with
> @@ -149,8 +159,10 @@ int freeze_processes(void)
>  	if (!error && !oom_killer_disable(msecs_to_jiffies(freeze_timeout_msecs)))
>  		error = -EBUSY;
>  
> -	if (error)
> +	if (error) {
> +		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
>  		thaw_processes();
> +	}
>  	return error;
>  }
>  
> @@ -188,6 +200,7 @@ void thaw_processes(void)
>  	pm_nosig_freezing = false;
>  
>  	oom_killer_enable();
> +	iterate_supers_excl(fs_suspend_thaw_sb, NULL);
>  
>  	pr_info("Restarting tasks ... ");
>  
> -- 
> 2.35.1
> 
