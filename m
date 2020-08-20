Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0C324B62B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 12:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbgHTKdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 06:33:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38234 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbgHTKdQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:33:16 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k8hsH-0003ho-Hd; Thu, 20 Aug 2020 10:32:49 +0000
Date:   Thu, 20 Aug 2020 12:32:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, mingo@kernel.org,
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
Message-ID: <20200820103248.vkzrndewvy5vlncz@wittgenstein>
References: <20200820002053.1424000-1-surenb@google.com>
 <20200820084654.jdl6jqgxsga7orvf@wittgenstein>
 <20200820090901.GD5033@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820090901.GD5033@dhcp22.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 20, 2020 at 11:09:01AM +0200, Michal Hocko wrote:
> On Thu 20-08-20 10:46:54, Christian Brauner wrote:
> > On Wed, Aug 19, 2020 at 05:20:53PM -0700, Suren Baghdasaryan wrote:
> > > Currently __set_oom_adj loops through all processes in the system to
> > > keep oom_score_adj and oom_score_adj_min in sync between processes
> > > sharing their mm. This is done for any task with more that one mm_users,
> > > which includes processes with multiple threads (sharing mm and signals).
> > > However for such processes the loop is unnecessary because their signal
> > > structure is shared as well.
> > > Android updates oom_score_adj whenever a tasks changes its role
> > > (background/foreground/...) or binds to/unbinds from a service, making
> > > it more/less important. Such operation can happen frequently.
> > > We noticed that updates to oom_score_adj became more expensive and after
> > > further investigation found out that the patch mentioned in "Fixes"
> > > introduced a regression. Using Pixel 4 with a typical Android workload,
> > > write time to oom_score_adj increased from ~3.57us to ~362us. Moreover
> > > this regression linearly depends on the number of multi-threaded
> > > processes running on the system.
> > > Mark the mm with a new MMF_PROC_SHARED flag bit when task is created with
> > > CLONE_VM and !CLONE_SIGHAND. Change __set_oom_adj to use MMF_PROC_SHARED
> > > instead of mm_users to decide whether oom_score_adj update should be
> > > synchronized between multiple processes. To prevent races between clone()
> > > and __set_oom_adj(), when oom_score_adj of the process being cloned might
> > > be modified from userspace, we use oom_adj_mutex. Its scope is changed to
> > > global and it is renamed into oom_adj_lock for naming consistency with
> > > oom_lock. Since the combination of CLONE_VM and !CLONE_SIGHAND is rarely
> > > used the additional mutex lock in that path of the clone() syscall should
> > > not affect its overall performance. Clearing the MMF_PROC_SHARED flag
> > > (when the last process sharing the mm exits) is left out of this patch to
> > > keep it simple and because it is believed that this threading model is
> > > rare. Should there ever be a need for optimizing that case as well, it
> > > can be done by hooking into the exit path, likely following the
> > > mm_update_next_owner pattern.
> > > With the combination of CLONE_VM and !CLONE_SIGHAND being quite rare, the
> > > regression is gone after the change is applied.
> > > 
> > > Fixes: 44a70adec910 ("mm, oom_adj: make sure processes sharing mm have same view of oom_score_adj")
> > > Reported-by: Tim Murray <timmurray@google.com>
> > > Suggested-by: Michal Hocko <mhocko@kernel.org>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  fs/proc/base.c                 | 7 +++----
> > >  include/linux/oom.h            | 1 +
> > >  include/linux/sched/coredump.h | 1 +
> > >  kernel/fork.c                  | 9 +++++++++
> > >  mm/oom_kill.c                  | 2 ++
> > >  5 files changed, 16 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > index 617db4e0faa0..cff1a58a236c 100644
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -1055,7 +1055,6 @@ static ssize_t oom_adj_read(struct file *file, char __user *buf, size_t count,
> > >  
> > >  static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> > >  {
> > > -	static DEFINE_MUTEX(oom_adj_mutex);
> > >  	struct mm_struct *mm = NULL;
> > >  	struct task_struct *task;
> > >  	int err = 0;
> > > @@ -1064,7 +1063,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> > >  	if (!task)
> > >  		return -ESRCH;
> > >  
> > > -	mutex_lock(&oom_adj_mutex);
> > > +	mutex_lock(&oom_adj_lock);
> > >  	if (legacy) {
> > >  		if (oom_adj < task->signal->oom_score_adj &&
> > >  				!capable(CAP_SYS_RESOURCE)) {
> > > @@ -1095,7 +1094,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> > >  		struct task_struct *p = find_lock_task_mm(task);
> > >  
> > >  		if (p) {
> > > -			if (atomic_read(&p->mm->mm_users) > 1) {
> > > +			if (test_bit(MMF_PROC_SHARED, &p->mm->flags)) {
> > >  				mm = p->mm;
> > >  				mmgrab(mm);
> > >  			}
> > > @@ -1132,7 +1131,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
> > >  		mmdrop(mm);
> > >  	}
> > >  err_unlock:
> > > -	mutex_unlock(&oom_adj_mutex);
> > > +	mutex_unlock(&oom_adj_lock);
> > >  	put_task_struct(task);
> > >  	return err;
> > >  }
> > > diff --git a/include/linux/oom.h b/include/linux/oom.h
> > > index f022f581ac29..861f22bd4706 100644
> > > --- a/include/linux/oom.h
> > > +++ b/include/linux/oom.h
> > > @@ -55,6 +55,7 @@ struct oom_control {
> > >  };
> > >  
> > >  extern struct mutex oom_lock;
> > > +extern struct mutex oom_adj_lock;
> > >  
> > >  static inline void set_current_oom_origin(void)
> > >  {
> > > diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> > > index ecdc6542070f..070629b722df 100644
> > > --- a/include/linux/sched/coredump.h
> > > +++ b/include/linux/sched/coredump.h
> > > @@ -72,6 +72,7 @@ static inline int get_dumpable(struct mm_struct *mm)
> > >  #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
> > >  #define MMF_OOM_VICTIM		25	/* mm is the oom victim */
> > >  #define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
> > > +#define MMF_PROC_SHARED	27	/* mm is shared while sighand is not */
> > >  #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
> > >  
> > >  #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 4d32190861bd..9177a76bf840 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -1403,6 +1403,15 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
> > >  	if (clone_flags & CLONE_VM) {
> > >  		mmget(oldmm);
> > >  		mm = oldmm;
> > > +		if (!(clone_flags & CLONE_SIGHAND)) {
> > > +			/* We need to synchronize with __set_oom_adj */
> > > +			mutex_lock(&oom_adj_lock);
> > > +			set_bit(MMF_PROC_SHARED, &mm->flags);
> > 
> > This seems fine.
> > 
> > > +			/* Update the values in case they were changed after copy_signal */
> > > +			tsk->signal->oom_score_adj = current->signal->oom_score_adj;
> > > +			tsk->signal->oom_score_adj_min = current->signal->oom_score_adj_min;
> > 
> > But this seems wrong to me.
> > copy_signal() should be the only place where ->signal is set. Just from
> > a pure conceptual perspective. The copy_*() should be as self-contained
> > as possible imho.
> > Also, now I have to remember/look for two different locations where
> > oom_score_adj{_min} is initialized during fork. And this also creates a
> > dependency between copy_signal() and copy_mm() that doesn't need to be
> > there imho. I'm not a fan.
> 
> Yes, this is not great but we will need it because the __set_oom_adj
> might happen between copy_signal and copy_mm. If that happens then
> __set_oom_adj misses this newly created task and so it will have a
> disagreeing oom_score_adj.

One more clarification. The commit message states that

> > > which includes processes with multiple threads (sharing mm and signals).
> > > However for such processes the loop is unnecessary because their signal
> > > structure is shared as well.

and it seems you want to exclude threads, i.e. only update mm that is
shared not among threads in the same thread-group.
But struct signal and struct sighand_struct are different things, i.e.
they can be shared or not independent of each other. A non-shared
signal_struct where oom_score_adj{_min} live is only implied by
!CLONE_THREAD. So shouldn't this be:

if (!(clone_flags & CLONE_THREAD)) rather than CLONE_SIGHAND?

I might be missing something obvious though...
Christian
