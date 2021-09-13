Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951BB4082D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 04:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbhIMCe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Sep 2021 22:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbhIMCey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Sep 2021 22:34:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA46C061574;
        Sun, 12 Sep 2021 19:33:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n4so4825463plh.9;
        Sun, 12 Sep 2021 19:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qYy0KCVjqA5pEmKlm19IjBGfrDpTLXBV/n8+39xqN+c=;
        b=BD3xXAbZF+qY80EUIGU1xUlLUL1AzWxdh1Lvpc4SDzr3nawJYdBAEij2j7YGWFu38+
         YnUr1i45+Lpa8NtETF5PjzqQcVWtme/+XNcMcq8119a6H2/oG9IOOg3MGBEpUhkJ6l1o
         mn92uakazr0HasRJtQJeELYVPVf5nvtcjlO3IpkwcfOUf6abwynmde2UUoKY5rpPd4Yi
         nBS0H8fVEJCSZ8D2qtdwijDByG2G9yzjPtLaITOklLB/2G+BHsWsVzzTpGvUgixbHwWw
         +Y7Z/RF5C1xg7brcWgXJnvfHTuWGpXrAcfjC/ZgIF8Do9c9ULNGkt3kkZK40Hx9EA9Dh
         5Pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qYy0KCVjqA5pEmKlm19IjBGfrDpTLXBV/n8+39xqN+c=;
        b=QV7Vannr/5v3ZzH/GL13w5CroXNwTlzJJ+2jIaclfuDUOWESB+4HRQeZquD3h23zyf
         krLOk94ndPrdyYYyfa2jN2eqSsydZSNINnkO0wmgFc4tYF9vtxjiULSZrAFuY1G6UryR
         ROeDrd1DRhwUNL8P9elCpYrFUVLQcnFp/t241K6MItlgloXJKR3HWIdMHu6InkdQSJ9g
         XsZnvd5FyIjrqC7VaNGYmCIH0aagt+A2WUkn221rMflb/zf4PHg9DLJsrccF9k16kbHO
         fjc1lWKa6Xck5bQCpGpP2k9yfDJgdXAAIug/dt0UYYVla5IDbtT59ScARPGz50GelPB1
         RWpA==
X-Gm-Message-State: AOAM533I1IThvdhGutGLTmg+oHKBZjb95g8aNoEqnwGv3gP7sMANkIP1
        OnXPmMhzKMDR1o6//Dct019UBCkxqSvXR1dDS3LM8Eh3NZax
X-Google-Smtp-Source: ABdhPJzAkAL95BaJCEgpSZ+UxxNyHAFn35NWdylQ1F3i1q7Fy3zwf1XckJNo50kN4sAo1YaIgy+sZ51eFyXaafZQZ9w=
X-Received: by 2002:a17:90a:b794:: with SMTP id m20mr9626881pjr.178.1631500418122;
 Sun, 12 Sep 2021 19:33:38 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 13 Sep 2021 10:33:27 +0800
Message-ID: <CACkBjsY4qoBdg6--P57UGyKA_hoKh9U7zNy_M99wv1Y6-+31KQ@mail.gmail.com>
Subject: INFO: task hung in iterate_supers
To:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 4b93c544e90e-thunderbolt: test: split up test cases
git tree: upstream
console output:
https://drive.google.com/file/d/1gi1OlktAs3lQS5uGyqcOmFdGg-hb5ek8/view?usp=sharing
kernel config: https://drive.google.com/file/d/1c0u2EeRDhRO-ZCxr9MP2VvAtJd6kfg-p/view?usp=sharing
Similar repot: https://groups.google.com/g/syzkaller-bugs/c/N3_ECgVYE0c/m/ubwipYJ6AgAJ

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task syz-executor:13124 blocked for more than 143 seconds.
      Not tainted 5.14.0+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:29232 pid:13124 ppid: 12323 flags:0x00404004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 rwsem_down_read_slowpath+0x4ee/0x9d0 kernel/locking/rwsem.c:993
 __down_read_common kernel/locking/rwsem.c:1214 [inline]
 __down_read kernel/locking/rwsem.c:1223 [inline]
 down_read+0xe4/0x440 kernel/locking/rwsem.c:1464
 iterate_supers+0xdb/0x290 fs/super.c:693
 ksys_sync+0x86/0x150 fs/sync.c:114
 __do_sys_sync+0xa/0x10 fs/sync.c:125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x2000000a
