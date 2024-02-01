Return-Path: <linux-fsdevel+bounces-9839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544B8454EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A23A1C2409E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1679D15B111;
	Thu,  1 Feb 2024 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x+/vWphe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="drFpimha";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SP6SSHr6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1npeiMmP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4BB4D9F4;
	Thu,  1 Feb 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782300; cv=none; b=jfEw8siTdvjinzgvuBdKC8hgTkj6iIptTJOAJ3CkA+RFGkk+ivP+pCmMh0IDsu/T4qT1SIxG+gOaWKBbjGSr+TBAm78Bj0r44Br2lsQ9ZfCydeppcvQXf1g/1lIDGGajr8CSZ53w2bJv2kumzdMYa/86z6L93UqptK7YHNF+YdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782300; c=relaxed/simple;
	bh=delr6aXVrNvhWk0YAPlLZlz4KPCKI3OEbgdCFomZngI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9wO7Yf74EfymS4Rsd5slZ1FeQhKR/M/uC/lqwBnqXrk507xz1PiCFev2AVSba118KGtot2hTUeA2pXd24ZBtGUtM6/2i0J/qAW5tm1H/QVG1dQ3aVbuzsl6J/vLcQuGVOmGkSPB3luBJbX34Qkg7UwlVUCLkzKIW3SyLPwK+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x+/vWphe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=drFpimha; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SP6SSHr6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1npeiMmP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9D321FB96;
	Thu,  1 Feb 2024 10:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9i6t0cpDDtl/sgJzPa58UP9cM/pGHN0SoBjL0mJ7wss=;
	b=x+/vWpheOuAtVXg05sGRtajPLL+dMghRjRysChng1SW0LC9UyfvjsR6Izuk5R35A5IYFFp
	+tz7nlQr9wlaZYkbxpG2uNdYZ1X0crVV8MYY2+RfV0+aoumsBfYi2BqeQPv0/ZCQHrfgzu
	ORBwfe22TNHKUE4rQZSlZw3jVyBpKNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9i6t0cpDDtl/sgJzPa58UP9cM/pGHN0SoBjL0mJ7wss=;
	b=drFpimhak2DlkHgLYmnGcBG0p8ip39+FYL4Pvv0s5x0hrC6N7FHlUTkIDBThJLJcdBkMOG
	bjL8s4OPqawCXLDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9i6t0cpDDtl/sgJzPa58UP9cM/pGHN0SoBjL0mJ7wss=;
	b=SP6SSHr64EY7EXDV8zCSjCO40DpNPMgDgRDE8dZxRgx+4LgA1E2Pw5MD0oOuySH1SPOcMu
	pg/Em88dTBi9PkL0l/lsy1moUzUNY3MGHTyc+0KxZMpa9SlDcGzPWXokE2dkQSS/Ct6Cvt
	Me7MF2Rsk+aL7jpJAMVxgFYnG/hsYeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9i6t0cpDDtl/sgJzPa58UP9cM/pGHN0SoBjL0mJ7wss=;
	b=1npeiMmP/72zbAB6QTpJC4N0VRCmo07hTJPAkBShP2IaxJpAMFdlPmaQt8LZ686aydrMxa
	cju0ZdTCXjp2EDDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9123C1329F;
	Thu,  1 Feb 2024 10:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id y81pI1duu2WtXAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:11:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5740FA0809; Thu,  1 Feb 2024 11:11:31 +0100 (CET)
Date: Thu, 1 Feb 2024 11:11:31 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 16/34] s390: port block device access to file
Message-ID: <20240201101131.cxpytawoo6533cy7@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-16-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-16-adbd023e19cc@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SP6SSHr6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1npeiMmP
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: A9D321FB96
X-Spam-Flag: NO

