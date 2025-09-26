Return-Path: <linux-fsdevel+bounces-62896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1DEBA46E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 17:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315F71C034FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DD521E08D;
	Fri, 26 Sep 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bVv4PWEa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5WsdL9yy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b8k60jAm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RMtAAtRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE821CA00
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900786; cv=none; b=XhgspzvvNFSKd5J03tH3RlagP14E8LDnHcXhfzz0DPrJcouTHwEBzVCOd3oD1YPCOvsx9OuDMSD4PTvk8/zvOrzraPLQY309zGrPcGSlz21x/ci2upu28cVgf975ggo1jk/3fBhmW43LSFlBMeiPh9j4D0TKiuPFLlhD3ra/AP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900786; c=relaxed/simple;
	bh=00S+r1tdL6PgC4Emlbo4NeWbCMLapoUjfcpuWfvk9ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NF/sVB/PT9Pnf93wzi9L02A3C/Q3g9vh4i8YL1eExTJCzp8mWz4cEA4bb+fHmG1ieL5IHN9E3O06UBcWid6FRJ9meuiEmELC/7zbfCd9SCsjlAelCy75ux40QOu0Zah2nDfeQzBCuY48GqE42PgJmpnhY+86ATrSb4JW9TsC7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bVv4PWEa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5WsdL9yy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b8k60jAm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RMtAAtRT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80AD537E10;
	Fri, 26 Sep 2025 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758900780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdhpPebHCqVXDxhTRmDXqiKy3zdiH1a2bFFZ2T9f0Ps=;
	b=bVv4PWEamDI28FNq0126MvAvV/UXvpmSwf/KnuXhz76DdwBKfDQ+q1zd4rtQz5p1gJDgFU
	jwURS4YpzvUF8LN0FWrSSi9scQi9fLmGc/J0ePKsnfBBHp3erHEUIdTXJ/vbWAKu/uUqDC
	w9EQRnl7iWu6gOeqiY2WVElxC9bWI6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758900780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdhpPebHCqVXDxhTRmDXqiKy3zdiH1a2bFFZ2T9f0Ps=;
	b=5WsdL9yyCD8p1S1MgvkfOBunN9cAXpTnfessgG45tCHFEKdiLH+MEiH5GXzsdt6kGqAI0c
	aZUUT14Iyhiz1bBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758900779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdhpPebHCqVXDxhTRmDXqiKy3zdiH1a2bFFZ2T9f0Ps=;
	b=b8k60jAmCCRsZ4NIsNzEwf0Af6Y2/0lX48M3RGa2qYLGvRWiejtJrV02vEvTbCmQVG/3FQ
	zOHPJY5UodnX24e7l2lvd8wu5/mjroTXPurPfKpSQt/QvP6jP28Km4Q/xFtzfNbdcp5/es
	YR9pvsefY6VXHjgaSnrZElu2mdT8xFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758900779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdhpPebHCqVXDxhTRmDXqiKy3zdiH1a2bFFZ2T9f0Ps=;
	b=RMtAAtRTtFCv/V917z9xtC71xYuaHQ5VtlQ29XrLrA8ChQ3vSF8H0iZyQ3Vw3m/WJuwKkn
	riRfuAN3vKY2olAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 730011386E;
	Fri, 26 Sep 2025 15:32:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tH0RHCuy1mjnAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 26 Sep 2025 15:32:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2C0C0A0AA0; Fri, 26 Sep 2025 17:32:59 +0200 (CEST)
Date: Fri, 26 Sep 2025 17:32:59 +0200
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
Subject: Re: [PATCH v3 08/38] vfs: make vfs_mknod break delegations on parent
 directory
Message-ID: <ke7z7ptll7svm4ygbtbmv7ezv7rox75ct6mv5sn73lrnqp6g2r@ju2aolr2n5n7>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
 <20250924-dir-deleg-v3-8-9f3af8bc5c40@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-dir-deleg-v3-8-9f3af8bc5c40@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,microsoft.com,talpey.com,brown.name,redhat.com,lwn.net,szeredi.hu,manguebit.org,linuxfoundation.org,tyhicks.com,chromium.org,goodmis.org,efficios.com,vger.kernel.org,lists.samba.org,lists.linux.dev];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL63fqwwx8ot6gmekemcs76f9d)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Wed 24-09-25 14:05:54, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
