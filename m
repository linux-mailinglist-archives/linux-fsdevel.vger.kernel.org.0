Return-Path: <linux-fsdevel+bounces-24823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAB7945147
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 19:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9C21F24077
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DF51B9B29;
	Thu,  1 Aug 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sCYGKYnf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w0K4wJnW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sCYGKYnf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w0K4wJnW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B6113957B
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531892; cv=none; b=fbqJwJ7VgcnAYm1C/v5KhOxrFDdhjQ8IjqXW8lSHR7jCsQ7Od+PLrV6+weoNNaJrAU+luvs2j0SwEaH4c22wgvMxlIHQz84rhIfiPgqPfF/tg0hLRRI5rS+AFsT3E3aw+l6SpXjNX22o8nMeuMA33oYwl7CgnW+DN7hIE5vfuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531892; c=relaxed/simple;
	bh=hz+5VtTE7JRPJOD1DyruvSFvelA/sGATiTxeX6TsDSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN44cO4XFmc0gU2r2A50wSpdLq3UNS6BOI77h/h92jMyCGmP9EWTgdRmHm5u7knYAciUtkQ7WjQxMMb0BrXQDntWsQaAxAtlPg38ciiyx/HJoUBH5jsYX+mZzkGk2dzFTOtN7AMgQ6EcGWrP+j5BH+GwF+6Ge6aI7TaNGNlOXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sCYGKYnf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w0K4wJnW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sCYGKYnf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w0K4wJnW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 380F41FB46;
	Thu,  1 Aug 2024 17:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722531889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6cAo1QO0yiTnRk67UZQOUds27frRPjWTRTtayeO/9g=;
	b=sCYGKYnfZ0Z4Z0KBMd5gXYNTlsazDRM0VzYzDJUYxqYCH+xQuqX3WedJ/TWla4uk3KuSlZ
	ME6/ZPtIDtLk//23vwr8oGhgpQXUKPW4hqQQPoYmxsX910DA2iUcbnsMaE9WNzf2IVaxgd
	SSMKxi0oWzZiDvNfq2NH3qEhKVPqkx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722531889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6cAo1QO0yiTnRk67UZQOUds27frRPjWTRTtayeO/9g=;
	b=w0K4wJnWQotWOhQlmfPBVrKEjxPh/1i22Yj5nU8QKayy/u4Cfi1BWrkvU8XDpCqwjrUVuq
	vG15U6/6QcssfGAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722531889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6cAo1QO0yiTnRk67UZQOUds27frRPjWTRTtayeO/9g=;
	b=sCYGKYnfZ0Z4Z0KBMd5gXYNTlsazDRM0VzYzDJUYxqYCH+xQuqX3WedJ/TWla4uk3KuSlZ
	ME6/ZPtIDtLk//23vwr8oGhgpQXUKPW4hqQQPoYmxsX910DA2iUcbnsMaE9WNzf2IVaxgd
	SSMKxi0oWzZiDvNfq2NH3qEhKVPqkx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722531889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6cAo1QO0yiTnRk67UZQOUds27frRPjWTRTtayeO/9g=;
	b=w0K4wJnWQotWOhQlmfPBVrKEjxPh/1i22Yj5nU8QKayy/u4Cfi1BWrkvU8XDpCqwjrUVuq
	vG15U6/6QcssfGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EE7B136CF;
	Thu,  1 Aug 2024 17:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YVVBBzHAq2ZqMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Aug 2024 17:04:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AFBC7A08CB; Thu,  1 Aug 2024 19:04:48 +0200 (CEST)
Date: Thu, 1 Aug 2024 19:04:48 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 04/10] fanotify: introduce FAN_PRE_ACCESS permission event
Message-ID: <20240801170448.3h6z462wbbztfiyb@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <ad940e3ced8e15ef83667ec213780b3b4a09240f.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad940e3ced8e15ef83667ec213780b3b4a09240f.1721931241.git.josef@toxicpanda.com>
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Thu 25-07-24 14:19:41, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> Similar to FAN_ACCESS_PERM permission event, but it is only allowed with
> class FAN_CLASS_PRE_CONTENT and only allowed on regular files are dirs.
								^^ and

