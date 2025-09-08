Return-Path: <linux-fsdevel+bounces-60493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC89B48913
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25466173EF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E29F2EDD41;
	Mon,  8 Sep 2025 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HAs3dQoq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ATgb21Hl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HAs3dQoq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ATgb21Hl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342181E505
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325161; cv=none; b=fzLEIbGSVWJwY0/EjG7R94lKbvVYsz/v6C6vvClBwcOImtxomUQdhe/R6rQvEFyYnAes7iyzOMpcyKLQFu/hD/BYG22MJ5PO+pGLYVgGUAreiMKKNYqaVXhRjzVF0mfJc37TDHZdd1P2WnlO2rewIxSnFcPrn/X16I58ves9SaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325161; c=relaxed/simple;
	bh=0OUhVAMy0G9t+pqudsTB3RfbAZhGz9Y8tWQ2L3PGjxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7XNhmZbjXj5T0Zvoe+OxDT9GnSmUs80kkI7zB6FhVxWQZ4kdQVlDS5rg6cFCDp2049ouDcoODe7AFNQs9xswWsa1oGBKNRri/q4jO0ApgmFP3yb3fuj4t3mJBM+H/WsemQbgM3EOPWGh3FrIRmA9clDDRBS3qQtANjzP5TZ5ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HAs3dQoq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ATgb21Hl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HAs3dQoq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ATgb21Hl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D20326869;
	Mon,  8 Sep 2025 09:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757325158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPa5SfJ24ZVnJ9PpS4ypwdKuNFror7PV8CPuC1V5z3A=;
	b=HAs3dQoq9tpW70YUaUWvUXEhMYZbxTLNKtrsxKz5tPCt0Hx8M08N4Q/yFJw9AzWJIqDWIC
	nvWnWdBMBmNsf4fH0UPJOtTjznk/ZEnLhWJej2iqmpuxnb/ankSm+RfseP6s8BUUXmrqbM
	nk/PSZi2rvPqrW3pucFo/zX1pCCxPj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757325158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPa5SfJ24ZVnJ9PpS4ypwdKuNFror7PV8CPuC1V5z3A=;
	b=ATgb21HluASOKA63m2UEqLG4SlNSV51uGlpiO+tmZwZmMVfmipAPY6KLkDJSuvzvz0Uck1
	V3UGHoOVJ1Ulx7DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HAs3dQoq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ATgb21Hl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757325158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPa5SfJ24ZVnJ9PpS4ypwdKuNFror7PV8CPuC1V5z3A=;
	b=HAs3dQoq9tpW70YUaUWvUXEhMYZbxTLNKtrsxKz5tPCt0Hx8M08N4Q/yFJw9AzWJIqDWIC
	nvWnWdBMBmNsf4fH0UPJOtTjznk/ZEnLhWJej2iqmpuxnb/ankSm+RfseP6s8BUUXmrqbM
	nk/PSZi2rvPqrW3pucFo/zX1pCCxPj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757325158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPa5SfJ24ZVnJ9PpS4ypwdKuNFror7PV8CPuC1V5z3A=;
	b=ATgb21HluASOKA63m2UEqLG4SlNSV51uGlpiO+tmZwZmMVfmipAPY6KLkDJSuvzvz0Uck1
	V3UGHoOVJ1Ulx7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 346C713869;
	Mon,  8 Sep 2025 09:52:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +aLIDGanvmi7cAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 09:52:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E1416A0A2D; Mon,  8 Sep 2025 11:52:37 +0200 (CEST)
