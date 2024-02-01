Return-Path: <linux-fsdevel+bounces-9862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AC88455DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA871F2168F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FAA15CD74;
	Thu,  1 Feb 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yUdRTSp/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+cKN22IA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yUdRTSp/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+cKN22IA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5F515B99C;
	Thu,  1 Feb 2024 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785046; cv=none; b=KHsw7ZDcM0xzcJNkMG9ZvUjqbE6KINdIo+fsY33brIL8/RedfbX2vGaw2afL67B+g5RLaKCiFaDEPApoD1JRf/34D0EEbrLIGqXe7gQswxvY6M4bErjfYtNURkgCwQWXdTtoDsglC8v/7gfUcO0YfaRdvwqPL3YJafHm42YWldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785046; c=relaxed/simple;
	bh=VE4eL9p1PqjoQy9U6UbshuGUYlgvMRlfzCK3tA05VCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEIHyCMIM4rVU1e54kySV93JQaWvYsQlLn0Sxn56pLW7llCsH1mfwxO2G4mRLrYZ59bqsOffWYWnxR76yLShiDMeMDsN5xmwdmLpORGj53G2ZbAd721QIzqQTaP3eR8io90GR7JdLweM0aijvA40LlyfgSzkG8ZhncS2OPlwhDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yUdRTSp/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+cKN22IA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yUdRTSp/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+cKN22IA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A2651FBA6;
	Thu,  1 Feb 2024 10:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706785042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwlwis/JWPSfokL3cZZ5j7+eVgsHk4oxfWF137WUuH4=;
	b=yUdRTSp/BfJtURIWkRdXWDP7ZrjedweInJHlodQ+XlYcYkm0aDlDzb9dO4ggkB5d4Zm9/E
	zp3761PdqVY+S+hJz1f61gzFCOgjOLF1SkRJzo/x8+dGROHSV0ISGzp6O6+M1ruvtbpP5e
	g+idxNMubgWw6b2B7Qf2beiIEMO86OE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706785042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwlwis/JWPSfokL3cZZ5j7+eVgsHk4oxfWF137WUuH4=;
	b=+cKN22IAGhqdk/ubvf6oZGuim7gnX5DPQpgBSkYDM6Xkh6/xJjPx+ATCJaNOiZuoPgZGf0
	HEOl6aDvoxJqICDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706785042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwlwis/JWPSfokL3cZZ5j7+eVgsHk4oxfWF137WUuH4=;
	b=yUdRTSp/BfJtURIWkRdXWDP7ZrjedweInJHlodQ+XlYcYkm0aDlDzb9dO4ggkB5d4Zm9/E
	zp3761PdqVY+S+hJz1f61gzFCOgjOLF1SkRJzo/x8+dGROHSV0ISGzp6O6+M1ruvtbpP5e
	g+idxNMubgWw6b2B7Qf2beiIEMO86OE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706785042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwlwis/JWPSfokL3cZZ5j7+eVgsHk4oxfWF137WUuH4=;
	b=+cKN22IAGhqdk/ubvf6oZGuim7gnX5DPQpgBSkYDM6Xkh6/xJjPx+ATCJaNOiZuoPgZGf0
	HEOl6aDvoxJqICDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FB0B139B1;
	Thu,  1 Feb 2024 10:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JaESIxJ5u2W6EwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:57:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4D3ECA0809; Thu,  1 Feb 2024 11:57:22 +0100 (CET)
Date: Thu, 1 Feb 2024 11:57:22 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 30/34] bdev: remove bdev pointer from struct
 bdev_handle
