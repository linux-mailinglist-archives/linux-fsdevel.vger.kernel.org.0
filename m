Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAA95AD4B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 16:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiIEOZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 10:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiIEOZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:25:34 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A0F20F75
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Sep 2022 07:25:32 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id e4-20020a5d85c4000000b0068bb3c11e72so5022556ios.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Sep 2022 07:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=naAYmitw6f3X8rTM5bpC9XQBwS2OMkWDIGC6IroQMdw=;
        b=wDC45wS4mMqUSQMoiwW0Op02fDjMSJzNWjpnt9tq4mruonrWcUKlPvXJ4ie2XxcB4v
         pw24v0j49pInkvb4blnMwUEXlRgm4g45GT7rTIdS3fgR3srA5PVEOIb4bCxJXVmAwuoe
         4Rux+IHn5+Ot4w3n/YVQ6gTRHVP2mlBzjnN4AbDV8M6zttdIHTkXE6V0RtwkBHDWO6C3
         OraJ5QQSByQAOJo109a+6CarFp7aQxFrg17gJaAYpCZsS9a2kFXB5ePOlRgQieahml1F
         SEcyrSdnbsvmV7+9X3OyoE/sQVizLUoCHolSxqPODrFVgRg22WoRRMJoCt4RKJVwFTxy
         qNZw==
X-Gm-Message-State: ACgBeo1IeMXEyFRhpqdEfNHYogxpabDEAoXgvBTjaE6lcl+OZOGLsXM1
        +dAjcPbO45EwQ0cPOuI+SXRNi42d5M9+YGx/FtNvG/PXUGxC
X-Google-Smtp-Source: AA6agR4eXUSGxrXbOCxu2KPVNXRQ3g4UJrAMlJppHKMaIm7JaxAqLDJyozycZSFgLqPEg5aRCbaL9/32uj7/e9UK6Hl2vfRrGZ7K
MIME-Version: 1.0
X-Received: by 2002:a05:6638:38a9:b0:34e:932f:d37d with SMTP id
 b41-20020a05663838a900b0034e932fd37dmr9041823jav.285.1662387931396; Mon, 05
 Sep 2022 07:25:31 -0700 (PDT)
Date:   Mon, 05 Sep 2022 07:25:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002141d205e7eedaea@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in do_page_fault
From:   syzbot <syzbot+3bca50295c8d986d2d16@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    85413d1e802e Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=110d078b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57b9bfeca947ab90
dashboard link: https://syzkaller.appspot.com/bug?extid=3bca50295c8d986d2d16
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1796b3ad080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13081a8b080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3bca50295c8d986d2d16@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.0.0-rc3-syzkaller-16800-g85413d1e802e #0 Not tainted
-----------------------------
kernel/sched/core.c:9854 Illegal context switch in RCU-bh read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by syz-executor478/3038:
 #0: ffff0000c90e7188 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0x5c/0x5e0 fs/seq_file.c:182
 #1: ffff80000d82d328 (binder_procs_lock){+.+.}-{3:3}, at: stats_show+0x60/0x3e0 drivers/android/binder.c:6350
 #2: ffff0000c937aa48 (&alloc->mutex){+.+.}-{3:3}, at: binder_alloc_print_pages+0x38/0x218 drivers/android/binder_alloc.c:930

stack backtrace:
CPU: 0 PID: 3038 Comm: syz-executor478 Not tainted 6.0.0-rc3-syzkaller-16800-g85413d1e802e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call trace:
 dump_backtrace+0x1b0/0x1dc arch/arm64/kernel/stacktrace.c:182
 show_stack+0x2c/0x64 arch/arm64/kernel/stacktrace.c:189
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 lockdep_rcu_suspicious+0x138/0x154 kernel/locking/lockdep.c:6595
 __might_resched+0x6c/0x218 kernel/sched/core.c:9854
 __might_sleep+0x48/0x78 kernel/sched/core.c:9821
 do_page_fault+0x214/0x79c arch/arm64/mm/fault.c:593
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:685
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:818
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:366
 el1h_64_sync_handler+0x5c/0x98 arch/arm64/kernel/entry-common.c:417
 el1h_64_sync+0x64/0x68
 __lock_acquire+0x60/0x30a4 kernel/locking/lockdep.c:4923
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 binder_alloc_print_pages+0x48/0x218 drivers/android/binder_alloc.c:936
 print_binder_proc_stats drivers/android/binder.c:6289 [inline]
 stats_show+0x2d8/0x3e0 drivers/android/binder.c:6352
 seq_read_iter+0x220/0x5e0 fs/seq_file.c:230
 seq_read+0x98/0xd0 fs/seq_file.c:162
 full_proxy_read+0x94/0x140 fs/debugfs/file.c:231
 vfs_read+0x19c/0x448 fs/read_write.c:468
 ksys_read+0xb4/0x160 fs/read_write.c:607
 __do_sys_read fs/read_write.c:617 [inline]
 __se_sys_read fs/read_write.c:615 [inline]
 __arm64_sys_read+0x24/0x34 fs/read_write.c:615
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190

