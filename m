Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C518F50461
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 10:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfFXIVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 04:21:08 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52713 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfFXIVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:21:07 -0400
Received: by mail-io1-f72.google.com with SMTP id p12so21013263iog.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2019 01:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3wbx66XjtrNDKjy5yo1ONJmuibxwTL2Y/NDCfUz1CRc=;
        b=j+pGs9q5cy+RGjnuHKSl+jGnHT3kbtwu6GhRtA/3ZleJD6jdl89JV4wZW6hpc1fC3a
         wJF+Oz5jLr47zoGdDUb2tXmrjy11anDIuVFjfZWTcD6Iplzx/RZXfm1qB2LihBmaj9kZ
         EBFI46741xl5KwWhnCLjUbtvQ3hgMfeiKY8x/LBaM7NRmCkCA6tfDvv/aX8jv8e21nty
         3MBpvv+KnKvDHQNy0/EFf157zRuLrUvfNF1CfLM5svyj+8czBI/i1DkwnIwifJ0bMGxp
         8k236MlNiKmP8MTvM1x33kGaywQh/wDfOdytA4NjJB5ZakcFB87RqiKZnqMY6qO1dBAr
         R2cQ==
X-Gm-Message-State: APjAAAWAi2D3iYipbmWG9WG6lLlB3T03EIvWHu6TZQ8Awlh23OxWiUYZ
        u5VOzFXVWxwt9oYUhn9RegW5lRtTJqZEB8uMswi/DVOVPrKD
X-Google-Smtp-Source: APXvYqzq26g+qUJSiKX+qhzG+N1V3GCN91+hK2RLY8R1V1u8qDa69oNKyOBTw/GDqrefBDH1udIPnevCMlG573olXu5T5S7Wb6+e
MIME-Version: 1.0
X-Received: by 2002:a6b:7b07:: with SMTP id l7mr14661964iop.225.1561364466648;
 Mon, 24 Jun 2019 01:21:06 -0700 (PDT)
Date:   Mon, 24 Jun 2019 01:21:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000665152058c0d7ed9@google.com>
Subject: INFO: task hung in io_uring_release
From:   syzbot <syzbot+94324416c485d422fe15@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bed3c0d8 Merge tag 'for-5.2-rc5-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1418bf0aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=94324416c485d422fe15
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+94324416c485d422fe15@syzkaller.appspotmail.com

INFO: task syz-executor.5:8634 blocked for more than 143 seconds.
       Not tainted 5.2.0-rc5+ #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.5  D25632  8634   8224 0x00004004
Call Trace:
  context_switch kernel/sched/core.c:2818 [inline]
  __schedule+0x658/0x9e0 kernel/sched/core.c:3445
  schedule+0x131/0x1d0 kernel/sched/core.c:3509
  schedule_timeout+0x9a/0x2b0 kernel/time/timer.c:1783
  do_wait_for_common+0x35e/0x5a0 kernel/sched/completion.c:83
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x47/0x60 kernel/sched/completion.c:136
  kthread_stop+0xb4/0x150 kernel/kthread.c:559
  io_sq_thread_stop fs/io_uring.c:2252 [inline]
  io_finish_async fs/io_uring.c:2259 [inline]
  io_ring_ctx_free fs/io_uring.c:2770 [inline]
  io_ring_ctx_wait_and_kill+0x268/0x880 fs/io_uring.c:2834
  io_uring_release+0x5d/0x70 fs/io_uring.c:2842
  __fput+0x2e4/0x740 fs/file_table.c:280
  ____fput+0x15/0x20 fs/file_table.c:313
  task_work_run+0x17e/0x1b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:185 [inline]
  exit_to_usermode_loop arch/x86/entry/common.c:168 [inline]
  prepare_exit_to_usermode+0x402/0x4f0 arch/x86/entry/common.c:199
  syscall_return_slowpath+0x110/0x440 arch/x86/entry/common.c:279
  do_syscall_64+0x126/0x140 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x412fb1
