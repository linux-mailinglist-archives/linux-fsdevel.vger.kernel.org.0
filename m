Return-Path: <linux-fsdevel+bounces-48977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11763AB704C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378FB1BA3CA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E678B1ACEDE;
	Wed, 14 May 2025 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHVubvXL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nT0uRQwh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHVubvXL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nT0uRQwh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B061AD51
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237758; cv=none; b=GmPWCYgE3ctxhvNwTVWVmRFmU6xbiwEv5xN97Kn2UuK3mxyy60gkm3ENmXuBww2ZKpEtASrRcMChLd+YuNLYTEgPxOFQWKOoOfTjAYCUiBBiNad3T8V+W7NpzYG8955FodCKzEqn2o205E2Wd6edRc8TXBjsImjAU35GCP8X9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237758; c=relaxed/simple;
	bh=FhdAueqti1NlhTl4gWm7yryBIES4PjCWfAd4CLSBlX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhrLGTCswJQweiPjT8gLc2u7pNKB0H8nFTweq0YMGkOHvA8pmHpGZAjHYaEUZWBJgNmh4T0iciITVFCZDR2QSD4xTmN2EE0SdimIFtgOlsxPjokS+SQ27Uu2sGxgO9orLwJmvanvX9n24MuHWmWXzqQ7Xs4slTPZ2XJU95cT7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHVubvXL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nT0uRQwh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHVubvXL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nT0uRQwh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 188141F38A;
	Wed, 14 May 2025 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747237753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VUSjwUF0ogi6Zo2eMyJc/05ugVw6k1oxXUKMq4TM34k=;
	b=HHVubvXL0zhka5JTMNAG/wZ0GV1pHGZtV7Arg31U+yuiAMos6tnn9MMpoOL9reKgP8zRmd
	TEu1EXB2tX6KX5LJNDjE/aq3kgmHr7T2Rw5EBeM9Ji09EXbNkxDTVLac7bcqHjKBQhSEh/
	r2XCH5A4g/HzunLh+hAwGtzre7shSPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747237753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VUSjwUF0ogi6Zo2eMyJc/05ugVw6k1oxXUKMq4TM34k=;
	b=nT0uRQwhxM5FDZm4QTJMqJkolrLskfz65v8GSaribFBDwHuUyaajlu2DrwNZLF6VM/mXOK
	Pashn8GJ/ySKwrAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HHVubvXL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nT0uRQwh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747237753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VUSjwUF0ogi6Zo2eMyJc/05ugVw6k1oxXUKMq4TM34k=;
	b=HHVubvXL0zhka5JTMNAG/wZ0GV1pHGZtV7Arg31U+yuiAMos6tnn9MMpoOL9reKgP8zRmd
	TEu1EXB2tX6KX5LJNDjE/aq3kgmHr7T2Rw5EBeM9Ji09EXbNkxDTVLac7bcqHjKBQhSEh/
	r2XCH5A4g/HzunLh+hAwGtzre7shSPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747237753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VUSjwUF0ogi6Zo2eMyJc/05ugVw6k1oxXUKMq4TM34k=;
	b=nT0uRQwhxM5FDZm4QTJMqJkolrLskfz65v8GSaribFBDwHuUyaajlu2DrwNZLF6VM/mXOK
	Pashn8GJ/ySKwrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04C5813306;
	Wed, 14 May 2025 15:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J/vQAHm7JGhAMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 14 May 2025 15:49:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9B42FA0A02; Wed, 14 May 2025 17:49:04 +0200 (CEST)
Date: Wed, 14 May 2025 17:49:04 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fanotify: support watching filesystems and mounts
 inside userns
Message-ID: <fsldmf3k4u5wi2k2su2z26nw7lmr4jonrt5caaiyt7fmpteqzg@xsu4cnaeu6oy>
References: <20250419100657.2654744-1-amir73il@gmail.com>
 <20250419100657.2654744-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419100657.2654744-3-amir73il@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 188141F38A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Sat 19-04-25 12:06:57, Amir Goldstein wrote:
