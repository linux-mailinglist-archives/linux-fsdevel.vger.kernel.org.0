Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8404FB9E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2019 14:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfFWMhG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jun 2019 08:37:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:47453 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWMhG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:37:06 -0400
Received: by mail-io1-f69.google.com with SMTP id r27so18152104iob.14
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jun 2019 05:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sarunq0A1sMgfSItDbzpicgpCBMaLWJDDOt+JuY0HN8=;
        b=hGOMFe+0BUvQ2e8tFQX0j1uTUA8EoFNcKO7caIlPHsLLFsjsXtSxBHou3znIxFBdYT
         bU8zCaL/hPa8VyVXDIkCMifJOsKZLDxOa999OpwFRSF86Kb91qQPq/DeUThSDYqC1LDh
         hoQV9Laoo2vnw7ottehlPwxVMfbGROe4ZC6pE4MufetHQoIVxu6dZbWZ9I2Zs2U7Bzms
         zPaMAxRft4pic6HdGtM8gWbByUMQBc/BQcK4Rk+5L2b5IZKU8YMA/O4ut2BEoaVrdvk+
         n1hgQWnicHNDiL4MkDYEwKu/IdudETct9rNYqcZ1766Dv6l+OYHcYOeHXc71fsx3/UPj
         kQ5Q==
X-Gm-Message-State: APjAAAU8J9G9LChscuRxAu5tywIwFdx0hQzcDUqXWLITFGaTLYP48gQS
        7Chs6FB/eo5K/NHiMkg5m5Bojg48e4inxey+kfzeBLkpVpt3
X-Google-Smtp-Source: APXvYqy/aUuGIO8U7WZKTPkfZeBfkImq/jMX6z9VAtxaCzTWq3mu8MwTvLkUkCLpFLVw2imyjPYOeMNQZBX4XfK4UlM5BZr5F5vV
MIME-Version: 1.0
X-Received: by 2002:a5d:8a0c:: with SMTP id w12mr58791506iod.68.1561293425068;
 Sun, 23 Jun 2019 05:37:05 -0700 (PDT)
Date:   Sun, 23 Jun 2019 05:37:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdd3f3058bfcf369@google.com>
Subject: WARNING: bad unlock balance in rcu_lock_release
From:   syzbot <syzbot+f9545ab3e9f85cd43a3a@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=148ef681a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=f9545ab3e9f85cd43a3a
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f9545ab3e9f85cd43a3a@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
5.2.0-rc5+ #3 Not tainted
-------------------------------------
syz-executor.3/1203 is trying to release lock (rcu_callback) at:
[<ffffffff81636ec4>] rcu_lock_release+0x4/0x20 include/linux/rcupdate.h:212
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor.3/1203:
  #0: 00000000ae396ab9 (&type->s_umount_key#48/1){+.+.}, at:  
alloc_super+0x15f/0x740 fs/super.c:228

stack backtrace:
CPU: 0 PID: 1203 Comm: syz-executor.3 Not tainted 5.2.0-rc5+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  print_unlock_imbalance_bug+0x26d/0x2b0 kernel/locking/lockdep.c:3846
  __lock_release kernel/locking/lockdep.c:4062 [inline]
  lock_release+0x435/0x790 kernel/locking/lockdep.c:4322
  rcu_lock_release+0x1c/0x20 include/linux/rcupdate.h:214
  __rcu_reclaim kernel/rcu/rcu.h:223 [inline]
  rcu_do_batch kernel/rcu/tree.c:2092 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2310 [inline]
  rcu_core+0x8e2/0xf90 kernel/rcu/tree.c:2291
  __do_softirq+0x340/0x7b0 arch/x86/include/asm/paravirt.h:777
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x21a/0x230 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0xf8/0x260 arch/x86/kernel/apic/apic.c:1068
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:806
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:767  
[inline]
RIP: 0010:console_unlock+0xa65/0xf20 kernel/printk/printk.c:2471
Code: 20 00 74 0c 48 c7 c7 90 63 aa 88 e8 a5 44 50 00 48 83 3d fd cc 4b 07  
00 0f 84 7d 04 00 00 e8 52 1b 17 00 48 8b 7c 24 28 57 9d <0f> 1f 44 00 00  
f6 44 24 1f 01 75 52 e8 3a 1b 17 00 eb 63 0f 1f 84
RSP: 0018:ffff88805b6c7540 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: ffffffff815e969e RBX: 0000000000000200 RCX: 0000000000040000
RDX: ffffc9000c450000 RSI: 000000000002643c RDI: 0000000000000282
RBP: ffff88805b6c7670 R08: ffff88805cb14040 R09: fffffbfff115a505
R10: fffffbfff115a505 R11: 1ffffffff115a504 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff88c31298
  vprintk_emit+0x239/0x3a0 kernel/printk/printk.c:1986
  vprintk_default+0x28/0x30 kernel/printk/printk.c:2013
  vprintk_func+0x158/0x170 kernel/printk/printk_safe.c:386
  printk+0xc4/0x11d kernel/printk/printk.c:2046
  __ntfs_error+0x21b/0x230 fs/ntfs/debug.c:89
  parse_options+0x481/0x1f80 fs/ntfs/super.c:234
  ntfs_fill_super+0x19b/0x2940 fs/ntfs/super.c:2748
  mount_bdev+0x31c/0x440 fs/super.c:1346
  ntfs_mount+0x34/0x40 fs/ntfs/super.c:3051
  legacy_get_tree+0xf9/0x1a0 fs/fs_context.c:661
  vfs_get_tree+0x8f/0x360 fs/super.c:1476
  do_new_mount fs/namespace.c:2791 [inline]
  do_mount+0x1813/0x2730 fs/namespace.c:3111
  ksys_mount+0xcc/0x100 fs/namespace.c:3320
  __do_sys_mount fs/namespace.c:3334 [inline]
  __se_sys_mount fs/namespace.c:3331 [inline]
  __x64_sys_mount+0xbf/0xd0 fs/namespace.c:3331
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45bd1a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 9d 8d fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7a 8d fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f49071c9a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f49071c9b40 RCX: 000000000045bd1a
RDX: 00007f49071c9ae0 RSI: 0000000020000140 RDI: 00007f49071c9b00
RBP: 0000000000000000 R08: 00007f49071c9b40 R09: 00007f49071c9ae0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000003
R13: 00000000004c82e2 R14: 00000000004deb40 R15: 00000000ffffffff
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_0
net_ratelimit: 21 callbacks suppressed
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
