Return-Path: <linux-fsdevel+bounces-56244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5F0B14D02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 13:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B0F16A54C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC0028CF74;
	Tue, 29 Jul 2025 11:26:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBF28CF5D
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753788393; cv=none; b=CLEifBFb7HpE3LZN6bX+A2Fol0FOiCUDgQo91+gkNy5H4hWV01yFuRMMNA7vcq9/yqS3uSc8O0qivqrzPri0QwMuz8dsH6mtvHf3YwrAGj0rgm8VnPzD0A4J7xURtj8MzGK4etO7hi49sTn4jqQeku41ADjM8g5i7sMbJAEitdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753788393; c=relaxed/simple;
	bh=YzC2A92KHCIxZqNCsbKeXgSkXugFE0D4UhBptNJiDtk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=THk2ZYgRFJ9i7niP7xnZcnFZQPuuUd7Kvp6YVUpDqUOFDWke+BuT/ZJtpJePNmOzvQcmwYWXHcoA9qd1ZkGFlKu6J9sQJVX7kTIAHOxtbn92vsaeODCgFB+BzkyTX4Ab02HkXZ+XvY5XX+Y3pl/y12mHJR4QNrgWkqVisKUU/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e3c9a3f22aso82240565ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 04:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753788390; x=1754393190;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJ3a+Fko02+wz2ZgKRQheYqnXG2eWMVZVW1SWK7/4e4=;
        b=D7UlzsqaWjstyRz11+R9/Qy/CO02YxeAFeaWWLRkfDPngisVT3XhD3xCyHRZP5063e
         cJ+44DhmvyzD+VEWtkErj/sQIhbZ+yrGbRkB5n6m1d/AfrNqLStnWaAtoaVW8+mq4t9D
         EoxjeNzv6SKCJIyjdMnyCDjr6hYoOobOYqY/aUQbF+3zXj6KT/9IQGtGtvuzgveMoLCW
         G8EsRwgIJlK8Xm2BtHu0on4/7TSTroHC73GYXW4ocORzRxZzUloPe/hc/gtk0cGpywWK
         BEknmi3ezbI59KiIU+aJR0UBWtEjLIdQLouzopG+9LsvmDgcXsGOuZhRiVab0X6Ccvg8
         b9/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWslqt0yirWc/cbIz740Sq/E+U9zigoSTajTwneITvcRx486rvO1u9bHsnpB18/wnm//BZR8u7t8dXRilKK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqt+HyZ4+mSUdhNubPiSN0kXPvitTFAlQ7O9vYQp3XlHJQmBNS
	owE6W1AgviCefaQ+78ePDkvH0UBMlblTXYuKMqrwcHUAEAurMWNgWnR4PfsC+zBajfVlZPrk7Jk
	zk6ieJQN50ey8th2wO0pG1YL97SY2oTwAJh6Wn3LqWOXy/xrYGsy1I87RpYA=
X-Google-Smtp-Source: AGHT+IGZtN7D7GDSq6+QmOMHdUeXYuQSIaqFTLN3i8AbZYpD0A34pasBBs0edQ7Tk2OD8K/HxZv1AKt4IMGAdh3RqRclfDh0L96e
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3712:b0:3e2:a139:9489 with SMTP id
 e9e14a558f8ab-3e3c52b04bemr247660665ab.11.1753788390498; Tue, 29 Jul 2025
 04:26:30 -0700 (PDT)
Date: Tue, 29 Jul 2025 04:26:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6888afe6.050a0220.f0410.0005.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in driver_remove_file
From: syzbot <syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89be9a83ccf1 Linux 6.16-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1759ab82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f175a9275d2cdd7
dashboard link: https://syzkaller.appspot.com/bug?extid=a56aa983ce6a1bf12485
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34b3f6e5e365/disk-89be9a83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/55356b071589/vmlinux-89be9a83.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5daf2522b291/bzImage-89be9a83.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in sysfs_remove_file_ns+0x63/0x70 fs/sysfs/file.c:522
Read of size 8 at addr ffff88802a853e30 by task syz.4.3387/21366

