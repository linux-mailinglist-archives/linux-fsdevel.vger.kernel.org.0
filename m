Return-Path: <linux-fsdevel+bounces-62405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ECEB9178C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 15:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34FE17982A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC83112A0;
	Mon, 22 Sep 2025 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mDKzbRZq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O3dw5W+O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mDKzbRZq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O3dw5W+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD2310645
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548510; cv=none; b=VkC5DvhGjcJtUsv/5h+EKYxX3YQOZ2o4ujNQQyFz4NVJjfp/edUbosw/3N6YpYsxPhXV/csFjNPUy/56L8S9Reae4C5g86j9cwYdV8XYOV3z2gvwOmsP03Vbs7LKKQkn3x7kGsJZZNl+aYpS4cjsGzmTv7b4SdufJPET0KwaK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548510; c=relaxed/simple;
	bh=QCYZ8VZ1obM5jhNJrU/IAMC6BQKyo/NXEc1fm3l1ohU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uES+AQ0Y24k5UE+jYubB68FeKXxBwp1vP7lOvyrE78vtXYnCTjSWWcqvNhR91Ep6I/h1sN2AtAIp1bJxEW5Coo3CI0ZB4azE/dV6trE1Me/ahb4uTdkG/sb7THAgdiUWgAGta/pov9a3jhxIBxvV/gLFpCWGbMDIhdytEwkTSZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mDKzbRZq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O3dw5W+O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mDKzbRZq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O3dw5W+O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD46A1F79A;
	Mon, 22 Sep 2025 13:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758548506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJD9bDmZtTi5CCPJhR0J5eHcEHugouHumtziqJL3Khk=;
	b=mDKzbRZqb+M3ngkz4VYlyMR8gSy6xjQgFvGS2sUedIQDPe3bVVox6jnlD7CPGbmpUw/M+V
	Cqw5UepWdHzM0UfqDBh5AAVRBl9CzPPT0S1uVbSW+n0MtuDPSlq7qhGRKl5yEsBofUlXpL
	R1o8iMdg+E86vhC1d0IGowEWsNG1hEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758548506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJD9bDmZtTi5CCPJhR0J5eHcEHugouHumtziqJL3Khk=;
	b=O3dw5W+OtmKgzA3uq6SPU+62Z+VB0SMSG0TaEL3GOp/ROmMaI9vWz1tPGfIW0Fud0J2d4H
	bLpHLOy+GoCz+vBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mDKzbRZq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O3dw5W+O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758548506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJD9bDmZtTi5CCPJhR0J5eHcEHugouHumtziqJL3Khk=;
	b=mDKzbRZqb+M3ngkz4VYlyMR8gSy6xjQgFvGS2sUedIQDPe3bVVox6jnlD7CPGbmpUw/M+V
	Cqw5UepWdHzM0UfqDBh5AAVRBl9CzPPT0S1uVbSW+n0MtuDPSlq7qhGRKl5yEsBofUlXpL
	R1o8iMdg+E86vhC1d0IGowEWsNG1hEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758548506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJD9bDmZtTi5CCPJhR0J5eHcEHugouHumtziqJL3Khk=;
	b=O3dw5W+OtmKgzA3uq6SPU+62Z+VB0SMSG0TaEL3GOp/ROmMaI9vWz1tPGfIW0Fud0J2d4H
	bLpHLOy+GoCz+vBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD5AC13A63;
	Mon, 22 Sep 2025 13:41:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c9NQKhpS0WhZfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Sep 2025 13:41:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 01D83A07C4; Mon, 22 Sep 2025 15:41:41 +0200 (CEST)
Date: Mon, 22 Sep 2025 15:41:41 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] ns: simplify ns_common_init() further
Message-ID: <6a5dyxarvdri6ykizyvr3mmfe5h2hsljcm426o6odao7ljujxn@xwk6n46qr6ww>
References: <20250922-work-namespace-ns_common-fixes-v1-0-3c26aeb30831@kernel.org>
 <20250922-work-namespace-ns_common-fixes-v1-2-3c26aeb30831@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922-work-namespace-ns_common-fixes-v1-2-3c26aeb30831@kernel.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: BD46A1F79A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Mon 22-09-25 14:42:36, Christian Brauner wrote:
