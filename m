Return-Path: <linux-fsdevel+bounces-1105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADC97D55CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 17:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82579B210EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE07136B11;
	Tue, 24 Oct 2023 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHHT/aik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D836AF1
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 15:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFF8C433CB;
	Tue, 24 Oct 2023 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698160883;
	bh=diRIqzns8cGInBmK8QGxtNLVvA8aB/f6LwwKDgHSTWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHHT/aikLgR86SQ7+bcVJkGg8Qyq9wKbKEYJhWTms93rlaukf6dmOXhjRUgyDx+W6
	 IlRIMj8egnHIsMReJYIHH8j7pcSjTp5vaach/tZgwgeqrcz0UnDU/JKjxRu6429DUr
	 +R6sU1aKSVDl9FTfZHKu3yW6n2zA6hEvNsOqif/0sRXO24MsnJ9jnVqGNuM0Uu13VG
	 mTlFbdfFh8b8A6Fg3IAbnzNJgoqw544sWpGpn8ZsEq1rXq3dDPssf75SgkAEI3ST6t
	 GK6CCHDZ3ZY6gN6Qo9Tg7qWcp2zy8T3OMcmhKwr1q5fwxwLKdmCSnf5DrVKST+RWa0
	 8/qJ1WlXUgnFQ==
Date: Tue, 24 Oct 2023 08:21:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] bdev: implement freeze and thaw holder
 operations
Message-ID: <20231024152122.GH11424@frogsfrogsfrogs>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
 <20231024-vfs-super-freeze-v2-5-599c19f4faac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-freeze-v2-5-599c19f4faac@kernel.org>

