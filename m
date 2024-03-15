Return-Path: <linux-fsdevel+bounces-14464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E487CF1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F7C283091
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160C338FAA;
	Fri, 15 Mar 2024 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TfUWIZJp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RrPEgEkb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TfUWIZJp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="loe0nbat"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33E1CA9C;
	Fri, 15 Mar 2024 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513480; cv=none; b=dvZuRYSkTJGbbRfb5RKaffB+TbKteF4MLUOTeIVg1CqoGzLafOu/5e+/1cpdBTuD4orIVqlDbG1d7Hc2NHW1O59B9ELFkZcEeLaAjHy5Fx4dANSu0MtYar55piSUFIpet0WuD7EGx+wXORSMGS/LAccZhpvnAebsBkFRfNVppXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513480; c=relaxed/simple;
	bh=4Yanb/jZML3l6rEB5OkdQpP9fnIDY3qD4VVRYd2WAfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgDWbs2vSf8j/FN+IojW4vzPf9t7ggoCzKD4x66nuKtcaLI0VNFUiGBkMDILFC7wm+ARQegJTsGZoui7STYVRHzcJIw46saDAqkr04QfkDXXks7i9Syd0SJOQ7yya838MDEEHv68BgZUprrJrgcQJpmOWmNBFc3dRFQqsPM5zmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TfUWIZJp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RrPEgEkb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TfUWIZJp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=loe0nbat; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB87221DE5;
	Fri, 15 Mar 2024 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710513476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8MegwTt9u9h1DjDh4+exCvuOPz3dS/kFHpRb7KaeYs=;
	b=TfUWIZJpC0iifTLqim5Dp72wApJW+FoKgv9xFIY0rX640B5y4UUIhKABhdGfOWeYux7qyS
	n6pPcVvtMrEDnGlQxB125HWW6VAdEqZrb9fkiURxjJfn+1e6o664tkkrycCxOILf1rCd3D
	4aawr0YeuQb2QGc3Qs82qVkO2juzI9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710513477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8MegwTt9u9h1DjDh4+exCvuOPz3dS/kFHpRb7KaeYs=;
	b=RrPEgEkbU9cmfvCtQv1+VqVHgPEfOJm3GaeY/Iaz3u18co+6yTT3eBNmbYF3mAgT16aA2q
	EeNE3iMkaUAFpyDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710513476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8MegwTt9u9h1DjDh4+exCvuOPz3dS/kFHpRb7KaeYs=;
	b=TfUWIZJpC0iifTLqim5Dp72wApJW+FoKgv9xFIY0rX640B5y4UUIhKABhdGfOWeYux7qyS
	n6pPcVvtMrEDnGlQxB125HWW6VAdEqZrb9fkiURxjJfn+1e6o664tkkrycCxOILf1rCd3D
	4aawr0YeuQb2QGc3Qs82qVkO2juzI9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710513476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8MegwTt9u9h1DjDh4+exCvuOPz3dS/kFHpRb7KaeYs=;
	b=loe0nbatlywe8hWJdawncNpliG/CH8CBluHpsSwLZEyVxz2Ae8ln9o3UbilewSbv0/R3WE
	L0do1R3eCkbh4JBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB9E213460;
	Fri, 15 Mar 2024 14:37:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eOfFLURd9GVGQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 14:37:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C0E9A07D9; Fri, 15 Mar 2024 15:37:56 +0100 (CET)
