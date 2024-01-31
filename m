Return-Path: <linux-fsdevel+bounces-9690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E10C8446EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538EE29086D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B35B12FF80;
	Wed, 31 Jan 2024 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2qHhJHOW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7ksUdXWC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YXdvwDG2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zo8Aye5b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5A12FF6F;
	Wed, 31 Jan 2024 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724935; cv=none; b=TuUCD1P0euxkigrbPGy26UEPeejbWDz7xHuXW7SQMd4xH9CbEB4ssWOLaVk9qDtYuDS5FRE1n44VGwEscTxc+Pwicz5ttWhvvLDBUV1lnGUL7HVRSJK/D6VToo0uGmMBBHoW3XwBglRncGCZFQPfxXl/Wj0GcpN41iia+tSPhq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724935; c=relaxed/simple;
	bh=j9c9Df7NqyDHYBMRwkiQ9gF0XB/TpL1R78naNmlyYMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqZJUv8fNFmLwsV5HFIzEHt6SiwRAdWFZl/B+l6Gc254ggm7ofrioKu9n25Gui+ajdEH509AnuIdExtqnxd9LVZeb1i1bwS6JZSfxJAGYvfK+yCV4+po8TevyE5NpJ1XoqlAbpPY3pDQMXPpeikokd0YffDqWhGPABV0jcS/xcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2qHhJHOW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7ksUdXWC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YXdvwDG2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zo8Aye5b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E70881FB8E;
	Wed, 31 Jan 2024 18:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706724932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4DBmUYcKjjsE7E15DwR90wptpUp3zkVEScBQXOLBKc=;
	b=2qHhJHOWTk70ju3e7cjY5MhIXOy34PIxC8vraKUSehKkrPVpmcGMRObVQ4sOc8jK6itjTz
	TrQcubVh/b2jbSLRzLRVx9NPh6/vEszNxJkO45NHCEPLeIefkPt06B9n99tQ/908pxRHrh
	JBBHdtgMKXJOHGjwvaLpmcFHVphjyiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706724932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4DBmUYcKjjsE7E15DwR90wptpUp3zkVEScBQXOLBKc=;
	b=7ksUdXWCt+KbBePgJNUyM0bhxwCo6l4DkJ2o93UqcoC9baZLp3NZfpGFwehkgk12yoXQZy
	OAg28S3AI+Ab9HAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706724931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4DBmUYcKjjsE7E15DwR90wptpUp3zkVEScBQXOLBKc=;
	b=YXdvwDG2wA5AbezLG2jiwY5NZXvkof1Ri7wL1g23LjFASWxocJ8zuPuyCPRHbdHYwYXCkl
	xnDE1b5Bo7VO+Z6pq24lgPWydK7sY1t7/GCJS+kL/f1jN5TF3e4jxA8dUCbdszsI2nhPj9
	lI4T0MX7FnBM8I5Mmh6zx2jCuHPc+bQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706724931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4DBmUYcKjjsE7E15DwR90wptpUp3zkVEScBQXOLBKc=;
	b=Zo8Aye5b7nN1noNR5Mr/EAW9r188XIA0LjPoMp5r3jQzOzzao1ewJKLlzRJ0eJF1vR7CME
	rPyPC70Zzynxv5Aw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D79F2139D9;
	Wed, 31 Jan 2024 18:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id P/ugNEOOumUoJAAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 18:15:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7A6DDA0809; Wed, 31 Jan 2024 19:15:31 +0100 (CET)
