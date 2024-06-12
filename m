Return-Path: <linux-fsdevel+bounces-21498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D58904949
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 05:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A281B23861
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 03:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904FA11182;
	Wed, 12 Jun 2024 03:03:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED903214
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161409; cv=none; b=dLbOTE1hoANIeKNB0CPFi1jiOShAjrAbPYvRYGT7m5QGhr8P6PHBk/yDKCsv1M6Cr4mogl8omwYfTOUjZ41kRWplfFq8kl9svQnIPiacbIrX4gKMuxacqavmdfli5E7sTvz0qTx12bH3X3NI2SygopA3WioOFfEtJi8JvJ1jvR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161409; c=relaxed/simple;
	bh=Qs2hlUAhVeMq8HsrLzYY7utvfUwsvhGAcK0sVBRNoRs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KeRLJ5DRbE7SUwk5h9mG8xOwnVLKPHdkLvCSPmxGN8APAUvyl8Ua1U3jFrvFMm8CJcPcH5zsHdzExUnH4xXbeUuaPJBPA1AcZAaKkkTUYJ6+LWQbo1S1jdAeEGYeShkaXzhjrQdQAuptZmm0+9OAmit79lFojFT7rWuFzQ566ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eb861e964cso313205839f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 20:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718161405; x=1718766205;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZK9UIQwMURllNmpPfX0nrsLoQ5V46AAXI+e0c27w0Q=;
        b=w9THy+bW7cJSewNDwClVJRNG2bIJzgnG4Q6SV1H8Biqa63Lx7+pLSLB7xHtb50D9yP
         aPmRD555k/6jRm2IRdg7vy1QrUTunbRu673bESDr2xz0fLQ0SYRT2uyHdVFamDyH2tDg
         R3hXnRlMiTy7bQXTdSQuOLQKXqO63Ra2j5Bd1gkOYosat0P9OKgiBBnqCJVpc6771DAz
         083u0WHHE5XJBWGixoK1HGVJeF+iZNCWoUQ9OeeyU/Zg+re3MKWV1LWYJd0LbQBg/7gG
         6FPBBknen+/IsSp0Y8wE3Gj2TvBC0OT2Cpwx8BGECj23dq7BGBX2548KDq1jRpmeF1Tc
         6gEQ==
X-Gm-Message-State: AOJu0YyuuuaLfMImxj7zBVmVy3qxi/3g+mmy/v/PQcpVLKLrPyP8D4Ge
	3Lzy9RHnJLUFPATDzDm+35dlP/xKW+H9SJle+hjaAG1Jz3FtORX3IlRXEalBbXPvVP/UrZYkYxP
	i0olQd7uyu+/KNlDpqsvdwn/SxhC5JhTZVKcKBq9dk+CIgYYh5Me2c1IC3A==
X-Google-Smtp-Source: AGHT+IG/QZ/b6tIdOPc2COHoswWyZ8n8byBW+l6yJFJ9G4csCN/UqihUdil+KlsakSc1crdW0tSp7XZjFP26dzlSdpeSJ9W4YZF0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8625:b0:4b9:f7d:8671 with SMTP id
 8926c6da1cb9f-4b93ec0e5f1mr27277173.1.1718161405694; Tue, 11 Jun 2024
 20:03:25 -0700 (PDT)
Date: Tue, 11 Jun 2024 20:03:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040e426061aa8a069@google.com>
Subject: [syzbot] [hfs?] KASAN: invalid-free in hfs_btree_close (2)
From: syzbot <syzbot+7155b2fe09e033c91381@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    96e09b8f8166 Merge tag 'platform-drivers-x86-v6.10-3' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10baf66a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96fd46a1ee1615e0
dashboard link: https://syzkaller.appspot.com/bug?extid=7155b2fe09e033c91381
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-96e09b8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2bf80e54d1f/vmlinux-96e09b8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b81837ec8c21/bzImage-96e09b8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7155b2fe09e033c91381@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in hfs_btree_close+0xac/0x390 fs/hfs/btree.c:154
Free of addr ffff888025e0fc00 by task syz-executor.2/5860

