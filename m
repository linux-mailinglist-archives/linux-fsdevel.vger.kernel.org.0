Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4FDCD5854
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2019 23:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfJMV2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Oct 2019 17:28:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55607 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbfJMV2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Oct 2019 17:28:07 -0400
Received: by mail-io1-f70.google.com with SMTP id r13so23402824ioj.22
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Oct 2019 14:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GIg3VjEyMLk62hnk3ZfVQXw4+hX6gWGCRiKhiGdR4cY=;
        b=nu4tftjEmU/dCwN8JY5Ikjt+IRaauOhR+ekVMBxVYFeug9ar5ZMG99WbWjV4PjvTh/
         AgCkxupWx4xINSmYYxJA1tfphChTUJ9IZH2LUkWDm1EjAHHbUnC+A093WVmjkrcpo2eJ
         qVRdyO9kvDH2N2Xd91YwZdRtnIVmmJghf55k5Rq9+pKTD+T/ObgfXNf8qgtpqtAaxrWU
         q/L/44Wnh+fTzMQ2kLLaX7cVuwz28FMWIut+zl8qTRupI9uNZdk34cbuAXf3bxeTKhn9
         dLj8OyyYMyCxc3mTqmekpvSjlRruHNUwmHsCyKO/RXeLO7Nohd419i8QAXiQ5wlllnvf
         hdJg==
X-Gm-Message-State: APjAAAUvnL0WyVejxH6AnPiVTFr34ewVKaBxpBUoqXPC85iqws3MnPxL
        bE5nplYiZG3gZd0dNJPkeBDCPMtVIfvUgZJGuAWu94XVw/lw
X-Google-Smtp-Source: APXvYqzU7CeUe+cDz04U0gUGKGhG1dLL0b24vjISLU6mfLTbuPSfT704IuLLCgmdBb9D9HfxDX6mxAngM79g87vlHfylZQZnetlB
MIME-Version: 1.0
X-Received: by 2002:a02:bb95:: with SMTP id g21mr35191266jan.38.1571002086507;
 Sun, 13 Oct 2019 14:28:06 -0700 (PDT)
Date:   Sun, 13 Oct 2019 14:28:06 -0700
In-Reply-To: <000000000000fdd3f3058bfcf369@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ecdb90594d16d77@google.com>
Subject: Re: WARNING: bad unlock balance in rcu_lock_release
From:   syzbot <syzbot+f9545ab3e9f85cd43a3a@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    da940012 Merge tag 'char-misc-5.4-rc3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cfdf4f600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d2fd92a28d3e50
dashboard link: https://syzkaller.appspot.com/bug?extid=f9545ab3e9f85cd43a3a
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148c9fc7600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100d3f8b600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f9545ab3e9f85cd43a3a@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
5.4.0-rc2+ #0 Not tainted
-------------------------------------
syz-executor111/7877 is trying to release lock (rcu_callback) at:
[<ffffffff81612bd4>] rcu_lock_release+0x4/0x20 include/linux/rcupdate.h:212
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor111/7877:
  #0: ffff8880a3c600d8 (&type->s_umount_key#42/1){+.+.}, at:  
alloc_super+0x15f/0x790 fs/super.c:229

stack backtrace:
CPU: 1 PID: 7877 Comm: syz-executor111 Not tainted 5.4.0-rc2+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  print_unlock_imbalance_bug+0x20b/0x240 kernel/locking/lockdep.c:4008
  __lock_release kernel/locking/lockdep.c:4244 [inline]
  lock_release+0x473/0x780 kernel/locking/lockdep.c:4506
  rcu_lock_release+0x1c/0x20 include/linux/rcupdate.h:214
  __rcu_reclaim kernel/rcu/rcu.h:223 [inline]
  rcu_do_batch kernel/rcu/tree.c:2157 [inline]
  rcu_core+0x84f/0x1050 kernel/rcu/tree.c:2377
  rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2386
  __do_softirq+0x333/0x7c4 arch/x86/include/asm/paravirt.h:766
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x227/0x230 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x113/0x280 arch/x86/kernel/apic/apic.c:1137
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:756  
[inline]
RIP: 0010:console_unlock+0xe35/0xef0 kernel/printk/printk.c:2477
Code: 20 00 74 0c 48 c7 c7 f0 91 8a 88 e8 65 da 4f 00 48 83 3d ad fd 2d 07  
00 0f 84 b1 00 00 00 e8 d2 9c 16 00 48 8b 7c 24 10 57 9d <0f> 1f 44 00 00  
eb 91 e8 bf 9c 16 00 eb 8a e8 b8 9c 16 00 eb 83 48
RSP: 0018:ffff888092daf930 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: ffffffff815c944e RBX: 0000000000000200 RCX: ffff888094422640
RDX: 0000000000000000 RSI: ffffffff815c8129 RDI: 0000000000000282
RBP: ffff888092daf9f0 R08: ffff888094422640 R09: fffffbfff111a4f1
R10: fffffbfff111a4f1 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff88a3d748
  vprintk_emit+0x239/0x3a0 kernel/printk/printk.c:1996
  vprintk_default+0x28/0x30 kernel/printk/printk.c:2023
  vprintk_func+0x158/0x170 kernel/printk/printk_safe.c:386
  printk+0x62/0x8d kernel/printk/printk.c:2056
  __ntfs_error+0x185/0x190 fs/ntfs/debug.c:89
  read_ntfs_boot_sector fs/ntfs/super.c:675 [inline]
  ntfs_fill_super+0x720/0x2a40 fs/ntfs/super.c:2784
  mount_bdev+0x27c/0x390 fs/super.c:1415
  ntfs_mount+0x34/0x40 fs/ntfs/super.c:3051
  legacy_get_tree+0xf9/0x1a0 fs/fs_context.c:647
  vfs_get_tree+0x8b/0x2a0 fs/super.c:1545
  do_new_mount fs/namespace.c:2823 [inline]
  do_mount+0x16c0/0x2510 fs/namespace.c:3143
  ksys_mount+0xcc/0x100 fs/namespace.c:3352
  __do_sys_mount fs/namespace.c:3366 [inline]
  __se_sys_mount fs/namespace.c:3363 [inline]
  __x64_sys_mount+0xbf/0xd0 fs/namespace.c:3363
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441e99
Code: e8 fc ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff8d7174e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441e99
RDX: 0000000020000140 RSI: 0000000020000280 RDI: 00000000200004c0
RBP: 000000000000f000 R08: 0000000000000000 R09: 00007fff8d717698
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006ccdc8
R13: 00000000006cd440 R14: 0000000000000000 R15: 0000000000000000

