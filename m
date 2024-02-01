Return-Path: <linux-fsdevel+bounces-9851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0114E84553D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAE8286333
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61315B966;
	Thu,  1 Feb 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MARg/ntr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gL+fWBf2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MARg/ntr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gL+fWBf2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0915B961;
	Thu,  1 Feb 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783069; cv=none; b=hob+PXMyUARlNktVZgEybIE4vqyhYJGq8jWewaWsq9sPlazz00IYX5SDh8WlwHfZJaOB7S9won7U+yZgxzXZpAInrNshbDk8G2ulgrUPlpZgUij0h0ohvQhPd+Y14dkfm4DfN8Bi+29Ky8suBBODvS5KCvUcESdPtZe0U4Tvhgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783069; c=relaxed/simple;
	bh=nu0OD/vhlaxbyL3zXta/kJJ7kKFvD562sBm6UIPnrig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9gCJCRPwBX20U4bkBqf9qzet8QycxRlgXQQNPhj5TrCnWW2L7njpfDCpztwXDNYBc6u/FDue+mw/zOzLpeQvriZqUBvqz5Sf2jHyeP1v35lffBDfCUI2WuyR8SwRQkQDQQOXgBtcfz8CHLgMiDZv+TZRz5GB8+R13eKOrJm898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MARg/ntr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gL+fWBf2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MARg/ntr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gL+fWBf2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8FF41FBB2;
	Thu,  1 Feb 2024 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706783065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaqD+lgu1dW3FIVXrQGwgQJ09vb4JWbWH4155yRoX8A=;
	b=MARg/ntrDD9oSUu6bIQnWsCm8reTVOrAGkHhxOaJhL/rd4UNH/+lLVDNROYMarZ3PqtO3J
	6DBFRtvrE3fl5bLY8QeQAk4QKBfPnonrkzHp8heFdj65A6EMsn/X7Wfv92KfZQpAsFXwQw
	Bo/HvxAxo2zq7poTA5cJfmX0kn9K0/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706783065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaqD+lgu1dW3FIVXrQGwgQJ09vb4JWbWH4155yRoX8A=;
	b=gL+fWBf2nwMJTuPNzQtHcDo4qg+10idCxB/ESxrmAvG8n47nVlzRb2dc05LXDn+ITohfZ5
	CF7iZ6B7uDUpl0Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706783065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaqD+lgu1dW3FIVXrQGwgQJ09vb4JWbWH4155yRoX8A=;
	b=MARg/ntrDD9oSUu6bIQnWsCm8reTVOrAGkHhxOaJhL/rd4UNH/+lLVDNROYMarZ3PqtO3J
	6DBFRtvrE3fl5bLY8QeQAk4QKBfPnonrkzHp8heFdj65A6EMsn/X7Wfv92KfZQpAsFXwQw
	Bo/HvxAxo2zq7poTA5cJfmX0kn9K0/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706783065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaqD+lgu1dW3FIVXrQGwgQJ09vb4JWbWH4155yRoX8A=;
	b=gL+fWBf2nwMJTuPNzQtHcDo4qg+10idCxB/ESxrmAvG8n47nVlzRb2dc05LXDn+ITohfZ5
	CF7iZ6B7uDUpl0Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EBD61329F;
	Thu,  1 Feb 2024 10:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6sG9Jllxu2WWXwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:24:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 65B36A0809; Thu,  1 Feb 2024 11:24:25 +0100 (CET)
Date: Thu, 1 Feb 2024 11:24:25 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 27/34] bdev: remove bdev_open_by_path()
Message-ID: <20240201102425.q3kcgq5lbzyvwlmb@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-27-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-27-adbd023e19cc@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="MARg/ntr";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gL+fWBf2
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
X-Rspamd-Queue-Id: A8FF41FBB2
X-Spam-Flag: NO

On Tue 23-01-24 14:26:44, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c           | 40 ----------------------------------------
>  include/linux/blkdev.h |  2 --
>  2 files changed, 42 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 4246a57a7c5a..eb5607af6ec5 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1007,46 +1007,6 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
>  }
>  EXPORT_SYMBOL(bdev_file_open_by_path);
>  
> -/**
> - * bdev_open_by_path - open a block device by name
> - * @path: path to the block device to open
> - * @mode: open mode (BLK_OPEN_*)
> - * @holder: exclusive holder identifier
> - * @hops: holder operations
> - *
> - * Open the block device described by the device file at @path.  If @holder is
> - * not %NULL, the block device is opened with exclusive access.  Exclusive opens
> - * may nest for the same @holder.
> - *
> - * CONTEXT:
> - * Might sleep.
> - *
> - * RETURNS:
> - * Handle with a reference to the block_device on success, ERR_PTR(-errno) on
> - * failure.
> - */
> -struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
> -		void *holder, const struct blk_holder_ops *hops)
> -{
> -	struct bdev_handle *handle;
> -	dev_t dev;
> -	int error;
> -
> -	error = lookup_bdev(path, &dev);
> -	if (error)
> -		return ERR_PTR(error);
> -
> -	handle = bdev_open_by_dev(dev, mode, holder, hops);
> -	if (!IS_ERR(handle) && (mode & BLK_OPEN_WRITE) &&
> -	    bdev_read_only(handle->bdev)) {
> -		bdev_release(handle);
> -		return ERR_PTR(-EACCES);
> -	}
> -
> -	return handle;
> -}
> -EXPORT_SYMBOL(bdev_open_by_path);
> -
>  void bdev_release(struct bdev_handle *handle)
>  {
>  	struct block_device *bdev = handle->bdev;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 76706aa47316..5880d5abfebe 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1484,8 +1484,6 @@ struct bdev_handle {
>  
>  struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  		const struct blk_holder_ops *hops);
> -struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
> -		void *holder, const struct blk_holder_ops *hops);
>  struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  		const struct blk_holder_ops *hops);
>  struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

