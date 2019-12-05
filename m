Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008A3113ADA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 05:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfLEEfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 23:35:10 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:44843 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbfLEEfJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 23:35:09 -0500
Received: by mail-io1-f72.google.com with SMTP id t17so1544616ioi.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2019 20:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yCrVhNqddFElrQxeNGjr6y5Otz+iXxG1Ybo4Faqxup4=;
        b=a2KKbC3TbFgHB1vyoSyg0SK7F1O7hC9HD5GQicKCZTmXGFM+LMizQZynIR8xoTleUz
         8Pzd3Ma5KCehJSBPxqKNLehxe50if/topuljBfDaCU+JCKaZmy42L6o4OHwkSGLmQQ+w
         zk06o44T6G1PU3elEY/wPEHmv7kXGKjv/6ognaX8eJdoem03hb8qA3SOjnjZepDnMlBB
         WfC89ajAxHIhgBKttHAMvEPOPI/arYRwRqHcPN31xJBmuee9Gx4WIQgBtukH6bLReRlW
         bdDmSpcBoFgM240DpAY2l3ItJqLAfAx1C6GGOz++TYi1fJya3SoaHOIpJneqVmgNt2he
         8NhA==
X-Gm-Message-State: APjAAAVqftZyotjem0ie+pvQvmr3JxLcpGsz2Hl8bS6gTNHWtCIIqcLS
        umhquf18+I8XU4gh3zV0D8tTAxNSbTcf5z44MWaM4I+gjB70
X-Google-Smtp-Source: APXvYqy2Fl0OePeXcAaB2Mbmyncmu5yVT0lCz4DaeeCrF7SXRxBMApN2OiBrERxrDUPQdzO3j2QOgcJ+/0VPqX3TxonjGjArRbIy
MIME-Version: 1.0
X-Received: by 2002:a92:3d49:: with SMTP id k70mr6714152ila.246.1575520508462;
 Wed, 04 Dec 2019 20:35:08 -0800 (PST)
Date:   Wed, 04 Dec 2019 20:35:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e5aa90598ed7415@google.com>
Subject: BUG: sleeping function called from invalid context in lock_sock_nested
From:   syzbot <syzbot+c2f1558d49e25cc36e5e@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    63de3747 Merge tag 'tag-chrome-platform-for-v5.5' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1727d59ce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d189d07c6717979
dashboard link: https://syzkaller.appspot.com/bug?extid=c2f1558d49e25cc36e5e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fcf97ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c2f1558d49e25cc36e5e@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at net/core/sock.c:2935
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9008, name: udevd
4 locks held by udevd/9008:
  #0: ffff888098598428 (sb_writers#5){.+.+}, at: sb_start_write  
include/linux/fs.h:1650 [inline]
  #0: ffff888098598428 (sb_writers#5){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:354
  #1: ffff8880a02bb248 (&type->i_mutex_dir_key#4/1){+.+.}, at:  
inode_lock_nested include/linux/fs.h:826 [inline]
  #1: ffff8880a02bb248 (&type->i_mutex_dir_key#4/1){+.+.}, at:  
filename_create+0x17c/0x4f0 fs/namei.c:3630
  #2: ffffffff89bb27a8 (tomoyo_ss){....}, at: tomoyo_path_perm+0x1cb/0x430  
security/tomoyo/file.c:847
  #3: ffffffff897a3fc0 (rcu_callback){....}, at: __rcu_reclaim  
kernel/rcu/rcu.h:210 [inline]
  #3: ffffffff897a3fc0 (rcu_callback){....}, at: rcu_do_batch  
kernel/rcu/tree.c:2183 [inline]
  #3: ffffffff897a3fc0 (rcu_callback){....}, at: rcu_core+0x5f8/0x1540  
