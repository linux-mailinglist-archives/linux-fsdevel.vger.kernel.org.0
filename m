Return-Path: <linux-fsdevel+bounces-9835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0B845482
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B23F1F2881D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3759815B0F6;
	Thu,  1 Feb 2024 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mqzkSvkz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q4gzzpmf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mqzkSvkz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q4gzzpmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ADC4DA19;
	Thu,  1 Feb 2024 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780871; cv=none; b=B+oFrKhlkQM/yC/01C+sgiCI2iOE3vBRNUbFqjUruHd8mkzEGxXO9A7jl8D7tXn3mvzmRO3d//ZcDUnEpDeirj2Dn6e6cnY55odIusELE4jorpOuX/sAQLt1NFfsn8pz6krUUVOKGmuYN5ud/Fo5xc1ph0h1jvwTSUmKj6pXrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780871; c=relaxed/simple;
	bh=7lgWTFR3nLe7e6C9QYHaPxadlHKrTQzqygh+h9lTtKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4RSJu0ee0F9N7XJk87V9hWEAoDSa+deKMvowhQC19wYWCmnJ5G6Q6eTXx+BqwrXNZD5LZwmsdvBqXNs5kQnvCO70QDBow3v6i419HP9y7c1QOROSccfdih4FcOAjmwkp5GeIczcZ4KM3HxEr1cIgZrxKqUwP20DDsnXceKfMzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mqzkSvkz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q4gzzpmf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mqzkSvkz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q4gzzpmf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00CC5221CF;
	Thu,  1 Feb 2024 09:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706780868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=egq5yfx8ebf06VIhCM9L6GSgAjHxR5yAT3J5HnQP22c=;
	b=mqzkSvkzZan+MInbKs3Crr2qvJtPM65ULwSsH8bMAvFw5PJSw0PVSOAFEcu69zyTmfevXI
	6QLYiGgsZnFlN9bCAXdpQt0uoxgPxqk0kxQxpR5b2lyoAgcUgE5Br5/WxFQhCxGikIrrqR
	LLeyRQfZ3/Qz9WvRAkied6UaI5Eca/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706780868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=egq5yfx8ebf06VIhCM9L6GSgAjHxR5yAT3J5HnQP22c=;
	b=q4gzzpmfy1XClitqgcI74kEcqQarYA8DB7TXALdTlZemLGiRa+/yeNnWSkKqpuJ2C449tb
	Nm42/zo79Ry3EJAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706780868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=egq5yfx8ebf06VIhCM9L6GSgAjHxR5yAT3J5HnQP22c=;
	b=mqzkSvkzZan+MInbKs3Crr2qvJtPM65ULwSsH8bMAvFw5PJSw0PVSOAFEcu69zyTmfevXI
	6QLYiGgsZnFlN9bCAXdpQt0uoxgPxqk0kxQxpR5b2lyoAgcUgE5Br5/WxFQhCxGikIrrqR
	LLeyRQfZ3/Qz9WvRAkied6UaI5Eca/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706780868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=egq5yfx8ebf06VIhCM9L6GSgAjHxR5yAT3J5HnQP22c=;
	b=q4gzzpmfy1XClitqgcI74kEcqQarYA8DB7TXALdTlZemLGiRa+/yeNnWSkKqpuJ2C449tb
	Nm42/zo79Ry3EJAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E3EE813594;
	Thu,  1 Feb 2024 09:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id z1RWN8Nou2X6VgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 09:47:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 87023A0809; Thu,  1 Feb 2024 10:47:43 +0100 (CET)
