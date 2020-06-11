Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F33D1F62DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 09:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgFKHoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 03:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgFKHoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:44:13 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B2DC08C5C2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2020 00:44:11 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id x16so2262328qvr.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2020 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHKJLDk73oGNQU2dm2DBoF4CrJFguiOo1VrnpaTinr4=;
        b=lTJMXLMKCkck6EnKyoUhMdEyJ/oYzqkutwDUO7rQUN+P1dbVyJxP35Hh8w1K1oYUKt
         ptnVjKhWSCp0fkzvHooqBvz9Y6/J9ZCACQIgTBC/QRjvbFV9xnCV5uZLipSp38uQQ0OQ
         ki2s0yBFQjj34mAB5inEZIIkjDyW23TozjlfzZn7hunEV8jda1rZdUYGIhCcIIHNSyX6
         HCyBc5Tuw+AZTlQuv8vT27ERZs9eAHNxVfCP57LBXu2KlxoaX/rVJusfzUIiDUqn9o44
         45lj4UC1tD75OiYmwO/399lTi6M5na7HFjBZnwj0nsA27QNJvSx3m5OZlNixcBoq40zk
         Thow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHKJLDk73oGNQU2dm2DBoF4CrJFguiOo1VrnpaTinr4=;
        b=qMxZkW4InNz1IkIJBjDir6sGbzyWRO3TBkXu1aw0qdtsS/sUQfDiP2cFno+1JWb0cM
         R9COVOcotfaCiUfzlojTDz2cdrbuKtoIMy4aR7piwbkVKpgS0gnwKRg+pxsyB70hfZD0
         bTIfqA/39brqdHyUH2P6+RIZalTMJgFV+dVZtPlhx2Ds2FSNCbNhJ6xPYKEMoc8yXHn7
         JzN2CIEQpfHIEd0PlOoCxswy/7xU0u2hpNn22cTrpE03dWcWz+r4FBwxiSoZtTDfL7+t
         eBzOg7b6LXLkkq86/PRwzt+EJ0oxcr9aXd9r5csF4+yYmvzFR193vnK+wmfFW4BNY5bw
         bu1Q==
X-Gm-Message-State: AOAM533tuOq8FcV1mX4ftgloIUglSmR8fup3T+NS0xMC/PSC1QHN3Ug9
        5qGaoXhM4UeIiQzXT1qDX4VplkLVS7HIV28FH0RnFg==
X-Google-Smtp-Source: ABdhPJz1KB7fhGyJS65Caw+Sj2mM22hnvjB7Ze94vA8b+z284SPnzDHDOKmEomSn4F7Y9iOJiQtcZGzLVDCDmWb9jQ0=
X-Received: by 2002:ad4:4868:: with SMTP id u8mr6894946qvy.34.1591861450092;
 Thu, 11 Jun 2020 00:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000760d0705a270ad0c@google.com> <69818a6c-7025-8950-da4b-7fdc065d90d6@redhat.com>
In-Reply-To: <69818a6c-7025-8950-da4b-7fdc065d90d6@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Jun 2020 09:43:58 +0200
Message-ID: <CACT4Y+brpePBoR7EUwPiSvGAgo6bhvpKvLTiCaCfRSadzn6yRw@mail.gmail.com>
Subject: Re: possible deadlock in send_sigio
To:     Waiman Long <longman@redhat.com>
Cc:     syzbot <syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, allison@lohutok.net,
        areber@redhat.com, aubrey.li@linux.intel.com,
        Andrei Vagin <avagin@gmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        Christian Brauner <christian@brauner.io>, cyphar@cyphar.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, guro@fb.com,
        Jeff Layton <jlayton@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>, linmiaohe@huawei.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, sargun@sargun.me,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 11, 2020 at 4:33 AM Waiman Long <longman@redhat.com> wrote:
>
> On 4/4/20 1:55 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    bef7b2a7 Merge tag 'devicetree-for-5.7' of git://git.kerne..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15f39c5de00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=91b674b8f0368e69
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a9fb1457d720a55d6dc5
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1454c3b7e00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a22ac7e00000
> >
> > The bug was bisected to:
> >
> > commit 7bc3e6e55acf065500a24621f3b313e7e5998acf
> > Author: Eric W. Biederman <ebiederm@xmission.com>
> > Date:   Thu Feb 20 00:22:26 2020 +0000
> >
> >      proc: Use a list of inodes to flush from proc
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165c4acde00000
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=155c4acde00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=115c4acde00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com
> > Fixes: 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")
> >
> > ========================================================
> > WARNING: possible irq lock inversion dependency detected
> > 5.6.0-syzkaller #0 Not tainted
> > --------------------------------------------------------
> > ksoftirqd/0/9 just changed the state of lock:
> > ffffffff898090d8 (tasklist_lock){.+.?}-{2:2}, at: send_sigio+0xa9/0x340 fs/fcntl.c:800
> > but this lock took another, SOFTIRQ-unsafe lock in the past:
> >   (&pid->wait_pidfd){+.+.}-{2:2}
> >
> >
> > and interrupts could create inverse lock ordering between them.
> >
> >
> > other info that might help us debug this:
> >   Possible interrupt unsafe locking scenario:
> >
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(&pid->wait_pidfd);
> >                                 local_irq_disable();
> >                                 lock(tasklist_lock);
> >                                 lock(&pid->wait_pidfd);
> >    <Interrupt>
> >      lock(tasklist_lock);
> >
> >   *** DEADLOCK ***
>
> That is a false positive. The qrwlock has the special property that it
> becomes unfair (for read lock) at interrupt context. So unless it is
> taking a write lock in the interrupt context, it won't go into deadlock.
> The current lockdep code does not capture the full semantics of qrwlock
> leading to this false positive.

Hi Longman

Thanks for looking into this.
Now the question is: how should we change lockdep annotations to fix this bug?
