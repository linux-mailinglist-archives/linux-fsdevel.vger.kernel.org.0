Return-Path: <linux-fsdevel+bounces-68209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A776C5728A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 12:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A633A2642
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 11:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BCF33B96C;
	Thu, 13 Nov 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tEx0PXpS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LOUAPU0D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TPAANJvU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IMDALd4J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114F2D7813
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032787; cv=none; b=OUdNaxoYuJ96GL5Gg1B9sU3mRNU12et1RCq/QrwnD7lBk+LUkl5Kmbu4AApkofqb6rXGVmaWCACvi3NRmcuKLOZS/A8BhGlwpK3NW2yzWmS3GzqsKkvhfbqk1+J5Bs2w8e2I78ffvX1vCcmBC/W6C44hl8CqGAbSEuuEDr07C4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032787; c=relaxed/simple;
	bh=3rFO83tVJVFEQkZ468DFpQrekAqbDzV1/0JoUWHKE0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aq9pRCQeI0RYA3avYvqrt/j91OLZfL8Pn5D5f+WBg6C5sRfvraqd8SNUsWPWK1vjNC2vSTlcyJCDPerH3gbzbDvQJPv1O7vlKwwgViLScZh/7t6q3USfMYHpwCEthWFU2WWoc2zSatBOr9Lq/G++w+ThZGBi0TpGW8JYy+WsTlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tEx0PXpS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LOUAPU0D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TPAANJvU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IMDALd4J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B45DC21281;
	Thu, 13 Nov 2025 11:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763032782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lczhD1MzObRMKndPkZG3oPhNpz/T85+A7Y0PvHv3zA4=;
	b=tEx0PXpSR9fC2UvG0u7MJFp2BSlhdeqm6tfjJPlZS4pzGQmOwabgT+ii7BsgRYsefYOMF3
	VvsJYx6JmgiNnIkc2NCbUzK9WMs4Iesgm99E+qFwo8H8q29+lEmIo9rS5V2MjR+2UAS7Qp
	XFnzrWjacC8RlMPSp7qTqHvuw+qVCws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763032782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lczhD1MzObRMKndPkZG3oPhNpz/T85+A7Y0PvHv3zA4=;
	b=LOUAPU0DI5ldL7amV9RP5y5ZRcrOsqlJWe+yGqm+w1F5fGBdUOw3+MjMsiQwLq6RLZlsah
	z1b+3BWuTShjlLBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TPAANJvU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IMDALd4J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763032780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lczhD1MzObRMKndPkZG3oPhNpz/T85+A7Y0PvHv3zA4=;
	b=TPAANJvULtvZbKY9kTlFDj3fHaqwcTQ7QSHepORPj1SmGNXAVQl+h4cThVAzOE6Yl7BCLK
	P+mNsKLJnjLZvTwsl3qRAtpBElJ625a6hag5mPaMbQZLS4fmnximef6W0ci53Jrf6gupH/
	2n45l6UZt9TFhva3h8X/wtCXAWukFSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763032780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lczhD1MzObRMKndPkZG3oPhNpz/T85+A7Y0PvHv3zA4=;
	b=IMDALd4JeMlPI9Mxv0/hWb4imPPdPuOJsIg/iIEqAN8lny7MqpgtZO9x5EjyCnO6vYkjJ5
	0uFVDgatEsam+WBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A65493EA61;
	Thu, 13 Nov 2025 11:19:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2zOKKMy+FWnVYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Nov 2025 11:19:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 63A30A0976; Thu, 13 Nov 2025 12:19:40 +0100 (CET)
Date: Thu, 13 Nov 2025 12:19:40 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, bpf@vger.kernel.org, bsegall@google.com, david@redhat.com, 
	dietmar.eggemann@arm.com, jack@suse.cz, jsavitz@redhat.com, juri.lelli@redhat.com, 
	kartikey406@gmail.com, kees@kernel.org, liam.howlett@oracle.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com, 
	mingo@redhat.com, mjguzik@gmail.com, oleg@redhat.com, paul@paul-moore.com, 
	peterz@infradead.org, rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com, 
	syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com
Subject: Re: [PATCH] nsproxy: fix free_nsproxy() and simplify
 create_new_namespaces()
Message-ID: <3yjawi3c72ieiss7ivefckuua55e2yvo55z4m4ykp2pzw2snpa@ym34e3d7cnoi>
References: <691360cc.a70a0220.22f260.013e.GAE@google.com>
 <20251111-sakralbau-guthaben-7dcc277d337f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111-sakralbau-guthaben-7dcc277d337f@brauner>
X-Rspamd-Queue-Id: B45DC21281
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[35];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim,appspotmail.com:email];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,linux-foundation.org,vger.kernel.org,google.com,redhat.com,arm.com,suse.cz,gmail.com,kernel.org,oracle.com,kvack.org,suse.de,suse.com,paul-moore.com,infradead.org,goodmis.org,googlegroups.com,linaro.org,zeniv.linux.org.uk];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,appspotmail.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[0a8655a80e189278487e,0b2e79f91ff6579bfa5b];
	R_RATELIMIT(0.00)[to_ip_from(RLuhuubkxd663ptcywq6p8zkwd)];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 

