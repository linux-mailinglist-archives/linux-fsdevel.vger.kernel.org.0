Return-Path: <linux-fsdevel+bounces-35287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726689D3663
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01D01F2179F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698D418A6DB;
	Wed, 20 Nov 2024 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pE8kEEin"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C190D136A;
	Wed, 20 Nov 2024 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093596; cv=none; b=UmLc2aocgJmhC0AJndgBDty5J0g6Ocoy0yVOMd8mC9W3tZJudK+TdHRcglU6BqpqT3IcCycSjSyYtfQeeu0FTAop1CMdRVnx6X0ff29I1c0SyRIavhbj+5mutSUWMtsIIMnINyCgSeeikn1ClCOsE6eVpQuM1/ue6cHtnhvsTeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093596; c=relaxed/simple;
	bh=RjFEASiXouGEWltEdLpjIE7k3PSCXSk+oThgMwY6pn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efHH/IYeekkMUgHBr2drzuah6M5dtPeeliBTaDg/S3LE9Dpe356sBwjk3TYIZgVeThINZy19yi65L4JfDRqyERYiUbXVfH1RUtR15Q6TDXngfTb+5FWM2AX0zA0Rmvr2uA1Xf/0waYZMuC7Mx4f447OOCz88KlYbYCE6mJfN+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pE8kEEin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A0DC4CECD;
	Wed, 20 Nov 2024 09:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093595;
	bh=RjFEASiXouGEWltEdLpjIE7k3PSCXSk+oThgMwY6pn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pE8kEEinf6fceTPzUuGpjxu2k9pzM9x1fRRzCixYYgsm1ygNOVatXmhOZtUMedsYe
	 wTylAv4PbITXLG7zohKX+bYzRQm8IEipaolnG/ZayHtAYlCQdBQgxaID80Sanx+0Yr
	 ap5CyJViWpPd7Bcye2j/OAI/Mx5rYxsrDiHQM/gP+pRhUfpn58skL1mMI0niBGIIVm
	 gFj0ZjaY9ODlpKPlNOMxvL9lnCAcrJDhkNgvNoBgQfeuENXrtAbEHu7zWbWWy2BWeC
	 oIwWWkP/3so9o55AEIk8xC4+I2sygOGqKfHnqIsVfvDwuSo2Tay98XgQCVzNu8+WQN
	 DI/DHaLBknsTA==
Date: Wed, 20 Nov 2024 10:06:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: stgraber@stgraber.org, tycho@tycho.pizza, cyphar@cyphar.com, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, mcgrof@kernel.org, kees@kernel.org, joel.granados@kernel.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel: add pid_max to pid_namespace
Message-ID: <20241120-entgiften-geldhahn-a9d2922ec3e0@brauner>
References: <20241105031024.3866383-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105031024.3866383-1-yun.zhou@windriver.com>

On Tue, Nov 05, 2024 at 11:10:24AM +0800, Yun Zhou wrote:
> It is necessary to have a different pid_max in different containers.
> For example, multiple containers are running on a host, one of which
> is Android, and its 32 bit bionic libc only accepts pid <= 65535. So
> it requires the global pid_max <= 65535. This will cause configuration
> conflicts with other containers and also limit the maximum number of
> tasks for the entire system.
> 
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---

Fwiw, I've done a patch like this years ago and then Alex revived it in
[1] including selftests! There's downsides to consider:

[1]: https://lore.kernel.org/lkml/20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com

