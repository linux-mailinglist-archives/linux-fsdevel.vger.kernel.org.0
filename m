Return-Path: <linux-fsdevel+bounces-14477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B9A87CFD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AFA1C2294D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E64B3D0AA;
	Fri, 15 Mar 2024 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XvHlPXqU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wx62y1OV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QOpPmtz+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lQkRzpz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AD3BBCD;
	Fri, 15 Mar 2024 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515371; cv=none; b=YT06x6r6NPKKCulpnksGSjDh10PRHQ3xHss/tVVLEWzplStHKePA4NwJQ9rr8Pz6F7o0tVoZwWNKgyaP80qgvgF3TxspQJhRGq29cgke3br0MexiGYyu6Axaosvv5XHLcNVFH9WAIEDkZ8LGtPR+xIEnRu0k/HcIJeFm2DQnMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515371; c=relaxed/simple;
	bh=3FupIdD3WOQDSB0a+AEZeUTfDUVIU0cWexEy6IfB1eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W362OVJhTx77V6c1KYUYiZUW9xbfaW2MLuBc22zZ82BaavBHuWmiZP2EPdjvy0zopoSE2VSLwEWfWzOOaJXDUvdVbkrz6nw28egyjQXEtntIebPD5KPw+hsUTkntFHgrRW4VCVx3K1Z30j4ix9E+jVMP57A8sTw2jzZRQtSf5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XvHlPXqU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wx62y1OV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QOpPmtz+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lQkRzpz+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE8BC1FB6C;
	Fri, 15 Mar 2024 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710515367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/SIPpKqTqGAQDNJH3up4vUokfpcApwrxl2Q4fiXRhUg=;
	b=XvHlPXqUp0L2igeeFaMQqjyWysqa2g/NsTB9/xdsZikGPgTzxnx7NI3T03vQEJ0VDStztO
	93QpggfP0LG/Umn7zxLsM2f1Jc0i9YDa0lwcfqhyGOiSQnKlhB3x1jcRKBGErXTggHGS5b
	jxkeC2hYwf32bmMHILZPND5eTFF70x4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710515367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/SIPpKqTqGAQDNJH3up4vUokfpcApwrxl2Q4fiXRhUg=;
	b=wx62y1OVw6F9r2PAmHDO68AYal9z28ZMmFHdNwrJ9bZWRYEt82+N2pSITbfqw2BJOvYQX0
	ABucIk+67lVlAQCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710515366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/SIPpKqTqGAQDNJH3up4vUokfpcApwrxl2Q4fiXRhUg=;
	b=QOpPmtz+luDbiJEXiI1NFSB8OmGJoNXOkh+UtB4OR38vUfm3ldUfPhS9uWVy0mgVh3VD+Y
	MA3mukJVJ0oCqNk7NnDM4JHfJB9Gck+rCWUJj4B/pNifoxsig55QSeOOi72lUZtu5XNr2D
	cIuq403hrw8F6AA2ZBvjANaCDtfvkyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710515366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/SIPpKqTqGAQDNJH3up4vUokfpcApwrxl2Q4fiXRhUg=;
	b=lQkRzpz+nmtmk0fVj5UtlttbDBFvzYpS4nfHiLhYpb7X/+qL39SDT/jpp53r6Tx35zbcGs
	0zWDywvGjk1poMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF5061368C;
	Fri, 15 Mar 2024 15:09:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IUBwLqZk9GXrTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 15:09:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6907CA07D9; Fri, 15 Mar 2024 16:09:22 +0100 (CET)
Date: Fri, 15 Mar 2024 16:09:22 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 11/19] btrfs: prevent direct access of
 bd_inode
