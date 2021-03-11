Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDA4336D99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 09:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCKIRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 03:17:43 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:38836 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhCKIRT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:17:19 -0500
Received: by mail-il1-f197.google.com with SMTP id o7so14885771ilt.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Mar 2021 00:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3TRstvQHyEbK+HiAu31j0sJsVSAUEWJchAJtufbYj58=;
        b=hFtjGHDfcQBcpmHGHNzodzjjXist/OXm38izxF1BNC8wUVhnv06X/QIkrx/BD4FiCM
         KI9+4Q7mzYHNqH5/HQfwcuhdd3kZMBZ1tXfL+H8IHpCIiiYIFo+vu13FpACMhMe0kclA
         xntpjFbkZugtIymIspItrEjzv2n2xBEGuc1BWZBHvctrMbQ1tNTJMoMeF7GpzNX8Reer
         0Zalce/wm+ceqortMKmqPqbCPLD3W0xicdjXuRk0gKznNZY9kbplQocyjPmC6wBK6+dv
         FVSFBjW/3o998tyG+3RoXs/BBmUsKBgLqWtAGh3hNsZu3P20ThfwtejL1T6ID33/MPw7
         0aXA==
X-Gm-Message-State: AOAM531vnnzFeFXNBkHohT9jAn5aXsezDsQpamtC+CIVjOxqKU6zLnS7
        0eS7a5g53elNuJl5cA/rLoUbh/l0UzFVi1oi8ZBgGffjdrCn
X-Google-Smtp-Source: ABdhPJz/m6p3XubniFs85aLjYXYK2RfUgR07T1xXcDHdxXKyUvyJFApR78RA564tPHMFvoHzuOU+mNXchdmko2mkC8CdRCY4zE+F
MIME-Version: 1.0
X-Received: by 2002:a6b:c40b:: with SMTP id y11mr5302010ioa.205.1615450638745;
 Thu, 11 Mar 2021 00:17:18 -0800 (PST)
Date:   Thu, 11 Mar 2021 00:17:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007987b005bd3e69e1@google.com>
Subject: [syzbot] inconsistent lock state in end_bio_bh_io_sync
From:   syzbot <syzbot+a464ba0296692a4d2692@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    05a59d79 Merge git://git.kernel.org:/pub/scm/linux/kernel/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100de152d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b28ee088c7349c4d
dashboard link: https://syzkaller.appspot.com/bug?extid=a464ba0296692a4d2692
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a464ba0296692a4d2692@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
5.12.0-rc2-syzkaller #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-R} usage.
kworker/u4:0/7 [HC0[0]:SC1[1]:HE0:SE0] takes:
8f87826c (&inode->i_size_seqcount){+.+-}-{0:0}, at: end_bio_bh_io_sync+0x38/0x54 fs/buffer.c:3006
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510
  lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483
  do_write_seqcount_begin_nested include/linux/seqlock.h:520 [inline]
  do_write_seqcount_begin include/linux/seqlock.h:545 [inline]
  i_size_write include/linux/fs.h:863 [inline]
  set_capacity+0x13c/0x1f8 block/genhd.c:50
  brd_alloc+0x130/0x180 drivers/block/brd.c:401
  brd_init+0xcc/0x1e0 drivers/block/brd.c:500
  do_one_initcall+0x8c/0x59c init/main.c:1226
  do_initcall_level init/main.c:1299 [inline]
  do_initcalls init/main.c:1315 [inline]
  do_basic_setup init/main.c:1335 [inline]
  kernel_init_freeable+0x2cc/0x330 init/main.c:1537
  kernel_init+0x10/0x120 init/main.c:1424
  ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:158
  0x0
irq event stamp: 2783413
hardirqs last  enabled at (2783412): [<802011ec>] __do_softirq+0xf4/0x7ac kernel/softirq.c:329
hardirqs last disabled at (2783413): [<8277d260>] __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:157 [inline]
hardirqs last disabled at (2783413): [<8277d260>] _raw_read_lock_irqsave+0x84/0x88 kernel/locking/spinlock.c:231
softirqs last  enabled at (2783410): [<826b5050>] spin_unlock_bh include/linux/spinlock.h:399 [inline]
softirqs last  enabled at (2783410): [<826b5050>] batadv_nc_purge_paths+0x10c/0x148 net/batman-adv/network-coding.c:467
softirqs last disabled at (2783411): [<8024ddfc>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (2783411): [<8024ddfc>] do_softirq kernel/softirq.c:248 [inline]
softirqs last disabled at (2783411): [<8024ddfc>] do_softirq+0xd8/0xe4 kernel/softirq.c:235

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&inode->i_size_seqcount);
  <Interrupt>
    lock(&inode->i_size_seqcount);

 *** DEADLOCK ***

