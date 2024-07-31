Return-Path: <linux-fsdevel+bounces-24680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B0B942D7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 13:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6891F229F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 11:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA841AD9D4;
	Wed, 31 Jul 2024 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uNehLLZ2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BqdbbUZ6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uNehLLZ2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BqdbbUZ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0521A8BE6
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426699; cv=none; b=Wxnzv7F4CUID7Qv8nZrgQynzEhxyHy4i3jZnVuYxfEiCXcAHsX4P7qHv8e4fN24hDaYrei0wcTxNW/cJChjF5E2QwlQFQeU0VZg5b+IVu2EaPm9TcsLVC4UrYPqcVNRsasaGnT452X+rPV7WumRqhNMJXwwKR4f+ZeUpKepGMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426699; c=relaxed/simple;
	bh=pAVnTS1zINHorFuIsFbEg7GIYh7KDhGvqKvkZmW7M1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LifDOeHUxfqEBynSwrtJ6g5NsiHJFCJLoVKSv7BZOs2A0Cg9e9hl1gkh5VodxWR0Jltuxn7yhhm+qMlZ/Z+L0O5plfLbi0uVV56FbwYFjJjkTyZ5Smu9pxE7s2QG08t74iEwOGXSla2Z2TCXp0b11xzRASDIdXEdrGjWP50ALV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uNehLLZ2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BqdbbUZ6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uNehLLZ2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BqdbbUZ6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C04521BD9;
	Wed, 31 Jul 2024 11:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722426695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sq9YIN5DlT9IR3A/G0n5OxqApgOU08B3b72mMHt4Hk8=;
	b=uNehLLZ2yvwWe+a4kFtXOzpuywYbALziTswUG1/ys1LzgD4pG5owhT25DckHgqGaStKSVV
	Djm4KI7PGVfQyo5pU+53XdMnB4fC09dJCoBP0fNm4XA2J/s83PQooofnlJ/aZxBaTpgTUv
	lvy+d3F3G7A6+OrgR8LZVlCOK/yDlH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722426695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sq9YIN5DlT9IR3A/G0n5OxqApgOU08B3b72mMHt4Hk8=;
	b=BqdbbUZ6LQ+g5rg0aZzVZmLxXl9/7x4IjGe9tvj7exfn2AmuKiSGORuXK0INTI2QV+OUNn
	+d6Er+F/Zt4w8SBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uNehLLZ2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BqdbbUZ6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722426695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sq9YIN5DlT9IR3A/G0n5OxqApgOU08B3b72mMHt4Hk8=;
	b=uNehLLZ2yvwWe+a4kFtXOzpuywYbALziTswUG1/ys1LzgD4pG5owhT25DckHgqGaStKSVV
	Djm4KI7PGVfQyo5pU+53XdMnB4fC09dJCoBP0fNm4XA2J/s83PQooofnlJ/aZxBaTpgTUv
	lvy+d3F3G7A6+OrgR8LZVlCOK/yDlH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722426695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sq9YIN5DlT9IR3A/G0n5OxqApgOU08B3b72mMHt4Hk8=;
	b=BqdbbUZ6LQ+g5rg0aZzVZmLxXl9/7x4IjGe9tvj7exfn2AmuKiSGORuXK0INTI2QV+OUNn
	+d6Er+F/Zt4w8SBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C3411368F;
	Wed, 31 Jul 2024 11:51:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7kXFCkclqmYxRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 31 Jul 2024 11:51:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7BDCFA099C; Wed, 31 Jul 2024 13:51:34 +0200 (CEST)
Date: Wed, 31 Jul 2024 13:51:34 +0200
From: Jan Kara <jack@suse.cz>
To: yangerkun <yangerkun@huawei.com>
Cc: hch@infradead.org, chuck.lever@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, hughd@google.com,
	zlang@kernel.org, fdmanana@suse.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, yangerkun@huaweicloud.com
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
Message-ID: <20240731115134.tkiklyu72lwnhbxg@quack3>
References: <20240731043835.1828697-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731043835.1828697-1-yangerkun@huawei.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.81 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 4C04521BD9
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.81

