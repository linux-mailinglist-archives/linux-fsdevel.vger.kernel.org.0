Return-Path: <linux-fsdevel+bounces-1231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D447D7F95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 11:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE5FB2139B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 09:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A3C27EE2;
	Thu, 26 Oct 2023 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KTcBW5or";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8TUbcXDC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2F210F7
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 09:31:25 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A56919A
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 02:31:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6779921B1F;
	Thu, 26 Oct 2023 09:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698312681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ89asvvaceVT1aIcQoQkwASXglms4umt+ib8jUfc74=;
	b=KTcBW5orsGyZe5ipJSXmSB5qM9e6mwVSGgB1a9wEi3ROCP6cr4iLD+u7/rSal478+Hy0sg
	W6GffuH0E844V3NnFUq+y1qU9Bn5cWqofd5EYzAjK9oJs7n1zRF3aLsnJHOS9mE5XuEyxj
	g6+4jg4QMhIlNtDBrYBqEva4FdeCnIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698312681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ89asvvaceVT1aIcQoQkwASXglms4umt+ib8jUfc74=;
	b=8TUbcXDCbVToP+Eeqm1u2aJb8gE+FaaYoA9KlFIbf/hFMWlHHOqMar59a8AhK8NVsdXT+N
	RJAl0Uxf+sU/AkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59C8B133F5;
	Thu, 26 Oct 2023 09:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id C7rhFekxOmUZMAAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 26 Oct 2023 09:31:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DCAE8A05BC; Thu, 26 Oct 2023 11:31:20 +0200 (CEST)
Date: Thu, 26 Oct 2023 11:31:20 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] bdev: implement freeze and thaw holder
 operations
Message-ID: <20231026093120.reoor7bcr6d4cp2r@quack3>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
 <20231024-vfs-super-freeze-v2-5-599c19f4faac@kernel.org>
 <20231025140105.rovejlelqifwbuqj@quack3>
 <20231026-ungewiss-sinken-ea11cd5002da@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-ungewiss-sinken-ea11cd5002da@brauner>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Thu 26-10-23 10:44:27, Christian Brauner wrote:
> Here's the updated diff:
> 
> From ac7b3ae74f1eae9d85a9e179ecf7facc498e9bee Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Wed, 27 Sep 2023 15:21:16 +0200
> Subject: [PATCH v3 05/10] bdev: implement freeze and thaw holder operations
> 
> The old method of implementing block device freeze and thaw operations
> required us to rely on get_active_super() to walk the list of all
> superblocks on the system to find any superblock that might use the
> block device. This is wasteful and not very pleasant overall.
> 
> Now that we can finally go straight from block device to owning
> superblock things become way simpler.
> 
> Link: https://lore.kernel.org/r/20230927-vfs-super-freeze-v1-3-ecc36d9ab4d9@kernel.org
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good to me now. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  block/bdev.c              | 65 +++++++++++++------------
>  fs/super.c                | 99 +++++++++++++++++++++++++++++++--------
>  include/linux/blk_types.h |  2 +-
>  3 files changed, 112 insertions(+), 54 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index a3e2af580a73..4a502fb9b814 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -222,31 +222,27 @@ EXPORT_SYMBOL(sync_blockdev_range);
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
> +	if (error)
> +		atomic_dec(&bdev->bd_fsfreeze_count);
> +
>  	mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  	return error;
>  }
> @@ -262,29 +258,32 @@ EXPORT_SYMBOL(bdev_freeze);
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
>  	if (error)
> -		bdev->bd_fsfreeze_count++;
> -	else
> -		bdev->bd_fsfreeze_sb = NULL;
> +		atomic_inc(&bdev->bd_fsfreeze_count);
>  out:
>  	mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  	return error;
> diff --git a/fs/super.c b/fs/super.c
> index b224182f2440..3b39da5334c5 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1437,7 +1437,7 @@ EXPORT_SYMBOL(sget_dev);
>   *
>   * The function must be called with bdev->bd_holder_lock and releases it.
>   */
> -static struct super_block *bdev_super_lock_shared(struct block_device *bdev)
> +static struct super_block *bdev_super_lock(struct block_device *bdev, bool excl)
>  	__releases(&bdev->bd_holder_lock)
>  {
>  	struct super_block *sb = bdev->bd_holder;
> @@ -1451,18 +1451,25 @@ static struct super_block *bdev_super_lock_shared(struct block_device *bdev)
>  	spin_lock(&sb_lock);
>  	sb->s_count++;
>  	spin_unlock(&sb_lock);
> +
>  	mutex_unlock(&bdev->bd_holder_lock);
>  
> -	locked = super_lock_shared(sb);
> -	if (!locked || !sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
> -		put_super(sb);
> -		return NULL;
> -	}
> +	locked = super_lock(sb, excl);
> +
>  	/*
> -	 * The superblock is active and we hold s_umount, we can drop our
> -	 * temporary reference now.
> -	 */
> +	 * If the superblock wasn't already SB_DYING then we hold
> +	 * s_umount and can safely drop our temporary reference.
> +         */
>  	put_super(sb);
> +
> +	if (!locked)
> +		return NULL;
> +
> +	if (!sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
> +		super_unlock(sb, excl);
> +		return NULL;
> +	}
> +
>  	return sb;
>  }
>  
> @@ -1470,7 +1477,7 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  {
>  	struct super_block *sb;
>  
> -	sb = bdev_super_lock_shared(bdev);
> +	sb = bdev_super_lock(bdev, false);
>  	if (!sb)
>  		return;
>  
> @@ -1488,16 +1495,74 @@ static void fs_bdev_sync(struct block_device *bdev)
>  {
>  	struct super_block *sb;
>  
> -	sb = bdev_super_lock_shared(bdev);
> +	sb = bdev_super_lock(bdev, false);
>  	if (!sb)
>  		return;
> +
>  	sync_filesystem(sb);
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
> +	sb = get_bdev_super(bdev);
> +	if (!sb)
> +		return -EINVAL;
> +
> +	if (sb->s_op->freeze_super)
> +		error = sb->s_op->freeze_super(sb, FREEZE_HOLDER_USERSPACE);
> +	else
> +		error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
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
> +	sb = get_bdev_super(bdev);
> +	if (WARN_ON_ONCE(!sb))
> +		return -EINVAL;
> +
> +	if (sb->s_op->thaw_super)
> +		error = sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE);
> +	else
> +		error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
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
> @@ -1527,15 +1592,10 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
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
> @@ -1548,7 +1608,6 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
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
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