Date: Wed, 31 Jan 2024 19:15:31 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 04/34] md: port block device access to file
Message-ID: <20240131181531.iva325lh6bkytgls@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-4-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-4-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
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
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue 23-01-24 14:26:21, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/md/dm.c               | 23 +++++++++++++----------
>  drivers/md/md.c               | 12 ++++++------
>  drivers/md/md.h               |  2 +-
>  include/linux/device-mapper.h |  2 +-
>  4 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 8dcabf84d866..87de5b5682ad 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -726,7 +726,8 @@ static struct table_device *open_table_device(struct mapped_device *md,
>  		dev_t dev, blk_mode_t mode)
>  {
>  	struct table_device *td;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
> +	struct block_device *bdev;
>  	u64 part_off;
>  	int r;
>  
> @@ -735,34 +736,36 @@ static struct table_device *open_table_device(struct mapped_device *md,
>  		return ERR_PTR(-ENOMEM);
>  	refcount_set(&td->count, 1);
>  
> -	bdev_handle = bdev_open_by_dev(dev, mode, _dm_claim_ptr, NULL);
> -	if (IS_ERR(bdev_handle)) {
> -		r = PTR_ERR(bdev_handle);
> +	bdev_file = bdev_file_open_by_dev(dev, mode, _dm_claim_ptr, NULL);
> +	if (IS_ERR(bdev_file)) {
> +		r = PTR_ERR(bdev_file);
>  		goto out_free_td;
>  	}
>  
> +	bdev = file_bdev(bdev_file);
> +
>  	/*
>  	 * We can be called before the dm disk is added.  In that case we can't
>  	 * register the holder relation here.  It will be done once add_disk was
>  	 * called.
>  	 */
>  	if (md->disk->slave_dir) {
> -		r = bd_link_disk_holder(bdev_handle->bdev, md->disk);
> +		r = bd_link_disk_holder(bdev, md->disk);
>  		if (r)
>  			goto out_blkdev_put;
>  	}
>  
>  	td->dm_dev.mode = mode;
> -	td->dm_dev.bdev = bdev_handle->bdev;
> -	td->dm_dev.bdev_handle = bdev_handle;
> -	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev_handle->bdev, &part_off,
> +	td->dm_dev.bdev = bdev;
> +	td->dm_dev.bdev_file = bdev_file;
> +	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off,
>  						NULL, NULL);
>  	format_dev_t(td->dm_dev.name, dev);
>  	list_add(&td->list, &md->table_devices);
>  	return td;
>  
>  out_blkdev_put:
> -	bdev_release(bdev_handle);
> +	fput(bdev_file);
>  out_free_td:
>  	kfree(td);
>  	return ERR_PTR(r);
> @@ -775,7 +778,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
>  {
>  	if (md->disk->slave_dir)
>  		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
> -	bdev_release(td->dm_dev.bdev_handle);
> +	fput(td->dm_dev.bdev_file);
>  	put_dax(td->dm_dev.dax_dev);
>  	list_del(&td->list);
>  	kfree(td);
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 2266358d8074..0653584db63b 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -2578,7 +2578,7 @@ static void export_rdev(struct md_rdev *rdev, struct mddev *mddev)
>  	if (test_bit(AutoDetected, &rdev->flags))
>  		md_autodetect_dev(rdev->bdev->bd_dev);
>  #endif
> -	bdev_release(rdev->bdev_handle);
> +	fput(rdev->bdev_file);
>  	rdev->bdev = NULL;
>  	kobject_put(&rdev->kobj);
>  }
> @@ -3773,16 +3773,16 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
>  	if (err)
>  		goto out_clear_rdev;
>  
> -	rdev->bdev_handle = bdev_open_by_dev(newdev,
> +	rdev->bdev_file = bdev_file_open_by_dev(newdev,
>  			BLK_OPEN_READ | BLK_OPEN_WRITE,
>  			super_format == -2 ? &claim_rdev : rdev, NULL);
> -	if (IS_ERR(rdev->bdev_handle)) {
> +	if (IS_ERR(rdev->bdev_file)) {
>  		pr_warn("md: could not open device unknown-block(%u,%u).\n",
>  			MAJOR(newdev), MINOR(newdev));
> -		err = PTR_ERR(rdev->bdev_handle);
> +		err = PTR_ERR(rdev->bdev_file);
>  		goto out_clear_rdev;
>  	}
> -	rdev->bdev = rdev->bdev_handle->bdev;
> +	rdev->bdev = file_bdev(rdev->bdev_file);
>  
>  	kobject_init(&rdev->kobj, &rdev_ktype);
>  
> @@ -3813,7 +3813,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
>  	return rdev;
>  
>  out_blkdev_put:
> -	bdev_release(rdev->bdev_handle);
> +	fput(rdev->bdev_file);
>  out_clear_rdev:
>  	md_rdev_clear(rdev);
>  out_free_rdev:
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 8d881cc59799..a079ee9b6190 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -59,7 +59,7 @@ struct md_rdev {
>  	 */
>  	struct block_device *meta_bdev;
>  	struct block_device *bdev;	/* block device handle */
> -	struct bdev_handle *bdev_handle;	/* Handle from open for bdev */
> +	struct file *bdev_file;		/* Handle from open for bdev */
>  
>  	struct page	*sb_page, *bb_page;
>  	int		sb_loaded;
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 772ab4d74d94..82b2195efaca 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -165,7 +165,7 @@ void dm_error(const char *message);
>  
>  struct dm_dev {
>  	struct block_device *bdev;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	struct dax_device *dax_dev;
>  	blk_mode_t mode;
>  	char name[16];
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