kernel/rcu/tree.c:2408
Preemption disabled at:
[<ffffffff880000f3>] __do_softirq+0xf3/0x98c kernel/softirq.c:269
CPU: 1 PID: 9008 Comm: udevd Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  ___might_sleep.cold+0x1fb/0x23e kernel/sched/core.c:6800
  __might_sleep+0x95/0x190 kernel/sched/core.c:6753
  lock_sock_nested+0x39/0x120 net/core/sock.c:2935
  lock_sock include/net/sock.h:1526 [inline]
  af_alg_release_parent+0x1a6/0x290 crypto/af_alg.c:137
  hash_sock_destruct+0x164/0x1c0 crypto/algif_hash.c:423
  __sk_destruct+0x53/0x7f0 net/core/sock.c:1695
  __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
  rcu_do_batch kernel/rcu/tree.c:2183 [inline]
  rcu_core+0x570/0x1540 kernel/rcu/tree.c:2408
  rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2417
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x19b/0x1e0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1137
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
  </IRQ>
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:70 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x20/0x50 kernel/kcov.c:102
Code: ff cc cc cc cc cc cc cc cc cc 55 48 89 e5 65 48 8b 04 25 c0 1e 02 00  
65 8b 15 34 23 8d 7e 81 e2 00 01 1f 00 48 8b 75 08 75 2b <8b> 90 80 13 00  
00 83 fa 02 75 20 48 8b 88 88 13 00 00 8b 80 84 13
RSP: 0018:ffffc90001d67a58 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffff88809ac86680 RBX: 0000000000000011 RCX: ffffffff835559d0
RDX: 0000000000000000 RSI: ffffffff8355597e RDI: 0000000000000003
RBP: ffffc90001d67a58 R08: ffff88809ac86680 R09: ffffed1014154557
R10: ffffed1014154556 R11: ffff8880a0aa2ab7 R12: dffffc0000000000
R13: ffff8880a0aa2ab0 R14: ffffc90001d67ba0 R15: 0000000000000011
  tomoyo_check_acl+0x28e/0x3e0 security/tomoyo/domain.c:181
  tomoyo_path_permission security/tomoyo/file.c:586 [inline]
  tomoyo_path_permission+0x1fb/0x360 security/tomoyo/file.c:573
  tomoyo_path_perm+0x374/0x430 security/tomoyo/file.c:838
  tomoyo_path_symlink+0xaa/0xf0 security/tomoyo/tomoyo.c:206
  security_path_symlink+0x10a/0x170 security/security.c:1053
  do_symlinkat+0x137/0x290 fs/namei.c:4148
  __do_sys_symlink fs/namei.c:4169 [inline]
  __se_sys_symlink fs/namei.c:4167 [inline]
  __x64_sys_symlink+0x59/0x80 fs/namei.c:4167
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f68d8603517
Code: 09 01 00 00 0f 05 48 3d 00 f0 ff ff 77 02 f3 c3 48 8b 15 14 39 2b 00  
f7 d8 64 89 02 83 c8 ff c3 90 90 90 b8 58 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 01 c3 48 8b 0d f1 38 2b 00 31 d2 48 29 c2 64
RSP: 002b:00007ffc322deae8 EFLAGS: 00000206 ORIG_RAX: 0000000000000058
RAX: ffffffffffffffda RBX: 00000000025b6250 RCX: 00007f68d8603517
RDX: 0000000000000002 RSI: 00007ffc322deb10 RDI: 00000000025cf730
RBP: 00000000025b62d0 R08: 00007ffc322de6c0 R09: 00007f68d8657de0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000032
R13: 00000000025c7970 R14: 00000000025b6250 R15: 000000000000000b

================================
WARNING: inconsistent lock state
5.4.0-syzkaller #0 Tainted: G        W
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
udevd/9008 [HC0[0]:SC1[3]:HE1:SE0] takes:
ffff88809f5a9110 (sk_lock-AF_ALG){+.?.}, at: lock_sock  
include/net/sock.h:1526 [inline]
ffff88809f5a9110 (sk_lock-AF_ALG){+.?.}, at:  
af_alg_release_parent+0x1a6/0x290 crypto/af_alg.c:137
{SOFTIRQ-ON-W} state was registered at:
   __trace_hardirqs_on_caller kernel/locking/lockdep.c:3389 [inline]
   lockdep_hardirqs_on+0x421/0x5e0 kernel/locking/lockdep.c:3434
   trace_hardirqs_on+0x67/0x240 kernel/trace/trace_preemptirq.c:31
   __local_bh_enable_ip+0x15a/0x270 kernel/softirq.c:194
   local_bh_enable include/linux/bottom_half.h:32 [inline]
   lock_sock_nested+0xe2/0x120 net/core/sock.c:2945
   lock_sock include/net/sock.h:1526 [inline]
   alg_bind+0x288/0x570 crypto/af_alg.c:187
   __sys_bind+0x239/0x290 net/socket.c:1649
   __do_sys_bind net/socket.c:1660 [inline]
   __se_sys_bind net/socket.c:1658 [inline]
   __x64_sys_bind+0x73/0xb0 net/socket.c:1658
   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
   entry_SYSCALL_64_after_hwframe+0x49/0xbe
