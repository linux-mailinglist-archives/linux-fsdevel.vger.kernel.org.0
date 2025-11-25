Return-Path: <linux-fsdevel+bounces-69781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D28BFC84EF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 13:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 569EA34843C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2F031A801;
	Tue, 25 Nov 2025 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rNdYFT44";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SuSkvEVx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rNdYFT44";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SuSkvEVx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870A7221F06
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072841; cv=none; b=ByO3OKuinp5w4v7Ixjp8VvR0/leicEL7uMPMt59lfH5T2ww5vYXgCEMl4SAvt2iN2bssb1i/vomFwin3xZvH0QZZn/lPRPvQqr/rENXlHSzBGiCN9dLTqAfOp7oEdnFoWQaWh2EmYRrcfBOAoAh5JHlJGTkCUDhNRUcRgNpnp5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072841; c=relaxed/simple;
	bh=uF/FOu1jS4o9rvuFCo6cCVEv4INKB6C0M4+q3uYSi1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlvuK6f++s4CDMdcY+9MWe2RyXJLZdkoYGCJ10z74wCvSlB9b1I/+934oRzjZx8Irl04brZ2VxDSeSoRN6jNpuBjomrn7/M9wjxPCb0Ma8yFHpXiersMBC9CJYNF7egMQiQgiZSbqvvlV8lLICe9clj+OlXxSBV+M8v+7Nydio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rNdYFT44; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SuSkvEVx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rNdYFT44; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SuSkvEVx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7023122833;
	Tue, 25 Nov 2025 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764072837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Kz8yzEj0oZuXUt/JteBW0t2Frr6zGoxVmLTC7P/clI=;
	b=rNdYFT44sjHEAIQ4q8tBF22SeD1costZq2/iMzLAbIBVICEfP0RO5LYHr+cvmrAm3ISvJl
	6hZj5ff9jg4hRzsREkgOCbYljf4ORz13mr79ZZ4Tpd5A/aCyM/l85maXE7LE2mp7eg8huu
	FqW8cOe5vphPKe3CThmhGVuixnRyi/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764072837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Kz8yzEj0oZuXUt/JteBW0t2Frr6zGoxVmLTC7P/clI=;
	b=SuSkvEVxuB4elM+YdRvkU6A4dAgjrUDAdGkmpwcoLCjM890C4ewHeNdthwJT0Chb8EWmr7
	Ae1ji8oxq7W6xXDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764072837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Kz8yzEj0oZuXUt/JteBW0t2Frr6zGoxVmLTC7P/clI=;
	b=rNdYFT44sjHEAIQ4q8tBF22SeD1costZq2/iMzLAbIBVICEfP0RO5LYHr+cvmrAm3ISvJl
	6hZj5ff9jg4hRzsREkgOCbYljf4ORz13mr79ZZ4Tpd5A/aCyM/l85maXE7LE2mp7eg8huu
	FqW8cOe5vphPKe3CThmhGVuixnRyi/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764072837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Kz8yzEj0oZuXUt/JteBW0t2Frr6zGoxVmLTC7P/clI=;
	b=SuSkvEVxuB4elM+YdRvkU6A4dAgjrUDAdGkmpwcoLCjM890C4ewHeNdthwJT0Chb8EWmr7
	Ae1ji8oxq7W6xXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 641013EA63;
	Tue, 25 Nov 2025 12:13:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SbxgGIWdJWnqXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Nov 2025 12:13:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 18A12A0C7D; Tue, 25 Nov 2025 13:13:57 +0100 (CET)
Date: Tue, 25 Nov 2025 13:13:57 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 08/47] fanotify: convert fanotify_init() to
 FD_PREPARE()