Date: Fri, 15 Mar 2024 15:37:56 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 03/19] block: remove sync_blockdev_range()
Message-ID: <20240315143756.gpbks7bmj7ivx6qv@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-4-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-4-yukuai1@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Thu 22-02-24 20:45:39, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that all filesystems stash the bdev file, it's ok to flush the file
> mapping directly.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c           |  7 -------
>  fs/btrfs/dev-replace.c |  2 +-
>  fs/btrfs/volumes.c     | 19 +++++++++++--------
>  fs/btrfs/volumes.h     |  2 +-
>  fs/exfat/fatent.c      |  2 +-
>  include/linux/blkdev.h |  1 -
>  6 files changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 49dcff483289..e493d5c72edb 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -200,13 +200,6 @@ int sync_blockdev(struct block_device *bdev)
>  }
>  EXPORT_SYMBOL(sync_blockdev);
>  
> -int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend)
> -{
> -	return filemap_write_and_wait_range(bdev->bd_inode->i_mapping,
> -			lstart, lend);
> -}
> -EXPORT_SYMBOL(sync_blockdev_range);
> -
>  /**
>   * bdev_freeze - lock a filesystem and force it into a consistent state
>   * @bdev:	blockdevice to lock
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 7057221a46c3..88d45118cc64 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -982,7 +982,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
>  	btrfs_sysfs_remove_device(src_device);
>  	btrfs_sysfs_update_devid(tgt_device);
>  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &src_device->dev_state))
> -		btrfs_scratch_superblocks(fs_info, src_device->bdev,
> +		btrfs_scratch_superblocks(fs_info, src_device->bdev_file,
>  					  src_device->name->str);
>  
>  	/* write back the superblocks */
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 493e33b4ae94..e12451ff911a 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2033,14 +2033,14 @@ static u64 btrfs_num_devices(struct btrfs_fs_info *fs_info)
>  }
>  
>  static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
> -				     struct block_device *bdev, int copy_num)
> +				     struct file *bdev_file, int copy_num)
>  {
>  	struct btrfs_super_block *disk_super;
>  	const size_t len = sizeof(disk_super->magic);
>  	const u64 bytenr = btrfs_sb_offset(copy_num);
>  	int ret;
>  
> -	disk_super = btrfs_read_disk_super(bdev, bytenr, bytenr);
> +	disk_super = btrfs_read_disk_super(file_bdev(bdev_file), bytenr, bytenr);
>  	if (IS_ERR(disk_super))
>  		return;
>  
> @@ -2048,26 +2048,29 @@ static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
>  	folio_mark_dirty(virt_to_folio(disk_super));
>  	btrfs_release_disk_super(disk_super);
>  
> -	ret = sync_blockdev_range(bdev, bytenr, bytenr + len - 1);
> +	ret = filemap_write_and_wait_range(bdev_file->f_mapping,
> +					   bytenr, bytenr + len - 1);
>  	if (ret)
>  		btrfs_warn(fs_info, "error clearing superblock number %d (%d)",
>  			copy_num, ret);
>  }
>  
>  void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
> -			       struct block_device *bdev,
> +			       struct file *bdev_file,
>  			       const char *device_path)
>  {
> +	struct block_device *bdev;
>  	int copy_num;
>  
> -	if (!bdev)
> +	if (!bdev_file)
>  		return;
>  
> +	bdev = file_bdev(bdev_file);
>  	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX; copy_num++) {
>  		if (bdev_is_zoned(bdev))
>  			btrfs_reset_sb_log_zones(bdev, copy_num);
>  		else
> -			btrfs_scratch_superblock(fs_info, bdev, copy_num);
> +			btrfs_scratch_superblock(fs_info, bdev_file, copy_num);
>  	}
>  
>  	/* Notify udev that device has changed */
> @@ -2209,7 +2212,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>  	 *  just flush the device and let the caller do the final bdev_release.
>  	 */
>  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
> -		btrfs_scratch_superblocks(fs_info, device->bdev,
> +		btrfs_scratch_superblocks(fs_info, device->bdev_file,
>  					  device->name->str);
>  		if (device->bdev) {
>  			sync_blockdev(device->bdev);
> @@ -2323,7 +2326,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
>  
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  
> -	btrfs_scratch_superblocks(tgtdev->fs_info, tgtdev->bdev,
> +	btrfs_scratch_superblocks(tgtdev->fs_info, tgtdev->bdev_file,
>  				  tgtdev->name->str);
>  
>  	btrfs_close_bdev(tgtdev);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 2ef78d3cc4c3..1d566f40b83d 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -818,7 +818,7 @@ struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
>  bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
>  					struct btrfs_device *failing_dev);
>  void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
> -			       struct block_device *bdev,
> +			       struct file *bdev_file,
>  			       const char *device_path);
>  
>  enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags);
> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
> index 56b870d9cc0d..1c86ec2465b7 100644
> --- a/fs/exfat/fatent.c
> +++ b/fs/exfat/fatent.c
> @@ -296,7 +296,7 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
>  	}
>  
>  	if (IS_DIRSYNC(dir))
> -		return sync_blockdev_range(sb->s_bdev,
> +		return filemap_write_and_wait_range(sb->s_bdev_file->f_mapping,
>  				EXFAT_BLK_TO_B(blknr, sb),
>  				EXFAT_BLK_TO_B(last_blknr, sb) - 1);
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 9e96811c8915..c510f334c84f 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1527,7 +1527,6 @@ unsigned int block_size(struct block_device *bdev);
>  #ifdef CONFIG_BLOCK
>  void invalidate_bdev(struct block_device *bdev);
>  int sync_blockdev(struct block_device *bdev);
> -int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
>  void sync_bdevs(bool wait);
>  void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
>  void printk_all_partitions(void);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

