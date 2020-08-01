Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9F235132
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 10:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgHAIp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 04:45:28 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55574 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHAIp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 04:45:28 -0400
Received: by mail-io1-f70.google.com with SMTP id k10so22661528ioh.22
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2020 01:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BBZutkTacxr13XLgNd/6w5PuH2prdsr2nIYsAbJDDKU=;
        b=GDm+qYsHsGAJyu/dQUUdnwdMFmgPKLy8uvV1AwHxMdcr0IyJFZg2sTiC+/9cmwZKNS
         uUGrTyRhftOKGewrRuZmSEbOgqBN7ZjfBUiaiLCNV04Q/2zl9R6T4BuU978RBxt7atD3
         Svz2iPyyH08MwVFQhGkygRkCbU3SRCd5sfkTQsQaDaQ0HcpaG/LMqYSXltKxkrekKFkB
         JctWpbFX+wo5nLyKyAh4QOTZtIIYAJo163iDJcakfo0eSxQqtabwQpJIUKvufHw2ssoS
         APWp0YuSLlDf88ei172KhnclLcit/edWReI3xVvsehVVV8JSmP8iQsPT/UaUtHF7IVtE
         ddXQ==
X-Gm-Message-State: AOAM533SEP5SdryptJFgU3u2lCK7DRLQgMFTvmaAypAPeayJGuVZt9FU
        iXbjMbVGlLJIvdQ3/QNTJJozMG4XMv16FwwmIlGlGQBAETtM
X-Google-Smtp-Source: ABdhPJykFeeU+YUoXWj37adu0JRTJ55m2zCkK8xSDPcBzGxRSfISmpe2Y+PHMJwhN/AFjPEOl2lvM7QjOgY1cmngMeUyZw0TmY/E
MIME-Version: 1.0
X-Received: by 2002:a92:da10:: with SMTP id z16mr7687513ilm.293.1596271525997;
 Sat, 01 Aug 2020 01:45:25 -0700 (PDT)
Date:   Sat, 01 Aug 2020 01:45:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045b3fe05abcced2f@google.com>
Subject: INFO: task hung in pipe_read (2)
From:   syzbot <syzbot+96cc7aba7e969b1d305c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    01830e6c Add linux-next specific files for 20200731
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11b922e0900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e226b2d1364112c
dashboard link: https://syzkaller.appspot.com/bug?extid=96cc7aba7e969b1d305c
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e5d5c900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96cc7aba7e969b1d305c@syzkaller.appspotmail.com

INFO: task syz-execprog:6857 blocked for more than 143 seconds.
      Not tainted 5.8.0-rc7-next-20200731-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-execprog    D27640  6857   6837 0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3669 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4418
 schedule+0xd0/0x2a0 kernel/sched/core.c:4493
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4552
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10e0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_read+0x136/0x13d0 fs/pipe.c:247
 call_read_iter include/linux/fs.h:1870 [inline]
 new_sync_read+0x5b3/0x6e0 fs/read_write.c:414
 vfs_read+0x383/0x5a0 fs/read_write.c:493
 ksys_read+0x1ee/0x250 fs/read_write.c:624
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4ad88b
Code: Bad RIP value.
RSP: 002b:000000c00002ae10 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000000c000020800 RCX: 00000000004ad88b
RDX: 0000000000010000 RSI: 000000c000390000 RDI: 0000000000000008
RBP: 000000c00002ae60 R08: 0000000000000001 R09: 0000000000000002
R10: 000000c000380000 R11: 0000000000000202 R12: 0000000000000003
R13: 000000c000082a80 R14: 000000c000310600 R15: 0000000000000000
INFO: task syz-executor.0:17080 blocked for more than 143 seconds.
      Not tainted 5.8.0-rc7-next-20200731-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D29144 17080  16608 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3669 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4418
 schedule+0xd0/0x2a0 kernel/sched/core.c:4493
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4552
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10e0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_write+0x12c/0x16c0 fs/pipe.c:435
 call_write_iter include/linux/fs.h:1876 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:515
 vfs_write+0x5ad/0x730 fs/read_write.c:595
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cc79
Code: Bad RIP value.
RSP: 002b:00007fff6c963cf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000037d40 RCX: 000000000045cc79
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000000
RBP: 000000000078bf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000790378
R13: 0000000000000000 R14: 0000000000000df5 R15: 000000000078bf0c
INFO: task syz-executor.0:17140 blocked for more than 144 seconds.
      Not tainted 5.8.0-rc7-next-20200731-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D29144 17140  16608 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3669 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4418
 schedule+0xd0/0x2a0 kernel/sched/core.c:4493
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4552
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10e0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_write+0x12c/0x16c0 fs/pipe.c:435
 call_write_iter include/linux/fs.h:1876 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:515
 vfs_write+0x5ad/0x730 fs/read_write.c:595
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cc79
Code: Bad RIP value.
RSP: 002b:00007fff6c963cf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000037d40 RCX: 000000000045cc79
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000000
RBP: 000000000078bf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000790378
R13: 0000000000000000 R14: 0000000000000df5 R15: 000000000078bf0c
INFO: task syz-executor.0:17145 blocked for more than 145 seconds.
      Not tainted 5.8.0-rc7-next-20200731-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D29144 17145  16608 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3669 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4418
 schedule+0xd0/0x2a0 kernel/sched/core.c:4493
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4552
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10e0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_write+0x12c/0x16c0 fs/pipe.c:435
 call_write_iter include/linux/fs.h:1876 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:515
 vfs_write+0x5ad/0x730 fs/read_write.c:595
 ksys_write+0x1ee/0x250 fs/read_write.c:648
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cc79
Code: Bad RIP value.
RSP: 002b:00007fff6c963cf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000037d40 RCX: 000000000045cc79
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000000
RBP: 000000000078bf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000790378
R13: 0000000000000000 R14: 0000000000000df5 R15: 000000000078bf0c

