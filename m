Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A85234A3DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 10:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCZJMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhCZJMO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A13A961A2D;
        Fri, 26 Mar 2021 09:12:11 +0000 (UTC)
Date:   Fri, 26 Mar 2021 10:12:07 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in filp_close (2)
Message-ID: <20210326091207.5si6knxs7tn6rmod@wittgenstein>
References: <00000000000069c40405be6bdad4@google.com>
 <CACT4Y+baP24jKmj-trhF8bG_d_zkz8jN7L1kYBnUR=EAY6hOaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+baP24jKmj-trhF8bG_d_zkz8jN7L1kYBnUR=EAY6hOaA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 26, 2021 at 09:02:08AM +0100, Dmitry Vyukov wrote:
> On Fri, Mar 26, 2021 at 8:55 AM syzbot
> <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    5ee96fa9 Merge tag 'irq-urgent-2021-03-21' of git://git.ke..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17fb84bed00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6abda3336c698a07
> > dashboard link: https://syzkaller.appspot.com/bug?extid=283ce5a46486d6acdbaf
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com
> 
> I was able to reproduce this with the following C program:
> https://gist.githubusercontent.com/dvyukov/00fb7aae489f22c60b4e64b45ef14d60/raw/cb368ca523d01986c2917f4414add0893b8f4243/gistfile1.txt
> 
> +Christian
> The repro also contains close_range as the previous similar crash:
> https://syzkaller.appspot.com/bug?id=1bef50bdd9622a1969608d1090b2b4a588d0c6ac
> I don't know if it's related or not in this case, but looks suspicious.

Hm, I fail to reproduce this with your repro. Do you need to have it run
for a long time?
One thing that strucky my eye is that binfmt_misc gets setup which made
me go huh and I see commit

commit e7850f4d844e0acfac7e570af611d89deade3146
Author: Lior Ribak <liorribak@gmail.com>
Date:   Fri Mar 12 21:07:41 2021 -0800

    binfmt_misc: fix possible deadlock in bm_register_write

which uses filp_close() after having called open_exec() on the
interpreter which makes me wonder why this doesn't have to use fput()
like in all other codepaths for binfmnt_*.

Can you revert this commit and see if you can reproduce this issue.
Maybe this is a complete red herring but worth a try.

Christian

> 
> 
> > ==================================================================
> > BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> > BUG: KASAN: null-ptr-deref in atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
> > BUG: KASAN: null-ptr-deref in atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
> > BUG: KASAN: null-ptr-deref in filp_close+0x22/0x170 fs/open.c:1289
> > Read of size 8 at addr 0000000000000077 by task syz-executor.4/16965
> >
> > CPU: 0 PID: 16965 Comm: syz-executor.4 Not tainted 5.12.0-rc3-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:79 [inline]
> >  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
> >  __kasan_report mm/kasan/report.c:403 [inline]
> >  kasan_report.cold+0x5f/0xd8 mm/kasan/report.c:416
> >  check_region_inline mm/kasan/generic.c:180 [inline]
> >  kasan_check_range+0x13d/0x180 mm/kasan/generic.c:186
> >  instrument_atomic_read include/linux/instrumented.h:71 [inline]
> >  atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
> >  atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
> >  filp_close+0x22/0x170 fs/open.c:1289
> >  close_files fs/file.c:403 [inline]
> >  put_files_struct fs/file.c:418 [inline]
> >  put_files_struct+0x1d0/0x350 fs/file.c:415
> >  exit_files+0x7e/0xa0 fs/file.c:435
> >  do_exit+0xbc2/0x2a60 kernel/exit.c:820
> >  do_group_exit+0x125/0x310 kernel/exit.c:922
> >  get_signal+0x42c/0x2100 kernel/signal.c:2773
> >  arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:789
> >  handle_signal_work kernel/entry/common.c:147 [inline]
> >  exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
> >  exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:208
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
> >  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x466459
> > Code: Unable to access opcode bytes at RIP 0x46642f.
> > RSP: 002b:00007feb5e334218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> > RAX: fffffffffffffe00 RBX: 000000000056bf68 RCX: 0000000000466459
> > RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000056bf68
> > RBP: 000000000056bf60 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf6c
> > R13: 0000000000a9fb1f R14: 00007feb5e334300 R15: 0000000000022000
> > ==================================================================
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000069c40405be6bdad4%40google.com.
