Return-Path: <linux-fsdevel+bounces-62083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A57C1B83B2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 11:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3037B1C07EB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 09:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507C52FF679;
	Thu, 18 Sep 2025 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E0dD+TP3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m4trHJRY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HqCcH+2O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mvJYBXJP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B9C34BA44
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186672; cv=none; b=cDxTP1Gir0YXcKCvf6yxQ5N6Of9CfgMKEyOIOM77Q6jPJ2na3mjOmlBpanyh1BLOOL6HfjW9pSvz6i+rMfAagI0ngm3ksHG60kpOCef0OEhxTRPFRdpNPt+AMOnyqwlljrBWkfLcDW11AvSaeZOmarlO1k1R11eF6PERLLtpo/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186672; c=relaxed/simple;
	bh=ROzj7x8f2E0Pg2YMtmuABkw2czH9kN4rhCy5VhmuH3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5Tmbkx/qbNGKTx7tRqvhDQQqYZJYGL4q92mq20r8miCTyId+m92zO6NaRmj3fGMXsK8wsaEkaGmbcF7ZpgjG/dTCu/WeJB0TR3VlKzZN5cAZ5GjpfxNsZc+NAcYPp3GXPEdnyBpK6DlU4hXLpvDzU759RYJcqHm8u+ekRfPkv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E0dD+TP3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m4trHJRY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HqCcH+2O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mvJYBXJP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D86F01F393;
	Thu, 18 Sep 2025 09:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758186663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xL+TtOqmZ5Gag6pbcfCwROUJiWuODRMG1zK+9kl5tPY=;
	b=E0dD+TP3vQjrBnQ/oelOtpFV41KQhpQc2W8SlXqeVXLtihY3dz/7Ag6tJJ26L1p9uQ2Wa/
	nCUiK1Z0eJZ8YaCl/IJOE9S2xvO9DiAg2Ly/elhfut40j8YEwmAde/JGV+XnAlURcXGpCx
	3GNJy1ahikrMvXyNfosJQ/6ceML+G8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758186663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xL+TtOqmZ5Gag6pbcfCwROUJiWuODRMG1zK+9kl5tPY=;
	b=m4trHJRY5zHvAEZwA0ZpBIRKHZqZdX5q+cC85KTn2wvebD4U5FXL6/2k7i8DSGs05jwf0F
	VcO/xFIHxtk/8MCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758186662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xL+TtOqmZ5Gag6pbcfCwROUJiWuODRMG1zK+9kl5tPY=;
	b=HqCcH+2Okzs3AWdSW93O8xOP/EblM0I/5A82okuPugcNAFwdTGE1bf5Fw+x/Tw4Xhx7uMb
	F/FoQlOaEEZ7omcEakAbb9OVdgrpWS650dOMkbp4inSIAqbVYJvNrzjdDt27086nb37MvJ
	i6JdP139bopILs6Mfh50i1GrXb8YQf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758186662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xL+TtOqmZ5Gag6pbcfCwROUJiWuODRMG1zK+9kl5tPY=;
	b=mvJYBXJPwG2sugGeTBbyqr9ePhgDyROO6CWRmvwTL5VVnYvsGlhatcLadmIw+zMJgRw60J
	rfSM4S54fWggVeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEDA213A39;
	Thu, 18 Sep 2025 09:11:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ieSSLqbMy2jLVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Sep 2025 09:11:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D2F7A09B1; Thu, 18 Sep 2025 11:11:02 +0200 (CEST)
Date: Thu, 18 Sep 2025 11:11:02 +0200
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
Subject: Re: [PATCH 9/9] ns: add ns_common_free()
Message-ID: <nn7h3bjzz5ckd5mjhqs5jci4fl4ndjc6uabos54242x2ck7mph@fbobo4nydu7p>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
 <20250917-work-namespace-ns_common-v1-9-1b3bda8ef8f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-work-namespace-ns_common-v1-9-1b3bda8ef8f2@kernel.org>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Wed 17-09-25 12:28:08, Christian Brauner wrote:
> And drop ns_free_inum(). Anything common that can be wasted centrally
> should be wasted in the new common helper.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c            | 4 ++--
>  include/linux/ns_common.h | 3 +++
>  include/linux/proc_ns.h   | 2 --
>  ipc/namespace.c           | 4 ++--
>  kernel/cgroup/namespace.c | 2 +-
>  kernel/nscommon.c         | 5 +++++
>  kernel/pid_namespace.c    | 4 ++--
>  kernel/time/namespace.c   | 2 +-
>  kernel/user_namespace.c   | 4 ++--
>  kernel/utsname.c          | 2 +-
>  net/core/net_namespace.c  | 4 ++--
>  11 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 31eb0e8f21eb..03bd04559e69 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4083,7 +4083,7 @@ static void dec_mnt_namespaces(struct ucounts *ucounts)
>  static void free_mnt_ns(struct mnt_namespace *ns)
>  {
>  	if (!is_anon_ns(ns))
> -		ns_free_inum(&ns->ns);
> +		ns_common_free(ns);
>  	dec_mnt_namespaces(ns->ucounts);
>  	mnt_ns_tree_remove(ns);
>  }
> @@ -4155,7 +4155,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
>  	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
>  	if (IS_ERR(new)) {
>  		namespace_unlock();
> -		ns_free_inum(&new_ns->ns);
> +		ns_common_free(ns);
>  		dec_mnt_namespaces(new_ns->ucounts);
>  		mnt_ns_release(new_ns);
>  		return ERR_CAST(new);
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index 284bba2b7c43..5094c0147b54 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -41,6 +41,7 @@ struct ns_common {
>  };
>  
>  int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops, int inum);
> +void __ns_common_free(struct ns_common *ns);
>  
>  #define to_ns_common(__ns)                              \
>  	_Generic((__ns),                                \
> @@ -82,4 +83,6 @@ int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
>  #define ns_common_init_inum(__ns, __ops, __inum) \
>  	__ns_common_init(&(__ns)->ns, __ops, __inum)
>  
> +#define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
> +
>  #endif
> diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
> index 9f21670b5824..08016f6e0e6f 100644
> --- a/include/linux/proc_ns.h
> +++ b/include/linux/proc_ns.h
> @@ -66,8 +66,6 @@ static inline void proc_free_inum(unsigned int inum) {}
>  
>  #endif /* CONFIG_PROC_FS */
>  
> -#define ns_free_inum(ns) proc_free_inum((ns)->inum)
> -
>  #define get_proc_ns(inode) ((struct ns_common *)(inode)->i_private)
>  
>  #endif /* _LINUX_PROC_NS_H */
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index 0f8bbd18a475..09d261a1a2aa 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -97,7 +97,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
>  
>  fail_put:
>  	put_user_ns(ns->user_ns);
> -	ns_free_inum(&ns->ns);
> +	ns_common_free(ns);
>  fail_free:
>  	kfree(ns);
>  fail_dec:
> @@ -161,7 +161,7 @@ static void free_ipc_ns(struct ipc_namespace *ns)
>  
>  	dec_ipc_namespaces(ns->ucounts);
>  	put_user_ns(ns->user_ns);
> -	ns_free_inum(&ns->ns);
> +	ns_common_free(ns);
>  	kfree(ns);
>  }
>  
> diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
> index d928c557e28b..16ead7508371 100644
> --- a/kernel/cgroup/namespace.c
> +++ b/kernel/cgroup/namespace.c
> @@ -40,7 +40,7 @@ void free_cgroup_ns(struct cgroup_namespace *ns)
>  	put_css_set(ns->root_cset);
>  	dec_cgroup_namespaces(ns->ucounts);
>  	put_user_ns(ns->user_ns);
> -	ns_free_inum(&ns->ns);
> +	ns_common_free(ns);
>  	/* Concurrent nstree traversal depends on a grace period. */
>  	kfree_rcu(ns, ns.ns_rcu);
>  }
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index c3a90bb665ad..7c1b07e2a6c9 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -18,3 +18,8 @@ int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
>  	}
>  	return proc_alloc_inum(&ns->inum);
>  }
> +
> +void __ns_common_free(struct ns_common *ns)
> +{
> +	proc_free_inum(ns->inum);
> +}
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 170757c265c2..27e2dd9ee051 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -127,7 +127,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
>  	return ns;
>  
>  out_free_inum:
> -	ns_free_inum(&ns->ns);
> +	ns_common_free(ns);
>  out_free_idr:
>  	idr_destroy(&ns->idr);
>  	kmem_cache_free(pid_ns_cachep, ns);
> @@ -152,7 +152,7 @@ static void destroy_pid_namespace(struct pid_namespace *ns)
>  	ns_tree_remove(ns);
>  	unregister_pidns_sysctls(ns);
>  
> -	ns_free_inum(&ns->ns);
> +	ns_common_free(ns);
>  
>  	idr_destroy(&ns->idr);
>  	call_rcu(&ns->rcu, delayed_free_pidns);
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index ce8e952104a7..d49c73015d6e 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -255,7 +255,7 @@ void free_time_ns(struct time_namespace *ns)
>  	ns_tree_remove(ns);
>  	dec_time_namespaces(ns->ucounts);
>  	put_user_ns(ns->user_ns);
> -	ns_free_inum(&ns->ns);
> +	ns_common_free(ns);
>  	__free_page(ns->vvar_page);
>  	/* Concurrent nstree traversal depends on a grace period. */
>  	kfree_rcu(ns, ns.ns_rcu);
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index db9f0463219c..32406bcab526 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -165,7 +165,7 @@ int create_user_ns(struct cred *new)
>  #ifdef CONFIG_PERSISTENT_KEYRINGS
>  	key_put(ns->persistent_keyring_register);
>  #endif
> -	ns_free_inum(&ns->ns);
> +	ns_common_free(ns);
>  fail_free:
>  	kmem_cache_free(user_ns_cachep, ns);
>  fail_dec:
> @@ -220,7 +220,7 @@ static void free_user_ns(struct work_struct *work)
>  #endif
>  		retire_userns_sysctls(ns);
>  		key_free_user_ns(ns);
> -		ns_free_inum(&ns->ns);
> +		ns_common_free(ns);
>  		/* Concurrent nstree traversal depends on a grace period. */
>  		kfree_rcu(ns, ns.ns_rcu);
>  		dec_user_namespaces(ucounts);
> diff --git a/kernel/utsname.c b/kernel/utsname.c
> index 399888be66bd..95d733eb2c98 100644
> --- a/kernel/utsname.c
> +++ b/kernel/utsname.c
> @@ -98,7 +98,7 @@ void free_uts_ns(struct uts_namespace *ns)
>  	ns_tree_remove(ns);
>  	dec_uts_namespaces(ns->ucounts);
>  	put_user_ns(ns->user_ns);
> -	ns_free_inum(&ns->ns);
> +	ns_common_free(ns);
>  	/* Concurrent nstree traversal depends on a grace period. */
>  	kfree_rcu(ns, ns.ns_rcu);
>  }
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index fdb266bbdf93..fdbaf5f8ac78 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -597,7 +597,7 @@ struct net *copy_net_ns(unsigned long flags,
>  		net_passive_dec(net);
>  dec_ucounts:
>  		dec_net_namespaces(ucounts);
> -		ns_free_inum(&net->ns);
> +		ns_common_free(net);
>  		return ERR_PTR(rv);
>  	}
>  	return net;
> @@ -719,7 +719,7 @@ static void cleanup_net(struct work_struct *work)
>  #endif
>  		put_user_ns(net->user_ns);
>  		net_passive_dec(net);
> -		ns_free_inum(&net->ns);
> +		ns_common_free(net);
>  	}
>  	WRITE_ONCE(cleanup_net_task, NULL);
>  }
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

