Return-Path: <linux-fsdevel+bounces-48222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 606D6AAC1D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 12:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E6C1C221BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84710278776;
	Tue,  6 May 2025 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r32AZo6z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="npHbnoms";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r32AZo6z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="npHbnoms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D32B20C028
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529060; cv=none; b=tivG7DLXkO4AAiL6NGfy8rzvn17eareNoF0hYJ+YORBsKl5+ZfAWxl6pqVO5juphtMIQXS7O20rQ5MJpkEnFs4H9VOVZN8yVXQntquntvudmE7+FA91PxGkM/58q78uq5cQ3Va3j1pvueT7M9ZnItbyOGhcJ1SI8t86IdUfOIP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529060; c=relaxed/simple;
	bh=KqiV6QkyfLhB2kxSzwViFrXIaJ8BtZKPBiE3Q0qGO7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iskVhaevaeqfZkeWF5dHKvEp3gtO7far5Dog9tzpxoLk+7IfriPd5hk2D8t2xirC2AKvRX+qd+DFWnqgzc1JmbxGUBPGKVVAqq8/+e05/yO9GhUxgFJyxkd15RtKyvF0gPxOE3iHgVkkOYLZbGae7+ErZXsKwIM1EvrB8StgXBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r32AZo6z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=npHbnoms; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r32AZo6z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=npHbnoms; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 504F7211F4;
	Tue,  6 May 2025 10:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746529056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAaO3bOM6nlbRoiQwQi9a+Pz4/M38rK9aYVsxd4Rpbo=;
	b=r32AZo6z1oSsmJQVWqlliShVGolzBAG2d1i2If7TdB368way5nEzKPbUQMFVet0YBXACKA
	fjZ6GNIp2mUvYOxKt8kaHz+3GnWJdhXFddrXiAprxdYibxOuQO757Aug1R3jJORitQq8kR
	zmuzI0A75sf3hSV0Cn/+GaPvXiXEAeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746529056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAaO3bOM6nlbRoiQwQi9a+Pz4/M38rK9aYVsxd4Rpbo=;
	b=npHbnomsj3MCQgI+lbayh6tV2hB34GwGecrJuEuhPPH6lM9puyat9vQGerKQkvFvKuhyf2
	h2KVQQ3Xx1Nh9jCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746529056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAaO3bOM6nlbRoiQwQi9a+Pz4/M38rK9aYVsxd4Rpbo=;
	b=r32AZo6z1oSsmJQVWqlliShVGolzBAG2d1i2If7TdB368way5nEzKPbUQMFVet0YBXACKA
	fjZ6GNIp2mUvYOxKt8kaHz+3GnWJdhXFddrXiAprxdYibxOuQO757Aug1R3jJORitQq8kR
	zmuzI0A75sf3hSV0Cn/+GaPvXiXEAeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746529056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAaO3bOM6nlbRoiQwQi9a+Pz4/M38rK9aYVsxd4Rpbo=;
	b=npHbnomsj3MCQgI+lbayh6tV2hB34GwGecrJuEuhPPH6lM9puyat9vQGerKQkvFvKuhyf2
	h2KVQQ3Xx1Nh9jCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40D2613687;
	Tue,  6 May 2025 10:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1G3ODyDrGWgVDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 May 2025 10:57:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E034CA09BE; Tue,  6 May 2025 12:57:35 +0200 (CEST)
Date: Tue, 6 May 2025 12:57:35 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] kill vfs_submount()
Message-ID: <raihngvxu7ffs44sgnswzjkqohthx64o6oybshba6v6amqtg65@2zm27vcp3qfr>
References: <20250503212925.GZ2023217@ZenIV>
 <utebik76wcdgaspk7sjzb3aedmlcwbmwj3olur45zuycbpapjc@pd5rhnudxb35>
 <20250505213829.GI2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505213829.GI2023217@ZenIV>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 05-05-25 22:38:29, Al Viro wrote:
