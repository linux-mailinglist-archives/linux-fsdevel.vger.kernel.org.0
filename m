Return-Path: <linux-fsdevel+bounces-52731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48133AE60D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14B219259FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93ED257AF9;
	Tue, 24 Jun 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LIQr7DNm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zmzr0S1n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LIQr7DNm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zmzr0S1n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4A91ADFFB
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757447; cv=none; b=HzwwgI4WRE4R3+dCxJkKmuPR0MCTP/2K3OBBoNfXJ5gxJHovD+tYLvYQWyJS/mH81c56EzMReIROPsbOfm00aMwJKFDWpt0DEgrA4uJmgxk6otAiE0+/98fEjhoYW8FFKToz0QkOv+yObZAmeXeQ9PSNWbH7N8yQj7QkHF0cl0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757447; c=relaxed/simple;
	bh=yKPQo10SwWyvjSyY1RLHwL86l/7+hljCKRvHdogDfuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKGh9aFWnxcjJSg31uTjjjWgplgtHDbtdvLeB2cy6v6MSemrkrsJsFaGNAixmI7KXG/TlBk69ZDZFhRzcRiQ14ZzvpVX9QiP/eC3etnK/1aJXj1XUoEc+EEqn5J/xn62u2CdyXMgv6p5ZqpU6CBcLlwBlJ8O1BapcKayHnNJISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LIQr7DNm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zmzr0S1n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LIQr7DNm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zmzr0S1n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9869E21188;
	Tue, 24 Jun 2025 09:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750757442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vsCXbi7GO2SyLNGIrJxZ9U8joz8RZ1gI2cJPHPiAGik=;
	b=LIQr7DNmS4Jm6nobdp06ugmQ5nEjKE6OoaSM8c99lj6qKNLnyaqijiNcWsdMznIKWNOdB8
	6i5S9XgnY0q4VuDhi242osnmiKIhSxlTDZybAirZXw8u7FUlI1pBtz+7YIsOLImbbHn2mO
	hl9fL+cF094sb+Uu4gHOg6gFOq1kz60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750757442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vsCXbi7GO2SyLNGIrJxZ9U8joz8RZ1gI2cJPHPiAGik=;
	b=Zmzr0S1n5TlBFxrZYl3IAVYXFUU38JO6BwmhIcWcQGccZ92pxSrA8ztHFH9Fqy1nkCBf/B
	h9TGn0e0Qqd9zkDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750757442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vsCXbi7GO2SyLNGIrJxZ9U8joz8RZ1gI2cJPHPiAGik=;
	b=LIQr7DNmS4Jm6nobdp06ugmQ5nEjKE6OoaSM8c99lj6qKNLnyaqijiNcWsdMznIKWNOdB8
	6i5S9XgnY0q4VuDhi242osnmiKIhSxlTDZybAirZXw8u7FUlI1pBtz+7YIsOLImbbHn2mO
	hl9fL+cF094sb+Uu4gHOg6gFOq1kz60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750757442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vsCXbi7GO2SyLNGIrJxZ9U8joz8RZ1gI2cJPHPiAGik=;
	b=Zmzr0S1n5TlBFxrZYl3IAVYXFUU38JO6BwmhIcWcQGccZ92pxSrA8ztHFH9Fqy1nkCBf/B
	h9TGn0e0Qqd9zkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8941013751;
	Tue, 24 Jun 2025 09:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZYk0IUJwWmjSHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 09:30:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 41395A0A03; Tue, 24 Jun 2025 11:30:42 +0200 (CEST)
Date: Tue, 24 Jun 2025 11:30:42 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 10/11] fhandle, pidfs: support open_by_handle_at()
 purely based on file handle
Message-ID: <ng6fvyydyem4qh3rtkvaeyyxm3suixjoef5nepyhwgc4k26chp@n2tlycbek4vl>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 24-06-25 10:29:13, Christian Brauner wrote:
> Various filesystems such as pidfs (and likely drm in the future) have a
> use-case to support opening files purely based on the handle without
> having to require a file descriptor to another object. That's especially
> the case for filesystems that don't do any lookup whatsoever and there's
> zero relationship between the objects. Such filesystems are also
> singletons that stay around for the lifetime of the system meaning that
> they can be uniquely identified and accessed purely based on the file
> handle type. Enable that so that userspace doesn't have to allocate an
> object needlessly especially if they can't do that for whatever reason.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/fhandle.c | 22 ++++++++++++++++++++--
>  fs/pidfs.c   |  5 ++++-
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index ab4891925b52..54081e19f594 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -173,7 +173,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
>  	return err;
>  }
>  
> -static int get_path_anchor(int fd, struct path *root)
> +static int get_path_anchor(int fd, struct path *root, int handle_type)
>  {
>  	if (fd >= 0) {
>  		CLASS(fd, f)(fd);
> @@ -193,6 +193,24 @@ static int get_path_anchor(int fd, struct path *root)
>  		return 0;
>  	}
>  
> +	/*
> +	 * Only autonomous handles can be decoded without a file
> +	 * descriptor.
> +	 */
> +	if (!(handle_type & FILEID_IS_AUTONOMOUS))
> +		return -EOPNOTSUPP;

This somewhat ties to my comment to patch 5 that if someone passed invalid
fd < 0 before, we'd be returning -EBADF and now we'd be returning -EINVAL
or -EOPNOTSUPP based on FILEID_IS_AUTONOMOUS setting. I don't care that
much about it so feel free to ignore me but I think the following might be
more sensible error codes:

	if (!(handle_type & FILEID_IS_AUTONOMOUS)) {
		if (fd == FD_INVALID)
			return -EOPNOTSUPP;
		return -EBADF;
	}

	if (fd != FD_INVALID)
		return -EBADF; (or -EINVAL no strong preference here)

Since I don't care that much feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> +
> +	if (fd != FD_INVALID)
> +		return -EINVAL;
> +
> +	switch (handle_type & ~FILEID_USER_FLAGS_MASK) {
> +	case FILEID_PIDFS:
> +		pidfs_get_root(root);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -347,7 +365,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS)
>  		return -EINVAL;
>  
> -	retval = get_path_anchor(mountdirfd, &ctx.root);
> +	retval = get_path_anchor(mountdirfd, &ctx.root, f_handle.handle_type);
>  	if (retval)
>  		return retval;
>  
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 69b0541042b5..2ab9b47fbfae 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -747,7 +747,7 @@ static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>  
>  	*max_len = 2;
>  	*(u64 *)fh = pid->ino;
> -	return FILEID_KERNFS;
> +	return FILEID_PIDFS;
>  }
>  
>  static int pidfs_ino_find(const void *key, const struct rb_node *node)
> @@ -802,6 +802,8 @@ static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
>  		return NULL;
>  
>  	switch (fh_type) {
> +	case FILEID_PIDFS:
> +		fallthrough;
>  	case FILEID_KERNFS:
>  		pid_ino = *(u64 *)fid;
>  		break;
> @@ -860,6 +862,7 @@ static const struct export_operations pidfs_export_operations = {
>  	.fh_to_dentry	= pidfs_fh_to_dentry,
>  	.open		= pidfs_export_open,
>  	.permission	= pidfs_export_permission,
> +	.flags		= EXPORT_OP_AUTONOMOUS_HANDLES,
>  };
>  
>  static int pidfs_init_inode(struct inode *inode, void *data)
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

