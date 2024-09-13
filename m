Return-Path: <linux-fsdevel+bounces-29313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFE7978003
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 14:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207391C20803
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B591A1DA0EB;
	Fri, 13 Sep 2024 12:32:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D071D932C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230735; cv=none; b=ujvQtYMryxBEDKm3AzUPDVJMfHGEMB2FRWyzGGGdjimYnYgdScGuvv/iA8nfu9+KwBOJRt6nqqEefPMVA+CsyZErVeWU+M7kJu/9zsOtz5HcaYygjWpptToqctJoMQzPVe8RDbR6v4jUPpHYyWAzKu8ydWX/rd2/zkDFZodZZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230735; c=relaxed/simple;
	bh=h0xbi+/vAy3kRvS4Um9VKuqVny1/xXwMxtOXBC+nQuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhYkvPDlJMdV9nMxguPbUA+nCBybQHx9R3vxL+wAMIWYrc9MOI3U6sc1cub+QC7tKXzBaKqY1waCorFbSh9rqIuQT6HN+m5U40USq4+YdHf/6L9wCecJYYDUwh0qRxUluzX+a1773L0A6kJEt9tDEmt61chW21zUiQPDbXtDrzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.185])
	by sina.com (10.185.250.21) with ESMTP
	id 66E4309200001F09; Fri, 13 Sep 2024 20:31:17 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8419933408527
X-SMAIL-UIID: B1BFFAF4C229440EAA8DC451C765B0BE-20240913-203117-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0930d8a3c3c55e931634@syzkaller.appspotmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in invalidate_bh_lru
Date: Fri, 13 Sep 2024 20:31:04 +0800
Message-Id: <20240913123104.367-1-hdanton@sina.com>
In-Reply-To: <0000000000005c2d960621e89afe@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 12 Sep 2024 02:19:26 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    b31c44928842 Merge tag 'linux_kselftest-kunit-fixes-6.11-r..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12696f29980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=58a85aa6925a8b78
> dashboard link: https://syzkaller.appspot.com/bug?extid=0930d8a3c3c55e931634
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-b31c4492.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c7a83e0168a1/vmlinux-b31c4492.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f991c4e68b58/bzImage-b31c4492.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0930d8a3c3c55e931634@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> BUG: KASAN: slab-use-after-free in __brelse fs/buffer.c:1235 [inline]
> BUG: KASAN: slab-use-after-free in brelse include/linux/buffer_head.h:325 [inline]
> BUG: KASAN: slab-use-after-free in __invalidate_bh_lrus fs/buffer.c:1508 [inline]
> BUG: KASAN: slab-use-after-free in invalidate_bh_lru+0xa8/0x1b0 fs/buffer.c:1521
> Read of size 4 at addr ffff88801c989a58 by task udevd/5114
> 
A worse case than the report looks like

	buff head is freed and reused with bh lru left intact
	flush bh lru
	__brelse()
	if (atomic_read(&bh->b_count)) {
		put_bh(bh);
		return;
	}

and bh->b_count gets corrupted by put_bh().

