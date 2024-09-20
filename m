Return-Path: <linux-fsdevel+bounces-29772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3444E97D99F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 20:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74AE6B2214F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D7C1836D5;
	Fri, 20 Sep 2024 18:38:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5DE17B402
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726857503; cv=none; b=MZxinwMgqOWQdvKM5WkkBN7LCL88Hlk5m5QAJ1coIrjWAnXPMHWLjoEJhVxzjNOSgw4UTMFAce72pxK+ZH+qM/NRtqB6UcZjnLETrhWddsC6+TpCZDroADkSYoXcLx8ynFHuCDrdecLiS/Mf5xqCFEsTR5EYvXorJLAtHJr5Zt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726857503; c=relaxed/simple;
	bh=dIu3SRweG+p0jrnTQvszdymDKKpSfksUdYhydrSDi5E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A0e0ZzQjv/2Ywos//nKoQt3E6YRUMA6NN3SARjCOwiMTIhCRSDsLk2MZ7UvrkXfDUp98O90vjUlS6uiFV7rh0mrDVgoX+UNz5/uylwBbLrc14ecL3tlKHjd5+wOCqR3BsPYzAtOvWTG60lY7biga2+kJ+TY5H28w2Z3rhJQIo0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0cadb1536so11408875ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 11:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726857501; x=1727462301;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1sy/nYfvKIhHvMi2nCIuLSMe20Sl3PixfNdK4qqzEJg=;
        b=J9k78ffLD3sbsdoShI2LLl9fGfnoITC2THv+cpiOBsEpcxK+s0cxM30qlySjvRRg08
         RssgZmdcXynVwG9brG6CtE8O1KFo5NQa30D2xzcApZHEDpcs69gt2nLF2/fKN7nc/sAK
         YtX30F15PMhn6bagp0O2rTpLXO31+4ihIErCXqXOSAfI8J9lphgCOElytXLAal5+Cj3D
         auyBpop5A0WTXh+ZNVg3jR0Z+AoUcwc9EjoeC0gztjk7l7lIk069D5ek0pDkyplf6x2Q
         HPQKEj/pOvZVFotePj7NlDq11yhrH7tCTuQu2gYTkB1IRjTKHpwePXaLkADBeQeXKsOd
         EtYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD+WpCkxVOZvbwBBqpI3S/BXKEgD6lfbGtUqIcOuZke+ynJmsAdX014Nsx/r3aLgxZEsKx/PNy4AD4Yit9@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYpVp+Bxnv/VskyJYxKjVAGPi3kO3bDKfTgqJSiK3O9Fcwrnb
	F+/x7RceUfp9I0j4M2pi8cKT3ynXmrUyOZ/IosUWmIhiJiDTNRuB/NH97SC4g8DLDNYgMloywLb
	bAEuV4VXgNUHGGtgxIERXJZZg1F7PPVDs71H7qQDC9M6f+YXDeJ/MqG4=
X-Google-Smtp-Source: AGHT+IE9sINK897BnzH/I22v+4+JYFkX46slu+qjkbO6bYiDMyk3Su8W+jmfVmRJ19vMrLjlPlrSudBT+XIMt6g/Z1ykrXxs/kso
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc7:b0:39f:5521:2cd4 with SMTP id
 e9e14a558f8ab-3a0c8d3978amr41032215ab.26.1726857500796; Fri, 20 Sep 2024
 11:38:20 -0700 (PDT)
Date: Fri, 20 Sep 2024 11:38:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66edc11c.050a0220.3195df.0008.GAE@google.com>
Subject: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_folioq_advance
From: syzbot <syzbot+e6089e62b4d92c4a7792@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    adfc3ded5c33 Merge tag 'for-6.12/io_uring-discard-20240913..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102fa8a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71033c66cc4b01c4
dashboard link: https://syzkaller.appspot.com/bug?extid=e6089e62b4d92c4a7792
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bd5c07980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f2d500580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-adfc3ded.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14d8d89edd95/vmlinux-adfc3ded.xz
kernel image: https://storage.googleapis.com/syzbot-assets/77b35977c15b/bzImage-adfc3ded.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6089e62b4d92c4a7792@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in iov_iter_folioq_advance+0x10c/0x360 lib/iov_iter.c:540
Read of size 8 at addr ffff88801fd92520 by task syz-executor251/5100

