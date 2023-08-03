Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC56876E764
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 13:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbjHCLvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 07:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjHCLvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:51:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A631273A;
        Thu,  3 Aug 2023 04:51:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A664218F6;
        Thu,  3 Aug 2023 11:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691063491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FSDsUsIEQz9MqYljBqqvkw70hXtdohgf+Xi67OczPRo=;
        b=odMACKCIVrFSIXlcffue7bXE6GbaXBcd5uZGciE4H0AoT/+WWV/L2NVjCjh25U1T4hX/cs
        TTJY8v5U9PLqp7sFGPj9P5jvU6MF0P30lZW3EvpPJELuObqYiD8Wgn+1RmiEU/gZzwcyaA
        EvOmiWaVUuvxkKP2YG9McS4lETi+k9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691063491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FSDsUsIEQz9MqYljBqqvkw70hXtdohgf+Xi67OczPRo=;
        b=jIB7cdSAyRslx1phzXdb8IVuWU82Qcmj3mJGynL7hiUUJ8Mnn3Rj/hJ8z5LEMxGiSqZEO3
        zfwQeDRaEtkTLMBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 818011333C;
        Thu,  3 Aug 2023 11:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6saaH8OUy2SWPgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 11:51:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1420AA076B; Thu,  3 Aug 2023 13:51:31 +0200 (CEST)
Date:   Thu, 3 Aug 2023 13:51:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/12] fs: use the super_block as holder when mounting
 file systems
Message-ID: <20230803115131.w6hbhjvvkqnv4qbq@quack3>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-7-hch@lst.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-08-23 17:41:25, Christoph Hellwig wrote:
> The file system type is not a very useful holder as it doesn't allow us
> to go back to the actual file system instance.  Pass the super_block instead
> which is useful when passed back to the file system driver.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice, this is what I also wanted to eventually do :). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/btrfs/super.c | 7 ++-----
>  fs/f2fs/super.c  | 7 +++----
>  fs/super.c       | 8 ++++----
>  3 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 5980b5dcc6b163..8a47c7f2690880 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -69,8 +69,6 @@ static const struct super_operations btrfs_super_ops;
>   * requested by subvol=/path. That way the callchain is straightforward and we
>   * don't have to play tricks with the mount options and recursive calls to
>   * btrfs_mount.
> - *
> - * The new btrfs_root_fs_type also servers as a tag for the bdev_holder.
>   */
>  static struct file_system_type btrfs_fs_type;
>  static struct file_system_type btrfs_root_fs_type;
> @@ -1498,8 +1496,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
>  	} else {
>  		struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>  
> -		error = btrfs_open_devices(fs_devices, sb_open_mode(flags),
> -					   fs_type);
> +		error = btrfs_open_devices(fs_devices, sb_open_mode(flags), s);
>  		if (error)
>  			goto out_deactivate;
>  
> @@ -1513,7 +1510,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
>  			 fs_devices->latest_dev->bdev);
>  		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
>  					s->s_id);
> -		btrfs_sb(s)->bdev_holder = fs_type;
> +		fs_info->bdev_holder = s;
>  		error = btrfs_fill_super(s, fs_devices, data);
>  	}
>  	if (!error)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ca31163da00a55..05c90fdb7a6cca 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1561,7 +1561,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
>  	int i;
>  
>  	for (i = 0; i < sbi->s_ndevs; i++) {
> -		blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
> +		blkdev_put(FDEV(i).bdev, sbi->sb);
>  #ifdef CONFIG_BLK_DEV_ZONED
>  		kvfree(FDEV(i).blkz_seq);
>  #endif
> @@ -4198,7 +4198,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  			/* Single zoned block device mount */
>  			FDEV(0).bdev =
>  				blkdev_get_by_dev(sbi->sb->s_bdev->bd_dev, mode,
> -						  sbi->sb->s_type, NULL);
> +						  sbi->sb, NULL);
>  		} else {
>  			/* Multi-device mount */
>  			memcpy(FDEV(i).path, RDEV(i).path, MAX_PATH_LEN);
> @@ -4217,8 +4217,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  					sbi->log_blocks_per_seg) - 1;
>  			}
>  			FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path, mode,
> -							  sbi->sb->s_type,
> -							  NULL);
> +							  sbi->sb, NULL);
>  		}
>  		if (IS_ERR(FDEV(i).bdev))
>  			return PTR_ERR(FDEV(i).bdev);
> diff --git a/fs/super.c b/fs/super.c
> index 6aaa275fa8630d..09b65ee1a8b737 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1249,7 +1249,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
>  	blk_mode_t mode = sb_open_mode(sb_flags);
>  	struct block_device *bdev;
>  
> -	bdev = blkdev_get_by_dev(sb->s_dev, mode, sb->s_type, &fs_holder_ops);
> +	bdev = blkdev_get_by_dev(sb->s_dev, mode, sb, &fs_holder_ops);
>  	if (IS_ERR(bdev)) {
>  		if (fc)
>  			errorf(fc, "%s: Can't open blockdev", fc->source);
> @@ -1262,7 +1262,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
>  	 * writable from userspace even for a read-only block device.
>  	 */
>  	if ((mode & BLK_OPEN_WRITE) && bdev_read_only(bdev)) {
> -		blkdev_put(bdev, sb->s_type);
> +		blkdev_put(bdev, sb);
>  		return -EACCES;
>  	}
>  
> @@ -1278,7 +1278,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
>  		mutex_unlock(&bdev->bd_fsfreeze_mutex);
>  		if (fc)
>  			warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
> -		blkdev_put(bdev, sb->s_type);
> +		blkdev_put(bdev, sb);
>  		return -EBUSY;
>  	}
>  	spin_lock(&sb_lock);
> @@ -1418,7 +1418,7 @@ void kill_block_super(struct super_block *sb)
>  	if (bdev) {
>  		bdev->bd_super = NULL;
>  		sync_blockdev(bdev);
> -		blkdev_put(bdev, sb->s_type);
> +		blkdev_put(bdev, sb);
>  	}
>  }
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
