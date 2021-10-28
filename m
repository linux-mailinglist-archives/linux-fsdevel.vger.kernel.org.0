Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909DE43E525
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 17:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhJ1PdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 11:33:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39352 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhJ1PdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:33:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B3A50212CC;
        Thu, 28 Oct 2021 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635435031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T36UwH1/yGl7wulr/lS8k0fNFoAeRpKFikpRqVqZdLw=;
        b=qzi+TgFcQHGEygIXEJLpSeK6AKJoEq3YAErFHPoGnl/E2zUA7bDs87zQgiVdeIocHX6od5
        3dNKswNTRQBRxGOTa+KLTQSpq4qJnOUWjkzcfFURoLWz5hZKkIOebWI2DZHE6sgnKBlM0p
        hOehuShlkx7w+kKhNpn6cLdkw8A4/hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635435031;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T36UwH1/yGl7wulr/lS8k0fNFoAeRpKFikpRqVqZdLw=;
        b=WhaP+UTdjDByfhpYJ7Tq1osjCTigCpHWYdsBkEuNAA4TwyrqsevSr7aS1fNUQegJKte62/
        oA1v2EbI+J9T9XDg==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8D76FA3B83;
        Thu, 28 Oct 2021 15:30:30 +0000 (UTC)
Date:   Thu, 28 Oct 2021 16:30:28 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1] sched/numa: add per-process numa_balancing
Message-ID: <20211028153028.GP3891@suse.de>
References: <20211027132633.86653-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211027132633.86653-1-ligang.bdlg@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 09:26:32PM +0800, Gang Li wrote:
> This patch add a new api PR_NUMA_BALANCING in prctl.
> 
> A large number of page faults will cause performance loss when numa balancing
> is performing. Thus those processes which care about worst-case performance
> need numa balancing disabled. Others, on the contrary, allow a temporary
> performance loss in exchange for higher average performance, so enable numa
> balancing is better for them.
> 
> Numa balancing can only be controlled globally by /proc/sys/kernel/numa_balancing.
> Due to the above case, we want to disable/enable numa_balancing per-process
> instead.
> 
> Add numa_balancing under mm_struct. Then use it in task_tick_numa.
> 
> Disable/enable per-process numa balancing:
> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING, 0/1);
> Get numa_balancing state:
> 	prctl(PR_NUMA_BALANCING, PR_GET_NUMA_BALANCING, &ret);
> 	cat /proc/<pid>/status | grep NumaBalancing_enabled
> 
> mm->numa_balancing only works when global numa_balancing is enabled.
> When the global numa_balancing is diabled, mm->numa_blancing will not
> change, but you will always get 0 while you want to get process
> numa_balancing state and kernel will return err when you use prctl set
> it.
> 

This would also need a prctl(2) patch.

That aside though, the configuration space could be better. It's possible
to selectively disable NUMA balance but not selectively enable because
prctl is disabled if global NUMA balancing is disabled. That could be
somewhat achieved by having a default value for mm->numa_balancing based on
whether the global numa balancing is disabled via command line or sysctl
and enabling the static branch if prctl is used with an informational
message. This is not the only potential solution but as it stands,
there are odd semantic corner cases. For example, explicit enabling
of NUMA balancing by prctl gets silently revoked if numa balancing is
disabled via sysctl and prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING,
1) means nothing.

> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
>  Documentation/filesystems/proc.rst |  2 ++
>  fs/proc/task_mmu.c                 | 16 ++++++++++++
>  include/linux/mm_types.h           |  3 +++
>  include/uapi/linux/prctl.h         |  5 ++++
>  kernel/fork.c                      |  3 +++
>  kernel/sched/fair.c                |  3 +++
>  kernel/sys.c                       | 39 ++++++++++++++++++++++++++++++
>  7 files changed, 71 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 8d7f141c6fc7..b90f43ed0668 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -192,6 +192,7 @@ read the file /proc/PID/status::
>    VmLib:      1412 kB
>    VmPTE:        20 kb
>    VmSwap:        0 kB
> +  NumaBalancing_enabled:  1

Bit verbose

NumaB_enabled:

>    HugetlbPages:          0 kB
>    CoreDumping:    0
>    THP_enabled:	  1
> @@ -273,6 +274,7 @@ It's slow but very precise.
>   VmPTE                       size of page table entries
>   VmSwap                      amount of swap used by anonymous private data
>                               (shmem swap usage is not included)
> + NumaBalancing_enabled       numa balancing state, use prctl(PR_NUMA_BALANCING, ...)

s/use/set by/

>   HugetlbPages                size of hugetlb memory portions
>   CoreDumping                 process's memory is currently being dumped
>                               (killing the process may lead to a corrupted core)
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ad667dbc96f5..161295e027d2 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -19,6 +19,7 @@
>  #include <linux/shmem_fs.h>
>  #include <linux/uaccess.h>
>  #include <linux/pkeys.h>
> +#include <linux/sched/numa_balancing.h>
>  
>  #include <asm/elf.h>
>  #include <asm/tlb.h>
> @@ -27,14 +28,23 @@
>  
>  #define SEQ_PUT_DEC(str, val) \
>  		seq_put_decimal_ull_width(m, str, (val) << (PAGE_SHIFT-10), 8)
> +
> +DECLARE_STATIC_KEY_FALSE(sched_numa_balancing);
> +

Declare in a header.

