Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC8D1E676
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 03:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfEOBDJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 21:03:09 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62631 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfEOBDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 21:03:09 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4F12b8Q009254;
        Wed, 15 May 2019 10:02:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Wed, 15 May 2019 10:02:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4F12buh009250;
        Wed, 15 May 2019 10:02:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x4F12b6o009249;
        Wed, 15 May 2019 10:02:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201905150102.x4F12b6o009249@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: INFO: task hung in =?ISO-2022-JP?B?X19nZXRfc3VwZXI=?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
MIME-Version: 1.0
Date:   Wed, 15 May 2019 10:02:37 +0900
References: <0000000000002cd22305879b22c4@google.com> 
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since lo_ioctl() is calling sb_set_blocksize() immediately after udf_load_vrs()
called sb_set_blocksize(), udf_tread() can't use expected i_blkbits settings...

[   48.685672][ T7322] fs/block_dev.c:135 bdev=0000000014fa0ec2 12 -> 9
[   48.694675][ T7322] CPU: 4 PID: 7322 Comm: a.out Not tainted 5.1.0+ #196
[   48.701321][ T7322] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[   48.710265][ T7322] Call Trace:
[   48.710272][ T7322]  dump_stack+0xaa/0xd8
[   48.715633][ T7322]  set_blocksize+0xff/0x140
[   48.822094][ T7322]  sb_set_blocksize+0x27/0x70
[   48.824843][ T7322]  udf_load_vrs+0x4b/0x500
[   48.827322][ T7322]  udf_fill_super+0x32e/0x890
[   48.830125][ T7322]  ? snprintf+0x66/0x90
[   48.832572][ T7322]  mount_bdev+0x1c7/0x210
[   48.835293][ T7322]  ? udf_load_vrs+0x500/0x500
[   48.838009][ T7322]  udf_mount+0x34/0x40
[   48.840504][ T7322]  legacy_get_tree+0x2d/0x80
[   48.843192][ T7322]  vfs_get_tree+0x30/0x140
[   48.845787][ T7322]  do_mount+0x830/0xc30
[   48.848325][ T7322]  ? copy_mount_options+0x152/0x1c0
[   48.851066][ T7322]  ksys_mount+0xab/0x120
[   48.853627][ T7322]  __x64_sys_mount+0x26/0x30
[   48.856168][ T7322]  do_syscall_64+0x7c/0x1a0
[   48.858943][ T7322]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[   48.978376][ T7332] fs/block_dev.c:135 bdev=0000000014fa0ec2 9 -> 12
[   49.079394][ T7332] CPU: 6 PID: 7332 Comm: a.out Not tainted 5.1.0+ #196
[   49.082769][ T7332] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[   49.089007][ T7332] Call Trace:
[   49.091410][ T7332]  dump_stack+0xaa/0xd8
[   49.094053][ T7332]  set_blocksize+0xff/0x140
[   49.096734][ T7332]  lo_ioctl+0x570/0xc60
[   49.099366][ T7332]  ? loop_queue_work+0xdb0/0xdb0
[   49.102079][ T7332]  blkdev_ioctl+0xb69/0xc10
[   49.104667][ T7332]  block_ioctl+0x56/0x70
[   49.107267][ T7332]  ? blkdev_fallocate+0x230/0x230
[   49.110035][ T7332]  do_vfs_ioctl+0xc1/0x7e0
[   49.112728][ T7332]  ? tomoyo_file_ioctl+0x23/0x30
[   49.115452][ T7332]  ksys_ioctl+0x94/0xb0
[   49.118008][ T7332]  __x64_sys_ioctl+0x1e/0x30
[   49.120686][ T7332]  do_syscall_64+0x7c/0x1a0
[   49.123470][ T7332]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[   49.163269][ T7322] UDF-fs: error (device loop2): udf_read_tagged: read failed, block=256, location=256
[   51.009494][ T7322] grow_dev_page: 5 callbacks suppressed
[   51.009509][ T7322] fs/buffer.c:960 bdev=0000000014fa0ec2 block=32 inode->i_blkbits=12 index=4 size=512
[   51.016583][ T7322] fs/buffer.c:967 bdev=0000000014fa0ec2 block=32 index=4 size=512 bh->b_size=512

[   55.046361][ T7322] grow_dev_page: 1177059 callbacks suppressed
[   55.046366][ T7322] fs/buffer.c:960 bdev=0000000014fa0ec2 block=32 inode->i_blkbits=12 index=4 size=512
[   55.054903][ T7322] grow_dev_page: 1177037 callbacks suppressed
[   55.054906][ T7322] fs/buffer.c:967 bdev=0000000014fa0ec2 block=32 index=4 size=512 bh->b_size=512
[   56.055187][ T7322] grow_dev_page: 1279065 callbacks suppressed
[   56.055191][ T7322] fs/buffer.c:960 bdev=0000000014fa0ec2 block=32 inode->i_blkbits=12 index=4 size=512
[   56.064443][ T7322] grow_dev_page: 1279065 callbacks suppressed
[   56.064446][ T7322] fs/buffer.c:967 bdev=0000000014fa0ec2 block=32 index=4 size=512 bh->b_size=512

