Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D147343B43E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 16:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbhJZOgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 10:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234211AbhJZOgC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:36:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A491610A0;
        Tue, 26 Oct 2021 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635258818;
        bh=2DDd82a6pBIXPZXoD4v/5F9Mf9Q9FC+VQw0+Z7QOTKQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qxhovtrPHavixa1LZdhWOwnO6V4lEjEdWdvA/IxLFpeJkxPrt6oIZBpe2dD9T15SE
         QUM7dmFIf4LACczKunnblhoVmTSJ7Tk3ifqoeMhzQocam/gh/HPnBBGs2UtLx+u9SF
         j/AJVqcCVpeo+hKkDbnc6xlnuFIycMSjjXA9zatU4NLNeqOC5DvyTBBJA3fXvQxMqZ
         BEWwGA+NujzkZblCRjWKMEozgicjZZmw+J8dhhiNZQqlJN4JcGMXH0bOfohQ/xqbdj
         DjubW1NZFltxZMG/2yAuOZ/mfqATHIPUsouDBATGjP3wBKh7ilC2cxdvCp2v5hxEOl
         6rVKTM8Sn8Esw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 546755C0D48; Tue, 26 Oct 2021 07:33:37 -0700 (PDT)
Date:   Tue, 26 Oct 2021 07:33:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+4dfb96a94317a78f44d9@syzkaller.appspotmail.com>,
        rcu@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] KCSAN: data-race in call_rcu / rcu_gp_fqs_loop
Message-ID: <20211026143337.GA1861432@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <000000000000ddb95c05cf2ad54a@google.com>
 <CANpmjNPC6Oqq3+8ENDfM=jXUtY+_zWHAkAE5Wq87ZMYZMV6uLg@mail.gmail.com>
 <20211026140729.GW880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026140729.GW880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 07:07:30AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 25, 2021 at 12:31:53PM +0200, Marco Elver wrote:
> > +Cc Paul
> > 
> > data race is in rcu code, presumably not yet discovered by rcutorture?
> 
> Quite possibly, and I will take a look.  Thank you for sending this
> along.

And this is (allegedly) fixed by commit 2431774f04d10 ("rcu: Mark accesses
to rcu_state.n_force_qs"), which is in -rcu and slated for the upcoming
merge window.  But yes, still a bug in mainline.

							Thanx, Paul

> > On Mon, 25 Oct 2021 at 12:29, syzbot
> > <syzbot+4dfb96a94317a78f44d9@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    9c0c4d24ac00 Merge tag 'block-5.15-2021-10-22' of git://gi..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=159c4954b00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=6339b6ea86d89fd7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=4dfb96a94317a78f44d9
> > > compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+4dfb96a94317a78f44d9@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KCSAN: data-race in call_rcu / rcu_gp_fqs_loop
> > >
> > > write to 0xffffffff837342e0 of 8 bytes by task 11 on cpu 1:
> > >  rcu_gp_fqs kernel/rcu/tree.c:1910 [inline]
> > >  rcu_gp_fqs_loop+0x348/0x470 kernel/rcu/tree.c:1971
> > >  rcu_gp_kthread+0x25/0x1a0 kernel/rcu/tree.c:2130
> > >  kthread+0x262/0x280 kernel/kthread.c:319
> > >  ret_from_fork+0x1f/0x30
> > >
> > > read to 0xffffffff837342e0 of 8 bytes by task 379 on cpu 0:
> > >  __call_rcu_core kernel/rcu/tree.c:2904 [inline]
> > >  __call_rcu kernel/rcu/tree.c:3020 [inline]
> > >  call_rcu+0x4c0/0x6d0 kernel/rcu/tree.c:3067
> > >  __dentry_kill+0x3ec/0x4e0 fs/dcache.c:596
> > >  dput+0xc6/0x360 fs/dcache.c:888
> > >  do_unlinkat+0x2a8/0x540 fs/namei.c:4172
> > >  __do_sys_unlink fs/namei.c:4217 [inline]
> > >  __se_sys_unlink fs/namei.c:4215 [inline]
> > >  __x64_sys_unlink+0x2c/0x30 fs/namei.c:4215
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x44/0xa0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >
> > > value changed: 0x0000000000005c0d -> 0x0000000000005c0e
> > >
> > > Reported by Kernel Concurrency Sanitizer on:
> > > CPU: 0 PID: 379 Comm: udevd Tainted: G        W         5.15.0-rc6-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > ==================================================================
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
