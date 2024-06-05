Return-Path: <linux-fsdevel+bounces-21060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 649868FD209
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB5F1C22DE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFB361FE7;
	Wed,  5 Jun 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kUuskTaw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="su2WJw7F";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wjyTHobE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mZpyCXZT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE94B2BCF4;
	Wed,  5 Jun 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602531; cv=none; b=Tc6XwZkxO6ty5emzwSn7YEZX2/IH4ziskONneK2Bv5pmLcx5g/og2etYCw7lLStj1tbg29IVp35QTKrUkDO65koQ1ibu6EJ25GjpqUJmhRHlgkRUVEYHW9T6s92Wj4TEFyZWFypPxasIEzEt3bNqgK593j58artI5l1GUlIzPPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602531; c=relaxed/simple;
	bh=o7P4VTUVmxGis7MEh+WJwauhMyf8FzKx/yk1ZJhdQ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgfqMlwU+cPGTE+XDKCXuiU8XjarNtU92n5GY+mCu/UxXKTA8HIXulKm46nuHD8Rqvvsteg4V3/DZQ9ENvi7zHPP526ClRin+DkXNyp0SMPNMY5A1rF79ALk8PX8esPhxlGsu8z6dQujlgiOfuvMlff9r9Nlfywxm55Q100oXPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kUuskTaw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=su2WJw7F; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wjyTHobE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mZpyCXZT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C76F421282;
	Wed,  5 Jun 2024 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717602528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eke/PwW5IHF9MP6AeRb2uK+IN8v41RUjYO0bVNvHypE=;
	b=kUuskTawuq1ztgPzYcpyU0+FLNw3k+ylQE61sSyDMghzRlMmUjYSLkfdxWGbClKLAPUQhx
	ZPxWyPv9OkGvS/kv4EN73rMCwwyjMGrlovOnSMOhbvndRcHQbSdnjs3ZXPKMt2zl+Rav/G
	0xFwvtkpzpR3adQECl0mu0Qq2wdH8Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717602528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eke/PwW5IHF9MP6AeRb2uK+IN8v41RUjYO0bVNvHypE=;
	b=su2WJw7Fik/YalrN103kRHvjeR5dPSey++r6Leffrd1RAACh8+T5uYk+kblNqF1tK/CisM
	gNk73ZplkqJXK4Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wjyTHobE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mZpyCXZT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717602527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eke/PwW5IHF9MP6AeRb2uK+IN8v41RUjYO0bVNvHypE=;
	b=wjyTHobERev7XJts0Kpfi4Mvqvh68nr7f7uu+8hgHslUuEM/uwPnphnsxO4Tqq+WhnMIFi
	4x4QEn51g0Gy/wnqHR/h2q57XcL8ODPnO4EAbzfT9KB/UvrGLxEfIg09BdoQlgIxz0VXlf
	yLJrdmImeNGfwEvtKf/C0qfi5DykX2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717602527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eke/PwW5IHF9MP6AeRb2uK+IN8v41RUjYO0bVNvHypE=;
	b=mZpyCXZTC0wzWWABhtpb6xZVJ/6V8jaRDTYgVXXW1XfRs3TYRIAuvsZlDIT6iUbxQP91Fh
	7qPPdSRvO6O543Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A955813A24;
	Wed,  5 Jun 2024 15:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f/NUKd+IYGY6TgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Jun 2024 15:48:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5B190A086C; Wed,  5 Jun 2024 17:48:43 +0200 (CEST)
Date: Wed, 5 Jun 2024 17:48:43 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] vfs: retire user_path_at_empty and drop empty arg
 from getname_flags
Message-ID: <20240605154843.cegwjtw7w576wjs3@quack3>
References: <20240604155257.109500-1-mjguzik@gmail.com>
 <20240604155257.109500-3-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604155257.109500-3-mjguzik@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C76F421282
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]

