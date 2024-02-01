Return-Path: <linux-fsdevel+bounces-9848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06358845528
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41821B23168
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DEE15B11D;
	Thu,  1 Feb 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kr0RPHOo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IIw9kuGM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kr0RPHOo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IIw9kuGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D94DA0D;
	Thu,  1 Feb 2024 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782927; cv=none; b=ug5LD9raOCbsu/YNurz4VB3cVLNuSjeYYpErCXCBrTpN2sWJ/eQd3qUYluQ2APs4Qo+tQBUERwkNEJE23dhO+mzG5JY6SdXnR3+R3Pf18LTJns2TJq+e/FSMe31qyN+u6jhEfRCDeaa4AR6Dj5uXYEKb8LpGqNx2yfK+y/mGlyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782927; c=relaxed/simple;
	bh=kjhO520qW0FAheL4epHZcV4dp1zqbaEGuSsfSHJAZCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFR59UOgUv0srQhXtrL5uA7t5zQ3l3W4Y6OWBSIuDiS0MSc+idQ6zMhbtksNojr3D18jEcK2oaqKvcwVMNwMpNM6pWGyV56wOo4a4OnuEGqBWV5pbqDjKqeGvr3pkb4xlxBnBnpstfvhkGB4im2HK1UFjWGaEvh9EIcXAn/FfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kr0RPHOo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IIw9kuGM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kr0RPHOo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IIw9kuGM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE1711FB96;
	Thu,  1 Feb 2024 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOWjVusFTOjRcR5a0H/dTg/Mz4qLoYQgA+Ph3FK0RVQ=;
	b=kr0RPHOo23hKUonEPF4MQUk94a0Ogfu3AlgzpC7WzE5h+deOsfgt1lKKHDkDu+WX8pkQMO
	IlC5EjpNi6CS8AqqiTCRQk+8b+4nPgAsLNMsHaSgiJdipGVWmvtv72U0UVv4rlIZn6cqlG
	YcbtI84ephrRQ5GOxCngd2STRxrD4CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOWjVusFTOjRcR5a0H/dTg/Mz4qLoYQgA+Ph3FK0RVQ=;
	b=IIw9kuGMXmPLG5gRkUjgNLs6nucxJrAt1q1uEQiJz35aB1UOyX2GGGH7GdbaayRphx0AIM
	GPvmR7oe4/gifhDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOWjVusFTOjRcR5a0H/dTg/Mz4qLoYQgA+Ph3FK0RVQ=;
	b=kr0RPHOo23hKUonEPF4MQUk94a0Ogfu3AlgzpC7WzE5h+deOsfgt1lKKHDkDu+WX8pkQMO
	IlC5EjpNi6CS8AqqiTCRQk+8b+4nPgAsLNMsHaSgiJdipGVWmvtv72U0UVv4rlIZn6cqlG
	YcbtI84ephrRQ5GOxCngd2STRxrD4CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOWjVusFTOjRcR5a0H/dTg/Mz4qLoYQgA+Ph3FK0RVQ=;
	b=IIw9kuGMXmPLG5gRkUjgNLs6nucxJrAt1q1uEQiJz35aB1UOyX2GGGH7GdbaayRphx0AIM
	GPvmR7oe4/gifhDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A224D1329F;
	Thu,  1 Feb 2024 10:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id PSaSJ8twu2UdXwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:22:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4282DA0809; Thu,  1 Feb 2024 11:22:03 +0100 (CET)