3 locks held by kworker/u4:0/7:
 #0: 88c622a8 ((wq_completion)bat_events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: 88c622a8 ((wq_completion)bat_events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: 88c622a8 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_one_work+0x214/0x998 kernel/workqueue.c:2246
 #1: 85147ef8 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:615 [inline]
 #1: 85147ef8 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #1: 85147ef8 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: process_one_work+0x214/0x998 kernel/workqueue.c:2246
 #2: 8f878010 (&ni->size_lock){...-}-{2:2}, at: ntfs_end_buffer_async_read+0x6c/0x558 fs/ntfs/aops.c:66

stack backtrace:
CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.12.0-rc2-syzkaller #0
Hardware name: ARM-Versatile Express
Workqueue: bat_events batadv_nc_worker
Backtrace: 
[<82740468>] (dump_backtrace) from [<827406dc>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:252)
 r7:00000080 r6:60000193 r5:00000000 r4:8422a3c4
[<827406c4>] (show_stack) from [<82751b58>] (__dump_stack lib/dump_stack.c:79 [inline])
[<827406c4>] (show_stack) from [<82751b58>] (dump_stack+0xb8/0xe8 lib/dump_stack.c:120)
[<82751aa0>] (dump_stack) from [<82742918>] (print_usage_bug.part.0+0x228/0x230 kernel/locking/lockdep.c:3806)
 r7:8512e868 r6:82803274 r5:848a3628 r4:8512e180
[<827426f0>] (print_usage_bug.part.0) from [<802bb4b8>] (print_usage_bug kernel/locking/lockdep.c:3776 [inline])
[<827426f0>] (print_usage_bug.part.0) from [<802bb4b8>] (valid_state kernel/locking/lockdep.c:3818 [inline])
[<827426f0>] (print_usage_bug.part.0) from [<802bb4b8>] (mark_lock_irq kernel/locking/lockdep.c:4021 [inline])
[<827426f0>] (print_usage_bug.part.0) from [<802bb4b8>] (mark_lock.part.0+0xc34/0x136c kernel/locking/lockdep.c:4478)
 r10:84a42fe8 r9:84437748 r8:00000000 r7:844372d4 r6:00000006 r5:8512e868
 r4:00000005
[<802ba884>] (mark_lock.part.0) from [<802bca0c>] (mark_lock kernel/locking/lockdep.c:4442 [inline])
[<802ba884>] (mark_lock.part.0) from [<802bca0c>] (mark_usage kernel/locking/lockdep.c:4365 [inline])
[<802ba884>] (mark_lock.part.0) from [<802bca0c>] (__lock_acquire+0xa84/0x3318 kernel/locking/lockdep.c:4854)
 r10:8512e868 r9:8512e180 r8:00000001 r7:00040000 r6:0000023a r5:848a3628
 r4:00000000
[<802bbf88>] (__lock_acquire) from [<802bfe90>] (lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510)
 r10:00000080 r9:60000193 r8:00000000 r7:00000000 r6:83ecd680 r5:83ecd680
 r4:85147b68
[<802bfda0>] (lock_acquire.part.0) from [<802c0228>] (lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483)
 r10:8052dcb4 r9:00000000 r8:00000001 r7:00000002 r6:00000000 r5:00000000
 r4:8f87826c
[<802c01bc>] (lock_acquire) from [<808b1af8>] (seqcount_lockdep_reader_access include/linux/seqlock.h:103 [inline])
[<802c01bc>] (lock_acquire) from [<808b1af8>] (i_size_read include/linux/fs.h:838 [inline])
[<802c01bc>] (lock_acquire) from [<808b1af8>] (ntfs_end_buffer_async_read+0xb4/0x558 fs/ntfs/aops.c:68)
 r10:8f878000 r9:60000193 r8:8052dcb4 r7:8f87826c r6:df3f0dc0 r5:8a4e46c0
 r4:8f8781c8
[<808b1a44>] (ntfs_end_buffer_async_read) from [<8052dcb4>] (end_bio_bh_io_sync+0x38/0x54 fs/buffer.c:3006)
 r10:00000200 r9:00000200 r8:0000000a r7:00000000 r6:8725ad00 r5:8a4e46c0
 r4:8b08c3c0
