Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2124C24BF34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgHTNoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 09:44:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47108 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbgHTNoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:44:14 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k8kr8-0007Yq-07; Thu, 20 Aug 2020 13:43:50 +0000
Date:   Thu, 20 Aug 2020 15:43:48 +0200
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
Message-ID: <20200820134348.tmoydr2aawghyfkt@wittgenstein>
References: <20200820002053.1424000-1-surenb@google.com>
 <20200820105555.GA4546@redhat.com>
 <20200820111349.GE5033@dhcp22.suse.cz>
 <20200820113023.rjxque4jveo4nj5o@wittgenstein>
 <20200820114245.GH5033@dhcp22.suse.cz>
 <20200820124109.GI5033@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820124109.GI5033@dhcp22.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 20, 2020 at 02:41:09PM +0200, Michal Hocko wrote:
> On Thu 20-08-20 13:42:56, Michal Hocko wrote:
> > On Thu 20-08-20 13:30:23, Christian Brauner wrote:
> [...]
> > > trying to rely on set_bit() and test_bit() in copy_mm() being atomic and
> > > then calling it where Oleg said after the point of no return.
> > 
> > No objections.
> 
> Would something like the following work for you?
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9177a76bf840..25b83f0912a6 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1403,15 +1403,6 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
>  	if (clone_flags & CLONE_VM) {
>  		mmget(oldmm);
>  		mm = oldmm;
> -		if (!(clone_flags & CLONE_SIGHAND)) {
> -			/* We need to synchronize with __set_oom_adj */
> -			mutex_lock(&oom_adj_lock);
> -			set_bit(MMF_PROC_SHARED, &mm->flags);
> -			/* Update the values in case they were changed after copy_signal */
> -			tsk->signal->oom_score_adj = current->signal->oom_score_adj;
> -			tsk->signal->oom_score_adj_min = current->signal->oom_score_adj_min;
> -			mutex_unlock(&oom_adj_lock);
> -		}
>  		goto good_mm;
>  	}
>  
> @@ -1818,6 +1809,19 @@ static __always_inline void delayed_free_task(struct task_struct *tsk)
>  		free_task(tsk);
>  }
>  
> +static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
> +{
> +	if ((clone_flags & (CLONE_VM | CLONE_THREAD | CLONE_VFORK)) == CLONE_VM) {
> +		/* We need to synchronize with __set_oom_adj */
> +		mutex_lock(&oom_adj_lock);
> +		set_bit(MMF_PROC_SHARED, &mm->flags);
> +		/* Update the values in case they were changed after copy_signal */
> +		tsk->signal->oom_score_adj = current->signal->oom_score_adj;
> +		tsk->signal->oom_score_adj_min = current->signal->oom_score_adj_min;
> +		mutex_unlock(&oom_adj_lock);
> +	}
> +}
> +
>  /*
>   * This creates a new process as a copy of the old one,
>   * but does not actually start it yet.
> @@ -2290,6 +2294,8 @@ static __latent_entropy struct task_struct *copy_process(
>  	trace_task_newtask(p, clone_flags);
>  	uprobe_copy_process(p, clone_flags);
>  
> +	copy_oom_score_adj(clone_flags, p);
> +
>  	return p;
>  
>  bad_fork_cancel_cgroup:

This should work, yes.
And keeps the patch reasonably small.

Christian
