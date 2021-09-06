Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655A2401628
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 08:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbhIFGGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 02:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhIFGGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 02:06:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9AFC061575;
        Sun,  5 Sep 2021 23:05:09 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r2so5683727pgl.10;
        Sun, 05 Sep 2021 23:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PGva41knd7GM3e5YVH8FUV9yeKh0+xyyOXoFtssO9cY=;
        b=nJdV6r6soby4QjRonWL3nJUwxmO/+GkCuort/5Rosenq3w/Sq6FYohbQOECao+RUxj
         fTijTU9vfUNMNk2Wc2sJef6MJPwMzZqITogio9P+Uh2KCE+iAncnWJjPtSwlLjuvGHNU
         WFQdi1TMa4lycEYihaxePWn9o1a2H+3mbpdRgogU9Bd82XVKJxzHu9wIjKYeNq6ugccq
         irvvTqjBwnSwWTd7X0BVJzrTgkrYJkd0voovPhN1ge9hd0q0YEGQVCVJ4du06/dNig7m
         2ljI+TfBvScum7EUpwJ9hzK/RoPLEy/F2Twu06kMqdWYve0Dsy9euT/QE8fxBtxoQBMz
         7CBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PGva41knd7GM3e5YVH8FUV9yeKh0+xyyOXoFtssO9cY=;
        b=eNcFBkJa4kmK5eivPQ8bhixa2RyYGuqcGxybcygntGvVEZVVweBldSydv13+3JQ2Yv
         PeXYjAsS3K/MBcGn6IjjMsxFQ/ak+zguJXcmcm/cb6nCulgxjzlmTEFARXcsfwP4RTzw
         rMeiJQBzMo/d14AT8k44fi5lGAGyPWKFaPsx4w8lucVydeMklvfbDYl8/4kOO+bMp1Rr
         GSvJbENiUD10TLmBk/LbY8f7pnn6BRR7bws2o/t/GknroNGssj6du0KoYlWltTWTwiWE
         5D7B/HC5sxtEf1hpeTUU0tVC0bpimYNK1w/795oOSGxi0ZEImp7gK45hAq7sbDmvQceI
         d0aA==
X-Gm-Message-State: AOAM532JiKq1XV9/850fJx+VyCoq12CxuXHFdVMXcCpVlrmJPO/Nmgco
        BswZ71ByDj6TUrgH+AO2RvwqnoB+MckkPuy6FcjneYFaE+CIuas=
X-Google-Smtp-Source: ABdhPJwiQUT4m/4hOkNAnEj3QRw5BWkk0k+r8PmEXecoIGKCCxp3TJrSkc3kZxZFlWnPmnP2RmU2tyK2o9xtL6uSJuo=
X-Received: by 2002:a63:36c4:: with SMTP id d187mr6573799pga.205.1630908308782;
 Sun, 05 Sep 2021 23:05:08 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 6 Sep 2021 14:04:58 +0800
