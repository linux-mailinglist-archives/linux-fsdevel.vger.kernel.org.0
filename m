Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 971D11C1BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 07:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfENFQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 01:16:20 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50185 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfENFQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 01:16:19 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4E5Ffwl049322;
        Tue, 14 May 2019 14:15:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Tue, 14 May 2019 14:15:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4E5FfVH049312;
        Tue, 14 May 2019 14:15:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x4E5Ff7q049310;
        Tue, 14 May 2019 14:15:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201905140515.x4E5Ff7q049310@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: INFO: task hung in =?ISO-2022-JP?B?X19nZXRfc3VwZXI=?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
MIME-Version: 1.0
Date:   Tue, 14 May 2019 14:15:41 +0900
References: <001a113ed5540f411c0568cc8418@google.com> <0000000000002cd22305879b22c4@google.com>
In-Reply-To: <0000000000002cd22305879b22c4@google.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Jan.

syzbot is still reporting livelocks inside __getblk_gfp() [1] (similar to
commit 04906b2f542c2362 ("blockdev: Fix livelocks on loop device")).

  [1] https://syzkaller.appspot.com/bug?id=835a0b9e75b14b55112661cbc61ca8b8f0edf767

A debug printk() patch shown below revealed that since bdev->bd_inode->i_blkbits
is unexpectedly modified, __find_get_block_slow() is failing to find buffer pages
created by grow_dev_page(). I guess that opening a loop device (while somebody is
doing mount operation on that loop device) can trigger set_init_blocksize() from
__blkdev_get().

----------------------------------------
diff --git a/fs/buffer.c b/fs/buffer.c
index 0faa41fb4c88..8e197c771476 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -190,7 +190,7 @@ EXPORT_SYMBOL(end_buffer_write_sync);
  * succeeds, there is no need to take private_lock.
  */
 static struct buffer_head *