> On Mon, May 05, 2025 at 12:55:34PM +0200, Jan Kara wrote:
> > >  	if (!type)
> > >  		return NULL;
> > > -	mnt = vfs_submount(mntpt, type, "tracefs", NULL);
> > > +
> > > +	fc = fs_context_for_submount(type, mntpt);
> > > +	if (IS_ERR(fc))
> > > +		return ERR_CAST(fc);
> > 
> > Missing put_filesystem() here?
> 
> Actually, I'd rather have it done unconditionally right after
> fc_context_for_submount() - fs_context allocation grabs
> a reference and it's held until put_fs_context, so...
> 
> [PATCH] kill vfs_submount()
>     
> The last remaining user of vfs_submount() (tracefs) is easy to convert
> to fs_context_for_submount(); do that and bury that thing, along with
> SB_SUBMOUNT
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Indeed this works as well. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 018e95fe5459..0577a9fb6050 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1329,21 +1329,6 @@ struct vfsmount *vfs_kern_mount(struct file_system_type *type,
>  }
>  EXPORT_SYMBOL_GPL(vfs_kern_mount);
>  
> -struct vfsmount *
> -vfs_submount(const struct dentry *mountpoint, struct file_system_type *type,
> -	     const char *name, void *data)
> -{
> -	/* Until it is worked out how to pass the user namespace
> -	 * through from the parent mount to the submount don't support
> -	 * unprivileged mounts with submounts.
> -	 */
> -	if (mountpoint->d_sb->s_user_ns != &init_user_ns)
> -		return ERR_PTR(-EPERM);
> -
> -	return vfs_kern_mount(type, SB_SUBMOUNT, name, data);
> -}
> -EXPORT_SYMBOL_GPL(vfs_submount);
> -
>  static struct mount *clone_mnt(struct mount *old, struct dentry *root,
>  					int flag)
>  {
> diff --git a/fs/super.c b/fs/super.c
> index 97a17f9d9023..1886e4c930e0 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -823,13 +823,6 @@ struct super_block *sget(struct file_system_type *type,
>  	struct super_block *old;
>  	int err;
>  
> -	/* We don't yet pass the user namespace of the parent
> -	 * mount through to here so always use &init_user_ns
> -	 * until that changes.
> -	 */
> -	if (flags & SB_SUBMOUNT)
> -		user_ns = &init_user_ns;
> -
>  retry:
>  	spin_lock(&sb_lock);
>  	if (test) {
> @@ -849,7 +842,7 @@ struct super_block *sget(struct file_system_type *type,
>  	}
>  	if (!s) {
>  		spin_unlock(&sb_lock);
> -		s = alloc_super(type, (flags & ~SB_SUBMOUNT), user_ns);
> +		s = alloc_super(type, flags, user_ns);
>  		if (!s)
>  			return ERR_PTR(-ENOMEM);
>  		goto retry;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..515e702d98ae 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1240,7 +1240,6 @@ extern int send_sigurg(struct file *file);
>  /* These sb flags are internal to the kernel */
>  #define SB_DEAD         BIT(21)
>  #define SB_DYING        BIT(24)
> -#define SB_SUBMOUNT     BIT(26)
>  #define SB_FORCE        BIT(27)
>  #define SB_NOSEC        BIT(28)
>  #define SB_BORN         BIT(29)
> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index dcc17ce8a959..d4eb90a367af 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -98,9 +98,6 @@ extern struct vfsmount *vfs_create_mount(struct fs_context *fc);
>  extern struct vfsmount *vfs_kern_mount(struct file_system_type *type,
>  				      int flags, const char *name,
>  				      void *data);
> -extern struct vfsmount *vfs_submount(const struct dentry *mountpoint,
> -				     struct file_system_type *type,
> -				     const char *name, void *data);
>  
>  extern void mnt_set_expiry(struct vfsmount *mnt, struct list_head *expiry_list);
>  extern void mark_mounts_for_expiry(struct list_head *mounts);
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e22aacb0028a..936a615e8c56 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -51,6 +51,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/sort.h>
>  #include <linux/io.h> /* vmap_page_range() */
> +#include <linux/fs_context.h>
>  
>  #include <asm/setup.h> /* COMMAND_LINE_SIZE */
>  
> @@ -10075,6 +10076,8 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
>  {
>  	struct vfsmount *mnt;
>  	struct file_system_type *type;
> +	struct fs_context *fc;
> +	int ret;
>  
>  	/*
>  	 * To maintain backward compatibility for tools that mount
> @@ -10084,10 +10087,20 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
>  	type = get_fs_type("tracefs");
>  	if (!type)
>  		return NULL;
> -	mnt = vfs_submount(mntpt, type, "tracefs", NULL);
> +
> +	fc = fs_context_for_submount(type, mntpt);
>  	put_filesystem(type);
> -	if (IS_ERR(mnt))
> -		return NULL;
> +	if (IS_ERR(fc))
> +		return ERR_CAST(fc);
> +
> +	ret = vfs_parse_fs_string(fc, "source",
> +				  "tracefs", strlen("tracefs"));
> +	if (!ret)
> +		mnt = fc_mount(fc);
> +	else
> +		mnt = ERR_PTR(ret);
> +
> +	put_fs_context(fc);
>  	return mnt;
>  }
>  
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

