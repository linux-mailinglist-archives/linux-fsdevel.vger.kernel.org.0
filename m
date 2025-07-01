Return-Path: <linux-fsdevel+bounces-53410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0889AAEEE06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 07:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E4617C963
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 05:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F38E23AB87;
	Tue,  1 Jul 2025 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkxkK2Mo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9483333EC;
	Tue,  1 Jul 2025 05:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751349286; cv=none; b=owUFCVdj/uTORCPQrXAuZ/kxP2sogt7u/CoxleCKEcb+v+H+2FCb8e7mzC0Ac0BI66ALK7Bu5jMhWTtir7nYaFyyh4ffadqEKt/kBh0ZFeIee8X9b9llOZYMFACBRtyVs45CgXAuCE4T4nEcHwXUp55TSUqqOoZNgWRKGBFnVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751349286; c=relaxed/simple;
	bh=AyerdwE+nKSV4R8WYgCDCHBqdWUhvaF5i0l5F4+SV9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRUYBDlf4Sh9NxfnUbQ6o9vZ/c1swEPy46Q0t+QZMlAXBp2ig1PlrY+53C0rwYkcT8Smh9EKjycDZIMA5Wu2hBzTT5Mm1HMX594PULHauHF2kUBPoSpMh1db3SSS/sLLkDCkbev+Lr8zu2lrFCmKwF86SPnQucXIe9/qoeSpg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkxkK2Mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACB4C4CEEB;
	Tue,  1 Jul 2025 05:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751349286;
	bh=AyerdwE+nKSV4R8WYgCDCHBqdWUhvaF5i0l5F4+SV9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkxkK2Mo2MpEzgbyZ0p6o52VugbPcf5slJkEdlU+VQSO2hAEUVSJqJHUgdlZ5vX2c
	 AlHQRi+czW0Y2H1QHl8IOv7ABlBwhai38qpI2pDiRX4olsfXLOskXG61bkGdGEPP1T
	 Ho17I2FO6y4lOZWjJoVa0tR350F9OLFrwFEq96SuOd+eqPVCSVUlFdWIEg3JYMtJdi
	 UxgTU0Gt8PvL5lLG82HjEZfM3eI/uMpxhCgWtp4c9rUcMIeefq0ZJNjc5IOl7QgXkM
	 BpNk/n2mLQxPjFgmkSTXc1oU8KPMe0cYgaW91XiQHgLY/Yl9vnCl5PENyxSNuT3eVU
	 wIJOFk/Lt5mtQ==
Date: Mon, 30 Jun 2025 22:54:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <20250701055445.GE9987@frogsfrogsfrogs>
References: <cover.1751347436.git.wqu@suse.com>
 <6164b8c708b6606c640c066fbc42f8ca9838c24b.1751347436.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6164b8c708b6606c640c066fbc42f8ca9838c24b.1751347436.git.wqu@suse.com>

On Tue, Jul 01, 2025 at 03:02:34PM +0930, Qu Wenruo wrote:
> Currently all the filesystems implementing the
> super_opearations::shutdown() call back can not afford losing a device.
> 
> Thus fs_bdev_mark_dead() will just call the shutdown() callback for the
> involved filesystem.
> 
> But it will no longer be the case, with multi-device filesystems like
> btrfs and bcachefs the filesystem can handle certain device loss without
> shutting down the whole filesystem.
> 
> To allow those multi-device filesystems to be integrated to use
> fs_holder_ops:
> 
> - Rename shutdown() call back to remove_bdev()
>   To better describe when the call back is called.
> 
> - Add a new @bdev parameter to remove_bdev() callback
>   To allow the fs to determine which device is missing, and do the
>   proper handling when needed.
> 
> For the existing shutdown callback users, the change is minimal.
> 
> They only need to follow the rename and the new parameter list.
> Since the behavior is still to shutdown the fs, they shouldn't change
> their function names.
> 
> This has a good side effect that, a single line like
> ".remove_bdev = ext4_shutdown," will easily show the fs behavior and
> indicate the fs will shutdown when a device went missing.
> 
> Btrfs is going to implement the callback soon, which will either
> shutdown the fs or continue read-write operations.

Hrmm, this could be useful for xfs rt devices, if we could some day
reattach a resurrected bdev to a still-running filesystem....

