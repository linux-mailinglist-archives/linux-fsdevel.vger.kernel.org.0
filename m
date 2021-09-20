Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C7C411540
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhITNGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 09:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbhITNGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:06:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57041C061760;
        Mon, 20 Sep 2021 06:05:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t20so11910998pju.5;
        Mon, 20 Sep 2021 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ndJ0+KRB2/XQ2B0Vd2RMBl5sKQxlV+sMBiWmbyoQFV8=;
        b=lYMKuPjsllcrlpsoCpTQbWQE1+OzSSHeKOHPbeXtWf+hMrTbWTAgrYY6OBNBg654HO
         moBY1Yh5GXvstfTMz7bi4rIlOHwuHSY8vRNPU4rdjn9n7786r+NkclBMPqdWE+y+xJcR
         xFne7OOXEcuhfJsVqR/YnGPuPBY0g8dS5eN7w0tYOE0dW6Yy+yiiDnY1XPL6PZXNahHd
         B8ZKotuoGV2t8zZAfj8rAzJ5mNLRwdG1seY9N9D2IbDXJiKf4mdBNKC18YNL8CcQZE8N
         vuVoSfxo3Uie8sWTPDRRp9F6lXVm0nI4X3A7VPvhq3z2L/mpL5iS7y2oPCt9eKS5ILrB
         0hpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ndJ0+KRB2/XQ2B0Vd2RMBl5sKQxlV+sMBiWmbyoQFV8=;
        b=pETrYc4PL+M52fwFAW9JD60gqcKVxQidYptAL77KqwTI24o/Um9rM9iLj8cDBRu/0v
         o1WrYCN8LyaDGWsR3tiIp4qDWB7BrnIz1dsK2vdAYrU0FOPOdWn9jyALrHTy9kmpB2JO
         E3ERqmCv1OOLzGKj8KhMYOo9ENXukUOlUw1jylHWPCRsjmMJv6QY/mRtA3g027qhf0Up
         uNUWXzg0o5zmbcD93AwnhcPQoVDfGTtwftpWKF+m3GonJ/MRAeQA5c8iqII3nbdoAb9m
         pzQPX2NpdLUwPOhcbTwlzJlmtUniWTh1ugPjQDeUOBHQS/mLZEFMTpVwYCsxDaNzs0oW
         8I4w==
X-Gm-Message-State: AOAM533JRVsz8NLvhpwXSfVmx8kEiR7ylZOORUwoPlFLpJRk+NHEv3vh
        RVl8kJPOARAKjSZsZ3Xg7AgkrUdC7D9mroikVSpSmPc3vg==
X-Google-Smtp-Source: ABdhPJygTMqMX0CEA1a1zHQD1b5Lcd5Vbm8xpWyocwAjkLsih3TkJVy6ssP/Yex+Nrrc5ATvI80NDz+Qy7HnCxNO670=
X-Received: by 2002:a17:90a:b794:: with SMTP id m20mr29688542pjr.178.1632143112406;
 Mon, 20 Sep 2021 06:05:12 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 20 Sep 2021 21:05:19 +0800
Message-ID: <CACkBjsaa83BmJ-m9bXzmxHcJjjbrhTfiaN6Oo_v2nTkk8Q-mDA@mail.gmail.com>
Subject: INFO: task hung in deactivate_super
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 4357f03d6611 Merge tag 'pm-5.15-rc2
git tree: upstream
console output:
https://drive.google.com/file/d/1gXBYGICW_aFSK8X-6NYECS6iIfHI66Nw/view?usp=sharing
kernel config: https://drive.google.com/file/d/1HKZtF_s3l6PL3OoQbNq_ei9CdBus-Tz0/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task syz-executor:31998 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1+ #19
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:11144 pid:31998 ppid:     1 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x323/0xae0 kernel/sched/core.c:6287
 schedule+0x36/0xe0 kernel/sched/core.c:6366
 rwsem_down_write_slowpath kernel/locking/rwsem.c:1107 [inline]
 __down_write_common.part.13+0x356/0x7a0 kernel/locking/rwsem.c:1262
 deactivate_super+0x4b/0x80 fs/super.c:365
 cleanup_mnt+0x138/0x1b0 fs/namespace.c:1137
 task_work_run+0x86/0xd0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x271/0x280 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
 do_syscall_64+0x40/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46c777
