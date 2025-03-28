Return-Path: <linux-fsdevel+bounces-45195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0098A74776
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 11:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37381670E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 10:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B9E218AD1;
	Fri, 28 Mar 2025 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNIRn0zt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE9A8F49;
	Fri, 28 Mar 2025 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156529; cv=none; b=ZBlbYLaQJQFeYxX+pkS1nLaXiTDywP1R1IdsAILWMlhwrJ1Isz5bkNSbw3v+v5ylpvxQCH1mBBSLBK2dLCb3lQ9u9ATaK5J6PAPvU2h1LkDf/7S7SA+mApC+IB8h+PwjN43vLBEhAm2Ugb/znAvluSKvAe47+BUx7gg67v7tsPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156529; c=relaxed/simple;
	bh=IBuL6oupYPuyrk5jIWUB08viJ0WBV7MJZMOTCmCa2fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bg5EI0Lh/eZq4bU9H1NGNJ7S7pwKEXx+YhayR4qlMYgqYuroKBqIP0S55K9KF4tsGhke6SxJ5VSo1JU+aUly0+HsoejoLZ0LgwaI/u2tddifvM1AO5BMio8H1gk5RnNj8RkjtcFGqhvanJaUuZhvCOgF1hao1AtHSBHwY/LpgF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNIRn0zt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DD9C4CEE4;
	Fri, 28 Mar 2025 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743156528;
	bh=IBuL6oupYPuyrk5jIWUB08viJ0WBV7MJZMOTCmCa2fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNIRn0ztsmG6A2lCuSoKejY7pCxRjxW00Ehvcn9L9dnuaDlWq8edGfv/DWfGJ66fK
	 QY6Zq120S2SQW8fSbwN7m0Q7qN0wwh91wc2O3E8y3YLFKJS7uC8ulxnp67fRHuMsYL
	 amyfdFvSXRFSAbpTz+n+40pEMinlemVFHeTUUKcRdReVmKK4BqoJQ9/3GSoyj7Lkq/
	 yA732YhNzd/iumvbiDOr5txCLFnfw6QTjCWU1VpHAbG//UlG93cQxdWqRMKSnDOUj3
	 ZLIeZ6obZW226mKEncxMcuyM/LSZWJv9oGA3u+NWqwiIKCwb4B/bf5BLCKxF3xt0TI
	 tAplIIU7+vT4Q==
Date: Fri, 28 Mar 2025 11:08:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, jack@suse.cz, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [RFC PATCH 4/4] vfs: add filesystem freeze/thaw callbacks for
 power management
Message-ID: <20250328-luxus-zinspolitik-835cc75fbad5@brauner>
References: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
 <20250327140613.25178-5-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327140613.25178-5-James.Bottomley@HansenPartnership.com>

On Thu, Mar 27, 2025 at 10:06:13AM -0400, James Bottomley wrote:
> Introduce a freeze function, which iterates superblocks in reverse
> order freezing filesystems.  The indicator a filesystem is freezable
> is either possessing a s_bdev or a freeze_super method.  So this can
> be used in efivarfs, whether the freeze is for hibernate is also
> passed in via the new FREEZE_FOR_HIBERNATE flag.
> 
> Thawing is done opposite to freezing (so superblock traversal in
> regular order) and the whole thing is plumbed into power management.
> The original ksys_sync() is preserved so the whole freezing step is
> optional (if it fails we're no worse off than we are today) so it
> doesn't inhibit suspend/hibernate if there's a failure.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  fs/super.c               | 61 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h       |  5 ++++
>  kernel/power/hibernate.c | 12 ++++++++
>  kernel/power/suspend.c   |  4 +++
>  4 files changed, 82 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 76785509d906..b4b0986414b0 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1461,6 +1461,67 @@ static struct super_block *get_bdev_super(struct block_device *bdev)
>  	return sb;
>  }
>  
> +/*
> + * Kernel freezing and thawing is only done in the power management
> + * subsystem and is thus single threaded (so we don't have to worry
> + * here about multiple calls to filesystems_freeze/thaw().
> + */
> +
> +static int freeze_flags;

Ugh, please don't use a global flag for this.

