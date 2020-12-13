Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C9A2D90B8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 22:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406354AbgLMVNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 16:13:52 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:51630 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406133AbgLMVNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 16:13:52 -0500
Received: by mail-il1-f198.google.com with SMTP id 1so8521777ilg.18
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 13:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cj9jZMXFcN6+FM67ipGQ3rExFovnFuNUDqS0LPSBXBk=;
        b=XU2J2t6rkYRzA5sMkTFo2EleVlv4Tz5iKpuvDmoHe5Gph1Sbq9W6QN6GJa4505QdH/
         NJfyWU9E2gsyrcxTV2jEuPe9hkadnufvgc0hiQWWTUDMe0eecxsJ4TSgy8GLKpc3JTvS
         TLfAnEyrTetNhIisIL9SFjPsyTJ0LA1sVCb06kU+sDgozGYXiiokRMRb+Kvomi17MW57
         s+gXy5HVhfXoUIxAaeQgHBFjxMZG3WvAyY/FBH/wfu5NlOBzuOR1B6Wpw92YrqWISSf/
         ByiYck6kzu/pMW23g7kicSkrlwsSaxz4q2kzWq8S1QyGLt1DtchtO2Ruz05vJbTydyir
         07fA==
X-Gm-Message-State: AOAM5339EXEA0+bcMDAMCn5U094Y+9bgbvs3qntXhQHFYbTCBmkesV05
        sSSk4eJhPsLpSw8hUBSqb2oUAMQAa3DDfxP2VuzPvbuUVjMm
X-Google-Smtp-Source: ABdhPJz26V+bBhVOozz5Zybfyb/FTBQvmEfNE7mnomLtNRnftNXc2J7NtzlcBliMivaPhqSjdf7IS7y8MldLMYFOtqumE7k3w1rS
MIME-Version: 1.0
X-Received: by 2002:a02:9107:: with SMTP id a7mr3388727jag.12.1607893990855;
 Sun, 13 Dec 2020 13:13:10 -0800 (PST)
Date:   Sun, 13 Dec 2020 13:13:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000295a6a05b65efe35@google.com>
Subject: INFO: task hung in fuse_simple_request
From:   syzbot <syzbot+46fe899420456e014d6b@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7b1b868e Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e17137500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3416bb960d5c705d
dashboard link: https://syzkaller.appspot.com/bug?extid=46fe899420456e014d6b
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46fe899420456e014d6b@syzkaller.appspotmail.com

INFO: task syz-executor.0:12044 blocked for more than 143 seconds.
      Not tainted 5.10.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28152 pid:12044 ppid:  8506 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3779 [inline]
 __schedule+0x893/0x2130 kernel/sched/core.c:4528
 schedule+0xcf/0x270 kernel/sched/core.c:4606
 request_wait_answer+0x552/0x840 fs/fuse/dev.c:411
 __fuse_request_send fs/fuse/dev.c:430 [inline]
 fuse_simple_request+0x58a/0xd10 fs/fuse/dev.c:515
 fuse_do_getattr+0x243/0xcb0 fs/fuse/dir.c:1029
 fuse_update_get_attr fs/fuse/dir.c:1065 [inline]
 fuse_getattr+0x3b0/0x470 fs/fuse/dir.c:1801
 vfs_getattr_nosec+0x246/0x2e0 fs/stat.c:87
 vfs_getattr fs/stat.c:124 [inline]
 vfs_statx+0x18d/0x390 fs/stat.c:189
 vfs_fstatat fs/stat.c:207 [inline]
 vfs_stat include/linux/fs.h:3121 [inline]
 __do_sys_newstat+0x91/0x110 fs/stat.c:349
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e159
RSP: 002b:00007f57f2e19c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 000000000045e159
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200004c0
RBP: 000000000119bfb8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bf8c
R13: 00000000016afb7f R14: 00007f57f2e1a9c0 R15: 000000000119bf8c

Showing all locks held in the system:
2 locks held by kworker/u4:0/8:
 #0: ffff8880b9e34998 (&rq->lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1292 [inline]
 #0: ffff8880b9e34998 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x21a/0x2130 kernel/sched/core.c:4446
 #1: ffff8880b9e20048 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x305/0x440 kernel/sched/psi.c:833
2 locks held by kworker/1:1/34:
 #0: ffff888010066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888010066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888010066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888010066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888010066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x821/0x15a0 kernel/workqueue.c:2243
 #1: ffffc90000e5fda8 ((work_completion)(&rew.rew_work)){+.+.}-{0:0}, at: process_one_work+0x854/0x15a0 kernel/workqueue.c:2247
3 locks held by kworker/u4:4/298:
 #0: ffff888010069138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010069138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888010069138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888010069138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888010069138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888010069138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x821/0x15a0 kernel/workqueue.c:2243
 #1: ffffc90001aafda8 ((reaper_work).work){+.+.}-{0:0}, at: process_one_work+0x854/0x15a0 kernel/workqueue.c:2247
 #2: ffff8880b9e34998 (&rq->lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1292 [inline]
 #2: ffff8880b9e34998 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x21a/0x2130 kernel/sched/core.c:4446
