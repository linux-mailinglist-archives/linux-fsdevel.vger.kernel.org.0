Return-Path: <linux-fsdevel+bounces-9842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E38454FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68C3287BE5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE424DA06;
	Thu,  1 Feb 2024 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MEIdaFSL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dF/Ug7MK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lr2Q2U9S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mkQ4FJTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB54C15B0EF;
	Thu,  1 Feb 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782574; cv=none; b=FCHMPnktCI1SEQjeg35c40OivolgqwjWCUOpeBQxW7rHnBQVr62spWq1Co8wbGJ0aLDAOa5tMlRx9IL8bkq/fK5GOdS7//PgSWELUqQYn5z35vIfPSreARnWWS84YGjuL+ZNZSeszCTt/dC62XBbKpgzKqulTi0qLOeCz/dSprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782574; c=relaxed/simple;
	bh=XFnvbgduCMbT0mfMiSpN63wUBR4gAtoLTug0fUHUCLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfIzQrfNufD2G4fQfWkYvXv32PguuUy7BaqNN1peHInO4gcjXs4MAX6/T4oV9lIyz36HSfeIsizGf72w+jh/hOX/AzNE4oibU/rIKp3o9vChSIjguFKdqIQnO1TqPDqHjXfkG0NFsMb+YXBSKFFmDx2gRMMcNUtHf+wfgH9w1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MEIdaFSL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dF/Ug7MK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lr2Q2U9S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mkQ4FJTw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4996221BF;
	Thu,  1 Feb 2024 10:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUSowqKBo5fPmmdKo0dH2F8H2gKLUU+TVQL6W8vK5Lo=;
	b=MEIdaFSLhTFWw+/V7P8MxNJRpqeciAWWiW0jCKIu1jld/aVOPF5ovYaiCz3yPmhaTh3V+Y
	bh5R5NsA75GTWwLzOy6FmC+fj22CohYTeOVFpoqQbNDs8xakRFrZQaaAF9szE9TWnD5L6U
	dmuYSJcUll9k6K33XIgvGjXaGslhFZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUSowqKBo5fPmmdKo0dH2F8H2gKLUU+TVQL6W8vK5Lo=;
	b=dF/Ug7MKwY+ef7CT2m33wuY4eK0uD37KcripXXWbrk9qeS5tCvFzcYjuSfTLVsLBDeVwIG
	ut37vh4ggQ4Y1GBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUSowqKBo5fPmmdKo0dH2F8H2gKLUU+TVQL6W8vK5Lo=;
	b=lr2Q2U9SqLIeQB/fFmrGoEll/RYFibFyTkBvtRWIUoHNwLLB1T4MlorePrZyJWWCux/+OA
	1UJ8H8KZGJlIjdJrFQEFJE8iqvlg8cXAP9fHfcKAWhiIuAL4tcTr1Ud5wKeMsWPc4lftFK
	+bjMkXK/nA4/ARYuyedcVtkxuSDvt4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUSowqKBo5fPmmdKo0dH2F8H2gKLUU+TVQL6W8vK5Lo=;
	b=mkQ4FJTwas4cn5FiE0VdKzySeHOiUoj3di7X3JjNbyuvN+kvUOaqbFKBeNAyjqkm2vANe/
	DKt73EfMjeVkC2Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B85B21329F;
	Thu,  1 Feb 2024 10:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id o9H8LGlvu2XQXQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:16:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 60BFBA0809; Thu,  1 Feb 2024 11:16:09 +0100 (CET)
