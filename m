Return-Path: <linux-fsdevel+bounces-64669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 934D2BF0433
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14D03A7040
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1312FB0B2;
	Mon, 20 Oct 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bdZI3JD3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Za8WiouB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gDTbR3kv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lt2aQ39T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B9A1F4CBF
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953132; cv=none; b=u2mmPK4yRY4BXB63qlbudzaySmQsTfAOJBqFEqLUg9ha+zoFdVDj+uSblT3RtCTbR8ZHFktS8nBZN/sUkvYWS87YOeHuAzDEUtI8JV9x6YicRPrj/Yg62lN1547XpziC2GcIg8VWUkcZFdTpZfRDIrgI5VQKqgd/wvyJDzuU/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953132; c=relaxed/simple;
	bh=kREKPglhEAif4v/xQGpS7czJEl9l2uidNn7Bzgeaa1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZkpxLffgGLwu0vESOvoG9HKRWgy/uddn88Ji1NN6iwchCJi6zWWXtOQRrhbbWskTboV9FFR6W9qnjVNSBGWhq9uhFDgEN6J/Kl9G7qR2h2NJntKFpwmhdJl1rYlCUJPWEKcOCpMs5f7sOVFcQGwu2sB+z5cWbCR44aqozFYikU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bdZI3JD3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Za8WiouB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gDTbR3kv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lt2aQ39T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17B0321182;
	Mon, 20 Oct 2025 09:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760953125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/D/kY+oah/j2+XAgwdrv68z8P/TYq7eOMrxdwF+Wbo=;
	b=bdZI3JD30Rx2nFDXMeyQZKsEw6aTxyfxrcRBn6HCUr+DdioLL63ZY1CyHciFi4Cl7K2129
	igiVvPs/NVB2r1rEVRO588U3FwNI8NpnulDqu11Do4j9Yb0NCIh07MlX5SrNHgnfHcCL1N
	es0tfL/Tf4H6M8vmXzQPB5YWSBDx+1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760953125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/D/kY+oah/j2+XAgwdrv68z8P/TYq7eOMrxdwF+Wbo=;
	b=Za8WiouBo0dZzlxGlTV60TN405gETwiVs76vC7J621CLihngINmRmRVLvXHIJlRLnqLcdq
	awC3/3yi6rXe11AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gDTbR3kv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lt2aQ39T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760953121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/D/kY+oah/j2+XAgwdrv68z8P/TYq7eOMrxdwF+Wbo=;
	b=gDTbR3kvhKbCmUMDJ5Ws8EvdTOmX3aQmDr7Godb3ukbi/ynjIPdKv3RkgTzY8kUl8YolE6
	bZ3IXXQfQix6Zx6J+hncavMTKDXnLxsDpwdnp/okynKuErRt97VcCtxRhiUzUWRx54Zj0T
	JQr56loFZKt5X1eM2aQHliNwU94CoTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760953121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/D/kY+oah/j2+XAgwdrv68z8P/TYq7eOMrxdwF+Wbo=;
	b=lt2aQ39TXTomlkwoBCdUQpjn6Kxa+HSKOSUiO/DDozdAhC3i3mbpRNZhHJH21fcOWqbFw6
	SeHbjjfux0VCvyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5A6C13AAC;
	Mon, 20 Oct 2025 09:38:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BowMOCAD9mhfDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 09:38:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A65F6A0856; Mon, 20 Oct 2025 11:38:36 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:38:36 +0200
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
Subject: Re: [PATCH 07/13] vfs: make vfs_create break delegations on parent
 directory
Message-ID: <psxxvdygi63345uyor76xs3jhzqjievrvg4meeabttitgtxdyd@pghojfcizltu>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
 <20251013-dir-deleg-ro-v1-7-406780a70e5e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-dir-deleg-ro-v1-7-406780a70e5e@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 17B0321182
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.51

On Mon 13-10-25 10:48:05, Jeff Layton wrote:
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
> index 786f42bd184b5dbf6d754fa1fb6c94c0f75429f2..1427c53e13978e70adefdc572b71247536985430 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3458,6 +3458,32 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
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
> @@ -3477,23 +3503,7 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
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
> @@ -4365,6 +4375,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  	struct path path;
>  	int error;
>  	unsigned int lookup_flags = 0;
> +	struct inode *delegated_inode = NULL;
>  
>  	error = may_mknod(mode);
>  	if (error)
> @@ -4383,8 +4394,9 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
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
> @@ -4399,6 +4411,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  	}
>  out2:
>  	end_creating_path(&path, dentry);
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

