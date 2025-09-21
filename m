Return-Path: <linux-fsdevel+bounces-62322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F719B8D48C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 06:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DA117ADF0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 04:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D5629AAF3;
	Sun, 21 Sep 2025 04:04:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423E82F56
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Sep 2025 04:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758427471; cv=none; b=BJTYWkGBsvo6Mi8IRNFWyzD0xXhGhpqSBCErtJ59/CVzN6hW+PuRoSgPVnUiCEf7N1cSrQfDqemH0i7XD6IVQTILV/rFdr1XhDYNRiVCYA74UY6z/bEcsVHUinwMYPhJoYbp/OLQI8GScsyJyxiS3XaiTrAxndP6N10Xhe7XRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758427471; c=relaxed/simple;
	bh=uYaPhNV1/+q9/3WTZa/AM3WFWfNB8GDVijY2bznYwP0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Dqem1WJMrD68cX8aYH7BeRRBCNDdQ7KXOhNgVcGpeuXZB0YWnvRv525gSMpphC5rJtV87NTLKf9bPWHBTGxn+97beEwlPBEqvUAx8+6badnOfpQQumZJicV6rkRAqd+4+9yMDq4wK27OrW7TIRbU+IFPrtGGgGYArcoHm2JLRMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-424828985d9so22134045ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Sep 2025 21:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758427468; x=1759032268;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ND+IRyVoBRx/ziTBiFkTALgcpMRoE1+blRu9ZWJN/k=;
        b=VYcGirturV0L6wXnh7Q/N9bj8ThuAwiWOpGtcZtXEB+RwRUPJHDPEq7hCGwjj3uvnm
         AjyabUbdL/coxmB9wvE3qE80iK6kODwxJ8g1/Bw0GTYVLzW3MDH7k9rFZO+WlYdnFzYE
         Ptq8u8wJqGDE34+2EfcOWWv/dFQGNKKcEL7oiUs9DmW8/GnLGIbpMlPDVDbaPQiXNCvQ
         cpK6BqSR5Cz8j6buE94r1o3KwQeaX92OHj0XOtXeXDEDIhztSp+WX2UNR6d0ef8YsOxC
         I+42tIx2Z/+6Io62JGipYR5kYIYGpmfO4sW3CCScfQaUjWmXu5MGwEEJaMf8ejHKGqO4
         gqPA==
X-Forwarded-Encrypted: i=1; AJvYcCXRIWU7Sei7Yl4qTvFkIFlL6bwOSGl6R0CqWRvXrkVEjPwPtZjBBDonIyXFUHl3QQpBFjB7JkQ9D9B6hNsV@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZGltblzOK0Hp/eEbKYzLfTVcdBUlmx9UpNy8BUpWUAf/ZuDr
	049l7slAxYLXXRkNLIABbkPrUKB4AD7F4sp0k+yO+1qvj4K0lnOGlN3VMIakdk6rM2Dlm7sj8Jj
	oM+bVJ+x2tORtknhaPsG2nKDYsrqhHh3DShb64Ow+jL3cphoJrSX9KGrz428=
X-Google-Smtp-Source: AGHT+IGufy4+nfq2omegs8kz88DcjlzFd1t+cm58oaN1JU+xnapDFfsm78+qyM3U+xr/3DxJlNNOIxGUpIFkKqd1FKqMPdPU6THW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd84:0:b0:424:89fd:73d6 with SMTP id
 e9e14a558f8ab-42489fd759cmr102691455ab.14.1758427468459; Sat, 20 Sep 2025
 21:04:28 -0700 (PDT)
Date: Sat, 20 Sep 2025 21:04:28 -0700
In-Reply-To: <6888afe6.050a0220.f0410.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cf794c.050a0220.13cd81.002a.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in driver_remove_file
From: syzbot <syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3b08f56fbbb9 Merge tag 'x86-urgent-2025-09-20' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ce5858580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=a56aa983ce6a1bf12485
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15571534580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152f7e42580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/50f34afb9e37/disk-3b08f56f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/421a8470ac48/vmlinux-3b08f56f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/218f92cd0c4d/bzImage-3b08f56f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com

comedi comedi1: c6xdigio: I/O port conflict (0x401,3)
==================================================================
BUG: KASAN: slab-use-after-free in sysfs_remove_file_ns+0x63/0x70 fs/sysfs/file.c:522
Read of size 8 at addr ffff88807d7e6e30 by task syz.0.18/6035

