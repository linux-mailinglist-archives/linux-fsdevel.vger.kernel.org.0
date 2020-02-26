Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C116F847
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 08:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgBZHAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 02:00:14 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:57213 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgBZHAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 02:00:14 -0500
Received: by mail-il1-f200.google.com with SMTP id p67so2426058ili.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2020 23:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=c/z5xsfniKKSLpZLHpMNU5fa7JkGhvt2XH2XB+rUEog=;
        b=BBOb/ruQVkbazKc1IVHwS/5AJMms2rVPsk6fzTG3EQ7YH8enCMMv5eaKwuSeGkSZNM
         ObK5ISQ2xAwEc/Enp8StnCPKybaxQz4hMdwigiaf3T2YVpp8zecDp6JkavMPeSc5Z+rg
         T0JiaWCU1nxaHvBAziTC4eTQ7RRK4xM1f9sJJd6f8PSvGJYFcwc1Qy35ESl48l4bVPBo
         pdQgRtIsDwI7Hsdofz1wuw123cxPh+pkIMLh4Hr7pbqKOvsNYrFuZT1JkTLRelMKBnbD
         Z3+dv2kQe8EzBS80u1Vp/sx78CQrl91fNja+zNXGqivg7MToxrVSBfVis7iZFdqReNN1
         IinA==
X-Gm-Message-State: APjAAAVWUyhAhjRQx8uvpWZecqZApkeo9za+92G+NKU8Zz5FI0f3OITO
        sXekY7HKefWisKsj9eqg5Q59Mvwn7+c0LKUzWJRdQGuMPjWz
X-Google-Smtp-Source: APXvYqwWuL/1JuLhG0V0aEToyB8sL6RDX/CpmmMPCuFzxXT/5tOdtCxBL3WSIP5W6PGne9CFUr4CfzGXSogvGK6t3P21q/3PQnOK
MIME-Version: 1.0
X-Received: by 2002:a92:d610:: with SMTP id w16mr2624725ilm.283.1582700413344;
 Tue, 25 Feb 2020 23:00:13 -0800 (PST)
Date:   Tue, 25 Feb 2020 23:00:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec635b059f752700@google.com>
Subject: KASAN: use-after-free Read in lockref_get
From:   syzbot <syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f8788d86 Linux 5.6-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f460e3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=603294af2d01acfdd6da
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in perf_trace_lock_acquire+0x401/0x530 include/trace/events/lock.h:13
Read of size 8 at addr ffff8880966bcef0 by task syz-executor.1/28128

CPU: 1 PID: 28128 Comm: syz-executor.1 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
 __kasan_report.cold+0x1b/0x32 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
 perf_trace_lock_acquire+0x401/0x530 include/trace/events/lock.h:13
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0x2de/0x410 kernel/locking/lockdep.c:4483
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
 lockref_get+0x16/0x60 include/linux/spinlock.h:338
 dget include/linux/dcache.h:321 [inline]
 simple_recursive_removal+0x3e/0x720 fs/libfs.c:268
 debugfs_remove fs/debugfs/inode.c:713 [inline]
 debugfs_remove+0x5e/0x80 fs/debugfs/inode.c:707
 blk_trace_free+0x38/0x140 kernel/trace/blktrace.c:311
 do_blk_trace_setup+0x735/0xb50 kernel/trace/blktrace.c:556
 __blk_trace_setup+0xe3/0x190 kernel/trace/blktrace.c:570
 blk_trace_ioctl+0x170/0x300 kernel/trace/blktrace.c:709
 blkdev_ioctl+0xc3/0x670 block/ioctl.c:710
 block_ioctl+0xee/0x130 fs/block_dev.c:1983
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x123/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c449
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4acd2fec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4acd2ff6d4 RCX: 000000000045c449
RDX: 0000000020000080 RSI: 00000000c0481273 RDI: 0000000000000004
RBP: 000000000076bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000228 R14: 00000000004c40ce R15: 000000000076bfcc

Allocated by task 28128:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:488
 kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:523
 slab_post_alloc_hook mm/slab.h:584 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 kmem_cache_alloc+0x121/0x710 mm/slab.c:3484
 __d_alloc+0x2e/0x8c0 fs/dcache.c:1690
 d_alloc+0x4d/0x280 fs/dcache.c:1769
 d_alloc_parallel+0xf4/0x1c00 fs/dcache.c:2521
 __lookup_slow+0x1ab/0x4d0 fs/namei.c:1742
 lookup_one_len+0x16d/0x1a0 fs/namei.c:2661
 start_creating+0x132/0x260 fs/debugfs/inode.c:338
 __debugfs_create_file+0x65/0x3f0 fs/debugfs/inode.c:383
 debugfs_create_file+0x5a/0x70 fs/debugfs/inode.c:440
 do_blk_trace_setup+0x361/0xb50 kernel/trace/blktrace.c:523
 __blk_trace_setup+0xe3/0x190 kernel/trace/blktrace.c:570
 blk_trace_ioctl+0x170/0x300 kernel/trace/blktrace.c:709
 blkdev_ioctl+0xc3/0x670 block/ioctl.c:710
 block_ioctl+0xee/0x130 fs/block_dev.c:1983
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x123/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 28134:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 __cache_free mm/slab.c:3426 [inline]
 kmem_cache_free+0x86/0x320 mm/slab.c:3694
 __d_free+0x20/0x30 fs/dcache.c:271
 rcu_do_batch kernel/rcu/tree.c:2186 [inline]
 rcu_core+0x5e1/0x1390 kernel/rcu/tree.c:2410
 rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2419
 __do_softirq+0x262/0x98c kernel/softirq.c:292

The buggy address belongs to the object at ffff8880966bce40
 which belongs to the cache dentry(28:syz1) of size 288
The buggy address is located 176 bytes inside of
 288-byte region [ffff8880966bce40, ffff8880966bcf60)
The buggy address belongs to the page:
page:ffffea000259af00 refcount:1 mapcount:0 mapping:ffff888093c038c0 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002594908 ffffea000234d388 ffff888093c038c0
raw: 0000000000000000 ffff8880966bc080 000000010000000b 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880966bcd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880966bce00: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>ffff8880966bce80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff8880966bcf00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff8880966bcf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