Looks good to me,
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-ext4@vger.kernel.org
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: ntfs3@lists.linux.dev
> Cc: linux-xfs@vger.kernel.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/exfat/super.c   | 4 ++--
>  fs/ext4/super.c    | 4 ++--
>  fs/f2fs/super.c    | 4 ++--
>  fs/ntfs3/super.c   | 4 ++--
>  fs/super.c         | 4 ++--
>  fs/xfs/xfs_super.c | 5 +++--
>  include/linux/fs.h | 7 ++++++-
>  7 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 7ed858937d45..5773026be84c 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -172,7 +172,7 @@ int exfat_force_shutdown(struct super_block *sb, u32 flags)
>  	return 0;
>  }
>  
> -static void exfat_shutdown(struct super_block *sb)
> +static void exfat_shutdown(struct super_block *sb, struct block_device *bdev)
>  {
>  	exfat_force_shutdown(sb, EXFAT_GOING_DOWN_NOSYNC);
>  }
> @@ -202,7 +202,7 @@ static const struct super_operations exfat_sops = {
>  	.put_super	= exfat_put_super,
>  	.statfs		= exfat_statfs,
>  	.show_options	= exfat_show_options,
> -	.shutdown	= exfat_shutdown,
> +	.remove_bdev	= exfat_shutdown,
>  };
>  
>  enum {
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c7d39da7e733..8724f89d20d8 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1456,7 +1456,7 @@ static void ext4_destroy_inode(struct inode *inode)
>  			 EXT4_I(inode)->i_reserved_data_blocks);
>  }
>  
> -static void ext4_shutdown(struct super_block *sb)
> +static void ext4_shutdown(struct super_block *sb, struct block_device *bdev)
>  {
>         ext4_force_shutdown(sb, EXT4_GOING_FLAGS_NOLOGFLUSH);
>  }
> @@ -1620,7 +1620,7 @@ static const struct super_operations ext4_sops = {
>  	.unfreeze_fs	= ext4_unfreeze,
>  	.statfs		= ext4_statfs,
>  	.show_options	= ext4_show_options,
> -	.shutdown	= ext4_shutdown,
> +	.remove_bdev	= ext4_shutdown,
>  #ifdef CONFIG_QUOTA
>  	.quota_read	= ext4_quota_read,
>  	.quota_write	= ext4_quota_write,
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index bbf1dad6843f..51c60b429a31 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2640,7 +2640,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  	return err;
>  }
>  
> -static void f2fs_shutdown(struct super_block *sb)
> +static void f2fs_shutdown(struct super_block *sb, struct block_device *bdev)
>  {
>  	f2fs_do_shutdown(F2FS_SB(sb), F2FS_GOING_DOWN_NOSYNC, false, false);
>  }
> @@ -3264,7 +3264,7 @@ static const struct super_operations f2fs_sops = {
>  	.unfreeze_fs	= f2fs_unfreeze,
>  	.statfs		= f2fs_statfs,
>  	.remount_fs	= f2fs_remount,
> -	.shutdown	= f2fs_shutdown,
> +	.remove_bdev	= f2fs_shutdown,
>  };
>  
>  #ifdef CONFIG_FS_ENCRYPTION
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 920a1ab47b63..5e422543b851 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -764,7 +764,7 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
>  /*
>   * ntfs_shutdown - super_operations::shutdown
>   */
> -static void ntfs_shutdown(struct super_block *sb)
> +static void ntfs_shutdown(struct super_block *sb, struct block_device *bdev)
>  {
>  	set_bit(NTFS_FLAGS_SHUTDOWN_BIT, &ntfs_sb(sb)->flags);
>  }
> @@ -821,7 +821,7 @@ static const struct super_operations ntfs_sops = {
>  	.put_super = ntfs_put_super,
>  	.statfs = ntfs_statfs,
>  	.show_options = ntfs_show_options,
> -	.shutdown = ntfs_shutdown,
> +	.remove_bdev = ntfs_shutdown,
>  	.sync_fs = ntfs_sync_fs,
>  	.write_inode = ntfs3_write_inode,
>  };
> diff --git a/fs/super.c b/fs/super.c
> index 80418ca8e215..c972efb38f6a 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1463,8 +1463,8 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  		sync_filesystem(sb);
>  	shrink_dcache_sb(sb);
>  	evict_inodes(sb);
> -	if (sb->s_op->shutdown)
> -		sb->s_op->shutdown(sb);
> +	if (sb->s_op->remove_bdev)
> +		sb->s_op->remove_bdev(sb, bdev);
>  
>  	super_unlock_shared(sb);
>  }
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 0bc4b5489078..e47d427f4416 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1277,7 +1277,8 @@ xfs_fs_free_cached_objects(
>  
>  static void
>  xfs_fs_shutdown(
> -	struct super_block	*sb)
> +	struct super_block	*sb,
> +	struct block_device	*bdev)
>  {
>  	xfs_force_shutdown(XFS_M(sb), SHUTDOWN_DEVICE_REMOVED);
>  }
> @@ -1308,7 +1309,7 @@ static const struct super_operations xfs_super_operations = {
>  	.show_options		= xfs_fs_show_options,
>  	.nr_cached_objects	= xfs_fs_nr_cached_objects,
>  	.free_cached_objects	= xfs_fs_free_cached_objects,
> -	.shutdown		= xfs_fs_shutdown,
> +	.remove_bdev		= xfs_fs_shutdown,
>  	.show_stats		= xfs_fs_show_stats,
>  };
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b085f161ed22..b08af63d2d4f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2367,7 +2367,12 @@ struct super_operations {
>  				  struct shrink_control *);
>  	long (*free_cached_objects)(struct super_block *,
>  				    struct shrink_control *);
> -	void (*shutdown)(struct super_block *sb);
> +	/*
> +	 * Called when block device @bdev belonging to @sb is removed.
> +	 *
> +	 * If the fs can't afford the device loss, it should be shutdown.
> +	 */
> +	void (*remove_bdev)(struct super_block *sb, struct block_device *bdev);
>  };
>  
>  /*
> -- 
> 2.50.0
> 
> 