[<8052dc7c>] (end_bio_bh_io_sync) from [<80f0f638>] (bio_endio+0x124/0x338 block/bio.c:1436)
 r5:80f0f84c r4:8b08c3c0
[<80f0f514>] (bio_endio) from [<80f166cc>] (req_bio_endio block/blk-core.c:265 [inline])
[<80f0f514>] (bio_endio) from [<80f166cc>] (blk_update_request+0x220/0x724 block/blk-core.c:1456)
 r9:00000200 r8:0000000a r7:00000000 r6:8725ad00 r5:00000200 r4:8b08c3c0
[<80f164ac>] (blk_update_request) from [<80f23128>] (blk_mq_end_request+0x1c/0x144 block/blk-mq.c:564)
 r10:00000010 r9:85146000 r8:8404ec98 r7:00000000 r6:00000004 r5:8725ad00
 r4:8725ad00
[<80f2310c>] (blk_mq_end_request) from [<811d1e2c>] (lo_complete_rq+0x98/0xd4 drivers/block/loop.c:497)
 r7:00000001 r6:00000004 r5:8725ad00 r4:ffffffc8
[<811d1d94>] (lo_complete_rq) from [<80f21ab4>] (blk_complete_reqs+0x5c/0x68 block/blk-mq.c:576)
 r5:00000005 r4:ffffffc8
[<80f21a58>] (blk_complete_reqs) from [<80f21b1c>] (blk_done_softirq+0x2c/0x30 block/blk-mq.c:581)
 r5:00000005 r4:83ed846c
[<80f21af0>] (blk_done_softirq) from [<802012fc>] (__do_softirq+0x204/0x7ac kernel/softirq.c:345)
 r5:00000005 r4:84004090
[<802010f8>] (__do_softirq) from [<8024ddfc>] (do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline])
[<802010f8>] (__do_softirq) from [<8024ddfc>] (do_softirq kernel/softirq.c:248 [inline])
[<802010f8>] (__do_softirq) from [<8024ddfc>] (do_softirq+0xd8/0xe4 kernel/softirq.c:235)
 r10:00000088 r9:88c9c2d0 r8:8aaaeac0 r7:00000000 r6:ffffe000 r5:826b5050
 r4:60000193
[<8024dd24>] (do_softirq) from [<8024e048>] (__local_bh_enable_ip+0x240/0x244 kernel/softirq.c:198)
 r5:826b5050 r4:00000001
[<8024de08>] (__local_bh_enable_ip) from [<8277cf8c>] (__raw_spin_unlock_bh include/linux/spinlock_api_smp.h:176 [inline])
[<8024de08>] (__local_bh_enable_ip) from [<8277cf8c>] (_raw_spin_unlock_bh+0x34/0x38 kernel/locking/spinlock.c:207)
 r7:00000000 r6:00000015 r5:88c9c2d0 r4:826b5050
[<8277cf58>] (_raw_spin_unlock_bh) from [<826b5050>] (spin_unlock_bh include/linux/spinlock.h:399 [inline])
[<8277cf58>] (_raw_spin_unlock_bh) from [<826b5050>] (batadv_nc_purge_paths+0x10c/0x148 net/batman-adv/network-coding.c:467)
 r5:8aae9740 r4:826b511c
[<826b4f44>] (batadv_nc_purge_paths) from [<826b57b0>] (batadv_nc_worker+0x304/0x470 net/batman-adv/network-coding.c:716)
 r10:00000088 r9:8404ec98 r8:8aae9d28 r7:88a9c200 r6:84006d00 r5:8aaea000
 r4:8aae9740
[<826b54ac>] (batadv_nc_worker) from [<802696a4>] (process_one_work+0x2d4/0x998 kernel/workqueue.c:2275)
 r10:00000088 r9:8404ec98 r8:84367a02 r7:88a9c200 r6:85020000 r5:850c9700
 r4:8aae9d28
[<802693d0>] (process_one_work) from [<80269dcc>] (worker_thread+0x64/0x54c kernel/workqueue.c:2421)
 r10:00000088 r9:85146000 r8:84006d00 r7:85020038 r6:850c9714 r5:85020000
 r4:850c9700
[<80269d68>] (worker_thread) from [<80271f40>] (kthread+0x184/0x1a4 kernel/kthread.c:292)
 r10:8511be34 r9:850c9700 r8:80269d68 r7:00000000 r6:85146000 r5:850cee40
 r4:850c9780
[<80271dbc>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:158)
Exception stack(0x85147fb0 to 0x85147ff8)
7fa0:                                     00000000 00000000 00000000 00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:80271dbc
 r4:850cee40


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