RSP: 002b:00007f38a62cbbb8 EFLAGS: 00000a83 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 000000002000000a
RDX: 0000000000004c01 RSI: 0000000000000003 RDI: 000000000000001c
RBP: 00000000000000ab R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000a83 R12: 000000000000000b
R13: 000000000000000c R14: 000000000000000d R15: 00007f38a62cbdc0
INFO: task syz-executor:13127 blocked for more than 143 seconds.
      Not tainted 5.14.0+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:27752 pid:13127 ppid: 12323 flags:0x00404004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 rwsem_down_read_slowpath+0x4ee/0x9d0 kernel/locking/rwsem.c:993
 __down_read_common kernel/locking/rwsem.c:1214 [inline]
 __down_read kernel/locking/rwsem.c:1223 [inline]
 down_read+0xe4/0x440 kernel/locking/rwsem.c:1464
 iterate_supers+0xdb/0x290 fs/super.c:693
 ksys_sync+0x86/0x150 fs/sync.c:114
 __do_sys_sync+0xa/0x10 fs/sync.c:125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x2000000a
RSP: 002b:00007f38a62aabb8 EFLAGS: 00000a83 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 000000002000000a
RDX: 0000000000004c01 RSI: 0000000000000003 RDI: 000000000000001c
RBP: 00000000000000ab R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000a83 R12: 000000000000000b
R13: 000000000000000c R14: 000000000000000d R15: 00007f38a62aadc0

Showing all locks held in the system:
1 lock held by khungtaskd/1360:
 #0: ffffffff8b97dde0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6446
1 lock held by in:imklog/8202:
 #0: ffff88801f4d7a70 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0xe9/0x100 fs/file.c:990
1 lock held by syz-executor/11128:
 #0: ffff88810f7600e0 (&type->s_umount_key#69/1){+.+.}-{3:3}, at:
alloc_super+0x1dd/0xab0 fs/super.c:229
1 lock held by syz-executor/11714:
 #0: ffff8880163760e0 (&type->s_umount_key#69/1){+.+.}-{3:3}, at:
alloc_super+0x1dd/0xab0 fs/super.c:229
1 lock held by syz-executor/12302:
 #0: ffff888026ad60e0 (&type->s_umount_key#69/1){+.+.}-{3:3}, at:
alloc_super+0x1dd/0xab0 fs/super.c:229
1 lock held by syz-executor/13124:
 #0: ffff88810f7600e0 (&type->s_umount_key#73){.+.+}-{3:3}, at:
iterate_supers+0xdb/0x290 fs/super.c:693
1 lock held by syz-executor/13127:
 #0: ffff88810f7600e0 (&type->s_umount_key#73){.+.+}-{3:3}, at:
iterate_supers+0xdb/0x290 fs/super.c:693
1 lock held by syz-executor/15012:
 #0: ffff88810f7600e0 (&type->s_umount_key#73){.+.+}-{3:3}, at:
iterate_supers+0xdb/0x290 fs/super.c:693
1 lock held by syz-executor/15016:
 #0: ffff88810f7600e0 (&type->s_umount_key#73){.+.+}-{3:3}, at:
iterate_supers+0xdb/0x290 fs/super.c:693
1 lock held by syz-executor/15627:
 #0: ffff88810f7600e0 (&type->s_umount_key#73){.+.+}-{3:3}, at:
iterate_supers+0xdb/0x290 fs/super.c:693
1 lock held by syz-executor/15630:
 #0: ffff88810f7600e0 (&type->s_umount_key#73){.+.+}-{3:3}, at:
iterate_supers+0xdb/0x290 fs/super.c:693
1 lock held by syz-executor/16215:
 #0: ffff88810f7600e0 (&type->s_umount_key#73){.+.+}-{3:3}, at:
