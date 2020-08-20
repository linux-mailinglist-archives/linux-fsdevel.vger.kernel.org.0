Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910F424B8D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 13:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgHTL3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 07:29:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:52438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbgHTL3f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:29:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 341A4AC98;
        Thu, 20 Aug 2020 11:30:00 +0000 (UTC)
Date:   Thu, 20 Aug 2020 13:29:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        christian.brauner@ubuntu.com, mingo@kernel.org,
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
Message-ID: <20200820112932.GG5033@dhcp22.suse.cz>
References: <20200820002053.1424000-1-surenb@google.com>
 <20200820105555.GA4546@redhat.com>
 <20200820111349.GE5033@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820111349.GE5033@dhcp22.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-08-20 13:13:55, Michal Hocko wrote:
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

I have tried to remember but I have to say that after reading man page I
am still confused. So what is the actual difference between CLONE_THREAD
and CLONE_SIGHAND? Essentially all we care about from the OOM (and
oom_score_adj) POV is that signals are delivered to all entities and
that thay share signal struct. copy_signal is checking for CLONE_THREAD
but CLONE_THREAD requires CLONE_SIGHAND AFAIU. So is there any cae where
checking for CLONE_SIGHAND would wrong for our purpose?

This is mostly an academic question because I do agree that checking for
CLONE_THREAD is likely more readable. And in fact the MMF_PROC_SHARED is
likely more suitable to be set in copy_signal. 

-- 
Michal Hocko
SUSE Labs
