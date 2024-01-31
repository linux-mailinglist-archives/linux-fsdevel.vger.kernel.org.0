Return-Path: <linux-fsdevel+bounces-9688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66518446E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3559E1F21D6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE75E1386BB;
	Wed, 31 Jan 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pl2d4wlO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XymzjEQu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pl2d4wlO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XymzjEQu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E47F498;
	Wed, 31 Jan 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724631; cv=none; b=NASq86s9BgAAlUfT49rPPYis8sFEvqrzJ07DVni5hhXwfWaEDXMiPvO1Dakefch2EfIx0sd1iUxczJURRbxoSYpm0oR82Y/yaB46niNAeSm1+PDdgM/pEoxLLDGAHBEc6255qZcu23dI9tJPSjoCUEDVnoR4a3hGAa9LrpUZzCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724631; c=relaxed/simple;
	bh=G5cxr68YnZ7/nFQzGn3N0w1hvrhGnsrR8oG/7jL4vbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAiKugJZe2P4cn4LjXkVQwcAJyL2c2Iqcwbs+rFv9d1nW0q7WlpxHENDEBoKRoXcKgdNcviuO4MzXDkr21P3AHBMYFaSA95wN8I/P4j59YYj3HyFMkccWNv7XU5d0WHyHeDLT3D0ycloqiMwJvCIWlMzGw8tEZcQDiUFbdddxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pl2d4wlO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XymzjEQu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pl2d4wlO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XymzjEQu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF48B1FB8E;
	Wed, 31 Jan 2024 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706724621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hxQM/rPqTFHw0In5LnmDFhvYuIj4ncoVrSoCLhqzK74=;
	b=Pl2d4wlOszEkqJVzvUTsZdAHxTXmVJ86XgLD2lUzDIB2tgr6S5o9Zwp+NbB4Hy0ayYETCo
	Wpq0YCsyrxUl0KVscOJoDyHyGtM78r60YlUybOTvYC4JVPHVAiZpTWvMqfctS4n9RNDESP
	L8V3F0Yla7EIWsdLNK1pdCRcXkKAbQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706724621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hxQM/rPqTFHw0In5LnmDFhvYuIj4ncoVrSoCLhqzK74=;
	b=XymzjEQu/KUk5VhLac6gy9W5MqOWdWibU8PuAJsrqajtA4td/qEhb3Q4hOHkVdpQBOCDca
	syM5hmXAh7WChCBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706724621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hxQM/rPqTFHw0In5LnmDFhvYuIj4ncoVrSoCLhqzK74=;
	b=Pl2d4wlOszEkqJVzvUTsZdAHxTXmVJ86XgLD2lUzDIB2tgr6S5o9Zwp+NbB4Hy0ayYETCo
	Wpq0YCsyrxUl0KVscOJoDyHyGtM78r60YlUybOTvYC4JVPHVAiZpTWvMqfctS4n9RNDESP
	L8V3F0Yla7EIWsdLNK1pdCRcXkKAbQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706724621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hxQM/rPqTFHw0In5LnmDFhvYuIj4ncoVrSoCLhqzK74=;
	b=XymzjEQu/KUk5VhLac6gy9W5MqOWdWibU8PuAJsrqajtA4td/qEhb3Q4hOHkVdpQBOCDca
	syM5hmXAh7WChCBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A4593139D9;
	Wed, 31 Jan 2024 18:10:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id bncaKA2NumXoIgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 18:10:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 36C5DA0809; Wed, 31 Jan 2024 19:10:21 +0100 (CET)
Date: Wed, 31 Jan 2024 19:10:21 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 02/34] block/ioctl: port blkdev_bszset() to file
Message-ID: <20240131181021.4k4gbnqrtsl7y5ix@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-2-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-2-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out2.suse.de;
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

On Tue 23-01-24 14:26:19, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/ioctl.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 9c73a763ef88..5d0619e02e4c 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -471,7 +471,7 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
>  		int __user *argp)
>  {
>  	int ret, n;
> -	struct bdev_handle *handle;
> +	struct file *file;
>  
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EACCES;
> @@ -483,12 +483,11 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
>  	if (mode & BLK_OPEN_EXCL)
>  		return set_blocksize(bdev, n);
>  
> -	handle = bdev_open_by_dev(bdev->bd_dev, mode, &bdev, NULL);
> -	if (IS_ERR(handle))
> +	file = bdev_file_open_by_dev(bdev->bd_dev, mode, &bdev, NULL);
> +	if (IS_ERR(file))
>  		return -EBUSY;
>  	ret = set_blocksize(bdev, n);
> -	bdev_release(handle);
> -
> +	fput(file);
>  	return ret;
>  }
>  
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