irq event stamp: 55316
hardirqs last  enabled at (55316): [<ffffffff81006743>]  
trace_hardirqs_on_thunk+0x1a/0x1c arch/x86/entry/thunk_64.S:41
hardirqs last disabled at (55315): [<ffffffff8100675f>]  
trace_hardirqs_off_thunk+0x1a/0x1c arch/x86/entry/thunk_64.S:42
softirqs last  enabled at (53682): [<ffffffff812aa92e>] memcpy  
include/linux/string.h:380 [inline]
softirqs last  enabled at (53682): [<ffffffff812aa92e>]  
fpu__copy+0x17e/0x8c0 arch/x86/kernel/fpu/core.c:195
softirqs last disabled at (55075): [<ffffffff81475c8b>] invoke_softirq  
kernel/softirq.c:373 [inline]
softirqs last disabled at (55075): [<ffffffff81475c8b>]  
irq_exit+0x19b/0x1e0 kernel/softirq.c:413

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(sk_lock-AF_ALG);
   <Interrupt>
     lock(sk_lock-AF_ALG);

  *** DEADLOCK ***

4 locks held by udevd/9008:
  #0: ffff888098598428 (sb_writers#5){.+.+}, at: sb_start_write  
include/linux/fs.h:1650 [inline]
  #0: ffff888098598428 (sb_writers#5){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:354
  #1: ffff8880a02bb248 (&type->i_mutex_dir_key#4/1){+.+.}, at:  
inode_lock_nested include/linux/fs.h:826 [inline]
  #1: ffff8880a02bb248 (&type->i_mutex_dir_key#4/1){+.+.}, at:  
filename_create+0x17c/0x4f0 fs/namei.c:3630
  #2: ffffffff89bb27a8 (tomoyo_ss){....}, at: tomoyo_path_perm+0x1cb/0x430  
security/tomoyo/file.c:847
  #3: ffffffff897a3fc0 (rcu_callback){....}, at: __rcu_reclaim  
kernel/rcu/rcu.h:210 [inline]
  #3: ffffffff897a3fc0 (rcu_callback){....}, at: rcu_do_batch  
kernel/rcu/tree.c:2183 [inline]
  #3: ffffffff897a3fc0 (rcu_callback){....}, at: rcu_core+0x5f8/0x1540  
kernel/rcu/tree.c:2408

