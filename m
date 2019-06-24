Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA43550352
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 09:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfFXH1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 03:27:25 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:52515 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFXH1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:27:09 -0400
Received: by mail-io1-f70.google.com with SMTP id p12so20867888iog.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2019 00:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=L3zKlrINEtE6m3v0kH7lOhB3kIE+T5TXT3Gi7uSg7F0=;
        b=OqzMlCXfI5t8SwvpyJMsfEtDY41p1f80x51HtoUzA0OS536Saaopj/5RPWl8pupP5+
         Cp/AiO/U4zpMijgN87cargf3Qkg83rfoRcvTmUkOP062msIPj5WYpeNwdTzSwcbMdyjq
         qg7vbSQ322UM94YP2UKXsIReJpnDJJXoF9qu/qL3SnJJMkFkw4O2OQ1AmsiCrWWXcyYV
         6RztTfnpVs8di+XJhDkSSO2QtDVUUeRX5Cb4hQi9AD0IgEDe/FLZXckLollKnKokB+wi
         0GCEGXfOpNAlR33MOjsbkJeZ62w8lHmjIF21VNT2h4UlN9UJHQgh6ubNM1dp4R0gdOeB
         0MTw==
X-Gm-Message-State: APjAAAXLVkYj7zbljyJ+Hyq/A3xb8jKVEP1f15Q+f5jcHTthmWFI7Mth
        4THgbUHDPyWPr4zltgC7roJHqVW4kb1/WRjYm4YQlNgeUsFs
X-Google-Smtp-Source: APXvYqwT7ZZGTV9XAVE3QghvMXv2mA7TgSCeRJIB2qYzFDbMsGzD8yDp7XEqfZK9PxMbPyBHa7uCMJy5T2qCljj08fFGP50gukur
MIME-Version: 1.0
X-Received: by 2002:a02:9a0f:: with SMTP id b15mr14994630jal.32.1561361228754;
 Mon, 24 Jun 2019 00:27:08 -0700 (PDT)
Date:   Mon, 24 Jun 2019 00:27:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067f693058c0cbdf4@google.com>
Subject: INFO: rcu detected stall in write_comp_data
From:   syzbot <syzbot+de50612027760b3a87aa@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17246026a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c77f8090a3b96b
dashboard link: https://syzkaller.appspot.com/bug?extid=de50612027760b3a87aa
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175e1ab2a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1156faf6a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+de50612027760b3a87aa@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 1, t=10502 jiffies, g=7925, q=38)
rcu: All QSes seen, last rcu_preempt kthread activity 10503  
(4295059525-4295049022), jiffies_till_next_fqs=1, root ->qsmask 0x0
syz-executor151 R  running task    26832  8885   8881 0x00004000
Call Trace:
  <IRQ>
  sched_show_task kernel/sched/core.c:5286 [inline]
  sched_show_task.cold+0x291/0x2fc kernel/sched/core.c:5261
  print_other_cpu_stall kernel/rcu/tree_stall.h:410 [inline]
  check_cpu_stall kernel/rcu/tree_stall.h:536 [inline]
  rcu_pending kernel/rcu/tree.c:2625 [inline]
  rcu_sched_clock_irq.cold+0xaaf/0xbfd kernel/rcu/tree.c:2161
  update_process_times+0x32/0x80 kernel/time/timer.c:1639
  tick_sched_handle+0xa2/0x190 kernel/time/tick-sched.c:167
  tick_sched_timer+0x47/0x130 kernel/time/tick-sched.c:1298
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x33b/0xdd0 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
  smp_apic_timer_interrupt+0x111/0x550 arch/x86/kernel/apic/apic.c:1066
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:806
  </IRQ>
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:68 [inline]
RIP: 0010:write_comp_data+0x9/0x70 kernel/kcov.c:123
Code: 12 00 00 8b 80 e4 12 00 00 48 8b 11 48 83 c2 01 48 39 d0 76 07 48 89  
34 d1 48 89 11 5d c3 0f 1f 00 65 4c 8b 04 25 c0 fd 01 00 <65> 8b 05 f8 3b  
91 7e a9 00 01 1f 00 75 51 41 8b 80 e0 12 00 00 83
RSP: 0018:ffff88808d9ef760 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: ffff88808d9ef848 RCX: ffffffff81b1c7ca
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffff88808d9ef768 R08: ffff88808421e080 R09: 0000000000000002
R10: ffffed1015d26c6f R11: ffff8880ae93637b R12: ffffffff877b6360
R13: 0000000003826ffc R14: 0000000000000001 R15: 0000000000000000
  do_iter_readv_writev+0x5ba/0x8f0 fs/read_write.c:690
  do_iter_write fs/read_write.c:970 [inline]
  do_iter_write+0x184/0x610 fs/read_write.c:951
  vfs_iter_write+0x77/0xb0 fs/read_write.c:983
  iter_file_splice_write+0x65c/0xbd0 fs/splice.c:746
  do_splice_from fs/splice.c:848 [inline]
  direct_splice_actor+0x123/0x190 fs/splice.c:1020
  splice_direct_to_actor+0x366/0x970 fs/splice.c:975
  do_splice_direct+0x1da/0x2a0 fs/splice.c:1063
  do_sendfile+0x597/0xd00 fs/read_write.c:1464
  __do_sys_sendfile64 fs/read_write.c:1519 [inline]
  __se_sys_sendfile64 fs/read_write.c:1511 [inline]
  __x64_sys_sendfile64+0x15a/0x220 fs/read_write.c:1511
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4417c9
Code: e8 7c e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffee86956c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007ffee8695870 RCX: 00000000004417c9
RDX: 0000000020000000 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00008080fffffffe R11: 0000000000000246 R12: 0000000000000000
R13: 00000000004024a0 R14: 0000000000000000 R15: 0000000000000000
rcu: rcu_preempt kthread starved for 10548 jiffies! g7925 f0x2  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    29056    10      2 0x80004000
Call Trace:
  context_switch kernel/sched/core.c:2818 [inline]
  __schedule+0x7cb/0x1560 kernel/sched/core.c:3445
  schedule+0xa8/0x260 kernel/sched/core.c:3509
  schedule_timeout+0x486/0xc50 kernel/time/timer.c:1807
  rcu_gp_fqs_loop kernel/rcu/tree.c:1589 [inline]
  rcu_gp_kthread+0x9b2/0x18b0 kernel/rcu/tree.c:1746
  kthread+0x354/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
