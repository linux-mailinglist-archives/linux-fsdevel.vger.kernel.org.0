Return-Path: <linux-fsdevel+bounces-62089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4ACB83E19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 11:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D042A3C31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 09:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DF82F25E8;
	Thu, 18 Sep 2025 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y6bA7e/p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="27bfigr9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y6bA7e/p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="27bfigr9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49BE2EF646
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188728; cv=none; b=NzTU1awm+kh66XJUupfVJgJJP6kjzPfJqOyechlI/fGGdJahW/lNVYQAVh73/UaNGNjelXkPKzMfT3qqwhvT1B2BcPc1j/vOGekmig1KH0VEk0nYp+bZTrzdoPbemua8ijgsdcMhvHHicGa08j6UoRkt8ROJyznfRmtPViK2hi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188728; c=relaxed/simple;
	bh=gPkIfztTZi0y6LE6Qd/+NfHWDHdqF3VndcKeLbxtUXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjNKMHDU9J5aponBJo8x7g4cTQjl+Ecc1HJV5N5CyCseOGLB5TukU5TEr2Rco6iIBYe7L4v5nY3pK/IFIft1GqWo4DuFW+YcTByscy42trqnkXX9qguZ8Iik/9JhYG830H+QT7splV+BJBoJJFGrHdV1OciNgNe05/JMdygVbyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y6bA7e/p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=27bfigr9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y6bA7e/p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=27bfigr9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1894A3370E;
	Thu, 18 Sep 2025 09:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758188725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jYVbT4f0JlXgqhMfqXCIC/MlW/e2h+FcYF+y8Dmeb+M=;
	b=Y6bA7e/pIkASQEcFdIfJt1WPX+tzhydEbJM85/qsqRgloJewgyUhZrYb77ylEy/GV4P0zr
	kUDBjWYxubMYEB9iVhX+26ubAE4TCPoamLDJG8GjVrzy5WgpsKh5vhyxMJXo2uPAjwJogL
	Kk5nTosowWltIhA8V3hf723eEib+l7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758188725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jYVbT4f0JlXgqhMfqXCIC/MlW/e2h+FcYF+y8Dmeb+M=;
	b=27bfigr9Bdp1FsrfQ785y9KDj8Voo8LDsecB7BAfcxNnYRdZ0MVsDNTAV3UcRrnGT6mGkh
	bmS93rYP9yUPhaCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Y6bA7e/p";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=27bfigr9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758188725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jYVbT4f0JlXgqhMfqXCIC/MlW/e2h+FcYF+y8Dmeb+M=;
	b=Y6bA7e/pIkASQEcFdIfJt1WPX+tzhydEbJM85/qsqRgloJewgyUhZrYb77ylEy/GV4P0zr
	kUDBjWYxubMYEB9iVhX+26ubAE4TCPoamLDJG8GjVrzy5WgpsKh5vhyxMJXo2uPAjwJogL
	Kk5nTosowWltIhA8V3hf723eEib+l7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758188725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jYVbT4f0JlXgqhMfqXCIC/MlW/e2h+FcYF+y8Dmeb+M=;
	b=27bfigr9Bdp1FsrfQ785y9KDj8Voo8LDsecB7BAfcxNnYRdZ0MVsDNTAV3UcRrnGT6mGkh
	bmS93rYP9yUPhaCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 060C213A51;
	Thu, 18 Sep 2025 09:45:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e1l4AbXUy2jUYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Sep 2025 09:45:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 44F67A09B1; Thu, 18 Sep 2025 11:45:20 +0200 (CEST)
Date: Thu, 18 Sep 2025 11:45:20 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jakub Kicinski <kuba@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 8/9] nscommon: simplify initialization
Message-ID: <so6gpy2udirre26cghfchiayvaxzhtnhq3y3j2mndzkkosxpcv@2dnlcxurzbjo>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-8-1b3bda8ef8f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-work-namespace-ns_common-v1-8-1b3bda8ef8f2@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1894A3370E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[22];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -2.51

