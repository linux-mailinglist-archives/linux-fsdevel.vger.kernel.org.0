Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEE824B917
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 13:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgHTLil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 07:38:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40639 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbgHTLat (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:30:49 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k8im0-0000Eh-8L; Thu, 20 Aug 2020 11:30:24 +0000
Date:   Thu, 20 Aug 2020 13:30:23 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, adobriyan@gmail.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, gladkov.alexey@gmail.com, walken@google.com,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, timmurray@google.com, minchan@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200820113023.rjxque4jveo4nj5o@wittgenstein>
References: <20200820002053.1424000-1-surenb@google.com>
 <20200820105555.GA4546@redhat.com>
 <20200820111349.GE5033@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820111349.GE5033@dhcp22.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 20, 2020 at 01:13:49PM +0200, Michal Hocko wrote:
> On Thu 20-08-20 12:55:56, Oleg Nesterov wrote:
> > On 08/19, Suren Baghdasaryan wrote:
> > >
> > > Since the combination of CLONE_VM and !CLONE_SIGHAND is rarely
> > > used the additional mutex lock in that path of the clone() syscall should
> > > not affect its overall performance. Clearing the MMF_PROC_SHARED flag
> > > (when the last process sharing the mm exits) is left out of this patch to
> > > keep it simple and because it is believed that this threading model is
> > > rare.
> > 
> > vfork() ?
> 
> Could you be more specific?

vfork() implies CLONE_VM but !CLONE_THREAD. The way this patch is
written the mutex lock will be taken every time you do a vfork().

(It's honestly also debatable whether it's that rare. For one, userspace
stuff I maintain uses it too (see [1]).
[1]: https://github.com/lxc/lxc/blob/9d3b7c97f0443adc9f0b0438437657ab42f5a1c3/src/lxc/start.c#L1676
)

> 
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -1403,6 +1403,15 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
> > >  	if (clone_flags & CLONE_VM) {
> > >  		mmget(oldmm);
> > >  		mm = oldmm;
> > > +		if (!(clone_flags & CLONE_SIGHAND)) {
> > 
> > I agree with Christian, you need CLONE_THREAD
> 
> This was my suggestion to Suren, likely because I've misrememberd which
> clone flag is responsible for the signal delivery. But now, after double
> checking we do explicitly disallow CLONE_SIGHAND && !CLONE_VM. So
> CLONE_THREAD is the right thing to check.
> 
> > > +			/* We need to synchronize with __set_oom_adj */
> > > +			mutex_lock(&oom_adj_lock);
> > > +			set_bit(MMF_PROC_SHARED, &mm->flags);
> > > +			/* Update the values in case they were changed after copy_signal */
> > > +			tsk->signal->oom_score_adj = current->signal->oom_score_adj;
> > > +			tsk->signal->oom_score_adj_min = current->signal->oom_score_adj_min;
> > > +			mutex_unlock(&oom_adj_lock);
> > 
> > I don't understand how this can close the race with __set_oom_adj...
> > 
> > What if __set_oom_adj() is called right after mutex_unlock() ? It will see
> > MMF_PROC_SHARED, but for_each_process() won't find the new child until
> > copy_process() does list_add_tail_rcu(&p->tasks, &init_task.tasks) ?
> 
> Good point. Then we will have to move this thing there.

I was toying with moving this into sm like:

static inline copy_oom_score(unsigned long flags, struct task_struct *tsk)

trying to rely on set_bit() and test_bit() in copy_mm() being atomic and
then calling it where Oleg said after the point of no return.

Christian
