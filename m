Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB54E2B0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 15:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343673AbiCUOn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 10:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349690AbiCUOnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:43:17 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86A118BCCF
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 07:41:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 17so20181058lji.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 07:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=75Gwq4uHWEN6DEz0j9a7FSUGeVHdNTQqq72dygCbFyU=;
        b=Ifna/CHrQAnT5/LK1JI6Od2Y8qAp5JdHTZcb3L0bAL46Po6MAUaw/J4QGSXVe9707j
         u0uFsPlTz9sIRnWTYp7DNDUP21oh0G4LcxsNoGKVZHFddg6ODUHI6m1w2niZBfPhvSZI
         OQUOtNu54JuwLFTixxAq+TNT0AUNt68NWqmhxp/mVw+mLczveaAoXZV11lojcttCPnmG
         RstKBoKuDN/AVRRRcZr8WZ/V8CbOmjesp4D/OdrPD1vvXe9wWPdaE80nTe8CJ4HWZUbR
         Piboqu2cqzJUSiO/iconevRs9Ky6bTDkgk3oewG3BvY8fdgHdqkHXHO6iti1V49K9qJy
         M+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=75Gwq4uHWEN6DEz0j9a7FSUGeVHdNTQqq72dygCbFyU=;
        b=IvWO0xGj3Xr0xuYAMFj42WvE/mxpj9e7oZG1EAycmwGMCKQagelJkenDQKmfKnwLRX
         RFcDUiS2lQ5wG6hnO5AHQ4KrcLJ/mowloHV9mLYCbjNJJ979iJXy2YYIltunyoJJOZqO
         dSA9M9m1GXVogyk3qn95fov5EI13HXvrmyI0tUnrYCcezcH/dxINsnpN0+ZWuPUrqZLN
         8hZNSDhjrF1/vC+YpPyZCy8BXZgQr4PSGbmT8e9NGgqMKlLMSQd+Awgo0AESQo2/MJ58
         ldeejmeTgDsRGuUlyAN8Qke+MIV6iEYvqw59NYv+0L0zC/YevAgv85LYTBx9ySpDdOTv
         YuXg==
X-Gm-Message-State: AOAM533RttHeR8H00yh/BYXslzgfHScyavBUkssj0rqO5iIe7aQYHrBP
        AuuttBsjcpb3ZCAfaz2HtWAIy8IsaBXJX1YWrgHTHg==
X-Google-Smtp-Source: ABdhPJxFqljoMBBwSBqHrF2ieRsY0JDuV+pkq1EcUn8iOy26rx7V0hLtdFw2WLdtJJj7VMSxabUROv3JxtP2Jage4Rc=
X-Received: by 2002:a2e:3607:0:b0:249:87a5:af18 with SMTP id
 d7-20020a2e3607000000b0024987a5af18mr2707697lja.93.1647873709522; Mon, 21 Mar
 2022 07:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000778f1005dab1558e@google.com>
In-Reply-To: <000000000000778f1005dab1558e@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 21 Mar 2022 15:41:13 +0100
Message-ID: <CAG48ez2AAk6JpZAA6GPVgvCmKimXHJXO906e=r=WGU06k=HB3A@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in pipe_write
To:     syzbot <syzbot+011e4ea1da6692cf881c@syzkaller.appspotmail.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This also looks like a watch_queue bug.

On Mon, Mar 21, 2022 at 3:34 AM syzbot
<syzbot+011e4ea1da6692cf881c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    56e337f2cf13 Revert "gpio: Revert regression in sysfs-gpio..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13f00f7e700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d35f9bc6884af6c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=011e4ea1da6692cf881c
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133235c5700000

The syz reproducer is:

#{"threaded":true,"procs":1,"slowdown":1,"sandbox":"","close_fds":false}
pipe(&(0x7f0000000240)={<r0=>0xffffffffffffffff, <r1=>0xffffffffffffffff})
pipe2(&(0x7f00000001c0)={0xffffffffffffffff, <r2=>0xffffffffffffffff}, 0x80)
splice(r0, 0x0, r2, 0x0, 0x1ff, 0x0)
vmsplice(r1, &(0x7f00000006c0)=[{&(0x7f0000000080)="b5", 0x1}], 0x1, 0x0)

That 0x80 is O_NOTIFICATION_PIPE (==O_EXCL).

It looks like the bug is that when you try to splice between a normal
pipe and a notification pipe, get_pipe_info(..., true) fails, so
splice() falls back to treating the notification pipe like a normal
pipe - so we end up in iter_file_splice_write(), which first locks the
input pipe, then calls vfs_iter_write(), which locks the output pipe.

I think this probably (?) can't actually lead to deadlocks, since
you'd need another way to nest locking a normal pipe into locking a
watch_queue pipe, but the lockdep annotations don't make that clear.

> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1248ca89700000
>
> Bisection is inconclusive: the issue happens on the oldest tested release.
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f235c5700000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=11f235c5700000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16f235c5700000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+011e4ea1da6692cf881c@syzkaller.appspotmail.com
>
> ============================================
> WARNING: possible recursive locking detected
> 5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0 Not tainted
> --------------------------------------------
> syz-executor190/3593 is trying to acquire lock:
> ffff888078020868 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:103 [inline]
> ffff888078020868 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x132/0x1c00 fs/pipe.c:431
>
> but task is already holding lock:
> ffff888078020468 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_lock_nested fs/pipe.c:82 [inline]
> ffff888078020468 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_lock fs/pipe.c:90 [inline]
> ffff888078020468 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_wait_readable+0x39b/0x420 fs/pipe.c:1049
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&pipe->mutex/1);
>   lock(&pipe->mutex/1);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 1 lock held by syz-executor190/3593:
>  #0: ffff888078020468 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_lock_nested fs/pipe.c:82 [inline]
>  #0: ffff888078020468 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_lock fs/pipe.c:90 [inline]
>  #0: ffff888078020468 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_wait_readable+0x39b/0x420 fs/pipe.c:1049
>
> stack backtrace:
> CPU: 1 PID: 3593 Comm: syz-executor190 Not tainted 5.17.0-rc8-syzkaller-00003-g56e337f2cf13 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_deadlock_bug kernel/locking/lockdep.c:2956 [inline]
>  check_deadlock kernel/locking/lockdep.c:2999 [inline]
>  validate_chain kernel/locking/lockdep.c:3788 [inline]
>  __lock_acquire.cold+0x213/0x3a9 kernel/locking/lockdep.c:5027
>  lock_acquire kernel/locking/lockdep.c:5639 [inline]
>  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
>  __mutex_lock_common kernel/locking/mutex.c:600 [inline]
>  __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:733
>  __pipe_lock fs/pipe.c:103 [inline]
>  pipe_write+0x132/0x1c00 fs/pipe.c:431
>  call_write_iter include/linux/fs.h:2074 [inline]
>  do_iter_readv_writev+0x47a/0x750 fs/read_write.c:725
>  do_iter_write+0x188/0x710 fs/read_write.c:851
>  vfs_iter_write+0x70/0xa0 fs/read_write.c:892
>  iter_file_splice_write+0x723/0xc70 fs/splice.c:689
>  do_splice_from fs/splice.c:767 [inline]
>  do_splice+0xb7e/0x1960 fs/splice.c:1079
>  __do_splice+0x134/0x250 fs/splice.c:1144
>  __do_sys_splice fs/splice.c:1350 [inline]
>  __se_sys_splice fs/splice.c:1332 [inline]
>  __x64_sys_splice+0x198/0x250 fs/splice.c:1332
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fb9ac14bca9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb9ac0fe308 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
> RAX: fffffff
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
