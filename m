Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31255282434
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 15:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgJCNJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 09:09:17 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:39456 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgJCNJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 09:09:16 -0400
Received: by mail-il1-f205.google.com with SMTP id r10so3378889ilq.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Oct 2020 06:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iVL3IohRqT6c/uXzx5CC8YPW5rjrUz4BS2oOo74sL2M=;
        b=av5IjgJBacHy2Q3YOQpnwpXQdOfItoTAQteFusjr/xG1m1x/zA0dvJZZNMiJKPmTSz
         9PyOVAElynfDgMXzjv8olPyMCdpUNG1eqsbyHU2EzQZWnzdNPLyWHHABYCA2VTpPSLS5
         i2tLoJTnJog2tOCvFc+6E7QuD1Lneob6H0THrguBEU5JACb80Ke8ZalwTqlLEAgBrtHx
         BtS64h5ipVLK+ualbZG1U0TULruwEbbKuRzDQ8uqne2+Zp2Z03oU9s7APIdTVGbpprR1
         cRXhydy62lyfyaYK0E95BAdfgvGj9t38RG46nXx+RZfXVrpnVUueFc9yKiEtTe5lsYDY
         yS9g==
X-Gm-Message-State: AOAM53030GnkWBwUEt740ZOEPW/H9t47n3FAov9X0duEaCZ5Mc7OW5d/
        aArqHemSvNL10AZa0IUNpSfRXqJM++wXKWtmC2gcOIvTz/cO
X-Google-Smtp-Source: ABdhPJzRay26HKMVft78Lrncn852vCrGTWO51ZHtl15nl4W8WpyjG0P3FlwM0y2vhB9msdxzy6rqhqrJOgovuNK0MeVEDP/zauuo
MIME-Version: 1.0
X-Received: by 2002:a05:6638:c6:: with SMTP id w6mr6259820jao.143.1601730555760;
 Sat, 03 Oct 2020 06:09:15 -0700 (PDT)
Date:   Sat, 03 Oct 2020 06:09:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd530a05b0c3f4bc@google.com>
Subject: INFO: task hung in blkdev_put (4)
From:   syzbot <syzbot+9a29d5e745bd7523c851@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchristi@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fb0155a0 Merge tag 'nfs-for-5.9-3' of git://git.linux-nfs...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1527329d900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41b736b7ce1b3ea4
dashboard link: https://syzkaller.appspot.com/bug?extid=9a29d5e745bd7523c851
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13cb63e3900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ae6083900000

The issue was bisected to:

commit 2da22da573481cc4837e246d0eee4d518b3f715e
Author: Mike Christie <mchristi@redhat.com>
Date:   Tue Aug 13 16:39:52 2019 +0000

    nbd: fix zero cmd timeout handling v2

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e51b27900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16e51b27900000
console output: https://syzkaller.appspot.com/x/log.txt?x=12e51b27900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a29d5e745bd7523c851@syzkaller.appspotmail.com
Fixes: 2da22da57348 ("nbd: fix zero cmd timeout handling v2")