>  void task_mem(struct seq_file *m, struct mm_struct *mm)
>  {
>  	unsigned long text, lib, swap, anon, file, shmem;
>  	unsigned long hiwater_vm, total_vm, hiwater_rss, total_rss;
> +#ifdef CONFIG_NUMA_BALANCING
> +	int numa_balancing;
> +#endif
>  

rename to numab_enabled, the name as-is gives little hint as to what
it means. If the prctl works even if numab is globally disabled by
default then the variable can go away.

>  	anon = get_mm_counter(mm, MM_ANONPAGES);
>  	file = get_mm_counter(mm, MM_FILEPAGES);
>  	shmem = get_mm_counter(mm, MM_SHMEMPAGES);
> +#ifdef CONFIG_NUMA_BALANCING
> +	numa_balancing = READ_ONCE(mm->numa_balancing);
> +#endif
>  

The READ_ONCE/WRITE_ONCE may be overkill given that the value is set at
fork time and doesn't change. I guess an application could be actively
calling prctl() but it would be inherently race-prone.

>  	/*
>  	 * Note: to minimize their overhead, mm maintains hiwater_vm and
> @@ -75,6 +85,12 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>  		    " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
>  	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
>  	seq_puts(m, " kB\n");
> +#ifdef CONFIG_NUMA_BALANCING
> +	if (!static_branch_unlikely(&sched_numa_balancing))
> +		numa_balancing = 0;
> +
> +	seq_printf(m, "NumaBalancing_enabled:\t%d\n", numa_balancing);
> +#endif
>  	hugetlb_report_usage(m, mm);
>  }
>  #undef SEQ_PUT_DEC
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index bb8c6f5f19bc..feeb6f639f87 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -612,6 +612,9 @@ struct mm_struct {
>  
>  		/* numa_scan_seq prevents two threads setting pte_numa */
>  		int numa_scan_seq;
> +
> +		/* numa_balancing control the numa balancing of this mm */
> +		int numa_balancing;
>  #endif
>  		/*
>  		 * An operation with batched TLB flushing is going on. Anything

Rename to numab_enabled. The comment is not that helpful

/* Controls whether NUMA balancing is active for this mm. */

> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index b2e4dc1449b9..2235b75efd30 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -272,4 +272,9 @@ struct prctl_mm_map {
>  # define PR_SCHED_CORE_SCOPE_THREAD_GROUP	1
>  # define PR_SCHED_CORE_SCOPE_PROCESS_GROUP	2
>  
> +/* Set/get enabled per-process numa_balancing */
> +#define PR_NUMA_BALANCING		63
> +# define PR_SET_NUMA_BALANCING		0
> +# define PR_GET_NUMA_BALANCING		1
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2079f1ebfe63..39e9d5daf00a 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1110,6 +1110,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	init_tlb_flush_pending(mm);
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
>  	mm->pmd_huge_pte = NULL;
> +#endif
> +#ifdef CONFIG_NUMA_BALANCING
> +	mm->numa_balancing = 1;
>  #endif
>  	mm_init_uprobes_state(mm);
>  	hugetlb_count_init(mm);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 87db481e8a56..1325253e3613 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2866,6 +2866,9 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
>  	if ((curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
>  		return;
>  
> +	if (!READ_ONCE(curr->mm->numa_balancing))
> +		return;
> +
>  	/*
>  	 * Using runtime rather than walltime has the dual advantage that
>  	 * we (mostly) drive the selection from busy threads and that the
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 8fdac0d90504..64aee3d63ea8 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -154,6 +154,8 @@ int fs_overflowgid = DEFAULT_FS_OVERFLOWGID;
>  EXPORT_SYMBOL(fs_overflowuid);
>  EXPORT_SYMBOL(fs_overflowgid);
>  
> +DECLARE_STATIC_KEY_FALSE(sched_numa_balancing);
> +

Header.

>  /*
>   * Returns true if current's euid is same as p's uid or euid,
>   * or has CAP_SYS_NICE to p's user_ns.
> @@ -2081,6 +2083,28 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_NUMA_BALANCING
> +static int prctl_pid_numa_balancing_write(int numa_balancing)
> +{
> +	if (!static_branch_unlikely(&sched_numa_balancing))
> +		return -EPERM;
> +

Obviously this would change again if prctl still has an effect if numa
balancing is disabled by default.

> +	if (numa_balancing != 0 && numa_balancing != 1)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(current->mm->numa_balancing, numa_balancing);
> +	return 0;
> +}
> +
> +static int prctl_pid_numa_balancing_read(void)
> +{
> +	if (!static_branch_unlikely(&sched_numa_balancing))
> +		return 0;
> +	else
> +		return READ_ONCE(current->mm->numa_balancing);
> +}
> +#endif
> +
>  static int prctl_set_mm(int opt, unsigned long addr,
>  			unsigned long arg4, unsigned long arg5)
>  {
> @@ -2525,6 +2549,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		error = set_syscall_user_dispatch(arg2, arg3, arg4,
>  						  (char __user *) arg5);
>  		break;
> +#ifdef CONFIG_NUMA_BALANCING
> +	case PR_NUMA_BALANCING:
> +		switch (arg2) {
> +		case PR_SET_NUMA_BALANCING:
> +			error = prctl_pid_numa_balancing_write((int)arg3);
> +			break;
> +		case PR_GET_NUMA_BALANCING:
> +			put_user(prctl_pid_numa_balancing_read(), (int __user *)arg3);
> +			break;
> +		default:
> +			error = -EINVAL;
> +			break;
> +		}
> +		break;
> +#endif
>  #ifdef CONFIG_SCHED_CORE
>  	case PR_SCHED_CORE:
>  		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
> -- 
> 2.20.1
> 

-- 
Mel Gorman
SUSE Labs
