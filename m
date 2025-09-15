Return-Path: <linux-fsdevel+bounces-61348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79C3B579E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6615F165F33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6BE2FABEF;
	Mon, 15 Sep 2025 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w/P/vpuM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RaR0f4EI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w/P/vpuM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RaR0f4EI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1573009FF
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937966; cv=none; b=iCj5xMzKf7Hv2/TUYgxYYd8xPAGiV3ysUNoSA8sHYFWOLdoox/1UswUxqzqkRsUUgVQ6uQcBBHlF9Cu+8bmHyjUULQmMGLNi7PEXWcwHOPqI+vw5hSfs6HTSbsX7SkJsjnR6oWjFdUTbotnvl1oRoULMCqbAWIS5TZcZWgxv+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937966; c=relaxed/simple;
	bh=ieCgUaCn0PQJ9/Ds2KJrwH89py7eiqdsMsiywVnTuzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANdH1/RV+f4lifdsDRqWoVCBWnnegSVpoxcq3/lWDbthliK+4PA3Vky4FixOn5vAC3/sQuvkzB1g1YyPb1/Pnidl8awdJrVWtnZ5J5H6EKL0CEZufeuMZqa+0VIYYZ4/TQVvHvYHTFCCqttw5DW8rjubr7Mq3vK/MNHc8wgNOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w/P/vpuM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RaR0f4EI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w/P/vpuM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RaR0f4EI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8575B21CA6;
	Mon, 15 Sep 2025 12:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757937962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRT5XYdX8vHnc4A25hKq6t64VMs5ajBCUyTmDY0RTM8=;
	b=w/P/vpuM7Kv2w2B991Bbid6VnV692PQ0W05VLN+E+g7w0p+50eCLxTdGOSV5teAenfhwb1
	c+BcvTI3tqDyV20+t/cfK5dCvDpHl2nOMaJcapaG/lxy4TTOLeQcqEfLFVi3MnfL462I05
	RgQG3zZdhp9mz9eu1deT16R2isnuZzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757937962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRT5XYdX8vHnc4A25hKq6t64VMs5ajBCUyTmDY0RTM8=;
	b=RaR0f4EIrdbHGWG5vBx5HZoIXxE1CUR+FDIZ5aiygJi4zREPGHeCkIxRzMycBddWoH8Zih
	91xaGDxl1sDu43AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757937962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRT5XYdX8vHnc4A25hKq6t64VMs5ajBCUyTmDY0RTM8=;
	b=w/P/vpuM7Kv2w2B991Bbid6VnV692PQ0W05VLN+E+g7w0p+50eCLxTdGOSV5teAenfhwb1
	c+BcvTI3tqDyV20+t/cfK5dCvDpHl2nOMaJcapaG/lxy4TTOLeQcqEfLFVi3MnfL462I05
	RgQG3zZdhp9mz9eu1deT16R2isnuZzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757937962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRT5XYdX8vHnc4A25hKq6t64VMs5ajBCUyTmDY0RTM8=;
	b=RaR0f4EIrdbHGWG5vBx5HZoIXxE1CUR+FDIZ5aiygJi4zREPGHeCkIxRzMycBddWoH8Zih
	91xaGDxl1sDu43AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 719C11398D;
	Mon, 15 Sep 2025 12:06:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1J26GyoByGiLMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Sep 2025 12:06:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2656DA0A06; Mon, 15 Sep 2025 14:06:02 +0200 (CEST)