Date: Thu, 1 Feb 2024 11:16:09 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 19/34] btrfs: port device access to file
Message-ID: <20240201101609.e5xymlvnr77rqju5@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-19-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-19-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Tue 23-01-24 14:26:36, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/btrfs/dev-replace.c | 14 ++++----
>  fs/btrfs/ioctl.c       | 16 ++++-----
>  fs/btrfs/volumes.c     | 92 +++++++++++++++++++++++++-------------------------
>  fs/btrfs/volumes.h     |  4 +--
>  4 files changed, 63 insertions(+), 63 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 1502d664c892..2eb11fe4bd05 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -246,7 +246,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>  {
>  	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>  	struct btrfs_device *device;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	struct block_device *bdev;
>  	u64 devid = BTRFS_DEV_REPLACE_DEVID;
>  	int ret = 0;
> @@ -257,13 +257,13 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>  		return -EINVAL;
>  	}
>  
> -	bdev_handle = bdev_open_by_path(device_path, BLK_OPEN_WRITE,
> +	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
>  					fs_info->bdev_holder, NULL);
> -	if (IS_ERR(bdev_handle)) {
> +	if (IS_ERR(bdev_file)) {
>  		btrfs_err(fs_info, "target device %s is invalid!", device_path);
> -		return PTR_ERR(bdev_handle);
> +		return PTR_ERR(bdev_file);
>  	}
> -	bdev = bdev_handle->bdev;
> +	bdev = file_bdev(bdev_file);
>  
>  	if (!btrfs_check_device_zone_type(fs_info, bdev)) {
>  		btrfs_err(fs_info,
> @@ -314,7 +314,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>  	device->commit_bytes_used = device->bytes_used;
>  	device->fs_info = fs_info;
>  	device->bdev = bdev;
> -	device->bdev_handle = bdev_handle;
> +	device->bdev_file = bdev_file;
>  	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>  	set_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
>  	device->dev_stats_valid = 1;
> @@ -335,7 +335,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>  	return 0;
>  
>  error:
> -	bdev_release(bdev_handle);
> +	fput(bdev_file);
>  	return ret;
>  }
>  
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 41b479861b3c..9e0b3932d90c 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2691,7 +2691,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
>  	struct inode *inode = file_inode(file);
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct btrfs_ioctl_vol_args_v2 *vol_args;
> -	struct bdev_handle *bdev_handle = NULL;
> +	struct file *bdev_file = NULL;
>  	int ret;
>  	bool cancel = false;
>  
> @@ -2728,7 +2728,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
>  		goto err_drop;
>  
>  	/* Exclusive operation is now claimed */
> -	ret = btrfs_rm_device(fs_info, &args, &bdev_handle);
> +	ret = btrfs_rm_device(fs_info, &args, &bdev_file);
>  
>  	btrfs_exclop_finish(fs_info);
>  
> @@ -2742,8 +2742,8 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
>  	}
>  err_drop:
>  	mnt_drop_write_file(file);
> -	if (bdev_handle)
> -		bdev_release(bdev_handle);
> +	if (bdev_file)
> +		fput(bdev_file);
>  out:
>  	btrfs_put_dev_args_from_path(&args);
>  	kfree(vol_args);
> @@ -2756,7 +2756,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
>  	struct inode *inode = file_inode(file);
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct btrfs_ioctl_vol_args *vol_args;
> -	struct bdev_handle *bdev_handle = NULL;
> +	struct file *bdev_file = NULL;
>  	int ret;
>  	bool cancel = false;
>  
> @@ -2783,15 +2783,15 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
>  	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
>  					   cancel);
>  	if (ret == 0) {
> -		ret = btrfs_rm_device(fs_info, &args, &bdev_handle);
> +		ret = btrfs_rm_device(fs_info, &args, &bdev_file);
>  		if (!ret)
>  			btrfs_info(fs_info, "disk deleted %s", vol_args->name);
>  		btrfs_exclop_finish(fs_info);
>  	}
>  
>  	mnt_drop_write_file(file);
> -	if (bdev_handle)
> -		bdev_release(bdev_handle);
> +	if (bdev_file)
> +		fput(bdev_file);
>  out:
>  	btrfs_put_dev_args_from_path(&args);
>  	kfree(vol_args);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4c32497311d2..769a1dc4b756 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -468,39 +468,39 @@ static noinline struct btrfs_fs_devices *find_fsid(
>  
>  static int
>  btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
> -		      int flush, struct bdev_handle **bdev_handle,
> +		      int flush, struct file **bdev_file,
>  		      struct btrfs_super_block **disk_super)
>  {
>  	struct block_device *bdev;
>  	int ret;
>  
> -	*bdev_handle = bdev_open_by_path(device_path, flags, holder, NULL);
> +	*bdev_file = bdev_file_open_by_path(device_path, flags, holder, NULL);
>  
> -	if (IS_ERR(*bdev_handle)) {
> -		ret = PTR_ERR(*bdev_handle);
> +	if (IS_ERR(*bdev_file)) {
> +		ret = PTR_ERR(*bdev_file);
>  		goto error;
>  	}
> -	bdev = (*bdev_handle)->bdev;
> +	bdev = file_bdev(*bdev_file);
>  
>  	if (flush)
>  		sync_blockdev(bdev);
>  	ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
>  	if (ret) {
> -		bdev_release(*bdev_handle);
> +		fput(*bdev_file);
>  		goto error;
>  	}
>  	invalidate_bdev(bdev);
>  	*disk_super = btrfs_read_dev_super(bdev);
>  	if (IS_ERR(*disk_super)) {
>  		ret = PTR_ERR(*disk_super);
> -		bdev_release(*bdev_handle);
> +		fput(*bdev_file);
>  		goto error;
>  	}
>  
>  	return 0;
>  
>  error:
> -	*bdev_handle = NULL;
> +	*bdev_file = NULL;
>  	return ret;
>  }
>  
> @@ -643,7 +643,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  			struct btrfs_device *device, blk_mode_t flags,
>  			void *holder)
>  {
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	struct btrfs_super_block *disk_super;
>  	u64 devid;
>  	int ret;
> @@ -654,7 +654,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  		return -EINVAL;
>  
>  	ret = btrfs_get_bdev_and_sb(device->name->str, flags, holder, 1,
> -				    &bdev_handle, &disk_super);
> +				    &bdev_file, &disk_super);
>  	if (ret)
>  		return ret;
>  
> @@ -678,20 +678,20 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  		clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>  		fs_devices->seeding = true;
>  	} else {
> -		if (bdev_read_only(bdev_handle->bdev))
> +		if (bdev_read_only(file_bdev(bdev_file)))
>  			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>  		else
>  			set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>  	}
>  
> -	if (!bdev_nonrot(bdev_handle->bdev))
> +	if (!bdev_nonrot(file_bdev(bdev_file)))
>  		fs_devices->rotating = true;
>  
> -	if (bdev_max_discard_sectors(bdev_handle->bdev))
> +	if (bdev_max_discard_sectors(file_bdev(bdev_file)))
>  		fs_devices->discardable = true;
>  
> -	device->bdev_handle = bdev_handle;
> -	device->bdev = bdev_handle->bdev;
> +	device->bdev_file = bdev_file;
> +	device->bdev = file_bdev(bdev_file);
>  	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>  
>  	fs_devices->open_devices++;
> @@ -706,7 +706,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  
>  error_free_page:
>  	btrfs_release_disk_super(disk_super);
> -	bdev_release(bdev_handle);
> +	fput(bdev_file);
>  
>  	return -EINVAL;
>  }
> @@ -1015,10 +1015,10 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>  		if (device->devid == BTRFS_DEV_REPLACE_DEVID)
>  			continue;
>  
> -		if (device->bdev_handle) {
> -			bdev_release(device->bdev_handle);
> +		if (device->bdev_file) {
> +			fput(device->bdev_file);
>  			device->bdev = NULL;
> -			device->bdev_handle = NULL;
> +			device->bdev_file = NULL;
>  			fs_devices->open_devices--;
>  		}
>  		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
> @@ -1063,7 +1063,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
>  		invalidate_bdev(device->bdev);
>  	}
>  
> -	bdev_release(device->bdev_handle);
> +	fput(device->bdev_file);
>  }
>  
>  static void btrfs_close_one_device(struct btrfs_device *device)
> @@ -1316,7 +1316,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>  	struct btrfs_super_block *disk_super;
>  	bool new_device_added = false;
>  	struct btrfs_device *device = NULL;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	u64 bytenr, bytenr_orig;
>  	int ret;
>  
> @@ -1339,18 +1339,18 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>  	 * values temporarily, as the device paths of the fsid are the only
>  	 * required information for assembling the volume.
>  	 */
> -	bdev_handle = bdev_open_by_path(path, flags, NULL, NULL);
> -	if (IS_ERR(bdev_handle))
> -		return ERR_CAST(bdev_handle);
> +	bdev_file = bdev_file_open_by_path(path, flags, NULL, NULL);
> +	if (IS_ERR(bdev_file))
> +		return ERR_CAST(bdev_file);
>  
>  	bytenr_orig = btrfs_sb_offset(0);
> -	ret = btrfs_sb_log_location_bdev(bdev_handle->bdev, 0, READ, &bytenr);
> +	ret = btrfs_sb_log_location_bdev(file_bdev(bdev_file), 0, READ, &bytenr);
>  	if (ret) {
>  		device = ERR_PTR(ret);
>  		goto error_bdev_put;
>  	}
>  
> -	disk_super = btrfs_read_disk_super(bdev_handle->bdev, bytenr,
> +	disk_super = btrfs_read_disk_super(file_bdev(bdev_file), bytenr,
>  					   bytenr_orig);
>  	if (IS_ERR(disk_super)) {
>  		device = ERR_CAST(disk_super);
> @@ -1381,7 +1381,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>  	btrfs_release_disk_super(disk_super);
>  
>  error_bdev_put:
> -	bdev_release(bdev_handle);
> +	fput(bdev_file);
>  
>  	return device;
>  }
> @@ -2057,7 +2057,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
>  
>  int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>  		    struct btrfs_dev_lookup_args *args,
> -		    struct bdev_handle **bdev_handle)
> +		    struct file **bdev_file)
>  {
>  	struct btrfs_trans_handle *trans;
>  	struct btrfs_device *device;
> @@ -2166,7 +2166,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>  
>  	btrfs_assign_next_active_device(device, NULL);
>  
> -	if (device->bdev_handle) {
> +	if (device->bdev_file) {
>  		cur_devices->open_devices--;
>  		/* remove sysfs entry */
>  		btrfs_sysfs_remove_device(device);
> @@ -2182,9 +2182,9 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>  	 * free the device.
>  	 *
>  	 * We cannot call btrfs_close_bdev() here because we're holding the sb
> -	 * write lock, and bdev_release() will pull in the ->open_mutex on
> -	 * the block device and it's dependencies.  Instead just flush the
> -	 * device and let the caller do the final bdev_release.
> +	 * write lock, and fput() on the block device will pull in the
> +	 * ->open_mutex on the block device and it's dependencies.  Instead
> +	 *  just flush the device and let the caller do the final bdev_release.
>  	 */
>  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>  		btrfs_scratch_superblocks(fs_info, device->bdev,
> @@ -2195,7 +2195,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>  		}
>  	}
>  
> -	*bdev_handle = device->bdev_handle;
> +	*bdev_file = device->bdev_file;
>  	synchronize_rcu();
>  	btrfs_free_device(device);
>  
> @@ -2332,7 +2332,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
>  				 const char *path)
>  {
>  	struct btrfs_super_block *disk_super;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	int ret;
>  
>  	if (!path || !path[0])
> @@ -2350,7 +2350,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
>  	}
>  
>  	ret = btrfs_get_bdev_and_sb(path, BLK_OPEN_READ, NULL, 0,
> -				    &bdev_handle, &disk_super);
> +				    &bdev_file, &disk_super);
>  	if (ret) {
>  		btrfs_put_dev_args_from_path(args);
>  		return ret;
> @@ -2363,7 +2363,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
>  	else
>  		memcpy(args->fsid, disk_super->fsid, BTRFS_FSID_SIZE);
>  	btrfs_release_disk_super(disk_super);
> -	bdev_release(bdev_handle);
> +	fput(bdev_file);
>  	return 0;
>  }
>  
> @@ -2583,7 +2583,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	struct btrfs_root *root = fs_info->dev_root;
>  	struct btrfs_trans_handle *trans;
>  	struct btrfs_device *device;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	struct super_block *sb = fs_info->sb;
>  	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>  	struct btrfs_fs_devices *seed_devices = NULL;
> @@ -2596,12 +2596,12 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	if (sb_rdonly(sb) && !fs_devices->seeding)
>  		return -EROFS;
>  
> -	bdev_handle = bdev_open_by_path(device_path, BLK_OPEN_WRITE,
> +	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
>  					fs_info->bdev_holder, NULL);
> -	if (IS_ERR(bdev_handle))
> -		return PTR_ERR(bdev_handle);
> +	if (IS_ERR(bdev_file))
> +		return PTR_ERR(bdev_file);
>  
> -	if (!btrfs_check_device_zone_type(fs_info, bdev_handle->bdev)) {
> +	if (!btrfs_check_device_zone_type(fs_info, file_bdev(bdev_file))) {
>  		ret = -EINVAL;
>  		goto error;
>  	}
> @@ -2613,11 +2613,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  		locked = true;
>  	}
>  
> -	sync_blockdev(bdev_handle->bdev);
> +	sync_blockdev(file_bdev(bdev_file));
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
> -		if (device->bdev == bdev_handle->bdev) {
> +		if (device->bdev == file_bdev(bdev_file)) {
>  			ret = -EEXIST;
>  			rcu_read_unlock();
>  			goto error;
> @@ -2633,8 +2633,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	}
>  
>  	device->fs_info = fs_info;
> -	device->bdev_handle = bdev_handle;
> -	device->bdev = bdev_handle->bdev;
> +	device->bdev_file = bdev_file;
> +	device->bdev = file_bdev(bdev_file);
>  	ret = lookup_bdev(device_path, &device->devt);
>  	if (ret)
>  		goto error_free_device;
> @@ -2817,7 +2817,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  error_free_device:
>  	btrfs_free_device(device);
>  error:
> -	bdev_release(bdev_handle);
> +	fput(bdev_file);
>  	if (locked) {
>  		mutex_unlock(&uuid_mutex);
>  		up_write(&sb->s_umount);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 53f87f398da7..a11854912d53 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -90,7 +90,7 @@ struct btrfs_device {
>  
>  	u64 generation;
>  
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	struct block_device *bdev;
>  
>  	struct btrfs_zoned_device_info *zone_info;
> @@ -661,7 +661,7 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
>  void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args);
>  int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>  		    struct btrfs_dev_lookup_args *args,
> -		    struct bdev_handle **bdev_handle);
> +		    struct file **bdev_file);
>  void __exit btrfs_cleanup_fs_uuids(void);
>  int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
>  int btrfs_grow_device(struct btrfs_trans_handle *trans,
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