-__find_get_block_slow(struct block_device *bdev, sector_t block)
+__find_get_block_slow(struct block_device *bdev, sector_t block, unsigned size)
 {
 	struct inode *bd_inode = bdev->bd_inode;
 	struct address_space *bd_mapping = bd_inode->i_mapping;
@@ -204,12 +204,20 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 
 	index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
 	page = find_get_page_flags(bd_mapping, index, FGP_ACCESSED);
-	if (!page)
+	if (!page) {
+		if (fatal_signal_pending(current) && __ratelimit(&last_warned))
+			printk("%s:%u block=%llu bd_inode->i_blkbits=%u index=%lu size=%u\n",
+			       __FILE__, __LINE__, block, bd_inode->i_blkbits, index, size);
 		goto out;
+	}
 
 	spin_lock(&bd_mapping->private_lock);
-	if (!page_has_buffers(page))
+	if (!page_has_buffers(page)) {
+		if (fatal_signal_pending(current) && __ratelimit(&last_warned))
+			printk("%s:%u block=%llu bd_inode->i_blkbits=%u index=%lu size=%u page=%p\n",
+			       __FILE__, __LINE__, block, bd_inode->i_blkbits, index, size, page);
 		goto out_unlock;
+	}
 	head = page_buffers(page);
 	bh = head;
 	do {
@@ -934,6 +942,8 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	sector_t end_block;
 	int ret = 0;		/* Will call free_more_memory() */
 	gfp_t gfp_mask;
+	static DEFINE_RATELIMIT_STATE(last_warned1, HZ, 1);
+	static DEFINE_RATELIMIT_STATE(last_warned2, HZ, 1);
 
 	gfp_mask = mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS) | gfp;
 
@@ -946,11 +956,15 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	gfp_mask |= __GFP_NOFAIL;
 
 	page = find_or_create_page(inode->i_mapping, index, gfp_mask);
+	if (fatal_signal_pending(current) && __ratelimit(&last_warned1))
+		printk("%s:%u block=%llu inode->i_blkbits=%u index=%lu size=%u\n", __FILE__, __LINE__, block, inode->i_blkbits, index, size);
 
 	BUG_ON(!PageLocked(page));
 
 	if (page_has_buffers(page)) {
 		bh = page_buffers(page);
+		if (fatal_signal_pending(current) && __ratelimit(&last_warned2))
+			printk("%s:%u block=%llu index=%lu size=%u bh->b_size=%lu\n", __FILE__, __LINE__, block, index, size, bh->b_size);
 		if (bh->b_size == size) {
 			end_block = init_page_buffers(page, bdev,
 						(sector_t)index << sizebits,
@@ -1292,7 +1306,7 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
 
 	if (bh == NULL) {
 		/* __find_get_block_slow will mark the page accessed */
-		bh = __find_get_block_slow(bdev, block);
+		bh = __find_get_block_slow(bdev, block, size);
 		if (bh)
 			bh_lru_install(bh);
 	} else
----------------------------------------

----------------------------------------
[   89.805981][ T7388] __find_get_block_slow: 1278192 callbacks suppressed
[   89.805987][ T7388] fs/buffer.c:218 block=1 bd_inode->i_blkbits=12 index=1 size=512 page=00000000cd89a24d
[   90.716164][ T7388] grow_dev_page: 1295496 callbacks suppressed
[   90.716167][ T7388] fs/buffer.c:960 block=1 inode->i_blkbits=12 index=0 size=512
[   90.735989][ T7388] grow_dev_page: 1296140 callbacks suppressed
[   90.735991][ T7388] fs/buffer.c:967 block=1 index=0 size=512 bh->b_size=512
[   90.815859][ T7388] __find_get_block_slow: 1312165 callbacks suppressed
[   90.815862][ T7388] fs/buffer.c:218 block=1 bd_inode->i_blkbits=12 index=1 size=512 page=00000000cd89a24d
[   91.726006][ T7388] grow_dev_page: 1306138 callbacks suppressed
[   91.726022][ T7388] fs/buffer.c:960 block=1 inode->i_blkbits=12 index=0 size=512
[   91.745856][ T7388] grow_dev_page: 1305423 callbacks suppressed
[   91.745859][ T7388] fs/buffer.c:967 block=1 index=0 size=512 bh->b_size=512
[   91.825701][ T7388] __find_get_block_slow: 1305252 callbacks suppressed
[   91.825719][ T7388] fs/buffer.c:218 block=1 bd_inode->i_blkbits=12 index=1 size=512 page=00000000cd89a24d
[   92.247976][ T1094] INFO: task a.out:7388 can't die for more than 60 seconds.
[   92.251681][ T1094] a.out           R  running task        0  7388      1 0x80004004
[   92.255528][ T1094] Call Trace:
[   92.258142][ T1094]  __schedule+0x2eb/0x600
[   92.260950][ T1094]  ? xas_start+0xa7/0x110
[   92.263748][ T1094]  ? xas_load+0x3d/0xd0
[   92.266548][ T1094]  ? xas_start+0xa7/0x110
[   92.269598][ T1094]  ? xas_load+0x3d/0xd0
[   92.272499][ T1094]  ? __find_get_block+0xa6/0x610
[   92.275293][ T1094]  ? _raw_spin_trylock+0x12/0x50
[   92.278173][ T1094]  ? ___ratelimit+0x28/0x1a0
[   92.280865][ T1094]  ? __getblk_gfp+0x307/0x490
[   92.283687][ T1094]  ? __bread_gfp+0x2d/0x130
[   92.286857][ T1094]  ? udf_tread+0x48/0x70
[   92.289344][ T1094]  ? udf_read_tagged+0x40/0x1a0
[   92.292008][ T1094]  ? udf_check_anchor_block+0x94/0x190
[   92.294766][ T1094]  ? udf_scan_anchors+0x12b/0x250
[   92.297524][ T1094]  ? udf_load_vrs+0x2b7/0x500
[   92.300086][ T1094]  ? udf_fill_super+0x32e/0x890
[   92.302667][ T1094]  ? snprintf+0x66/0x90
[   92.305029][ T1094]  ? mount_bdev+0x1c7/0x210
[   92.307570][ T1094]  ? udf_load_vrs+0x500/0x500
[   92.309999][ T1094]  ? udf_mount+0x34/0x40
[   92.312295][ T1094]  ? legacy_get_tree+0x2d/0x80
[   92.314673][ T1094]  ? vfs_get_tree+0x30/0x140
[   92.317041][ T1094]  ? do_mount+0x830/0xc30
[   92.319463][ T1094]  ? copy_mount_options+0x152/0x1c0
[   92.321987][ T1094]  ? ksys_mount+0xab/0x120
[   92.324226][ T1094]  ? __x64_sys_mount+0x26/0x30
[   92.326956][ T1094]  ? do_syscall_64+0x7c/0x1a0
[   92.329278][ T1094]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   92.331880][ T1094] INFO: task a.out:7400 can't die for more than 60 seconds.
[   92.334877][ T1094] a.out           D    0  7400      1 0x00004004
[   92.337732][ T1094] Call Trace:
[   92.339595][ T1094]  __schedule+0x2e3/0x600
[   92.341668][ T1094]  schedule+0x32/0xc0
[   92.343578][ T1094]  rwsem_down_read_failed+0xf0/0x1a0
[   92.346142][ T1094]  down_read+0x2f/0x40
[   92.348047][ T1094]  ? down_read+0x2f/0x40
[   92.351045][ T1094]  __get_super.part.12+0x113/0x140
[   92.353673][ T1094]  get_super+0x2d/0x40
[   92.355705][ T1094]  fsync_bdev+0x19/0x80
[   92.357634][ T1094]  invalidate_partition+0x35/0x60
[   92.359829][ T1094]  rescan_partitions+0x53/0x4b0
[   92.361983][ T1094]  __blkdev_reread_part+0x6a/0xa0
[   92.364185][ T1094]  blkdev_reread_part+0x24/0x40
[   92.366804][ T1094]  loop_reread_partitions+0x1e/0x60
[   92.369377][ T1094]  loop_set_status+0x4fa/0x5a0
[   92.371571][ T1094]  loop_set_status64+0x55/0x90
[   92.373722][ T1094]  lo_ioctl+0x651/0xc60
[   92.375750][ T1094]  ? loop_queue_work+0xdb0/0xdb0
[   92.377951][ T1094]  blkdev_ioctl+0xb69/0xc10
[   92.380030][ T1094]  block_ioctl+0x56/0x70
[   92.381994][ T1094]  ? blkdev_fallocate+0x230/0x230
[   92.384240][ T1094]  do_vfs_ioctl+0xc1/0x7e0
[   92.386495][ T1094]  ? tomoyo_file_ioctl+0x23/0x30
[   92.388886][ T1094]  ksys_ioctl+0x94/0xb0
[   92.390889][ T1094]  __x64_sys_ioctl+0x1e/0x30
[   92.392963][ T1094]  do_syscall_64+0x7c/0x1a0
[   92.395057][ T1094]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   92.397695][ T1094] RIP: 0033:0x7fc3dd4195d7
[   92.399728][ T1094] Code: Bad RIP value.
[   92.401773][ T1094] RSP: 002b:00007ffd221788b8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[   92.405194][ T1094] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fc3dd4195d7
[   92.409004][ T1094] RDX: 00007ffd22178970 RSI: 0000000000004c04 RDI: 0000000000000004
[   92.412289][ T1094] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   92.415315][ T1094] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fc3dd90e480
[   92.418396][ T1094] R13: 00007ffd22178a60 R14: 00007ffd22178970 R15: 00007ffd22178b70
[   92.421509][ T1094] INFO: task a.out:7400 blocked for more than 60 seconds.
[   92.424267][ T1094]       Not tainted 5.1.0+ #193
[   92.426533][ T1094] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   92.429861][ T1094] a.out           D    0  7400      1 0x00004004
[   92.432589][ T1094] Call Trace:
[   92.434377][ T1094]  __schedule+0x2e3/0x600
[   92.436637][ T1094]  schedule+0x32/0xc0
[   92.438625][ T1094]  rwsem_down_read_failed+0xf0/0x1a0
[   92.441090][ T1094]  down_read+0x2f/0x40
[   92.443124][ T1094]  ? down_read+0x2f/0x40
[   92.445145][ T1094]  __get_super.part.12+0x113/0x140
[   92.447907][ T1094]  get_super+0x2d/0x40
[   92.449997][ T1094]  fsync_bdev+0x19/0x80
[   92.452049][ T1094]  invalidate_partition+0x35/0x60
[   92.454394][ T1094]  rescan_partitions+0x53/0x4b0
[   92.456792][ T1094]  __blkdev_reread_part+0x6a/0xa0
[   92.459063][ T1094]  blkdev_reread_part+0x24/0x40
[   92.461303][ T1094]  loop_reread_partitions+0x1e/0x60
[   92.463630][ T1094]  loop_set_status+0x4fa/0x5a0
[   92.465990][ T1094]  loop_set_status64+0x55/0x90
[   92.468377][ T1094]  lo_ioctl+0x651/0xc60
[   92.470605][ T1094]  ? loop_queue_work+0xdb0/0xdb0
[   92.472968][ T1094]  blkdev_ioctl+0xb69/0xc10
[   92.475107][ T1094]  block_ioctl+0x56/0x70
[   92.477221][ T1094]  ? blkdev_fallocate+0x230/0x230
[   92.479441][ T1094]  do_vfs_ioctl+0xc1/0x7e0
[   92.481720][ T1094]  ? tomoyo_file_ioctl+0x23/0x30
[   92.483973][ T1094]  ksys_ioctl+0x94/0xb0
[   92.486686][ T1094]  __x64_sys_ioctl+0x1e/0x30
[   92.489081][ T1094]  do_syscall_64+0x7c/0x1a0
[   92.491202][ T1094]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   92.493565][ T1094] RIP: 0033:0x7fc3dd4195d7
[   92.495690][ T1094] Code: Bad RIP value.
[   92.497609][ T1094] RSP: 002b:00007ffd221788b8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[   92.500723][ T1094] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fc3dd4195d7
[   92.503822][ T1094] RDX: 00007ffd22178970 RSI: 0000000000004c04 RDI: 0000000000000004
[   92.506967][ T1094] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[   92.510022][ T1094] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fc3dd90e480
[   92.512985][ T1094] R13: 00007ffd22178a60 R14: 00007ffd22178970 R15: 00007ffd22178b70
[   92.516039][ T1094] INFO: task probe-bcache:7402 blocked for more than 60 seconds.
[   92.519171][ T1094]       Not tainted 5.1.0+ #193
[   92.521295][ T1094] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   92.524469][ T1094] probe-bcache    D    0  7402   7305 0x80000122
[   92.527614][ T1094] Call Trace:
[   92.529505][ T1094]  __schedule+0x2e3/0x600
[   92.531494][ T1094]  schedule+0x32/0xc0
[   92.533473][ T1094]  schedule_preempt_disabled+0x13/0x20
[   92.536036][ T1094]  __mutex_lock.isra.8+0x16b/0x500
[   92.538407][ T1094]  __mutex_lock_slowpath+0xe/0x10
[   92.540665][ T1094]  ? __mutex_lock_slowpath+0xe/0x10
[   92.542944][ T1094]  mutex_lock+0x1d/0x20
[   92.544945][ T1094]  blkdev_put+0x22/0x190
[   92.547434][ T1094]  ? blkdev_put+0x190/0x190
[   92.549519][ T1094]  blkdev_close+0x26/0x30
[   92.551667][ T1094]  __fput+0xe9/0x300
[   92.553711][ T1094]  ____fput+0x15/0x20
[   92.555690][ T1094]  task_work_run+0xa9/0xd0
[   92.557821][ T1094]  do_exit+0x37a/0xf40
[   92.559723][ T1094]  ? __secure_computing+0x72/0x150
[   92.562039][ T1094]  ? syscall_trace_enter+0x10a/0x3b0
[   92.564355][ T1094]  do_group_exit+0x57/0xe0
[   92.566780][ T1094]  __x64_sys_exit_group+0x1c/0x20
[   92.569307][ T1094]  do_syscall_64+0x7c/0x1a0
[   92.571461][ T1094]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   92.573874][ T1094] RIP: 0033:0x7f197f9e6e06
[   92.576039][ T1094] Code: Bad RIP value.
[   92.578264][ T1094] RSP: 002b:00007ffcfbcfce58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   92.581582][ T1094] RAX: ffffffffffffffda RBX: 00007f197fce9740 RCX: 00007f197f9e6e06
[   92.584878][ T1094] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[   92.588253][ T1094] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff30
[   92.591427][ T1094] R10: 0000000000000004 R11: 0000000000000246 R12: 00007f197fce9740
[   92.594646][ T1094] R13: 0000000000000001 R14: 00007f197fcf2628 R15: 0000000000000000
----------------------------------------

