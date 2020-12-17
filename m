Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5602D2DD3FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 16:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgLQPTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 10:19:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgLQPTp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:19:45 -0500
Date:   Thu, 17 Dec 2020 07:19:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608218344;
        bh=RSVecaGULUl9bn8yun7uAthvTLRzL5v+XNCje+IERvk=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lSJ9bzossl6Kp+UBFKCu+RKSFSGjYPefsQRn5dzasZK1nmrEJnIBlUcglwH7E2p51
         edaPnwofd6wPzu6LRoVSddXNaVlVfoicuo4Xh7kkviKlw1YDxh0ZHhomin4SljSpvv
         VjMOuLPywMqnywH9BLlaBaROj6AVswVl1odJMOBjh4r9QzQzIg8u8HyfcbZMv7Hkt3
         NbrOu2VRbEpBO66H6v/Z9w4YiSiaFjUt9MV0ijenVcueC92bkAPQcZWTlfOGUoqopD
         9EeVJSjCzdFt1+Iz1SbPUShWjNyMsZtRT8XnYU8vKE0eOFnUvvwyT2acc96PU6wfg7
         3xtgLjVfNkpAQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        syzbot <syzbot+51ce7a5794c3b12a70d1@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: WARNING: suspicious RCU usage in count
Message-ID: <20201217151904.GQ2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <0000000000009867cb05b699f5b6@google.com>
 <20201216205536.GX2443@casper.infradead.org>
 <CACT4Y+b7tNcnTQpUpO58rHcMCqe6UpQab_TxxYF_nxBZ1xDw9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b7tNcnTQpUpO58rHcMCqe6UpQab_TxxYF_nxBZ1xDw9Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 09:26:44AM +0100, Dmitry Vyukov wrote:
> On Wed, Dec 16, 2020 at 9:55 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Dec 16, 2020 at 11:34:10AM -0800, syzbot wrote:
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+51ce7a5794c3b12a70d1@syzkaller.appspotmail.com
> > >
> > > =============================
> > > WARNING: suspicious RCU usage
> > > 5.10.0-rc7-syzkaller #0 Not tainted
> > > -----------------------------
> > > kernel/sched/core.c:7270 Illegal context switch in RCU-bh read-side critical section!
> > >
> > > other info that might help us debug this:
> > >
> > >
> > > rcu_scheduler_active = 2, debug_locks = 0
> > > no locks held by udevd/9038.
> > >
> > > stack backtrace:
> > > CPU: 3 PID: 9038 Comm: udevd Not tainted 5.10.0-rc7-syzkaller #0
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > > Call Trace:
> > >  __dump_stack lib/dump_stack.c:77 [inline]
> > >  dump_stack+0x107/0x163 lib/dump_stack.c:118
> > >  ___might_sleep+0x220/0x2b0 kernel/sched/core.c:7270
> > >  count.constprop.0+0x164/0x270 fs/exec.c:449
> > >  do_execveat_common+0x2fd/0x7c0 fs/exec.c:1893
> > >  do_execve fs/exec.c:1983 [inline]
> > >  __do_sys_execve fs/exec.c:2059 [inline]
> > >  __se_sys_execve fs/exec.c:2054 [inline]
> > >  __x64_sys_execve+0x8f/0xc0 fs/exec.c:2054
> > >  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >
> > This must be the victim of something else.  There's no way this call
> > trace took the RCU read lock.
> 
> +lockdep maintainers for lockdep false positive then and +Paul for rcu

Note that this was "RCU-bh" rather than "RCU", so it might be something
like local_bh_disable() rather than rcu_read_lock() that might_sleep()
is complaining about.

> There is another recent claim of a false "suspicious RCU usage":
> https://lore.kernel.org/lkml/CAKMK7uEiS5SrBYv-2w2wWL=9G4ByoHvtiWVsPqekswZzOGmzjg@mail.gmail.com/

That one does look familiar.  ;-)

							Thanx, Paul
