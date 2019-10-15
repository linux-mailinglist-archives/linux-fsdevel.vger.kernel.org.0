Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB739D7092
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 09:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfJOH4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 03:56:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:50704 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726549AbfJOH4e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:56:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 176EFB471;
        Tue, 15 Oct 2019 07:56:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6C1901E4A8A; Tue, 15 Oct 2019 09:56:31 +0200 (CEST)
Date:   Tue, 15 Oct 2019 09:56:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+f9545ab3e9f85cd43a3a@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING: bad unlock balance in rcu_lock_release
Message-ID: <20191015075631.GB21550@quack2.suse.cz>
References: <000000000000fdd3f3058bfcf369@google.com>
 <0000000000004ecdb90594d16d77@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004ecdb90594d16d77@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 13-10-19 14:28:06, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    da940012 Merge tag 'char-misc-5.4-rc3' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12cfdf4f600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2d2fd92a28d3e50
> dashboard link: https://syzkaller.appspot.com/bug?extid=f9545ab3e9f85cd43a3a
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148c9fc7600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100d3f8b600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f9545ab3e9f85cd43a3a@syzkaller.appspotmail.com
> 
> =====================================
> WARNING: bad unlock balance detected!
> 5.4.0-rc2+ #0 Not tainted
> -------------------------------------
> syz-executor111/7877 is trying to release lock (rcu_callback) at:
> [<ffffffff81612bd4>] rcu_lock_release+0x4/0x20 include/linux/rcupdate.h:212
> but there are no more locks to release!

Hum, this is really weird. Look:

> other info that might help us debug this:
> 1 lock held by syz-executor111/7877:
>  #0: ffff8880a3c600d8 (&type->s_umount_key#42/1){+.+.}, at:
> alloc_super+0x15f/0x790 fs/super.c:229
> 
> stack backtrace:
> CPU: 1 PID: 7877 Comm: syz-executor111 Not tainted 5.4.0-rc2+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
>  print_unlock_imbalance_bug+0x20b/0x240 kernel/locking/lockdep.c:4008
>  __lock_release kernel/locking/lockdep.c:4244 [inline]
>  lock_release+0x473/0x780 kernel/locking/lockdep.c:4506
>  rcu_lock_release+0x1c/0x20 include/linux/rcupdate.h:214
>  __rcu_reclaim kernel/rcu/rcu.h:223 [inline]

__rcu_reclaim_kernel() has:

        rcu_lock_acquire(&rcu_callback_map);
        if (__is_kfree_rcu_offset(offset)) {
                trace_rcu_invoke_kfree_callback(rn, head, offset);
                kfree((void *)head - offset);
                rcu_lock_release(&rcu_callback_map);
                return true;
        } else {
                trace_rcu_invoke_callback(rn, head);
                f = head->func;
                WRITE_ONCE(head->func, (rcu_callback_t)0L);
                f(head);
                rcu_lock_release(&rcu_callback_map);
                return false;
        }

So RCU locking is clearly balanced there. The only possibility I can see
how this can happen is that RCU callback we have called actually released
rcu_callback_map but grepping the kernel doesn't show any other place where
that would get released? Confused.

But apparently there is even a reproducer for this so we could dig
further...

								Honza

>  rcu_do_batch kernel/rcu/tree.c:2157 [inline]
>  rcu_core+0x84f/0x1050 kernel/rcu/tree.c:2377
>  rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2386
>  __do_softirq+0x333/0x7c4 arch/x86/include/asm/paravirt.h:766
>  invoke_softirq kernel/softirq.c:373 [inline]
>  irq_exit+0x227/0x230 kernel/softirq.c:413
>  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
>  smp_apic_timer_interrupt+0x113/0x280 arch/x86/kernel/apic/apic.c:1137
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
>  </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:756
> [inline]
> RIP: 0010:console_unlock+0xe35/0xef0 kernel/printk/printk.c:2477
> Code: 20 00 74 0c 48 c7 c7 f0 91 8a 88 e8 65 da 4f 00 48 83 3d ad fd 2d 07
> 00 0f 84 b1 00 00 00 e8 d2 9c 16 00 48 8b 7c 24 10 57 9d <0f> 1f 44 00 00 eb
> 91 e8 bf 9c 16 00 eb 8a e8 b8 9c 16 00 eb 83 48
> RSP: 0018:ffff888092daf930 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
> RAX: ffffffff815c944e RBX: 0000000000000200 RCX: ffff888094422640
> RDX: 0000000000000000 RSI: ffffffff815c8129 RDI: 0000000000000282
> RBP: ffff888092daf9f0 R08: ffff888094422640 R09: fffffbfff111a4f1
> R10: fffffbfff111a4f1 R11: 0000000000000000 R12: dffffc0000000000
> R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff88a3d748
>  vprintk_emit+0x239/0x3a0 kernel/printk/printk.c:1996
>  vprintk_default+0x28/0x30 kernel/printk/printk.c:2023
>  vprintk_func+0x158/0x170 kernel/printk/printk_safe.c:386
>  printk+0x62/0x8d kernel/printk/printk.c:2056
>  __ntfs_error+0x185/0x190 fs/ntfs/debug.c:89
>  read_ntfs_boot_sector fs/ntfs/super.c:675 [inline]
>  ntfs_fill_super+0x720/0x2a40 fs/ntfs/super.c:2784
>  mount_bdev+0x27c/0x390 fs/super.c:1415
>  ntfs_mount+0x34/0x40 fs/ntfs/super.c:3051
>  legacy_get_tree+0xf9/0x1a0 fs/fs_context.c:647
>  vfs_get_tree+0x8b/0x2a0 fs/super.c:1545
>  do_new_mount fs/namespace.c:2823 [inline]
>  do_mount+0x16c0/0x2510 fs/namespace.c:3143
>  ksys_mount+0xcc/0x100 fs/namespace.c:3352
>  __do_sys_mount fs/namespace.c:3366 [inline]
>  __se_sys_mount fs/namespace.c:3363 [inline]
>  __x64_sys_mount+0xbf/0xd0 fs/namespace.c:3363
>  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x441e99
> Code: e8 fc ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 3b 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fff8d7174e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441e99
> RDX: 0000000020000140 RSI: 0000000020000280 RDI: 00000000200004c0
> RBP: 000000000000f000 R08: 0000000000000000 R09: 00007fff8d717698
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006ccdc8
> R13: 00000000006cd440 R14: 0000000000000000 R15: 0000000000000000
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