INFO: task syz-executor931:6875 blocked for more than 143 seconds.
      Not tainted 5.9.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor931 state:D stack:27640 pid: 6875 ppid:  6874 flags:0x80004006
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0xec9/0x2280 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4661
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10e0 kernel/locking/mutex.c:1103
 blkdev_put+0x30/0x520 fs/block_dev.c:1804
 blkdev_close+0x8c/0xb0 fs/block_dev.c:1853
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 exit_task_work include/linux/task_work.h:25 [inline]
 do_exit+0xb7d/0x29f0 kernel/exit.c:806
 do_group_exit+0x125/0x310 kernel/exit.c:903
 get_signal+0x428/0x1f00 kernel/signal.c:2757
 arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:161 [inline]
 exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:192
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:267
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x445039
Code: Bad RIP value.
RSP: 002b:00007ffdc5595ec8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 0000000000445039
RDX: 00000000ffffffff RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 00000000006cf018 R08: 00000000004002e0 R09: 00000000004002e0
R10: 00000000004002e0 R11: 0000000000000246 R12: 0000000000402200
R13: 0000000000402290 R14: 0000000000000000 R15: 0000000000000000
INFO: task systemd-udevd:6879 blocked for more than 143 seconds.
      Not tainted 5.9.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-udevd   state:D stack:26264 pid: 6879 ppid:  3932 flags:0x00004100
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0xec9/0x2280 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 io_schedule+0xb5/0x120 kernel/sched/core.c:6296
 wait_on_page_bit_common+0x32a/0xe30 mm/filemap.c:1253
 wait_on_page_bit mm/filemap.c:1314 [inline]
 wait_on_page_locked include/linux/pagemap.h:611 [inline]
 wait_on_page_read mm/filemap.c:2931 [inline]
 do_read_cache_page+0x957/0x1390 mm/filemap.c:2974
 read_mapping_page include/linux/pagemap.h:437 [inline]
 read_part_sector+0xf6/0x5af block/partitions/core.c:777
 adfspart_check_ICS+0x9d/0xc90 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:140 [inline]
 blk_add_partitions+0x45c/0xe40 block/partitions/core.c:705
 bdev_disk_changed+0x1ea/0x370 fs/block_dev.c:1416
 __blkdev_get+0xee4/0x1aa0 fs/block_dev.c:1559
 blkdev_get fs/block_dev.c:1639 [inline]
 blkdev_open+0x227/0x300 fs/block_dev.c:1753
 do_dentry_open+0x4b9/0x11b0 fs/open.c:817
 do_open fs/namei.c:3251 [inline]
 path_openat+0x1b9a/0x2730 fs/namei.c:3368
 do_filp_open+0x17e/0x3c0 fs/namei.c:3395
 do_sys_openat2+0x16d/0x420 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_open fs/open.c:1192 [inline]
 __se_sys_open fs/open.c:1188 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1188
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fd8b1526840
Code: Bad RIP value.
RSP: 002b:00007ffc6e5f3668 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 000055f1c1bb6e40 RCX: 00007fd8b1526840
RDX: 000055f1c0593fe3 RSI: 00000000000a0800 RDI: 000055f1c1bb9b10
RBP: 00007ffc6e5f37e0 R08: 000055f1c0593670 R09: 0000000000000010
R10: 000055f1c0593d0c R11: 0000000000000246 R12: 00007ffc6e5f3730
R13: 000055f1c1bb1a90 R14: 0000000000000003 R15: 000000000000000e

Showing all locks held in the system:
1 lock held by khungtaskd/1174:
 #0: ffffffff8a067f40 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5852
1 lock held by in:imklog/6556:
 #0: ffff88809144e370 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930
1 lock held by syz-executor931/6875:
 #0: ffff88808927b6c0 (&bdev->bd_mutex){+.+.}-{3:3}, at: blkdev_put+0x30/0x520 fs/block_dev.c:1804
1 lock held by systemd-udevd/6879:
 #0: ffff88808927b6c0 (&bdev->bd_mutex){+.+.}-{3:3}, at: __blkdev_get+0x4b8/0x1aa0 fs/block_dev.c:1492

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1174 Comm: khungtaskd Not tainted 5.9.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x1b3/0x223 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd7d/0x1000 kernel/hung_task.c:295
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 3911 Comm: systemd-journal Not tainted 5.9.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0xffffffffa00185f0
Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <0f> 1f 44 00 00 55 48 89 e5 48 81 ec 00 00 00 00 53 41 55 41 56 41
RSP: 0018:ffffc90003817d88 EFLAGS: 00000246
RAX: 1ffff920001c3e06 RBX: ffff8880a7b97c00 RCX: dffffc0000000000
RDX: ffff8880a77602c0 RSI: ffffc90000e1f038 RDI: ffffc90003817e38
RBP: ffffc90000e1f000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: 00000000000001a0 R14: 0000000000080042 R15: ffffc90003817e38
FS:  00007fa30091e8c0(0000) GS:ffff8880ae400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa2fdcde010 CR3: 00000000a8f90000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