> CPU: 0 UID: 0 PID: 5114 Comm: udevd Not tainted 6.11.0-rc6-syzkaller-00308-gb31c44928842 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  instrument_atomic_read include/linux/instrumented.h:68 [inline]
>  atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
>  __brelse fs/buffer.c:1235 [inline]
>  brelse include/linux/buffer_head.h:325 [inline]
>  __invalidate_bh_lrus fs/buffer.c:1508 [inline]
>  invalidate_bh_lru+0xa8/0x1b0 fs/buffer.c:1521
>  csd_do_func kernel/smp.c:134 [inline]
>  smp_call_function_many_cond+0x15d7/0x29d0 kernel/smp.c:847
>  on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1023
>  kill_bdev block/bdev.c:89 [inline]
>  blkdev_flush_mapping+0xfe/0x250 block/bdev.c:664
>  blkdev_put_whole block/bdev.c:671 [inline]
>  bdev_release+0x466/0x700 block/bdev.c:1096
>  blkdev_release+0x15/0x20 block/fops.c:638
>  __fput+0x24a/0x8a0 fs/file_table.c:422
>  __do_sys_close fs/open.c:1566 [inline]
>  __se_sys_close fs/open.c:1551 [inline]
>  __x64_sys_close+0x7f/0x110 fs/open.c:1551
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8226f170a8
> Code: 48 8b 05 83 9d 0d 00 64 c7 00 16 00 00 00 83 c8 ff 48 83 c4 20 5b c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 5b 48 8b 15 51 9d 0d 00 f7 d8 64 89 02 48 83
> RSP: 002b:00007ffe0319be58 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> RAX: ffffffffffffffda RBX: 00007f8226dee0e0 RCX: 00007f8226f170a8
> RDX: 000056579a6766d5 RSI: 00007ffe0319b658 RDI: 0000000000000008
> RBP: 00005652ff487f60 R08: 0000000000000006 R09: b595b5b875e4bbae
> R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000002
> R13: 00005652ff478840 R14: 0000000000000008 R15: 00005652ff466910
>  </TASK>
> 
> Allocated by task 5112:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:312 [inline]
>  __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
>  kasan_slab_alloc include/linux/kasan.h:201 [inline]
>  slab_post_alloc_hook mm/slub.c:3992 [inline]
>  slab_alloc_node mm/slub.c:4041 [inline]
>  kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4048
>  alloc_buffer_head+0x2a/0x290 fs/buffer.c:3025
>  folio_alloc_buffers+0x241/0x5b0 fs/buffer.c:929
>  grow_dev_folio fs/buffer.c:1072 [inline]
>  grow_buffers fs/buffer.c:1113 [inline]
>  __getblk_slow fs/buffer.c:1139 [inline]
>  bdev_getblk+0x2a6/0x550 fs/buffer.c:1441
>  __bread_gfp+0x86/0x400 fs/buffer.c:1495
>  sb_bread include/linux/buffer_head.h:347 [inline]
>  sysv_fill_super+0x231/0x710 fs/sysv/super.c:379
>  mount_bdev+0x20a/0x2d0 fs/super.c:1679
>  legacy_get_tree+0xee/0x190 fs/fs_context.c:662
>  vfs_get_tree+0x90/0x2b0 fs/super.c:1800
>  do_new_mount+0x2be/0xb40 fs/namespace.c:3472
>  do_mount fs/namespace.c:3812 [inline]
>  __do_sys_mount fs/namespace.c:4020 [inline]
>  __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 79:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2256 [inline]
>  slab_free mm/slub.c:4477 [inline]
>  kmem_cache_free+0x145/0x350 mm/slub.c:4552
>  free_buffer_head+0x54/0x240 fs/buffer.c:3041
>  try_to_free_buffers+0x311/0x5f0 fs/buffer.c:2982
>  shrink_folio_list+0x26c2/0x8c90 mm/vmscan.c:1413
>  evict_folios+0x50f7/0x7780 mm/vmscan.c:4560
>  try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4755
>  shrink_one+0x3b9/0x850 mm/vmscan.c:4793
>  shrink_many mm/vmscan.c:4856 [inline]
>  lru_gen_shrink_node mm/vmscan.c:4934 [inline]
>  shrink_node+0x3799/0x3de0 mm/vmscan.c:5914
>  kswapd_shrink_node mm/vmscan.c:6742 [inline]
>  balance_pgdat mm/vmscan.c:6934 [inline]
>  kswapd+0x1cbc/0x3720 mm/vmscan.c:7203
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> The buggy address belongs to the object at ffff88801c9899f8
>  which belongs to the cache buffer_head of size 168
> The buggy address is located 96 bytes inside of
>  freed 168-byte region [ffff88801c9899f8, ffff88801c989aa0)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c989
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xfdffffff(slab)
> raw: 00fff00000000000 ffff88801b763c80 ffffea0000725d40 0000000000000006
> raw: 0000000000000000 0000000080110011 00000001fdffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x152c50(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 1, tgid 1 (init), ts 28576033639, free_ts 0
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
>  prep_new_page mm/page_alloc.c:1508 [inline]
>  get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3446
>  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
>  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>  alloc_slab_page+0x5f/0x120 mm/slub.c:2325
>  allocate_slab+0x5a/0x2f0 mm/slub.c:2488
>  new_slab mm/slub.c:2541 [inline]
>  ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3727
>  __slab_alloc+0x58/0xa0 mm/slub.c:3817
>  __slab_alloc_node mm/slub.c:3870 [inline]
>  slab_alloc_node mm/slub.c:4029 [inline]
>  kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4048
>  alloc_buffer_head+0x2a/0x290 fs/buffer.c:3025
>  folio_alloc_buffers+0x241/0x5b0 fs/buffer.c:929
>  grow_dev_folio fs/buffer.c:1072 [inline]
>  grow_buffers fs/buffer.c:1113 [inline]
>  __getblk_slow fs/buffer.c:1139 [inline]
>  bdev_getblk+0x2a6/0x550 fs/buffer.c:1441
>  __getblk include/linux/buffer_head.h:381 [inline]
>  sb_getblk include/linux/buffer_head.h:387 [inline]
>  ext4_read_inode_bitmap+0x24c/0x12f0 fs/ext4/ialloc.c:145
>  __ext4_new_inode+0x106f/0x4260 fs/ext4/ialloc.c:1054
>  ext4_create+0x279/0x550 fs/ext4/namei.c:2832
>  lookup_open fs/namei.c:3578 [inline]
>  open_last_lookups fs/namei.c:3647 [inline]
>  path_openat+0x1a9a/0x3470 fs/namei.c:3883
>  do_filp_open+0x235/0x490 fs/namei.c:3913
> page_owner free stack trace missing
> 
> Memory state around the buggy address:
>  ffff88801c989900: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88801c989980: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa
> >ffff88801c989a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                     ^
>  ffff88801c989a80: fb fb fb fb fc fc fc fc fc fc fc fc 00 00 00 00
>  ffff88801c989b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================

