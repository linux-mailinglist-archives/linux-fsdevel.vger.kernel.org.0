Return-Path: <linux-fsdevel+bounces-28377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B52969F3E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89591C2402F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9C08C06;
	Tue,  3 Sep 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lp43WVbM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="umLk8QJf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lp43WVbM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="umLk8QJf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89069848E
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370796; cv=none; b=f60zjdtFq9VH4t6kmEoEfsXJWE4g7uK3HJe3rjW20aCzkX39GKx8skpGqSw49q0tOaKL+CYeHKrmJVU9wKwZkfO4yXlCKrIAfqNmn8Be8VDsY4HrGiEtYtFFO0EgU0HQ000fAYou3PdoRQURDJ9RNj0GLQ08o30SsVjRXUnHPTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370796; c=relaxed/simple;
	bh=/pgzd6Zvo+zK+xuGAXw5X3+AXNGkr6d3zX4pO40tonA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIEddXMqiEMuhMqwXJZ2tmGBIwc5yEdscgkfXjL9VjGXY1T/p+zhkX15uXDqSb5DrdCz66UZzW0qLEVwcs4xo2aPeOWGXu4Zv9iMvrlUJFKk3WSd2BaKM/Mv2zHUKO5NMHj3stS+qZmbuCWHTUz+QXgWd5dLz9nrJ4llkMDt+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lp43WVbM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=umLk8QJf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lp43WVbM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=umLk8QJf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0A9021BA2;
	Tue,  3 Sep 2024 13:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725370792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YGSD2BcZJxhGdjrI/Uqg8TGwDC0HsxNcgFYaiI+IDs=;
	b=Lp43WVbMsqi8TVPqHZINsrxl9itlkb5lm+khvzWBZ1TH/exCa5+E/awxiaLPZOETuZI0IC
	Hb3PdrIHiHp+NYe0oy4LZ2bG7MV9AOnAwQnKwsWs4Q0OOWMzAOt67eGB00zUPYvxSjE8r6
	955etmhn5v7U5ONapH+1srhWPabXVMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725370792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YGSD2BcZJxhGdjrI/Uqg8TGwDC0HsxNcgFYaiI+IDs=;
	b=umLk8QJf99Wd8/x0WcjJrG7FI5sIrhickTrdWSA/jJWfsGvP4bJtWaLJ/xIL3qmfbMEfG+
	k8s6undTsM3wplAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Lp43WVbM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=umLk8QJf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725370792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YGSD2BcZJxhGdjrI/Uqg8TGwDC0HsxNcgFYaiI+IDs=;
	b=Lp43WVbMsqi8TVPqHZINsrxl9itlkb5lm+khvzWBZ1TH/exCa5+E/awxiaLPZOETuZI0IC
	Hb3PdrIHiHp+NYe0oy4LZ2bG7MV9AOnAwQnKwsWs4Q0OOWMzAOt67eGB00zUPYvxSjE8r6
	955etmhn5v7U5ONapH+1srhWPabXVMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725370792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YGSD2BcZJxhGdjrI/Uqg8TGwDC0HsxNcgFYaiI+IDs=;
	b=umLk8QJf99Wd8/x0WcjJrG7FI5sIrhickTrdWSA/jJWfsGvP4bJtWaLJ/xIL3qmfbMEfG+
	k8s6undTsM3wplAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9528513A52;
	Tue,  3 Sep 2024 13:39:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7PdqJKgR12YySwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 13:39:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 272E8A096C; Tue,  3 Sep 2024 15:39:48 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:39:48 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 17/20] ubifs: store cookie in private data
