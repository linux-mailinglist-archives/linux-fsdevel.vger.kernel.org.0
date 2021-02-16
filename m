Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407D531CE07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 17:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhBPQ2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 11:28:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:38394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhBPQ2i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:28:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B0DB5AD3E;
        Tue, 16 Feb 2021 16:27:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 409231F2AA7; Tue, 16 Feb 2021 17:27:54 +0100 (CET)
Date:   Tue, 16 Feb 2021 17:27:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH 1/2] fanotify: configurable limits via sysfs
Message-ID: <20210216162754.GF21108@quack2.suse.cz>
References: <20210124184204.899729-1-amir73il@gmail.com>
 <20210124184204.899729-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124184204.899729-2-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!


I'm sorry that I've got to this only now.

On Sun 24-01-21 20:42:03, Amir Goldstein wrote:
> fanotify has some hardcoded limits. The only APIs to escape those limits
> are FAN_UNLIMITED_QUEUE and FAN_UNLIMITED_MARKS.
> 
> Allow finer grained tuning of the system limits via sysfs tunables under
> /proc/sys/fs/fanotify/, similar to tunables under /proc/sys/fs/inotify,
> with some minor differences.
> 
> - max_queued_events - global system tunable for group queue size limit.
>   Like the inotify tunable with the same name, it defaults to 16384 and
>   applies on initialization of a new group.
> 
> - max_listener_marks - global system tunable of marks limit per group.
>   Defaults to 8192. inotify has no per group marks limit.
> 
> - max_user_marks - user ns tunable for marks limit per user.
>   Like the inotify tunable named max_user_watches, it defaults to 1048576
>   and is accounted for every containing user ns.
> 
> - max_user_listeners - user ns tunable for number of listeners per user.
>   Like the inotify tunable named max_user_instances, it defaults to 128
>   and is accounted for every containing user ns.

I think term 'group' is used in the manpages even more and in the code as
well. 'listener' more generally tends to refer to the application listening
to the events. So I'd rather call the limits 'max_group_marks' and
'max_user_groups'.
 
> The slightly different tunable names are derived from the "listener" and
> "mark" terminology used in the fanotify man pages.
> 
> max_listener_marks was kept for compatibility with legacy fanotify
> behavior. Given that inotify max_user_instances was increased from 8192
> to 1048576 in kernel v5.10, we may want to consider changing also the
> default for max_listener_marks or remove it completely, leaving only the
> per user marks limit.

Yes, probably I'd just drop 'max_group_marks' completely and leave just
per-user marks limit. You can always tune it in init_user_ns if you wish.
Can't you?

Also as a small style nit, please try to stay within 80 columns. Otherwise
the patch looks OK to me.

								Honza


> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fanotify/fanotify.c      |  14 ++--
>  fs/notify/fanotify/fanotify_user.c | 106 ++++++++++++++++++++++++-----
>  include/linux/fanotify.h           |   3 +
>  include/linux/fsnotify_backend.h   |   2 +-
>  include/linux/sched/user.h         |   3 -
>  include/linux/user_namespace.h     |   4 ++
>  kernel/sysctl.c                    |  12 +++-
>  kernel/ucount.c                    |   4 ++
>  8 files changed, 121 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 1192c9953620..aaa81ce916c3 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -736,11 +736,8 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  
>  static void fanotify_free_group_priv(struct fsnotify_group *group)
>  {
> -	struct user_struct *user;
> -
> -	user = group->fanotify_data.user;
> -	atomic_dec(&user->fanotify_listeners);
> -	free_uid(user);
> +	if (group->fanotify_data.ucounts)
> +		dec_ucount(group->fanotify_data.ucounts, UCOUNT_FANOTIFY_LISTENERS);
>  }
>  
>  static void fanotify_free_path_event(struct fanotify_event *event)
> @@ -796,6 +793,12 @@ static void fanotify_free_event(struct fsnotify_event *fsn_event)
>  	}
>  }
>  
> +static void fanotify_freeing_mark(struct fsnotify_mark *mark,
> +				  struct fsnotify_group *group)
> +{
> +	dec_ucount(group->fanotify_data.ucounts, UCOUNT_FANOTIFY_MARKS);
> +}
> +
>  static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
>  {
>  	kmem_cache_free(fanotify_mark_cache, fsn_mark);
> @@ -805,5 +808,6 @@ const struct fsnotify_ops fanotify_fsnotify_ops = {
>  	.handle_event = fanotify_handle_event,
>  	.free_group_priv = fanotify_free_group_priv,
>  	.free_event = fanotify_free_event,
> +	.freeing_mark = fanotify_freeing_mark,
>  	.free_mark = fanotify_free_mark,
>  };
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index b78dd1f88f7c..4ade3f9df337 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -27,8 +27,65 @@
>  #include "fanotify.h"
>  
>  #define FANOTIFY_DEFAULT_MAX_EVENTS	16384
> -#define FANOTIFY_DEFAULT_MAX_MARKS	8192
> +#define FANOTIFY_OLD_DEFAULT_MAX_MARKS	8192
>  #define FANOTIFY_DEFAULT_MAX_LISTENERS	128
> +/*
> + * Legacy fanotify marks limits is per group and we introduced an additional
> + * limit of marks per user, similar to inotify.  Effectively, the legacy limit
> + * of fanotify marks per user is <max marks per group> * <max groups per user>.
> + * This default limit (1M) also happens to match the increased limit for inotify
> + * max_user_watches since v5.10.
> + */
> +#define FANOTIFY_DEFAULT_MAX_LISTENER_MARKS \
> +	FANOTIFY_OLD_DEFAULT_MAX_MARKS
> +#define FANOTIFY_DEFAULT_MAX_USER_MARKS	\
> +	(FANOTIFY_DEFAULT_MAX_LISTENER_MARKS * FANOTIFY_DEFAULT_MAX_LISTENERS)
> +
> +/* configurable via /proc/sys/fs/fanotify/ */
> +static int fanotify_max_queued_events __read_mostly;
> +static int fanotify_max_listener_marks __read_mostly;
> +
> +#ifdef CONFIG_SYSCTL
> +
> +#include <linux/sysctl.h>
> +
> +struct ctl_table fanotify_table[] = {
> +	{
> +		.procname	= "max_user_listeners",
> +		.data		= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_LISTENERS],
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +	},
> +	{
> +		.procname	= "max_user_marks",
> +		.data		= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_MARKS],
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +	},
> +	{
> +		.procname	= "max_listener_marks",
> +		.data		= &fanotify_max_listener_marks,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO
> +	},
> +	{
> +		.procname	= "max_queued_events",
> +		.data		= &fanotify_max_queued_events,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO
> +	},
> +	{ }
> +};
> +#endif /* CONFIG_SYSCTL */
> +
>  
>  /*
>   * All flags that may be specified in parameter event_f_flags of fanotify_init.
> @@ -822,24 +879,36 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>  						   unsigned int type,
>  						   __kernel_fsid_t *fsid)
>  {
> +	struct ucounts *ucounts = group->fanotify_data.ucounts;
>  	struct fsnotify_mark *mark;
>  	int ret;
>  
> -	if (atomic_read(&group->num_marks) > group->fanotify_data.max_marks)
> +	/*
> +	 * Enfore global limit of marks per group and limit of marks per user
> +	 * for the user that initiated the group in all containing user ns.
> +	 */
> +	if (atomic_read(&group->num_marks) > group->fanotify_data.max_marks ||
> +	    !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
>  		return ERR_PTR(-ENOSPC);
>  
>  	mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
> -	if (!mark)
> -		return ERR_PTR(-ENOMEM);
> +	if (!mark) {
> +		ret = -ENOMEM;
> +		goto out_dec_ucounts;
> +	}
>  
>  	fsnotify_init_mark(mark, group);
>  	ret = fsnotify_add_mark_locked(mark, connp, type, 0, fsid);
>  	if (ret) {
>  		fsnotify_put_mark(mark);
> -		return ERR_PTR(ret);
> +		goto out_dec_ucounts;
>  	}
>  
>  	return mark;
> +
> +out_dec_ucounts:
> +	dec_ucount(ucounts, UCOUNT_FANOTIFY_MARKS);
> +	return ERR_PTR(ret);
>  }
>  
>  
> @@ -924,7 +993,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  {
>  	struct fsnotify_group *group;
>  	int f_flags, fd;
> -	struct user_struct *user;
>  	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
>  	unsigned int class = flags & FANOTIFY_CLASS_BITS;
>  
> @@ -963,12 +1031,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	if ((fid_mode & FAN_REPORT_NAME) && !(fid_mode & FAN_REPORT_DIR_FID))
>  		return -EINVAL;
>  
> -	user = get_current_user();
> -	if (atomic_read(&user->fanotify_listeners) > FANOTIFY_DEFAULT_MAX_LISTENERS) {
> -		free_uid(user);
> -		return -EMFILE;
> -	}
> -
>  	f_flags = O_RDWR | FMODE_NONOTIFY;
>  	if (flags & FAN_CLOEXEC)
>  		f_flags |= O_CLOEXEC;
> @@ -978,13 +1040,18 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
>  	group = fsnotify_alloc_user_group(&fanotify_fsnotify_ops);
>  	if (IS_ERR(group)) {
> -		free_uid(user);
>  		return PTR_ERR(group);
>  	}
>  
> -	group->fanotify_data.user = user;
> +	/* Enforce listeners limits per user in all containing user ns */
> +	group->fanotify_data.ucounts = inc_ucount(current_user_ns(), current_euid(),
> +						  UCOUNT_FANOTIFY_LISTENERS);
> +	if (!group->fanotify_data.ucounts) {
> +		fd = -EMFILE;
> +		goto out_destroy_group;
> +	}
> +
>  	group->fanotify_data.flags = flags;
> -	atomic_inc(&user->fanotify_listeners);
>  	group->memcg = get_mem_cgroup_from_mm(current->mm);
>  
>  	group->overflow_event = fanotify_alloc_overflow_event();
> @@ -1019,7 +1086,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  			goto out_destroy_group;
>  		group->max_events = UINT_MAX;
>  	} else {
> -		group->max_events = FANOTIFY_DEFAULT_MAX_EVENTS;
> +		group->max_events = fanotify_max_queued_events;
>  	}
>  
>  	if (flags & FAN_UNLIMITED_MARKS) {
> @@ -1028,7 +1095,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  			goto out_destroy_group;
>  		group->fanotify_data.max_marks = UINT_MAX;
>  	} else {
> -		group->fanotify_data.max_marks = FANOTIFY_DEFAULT_MAX_MARKS;
> +		group->fanotify_data.max_marks = fanotify_max_listener_marks;
>  	}
>  
>  	if (flags & FAN_ENABLE_AUDIT) {
> @@ -1326,6 +1393,11 @@ static int __init fanotify_user_setup(void)
>  			KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
>  	}
>  
> +	fanotify_max_queued_events = FANOTIFY_DEFAULT_MAX_EVENTS;
> +	fanotify_max_listener_marks = FANOTIFY_DEFAULT_MAX_LISTENER_MARKS;
> +	init_user_ns.ucount_max[UCOUNT_FANOTIFY_LISTENERS] = FANOTIFY_DEFAULT_MAX_LISTENERS;
> +	init_user_ns.ucount_max[UCOUNT_FANOTIFY_MARKS] = FANOTIFY_DEFAULT_MAX_USER_MARKS;
> +
>  	return 0;
>  }
>  device_initcall(fanotify_user_setup);
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 3e9c56ee651f..031a97d8369a 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -2,8 +2,11 @@
>  #ifndef _LINUX_FANOTIFY_H
>  #define _LINUX_FANOTIFY_H
>  
> +#include <linux/sysctl.h>
>  #include <uapi/linux/fanotify.h>
>  
> +extern struct ctl_table fanotify_table[]; /* for sysctl */
> +
>  #define FAN_GROUP_FLAG(group, flag) \
>  	((group)->fanotify_data.flags & (flag))
>  
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index e5409b83e731..2179f06f6e89 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -240,7 +240,7 @@ struct fsnotify_group {
>  			int flags;           /* flags from fanotify_init() */
>  			int f_flags; /* event_f_flags from fanotify_init() */
>  			unsigned int max_marks;
> -			struct user_struct *user;
> +			struct ucounts *ucounts;
>  		} fanotify_data;
>  #endif /* CONFIG_FANOTIFY */
>  	};
> diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
> index a8ec3b6093fc..3632c5d6ec55 100644
> --- a/include/linux/sched/user.h
> +++ b/include/linux/sched/user.h
> @@ -14,9 +14,6 @@ struct user_struct {
>  	refcount_t __count;	/* reference count */
>  	atomic_t processes;	/* How many processes does this user have? */
>  	atomic_t sigpending;	/* How many pending signals does this user have? */
> -#ifdef CONFIG_FANOTIFY
> -	atomic_t fanotify_listeners;
> -#endif
>  #ifdef CONFIG_EPOLL
>  	atomic_long_t epoll_watches; /* The number of file descriptors currently watched */
>  #endif
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 64cf8ebdc4ec..d8e6ff5e1040 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -49,6 +49,10 @@ enum ucount_type {
>  #ifdef CONFIG_INOTIFY_USER
>  	UCOUNT_INOTIFY_INSTANCES,
>  	UCOUNT_INOTIFY_WATCHES,
> +#endif
> +#ifdef CONFIG_FANOTIFY
> +	UCOUNT_FANOTIFY_LISTENERS,
> +	UCOUNT_FANOTIFY_MARKS,
>  #endif
>  	UCOUNT_COUNTS,
>  };
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index c9fbdd848138..46c86830b811 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -148,6 +148,9 @@ static unsigned long hung_task_timeout_max = (LONG_MAX/HZ);
>  #ifdef CONFIG_INOTIFY_USER
>  #include <linux/inotify.h>
>  #endif
> +#ifdef CONFIG_FANOTIFY
> +#include <linux/fanotify.h>
> +#endif
>  
>  #ifdef CONFIG_PROC_SYSCTL
>  
> @@ -3258,7 +3261,14 @@ static struct ctl_table fs_table[] = {
>  		.mode		= 0555,
>  		.child		= inotify_table,
>  	},
> -#endif	
> +#endif
> +#ifdef CONFIG_FANOTIFY
> +	{
> +		.procname	= "fanotify",
> +		.mode		= 0555,
> +		.child		= fanotify_table,
> +	},
> +#endif
>  #ifdef CONFIG_EPOLL
>  	{
>  		.procname	= "epoll",
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 11b1596e2542..edeabc5de28f 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -73,6 +73,10 @@ static struct ctl_table user_table[] = {
>  #ifdef CONFIG_INOTIFY_USER
>  	UCOUNT_ENTRY("max_inotify_instances"),
>  	UCOUNT_ENTRY("max_inotify_watches"),
> +#endif
> +#ifdef CONFIG_FANOTIFY
> +	UCOUNT_ENTRY("max_fanotify_listeners"),
> +	UCOUNT_ENTRY("max_fanotify_marks"),
>  #endif
>  	{ }
>  };
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