Code: 80 3b 7c 0f 84 c7 02 00 00 c7 85 d0 00 00 00 00 00 00 00 48 8b 05 cf  
a6 24 00 49 8b 14 24 41 b9 cb 2a 44 00 48 89 ee 48 89 df <48> 85 c0 4c 0f  
45 c8 45 31 c0 31 c9 e8 0e 5b 00 00 85 c0 41 89 c7
RSP: 002b:00007ffe7ee6a180 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000412fb1
RDX: 0000001b2d920000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00000000f3a3e1f8 R09: 00000000f3a3e1fc
R10: 00007ffe7ee6a260 R11: 0000000000000293 R12: 000000000075c9a0
R13: 000000000075c9a0 R14: 0000000000024c00 R15: 000000000075bf2c

Showing all locks held in the system:
1 lock held by khungtaskd/1043:
  #0: 00000000ec789630 (rcu_read_lock){....}, at: rcu_lock_acquire+0x4/0x30  
include/linux/rcupdate.h:207
1 lock held by rsyslogd/8054:
  #0: 00000000a1730567 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x243/0x2e0  
fs/file.c:801
2 locks held by getty/8167:
  #0: 000000000d85b796 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 000000006ecd2335 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
2 locks held by getty/8168:
  #0: 000000005c58bd1f (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 00000000158ead38 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
2 locks held by getty/8169:
  #0: 000000003d373884 (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 0000000026014169 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
2 locks held by getty/8170:
  #0: 00000000ba3eabbd (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 0000000003284ce2 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
2 locks held by getty/8171:
  #0: 000000009fcb2c0e (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 00000000ac5d0da7 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
2 locks held by getty/8172:
  #0: 000000003f4e772c (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 000000000c930b31 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156
2 locks held by getty/8173:
  #0: 000000002a3615cf (&tty->ldisc_sem){++++}, at:  
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:272
  #1: 00000000dd5c3618 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x2ee/0x1c80 drivers/tty/n_tty.c:2156

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1043 Comm: khungtaskd Not tainted 5.2.0-rc5+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  nmi_cpu_backtrace+0x89/0x160 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x125/0x230 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x10/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace+0x17/0x20 include/linux/nmi.h:146
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0xbb9/0xbd0 kernel/hung_task.c:289
  kthread+0x325/0x350 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2546 Comm: kworker/u4:4 Not tainted 5.2.0-rc5+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:31 [inline]
RIP: 0010:atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
RIP: 0010:rcu_dynticks_curr_cpu_in_eqs kernel/rcu/tree.c:292 [inline]
RIP: 0010:rcu_is_watching+0x62/0xa0 kernel/rcu/tree.c:872
Code: 4c 89 f7 e8 70 50 4c 00 48 c7 c3 b8 5f 03 00 49 03 1e 48 89 df be 04  
00 00 00 e8 89 25 4c 00 48 89 d8 48 c1 e8 03 42 8a 04 38 <84> c0 75 1e 8b  
03 65 ff 0d 5d 72 9f 7e 74 0c 83 e0 02 d1 e8 5b 41
RSP: 0018:ffff8880a10ffbe8 EFLAGS: 00000a02
RAX: 1ffff11015d66b00 RBX: ffff8880aeb35fb8 RCX: ffffffff81628ad7
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880aeb35fb8
RBP: ffff8880a10ffc00 R08: dffffc0000000000 R09: ffffed1015d66bf8
R10: ffffed1015d66bf8 R11: 1ffff11015d66bf7 R12: dffffc0000000000
R13: ffff8880a93c9b00 R14: ffffffff8881f258 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c434bbb720 CR3: 000000008e6fa000 CR4: 00000000001406e0
Call Trace:
  rcu_read_lock include/linux/rcupdate.h:594 [inline]
  batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:407 [inline]
  batadv_nc_worker+0x115/0x600 net/batman-adv/network-coding.c:718
  process_one_work+0x814/0x1130 kernel/workqueue.c:2269
  worker_thread+0xc01/0x1640 kernel/workqueue.c:2415
  kthread+0x325/0x350 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
