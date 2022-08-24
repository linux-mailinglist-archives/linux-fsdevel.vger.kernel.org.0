Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A20B59F11E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 03:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiHXBpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 21:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiHXBpj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:45:39 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF55163F1F
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 18:45:31 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id w6-20020a056e02190600b002e74e05fdc2so11761573ilu.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 18:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=GL2Ggd4mwsa0q8HQeURtEnN4BRyP8Bg8OcXunPbsv08=;
        b=vqj4BVLc6vwRIEqWXhjjtJNP6+GGVBT2goYhJBfh2k8tcZgxXBVYA1dqipkzRqIBls
         AVAeb60vpNqrBdQxWVLDb4YC/8WC0Vp9mB1rYZTlxl/bvN7uAgqJWdcZ+urcFGPGQmw1
         8qgPMW8WNMIFOjXz2V6FGxwgwnF4S4eiWf0O/HQsTzEEm0Kg1ExZDtC3/UK0eDxYboMt
         wUUQEh8B9zjGFZ0CnPrImD/k61ErPSVJU9o2tbcaK2oJYAZftcvJpQIVUUReyVEYnZix
         b/GnAlj1o4gSDk9m1sUXQMSxpx+2A9GhWjVlW2ee5Dya9ID5LBMgUjUtC7OAnBATCh28
         NSJw==
X-Gm-Message-State: ACgBeo02UiqQaU7yVhCMRbwyAb+tJOrGR2FGRwN7Wj4ki+r2Ha1x0gOJ
        jphd14Mue0UKdd8dJOXgIocs7zvP3r2RvYUI0cT7iCjm8m54
X-Google-Smtp-Source: AA6agR6QjUfQB/0wA+RCeXywfVG3NAToTdPcrseIyg1FUZ0kseESRrDv3lrfYk2GI0+VIZ8yC6oEws5ZX3OWnoSzuvYyLZCuBPSZ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2a43:b0:689:f95d:330b with SMTP id
 k3-20020a0566022a4300b00689f95d330bmr5406689iov.128.1661305531185; Tue, 23
 Aug 2022 18:45:31 -0700 (PDT)
Date:   Tue, 23 Aug 2022 18:45:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cc4b605e6f2d6c7@google.com>
Subject: [syzbot] INFO: trying to register non-static key in __access_remote_vm
From:   syzbot <syzbot+d011b5a27f77c61c6345@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, brauner@kernel.org,
        chengzhihao1@huawei.com, deller@gmx.de, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xu.xin16@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8755ae45a9e8 Add linux-next specific files for 20220819
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1420bffd080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ead6107a3bbe3c62
dashboard link: https://syzkaller.appspot.com/bug?extid=d011b5a27f77c61c6345
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170f3023080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e56b35080000

Bisection is inconclusive: the first bad commit could be any of:

4fae831b3a71 tty: n_gsm: fix packet re-transmission without open control channel
32dd59f96924 tty: n_gsm: fix race condition in gsmld_write()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170af485080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d011b5a27f77c61c6345@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 3617 Comm: syz-executor272 Not tainted 6.0.0-rc1-next-20220819-syzkaller #0
BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1521
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 3617, name: syz-executor272
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
irq event stamp: 4716
hardirqs last  enabled at (4715): [<ffffffff898354ff>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (4715): [<ffffffff898354ff>] _raw_spin_unlock_irq+0x1f/0x40 kernel/locking/spinlock.c:202
hardirqs last disabled at (4716): [<ffffffff8983532e>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (4716): [<ffffffff8983532e>] _raw_spin_lock_irqsave+0x4e/0x50 kernel/locking/spinlock.c:162
softirqs last  enabled at (4594): [<ffffffff81491a33>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last  enabled at (4594): [<ffffffff81491a33>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
softirqs last disabled at (4561): [<ffffffff81491a33>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last disabled at (4561): [<ffffffff81491a33>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 3617 Comm: syz-executor272 Not tainted 6.0.0-rc1-next-20220819-syzkaller #0
syz-executor272[3617] cmdline: ./syz-executor2726460068
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:122 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:140
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9896
 down_read_killable+0x75/0x490 kernel/locking/rwsem.c:1521
 mmap_read_lock_killable include/linux/mmap_lock.h:126 [inline]
 __access_remote_vm+0xac/0x6f0 mm/memory.c:5461
 get_mm_cmdline.part.0+0x217/0x620 fs/proc/base.c:299
 get_mm_cmdline fs/proc/base.c:367 [inline]
 get_task_cmdline_kernel+0x1d9/0x220 fs/proc/base.c:367
 dump_stack_print_cmdline.part.0+0x82/0x150 lib/dump_stack.c:61
 dump_stack_print_cmdline lib/dump_stack.c:89 [inline]
 dump_stack_print_info+0x185/0x190 lib/dump_stack.c:97
 __dump_stack lib/dump_stack.c:121 [inline]
 dump_stack_lvl+0xc1/0x134 lib/dump_stack.c:140
 assign_lock_key kernel/locking/lockdep.c:979 [inline]
 register_lock_class+0xf1b/0x1120 kernel/locking/lockdep.c:1292
 __lock_acquire+0x109/0x56d0 kernel/locking/lockdep.c:4932
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 gsmld_write+0x5e/0x140 drivers/tty/n_gsm.c:3023
 do_tty_write drivers/tty/tty_io.c:1024 [inline]
 file_tty_write.constprop.0+0x499/0x8f0 drivers/tty/tty_io.c:1095
 call_write_iter include/linux/fs.h:2188 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:578
 ksys_write+0x127/0x250 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc136bf5289
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc832732f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc136bf5289
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fc136bb9070 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000000e R11: 0000000000000246 R12: 00007fc136bb9100
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
syz-executor272[3617] cmdline: ./syz-executor2726460068
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:122 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:140
 assign_lock_key kernel/locking/lockdep.c:979 [inline]
 register_lock_class+0xf1b/0x1120 kernel/locking/lockdep.c:1292
 __lock_acquire+0x109/0x56d0 kernel/locking/lockdep.c:4932
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 gsmld_write+0x5e/0x140 drivers/tty/n_gsm.c:3023
 do_tty_write drivers/tty/tty_io.c:1024 [inline]
 file_tty_write.constprop.0+0x499/0x8f0 drivers/tty/tty_io.c:1095
 call_write_iter include/linux/fs.h:2188 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:578
 ksys_write+0x127/0x250 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc136bf5289
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
