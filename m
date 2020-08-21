Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B1A24CF16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgHUHVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:21:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:36466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbgHUHRg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:17:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 96A57AAC7;
        Fri, 21 Aug 2020 07:17:59 +0000 (UTC)
Date:   Fri, 21 Aug 2020 09:17:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tim Murray <timmurray@google.com>, mingo@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com,
        Shakeel Butt <shakeelb@google.com>, cyphar@cyphar.com,
        Oleg Nesterov <oleg@redhat.com>, adobriyan@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        gladkov.alexey@gmail.com, Michel Lespinasse <walken@google.com>,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de,
        John Johansen <john.johansen@canonical.com>,
        laoar.shao@gmail.com, Minchan Kim <minchan@kernel.org>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200821071730.GA32537@dhcp22.suse.cz>
References: <87d03lxysr.fsf@x220.int.ebiederm.org>
 <20200820132631.GK5033@dhcp22.suse.cz>
 <20200820133454.ch24kewh42ax4ebl@wittgenstein>
 <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein>
 <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
 <87k0xtv0d4.fsf@x220.int.ebiederm.org>
 <CAJuCfpHsjisBnNiDNQbm8Yi92cznaptiXYPdc-aVa+_zkuaPhA@mail.gmail.com>
 <20200820162645.GP5033@dhcp22.suse.cz>
 <87r1s0txxe.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1s0txxe.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-08-20 23:39:25, Eric W. Biederman wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Thu 20-08-20 08:56:53, Suren Baghdasaryan wrote:
> > [...]
> >> Catching up on the discussion which was going on while I was asleep...
> >> So it sounds like there is a consensus that oom_adj should be moved to
> >> mm_struct rather than trying to synchronize it among tasks sharing mm.
> >> That sounds reasonable to me too. Michal answered all the earlier
> >> questions about this patch, so I won't be reiterating them, thanks
> >> Michal. If any questions are still lingering about the original patch
> >> I'll be glad to answer them.
> >
> > I think it still makes some sense to go with a simpler (aka less tricky)
> > solution which would be your original patch with an incremental fix for
> > vfork and the proper ordering (http://lkml.kernel.org/r/20200820124109.GI5033@dhcp22.suse.cz)
> > and then make a more complex shift to mm struct on top of that. The
> > former will be less tricky to backport to stable IMHO.
> 
> So I am confused.
> 
> I don't know how a subtle dependency on something in clone
> is better than something flat footed in exec.

Well, I think that setting a flag is an easier approach than handle all
the special cases for the mm thing. But this is likely because this is
not my domain so my judgment call might be misled. Anyway if there is a
general consensus that doing the middle step is not worth it I am not
going to object.

> That said if we are going for a small change why not:
> 
> 	/*
> 	 * Make sure we will check other processes sharing the mm if this is
> 	 * not vfrok which wants its own oom_score_adj.
> 	 * pin the mm so it doesn't go away and get reused after task_unlock
> 	 */
> 	if (!task->vfork_done) {
> 		struct task_struct *p = find_lock_task_mm(task);
> 
> 		if (p) {
> -			if (atomic_read(&p->mm->mm_users) > 1) {
> +			if (atomic_read(&p->mm->mm_users) > p->signal->nr_threads) {
> 				mm = p->mm;
> 				mmgrab(mm);
> 			}
> 			task_unlock(p);
> 		}
> 	}

I remember playing with something like that but it had problems too. I
do not remember details. Oleg would know better.

-- 
Michal Hocko
SUSE Labs