On Tue 11-11-25 22:29:44, Christian Brauner wrote:
> Make it possible to handle NULL being passed to the reference count
> helpers instead of forcing the caller to handle this. Afterwards we can
> nicely allow a cleanup guard to handle nsproxy freeing.
> 
> Active reference count handling is not done in nsproxy_free() but rather
> in free_nsproxy() as nsproxy_free() is also called from setns() failure
> paths where a new nsproxy has been prepared but has not been marked as
> active via switch_task_namespaces().
> 
> Fixes: 3c9820d5c64a ("ns: add active reference count")
> Reported-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
> Reported-by: syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/690bfb9e.050a0220.2e3c35.0013.GAE@google.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>

I believe having free_nsproxy() and nsproxy_free() functions with
the same signature and slightly different semantics is making things too
easy to get wrong. Maybe call free_nsproxy() say deactivate_nsproxy()?

Otherwise the patch looks correct to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/ns_common.h |  11 ++--
>  kernel/nsproxy.c          | 107 +++++++++++++++-----------------------
>  2 files changed, 48 insertions(+), 70 deletions(-)
> 
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index 136f6a322e53..825f5865bfc5 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -114,11 +114,14 @@ static __always_inline __must_check bool __ns_ref_dec_and_lock(struct ns_common
>  }
>  
>  #define ns_ref_read(__ns) __ns_ref_read(to_ns_common((__ns)))
> -#define ns_ref_inc(__ns) __ns_ref_inc(to_ns_common((__ns)))
> -#define ns_ref_get(__ns) __ns_ref_get(to_ns_common((__ns)))
> -#define ns_ref_put(__ns) __ns_ref_put(to_ns_common((__ns)))
> +#define ns_ref_inc(__ns) \
> +	do { if (__ns) __ns_ref_inc(to_ns_common((__ns))); } while (0)
> +#define ns_ref_get(__ns) \
> +	((__ns) ? __ns_ref_get(to_ns_common((__ns))) : false)
> +#define ns_ref_put(__ns) \
> +	((__ns) ? __ns_ref_put(to_ns_common((__ns))) : false)
>  #define ns_ref_put_and_lock(__ns, __ns_lock) \
> -	__ns_ref_dec_and_lock(to_ns_common((__ns)), __ns_lock)
> +	((__ns) ? __ns_ref_dec_and_lock(to_ns_common((__ns)), __ns_lock) : false)
>  
>  #define ns_ref_active_read(__ns) \
>  	((__ns) ? __ns_ref_active_read(to_ns_common(__ns)) : 0)
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index 94c2cfe0afa1..2c94452dc793 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -60,6 +60,27 @@ static inline struct nsproxy *create_nsproxy(void)
>  	return nsproxy;
>  }
>  
> +static inline void nsproxy_free(struct nsproxy *ns)
> +{
> +	put_mnt_ns(ns->mnt_ns);
> +	put_uts_ns(ns->uts_ns);
> +	put_ipc_ns(ns->ipc_ns);
> +	put_pid_ns(ns->pid_ns_for_children);
> +	put_time_ns(ns->time_ns);
> +	put_time_ns(ns->time_ns_for_children);
> +	put_cgroup_ns(ns->cgroup_ns);
> +	put_net(ns->net_ns);
> +	kmem_cache_free(nsproxy_cachep, ns);
> +}
> +
> +DEFINE_FREE(nsproxy_free, struct nsproxy *, if (_T) nsproxy_free(_T))
> +
> +void free_nsproxy(struct nsproxy *ns)
> +{
> +	nsproxy_ns_active_put(ns);
> +	nsproxy_free(ns);
> +}
> +
>  /*
>   * Create new nsproxy and all of its the associated namespaces.
>   * Return the newly created nsproxy.  Do not attach this to the task,
> @@ -69,76 +90,45 @@ static struct nsproxy *create_new_namespaces(u64 flags,
>  	struct task_struct *tsk, struct user_namespace *user_ns,
>  	struct fs_struct *new_fs)
>  {
> -	struct nsproxy *new_nsp;
> -	int err;
> +	struct nsproxy *new_nsp __free(nsproxy_free) = NULL;
>  
>  	new_nsp = create_nsproxy();
>  	if (!new_nsp)
>  		return ERR_PTR(-ENOMEM);
>  
>  	new_nsp->mnt_ns = copy_mnt_ns(flags, tsk->nsproxy->mnt_ns, user_ns, new_fs);
> -	if (IS_ERR(new_nsp->mnt_ns)) {
> -		err = PTR_ERR(new_nsp->mnt_ns);
> -		goto out_ns;
> -	}
> +	if (IS_ERR(new_nsp->mnt_ns))
> +		return ERR_CAST(new_nsp->mnt_ns);
>  
>  	new_nsp->uts_ns = copy_utsname(flags, user_ns, tsk->nsproxy->uts_ns);
> -	if (IS_ERR(new_nsp->uts_ns)) {
> -		err = PTR_ERR(new_nsp->uts_ns);
> -		goto out_uts;
> -	}
> +	if (IS_ERR(new_nsp->uts_ns))
> +		return ERR_CAST(new_nsp->uts_ns);
>  
>  	new_nsp->ipc_ns = copy_ipcs(flags, user_ns, tsk->nsproxy->ipc_ns);
> -	if (IS_ERR(new_nsp->ipc_ns)) {
> -		err = PTR_ERR(new_nsp->ipc_ns);
> -		goto out_ipc;
> -	}
> +	if (IS_ERR(new_nsp->ipc_ns))
> +		return ERR_CAST(new_nsp->ipc_ns);
>  
> -	new_nsp->pid_ns_for_children =
> -		copy_pid_ns(flags, user_ns, tsk->nsproxy->pid_ns_for_children);
> -	if (IS_ERR(new_nsp->pid_ns_for_children)) {
> -		err = PTR_ERR(new_nsp->pid_ns_for_children);
> -		goto out_pid;
> -	}
> +	new_nsp->pid_ns_for_children = copy_pid_ns(flags, user_ns,
> +						   tsk->nsproxy->pid_ns_for_children);
> +	if (IS_ERR(new_nsp->pid_ns_for_children))
> +		return ERR_CAST(new_nsp->pid_ns_for_children);
>  
>  	new_nsp->cgroup_ns = copy_cgroup_ns(flags, user_ns,
>  					    tsk->nsproxy->cgroup_ns);
> -	if (IS_ERR(new_nsp->cgroup_ns)) {
> -		err = PTR_ERR(new_nsp->cgroup_ns);
> -		goto out_cgroup;
> -	}
> +	if (IS_ERR(new_nsp->cgroup_ns))
> +		return ERR_CAST(new_nsp->cgroup_ns);
>  
>  	new_nsp->net_ns = copy_net_ns(flags, user_ns, tsk->nsproxy->net_ns);
> -	if (IS_ERR(new_nsp->net_ns)) {
> -		err = PTR_ERR(new_nsp->net_ns);
> -		goto out_net;
> -	}
> +	if (IS_ERR(new_nsp->net_ns))
> +		return ERR_CAST(new_nsp->net_ns);
>  
>  	new_nsp->time_ns_for_children = copy_time_ns(flags, user_ns,
> -					tsk->nsproxy->time_ns_for_children);
> -	if (IS_ERR(new_nsp->time_ns_for_children)) {
> -		err = PTR_ERR(new_nsp->time_ns_for_children);
> -		goto out_time;
> -	}
> +						     tsk->nsproxy->time_ns_for_children);
> +	if (IS_ERR(new_nsp->time_ns_for_children))
> +		return ERR_CAST(new_nsp->time_ns_for_children);
>  	new_nsp->time_ns = get_time_ns(tsk->nsproxy->time_ns);
>  
> -	return new_nsp;
> -
> -out_time:
> -	put_net(new_nsp->net_ns);
> -out_net:
> -	put_cgroup_ns(new_nsp->cgroup_ns);
> -out_cgroup:
> -	put_pid_ns(new_nsp->pid_ns_for_children);
> -out_pid:
> -	put_ipc_ns(new_nsp->ipc_ns);
> -out_ipc:
> -	put_uts_ns(new_nsp->uts_ns);
> -out_uts:
> -	put_mnt_ns(new_nsp->mnt_ns);
> -out_ns:
> -	kmem_cache_free(nsproxy_cachep, new_nsp);
> -	return ERR_PTR(err);
> +	return no_free_ptr(new_nsp);
>  }
>  
>  /*
> @@ -185,21 +175,6 @@ int copy_namespaces(u64 flags, struct task_struct *tsk)
>  	return 0;
>  }
>  
> -void free_nsproxy(struct nsproxy *ns)
> -{
> -	nsproxy_ns_active_put(ns);
> -
> -	put_mnt_ns(ns->mnt_ns);
> -	put_uts_ns(ns->uts_ns);
> -	put_ipc_ns(ns->ipc_ns);
> -	put_pid_ns(ns->pid_ns_for_children);
> -	put_time_ns(ns->time_ns);
> -	put_time_ns(ns->time_ns_for_children);
> -	put_cgroup_ns(ns->cgroup_ns);
> -	put_net(ns->net_ns);
> -	kmem_cache_free(nsproxy_cachep, ns);
> -}
> -
>  /*
>   * Called from unshare. Unshare all the namespaces part of nsproxy.
>   * On success, returns the new nsproxy.
> @@ -338,7 +313,7 @@ static void put_nsset(struct nsset *nsset)
>  	if (nsset->fs && (flags & CLONE_NEWNS) && (flags & ~CLONE_NEWNS))
>  		free_fs_struct(nsset->fs);
>  	if (nsset->nsproxy)
> -		free_nsproxy(nsset->nsproxy);
> +		nsproxy_free(nsset->nsproxy);
>  }
>  
>  static int prepare_nsset(unsigned flags, struct nsset *nsset)
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

