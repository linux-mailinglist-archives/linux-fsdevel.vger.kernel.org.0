Return-Path: <linux-fsdevel+bounces-9689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65228446E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C817F1C22A9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC79F12FF91;
	Wed, 31 Jan 2024 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u/r0X3Fb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vgAE0jBD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u/r0X3Fb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vgAE0jBD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C712C549;
	Wed, 31 Jan 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724793; cv=none; b=c7brjr/mqc99N7knqwa0usluEqYTFkHGdJCjbltZoC2/jZEJO8FW0Gj+ZqCCJM1JuMhKONqckKlzI1JpUQKmFa1svK15jvZk1BSa5+K1KBRmgPb+KHEVkb4FuR2+IISPTVmk4Q+fYvivRoLKVJ+IDtz07pXzQf1FQmjxAFXtpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724793; c=relaxed/simple;
	bh=14JakqBTjFOmsdZuYX8lY9cHsK5qzpoAxVh3QqPLGSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9+0ODmaNlCg/gZKgHVGA5hxaaZN9vrR/zbNDUer9n3pJD+3M8rbCiWTbpVv4yJtGt4+Ntm4QVmy10uJsCfZwxVNb9ThSqq63fQxBBstipeAm2v7he6fQhl4wNEXiMkqeRS39V1rsQgCbnVnreUoL9ZLzDIGG7LED8UKgEntUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u/r0X3Fb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vgAE0jBD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u/r0X3Fb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vgAE0jBD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F7051FB8E;
	Wed, 31 Jan 2024 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706724789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmfTE2/Z6sa29DQZFaaHkiwmCal+qBCitrukamRzqQM=;
	b=u/r0X3FbMZ1OWgPypO62vM+cz1pbplrucbl61g3o7XkidTffancae52AqX5f718Y0H+J6P
	I8+2uIAUlRA1gnUdOptDZgtAG0QbQsJJpwc9JkvbjEGVQLZ1gbWcTnMmnnf/0CjSwEbMy0
	NuDoYem8esQUDLzdw9I4+hIsCKEKl5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706724789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmfTE2/Z6sa29DQZFaaHkiwmCal+qBCitrukamRzqQM=;
	b=vgAE0jBDGHbu+7taDwmnFJ7/ZMjS59np1Ws/yliPFBqZEaGJOGCj36sux+9kywbPDOatuM
	mqmwKybjNBj6bzBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706724789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmfTE2/Z6sa29DQZFaaHkiwmCal+qBCitrukamRzqQM=;
	b=u/r0X3FbMZ1OWgPypO62vM+cz1pbplrucbl61g3o7XkidTffancae52AqX5f718Y0H+J6P
	I8+2uIAUlRA1gnUdOptDZgtAG0QbQsJJpwc9JkvbjEGVQLZ1gbWcTnMmnnf/0CjSwEbMy0
	NuDoYem8esQUDLzdw9I4+hIsCKEKl5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706724789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmfTE2/Z6sa29DQZFaaHkiwmCal+qBCitrukamRzqQM=;
	b=vgAE0jBDGHbu+7taDwmnFJ7/ZMjS59np1Ws/yliPFBqZEaGJOGCj36sux+9kywbPDOatuM
	mqmwKybjNBj6bzBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 74EED139D9;
	Wed, 31 Jan 2024 18:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tDaKHLWNumWbIwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 18:13:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0A4C8A0809; Wed, 31 Jan 2024 19:13:09 +0100 (CET)
Date: Wed, 31 Jan 2024 19:13:09 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 03/34] block/genhd: port disk_scan_partitions() to file
Message-ID: <20240131181309.cntrwyt7ftwgk2w6@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-3-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-3-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="u/r0X3Fb";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vgAE0jBD
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
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F7051FB8E
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 23-01-24 14:26:20, Christian Brauner wrote:
> This may run from a kernel thread via device_add_disk(). So this could
> also use __fput_sync() if we were worried about EBUSY. But when it is
> called from a kernel thread it's always BLK_OPEN_READ so EBUSY can't
> really happen even if we do BLK_OPEN_RESTRICT_WRITES or BLK_OPEN_EXCL.
> 
> Otherwise it's called from an ioctl on the block device which is only
> called from userspace and can rely on task work.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/genhd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index d74fb5b4ae68..a911d2969c07 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(disk_uevent);
>  
>  int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
>  {
> -	struct bdev_handle *handle;
> +	struct file *file;
>  	int ret = 0;
>  
>  	if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
> @@ -366,12 +366,12 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
>  	}
>  
>  	set_bit(GD_NEED_PART_SCAN, &disk->state);
> -	handle = bdev_open_by_dev(disk_devt(disk), mode & ~BLK_OPEN_EXCL, NULL,
> -				  NULL);
> -	if (IS_ERR(handle))
> -		ret = PTR_ERR(handle);
> +	file = bdev_file_open_by_dev(disk_devt(disk), mode & ~BLK_OPEN_EXCL,
> +				     NULL, NULL);
> +	if (IS_ERR(file))
> +		ret = PTR_ERR(file);
>  	else
> -		bdev_release(handle);
> +		fput(file);
>  
>  	/*
>  	 * If blkdev_get_by_dev() failed early, GD_NEED_PART_SCAN is still set,
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

