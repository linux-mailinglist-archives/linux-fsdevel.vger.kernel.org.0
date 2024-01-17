Return-Path: <linux-fsdevel+bounces-8173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6505E8309CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C43A7B24075
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EE021A0E;
	Wed, 17 Jan 2024 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P9Q5o9KD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/2RnBWo2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="006FGMTd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UDa9WqX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE6121379;
	Wed, 17 Jan 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705505475; cv=none; b=olTMw2P6HXvQJ75T4OYUCJBqF+zw115bitRAh7Ku1nFOj7xiy+S7eQz/cVfP0sH/aP91Grg/G/tZH/bOx6N3tdl7T8USLAoj9fjleOQdyVhLbRA2EvPzoheJSZFOzJsbYteg3GZYYOMTLt93G5j2w2GyiNUsJAipzsJou20ptKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705505475; c=relaxed/simple;
	bh=OXSO58Em6aPRvnnfL6+TbuZRvQi6FV816/vdCp81hsQ=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spamd-Result:X-Spam-Level:
	 X-Spam-Flag:X-Spam-Score; b=eX6xZJIAAZ2z+LAL98c0QkOyxQEwK9UT0lnOT7sSg0YOSek8DHc4QpokBvou8Iu6ei7f0ngpk6vdf/He31DkB2VY5ilrP98To6Dz4aPqFuhocVX90rnbp0vnGO3sJVNp0lne9G0/oiyEyPinUrKwQCBezpJicNfl5dIQy+GX1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P9Q5o9KD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/2RnBWo2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=006FGMTd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UDa9WqX0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D700121F9E;
	Wed, 17 Jan 2024 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705505472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjWEfIRg/2Y5Ke+/aE+DDZSg6iEW2Ha0Otmf4qb5sTs=;
	b=P9Q5o9KDruR9afhl6mZpMnSES7bMzuTqO6JhzyNGOo5tDV31yODb/A7mm4Xb5ZttMG2MlW
	oOZ6r+78ZecVkZsy5EzmaDCvRdAevsJs0V+idOb9nvrgBqh75SfOKjbrc7rpEPvkF3+A8G
	yPda2LTLkWh8bySDbxaGMsJcvhJWOBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705505472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjWEfIRg/2Y5Ke+/aE+DDZSg6iEW2Ha0Otmf4qb5sTs=;
	b=/2RnBWo2oK+zG2l+AqMPj/5G+Ht1jUuWVLjm0r6YMaAzsTbZlUK4p4MCiRYHu4erpfw6d1
	exwmxgv5USiMOoAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705505471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjWEfIRg/2Y5Ke+/aE+DDZSg6iEW2Ha0Otmf4qb5sTs=;
	b=006FGMTdR8BRnzNK4EWwaQqV31nSTNrFX0pBmBtT9cJWCbPuaFY7Uu5xMpoZAJhNTo+F9O
	dgzOb6CECCJGcAOije9nUi96/yZi1866DjDPAc3l6JQLgYoEbM6nrZckREzwx646KhV0D/
	APXRkujwcFZEm7kqfWDjxkp9WJp4hzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705505471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjWEfIRg/2Y5Ke+/aE+DDZSg6iEW2Ha0Otmf4qb5sTs=;
	b=UDa9WqX0LiXfFJnqulWvYDwQAGrZikJRnPpxATrrCZTv7sauayDO2XbPxbOiQYrQvd4GmJ
	vcVChYwP+9p8WSCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C36E213800;
	Wed, 17 Jan 2024 15:31:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bSewL7/yp2XHGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 15:31:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6F453A0803; Wed, 17 Jan 2024 16:31:07 +0100 (CET)
Date: Wed, 17 Jan 2024 16:31:07 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 01/34] bdev: open block device as files
Message-ID: <20240117153107.pilkkl56ngpp3xlj@quack3>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240103-vfs-bdev-file-v1-1-6c8ee55fb6ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103-vfs-bdev-file-v1-1-6c8ee55fb6ef@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(0.00)[15.47%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.40

On Wed 03-01-24 13:54:59, Christian Brauner wrote:
> +struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
> +				   const struct blk_holder_ops *hops)
> +{
> +	struct file *file;
> +	struct bdev_handle *handle;
> +	unsigned int flags;
> +
> +	handle = bdev_open_by_dev(dev, mode, holder, hops);
> +	if (IS_ERR(handle))
> +		return ERR_CAST(handle);
> +
> +	flags = blk_to_file_flags(mode);
> +	file = alloc_file_pseudo(handle->bdev->bd_inode, blockdev_mnt, "",
> +				 flags | O_LARGEFILE, &def_blk_fops);
> +	if (IS_ERR(file)) {
> +		bdev_release(handle);
> +		return file;
> +	}
> +	ihold(handle->bdev->bd_inode);
> +
> +	file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT | FMODE_NOACCOUNT;
> +	if (bdev_nowait(handle->bdev))
> +		file->f_mode |= FMODE_NOWAIT;
> +
> +	file->f_mapping = handle->bdev->bd_inode->i_mapping;
> +	file->f_wb_err = filemap_sample_wb_err(file->f_mapping);
> +	file->private_data = handle;
> +	return file;

Maybe I'm dense but when the file is closed where do we drop the
bdev_handle?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