[   92.282798][ T1097] INFO: task a.out:7322 can't die for more than 30 seconds.
[   92.285926][ T1097] a.out           R  running task        0  7322      1 0x80004004
[   92.289143][ T1097] Call Trace:
[   92.291175][ T1097]  __schedule+0x2eb/0x600
[   92.293354][ T1097]  ? apic_timer_interrupt+0xa/0x20
[   92.295802][ T1097]  ? xas_load+0x13/0xd0
[   92.298079][ T1097]  ? __switch_to_asm+0x40/0x70
[   92.300466][ T1097]  ? __switch_to_asm+0x34/0x70
[   92.302890][ T1097]  ? __switch_to_asm+0x40/0x70
[   92.305299][ T1097]  ? __switch_to_asm+0x34/0x70
[   92.307621][ T1097]  ? __switch_to_asm+0x40/0x70
[   92.309908][ T1097]  ? __switch_to_asm+0x34/0x70
[   92.312161][ T1097]  ? debug_smp_processor_id+0x2b/0x130
[   92.314532][ T1097]  ? xas_start+0xa7/0x110
[   92.317139][ T1097]  ? xas_load+0x3d/0xd0
[   92.319674][ T1097]  ? xas_start+0xa7/0x110
[   92.321746][ T1097]  ? xas_load+0x3d/0xd0
[   92.323831][ T1097]  ? find_get_entry+0x172/0x220
[   92.326115][ T1097]  ? __this_cpu_preempt_check+0x37/0x120
[   92.328714][ T1097]  ? __find_get_block+0x485/0x610
[   92.331096][ T1097]  ? _raw_spin_trylock+0x12/0x50
[   92.333402][ T1097]  ? __getblk_gfp+0xd9/0x4a0
[   92.335617][ T1097]  ? __bread_gfp+0x2d/0x130
[   92.338410][ T1097]  ? udf_tread+0x48/0x70
[   92.341144][ T1097]  ? udf_read_tagged+0x40/0x1a0
[   92.343537][ T1097]  ? udf_check_anchor_block+0x94/0x190
[   92.346054][ T1097]  ? udf_scan_anchors+0x12b/0x250
[   92.348480][ T1097]  ? udf_load_vrs+0x2b7/0x500
[   92.350732][ T1097]  ? udf_fill_super+0x32e/0x890
[   92.353172][ T1097]  ? snprintf+0x66/0x90
[   92.355256][ T1097]  ? mount_bdev+0x1c7/0x210
[   92.358214][ T1097]  ? udf_load_vrs+0x500/0x500
[   92.361251][ T1097]  ? udf_mount+0x34/0x40
[   92.363661][ T1097]  ? legacy_get_tree+0x2d/0x80
[   92.366298][ T1097]  ? vfs_get_tree+0x30/0x140
[   92.368955][ T1097]  ? do_mount+0x830/0xc30
[   92.371468][ T1097]  ? copy_mount_options+0x152/0x1c0
[   92.374098][ T1097]  ? ksys_mount+0xab/0x120
[   92.376605][ T1097]  ? __x64_sys_mount+0x26/0x30
[   92.379553][ T1097]  ? do_syscall_64+0x7c/0x1a0
[   92.381615][ T1097]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   92.383942][ T1097] INFO: task a.out:7332 can't die for more than 30 seconds.
[   92.387037][ T1097] a.out           D    0  7332      1 0x00004004
[   92.389621][ T1097] Call Trace:
[   92.391297][ T1097]  __schedule+0x2e3/0x600
[   92.393313][ T1097]  ? __switch_to_asm+0x40/0x70
[   92.395486][ T1097]  schedule+0x32/0xc0
[   92.404871][ T1097]  rwsem_down_read_failed+0xf0/0x1a0
[   92.407605][ T1097]  down_read+0x2f/0x40
[   92.417196][ T1097]  ? down_read+0x2f/0x40
[   92.419579][ T1097]  __get_super.part.12+0x113/0x140
[   92.422165][ T1097]  get_super+0x2d/0x40
[   92.424559][ T1097]  fsync_bdev+0x19/0x80
[   92.427012][ T1097]  invalidate_partition+0x35/0x60
[   92.429588][ T1097]  rescan_partitions+0x53/0x4b0
[   92.432137][ T1097]  __blkdev_reread_part+0x6a/0xa0
[   92.434856][ T1097]  blkdev_reread_part+0x24/0x40
[   92.438203][ T1097]  loop_reread_partitions+0x1e/0x60
[   92.440909][ T1097]  loop_set_status+0x4fa/0x5a0
[   92.443427][ T1097]  loop_set_status64+0x55/0x90
[   92.445962][ T1097]  lo_ioctl+0x651/0xc60
[   92.448427][ T1097]  ? loop_queue_work+0xdb0/0xdb0
[   92.451260][ T1097]  blkdev_ioctl+0xb69/0xc10
[   92.453771][ T1097]  block_ioctl+0x56/0x70
[   92.456284][ T1097]  ? blkdev_fallocate+0x230/0x230
[   92.458957][ T1097]  do_vfs_ioctl+0xc1/0x7e0
[   92.461639][ T1097]  ? tomoyo_file_ioctl+0x23/0x30
[   92.464071][ T1097]  ksys_ioctl+0x94/0xb0
[   92.466394][ T1097]  __x64_sys_ioctl+0x1e/0x30
[   92.468879][ T1097]  do_syscall_64+0x7c/0x1a0
[   92.471339][ T1097]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
