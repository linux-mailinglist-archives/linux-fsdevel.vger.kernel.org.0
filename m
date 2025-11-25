Return-Path: <linux-fsdevel+bounces-69791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E61D7C85032
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 13:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 891EC4E32F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6922830CDAA;
	Tue, 25 Nov 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iGYUjYa2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y/ukB3y9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iGYUjYa2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y/ukB3y9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47B18DB1E
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074551; cv=none; b=rNK3+qa1TfK03IfANbmM88llPetCIECUATrNQpehKlBgCHcZNHbOaEBnxjk4epLBYcwAoGuaxSLbL9gHGJyp3/DI/oWNVqJ9wZmSqHXWmuESyQg80xnM5cgISYgW6BoQVb8tN8x6aKdzflKDnDBBXWBXeiwp9phE6+Yoe55ZktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074551; c=relaxed/simple;
	bh=M8FkGwRekWhLsRJ/1ZW2QUSi1xqFwa9A43CUi4nErwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2qB4TZ5/Q47+LUX4FQehMZ/0qd+Nd9a0sMAYoGVmJ9P+Xh+aQ1bOsYRnT38bo2iDXmC2UBgP57xkb57u7TVj+qglJINZMcHf0yC8V8Q3tSHZ3Nqxl7giNUnuSEwWk613LQxDb+XLj/Pey+EYhOfGz8mruF3oYsIu/V8JkJbM8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iGYUjYa2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y/ukB3y9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iGYUjYa2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y/ukB3y9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B2DF5BD86;
	Tue, 25 Nov 2025 12:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764074548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PNg0JW7zlx6ZjKTtFaQOYcylk78WbcT50kA3jJqyCBQ=;
	b=iGYUjYa27VdI35LYi1W4NDGbIIvcO8rjwwk71ccP1lybEb4RosmBiKrEwBrxG73BPU6gtu
	ttFsZEya6jOVnIpDKIpiaFQhRcxvwr8J3Ck5d9PNifPRIcBin+n/C1uklJk4ZMcutN0GQ7
	DbkBo5KUcbMcjvK42ZZdmBobvRhgU4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764074548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PNg0JW7zlx6ZjKTtFaQOYcylk78WbcT50kA3jJqyCBQ=;
	b=Y/ukB3y9Aytt5huGfJdYdI/LzK48kV5rbn0jdDhayF3SkQQov6s0bVilLk9UkSchAgxkHR
	Z+rgNKk3B6iPrECw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iGYUjYa2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Y/ukB3y9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764074548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PNg0JW7zlx6ZjKTtFaQOYcylk78WbcT50kA3jJqyCBQ=;
	b=iGYUjYa27VdI35LYi1W4NDGbIIvcO8rjwwk71ccP1lybEb4RosmBiKrEwBrxG73BPU6gtu
	ttFsZEya6jOVnIpDKIpiaFQhRcxvwr8J3Ck5d9PNifPRIcBin+n/C1uklJk4ZMcutN0GQ7
	DbkBo5KUcbMcjvK42ZZdmBobvRhgU4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764074548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PNg0JW7zlx6ZjKTtFaQOYcylk78WbcT50kA3jJqyCBQ=;
	b=Y/ukB3y9Aytt5huGfJdYdI/LzK48kV5rbn0jdDhayF3SkQQov6s0bVilLk9UkSchAgxkHR
	Z+rgNKk3B6iPrECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 209DE3EA63;
	Tue, 25 Nov 2025 12:42:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UFLyBzSkJWlRewAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Nov 2025 12:42:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C6E30A0C7D; Tue, 25 Nov 2025 13:42:23 +0100 (CET)
