Return-Path: <linux-fsdevel+bounces-1167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDB47D6DE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6CE281D39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECACE28E06;
	Wed, 25 Oct 2023 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q6bVgPLp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aE//j0Qq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1A28DDE
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:01:14 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980D218C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:01:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E13F11FF65;
	Wed, 25 Oct 2023 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698242465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z+O8iWOnl1o7WS/KTyBq8T7LPnq6P0yfeZZZj5ksoLc=;
	b=q6bVgPLpSEtLMeNFZBZLsqzDWHJOW7RupSEfOYkHTFwa+fBRdejE8LXGFwqX8MXOj2CVvp
	V+9eBhrUMMH3++B7QGEW+XZPQbMb1WX0XFDz+Ub9PigDbl0ReTaRSbjd1jEreIm2bFwuIl
	biSUwxdXyqoLlJZMVmfK3bZGYottD7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698242465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z+O8iWOnl1o7WS/KTyBq8T7LPnq6P0yfeZZZj5ksoLc=;
	b=aE//j0QqjER5oIYApiE3cWVt0WW30GdPHiXxx2+xAyJllzOEj01XKtBrDjLYim2OPlwmoT
	i7laN7UdqECF7bAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D35A613524;
	Wed, 25 Oct 2023 14:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ceeSM6EfOWVoEAAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 14:01:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 691A8A05BC; Wed, 25 Oct 2023 16:01:05 +0200 (CEST)
Date: Wed, 25 Oct 2023 16:01:05 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] bdev: implement freeze and thaw holder
 operations
Message-ID: <20231025140105.rovejlelqifwbuqj@quack3>
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

On Tue 24-10-23 15:01:11, Christian Brauner wrote:
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

Some comments below:

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

It's somewhat strange that if we return error here, we still keep
bd_fsfreeze_count elevated. So I'd add here:

	if (error)
		atomic_dec(&bdev->bd_fsfreeze_count);

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

Here I'd also keep the error handling behavior and increment
bd_fsfreeze_count in case of error from ->thaw().

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

Perhaps you can preserve the comment before put_super() here like:
	/*
	 * The superblock is not SB_DYING and we hold s_umount, we can drop
	 * our temporary reference now.
	 */

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

Any reason why you didn't keep these checks in bdev_super_lock()? The use
in get_bdev_super() is actually limited to active superblocks anyway. And
then we can just get rid of bdev_super_lock_shared() and use
bdev_super_lock(bdev, false) instead.

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

This is going to break assumptions that bd_holder_lock is dropped by the
->freeze callback. Also the check seems a bit pointless to me given the
single callsite but whatever.

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

This IMHO belongs into bdev_freeze().

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

The same comment about bd_holder_lock applies here...

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

And this error handling belongs into bdev_thaw().

> +	deactivate_super(sb);
> +	return error;
> +}
> +

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