>  - Remove sentinels from ctl_table arrays.
> v1 - https://lore.kernel.org/all/20241030052933.1041408-1-yun.zhou@windriver.com/
> ---
>  include/linux/pid_namespace.h     |  1 +
>  kernel/pid.c                      | 12 +++++------
>  kernel/pid_namespace.c            | 34 ++++++++++++++++++++++++++-----
>  kernel/sysctl.c                   |  9 --------
>  kernel/trace/pid_list.c           |  2 +-
>  kernel/trace/trace.h              |  2 --
>  kernel/trace/trace_sched_switch.c |  2 +-
>  7 files changed, 38 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index f9f9931e02d6..064cfe2542fc 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -38,6 +38,7 @@ struct pid_namespace {
>  	struct ucounts *ucounts;
>  	int reboot;	/* group exit code if this pidns was rebooted */
>  	struct ns_common ns;
> +	int pid_max;
>  #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
>  	int memfd_noexec_scope;
>  #endif
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 2715afb77eab..f8026a61436b 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -60,8 +60,6 @@ struct pid init_struct_pid = {
>  	}, }
>  };
>  
> -int pid_max = PID_MAX_DEFAULT;
> -
>  int pid_max_min = RESERVED_PIDS + 1;
>  int pid_max_max = PID_MAX_LIMIT;
>  /*
> @@ -78,6 +76,7 @@ static u64 pidfs_ino = RESERVED_PIDS;
>   */
>  struct pid_namespace init_pid_ns = {
>  	.ns.count = REFCOUNT_INIT(2),
> +	.pid_max = PID_MAX_DEFAULT,
>  	.idr = IDR_INIT(init_pid_ns.idr),
>  	.pid_allocated = PIDNS_ADDING,
>  	.level = 0,
> @@ -198,7 +197,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  			tid = set_tid[ns->level - i];
>  
>  			retval = -EINVAL;
> -			if (tid < 1 || tid >= pid_max)
> +			if (tid < 1 || tid >= tmp->pid_max)
>  				goto out_free;
>  			/*
>  			 * Also fail if a PID != 1 is requested and
> @@ -238,7 +237,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  			 * a partially initialized PID (see below).
>  			 */
>  			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> -					      pid_max, GFP_ATOMIC);
> +					      tmp->pid_max, GFP_ATOMIC);
>  		}
>  		spin_unlock_irq(&pidmap_lock);
>  		idr_preload_end();
> @@ -653,11 +652,12 @@ void __init pid_idr_init(void)
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
> index d70ab49d5b4a..a5a8254825d5 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -111,6 +111,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
>  	ns->user_ns = get_user_ns(user_ns);
>  	ns->ucounts = ucounts;
>  	ns->pid_allocated = PIDNS_ADDING;
> +	ns->pid_max = parent_pid_ns->pid_max;
>  #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
>  	ns->memfd_noexec_scope = pidns_memfd_noexec_scope(parent_pid_ns);
>  #endif
> @@ -280,19 +281,44 @@ static int pid_ns_ctl_handler(const struct ctl_table *table, int write,
>  
>  	return ret;
>  }
> +#endif	/* CONFIG_CHECKPOINT_RESTORE */
> +
> +static int pid_max_ns_ctl_handler(const struct ctl_table *table, int write,
> +		void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct pid_namespace *pid_ns = task_active_pid_ns(current);
> +	struct ctl_table tmp = *table;
> +
> +	if (write && !checkpoint_restore_ns_capable(pid_ns->user_ns))
> +		return -EPERM;
> +
> +	tmp.data = &pid_ns->pid_max;
> +	if (pid_ns->parent)
> +		tmp.extra2 = &pid_ns->parent->pid_max;
> +
> +	return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
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
>  	},
> -};
>  #endif	/* CONFIG_CHECKPOINT_RESTORE */
> +	{
> +		.procname = "pid_max",
> +		.maxlen = sizeof(int),
> +		.mode = 0644,
> +		.proc_handler = pid_max_ns_ctl_handler,
> +		.extra1 = &pid_max_min,
> +		.extra2 = &pid_max_max,
> +	},
> +};
>  
>  int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
>  {
> @@ -449,9 +475,7 @@ static __init int pid_namespaces_init(void)
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
> index 79e6cb1d5c48..676a0d675e7f 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1804,15 +1804,6 @@ static struct ctl_table kern_table[] = {
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
> index 4966e6bbdf6f..c62b9b3cfb3d 100644
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
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index c866991b9c78..e51851d64e4d 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -715,8 +715,6 @@ extern unsigned long tracing_thresh;
>  
>  /* PID filtering */
>  
> -extern int pid_max;
> -
>  bool trace_find_filtered_pid(struct trace_pid_list *filtered_pids,
>  			     pid_t search_pid);
>  bool trace_ignore_this_task(struct trace_pid_list *filtered_pids,
> diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
> index 8a407adb0e1c..c20c80abe065 100644
> --- a/kernel/trace/trace_sched_switch.c
> +++ b/kernel/trace/trace_sched_switch.c
> @@ -442,7 +442,7 @@ int trace_alloc_tgid_map(void)
>  	if (tgid_map)
>  		return 0;
>  
> -	tgid_map_max = pid_max;
> +	tgid_map_max = init_pid_ns.pid_max;
>  	map = kvcalloc(tgid_map_max + 1, sizeof(*tgid_map),
>  		       GFP_KERNEL);
>  	if (!map)
> -- 
> 2.27.0
> 