Date: Thu, 1 Feb 2024 10:47:43 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 14/34] block2mtd: port device access to files
Message-ID: <20240201094743.235uoxzqg6bwnalq@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-14-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-14-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out1.suse.de;
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue 23-01-24 14:26:31, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/mtd/devices/block2mtd.c | 46 +++++++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
> index aa44a23ec045..97a00ec9a4d4 100644
> --- a/drivers/mtd/devices/block2mtd.c
> +++ b/drivers/mtd/devices/block2mtd.c
> @@ -37,7 +37,7 @@
>  /* Info for the block device */
>  struct block2mtd_dev {
>  	struct list_head list;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	struct mtd_info mtd;
>  	struct mutex write_mutex;
>  };
> @@ -55,8 +55,7 @@ static struct page *page_read(struct address_space *mapping, pgoff_t index)
>  /* erase a specified part of the device */
>  static int _block2mtd_erase(struct block2mtd_dev *dev, loff_t to, size_t len)
>  {
> -	struct address_space *mapping =
> -				dev->bdev_handle->bdev->bd_inode->i_mapping;
> +	struct address_space *mapping = dev->bdev_file->f_mapping;
>  	struct page *page;
>  	pgoff_t index = to >> PAGE_SHIFT;	// page index
>  	int pages = len >> PAGE_SHIFT;
> @@ -106,8 +105,7 @@ static int block2mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
>  		size_t *retlen, u_char *buf)
>  {
>  	struct block2mtd_dev *dev = mtd->priv;
> -	struct address_space *mapping =
> -				dev->bdev_handle->bdev->bd_inode->i_mapping;
> +	struct address_space *mapping = dev->bdev_file->f_mapping;
>  	struct page *page;
>  	pgoff_t index = from >> PAGE_SHIFT;
>  	int offset = from & (PAGE_SIZE-1);
> @@ -142,8 +140,7 @@ static int _block2mtd_write(struct block2mtd_dev *dev, const u_char *buf,
>  		loff_t to, size_t len, size_t *retlen)
>  {
>  	struct page *page;
> -	struct address_space *mapping =
> -				dev->bdev_handle->bdev->bd_inode->i_mapping;
> +	struct address_space *mapping = dev->bdev_file->f_mapping;
>  	pgoff_t index = to >> PAGE_SHIFT;	// page index
>  	int offset = to & ~PAGE_MASK;	// page offset
>  	int cpylen;
> @@ -198,7 +195,7 @@ static int block2mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
>  static void block2mtd_sync(struct mtd_info *mtd)
>  {
>  	struct block2mtd_dev *dev = mtd->priv;
> -	sync_blockdev(dev->bdev_handle->bdev);
> +	sync_blockdev(file_bdev(dev->bdev_file));
>  	return;
>  }
>  
> @@ -210,10 +207,9 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
>  
>  	kfree(dev->mtd.name);
>  
> -	if (dev->bdev_handle) {
> -		invalidate_mapping_pages(
> -			dev->bdev_handle->bdev->bd_inode->i_mapping, 0, -1);
> -		bdev_release(dev->bdev_handle);
> +	if (dev->bdev_file) {
> +		invalidate_mapping_pages(dev->bdev_file->f_mapping, 0, -1);
> +		fput(dev->bdev_file);
>  	}
>  
>  	kfree(dev);
> @@ -223,10 +219,10 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
>   * This function is marked __ref because it calls the __init marked
>   * early_lookup_bdev when called from the early boot code.
>   */
> -static struct bdev_handle __ref *mdtblock_early_get_bdev(const char *devname,
> +static struct file __ref *mdtblock_early_get_bdev(const char *devname,
>  		blk_mode_t mode, int timeout, struct block2mtd_dev *dev)
>  {
> -	struct bdev_handle *bdev_handle = ERR_PTR(-ENODEV);
> +	struct file *bdev_file = ERR_PTR(-ENODEV);
>  #ifndef MODULE
>  	int i;
>  
> @@ -234,7 +230,7 @@ static struct bdev_handle __ref *mdtblock_early_get_bdev(const char *devname,
>  	 * We can't use early_lookup_bdev from a running system.
>  	 */
>  	if (system_state >= SYSTEM_RUNNING)
> -		return bdev_handle;
> +		return bdev_file;
>  
>  	/*
>  	 * We might not have the root device mounted at this point.
> @@ -253,20 +249,20 @@ static struct bdev_handle __ref *mdtblock_early_get_bdev(const char *devname,
>  		wait_for_device_probe();
>  
>  		if (!early_lookup_bdev(devname, &devt)) {
> -			bdev_handle = bdev_open_by_dev(devt, mode, dev, NULL);
> -			if (!IS_ERR(bdev_handle))
> +			bdev_file = bdev_file_open_by_dev(devt, mode, dev, NULL);
> +			if (!IS_ERR(bdev_file))
>  				break;
>  		}
>  	}
>  #endif
> -	return bdev_handle;
> +	return bdev_file;
>  }
>  
>  static struct block2mtd_dev *add_device(char *devname, int erase_size,
>  		char *label, int timeout)
>  {
>  	const blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_WRITE;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	struct block_device *bdev;
>  	struct block2mtd_dev *dev;
>  	char *name;
> @@ -279,16 +275,16 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
>  		return NULL;
>  
>  	/* Get a handle on the device */
> -	bdev_handle = bdev_open_by_path(devname, mode, dev, NULL);
> -	if (IS_ERR(bdev_handle))
> -		bdev_handle = mdtblock_early_get_bdev(devname, mode, timeout,
> +	bdev_file = bdev_file_open_by_path(devname, mode, dev, NULL);
> +	if (IS_ERR(bdev_file))
> +		bdev_file = mdtblock_early_get_bdev(devname, mode, timeout,
>  						      dev);
> -	if (IS_ERR(bdev_handle)) {
> +	if (IS_ERR(bdev_file)) {
>  		pr_err("error: cannot open device %s\n", devname);
>  		goto err_free_block2mtd;
>  	}
> -	dev->bdev_handle = bdev_handle;
> -	bdev = bdev_handle->bdev;
> +	dev->bdev_file = bdev_file;
> +	bdev = file_bdev(bdev_file);
>  
>  	if (MAJOR(bdev->bd_dev) == MTD_BLOCK_MAJOR) {
>  		pr_err("attempting to use an MTD device as a block device\n");
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