CPU: 1 UID: 0 PID: 21366 Comm: syz.4.3387 Not tainted 6.16.0-rc7-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x610 mm/kasan/report.c:480
 kasan_report+0xe0/0x110 mm/kasan/report.c:593
 sysfs_remove_file_ns+0x63/0x70 fs/sysfs/file.c:522
 sysfs_remove_file include/linux/sysfs.h:777 [inline]
 driver_remove_file drivers/base/driver.c:201 [inline]
 driver_remove_file+0x4a/0x60 drivers/base/driver.c:197
 remove_bind_files drivers/base/bus.c:605 [inline]
 bus_remove_driver+0x224/0x2c0 drivers/base/bus.c:743
 driver_unregister+0x76/0xb0 drivers/base/driver.c:277
 comedi_device_detach+0x13d/0x9e0 drivers/comedi/drivers.c:207
 do_devconfig_ioctl+0x46c/0x580 drivers/comedi/comedi_fops.c:833
 comedi_unlocked_ioctl+0x165d/0x2f00 drivers/comedi/comedi_fops.c:2156
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f61c4b8e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f61c5a94038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f61c4db6160 RCX: 00007f61c4b8e9a9
RDX: 0000000000000000 RSI: 0000000040946400 RDI: 000000000000000c
RBP: 00007f61c4c10d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f61c4db6160 R15: 00007ffc33564208
 </TASK>

Allocated by task 21140:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4328 [inline]
 __kmalloc_noprof+0x223/0x510 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 security_inode_init_security+0x13f/0x390 security/security.c:1829
 shmem_mknod+0x22e/0x450 mm/shmem.c:3851
 lookup_open.isra.0+0x11d3/0x1580 fs/namei.c:3717
 open_last_lookups fs/namei.c:3816 [inline]
 path_openat+0x893/0x2cb0 fs/namei.c:4052
 do_filp_open+0x20b/0x470 fs/namei.c:4082
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 21140:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4842
 security_inode_init_security+0x2eb/0x390 security/security.c:1856
 shmem_mknod+0x22e/0x450 mm/shmem.c:3851
 lookup_open.isra.0+0x11d3/0x1580 fs/namei.c:3717
 open_last_lookups fs/namei.c:3816 [inline]
 path_openat+0x893/0x2cb0 fs/namei.c:4052
 do_filp_open+0x20b/0x470 fs/namei.c:4082
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802a853e00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 48 bytes inside of
 freed 256-byte region [ffff88802a853e00, ffff88802a853f00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a852
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b841b40 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b841b40 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000001 ffffea0000aa1481 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5826, tgid 5826 (syz-executor), ts 73000958408, free_ts 72989579897
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x1321/0x3890 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:4959
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab mm/slub.c:2619 [inline]
 new_slab+0x23b/0x330 mm/slub.c:2673
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3859
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 lsm_blob_alloc+0x68/0x90 security/security.c:684
 lsm_superblock_alloc security/security.c:862 [inline]
 security_sb_alloc+0x28/0x230 security/security.c:1409
 alloc_super+0x23d/0xbd0 fs/super.c:347
 sget_fc+0x116/0xc20 fs/super.c:761
 vfs_get_super fs/super.c:1320 [inline]
 get_tree_nodev+0x28/0x190 fs/super.c:1344
 vfs_get_tree+0x8b/0x340 fs/super.c:1804
 do_new_mount fs/namespace.c:3902 [inline]
 path_mount+0x1414/0x2020 fs/namespace.c:4226
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount fs/namespace.c:4427 [inline]
 __x64_sys_mount+0x28d/0x310 fs/namespace.c:4427
page last free pid 5824 tgid 5824 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0x7fe/0x1180 mm/page_alloc.c:2706
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_node_noprof+0x1d5/0x3b0 mm/slub.c:4249
 __alloc_skb+0x2b2/0x380 net/core/skbuff.c:660
 alloc_skb include/linux/skbuff.h:1336 [inline]
 nlmsg_new include/net/netlink.h:1041 [inline]
 netlink_ack+0x15d/0xb80 net/netlink/af_netlink.c:2489
 netlink_rcv_skb+0x332/0x420 net/netlink/af_netlink.c:2558
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x58d/0x850 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 __sys_sendto+0x4a0/0x520 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2183
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802a853d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802a853d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802a853e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88802a853e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a853f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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