iterate_supers+0xdb/0x290 fs/super.c:693
1 lock held by syz-executor/16219:
 #0: ffff88810f7600e0 (&type->s_umount_key#73){.+.+}-{3:3}, at:
iterate_supers+0xdb/0x290 fs/super.c:693

=============================================

NMI backtrace for cpu 3
CPU: 3 PID: 1360 Comm: khungtaskd Not tainted 5.14.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1e1/0x220 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xcc8/0x1010 kernel/hung_task.c:295
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 3 to CPUs 0-2:
NMI backtrace for cpu 1
CPU: 1 PID: 4939 Comm: systemd-journal Not tainted 5.14.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__sanitizer_cov_trace_pc+0x1a/0x40 kernel/kcov.c:197
Code: 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 65 48 8b 0c 25
40 f0 01 00 bf 02 00 00 00 48 89 ce 4c 8b 04 24 e8 76 ff ff ff <84> c0
74 20 48 8b 91 20 15 00 00 8b 89 1c 15 00 00 48 8b 02 48 83
RSP: 0018:ffffc9000112fd08 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000059 RCX: ffff888012bb5580
RDX: 0000000000000000 RSI: ffff888012bb5580 RDI: 0000000000000002
RBP: ffff8880125b8151 R08: ffffffff81c7243d R09: 0000000000000000
R10: 0000000000000007 R11: ffffed10024b7000 R12: ffff8880125b80f8
R13: 0000000000000001 R14: ffffea0000496e00 R15: ffffea0000496e00
FS:  00007f5f361678c0(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5f3364d000 CR3: 00000000233d6000 CR4: 0000000000350ee0
Call Trace:
 PageSlab include/linux/page-flags.h:345 [inline]
 check_heap_object mm/usercopy.c:238 [inline]
 __check_object_size mm/usercopy.c:286 [inline]
 __check_object_size+0x26d/0x450 mm/usercopy.c:256
 check_object_size include/linux/thread_info.h:185 [inline]
 check_copy_size include/linux/thread_info.h:218 [inline]
 copy_to_user include/linux/uaccess.h:199 [inline]
 devkmsg_read+0x530/0x750 kernel/printk/printk.c:761
 vfs_read+0x1b5/0x600 fs/read_write.c:483
 ksys_read+0x12d/0x250 fs/read_write.c:623
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5f356f7210
Code: 73 01 c3 48 8b 0d 98 7d 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66
0f 1f 44 00 00 83 3d b9 c1 20 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 31 c3 48 83 ec 08 e8 4e fc ff ff 48 89 04 24
RSP: 002b:00007ffc1620fa58 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007ffc162124d0 RCX: 00007f5f356f7210
RDX: 0000000000002000 RSI: 00007ffc162102d0 RDI: 0000000000000009
RBP: 0000000000000000 R08: 0000000000000008 R09: 00007ffc162e60f0
R10: 0000000000012664 R11: 0000000000000246 R12: 00007ffc162102d0
R13: 00007ffc16212428 R14: 0000555f702f1958 R15: 0005cb9b366b0203
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
----------------
Code disassembly (best guess):
   0: 00 c3                add    %al,%bl
   2: 66 66 2e 0f 1f 84 00 data16 nopw %cs:0x0(%rax,%rax,1)
   9: 00 00 00 00
   d: 0f 1f 00              nopl   (%rax)
  10: 65 48 8b 0c 25 40 f0 mov    %gs:0x1f040,%rcx
  17: 01 00
  19: bf 02 00 00 00        mov    $0x2,%edi
  1e: 48 89 ce              mov    %rcx,%rsi
  21: 4c 8b 04 24          mov    (%rsp),%r8
  25: e8 76 ff ff ff        callq  0xffffffa0
* 2a: 84 c0                test   %al,%al <-- trapping instruction
  2c: 74 20                je     0x4e
  2e: 48 8b 91 20 15 00 00 mov    0x1520(%rcx),%rdx
  35: 8b 89 1c 15 00 00    mov    0x151c(%rcx),%ecx
  3b: 48 8b 02              mov    (%rdx),%rax
  3e: 48                    rex.W
  3f: 83                    .byte 0x83
