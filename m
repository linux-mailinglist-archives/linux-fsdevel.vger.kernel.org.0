Return-Path: <linux-fsdevel+bounces-9698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD3844730
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FBB1B25B16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D1218AFB;
	Wed, 31 Jan 2024 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jpAGjXxn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PtUsiUZv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jpAGjXxn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PtUsiUZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD7937E;
	Wed, 31 Jan 2024 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725959; cv=none; b=AwSKLZn/+CFi2zbT/UzSLEsAZ5iOH2cT9HH4fmsEi4ZnvEBIeUxo9mtz94iR+6yOmRnOar/cKwfQ6o9iqLQXkvU/6mm1u6FCdF5bX7UPSsvfQf3jdHNOce1qoVAuPU1NgOksxRXZ6VUnDIVTDDZXgJdfTSQ8ww8/12weB14ky44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725959; c=relaxed/simple;
	bh=ugzg7SFBmqRNVVDHo/ITp+8HuQpRpVGeF3jev/137Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnP9C9ylPs1ICngZ+ncBdlfyOIbkHA7xdWobB5gRmD/5tTWc5C00iyE4RaQIuQ2skCfcE386r8puh8ZD0V+4uBB6d5ARkdpuD0COJ70UZTbIgHqtQIf0hFzEX9P//iXRkyrQpWUuYSsM0XTCsiVYwKGIC5pChMHQJpzPl/yDF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jpAGjXxn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PtUsiUZv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jpAGjXxn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PtUsiUZv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 931361FB8E;
	Wed, 31 Jan 2024 18:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2iBLw9CN9KSEot10vdLSkJcxxMH8F6oRTLos2sEZ9Qk=;
	b=jpAGjXxnUCyt18XLju9ewxT26c1a+GYmS2Z50gCwGf2QMtwks4YQiYX7D0UG330EIQ9TmZ
	2r+VygAhEqwR3cZVBj/2Gx41KDQx0duh7u/nCzr/Lof2b8/NG81Ef3QnnkuFgtcSCIefVb
	kEHDaokKsSnSCVVpIjPDtXF8h+JTX6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2iBLw9CN9KSEot10vdLSkJcxxMH8F6oRTLos2sEZ9Qk=;
	b=PtUsiUZvGmxj+7IFANKUHR2vPLZ2Wi8SJEAXx3b1PDH3ZM96qRbt6O4CJCyFaqh2EOTIdZ
	/iBTgosTth39g6DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2iBLw9CN9KSEot10vdLSkJcxxMH8F6oRTLos2sEZ9Qk=;
	b=jpAGjXxnUCyt18XLju9ewxT26c1a+GYmS2Z50gCwGf2QMtwks4YQiYX7D0UG330EIQ9TmZ
	2r+VygAhEqwR3cZVBj/2Gx41KDQx0duh7u/nCzr/Lof2b8/NG81Ef3QnnkuFgtcSCIefVb
	kEHDaokKsSnSCVVpIjPDtXF8h+JTX6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2iBLw9CN9KSEot10vdLSkJcxxMH8F6oRTLos2sEZ9Qk=;
	b=PtUsiUZvGmxj+7IFANKUHR2vPLZ2Wi8SJEAXx3b1PDH3ZM96qRbt6O4CJCyFaqh2EOTIdZ
	/iBTgosTth39g6DQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 84429139D9;
	Wed, 31 Jan 2024 18:32:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YMpEIEOSumXQJwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 18:32:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DABD9A0809; Wed, 31 Jan 2024 19:32:34 +0100 (CET)
Date: Wed, 31 Jan 2024 19:32:34 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 12/34] zram: port block device access to file
Message-ID: <20240131183234.gmtfqjlx5zu433ga@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-12-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-12-adbd023e19cc@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jpAGjXxn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PtUsiUZv
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
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 931361FB8E
X-Spam-Flag: NO

