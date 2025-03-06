Return-Path: <linux-fsdevel+bounces-43323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37271A545AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 09:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BED61883DB5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 08:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74F02080FB;
	Thu,  6 Mar 2025 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdOqRN92"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B622063F8;
	Thu,  6 Mar 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251560; cv=none; b=umSo49/D3jdiwndlUqgKfnDPlua4sIhkPqPyKriruYTQip2/6m4pXqqNv5qStP4PCdElqF6cju8WhfspKREHe/3t17d50ORwGGo47oZKwCVJx8uN3+rPsCUzJSxlcyxO9yPs0CwTuamJFfQunRGbG8b4MVqKlzaU6zXbamp+V9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251560; c=relaxed/simple;
	bh=w6Dn2/qTCu57870nK+uZAVm2dN+cuocLCxSK1mHE6HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy9OZ7lFylztRk5Z0gOxfp4M4y9DjH3+okZvGS8SYU3+Jzy+FtJfFN4V9E3Fph2tJ0OEyIFvcMzh8mG6PcFECeYz6I9rqtDczpIaa4OtYg4y853iACNC9dwH9rSOCUc71zIAi/q+XWPTgoYJKZOJuON9nc15+8h+yAINgSzwQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdOqRN92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5052C4CEE0;
	Thu,  6 Mar 2025 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741251559;
	bh=w6Dn2/qTCu57870nK+uZAVm2dN+cuocLCxSK1mHE6HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdOqRN92Ep0AQ/tPCJAzKM2hSvhWkyywYZZYaTNEDfO45ZtcBL7tBA8R/LEccME2y
	 KJHqApA4Am1WOSr9l6TMbMcyexBCVhLtuKB05WS7PvMGUPWIIX2Gkpm95X/hZMQHCc
	 57/Rel6d5bVGQxu10DNNnvfJsdkLQtyykmup5RrxpHV/zZJ41eia4UT6hZvkiLVTMn
	 qJMfjq/m48Ni2ZL5h/N1WwAZLAX5ZvI/w3E1mrSLiwTfvdBCj7Jpuy3U/0KvYsdFut
	 OBMd4zkRmnvjQOZx1I6UfbmI96hKZbu/uc6/apC4HEYeWgfUl+bvp9zPR7TMOQyaXJ
	 nOCRCB7WRCoew==
Date: Thu, 6 Mar 2025 09:59:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/2] pid: Optional first-fit pid allocation
Message-ID: <20250306-esskultur-sitzheizung-d482c4a35f80@brauner>
References: <20250221170249.890014-1-mkoutny@suse.com>
 <20250221170249.890014-3-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221170249.890014-3-mkoutny@suse.com>

On Fri, Feb 21, 2025 at 06:02:49PM +0100, Michal Koutný wrote:
> Noone would need to use this allocation strategy (it's slower, pid
> numbers collide sooner). Its primary purpose are pid namespaces in
> conjunction with pids.max cgroup limit which keeps (virtual) pid numbers
> below the given limit. This is for 32-bit userspace programs that may
> not work well with pid numbers above 65536.
> 
> Link: https://lore.kernel.org/r/20241122132459.135120-1-aleksandr.mikhalitsyn@canonical.com/
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst |  2 ++
>  include/linux/pid_namespace.h               |  3 +++
>  kernel/pid.c                                | 12 +++++++--
>  kernel/pid_namespace.c                      | 28 +++++++++++++++------
>  4 files changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index a43b78b4b6464..f5e68d1c8849f 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1043,6 +1043,8 @@ The last pid allocated in the current (the one task using this sysctl
>  lives in) pid namespace. When selecting a pid for a next task on fork
>  kernel tries to allocate a number starting from this one.
>  
> +When set to -1, first-fit pid numbering is used instead of the next-fit.

I strongly disagree with this approach. This is way worse then making
pid_max per pid namespace.

I'm fine if you come up with something else that's purely based on
cgroups somehow and is uniform across 64-bit and 32-bit. Allowing to
change the pid allocation strategy just for 32-bit is not the solution
and not mergable.