stack backtrace:
CPU: 1 PID: 9008 Comm: udevd Tainted: G        W         5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_usage_bug.cold+0x327/0x378 kernel/locking/lockdep.c:3101
  valid_state kernel/locking/lockdep.c:3112 [inline]
  mark_lock_irq kernel/locking/lockdep.c:3309 [inline]
  mark_lock+0xbb4/0x1220 kernel/locking/lockdep.c:3666
  mark_usage kernel/locking/lockdep.c:3566 [inline]
  __lock_acquire+0x1e8e/0x4a00 kernel/locking/lockdep.c:3909
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
  lock_sock_nested+0xcb/0x120 net/core/sock.c:2944
  lock_sock include/net/sock.h:1526 [inline]
  af_alg_release_parent+0x1a6/0x290 crypto/af_alg.c:137
  hash_sock_destruct+0x164/0x1c0 crypto/algif_hash.c:423
  __sk_destruct+0x53/0x7f0 net/core/sock.c:1695
  __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
  rcu_do_batch kernel/rcu/tree.c:2183 [inline]
  rcu_core+0x570/0x1540 kernel/rcu/tree.c:2408
  rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2417
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x19b/0x1e0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1137
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
  </IRQ>
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:70 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x20/0x50 kernel/kcov.c:102
Code: ff cc cc cc cc cc cc cc cc cc 55 48 89 e5 65 48 8b 04 25 c0 1e 02 00  
65 8b 15 34 23 8d 7e 81 e2 00 01 1f 00 48 8b 75 08 75 2b <8b> 90 80 13 00  
00 83 fa 02 75 20 48 8b 88 88 13 00 00 8b 80 84 13
RSP: 0018:ffffc90001d67a58 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffff88809ac86680 RBX: 0000000000000011 RCX: ffffffff835559d0
RDX: 0000000000000000 RSI: ffffffff8355597e RDI: 0000000000000003
RBP: ffffc90001d67a58 R08: ffff88809ac86680 R09: ffffed1014154557
R10: ffffed1014154556 R11: ffff8880a0aa2ab7 R12: dffffc0000000000
R13: ffff8880a0aa2ab0 R14: ffffc90001d67ba0 R15: 0000000000000011
  tomoyo_check_acl+0x28e/0x3e0 security/tomoyo/domain.c:181
  tomoyo_path_permission security/tomoyo/file.c:586 [inline]
  tomoyo_path_permission+0x1fb/0x360 security/tomoyo/file.c:573
  tomoyo_path_perm+0x374/0x430 security/tomoyo/file.c:838
  tomoyo_path_symlink+0xaa/0xf0 security/tomoyo/tomoyo.c:206
  security_path_symlink+0x10a/0x170 security/security.c:1053
  do_symlinkat+0x137/0x290 fs/namei.c:4148
  __do_sys_symlink fs/namei.c:4169 [inline]
  __se_sys_symlink fs/namei.c:4167 [inline]
  __x64_sys_symlink+0x59/0x80 fs/namei.c:4167
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f68d8603517
Code: 09 01 00 00 0f 05 48 3d 00 f0 ff ff 77 02 f3 c3 48 8b 15 14 39 2b 00  
f7 d8 64 89 02 83 c8 ff c3 90 90 90 b8 58 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 01 c3 48 8b 0d f1 38 2b 00 31 d2 48 29 c2 64
RSP: 002b:00007ffc322deae8 EFLAGS: 00000206 ORIG_RAX: 0000000000000058
RAX: ffffffffffffffda RBX: 00000000025b6250 RCX: 00007f68d8603517
RDX: 0000000000000002 RSI: 00007ffc322deb10 RDI: 00000000025cf730
RBP: 00000000025b62d0 R08: 00007ffc322de6c0 R09: 00007f68d8657de0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000032
R13: 00000000025c7970 R14: 00000000025b6250 R15: 000000000000000b
BUG: sleeping function called from invalid context at net/core/sock.c:2935
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 16, name: ksoftirqd/1
INFO: lockdep is turned off.
Preemption disabled at:
[<ffffffff880000f3>] __do_softirq+0xf3/0x98c kernel/softirq.c:269
CPU: 1 PID: 16 Comm: ksoftirqd/1 Tainted: G        W          
5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  ___might_sleep.cold+0x1fb/0x23e kernel/sched/core.c:6800
  __might_sleep+0x95/0x190 kernel/sched/core.c:6753
  lock_sock_nested+0x39/0x120 net/core/sock.c:2935
  lock_sock include/net/sock.h:1526 [inline]
  af_alg_release_parent+0x1a6/0x290 crypto/af_alg.c:137
  hash_sock_destruct+0x164/0x1c0 crypto/algif_hash.c:423
  __sk_destruct+0x53/0x7f0 net/core/sock.c:1695
  __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
  rcu_do_batch kernel/rcu/tree.c:2183 [inline]
  rcu_core+0x570/0x1540 kernel/rcu/tree.c:2408
  rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2417
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  run_ksoftirqd kernel/softirq.c:603 [inline]
  run_ksoftirqd+0x8e/0x110 kernel/softirq.c:595
  smpboot_thread_fn+0x6a3/0xa40 kernel/smpboot.c:165
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
BUG: sleeping function called from invalid context at net/core/sock.c:2935
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 16, name: ksoftirqd/1
INFO: lockdep is turned off.
Preemption disabled at:
[<ffffffff880000f3>] __do_softirq+0xf3/0x98c kernel/softirq.c:269
CPU: 1 PID: 16 Comm: ksoftirqd/1 Tainted: G        W          
5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  ___might_sleep.cold+0x1fb/0x23e kernel/sched/core.c:6800
  __might_sleep+0x95/0x190 kernel/sched/core.c:6753
  lock_sock_nested+0x39/0x120 net/core/sock.c:2935
  lock_sock include/net/sock.h:1526 [inline]
  af_alg_release_parent+0x1a6/0x290 crypto/af_alg.c:137
  hash_sock_destruct+0x164/0x1c0 crypto/algif_hash.c:423
  __sk_destruct+0x53/0x7f0 net/core/sock.c:1695
  __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
  rcu_do_batch kernel/rcu/tree.c:2183 [inline]
  rcu_core+0x570/0x1540 kernel/rcu/tree.c:2408
  rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2417
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  run_ksoftirqd kernel/softirq.c:603 [inline]
  run_ksoftirqd+0x8e/0x110 kernel/softirq.c:595
  smpboot_thread_fn+0x6a3/0xa40 kernel/smpboot.c:165
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