Message-ID: <20240903133948.53k76uatswcm334p@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-17-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-17-6d3e4816aa7b@kernel.org>
X-Rspamd-Queue-Id: B0A9021BA2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 30-08-24 15:04:58, Christian Brauner wrote:
> Store the cookie to detect concurrent seeks on directories in
> file->private_data.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ubifs/dir.c | 65 ++++++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 47 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index c77ea57fe696..76bcafa92200 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -555,6 +555,11 @@ static unsigned int vfs_dent_type(uint8_t type)
>  	return 0;
>  }
>  
> +struct ubifs_dir_data {
> +	struct ubifs_dent_node *dent;
> +	u64 cookie;
> +};
> +
>  /*
>   * The classical Unix view for directory is that it is a linear array of
>   * (name, inode number) entries. Linux/VFS assumes this model as well.
> @@ -582,6 +587,7 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
>  	struct inode *dir = file_inode(file);
>  	struct ubifs_info *c = dir->i_sb->s_fs_info;
>  	bool encrypted = IS_ENCRYPTED(dir);
> +	struct ubifs_dir_data *data = file->private_data;
>  
>  	dbg_gen("dir ino %lu, f_pos %#llx", dir->i_ino, ctx->pos);
>  
> @@ -604,27 +610,27 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
>  		fstr_real_len = fstr.len;
>  	}
>  
> -	if (file->f_version == 0) {
> +	if (data->cookie == 0) {
>  		/*
> -		 * The file was seek'ed, which means that @file->private_data
> +		 * The file was seek'ed, which means that @data->dent
>  		 * is now invalid. This may also be just the first
>  		 * 'ubifs_readdir()' invocation, in which case
> -		 * @file->private_data is NULL, and the below code is
> +		 * @data->dent is NULL, and the below code is
>  		 * basically a no-op.
>  		 */
> -		kfree(file->private_data);
> -		file->private_data = NULL;
> +		kfree(data->dent);
> +		data->dent = NULL;
>  	}
>  
>  	/*
> -	 * 'generic_file_llseek()' unconditionally sets @file->f_version to
> -	 * zero, and we use this for detecting whether the file was seek'ed.
> +	 * 'ubifs_dir_llseek()' sets @data->cookie to zero, and we use this
> +	 * for detecting whether the file was seek'ed.
>  	 */
> -	file->f_version = 1;
> +	data->cookie = 1;
>  
>  	/* File positions 0 and 1 correspond to "." and ".." */
>  	if (ctx->pos < 2) {
> -		ubifs_assert(c, !file->private_data);
> +		ubifs_assert(c, !data->dent);
>  		if (!dir_emit_dots(file, ctx)) {
>  			if (encrypted)
>  				fscrypt_fname_free_buffer(&fstr);
> @@ -641,10 +647,10 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
>  		}
>  
>  		ctx->pos = key_hash_flash(c, &dent->key);
> -		file->private_data = dent;
> +		data->dent = dent;
>  	}
>  
> -	dent = file->private_data;
> +	dent = data->dent;
>  	if (!dent) {
>  		/*
>  		 * The directory was seek'ed to and is now readdir'ed.
> @@ -658,7 +664,7 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
>  			goto out;
>  		}
>  		ctx->pos = key_hash_flash(c, &dent->key);
> -		file->private_data = dent;
> +		data->dent = dent;
>  	}
>  
>  	while (1) {
> @@ -701,15 +707,15 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
>  			goto out;
>  		}
>  
> -		kfree(file->private_data);
> +		kfree(data->dent);
>  		ctx->pos = key_hash_flash(c, &dent->key);
> -		file->private_data = dent;
> +		data->dent = dent;
>  		cond_resched();
>  	}
>  
>  out:
> -	kfree(file->private_data);
> -	file->private_data = NULL;
> +	kfree(data->dent);
> +	data->dent = NULL;
>  
>  	if (encrypted)
>  		fscrypt_fname_free_buffer(&fstr);
> @@ -733,7 +739,10 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
>  /* Free saved readdir() state when the directory is closed */
>  static int ubifs_dir_release(struct inode *dir, struct file *file)
>  {
> -	kfree(file->private_data);
> +	struct ubifs_dir_data *data = file->private_data;
> +
> +	kfree(data->dent);
> +	kfree(data);
>  	file->private_data = NULL;
>  	return 0;
>  }
> @@ -1712,6 +1721,24 @@ int ubifs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	return 0;
>  }
>  
> +static int ubifs_dir_open(struct inode *inode, struct file *file)
> +{
> +	struct ubifs_dir_data	*data;
> +
> +	data = kzalloc(sizeof(struct ubifs_dir_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	file->private_data = data;
> +	return 0;
> +}
> +
> +static loff_t ubifs_dir_llseek(struct file *file, loff_t offset, int whence)
> +{
> +	struct ubifs_dir_data *data = file->private_data;
> +
> +	return generic_llseek_cookie(file, offset, whence, &data->cookie);
> +}
> +
>  const struct inode_operations ubifs_dir_inode_operations = {
>  	.lookup      = ubifs_lookup,
>  	.create      = ubifs_create,
> @@ -1732,7 +1759,9 @@ const struct inode_operations ubifs_dir_inode_operations = {
>  };
>  
>  const struct file_operations ubifs_dir_operations = {
> -	.llseek         = generic_file_llseek,
> +	.open		= ubifs_dir_open,
> +	.release	= ubifs_dir_release,
> +	.llseek         = ubifs_dir_llseek,
>  	.release        = ubifs_dir_release,
>  	.read           = generic_read_dir,
>  	.iterate_shared = ubifs_readdir,
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

