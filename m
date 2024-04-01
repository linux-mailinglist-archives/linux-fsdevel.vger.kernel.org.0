Return-Path: <linux-fsdevel+bounces-15837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09248944B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 20:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635981F21AFD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D52E4F605;
	Mon,  1 Apr 2024 18:17:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586AA4E1D5
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995455; cv=none; b=Ts0jHC7jRV5Y6yFizcpkZoVdcP0onoiFBapi0Jugw2ibYS7r0040ydfpY2Rx07lb+x/o0KaaBEI9rZ4HyIRj9xQ31CKmbxniNbrdGJpQrsSUcHb68UfF02Q6X2rGlFHRMSmxqqn6vnyVyl442+yqtm/jZIHhsXY8uFEmA2+eztM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995455; c=relaxed/simple;
	bh=bb4LafNlDSEVYUwO6GJJYTtKCbBgPslKVqiu1vVzTDs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LjbGqk9y5dBqi7F7orck6zTPtSAqKPicThXem6/Y6zfcKSjPLR1VbJ2xG/LITDGGOTVzK2+feWPr7YHydsl62wyaq7tm+fVmgpQ/tF91g96eIE/FYOeJyC87Vp0kuY1B48Hc7RM5k+PubVODwoYzM7a7fRFvalhjhLpdeX6saos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso345669939f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Apr 2024 11:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711995452; x=1712600252;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Z7Tiaufdegz9YqZFUAowuT6FetFeBQhbyO0ECn1uS0=;
        b=DNQWKPgwqjtPoLio6x7zqrABcglAG2wdHmAD6pIXs6TGfshQzhlxqtep/umInl2YA+
         TbIvQCLOhvgE9IldRcqXJJdSnVxJ5ZEyU5lxWWoBmHyGV8jyvm7pMZKXLzOeMSaqAZDB
         wjtpiwCVXAWYhDll6fHg6xTeb+2S4IGwCRj4boFcAi5FFbJROl884jSLv0HHBJocO4Q6
         HEProEKGBcIjuSPLjXLgJOaf7knHJOxSGTfj3ARaMH+PGu3nK2Si04z18cnbkUSxzCLK
         YHJ9zeEZ5KqDCLJMPI6yLMQ0kl+JZxnrsfegbnJu178z/223joWTjXkLqAHq67esftIr
         Ptow==
X-Forwarded-Encrypted: i=1; AJvYcCWfan91S0r4E5ul7H5JjWtRVKr6R1hneVvFL7+RJEaJ7vVBxcNAZDXccn2pNBX0eWvt+bxBmRHEmN4viGn51x77xH5GPxEJW9yKnlyYCg==
X-Gm-Message-State: AOJu0YwKUZJZK3bTloW322bKUtHtlr7B9e5rsWx+qPuE1cPpCWuCXTb6
	pWMnoWmpJYfb4yaAUzXNzgwtCESOsHslyT7izPobvap+AlRd+TY6bSc9O91RsSWoOJWdzqnYiZG
	sbW6tRAcRB+RdYNnLBoCTk6ugLYUPnGjpBjiEmF3HbRcY5VWdy4gwKuo=
X-Google-Smtp-Source: AGHT+IFbuwNsqWvjTbGi787iFy9FvDDwG/sFhfCqRnf0Cte5HlXU4U2lUMC5VOi54I5LqEwyUMRyimpQb3bbr57SqYEKec/IYhOO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35ab:b0:47e:db25:8eb7 with SMTP id
 v43-20020a05663835ab00b0047edb258eb7mr665597jal.2.1711995452604; Mon, 01 Apr
 2024 11:17:32 -0700 (PDT)
Date: Mon, 01 Apr 2024 11:17:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf534906150d00c1@google.com>
Subject: [syzbot] [gfs2?] KASAN: slab-use-after-free Write in gfs2_qd_dealloc (2)
From: syzbot <syzbot+956651316bb16496a837@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    18737353cca0 Merge tag 'edac_urgent_for_v6.9_rc2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1536130d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f64ec427e98bccd7
dashboard link: https://syzkaller.appspot.com/bug?extid=956651316bb16496a837
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1669dc5e180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-18737353.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e9d064c31921/vmlinux-18737353.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6d950d42963e/bzImage-18737353.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a7a0dc360e37/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+956651316bb16496a837@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 [inline]
BUG: KASAN: slab-use-after-free in gfs2_qd_dealloc+0x7a/0xf0 fs/gfs2/quota.c:115
Write of size 4 at addr ffff88802040ca78 by task kworker/0:1/9

CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.9.0-rc1-syzkaller-00379-g18737353cca0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: rcu_gp process_srcu
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 [inline]
 gfs2_qd_dealloc+0x7a/0xf0 fs/gfs2/quota.c:115
 rcu_do_batch kernel/rcu/tree.c:2196 [inline]
 rcu_core+0x828/0x16b0 kernel/rcu/tree.c:2471
 __do_softirq+0x218/0x922 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:633 [inline]
 irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:queue_delayed_work_on+0x9e/0x130 kernel/workqueue.c:2600
Code: ff 48 89 ee e8 03 e5 34 00 48 85 ed 75 46 e8 e9 e9 34 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 e7 e4 34 00 48 85 db 75 75 <e8> cd e9 34 00 44 89 e8 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffffc900000c7c90 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff815888c4
RDX: ffff8880176fc880 RSI: ffffffff815888ce RDI: 0000000000000007
RBP: 0000000000000200 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000004 R12: ffff8880154b8000
R13: 0000000000000001 R14: ffff88801548a800 R15: 0000000000000000
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 8319:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 init_sbd fs/gfs2/ops_fstype.c:77 [inline]
 gfs2_fill_super+0x141/0x2bf0 fs/gfs2/ops_fstype.c:1160
 get_tree_bdev+0x36f/0x610 fs/super.c:1632
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1341
 vfs_get_tree+0x8f/0x380 fs/super.c:1797
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

Freed by task 8319:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x129/0x390 mm/slub.c:4390
 free_sbd fs/gfs2/ops_fstype.c:69 [inline]
 gfs2_fill_super+0x13d8/0x2bf0 fs/gfs2/ops_fstype.c:1324
 get_tree_bdev+0x36f/0x610 fs/super.c:1632
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1341
 vfs_get_tree+0x8f/0x380 fs/super.c:1797
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

The buggy address belongs to the object at ffff88802040c000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 2680 bytes inside of
 freed 8192-byte region [ffff88802040c000, ffff88802040e000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x20408
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888015443180 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000020002 00000001ffffffff 0000000000000000
head: 00fff80000000840 ffff888015443180 dead000000000100 dead000000000122
head: 0000000000000000 0000000000020002 00000001ffffffff 0000000000000000
head: 00fff80000000003 ffffea0000810201 dead000000000122 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd28c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4909, tgid 4909 (dhcpcd), ts 28969140910, free_ts 28042324067
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3317
 __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2391
 ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc_node_track_caller+0x367/0x470 mm/slub.c:3986
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:599
 __alloc_skb+0x164/0x380 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1313 [inline]
 netlink_dump+0x2b2/0xe00 net/netlink/af_netlink.c:2229
 netlink_recvmsg+0xa13/0xf40 net/netlink/af_netlink.c:1987
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x1f6/0x250 net/socket.c:1068
 ____sys_recvmsg+0x21f/0x6b0 net/socket.c:2803
 ___sys_recvmsg+0x115/0x1a0 net/socket.c:2845
 __sys_recvmsg+0x114/0x1e0 net/socket.c:2875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
page last free pid 4994 tgid 4994 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2487
 __put_partials+0x14c/0x170 mm/slub.c:2906
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc+0x136/0x320 mm/slub.c:3852
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
 getname_flags+0x9b/0xf0 include/linux/audit.h:322
 vfs_fstatat+0x9a/0x150 fs/stat.c:303
 __do_sys_newfstatat+0x98/0x120 fs/stat.c:468
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

Memory state around the buggy address:
 ffff88802040c900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802040c980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802040ca00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff88802040ca80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802040cb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	ff 48 89             	decl   -0x77(%rax)
   3:	ee                   	out    %al,(%dx)
   4:	e8 03 e5 34 00       	call   0x34e50c
   9:	48 85 ed             	test   %rbp,%rbp
   c:	75 46                	jne    0x54
   e:	e8 e9 e9 34 00       	call   0x34e9fc
  13:	9c                   	pushf
  14:	5b                   	pop    %rbx
  15:	81 e3 00 02 00 00    	and    $0x200,%ebx
  1b:	31 ff                	xor    %edi,%edi
  1d:	48 89 de             	mov    %rbx,%rsi
  20:	e8 e7 e4 34 00       	call   0x34e50c
  25:	48 85 db             	test   %rbx,%rbx
  28:	75 75                	jne    0x9f
* 2a:	e8 cd e9 34 00       	call   0x34e9fc <-- trapping instruction
  2f:	44 89 e8             	mov    %r13d,%eax
  32:	48 83 c4 08          	add    $0x8,%rsp
  36:	5b                   	pop    %rbx
  37:	5d                   	pop    %rbp
  38:	41 5c                	pop    %r12
  3a:	41 5d                	pop    %r13
  3c:	41 5e                	pop    %r14
  3e:	41 5f                	pop    %r15


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

