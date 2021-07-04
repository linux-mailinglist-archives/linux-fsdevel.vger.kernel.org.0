Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871863BAC2B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jul 2021 10:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhGDI7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 04:59:52 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:50007 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhGDI7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 04:59:51 -0400
Received: by mail-il1-f198.google.com with SMTP id a5-20020a056e020e05b02901ef113bb0fcso8647324ilk.16
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jul 2021 01:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cch0r+JPXZXrmRJNQVGj8QvCVX3qVKWwi389gDGQaAk=;
        b=iFKcOIXC1a7fYrJD3G6Qukt1AePy2niY52wKlVjRt82gbkkVS34m3/LbXoP1frRMWf
         J3WhMXYyxrY7SUAWdukxg9gqydn1VG29tuvhIifPnVplqvN9fE4gIsVHEpthuEXic4en
         zczdrwKBO9KiU3COws3KdNbsuHPIABXJ9m47zs+deUCP0L6A7hTE9MPjRb5qFdipNtDh
         W8z2ewzYzEA0QvU4ZO/zGMzLobI2S/aH3sl8HeeeEoY/54wV3aMoh5/fKigAU12uKVJe
         TEROR1sFDvcjcFzKjI7VRw0COdpxznlV09tHuPv0IdG+OX20tjl6Ir/3HvXw3ha0+1kQ
         5k3Q==
X-Gm-Message-State: AOAM532VWT3z+Iy9DdECe0giFUjYueTBwM5EdJBzRMPdxqdAjluMX1Yi
        oia9GLBUsmaXcn0sxukNT+j6qp14iQhO1ZpzKkn5xUvXrUNk
X-Google-Smtp-Source: ABdhPJyiEVKFW46HilsSfyQEHoNJDvSpN1lEjrVTptv4lweGLp5gHDV7yP828xjLatUWgRkwO4YxU5BT+mlXlxSifY8WrL/HpUOH
MIME-Version: 1.0
X-Received: by 2002:a5d:87d0:: with SMTP id q16mr7192824ios.109.1625389036228;
 Sun, 04 Jul 2021 01:57:16 -0700 (PDT)
Date:   Sun, 04 Jul 2021 01:57:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002054ab05c6486083@google.com>
Subject: [syzbot] possible deadlock in __fs_reclaim_acquire
From:   syzbot <syzbot+127fd7828d6eeb611703@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1333db52300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1700b0b2b41cd52c
dashboard link: https://syzkaller.appspot.com/bug?extid=127fd7828d6eeb611703
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+127fd7828d6eeb611703@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.13.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.3/21469 is trying to acquire lock:
ffffffff8cfd6720 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30 mm/page_alloc.c:4222

