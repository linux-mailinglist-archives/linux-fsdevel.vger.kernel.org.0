Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4DC2411D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 22:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgHJUhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 16:37:22 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:37677 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgHJUhS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:37:18 -0400
Received: by mail-io1-f69.google.com with SMTP id f6so8006375ioa.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 13:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jS1QhIpDWAybN3/rlAubKTo0kERuNQcJeBNxwDNaJb8=;
        b=JzxL42bTuM5F6AJfptQOBbUdvkP5mfKWQqrcvdB1qW1pox1br9638xe8WWyD18GzPA
         kgr92/llr+tnGYroI37nRpeXRwaI+qIN8jFX7Ati9uF1jm22981BhaOfr5v+jzaAYHGb
         89hhSqwFPCFF82s6JHEo+AVmNg9tC0wO7YW4drrxSn+uQIIAyTkMTbW8iw4ag/yzyQwM
         D+i9O2lD9bfomzbh5fqLs6TwHNCS3LHYUqsIkmpa4lxJVbPFr/lYD5QJsohbS5MPk+Zp
         Q0XDmRc7UQY89551wEkzGoove6rHKaEs+4MukYtzSRPj/0TK2VbTHvq0K1FFDMrC8kWq
         czWQ==
X-Gm-Message-State: AOAM533eSiF8ppE3bO/X8yuxlmnXL6h5BwEzLwtg1fdEFhBFaD1PuLhd
        xnBMHC6o5EpdZm/ok1YCPfDkFWnBWTOnmgTXzIclcDVrYE7t
X-Google-Smtp-Source: ABdhPJyptFFiDVTYZlHIWIwqGQHG79vYSxw25ZonY4cvb285CFWWMwIlkFh+k/k6io3NjMnXY1r0mXFG9AbRdjdLviLJGz9y1bpL
MIME-Version: 1.0
X-Received: by 2002:a92:d590:: with SMTP id a16mr6513877iln.87.1597091836660;
 Mon, 10 Aug 2020 13:37:16 -0700 (PDT)
Date:   Mon, 10 Aug 2020 13:37:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000991ae405ac8beb12@google.com>
Subject: INFO: task can't die in io_uring_flush
From:   syzbot <syzbot+6d70b15b0d106c3450c5@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f80535b9 Add linux-next specific files for 20200810
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11df00d6900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2055bd0d83d5ee16
dashboard link: https://syzkaller.appspot.com/bug?extid=6d70b15b0d106c3450c5
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d70b15b0d106c3450c5@syzkaller.appspotmail.com

INFO: task syz-executor.5:31048 can't die for more than 143 seconds.
syz-executor.5  D28360 31048   7448 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 io_uring_cancel_files fs/io_uring.c:7897 [inline]
 io_uring_flush+0x740/0xa90 fs/io_uring.c:7914
 filp_close+0xb4/0x170 fs/open.c:1276
 __close_fd+0x2f/0x50 fs/file.c:671
 __do_sys_close fs/open.c:1295 [inline]
 __se_sys_close fs/open.c:1293 [inline]
 __x64_sys_close+0x69/0x100 fs/open.c:1293
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x416981
Code: Bad RIP value.
RSP: 002b:00007ffe164f4ff0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000416981
RDX: 0000000000000000 RSI: 00000000000010bc RDI: 0000000000000003
RBP: 0000000000000001 R08: 00000000102b50bc R09: 00000000102b50c0
R10: 00007ffe164f50e0 R11: 0000000000000293 R12: 0000000001191d50
R13: 0000000000126257 R14: ffffffffffffffff R15: 000000000118bf2c
INFO: task syz-executor.5:31048 blocked for more than 143 seconds.
      Not tainted 5.8.0-next-20200810-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.5  D28360 31048   7448 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 io_uring_cancel_files fs/io_uring.c:7897 [inline]
 io_uring_flush+0x740/0xa90 fs/io_uring.c:7914
 filp_close+0xb4/0x170 fs/open.c:1276
 __close_fd+0x2f/0x50 fs/file.c:671
 __do_sys_close fs/open.c:1295 [inline]
 __se_sys_close fs/open.c:1293 [inline]
 __x64_sys_close+0x69/0x100 fs/open.c:1293
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x416981
Code: Bad RIP value.
RSP: 002b:00007ffe164f4ff0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000416981
RDX: 0000000000000000 RSI: 00000000000010bc RDI: 0000000000000003
RBP: 0000000000000001 R08: 00000000102b50bc R09: 00000000102b50c0
R10: 00007ffe164f50e0 R11: 0000000000000293 R12: 0000000001191d50
R13: 0000000000126257 R14: ffffffffffffffff R15: 000000000118bf2c

Showing all locks held in the system:
1 lock held by khungtaskd/1170:
 #0: ffffffff89c66c40 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5825
1 lock held by in:imklog/6542:
 #0: ffff88809e544630 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1170 Comm: khungtaskd Not tainted 5.8.0-next-20200810-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x1b3/0x223 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:147 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:253 [inline]
 watchdog+0xd89/0xf30 kernel/hung_task.c:339
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 6543 Comm: rs:main Q:Reg Not tainted 5.8.0-next-20200810-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0033:0x55c2017dc011
Code: e7 e8 03 5d fc ff 4c 89 e7 48 89 c5 e8 d8 5c fc ff 48 63 54 24 2c 4c 63 e0 89 44 24 1c 48 89 d8 4c 01 e0 48 01 d0 80 7d 00 20 <41> 0f 95 c5 4d 8d 6c 05 13 41 8b 47 08 49 39 c5 72 13 4c 89 ee 4c
RSP: 002b:00007faa8110e810 EFLAGS: 00000202
RAX: 0000000000000032 RBX: 0000000000000009 RCX: 0000000000000000
RDX: 0000000000000007 RSI: 00007faa8110e840 RDI: 00007faa7401fb70
RBP: 00007faa7401fcb0 R08: 0000000000000000 R09: 0000000000000000
R10: 000055c201a19280 R11: 0000000000000000 R12: 0000000000000022
R13: 0000000000000000 R14: 00007faa7401fd68 R15: 00007faa78019c00
FS:  00007faa8110f700 GS:  0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