CPU: 1 PID: 5860 Comm: syz-executor.2 Not tainted 6.10.0-rc2-syzkaller-00269-g96e09b8f8166 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report_invalid_free+0xaa/0xd0 mm/kasan/report.c:563
 poison_slab_object+0x135/0x160 mm/kasan/common.c:232
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2195 [inline]
 slab_free mm/slub.c:4436 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4557
 hfs_btree_close+0xac/0x390 fs/hfs/btree.c:154
 hfs_mdb_put+0xbf/0x380 fs/hfs/mdb.c:360
 generic_shutdown_super+0x159/0x3d0 fs/super.c:642
 kill_block_super+0x3b/0x90 fs/super.c:1676
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7353579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffbe5de8 EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffbe5e90 RCX: 0000000000000009
RDX: 00000000f74a9ff4 RSI: 00000000f73fa361 RDI: 00000000ffbe6f34
RBP: 00000000ffbe5e90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 8233:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0x1ec/0x420 mm/slub.c:4134
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 __hfs_bnode_create+0x108/0x860 fs/hfs/bnode.c:259
 hfs_bnode_find+0x2d1/0xc50 fs/hfs/bnode.c:335
 hfs_brec_find+0x2af/0x510 fs/hfs/bfind.c:126
 hfs_brec_read+0x26/0x120 fs/hfs/bfind.c:165
 hfs_lookup+0x209/0x320 fs/hfs/dir.c:32
 lookup_open.isra.0+0x928/0x13c0 fs/namei.c:3483
 open_last_lookups fs/namei.c:3574 [inline]
 path_openat+0x92f/0x29f0 fs/namei.c:3804
 do_filp_open+0x1dc/0x430 fs/namei.c:3834
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_compat_sys_openat fs/open.c:1480 [inline]
 __se_compat_sys_openat fs/open.c:1478 [inline]
 __ia32_compat_sys_openat+0x16e/0x210 fs/open.c:1478
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Freed by task 111:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2195 [inline]
 slab_free mm/slub.c:4436 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4557
 hfs_release_folio+0x435/0x570 fs/hfs/inode.c:118
 filemap_release_folio+0x1ed/0x280 mm/filemap.c:4173
 shrink_folio_list+0x254a/0x4150 mm/vmscan.c:1394
 evict_folios+0x6e6/0x1bf0 mm/vmscan.c:4553
 try_to_shrink_lruvec+0x618/0x9b0 mm/vmscan.c:4749
 shrink_one+0x3f8/0x7c0 mm/vmscan.c:4788
 shrink_many mm/vmscan.c:4851 [inline]
 lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4951
 shrink_node mm/vmscan.c:5910 [inline]
 kswapd_shrink_node mm/vmscan.c:6720 [inline]
 balance_pgdat+0x1105/0x1970 mm/vmscan.c:6911
 kswapd+0x5ea/0xbf0 mm/vmscan.c:7180
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888025e0fc00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 192-byte region [ffff888025e0fc00, ffff888025e0fcc0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25e0f
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000000 ffff8880154423c0 ffffea00006e4540 dead000000000004
raw: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 7495, tgid 7495 (syz-executor.1), ts 157561693608, free_ts 157207432708
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x136a/0x2df0 mm/page_alloc.c:3402
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4660
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2264
 allocate_slab mm/slub.c:2427 [inline]
 new_slab+0x84/0x260 mm/slub.c:2480
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3666
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 kmalloc_trace_noprof+0x2c5/0x310 mm/slub.c:4147
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 kset_create lib/kobject.c:965 [inline]
 kset_create_and_add+0x4d/0x190 lib/kobject.c:1008
 register_queue_kobjects net/core/net-sysfs.c:1887 [inline]
 netdev_register_kobject+0x1cd/0x3f0 net/core/net-sysfs.c:2140
 register_netdevice+0x12ce/0x1c40 net/core/dev.c:10375
 br_dev_newlink+0x27/0x110 net/bridge/br_netlink.c:1563
 rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
 __rtnl_newlink+0x119c/0x1960 net/core/rtnetlink.c:3730
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6635
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2564
page last free pid 826 tgid 826 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2565
 vfree+0x181/0x7a0 mm/vmalloc.c:3346
 delayed_vfree_work+0x56/0x70 mm/vmalloc.c:3267
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888025e0fb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888025e0fb80: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888025e0fc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888025e0fc80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888025e0fd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

