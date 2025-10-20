Return-Path: <linux-fsdevel+bounces-64666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 114A5BF0394
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9771189F9A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FBB2F6564;
	Mon, 20 Oct 2025 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g/FRmIih";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lh1Sej06";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CU6trVZO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u3A+0Mft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143CF2F656D
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953118; cv=none; b=UCUQCITykelohNRhOEgfhO32JMzZ2Qs7UWUczGRk8xGAVBqyi/WXycCShsS1KGejuZkkAsvd0uAKBoI+McfkCuNW5YshWMFwiNcV9Ouj7DA0/RsyZz2MMXmHhFwIuI5mdfMUTtP1tMMknkniWqgU6uIq8Y6zv1p+0MDE/xPsfnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953118; c=relaxed/simple;
	bh=vL3kCcKfldcUpYJEaxyLkt/qs32zPC6sUT4thTLF5wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vg1oU+beLU8otX1s/SApvfPDzGCRZFBc4Cw8WR7fVnreyynx7Qrd43zu3Q8KOwYZ2yO2nPMn/yTaLshx5QY0O6uJufib2VcP4WaUmkOgacZNBRcmgcv12MXtM7gvlsFXaEhZkWjkk8eSsV8om6XNwG3lHYuIUV/lDSnxVo0t6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g/FRmIih; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lh1Sej06; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CU6trVZO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u3A+0Mft; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 089251F385;
	Mon, 20 Oct 2025 09:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760953109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iusiOXx65QWEhBsxlp0QWw9n+ynsAMdO86FaydN8grw=;
	b=g/FRmIih6dFhdnppxxoS6HVN4qDJ3UkOKwN8ZCbIYNt65E1unIfQ3fVG4myQ2m2L3fA9zV
	r/WCTGT6ggsEtAu4mas2aRNWRW6p2uw566Fq4P7+16NqD2BQgzhUMQ25Jt1rixyzczjSaf
	a0kZmWQW1MMgtSd9mIuKjXujttFV74A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760953109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iusiOXx65QWEhBsxlp0QWw9n+ynsAMdO86FaydN8grw=;
	b=lh1Sej065iGEf6nI6IkT+W2JmsZoWuW6Ci78m71zKo7/fkSBwWgsWCV3cPp9NY5r3MgV8y
	5/1XDfETapzWbfAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CU6trVZO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u3A+0Mft
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760953105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iusiOXx65QWEhBsxlp0QWw9n+ynsAMdO86FaydN8grw=;
	b=CU6trVZOwRmMATpE0IfIwWq7CN3EzD+9o7U9uxXFk2GaGlPM6FDcLf/ByR5GuhKUYEOGsH
	r5km9ay4JjmoNuNpSPliCAhk+esizVxJwNM4R/xS3jEqzTfzPUoTHy+jv2Z4rNNaODWwIF
	McRs0RsChYadzwz39jSy8UU6KXc6hCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760953105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iusiOXx65QWEhBsxlp0QWw9n+ynsAMdO86FaydN8grw=;
	b=u3A+0MftxfZ10dLEU4yZQHjc4OxFw472C1bR1mXQiKz3HAWV9X75e0DFJ7fkei9iBF0+Km
	08TyztXFmp/NMNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB1F513AAC;
	Mon, 20 Oct 2025 09:38:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t1dhORAD9mg5DwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 09:38:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A4D09A0856; Mon, 20 Oct 2025 11:38:20 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:38:20 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Howells <dhowells@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 04/13] vfs: allow mkdir to wait for delegation break on
 parent
Message-ID: <wfsice3qjgzmfeibyuonhlur2sef65psoitir2irkfapekjdid@3egphok6hmaa>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
 <20251013-dir-deleg-ro-v1-4-406780a70e5e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-dir-deleg-ro-v1-4-406780a70e5e@kernel.org>
X-Rspamd-Queue-Id: 089251F385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLpnapcpkwxdkc5mopt1ezhhna)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,manguebit.org,microsoft.com,talpey.com,linuxfoundation.org,redhat.com,tyhicks.com,brown.name,chromium.org,google.com,davemloft.net,vger.kernel.org,lists.samba.org,lists.linux.dev];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 

