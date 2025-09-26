Return-Path: <linux-fsdevel+bounces-62893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86339BA4633
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 17:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F73E6222D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF22218AB0;
	Fri, 26 Sep 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="peMzWo9m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+W+ecXus";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="peMzWo9m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+W+ecXus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2B1FF1BF
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900128; cv=none; b=eqHJH45XTMFA3bo8mJSyizSAtd5iS7M+U7PEzPM1QEu6EF2jjRnncwY7Y//v003jnng3G5uRXGiTP4s2AnQwPt++JEzKFVhVLib1cMxdY2yNWRoLrjSiCf5tTnOr6XTThK+GXKnZ9e/+zb564YJCI6QVu2obZtNdGeK5Y3DJnUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900128; c=relaxed/simple;
	bh=ZqNMdSg92Q43iVc6GYR+vFrV5HRNb/gprh+Bc8qnBSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMqDhM9qW2nDFGckt3LV0bC3wl2Hm/AZRQflVP+mLnTuFaHsnT61muz7BB53M1ewclsw8dng1oOahppLkMUT5xOFWU5YbmLTJ5vy7TZ4FCDpl1b1BezH0s72IUMLxBgiHqWFvo/UXEK4W+6t4ipA7WjOpIiM4z2O7Jpk0nWUseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=peMzWo9m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+W+ecXus; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=peMzWo9m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+W+ecXus; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CAB022132;
	Fri, 26 Sep 2025 15:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758900123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3iYmdnwJUFP5zwtZs6WEPYNQrwZHjasFtnMnsic4KPA=;
	b=peMzWo9m+tnTxP/Tp7YB9ZgrZjkKp8r52HwiynhGzsLIBga6V5QNqFztCsRWM9tDKzNtys
	AA79qUSJ37lvz+WSR9b59t4cuONAbApJvPbopQHia2gy9Zmc5A7tgG9WoJAM05NJPqBH18
	pz3Fis2q+koxAwkI/SENzsXJP0zmXgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758900123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3iYmdnwJUFP5zwtZs6WEPYNQrwZHjasFtnMnsic4KPA=;
	b=+W+ecXus5herC6N6WvdTLoN+OfYoZ0K4CBU3nZ1DQkgNQ6lNO62OhpnJckwv2tL7Rsbiyf
	mdGfmIr8MBCrv4AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758900123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3iYmdnwJUFP5zwtZs6WEPYNQrwZHjasFtnMnsic4KPA=;
	b=peMzWo9m+tnTxP/Tp7YB9ZgrZjkKp8r52HwiynhGzsLIBga6V5QNqFztCsRWM9tDKzNtys
	AA79qUSJ37lvz+WSR9b59t4cuONAbApJvPbopQHia2gy9Zmc5A7tgG9WoJAM05NJPqBH18
	pz3Fis2q+koxAwkI/SENzsXJP0zmXgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758900123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3iYmdnwJUFP5zwtZs6WEPYNQrwZHjasFtnMnsic4KPA=;
	b=+W+ecXus5herC6N6WvdTLoN+OfYoZ0K4CBU3nZ1DQkgNQ6lNO62OhpnJckwv2tL7Rsbiyf
	mdGfmIr8MBCrv4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 210CE1386E;
	Fri, 26 Sep 2025 15:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OjwwCJuv1mhYfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 26 Sep 2025 15:22:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C260CA0AA0; Fri, 26 Sep 2025 17:21:54 +0200 (CEST)
Date: Fri, 26 Sep 2025 17:21:54 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Jonathan Corbet <corbet@lwn.net>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Paulo Alcantara <pc@manguebit.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Rick Macklem <rick.macklem@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/38] vfs: make vfs_create break delegations on
 parent directory
Message-ID: <k4iyqydv6i45nke27ie5likvn5r5famnehzrmdso42mb6w6lah@yuiy3ksfgeus>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
 <20250924-dir-deleg-v3-7-9f3af8bc5c40@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-dir-deleg-v3-7-9f3af8bc5c40@kernel.org>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RL63fqwwx8ot6gmekemcs76f9d)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,microsoft.com,talpey.com,brown.name,redhat.com,lwn.net,szeredi.hu,manguebit.org,linuxfoundation.org,tyhicks.com,chromium.org,goodmis.org,efficios.com,vger.kernel.org,lists.samba.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Wed 24-09-25 14:05:53, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
> 
> Rename vfs_create as __vfs_create, make it static, and add a new
> delegated_inode parameter. Fix do_mknodat to call __vfs_create and wait
> for a delegation break if there is one. Add a new exported vfs_create
> wrapper that passes in NULL for delegated_inode.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 55 ++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 903b70a82530938a0fdf10508529a1b7cc38136d..d4b8330a3eb97e205dc2e71766fed1e45503323b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3370,6 +3370,32 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
>  	return mode;
>  }
>  
> +static int __vfs_create(struct mnt_idmap *idmap, struct inode *dir,
> +			struct dentry *dentry, umode_t mode, bool want_excl,
> +			struct inode **delegated_inode)
> +{
> +	int error;
> +
> +	error = may_create(idmap, dir, dentry);
> +	if (error)
> +		return error;
> +
> +	if (!dir->i_op->create)
> +		return -EACCES;	/* shouldn't it be ENOSYS? */
> +
> +	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
> +	error = security_inode_create(dir, dentry, mode);
> +	if (error)
> +		return error;
> +	error = try_break_deleg(dir, delegated_inode);
> +	if (error)
> +		return error;
> +	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
> +	if (!error)
> +		fsnotify_create(dir, dentry);
> +	return error;
> +}
> +
>  /**
>   * vfs_create - create new file
>   * @idmap:	idmap of the mount the inode was found from
> @@ -3389,23 +3415,7 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
>  int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
>  	       struct dentry *dentry, umode_t mode, bool want_excl)
>  {
> -	int error;
> -
> -	error = may_create(idmap, dir, dentry);
> -	if (error)
> -		return error;
> -
> -	if (!dir->i_op->create)
> -		return -EACCES;	/* shouldn't it be ENOSYS? */
> -
> -	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
> -	error = security_inode_create(dir, dentry, mode);
> -	if (error)
> -		return error;
> -	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
> -	if (!error)
> -		fsnotify_create(dir, dentry);
> -	return error;
> +	return __vfs_create(idmap, dir, dentry, mode, want_excl, NULL);
>  }
>  EXPORT_SYMBOL(vfs_create);
>  
> @@ -4278,6 +4288,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  	struct path path;
>  	int error;
>  	unsigned int lookup_flags = 0;
> +	struct inode *delegated_inode = NULL;
>  
>  	error = may_mknod(mode);
>  	if (error)
> @@ -4296,8 +4307,9 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  	idmap = mnt_idmap(path.mnt);
>  	switch (mode & S_IFMT) {
>  		case 0: case S_IFREG:
> -			error = vfs_create(idmap, path.dentry->d_inode,
> -					   dentry, mode, true);
> +			error = __vfs_create(idmap, path.dentry->d_inode,
> +					     dentry, mode, true,
> +					     &delegated_inode);
>  			if (!error)
>  				security_path_post_mknod(idmap, dentry);
>  			break;
> @@ -4312,6 +4324,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  	}
>  out2:
>  	done_path_create(&path, dentry);
> +	if (delegated_inode) {
> +		error = break_deleg_wait(&delegated_inode);
> +		if (!error)
> +			goto retry;
> +	}
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |= LOOKUP_REVAL;
>  		goto retry;
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

