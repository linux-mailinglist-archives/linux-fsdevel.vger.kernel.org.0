Return-Path: <linux-fsdevel+bounces-10468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA684B727
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54EE1C25817
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020B113175B;
	Tue,  6 Feb 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ThwW/SsX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4HSSJvHX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ThwW/SsX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4HSSJvHX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6D8131E3B;
	Tue,  6 Feb 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227929; cv=none; b=YZQJL6TYfh68oY4Zch3unuEmYgBk3rv+EanH4Nfvh36I62FfrJgLU9fgDQXueRvjnukGi+FuAPzUovYUmugqDa3Gypp91/vjJeSCojkO/efprYRm7kjDW4yqmggzMT905+wR5l96B5s9hUKl4Y1qg9hcKyBDYGCnDLLFwbcByMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227929; c=relaxed/simple;
	bh=kGM9y84uI9exnot+zoOwpz2LIJDQ90aCnYUn8efRKTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxLtCQKMDXLDueeWvb6YECH+Sqh+5mrMh9Pllrm1V8A32XAcaL8cWtzLW83PztQ64tXgBVdukPFWrrf1h1uKBeAshawXOULPMaqTsRUoXfJQADPLZ25mri5YsNb0YjNKkIUYbYYMi+znAM0Un4gmjF9AarqkG+6Dt+LnlYKadFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ThwW/SsX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4HSSJvHX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ThwW/SsX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4HSSJvHX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C60E01F8B2;
	Tue,  6 Feb 2024 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707227925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9xKUcT2u73lphgLRoX8nwN7nUAHZESi86HgUK+Ci6s=;
	b=ThwW/SsX9nO37AmJ39hkyiEGv+lPwaDQc300SXyjHjhNA4ZRbDyD4wlHsFTKlysc0zrHpF
	f2u1eTVUcgamaX95qlHGZWOxAMVLZTqzveBF2icw1tZp0jHRXtV8KkGapD4yO/XFDALQrP
	B5QSyj0uwTGoAvOvV7J6cUa9CT3JWak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707227925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9xKUcT2u73lphgLRoX8nwN7nUAHZESi86HgUK+Ci6s=;
	b=4HSSJvHX2Ph9pqEHXRwGs3O7g/J2RNlBPHAfjK1lJ+qjVKexC5yCm26YT3uA0yM0aNXQXY
	tJGYg8AzYo58JXAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707227925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9xKUcT2u73lphgLRoX8nwN7nUAHZESi86HgUK+Ci6s=;
	b=ThwW/SsX9nO37AmJ39hkyiEGv+lPwaDQc300SXyjHjhNA4ZRbDyD4wlHsFTKlysc0zrHpF
	f2u1eTVUcgamaX95qlHGZWOxAMVLZTqzveBF2icw1tZp0jHRXtV8KkGapD4yO/XFDALQrP
	B5QSyj0uwTGoAvOvV7J6cUa9CT3JWak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707227925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9xKUcT2u73lphgLRoX8nwN7nUAHZESi86HgUK+Ci6s=;
	b=4HSSJvHX2Ph9pqEHXRwGs3O7g/J2RNlBPHAfjK1lJ+qjVKexC5yCm26YT3uA0yM0aNXQXY
	tJGYg8AzYo58JXAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB6C8132DD;
	Tue,  6 Feb 2024 13:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id by29LRU7wmWzRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Feb 2024 13:58:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55F02A0809; Tue,  6 Feb 2024 14:58:41 +0100 (CET)
Date: Tue, 6 Feb 2024 14:58:41 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/34] Open block devices as files
Message-ID: <20240206135841.jxusuos7pq52efik@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240205-biotechnologie-korallen-d2b3a7138ec0@brauner>
 <20240205141911.vbuqvjdbjw5pq2wc@quack3>
 <20240206-zersplittern-unqualifiziert-c449ed7a4b5f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206-zersplittern-unqualifiziert-c449ed7a4b5f@brauner>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Tue 06-02-24 14:39:13, Christian Brauner wrote:
> On Mon, Feb 05, 2024 at 03:19:11PM +0100, Jan Kara wrote:
> > Hi!
> > 
> > On Mon 05-02-24 12:55:18, Christian Brauner wrote:
> > > On Tue, Jan 23, 2024 at 02:26:17PM +0100, Christian Brauner wrote:
> > > > Hey Christoph,
> > > > Hey Jan,
> > > > Hey Jens,
> > > > 
> > > > This opens block devices as files. Instead of introducing a separate
> > > > indirection into bdev_open_by_*() vis struct bdev_handle we can just
> > > > make bdev_file_open_by_*() return a struct file. Opening and closing a
> > > > block device from setup_bdev_super() and in all other places just
> > > > becomes equivalent to opening and closing a file.
> > > > 
> > > > This has held up in xfstests and in blktests so far and it seems stable
> > > > and clean. The equivalence of opening and closing block devices to
> > > > regular files is a win in and of itself imho. Added to that is the
> > > > ability to do away with struct bdev_handle completely and make various
> > > > low-level helpers private to the block layer.
> > > > 
> > > > All places were we currently stash a struct bdev_handle we just stash a
> > > > file and use an accessor such as file_bdev() akin to I_BDEV() to get to
> > > > the block device.
> > > > 
> > > > It's now also possible to use file->f_mapping as a replacement for
> > > > bdev->bd_inode->i_mapping and file->f_inode or file->f_mapping->host as
> > > > an alternative to bdev->bd_inode allowing us to significantly reduce or
> > > > even fully remove bdev->bd_inode in follow-up patches.
> > > > 
> > > > In addition, we could get rid of sb->s_bdev and various other places
> > > > that stash the block device directly and instead stash the block device
> > > > file. Again, this is follow-up work.
> > > > 
> > > > Thanks!
> > > > Christian
> > > > 
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > ---
> > > 
> > > With all fixes applied I've moved this into vfs.super on vfs/vfs.git so
> > > this gets some exposure in -next asap. Please let me know if you have
> > > quarrels with that.
> > 
> > No quarrels really. I went through the patches and all of them look fine to
> > me to feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > I have just noticed that in "bdev: make struct bdev_handle private to the
> > block layer" in bdev_open() we are still leaking the handle in case of
> > error. This is however temporary (until the end of the series when we get
> > rid of handles altogether) so whatever.
> 
> Can you double-check what's in vfs.super right now? I thought I fixed
> this up. I'll check too!

Well, you've fixed the "double allocation" issue but there's still a
problem that you do:

int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
	      const struct blk_holder_ops *hops, struct file *bdev_file)
{
...
	handle = kmalloc(sizeof(struct bdev_handle), GFP_KERNEL);
	if (!handle)
		return -ENOMEM;
 	if (holder) {
 		mode |= BLK_OPEN_EXCL;
 		ret = bd_prepare_to_claim(bdev, holder, hops);
 		if (ret)
			return ret;
 	} else {
...


So in case bd_prepare_to_claim() fails we forget to free the allocated
handle.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

