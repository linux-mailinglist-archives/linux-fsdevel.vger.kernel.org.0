Return-Path: <linux-fsdevel+bounces-35965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39259DA512
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 10:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645E21628E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 09:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584581946A1;
	Wed, 27 Nov 2024 09:48:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4DC1514CE
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700914; cv=none; b=LUq4HK96HUxkMtDnaxgdLFd00IAcO2F0JXboANHRqzf860rJGdoeGBRkCcgpJFJuYwNUhjL6DUbyTJTgnCpHZksuqxVex0x5vNRvIHDHXcgD4lx/9TcUaxXGvjm/YZsv2bQilncClPxxxO7UIvyDxP/OunrneZ2kZXMI8S0+8lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700914; c=relaxed/simple;
	bh=EUjuDcDDQ7HPtObF2f8PcaVhXjo6b5keBz6dvzR2I2I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QfJXlY8PQRgJY4P55+C3Isu2rYEkmKjyHSkj+JqlN0TPGmqTXm14SHzTrYJYxTFW1XDXUPONt4C1vfonoXxSY0UUhsrlAbjlXl6VuyKPCCDNaFUQQ+zftJVDVeTkUz3QlXG71x+zow9zOapRR3Q7I7Uy9wFumOAzK3YnmPcY0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a77fad574cso62401875ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 01:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732700911; x=1733305711;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkV5MT59LrGQIDrUcEwF8zFHyzSE9f1cTn2gUDzImaU=;
        b=Xyetw4UzYWS7y25Lj2YrsudvhMan0qkDGC9izrfy78Ax/5vCcD/3YB2JgOA6bu8Oso
         XA+bfwzbstgfOzV5RhnP5BvnM8WmmumzdYG2Z8Cqk79SC4k9MYVfBRytSAda2bA/mByx
         Cga9UJS+Scra6J1E72502roJiZOrSX6ZsyYKC1Qc/8ot/dP6Yxp2WUOMlNMKS4Y1xhRT
         5Q4XZynoOt7ONrdsP3DMbWk2NRrVkUKNqfCxnVrmV+OAbxz0Gm8S8NZ0y631ltngndyw
         xOsPAVty8c1nAboehYFx7s6F+pz6lm0p3Te5V9djdElcPMeA+t70f9sMMvAaxwU6HEcx
         PKcw==
X-Gm-Message-State: AOJu0YzuRgAFhF1tRJDCXP/9BpIwTK2npfDhUB9KSwXAjF9dXTVGHzmK
	JyFYKK1UE3B8EJtl7iYzK6Qp+MaKdhkxO3DxZ7PquIL1FsYG42cO/B/Lu5WLGn+8d3Vscm6YHI9
	SpSX41UPmp24nWOs/h+DRFcY+CVmB7G1Ohs3dXI+/wriIPIMn99eystQ=
X-Google-Smtp-Source: AGHT+IHMGPI2lxO19IAe1JnHuHOdSwz5jXcdGxAhz5ytMercXDLm5ej0Q+hGVeJKYHRy0o8NhszNf0YNeXNWXb603IQMNNICBpnW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:3a7:6d14:cc18 with SMTP id
 e9e14a558f8ab-3a7c55eb991mr25749275ab.23.1732700911538; Wed, 27 Nov 2024
 01:48:31 -0800 (PST)
Date: Wed, 27 Nov 2024 01:48:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6746eaef.050a0220.21d33d.0020.GAE@google.com>
Subject: [syzbot] [hfs?] KASAN: slab-out-of-bounds Write in hfs_bnode_read
From: syzbot <syzbot+c6811fc2262cec1e6266@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1511975f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=461a3713d88227a7
dashboard link: https://syzkaller.appspot.com/bug?extid=c6811fc2262cec1e6266
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e7b78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129181c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d7a02c7a344e/disk-06afb0f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fde64ce8ab66/vmlinux-06afb0f3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/434a8f870801/bzImage-06afb0f3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3ff5f1d4d4fc/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=146c575f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=166c575f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=126c575f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6811fc2262cec1e6266@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy_from_page include/linux/highmem.h:423 [inline]
BUG: KASAN: slab-out-of-bounds in hfs_bnode_read+0xbc/0x220 fs/hfs/bnode.c:35
Write of size 94 at addr ffff888141376a80 by task syz-executor396/5845

CPU: 0 UID: 0 PID: 5845 Comm: syz-executor396 Not tainted 6.12.0-syzkaller-07834-g06afb0f36106 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 __asan_memcpy+0x3c/0x60 mm/kasan/shadow.c:106
 memcpy_from_page include/linux/highmem.h:423 [inline]
 hfs_bnode_read+0xbc/0x220 fs/hfs/bnode.c:35
 hfs_bnode_read_key+0x14e/0x1f0 fs/hfs/bnode.c:70
 hfs_brec_insert+0x66b/0xb90 fs/hfs/brec.c:159
 hfs_cat_move+0x3f0/0x7e0 fs/hfs/catalog.c:336
 hfs_rename+0xe8/0x200 fs/hfs/dir.c:299
 vfs_rename+0xf8b/0x21f0 fs/namei.c:5067
 do_renameat2+0xc5f/0xdd0 fs/namei.c:5224
 __do_sys_renameat2 fs/namei.c:5258 [inline]
 __se_sys_renameat2 fs/namei.c:5255 [inline]
 __x64_sys_renameat2+0xe7/0x130 fs/namei.c:5255
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff2c46adad9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff22f2dbd8 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff2c46adad9
RDX: 0000000000000004 RSI: 0000000020000380 RDI: 0000000000000004
RBP: 00007ff2c47215f0 R08: 0000000000000000 R09: 000055557c7724c0
R10: 0000000020000200 R11: 0000000000000246 R12: 00007fff22f2dc00
R13: 00007fff22f2de28 R14: 431bde82d7b634db R15: 00007ff2c46f603b
 </TASK>

Allocated by task 5845:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1e8/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:883 [inline]
 hfs_find_init+0x95/0x220 fs/hfs/bfind.c:21
 hfs_cat_move+0x15a/0x7e0 fs/hfs/catalog.c:301
 hfs_rename+0xe8/0x200 fs/hfs/dir.c:299
 vfs_rename+0xf8b/0x21f0 fs/namei.c:5067
 do_renameat2+0xc5f/0xdd0 fs/namei.c:5224
 __do_sys_renameat2 fs/namei.c:5258 [inline]
 __se_sys_renameat2 fs/namei.c:5255 [inline]
 __x64_sys_renameat2+0xe7/0x130 fs/namei.c:5255
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888141376a80
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes inside of
 allocated 78-byte region [ffff888141376a80, ffff888141376ace)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x141376
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000000 ffff88801b041280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 20294449508, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_noprof+0x2b4/0x300 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:879 [inline]
 kzalloc_noprof include/linux/slab.h:1015 [inline]
 dev_pm_qos_expose_flags+0x96/0x310 drivers/base/power/qos.c:783
 usb_hub_create_port_device+0x8fd/0xde0 drivers/usb/core/port.c:812
 hub_configure drivers/usb/core/hub.c:1710 [inline]
 hub_probe+0x1e1f/0x3200 drivers/usb/core/hub.c:1965
 usb_probe_interface+0x30c/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x241/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888141376980: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888141376a00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>ffff888141376a80: 00 00 00 00 00 00 00 00 00 06 fc fc fc fc fc fc
                                              ^
 ffff888141376b00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff888141376b80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

