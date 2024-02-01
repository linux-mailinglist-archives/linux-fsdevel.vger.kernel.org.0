Return-Path: <linux-fsdevel+bounces-9865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E5C84561C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 12:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D763A28B89B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDE515CD54;
	Thu,  1 Feb 2024 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uG2n/Vnx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fK2vj5Ms";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uG2n/Vnx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fK2vj5Ms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB4F51A;
	Thu,  1 Feb 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706786412; cv=none; b=SNY5gJZpUvPC7050pPl2e4gwMleqMTkdmxdePwbKF8kwRcN+2BhU/5ygRftNjASC9HvSY0GDgkrNN5acnpND6Pe+EuDo8e2kD9eIaq7wjcq+udI+oiUEta23oAir/l2bINZ3raZ8JdVdOqnvKP4bFm3jGzhgGg9JqYKnjnYEXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706786412; c=relaxed/simple;
	bh=GQw8xFZd/6DRPyfIbKg4pMnsnWpGP2B+qjCIpT783SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIEeNxYkGBrFBEtIcbyc6erUZu5Iy09FK+zfAv7+nJNtkAqBx101DkGBvSpchsA4ZbVx6vmCf1VRp53wXa8DO/Mn1iY25KgQ3Vi44ruXSc2ORzV8PSy4TCks+WawGpkvSSLPJiA3awXcIEucevzp2j78mzaBd98NQg4hsmMPMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uG2n/Vnx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fK2vj5Ms; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uG2n/Vnx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fK2vj5Ms; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D6911FBB6;
	Thu,  1 Feb 2024 11:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706786408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tKq0GkMHjxtzTevmgphwTgtH9VJy5bl6PRcddTkroY4=;
	b=uG2n/Vnx4QHheS0zWj3td4C82GwISGLaYqlmaloaUWIDd2t5DIrA8Kx1BShOexi2qrvTYP
	Toytb8hV3A7dIM/ce0YLQF2B5FPAMS2SZ+vXjBMA9BA8CesQpLqfmwnDYjP6Nfw5rAqyqK
	vos2eac1IVQwDC6B0Mg2d/S0n06dpq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706786408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tKq0GkMHjxtzTevmgphwTgtH9VJy5bl6PRcddTkroY4=;
	b=fK2vj5MswxZAjaqCaJ1lyoA7igC9zUvwFMBiQz3W8UATriHG118HWIS5r3oWePRUfv5x+P
	pX92L5ZNRlIy+/Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706786408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tKq0GkMHjxtzTevmgphwTgtH9VJy5bl6PRcddTkroY4=;
	b=uG2n/Vnx4QHheS0zWj3td4C82GwISGLaYqlmaloaUWIDd2t5DIrA8Kx1BShOexi2qrvTYP
	Toytb8hV3A7dIM/ce0YLQF2B5FPAMS2SZ+vXjBMA9BA8CesQpLqfmwnDYjP6Nfw5rAqyqK
	vos2eac1IVQwDC6B0Mg2d/S0n06dpq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706786408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tKq0GkMHjxtzTevmgphwTgtH9VJy5bl6PRcddTkroY4=;
	b=fK2vj5MswxZAjaqCaJ1lyoA7igC9zUvwFMBiQz3W8UATriHG118HWIS5r3oWePRUfv5x+P
	pX92L5ZNRlIy+/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72A77139B1;
	Thu,  1 Feb 2024 11:20:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Dj7G2h+u2WlGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 11:20:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 22150A0809; Thu,  1 Feb 2024 12:20:08 +0100 (CET)
Date: Thu, 1 Feb 2024 12:20:08 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 32/34] block: remove bdev_handle completely
Message-ID: <20240201112008.6kdph4ctuyeck5tq@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-32-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-32-adbd023e19cc@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="uG2n/Vnx";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fK2vj5Ms
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 7D6911FBB6
X-Spam-Flag: NO

On Tue 23-01-24 14:26:49, Christian Brauner wrote:
> We just need to use the holder to indicate whether a block device open
> was exclusive or not. We did use to do that before but had to give that
> up once we switched to struct bdev_handle. Before struct bdev_handle we
> only stashed stuff in file->private_data if this was an exclusive open
> but after struct bdev_handle we always set file->private_data to a
> struct bdev_handle and so we had to use bdev_handle->mode or
> bdev_handle->holder. Now that we don't use struct bdev_handle anymore we
> can revert back to the old behavior.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Two small comments below.

> diff --git a/block/fops.c b/block/fops.c
> index f56bdfe459de..a0bff2c0d88d 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -569,7 +569,6 @@ static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
>  blk_mode_t file_to_blk_mode(struct file *file)
>  {
>  	blk_mode_t mode = 0;
> -	struct bdev_handle *handle = file->private_data;
>  
>  	if (file->f_mode & FMODE_READ)
>  		mode |= BLK_OPEN_READ;
> @@ -579,8 +578,8 @@ blk_mode_t file_to_blk_mode(struct file *file)
>  	 * do_dentry_open() clears O_EXCL from f_flags, use handle->mode to
>  	 * determine whether the open was exclusive for already open files.
>  	 */
^^^ This comment needs update now...

> -	if (handle)
> -		mode |= handle->mode & BLK_OPEN_EXCL;
> +	if (file->private_data)
> +		mode |= BLK_OPEN_EXCL;
>  	else if (file->f_flags & O_EXCL)
>  		mode |= BLK_OPEN_EXCL;
>  	if (file->f_flags & O_NDELAY)
> @@ -601,12 +600,17 @@ static int blkdev_open(struct inode *inode, struct file *filp)
>  {
>  	struct block_device *bdev;
>  	blk_mode_t mode;
> -	void *holder;
>  	int ret;
>  
> +	/*
> +	 * Use the file private data to store the holder for exclusive opens.
> +	 * file_to_blk_mode relies on it being present to set BLK_OPEN_EXCL.
> +	 */
> +	if (filp->f_flags & O_EXCL)
> +		filp->private_data = filp;

Well, if we have O_EXCL in f_flags here, then file_to_blk_mode() on the
next line is going to do the right thing and set BLK_OPEN_EXCL even
without filp->private_data. So this shound't be needed AFAICT.

>  	mode = file_to_blk_mode(filp);
> -	holder = mode & BLK_OPEN_EXCL ? filp : NULL;
> -	ret = bdev_permission(inode->i_rdev, mode, holder);
> +	ret = bdev_permission(inode->i_rdev, mode, filp->private_data);
>  	if (ret)
>  		return ret;

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

