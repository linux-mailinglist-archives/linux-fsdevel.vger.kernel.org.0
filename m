Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113FB6C235D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 22:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCTVGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 17:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCTVGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:06:52 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF1B1968A
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 14:06:43 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id w4-20020a5d9604000000b0074d326b26bcso6770173iol.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 14:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679346402;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3Im1iotephzHTArso9JzNxY2sG0ihvzovoTm2quEmw=;
        b=XRkSXQp5PgDUfDCjbilq2HkdIVH/FUh14QTDm/KsLVn8Z4gwhpzb7bs5UT9ihe8/Rn
         Hqu0v41oKBRQ5Y3GaCC+dcLtPgoYhNgEZHuB48r1HA4SrLTHEWCFnEowO/Ye6X9E/Xlc
         qYs1vlKFgZi6qbLR0WcaZCWgnG09lFS2sNJ3X/74j4HB6fApxrOj1PbLEsH2OXgwlQPM
         m2zitzUE6+kbzi9bBuWgbbQDrHN3+kf83yhbRRywHmXhyQUlgdksA5jbxL8sCnkU+Klk
         xk6n935vVN7Ot8HmTTldSY0LsKTC18LHQHh/LG6oyZABiHJiGi4yxCGhBmt/IO20UeR/
         aPkg==
X-Gm-Message-State: AO0yUKWUgdO1PcmmT6llVarsNbY9kRoyYHzuHdUdPz/Jd0dxuea47Mz6
        BOccy32J/MWY3Xn3az3n8h0U8c9NMB2fgG6E63DNTY5uIFMa
X-Google-Smtp-Source: AK7set8KtlUE2+vk3LTvNYhn04bytoou0egQwD9Gj82l5pYzyxhz8hVnyM/JuhZMSxLtVCREXukf1/K+mFIs9AW6HCgWwxMj1frF
MIME-Version: 1.0
X-Received: by 2002:a6b:3109:0:b0:755:ba1c:1452 with SMTP id
 j9-20020a6b3109000000b00755ba1c1452mr128358ioa.4.1679346402513; Mon, 20 Mar
 2023 14:06:42 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:06:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6dc0305f75b4d74@google.com>
Subject: [syzbot] [fs?] INFO: task hung in eventpoll_release_file
From:   syzbot <syzbot+e6dab35a08df7f7aa260@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6f72958a49f6 Add linux-next specific files for 20230316
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=178faee6c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd64232230d3a0d8
dashboard link: https://syzkaller.appspot.com/bug?extid=e6dab35a08df7f7aa260
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1156a6ecc80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179e9648c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3fcac83e3d53/disk-6f72958a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/37b457d3103a/vmlinux-6f72958a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b82735625cce/bzImage-6f72958a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6dab35a08df7f7aa260@syzkaller.appspotmail.com

INFO: task syz-executor397:5874 blocked for more than 143 seconds.
      Not tainted 6.3.0-rc2-next-20230316-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor397 state:D stack:27072 pid:5874  ppid:5147   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5305 [inline]
 __schedule+0x1d23/0x5650 kernel/sched/core.c:6623
 schedule+0xde/0x1a0 kernel/sched/core.c:6699
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6758
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa3b/0x1350 kernel/locking/mutex.c:747
 eventpoll_release_file+0xe2/0x1d0 fs/eventpoll.c:962
 eventpoll_release include/linux/eventpoll.h:53 [inline]
 __fput+0x7da/0xa90 fs/file_table.c:312
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0183a1b0b9
RSP: 002b:00007f01831bf208 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: 0000000000000116 RBX: 00007f0183a9d4a8 RCX: 00007f0183a1b0b9
RDX: 0000000000000318 RSI: 00000000200bd000 RDI: 0000000000000004
RBP: 00007f0183a9d4a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0183a9d4ac
R13: 00007fff8a59281f R14: 00007f01831bf300 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8c795830 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:516
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8c795530 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:516
1 lock held by khungtaskd/28:
 #0: ffffffff8c796400 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x51/0x390 kernel/locking/lockdep.c:6545
2 locks held by getty/4761:
 #0: ffff88814a34b098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2177
1 lock held by syz-executor397/5873:
1 lock held by syz-executor397/5874:
 #0: ffff88801e3d5c68 (&ep->mtx){+.+.}-{3:3}, at: eventpoll_release_file+0xe2/0x1d0 fs/eventpoll.c:962

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.3.0-rc2-next-20230316-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x29c/0x350 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x2a4/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xe16/0x1090 kernel/hung_task.c:379
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5873 Comm: syz-executor397 Not tainted 6.3.0-rc2-next-20230316-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:29 [inline]
RIP: 0010:rcu_dynticks_curr_cpu_in_eqs include/linux/context_tracking.h:121 [inline]
RIP: 0010:rcu_is_watching+0x47/0xb0 kernel/rcu/tree.c:695
Code: c5 77 7a 48 8d 3c ed 00 fa 10 8c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 03 1c ed 00 fa 10 8c <48> b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 0f b6 14 02 48
RSP: 0018:ffffc90004c9fc58 EFLAGS: 00000282
RAX: dffffc0000000000 RBX: ffff8880b9936c68 RCX: ffffffff8164cf65
RDX: 1ffffffff1821f41 RSI: 0000000000000002 RDI: ffffffff8c10fa08
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8e784717
R10: fffffbfff1cf08e2 R11: 0000000000000000 R12: ffff8880772cf1c8
R13: ffff88801e3d5c00 R14: ffff8880772cf180 R15: 0000000000000000
FS:  0000555556477400(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005642a1c9c5c0 CR3: 0000000025100000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x4fb/0x670 kernel/locking/lockdep.c:5702
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x16/0x40 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:390 [inline]
 __ep_remove+0x6ce/0xa50 fs/eventpoll.c:737
 ep_remove_safe fs/eventpoll.c:782 [inline]
 ep_clear_and_put+0x21c/0x3b0 fs/eventpoll.c:815
 ep_eventpoll_release+0x45/0x60 fs/eventpoll.c:831
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f01839d3dfb
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007fff8a592880 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 00007f01839d3dfb
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000152fad R08: 0000000000000000 R09: 00007fff8a5a7080
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f0183a9d4bc
R13: 00007fff8a592900 R14: 00007fff8a5929a0 R15: 00007f0183a9d4a0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