> An unprivileged user is allowed to create an fanotify group and add
> inode marks, but not filesystem, mntns and mount marks.
> 
> Add limited support for setting up filesystem, mntns and mount marks by
> an unprivileged user under the following conditions:
> 
> 1.   User has CAP_SYS_ADMIN in the user ns where the group was created
> 2.a. User has CAP_SYS_ADMIN in the user ns where the filesystem was
>      mounted (implies FS_USERNS_MOUNT)
>   OR (in case setting up a mntns or mount mark)
> 2.b. User has CAP_SYS_ADMIN in the user ns associated with the mntns
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I'm sorry for the delay. Both patches look good to me but I'd like somebody
more versed with user namespaces to double check namespace checks in this
patch are indeed sound (so that we don't introduce some security issue).
Christian, can you have a look please?

								Honza

> ---
>  fs/notify/fanotify/fanotify.c      |  1 +
>  fs/notify/fanotify/fanotify_user.c | 36 +++++++++++++++++++++---------
>  include/linux/fanotify.h           |  5 ++---
>  include/linux/fsnotify_backend.h   |  1 +
>  4 files changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 6d386080faf2..060d9bee34bd 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -1009,6 +1009,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  
>  static void fanotify_free_group_priv(struct fsnotify_group *group)
>  {
> +	put_user_ns(group->user_ns);
>  	kfree(group->fanotify_data.merge_hash);
>  	if (group->fanotify_data.ucounts)
>  		dec_ucount(group->fanotify_data.ucounts,
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 471c57832357..b4255b661bda 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1499,6 +1499,7 @@ static struct hlist_head *fanotify_alloc_merge_hash(void)
>  /* fanotify syscalls */
>  SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  {
> +	struct user_namespace *user_ns = current_user_ns();
>  	struct fsnotify_group *group;
>  	int f_flags, fd;
>  	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
> @@ -1513,10 +1514,11 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  		/*
>  		 * An unprivileged user can setup an fanotify group with
>  		 * limited functionality - an unprivileged group is limited to
> -		 * notification events with file handles and it cannot use
> -		 * unlimited queue/marks.
> +		 * notification events with file handles or mount ids and it
> +		 * cannot use unlimited queue/marks.
>  		 */
> -		if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) || !fid_mode)
> +		if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
> +		    !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT)))
>  			return -EPERM;
>  
>  		/*
> @@ -1595,8 +1597,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	}
>  
>  	/* Enforce groups limits per user in all containing user ns */
> -	group->fanotify_data.ucounts = inc_ucount(current_user_ns(),
> -						  current_euid(),
> +	group->fanotify_data.ucounts = inc_ucount(user_ns, current_euid(),
>  						  UCOUNT_FANOTIFY_GROUPS);
>  	if (!group->fanotify_data.ucounts) {
>  		fd = -EMFILE;
> @@ -1605,6 +1606,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  
>  	group->fanotify_data.flags = flags | internal_flags;
>  	group->memcg = get_mem_cgroup_from_mm(current->mm);
> +	group->user_ns = get_user_ns(user_ns);
>  
>  	group->fanotify_data.merge_hash = fanotify_alloc_merge_hash();
>  	if (!group->fanotify_data.merge_hash) {
> @@ -1804,6 +1806,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	struct fsnotify_group *group;
>  	struct path path;
>  	struct fan_fsid __fsid, *fsid = NULL;
> +	struct user_namespace *user_ns = NULL;
>  	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
>  	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
>  	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
> @@ -1897,12 +1900,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	}
>  
>  	/*
> -	 * An unprivileged user is not allowed to setup mount nor filesystem
> -	 * marks.  This also includes setting up such marks by a group that
> -	 * was initialized by an unprivileged user.
> +	 * A user is allowed to setup sb/mount/mntns marks only if it is
> +	 * capable in the user ns where the group was created.
>  	 */
> -	if ((!capable(CAP_SYS_ADMIN) ||
> -	     FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&
> +	if (!ns_capable(group->user_ns, CAP_SYS_ADMIN) &&
>  	    mark_type != FAN_MARK_INODE)
>  		return -EPERM;
>  
> @@ -1987,12 +1988,27 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		obj = inode;
>  	} else if (obj_type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
>  		obj = path.mnt;
> +		user_ns = real_mount(obj)->mnt_ns->user_ns;
>  	} else if (obj_type == FSNOTIFY_OBJ_TYPE_SB) {
>  		obj = path.mnt->mnt_sb;
> +		user_ns = path.mnt->mnt_sb->s_user_ns;
>  	} else if (obj_type == FSNOTIFY_OBJ_TYPE_MNTNS) {
>  		obj = mnt_ns_from_dentry(path.dentry);
> +		user_ns = ((struct mnt_namespace *)obj)->user_ns;
>  	}
>  
> +	/*
> +	 * In addition to being capable in the user ns where group was created,
> +	 * the user also needs to be capable in the user ns associated with
> +	 * the marked filesystem (for FS_USERNS_MOUNT filesystems) or in the
> +	 * user ns associated with the mntns (when marking a mount or mntns).
> +	 * This is aligned with the required permissions to open_by_handle_at()
> +	 * a directory fid provided with the events.
> +	 */
> +	ret = -EPERM;
> +	if (user_ns && !ns_capable(user_ns, CAP_SYS_ADMIN))
> +		goto path_put_and_out;
> +
>  	ret = -EINVAL;
>  	if (!obj)
>  		goto path_put_and_out;
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 3c817dc6292e..879cff5eccd4 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -38,8 +38,7 @@
>  					 FAN_REPORT_PIDFD | \
>  					 FAN_REPORT_FD_ERROR | \
>  					 FAN_UNLIMITED_QUEUE | \
> -					 FAN_UNLIMITED_MARKS | \
> -					 FAN_REPORT_MNT)
> +					 FAN_UNLIMITED_MARKS)
>  
>  /*
>   * fanotify_init() flags that are allowed for user without CAP_SYS_ADMIN.
> @@ -48,7 +47,7 @@
>   * so one of the flags for reporting file handles is required.
>   */
>  #define FANOTIFY_USER_INIT_FLAGS	(FAN_CLASS_NOTIF | \
> -					 FANOTIFY_FID_BITS | \
> +					 FANOTIFY_FID_BITS | FAN_REPORT_MNT | \
>  					 FAN_CLOEXEC | FAN_NONBLOCK)
>  
>  #define FANOTIFY_INIT_FLAGS	(FANOTIFY_ADMIN_INIT_FLAGS | \
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index fc27b53c58c2..d4034ddaf392 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -250,6 +250,7 @@ struct fsnotify_group {
>  						 * full */
>  
>  	struct mem_cgroup *memcg;	/* memcg to charge allocations */
> +	struct user_namespace *user_ns;	/* user ns where group was created */
>  
>  	/* groups can define private fields here or use the void *private */
>  	union {
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

