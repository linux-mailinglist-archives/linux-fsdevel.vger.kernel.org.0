Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D723424B97F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 13:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgHTLsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 07:48:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40951 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbgHTLr3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:47:29 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k8j26-0001SH-AW; Thu, 20 Aug 2020 11:47:02 +0000
Date:   Thu, 20 Aug 2020 13:47:00 +0200
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
Message-ID: <20200820114700.bmla72v3t4ux7gsm@wittgenstein>
References: <20200820002053.1424000-1-surenb@google.com>
 <20200820105555.GA4546@redhat.com>
 <20200820111349.GE5033@dhcp22.suse.cz>
 <20200820112932.GG5033@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820112932.GG5033@dhcp22.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 20, 2020 at 01:29:32PM +0200, Michal Hocko wrote:
> On Thu 20-08-20 13:13:55, Michal Hocko wrote:
> > On Thu 20-08-20 12:55:56, Oleg Nesterov wrote:
> > > On 08/19, Suren Baghdasaryan wrote:
> > > >
> > > > Since the combination of CLONE_VM and !CLONE_SIGHAND is rarely
> > > > used the additional mutex lock in that path of the clone() syscall should
> > > > not affect its overall performance. Clearing the MMF_PROC_SHARED flag
> > > > (when the last process sharing the mm exits) is left out of this patch to
> > > > keep it simple and because it is believed that this threading model is
> > > > rare.
> > > 
> > > vfork() ?
> > 
> > Could you be more specific?
> > 
> > > > --- a/kernel/fork.c
> > > > +++ b/kernel/fork.c
> > > > @@ -1403,6 +1403,15 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
> > > >  	if (clone_flags & CLONE_VM) {
> > > >  		mmget(oldmm);
> > > >  		mm = oldmm;
> > > > +		if (!(clone_flags & CLONE_SIGHAND)) {
> > > 
> > > I agree with Christian, you need CLONE_THREAD
> > 
> > This was my suggestion to Suren, likely because I've misrememberd which
> > clone flag is responsible for the signal delivery. But now, after double
> > checking we do explicitly disallow CLONE_SIGHAND && !CLONE_VM. So
> > CLONE_THREAD is the right thing to check.
> 
> I have tried to remember but I have to say that after reading man page I
> am still confused. So what is the actual difference between CLONE_THREAD
> and CLONE_SIGHAND? Essentially all we care about from the OOM (and

CLONE_THREAD implies CLONE_SIGHAND
CLONE_SIGHAND implies CLONE_VM but CLONE_SIGHAND doesn't imply CLONE_THREAD.

> oom_score_adj) POV is that signals are delivered to all entities and
> that thay share signal struct. copy_signal is checking for CLONE_THREAD

If a thread has a separate sighand struct it can have separate handlers
(Oleg will correct me if wrong.). But fatal signals will take the whole
thread-group down and can't be ignored which is the only thing you care
about with OOM afair.
What you care about is that the oom_score_adj{_min} settings are shared
and they live in struct signal_struct and whether that's shared or not
is basically guided by CLONE_THREAD.

> but CLONE_THREAD requires CLONE_SIGHAND AFAIU. So is there any cae where
> checking for CLONE_SIGHAND would wrong for our purpose?

Without having spent a long time thinking deeply about this it likely
wouldn't. But using CLONE_SIGHAND is very irritating since it doesn't
clearly express what you want this for. Especially since there's now a
difference between the check in copy_signal() and copy_mm() and a
disconnect to what is expressed in the commit message too, imho.

Christian