1 lock held by khungtaskd/1631:
 #0: ffffffff8b3378e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6254
3 locks held by systemd-udevd/4897:
1 lock held by in:imklog/8170:
 #0: ffff8880186bcaf0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:932
1 lock held by syz-executor.0/8506:
 #0: ffff888020e38458 (&xt[i].mutex){+.+.}-{3:3}, at: xt_find_table_lock+0x41/0x540 net/netfilter/x_tables.c:1206
1 lock held by syz-executor.1/8533:
 #0: ffff888020e38d88 (&xt[i].mutex){+.+.}-{3:3}, at: xt_find_table_lock+0x41/0x540 net/netfilter/x_tables.c:1206
1 lock held by syz-executor.3/8756:
 #0: ffff888020e38d88 (&xt[i].mutex){+.+.}-{3:3}, at: xt_find_table_lock+0x41/0x540 net/netfilter/x_tables.c:1206
2 locks held by syz-executor.4/8837:
 #0: ffff888020e38d88 (&xt[i].mutex){+.+.}-{3:3}, at: xt_find_table_lock+0x41/0x540 net/netfilter/x_tables.c:1206
 #1: ffffffff8b33ffa8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:290 [inline]
 #1: ffffffff8b33ffa8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x4f2/0x610 kernel/rcu/tree_exp.h:836
2 locks held by syz-executor.2/10213:
 #0: ffff888020e38458 (&xt[i].mutex){+.+.}-{3:3}, at: xt_find_table_lock+0x41/0x540 net/netfilter/x_tables.c:1206
 #1: ffffffff8b33ffa8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:322 [inline]
 #1: ffffffff8b33ffa8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x27e/0x610 kernel/rcu/tree_exp.h:836

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1631 Comm: khungtaskd Not tainted 5.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd43/0xfa0 kernel/hung_task.c:294
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 18218 Comm: syz-executor.0 Not tainted 5.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:unwind_next_frame+0x98/0x1f90 arch/x86/kernel/unwind_orc.c:618
Code: b6 04 02 84 c0 74 08 3c 03 0f 8e 54 0b 00 00 41 8b 2f 31 c0 85 ed 75 3b 48 ba 00 00 00 00 00 fc ff df 48 c7 04 13 00 00 00 00 <48> 8b 9c 24 98 00 00 00 65 48 2b 1c 25 28 00 00 00 0f 85 4a 16 00
RSP: 0000:ffffc900157af888 EFLAGS: 00000286
RAX: 0000000000000001 RBX: 1ffff92002af5f19 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffc900157afef8 RDI: 0000000000000001
RBP: ffffc900157aff28 R08: ffffffff8d62e65a R09: 0000000000000001
R10: 0000000000082081 R11: 0000000000000001 R12: ffffc900157a8000
R13: ffffc900157af995 R14: ffffc900157af9b0 R15: ffffc900157af960
FS:  000000000344a940(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f57f2dd8d90 CR3: 0000000022b2a000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:461
 slab_post_alloc_hook mm/slab.h:535 [inline]
 slab_alloc_node mm/slub.c:2891 [inline]
 slab_alloc mm/slub.c:2899 [inline]
 kmem_cache_alloc+0x1c6/0x440 mm/slub.c:2904
 anon_vma_chain_alloc mm/rmap.c:136 [inline]
 __anon_vma_prepare+0x5d/0x560 mm/rmap.c:190
 anon_vma_prepare include/linux/rmap.h:153 [inline]
 do_anonymous_page mm/memory.c:3520 [inline]
 handle_pte_fault mm/memory.c:4372 [inline]
 __handle_mm_fault mm/memory.c:4509 [inline]
 handle_mm_fault+0x87d/0x55d0 mm/memory.c:4607
 do_user_addr_fault+0x55b/0xb40 arch/x86/mm/fault.c:1372
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1485
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:583
RIP: 0033:0x41557f
Code: 0f 84 c8 02 00 00 48 83 bd 78 ff ff ff 00 0f 84 f9 04 00 00 48 8b 95 68 ff ff ff 44 89 95 38 ff ff ff 4c 8d ac 10 00 f7 ff ff <49> 89 85 90 06 00 00 49 8d 85 10 03 00 00 49 89 95 98 06 00 00 41
RSP: 002b:00000000016afb10 EFLAGS: 00010206
RAX: 00007f57f2db8000 RBX: 0000000000020000 RCX: 000000000045e1aa
RDX: 0000000000021000 RSI: 0000000000021000 RDI: 0000000000000000
RBP: 00000000016afbf0 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000016afce0
R13: 00007f57f2dd8700 R14: 0000000000000003 R15: 000000000119c0dc


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