=============================
WARNING: suspicious RCU usage
6.0.0-rc3-syzkaller-16800-g85413d1e802e #0 Not tainted
-----------------------------
kernel/sched/core.c:9854 Illegal context switch in RCU-sched read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by syz-executor478/3038:
 #0: ffff0000c90e7188 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0x5c/0x5e0 fs/seq_file.c:182
 #1: ffff80000d82d328 (binder_procs_lock){+.+.}-{3:3}, at: stats_show+0x60/0x3e0 drivers/android/binder.c:6350
 #2: ffff0000c937aa48 (&alloc->mutex){+.+.}-{3:3}, at: binder_alloc_print_pages+0x38/0x218 drivers/android/binder_alloc.c:930

stack backtrace:
CPU: 0 PID: 3038 Comm: syz-executor478 Not tainted 6.0.0-rc3-syzkaller-16800-g85413d1e802e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call trace:
 dump_backtrace+0x1b0/0x1dc arch/arm64/kernel/stacktrace.c:182
 show_stack+0x2c/0x64 arch/arm64/kernel/stacktrace.c:189
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 lockdep_rcu_suspicious+0x138/0x154 kernel/locking/lockdep.c:6595
 __might_resched+0xb4/0x218 kernel/sched/core.c:9854
 __might_sleep+0x48/0x78 kernel/sched/core.c:9821
 do_page_fault+0x214/0x79c arch/arm64/mm/fault.c:593
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:685
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:818
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:366
 el1h_64_sync_handler+0x5c/0x98 arch/arm64/kernel/entry-common.c:417
 el1h_64_sync+0x64/0x68
 __lock_acquire+0x60/0x30a4 kernel/locking/lockdep.c:4923
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 binder_alloc_print_pages+0x48/0x218 drivers/android/binder_alloc.c:936
 print_binder_proc_stats drivers/android/binder.c:6289 [inline]
 stats_show+0x2d8/0x3e0 drivers/android/binder.c:6352
 seq_read_iter+0x220/0x5e0 fs/seq_file.c:230
 seq_read+0x98/0xd0 fs/seq_file.c:162
 full_proxy_read+0x94/0x140 fs/debugfs/file.c:231
 vfs_read+0x19c/0x448 fs/read_write.c:468
 ksys_read+0xb4/0x160 fs/read_write.c:607
 __do_sys_read fs/read_write.c:617 [inline]
 __se_sys_read fs/read_write.c:615 [inline]
 __arm64_sys_read+0x24/0x34 fs/read_write.c:615
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
BUG: sleeping function called from invalid context at arch/arm64/mm/fault.c:593
in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 3038, name: syz-executor478
preempt_count: 0, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by syz-executor478/3038:
 #0: ffff0000c90e7188 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0x5c/0x5e0 fs/seq_file.c:182
 #1: ffff80000d82d328 (binder_procs_lock){+.+.}-{3:3}, at: stats_show+0x60/0x3e0 drivers/android/binder.c:6350
 #2: ffff0000c937aa48 (&alloc->mutex){+.+.}-{3:3}, at: binder_alloc_print_pages+0x38/0x218 drivers/android/binder_alloc.c:930