Message-ID: <CACkBjsbWHkfNWRuGWkLrjoyTRbnwLHdm35KYfCfsKB5vP399dQ@mail.gmail.com>
Subject: INFO: task hung in blkdev_put
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 7d2a07b76933 Linux 5.14
git tree: upstream
console output:
https://drive.google.com/file/d/15bKzfm25-e8kS5RDgiqoT024VpaOBhju/view?usp=sharing
kernel config: https://drive.google.com/file/d/1XD9WYDViQLSXN7RGwH8AGGDvP9JvOghx/view?usp=sharing
Similar bug reported by Syzbot:
https://syzkaller.appspot.com/bug?id=9b6cad151b16cc24fe15fc086a3e53c0a3b2a43c

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task syz-executor:10684 blocked for more than 143 seconds.
      Not tainted 5.14.0 #25
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:27880 pid:10684 ppid:  9037 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4695 [inline]
 __schedule+0x974/0x2510 kernel/sched/core.c:6026
 schedule+0xd3/0x270 kernel/sched/core.c:6105
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6164
 __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
 __mutex_lock+0x92e/0x1390 kernel/locking/mutex.c:1104
 blkdev_put+0x98/0x720 fs/block_dev.c:1534
 blkdev_close+0x8c/0xb0 fs/block_dev.c:1586
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xe0/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x28d/0x2a0 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
RSP: 002b:00007f1d42ba6198 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 000000000059c0a0 RCX: 00000000004739cd
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 00000000004ebd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c0a0
R13: 00007fffd3a7039f R14: 00007fffd3a70540 R15: 00007f1d42ba6300
INFO: task syz-executor:10690 blocked for more than 143 seconds.
      Not tainted 5.14.0 #25
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:27456 pid:10690 ppid:  9037 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4695 [inline]
 __schedule+0x974/0x2510 kernel/sched/core.c:6026
 schedule+0xd3/0x270 kernel/sched/core.c:6105
 io_schedule+0x17/0x70 kernel/sched/core.c:8076
 bit_wait_io+0x12/0xd0 kernel/sched/wait_bit.c:209
 __wait_on_bit+0x60/0x190 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xd5/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:101 [inline]
 __wait_on_buffer fs/buffer.c:122 [inline]
 wait_on_buffer include/linux/buffer_head.h:356 [inline]
 __block_write_begin_int+0x944/0x1f00 fs/buffer.c:2044
 __block_write_begin fs/buffer.c:2056 [inline]
 block_write_begin+0x58/0x2e0 fs/buffer.c:2116
 generic_perform_write+0x1fe/0x510 mm/filemap.c:3656
 __generic_file_write_iter+0x24e/0x610 mm/filemap.c:3783
 blkdev_write_iter+0x2a3/0x560 fs/block_dev.c:1645
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write+0x42f/0x660 fs/read_write.c:518
 vfs_write+0x67a/0xa50 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
RSP: 002b:00007f1d42b85198 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000059c158 RCX: 00000000004739cd
RDX: 0000000000000078 RSI: 00000000200000c0 RDI: 0000000000000006
RBP: 00000000004ebd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c158
R13: 00007fffd3a7039f R14: 00007fffd3a70540 R15: 00007f1d42b85300
INFO: task syz-executor:10693 blocked for more than 143 seconds.
      Not tainted 5.14.0 #25
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:28400 pid:10693 ppid:  9037 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4695 [inline]
 __schedule+0x974/0x2510 kernel/sched/core.c:6026
 schedule+0xd3/0x270 kernel/sched/core.c:6105
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6164
 __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
 __mutex_lock+0x92e/0x1390 kernel/locking/mutex.c:1104
 blkdev_get_by_dev fs/block_dev.c:1410 [inline]
 blkdev_get_by_dev+0x457/0xb80 fs/block_dev.c:1383
 blkdev_open+0x154/0x2b0 fs/block_dev.c:1512
 do_dentry_open+0x4c8/0x11d0 fs/open.c:826
 do_open fs/namei.c:3374 [inline]
 path_openat+0x1bf9/0x27a0 fs/namei.c:3507
 do_filp_open+0x1c1/0x290 fs/namei.c:3534
 do_sys_openat2+0x61b/0x8f0 fs/open.c:1204
 do_sys_open+0xc3/0x140 fs/open.c:1220
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x41a334
RSP: 002b:00007f1d42b63cc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 000000000041a334
RDX: 0000000000000000 RSI: 00007f1d42b63d60 RDI: 00000000ffffff9c
RBP: 00007f1d42b63d60 R08: 0000000000000000 R09: 002364626e2f7665
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007fffd3a7039f R14: 00007fffd3a70540 R15: 00007f1d42b64300
INFO: task systemd-udevd:10692 blocked for more than 143 seconds.
      Not tainted 5.14.0 #25
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-udevd   state:D stack:27640 pid:10692 ppid:  4542 flags:0x00004220
Call Trace:
 context_switch kernel/sched/core.c:4695 [inline]
 __schedule+0x974/0x2510 kernel/sched/core.c:6026
 schedule+0xd3/0x270 kernel/sched/core.c:6105
 io_schedule+0x17/0x70 kernel/sched/core.c:8076
 wait_on_page_bit_common+0x57c/0xf10 mm/filemap.c:1301
 wait_on_page_bit mm/filemap.c:1362 [inline]
 wait_on_page_locked include/linux/pagemap.h:689 [inline]
 do_read_cache_page+0x26d/0x1440 mm/filemap.c:3394
 read_mapping_page include/linux/pagemap.h:515 [inline]
 read_part_sector+0x146/0x670 block/partitions/core.c:726
 adfspart_check_ICS+0x9d/0xc90 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:147 [inline]
 blk_add_partitions block/partitions/core.c:611 [inline]
 bdev_disk_changed block/partitions/core.c:697 [inline]
 bdev_disk_changed+0x753/0x1130 block/partitions/core.c:664
 blkdev_get_whole+0x216/0x3f0 fs/block_dev.c:1269
 blkdev_get_by_dev fs/block_dev.c:1417 [inline]
 blkdev_get_by_dev+0x4c0/0xb80 fs/block_dev.c:1383
 blkdev_open+0x154/0x2b0 fs/block_dev.c:1512
 do_dentry_open+0x4c8/0x11d0 fs/open.c:826
 do_open fs/namei.c:3374 [inline]
 path_openat+0x1bf9/0x27a0 fs/namei.c:3507
 do_filp_open+0x1c1/0x290 fs/namei.c:3534
 do_sys_openat2+0x61b/0x8f0 fs/open.c:1204
 do_sys_open+0xc3/0x140 fs/open.c:1220
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5595f12840
RSP: 002b:00007ffd28c6bbb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 000055f37228aa00 RCX: 00007f5595f12840
RDX: 000055f371560fe3 RSI: 00000000000a0800 RDI: 000055f372286c80
RBP: 00007ffd28c6bd30 R08: 000055f371560670 R09: 0000000000000010
R10: 000055f371560d0c R11: 0000000000000246 R12: 00007ffd28c6bc80
R13: 000055f3722878f0 R14: 0000000000000003 R15: 000000000000000e
Showing all locks held in the system:
1 lock held by khungtaskd/1630:
 #0: ffffffff8b979b80 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6446
