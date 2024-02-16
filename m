Return-Path: <linux-fsdevel+bounces-11840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8E7857A16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 11:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B87E1F224B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 10:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397CE2031A;
	Fri, 16 Feb 2024 10:15:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC7200C9
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078519; cv=none; b=ufAmWRCGvk1LdvJNVdz9DY3zguA4wGlWbGDzqEUGxqixWvEmPMEWUdCfCByKNrhxIdfdi/0x65KoUydFSUq77oVnnSGGiN15B1Q29fWVPyXaHBNyaMrvRZ25xoJLPXrAxPZKnt1vOy8Vmn41ISMgIS7GQdbFp1VlhyjbQOliR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078519; c=relaxed/simple;
	bh=YwoKoOd80tW8+Pr0Ieo+G1+Gv97JTqZHAZl7BOs2kAI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bCpAl9k/zzCWWRBwJc5MR7xK49sk9hdQV+Y2g6LJNE5F57GLDtiYrPaJEubu3meF6S9fzSoIt1D+6q/B9aRz4RYMKAejlQPOGF4ZsnTm5jh7w3tyulj7BD2/OdSt1zu76/1NGYdaxkMSwdKlajENzs+hLJKtME8LlzzswMgd/2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-364f951ecc1so11049095ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 02:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708078517; x=1708683317;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=moQ8sFKtLQoeo5n8lLiIU+t/1UYmC2uUZEV0FOvabRg=;
        b=WLW7erd34zMHh8cYfd9fqGkOgfta6fD27odvMqjL4sdxLZSJT6JNrEeZUWgotyGDx2
         2SQHJnT/gbzpZ1lIkSwYDYcBxB8/qn8zDoM0LMYnEopNt1kiaavRxN1r7CWmztfZntVs
         bILcfZNXs0y4DYp9CN9iSS8hH4+2I9j1ze1zESnTOSTtpz/+s4ryU8imG6225ZY7ouho
         /8OJWLQBPKfsncqW0MInlAklTa8L7T2eSsu0KNO8hZG+gp0EgEkXTr0/JoK4+8Tj8rw8
         Xqs6542fP9PpOf4G1HSDL5OQ7QQuqTPTjPuTCicHyOdIn6pSmtT/BeNHJQuhRHg9L/vW
         GaIA==
X-Forwarded-Encrypted: i=1; AJvYcCVdhMA9ysCT2xKIDomPnKXJpFEGnS9R+dJmMke7uBklIxXQAMj6CM5IbTxoV5PdVuxGl3mW2Zyi8ZueQDfmJSSpkwqMIMaoBBSTdWkmBQ==
X-Gm-Message-State: AOJu0Yz2i1gMF3pAP6dQuHuslcMmGbc5YQU6shq5Vj9GgecdcFYCvBhx
	Ue6OQp5X6LlKsFNov+orGmcs1uhGZXMWpgQoSoae0sVc9LAXtcnVp66Lz8ZueJ7BLJyZwv4Rxy4
	m4tI10MqAqCshygG1+GYxaG4M6YiUPcCCuRQ0QjdDtAt8sCw4DqY4Ny0=
X-Google-Smtp-Source: AGHT+IHfgUdZ/18YJvY6CyzoGnjWgo2xRyJJDfLy4KvLjGEvHkhLD3H+6Pmt6jbGmCXLh6l9l1ZgXKJ0R/FdYZ5JUxbWX+BsrH5A
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24c:0:b0:363:c25b:75e7 with SMTP id
 k12-20020a92c24c000000b00363c25b75e7mr264141ilo.3.1708078517203; Fri, 16 Feb
 2024 02:15:17 -0800 (PST)
Date: Fri, 16 Feb 2024 02:15:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000443bc506117d05c1@google.com>
Subject: [syzbot] [kernfs?] KASAN: slab-use-after-free Read in kernfs_get
From: syzbot <syzbot+615e0ade319f27aeab87@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c58494180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=615e0ade319f27aeab87
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d430539932db/disk-4f5e5092.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6369586e33b7/vmlinux-4f5e5092.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c1e38f80254/bzImage-4f5e5092.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+615e0ade319f27aeab87@syzkaller.appspotmail.com

usb 4-1: Direct firmware load for ueagle-atm/adi930.fw failed with error -2
usb 4-1: Falling back to sysfs fallback for: ueagle-atm/adi930.fw
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in kernfs_get+0x20/0x90 fs/kernfs/dir.c:526
Read of size 4 at addr ffff888029e1f3e0 by task kworker/0:0/8

CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.8.0-rc4-syzkaller-00180-g4f5e5092fdbf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x167/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 kernfs_get+0x20/0x90 fs/kernfs/dir.c:526
 sysfs_get include/linux/sysfs.h:653 [inline]
 create_dir lib/kobject.c:87 [inline]
 kobject_add_internal+0x483/0x8a0 lib/kobject.c:238
 kobject_add_varg lib/kobject.c:372 [inline]
 kobject_add+0x152/0x220 lib/kobject.c:424
 device_add+0x4b5/0xca0 drivers/base/core.c:3563
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:86 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:162 [inline]
 firmware_fallback_sysfs+0x307/0x9e0 drivers/base/firmware_loader/fallback.c:238
 _request_firmware+0xc97/0x1250 drivers/base/firmware_loader/main.c:910
 request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1161
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 8:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:314 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc+0x16f/0x340 mm/slub.c:3867
 kmem_cache_zalloc include/linux/slab.h:701 [inline]
 __kernfs_new_node+0xd8/0x880 fs/kernfs/dir.c:615
 kernfs_new_node+0x13a/0x240 fs/kernfs/dir.c:691
 kernfs_create_dir_ns+0x43/0x120 fs/kernfs/dir.c:1052
 sysfs_create_dir_ns+0x189/0x3a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x40d/0x8a0 lib/kobject.c:238
 kobject_add_varg lib/kobject.c:372 [inline]
 kobject_add+0x152/0x220 lib/kobject.c:424
 device_add+0x4b5/0xca0 drivers/base/core.c:3563
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:86 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:162 [inline]
 firmware_fallback_sysfs+0x307/0x9e0 drivers/base/firmware_loader/fallback.c:238
 _request_firmware+0xc97/0x1250 drivers/base/firmware_loader/main.c:910
 request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1161
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242

Freed by task 9:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x4e/0x60 mm/kasan/generic.c:640
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:241
 __kasan_slab_free+0x34/0x70 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kmem_cache_free+0x102/0x2a0 mm/slub.c:4363
 kernfs_put+0x2a4/0x420 fs/kernfs/dir.c:569
 __kernfs_remove+0x76e/0x880 fs/kernfs/dir.c:1499
 kernfs_remove+0x7a/0xa0 fs/kernfs/dir.c:1519
 __kobject_del+0xd1/0x300 lib/kobject.c:601
 kobject_del+0x45/0x60 lib/kobject.c:624
 device_del+0x83d/0xa30 drivers/base/core.c:3834
 usb_disconnect+0x60b/0x950 drivers/usb/core/hub.c:2295
 hub_port_connect drivers/usb/core/hub.c:5323 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5623 [inline]
 port_event drivers/usb/core/hub.c:5783 [inline]
 hub_event+0x1e62/0x50f0 drivers/usb/core/hub.c:5865
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff888029e1f3e0
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 0 bytes inside of
 freed 168-byte region [ffff888029e1f3e0, ffff888029e1f488)

The buggy address belongs to the physical page:
page:ffffea0000a787c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29e1f
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff8880162b4dc0 ffffea0001d9c7c0 0000000000000004
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 20250, tgid 20246 (syz-executor.1), ts 407489926347, free_ts 399703976306
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd17/0x13e0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 kmem_cache_alloc+0x24d/0x340 mm/slub.c:3867
 kmem_cache_zalloc include/linux/slab.h:701 [inline]
 __kernfs_new_node+0xd8/0x880 fs/kernfs/dir.c:615
 kernfs_new_node+0x13a/0x240 fs/kernfs/dir.c:691
 __kernfs_create_file+0x49/0x2f0 fs/kernfs/file.c:1025
 sysfs_add_file_mode_ns+0x24a/0x310 fs/sysfs/file.c:307
 create_files fs/sysfs/group.c:64 [inline]
 internal_create_group+0x4f4/0xf20 fs/sysfs/group.c:152
 internal_create_groups fs/sysfs/group.c:192 [inline]
 sysfs_create_groups+0x56/0x120 fs/sysfs/group.c:218
 device_add_groups drivers/base/core.c:2727 [inline]
 device_add_attrs+0x199/0x600 drivers/base/core.c:2847
 device_add+0x57d/0xca0 drivers/base/core.c:3579
 netdev_register_kobject+0x17e/0x310 net/core/net-sysfs.c:2055
page last free pid 55 tgid 55 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 kasan_depopulate_vmalloc_pte+0x74/0x90 mm/kasan/shadow.c:415
 apply_to_pte_range mm/memory.c:2619 [inline]
 apply_to_pmd_range mm/memory.c:2663 [inline]
 apply_to_pud_range mm/memory.c:2699 [inline]
 apply_to_p4d_range mm/memory.c:2735 [inline]
 __apply_to_page_range+0x8ec/0xe40 mm/memory.c:2769
 kasan_release_vmalloc+0x9a/0xb0 mm/kasan/shadow.c:532
 __purge_vmap_area_lazy+0x163f/0x1a10 mm/vmalloc.c:1770
 drain_vmap_area_work+0x40/0xd0 mm/vmalloc.c:1804
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff888029e1f280: fb fb fb fc fc fc fc fc fc fc fc fc fc fb fb fb
 ffff888029e1f300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888029e1f380: fb fb fc fc fc fc fc fc fc fc fc fc fa fb fb fb
                                                       ^
 ffff888029e1f400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029e1f480: fb fc fc fc fc fc fc fc fc fc fc 00 00 00 00 00
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