irq event stamp: 519
hardirqs last  enabled at (519): [<ffff800008038c9c>] local_daif_restore arch/arm64/include/asm/daifflags.h:75 [inline]
hardirqs last  enabled at (519): [<ffff800008038c9c>] el0_svc_common+0x40/0x220 arch/arm64/kernel/syscall.c:107
hardirqs last disabled at (518): [<ffff80000c001358>] el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
softirqs last  enabled at (504): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (495): [<ffff800008104658>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (495): [<ffff800008104658>] invoke_softirq+0x70/0xbc kernel/softirq.c:452
CPU: 0 PID: 3038 Comm: syz-executor478 Not tainted 6.0.0-rc3-syzkaller-16800-g85413d1e802e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call trace:
 dump_backtrace+0x1b0/0x1dc arch/arm64/kernel/stacktrace.c:182
 show_stack+0x2c/0x64 arch/arm64/kernel/stacktrace.c:189
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 __might_resched+0x208/0x218 kernel/sched/core.c:9892
 __might_sleep+0x48/0x78 kernel/sched/core.c:9821
 do_page_fault+0x214/0x79c arch/arm64/mm/fault.c:593
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:685
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:818
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:366
 el1h_64_sync_handler+0x5c/0x98 arch/arm64/kernel/entry-common.c:417
 el1h_64_sync+0x64/0x68
 __lock_acquire+0x60/0x30a4 kernel/locking/lockdep.c:4923
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 binder_alloc_print_pages+0x48/0x218 drivers/android/binder_alloc.c:936
 print_binder_proc_stats drivers/android/binder.c:6289 [inline]
 stats_show+0x2d8/0x3e0 drivers/android/binder.c:6352
 seq_read_iter+0x220/0x5e0 fs/seq_file.c:230
 seq_read+0x98/0xd0 fs/seq_file.c:162
 full_proxy_read+0x94/0x140 fs/debugfs/file.c:231
 vfs_read+0x19c/0x448 fs/read_write.c:468
 ksys_read+0xb4/0x160 fs/read_write.c:607
 __do_sys_read fs/read_write.c:617 [inline]
 __se_sys_read fs/read_write.c:615 [inline]
 __arm64_sys_read+0x24/0x34 fs/read_write.c:615
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000118
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010c4fd000
[0000000000000118] pgd=080000010c4cd003, p4d=080000010c4cd003, pud=080000010c4cc003, pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3038 Comm: syz-executor478 Tainted: G        W          6.0.0-rc3-syzkaller-16800-g85413d1e802e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lock_acquire+0x60/0x30a4 kernel/locking/lockdep.c:4923
lr : lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
sp : ffff8000126e38c0
x29: ffff8000126e39a0 x28: 0000000000000000 x27: 0000000000000000
x26: 0000000000000118 x25: ffff80000aff1fcc x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000118 x21: 0000000000000000
x20: 0000000000000001 x19: 0000000000000000 x18: 00000000000000c0
x17: ffff80000dd7a698 x16: ffff80000dbb8658 x15: ffff0000c4a2b500
x14: 00000000000000b8 x13: 00000000ffffffff x12: ffff0000c4a2b500
x11: ff808000095ecde4 x10: 0000000000000000 x9 : 0000000000000001
x8 : 0000000000000001 x7 : ffff80000aff1fcc x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000001
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000118
Call trace:
 __lock_acquire+0x60/0x30a4 kernel/locking/lockdep.c:4923
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
 mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 binder_alloc_print_pages+0x48/0x218 drivers/android/binder_alloc.c:936
 print_binder_proc_stats drivers/android/binder.c:6289 [inline]
 stats_show+0x2d8/0x3e0 drivers/android/binder.c:6352
 seq_read_iter+0x220/0x5e0 fs/seq_file.c:230
 seq_read+0x98/0xd0 fs/seq_file.c:162
 full_proxy_read+0x94/0x140 fs/debugfs/file.c:231
 vfs_read+0x19c/0x448 fs/read_write.c:468
 ksys_read+0xb4/0x160 fs/read_write.c:607
 __do_sys_read fs/read_write.c:617 [inline]
 __se_sys_read fs/read_write.c:615 [inline]
 __arm64_sys_read+0x24/0x34 fs/read_write.c:615
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: 2a0303f4 2a0203f7 aa0003fa 34000148 (f9400348) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	2a0303f4 	mov	w20, w3
   4:	2a0203f7 	mov	w23, w2
   8:	aa0003fa 	mov	x26, x0
   c:	34000148 	cbz	w8, 0x34
* 10:	f9400348 	ldr	x8, [x26] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