1 lock held by in:imklog/7561:
 #0: ffff888101e1dc70 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0xe9/0x100 fs/file.c:974
2 locks held by agetty/7569:
 #0: ffff888108bbf098 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffffc900002a42e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x8db/0x1250 drivers/tty/n_tty.c:2113
1 lock held by syz-executor/10684:
 #0: ffff888100c14d18 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_put+0x98/0x720 fs/block_dev.c:1534
1 lock held by syz-executor/10693:
 #0: ffff888100c14d18 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev fs/block_dev.c:1410 [inline]
 #0: ffff888100c14d18 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev+0x457/0xb80 fs/block_dev.c:1383
1 lock held by systemd-udevd/10692:
 #0: ffff888100c14d18 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev fs/block_dev.c:1410 [inline]
 #0: ffff888100c14d18 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev+0x457/0xb80 fs/block_dev.c:1383
1 lock held by syz-executor/11137:
 #0: ffff888100c14d18 (&disk->open_mutex){+.+.}-{3:3}, at:
iterate_bdevs+0xe0/0x2d0 fs/block_dev.c:1869
1 lock held by syz-executor/11425:
 #0: ffff888100c14d18 (&disk->open_mutex){+.+.}-{3:3}, at:
iterate_bdevs+0xe0/0x2d0 fs/block_dev.c:1869
1 lock held by syz-executor/11428:
 #0: ffff888100c14d18 (&disk->open_mutex){+.+.}-{3:3}, at:
iterate_bdevs+0xe0/0x2d0 fs/block_dev.c:1869
1 lock held by syz-executor/11843:
 #0: ffff888100c14d18 (&disk->open_mutex){+.+.}-{3:3}, at:
iterate_bdevs+0xe0/0x2d0 fs/block_dev.c:1869
1 lock held by syz-executor/12538:
 #0: ffff888100c14d18 (&disk->open_mutex){+.+.}-{3:3}, at:
iterate_bdevs+0xe0/0x2d0 fs/block_dev.c:1869
1 lock held by syz-executor/12540:
 #0: ffff888100c14d18 (&disk->open_mutex){+.+.}-{3:3}, at:
iterate_bdevs+0xe0/0x2d0 fs/block_dev.c:1869