> Unlike FAN_ACCESS_PERM, it is safe to write to the file being accessed
> in the context of the event handler.
> 
> This pre-content event is meant to be used by hierarchical storage
> managers that want to fill the content of files on first read access.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Otherwise the patch looks good.

								Honza

> ---
>  fs/notify/fanotify/fanotify.c      |  3 ++-
>  fs/notify/fanotify/fanotify_user.c | 17 ++++++++++++++---
>  include/linux/fanotify.h           | 14 ++++++++++----
>  include/uapi/linux/fanotify.h      |  2 ++
>  4 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 224bccaab4cc..7dac8e4486df 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -910,8 +910,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
>  	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>  	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
> +	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 22);
>  
>  	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
>  					 mask, data, data_type, dir);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 2e2fba8a9d20..c294849e474f 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1628,6 +1628,7 @@ static int fanotify_events_supported(struct fsnotify_group *group,
>  				     unsigned int flags)
>  {
>  	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
> +	bool is_dir = d_is_dir(path->dentry);
>  	/* Strict validation of events in non-dir inode mask with v5.17+ APIs */
>  	bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
>  				 (mask & FAN_RENAME) ||
> @@ -1665,9 +1666,15 @@ static int fanotify_events_supported(struct fsnotify_group *group,
>  	 * but because we always allowed it, error only when using new APIs.
>  	 */
>  	if (strict_dir_events && mark_type == FAN_MARK_INODE &&
> -	    !d_is_dir(path->dentry) && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
> +	    !is_dir && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
>  		return -ENOTDIR;
>  
> +	/* Pre-content events are only supported on regular files and dirs */
> +	if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
> +		if (!is_dir && !d_is_reg(path->dentry))
> +			return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1769,11 +1776,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		goto fput_and_out;
>  
>  	/*
> -	 * Permission events require minimum priority FAN_CLASS_CONTENT.
> +	 * Permission events are not allowed for FAN_CLASS_NOTIF.
> +	 * Pre-content permission events are not allowed for FAN_CLASS_CONTENT.
>  	 */
>  	ret = -EINVAL;
>  	if (mask & FANOTIFY_PERM_EVENTS &&
> -	    group->priority < FSNOTIFY_PRIO_CONTENT)
> +	    group->priority == FSNOTIFY_PRIO_NORMAL)
> +		goto fput_and_out;
> +	else if (mask & FANOTIFY_PRE_CONTENT_EVENTS &&
> +		 group->priority == FSNOTIFY_PRIO_CONTENT)
>  		goto fput_and_out;
>  
>  	if (mask & FAN_FS_ERROR &&
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 4f1c4f603118..5c811baf44d2 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -88,6 +88,16 @@
>  #define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE | \
>  				 FAN_RENAME)
>  
> +/* Content events can be used to inspect file content */
> +#define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
> +				      FAN_ACCESS_PERM)
> +/* Pre-content events can be used to fill file content */
> +#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
> +
> +/* Events that require a permission response from user */
> +#define FANOTIFY_PERM_EVENTS	(FANOTIFY_CONTENT_PERM_EVENTS | \
> +				 FANOTIFY_PRE_CONTENT_EVENTS)
> +
>  /* Events that can be reported with event->fd */
>  #define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
>  
> @@ -103,10 +113,6 @@
>  				 FANOTIFY_INODE_EVENTS | \
>  				 FANOTIFY_ERROR_EVENTS)
>  
> -/* Events that require a permission response from user */
> -#define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
> -				 FAN_OPEN_EXEC_PERM)
> -
>  /* Extra flags that may be reported with event or control handling of events */
>  #define FANOTIFY_EVENT_FLAGS	(FAN_EVENT_ON_CHILD | FAN_ONDIR)
>  
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index a37de58ca571..3ae43867d318 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -26,6 +26,8 @@
>  #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
>  #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
>  
> +#define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
> +
>  #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
>  
>  #define FAN_RENAME		0x10000000	/* File was renamed */
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