> +
>  
>  powersave-nap (PPC only)
>  ========================
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index f9f9931e02d6a..10bf66ca78590 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -41,6 +41,9 @@ struct pid_namespace {
>  #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
>  	int memfd_noexec_scope;
>  #endif
> +#ifdef CONFIG_IA32_EMULATION
> +	bool pid_noncyclic;
> +#endif
>  } __randomize_layout;
>  
>  extern struct pid_namespace init_pid_ns;
> diff --git a/kernel/pid.c b/kernel/pid.c
> index aa2a7d4da4555..e9da1662b8821 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -191,6 +191,10 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  
>  	for (i = ns->level; i >= 0; i--) {
>  		int tid = 0;
> +		bool pid_noncyclic = 0;
> +#ifdef CONFIG_IA32_EMULATION
> +		pid_noncyclic = READ_ONCE(tmp->pid_noncyclic);
> +#endif
>  
>  		if (set_tid_size) {
>  			tid = set_tid[ns->level - i];
> @@ -235,8 +239,12 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  			 * Store a null pointer so find_pid_ns does not find
>  			 * a partially initialized PID (see below).
>  			 */
> -			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> -					      pid_max, GFP_ATOMIC);
> +			if (likely(!pid_noncyclic))
> +				nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> +						      pid_max, GFP_ATOMIC);
> +			else
> +				nr = idr_alloc(&tmp->idr, NULL, pid_min,
> +						      pid_max, GFP_ATOMIC);
>  		}
>  		spin_unlock_irq(&pidmap_lock);
>  		idr_preload_end();
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 0f23285be4f92..ceda94a064294 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -113,6 +113,9 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
>  	ns->pid_allocated = PIDNS_ADDING;
>  #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
>  	ns->memfd_noexec_scope = pidns_memfd_noexec_scope(parent_pid_ns);
> +#endif
> +#ifdef CONFIG_IA32_EMULATION
> +	ns->pid_noncyclic = READ_ONCE(parent_pid_ns->pid_noncyclic);
>  #endif
>  	return ns;
>  
> @@ -260,7 +263,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
>  	return;
>  }
>  
> -#ifdef CONFIG_CHECKPOINT_RESTORE
> +#if defined(CONFIG_CHECKPOINT_RESTORE) || defined(CONFIG_IA32_EMULATION)
>  static int pid_ns_ctl_handler(const struct ctl_table *table, int write,
>  		void *buffer, size_t *lenp, loff_t *ppos)
>  {
> @@ -271,12 +274,23 @@ static int pid_ns_ctl_handler(const struct ctl_table *table, int write,
>  	if (write && !checkpoint_restore_ns_capable(pid_ns->user_ns))
>  		return -EPERM;
>  
> -	next = idr_get_cursor(&pid_ns->idr) - 1;
> +	next = -1;
> +#ifdef CONFIG_IA32_EMULATION
> +	if (!pid_ns->pid_noncyclic)
> +#endif
> +		next += idr_get_cursor(&pid_ns->idr);
>  
>  	tmp.data = &next;
>  	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
> -	if (!ret && write)
> -		idr_set_cursor(&pid_ns->idr, next + 1);
> +	if (!ret && write) {
> +		if (next > -1)
> +			idr_set_cursor(&pid_ns->idr, next + 1);
> +		else if (!IS_ENABLED(CONFIG_IA32_EMULATION))
> +			ret = -EINVAL;
> +#ifdef CONFIG_IA32_EMULATION
> +		WRITE_ONCE(pid_ns->pid_noncyclic, next == -1);
> +#endif
> +	}
>  
>  	return ret;
>  }
> @@ -288,11 +302,11 @@ static const struct ctl_table pid_ns_ctl_table[] = {
>  		.maxlen = sizeof(int),
>  		.mode = 0666, /* permissions are checked in the handler */
>  		.proc_handler = pid_ns_ctl_handler,
> -		.extra1 = SYSCTL_ZERO,
> +		.extra1 = SYSCTL_NEG_ONE,
>  		.extra2 = &pid_max,
>  	},
>  };
> -#endif	/* CONFIG_CHECKPOINT_RESTORE */
> +#endif	/* CONFIG_CHECKPOINT_RESTORE || CONFIG_IA32_EMULATION */
>  
>  int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
>  {
> @@ -449,7 +463,7 @@ static __init int pid_namespaces_init(void)
>  {
>  	pid_ns_cachep = KMEM_CACHE(pid_namespace, SLAB_PANIC | SLAB_ACCOUNT);
>  
> -#ifdef CONFIG_CHECKPOINT_RESTORE
> +#if defined(CONFIG_CHECKPOINT_RESTORE) || defined(CONFIG_IA32_EMULATION)
>  	register_sysctl_init("kernel", pid_ns_ctl_table);
>  #endif
>  
> -- 
> 2.48.1
> 