On Tue, Oct 24, 2023 at 03:01:11PM +0200, Christian Brauner wrote:
> The old method of implementing block device freeze and thaw operations
> required us to rely on get_active_super() to walk the list of all
> superblocks on the system to find any superblock that might use the
> block device. This is wasteful and not very pleasant overall.
> 
> Now that we can finally go straight from block device to owning
> superblock things become way simpler.
> 
> Link: https://lore.kernel.org/r/20230927-vfs-super-freeze-v1-3-ecc36d9ab4d9@kernel.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good now,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  block/bdev.c              |  62 +++++++++++------------
>  fs/super.c                | 124 ++++++++++++++++++++++++++++++++++++----------
>  include/linux/blk_types.h |   2 +-
>  3 files changed, 128 insertions(+), 60 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index a3e2af580a73..9deacd346192 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -222,31 +222,24 @@ EXPORT_SYMBOL(sync_blockdev_range);
>   */
>  int bdev_freeze(struct block_device *bdev)
>  {
> -	struct super_block *sb;
>  	int error = 0;
>  
>  	mutex_lock(&bdev->bd_fsfreeze_mutex);
> -	if (++bdev->bd_fsfreeze_count > 1)
> -		goto done;
> -
> -	sb = get_active_super(bdev);
> -	if (!sb)
> -		goto sync;
> -	if (sb->s_op->freeze_super)
> -		error = sb->s_op->freeze_super(sb, FREEZE_HOLDER_USERSPACE);
> -	else
> -		error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
> -	deactivate_super(sb);
>  
> -	if (error) {
> -		bdev->bd_fsfreeze_count--;
> -		goto done;
> +	if (atomic_inc_return(&bdev->bd_fsfreeze_count) > 1) {
> +		mutex_unlock(&bdev->bd_fsfreeze_mutex);
> +		return 0;
> +	}
> +
> +	mutex_lock(&bdev->bd_holder_lock);
> +	if (bdev->bd_holder_ops && bdev->bd_holder_ops->freeze) {
> +		error = bdev->bd_holder_ops->freeze(bdev);
> +		lockdep_assert_not_held(&bdev->bd_holder_lock);
> +	} else {
> +		mutex_unlock(&bdev->bd_holder_lock);
> +		error = sync_blockdev(bdev);
>  	}
> -	bdev->bd_fsfreeze_sb = sb;
>  
> -sync:
> -	error = sync_blockdev(bdev);
> -done:
>  	mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  	return error;
>  }
> @@ -262,29 +255,30 @@ EXPORT_SYMBOL(bdev_freeze);
>   */
>  int bdev_thaw(struct block_device *bdev)
>  {
> -	struct super_block *sb;
> -	int error = -EINVAL;
> +	int error = -EINVAL, nr_freeze;
>  
>  	mutex_lock(&bdev->bd_fsfreeze_mutex);
> -	if (!bdev->bd_fsfreeze_count)
> +
> +	/*
> +	 * If this returns < 0 it means that @bd_fsfreeze_count was
> +	 * already 0 and no decrement was performed.
> +	 */
> +	nr_freeze = atomic_dec_if_positive(&bdev->bd_fsfreeze_count);
> +	if (nr_freeze < 0)
>  		goto out;
>  
>  	error = 0;
> -	if (--bdev->bd_fsfreeze_count > 0)
> +	if (nr_freeze > 0)
>  		goto out;
>  
> -	sb = bdev->bd_fsfreeze_sb;
> -	if (!sb)
> -		goto out;
> +	mutex_lock(&bdev->bd_holder_lock);
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
>  out:
>  	mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  	return error;
> diff --git a/fs/super.c b/fs/super.c
> index b224182f2440..ee0795ce09c7 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1430,14 +1430,8 @@ struct super_block *sget_dev(struct fs_context *fc, dev_t dev)
>  EXPORT_SYMBOL(sget_dev);
>  
>  #ifdef CONFIG_BLOCK
> -/*
> - * Lock the superblock that is holder of the bdev. Returns the superblock
> - * pointer if we successfully locked the superblock and it is alive. Otherwise
> - * we return NULL and just unlock bdev->bd_holder_lock.
> - *
> - * The function must be called with bdev->bd_holder_lock and releases it.
> - */
> -static struct super_block *bdev_super_lock_shared(struct block_device *bdev)
> +
> +static struct super_block *bdev_super_lock(struct block_device *bdev, bool excl)
>  	__releases(&bdev->bd_holder_lock)
>  {
>  	struct super_block *sb = bdev->bd_holder;
> @@ -1451,18 +1445,37 @@ static struct super_block *bdev_super_lock_shared(struct block_device *bdev)
>  	spin_lock(&sb_lock);
>  	sb->s_count++;
>  	spin_unlock(&sb_lock);
> +
>  	mutex_unlock(&bdev->bd_holder_lock);
>  
> -	locked = super_lock_shared(sb);
> -	if (!locked || !sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
> -		put_super(sb);
> +	locked = super_lock(sb, excl);
> +	put_super(sb);
> +	if (!locked)
> +		return NULL;
> +
> +	return sb;
> +}
> +
> +/*
> + * Lock the superblock that is holder of the bdev. Returns the superblock
> + * pointer if we successfully locked the superblock and it is alive. Otherwise
> + * we return NULL and just unlock bdev->bd_holder_lock.
> + *
> + * The function must be called with bdev->bd_holder_lock and releases it.
> + */
> +static struct super_block *bdev_super_lock_shared(struct block_device *bdev)
> +{
> +	struct super_block *sb;
> +
> +	sb = bdev_super_lock(bdev, false);
> +	if (!sb)
> +		return NULL;
> +
> +	if (!sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
> +		super_unlock_shared(sb);
>  		return NULL;
>  	}
> -	/*
> -	 * The superblock is active and we hold s_umount, we can drop our
> -	 * temporary reference now.
> -	 */
> -	put_super(sb);
> +
>  	return sb;
>  }
>  
> @@ -1495,9 +1508,76 @@ static void fs_bdev_sync(struct block_device *bdev)
>  	super_unlock_shared(sb);
>  }
>  
> +static struct super_block *get_bdev_super(struct block_device *bdev)
> +{
> +	bool active = false;
> +	struct super_block *sb;
> +
> +	sb = bdev_super_lock(bdev, true);
> +	if (sb) {
> +		active = atomic_inc_not_zero(&sb->s_active);
> +		super_unlock_excl(sb);
> +	}
> +	if (!active)
> +		return NULL;
> +	return sb;
> +}
> +
> +static int fs_bdev_freeze(struct block_device *bdev)
> +{
> +	struct super_block *sb;
> +	int error = 0;
> +
> +	lockdep_assert_held(&bdev->bd_fsfreeze_mutex);
> +
> +	if (WARN_ON_ONCE(unlikely(!bdev->bd_holder)))
> +		return -EINVAL;
> +
> +	sb = get_bdev_super(bdev);
> +	if (!sb)
> +		return -EINVAL;
> +
> +	if (sb->s_op->freeze_super)
> +		error = sb->s_op->freeze_super(sb, FREEZE_HOLDER_USERSPACE);
> +	else
> +		error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
> +	if (error)
> +		atomic_dec(&bdev->bd_fsfreeze_count);
> +	if (!error)
> +		error = sync_blockdev(bdev);
> +	deactivate_super(sb);
> +	return error;
> +}
> +
> +static int fs_bdev_thaw(struct block_device *bdev)
> +{
> +	struct super_block *sb;
> +	int error;
> +
> +	lockdep_assert_held(&bdev->bd_fsfreeze_mutex);
> +
> +	if (WARN_ON_ONCE(unlikely(!bdev->bd_holder)))
> +		return -EINVAL;
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
> +	deactivate_super(sb);
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
> @@ -1527,15 +1607,10 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
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
>  		bdev_release(bdev_handle);
> @@ -1548,7 +1623,6 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
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