On Wed 17-09-25 12:28:07, Christian Brauner wrote:
> There's a lot of information that namespace implementers don't need to
> know about at all. Encapsulate this all in the initialization helper.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c            |  5 +++--
>  include/linux/ns_common.h | 41 +++++++++++++++++++++++++++++++++++++++--
>  ipc/namespace.c           |  2 +-
>  kernel/cgroup/namespace.c |  2 +-
>  kernel/nscommon.c         | 17 ++++++++---------
>  kernel/pid_namespace.c    |  2 +-
>  kernel/time/namespace.c   |  2 +-
>  kernel/user_namespace.c   |  2 +-
>  kernel/utsname.c          |  2 +-
>  net/core/net_namespace.c  |  2 +-
>  10 files changed, 57 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 09e4ecd44972..31eb0e8f21eb 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4105,8 +4105,9 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
>  	}
>  
>  	if (anon)
> -		new_ns->ns.inum = MNT_NS_ANON_INO;
> -	ret = ns_common_init(&new_ns->ns, &mntns_operations, !anon);
> +		ret = ns_common_init_inum(new_ns, &mntns_operations, MNT_NS_ANON_INO);
> +	else
> +		ret = ns_common_init(new_ns, &mntns_operations);
>  	if (ret) {
>  		kfree(new_ns);
>  		dec_mnt_namespaces(ucounts);
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index 78b17fe80b62..284bba2b7c43 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -16,6 +16,15 @@ struct time_namespace;
>  struct user_namespace;
>  struct uts_namespace;
>  
> +extern struct cgroup_namespace init_cgroup_ns;
> +extern struct ipc_namespace init_ipc_ns;
> +extern struct mnt_namespace *init_mnt_ns;
> +extern struct net init_net;
> +extern struct pid_namespace init_pid_ns;
> +extern struct time_namespace init_time_ns;
> +extern struct user_namespace init_user_ns;
> +extern struct uts_namespace init_uts_ns;
> +
>  struct ns_common {
>  	struct dentry *stashed;
>  	const struct proc_ns_operations *ops;
> @@ -31,8 +40,7 @@ struct ns_common {
>  	};
>  };
>  
> -int ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
> -		   bool alloc_inum);
> +int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops, int inum);
>  
>  #define to_ns_common(__ns)                              \
>  	_Generic((__ns),                                \
> @@ -45,4 +53,33 @@ int ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
>  		struct user_namespace *:   &(__ns)->ns, \
>  		struct uts_namespace *:    &(__ns)->ns)
>  
> +#define ns_init_inum(__ns)                                     \
> +	_Generic((__ns),                                       \
> +		struct cgroup_namespace *: CGROUP_NS_INIT_INO, \
> +		struct ipc_namespace *:    IPC_NS_INIT_INO,    \
> +		struct mnt_namespace *:    MNT_NS_INIT_INO,    \
> +		struct net *:              NET_NS_INIT_INO,    \
> +		struct pid_namespace *:    PID_NS_INIT_INO,    \
> +		struct time_namespace *:   TIME_NS_INIT_INO,   \
> +		struct user_namespace *:   USER_NS_INIT_INO,   \
> +		struct uts_namespace *:    UTS_NS_INIT_INO)
> +
> +#define ns_init_ns(__ns)                                    \
> +	_Generic((__ns),                                    \
> +		struct cgroup_namespace *: &init_cgroup_ns, \
> +		struct ipc_namespace *:    &init_ipc_ns,    \
> +		struct mnt_namespace *:    init_mnt_ns,     \
> +		struct net *:              &init_net,       \
> +		struct pid_namespace *:    &init_pid_ns,    \
> +		struct time_namespace *:   &init_time_ns,   \
> +		struct user_namespace *:   &init_user_ns,   \
> +		struct uts_namespace *:    &init_uts_ns)
> +
> +#define ns_common_init(__ns, __ops) \
> +	__ns_common_init(&(__ns)->ns, __ops, \
> +		         (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0))
> +
> +#define ns_common_init_inum(__ns, __ops, __inum) \
> +	__ns_common_init(&(__ns)->ns, __ops, __inum)
> +
>  #endif
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index 89588819956b..0f8bbd18a475 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -62,7 +62,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
>  	if (ns == NULL)
>  		goto fail_dec;
>  
> -	err = ns_common_init(&ns->ns, &ipcns_operations, true);
> +	err = ns_common_init(ns, &ipcns_operations);
>  	if (err)
>  		goto fail_free;
>  
> diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
> index 5a327914b565..d928c557e28b 100644
> --- a/kernel/cgroup/namespace.c
> +++ b/kernel/cgroup/namespace.c
> @@ -27,7 +27,7 @@ static struct cgroup_namespace *alloc_cgroup_ns(void)
>  	new_ns = kzalloc(sizeof(struct cgroup_namespace), GFP_KERNEL_ACCOUNT);
>  	if (!new_ns)
>  		return ERR_PTR(-ENOMEM);
> -	ret = ns_common_init(&new_ns->ns, &cgroupns_operations, true);
> +	ret = ns_common_init(new_ns, &cgroupns_operations);
>  	if (ret)
>  		return ERR_PTR(ret);
>  	ns_tree_add(new_ns);
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index e10fad8afe61..c3a90bb665ad 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -1,21 +1,20 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
>  #include <linux/ns_common.h>
> +#include <linux/proc_ns.h>
>  
> -int ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
> -		   bool alloc_inum)
> +int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops, int inum)
>  {
> -	if (alloc_inum && !ns->inum) {
> -		int ret;
> -		ret = proc_alloc_inum(&ns->inum);
> -		if (ret)
> -			return ret;
> -	}
>  	refcount_set(&ns->count, 1);
>  	ns->stashed = NULL;
>  	ns->ops = ops;
>  	ns->ns_id = 0;
>  	RB_CLEAR_NODE(&ns->ns_tree_node);
>  	INIT_LIST_HEAD(&ns->ns_list_node);
> -	return 0;
> +
> +	if (inum) {
> +		ns->inum = inum;
> +		return 0;
> +	}
> +	return proc_alloc_inum(&ns->inum);
>  }
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 9b327420309e..170757c265c2 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -103,7 +103,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
>  	if (ns->pid_cachep == NULL)
>  		goto out_free_idr;
>  
> -	err = ns_common_init(&ns->ns, &pidns_operations, true);
> +	err = ns_common_init(ns, &pidns_operations);
>  	if (err)
>  		goto out_free_idr;
>  
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index 20b65f90549e..ce8e952104a7 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -97,7 +97,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
>  	if (!ns->vvar_page)
>  		goto fail_free;
>  
> -	err = ns_common_init(&ns->ns, &timens_operations, true);
> +	err = ns_common_init(ns, &timens_operations);
>  	if (err)
>  		goto fail_free_page;
>  
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index cfb0e28f2779..db9f0463219c 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -126,7 +126,7 @@ int create_user_ns(struct cred *new)
>  
>  	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
>  
> -	ret = ns_common_init(&ns->ns, &userns_operations, true);
> +	ret = ns_common_init(ns, &userns_operations);
>  	if (ret)
>  		goto fail_free;
>  
> diff --git a/kernel/utsname.c b/kernel/utsname.c
> index a682830742d3..399888be66bd 100644
> --- a/kernel/utsname.c
> +++ b/kernel/utsname.c
> @@ -50,7 +50,7 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
>  	if (!ns)
>  		goto fail_dec;
>  
> -	err = ns_common_init(&ns->ns, &utsns_operations, true);
> +	err = ns_common_init(ns, &utsns_operations);
>  	if (err)
>  		goto fail_free;
>  
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 897f4927df9e..fdb266bbdf93 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -409,7 +409,7 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
>  	ns_ops = NULL;
>  #endif
>  
> -	ret = ns_common_init(&net->ns, ns_ops, true);
> +	ret = ns_common_init(net, ns_ops);
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

