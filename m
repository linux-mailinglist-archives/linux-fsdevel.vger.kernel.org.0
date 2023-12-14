Return-Path: <linux-fsdevel+bounces-6135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71866813AC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0671F21F53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA643697A2;
	Thu, 14 Dec 2023 19:30:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8C69794
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ceb9596211so10737554b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 11:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582227; x=1703187027;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFxef2h5lrExuJ8D5wN9A1CJDkySZu+2Kkfu5Vl6v+Q=;
        b=sFB/ThWes6Vp9yRiBx2jPNZ5JLy8e1QTIYVqHoPHNBi0VPNJqHear1z9n5yvRcH/YL
         bYs1aZdl3H7ymM44VeyjsQi5rNa0MbjGIRaZtdhYw5Ce8mN0g8gTXwmKP/eCrwX7dam1
         pQ03qjpO7EtyKhCPJpZQa8SPahxe058miL0RFzJ9EnByNItkgi+98mSjhu3A1hijsoll
         EfdfOzCvpdKeTc/2CdU6wQSNqMalYClLFr5nYXx/3QxDHyyx1oRTjyyrjh9BeeN+/omq
         X5M6suQyJgwTvqBBjIRBf2NcLvG5YDhb7jYfxKl90mTSQaemMU1qX2hOzmoJIT7d0FBf
         M+Sw==
X-Gm-Message-State: AOJu0YwGzZEQE5VwbGfwQUBoXiwzLRrGDZ/ehwnEqm2HvB+tfn+OReQA
	mTTc1fD1IHRqSuoglwsYeCCo/vowba1L+OGSXXsKS1VFE3tY
X-Google-Smtp-Source: AGHT+IEZmS2KDd1o4gzGWFiiliXEyQLQO5gWVjZyRM0uF2KOupYUaFLfAkmCQCVNKz36roMZ09oblsWXT1+m0IrYth2UBOtBzHTz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:aa7:93b4:0:b0:6d2:671e:84cc with SMTP id
 x20-20020aa793b4000000b006d2671e84ccmr587103pff.0.1702582226950; Thu, 14 Dec
 2023 11:30:26 -0800 (PST)
Date: Thu, 14 Dec 2023 11:30:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d69fc4060c7d50a2@google.com>
Subject: [syzbot] [mm?] [hfs?] KASAN: slab-out-of-bounds Write in shmem_file_read_iter
From: syzbot <syzbot+3e719fc23ab95580e4c2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hughd@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d46efae31672 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16803d66e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62dd67b72f86455
dashboard link: https://syzkaller.appspot.com/bug?extid=3e719fc23ab95580e4c2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1743a366e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d5101ee80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1c7fab7b512/disk-d46efae3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44ed3d86d2c1/vmlinux-d46efae3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e0b5f52455a/Image-d46efae3.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3e3c3babb0db/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e719fc23ab95580e4c2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy_to_iter lib/iov_iter.c:65 [inline]
BUG: KASAN: slab-out-of-bounds in iterate_bvec include/linux/iov_iter.h:122 [inline]
BUG: KASAN: slab-out-of-bounds in iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
BUG: KASAN: slab-out-of-bounds in iterate_and_advance include/linux/iov_iter.h:271 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_to_iter+0x7dc/0x1500 lib/iov_iter.c:186
Write of size 2048 at addr ffff0000ce31a400 by task kworker/u4:5/220

CPU: 1 PID: 220 Comm: kworker/u4:5 Not tainted 6.7.0-rc4-syzkaller-gd46efae31672 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: loop0 loop_rootcg_workfn
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x174/0x514 mm/kasan/report.c:475
 kasan_report+0xd8/0x138 mm/kasan/report.c:588
 kasan_check_range+0x254/0x294 mm/kasan/generic.c:187
 __asan_memcpy+0x54/0x84 mm/kasan/shadow.c:106
 memcpy_to_iter lib/iov_iter.c:65 [inline]
 iterate_bvec include/linux/iov_iter.h:122 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0x7dc/0x1500 lib/iov_iter.c:186
 copy_page_to_iter+0x200/0x2f8 lib/iov_iter.c:381
 shmem_file_read_iter+0x4a0/0x9dc mm/shmem.c:2824
 do_iter_read+0x668/0xa80 fs/read_write.c:795
 vfs_iter_read+0x88/0xac fs/read_write.c:837
 lo_read_simple drivers/block/loop.c:290 [inline]
 do_req_filebacked drivers/block/loop.c:500 [inline]
 loop_handle_cmd drivers/block/loop.c:1915 [inline]
 loop_process_work+0xe9c/0x2498 drivers/block/loop.c:1950
 loop_rootcg_workfn+0x28/0x38 drivers/block/loop.c:1981
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

Allocated by task 6095:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x7c mm/kasan/common.c:52
 kasan_save_alloc_info+0x24/0x30 mm/kasan/generic.c:511
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc+0xcc/0x1b8 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 hfsplus_read_wrapper+0x46c/0xfcc fs/hfsplus/wrapper.c:181
 hfsplus_fill_super+0x2f0/0x166c fs/hfsplus/super.c:413
 mount_bdev+0x1e8/0x2b4 fs/super.c:1650
 hfsplus_mount+0x44/0x58 fs/hfsplus/super.c:641
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:662
 vfs_get_tree+0x90/0x288 fs/super.c:1771
 do_new_mount+0x25c/0x8c8 fs/namespace.c:3337
 path_mount+0x590/0xe04 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount fs/namespace.c:3863 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3863
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

The buggy address belongs to the object at ffff0000ce31a400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
 allocated 512-byte region [ffff0000ce31a400, ffff0000ce31a600)

The buggy address belongs to the physical page:
page:00000000950b7bf3 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10e318
head:00000000950b7bf3 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0001c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000ce31a500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000ce31a580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff0000ce31a600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff0000ce31a680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000ce31a700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