On Mon 13-10-25 10:48:02, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
> 
> Add a new delegated_inode parameter to vfs_mkdir. All of the existing
> callers set that to NULL for now, except for do_mkdirat which will
> properly block until the lease is gone.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/base/devtmpfs.c  |  2 +-
>  fs/cachefiles/namei.c    |  2 +-
>  fs/ecryptfs/inode.c      |  2 +-
>  fs/init.c                |  2 +-
>  fs/namei.c               | 24 ++++++++++++++++++------
>  fs/nfsd/nfs4recover.c    |  2 +-
>  fs/nfsd/vfs.c            |  2 +-
>  fs/overlayfs/overlayfs.h |  2 +-
>  fs/smb/server/vfs.c      |  2 +-
>  fs/xfs/scrub/orphanage.c |  2 +-
>  include/linux/fs.h       |  2 +-
>  11 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 9d4e46ad8352257a6a65d85526ebdbf9bf2d4b19..0e79621cb0f79870003b867ca384199171ded4e0 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -180,7 +180,7 @@ static int dev_mkdir(const char *name, umode_t mode)
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> -	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode);
> +	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode, NULL);
>  	if (!IS_ERR(dentry))
>  		/* mark as kernel-created inode */
>  		d_inode(dentry)->i_private = &thread;
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index d1edb2ac38376c4f9d2a18026450bb3c774f7824..50c0f9c76d1fd4c05db90d7d0d1bad574523ead0 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -130,7 +130,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
>  			goto mkdir_error;
>  		ret = cachefiles_inject_write_error();
>  		if (ret == 0)
> -			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> +			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700, NULL);
>  		else
>  			subdir = ERR_PTR(ret);
>  		if (IS_ERR(subdir)) {
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index ed1394da8d6bd7065f2a074378331f13fcda17f9..35830b3144f8f71374a78b3e7463b864f4fc216e 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -508,7 +508,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  		goto out;
>  
>  	lower_dentry = vfs_mkdir(&nop_mnt_idmap, lower_dir,
> -				 lower_dentry, mode);
> +				 lower_dentry, mode, NULL);
>  	rc = PTR_ERR(lower_dentry);
>  	if (IS_ERR(lower_dentry))
>  		goto out;
> diff --git a/fs/init.c b/fs/init.c
> index 07f592ccdba868509d0f3aaf9936d8d890fdbec5..895f8a09a71acfd03e11164e3b441a7d4e2de146 100644
> --- a/fs/init.c
> +++ b/fs/init.c
> @@ -233,7 +233,7 @@ int __init init_mkdir(const char *pathname, umode_t mode)
>  	error = security_path_mkdir(&path, dentry, mode);
>  	if (!error) {
>  		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> -				  dentry, mode);
> +				  dentry, mode, NULL);
>  		if (IS_ERR(dentry))
>  			error = PTR_ERR(dentry);
>  	}
> diff --git a/fs/namei.c b/fs/namei.c
> index 6e61e0215b34134b1690f864e2719e3f82cf71a8..86cf6eca1f485361c6732974e4103cf5ea721539 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4407,10 +4407,11 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
>  
>  /**
>   * vfs_mkdir - create directory returning correct dentry if possible
> - * @idmap:	idmap of the mount the inode was found from
> - * @dir:	inode of the parent directory
> - * @dentry:	dentry of the child directory
> - * @mode:	mode of the child directory
> + * @idmap:		idmap of the mount the inode was found from
> + * @dir:		inode of the parent directory
> + * @dentry:		dentry of the child directory
> + * @mode:		mode of the child directory
> + * @delegated_inode:	returns parent inode, if the inode is delegated.
>   *
>   * Create a directory.
>   *
> @@ -4427,7 +4428,8 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
>   * In case of an error the dentry is dput() and an ERR_PTR() is returned.
>   */
>  struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -			 struct dentry *dentry, umode_t mode)
> +			 struct dentry *dentry, umode_t mode,
> +			 struct inode **delegated_inode)
>  {
>  	int error;
>  	unsigned max_links = dir->i_sb->s_max_links;
> @@ -4450,6 +4452,10 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	if (max_links && dir->i_nlink >= max_links)
>  		goto err;
>  
> +	error = try_break_deleg(dir, delegated_inode);
> +	if (error)
> +		goto err;
> +
>  	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
>  	error = PTR_ERR(de);
>  	if (IS_ERR(de))
> @@ -4473,6 +4479,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
>  	struct path path;
>  	int error;
>  	unsigned int lookup_flags = LOOKUP_DIRECTORY;
> +	struct inode *delegated_inode = NULL;
>  
>  retry:
>  	dentry = filename_create(dfd, name, &path, lookup_flags);
> @@ -4484,11 +4491,16 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
>  			mode_strip_umask(path.dentry->d_inode, mode));
>  	if (!error) {
>  		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> -				  dentry, mode);
> +				   dentry, mode, &delegated_inode);
>  		if (IS_ERR(dentry))
>  			error = PTR_ERR(dentry);
>  	}
>  	end_creating_path(&path, dentry);
> +	if (delegated_inode) {
> +		error = break_deleg_wait(&delegated_inode);
> +		if (!error)
> +			goto retry;
> +	}
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |= LOOKUP_REVAL;
>  		goto retry;
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index c41bb85e06822a82c86e2a33bd9a91e978c75965..3dfbb85c9a1166b56e56eb9f1d6bfd140584730b 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -162,7 +162,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>  		 * as well be forgiving and just succeed silently.
>  		 */
>  		goto out_put;
> -	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
> +	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, 0700, NULL);
>  	if (IS_ERR(dentry))
>  		status = PTR_ERR(dentry);
>  out_put:
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f537a7b4ee01f49cfb864df9a92a9660b743a51e..447f5ab8e0b92288c9f220060ab15f32f2a84de9 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1644,7 +1644,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			nfsd_check_ignore_resizing(iap);
>  		break;
>  	case S_IFDIR:
> -		dchild = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
> +		dchild = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode, NULL);
>  		if (IS_ERR(dchild)) {
>  			host_err = PTR_ERR(dchild);
>  		} else if (d_is_negative(dchild)) {
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index c8fd5951fc5ece1ae6b3e2a0801ca15f9faf7d72..0f65f9a5d54d4786b39e4f4f30f416d5b9016e70 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -248,7 +248,7 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_fs *ofs,
>  {
>  	struct dentry *ret;
>  
> -	ret = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
> +	ret = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, NULL);
>  	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, PTR_ERR_OR_ZERO(ret));
>  	return ret;
>  }
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 891ed2dc2b7351a5cb14a2241d71095ffdd03f08..3d2190f26623b23ea79c63410905a3c3ad684048 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -230,7 +230,7 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
>  	idmap = mnt_idmap(path.mnt);
>  	mode |= S_IFDIR;
>  	d = dentry;
> -	dentry = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
> +	dentry = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode, NULL);
>  	if (IS_ERR(dentry))
>  		err = PTR_ERR(dentry);
>  	else if (d_is_negative(dentry))
> diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> index 9c12cb8442311ca26b169e4d1567939ae44a5be0..91c9d07b97f306f57aebb9b69ba564b0c2cb8c17 100644
> --- a/fs/xfs/scrub/orphanage.c
> +++ b/fs/xfs/scrub/orphanage.c
> @@ -167,7 +167,7 @@ xrep_orphanage_create(
>  	 */
>  	if (d_really_is_negative(orphanage_dentry)) {
>  		orphanage_dentry = vfs_mkdir(&nop_mnt_idmap, root_inode,
> -					     orphanage_dentry, 0750);
> +					     orphanage_dentry, 0750, NULL);
>  		error = PTR_ERR(orphanage_dentry);
>  		if (IS_ERR(orphanage_dentry))
>  			goto out_unlock_root;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444be36e0a779df55622cc38c9419ff..1040df3792794cd353b86558b41618294e25b8a6 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2113,7 +2113,7 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
>  int vfs_create(struct mnt_idmap *, struct inode *,
>  	       struct dentry *, umode_t, bool);
>  struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
> -			 struct dentry *, umode_t);
> +			 struct dentry *, umode_t, struct inode **);
>  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
>                umode_t, dev_t);
>  int vfs_symlink(struct mnt_idmap *, struct inode *,
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

