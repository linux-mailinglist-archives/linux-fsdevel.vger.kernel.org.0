Return-Path: <linux-fsdevel+bounces-9694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711EB844708
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C3C28C682
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0714F12DD88;
	Wed, 31 Jan 2024 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CGIp155+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NuLF2Wtr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CGIp155+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NuLF2Wtr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208612BEB7;
	Wed, 31 Jan 2024 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725378; cv=none; b=adEZGwk24+j/Id8kXzvure4IjY+I3eMbf1j+0eS1wTSoUQtjc9eeOqaImZ578x2fr8KTTSjIfhJcCd15uTvcaheT2CGiRRt4McQl3s0Mkq1dSPFWMfTr5uZ1K2I958ZpJ4Khpx/97td5V9TLb8eSSjvppNHO8+KW/XlZz9JwNtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725378; c=relaxed/simple;
	bh=Rbv4JXRt61xWvkAay3a0gEiZoTtCKaJICKZpSQ6fbck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1BaN1WJtK6w/wFRTwVyBRYazf9ZiVO/vtZnPFmBCRdLF7Miw2xO20JI27ojh88/q/vpptYWmH9wxYFOWKFPxg5GcpuUlYuHbnSY7mlQIiC+O6twkd1+xsuzgUHxcQi8RPkF8pCs9Rcx2OSvLoaTOiKDKtC62+BViK+y3vOpU5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CGIp155+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NuLF2Wtr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CGIp155+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NuLF2Wtr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ACF371FB95;
	Wed, 31 Jan 2024 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jGBTn9HQbbxhpUyXZo3wOTfynZbjo5fEDtPQiKmNiA4=;
	b=CGIp155+F3Ipb0KH4D0noVXqRi5ih7hIrZ4FNEpa1OEcptY6aHPBTIsiHXPb9wk34gbTzZ
	cSzunY7LV0mstnydTReKFRwbnvPx7zFUuJKkbGfQo45jG+HXZ2/aA2YibOqtBTob62xBKW
	/LSuTYfy0NJBMdT/yVZ4kCJngLuF+gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jGBTn9HQbbxhpUyXZo3wOTfynZbjo5fEDtPQiKmNiA4=;
	b=NuLF2Wtr4SAeRJxJD4rQJGY+dMVqP3qjY/HSArU8wwZzrnKZKUf7scGv8BvPaHz6VxuT97
	EDTpqA3Rn2Rr+TDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jGBTn9HQbbxhpUyXZo3wOTfynZbjo5fEDtPQiKmNiA4=;
	b=CGIp155+F3Ipb0KH4D0noVXqRi5ih7hIrZ4FNEpa1OEcptY6aHPBTIsiHXPb9wk34gbTzZ
	cSzunY7LV0mstnydTReKFRwbnvPx7zFUuJKkbGfQo45jG+HXZ2/aA2YibOqtBTob62xBKW
	/LSuTYfy0NJBMdT/yVZ4kCJngLuF+gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jGBTn9HQbbxhpUyXZo3wOTfynZbjo5fEDtPQiKmNiA4=;
	b=NuLF2Wtr4SAeRJxJD4rQJGY+dMVqP3qjY/HSArU8wwZzrnKZKUf7scGv8BvPaHz6VxuT97
	EDTpqA3Rn2Rr+TDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A17B3139D9;
	Wed, 31 Jan 2024 18:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IrNmJ/6PumXFJQAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 18:22:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3BBF7A0809; Wed, 31 Jan 2024 19:22:54 +0100 (CET)