> +
> +static void filesystems_freeze_callback(struct super_block *sb)
> +{
> +	/* errors don't fail suspend so ignore them */
> +	if (sb->s_op->freeze_super)
> +		sb->s_op->freeze_super(sb, FREEZE_MAY_NEST
> +				       | FREEZE_HOLDER_KERNEL
> +				       | freeze_flags);
> +	else if (sb->s_bdev)
> +		freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL
> +			     | freeze_flags);
> +	else {
> +		pr_info("Ignoring filesystem %s\n", sb->s_type->name);
> +		return;
> +	}
> +
> +	pr_info("frozen %s, now syncing block ...", sb->s_type->name);
> +	sync_blockdev(sb->s_bdev);
> +	pr_info("done.");
> +}
> +
> +/**
> + * filesystems_freeze - freeze callback for power management
> + *
> + * Freeze all active filesystems (in reverse superblock order)
> + */
> +void filesystems_freeze(bool for_hibernate)
> +{
> +	freeze_flags = for_hibernate ? FREEZE_FOR_HIBERNATE : 0;
> +	__iterate_supers_rev(filesystems_freeze_callback);
> +}
> +
> +static void filesystems_thaw_callback(struct super_block *sb)
> +{
> +	if (sb->s_op->thaw_super)
> +		sb->s_op->thaw_super(sb, FREEZE_MAY_NEST
> +				     | FREEZE_HOLDER_KERNEL
> +				     | freeze_flags);
> +	else if (sb->s_bdev)
> +		thaw_super(sb,	FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL
> +			   | freeze_flags);
> +}
> +
> +/**
> + * filesystems_thaw - thaw callback for power management
> + *
> + * Thaw all active filesystems (in forward superblock order)
> + */
> +void filesystems_thaw(bool for_hibernate)
> +{
> +	freeze_flags = for_hibernate ? FREEZE_FOR_HIBERNATE : 0;
> +	__iterate_supers(filesystems_thaw_callback);

This doesn't work and I've explained in my reply to Luis how this
doesn't work and what the alternative are:

A concurrent umount() can wipe the filesystem behind your back. So you
either need an active superblock reference or you need to communicate
that the superblock is locked through the new flag I proposed (naming
irrelevant for now).

> +}
> +
>  /**
>   * fs_bdev_freeze - freeze owning filesystem of block device
>   * @bdev: block device
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index cbbb704eff74..de154e9379ec 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2272,6 +2272,7 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
>   * @FREEZE_HOLDER_KERNEL: kernel wants to freeze or thaw filesystem
>   * @FREEZE_HOLDER_USERSPACE: userspace wants to freeze or thaw filesystem
>   * @FREEZE_MAY_NEST: whether nesting freeze and thaw requests is allowed
> + * @FREEZE_FOR_HIBERNATE: set if freeze is from power management hibernate
>   *
>   * Indicate who the owner of the freeze or thaw request is and whether
>   * the freeze needs to be exclusive or can nest.
> @@ -2285,6 +2286,7 @@ enum freeze_holder {
>  	FREEZE_HOLDER_KERNEL	= (1U << 0),
>  	FREEZE_HOLDER_USERSPACE	= (1U << 1),
>  	FREEZE_MAY_NEST		= (1U << 2),
> +	FREEZE_FOR_HIBERNATE	= (1U << 3),
>  };
>  
>  struct super_operations {
> @@ -3919,4 +3921,7 @@ static inline bool vfs_empty_path(int dfd, const char __user *path)
>  
>  int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
>  
> +void filesystems_freeze(bool for_hibernate);
> +void filesystems_thaw(bool for_hibernate);
> +
>  #endif /* _LINUX_FS_H */
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 10a01af63a80..fc2106e6685a 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -778,7 +778,12 @@ int hibernate(void)
>  
>  	ksys_sync_helper();
>  
> +	pr_info("about to freeze filesystems\n");
> +	filesystems_freeze(true);
> +	pr_info("filesystem freeze done\n");
> +
>  	error = freeze_processes();
> +	pr_info("process freeze done\n");
>  	if (error)
>  		goto Exit;
>  
> @@ -788,7 +793,9 @@ int hibernate(void)
>  	if (error)
>  		goto Thaw;
>  
> +	pr_info("About to create snapshot\n");
>  	error = hibernation_snapshot(hibernation_mode == HIBERNATION_PLATFORM);
> +	pr_info("snapshot done\n");
>  	if (error || freezer_test_done)
>  		goto Free_bitmaps;
>  
> @@ -842,6 +849,8 @@ int hibernate(void)
>  	}
>  	thaw_processes();
>  
> +	filesystems_thaw(true);
> +
>  	/* Don't bother checking whether freezer_test_done is true */
>  	freezer_test_done = false;
>   Exit:
> @@ -939,6 +948,8 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
>  
>  	thaw_processes();
>  
> +	filesystems_thaw(true);
> +
>  exit:
>  	pm_notifier_call_chain(PM_POST_HIBERNATION);
>  
> @@ -1041,6 +1052,7 @@ static int software_resume(void)
>  
>  	error = load_image_and_restore();
>  	thaw_processes();
> +	filesystems_thaw(true);
>   Finish:
>  	pm_notifier_call_chain(PM_POST_RESTORE);
>   Restore:
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 09f8397bae15..34cc5b0c408c 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -544,6 +544,7 @@ int suspend_devices_and_enter(suspend_state_t state)
>  static void suspend_finish(void)
>  {
>  	suspend_thaw_processes();
> +	filesystems_thaw(false);
>  	pm_notifier_call_chain(PM_POST_SUSPEND);
>  	pm_restore_console();
>  }
> @@ -581,6 +582,7 @@ static int enter_state(suspend_state_t state)
>  		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
>  		ksys_sync_helper();
>  		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> +		filesystems_freeze(false);
>  	}
>  
>  	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
> @@ -603,6 +605,8 @@ static int enter_state(suspend_state_t state)
>  	pm_pr_dbg("Finishing wakeup.\n");
>  	suspend_finish();
>   Unlock:
> +	if (sync_on_suspend_enabled)
> +		filesystems_thaw(false);
>  	mutex_unlock(&system_transition_mutex);
>  	return error;
>  }
> -- 
> 2.43.0
> 