Showing all locks held in the system:
1 lock held by khungtaskd/1170:
 #0: ffffffff89c52a80 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5823
1 lock held by systemd-udevd/3906:
1 lock held by in:imklog/6629:
 #0: ffff8880996bf930 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930
1 lock held by syz-execprog/6857:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_read+0x136/0x13d0 fs/pipe.c:247
1 lock held by syz-executor.0/16822:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x5bd/0x16c0 fs/pipe.c:580
1 lock held by syz-executor.0/17080:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17140:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17145:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17209:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17222:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17312:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17314:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17317:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17333:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17360:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17363:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17369:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17377:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17382:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17385:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17390:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17400:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17410:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17415:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17441:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17489:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17501:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17516:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17524:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17531:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17574:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17579:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17582:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17584:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17587:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17590:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17593:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17595:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17600:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17605:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17610:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17612:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17615:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17625:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17632:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17637:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17661:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17691:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17731:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17752:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17764:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17781:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17786:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17791:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17794:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17819:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17829:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17876:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17891:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17894:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17896:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/17906:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18001:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18044:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18054:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18067:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18087:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18093:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18098:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18105:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18130:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18133:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18146:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18149:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18153:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18165:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18173:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18185:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18190:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18195:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18202:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18207:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18217:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18222:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18225:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18237:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18250:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18255:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18269:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18286:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18296:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18304:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18306:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18311:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18321:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18335:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18340:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18343:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18358:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18361:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18363:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18378:
1 lock held by syz-executor.0/18409:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/18792:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19006:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19154:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/19338:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20014:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20107:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20266:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20673:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/20961:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21389:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21601:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21778:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21835:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/21965:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22161:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22243:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22293:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22530:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22681:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22732:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/22837:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/23154:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/23328:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/23804:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/24439:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/24641:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/24706:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/24903:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/25118:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/25179:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/25463:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/25472:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/25518:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/25592:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/25594:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/25880:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/25891:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/25902:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/25953:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/26037:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/26090:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/26218:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/26292:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/26496:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/26671:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/26755:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/26764:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/27070:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/27105:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/27176:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/27637:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435
1 lock held by syz-executor.0/27730:
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888092562068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x12c/0x16c0 fs/pipe.c:435

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1170 Comm: khungtaskd Not tainted 5.8.0-rc7-next-20200731-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x223 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:147 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:253 [inline]
 watchdog+0xd89/0xf30 kernel/hung_task.c:339
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 3905 Comm: systemd-journal Not tainted 5.8.0-rc7-next-20200731-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0033:0x7ffc39794990
Code: ff ff ff 7f 48 8d 05 0f b7 ff ff 48 8d 15 08 e7 ff ff 48 0f 44 c2 48 85 ff 48 8b 40 20 74 03 48 89 07 c3 0f 1f 80 00 00 00 00 <55> 48 89 e5 41 55 4c 63 ef 41 54 49 89 f4 48 83 ec 08 41 83 fd 0f
RSP: 002b:00007ffc397271d8 EFLAGS: 00000206
RAX: 00007ffc39794990 RBX: 0000000000000000 RCX: 00000000000000cc
RDX: 00000000000003e7 RSI: 00007ffc39727200 RDI: 0000000000000000
RBP: 00007ffc39727200 R08: 00005615fdccd3e5 R09: 0000000000000018
R10: 0000000000000069 R11: 0000000000000246 R12: 000000000000014d
R13: 00000000000012bf R14: 0000000000000033 R15: 00007ffc397276f0
FS:  00007fade38dd8c0 GS:  0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
