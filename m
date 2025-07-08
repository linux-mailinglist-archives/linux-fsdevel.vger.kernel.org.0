Return-Path: <linux-fsdevel+bounces-54237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAE2AFC98B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 13:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7239C3B4720
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F01E2D8779;
	Tue,  8 Jul 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RnKi1Dp0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eA+ZSgNf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RnKi1Dp0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eA+ZSgNf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6579F9E8
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973966; cv=none; b=appVx/1c1llOaT1vweEeASWeJ6Z/c4I8ttTmqodKfPo4SGvOXwPvYU6QrmFNCwciDtyIno3++kO3fAKF11d9WlupwVgWk9IBFrxBO57g4JoHAZl5PsGQ7+Si9ATW5DotWnAL/kzMm3o6qQCzvAKI/6HSa9juwSjdcW2MBcAv5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973966; c=relaxed/simple;
	bh=w6i/0do/FxjaWnmDepNI9XKVL3Mar9p20k9dpOaIupA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdP1qkhDlKXiIwh6UsjNp9b7sqBhCIL0doFakuY6cKgHLaHcc+Uer3b3wjdeFHWmaO1GgNhRA4563HxAYPRwSSvA239u85NjbJWPENC2wx6PdDQFRe45XraeH6/gT8OJi9cUrGTOFBKB1x5rfjl2Sai+HZNrOaPvnpX2g8W1O8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RnKi1Dp0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eA+ZSgNf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RnKi1Dp0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eA+ZSgNf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 545001F390;
	Tue,  8 Jul 2025 11:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751973961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAcNR5hve3UXbk+1Ne3zvZfUmZvq73kJGQPIeeY3FYU=;
	b=RnKi1Dp0kYfTAgIM92S6w2RBENZwymm2cESRbGD+E/RNz6ZNE40Hr+PZ8aVUT8w7Yj7jJK
	1MyfJP3tmccDnkKo2ty2gwHunK+X7A+SQBdHm4Y2QOuUy1NsbAVo0G9TFqbaWfSMVgd+eE
	mL1uKfR7ECV1phOLsdQG5t36zc+N44U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751973961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAcNR5hve3UXbk+1Ne3zvZfUmZvq73kJGQPIeeY3FYU=;
	b=eA+ZSgNfnRRjl30dvwzc9ma+ddi0wbdU5wsC4CzF6mXNAo0DJm3hVV15bftwiJBK2whP98
	eAd0oqjKjLzrnoCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751973961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAcNR5hve3UXbk+1Ne3zvZfUmZvq73kJGQPIeeY3FYU=;
	b=RnKi1Dp0kYfTAgIM92S6w2RBENZwymm2cESRbGD+E/RNz6ZNE40Hr+PZ8aVUT8w7Yj7jJK
	1MyfJP3tmccDnkKo2ty2gwHunK+X7A+SQBdHm4Y2QOuUy1NsbAVo0G9TFqbaWfSMVgd+eE
	mL1uKfR7ECV1phOLsdQG5t36zc+N44U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751973961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAcNR5hve3UXbk+1Ne3zvZfUmZvq73kJGQPIeeY3FYU=;
	b=eA+ZSgNfnRRjl30dvwzc9ma+ddi0wbdU5wsC4CzF6mXNAo0DJm3hVV15bftwiJBK2whP98
	eAd0oqjKjLzrnoCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0689A13A54;
	Tue,  8 Jul 2025 11:26:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hks2AUkAbWjEDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Jul 2025 11:26:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 01F6CA098F; Tue,  8 Jul 2025 13:25:58 +0200 (CEST)
Date: Tue, 8 Jul 2025 13:25:58 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fsnotify: optimize FMODE_NONOTIFY_PERM for the
 common cases
Message-ID: <s2a5tw4bzb43jvqn6tzz4tkn4rllaul6xuukna6yglxh6rw7rj@qd5p47ylgyxm>
References: <20250707170704.303772-1-amir73il@gmail.com>
 <20250707170704.303772-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707170704.303772-3-amir73il@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 07-07-25 19:07:04, Amir Goldstein wrote:
> The most unlikely watched permission event is FAN_ACCESS_PERM, because
> at the time that it was introduced there were no evictable ignore mark,
> so subscribing to FAN_ACCESS_PERM would have incured a very high
> overhead.
> 
> Yet, when we set the fmode to FMODE_NOTIFY_HSM(), we never skip trying
> to send FAN_ACCESS_PERM, which is almost always a waste of cycles.
> 
> We got to this logic because of bundling open permisson events and access
> permission events in the same category and because FAN_OPEN_PERM is a
> commonly used event.
> 
> By open coding fsnotify_open_perm() in fsnotify_open_perm_and_set_mode(),
> we no longer need to regard FAN_OPEN*_PERM when calculating fmode.
> 
> This leaves the case of having pre-content events and not having access
> permission events in the object masks a more likely case than the other
> way around.
> 
> Rework the fmode macros and code so that their meaning now refers only
> to hooks on an already open file:
> 
> - FMODE_NOTIFY_NONE()	skip all events
> - FMODE_NOTIFY_PERM()	send all access permission events

I was a bit confused here but AFAIU you mean "send pre-content events and
FAN_ACCESS_PERM". And perhaps I'd call this macro
FMODE_NOTIFY_ACCESS_PERM() because that's the only place where it's going
to be used...

> - FMODE_NOTIFY_HSM()	send pre-conent permission events
				 ^^^ content
 

Otherwise neat trick, I like it. Some nitty comments below.

> @@ -683,45 +683,70 @@ int fsnotify_open_perm_and_set_mode(struct file *file)
>  	}
>  
>  	/*
> -	 * If there are permission event watchers but no pre-content event
> -	 * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate that.
> +	 * OK, there are some permission event watchers. Check if anybody is
> +	 * watching for permission events on *this* file.
>  	 */
> -	if ((!d_is_dir(dentry) && !d_is_reg(dentry)) ||
> -	    likely(!fsnotify_sb_has_priority_watchers(sb,
> -						FSNOTIFY_PRIO_PRE_CONTENT))) {
> -		file_set_fsnotify_mode(file, FMODE_NONOTIFY |
> -				       FMODE_NONOTIFY_PERM);
> +	mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
> +	p_mask = fsnotify_object_watched(d_inode(dentry), mnt_mask,
> +					 ALL_FSNOTIFY_PERM_EVENTS);
> +	if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
> +		parent = dget_parent(dentry);
> +		p_mask |= fsnotify_inode_watches_children(d_inode(parent));
> +		dput(parent);
> +	}
> +
> +	/*
> +	 * Without any access permission events, we only need to call the
> +	 * open perm hook and no further permission hooks on the open file.
> +	 * That is the common case with Anti-Malware protection service.
> +	 */
> +	if (likely(!(p_mask & FSNOTIFY_ACCESS_PERM_EVENTS))) {
> +		file_set_fsnotify_mode(file, FMODE_NONOTIFY_PERM);
>  		goto open_perm;
>  	}

Why is the above if needed? It seems to me all the cases are properly
handled below already? And they are very cheap to check...