CPU: 1 UID: 0 PID: 6035 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 sysfs_remove_file_ns+0x63/0x70 fs/sysfs/file.c:522
 sysfs_remove_file include/linux/sysfs.h:777 [inline]
 driver_remove_file drivers/base/driver.c:201 [inline]
 driver_remove_file+0x4a/0x60 drivers/base/driver.c:197
 remove_bind_files drivers/base/bus.c:605 [inline]
 bus_remove_driver+0x224/0x2c0 drivers/base/bus.c:743
 driver_unregister+0x76/0xb0 drivers/base/driver.c:277
 comedi_device_detach_locked+0x12f/0xa50 drivers/comedi/drivers.c:207
 comedi_device_detach+0x67/0xb0 drivers/comedi/drivers.c:215
 comedi_device_attach+0x43d/0x900 drivers/comedi/drivers.c:1011
 do_devconfig_ioctl+0x1b1/0x710 drivers/comedi/comedi_fops.c:872
 comedi_unlocked_ioctl+0x165d/0x2f00 drivers/comedi/comedi_fops.c:2178
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl fs/ioctl.c:584 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f623a78ec29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe5ded2158 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f623a9d5fa0 RCX: 00007f623a78ec29
RDX: 0000200000000080 RSI: 0000000040946400 RDI: 0000000000000004
RBP: 00007f623a811e41 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f623a9d5fa0 R14: 00007f623a9d5fa0 R15: 0000000000000003
 </TASK>

Allocated by task 6034:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:405
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 bus_add_driver+0x92/0x690 drivers/base/bus.c:662
 driver_register+0x15c/0x4b0 drivers/base/driver.c:249
 c6xdigio_attach drivers/comedi/drivers/c6xdigio.c:253 [inline]
 c6xdigio_attach+0xa3/0x4b0 drivers/comedi/drivers/c6xdigio.c:238
 comedi_device_attach+0x3b0/0x900 drivers/comedi/drivers.c:1007
 do_devconfig_ioctl+0x1b1/0x710 drivers/comedi/comedi_fops.c:872
 comedi_unlocked_ioctl+0x165d/0x2f00 drivers/comedi/comedi_fops.c:2178
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl fs/ioctl.c:584 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6034:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x60/0x70 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4894
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e7/0x5a0 lib/kobject.c:737
 bus_remove_driver+0x16e/0x2c0 drivers/base/bus.c:749
 driver_unregister+0x76/0xb0 drivers/base/driver.c:277
 comedi_device_detach_locked+0x12f/0xa50 drivers/comedi/drivers.c:207
 comedi_device_detach+0x67/0xb0 drivers/comedi/drivers.c:215
 comedi_device_attach+0x43d/0x900 drivers/comedi/drivers.c:1011
 do_devconfig_ioctl+0x1b1/0x710 drivers/comedi/comedi_fops.c:872
 comedi_unlocked_ioctl+0x165d/0x2f00 drivers/comedi/comedi_fops.c:2178
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl fs/ioctl.c:584 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807d7e6e00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 48 bytes inside of
 freed 256-byte region [ffff88807d7e6e00, ffff88807d7e6f00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7d7e6
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b841b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b841b40 dead000000000122 0000000000000000
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000001 ffffea0001f5f981 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5959, tgid 5959 (syz-executor), ts 73428545830, free_ts 73053846504
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x132b/0x38e0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:5148
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab mm/slub.c:2660 [inline]
 new_slab+0x247/0x330 mm/slub.c:2714
 ___slab_alloc+0xcf2/0x1750 mm/slub.c:3901
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3992
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 __list_lru_init+0xe8/0x4c0 mm/list_lru.c:588
 alloc_super+0x904/0xbd0 fs/super.c:391
 sget_fc+0x116/0xc20 fs/super.c:761
 vfs_get_super fs/super.c:1320 [inline]
 get_tree_nodev+0x28/0x190 fs/super.c:1344
 vfs_get_tree+0x8e/0x340 fs/super.c:1815
 do_new_mount fs/namespace.c:3808 [inline]
 path_mount+0x1513/0x2000 fs/namespace.c:4123
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount fs/namespace.c:4324 [inline]
 __x64_sys_mount+0x28d/0x310 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
page last free pid 6026 tgid 6026 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0x7d5/0x10f0 mm/page_alloc.c:2895
 discard_slab mm/slub.c:2758 [inline]
 __put_partials+0x165/0x1c0 mm/slub.c:3223
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_noprof+0x1cb/0x3b0 mm/slub.c:4247
 vm_area_dup+0x27/0x8d0 mm/vma_init.c:122
 __split_vma+0x18e/0x1070 mm/vma.c:515
 vms_gather_munmap_vmas+0x1d2/0x1340 mm/vma.c:1359
 __mmap_prepare mm/vma.c:2359 [inline]
 __mmap_region+0x436/0x27b0 mm/vma.c:2651
 mmap_region+0x1ab/0x3f0 mm/vma.c:2739
 do_mmap+0xa3e/0x1210 mm/mmap.c:558
 vm_mmap_pgoff+0x29e/0x470 mm/util.c:580
 ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:604
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94

Memory state around the buggy address:
 ffff88807d7e6d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807d7e6d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807d7e6e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88807d7e6e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807d7e6f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

