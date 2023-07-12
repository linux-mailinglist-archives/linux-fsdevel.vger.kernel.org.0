Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EBA75001D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 09:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjGLHfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 03:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGLHfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:35:17 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7E5E5C
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 00:35:13 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3a1bcdd0966so8147140b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 00:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689147312; x=1691739312;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+SQFg+7zXK+mKefvUNVcXSJPT7ibCPmFtzOXy4FGgkQ=;
        b=EhjEOK0lwqLd1/PEscLvBdXLpHDpfCH0BoCJuwHElAiQJIHa46V3uloaNHet1JCACb
         oGEOPCH98fitO3x9kSJ2mUynq38mISWiaqtRldhWjMvHpRiA93W5IRTB4HsOTDB/57hW
         sXtwdcLyXVWKBzX07KJDSSdyN135RrYrxYdXIjvZ7Y5ksDRgthRb25M/DYTiKQRuLP8V
         c3+X+EZJCE2VnjH8A8/bbFZxuQ5Hh2I9EB4f80C8xDbWbTczdqJi1OGbGeijE2UP/a7B
         Ro9Ym7sjBwZVmQ9ncIsSxPZH0UFFY1g+1DSrISz7QrLOS54v8ujeFtkm0VPCFmPO9ADv
         lzUw==
X-Gm-Message-State: ABy/qLZ8HyhmL224jqELyJIh/YQUDGKmZ1r48dj9d0iQCZrxXXdxSv+D
        MLXjJO01jFnb7DqWct4ir9BK2y6U5Db9Fznn9/A8fTe7ctPa
X-Google-Smtp-Source: APBJJlE9Bwb8jCHDJDGiKiGGdZY9M32HYBl4dmzk0lNnXQC3JMuXwZhLZ02vPPwFHCQaXw0X4V9cjxbTOsq8JaLaeSdYatQ4RkG5
MIME-Version: 1.0
X-Received: by 2002:aca:b9c2:0:b0:3a1:f3e2:c977 with SMTP id
 j185-20020acab9c2000000b003a1f3e2c977mr3999935oif.11.1689147312445; Wed, 12
 Jul 2023 00:35:12 -0700 (PDT)
Date:   Wed, 12 Jul 2023 00:35:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000881d0606004541d1@google.com>
Subject: [syzbot] [fs?] INFO: task hung in pipe_release (4)
From:   syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16c5cd8ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=150188feee7071a7
dashboard link: https://syzkaller.appspot.com/bug?extid=f527b971b4bdc8e79f9e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a86682a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1520ab6ca80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/991cea284d12/disk-3f01e9fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13051b4d971a/vmlinux-3f01e9fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31cc7c3c2596/bzImage-3f01e9fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com

INFO: task syz-executor421:5031 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc1-syzkaller-00006-g3f01e9fed845 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor421 state:D stack:27728 pid:5031  ppid:5021   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6710
 schedule+0xde/0x1a0 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa3b/0x1350 kernel/locking/mutex.c:747
 __pipe_lock fs/pipe.c:103 [inline]
 pipe_release+0x4d/0x310 fs/pipe.c:721
 __fput+0x40c/0xad0 fs/file_table.c:384
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 ptrace_notify+0x118/0x140 kernel/signal.c:2372
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:252 [inline]
 syscall_exit_to_user_mode_prepare+0x129/0x220 kernel/entry/common.c:279
 __syscall_exit_to_user_mode_work kernel/entry/common.c:284 [inline]
 syscall_exit_to_user_mode+0xd/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbe8982b7da
RSP: 002b:00007ffd74cb3820 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007fbe8982b7da
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 000000000000000a R08: 0000000000000000 R09: 00007ffd74d90080
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000a9f7
R13: 000000000000aa29 R14: 00007fbe898b642c R15: 00007fbe898b6420
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8c9a3af0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8c9a37f0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/28:
 #0: ffffffff8c9a4700 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6615
2 locks held by getty/4773:
 #0: ffff88802d33a098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015c02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xf08/0x13f0 drivers/tty/n_tty.c:2187
1 lock held by syz-executor421/5031:
 #0: ffff888022606868 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:103 [inline]
 #0: ffff888022606868 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_release+0x4d/0x310 fs/pipe.c:721
2 locks held by syz-executor421/5032:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.5.0-rc1-syzkaller-00006-g3f01e9fed845 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x29c/0x350 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x2a4/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xe16/0x1090 kernel/hung_task.c:379
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5032 Comm: syz-executor421 Not tainted 6.5.0-rc1-syzkaller-00006-g3f01e9fed845 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:__ip_append_data+0x957/0x3c90 net/ipv4/ip_output.c:1198
Code: 31 ff 29 eb 89 de e8 d8 6d e9 f8 85 db 0f 8e b5 1a 00 00 e8 ab 71 e9 f8 48 8b 44 24 38 41 39 de 41 0f 4e de 41 89 dc 80 38 00 <0f> 85 15 29 00 00 48 8b 44 24 18 48 8b 18 48 8d bb f0 00 00 00 48
RSP: 0018:ffffc90003b9f520 EFLAGS: 00000246
RAX: ffffed100fab0f00 RBX: 0000000000000006 RCX: 0000000000000000
RDX: ffff888019e95940 RSI: ffffffff889b7015 RDI: 0000000000000005
RBP: 000000000000001c R08: 0000000000000005 R09: 0000000000000000
R10: 000000000000057e R11: 0000000000000001 R12: 0000000000000006
R13: dffffc0000000000 R14: 0000000000000006 R15: ffff8880132dd3c0
FS:  00007fbe897e96c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005598ca226780 CR3: 00000000193f8000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 ip_append_data net/ipv4/ip_output.c:1352 [inline]
 ip_append_data+0x115/0x1a0 net/ipv4/ip_output.c:1331
 udp_sendmsg+0x881/0x2840 net/ipv4/udp.c:1287
 inet_sendmsg+0x9d/0xe0 net/ipv4/af_inet.c:830
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:748
 splice_to_socket+0x964/0xee0 fs/splice.c:882
 do_splice_from fs/splice.c:934 [inline]
 do_splice+0xb8a/0x1ec0 fs/splice.c:1295
 __do_splice+0x14e/0x270 fs/splice.c:1373
 __do_sys_splice fs/splice.c:1584 [inline]
 __se_sys_splice fs/splice.c:1566 [inline]
 __x64_sys_splice+0x19c/0x250 fs/splice.c:1566
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbe8982c519
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbe897e9218 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00007fbe898b6428 RCX: 00007fbe8982c519
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fbe898b6420 R08: 000000000004ffe0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbe898b642c
R13: 00007fbe898834f4 R14: 04000000000003bd R15: 00007ffd74cb3758
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