Date: Mon, 8 Sep 2025 11:52:37 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, John Johansen <john@apparmor.net>
Subject: Re: [PATCH 2/2] Have cc(1) catch attempts to modify ->f_path
Message-ID: <lh5fageg5tkjqkh4k5uioh2nlvrwjtzbfiz2squpzkeabgoxus@ccrpcw2gtb7q>
References: <20250906090738.GA31600@ZenIV>
 <20250906091458.GC31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906091458.GC31600@ZenIV>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,kernel.org,suse.cz,gmail.com,oracle.com,apparmor.net];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linux.org.uk:email,suse.cz:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 3D20326869
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Sat 06-09-25 10:14:58, Al Viro wrote:
> [last one in #work.f_path, following the merge with #work.mount and #work.path]
> 
> There are very few places that have cause to do that - all in core
> VFS now, and all done to files that are not yet opened (or visible
> to anybody else, for that matter).
> 
> Let's turn f_path into a union of struct path __f_path and const
> struct path f_path.  It's C, not C++ - 6.5.2.3[4] in C99 and
> later explicitly allows that kind of type-punning.
> 
> That way any attempts to bypass these checks will be either very
> easy to catch, or (if the bastards get sufficiently creative to
> make it hard to spot with grep alone) very clearly malicious -
> and still catchable with a bit of instrumentation for sparse.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 85b53e39138d..b223d873e48b 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -171,7 +171,7 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
>  	 * the respective member when opening the file.
>  	 */
>  	mutex_init(&f->f_pos_lock);
> -	memset(&f->f_path, 0, sizeof(f->f_path));
> +	memset(&f->__f_path, 0, sizeof(f->f_path));
>  	memset(&f->f_ra, 0, sizeof(f->f_ra));
>  
>  	f->f_flags	= flags;
> @@ -319,7 +319,7 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
>  static void file_init_path(struct file *file, const struct path *path,
>  			   const struct file_operations *fop)
>  {
> -	file->f_path = *path;
> +	file->__f_path = *path;
>  	file->f_inode = path->dentry->d_inode;
>  	file->f_mapping = path->dentry->d_inode->i_mapping;
>  	file->f_wb_err = filemap_sample_wb_err(file->f_mapping);
> diff --git a/fs/namei.c b/fs/namei.c
> index 3eb0408e3400..ba8bf73d2f9c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3563,8 +3563,8 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
>  	if (nd->flags & LOOKUP_DIRECTORY)
>  		open_flag |= O_DIRECTORY;
>  
> -	file->f_path.dentry = DENTRY_NOT_SET;
> -	file->f_path.mnt = nd->path.mnt;
> +	file->__f_path.dentry = DENTRY_NOT_SET;
> +	file->__f_path.mnt = nd->path.mnt;
>  	error = dir->i_op->atomic_open(dir, dentry, file,
>  				       open_to_namei_flags(open_flag), mode);
>  	d_lookup_done(dentry);
> @@ -3932,8 +3932,8 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
>  	child = d_alloc(parentpath->dentry, &slash_name);
>  	if (unlikely(!child))
>  		return -ENOMEM;
> -	file->f_path.mnt = parentpath->mnt;
> -	file->f_path.dentry = child;
> +	file->__f_path.mnt = parentpath->mnt;
> +	file->__f_path.dentry = child;
>  	mode = vfs_prepare_mode(idmap, dir, mode, mode, mode);
>  	error = dir->i_op->tmpfile(idmap, dir, file, mode);
>  	dput(child);
> diff --git a/fs/open.c b/fs/open.c
> index 9655158c3885..f4bdf7693530 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1022,8 +1022,8 @@ static int do_dentry_open(struct file *f,
>  	put_file_access(f);
>  cleanup_file:
>  	path_put(&f->f_path);
> -	f->f_path.mnt = NULL;
> -	f->f_path.dentry = NULL;
> +	f->__f_path.mnt = NULL;
> +	f->__f_path.dentry = NULL;
>  	f->f_inode = NULL;
>  	return error;
>  }
> @@ -1050,7 +1050,7 @@ int finish_open(struct file *file, struct dentry *dentry,
>  {
>  	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
>  
> -	file->f_path.dentry = dentry;
> +	file->__f_path.dentry = dentry;
>  	return do_dentry_open(file, open);
>  }
>  EXPORT_SYMBOL(finish_open);
> @@ -1071,7 +1071,7 @@ EXPORT_SYMBOL(finish_open);
>   */
>  int finish_no_open(struct file *file, struct dentry *dentry)
>  {
> -	file->f_path.dentry = dentry;
> +	file->__f_path.dentry = dentry;
>  	return 0;
>  }
>  EXPORT_SYMBOL(finish_no_open);
> @@ -1091,7 +1091,7 @@ int vfs_open(const struct path *path, struct file *file)
>  {
>  	int ret;
>  
> -	file->f_path = *path;
> +	file->__f_path = *path;
>  	ret = do_dentry_open(file, NULL);
>  	if (!ret) {
>  		/*
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index af514fae4e2d..7fe4831b7663 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1107,7 +1107,10 @@ struct file {
>  	const struct cred		*f_cred;
>  	struct fown_struct		*f_owner;
>  	/* --- cacheline 1 boundary (64 bytes) --- */
> -	struct path			f_path;
> +	union {
> +		const struct path	f_path;
> +		struct path		__f_path;
> +	};
>  	union {
>  		/* regular files (with FMODE_ATOMIC_POS) and directories */
>  		struct mutex		f_pos_lock;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