Message-ID: <nwv4dvazs2cr3qijh3wgxs6q434fhgyiabst5lxh66blacm6ex@xt7k6p3m2sck>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-8-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-work-fd-prepare-v4-8-b6efa1706cfd@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,kernel.org,gmail.com,kernel.dk];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Sun 23-11-25 17:33:26, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/notify/fanotify/fanotify_user.c | 60 ++++++++++++++------------------------
>  1 file changed, 22 insertions(+), 38 deletions(-)

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 1dadda82cae5..be0a96ad4316 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1597,16 +1597,20 @@ static struct hlist_head *fanotify_alloc_merge_hash(void)
>  	return hash;
>  }
>  
> +DEFINE_CLASS(fsnotify_group,
> +	      struct fsnotify_group *,
> +	      if (_T) fsnotify_destroy_group(_T),
> +	      fsnotify_alloc_group(ops, flags),
> +	      const struct fsnotify_ops *ops, int flags)
> +
>  /* fanotify syscalls */
>  SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  {
>  	struct user_namespace *user_ns = current_user_ns();
> -	struct fsnotify_group *group;
>  	int f_flags, fd;
>  	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
>  	unsigned int class = flags & FANOTIFY_CLASS_BITS;
>  	unsigned int internal_flags = 0;
> -	struct file *file;
>  
>  	pr_debug("%s: flags=%x event_f_flags=%x\n",
>  		 __func__, flags, event_f_flags);
> @@ -1690,36 +1694,29 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	if (flags & FAN_NONBLOCK)
>  		f_flags |= O_NONBLOCK;
>  
> -	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
> -	group = fsnotify_alloc_group(&fanotify_fsnotify_ops,
> +	CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops,
>  				     FSNOTIFY_GROUP_USER);
> -	if (IS_ERR(group)) {
> +	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
> +	if (IS_ERR(group))
>  		return PTR_ERR(group);
> -	}
>  
>  	/* Enforce groups limits per user in all containing user ns */
>  	group->fanotify_data.ucounts = inc_ucount(user_ns, current_euid(),
>  						  UCOUNT_FANOTIFY_GROUPS);
> -	if (!group->fanotify_data.ucounts) {
> -		fd = -EMFILE;
> -		goto out_destroy_group;
> -	}
> +	if (!group->fanotify_data.ucounts)
> +		return -EMFILE;
>  
>  	group->fanotify_data.flags = flags | internal_flags;
>  	group->memcg = get_mem_cgroup_from_mm(current->mm);
>  	group->user_ns = get_user_ns(user_ns);
>  
>  	group->fanotify_data.merge_hash = fanotify_alloc_merge_hash();
> -	if (!group->fanotify_data.merge_hash) {
> -		fd = -ENOMEM;
> -		goto out_destroy_group;
> -	}
> +	if (!group->fanotify_data.merge_hash)
> +		return -ENOMEM;
>  
>  	group->overflow_event = fanotify_alloc_overflow_event();
> -	if (unlikely(!group->overflow_event)) {
> -		fd = -ENOMEM;
> -		goto out_destroy_group;
> -	}
> +	if (unlikely(!group->overflow_event))
> +		return -ENOMEM;
>  
>  	if (force_o_largefile())
>  		event_f_flags |= O_LARGEFILE;
> @@ -1738,8 +1735,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  		group->priority = FSNOTIFY_PRIO_PRE_CONTENT;
>  		break;
>  	default:
> -		fd = -EINVAL;
> -		goto out_destroy_group;
> +		return -EINVAL;
>  	}
>  
>  	BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
> @@ -1750,27 +1746,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	}
>  
>  	if (flags & FAN_ENABLE_AUDIT) {
> -		fd = -EPERM;
>  		if (!capable(CAP_AUDIT_WRITE))
> -			goto out_destroy_group;
> -	}
> -
> -	fd = get_unused_fd_flags(f_flags);
> -	if (fd < 0)
> -		goto out_destroy_group;
> -
> -	file = anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, group,
> -					f_flags, FMODE_NONOTIFY);
> -	if (IS_ERR(file)) {
> -		put_unused_fd(fd);
> -		fd = PTR_ERR(file);
> -		goto out_destroy_group;
> +			return -EPERM;
>  	}
> -	fd_install(fd, file);
> -	return fd;
>  
> -out_destroy_group:
> -	fsnotify_destroy_group(group);
> +	fd = FD_ADD(f_flags,
> +		    anon_inode_getfile_fmode("[fanotify]", &fanotify_fops,
> +					     group, f_flags, FMODE_NONOTIFY));
> +	if (fd >= 0)
> +		retain_and_null_ptr(group);
>  	return fd;
>  }
>  
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

