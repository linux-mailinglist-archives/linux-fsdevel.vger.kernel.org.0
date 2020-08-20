Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F104B24C055
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 16:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgHTOMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 10:12:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgHTOMc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:12:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 112F0ABD2;
        Thu, 20 Aug 2020 14:12:50 +0000 (UTC)
Date:   Thu, 20 Aug 2020 16:12:22 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        christian.brauner@ubuntu.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, oleg@redhat.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, gladkov.alexey@gmail.com,
        walken@google.com, daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, timmurray@google.com, minchan@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200820141222.GL5033@dhcp22.suse.cz>
References: <20200820002053.1424000-1-surenb@google.com>
 <87zh6pxzq6.fsf@x220.int.ebiederm.org>
 <20200820124241.GJ5033@dhcp22.suse.cz>
 <87lfi9xz7y.fsf@x220.int.ebiederm.org>
 <87d03lxysr.fsf@x220.int.ebiederm.org>
 <20200820132631.GK5033@dhcp22.suse.cz>
 <874koxxwn5.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874koxxwn5.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-08-20 08:41:18, Eric W. Biederman wrote:
[...]
> I expect something like this completley untested patch will work.

Neat. I think you will need to duplicate oom_score_adj_min as well.
I am not familiar with vfork specifics to review this in depth but if
this is correct then it is much more effective than the existing
implementation which has focused more on not spreading the oom specifics
to the core code. So if the state duplication is deemed ok then no
objections from me.

Thanks!