RSP: 002b:00007ffd324c9358 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000046c777
RDX: 0000000000404e22 RSI: 0000000000000002 RDI: 00007ffd324c9420
RBP: 00007ffd324c9420 R08: 00000000025e5033 R09: 000000000000000b
R10: 00000000fffffffb R11: 0000000000000246 R12: 00000000004e38c6
R13: 00007ffd324ca4d0 R14: 00007ffd324ca4cc R15: 0000000000000004
INFO: task syz-executor:1024 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1+ #19
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:12440 pid: 1024 ppid: 31998 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x323/0xae0 kernel/sched/core.c:6287
 schedule+0x36/0xe0 kernel/sched/core.c:6366
 wait_current_trans+0x122/0x1a0 fs/btrfs/transaction.c:534
 start_transaction+0x3b5/0x970 fs/btrfs/transaction.c:681
 btrfs_attach_transaction_barrier+0x21/0x60 fs/btrfs/transaction.c:837
 btrfs_sync_fs+0x7e/0x430 fs/btrfs/super.c:1401
 sync_fs_one_sb+0x40/0x50 fs/sync.c:81
 iterate_supers+0xa7/0x130 fs/super.c:695
 ksys_sync+0x60/0xc0 fs/sync.c:116
 __do_sys_sync+0xa/0x10 fs/sync.c:125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x200003ca
RSP: 002b:00007eff022caba8 EFLAGS: 00000a83 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00000000200003ca
RDX: 0000000000004c01 RSI: 0000000000000003 RDI: 0000000000400000
RBP: 00000000000000eb R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000a83 R12: 000000000000000b
R13: 000000000000000c R14: 000000000000000d R15: 00007ffd324ca3a0
INFO: task syz-executor:1054 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1+ #19
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:12440 pid: 1054 ppid: 31998 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x323/0xae0 kernel/sched/core.c:6287
 schedule+0x36/0xe0 kernel/sched/core.c:6366
 wait_current_trans+0x122/0x1a0 fs/btrfs/transaction.c:534
 start_transaction+0x3b5/0x970 fs/btrfs/transaction.c:681
 btrfs_attach_transaction_barrier+0x21/0x60 fs/btrfs/transaction.c:837
 btrfs_sync_fs+0x7e/0x430 fs/btrfs/super.c:1401
 sync_fs_one_sb+0x40/0x50 fs/sync.c:81
 iterate_supers+0xa7/0x130 fs/super.c:695
 ksys_sync+0x60/0xc0 fs/sync.c:116
 __do_sys_sync+0xa/0x10 fs/sync.c:125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x200003ca
RSP: 002b:00007eff022caba8 EFLAGS: 00000a83 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00000000200003ca
RDX: 0000000000004c01 RSI: 0000000000000003 RDI: 0000000000400000
RBP: 00000000000000eb R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000a83 R12: 000000000000000b
R13: 000000000000000c R14: 000000000000000d R15: 00007ffd324ca3a0
INFO: task syz-executor:1654 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1+ #19
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:12488 pid: 1654 ppid: 31998 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x323/0xae0 kernel/sched/core.c:6287
 schedule+0x36/0xe0 kernel/sched/core.c:6366
 rwsem_down_write_slowpath kernel/locking/rwsem.c:1107 [inline]
 __down_write_common.part.13+0x356/0x7a0 kernel/locking/rwsem.c:1262
 __btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4740 [inline]
 btrfs_alloc_tree_block+0x19c/0x670 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x16f/0x820 fs/btrfs/ctree.c:415
 btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
 btrfs_update_root+0x6b/0x470 fs/btrfs/root-tree.c:134
 commit_fs_roots+0x151/0x220 fs/btrfs/transaction.c:1373
 btrfs_commit_transaction+0x443/0x1450 fs/btrfs/transaction.c:2265
 btrfs_sync_fs+0x9a/0x430 fs/btrfs/super.c:1426
 sync_fs_one_sb+0x40/0x50 fs/sync.c:81
 iterate_supers+0xa7/0x130 fs/super.c:695
 ksys_sync+0x60/0xc0 fs/sync.c:116
 __do_sys_sync+0xa/0x10 fs/sync.c:125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x2000030a