CPU: 0 UID: 0 PID: 5100 Comm: syz-executor251 Not tainted 6.11.0-syzkaller-02520-gadfc3ded5c33 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 iov_iter_folioq_advance+0x10c/0x360 lib/iov_iter.c:540
 netfs_write_folio+0x154b/0x1fe0 fs/netfs/write_issue.c:481
 netfs_writepages+0x89f/0xe80 fs/netfs/write_issue.c:541
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 __filemap_fdatawrite mm/filemap.c:436 [inline]
 filemap_fdatawrite+0xfb/0x160 mm/filemap.c:441
 v9fs_dir_release+0x151/0x560 fs/9p/vfs_dir.c:219
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x27f0 kernel/exit.c:882
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f354c1210c9
Code: Unable to access opcode bytes at 0x7f354c12109f.
RSP: 002b:00007ffdcf751d08 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f354c1210c9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f354c19c390 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 000000007ffff000 R11: 0000000000000246 R12: 00007f354c19c390
R13: 0000000000000000 R14: 00007f354c19cde0 R15: 00007f354c0f20b0
 </TASK>

Allocated by task 5100:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4190
 kmalloc_noprof include/linux/slab.h:690 [inline]
 netfs_buffer_append_folio+0x1f1/0x8b0 fs/netfs/misc.c:25
 netfs_write_folio+0xe69/0x1fe0 fs/netfs/write_issue.c:421
 netfs_writepages+0x89f/0xe80 fs/netfs/write_issue.c:541
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 __filemap_fdatawrite mm/filemap.c:436 [inline]
 filemap_fdatawrite+0xfb/0x160 mm/filemap.c:441
 v9fs_dir_release+0x151/0x560 fs/9p/vfs_dir.c:219
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x27f0 kernel/exit.c:882
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1030:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2250 [inline]
 slab_free mm/slub.c:4474 [inline]
 kfree+0x149/0x360 mm/slub.c:4595
 netfs_delete_buffer_head+0x9f/0xd0 fs/netfs/misc.c:59
 netfs_writeback_unlock_folios fs/netfs/write_collect.c:139 [inline]
 netfs_collect_write_results fs/netfs/write_collect.c:493 [inline]
 netfs_write_collection_worker+0x1b9a/0x4950 fs/netfs/write_collect.c:551
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x870/0xd30 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88801fd92400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 288 bytes inside of
 freed 512-byte region [ffff88801fd92400, ffff88801fd92600)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1fd92
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801ac41c80 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080080008 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801ac41c80 dead000000000122 0000000000000000
head: 0000000000000000 0000000080080008 00000001fdffffff 0000000000000000
head: 00fff00000000001 ffffea00007f6481 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5100, tgid 5100 (syz-executor251), ts 89108296142, free_ts 87555671864
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2319
 allocate_slab+0x5a/0x2f0 mm/slub.c:2482
 new_slab mm/slub.c:2535 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3721
 __slab_alloc+0x58/0xa0 mm/slub.c:3811
 __slab_alloc_node mm/slub.c:3864 [inline]
 slab_alloc_node mm/slub.c:4026 [inline]
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4185
 kmalloc_noprof include/linux/slab.h:690 [inline]
 netfs_buffer_append_folio+0x1f1/0x8b0 fs/netfs/misc.c:25
 netfs_write_folio+0xe69/0x1fe0 fs/netfs/write_issue.c:421
 netfs_writepages+0x89f/0xe80 fs/netfs/write_issue.c:541
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 __filemap_fdatawrite mm/filemap.c:436 [inline]
 filemap_fdatawrite+0xfb/0x160 mm/filemap.c:441
 v9fs_dir_release+0x151/0x560 fs/9p/vfs_dir.c:219
 __fput+0x23f/0x880 fs/file_table.c:431
page last free pid 5094 tgid 5094 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2619
 skb_free_frag include/linux/skbuff.h:3399 [inline]
 skb_free_head net/core/skbuff.c:1096 [inline]
 skb_release_data+0x6dc/0x8a0 net/core/skbuff.c:1125
 skb_release_all net/core/skbuff.c:1190 [inline]
 __napi_kfree_skb net/core/skbuff.c:1480 [inline]
 kfree_skb_napi_cache net/core/skbuff.c:7115 [inline]
 skb_attempt_defer_free+0x42f/0x5c0 net/core/skbuff.c:7137
 tcp_eat_recv_skb net/ipv4/tcp.c:1526 [inline]
 tcp_recvmsg_locked+0x2995/0x3c80 net/ipv4/tcp.c:2805
 tcp_recvmsg+0x25d/0x920 net/ipv4/tcp.c:2851
 inet_recvmsg+0x150/0x2d0 net/ipv4/af_inet.c:885
 sock_recvmsg_nosec net/socket.c:1052 [inline]
 sock_recvmsg+0x1ae/0x280 net/socket.c:1074
 sock_read_iter+0x2c4/0x3d0 net/socket.c:1144
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x9bb/0xbc0 fs/read_write.c:569
 ksys_read+0x1a0/0x2c0 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88801fd92400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801fd92480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801fd92500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88801fd92580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801fd92600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

