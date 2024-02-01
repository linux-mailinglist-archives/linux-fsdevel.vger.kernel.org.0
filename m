Return-Path: <linux-fsdevel+bounces-9861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10E18455CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CB12870AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB21615CD53;
	Thu,  1 Feb 2024 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b3/AQwd5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TmFKDY+W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b3/AQwd5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TmFKDY+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A50115B99B;
	Thu,  1 Feb 2024 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784866; cv=none; b=QfSWme+JKeXtYtaK2TvWpEVyjyb+77SG3aB4Nx+EOaCLgeJN1v+CSD1UpM4BeFt/RYdUz7Ks12HDxxXyoHGI5OtbQFYV8RJ68bYKY1aaxWQDrlas8/jMexE7HXaOO8BNr98DOe8dXF0lKlz92sIT62G7ejlPZdwCXCTcY4iTQHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784866; c=relaxed/simple;
	bh=3Iu2sphE5rfPf2AGjH10rpfskubb6yIS6l5SwFDj2AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+s66a3vadMDzpbr3RZW2qz7pso2b9w3xFwoc9rSwWNRN7AOJdCWDw6BdVOWo8P5f30PQsJ9CUKbLH3HuYLQv+vppHDtYWL/EtZDcqyxIZqJnOojEphLbli1Sts46HwEQq3iIrwKP+hXH7VXUpv/7p0XWGS1P0n9/WtDpXuqpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b3/AQwd5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TmFKDY+W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b3/AQwd5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TmFKDY+W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FA02221C1;
	Thu,  1 Feb 2024 10:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706784862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ND1eHWEsj/lVZfFUdkQY9d40Ezt3xmgY3ehhDij8XGQ=;
	b=b3/AQwd58J3mvrbSTbw4rjP0y68Oc7QPVuzs/f8d9Gs7A+K9p7ziZFF78U0TxgczDLW8uX
	02VZOaDmlLszXp57pm8euBv04lqsh6/HIgOl3ONWjpGzcMkfjrKp8WMntgq8nLe1C1ZgKG
	Gv44UzG6cyTY8omzHwr85ql9a5tuHWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706784862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ND1eHWEsj/lVZfFUdkQY9d40Ezt3xmgY3ehhDij8XGQ=;
	b=TmFKDY+Wz7ogQuco+MgbdbQwyKJwEBes+p3vvcyofpB1xyta/wZEGeShoDt40wtm2ZpBye
	RU4wSVEZ8vBl5nBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706784862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ND1eHWEsj/lVZfFUdkQY9d40Ezt3xmgY3ehhDij8XGQ=;
	b=b3/AQwd58J3mvrbSTbw4rjP0y68Oc7QPVuzs/f8d9Gs7A+K9p7ziZFF78U0TxgczDLW8uX
	02VZOaDmlLszXp57pm8euBv04lqsh6/HIgOl3ONWjpGzcMkfjrKp8WMntgq8nLe1C1ZgKG
	Gv44UzG6cyTY8omzHwr85ql9a5tuHWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706784862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ND1eHWEsj/lVZfFUdkQY9d40Ezt3xmgY3ehhDij8XGQ=;
	b=TmFKDY+Wz7ogQuco+MgbdbQwyKJwEBes+p3vvcyofpB1xyta/wZEGeShoDt40wtm2ZpBye
	RU4wSVEZ8vBl5nBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74539139B1;
	Thu,  1 Feb 2024 10:54:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +odeHF54u2X9EgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:54:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1E602A0809; Thu,  1 Feb 2024 11:54:22 +0100 (CET)
Date: Thu, 1 Feb 2024 11:54:22 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 29/34] bdev: make struct bdev_handle private to the
 block layer
Message-ID: <20240201105422.3wuw332vh4tusbzp@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-29-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-29-adbd023e19cc@kernel.org>
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue 23-01-24 14:26:46, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Some comments below...

