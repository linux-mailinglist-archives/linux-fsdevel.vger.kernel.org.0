Return-Path: <linux-fsdevel+bounces-66732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DDBC2B4DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97DCC4F3D03
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9367C303A10;
	Mon,  3 Nov 2025 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKubhfGZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05DC30171A;
	Mon,  3 Nov 2025 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168927; cv=none; b=NaRA4DFgxX4g/lDOe6NV898xJ9TcSyyR34i1dR86Wj1QeTiSbodfOzcWMqpFPRGcmsv3v3lPPtVTT979h8nwe8YOJj2HwkVajlnER4icm4O1QNs3SJk5UavCNejEmXUuT4YiUgRlJVd++VMPhj7KHivLOI1/3o6wGWF+Dj5EjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168927; c=relaxed/simple;
	bh=zZlF5mFS0f/Oq95hrQaLrWEgcxubppt7A+bJPXZk8eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmPsyzbDY/7IJXhm1k+75I7CwI6JRH52HF2v53ZVeCvMYMYDZxQKYR1AHZBVSWtVuN1PXU0VHAGOB4auMhDRbUmN3K7hczWVmKzvXNx6+oF7AvusCfmN34pydvsTJEtdvTm0wZzdumwR0SiK82G3jH6o+wUdXUT7H9US2HWNtls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKubhfGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD38C4CEE7;
	Mon,  3 Nov 2025 11:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762168926;
	bh=zZlF5mFS0f/Oq95hrQaLrWEgcxubppt7A+bJPXZk8eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tKubhfGZ1E3MStl1BRbOzd2Q8vO1r0ckcnlGtZNrHz/RNHeEjLwXnDvVXIV0c6TYz
	 KNKPv8aObnAuFGp3Z55H2JmW2+92bW4vRZjS6IyEegkcbwMNRWtRu2UToQNkZtro3m
	 g5ozgD6/Jbdhk/RN4XxvUAr9UjaLb5OhQbBUBf8tfJcg4LetahlzKygwN78VAKG3bY
	 uLgDEg203RIUt31Ie/o7VV8TTHy94ZLqBWKZZl73KTARp2BEgaa5nygNPr90jeKk+F
	 KHH2mNubBAoPfyxFwy7RZ6a4g/BnE+ssGrAYUXuaYea164SPMWY5wjkLX/RGhBvut8
	 5GzQycJcNdYWg==
Date: Mon, 3 Nov 2025 12:21:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 18/72] nstree: add unified namespace list
Message-ID: <20251103-morsch-kunst-e8d040981325@brauner>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
 <20251029-work-namespace-nstree-listns-v4-18-2e6f823ebdc0@kernel.org>
 <87ecqhy2y5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ecqhy2y5.ffs@tglx>

On Sat, Nov 01, 2025 at 08:20:50PM +0100, Thomas Gleixner wrote:
> Christian!
> 
> On Wed, Oct 29 2025 at 13:20, Christian Brauner wrote:
> > --- a/kernel/time/namespace.c
> > +++ b/kernel/time/namespace.c
> > @@ -488,6 +488,7 @@ struct time_namespace init_time_ns = {
> >  	.ns.ns_owner = LIST_HEAD_INIT(init_time_ns.ns.ns_owner),
> >  	.frozen_offsets	= true,
> >  	.ns.ns_list_node = LIST_HEAD_INIT(init_time_ns.ns.ns_list_node),
> > +	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_time_ns.ns.ns_unified_list_node),
> 
> Sorry that I did not catch that earlier, but
> 
>   1) this screws up the proper tabular struct initializer
> 
>   2) the churn of touching every compile time struct each time you add a
>      new field and add the same stupid initialization to each of them
>      can be avoided, when you do something like the uncompiled below.
>      You get the idea.
> 
> Thanks,

Nice! I'm stealing that and I'll slap a Suggested-by for you on it.
Thanks!

