Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48AD7B075F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjI0Oxx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjI0Oxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:53:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C98219C
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 07:53:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABE4C433C7;
        Wed, 27 Sep 2023 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695826430;
        bh=MjGoV3bLOlCf4bQws7AR3zHLiF38NOhNMVNREDWBB2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KwFU65unGL5A1XjfN3c6bNN4w4VuvhB0tD51jtBLbeQW6lkL9YoeavySyvfBcbw65
         UY4TIUVwGeBXjVOKzV+0frGxTN+epRYWHSmxgXTFXkvRlBK1CCSuChr7+I9RaQvPla
         /ADuYxL79qeMqau3mL3qy0bnMh8TyeIMstuJYBKgB+nh7gmSdJyUuyL/CoQhIxlDBv
         wGOLQvHO6BTm1r2j0z4/1uF0Oairz0YScjFRw4Awl5MFWCKjNGfuLYRTAVbWbChAgE
         RU/RF/H6gGoCV8Fiqdd/R10yYNMkgbxfFLRnpQaiq9png8evFq4cjCYKMSef91RkCF
         kW1TZSpQaWqqw==
Date:   Wed, 27 Sep 2023 07:53:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] bdev: implement freeze and thaw holder operations
Message-ID: <20230927145350.GC11414@frogsfrogsfrogs>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-3-ecc36d9ab4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-vfs-super-freeze-v1-3-ecc36d9ab4d9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:21:16PM +0200, Christian Brauner wrote:
> The old method of implementing block device freeze and thaw operations
> required us to rely on get_active_super() to walk the list of all
> superblocks on the system to find any superblock that might use the
> block device. This is wasteful and not very pleasant overall.
> 
> Now that we can finally go straight from block device to owning
> superblock things become way simpler. In fact, we can even get rid of
> bd_fsfreeze_mutex and rely on the holder lock for freezing.
> 
> We let fs_bdev_thaw() grab its own active reference so we can hold
> bd_holder_lock across freeze and thaw without risk of deadlocks. That in
> turn allows us to get rid of bd_fsfreeze_mutex. This means
> fs_bdev_thaw() might put the last reference to the superblock instead of
> thaw_super(). This shouldn't be an issue. If it turns out to be one we
> can reshuffle the code to simply hold s_umount when thaw_super() returns.
> 
> Thanks to Jan and Christoph who pointed out that bd_fsfreeze_mutex is
> unnecessary now.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  block/bdev.c              | 74 +++++++++++++++++--------------------
>  fs/super.c                | 94 ++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/blk_types.h |  2 +-
>  3 files changed, 119 insertions(+), 51 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 0d27db3e69e7..3deccd0ffcf2 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -222,32 +222,23 @@ EXPORT_SYMBOL(sync_blockdev_range);
>   */
>  int bdev_freeze(struct block_device *bdev)
>  {
> -	struct super_block *sb;
>  	int error = 0;
>  
> -	mutex_lock(&bdev->bd_fsfreeze_mutex);
> -	if (++bdev->bd_fsfreeze_count > 1)
> -		goto done;
> +	mutex_lock(&bdev->bd_holder_lock);
>  
> -	sb = get_active_super(bdev);
> -	if (!sb)
> -		goto sync;
> -	if (sb->s_op->freeze_super)
> -		error = sb->s_op->freeze_super(sb, FREEZE_HOLDER_USERSPACE);
> -	else
> -		error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
> -	deactivate_super(sb);
> +	if (atomic_inc_return(&bdev->bd_fsfreeze_count) > 1) {
> +		mutex_unlock(&bdev->bd_holder_lock);
> +		return 0;
> +	}
>  
> -	if (error) {
> -		bdev->bd_fsfreeze_count--;
> -		goto done;
> +	if (bdev->bd_holder_ops && bdev->bd_holder_ops->freeze) {
> +		error = bdev->bd_holder_ops->freeze(bdev);
> +		lockdep_assert_not_held(&bdev->bd_holder_lock);
> +	} else {
> +		sync_blockdev(bdev);

Why ignore the return value from sync_blockdev?  It calls
filemap_write_and_wait, which clears AS_EIO/AS_ENOSPC from the bdev
mapping, which means that we'll silently drop accumulated IO errors.

> +		mutex_unlock(&bdev->bd_holder_lock);

Also not sure why this fallback case holds bd_holder_lock across the
sync_blockdev but fs_bdev_freeze doesn't?

>  	}
> -	bdev->bd_fsfreeze_sb = sb;
>  
> -sync:
> -	sync_blockdev(bdev);
> -done:
> -	mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  	return error;
>  }
>  EXPORT_SYMBOL(bdev_freeze);
> @@ -262,31 +253,32 @@ EXPORT_SYMBOL(bdev_freeze);
>   */
>  int bdev_thaw(struct block_device *bdev)
>  {
> -	struct super_block *sb;
> -	int error = -EINVAL;
> +	int error = 0, nr_freeze;
>  
> -	mutex_lock(&bdev->bd_fsfreeze_mutex);
> -	if (!bdev->bd_fsfreeze_count)
> -		goto out;
> +	mutex_lock(&bdev->bd_holder_lock);
>  
> -	error = 0;
> -	if (--bdev->bd_fsfreeze_count > 0)
> -		goto out;
> +	/*
> +	 * If this returns < 0 it means that @bd_fsfreeze_count was
> +	 * already 0 and no decrement was performed.
> +	 */
> +	nr_freeze = atomic_dec_if_positive(&bdev->bd_fsfreeze_count);
> +	if (nr_freeze < 0) {
> +		mutex_unlock(&bdev->bd_holder_lock);
> +		return -EINVAL;
> +	}
>  
> -	sb = bdev->bd_fsfreeze_sb;
> -	if (!sb)
> -		goto out;
> +	if (nr_freeze > 0) {
> +		mutex_unlock(&bdev->bd_holder_lock);
> +		return 0;
> +	}
> +
> +	if (bdev->bd_holder_ops && bdev->bd_holder_ops->thaw) {
> +		error = bdev->bd_holder_ops->thaw(bdev);
> +		lockdep_assert_not_held(&bdev->bd_holder_lock);
> +	} else {
> +		mutex_unlock(&bdev->bd_holder_lock);
> +	}
>  
> -	if (sb->s_op->thaw_super)
> -		error = sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE);
> -	else
> -		error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
> -	if (error)
> -		bdev->bd_fsfreeze_count++;
> -	else
> -		bdev->bd_fsfreeze_sb = NULL;
> -out:
> -	mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  	return error;
>  }
>  EXPORT_SYMBOL(bdev_thaw);
> diff --git a/fs/super.c b/fs/super.c
> index e54866345dc7..672f1837fbef 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1469,9 +1469,91 @@ static void fs_bdev_sync(struct block_device *bdev)
>  	super_unlock_shared(sb);
>  }
>  
> +static struct super_block *get_bdev_super(const struct block_device *bdev)
> +{
> +	struct super_block *sb_bdev = bdev->bd_holder, *sb = NULL;
> +
> +	if (!sb_bdev)
> +		return NULL;
> +	if (super_lock_excl(sb_bdev) && atomic_inc_not_zero(&sb_bdev->s_active))
> +		sb = sb_bdev;
> +	super_unlock_excl(sb_bdev);
> +	return sb;
> +}
> +
> +static int fs_bdev_freeze(struct block_device *bdev)
> +	__releases(&bdev->bd_holder_lock)
> +{
> +	struct super_block *sb;
> +	int error = 0;
> +
> +	lockdep_assert_held(&bdev->bd_holder_lock);
> +
> +	sb = get_bdev_super(bdev);
> +	if (sb) {
> +		if (sb->s_op->freeze_super)
> +			error = sb->s_op->freeze_super(sb, FREEZE_HOLDER_USERSPACE);
> +		else
> +			error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
> +		if (error)
> +			atomic_dec(&bdev->bd_fsfreeze_count);
> +	}
> +
> +	/*
> +	 * We have grabbed an active reference which means that the
> +	 * superblock and the block device cannot go away. But we might
> +	 * end up holding the last reference and so end up shutting the
> +	 * superblock down. So drop @bdev->bd_holder_lock to avoid
> +	 * deadlocks with blkdev_put().
> +	 */
> +	mutex_unlock(&bdev->bd_holder_lock);
> +
> +	if (sb)
> +		deactivate_super(sb);
> +
> +	if (!error)
> +		sync_blockdev(bdev);

Same question here about ignoring the return value.

(Everything after this point looks ok to me.)

--D

> +
> +	return error;
> +}
> +
> +static int fs_bdev_thaw(struct block_device *bdev)
> +	__releases(&bdev->bd_holder_lock)
> +{
> +	struct super_block *sb;
> +	int error;
> +
> +	lockdep_assert_held(&bdev->bd_holder_lock);
> +
> +	sb = get_bdev_super(bdev);
> +	if (WARN_ON_ONCE(!sb))
> +		return -EINVAL;
> +
> +	if (sb->s_op->thaw_super)
> +		error = sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE);
> +	else
> +		error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
> +	if (error)
> +		atomic_inc(&bdev->bd_fsfreeze_count);
> +
> +	/*
> +	 * We have grabbed an active reference which means that the
> +	 * superblock and the block device cannot go away. But we might
> +	 * end up holding the last reference and so end up shutting the
> +	 * superblock down. So drop @bdev->bd_holder_lock to avoid
> +	 * deadlocks with blkdev_put().
> +	 */
> +	mutex_unlock(&bdev->bd_holder_lock);
> +	deactivate_super(sb);
> +
> +	return error;
> +}
> +
>  const struct blk_holder_ops fs_holder_ops = {
>  	.mark_dead		= fs_bdev_mark_dead,
>  	.sync			= fs_bdev_sync,
> +	.freeze			= fs_bdev_freeze,
> +	.thaw			= fs_bdev_thaw,
>  };
>  EXPORT_SYMBOL_GPL(fs_holder_ops);
>  
> @@ -1499,15 +1581,10 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
>  	}
>  
>  	/*
> -	 * Until SB_BORN flag is set, there can be no active superblock
> -	 * references and thus no filesystem freezing. get_active_super() will
> -	 * just loop waiting for SB_BORN so even bdev_freeze() cannot proceed.
> -	 *
> -	 * It is enough to check bdev was not frozen before we set s_bdev.
> +	 * It is enough to check bdev was not frozen before we set
> +	 * s_bdev as freezing will wait until SB_BORN is set.
>  	 */
> -	mutex_lock(&bdev->bd_fsfreeze_mutex);
> -	if (bdev->bd_fsfreeze_count > 0) {
> -		mutex_unlock(&bdev->bd_fsfreeze_mutex);
> +	if (atomic_read(&bdev->bd_fsfreeze_count) > 0) {
>  		if (fc)
>  			warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
>  		blkdev_put(bdev, sb);
> @@ -1519,7 +1596,6 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
>  	if (bdev_stable_writes(bdev))
>  		sb->s_iflags |= SB_I_STABLE_WRITES;
>  	spin_unlock(&sb_lock);
> -	mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  
>  	snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
>  	shrinker_debugfs_rename(&sb->s_shrink, "sb-%s:%s", sb->s_type->name,
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index d5c5e59ddbd2..88e1848b0869 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -57,7 +57,7 @@ struct block_device {
>  	const struct blk_holder_ops *bd_holder_ops;
>  	struct mutex		bd_holder_lock;
>  	/* The counter of freeze processes */
> -	int			bd_fsfreeze_count;
> +	atomic_t		bd_fsfreeze_count;
>  	int			bd_holders;
>  	struct kobject		*bd_holder_dir;
>  
> 
> -- 
> 2.34.1
> 
