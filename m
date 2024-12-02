Return-Path: <linux-fsdevel+bounces-36271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F3B9E07F3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 17:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2198BB38073
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389B313B58D;
	Mon,  2 Dec 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lv0UTB8n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B4/nFAXD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lv0UTB8n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B4/nFAXD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD10757EA;
	Mon,  2 Dec 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155120; cv=none; b=WEIT4nUbiyORU0iifnayTwsbp4vjG5eFZQ7EbwbRI90i9DiRmgkU2KGkBH5TVrtiPfsWfCbnJ2EG7zwELP1xU4HQehDkMjFgjhbZPcZKBEwrp9iI+0f4CmPQ5mehLmwdTDBYUKnW8Du+mGuvPqOYsaYSH/mEbQwwjRodZ0dYq8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155120; c=relaxed/simple;
	bh=y4FPdSIaQI0lGQ+P9ptBPKy5k1E/YAFgbd//GVIcaog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpNsZSR6+9AmB7sm5yntKmdngBAoH/3SnFJl6IQBruO4PM194OXm0tB8ZFYJMhJnkGGGFpMkQdPOdF6qQGv96BMWOJsopjoQtwJlhmfTyIm4xXNHoXYxCHQX+7TjNaICFcxW2TfyQidoXTkkK9U+zu59wucoTKTnIHgZ1oLUJK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lv0UTB8n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B4/nFAXD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lv0UTB8n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B4/nFAXD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2D391F44B;
	Mon,  2 Dec 2024 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733155116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/qsso5X6tOKUMH1encIDj8wl9rBwroV8igumBF6W+c=;
	b=Lv0UTB8nhcEKSq9FxnB///3AsWpimsb15LmK57cwuwb/VKfpJEL3K2FzO/Xi35Jt1TKBr2
	e13OjguVMWOPgBjyBBEa3NJw6YLlcuBbOuAZiHp+Us41N9jG9vabCwVNLiZFu43+JDnL1L
	oNbcRQ4VSfTG3PHxExwnA6iecbpH1Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733155116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/qsso5X6tOKUMH1encIDj8wl9rBwroV8igumBF6W+c=;
	b=B4/nFAXD6yEwt48h/WczVcrocG9efPTMm7tOfp5Aqa1+0B6G8ZSKnEpB8rfREGJmX+0IaL
	XVf7pCKA/b0A/KDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Lv0UTB8n;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="B4/nFAXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733155116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/qsso5X6tOKUMH1encIDj8wl9rBwroV8igumBF6W+c=;
	b=Lv0UTB8nhcEKSq9FxnB///3AsWpimsb15LmK57cwuwb/VKfpJEL3K2FzO/Xi35Jt1TKBr2
	e13OjguVMWOPgBjyBBEa3NJw6YLlcuBbOuAZiHp+Us41N9jG9vabCwVNLiZFu43+JDnL1L
	oNbcRQ4VSfTG3PHxExwnA6iecbpH1Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733155116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/qsso5X6tOKUMH1encIDj8wl9rBwroV8igumBF6W+c=;
	b=B4/nFAXD6yEwt48h/WczVcrocG9efPTMm7tOfp5Aqa1+0B6G8ZSKnEpB8rfREGJmX+0IaL
	XVf7pCKA/b0A/KDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4E6813A31;
	Mon,  2 Dec 2024 15:58:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EHXrJyzZTWfqOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Dec 2024 15:58:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3ACAFA07B4; Mon,  2 Dec 2024 16:58:32 +0100 (CET)
Date: Mon, 2 Dec 2024 16:58:32 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/6] fhandle: simplify error handling
Message-ID: <20241202155832.uoc4h4xazyocmqot@quack3>
References: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
 <20241129-work-pidfs-file_handle-v1-2-87d803a42495@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-work-pidfs-file_handle-v1-2-87d803a42495@kernel.org>
X-Rspamd-Queue-Id: C2D391F44B
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[e43.eu,gmail.com,kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 29-11-24 14:38:01, Christian Brauner wrote:
> Rely on our cleanup infrastructure.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fhandle.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index ec9145047dfc9d25e109e72d210987bbf6b36a20..c00d88fb14e16654b5cbbb71760c0478eac20384 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -261,19 +261,20 @@ static int do_handle_to_path(struct file_handle *handle, struct path *path,
>  {
>  	int handle_dwords;
>  	struct vfsmount *mnt = ctx->root.mnt;
> +	struct dentry *dentry;
>  
>  	/* change the handle size to multiple of sizeof(u32) */
>  	handle_dwords = handle->handle_bytes >> 2;
> -	path->dentry = exportfs_decode_fh_raw(mnt,
> -					  (struct fid *)handle->f_handle,
> -					  handle_dwords, handle->handle_type,
> -					  ctx->fh_flags,
> -					  vfs_dentry_acceptable, ctx);
> -	if (IS_ERR_OR_NULL(path->dentry)) {
> -		if (path->dentry == ERR_PTR(-ENOMEM))
> +	dentry = exportfs_decode_fh_raw(mnt, (struct fid *)handle->f_handle,
> +					handle_dwords, handle->handle_type,
> +					ctx->fh_flags, vfs_dentry_acceptable,
> +					ctx);
> +	if (IS_ERR_OR_NULL(dentry)) {
> +		if (dentry == ERR_PTR(-ENOMEM))
>  			return -ENOMEM;
>  		return -ESTALE;
>  	}
> +	path->dentry = dentry;
>  	path->mnt = mntget(mnt);
>  	return 0;
>  }
> @@ -398,29 +399,23 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
>  			   int open_flag)
>  {
>  	long retval = 0;
> -	struct path path;
> +	struct path path __free(path_put) = {};
>  	struct file *file;
> -	int fd;
>  
>  	retval = handle_to_path(mountdirfd, ufh, &path, open_flag);
>  	if (retval)
>  		return retval;
>  
> -	fd = get_unused_fd_flags(open_flag);
> -	if (fd < 0) {
> -		path_put(&path);
> +	CLASS(get_unused_fd, fd)(O_CLOEXEC);
> +	if (fd < 0)
>  		return fd;
> -	}
> +
>  	file = file_open_root(&path, "", open_flag, 0);
> -	if (IS_ERR(file)) {
> -		put_unused_fd(fd);
> -		retval =  PTR_ERR(file);
> -	} else {
> -		retval = fd;
> -		fd_install(fd, file);
> -	}
> -	path_put(&path);
> -	return retval;
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	fd_install(fd, file);
> +	return take_fd(fd);
>  }
>  
>  /**
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

