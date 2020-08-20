Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C060224AED2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 07:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgHTF4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 01:56:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:52652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgHTF4e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:56:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8976CAAB0;
        Thu, 20 Aug 2020 05:56:59 +0000 (UTC)
Date:   Thu, 20 Aug 2020 07:56:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     christian.brauner@ubuntu.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, oleg@redhat.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        gladkov.alexey@gmail.com, walken@google.com,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, timmurray@google.com, minchan@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200820055630.GW5422@dhcp22.suse.cz>
References: <20200820002053.1424000-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820002053.1424000-1-surenb@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 19-08-20 17:20:53, Suren Baghdasaryan wrote:
> Currently __set_oom_adj loops through all processes in the system to
> keep oom_score_adj and oom_score_adj_min in sync between processes
> sharing their mm. This is done for any task with more that one mm_users,
> which includes processes with multiple threads (sharing mm and signals).
> However for such processes the loop is unnecessary because their signal
> structure is shared as well.
> Android updates oom_score_adj whenever a tasks changes its role
> (background/foreground/...) or binds to/unbinds from a service, making
> it more/less important. Such operation can happen frequently.
> We noticed that updates to oom_score_adj became more expensive and after
> further investigation found out that the patch mentioned in "Fixes"
> introduced a regression. Using Pixel 4 with a typical Android workload,
> write time to oom_score_adj increased from ~3.57us to ~362us. Moreover
> this regression linearly depends on the number of multi-threaded
> processes running on the system.
> Mark the mm with a new MMF_PROC_SHARED flag bit when task is created with
> CLONE_VM and !CLONE_SIGHAND. Change __set_oom_adj to use MMF_PROC_SHARED
> instead of mm_users to decide whether oom_score_adj update should be
> synchronized between multiple processes. To prevent races between clone()
> and __set_oom_adj(), when oom_score_adj of the process being cloned might
> be modified from userspace, we use oom_adj_mutex. Its scope is changed to
> global and it is renamed into oom_adj_lock for naming consistency with
> oom_lock. Since the combination of CLONE_VM and !CLONE_SIGHAND is rarely
> used the additional mutex lock in that path of the clone() syscall should
> not affect its overall performance. Clearing the MMF_PROC_SHARED flag
> (when the last process sharing the mm exits) is left out of this patch to
> keep it simple and because it is believed that this threading model is
> rare. Should there ever be a need for optimizing that case as well, it
> can be done by hooking into the exit path, likely following the
> mm_update_next_owner pattern.
> With the combination of CLONE_VM and !CLONE_SIGHAND being quite rare, the
> regression is gone after the change is applied.

Yes this seems like a reasonable approach. Should we learn about a
usecase which relies on this threading model we might need a more
sophisticated synchronization but for now this sounds like good enough.

> Fixes: 44a70adec910 ("mm, oom_adj: make sure processes sharing mm have same view of oom_score_adj")
> Reported-by: Tim Murray <timmurray@google.com>
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  fs/proc/base.c                 | 7 +++----
>  include/linux/oom.h            | 1 +
>  include/linux/sched/coredump.h | 1 +
>  kernel/fork.c                  | 9 +++++++++
>  mm/oom_kill.c                  | 2 ++
>  5 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 617db4e0faa0..cff1a58a236c 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1055,7 +1055,6 @@ static ssize_t oom_adj_read(struct file *file, char __user *buf, size_t count,
>  
>  static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  {
> -	static DEFINE_MUTEX(oom_adj_mutex);
>  	struct mm_struct *mm = NULL;
>  	struct task_struct *task;
>  	int err = 0;
> @@ -1064,7 +1063,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  	if (!task)
>  		return -ESRCH;
>  
> -	mutex_lock(&oom_adj_mutex);
> +	mutex_lock(&oom_adj_lock);
>  	if (legacy) {
>  		if (oom_adj < task->signal->oom_score_adj &&
>  				!capable(CAP_SYS_RESOURCE)) {
> @@ -1095,7 +1094,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  		struct task_struct *p = find_lock_task_mm(task);
>  
>  		if (p) {
> -			if (atomic_read(&p->mm->mm_users) > 1) {
> +			if (test_bit(MMF_PROC_SHARED, &p->mm->flags)) {
>  				mm = p->mm;
>  				mmgrab(mm);
>  			}
> @@ -1132,7 +1131,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  		mmdrop(mm);
>  	}
>  err_unlock:
> -	mutex_unlock(&oom_adj_mutex);
> +	mutex_unlock(&oom_adj_lock);
>  	put_task_struct(task);
>  	return err;
>  }
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index f022f581ac29..861f22bd4706 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -55,6 +55,7 @@ struct oom_control {
>  };
>  
>  extern struct mutex oom_lock;
> +extern struct mutex oom_adj_lock;
>  
>  static inline void set_current_oom_origin(void)
>  {
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index ecdc6542070f..070629b722df 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -72,6 +72,7 @@ static inline int get_dumpable(struct mm_struct *mm)
>  #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
>  #define MMF_OOM_VICTIM		25	/* mm is the oom victim */
>  #define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
> +#define MMF_PROC_SHARED	27	/* mm is shared while sighand is not */
>  #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
>  
>  #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 4d32190861bd..9177a76bf840 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1403,6 +1403,15 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
>  	if (clone_flags & CLONE_VM) {
>  		mmget(oldmm);
>  		mm = oldmm;
> +		if (!(clone_flags & CLONE_SIGHAND)) {
> +			/* We need to synchronize with __set_oom_adj */
> +			mutex_lock(&oom_adj_lock);
> +			set_bit(MMF_PROC_SHARED, &mm->flags);
> +			/* Update the values in case they were changed after copy_signal */
> +			tsk->signal->oom_score_adj = current->signal->oom_score_adj;
> +			tsk->signal->oom_score_adj_min = current->signal->oom_score_adj_min;
> +			mutex_unlock(&oom_adj_lock);
> +		}
>  		goto good_mm;
>  	}
>  
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index e90f25d6385d..c22f07c986cb 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -64,6 +64,8 @@ int sysctl_oom_dump_tasks = 1;
>   * and mark_oom_victim
>   */
>  DEFINE_MUTEX(oom_lock);
> +/* Serializes oom_score_adj and oom_score_adj_min updates */
> +DEFINE_MUTEX(oom_adj_lock);
>  
>  static inline bool is_memcg_oom(struct oom_control *oc)
>  {
> -- 
> 2.28.0.297.g1956fa8f8d-goog

-- 
Michal Hocko
SUSE Labs