Message-ID: <20240201105722.gau5i4zlxr6l3dek@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-30-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-30-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="yUdRTSp/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+cKN22IA
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
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
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9A2651FBA6
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 23-01-24 14:26:47, Christian Brauner wrote:
> We can always go directly via:
> 
> * I_BDEV(bdev_file->f_inode)
> * I_BDEV(bdev_file->f_mapping->host)
> 
> So keeping struct bdev in struct bdev_handle is redundant.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c | 26 ++++++++++++--------------
>  block/blk.h  |  3 +--
>  block/fops.c |  2 +-
>  3 files changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 34b9a16edb6e..71eaa1b5b7eb 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -51,8 +51,7 @@ EXPORT_SYMBOL(I_BDEV);
>  
>  struct block_device *file_bdev(struct file *bdev_file)
>  {
> -	struct bdev_handle *handle = bdev_file->private_data;
> -	return handle->bdev;
> +	return I_BDEV(bdev_file->f_mapping->host);
>  }
>  EXPORT_SYMBOL(file_bdev);
>  
> @@ -894,7 +893,6 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
>  
>  	if (unblock_events)
>  		disk_unblock_events(disk);
> -	handle->bdev = bdev;
>  	handle->holder = holder;
>  	handle->mode = mode;
>  
> @@ -908,7 +906,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
>  	bdev_file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
>  	if (bdev_nowait(bdev))
>  		bdev_file->f_mode |= FMODE_NOWAIT;
> -	bdev_file->f_mapping = handle->bdev->bd_inode->i_mapping;
> +	bdev_file->f_mapping = bdev->bd_inode->i_mapping;
>  	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
>  	bdev_file->private_data = handle;
>  
> @@ -998,7 +996,7 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
>  				    void *holder,
>  				    const struct blk_holder_ops *hops)
>  {
> -	struct file *bdev_file;
> +	struct file *file;
>  	dev_t dev;
>  	int error;
>  
> @@ -1006,22 +1004,22 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
>  	if (error)
>  		return ERR_PTR(error);
>  
> -	bdev_file = bdev_file_open_by_dev(dev, mode, holder, hops);
> -	if (!IS_ERR(bdev_file) && (mode & BLK_OPEN_WRITE)) {
> -		struct bdev_handle *handle = bdev_file->private_data;
> -		if (bdev_read_only(handle->bdev)) {
> -			fput(bdev_file);
> -			bdev_file = ERR_PTR(-EACCES);
> +	file = bdev_file_open_by_dev(dev, mode, holder, hops);
> +	if (!IS_ERR(file) && (mode & BLK_OPEN_WRITE)) {
> +		if (bdev_read_only(file_bdev(file))) {
> +			fput(file);
> +			file = ERR_PTR(-EACCES);
>  		}
>  	}
>  
> -	return bdev_file;
> +	return file;
>  }
>  EXPORT_SYMBOL(bdev_file_open_by_path);
>  
> -void bdev_release(struct bdev_handle *handle)
> +void bdev_release(struct file *bdev_file)
>  {
> -	struct block_device *bdev = handle->bdev;
> +	struct block_device *bdev = file_bdev(bdev_file);
> +	struct bdev_handle *handle = bdev_file->private_data;
>  	struct gendisk *disk = bdev->bd_disk;
>  
>  	/*
> diff --git a/block/blk.h b/block/blk.h
> index 19b15870284f..7ca24814f3a0 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -26,7 +26,6 @@ struct blk_flush_queue {
>  };
>  
>  struct bdev_handle {
> -	struct block_device *bdev;
>  	void *holder;
>  	blk_mode_t mode;
>  };
> @@ -522,7 +521,7 @@ static inline int req_ref_read(struct request *req)
>  	return atomic_read(&req->ref);
>  }
>  
> -void bdev_release(struct bdev_handle *handle);
> +void bdev_release(struct file *bdev_file);
>  int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
>  	      const struct blk_holder_ops *hops, struct file *bdev_file);
>  int bdev_permission(dev_t dev, blk_mode_t mode, void *holder);
> diff --git a/block/fops.c b/block/fops.c
> index 81ff8c0ce32f..5589bf9c3822 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -622,7 +622,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
>  
>  static int blkdev_release(struct inode *inode, struct file *filp)
>  {
> -	bdev_release(filp->private_data);
> +	bdev_release(filp);
>  	return 0;
>  }
>  
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