but task is already holding lock:
ffff8880b9b31088 (lock#2){-.-.}-{2:2}, at: local_lock_acquire+0x7/0x130 include/linux/local_lock_internal.h:41

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (lock#2){-.-.}-{2:2}:
       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
       local_lock_acquire+0x23/0x130 include/linux/local_lock_internal.h:42
       rmqueue_pcplist+0x10c/0x4d0 mm/page_alloc.c:3675
       rmqueue+0x1eb4/0x22e0 mm/page_alloc.c:3713
       get_page_from_freelist+0x4b3/0xa30 mm/page_alloc.c:4175
       __alloc_pages+0x26c/0x5f0 mm/page_alloc.c:5386
       stack_depot_save+0x361/0x490 lib/stackdepot.c:303
       kasan_save_stack+0x3e/0x50 mm/kasan/common.c:40
       kasan_record_aux_stack+0xee/0x120 mm/kasan/generic.c:348
       __call_rcu kernel/rcu/tree.c:3038 [inline]
       call_rcu+0x1a0/0xa20 kernel/rcu/tree.c:3113
       context_switch kernel/sched/core.c:4686 [inline]
       __schedule+0xc0f/0x11f0 kernel/sched/core.c:5940
       preempt_schedule_notrace+0x12c/0x170 kernel/sched/core.c:6179
       preempt_schedule_notrace_thunk+0x16/0x18 arch/x86/entry/thunk_64.S:36
       rcu_read_unlock_sched_notrace include/linux/rcupdate.h:809 [inline]
       trace_lock_release+0x9f/0x140 include/trace/events/lock.h:58
       lock_release+0x81/0x7b0 kernel/locking/lockdep.c:5636
       might_alloc include/linux/sched/mm.h:199 [inline]
       slab_pre_alloc_hook mm/slab.h:485 [inline]
       slab_alloc_node mm/slub.c:2891 [inline]
       slab_alloc mm/slub.c:2978 [inline]
       kmem_cache_alloc+0x41/0x340 mm/slub.c:2983
       kmem_cache_zalloc include/linux/slab.h:711 [inline]
       __alloc_file+0x26/0x2f0 fs/file_table.c:101
       alloc_empty_file+0xa9/0x1b0 fs/file_table.c:150
       path_openat+0x119/0x39b0 fs/namei.c:3480
       do_filp_open+0x221/0x460 fs/namei.c:3521
       do_open_execat+0x16d/0x710 fs/exec.c:913
       bprm_execve+0x505/0x1470 fs/exec.c:1809
       kernel_execve+0x8ce/0x9a0 fs/exec.c:1977
       call_usermodehelper_exec_async+0x262/0x3b0 kernel/umh.c:112
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add+0x4f9/0x5b30 kernel/locking/lockdep.c:3174
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x4476/0x6100 kernel/locking/lockdep.c:5015
       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
       __fs_reclaim_acquire+0x20/0x30 mm/page_alloc.c:4564
       fs_reclaim_acquire+0x59/0xf0 mm/page_alloc.c:4578
       prepare_alloc_pages+0x151/0x5a0 mm/page_alloc.c:5176
       __alloc_pages+0x14d/0x5f0 mm/page_alloc.c:5375
       stack_depot_save+0x361/0x490 lib/stackdepot.c:303
       save_stack+0xf9/0x1f0 mm/page_owner.c:120
       __set_page_owner+0x42/0x2f0 mm/page_owner.c:181
       prep_new_page mm/page_alloc.c:2445 [inline]
       __alloc_pages_bulk+0x9f2/0x1090 mm/page_alloc.c:5313
       alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
       vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
       __vmalloc_area_node mm/vmalloc.c:2845 [inline]
       __vmalloc_node_range+0x3ad/0x7f0 mm/vmalloc.c:2947
       __vmalloc_node mm/vmalloc.c:2996 [inline]
       vzalloc+0x75/0x80 mm/vmalloc.c:3066
       n_tty_open+0x19/0x150 drivers/tty/n_tty.c:1914
       tty_ldisc_open drivers/tty/tty_ldisc.c:464 [inline]
       tty_ldisc_setup+0xcf/0x3c0 drivers/tty/tty_ldisc.c:781
       tty_init_dev+0x271/0x4c0 drivers/tty/tty_io.c:1461
       tty_open_by_driver drivers/tty/tty_io.c:2102 [inline]
       tty_open+0x89a/0xdd0 drivers/tty/tty_io.c:2150
       chrdev_open+0x53b/0x5f0 fs/char_dev.c:414
       do_dentry_open+0x7cb/0x1010 fs/open.c:826
       do_open fs/namei.c:3361 [inline]
       path_openat+0x28e6/0x39b0 fs/namei.c:3494
       do_filp_open+0x221/0x460 fs/namei.c:3521
       do_sys_openat2+0x124/0x460 fs/open.c:1195
       do_sys_open fs/open.c:1211 [inline]
       __do_sys_openat fs/open.c:1227 [inline]
       __se_sys_openat fs/open.c:1222 [inline]
       __x64_sys_openat+0x243/0x290 fs/open.c:1222
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(lock#2);
                               lock(fs_reclaim);
                               lock(lock#2);
  lock(fs_reclaim);

 *** DEADLOCK ***

4 locks held by syz-executor.3/21469:
 #0: ffffffff8d5ca708 (tty_mutex){+.+.}-{3:3}, at: tty_open_by_driver drivers/tty/tty_io.c:2066 [inline]
 #0: ffffffff8d5ca708 (tty_mutex){+.+.}-{3:3}, at: tty_open+0x235/0xdd0 drivers/tty/tty_io.c:2150
 #1: ffff8880257541c0 (&tty->legacy_mutex){+.+.}-{3:3}, at: tty_init_dev+0x6a/0x4c0 drivers/tty/tty_io.c:1436
 #2: ffff888025754098 (&tty->ldisc_sem){++++}-{0:0}, at: __tty_ldisc_lock drivers/tty/tty_ldisc.c:315 [inline]
 #2: ffff888025754098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_lock+0x6a/0xb0 drivers/tty/tty_ldisc.c:339
 #3: ffff8880b9b31088 (lock#2){-.-.}-{2:2}, at: local_lock_acquire+0x7/0x130 include/linux/local_lock_internal.h:41

stack backtrace:
CPU: 1 PID: 21469 Comm: syz-executor.3 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:96
 print_circular_bug+0xb17/0xdc0 kernel/locking/lockdep.c:2009
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add+0x4f9/0x5b30 kernel/locking/lockdep.c:3174
 validate_chain kernel/locking/lockdep.c:3789 [inline]
 __lock_acquire+0x4476/0x6100 kernel/locking/lockdep.c:5015
 lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
 __fs_reclaim_acquire+0x20/0x30 mm/page_alloc.c:4564
 fs_reclaim_acquire+0x59/0xf0 mm/page_alloc.c:4578
 prepare_alloc_pages+0x151/0x5a0 mm/page_alloc.c:5176
 __alloc_pages+0x14d/0x5f0 mm/page_alloc.c:5375
 stack_depot_save+0x361/0x490 lib/stackdepot.c:303
 save_stack+0xf9/0x1f0 mm/page_owner.c:120
 __set_page_owner+0x42/0x2f0 mm/page_owner.c:181
 prep_new_page mm/page_alloc.c:2445 [inline]
 __alloc_pages_bulk+0x9f2/0x1090 mm/page_alloc.c:5313
 alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
 vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
 __vmalloc_area_node mm/vmalloc.c:2845 [inline]
 __vmalloc_node_range+0x3ad/0x7f0 mm/vmalloc.c:2947
 __vmalloc_node mm/vmalloc.c:2996 [inline]
 vzalloc+0x75/0x80 mm/vmalloc.c:3066
 n_tty_open+0x19/0x150 drivers/tty/n_tty.c:1914
 tty_ldisc_open drivers/tty/tty_ldisc.c:464 [inline]
 tty_ldisc_setup+0xcf/0x3c0 drivers/tty/tty_ldisc.c:781
 tty_init_dev+0x271/0x4c0 drivers/tty/tty_io.c:1461
 tty_open_by_driver drivers/tty/tty_io.c:2102 [inline]
 tty_open+0x89a/0xdd0 drivers/tty/tty_io.c:2150
 chrdev_open+0x53b/0x5f0 fs/char_dev.c:414
 do_dentry_open+0x7cb/0x1010 fs/open.c:826
 do_open fs/namei.c:3361 [inline]
 path_openat+0x28e6/0x39b0 fs/namei.c:3494
 do_filp_open+0x221/0x460 fs/namei.c:3521
 do_sys_openat2+0x124/0x460 fs/open.c:1195
 do_sys_open fs/open.c:1211 [inline]
 __do_sys_openat fs/open.c:1227 [inline]
 __se_sys_openat fs/open.c:1222 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1222
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4196c4
Code: 84 00 00 00 00 00 44 89 54 24 0c e8 96 f9 ff ff 44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 c8 f9 ff ff 8b 44
RSP: 002b:00007f7b60ac8cc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004196c4
RDX: 0000000000000002 RSI: 00007f7b60ac8d60 RDI: 00000000ffffff9c
RBP: 00007f7b60ac8d60 R08: 0000000000000000 R09: 000000000000000e
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000002
R13: 00007ffc7de709ef R14: 00007f7b60ac9300 R15: 0000000000022000
BUG: sleeping function called from invalid context at mm/page_alloc.c:5179
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 21469, name: syz-executor.3
INFO: lockdep is turned off.
irq event stamp: 200
hardirqs last  enabled at (199): [<ffffffff89cf038b>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
hardirqs last  enabled at (199): [<ffffffff89cf038b>] _raw_spin_unlock_irqrestore+0x8b/0x120 kernel/locking/spinlock.c:191
hardirqs last disabled at (200): [<ffffffff81be4351>] __alloc_pages_bulk+0x801/0x1090 mm/page_alloc.c:5291
softirqs last  enabled at (0): [<ffffffff814b0828>] copy_process+0x1498/0x5b30 kernel/fork.c:2065
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 1 PID: 21469 Comm: syz-executor.3 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:96
 ___might_sleep+0x4e5/0x6b0 kernel/sched/core.c:9153
 prepare_alloc_pages+0x1c0/0x5a0 mm/page_alloc.c:5179
 __alloc_pages+0x14d/0x5f0 mm/page_alloc.c:5375
 stack_depot_save+0x361/0x490 lib/stackdepot.c:303
 save_stack+0xf9/0x1f0 mm/page_owner.c:120
 __set_page_owner+0x42/0x2f0 mm/page_owner.c:181
 prep_new_page mm/page_alloc.c:2445 [inline]
 __alloc_pages_bulk+0x9f2/0x1090 mm/page_alloc.c:5313
 alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
 vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
 __vmalloc_area_node mm/vmalloc.c:2845 [inline]
 __vmalloc_node_range+0x3ad/0x7f0 mm/vmalloc.c:2947
 __vmalloc_node mm/vmalloc.c:2996 [inline]
 vzalloc+0x75/0x80 mm/vmalloc.c:3066
 n_tty_open+0x19/0x150 drivers/tty/n_tty.c:1914
 tty_ldisc_open drivers/tty/tty_ldisc.c:464 [inline]
 tty_ldisc_setup+0xcf/0x3c0 drivers/tty/tty_ldisc.c:781
 tty_init_dev+0x271/0x4c0 drivers/tty/tty_io.c:1461
 tty_open_by_driver drivers/tty/tty_io.c:2102 [inline]
 tty_open+0x89a/0xdd0 drivers/tty/tty_io.c:2150
 chrdev_open+0x53b/0x5f0 fs/char_dev.c:414
 do_dentry_open+0x7cb/0x1010 fs/open.c:826
 do_open fs/namei.c:3361 [inline]
 path_openat+0x28e6/0x39b0 fs/namei.c:3494
 do_filp_open+0x221/0x460 fs/namei.c:3521
 do_sys_openat2+0x124/0x460 fs/open.c:1195
 do_sys_open fs/open.c:1211 [inline]
 __do_sys_openat fs/open.c:1227 [inline]
 __se_sys_openat fs/open.c:1222 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1222
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4196c4
Code: 84 00 00 00 00 00 44 89 54 24 0c e8 96 f9 ff ff 44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 c8 f9 ff ff 8b 44
RSP: 002b:00007f7b60ac8cc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004196c4
RDX: 0000000000000002 RSI: 00007f7b60ac8d60 RDI: 00000000ffffff9c
RBP: 00007f7b60ac8d60 R08: 0000000000000000 R09: 000000000000000e
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000002
R13: 00007ffc7de709ef R14: 00007f7b60ac9300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
