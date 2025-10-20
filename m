Return-Path: <linux-fsdevel+bounces-64667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57500BF03AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF73234ACCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4E82F83AB;
	Mon, 20 Oct 2025 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fCKbPopG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MBH6jdgO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nm/Ye4Iv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WxzPXaxR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CA22F6920
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953125; cv=none; b=siM9zfQc2wwCzkSWLxa5T+gLJvKYqYls3XQl+NxnplP7wvxwOqGPS++H64/YJkhsp8XLp/k00AaMWr15PYpiv4z2Oq9yvQdC1+5uE+vVYsVK2vg8WElfJVnG1lkAOigw5t43q8boT6MPehAUmsT6BFr+CC3D9OIWH3rapoBgT44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953125; c=relaxed/simple;
	bh=mwArIbMJNjPxkMR7gRaFJlyMcj6jovxh5gpIxVvu7T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqMZZYHwYYVadpcP3eUjEIP60q9fyGKVcJTWyt0z3EKeSSXzg4U38jsKuCxgedKgjAMoNEcG0EneY1YSmoCLLGyip+Dp2vrKjg8rLV35KmS8B2lJQeN+tazvuI5fl/LgCmheyrbphfoYjt5xnNqOzv+x4/rEtm+wbbRGt8YC46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fCKbPopG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MBH6jdgO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nm/Ye4Iv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WxzPXaxR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72B9921174;
	Mon, 20 Oct 2025 09:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760953115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKbymr3jQEOCCpqmE9Vmgx8KF0rDhcumRs3XaWmxad0=;
	b=fCKbPopGQvwUNY4o5FQ9GY052P0nmo1gHhjtXANE9C0mk66OgSjGNx/Vq5sCcVQIWtLbXG
	jTMWDOAVh+PQ/cgEsYSWMzXcBKVSDWjjGOtt5YkfW913YSdOquSr3B0L6jlXkwtlmY/dtL
	Itbvgsclz4r6GqfZAv/lX4VLXlu5OnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760953115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKbymr3jQEOCCpqmE9Vmgx8KF0rDhcumRs3XaWmxad0=;
	b=MBH6jdgOVdjCwhRUWwlqYesDxmAPDfZORnRUkwPsAm/D3xNC5QFveYzP8K5tcNNk83XbVH
	AvvkOacScpY4FiDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="nm/Ye4Iv";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WxzPXaxR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760953111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKbymr3jQEOCCpqmE9Vmgx8KF0rDhcumRs3XaWmxad0=;
	b=nm/Ye4Ivyo2PHjNc/kQiB9IKoMXi68/aFXoMXVINi6+vIn+F7Za1EtgZ2kVclDioWvpslf
	eSw54TdYxsqu6AnmXF/hLk8EjC1CgASxbY4YxJ0MXbr5G6BdCSa47mUz7wXqqqc26YIYtd
	0kYTtZ/SQFqlsw4sB3lfuImZTUIQw3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760953111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKbymr3jQEOCCpqmE9Vmgx8KF0rDhcumRs3XaWmxad0=;
	b=WxzPXaxRDG4GwjOXPRWGQ1zT2mNm+Kx8EtwyKMZrQDel2zD1Ln4QUzHr9DR1GfJc5HQhy9
	s4Flg2uA8W+DzHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6254113AD6;
	Mon, 20 Oct 2025 09:38:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oiMAGBcD9mhGDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 09:38:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1DE8CA0856; Mon, 20 Oct 2025 11:38:31 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:38:31 +0200
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
Subject: Re: [PATCH 06/13] vfs: break parent dir delegations in open(...,
 O_CREAT) codepath
Message-ID: <5fng2d6q5sacwca3un6r6ud7sreypmphei4xvfv4cp2romjdw6@pyes2nd3747m>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
 <20251013-dir-deleg-ro-v1-6-406780a70e5e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-dir-deleg-ro-v1-6-406780a70e5e@kernel.org>
X-Rspamd-Queue-Id: 72B9921174
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 

On Mon 13-10-25 10:48:04, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
> 
> Add a delegated_inode parameter to lookup_open and have it break the
> delegation. Then, open_last_lookups can wait for the delegation break
> and retry the call to lookup_open once it's done.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 4b5a99653c558397e592715d9d4663cd4a63ef86..786f42bd184b5dbf6d754fa1fb6c94c0f75429f2 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3697,7 +3697,7 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
>   */
>  static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  				  const struct open_flags *op,
> -				  bool got_write)
> +				  bool got_write, struct inode **delegated_inode)
>  {
>  	struct mnt_idmap *idmap;
>  	struct dentry *dir = nd->path.dentry;
> @@ -3786,6 +3786,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  
>  	/* Negative dentry, just create the file */
>  	if (!dentry->d_inode && (open_flag & O_CREAT)) {
> +		/* but break the directory lease first! */
> +		error = try_break_deleg(dir_inode, delegated_inode);
> +		if (error)
> +			goto out_dput;
> +
>  		file->f_mode |= FMODE_CREATED;
>  		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
>  		if (!dir_inode->i_op->create) {
> @@ -3849,6 +3854,7 @@ static const char *open_last_lookups(struct nameidata *nd,
>  		   struct file *file, const struct open_flags *op)
>  {
>  	struct dentry *dir = nd->path.dentry;
> +	struct inode *delegated_inode = NULL;
>  	int open_flag = op->open_flag;
>  	bool got_write = false;
>  	struct dentry *dentry;
> @@ -3879,7 +3885,7 @@ static const char *open_last_lookups(struct nameidata *nd,
>  				return ERR_PTR(-ECHILD);
>  		}
>  	}
> -
> +retry:
>  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
>  		got_write = !mnt_want_write(nd->path.mnt);
>  		/*
> @@ -3892,7 +3898,7 @@ static const char *open_last_lookups(struct nameidata *nd,
>  		inode_lock(dir->d_inode);
>  	else
>  		inode_lock_shared(dir->d_inode);
> -	dentry = lookup_open(nd, file, op, got_write);
> +	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
>  	if (!IS_ERR(dentry)) {
>  		if (file->f_mode & FMODE_CREATED)
>  			fsnotify_create(dir->d_inode, dentry);
> @@ -3907,8 +3913,16 @@ static const char *open_last_lookups(struct nameidata *nd,
>  	if (got_write)
>  		mnt_drop_write(nd->path.mnt);
>  
> -	if (IS_ERR(dentry))
> +	if (IS_ERR(dentry)) {
> +		if (delegated_inode) {
> +			int error = break_deleg_wait(&delegated_inode);
> +
> +			if (!error)
> +				goto retry;
> +			return ERR_PTR(error);
> +		}
>  		return ERR_CAST(dentry);
> +	}
>  
>  	if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
>  		dput(nd->path.dentry);
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

