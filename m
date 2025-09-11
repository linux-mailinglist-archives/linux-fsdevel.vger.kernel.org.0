Return-Path: <linux-fsdevel+bounces-60919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C8B52E11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 12:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8297BBB28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 10:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002E430E0D1;
	Thu, 11 Sep 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WuKs3lkQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5eCY8HPF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WuKs3lkQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5eCY8HPF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C422578A
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585529; cv=none; b=pS0xrr3sLLbFMWFQgNgSeDk8RHtiwx2lEDTG8aR7LqdntVIRZk6U1QvV0r5zZzieBvbITpw4Yc2cCg7vSdOyGSIV989CE6gyJSlmGhJagpAkr24Bha4E8x64WhryUvvfPnoBy8uXSbL5eXf76N5jQpkUq/y0rszRwkfBng0lfVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585529; c=relaxed/simple;
	bh=Wq9kv36PXgeKaCw85qA4ZTD1AGdVRNL4OnMVsqjObEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukIdRu9m8LbWgINjJgr9e+7n7Oj1byZEDsuXtO2BhW+ejO3VJPigUXF1iHyVvoEn+DFYH4X+lqWADB5bRBIDyROzWuXQ/7XaB23t70RNXPEkCG6wdj/JmlDXdxFqmK3as9DIDh/Uypvo2U80kWwhaiOAAzMxQqSU4TgeZ2+zgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WuKs3lkQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5eCY8HPF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WuKs3lkQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5eCY8HPF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3423F223D6;
	Thu, 11 Sep 2025 10:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757585525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzrt736u1vSe3f3WN/AwT/UqJ3hJD7ktYO6uGpX03yQ=;
	b=WuKs3lkQCyG4Ud2gWnBi1IfnT2OAMl+0HjTZJKpJPEqeyzD2Hj8eCrJTTSpLNylev+8JYn
	kisHeKsBtXywemSeBSXtH1e/KsP8foVhqrHv6lnIzkLufFa/AN/Aw/4LzqovSl6fyeJl5t
	CN/HnHm2FfgE+i07/qkKCb9RplCFJjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757585525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzrt736u1vSe3f3WN/AwT/UqJ3hJD7ktYO6uGpX03yQ=;
	b=5eCY8HPFUfF+8vPQ+Sywmz1q/AOjqjEwRsw8kAe98cd7KTWd3JMuNuXJL5wI/D9IM3H3Eb
	1MzLunHcp6zGxVDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757585525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzrt736u1vSe3f3WN/AwT/UqJ3hJD7ktYO6uGpX03yQ=;
	b=WuKs3lkQCyG4Ud2gWnBi1IfnT2OAMl+0HjTZJKpJPEqeyzD2Hj8eCrJTTSpLNylev+8JYn
	kisHeKsBtXywemSeBSXtH1e/KsP8foVhqrHv6lnIzkLufFa/AN/Aw/4LzqovSl6fyeJl5t
	CN/HnHm2FfgE+i07/qkKCb9RplCFJjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757585525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzrt736u1vSe3f3WN/AwT/UqJ3hJD7ktYO6uGpX03yQ=;
	b=5eCY8HPFUfF+8vPQ+Sywmz1q/AOjqjEwRsw8kAe98cd7KTWd3JMuNuXJL5wI/D9IM3H3Eb
	1MzLunHcp6zGxVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 293C31372E;
	Thu, 11 Sep 2025 10:12:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YY4MCnWgwmhFFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Sep 2025 10:12:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DD0B3A0A2D; Thu, 11 Sep 2025 12:12:00 +0200 (CEST)
Date: Thu, 11 Sep 2025 12:12:00 +0200
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2] fanotify: add watchdog for permission events
Message-ID: <fyvzypw7ywz4mmqd7vtw34wa7k6gsicvtsjro5mnu6uggy2aeg@3e4p7l3q6gfm>
References: <20250909143053.112171-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909143053.112171-1-mszeredi@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 09-09-25 16:30:47, Miklos Szeredi wrote:
> This is to make it easier to debug issues with AV software, which time and
> again deadlocks with no indication of where the issue comes from, and the
> kernel being blamed for the deadlock.  Then we need to analyze dumps to
> prove that the kernel is not in fact at fault.
> 
> The deadlock comes from recursion: handling the event triggers another
> permission event, in some roundabout way, obviously, otherwise it would
> have been found in testing.
> 
> With this patch a warning is printed when permission event is received by
> userspace but not answered for more than the timeout specified in
> /proc/sys/fs/fanotify/watchdog_timeout.  The watchdog can be turned off by
> setting the timeout to zero (which is the default).
> 
> The timeout is very coarse (T <= t < 2T) but I guess it's good enough for
> the purpose.
> 
> Overhead should be minimal.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Overall looks good. Just some nits below, I'll fix them up on commit if you
won't object.

> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index b78308975082..1a007e211bae 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -437,11 +437,13 @@ FANOTIFY_ME(struct fanotify_event *event)
>  struct fanotify_perm_event {
>  	struct fanotify_event fae;
>  	struct path path;
> -	const loff_t *ppos;		/* optional file range info */
> +	const loff_t *ppos;	/* optional file range info */

Stray modification.

>  	size_t count;
>  	u32 response;			/* userspace answer to the event */
>  	unsigned short state;		/* state of the event */
> +	unsigned short watchdog_cnt;	/* already scanned by watchdog? */
>  	int fd;		/* fd we passed to userspace for this event */
> +	pid_t recv_pid;	/* pid of task receiving the event */
>  	union {
>  		struct fanotify_response_info_header hdr;
>  		struct fanotify_response_info_audit_rule audit_rule;
...
> @@ -95,6 +104,84 @@ static void __init fanotify_sysctls_init(void)
>  #define fanotify_sysctls_init() do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>  
> +static LIST_HEAD(perm_group_list);
> +static DEFINE_SPINLOCK(perm_group_lock);
> +static void perm_group_watchdog(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(perm_group_work, perm_group_watchdog);
> +
> +static void perm_group_watchdog_schedule(void)
> +{
> +	schedule_delayed_work(&perm_group_work, secs_to_jiffies(perm_group_timeout));
> +}
> +
> +static void perm_group_watchdog(struct work_struct *work)
> +{
> +	struct fsnotify_group *group;
> +	struct fanotify_perm_event *event;
> +	struct task_struct *task;
> +	pid_t failed_pid = 0;
> +
> +	guard(spinlock)(&perm_group_lock);
> +	if (list_empty(&perm_group_list))
> +		return;
> +
> +	list_for_each_entry(group, &perm_group_list, fanotify_data.perm_group) {
> +		/*
> +		 * Ok to test without lock, racing with an addition is
> +		 * fine, will deal with it next round
> +		 */
> +		if (list_empty(&group->fanotify_data.access_list))
> +			continue;
> +
> +		scoped_guard(spinlock, &group->notification_lock) {

Frankly, I don't see the scoped guard bringing benefit here. It just shifts
indentation level by 1 which makes some of the lines below longer than I
like :)

> +			list_for_each_entry(event, &group->fanotify_data.access_list, fae.fse.list) {
> +				if (likely(event->watchdog_cnt == 0)) {
> +					event->watchdog_cnt = 1;
> +				} else if (event->watchdog_cnt == 1) {
> +					/* Report on event only once */
> +					event->watchdog_cnt = 2;
> +
> +					/* Do not report same pid repeatedly */
> +					if (event->recv_pid == failed_pid)
> +						continue;
> +
> +					failed_pid = event->recv_pid;
> +					rcu_read_lock();
> +					task = find_task_by_pid_ns(event->recv_pid, &init_pid_ns);
> +					pr_warn_ratelimited("PID %u (%s) failed to respond to fanotify queue for more than %i seconds\n",

Use %d instead of %i here? IMHO we use %d everywhere in the kernel. I had
to look up whether %i is really signed int.

> +							    event->recv_pid, task ? task->comm : NULL, perm_group_timeout);
> +					rcu_read_unlock();
> +				}
> +			}

I'm wondering if we should cond_resched() somewhere in these loops. There
could be *many* events pending... OTOH continuing the iteration afterwards
would be non-trivial so probably let's keep our fingers crossed that
softlockups won't trigger...

> +		}
> +	}
> +	perm_group_watchdog_schedule();
> +}
> +
> +static void fanotify_perm_watchdog_group_remove(struct fsnotify_group *group)
> +{
> +	if (!list_empty(&group->fanotify_data.perm_group)) {
> +		/* Perm event watchdog can no longer scan this group. */
> +		spin_lock(&perm_group_lock);
> +		list_del(&group->fanotify_data.perm_group);

list_del_init() here would give me a better peace of mind... It's not like
the performance matters here.

> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index d4034ddaf392..7f7fe4f3aa34 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -273,6 +273,8 @@ struct fsnotify_group {
>  			int f_flags; /* event_f_flags from fanotify_init() */
>  			struct ucounts *ucounts;
>  			mempool_t error_events_pool;
> +			/* chained on perm_group_list */
> +			struct list_head perm_group;

Can we call this perm_group_list, perm_list or simply something with 'list'
in the name, please? We follow this naming convention throughout the
fsnotify subsystem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