Message-ID: <20240315150922.l7cnj7sclqsmg6xx@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-12-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-12-yukuai1@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Thu 22-02-24 20:45:47, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that all filesystems stash the bdev file, it's ok to get inode or
> mapping from the file.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/btrfs/disk-io.c | 17 +++++++++--------
>  fs/btrfs/disk-io.h |  4 ++--
>  fs/btrfs/super.c   |  2 +-
>  fs/btrfs/volumes.c | 15 +++++++--------
>  fs/btrfs/zoned.c   | 20 +++++++++++---------
>  fs/btrfs/zoned.h   |  4 ++--
>  6 files changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index bececdd63b4d..344955765f3e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3235,7 +3235,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	/*
>  	 * Read super block and check the signature bytes only
>  	 */
> -	disk_super = btrfs_read_dev_super(fs_devices->latest_dev->bdev);
> +	disk_super = btrfs_read_dev_super(fs_devices->latest_dev->bdev_file);
>  	if (IS_ERR(disk_super)) {
>  		ret = PTR_ERR(disk_super);
>  		goto fail_alloc;
> @@ -3656,17 +3656,18 @@ static void btrfs_end_super_write(struct bio *bio)
>  	bio_put(bio);
>  }
>  
> -struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> +struct btrfs_super_block *btrfs_read_dev_one_super(struct file *bdev_file,
>  						   int copy_num, bool drop_cache)
>  {
>  	struct btrfs_super_block *super;
>  	struct page *page;
>  	u64 bytenr, bytenr_orig;
> -	struct address_space *mapping = bdev->bd_inode->i_mapping;
> +	struct block_device *bdev = file_bdev(bdev_file);
> +	struct address_space *mapping = bdev_file->f_mapping;
>  	int ret;
>  
>  	bytenr_orig = btrfs_sb_offset(copy_num);
> -	ret = btrfs_sb_log_location_bdev(bdev, copy_num, READ, &bytenr);
> +	ret = btrfs_sb_log_location_bdev(bdev_file, copy_num, READ, &bytenr);
>  	if (ret == -ENOENT)
>  		return ERR_PTR(-EINVAL);
>  	else if (ret)
> @@ -3707,7 +3708,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
>  }
>  
>  
> -struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
> +struct btrfs_super_block *btrfs_read_dev_super(struct file *bdev_file)
>  {
>  	struct btrfs_super_block *super, *latest = NULL;
>  	int i;
> @@ -3719,7 +3720,7 @@ struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
>  	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
>  	 */
>  	for (i = 0; i < 1; i++) {
> -		super = btrfs_read_dev_one_super(bdev, i, false);
> +		super = btrfs_read_dev_one_super(bdev_file, i, false);
>  		if (IS_ERR(super))
>  			continue;
>  
> @@ -3749,7 +3750,7 @@ static int write_dev_supers(struct btrfs_device *device,
>  			    struct btrfs_super_block *sb, int max_mirrors)
>  {
>  	struct btrfs_fs_info *fs_info = device->fs_info;
> -	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
> +	struct address_space *mapping = device->bdev_file->f_mapping;
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	int i;
>  	int errors = 0;
> @@ -3866,7 +3867,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
>  		    device->commit_total_bytes)
>  			break;
>  
> -		page = find_get_page(device->bdev->bd_inode->i_mapping,
> +		page = find_get_page(device->bdev_file->f_mapping,
>  				     bytenr >> PAGE_SHIFT);
>  		if (!page) {
>  			errors++;
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 375f62ae3709..2c627885d8d1 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -60,8 +60,8 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>  			 struct btrfs_super_block *sb, int mirror_num);
>  int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount);
>  int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
> -struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
> -struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> +struct btrfs_super_block *btrfs_read_dev_super(struct file *bdev_file);
> +struct btrfs_super_block *btrfs_read_dev_one_super(struct file *bdev_file,
>  						   int copy_num, bool drop_cache);
>  int btrfs_commit_super(struct btrfs_fs_info *fs_info);
>  struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 40ae264fd3ed..9f50f20a1ba4 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2286,7 +2286,7 @@ static int check_dev_super(struct btrfs_device *dev)
>  		return 0;
>  
>  	/* Only need to check the primary super block. */
> -	sb = btrfs_read_dev_one_super(dev->bdev, 0, true);
> +	sb = btrfs_read_dev_one_super(dev->bdev_file, 0, true);
>  	if (IS_ERR(sb))
>  		return PTR_ERR(sb);
>  
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e12451ff911a..9fccfb156bd2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -488,7 +488,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
>  		goto error;
>  	}
>  	invalidate_bdev(bdev);
> -	*disk_super = btrfs_read_dev_super(bdev);
> +	*disk_super = btrfs_read_dev_super(*bdev_file);
>  	if (IS_ERR(*disk_super)) {
>  		ret = PTR_ERR(*disk_super);
>  		fput(*bdev_file);
> @@ -1244,7 +1244,7 @@ void btrfs_release_disk_super(struct btrfs_super_block *super)
>  	put_page(page);
>  }
>  
> -static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
> +static struct btrfs_super_block *btrfs_read_disk_super(struct file *bdev_file,
>  						       u64 bytenr, u64 bytenr_orig)
>  {
>  	struct btrfs_super_block *disk_super;
> @@ -1253,7 +1253,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
>  	pgoff_t index;
>  
>  	/* make sure our super fits in the device */
> -	if (bytenr + PAGE_SIZE >= bdev_nr_bytes(bdev))
> +	if (bytenr + PAGE_SIZE >= bdev_nr_bytes(file_bdev(bdev_file)))
>  		return ERR_PTR(-EINVAL);
>  
>  	/* make sure our super fits in the page */
> @@ -1266,7 +1266,7 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
>  		return ERR_PTR(-EINVAL);
>  
>  	/* pull in the page with our super */
> -	page = read_cache_page_gfp(bdev->bd_inode->i_mapping, index, GFP_KERNEL);
> +	page = read_cache_page_gfp(bdev_file->f_mapping, index, GFP_KERNEL);
>  
>  	if (IS_ERR(page))
>  		return ERR_CAST(page);
> @@ -1368,14 +1368,13 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>  		return ERR_CAST(bdev_file);
>  
>  	bytenr_orig = btrfs_sb_offset(0);
> -	ret = btrfs_sb_log_location_bdev(file_bdev(bdev_file), 0, READ, &bytenr);
> +	ret = btrfs_sb_log_location_bdev(bdev_file, 0, READ, &bytenr);
>  	if (ret) {
>  		device = ERR_PTR(ret);
>  		goto error_bdev_put;
>  	}
>  
> -	disk_super = btrfs_read_disk_super(file_bdev(bdev_file), bytenr,
> -					   bytenr_orig);
> +	disk_super = btrfs_read_disk_super(bdev_file, bytenr, bytenr_orig);
>  	if (IS_ERR(disk_super)) {
>  		device = ERR_CAST(disk_super);
>  		goto error_bdev_put;
> @@ -2040,7 +2039,7 @@ static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
>  	const u64 bytenr = btrfs_sb_offset(copy_num);
>  	int ret;
>  
> -	disk_super = btrfs_read_disk_super(file_bdev(bdev_file), bytenr, bytenr);
> +	disk_super = btrfs_read_disk_super(bdev_file, bytenr, bytenr);
>  	if (IS_ERR(disk_super))
>  		return;
>  
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 12d77aba0148..9e4e2951cdf5 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -81,7 +81,7 @@ static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx, void *data
>  	return 0;
>  }
>  
> -static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
> +static int sb_write_pointer(struct file *bdev_file, struct blk_zone *zones,
>  			    u64 *wp_ret)
>  {
>  	bool empty[BTRFS_NR_SB_LOG_ZONES];
> @@ -118,7 +118,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
>  		return -ENOENT;
>  	} else if (full[0] && full[1]) {
>  		/* Compare two super blocks */
> -		struct address_space *mapping = bdev->bd_inode->i_mapping;
> +		struct address_space *mapping = bdev_file->f_mapping;
>  		struct page *page[BTRFS_NR_SB_LOG_ZONES];
>  		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
>  		int i;
> @@ -562,7 +562,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>  		    BLK_ZONE_TYPE_CONVENTIONAL)
>  			continue;
>  
> -		ret = sb_write_pointer(device->bdev,
> +		ret = sb_write_pointer(device->bdev_file,
>  				       &zone_info->sb_zones[sb_pos], &sb_wp);
>  		if (ret != -ENOENT && ret) {
>  			btrfs_err_in_rcu(device->fs_info,
> @@ -798,7 +798,7 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info, unsigned long *mount
>  	return 0;
>  }
>  
> -static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
> +static int sb_log_location(struct file *bdev_file, struct blk_zone *zones,
>  			   int rw, u64 *bytenr_ret)
>  {
>  	u64 wp;
> @@ -809,7 +809,7 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
>  		return 0;
>  	}
>  
> -	ret = sb_write_pointer(bdev, zones, &wp);
> +	ret = sb_write_pointer(bdev_file, zones, &wp);
>  	if (ret != -ENOENT && ret < 0)
>  		return ret;
>  
> @@ -827,7 +827,8 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
>  			ASSERT(sb_zone_is_full(reset));
>  
>  			nofs_flags = memalloc_nofs_save();
> -			ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
> +			ret = blkdev_zone_mgmt(file_bdev(bdev_file),
> +					       REQ_OP_ZONE_RESET,
>  					       reset->start, reset->len);
>  			memalloc_nofs_restore(nofs_flags);
>  			if (ret)
> @@ -859,10 +860,11 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
>  
>  }
>  
> -int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
> +int btrfs_sb_log_location_bdev(struct file *bdev_file, int mirror, int rw,
>  			       u64 *bytenr_ret)
>  {
>  	struct blk_zone zones[BTRFS_NR_SB_LOG_ZONES];
> +	struct block_device *bdev = file_bdev(bdev_file);
>  	sector_t zone_sectors;
>  	u32 sb_zone;
>  	int ret;
> @@ -896,7 +898,7 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
>  	if (ret != BTRFS_NR_SB_LOG_ZONES)
>  		return -EIO;
>  
> -	return sb_log_location(bdev, zones, rw, bytenr_ret);
> +	return sb_log_location(bdev_file, zones, rw, bytenr_ret);
>  }
>  
>  int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
> @@ -920,7 +922,7 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
>  	if (zone_num + 1 >= zinfo->nr_zones)
>  		return -ENOENT;
>  
> -	return sb_log_location(device->bdev,
> +	return sb_log_location(device->bdev_file,
>  			       &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror],
>  			       rw, bytenr_ret);
>  }
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 77c4321e331f..32680a04aa1f 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -61,7 +61,7 @@ void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
>  struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(struct btrfs_device *orig_dev);
>  int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
>  int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info, unsigned long *mount_opt);
> -int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
> +int btrfs_sb_log_location_bdev(struct file *bdev_file, int mirror, int rw,
>  			       u64 *bytenr_ret);
>  int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
>  			  u64 *bytenr_ret);
> @@ -142,7 +142,7 @@ static inline int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info,
>  	return 0;
>  }
>  
> -static inline int btrfs_sb_log_location_bdev(struct block_device *bdev,
> +static inline int btrfs_sb_log_location_bdev(struct file *bdev_file,
>  					     int mirror, int rw, u64 *bytenr_ret)
>  {
>  	*bytenr_ret = btrfs_sb_offset(mirror);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