> 
> Rename vfs_mknod as __vfs_mknod, make it static, and add a new
> delegated_inode parameter.  Make do_mknodat call __vfs_mknod and wait
> synchronously for delegation breaks to complete. Add a new exported
> vfs_mknod wrapper that calls __vfs_mknod with a NULL delegated_inode
> pointer.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 57 +++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 35 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index d4b8330a3eb97e205dc2e71766fed1e45503323b..7bcd898c84138061030f1f8b91273261cdf2a9b4 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4215,24 +4215,9 @@ inline struct dentry *user_path_create(int dfd, const char __user *pathname,
>  }
>  EXPORT_SYMBOL(user_path_create);
>  
> -/**
> - * vfs_mknod - create device node or file
> - * @idmap:	idmap of the mount the inode was found from
> - * @dir:	inode of the parent directory
> - * @dentry:	dentry of the child device node
> - * @mode:	mode of the child device node
> - * @dev:	device number of device to create
> - *
> - * Create a device node or file.
> - *
> - * If the inode has been found through an idmapped mount the idmap of
> - * the vfsmount must be passed through @idmap. This function will then take
> - * care to map the inode according to @idmap before checking permissions.
> - * On non-idmapped mounts or if permission checking is to be performed on the
> - * raw inode simply pass @nop_mnt_idmap.
> - */
> -int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
> -	      struct dentry *dentry, umode_t mode, dev_t dev)
> +static int __vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
> +		       struct dentry *dentry, umode_t mode, dev_t dev,
> +		       struct inode **delegated_inode)
>  {
>  	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
>  	int error = may_create(idmap, dir, dentry);
> @@ -4256,11 +4241,37 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	if (error)
>  		return error;
>  
> +	error = try_break_deleg(dir, delegated_inode);
> +	if (error)
> +		return error;
> +
>  	error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
>  	if (!error)
>  		fsnotify_create(dir, dentry);
>  	return error;
>  }
> +
> +/**
> + * vfs_mknod - create device node or file
> + * @idmap:	idmap of the mount the inode was found from
> + * @dir:	inode of the parent directory
> + * @dentry:	dentry of the child device node
> + * @mode:	mode of the child device node
> + * @dev:	device number of device to create
> + *
> + * Create a device node or file.
> + *
> + * If the inode has been found through an idmapped mount the idmap of
> + * the vfsmount must be passed through @idmap. This function will then take
> + * care to map the inode according to @idmap before checking permissions.
> + * On non-idmapped mounts or if permission checking is to be performed on the
> + * raw inode simply pass @nop_mnt_idmap.
> + */
> +int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
> +	      struct dentry *dentry, umode_t mode, dev_t dev)
> +{
> +	return __vfs_mknod(idmap, dir, dentry, mode, dev, NULL);
> +}
>  EXPORT_SYMBOL(vfs_mknod);
>  
>  static int may_mknod(umode_t mode)
> @@ -4314,12 +4325,14 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  				security_path_post_mknod(idmap, dentry);
>  			break;
>  		case S_IFCHR: case S_IFBLK:
> -			error = vfs_mknod(idmap, path.dentry->d_inode,
> -					  dentry, mode, new_decode_dev(dev));
> +			error = __vfs_mknod(idmap, path.dentry->d_inode,
> +					    dentry, mode, new_decode_dev(dev),
> +					    &delegated_inode);
>  			break;
>  		case S_IFIFO: case S_IFSOCK:
> -			error = vfs_mknod(idmap, path.dentry->d_inode,
> -					  dentry, mode, 0);
> +			error = __vfs_mknod(idmap, path.dentry->d_inode,
> +					    dentry, mode, 0,
> +					    &delegated_inode);
>  			break;
>  	}
>  out2:
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