----------------------------------------
[  120.248453][ T7298] fs/buffer.c:960 block=7 inode->i_blkbits=12 index=3 size=2048
[  120.318363][ T7298] grow_dev_page: 1514869 callbacks suppressed
[  120.318365][ T7298] fs/buffer.c:967 block=7 index=3 size=2048 bh->b_size=2048
[  120.328408][ T7298] __find_get_block_slow: 1515516 callbacks suppressed
[  120.328410][ T7298] fs/buffer.c:210 block=7 bd_inode->i_blkbits=12 index=7 size=2048
[  121.258324][ T7298] grow_dev_page: 1514197 callbacks suppressed
[  121.258327][ T7298] fs/buffer.c:960 block=7 inode->i_blkbits=12 index=3 size=2048
[  121.328271][ T7298] grow_dev_page: 1508348 callbacks suppressed
[  121.328273][ T7298] fs/buffer.c:967 block=7 index=3 size=2048 bh->b_size=2048
[  121.338232][ T7298] __find_get_block_slow: 1507633 callbacks suppressed
[  121.338234][ T7298] fs/buffer.c:210 block=7 bd_inode->i_blkbits=12 index=7 size=2048
[  122.268187][ T7298] grow_dev_page: 1469440 callbacks suppressed
[  122.268190][ T7298] fs/buffer.c:960 block=7 inode->i_blkbits=12 index=3 size=2048
[  122.268307][ T1095] INFO: task a.out:7298 can't die for more than 30 seconds.
[  122.277909][ T1095] a.out           R  running task        0  7298      1 0x80004004
[  122.281569][ T1095] Call Trace:
[  122.283953][ T1095]  ? xas_start+0xa7/0x110
[  122.286658][ T1095]  ? xas_load+0x3d/0xd0
[  122.289248][ T1095]  ? xas_start+0xa7/0x110
[  122.291690][ T1095]  ? xas_load+0x3d/0xd0
[  122.294112][ T1095]  ? find_get_entry+0x172/0x220
[  122.296911][ T1095]  ? preempt_count_add+0x80/0xc0
[  122.299633][ T1095]  ? __getblk_gfp+0x439/0x490
[  122.302126][ T1095]  ? __bread_gfp+0x2d/0x130
[  122.305032][ T1095]  ? udf_tread+0x48/0x70
[  122.308252][ T1095]  ? udf_read_tagged+0x40/0x1a0
[  122.311864][ T1095]  ? udf_check_anchor_block+0x94/0x190
[  122.315502][ T1095]  ? udf_scan_anchors+0x12b/0x250
[  122.318995][ T1095]  ? udf_load_vrs+0x2b7/0x500
[  122.322278][ T1095]  ? udf_fill_super+0x32e/0x890
[  122.325533][ T1095]  ? snprintf+0x66/0x90
[  122.328862][ T1095]  ? mount_bdev+0x1c7/0x210
[  122.332195][ T1095]  ? udf_load_vrs+0x500/0x500
[  122.334499][ T1095]  ? udf_mount+0x34/0x40
[  122.336594][ T1095]  ? legacy_get_tree+0x2d/0x80
[  122.338071][ T7298] grow_dev_page: 1454158 callbacks suppressed
[  122.338074][ T7298] fs/buffer.c:967 block=7 index=3 size=2048 bh->b_size=2048
[  122.338945][ T1095]  ? vfs_get_tree+0x30/0x140
[  122.346797][ T1095]  ? do_mount+0x830/0xc30
[  122.348091][ T7298] __find_get_block_slow: 1459190 callbacks suppressed
[  122.348093][ T7298] fs/buffer.c:210 block=7 bd_inode->i_blkbits=12 index=7 size=2048
[  122.349493][ T1095]  ? copy_mount_options+0x152/0x1c0
[  122.357382][ T1095]  ? ksys_mount+0xab/0x120
[  122.359788][ T1095]  ? __x64_sys_mount+0x26/0x30
[  122.362247][ T1095]  ? do_syscall_64+0x7c/0x1a0
[  122.364517][ T1095]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  122.367426][ T1095] INFO: task systemd-udevd:7302 blocked for more than 30 seconds.
[  122.371445][ T1095]       Not tainted 5.1.0+ #193
[  122.373967][ T1095] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  122.377365][ T1095] systemd-udevd   D    0  7302   5781 0x00000120
[  122.380380][ T1095] Call Trace:
[  122.382268][ T1095]  __schedule+0x2e3/0x600
[  122.384422][ T1095]  schedule+0x32/0xc0
[  122.386491][ T1095]  schedule_preempt_disabled+0x13/0x20
[  122.389047][ T1095]  __mutex_lock.isra.8+0x16b/0x500
[  122.391466][ T1095]  ? get_disk_and_module+0x80/0x80
[  122.393879][ T1095]  __mutex_lock_slowpath+0xe/0x10
[  122.396457][ T1095]  ? __mutex_lock_slowpath+0xe/0x10
[  122.398992][ T1095]  mutex_lock+0x1d/0x20
[  122.401200][ T1095]  __blkdev_get+0x9a/0x720
[  122.403366][ T1095]  blkdev_get+0x18c/0x440
[  122.405591][ T1095]  ? preempt_count_add+0x80/0xc0
[  122.407966][ T1095]  blkdev_open+0xbd/0xf0
[  122.410221][ T1095]  do_dentry_open+0x2b2/0x500
[  122.412756][ T1095]  ? bd_acquire+0x120/0x120
[  122.415044][ T1095]  vfs_open+0x38/0x40
[  122.417109][ T1095]  path_openat+0x3c9/0x1a90
[  122.419546][ T1095]  ? ptep_set_access_flags+0x52/0x70
[  122.422031][ T1095]  do_filp_open+0xb9/0x150
[  122.424222][ T1095]  ? strncpy_from_user+0x19f/0x230
[  122.426670][ T1095]  ? _raw_spin_unlock+0x1f/0x40
[  122.429675][ T1095]  do_sys_open+0x2a2/0x380
[  122.431965][ T1095]  ? do_sys_open+0x2a2/0x380
[  122.434174][ T1095]  __x64_sys_openat+0x24/0x30
[  122.436449][ T1095]  do_syscall_64+0x7c/0x1a0
[  122.438747][ T1095]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  122.441343][ T1095] RIP: 0033:0x7f27aff41c8e
[  122.443511][ T1095] Code: Bad RIP value.
[  122.445632][ T1095] RSP: 002b:00007ffcabf214b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[  122.449006][ T1095] RAX: ffffffffffffffda RBX: 00005639f5178280 RCX: 00007f27aff41c8e
[  122.452025][ T1095] RDX: 0000000000080000 RSI: 00005639f5179310 RDI: 00000000ffffff9c
[  122.455064][ T1095] RBP: 0000000000000001 R08: 00005639f3dba346 R09: 00007f27b021dc40
[  122.458167][ T1095] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  122.461701][ T1095] R13: 0000000000000000 R14: 00005639f517ab50 R15: 00000000ffffffff
[  122.465636][ T1095] INFO: task a.out:7319 can't die for more than 30 seconds.
[  122.469411][ T1095] a.out           D    0  7319      1 0x00004004
[  122.473056][ T1095] Call Trace:
[  122.475416][ T1095]  __schedule+0x2e3/0x600
[  122.478216][ T1095]  ? __switch_to_asm+0x34/0x70
[  122.480823][ T1095]  schedule+0x32/0xc0
[  122.482688][ T1095]  rwsem_down_read_failed+0xf0/0x1a0
[  122.484951][ T1095]  down_read+0x2f/0x40
[  122.486819][ T1095]  ? down_read+0x2f/0x40
[  122.488965][ T1095]  __get_super.part.12+0x113/0x140
[  122.491230][ T1095]  get_super+0x2d/0x40
[  122.493112][ T1095]  fsync_bdev+0x19/0x80
[  122.495157][ T1095]  invalidate_partition+0x35/0x60
[  122.497444][ T1095]  rescan_partitions+0x53/0x4b0
[  122.499634][ T1095]  __blkdev_reread_part+0x6a/0xa0
[  122.501926][ T1095]  blkdev_reread_part+0x24/0x40
[  122.504018][ T1095]  loop_reread_partitions+0x1e/0x60
[  122.506257][ T1095]  loop_set_status+0x4fa/0x5a0
[  122.508836][ T1095]  loop_set_status64+0x55/0x90
[  122.510962][ T1095]  lo_ioctl+0x651/0xc60
[  122.513809][ T1095]  ? loop_queue_work+0xdb0/0xdb0
[  122.516747][ T1095]  blkdev_ioctl+0xb69/0xc10
[  122.519569][ T1095]  block_ioctl+0x56/0x70
[  122.522421][ T1095]  ? blkdev_fallocate+0x230/0x230
[  122.524723][ T1095]  do_vfs_ioctl+0xc1/0x7e0
[  122.526859][ T1095]  ? tomoyo_file_ioctl+0x23/0x30
[  122.529657][ T1095]  ksys_ioctl+0x94/0xb0
[  122.531694][ T1095]  __x64_sys_ioctl+0x1e/0x30
[  122.533872][ T1095]  do_syscall_64+0x7c/0x1a0
[  122.536038][ T1095]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  122.538589][ T1095] RIP: 0033:0x7fe9a73645d7
[  122.540708][ T1095] Code: Bad RIP value.
[  122.542701][ T1095] RSP: 002b:00007ffe29d27c78 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  122.546144][ T1095] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe9a73645d7
[  122.549752][ T1095] RDX: 00007ffe29d27d30 RSI: 0000000000004c04 RDI: 0000000000000004
[  122.552970][ T1095] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[  122.556034][ T1095] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fe9a7859480
[  122.559177][ T1095] R13: 00007ffe29d27e20 R14: 00007ffe29d27d30 R15: 00007ffe29d27f30
[  122.562486][ T1095] INFO: task a.out:7319 blocked for more than 30 seconds.
[  122.565427][ T1095]       Not tainted 5.1.0+ #193
[  122.567733][ T1095] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  122.571274][ T1095] a.out           D    0  7319      1 0x00004004
[  122.573997][ T1095] Call Trace:
[  122.575858][ T1095]  __schedule+0x2e3/0x600
[  122.578070][ T1095]  ? __switch_to_asm+0x34/0x70
[  122.580532][ T1095]  schedule+0x32/0xc0
[  122.582647][ T1095]  rwsem_down_read_failed+0xf0/0x1a0
[  122.585117][ T1095]  down_read+0x2f/0x40
[  122.587168][ T1095]  ? down_read+0x2f/0x40
[  122.589792][ T1095]  __get_super.part.12+0x113/0x140
[  122.592223][ T1095]  get_super+0x2d/0x40
[  122.594273][ T1095]  fsync_bdev+0x19/0x80
[  122.596558][ T1095]  invalidate_partition+0x35/0x60
[  122.598959][ T1095]  rescan_partitions+0x53/0x4b0
[  122.601206][ T1095]  __blkdev_reread_part+0x6a/0xa0
[  122.603587][ T1095]  blkdev_reread_part+0x24/0x40
[  122.605875][ T1095]  loop_reread_partitions+0x1e/0x60
[  122.608326][ T1095]  loop_set_status+0x4fa/0x5a0
[  122.610707][ T1095]  loop_set_status64+0x55/0x90
[  122.613168][ T1095]  lo_ioctl+0x651/0xc60
[  122.615247][ T1095]  ? loop_queue_work+0xdb0/0xdb0
[  122.617606][ T1095]  blkdev_ioctl+0xb69/0xc10
[  122.619987][ T1095]  block_ioctl+0x56/0x70
[  122.622083][ T1095]  ? blkdev_fallocate+0x230/0x230
[  122.624626][ T1095]  do_vfs_ioctl+0xc1/0x7e0
[  122.627152][ T1095]  ? tomoyo_file_ioctl+0x23/0x30
[  122.631102][ T1095]  ksys_ioctl+0x94/0xb0
[  122.634123][ T1095]  __x64_sys_ioctl+0x1e/0x30
[  122.636641][ T1095]  do_syscall_64+0x7c/0x1a0
[  122.638877][ T1095]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  122.641414][ T1095] RIP: 0033:0x7fe9a73645d7
[  122.643578][ T1095] Code: Bad RIP value.
[  122.645736][ T1095] RSP: 002b:00007ffe29d27c78 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  122.649091][ T1095] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe9a73645d7
[  122.652392][ T1095] RDX: 00007ffe29d27d30 RSI: 0000000000004c04 RDI: 0000000000000004
[  122.655581][ T1095] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[  122.658769][ T1095] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fe9a7859480
[  122.662073][ T1095] R13: 00007ffe29d27e20 R14: 00007ffe29d27d30 R15: 00007ffe29d27f30
----------------------------------------
