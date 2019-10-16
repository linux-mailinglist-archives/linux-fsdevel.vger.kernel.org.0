Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD699D8C82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 11:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404204AbfJPJ1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 05:27:10 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:51124 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732124AbfJPJ1K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:27:10 -0400
Received: by mail-io1-f70.google.com with SMTP id f5so36830362iob.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2019 02:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lQr0ok6MRutKtTJ5U+lFMsazKVKwReVzwbr4H/cT9EA=;
        b=QUltU6G/vUYIjnqYnMgtT+JGDpG7F/ocYzbNZj2ELDdW1ayfW3webzsV+bHXEiW3Yq
         S7hslvSnJ26JUcOoKzhcBPtmJzGfYG5LaTtGbADgO3m0bJli+/rxwWAMHVqlp0lg8uDj
         xbUcQMXBcJNNhga0zUIQ2NfBU7frQVYAa+daE0dc6VmJtwdtUL50OP4G2DPzQ+jtsCKa
         SIsS+hjpjMBVaz7LMfvX58HCs5V8JujY7t5PuSZvHb/m721RSze9zoyUgRf/R/84c9H+
         2Ef8o+T1xySTt04mFJPJ7JC9+/oN+7U6QXBi9x/1x7nFQAgHKcd3Lldog0j1j1PdGl/f
         ovdg==
X-Gm-Message-State: APjAAAX78ZEOtz6YabOdLDwPZholyDpJcRpLyfVt7c9J0jYMBF2CBPwD
        nuW8vxrhkUyx2sr6b1bDfgPuJti4xhfDjZD4wK/VbDbEjXbL
X-Google-Smtp-Source: APXvYqyLhW0ls6OxrjEZ/9eOcP0MAq9LWA7NbkaFdWzwih4RhdUXPkPERvYUBnW/3idsLACu7ZGcCxr6WboAUwTKzYIR4mFDP9JS
MIME-Version: 1.0
X-Received: by 2002:a92:a144:: with SMTP id v65mr11052965ili.240.1571218027106;
 Wed, 16 Oct 2019 02:27:07 -0700 (PDT)
Date:   Wed, 16 Oct 2019 02:27:07 -0700
In-Reply-To: <000000000000c0bffa0586795098@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005edcd0059503b4aa@google.com>
Subject: Re: WARNING: bad unlock balance in rcu_core
From:   syzbot <syzbot+36baa6c2180e959e19b1@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    0e9d28bc Add linux-next specific files for 20191015
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11745608e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d84ca04228b0bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=36baa6c2180e959e19b1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159d297f600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16289b30e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+36baa6c2180e959e19b1@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
5.4.0-rc3-next-20191015 #0 Not tainted
-------------------------------------
syz-executor276/8897 is trying to release lock (rcu_callback) at:
[<ffffffff8160e7a4>] __write_once_size include/linux/compiler.h:226 [inline]
[<ffffffff8160e7a4>] __rcu_reclaim kernel/rcu/rcu.h:221 [inline]
[<ffffffff8160e7a4>] rcu_do_batch kernel/rcu/tree.c:2157 [inline]
[<ffffffff8160e7a4>] rcu_core+0x574/0x1560 kernel/rcu/tree.c:2377
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor276/8897:
  #0: ffff88809a3cc0d8 (&type->s_umount_key#40/1){+.+.}, at:  
alloc_super+0x158/0x910 fs/super.c:229

stack backtrace:
CPU: 0 PID: 8897 Comm: syz-executor276 Not tainted 5.4.0-rc3-next-20191015  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_unlock_imbalance_bug kernel/locking/lockdep.c:4008 [inline]
  print_unlock_imbalance_bug.cold+0x114/0x123 kernel/locking/lockdep.c:3984
  __lock_release kernel/locking/lockdep.c:4244 [inline]
  lock_release+0x5f2/0x960 kernel/locking/lockdep.c:4505
  rcu_lock_release include/linux/rcupdate.h:213 [inline]
  __rcu_reclaim kernel/rcu/rcu.h:223 [inline]
  rcu_do_batch kernel/rcu/tree.c:2157 [inline]
  rcu_core+0x594/0x1560 kernel/rcu/tree.c:2377
  rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2386
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x19b/0x1e0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1137
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:756  
[inline]
RIP: 0010:console_unlock+0xbb8/0xf00 kernel/printk/printk.c:2481
Code: f3 88 48 c1 e8 03 42 80 3c 30 00 0f 85 e4 02 00 00 48 83 3d 99 9c 96  
07 00 0f 84 91 01 00 00 e8 be c4 16 00 48 8b 7d 98 57 9d <0f> 1f 44 00 00  
e9 6d ff ff ff e8 a9 c4 16 00 48 8b 7d 08 c7 05 eb
RSP: 0018:ffff88809fd7f8f0 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff8880a8bee540 RBX: 0000000000000200 RCX: 1ffffffff138eea6
RDX: 0000000000000000 RSI: ffffffff815c8592 RDI: 0000000000000293
RBP: ffff88809fd7f978 R08: ffff8880a8bee540 R09: fffffbfff11f4119
R10: fffffbfff11f4118 R11: 0000000000000001 R12: 0000000000000000
R13: ffffffff843f8ca0 R14: dffffc0000000000 R15: ffffffff895e1130
  vprintk_emit+0x2a0/0x700 kernel/printk/printk.c:1996
  vprintk_default+0x28/0x30 kernel/printk/printk.c:2023
  vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:386
  printk+0xba/0xed kernel/printk/printk.c:2056
  __ntfs_error.cold+0x91/0xc7 fs/ntfs/debug.c:89
  read_ntfs_boot_sector fs/ntfs/super.c:682 [inline]
  ntfs_fill_super+0x1ad3/0x3160 fs/ntfs/super.c:2784
  mount_bdev+0x304/0x3c0 fs/super.c:1415
  ntfs_mount+0x35/0x40 fs/ntfs/super.c:3051
  legacy_get_tree+0x108/0x220 fs/fs_context.c:647
  vfs_get_tree+0x8e/0x300 fs/super.c:1545
  do_new_mount fs/namespace.c:2823 [inline]
  do_mount+0x142e/0x1cf0 fs/namespace.c:3143
  ksys_mount+0xdb/0x150 fs/namespace.c:3352
  __do_sys_mount fs/namespace.c:3366 [inline]
  __se_sys_mount fs/namespace.c:3363 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3363
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4411a9
Code: e8 fc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 9b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffffff57cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004411a9
RDX: 0000000020000140 RSI: 0000000020000280 RDI: 00000000200004c0
RBP: 00000000000114e0 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401fd0
R13: 0000000000402060 R14: 0000000000000000 R15: 0000000000000000

