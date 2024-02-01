Return-Path: <linux-fsdevel+bounces-9834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA84184547B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6084A1F24E66
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B7A4DA18;
	Thu,  1 Feb 2024 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RLybB+FI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RtR7Gbwx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VZm1Zb8s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lnquogje"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF614DA09;
	Thu,  1 Feb 2024 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780754; cv=none; b=EdJnvYuu18XHchpwE1ox4CS+/wxcbsHVWE+EOOi2SItmQTKSXo/CbOt5j7eWN/qXek1s9zmzIwBcCTlGogK/XywLSBLShEq7Y/ZJbK4QC1cl05d0py5BunIDbU2SnNfLPlFYsK2OhpBblI5P1Okov7ZO/5kzEqVf+9xhmYl36jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780754; c=relaxed/simple;
	bh=W549+IzA9DtdsnqZ5306BQkGEBv/6gtRdfn62Z/TbM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1E/mtQgCLsWra1ZJBr3otOycO3dQ2KlOhuW3k5hkmiEfFSrWCCdpNRSX32wMurl7oghUfp4CKvgTcyTGQxhoPSX5zTz1/oTKjaVPegwmMgSIdPbrfKLESGvCZM0iJ6ksTaSrKLZZjgDS3NC77BLP+IDhPSn8MiYa23AiOwapK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RLybB+FI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RtR7Gbwx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VZm1Zb8s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lnquogje; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A3CC221CF;
	Thu,  1 Feb 2024 09:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706780750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wl9BjwJmlh5vNvGMV1TASorbwF0hvdQC8HX7XESsXfw=;
	b=RLybB+FIFT5yFylFGoUsruLryYJ7HkWJ9Blf2mBKBIqPcgOCr4/EvVDYCIaT5UMz9lVx4z
	Qtj5wLXSCdnY1FD4nXGti2KM8QKq8dgdbzo22PhhQwcctEVJOOtvJKSRIADoI/ue0Cuk19
	B4sLTe8qYdszquBx/frzZbO4iRP2btA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706780750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wl9BjwJmlh5vNvGMV1TASorbwF0hvdQC8HX7XESsXfw=;
	b=RtR7GbwxeYqaW8jRL4iEfaQH4Gmvo7LGpYjO1Q48OE1oTNu9Xciiy3aXHwFqakcaPcDxsj
	RTLfGmZJG/A15ZCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706780749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wl9BjwJmlh5vNvGMV1TASorbwF0hvdQC8HX7XESsXfw=;
	b=VZm1Zb8suQm4GH+yKpUFgX18uW8fvyLANyonlNZeg5H6jaVxYevk+7veWNbx7WFF7F+yso
	yZTkcxQ9BjilwxlvbmS02Jggqej8c7Byuun/8Lanr41XxmlHDQTJNEzyjwyVlvXlMjfiE1
	6kKBihyG0eVdTgvi7hnydCnTJrqqy44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706780749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wl9BjwJmlh5vNvGMV1TASorbwF0hvdQC8HX7XESsXfw=;
	b=lnquogjebjNVa0zA2q7Mg65kqPzqbYzG4lbhKEtW5biQfZTx5OptiebEbf72F7/QJqhMwH
	AZSnh72IZjzgjlAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AAF413594;
	Thu,  1 Feb 2024 09:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id cjcIGk1ou2WIVgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 09:45:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 13E51A0809; Thu,  1 Feb 2024 10:45:49 +0100 (CET)
Date: Thu, 1 Feb 2024 10:45:49 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 13/34] bcache: port block device access to files
Message-ID: <20240201094549.tw3dskvc336bim5d@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-13-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-13-adbd023e19cc@kernel.org>
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