>  	/*
> -	 * OK, there are some pre-content watchers. Check if anybody is
> -	 * watching for pre-content events on *this* file.
> +	 * Legacy FAN_ACCESS_PERM events have very high performance overhead,
> +	 * so unlikely to be used in the wild. If they are used there will be
> +	 * no optimizations at all.
>  	 */
> -	mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
> -	if (unlikely(fsnotify_object_watched(d_inode(dentry), mnt_mask,
> -				     FSNOTIFY_PRE_CONTENT_EVENTS))) {
> -		/* Enable pre-content events */
> +	if (unlikely(p_mask & FS_ACCESS_PERM)) {
> +		/* Enable all permission and pre-content events */
>  		file_set_fsnotify_mode(file, 0);
>  		goto open_perm;
>  	}
>  
> -	/* Is parent watching for pre-content events on this file? */
> -	if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
> -		parent = dget_parent(dentry);
> -		p_mask = fsnotify_inode_watches_children(d_inode(parent));
> -		dput(parent);
> -		if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS) {
> -			/* Enable pre-content events */
> -			file_set_fsnotify_mode(file, 0);
> -			goto open_perm;
> -		}
> +	/*
> +	 * Pre-content events are only supported on regular files.
> +	 * If there are pre-content event watchers and no permission access
> +	 * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate that.
> +	 * That is the common case with HSM service.
> +	 */
> +	if (d_is_reg(dentry) && (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)) {
> +		file_set_fsnotify_mode(file, FMODE_NONOTIFY |
> +					     FMODE_NONOTIFY_PERM);
> +		goto open_perm;
>  	}
> -	/* Nobody watching for pre-content events from this file */
> -	file_set_fsnotify_mode(file, FMODE_NONOTIFY | FMODE_NONOTIFY_PERM);
> +
> +	/* Nobody watching permission and pre-content events on this file */
> +	file_set_fsnotify_mode(file, FMODE_NONOTIFY_PERM);

<snip>

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 45fe8f833284..1d54d323d9de 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -205,7 +205,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>   *
>   * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
>   * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
> - * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only pre-content events.
> + * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - .. (excl. pre-content) events.
					     ^^ I'd write here "suppress
FAN_ACCESS_PERM" to be explicit what this is about.

> @@ -213,10 +213,10 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  #define FMODE_FSNOTIFY_NONE(mode) \
>  	((mode & FMODE_FSNOTIFY_MASK) == FMODE_NONOTIFY)
>  #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
> -#define FMODE_FSNOTIFY_PERM(mode) \
> +#define FMODE_FSNOTIFY_HSM(mode) \
>  	((mode & FMODE_FSNOTIFY_MASK) == 0 || \
>  	 (mode & FMODE_FSNOTIFY_MASK) == (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM))
> -#define FMODE_FSNOTIFY_HSM(mode) \
> +#define FMODE_FSNOTIFY_PERM(mode) \
>  	((mode & FMODE_FSNOTIFY_MASK) == 0)

As mentioned above I'd call this FMODE_FSNOTIFY_ACCESS_PERM().

> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 832d94d783d9..557f9b127960 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -87,14 +87,18 @@
>  /* Mount namespace events */
>  #define FSNOTIFY_MNT_EVENTS (FS_MNT_ATTACH | FS_MNT_DETACH)
>  
> +#define FSNOTIFY_OPEN_PERM_EVENTS    (FS_OPEN_PERM | FS_OPEN_EXEC_PERM)
>  /* Content events can be used to inspect file content */
> -#define FSNOTIFY_CONTENT_PERM_EVENTS (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | \
> +#define FSNOTIFY_CONTENT_PERM_EVENTS (FSNOTIFY_OPEN_PERM_EVENTS | \
>  				      FS_ACCESS_PERM)

You don't use FSNOTIFY_OPEN_PERM_EVENTS anywhere. If anything I'd drop
FSNOTIFY_CONTENT_PERM_EVENTS completely as that has only single use in
ALL_FSNOTIFY_PERM_EVENTS instead of adding more practically unused defines. 

>  /* Pre-content events can be used to fill file content */
>  #define FSNOTIFY_PRE_CONTENT_EVENTS  (FS_PRE_ACCESS)
>  
>  #define ALL_FSNOTIFY_PERM_EVENTS (FSNOTIFY_CONTENT_PERM_EVENTS | \
>  				  FSNOTIFY_PRE_CONTENT_EVENTS)
> +/* Access permission events determine FMODE_NONOTIFY_PERM mode */
> +#define FSNOTIFY_ACCESS_PERM_EVENTS (FS_ACCESS_PERM | \
> +				     FSNOTIFY_PRE_CONTENT_EVENTS)

I don't think this define is needed either so I'd drop it for now...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