Date: Wed, 31 Jan 2024 19:22:54 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 08/34] drbd: port block device access to file
Message-ID: <20240131182254.m3u2loidcd5s44if@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-8-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-8-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CGIp155+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NuLF2Wtr
X-Spamd-Result: default: False [5.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_SPAM(5.10)[100.00%];
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
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 5.29
X-Rspamd-Queue-Id: ACF371FB95
X-Spam-Level: *****
X-Spam-Flag: NO
X-Spamd-Bar: +++++

On Tue 23-01-24 14:26:25, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/drbd/drbd_int.h |  4 +--
>  drivers/block/drbd/drbd_nl.c  | 58 +++++++++++++++++++++----------------------
>  2 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
> index c21e3732759e..94dc0a235919 100644
> --- a/drivers/block/drbd/drbd_int.h
> +++ b/drivers/block/drbd/drbd_int.h
> @@ -524,9 +524,9 @@ struct drbd_md {
>  
>  struct drbd_backing_dev {
>  	struct block_device *backing_bdev;
> -	struct bdev_handle *backing_bdev_handle;
> +	struct file *backing_bdev_file;
>  	struct block_device *md_bdev;
> -	struct bdev_handle *md_bdev_handle;
> +	struct file *f_md_bdev;
>  	struct drbd_md md;
>  	struct disk_conf *disk_conf; /* RCU, for updates: resource->conf_update */
>  	sector_t known_size; /* last known size of that backing device */
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 43747a1aae43..6aed67278e8b 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -1635,45 +1635,45 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
>  	return 0;
>  }
>  
> -static struct bdev_handle *open_backing_dev(struct drbd_device *device,
> +static struct file *open_backing_dev(struct drbd_device *device,
>  		const char *bdev_path, void *claim_ptr, bool do_bd_link)
>  {
> -	struct bdev_handle *handle;
> +	struct file *file;
>  	int err = 0;
>  
> -	handle = bdev_open_by_path(bdev_path, BLK_OPEN_READ | BLK_OPEN_WRITE,
> -				   claim_ptr, NULL);
> -	if (IS_ERR(handle)) {
> +	file = bdev_file_open_by_path(bdev_path, BLK_OPEN_READ | BLK_OPEN_WRITE,
> +				      claim_ptr, NULL);
> +	if (IS_ERR(file)) {
>  		drbd_err(device, "open(\"%s\") failed with %ld\n",
> -				bdev_path, PTR_ERR(handle));
> -		return handle;
> +				bdev_path, PTR_ERR(file));
> +		return file;
>  	}
>  
>  	if (!do_bd_link)
> -		return handle;
> +		return file;
>  
> -	err = bd_link_disk_holder(handle->bdev, device->vdisk);
> +	err = bd_link_disk_holder(file_bdev(file), device->vdisk);
>  	if (err) {
> -		bdev_release(handle);
> +		fput(file);
>  		drbd_err(device, "bd_link_disk_holder(\"%s\", ...) failed with %d\n",
>  				bdev_path, err);
> -		handle = ERR_PTR(err);
> +		file = ERR_PTR(err);
>  	}
> -	return handle;
> +	return file;
>  }
>  
>  static int open_backing_devices(struct drbd_device *device,
>  		struct disk_conf *new_disk_conf,
>  		struct drbd_backing_dev *nbc)
>  {
> -	struct bdev_handle *handle;
> +	struct file *file;
>  
> -	handle = open_backing_dev(device, new_disk_conf->backing_dev, device,
> +	file = open_backing_dev(device, new_disk_conf->backing_dev, device,
>  				  true);
> -	if (IS_ERR(handle))
> +	if (IS_ERR(file))
>  		return ERR_OPEN_DISK;
> -	nbc->backing_bdev = handle->bdev;
> -	nbc->backing_bdev_handle = handle;
> +	nbc->backing_bdev = file_bdev(file);
> +	nbc->backing_bdev_file = file;
>  
>  	/*
>  	 * meta_dev_idx >= 0: external fixed size, possibly multiple
> @@ -1683,7 +1683,7 @@ static int open_backing_devices(struct drbd_device *device,
>  	 * should check it for you already; but if you don't, or
>  	 * someone fooled it, we need to double check here)
>  	 */
> -	handle = open_backing_dev(device, new_disk_conf->meta_dev,
> +	file = open_backing_dev(device, new_disk_conf->meta_dev,
>  		/* claim ptr: device, if claimed exclusively; shared drbd_m_holder,
>  		 * if potentially shared with other drbd minors */
>  			(new_disk_conf->meta_dev_idx < 0) ? (void*)device : (void*)drbd_m_holder,
> @@ -1691,21 +1691,21 @@ static int open_backing_devices(struct drbd_device *device,
>  		 * as would happen with internal metadata. */
>  			(new_disk_conf->meta_dev_idx != DRBD_MD_INDEX_FLEX_INT &&
>  			 new_disk_conf->meta_dev_idx != DRBD_MD_INDEX_INTERNAL));
> -	if (IS_ERR(handle))
> +	if (IS_ERR(file))
>  		return ERR_OPEN_MD_DISK;
> -	nbc->md_bdev = handle->bdev;
> -	nbc->md_bdev_handle = handle;
> +	nbc->md_bdev = file_bdev(file);
> +	nbc->f_md_bdev = file;
>  	return NO_ERROR;
>  }
>  
>  static void close_backing_dev(struct drbd_device *device,
> -		struct bdev_handle *handle, bool do_bd_unlink)
> +		struct file *bdev_file, bool do_bd_unlink)
>  {
> -	if (!handle)
> +	if (!bdev_file)
>  		return;
>  	if (do_bd_unlink)
> -		bd_unlink_disk_holder(handle->bdev, device->vdisk);
> -	bdev_release(handle);
> +		bd_unlink_disk_holder(file_bdev(bdev_file), device->vdisk);
> +	fput(bdev_file);
>  }
>  
>  void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *ldev)
> @@ -1713,9 +1713,9 @@ void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *
>  	if (ldev == NULL)
>  		return;
>  
> -	close_backing_dev(device, ldev->md_bdev_handle,
> +	close_backing_dev(device, ldev->f_md_bdev,
>  			  ldev->md_bdev != ldev->backing_bdev);
> -	close_backing_dev(device, ldev->backing_bdev_handle, true);
> +	close_backing_dev(device, ldev->backing_bdev_file, true);
>  
>  	kfree(ldev->disk_conf);
>  	kfree(ldev);
> @@ -2131,9 +2131,9 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
>   fail:
>  	conn_reconfig_done(connection);
>  	if (nbc) {
> -		close_backing_dev(device, nbc->md_bdev_handle,
> +		close_backing_dev(device, nbc->f_md_bdev,
>  			  nbc->md_bdev != nbc->backing_bdev);
> -		close_backing_dev(device, nbc->backing_bdev_handle, true);
> +		close_backing_dev(device, nbc->backing_bdev_file, true);
>  		kfree(nbc);
>  	}
>  	kfree(new_disk_conf);
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

