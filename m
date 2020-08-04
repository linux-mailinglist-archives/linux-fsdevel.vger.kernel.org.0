Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6F323C1F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 00:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHDW5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 18:57:25 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52414 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgHDW5W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 18:57:22 -0400
Received: by mail-io1-f72.google.com with SMTP id k12so30278267iom.19
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2020 15:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iqKP25UzsiCIOGmwjG5Hi6ShesiPUDsF5DFtcFdbi2w=;
        b=sLBr8sa0dUxwPSbcT/iOzi4ihOUJrNIY9UWtC2/jB5iaMpbxCXLoouOaadu6vc+Xnk
         0Lzd+OI8GASXuhgtRa8+ljkBXeD0ZSnZtJPPLdU/4WrD0yRzdraDnV1Ho0IgY0AYdHGN
         JPygm1nHZgzAPQimc8wXcDnaTvHhe9xEZn86N54uxw1hLMQpbqTVKGUxRyehyLLjkzj1
         tXu07e/64lXRZBc5E5qobA9W96dmRUySvxqqw1Z9K1jP47SxC0Fzjbfq9bsghZ2+FPDX
         Ct2cPZckC25ULx41yus9griG8CxMUt4/ecEESC1cSzvkWiqOvC7kyxHGKy+s0V9FNZrW
         tHWA==
X-Gm-Message-State: AOAM533fWBIFKa0ws4gByFmpsVbLvotIZCPYfKog9c2R2TH+CyX4/t2x
        FOkDXbgszWtML2LgUdWRBxEiqWAgaCb0Qri4lve0Rkt1vz53
X-Google-Smtp-Source: ABdhPJwDDM1beuT81/qBcgL1dJer8YnCjm1ioGAfCzPKJK0aZOEj6wI9IccceHh0K9lXed9nJY+/j2cq8vBcw6Wlr8u9ihU4jtpA
MIME-Version: 1.0
X-Received: by 2002:a92:d392:: with SMTP id o18mr859787ilo.224.1596581841211;
 Tue, 04 Aug 2020 15:57:21 -0700 (PDT)
Date:   Tue, 04 Aug 2020 15:57:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008017b905ac152dfe@google.com>
Subject: INFO: task can't die in pipe_release
From:   syzbot <syzbot+e9a0f7eeac6eb345692d@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=161d1214900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e226b2d1364112c
dashboard link: https://syzkaller.appspot.com/bug?extid=e9a0f7eeac6eb345692d
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16441648900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e9a0f7eeac6eb345692d@syzkaller.appspotmail.com

INFO: task syz-executor.0:7667 can't die for more than 143 seconds.
syz-executor.0  D28360  7667   6876 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3669 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4418
 schedule+0xd0/0x2a0 kernel/sched/core.c:4493
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4552
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10e0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_release+0x49/0x320 fs/pipe.c:722
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:135
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:139 [inline]
 exit_to_user_mode_prepare+0x195/0x1c0 kernel/entry/common.c:166
 syscall_exit_to_user_mode+0x59/0x2b0 kernel/entry/common.c:241
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x416791
Code: Bad RIP value.
RSP: 002b:00007ffd7aff1510 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000416791
RDX: 0000000000000000 RSI: 00000000007904d0 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffd7aff1600 R11: 0000000000000293 R12: 00000000007905a8
R13: 000000000010297d R14: ffffffffffffffff R15: 000000000078bfac
INFO: task syz-executor.0:7667 blocked for more than 143 seconds.
      Not tainted 5.8.0-rc7-next-20200731-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.0  D28360  7667   6876 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3669 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4418
 schedule+0xd0/0x2a0 kernel/sched/core.c:4493
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4552
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10e0 kernel/locking/mutex.c:1103
 __pipe_lock fs/pipe.c:87 [inline]
 pipe_release+0x49/0x320 fs/pipe.c:722
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:135
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:139 [inline]
 exit_to_user_mode_prepare+0x195/0x1c0 kernel/entry/common.c:166
 syscall_exit_to_user_mode+0x59/0x2b0 kernel/entry/common.c:241
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x416791
Code: Bad RIP value.
RSP: 002b:00007ffd7aff1510 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000416791
RDX: 0000000000000000 RSI: 00000000007904d0 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffd7aff1600 R11: 0000000000000293 R12: 00000000007905a8
R13: 000000000010297d R14: ffffffffffffffff R15: 000000000078bfac
INFO: task syz-executor.0:7670 can't die for more than 143 seconds.
syz-executor.0  R  running task    28640  7670   6876 0x00004006
Call Trace:

Showing all locks held in the system:
1 lock held by khungtaskd/1166:
 #0: ffffffff89c52a80 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5823
1 lock held by in:imklog/6548:
 #0: ffff8880a78ff6b0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930
1 lock held by syz-executor.0/7667:
 #0: ffff888095b17068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:87 [inline]
 #0: ffff888095b17068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_release+0x49/0x320 fs/pipe.c:722
2 locks held by syz-executor.0/7670:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1166 Comm: khungtaskd Not tainted 5.8.0-rc7-next-20200731-syzkaller #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 7670 Comm: syz-executor.0 Not tainted 5.8.0-rc7-next-20200731-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x9/0x60 kernel/kcov.c:197
Code: 5d be 03 00 00 00 e9 a6 06 27 02 66 0f 1f 44 00 00 48 8b be b0 01 00 00 e8 b4 ff ff ff 31 c0 c3 90 65 48 8b 14 25 c0 fe 01 00 <65> 8b 05 60 be 8d 7e a9 00 01 ff 00 48 8b 34 24 74 0f f6 c4 01 74
RSP: 0018:ffffc9000810f8c8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83996704
RDX: ffff888099a02400 RSI: ffff888099a02400 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff888098fb63c7
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffffc9000810fcd0 R14: dffffc0000000000 R15: ffff88808a07c800
FS:  00007f1f60805700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d76e4bd938 CR3: 00000000a8964000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 iov_iter_alignment+0x4c2/0x850 lib/iov_iter.c:1237
 ext4_unaligned_io fs/ext4/file.c:175 [inline]
 ext4_dio_write_iter fs/ext4/file.c:465 [inline]
 ext4_file_write_iter+0x345/0x1390 fs/ext4/file.c:655
 call_write_iter include/linux/fs.h:1876 [inline]
 do_iter_readv_writev+0x567/0x780 fs/read_write.c:730
 do_iter_write+0x188/0x670 fs/read_write.c:1035
 vfs_iter_write+0x70/0xa0 fs/read_write.c:1076
 iter_file_splice_write+0x721/0xbe0 fs/splice.c:667
 do_splice_from fs/splice.c:736 [inline]
 do_splice+0xbb8/0x17a0 fs/splice.c:1043
 __do_sys_splice fs/splice.c:1318 [inline]
 __se_sys_splice fs/splice.c:1300 [inline]
 __x64_sys_splice+0x198/0x250 fs/splice.c:1300
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cc79
Code: 2d b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb b5 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1f60804c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 0000000000032b80 RCX: 000000000045cc79
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000078bff8 R08: 000000000000ffe0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bfac
R13: 00007ffd7aff149f R14: 00007f1f608059c0 R15: 000000000078bfac


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