> @@ -795,15 +813,15 @@ static void bdev_yield_write_access(struct block_device *bdev, blk_mode_t mode)
>  }
>  
>  /**
> - * bdev_open_by_dev - open a block device by device number
> - * @dev: device number of block device to open
> + * bdev_open - open a block device
> + * @bdev: block device to open
>   * @mode: open mode (BLK_OPEN_*)
>   * @holder: exclusive holder identifier
>   * @hops: holder operations
> + * @bdev_file: file for the block device
>   *
> - * Open the block device described by device number @dev. If @holder is not
> - * %NULL, the block device is opened with exclusive access.  Exclusive opens may
> - * nest for the same @holder.
> + * Open the block device. If @holder is not %NULL, the block device is opened
> + * with exclusive access.  Exclusive opens may nest for the same @holder.
>   *
>   * Use this interface ONLY if you really do not have anything better - i.e. when
>   * you are behind a truly sucky interface and all you are given is a device
      ^^^
I guess this part of comment is stale now?

> @@ -902,7 +897,22 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  	handle->bdev = bdev;
>  	handle->holder = holder;
>  	handle->mode = mode;
> -	return handle;
> +
> +	/*
> +	 * Preserve backwards compatibility and allow large file access
> +	 * even if userspace doesn't ask for it explicitly. Some mkfs
> +	 * binary needs it. We might want to drop this workaround
> +	 * during an unstable branch.
> +	 */

Heh, I think the sentense "We might want to drop this workaround during an
unstable branch." does not need to be moved as well :)

> +	bdev_file->f_flags |= O_LARGEFILE;
> +	bdev_file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
> +	if (bdev_nowait(bdev))
> +		bdev_file->f_mode |= FMODE_NOWAIT;
> +	bdev_file->f_mapping = handle->bdev->bd_inode->i_mapping;
> +	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
> +	bdev_file->private_data = handle;
> +
> +	return 0;
>  put_module:
>  	module_put(disk->fops->owner);
>  abort_claiming:
> @@ -910,11 +920,8 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  		bd_abort_claiming(bdev, holder);
>  	mutex_unlock(&disk->open_mutex);
>  	disk_unblock_events(disk);
> -put_blkdev:
> -	blkdev_put_no_open(bdev);
> -free_handle:
>  	kfree(handle);
> -	return ERR_PTR(ret);
> +	return ret;
>  }
>  
>  static unsigned blk_to_file_flags(blk_mode_t mode)
> @@ -954,29 +961,35 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  				   const struct blk_holder_ops *hops)
>  {
>  	struct file *bdev_file;
> -	struct bdev_handle *handle;
> +	struct block_device *bdev;
>  	unsigned int flags;
> +	int ret;
>  
> -	handle = bdev_open_by_dev(dev, mode, holder, hops);
> -	if (IS_ERR(handle))
> -		return ERR_CAST(handle);
> +	ret = bdev_permission(dev, 0, holder);
				   ^^ Maybe I'm missing something but why
do you pass 0 mode here?


> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	bdev = blkdev_get_no_open(dev);
> +	if (!bdev)
> +		return ERR_PTR(-ENXIO);
>  
>  	flags = blk_to_file_flags(mode);
> -	bdev_file = alloc_file_pseudo_noaccount(handle->bdev->bd_inode,
> +	bdev_file = alloc_file_pseudo_noaccount(bdev->bd_inode,
>  			blockdev_mnt, "", flags | O_LARGEFILE, &def_blk_fops);
>  	if (IS_ERR(bdev_file)) {
> -		bdev_release(handle);
> +		blkdev_put_no_open(bdev);
>  		return bdev_file;
>  	}
> -	ihold(handle->bdev->bd_inode);
> +	bdev_file->f_mode &= ~FMODE_OPENED;

Hum, why do you need these games with FMODE_OPENED? I suspect you want to
influence fput() behavior but then AFAICT we will leak dentry, mnt, etc. on
error? If this is indeed needed, it deserves a comment...

> -	bdev_file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
> -	if (bdev_nowait(handle->bdev))
> -		bdev_file->f_mode |= FMODE_NOWAIT;
> -
> -	bdev_file->f_mapping = handle->bdev->bd_inode->i_mapping;
> -	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
> -	bdev_file->private_data = handle;
> +	ihold(bdev->bd_inode);
> +	ret = bdev_open(bdev, mode, holder, hops, bdev_file);
> +	if (ret) {
> +		fput(bdev_file);
> +		return ERR_PTR(ret);
> +	}
> +	/* Now that thing is opened. */
> +	bdev_file->f_mode |= FMODE_OPENED;
>  	return bdev_file;
>  }
>  EXPORT_SYMBOL(bdev_file_open_by_dev);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