> Simply derive the ns operations from the namespace type.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Nice! As much as I already feel pity for the guy who'll be reading all
these macros to figure out how some ns gets initialized :) feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c            |  4 ++--
>  include/linux/ns_common.h | 30 ++++++++++++++++++++++++++----
>  ipc/namespace.c           |  2 +-
>  kernel/cgroup/namespace.c |  2 +-
>  kernel/pid_namespace.c    |  2 +-
>  kernel/time/namespace.c   |  2 +-
>  kernel/user_namespace.c   |  2 +-
>  kernel/utsname.c          |  2 +-
>  net/core/net_namespace.c  |  9 +--------
>  9 files changed, 35 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 271cd6294c8a..d65917ec5544 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4104,9 +4104,9 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
>  	}
>  
>  	if (anon)
> -		ret = ns_common_init_inum(new_ns, &mntns_operations, MNT_NS_ANON_INO);
> +		ret = ns_common_init_inum(new_ns, MNT_NS_ANON_INO);
>  	else
> -		ret = ns_common_init(new_ns, &mntns_operations);
> +		ret = ns_common_init(new_ns);
>  	if (ret) {
>  		kfree(new_ns);
>  		dec_mnt_namespaces(ucounts);
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index aea8528d799a..56492cd9ff8d 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -25,6 +25,17 @@ extern struct time_namespace init_time_ns;
>  extern struct user_namespace init_user_ns;
>  extern struct uts_namespace init_uts_ns;
>  
> +extern const struct proc_ns_operations netns_operations;
> +extern const struct proc_ns_operations utsns_operations;
> +extern const struct proc_ns_operations ipcns_operations;
> +extern const struct proc_ns_operations pidns_operations;
> +extern const struct proc_ns_operations pidns_for_children_operations;
> +extern const struct proc_ns_operations userns_operations;
> +extern const struct proc_ns_operations mntns_operations;
> +extern const struct proc_ns_operations cgroupns_operations;
> +extern const struct proc_ns_operations timens_operations;
> +extern const struct proc_ns_operations timens_for_children_operations;
> +
>  struct ns_common {
>  	struct dentry *stashed;
>  	const struct proc_ns_operations *ops;
> @@ -84,10 +95,21 @@ void __ns_common_free(struct ns_common *ns);
>  		struct user_namespace *:   &init_user_ns,   \
>  		struct uts_namespace *:    &init_uts_ns)
>  
> -#define ns_common_init(__ns, __ops) \
> -	__ns_common_init(to_ns_common(__ns), __ops, (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0))
> -
> -#define ns_common_init_inum(__ns, __ops, __inum) __ns_common_init(to_ns_common(__ns), __ops, __inum)
> +#define to_ns_operations(__ns)                                                                         \
> +	_Generic((__ns),                                                                               \
> +		struct cgroup_namespace *: (IS_ENABLED(CONFIG_CGROUPS) ? &cgroupns_operations : NULL), \
> +		struct ipc_namespace *:    (IS_ENABLED(CONFIG_IPC_NS)  ? &ipcns_operations    : NULL), \
> +		struct mnt_namespace *:    &mntns_operations,                                          \
> +		struct net *:              (IS_ENABLED(CONFIG_NET_NS)  ? &netns_operations    : NULL), \
> +		struct pid_namespace *:    (IS_ENABLED(CONFIG_PID_NS)  ? &pidns_operations    : NULL), \
> +		struct time_namespace *:   (IS_ENABLED(CONFIG_TIME_NS) ? &timens_operations   : NULL), \
> +		struct user_namespace *:   (IS_ENABLED(CONFIG_USER_NS) ? &userns_operations   : NULL), \
> +		struct uts_namespace *:    (IS_ENABLED(CONFIG_UTS_NS)  ? &utsns_operations    : NULL))
> +
> +#define ns_common_init(__ns) \
> +	__ns_common_init(to_ns_common(__ns), to_ns_operations(__ns), (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0))
> +
> +#define ns_common_init_inum(__ns, __inum) __ns_common_init(to_ns_common(__ns), to_ns_operations(__ns), __inum)
>  
>  #define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
>  
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index bd85d1c9d2c2..d89dfd718d2b 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -62,7 +62,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
>  	if (ns == NULL)
>  		goto fail_dec;
>  
> -	err = ns_common_init(ns, &ipcns_operations);
> +	err = ns_common_init(ns);
>  	if (err)
>  		goto fail_free;
>  
> diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
> index 16ead7508371..04c98338ac08 100644
> --- a/kernel/cgroup/namespace.c
> +++ b/kernel/cgroup/namespace.c
> @@ -27,7 +27,7 @@ static struct cgroup_namespace *alloc_cgroup_ns(void)
>  	new_ns = kzalloc(sizeof(struct cgroup_namespace), GFP_KERNEL_ACCOUNT);
>  	if (!new_ns)
>  		return ERR_PTR(-ENOMEM);
> -	ret = ns_common_init(new_ns, &cgroupns_operations);
> +	ret = ns_common_init(new_ns);
>  	if (ret)
>  		return ERR_PTR(ret);
>  	ns_tree_add(new_ns);
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 162f5fb63d75..a262a3f19443 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -103,7 +103,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
>  	if (ns->pid_cachep == NULL)
>  		goto out_free_idr;
>  
> -	err = ns_common_init(ns, &pidns_operations);
> +	err = ns_common_init(ns);
>  	if (err)
>  		goto out_free_idr;
>  
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index 7aa4d6fedd49..9f26e61be044 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -97,7 +97,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
>  	if (!ns->vvar_page)
>  		goto fail_free;
>  
> -	err = ns_common_init(ns, &timens_operations);
> +	err = ns_common_init(ns);
>  	if (err)
>  		goto fail_free_page;
>  
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index f9df45c46235..e1559e8a8a02 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -126,7 +126,7 @@ int create_user_ns(struct cred *new)
>  
>  	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
>  
> -	ret = ns_common_init(ns, &userns_operations);
> +	ret = ns_common_init(ns);
>  	if (ret)
>  		goto fail_free;
>  
> diff --git a/kernel/utsname.c b/kernel/utsname.c
> index 95d733eb2c98..00001592ad13 100644
> --- a/kernel/utsname.c
> +++ b/kernel/utsname.c
> @@ -50,7 +50,7 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
>  	if (!ns)
>  		goto fail_dec;
>  
> -	err = ns_common_init(ns, &utsns_operations);
> +	err = ns_common_init(ns);
>  	if (err)
>  		goto fail_free;
>  
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index d5e3fd819163..bdea7d5fac56 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -400,16 +400,9 @@ static __net_init void preinit_net_sysctl(struct net *net)
>  /* init code that must occur even if setup_net() is not called. */
>  static __net_init int preinit_net(struct net *net, struct user_namespace *user_ns)
>  {
> -	const struct proc_ns_operations *ns_ops;
>  	int ret;
>  
> -#ifdef CONFIG_NET_NS
> -	ns_ops = &netns_operations;
> -#else
> -	ns_ops = NULL;
> -#endif
> -
> -	ret = ns_common_init(net, ns_ops);
> +	ret = ns_common_init(net);
>  	if (ret)
>  		return ret;
>  
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