Date: Tue, 25 Nov 2025 13:42:23 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 07/47] namespace: convert fsmount() to FD_PREPARE()
Message-ID: <oo73k4osas7dkamzz2tbphtsekh4jgextovp2shbnwasbnm55r@o3edbk5egat2>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-7-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-work-fd-prepare-v4-7-b6efa1706cfd@kernel.org>
X-Rspamd-Queue-Id: 2B2DF5BD86
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,kernel.org,gmail.com,kernel.dk];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Sun 23-11-25 17:33:25, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c | 55 +++++++++++++++++++++----------------------------------
>  1 file changed, 21 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 0c4024558c13..f118fc318156 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4273,8 +4273,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
>  {
>  	struct mnt_namespace *ns;
>  	struct fs_context *fc;
> -	struct file *file;
> -	struct path newmount;
> +	struct path newmount __free(path_put) = {};
>  	struct mount *mnt;
>  	unsigned int mnt_flags = 0;
>  	long ret;
> @@ -4312,33 +4311,32 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
>  
>  	fc = fd_file(f)->private_data;
>  
> -	ret = mutex_lock_interruptible(&fc->uapi_mutex);
> -	if (ret < 0)
> +	ACQUIRE(mutex_intr, uapi_mutex)(&fc->uapi_mutex);
> +	ret = ACQUIRE_ERR(mutex_intr, &uapi_mutex);
> +	if (ret)
>  		return ret;
>  
>  	/* There must be a valid superblock or we can't mount it */
>  	ret = -EINVAL;
>  	if (!fc->root)
> -		goto err_unlock;
> +		return ret;
>  
>  	ret = -EPERM;
>  	if (mount_too_revealing(fc->root->d_sb, &mnt_flags)) {
>  		errorfcp(fc, "VFS", "Mount too revealing");
> -		goto err_unlock;
> +		return ret;
>  	}
>  
>  	ret = -EBUSY;
>  	if (fc->phase != FS_CONTEXT_AWAITING_MOUNT)
> -		goto err_unlock;
> +		return ret;
>  
>  	if (fc->sb_flags & SB_MANDLOCK)
>  		warn_mandlock();
>  
>  	newmount.mnt = vfs_create_mount(fc);
> -	if (IS_ERR(newmount.mnt)) {
> -		ret = PTR_ERR(newmount.mnt);
> -		goto err_unlock;
> -	}
> +	if (IS_ERR(newmount.mnt))
> +		return PTR_ERR(newmount.mnt);
>  	newmount.dentry = dget(fc->root);
>  	newmount.mnt->mnt_flags = mnt_flags;
>  
> @@ -4350,38 +4348,27 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
>  	vfs_clean_context(fc);
>  
>  	ns = alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns, true);
> -	if (IS_ERR(ns)) {
> -		ret = PTR_ERR(ns);
> -		goto err_path;
> -	}
> +	if (IS_ERR(ns))
> +		return PTR_ERR(ns);
>  	mnt = real_mount(newmount.mnt);
>  	ns->root = mnt;
>  	ns->nr_mounts = 1;
>  	mnt_add_to_ns(ns, mnt);
>  	mntget(newmount.mnt);
>  
> -	/* Attach to an apparent O_PATH fd with a note that we need to unmount
> -	 * it, not just simply put it.
> -	 */
> -	file = dentry_open(&newmount, O_PATH, fc->cred);
> -	if (IS_ERR(file)) {
> +	FD_PREPARE(fdf, (flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0,
> +		   dentry_open(&newmount, O_PATH, fc->cred));
> +	if (fdf.err) {
>  		dissolve_on_fput(newmount.mnt);
> -		ret = PTR_ERR(file);
> -		goto err_path;
> +		return fdf.err;
>  	}
> -	file->f_mode |= FMODE_NEED_UNMOUNT;
> -
> -	ret = get_unused_fd_flags((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0);
> -	if (ret >= 0)
> -		fd_install(ret, file);
> -	else
> -		fput(file);
>  
> -err_path:
> -	path_put(&newmount);
> -err_unlock:
> -	mutex_unlock(&fc->uapi_mutex);
> -	return ret;
> +	/*
> +	 * Attach to an apparent O_PATH fd with a note that we
> +	 * need to unmount it, not just simply put it.
> +	 */
> +	fd_prepare_file(fdf)->f_mode |= FMODE_NEED_UNMOUNT;
> +	return fd_publish(fdf);
>  }
>  
>  static inline int vfs_move_mount(const struct path *from_path,
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