On Tue 23-01-24 14:26:30, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/md/bcache/bcache.h |  4 +--
>  drivers/md/bcache/super.c  | 74 +++++++++++++++++++++++-----------------------
>  2 files changed, 39 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
> index 6ae2329052c9..4e6afa89921f 100644
> --- a/drivers/md/bcache/bcache.h
> +++ b/drivers/md/bcache/bcache.h
> @@ -300,7 +300,7 @@ struct cached_dev {
>  	struct list_head	list;
>  	struct bcache_device	disk;
>  	struct block_device	*bdev;
> -	struct bdev_handle	*bdev_handle;
> +	struct file		*bdev_file;
>  
>  	struct cache_sb		sb;
>  	struct cache_sb_disk	*sb_disk;
> @@ -423,7 +423,7 @@ struct cache {
>  
>  	struct kobject		kobj;
>  	struct block_device	*bdev;
> -	struct bdev_handle	*bdev_handle;
> +	struct file		*bdev_file;
>  
>  	struct task_struct	*alloc_thread;
>  
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index dc3f50f69714..d00b3abab133 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1369,8 +1369,8 @@ static CLOSURE_CALLBACK(cached_dev_free)
>  	if (dc->sb_disk)
>  		put_page(virt_to_page(dc->sb_disk));
>  
> -	if (dc->bdev_handle)
> -		bdev_release(dc->bdev_handle);
> +	if (dc->bdev_file)
> +		fput(dc->bdev_file);
>  
>  	wake_up(&unregister_wait);
>  
> @@ -1445,7 +1445,7 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
>  /* Cached device - bcache superblock */
>  
>  static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
> -				 struct bdev_handle *bdev_handle,
> +				 struct file *bdev_file,
>  				 struct cached_dev *dc)
>  {
>  	const char *err = "cannot allocate memory";
> @@ -1453,8 +1453,8 @@ static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
>  	int ret = -ENOMEM;
>  
>  	memcpy(&dc->sb, sb, sizeof(struct cache_sb));
> -	dc->bdev_handle = bdev_handle;
> -	dc->bdev = bdev_handle->bdev;
> +	dc->bdev_file = bdev_file;
> +	dc->bdev = file_bdev(bdev_file);
>  	dc->sb_disk = sb_disk;
>  
>  	if (cached_dev_init(dc, sb->block_size << 9))
> @@ -2218,8 +2218,8 @@ void bch_cache_release(struct kobject *kobj)
>  	if (ca->sb_disk)
>  		put_page(virt_to_page(ca->sb_disk));
>  
> -	if (ca->bdev_handle)
> -		bdev_release(ca->bdev_handle);
> +	if (ca->bdev_file)
> +		fput(ca->bdev_file);
>  
>  	kfree(ca);
>  	module_put(THIS_MODULE);
> @@ -2339,18 +2339,18 @@ static int cache_alloc(struct cache *ca)
>  }
>  
>  static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
> -				struct bdev_handle *bdev_handle,
> +				struct file *bdev_file,
>  				struct cache *ca)
>  {
>  	const char *err = NULL; /* must be set for any error case */
>  	int ret = 0;
>  
>  	memcpy(&ca->sb, sb, sizeof(struct cache_sb));
> -	ca->bdev_handle = bdev_handle;
> -	ca->bdev = bdev_handle->bdev;
> +	ca->bdev_file = bdev_file;
> +	ca->bdev = file_bdev(bdev_file);
>  	ca->sb_disk = sb_disk;
>  
> -	if (bdev_max_discard_sectors((bdev_handle->bdev)))
> +	if (bdev_max_discard_sectors(file_bdev(bdev_file)))
>  		ca->discard = CACHE_DISCARD(&ca->sb);
>  
>  	ret = cache_alloc(ca);
> @@ -2361,20 +2361,20 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
>  			err = "cache_alloc(): cache device is too small";
>  		else
>  			err = "cache_alloc(): unknown error";
> -		pr_notice("error %pg: %s\n", bdev_handle->bdev, err);
> +		pr_notice("error %pg: %s\n", file_bdev(bdev_file), err);
>  		/*
>  		 * If we failed here, it means ca->kobj is not initialized yet,
>  		 * kobject_put() won't be called and there is no chance to
> -		 * call bdev_release() to bdev in bch_cache_release(). So
> -		 * we explicitly call bdev_release() here.
> +		 * call fput() to bdev in bch_cache_release(). So
> +		 * we explicitly call fput() on the block device here.
>  		 */
> -		bdev_release(bdev_handle);
> +		fput(bdev_file);
>  		return ret;
>  	}
>  
> -	if (kobject_add(&ca->kobj, bdev_kobj(bdev_handle->bdev), "bcache")) {
> +	if (kobject_add(&ca->kobj, bdev_kobj(file_bdev(bdev_file)), "bcache")) {
>  		pr_notice("error %pg: error calling kobject_add\n",
> -			  bdev_handle->bdev);
> +			  file_bdev(bdev_file));
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> @@ -2388,7 +2388,7 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
>  		goto out;
>  	}
>  
> -	pr_info("registered cache device %pg\n", ca->bdev_handle->bdev);
> +	pr_info("registered cache device %pg\n", file_bdev(ca->bdev_file));
>  
>  out:
>  	kobject_put(&ca->kobj);
> @@ -2446,7 +2446,7 @@ struct async_reg_args {
>  	char *path;
>  	struct cache_sb *sb;
>  	struct cache_sb_disk *sb_disk;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	void *holder;
>  };
>  
> @@ -2457,7 +2457,7 @@ static void register_bdev_worker(struct work_struct *work)
>  		container_of(work, struct async_reg_args, reg_work.work);
>  
>  	mutex_lock(&bch_register_lock);
> -	if (register_bdev(args->sb, args->sb_disk, args->bdev_handle,
> +	if (register_bdev(args->sb, args->sb_disk, args->bdev_file,
>  			  args->holder) < 0)
>  		fail = true;
>  	mutex_unlock(&bch_register_lock);
> @@ -2478,7 +2478,7 @@ static void register_cache_worker(struct work_struct *work)
>  		container_of(work, struct async_reg_args, reg_work.work);
>  
>  	/* blkdev_put() will be called in bch_cache_release() */
> -	if (register_cache(args->sb, args->sb_disk, args->bdev_handle,
> +	if (register_cache(args->sb, args->sb_disk, args->bdev_file,
>  			   args->holder))
>  		fail = true;
>  
> @@ -2516,7 +2516,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>  	char *path = NULL;
>  	struct cache_sb *sb;
>  	struct cache_sb_disk *sb_disk;
> -	struct bdev_handle *bdev_handle, *bdev_handle2;
> +	struct file *bdev_file, *bdev_file2;
>  	void *holder = NULL;
>  	ssize_t ret;
>  	bool async_registration = false;
> @@ -2549,15 +2549,15 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>  
>  	ret = -EINVAL;
>  	err = "failed to open device";
> -	bdev_handle = bdev_open_by_path(strim(path), BLK_OPEN_READ, NULL, NULL);
> -	if (IS_ERR(bdev_handle))
> +	bdev_file = bdev_file_open_by_path(strim(path), BLK_OPEN_READ, NULL, NULL);
> +	if (IS_ERR(bdev_file))
>  		goto out_free_sb;
>  
>  	err = "failed to set blocksize";
> -	if (set_blocksize(bdev_handle->bdev, 4096))
> +	if (set_blocksize(file_bdev(bdev_file), 4096))
>  		goto out_blkdev_put;
>  
> -	err = read_super(sb, bdev_handle->bdev, &sb_disk);
> +	err = read_super(sb, file_bdev(bdev_file), &sb_disk);
>  	if (err)
>  		goto out_blkdev_put;
>  
> @@ -2569,13 +2569,13 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>  	}
>  
>  	/* Now reopen in exclusive mode with proper holder */
> -	bdev_handle2 = bdev_open_by_dev(bdev_handle->bdev->bd_dev,
> +	bdev_file2 = bdev_file_open_by_dev(file_bdev(bdev_file)->bd_dev,
>  			BLK_OPEN_READ | BLK_OPEN_WRITE, holder, NULL);
> -	bdev_release(bdev_handle);
> -	bdev_handle = bdev_handle2;
> -	if (IS_ERR(bdev_handle)) {
> -		ret = PTR_ERR(bdev_handle);
> -		bdev_handle = NULL;
> +	fput(bdev_file);
> +	bdev_file = bdev_file2;
> +	if (IS_ERR(bdev_file)) {
> +		ret = PTR_ERR(bdev_file);
> +		bdev_file = NULL;
>  		if (ret == -EBUSY) {
>  			dev_t dev;
>  
> @@ -2610,7 +2610,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>  		args->path	= path;
>  		args->sb	= sb;
>  		args->sb_disk	= sb_disk;
> -		args->bdev_handle	= bdev_handle;
> +		args->bdev_file	= bdev_file;
>  		args->holder	= holder;
>  		register_device_async(args);
>  		/* No wait and returns to user space */
> @@ -2619,14 +2619,14 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>  
>  	if (SB_IS_BDEV(sb)) {
>  		mutex_lock(&bch_register_lock);
> -		ret = register_bdev(sb, sb_disk, bdev_handle, holder);
> +		ret = register_bdev(sb, sb_disk, bdev_file, holder);
>  		mutex_unlock(&bch_register_lock);
>  		/* blkdev_put() will be called in cached_dev_free() */
>  		if (ret < 0)
>  			goto out_free_sb;
>  	} else {
>  		/* blkdev_put() will be called in bch_cache_release() */
> -		ret = register_cache(sb, sb_disk, bdev_handle, holder);
> +		ret = register_cache(sb, sb_disk, bdev_file, holder);
>  		if (ret)
>  			goto out_free_sb;
>  	}
> @@ -2642,8 +2642,8 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>  out_put_sb_page:
>  	put_page(virt_to_page(sb_disk));
>  out_blkdev_put:
> -	if (bdev_handle)
> -		bdev_release(bdev_handle);
> +	if (bdev_file)
> +		fput(bdev_file);
>  out_free_sb:
>  	kfree(sb);
>  out_free_path:
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

