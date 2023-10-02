Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B987B512B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjJBL2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjJBL2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:28:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42465BF
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 04:28:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D866E21857;
        Mon,  2 Oct 2023 11:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696246091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UxmfiogkzjTZdC58ZW6YQ38GyHzjj/FptrL2NgvTQOE=;
        b=owmHwtyH9ixWuzQ0qWrXe4au2uhpoxBllgYFBgYqNe1VW8cPSzQzvdA/OLwUpHLtSx+wCy
        Zl6ue2q6A4KepRAV5YzcS+fIr49khPElkAqB4WDHxCkj60AI7INMpriNBghl1PPzNEIhu7
        Arps7ACt6XUmaPGnbj9sA93wT8PjCWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696246091;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UxmfiogkzjTZdC58ZW6YQ38GyHzjj/FptrL2NgvTQOE=;
        b=iLFyosk4C5gQ5s26UptxcXjida1CYniwDAAgj5pzFfxWWsniLbrC8jWYzT9VX36nero2Sk
        XFoGXT8+T1nbkACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C99EE13456;
        Mon,  2 Oct 2023 11:28:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BsU1MUupGmUUBQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Oct 2023 11:28:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 69AEAA07C9; Mon,  2 Oct 2023 13:28:11 +0200 (CEST)
