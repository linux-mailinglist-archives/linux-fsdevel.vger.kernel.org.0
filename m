Return-Path: <linux-fsdevel+bounces-31017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA86990F80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97386283997
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25651F943B;
	Fri,  4 Oct 2024 19:04:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C681F9427;
	Fri,  4 Oct 2024 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068667; cv=none; b=XIF0LngfPpw31Y3euVcYtdSoGa+u7drWUo5sSmuU7A6e5yDGoMnAkNDGuT1W+ysvdBYYns3+5rcBWe/og8WOiEVl/WFFdmAQu2NNeXdsveoRMTra0Cf3Ymg20G+WG7INn3F8Ei2cjeadULopnWcN2t+bzyJkqyqOKcIDEaIs+IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068667; c=relaxed/simple;
	bh=2MpuodfLJmLx8CQl8yY7IALszfE+GszCrpWSPCvHPlY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXYsMtOdk8C5NWzZ1YUrzQbsEH4+XjvhaxHyiVr3bg2B7+tgYly6XO4jM2Orklz5vC8xwA1mbEhU1+YDmKjT1TPOu3hka/H/qEcCNE55TwFPfYaayqqhnwjlQcD++vKGCsb1PF3M+xheYZm0eiVmTFcRvpQBZgvFVNWxe9Ra0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C899CC4CEC6;
	Fri,  4 Oct 2024 19:04:25 +0000 (UTC)
Date: Fri, 4 Oct 2024 15:05:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel: add pid_max to pid_namespace
Message-ID: <20241004150521.361af760@gandalf.local.home>
In-Reply-To: <20240902114920.1534699-1-yun.zhou@windriver.com>
References: <20240902114920.1534699-1-yun.zhou@windriver.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 19:49:20 +0800
Yun Zhou <yun.zhou@windriver.com> wrote:


-ENOCHANGELOG

What? Why? Why should I care about this?

A change log *must* have all the information to say why this change is
necessary. It's OK for the subject to state what it is doing, but there
most definitely needs a "why?" in the change log.

-- Steve


> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>  include/linux/pid_namespace.h |  1 +
>  kernel/pid.c                  | 12 ++++++------
>  kernel/pid_namespace.c        | 33 ++++++++++++++++++++++++++++-----
>  kernel/sysctl.c               |  9 ---------
>  kernel/trace/pid_list.c       |  2 +-
>  kernel/trace/trace.c          |  2 +-
>  kernel/trace/trace.h          |  2 --
>  7 files changed, 37 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index f9f9931e02d6..0e3c18f3cac5 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -27,6 +27,7 @@ struct pid_namespace {
>  	struct idr idr;
>  	struct rcu_head rcu;
>  	unsigned int pid_allocated;
> +	int pid_max;
>  	struct task_struct *child_reaper;
>  	struct kmem_cache *pid_cachep;
>  	unsigned int level;
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 6500ef956f2f..14da3f68ceed 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -59,8 +59,6 @@ struct pid init_struct_pid = {
>  	}, }
>  };
>  
> -int pid_max = PID_MAX_DEFAULT;
> -
>  #define RESERVED_PIDS		300
>  
>  int pid_max_min = RESERVED_PIDS + 1;
> @@ -74,6 +72,7 @@ int pid_max_max = PID_MAX_LIMIT;
>   */
>  struct pid_namespace init_pid_ns = {
>  	.ns.count = REFCOUNT_INIT(2),
> +	.pid_max = PID_MAX_DEFAULT,
>  	.idr = IDR_INIT(init_pid_ns.idr),
>  	.pid_allocated = PIDNS_ADDING,
>  	.level = 0,
> @@ -194,7 +193,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  			tid = set_tid[ns->level - i];
>  
>  			retval = -EINVAL;
> -			if (tid < 1 || tid >= pid_max)
> +			if (tid < 1 || tid >= tmp->pid_max)
>  				goto out_free;
>  			/*
>  			 * Also fail if a PID != 1 is requested and
> @@ -234,7 +233,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  			 * a partially initialized PID (see below).
>  			 */
>  			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> -					      pid_max, GFP_ATOMIC);
> +					      tmp->pid_max, GFP_ATOMIC);
>  		}
>  		spin_unlock_irq(&pidmap_lock);
>  		idr_preload_end();
> @@ -651,11 +650,12 @@ void __init pid_idr_init(void)
>  	BUILD_BUG_ON(PID_MAX_LIMIT >= PIDNS_ADDING);
>  
>  	/* bump default and minimum pid_max based on number of cpus */
> -	pid_max = min(pid_max_max, max_t(int, pid_max,
> +	init_pid_ns.pid_max = min(pid_max_max, max_t(int, init_pid_ns.pid_max,
>  				PIDS_PER_CPU_DEFAULT * num_possible_cpus()));
>  	pid_max_min = max_t(int, pid_max_min,
>  				PIDS_PER_CPU_MIN * num_possible_cpus());
> -	pr_info("pid_max: default: %u minimum: %u\n", pid_max, pid_max_min);
> +	pr_info("pid_max: default: %u minimum: %u\n", init_pid_ns.pid_max,
> +			pid_max_min);
>  
>  	idr_init(&init_pid_ns.idr);
>  
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 3028b2218aa4..d6b3f34ecb25 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -110,6 +110,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
>  	ns->user_ns = get_user_ns(user_ns);
>  	ns->ucounts = ucounts;
>  	ns->pid_allocated = PIDNS_ADDING;
> +	ns->pid_max = parent_pid_ns->pid_max;
>  #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
>  	ns->memfd_noexec_scope = pidns_memfd_noexec_scope(parent_pid_ns);
>  #endif
> @@ -295,20 +296,44 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
>  
>  	return ret;
>  }
> +#endif	/* CONFIG_CHECKPOINT_RESTORE */
> +
> +static int pid_max_ns_ctl_handler(struct ctl_table *table, int write,
> +		void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct pid_namespace *pid_ns = task_active_pid_ns(current);
> +
> +	if (write && !checkpoint_restore_ns_capable(pid_ns->user_ns))
> +		return -EPERM;
> +
> +	table->data = &pid_ns->pid_max;
> +	if (pid_ns->parent)
> +		table->extra2 = &pid_ns->parent->pid_max;
> +
> +	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +}
>  
> -extern int pid_max;
>  static struct ctl_table pid_ns_ctl_table[] = {
> +#ifdef CONFIG_CHECKPOINT_RESTORE
>  	{
>  		.procname = "ns_last_pid",
>  		.maxlen = sizeof(int),
>  		.mode = 0666, /* permissions are checked in the handler */
>  		.proc_handler = pid_ns_ctl_handler,
>  		.extra1 = SYSCTL_ZERO,
> -		.extra2 = &pid_max,
> +		.extra2 = &init_pid_ns.pid_max,
> +	},
> +#endif	/* CONFIG_CHECKPOINT_RESTORE */
> +	{
> +		.procname	= "pid_max",
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= pid_max_ns_ctl_handler,
> +		.extra1		= &pid_max_min,
> +		.extra2		= &pid_max_max,
>  	},
>  	{ }
>  };
> -#endif	/* CONFIG_CHECKPOINT_RESTORE */
>  
>  int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
>  {
> @@ -465,9 +490,7 @@ static __init int pid_namespaces_init(void)
>  {
>  	pid_ns_cachep = KMEM_CACHE(pid_namespace, SLAB_PANIC | SLAB_ACCOUNT);
>  
> -#ifdef CONFIG_CHECKPOINT_RESTORE
>  	register_sysctl_init("kernel", pid_ns_ctl_table);
> -#endif
>  
>  	register_pid_ns_sysctl_table_vm();
>  	return 0;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 157f7ce2942d..857bfdb39b15 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1809,15 +1809,6 @@ static struct ctl_table kern_table[] = {
>  		.proc_handler	= proc_dointvec,
>  	},
>  #endif
> -	{
> -		.procname	= "pid_max",
> -		.data		= &pid_max,
> -		.maxlen		= sizeof (int),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= &pid_max_min,
> -		.extra2		= &pid_max_max,
> -	},
>  	{
>  		.procname	= "panic_on_oops",
>  		.data		= &panic_on_oops,
> diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
> index 95106d02b32d..ef52820e6719 100644
> --- a/kernel/trace/pid_list.c
> +++ b/kernel/trace/pid_list.c
> @@ -414,7 +414,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
>  	int i;
>  
>  	/* According to linux/thread.h, pids can be no bigger that 30 bits */
> -	WARN_ON_ONCE(pid_max > (1 << 30));
> +	WARN_ON_ONCE(init_pid_ns.pid_max > (1 << 30));
>  
>  	pid_list = kzalloc(sizeof(*pid_list), GFP_KERNEL);
>  	if (!pid_list)
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index fbcd3bafb93e..6295679ce16c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5415,7 +5415,7 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
>  
>  	if (mask == TRACE_ITER_RECORD_TGID) {
>  		if (!tgid_map) {
> -			tgid_map_max = pid_max;
> +			tgid_map_max = init_pid_ns.pid_max;
>  			map = kvcalloc(tgid_map_max + 1, sizeof(*tgid_map),
>  				       GFP_KERNEL);
>  
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index b7f4ea25a194..df61b1db86a2 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -700,8 +700,6 @@ extern unsigned long tracing_thresh;
>  
>  /* PID filtering */
>  
> -extern int pid_max;
> -
>  bool trace_find_filtered_pid(struct trace_pid_list *filtered_pids,
>  			     pid_t search_pid);
>  bool trace_ignore_this_task(struct trace_pid_list *filtered_pids,