> 
> Eric
> 
> 
>  fs/exec.c                    |    4 ++++
>  fs/proc/base.c               |   30 ++++++------------------------
>  include/linux/mm_types.h     |    4 ++++
>  include/linux/sched/signal.h |    4 +---
>  kernel/fork.c                |    3 +--
>  mm/oom_kill.c                |   12 ++++++------
>  6 files changed, 22 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 9b723d2560d1..e7eed5212c6c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1139,6 +1139,10 @@ static int exec_mmap(struct mm_struct *mm)
>  	vmacache_flush(tsk);
>  	task_unlock(tsk);
>  	if (old_mm) {
> +		mm->oom_score_adj = old_mm->oom_score_adj;
> +		mm->oom_score_adj_min = old_mm->oom_score_adj_min;
> +		if (tsk->vfork_done)
> +			mm->oom_score_adj = tsk->vfork_oom_score_adj;
>  		mmap_read_unlock(old_mm);
>  		BUG_ON(active_mm != old_mm);
>  		setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 617db4e0faa0..795fa0a8db52 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1103,33 +1103,15 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  		}
>  	}
>  
> -	task->signal->oom_score_adj = oom_adj;
> -	if (!legacy && has_capability_noaudit(current, CAP_SYS_RESOURCE))
> -		task->signal->oom_score_adj_min = (short)oom_adj;
> -	trace_oom_score_adj_update(task);
> -
>  	if (mm) {
>  		struct task_struct *p;
>  
> -		rcu_read_lock();
> -		for_each_process(p) {
> -			if (same_thread_group(task, p))
> -				continue;
> -
> -			/* do not touch kernel threads or the global init */
> -			if (p->flags & PF_KTHREAD || is_global_init(p))
> -				continue;
> -
> -			task_lock(p);
> -			if (!p->vfork_done && process_shares_mm(p, mm)) {
> -				p->signal->oom_score_adj = oom_adj;
> -				if (!legacy && has_capability_noaudit(current, CAP_SYS_RESOURCE))
> -					p->signal->oom_score_adj_min = (short)oom_adj;
> -			}
> -			task_unlock(p);
> -		}
> -		rcu_read_unlock();
> -		mmdrop(mm);
> +		mm->oom_score_adj = oom_adj;
> +		if (!legacy && has_capability_noaudit(current, CAP_SYS_RESOURCE))
> +			mm->oom_score_adj_min = (short)oom_adj;
> +		trace_oom_score_adj_update(task);
> +	} else {
> +		task->signal->vfork_oom_score_adj = oom_adj;
>  	}
>  err_unlock:
>  	mutex_unlock(&oom_adj_mutex);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 496c3ff97cce..b865048ab25a 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -542,6 +542,10 @@ struct mm_struct {
>  		atomic_long_t hugetlb_usage;
>  #endif
>  		struct work_struct async_put_work;
> +
> +		short oom_score_adj;		/* OOM kill score adjustment */
> +		short oom_score_adj_min;	/* OOM kill score adjustment min value.
> +					 * Only settable by CAP_SYS_RESOURCE. */
>  	} __randomize_layout;
>  
>  	/*
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 1bad18a1d8ba..a69eb9e0d247 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -218,9 +218,7 @@ struct signal_struct {
>  	 * oom
>  	 */
>  	bool oom_flag_origin;
> -	short oom_score_adj;		/* OOM kill score adjustment */
> -	short oom_score_adj_min;	/* OOM kill score adjustment min value.
> -					 * Only settable by CAP_SYS_RESOURCE. */
> +	short vfork_oom_score_adj;		/* OOM kill score adjustment */
>  	struct mm_struct *oom_mm;	/* recorded mm when the thread group got
>  					 * killed by the oom killer */
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3049a41076f3..1ba4deaa2f98 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1584,8 +1584,7 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
>  	tty_audit_fork(sig);
>  	sched_autogroup_fork(sig);
>  
> -	sig->oom_score_adj = current->signal->oom_score_adj;
> -	sig->oom_score_adj_min = current->signal->oom_score_adj_min;
> +	sig->vfork_oom_score_adj = current->mm->oom_score_adj;
>  
>  	mutex_init(&sig->cred_guard_mutex);
>  	mutex_init(&sig->exec_update_mutex);
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index e90f25d6385d..0412f64e74c1 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -213,7 +213,7 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
>  	 * unkillable or have been already oom reaped or the are in
>  	 * the middle of vfork
>  	 */
> -	adj = (long)p->signal->oom_score_adj;
> +	adj = (long)p->mm->oom_score_adj;
>  	if (adj == OOM_SCORE_ADJ_MIN ||
>  			test_bit(MMF_OOM_SKIP, &p->mm->flags) ||
>  			in_vfork(p)) {
> @@ -403,7 +403,7 @@ static int dump_task(struct task_struct *p, void *arg)
>  		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
>  		mm_pgtables_bytes(task->mm),
>  		get_mm_counter(task->mm, MM_SWAPENTS),
> -		task->signal->oom_score_adj, task->comm);
> +		task->mm->oom_score_adj, task->comm);
>  	task_unlock(task);
>  
>  	return 0;
> @@ -452,7 +452,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
>  {
>  	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
>  		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
> -			current->signal->oom_score_adj);
> +			current->mm->oom_score_adj);
>  	if (!IS_ENABLED(CONFIG_COMPACTION) && oc->order)
>  		pr_warn("COMPACTION is disabled!!!\n");
>  
> @@ -892,7 +892,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  		K(get_mm_counter(mm, MM_FILEPAGES)),
>  		K(get_mm_counter(mm, MM_SHMEMPAGES)),
>  		from_kuid(&init_user_ns, task_uid(victim)),
> -		mm_pgtables_bytes(mm) >> 10, victim->signal->oom_score_adj);
> +		mm_pgtables_bytes(mm) >> 10, victim->mm->oom_score_adj);
>  	task_unlock(victim);
>  
>  	/*
> @@ -942,7 +942,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>   */
>  static int oom_kill_memcg_member(struct task_struct *task, void *message)
>  {
> -	if (task->signal->oom_score_adj != OOM_SCORE_ADJ_MIN &&
> +	if (task->mm->oom_score_adj != OOM_SCORE_ADJ_MIN &&
>  	    !is_global_init(task)) {
>  		get_task_struct(task);
>  		__oom_kill_process(task, message);
> @@ -1089,7 +1089,7 @@ bool out_of_memory(struct oom_control *oc)
>  	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
>  	    current->mm && !oom_unkillable_task(current) &&
>  	    oom_cpuset_eligible(current, oc) &&
> -	    current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
> +	    current->mm->oom_score_adj != OOM_SCORE_ADJ_MIN) {
>  		get_task_struct(current);
>  		oc->chosen = current;
>  		oom_kill_process(oc, "Out of memory (oom_kill_allocating_task)");

-- 
Michal Hocko
SUSE Labs