On Wed 31-07-24 12:38:35, yangerkun wrote:
> After we switch tmpfs dir operations from simple_dir_operations to
> simple_offset_dir_operations, every rename happened will fill new dentry
> to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
> key starting with octx->newx_offset, and then set newx_offset equals to
> free key + 1. This will lead to infinite readdir combine with rename
> happened at the same time, which fail generic/736 in xfstests(detail show
> as below).
> 
> 1. create 5000 files(1 2 3...) under one dir
> 2. call readdir(man 3 readdir) once, and get one entry
> 3. rename(entry, "TEMPFILE"), then rename("TEMPFILE", entry)
> 4. loop 2~3, until readdir return nothing or we loop too many
>    times(tmpfs break test with the second condition)
> 
> We choose the same logic what commit 9b378f6ad48cf ("btrfs: fix infinite
> directory reads") to fix it, record the last_index when we open dir, and
> do not emit the entry which index >= last_index. The file->private_data
> now used in offset dir can use directly to do this, and we also update
> the last_index when we llseek the dir file.

The patch looks good! Just I'm not sure about the llseek part. As far as I
understand it was added due to this sentence in the standard:

"If a file is removed from or added to the directory after the most recent
call to opendir() or rewinddir(), whether a subsequent call to readdir()
returns an entry for that file is unspecified."

So if the offset used in offset_dir_llseek() is 0, then we should update
last_index. But otherwise I'd leave it alone because IMHO it would do more
harm than good.

								Honza

> 
> Fixes: a2e459555c5f ("shmem: stable directory offsets")
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  fs/libfs.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 8aa34870449f..38b306738c00 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -450,6 +450,14 @@ void simple_offset_destroy(struct offset_ctx *octx)
>  	mtree_destroy(&octx->mt);
>  }
>  
> +static int offset_dir_open(struct inode *inode, struct file *file)
> +{
> +	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> +
> +	file->private_data = (void *)ctx->next_offset;
> +	return 0;
> +}
> +
>  /**
>   * offset_dir_llseek - Advance the read position of a directory descriptor
>   * @file: an open directory whose position is to be updated
> @@ -463,6 +471,9 @@ void simple_offset_destroy(struct offset_ctx *octx)
>   */
>  static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>  {
> +	struct inode *inode = file->f_inode;
> +	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> +
>  	switch (whence) {
>  	case SEEK_CUR:
>  		offset += file->f_pos;
> @@ -476,7 +487,7 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>  	}
>  
>  	/* In this case, ->private_data is protected by f_pos_lock */
> -	file->private_data = NULL;
> +	file->private_data = (void *)ctx->next_offset;
>  	return vfs_setpos(file, offset, LONG_MAX);
>  }
>  
> @@ -507,7 +518,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>  			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>  }
>  
> -static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> +static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
>  {
>  	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>  	struct dentry *dentry;
> @@ -515,17 +526,21 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  	while (true) {
>  		dentry = offset_find_next(octx, ctx->pos);
>  		if (!dentry)
> -			return ERR_PTR(-ENOENT);
> +			return;
> +
> +		if (dentry2offset(dentry) >= last_index) {
> +			dput(dentry);
> +			return;
> +		}
>  
>  		if (!offset_dir_emit(ctx, dentry)) {
>  			dput(dentry);
> -			break;
> +			return;
>  		}
>  
>  		ctx->pos = dentry2offset(dentry) + 1;
>  		dput(dentry);
>  	}
> -	return NULL;
>  }
>  
>  /**
> @@ -552,22 +567,19 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  static int offset_readdir(struct file *file, struct dir_context *ctx)
>  {
>  	struct dentry *dir = file->f_path.dentry;
> +	long last_index = (long)file->private_data;
>  
>  	lockdep_assert_held(&d_inode(dir)->i_rwsem);
>  
>  	if (!dir_emit_dots(file, ctx))
>  		return 0;
>  
> -	/* In this case, ->private_data is protected by f_pos_lock */
> -	if (ctx->pos == DIR_OFFSET_MIN)
> -		file->private_data = NULL;
> -	else if (file->private_data == ERR_PTR(-ENOENT))
> -		return 0;
> -	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
> +	offset_iterate_dir(d_inode(dir), ctx, last_index);
>  	return 0;
>  }
>  
>  const struct file_operations simple_offset_dir_operations = {
> +	.open		= offset_dir_open,
>  	.llseek		= offset_dir_llseek,
>  	.iterate_shared	= offset_readdir,
>  	.read		= generic_read_dir,
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