Date:   Mon, 2 Oct 2023 13:28:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 1/7] bdev: rename freeze and thaw helpers
Message-ID: <20231002112811.oattgwyomgqxa6vs@quack3>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-1-ecc36d9ab4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-vfs-super-freeze-v1-1-ecc36d9ab4d9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 27-09-23 15:21:14, Christian Brauner wrote:
> We have bdev_mark_dead() etc and we're going to move block device
> freezing to holder ops in the next patch. Make the naming consistent:
> 
> * freeze_bdev() -> bdev_freeze()
> * thaw_bdev()   -> bdev_thaw()
> 
> Also document the return code.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c           | 22 +++++++++++++---------
>  drivers/md/dm.c        |  4 ++--
>  fs/ext4/ioctl.c        |  4 ++--
>  fs/f2fs/file.c         |  4 ++--
>  fs/super.c             |  4 ++--
>  fs/xfs/xfs_fsops.c     |  4 ++--
>  include/linux/blkdev.h |  4 ++--
>  7 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index f3b13aa1b7d4..0d27db3e69e7 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -207,18 +207,20 @@ int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend)
>  EXPORT_SYMBOL(sync_blockdev_range);
>  
>  /**
> - * freeze_bdev - lock a filesystem and force it into a consistent state
> + * bdev_freeze - lock a filesystem and force it into a consistent state
>   * @bdev:	blockdevice to lock
>   *
>   * If a superblock is found on this device, we take the s_umount semaphore
>   * on it to make sure nobody unmounts until the snapshot creation is done.
>   * The reference counter (bd_fsfreeze_count) guarantees that only the last
>   * unfreeze process can unfreeze the frozen filesystem actually when multiple
> - * freeze requests arrive simultaneously. It counts up in freeze_bdev() and
> - * count down in thaw_bdev(). When it becomes 0, thaw_bdev() will unfreeze
> + * freeze requests arrive simultaneously. It counts up in bdev_freeze() and
> + * count down in bdev_thaw(). When it becomes 0, thaw_bdev() will unfreeze
>   * actually.
> + *
> + * Return: On success zero is returned, negative error code on failure.
>   */
> -int freeze_bdev(struct block_device *bdev)
> +int bdev_freeze(struct block_device *bdev)
>  {
>  	struct super_block *sb;
>  	int error = 0;
> @@ -248,15 +250,17 @@ int freeze_bdev(struct block_device *bdev)
>  	mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  	return error;
>  }
> -EXPORT_SYMBOL(freeze_bdev);
> +EXPORT_SYMBOL(bdev_freeze);
>  
>  /**
> - * thaw_bdev - unlock filesystem
> + * bdev_thaw - unlock filesystem
>   * @bdev:	blockdevice to unlock
>   *
> - * Unlocks the filesystem and marks it writeable again after freeze_bdev().
> + * Unlocks the filesystem and marks it writeable again after bdev_freeze().
> + *
> + * Return: On success zero is returned, negative error code on failure.
>   */
> -int thaw_bdev(struct block_device *bdev)
> +int bdev_thaw(struct block_device *bdev)
>  {
>  	struct super_block *sb;
>  	int error = -EINVAL;
> @@ -285,7 +289,7 @@ int thaw_bdev(struct block_device *bdev)
>  	mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  	return error;
>  }
> -EXPORT_SYMBOL(thaw_bdev);
> +EXPORT_SYMBOL(bdev_thaw);
>  
>  /*
>   * pseudo-fs
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 64a1f306c96c..6fa309e8efb0 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2648,7 +2648,7 @@ static int lock_fs(struct mapped_device *md)
>  
>  	WARN_ON(test_bit(DMF_FROZEN, &md->flags));
>  
> -	r = freeze_bdev(md->disk->part0);
> +	r = bdev_freeze(md->disk->part0);
>  	if (!r)
>  		set_bit(DMF_FROZEN, &md->flags);
>  	return r;
> @@ -2658,7 +2658,7 @@ static void unlock_fs(struct mapped_device *md)
>  {
>  	if (!test_bit(DMF_FROZEN, &md->flags))
>  		return;
> -	thaw_bdev(md->disk->part0);
> +	bdev_thaw(md->disk->part0);
>  	clear_bit(DMF_FROZEN, &md->flags);
>  }
>  
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 0bfe2ce589e2..c1390219c945 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -810,11 +810,11 @@ int ext4_force_shutdown(struct super_block *sb, u32 flags)
>  
>  	switch (flags) {
>  	case EXT4_GOING_FLAGS_DEFAULT:
> -		ret = freeze_bdev(sb->s_bdev);
> +		ret = bdev_freeze(sb->s_bdev);
>  		if (ret)
>  			return ret;
>  		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
> -		thaw_bdev(sb->s_bdev);
> +		bdev_thaw(sb->s_bdev);
>  		break;
>  	case EXT4_GOING_FLAGS_LOGFLUSH:
>  		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ca5904129b16..c22aeb9ffb61 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2239,11 +2239,11 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>  
>  	switch (in) {
>  	case F2FS_GOING_DOWN_FULLSYNC:
> -		ret = freeze_bdev(sb->s_bdev);
> +		ret = bdev_freeze(sb->s_bdev);
>  		if (ret)
>  			goto out;
>  		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
> -		thaw_bdev(sb->s_bdev);
> +		bdev_thaw(sb->s_bdev);
>  		break;
>  	case F2FS_GOING_DOWN_METASYNC:
>  		/* do checkpoint only */
> diff --git a/fs/super.c b/fs/super.c
> index 2d762ce67f6e..e54866345dc7 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1210,7 +1210,7 @@ static void do_thaw_all_callback(struct super_block *sb)
>  
>  	if (born && sb->s_root) {
>  		if (IS_ENABLED(CONFIG_BLOCK))
> -			while (sb->s_bdev && !thaw_bdev(sb->s_bdev))
> +			while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
>  				pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
>  		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
>  	} else {
> @@ -1501,7 +1501,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
>  	/*
>  	 * Until SB_BORN flag is set, there can be no active superblock
>  	 * references and thus no filesystem freezing. get_active_super() will
> -	 * just loop waiting for SB_BORN so even freeze_bdev() cannot proceed.
> +	 * just loop waiting for SB_BORN so even bdev_freeze() cannot proceed.
>  	 *
>  	 * It is enough to check bdev was not frozen before we set s_bdev.
>  	 */
> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> index 7cb75cb6b8e9..57076a25f17d 100644
> --- a/fs/xfs/xfs_fsops.c
> +++ b/fs/xfs/xfs_fsops.c
> @@ -482,9 +482,9 @@ xfs_fs_goingdown(
>  {
>  	switch (inflags) {
>  	case XFS_FSOP_GOING_FLAGS_DEFAULT: {
> -		if (!freeze_bdev(mp->m_super->s_bdev)) {
> +		if (!bdev_freeze(mp->m_super->s_bdev)) {
>  			xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
> -			thaw_bdev(mp->m_super->s_bdev);
> +			bdev_thaw(mp->m_super->s_bdev);
>  		}
>  		break;
>  	}
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index eef450f25982..bf25b63e13d5 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1530,8 +1530,8 @@ static inline int early_lookup_bdev(const char *pathname, dev_t *dev)
>  }
>  #endif /* CONFIG_BLOCK */
>  
> -int freeze_bdev(struct block_device *bdev);
> -int thaw_bdev(struct block_device *bdev);
> +int bdev_freeze(struct block_device *bdev);
> +int bdev_thaw(struct block_device *bdev);
>  
>  struct io_comp_batch {
>  	struct request *req_list;
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