RSP: 002b:00007eff022caba8 EFLAGS: 00000a83 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 000000002000030a
RDX: 0000000000004c01 RSI: 0000000000000003 RDI: 0000000000400000
RBP: 00000000000000ab R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000a83 R12: 000000000000000b
R13: 000000000000000c R14: 000000000000000d R15: 00007ffd324ca3a0
INFO: lockdep is turned off.
NMI backtrace for cpu 3
CPU: 3 PID: 39 Comm: khungtaskd Not tainted 5.15.0-rc1+ #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 nmi_cpu_backtrace+0x1e9/0x210 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x120/0x180 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0x4e1/0x980 kernel/hung_task.c:295
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 3 to CPUs 0-2:
NMI backtrace for cpu 2 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 2 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 2 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
NMI backtrace for cpu 0 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 0 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
NMI backtrace for cpu 1
CPU: 1 PID: 3015 Comm: systemd-journal Not tainted 5.15.0-rc1+ #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:lookup_object lib/debugobjects.c:196 [inline]
RIP: 0010:debug_object_activate+0xdb/0x230 lib/debugobjects.c:663
Code: 88 4c 89 f7 e8 86 16 fb 01 48 8b 9b 00 81 81 88 48 85 db 74 65
4c 3b 63 18 74 20 48 8b 1b ba 01 00 00 00 48 85 db 75 0a eb 52 <48> 8b
1b 48 85 db 74 4a 83 c2 01 4c 3b 63 18 75 ef 8b 53 10 83 fa
RSP: 0018:ffffc9000087fe20 EFLAGS: 00000087
RAX: 0000000000000206 RBX: ffff888008c50d98 RCX: 0000000000000000
RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffffffff888cc108
RBP: ffffc9000087fe80 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc9000087fea0 R11: 0000000000000000 R12: ffff88810eb33000
R13: ffffffff8482f6a0 R14: ffffffff888cc108 R15: ffffffff8736e2d0
FS:  00007f839bff48c0(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8396a2c008 CR3: 0000000104716000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 debug_rcu_head_queue kernel/rcu/rcu.h:176 [inline]
 __call_rcu kernel/rcu/tree.c:2971 [inline]
 call_rcu+0x2c/0x320 kernel/rcu/tree.c:3067
 task_work_run+0x86/0xd0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x271/0x280 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
 do_syscall_64+0x40/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f839b58485d
Code: bb 20 00 00 75 10 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31
c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b
3c 24 48 89 c2 e8 67 f6 ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffd9a511330 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: fffffffffffffffe RBX: 00007ffd9a511640 RCX: 00007f839b58485d
RDX: 00000000000001a0 RSI: 0000000000080042 RDI: 0000564967919cd0
RBP: 000000000000000d R08: 000000000000ffc0 R09: 00000000ffffffff
R10: 0000000000000069 R11: 0000000000000293 R12: 00000000ffffffff
R13: 000056496790e040 R14: 00007ffd9a511600 R15: 0000564967911e80
----------------
Code disassembly (best guess):
   0:   88 4c 89 f7             mov    %cl,-0x9(%rcx,%rcx,4)
   4:   e8 86 16 fb 01          callq  0x1fb168f
   9:   48 8b 9b 00 81 81 88    mov    -0x777e7f00(%rbx),%rbx
  10:   48 85 db                test   %rbx,%rbx
  13:   74 65                   je     0x7a
  15:   4c 3b 63 18             cmp    0x18(%rbx),%r12
  19:   74 20                   je     0x3b
  1b:   48 8b 1b                mov    (%rbx),%rbx
  1e:   ba 01 00 00 00          mov    $0x1,%edx
  23:   48 85 db                test   %rbx,%rbx
  26:   75 0a                   jne    0x32
  28:   eb 52                   jmp    0x7c
* 2a:   48 8b 1b                mov    (%rbx),%rbx <-- trapping instruction
  2d:   48 85 db                test   %rbx,%rbx
  30:   74 4a                   je     0x7c
  32:   83 c2 01                add    $0x1,%edx
  35:   4c 3b 63 18             cmp    0x18(%rbx),%r12
  39:   75 ef                   jne    0x2a
  3b:   8b 53 10                mov    0x10(%rbx),%edx
  3e:   83                      .byte 0x83
  3f:   fa                      cli