On Tue 23-01-24 14:26:29, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/zram/zram_drv.c | 26 +++++++++++++-------------
>  drivers/block/zram/zram_drv.h |  2 +-
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 6772e0c654fa..d96b3851b5d3 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -426,11 +426,11 @@ static void reset_bdev(struct zram *zram)
>  	if (!zram->backing_dev)
>  		return;
>  
> -	bdev_release(zram->bdev_handle);
> +	fput(zram->bdev_file);
>  	/* hope filp_close flush all of IO */
>  	filp_close(zram->backing_dev, NULL);
>  	zram->backing_dev = NULL;
> -	zram->bdev_handle = NULL;
> +	zram->bdev_file = NULL;
>  	zram->disk->fops = &zram_devops;
>  	kvfree(zram->bitmap);
>  	zram->bitmap = NULL;
> @@ -476,7 +476,7 @@ static ssize_t backing_dev_store(struct device *dev,
>  	struct address_space *mapping;
>  	unsigned int bitmap_sz;
>  	unsigned long nr_pages, *bitmap = NULL;
> -	struct bdev_handle *bdev_handle = NULL;
> +	struct file *bdev_file = NULL;
>  	int err;
>  	struct zram *zram = dev_to_zram(dev);
>  
> @@ -513,11 +513,11 @@ static ssize_t backing_dev_store(struct device *dev,
>  		goto out;
>  	}
>  
> -	bdev_handle = bdev_open_by_dev(inode->i_rdev,
> +	bdev_file = bdev_file_open_by_dev(inode->i_rdev,
>  				BLK_OPEN_READ | BLK_OPEN_WRITE, zram, NULL);
> -	if (IS_ERR(bdev_handle)) {
> -		err = PTR_ERR(bdev_handle);
> -		bdev_handle = NULL;
> +	if (IS_ERR(bdev_file)) {
> +		err = PTR_ERR(bdev_file);
> +		bdev_file = NULL;
>  		goto out;
>  	}
>  
> @@ -531,7 +531,7 @@ static ssize_t backing_dev_store(struct device *dev,
>  
>  	reset_bdev(zram);
>  
> -	zram->bdev_handle = bdev_handle;
> +	zram->bdev_file = bdev_file;
>  	zram->backing_dev = backing_dev;
>  	zram->bitmap = bitmap;
>  	zram->nr_pages = nr_pages;
> @@ -544,8 +544,8 @@ static ssize_t backing_dev_store(struct device *dev,
>  out:
>  	kvfree(bitmap);
>  
> -	if (bdev_handle)
> -		bdev_release(bdev_handle);
> +	if (bdev_file)
> +		fput(bdev_file);
>  
>  	if (backing_dev)
>  		filp_close(backing_dev, NULL);
> @@ -587,7 +587,7 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
>  {
>  	struct bio *bio;
>  
> -	bio = bio_alloc(zram->bdev_handle->bdev, 1, parent->bi_opf, GFP_NOIO);
> +	bio = bio_alloc(file_bdev(zram->bdev_file), 1, parent->bi_opf, GFP_NOIO);
>  	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
>  	__bio_add_page(bio, page, PAGE_SIZE, 0);
>  	bio_chain(bio, parent);
> @@ -703,7 +703,7 @@ static ssize_t writeback_store(struct device *dev,
>  			continue;
>  		}
>  
> -		bio_init(&bio, zram->bdev_handle->bdev, &bio_vec, 1,
> +		bio_init(&bio, file_bdev(zram->bdev_file), &bio_vec, 1,
>  			 REQ_OP_WRITE | REQ_SYNC);
>  		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
>  		__bio_add_page(&bio, page, PAGE_SIZE, 0);
> @@ -785,7 +785,7 @@ static void zram_sync_read(struct work_struct *work)
>  	struct bio_vec bv;
>  	struct bio bio;
>  
> -	bio_init(&bio, zw->zram->bdev_handle->bdev, &bv, 1, REQ_OP_READ);
> +	bio_init(&bio, file_bdev(zw->zram->bdev_file), &bv, 1, REQ_OP_READ);
>  	bio.bi_iter.bi_sector = zw->entry * (PAGE_SIZE >> 9);
>  	__bio_add_page(&bio, zw->page, PAGE_SIZE, 0);
>  	zw->error = submit_bio_wait(&bio);
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index 3b94d12f41b4..37bf29f34d26 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -132,7 +132,7 @@ struct zram {
>  	spinlock_t wb_limit_lock;
>  	bool wb_limit_enable;
>  	u64 bd_wb_limit;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	unsigned long *bitmap;
>  	unsigned long nr_pages;
>  #endif
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