On Tue 04-06-24 17:52:56, Mateusz Guzik wrote:
> No users after do_readlinkat started doing the job on its own.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fsopen.c           |  2 +-
>  fs/namei.c            | 16 +++++++---------
>  fs/stat.c             |  6 +++---
>  include/linux/fs.h    |  2 +-
>  include/linux/namei.h |  8 +-------
>  io_uring/statx.c      |  3 +--
>  io_uring/xattr.c      |  4 ++--
>  7 files changed, 16 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index 6593ae518115..e7d0080c4f8b 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -451,7 +451,7 @@ SYSCALL_DEFINE5(fsconfig,
>  		fallthrough;
>  	case FSCONFIG_SET_PATH:
>  		param.type = fs_value_is_filename;
> -		param.name = getname_flags(_value, lookup_flags, NULL);
> +		param.name = getname_flags(_value, lookup_flags);
>  		if (IS_ERR(param.name)) {
>  			ret = PTR_ERR(param.name);
>  			goto out_key;
> diff --git a/fs/namei.c b/fs/namei.c
> index 37fb0a8aa09a..950ad6bdd9fe 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -126,7 +126,7 @@
>  #define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
>  
>  struct filename *
> -getname_flags(const char __user *filename, int flags, int *empty)
> +getname_flags(const char __user *filename, int flags)
>  {
>  	struct filename *result;
>  	char *kname;
> @@ -190,8 +190,6 @@ getname_flags(const char __user *filename, int flags, int *empty)
>  	atomic_set(&result->refcnt, 1);
>  	/* The empty path is special. */
>  	if (unlikely(!len)) {
> -		if (empty)
> -			*empty = 1;
>  		if (!(flags & LOOKUP_EMPTY)) {
>  			putname(result);
>  			return ERR_PTR(-ENOENT);
> @@ -209,13 +207,13 @@ getname_uflags(const char __user *filename, int uflags)
>  {
>  	int flags = (uflags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
>  
> -	return getname_flags(filename, flags, NULL);
> +	return getname_flags(filename, flags);
>  }
>  
>  struct filename *
>  getname(const char __user * filename)
>  {
> -	return getname_flags(filename, 0, NULL);
> +	return getname_flags(filename, 0);
>  }
>  
>  struct filename *
> @@ -2922,16 +2920,16 @@ int path_pts(struct path *path)
>  }
>  #endif
>  
> -int user_path_at_empty(int dfd, const char __user *name, unsigned flags,
> -		 struct path *path, int *empty)
> +int user_path_at(int dfd, const char __user *name, unsigned flags,
> +		 struct path *path)
>  {
> -	struct filename *filename = getname_flags(name, flags, empty);
> +	struct filename *filename = getname_flags(name, flags);
>  	int ret = filename_lookup(dfd, filename, flags, path, NULL);
>  
>  	putname(filename);
>  	return ret;
>  }
> -EXPORT_SYMBOL(user_path_at_empty);
> +EXPORT_SYMBOL(user_path_at);
>  
>  int __check_sticky(struct mnt_idmap *idmap, struct inode *dir,
>  		   struct inode *inode)
> diff --git a/fs/stat.c b/fs/stat.c
> index 7f7861544500..16aa1f5ceec4 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -300,7 +300,7 @@ int vfs_fstatat(int dfd, const char __user *filename,
>  			return vfs_fstat(dfd, stat);
>  	}
>  
> -	name = getname_flags(filename, getname_statx_lookup_flags(statx_flags), NULL);
> +	name = getname_flags(filename, getname_statx_lookup_flags(statx_flags));
>  	ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
>  	putname(name);
>  
> @@ -496,7 +496,7 @@ static int do_readlinkat(int dfd, const char __user *pathname,
>  		return -EINVAL;
>  
>  retry:
> -	name = getname_flags(pathname, lookup_flags, NULL);
> +	name = getname_flags(pathname, lookup_flags);
>  	error = filename_lookup(dfd, name, lookup_flags, &path, NULL);
>  	if (unlikely(error)) {
>  		putname(name);
> @@ -710,7 +710,7 @@ SYSCALL_DEFINE5(statx,
>  	int ret;
>  	struct filename *name;
>  
> -	name = getname_flags(filename, getname_statx_lookup_flags(flags), NULL);
> +	name = getname_flags(filename, getname_statx_lookup_flags(flags));
>  	ret = do_statx(dfd, name, flags, mask, buffer);
>  	putname(name);
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 0283cf366c2a..dfe22a622df6 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2685,7 +2685,7 @@ static inline struct file *file_clone_open(struct file *file)
>  }
>  extern int filp_close(struct file *, fl_owner_t id);
>  
> -extern struct filename *getname_flags(const char __user *, int, int *);
> +extern struct filename *getname_flags(const char __user *, int);
>  extern struct filename *getname_uflags(const char __user *, int);
>  extern struct filename *getname(const char __user *);
>  extern struct filename *getname_kernel(const char *);
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 967aa9ea9f96..8ec8fed3bce8 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -50,13 +50,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
>  
>  extern int path_pts(struct path *path);
>  
> -extern int user_path_at_empty(int, const char __user *, unsigned, struct path *, int *empty);
> -
> -static inline int user_path_at(int dfd, const char __user *name, unsigned flags,
> -		 struct path *path)
> -{
> -	return user_path_at_empty(dfd, name, flags, path, NULL);
> -}
> +extern int user_path_at(int, const char __user *, unsigned, struct path *);
>  
>  struct dentry *lookup_one_qstr_excl(const struct qstr *name,
>  				    struct dentry *base,
> diff --git a/io_uring/statx.c b/io_uring/statx.c
> index abb874209caa..f7f9b202eec0 100644
> --- a/io_uring/statx.c
> +++ b/io_uring/statx.c
> @@ -37,8 +37,7 @@ int io_statx_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  	sx->flags = READ_ONCE(sqe->statx_flags);
>  
>  	sx->filename = getname_flags(path,
> -				     getname_statx_lookup_flags(sx->flags),
> -				     NULL);
> +				     getname_statx_lookup_flags(sx->flags));
>  
>  	if (IS_ERR(sx->filename)) {
>  		int ret = PTR_ERR(sx->filename);
> diff --git a/io_uring/xattr.c b/io_uring/xattr.c
> index 44905b82eea8..6cf41c3bc369 100644
> --- a/io_uring/xattr.c
> +++ b/io_uring/xattr.c
> @@ -96,7 +96,7 @@ int io_getxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  
>  	path = u64_to_user_ptr(READ_ONCE(sqe->addr3));
>  
> -	ix->filename = getname_flags(path, LOOKUP_FOLLOW, NULL);
> +	ix->filename = getname_flags(path, LOOKUP_FOLLOW);
>  	if (IS_ERR(ix->filename)) {
>  		ret = PTR_ERR(ix->filename);
>  		ix->filename = NULL;
> @@ -189,7 +189,7 @@ int io_setxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  
>  	path = u64_to_user_ptr(READ_ONCE(sqe->addr3));
>  
> -	ix->filename = getname_flags(path, LOOKUP_FOLLOW, NULL);
> +	ix->filename = getname_flags(path, LOOKUP_FOLLOW);
>  	if (IS_ERR(ix->filename)) {
>  		ret = PTR_ERR(ix->filename);
>  		ix->filename = NULL;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