Date: Thu, 1 Feb 2024 11:22:03 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 24/34] nfs: port block device access to files
Message-ID: <20240201102203.4q64hie7mzgpyxfx@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-24-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-24-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kr0RPHOo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IIw9kuGM
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AE1711FB96
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 23-01-24 14:26:41, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza
> ---
>  fs/nfs/blocklayout/blocklayout.h |  2 +-
>  fs/nfs/blocklayout/dev.c         | 68 ++++++++++++++++++++--------------------
>  2 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
> index b4294a8aa2d4..f1eeb4914199 100644
> --- a/fs/nfs/blocklayout/blocklayout.h
> +++ b/fs/nfs/blocklayout/blocklayout.h
> @@ -108,7 +108,7 @@ struct pnfs_block_dev {
>  	struct pnfs_block_dev		*children;
>  	u64				chunk_size;
>  
> -	struct bdev_handle		*bdev_handle;
> +	struct file			*bdev_file;
>  	u64				disk_offset;
>  
>  	u64				pr_key;
> diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
> index c97ebc42ec0f..93ef7f864980 100644
> --- a/fs/nfs/blocklayout/dev.c
> +++ b/fs/nfs/blocklayout/dev.c
> @@ -25,17 +25,17 @@ bl_free_device(struct pnfs_block_dev *dev)
>  	} else {
>  		if (dev->pr_registered) {
>  			const struct pr_ops *ops =
> -				dev->bdev_handle->bdev->bd_disk->fops->pr_ops;
> +				file_bdev(dev->bdev_file)->bd_disk->fops->pr_ops;
>  			int error;
>  
> -			error = ops->pr_register(dev->bdev_handle->bdev,
> +			error = ops->pr_register(file_bdev(dev->bdev_file),
>  				dev->pr_key, 0, false);
>  			if (error)
>  				pr_err("failed to unregister PR key.\n");
>  		}
>  
> -		if (dev->bdev_handle)
> -			bdev_release(dev->bdev_handle);
> +		if (dev->bdev_file)
> +			fput(dev->bdev_file);
>  	}
>  }
>  
> @@ -169,7 +169,7 @@ static bool bl_map_simple(struct pnfs_block_dev *dev, u64 offset,
>  	map->start = dev->start;
>  	map->len = dev->len;
>  	map->disk_offset = dev->disk_offset;
> -	map->bdev = dev->bdev_handle->bdev;
> +	map->bdev = file_bdev(dev->bdev_file);
>  	return true;
>  }
>  
> @@ -236,26 +236,26 @@ bl_parse_simple(struct nfs_server *server, struct pnfs_block_dev *d,
>  		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
>  {
>  	struct pnfs_block_volume *v = &volumes[idx];
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	dev_t dev;
>  
>  	dev = bl_resolve_deviceid(server, v, gfp_mask);
>  	if (!dev)
>  		return -EIO;
>  
> -	bdev_handle = bdev_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
> +	bdev_file = bdev_file_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
>  				       NULL, NULL);
> -	if (IS_ERR(bdev_handle)) {
> +	if (IS_ERR(bdev_file)) {
>  		printk(KERN_WARNING "pNFS: failed to open device %d:%d (%ld)\n",
> -			MAJOR(dev), MINOR(dev), PTR_ERR(bdev_handle));
> -		return PTR_ERR(bdev_handle);
> +			MAJOR(dev), MINOR(dev), PTR_ERR(bdev_file));
> +		return PTR_ERR(bdev_file);
>  	}
> -	d->bdev_handle = bdev_handle;
> -	d->len = bdev_nr_bytes(bdev_handle->bdev);
> +	d->bdev_file = bdev_file;
> +	d->len = bdev_nr_bytes(file_bdev(bdev_file));
>  	d->map = bl_map_simple;
>  
>  	printk(KERN_INFO "pNFS: using block device %s\n",
> -		bdev_handle->bdev->bd_disk->disk_name);
> +		file_bdev(bdev_file)->bd_disk->disk_name);
>  	return 0;
>  }
>  
> @@ -300,10 +300,10 @@ bl_validate_designator(struct pnfs_block_volume *v)
>  	}
>  }
>  
> -static struct bdev_handle *
> +static struct file *
>  bl_open_path(struct pnfs_block_volume *v, const char *prefix)
>  {
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	const char *devname;
>  
>  	devname = kasprintf(GFP_KERNEL, "/dev/disk/by-id/%s%*phN",
> @@ -311,15 +311,15 @@ bl_open_path(struct pnfs_block_volume *v, const char *prefix)
>  	if (!devname)
>  		return ERR_PTR(-ENOMEM);
>  
> -	bdev_handle = bdev_open_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
> +	bdev_file = bdev_file_open_by_path(devname, BLK_OPEN_READ | BLK_OPEN_WRITE,
>  					NULL, NULL);
> -	if (IS_ERR(bdev_handle)) {
> +	if (IS_ERR(bdev_file)) {
>  		pr_warn("pNFS: failed to open device %s (%ld)\n",
> -			devname, PTR_ERR(bdev_handle));
> +			devname, PTR_ERR(bdev_file));
>  	}
>  
>  	kfree(devname);
> -	return bdev_handle;
> +	return bdev_file;
>  }
>  
>  static int
> @@ -327,7 +327,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
>  		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
>  {
>  	struct pnfs_block_volume *v = &volumes[idx];
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	const struct pr_ops *ops;
>  	int error;
>  
> @@ -340,14 +340,14 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
>  	 * On other distributions like Debian, the default SCSI by-id path will
>  	 * point to the dm-multipath device if one exists.
>  	 */
> -	bdev_handle = bl_open_path(v, "dm-uuid-mpath-0x");
> -	if (IS_ERR(bdev_handle))
> -		bdev_handle = bl_open_path(v, "wwn-0x");
> -	if (IS_ERR(bdev_handle))
> -		return PTR_ERR(bdev_handle);
> -	d->bdev_handle = bdev_handle;
> -
> -	d->len = bdev_nr_bytes(d->bdev_handle->bdev);
> +	bdev_file = bl_open_path(v, "dm-uuid-mpath-0x");
> +	if (IS_ERR(bdev_file))
> +		bdev_file = bl_open_path(v, "wwn-0x");
> +	if (IS_ERR(bdev_file))
> +		return PTR_ERR(bdev_file);
> +	d->bdev_file = bdev_file;
> +
> +	d->len = bdev_nr_bytes(file_bdev(d->bdev_file));
>  	d->map = bl_map_simple;
>  	d->pr_key = v->scsi.pr_key;
>  
> @@ -355,20 +355,20 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
>  		return -ENODEV;
>  
>  	pr_info("pNFS: using block device %s (reservation key 0x%llx)\n",
> -		d->bdev_handle->bdev->bd_disk->disk_name, d->pr_key);
> +		file_bdev(d->bdev_file)->bd_disk->disk_name, d->pr_key);
>  
> -	ops = d->bdev_handle->bdev->bd_disk->fops->pr_ops;
> +	ops = file_bdev(d->bdev_file)->bd_disk->fops->pr_ops;
>  	if (!ops) {
>  		pr_err("pNFS: block device %s does not support reservations.",
> -				d->bdev_handle->bdev->bd_disk->disk_name);
> +				file_bdev(d->bdev_file)->bd_disk->disk_name);
>  		error = -EINVAL;
>  		goto out_blkdev_put;
>  	}
>  
> -	error = ops->pr_register(d->bdev_handle->bdev, 0, d->pr_key, true);
> +	error = ops->pr_register(file_bdev(d->bdev_file), 0, d->pr_key, true);
>  	if (error) {
>  		pr_err("pNFS: failed to register key for block device %s.",
> -				d->bdev_handle->bdev->bd_disk->disk_name);
> +				file_bdev(d->bdev_file)->bd_disk->disk_name);
>  		goto out_blkdev_put;
>  	}
>  
> @@ -376,7 +376,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
>  	return 0;
>  
>  out_blkdev_put:
> -	bdev_release(d->bdev_handle);
> +	fput(d->bdev_file);
>  	return error;
>  }
>  
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