> 
>         tglx
> ---
>  fs/namespace.c            |    9 +--------
>  include/linux/ns_common.h |   12 ++++++++++++
>  init/version-timestamp.c  |    9 +--------
>  ipc/msgutil.c             |    9 +--------
>  kernel/pid.c              |    8 +-------
>  kernel/time/namespace.c   |    9 +--------
>  kernel/user.c             |    9 +--------
>  7 files changed, 18 insertions(+), 47 deletions(-)
> 
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5985,19 +5985,12 @@ SYSCALL_DEFINE4(listmount, const struct
>  }
>  
>  struct mnt_namespace init_mnt_ns = {
> -	.ns.inum	= ns_init_inum(&init_mnt_ns),
> +	.ns		= NS_COMMON_INIT(init_mnt_ns, 1, 1),
>  	.ns.ops		= &mntns_operations,
>  	.user_ns	= &init_user_ns,
> -	.ns.__ns_ref	= REFCOUNT_INIT(1),
> -	.ns.__ns_ref_active = ATOMIC_INIT(1),
> -	.ns.ns_type	= ns_common_type(&init_mnt_ns),
>  	.passive	= REFCOUNT_INIT(1),
>  	.mounts		= RB_ROOT,
>  	.poll		= __WAIT_QUEUE_HEAD_INITIALIZER(init_mnt_ns.poll),
> -	.ns.ns_list_node = LIST_HEAD_INIT(init_mnt_ns.ns.ns_list_node),
> -	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_mnt_ns.ns.ns_unified_list_node),
> -	.ns.ns_owner_entry = LIST_HEAD_INIT(init_mnt_ns.ns.ns_owner_entry),
> -	.ns.ns_owner = LIST_HEAD_INIT(init_mnt_ns.ns.ns_owner),
>  };
>  
>  static void __init init_mount_tree(void)
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -129,6 +129,18 @@ struct ns_common {
>  	};
>  };
>  
> +#define NS_COMMON_INIT(nsname, refs, active)						\
> +{											\
> +	.ns_type		= ns_common_type(&nsname),				\
> +	.inum			= ns_init_inum(&nsname),				\
> +	.__ns_ref		= REFCOUNT_INIT(refs),					\
> +	.__ns_ref_active	= ATOMIC_INIT(active),					\
> +	.ns_list_node		= LIST_HEAD_INIT(nsname.ns.ns_list_node),		\
> +	.ns_unified_list_node	= LIST_HEAD_INIT(nsname.ns.ns_unified_list_node),	\
> +	.ns_owner_entry		= LIST_HEAD_INIT(nsname.ns.ns_owner_entry),		\
> +	.ns_owner		= LIST_HEAD_INIT(nsname.ns.ns_owner),			\
> +}
> +
>  int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum);
>  void __ns_common_free(struct ns_common *ns);
>  
> --- a/init/version-timestamp.c
> +++ b/init/version-timestamp.c
> @@ -8,9 +8,7 @@
>  #include <linux/utsname.h>
>  
>  struct uts_namespace init_uts_ns = {
> -	.ns.ns_type = ns_common_type(&init_uts_ns),
> -	.ns.__ns_ref = REFCOUNT_INIT(2),
> -	.ns.__ns_ref_active = ATOMIC_INIT(1),
> +	.ns = NS_COMMON_INIT(init_uts_ns, 2, 1),
>  	.name = {
>  		.sysname	= UTS_SYSNAME,
>  		.nodename	= UTS_NODENAME,
> @@ -20,11 +18,6 @@ struct uts_namespace init_uts_ns = {
>  		.domainname	= UTS_DOMAINNAME,
>  	},
>  	.user_ns = &init_user_ns,
> -	.ns.inum = ns_init_inum(&init_uts_ns),
> -	.ns.ns_list_node = LIST_HEAD_INIT(init_uts_ns.ns.ns_list_node),
> -	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_uts_ns.ns.ns_unified_list_node),
> -	.ns.ns_owner_entry = LIST_HEAD_INIT(init_uts_ns.ns.ns_owner_entry),
> -	.ns.ns_owner = LIST_HEAD_INIT(init_uts_ns.ns.ns_owner),
>  #ifdef CONFIG_UTS_NS
>  	.ns.ops = &utsns_operations,
>  #endif
> --- a/ipc/msgutil.c
> +++ b/ipc/msgutil.c
> @@ -27,18 +27,11 @@ DEFINE_SPINLOCK(mq_lock);
>   * and not CONFIG_IPC_NS.
>   */
>  struct ipc_namespace init_ipc_ns = {
> -	.ns.__ns_ref = REFCOUNT_INIT(1),
> -	.ns.__ns_ref_active = ATOMIC_INIT(1),
> +	.ns = NS_COMMON_INIT(init_ipc_ns, 1, 1),
>  	.user_ns = &init_user_ns,
> -	.ns.inum = ns_init_inum(&init_ipc_ns),
> -	.ns.ns_list_node = LIST_HEAD_INIT(init_ipc_ns.ns.ns_list_node),
> -	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_ipc_ns.ns.ns_unified_list_node),
> -	.ns.ns_owner_entry = LIST_HEAD_INIT(init_ipc_ns.ns.ns_owner_entry),
> -	.ns.ns_owner = LIST_HEAD_INIT(init_ipc_ns.ns.ns_owner),
>  #ifdef CONFIG_IPC_NS
>  	.ns.ops = &ipcns_operations,
>  #endif
> -	.ns.ns_type = ns_common_type(&init_ipc_ns),
>  };
>  
>  struct msg_msgseg {
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -71,18 +71,12 @@ static int pid_max_max = PID_MAX_LIMIT;
>   * the scheme scales to up to 4 million PIDs, runtime.
>   */
>  struct pid_namespace init_pid_ns = {
> -	.ns.__ns_ref = REFCOUNT_INIT(2),
> -	.ns.__ns_ref_active = ATOMIC_INIT(1),
> +	.ns = NS_COMMON_INIT(init_pid_ns, 2, 1),
>  	.idr = IDR_INIT(init_pid_ns.idr),
>  	.pid_allocated = PIDNS_ADDING,
>  	.level = 0,
>  	.child_reaper = &init_task,
>  	.user_ns = &init_user_ns,
> -	.ns.inum = ns_init_inum(&init_pid_ns),
> -	.ns.ns_list_node = LIST_HEAD_INIT(init_pid_ns.ns.ns_list_node),
> -	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_pid_ns.ns.ns_unified_list_node),
> -	.ns.ns_owner_entry = LIST_HEAD_INIT(init_pid_ns.ns.ns_owner_entry),
> -	.ns.ns_owner = LIST_HEAD_INIT(init_pid_ns.ns.ns_owner),
>  #ifdef CONFIG_PID_NS
>  	.ns.ops = &pidns_operations,
>  #endif
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -478,17 +478,10 @@ const struct proc_ns_operations timens_f
>  };
>  
>  struct time_namespace init_time_ns = {
> -	.ns.ns_type	= ns_common_type(&init_time_ns),
> -	.ns.__ns_ref	= REFCOUNT_INIT(3),
> -	.ns.__ns_ref_active = ATOMIC_INIT(1),
> +	.ns		= NS_COMMON_INIT(init_time_ns, 3, 1),
>  	.user_ns	= &init_user_ns,
> -	.ns.inum	= ns_init_inum(&init_time_ns),
>  	.ns.ops		= &timens_operations,
> -	.ns.ns_owner_entry = LIST_HEAD_INIT(init_time_ns.ns.ns_owner_entry),
> -	.ns.ns_owner = LIST_HEAD_INIT(init_time_ns.ns.ns_owner),
>  	.frozen_offsets	= true,
> -	.ns.ns_list_node = LIST_HEAD_INIT(init_time_ns.ns.ns_list_node),
> -	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_time_ns.ns.ns_unified_list_node),
>  };
>  
>  void __init time_ns_init(void)
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -65,16 +65,9 @@ struct user_namespace init_user_ns = {
>  			.nr_extents = 1,
>  		},
>  	},
> -	.ns.ns_type = ns_common_type(&init_user_ns),
> -	.ns.__ns_ref = REFCOUNT_INIT(3),
> -	.ns.__ns_ref_active = ATOMIC_INIT(1),
> +	.ns = NS_COMMON_INIT(init_user_ns, 3, 1),
>  	.owner = GLOBAL_ROOT_UID,
>  	.group = GLOBAL_ROOT_GID,
> -	.ns.inum = ns_init_inum(&init_user_ns),
> -	.ns.ns_list_node = LIST_HEAD_INIT(init_user_ns.ns.ns_list_node),
> -	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_user_ns.ns.ns_unified_list_node),
> -	.ns.ns_owner_entry = LIST_HEAD_INIT(init_user_ns.ns.ns_owner_entry),
> -	.ns.ns_owner = LIST_HEAD_INIT(init_user_ns.ns.ns_owner),
>  #ifdef CONFIG_USER_NS
>  	.ns.ops = &userns_operations,
>  #endif