Date: Mon, 15 Sep 2025 14:06:02 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 26/33] ns: add to_<type>_ns() to respective headers
Message-ID: <rh72ppvzyvrit4bqcofy3er6t44punsmixekrzagovuqivp622@dgdhxd2qxyg4>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-26-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-26-1a247645cef5@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLbyy5b47ky7xssyr143sji8pp)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Fri 12-09-25 13:52:49, Christian Brauner wrote:
> Every namespace type has a container_of(ns, <ns_type>, ns) static inline
> function that is currently not exposed in the header. So we have a bunch
> of places that open-code it via container_of(). Move it to the headers
> so we can use it directly.
> 
> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/cgroup.h         | 5 +++++
>  include/linux/ipc_namespace.h  | 5 +++++
>  include/linux/pid_namespace.h  | 5 +++++
>  include/linux/time_namespace.h | 4 ++++
>  include/linux/user_namespace.h | 5 +++++
>  include/linux/utsname.h        | 5 +++++
>  include/net/net_namespace.h    | 5 +++++
>  ipc/namespace.c                | 5 -----
>  kernel/cgroup/namespace.c      | 5 -----
>  kernel/pid_namespace.c         | 5 -----
>  kernel/time/namespace.c        | 5 -----
>  kernel/user_namespace.c        | 5 -----
>  kernel/utsname.c               | 5 -----
>  net/core/net_namespace.c       | 5 -----
>  14 files changed, 34 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index b18fb5fcb38e..9ca25346f7cb 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -794,6 +794,11 @@ extern struct cgroup_namespace init_cgroup_ns;
>  
>  #ifdef CONFIG_CGROUPS
>  
> +static inline struct cgroup_namespace *to_cg_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct cgroup_namespace, ns);
> +}
> +
>  void free_cgroup_ns(struct cgroup_namespace *ns);
>  
>  struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
> diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
> index e8240cf2611a..924e4754374f 100644
> --- a/include/linux/ipc_namespace.h
> +++ b/include/linux/ipc_namespace.h
> @@ -129,6 +129,11 @@ static inline int mq_init_ns(struct ipc_namespace *ns) { return 0; }
>  #endif
>  
>  #if defined(CONFIG_IPC_NS)
> +static inline struct ipc_namespace *to_ipc_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct ipc_namespace, ns);
> +}
> +
>  extern struct ipc_namespace *copy_ipcs(unsigned long flags,
>  	struct user_namespace *user_ns, struct ipc_namespace *ns);
>  
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index 7c67a5811199..ba0efc8c8596 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -54,6 +54,11 @@ extern struct pid_namespace init_pid_ns;
>  #define PIDNS_ADDING (1U << 31)
>  
>  #ifdef CONFIG_PID_NS
> +static inline struct pid_namespace *to_pid_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct pid_namespace, ns);
> +}
> +
>  static inline struct pid_namespace *get_pid_ns(struct pid_namespace *ns)
>  {
>  	if (ns != &init_pid_ns)
> diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
> index 7f6af7a9771e..a47a4ce4183e 100644
> --- a/include/linux/time_namespace.h
> +++ b/include/linux/time_namespace.h
> @@ -33,6 +33,10 @@ struct time_namespace {
>  extern struct time_namespace init_time_ns;
>  
>  #ifdef CONFIG_TIME_NS
> +static inline struct time_namespace *to_time_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct time_namespace, ns);
> +}
>  void __init time_ns_init(void);
>  extern int vdso_join_timens(struct task_struct *task,
>  			    struct time_namespace *ns);
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index a0bb6d012137..a09056ad090e 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -168,6 +168,11 @@ static inline void set_userns_rlimit_max(struct user_namespace *ns,
>  
>  #ifdef CONFIG_USER_NS
>  
> +static inline struct user_namespace *to_user_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct user_namespace, ns);
> +}
> +
>  static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
>  {
>  	if (ns)
> diff --git a/include/linux/utsname.h b/include/linux/utsname.h
> index bf7613ba412b..5d34c4f0f945 100644
> --- a/include/linux/utsname.h
> +++ b/include/linux/utsname.h
> @@ -30,6 +30,11 @@ struct uts_namespace {
>  extern struct uts_namespace init_uts_ns;
>  
>  #ifdef CONFIG_UTS_NS
> +static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct uts_namespace, ns);
> +}
> +
>  static inline void get_uts_ns(struct uts_namespace *ns)
>  {
>  	refcount_inc(&ns->ns.count);
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index 42075748dff1..b9c5f6c7ee1e 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -263,6 +263,11 @@ void ipx_unregister_sysctl(void);
>  #ifdef CONFIG_NET_NS
>  void __put_net(struct net *net);
>  
> +static inline struct net *to_net_ns(struct ns_common *ns)
> +{
> +	return container_of(ns, struct net, ns);
> +}
> +
>  /* Try using get_net_track() instead */
>  static inline struct net *get_net(struct net *net)
>  {
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index 9f923c1a1eb3..89588819956b 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -209,11 +209,6 @@ void put_ipc_ns(struct ipc_namespace *ns)
>  	}
>  }
>  
> -static inline struct ipc_namespace *to_ipc_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct ipc_namespace, ns);
> -}
> -
>  static struct ns_common *ipcns_get(struct task_struct *task)
>  {
>  	struct ipc_namespace *ns = NULL;
> diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
> index fc12c416dfeb..5a327914b565 100644
> --- a/kernel/cgroup/namespace.c
> +++ b/kernel/cgroup/namespace.c
> @@ -89,11 +89,6 @@ struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
>  	return new_ns;
>  }
>  
> -static inline struct cgroup_namespace *to_cg_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct cgroup_namespace, ns);
> -}
> -
>  static int cgroupns_install(struct nsset *nsset, struct ns_common *ns)
>  {
>  	struct nsproxy *nsproxy = nsset->nsproxy;
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 228ae20299f9..9b327420309e 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -345,11 +345,6 @@ int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
>  	return 0;
>  }
>  
> -static inline struct pid_namespace *to_pid_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct pid_namespace, ns);
> -}
> -
>  static struct ns_common *pidns_get(struct task_struct *task)
>  {
>  	struct pid_namespace *ns;
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index 408f60d0a3b6..20b65f90549e 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -261,11 +261,6 @@ void free_time_ns(struct time_namespace *ns)
>  	kfree_rcu(ns, ns.ns_rcu);
>  }
>  
> -static struct time_namespace *to_time_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct time_namespace, ns);
> -}
> -
>  static struct ns_common *timens_get(struct task_struct *task)
>  {
>  	struct time_namespace *ns = NULL;
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index ade5b6806c5c..cfb0e28f2779 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -1325,11 +1325,6 @@ bool current_in_userns(const struct user_namespace *target_ns)
>  }
>  EXPORT_SYMBOL(current_in_userns);
>  
> -static inline struct user_namespace *to_user_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct user_namespace, ns);
> -}
> -
>  static struct ns_common *userns_get(struct task_struct *task)
>  {
>  	struct user_namespace *user_ns;
> diff --git a/kernel/utsname.c b/kernel/utsname.c
> index 64155417ae0c..a682830742d3 100644
> --- a/kernel/utsname.c
> +++ b/kernel/utsname.c
> @@ -103,11 +103,6 @@ void free_uts_ns(struct uts_namespace *ns)
>  	kfree_rcu(ns, ns.ns_rcu);
>  }
>  
> -static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct uts_namespace, ns);
> -}
> -
>  static struct ns_common *utsns_get(struct task_struct *task)
>  {
>  	struct uts_namespace *ns = NULL;
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 169ec22c4758..a57b3cda8dbc 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -1541,11 +1541,6 @@ static struct ns_common *netns_get(struct task_struct *task)
>  	return net ? &net->ns : NULL;
>  }
>  
> -static inline struct net *to_net_ns(struct ns_common *ns)
> -{
> -	return container_of(ns, struct net, ns);
> -}
> -
>  static void netns_put(struct ns_common *ns)
>  {
>  	put_net(to_net_ns(ns));
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