On Tue 23-01-24 14:26:33, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/s390/block/dasd.c       | 10 +++++-----
>  drivers/s390/block/dasd_genhd.c | 36 ++++++++++++++++++------------------
>  drivers/s390/block/dasd_int.h   |  2 +-
>  drivers/s390/block/dasd_ioctl.c |  2 +-
>  4 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index 7327e81352e9..c833a7c7d7b2 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -412,7 +412,7 @@ dasd_state_ready_to_online(struct dasd_device * device)
>  					KOBJ_CHANGE);
>  			return 0;
>  		}
> -		disk_uevent(device->block->bdev_handle->bdev->bd_disk,
> +		disk_uevent(file_bdev(device->block->bdev_file)->bd_disk,
>  			    KOBJ_CHANGE);
>  	}
>  	return 0;
> @@ -433,7 +433,7 @@ static int dasd_state_online_to_ready(struct dasd_device *device)
>  
>  	device->state = DASD_STATE_READY;
>  	if (device->block && !(device->features & DASD_FEATURE_USERAW))
> -		disk_uevent(device->block->bdev_handle->bdev->bd_disk,
> +		disk_uevent(file_bdev(device->block->bdev_file)->bd_disk,
>  			    KOBJ_CHANGE);
>  	return 0;
>  }
> @@ -3588,7 +3588,7 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
>  	 * in the other openers.
>  	 */
>  	if (device->block) {
> -		max_count = device->block->bdev_handle ? 0 : -1;
> +		max_count = device->block->bdev_file ? 0 : -1;
>  		open_count = atomic_read(&device->block->open_count);
>  		if (open_count > max_count) {
>  			if (open_count > 0)
> @@ -3634,8 +3634,8 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
>  		 * so sync bdev first and then wait for our queues to become
>  		 * empty
>  		 */
> -		if (device->block && device->block->bdev_handle)
> -			bdev_mark_dead(device->block->bdev_handle->bdev, false);
> +		if (device->block && device->block->bdev_file)
> +			bdev_mark_dead(file_bdev(device->block->bdev_file), false);
>  		dasd_schedule_device_bh(device);
>  		rc = wait_event_interruptible(shutdown_waitq,
>  					      _wait_for_empty_queues(device));
> diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
> index 55e3abe94cde..8bf2cf0ccc15 100644
> --- a/drivers/s390/block/dasd_genhd.c
> +++ b/drivers/s390/block/dasd_genhd.c
> @@ -127,15 +127,15 @@ void dasd_gendisk_free(struct dasd_block *block)
>   */
>  int dasd_scan_partitions(struct dasd_block *block)
>  {
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	int rc;
>  
> -	bdev_handle = bdev_open_by_dev(disk_devt(block->gdp), BLK_OPEN_READ,
> +	bdev_file = bdev_file_open_by_dev(disk_devt(block->gdp), BLK_OPEN_READ,
>  				       NULL, NULL);
> -	if (IS_ERR(bdev_handle)) {
> +	if (IS_ERR(bdev_file)) {
>  		DBF_DEV_EVENT(DBF_ERR, block->base,
>  			      "scan partitions error, blkdev_get returned %ld",
> -			      PTR_ERR(bdev_handle));
> +			      PTR_ERR(bdev_file));
>  		return -ENODEV;
>  	}
>  
> @@ -147,15 +147,15 @@ int dasd_scan_partitions(struct dasd_block *block)
>  				"scan partitions error, rc %d", rc);
>  
>  	/*
> -	 * Since the matching bdev_release() call to the
> -	 * bdev_open_by_path() in this function is not called before
> +	 * Since the matching fput() call to the
> +	 * bdev_file_open_by_path() in this function is not called before
>  	 * dasd_destroy_partitions the offline open_count limit needs to be
> -	 * increased from 0 to 1. This is done by setting device->bdev_handle
> +	 * increased from 0 to 1. This is done by setting device->bdev_file
>  	 * (see dasd_generic_set_offline). As long as the partition detection
>  	 * is running no offline should be allowed. That is why the assignment
> -	 * to block->bdev_handle is done AFTER the BLKRRPART ioctl.
> +	 * to block->bdev_file is done AFTER the BLKRRPART ioctl.
>  	 */
> -	block->bdev_handle = bdev_handle;
> +	block->bdev_file = bdev_file;
>  	return 0;
>  }
>  
> @@ -165,21 +165,21 @@ int dasd_scan_partitions(struct dasd_block *block)
>   */
>  void dasd_destroy_partitions(struct dasd_block *block)
>  {
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  
>  	/*
> -	 * Get the bdev_handle pointer from the device structure and clear
> -	 * device->bdev_handle to lower the offline open_count limit again.
> +	 * Get the bdev_file pointer from the device structure and clear
> +	 * device->bdev_file to lower the offline open_count limit again.
>  	 */
> -	bdev_handle = block->bdev_handle;
> -	block->bdev_handle = NULL;
> +	bdev_file = block->bdev_file;
> +	block->bdev_file = NULL;
>  
> -	mutex_lock(&bdev_handle->bdev->bd_disk->open_mutex);
> -	bdev_disk_changed(bdev_handle->bdev->bd_disk, true);
> -	mutex_unlock(&bdev_handle->bdev->bd_disk->open_mutex);
> +	mutex_lock(&file_bdev(bdev_file)->bd_disk->open_mutex);
> +	bdev_disk_changed(file_bdev(bdev_file)->bd_disk, true);
> +	mutex_unlock(&file_bdev(bdev_file)->bd_disk->open_mutex);
>  
>  	/* Matching blkdev_put to the blkdev_get in dasd_scan_partitions. */
> -	bdev_release(bdev_handle);
> +	fput(bdev_file);
>  }
>  
>  int dasd_gendisk_init(void)
> diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
> index 1b1b8a41c4d4..aecd502aec51 100644
> --- a/drivers/s390/block/dasd_int.h
> +++ b/drivers/s390/block/dasd_int.h
> @@ -650,7 +650,7 @@ struct dasd_block {
>  	struct gendisk *gdp;
>  	spinlock_t request_queue_lock;
>  	struct blk_mq_tag_set tag_set;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	atomic_t open_count;
>  
>  	unsigned long blocks;	   /* size of volume in blocks */
> diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
> index 61b9675e2a67..de85a5e4e21b 100644
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
> @@ -537,7 +537,7 @@ static int __dasd_ioctl_information(struct dasd_block *block,
>  	 * This must be hidden from user-space.
>  	 */
>  	dasd_info->open_count = atomic_read(&block->open_count);
> -	if (!block->bdev_handle)
> +	if (!block->bdev_file)
>  		dasd_info->open_count++;
>  
>  	/*
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

