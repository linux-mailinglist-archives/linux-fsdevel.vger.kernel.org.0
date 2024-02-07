Return-Path: <linux-fsdevel+bounces-10578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0C184C681
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2741C23E0B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D9720DE5;
	Wed,  7 Feb 2024 08:44:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34D208BB
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295465; cv=none; b=c75zRNTAnS5W4jyL1W4Sxp91SLA2SRNK/uxuYb2EJvQ5xXkoMzgLDsuyqhQI+R79zArFoegzi5LhqaD9jV9wUirg+YYlQOdmRe55KvwjpTCPehy5tL8+BO7iSM0zQ8+D+2OxkbZ3aaHJ9WKRLcDH4iLLgyUaGafVcjm1BxSKI3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295465; c=relaxed/simple;
	bh=kXF+1SWOveE7F13ZT6xkBXUF2xosnAPNwsf7IsTYVE0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VQWgNtHe6N/ZGMsoLWd+6rWxG47OdFm+xNZakfCmO1Ccaxd2vbvxN+u2fyVRsNBzecGp7/Wpg8u7V9Zk8Op0QuY/1b/MvE1FaHfeeAyMxSw7J91dZROMb+Fe5kbloaS3uThXRupHKgm2HAUprEj2Gr2rTf+Err9u6YY23bsJYJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363d7d5821cso2690065ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 00:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295462; x=1707900262;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2gZsBuExxNt/ZQaIeT/QcDer15IeSIPf303fEJnFZc0=;
        b=tfIcr5TgLHHiwzArdAHcK62wwP5avVY080VeohWBNJnW0f+G8CuAWkOt1uN9zxqkWT
         XkBmHZlXyYlfZCMpjSQg2CcXE3ULtUnItKTfZ+R+1gYn98WQ0VMWyL5Sc5AZiHph+9hn
         YFZsRKEWYV14WtQ/SY0m1Yz/9lUbj+CEbDY4/1hNX03DSFneLXYQn6tpJDqGA0LbcLqb
         3tvrM+NDF/9kU68wJydy3QJF8nqyeK+XX//9ixRAy6QOh4pJWFJrVH0I7qM8GrEhBTe4
         y8q5Q01FgxZwcFIYHOrZ/ozRFz5tex2cQd0xj7xe3B2ZT47zvqAoC17oTS9DLBTkwCF4
         /jxQ==
X-Gm-Message-State: AOJu0YxpS4xj8oNNbJ+U3yCbTJ+OdVzkX3kpLN0+5n4B9kD+2g/cu/u3
	K8EAFjLf7b3ne4uzKZASZmLwn1aL1fNGev1AQ+fCwzwN+NZaQfyw7iKwuAgoaswk9NjQB+SFmKC
	erX81M9mt76l5fY1E0BA06kdDa1Wm8LqjBgaSytDmy/QNHCnbQKXE3+o=
X-Google-Smtp-Source: AGHT+IGuRv49JOThcLFReFlT+ySXgfC8Uhp+R8Mxfy3lkQfqepHrTsgUBBfXQ2aCQJ3CEe/b8RYvFCCosWRsigosSx20mQ+2Neyg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e9:b0:363:8396:a068 with SMTP id
 q9-20020a056e0220e900b003638396a068mr327995ilv.5.1707295462318; Wed, 07 Feb
 2024 00:44:22 -0800 (PST)
Date: Wed, 07 Feb 2024 00:44:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008eec060610c6b378@google.com>
Subject: [syzbot] [usb?] [fs?] KASAN: slab-use-after-free Read in comedi_release_hardware_device
From: syzbot <syzbot+cf1afeda4043ffecf03e@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ed5551279c91 Merge 6.8-rc3 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=113f3c9fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28a3704ea90ef255
dashboard link: https://syzkaller.appspot.com/bug?extid=cf1afeda4043ffecf03e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d42d8fe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/10b543a7171a/disk-ed555127.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dc10f27643e8/vmlinux-ed555127.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb6389e754b9/bzImage-ed555127.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf1afeda4043ffecf03e@syzkaller.appspotmail.com

vmk80xx 2-1:0.173: driver 'vmk80xx' failed to auto-configure device.
------------[ cut here ]------------
==================================================================
BUG: KASAN: slab-use-after-free in string_nocheck lib/vsprintf.c:646 [inline]
BUG: KASAN: slab-use-after-free in string+0x394/0x3d0 lib/vsprintf.c:728
Read of size 1 at addr ffff888103efc600 by task kworker/1:2/725

CPU: 1 PID: 725 Comm: kworker/1:2 Not tainted 6.8.0-rc3-syzkaller-00047-ged5551279c91 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 string_nocheck lib/vsprintf.c:646 [inline]
 string+0x394/0x3d0 lib/vsprintf.c:728
 vsnprintf+0xc5f/0x1870 lib/vsprintf.c:2824
 vprintk_store+0x3a0/0xb80 kernel/printk/printk.c:2187
 vprintk_emit+0x14c/0x5f0 kernel/printk/printk.c:2284
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 __warn_printk+0x181/0x350 kernel/panic.c:724
 sysfs_remove_group+0x12b/0x180 fs/sysfs/group.c:282
 dpm_sysfs_remove+0x9d/0xb0 drivers/base/power/sysfs.c:837
 device_del+0x1a8/0xa50 drivers/base/core.c:3789
 device_unregister+0x1d/0xc0 drivers/base/core.c:3855
 device_destroy+0x9a/0xd0 drivers/base/core.c:4414
 comedi_free_board_dev drivers/comedi/comedi_fops.c:611 [inline]
 comedi_free_board_dev drivers/comedi/comedi_fops.c:606 [inline]
 comedi_release_hardware_device+0x196/0x210 drivers/comedi/comedi_fops.c:3291
 comedi_auto_config+0x1f2/0x440 drivers/comedi/drivers.c:1076
 usb_probe_interface+0x307/0x9c0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
 usb_set_configuration+0x10cb/0x1c40 drivers/usb/core/message.c:2207
 usb_generic_driver_probe+0xad/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2643
 hub_port_connect drivers/usb/core/hub.c:5512 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5652 [inline]
 port_event drivers/usb/core/hub.c:5812 [inline]
 hub_event+0x2e62/0x4f40 drivers/usb/core/hub.c:5894
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 4815:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0x87/0x90 mm/kasan/common.c:389
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc_node_track_caller+0x212/0x420 mm/slub.c:4001
 kvasprintf+0xbd/0x160 lib/kasprintf.c:25
 kvasprintf_const+0x66/0x190 lib/kasprintf.c:49
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 device_create_groups_vargs+0x1b1/0x270 drivers/base/core.c:4308
 device_create+0xe9/0x120 drivers/base/core.c:4351
 comedi_alloc_board_minor+0x24c/0x3a0 drivers/comedi/comedi_fops.c:3270
 comedi_auto_config+0x74/0x440 drivers/comedi/drivers.c:1055
 usb_probe_interface+0x307/0x9c0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
 usb_set_configuration+0x10cb/0x1c40 drivers/usb/core/message.c:2207
 usb_generic_driver_probe+0xad/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2643
 hub_port_connect drivers/usb/core/hub.c:5512 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5652 [inline]
 port_event drivers/usb/core/hub.c:5812 [inline]
 hub_event+0x2e62/0x4f40 drivers/usb/core/hub.c:5894
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Freed by task 4815:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
 poison_slab_object mm/kasan/common.c:241 [inline]
 __kasan_slab_free+0x106/0x1b0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x105/0x340 mm/slub.c:4409
 kfree_const+0x55/0x60 mm/util.c:41
 kobject_cleanup lib/kobject.c:691 [inline]
 kobject_release lib/kobject.c:716 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f1/0x440 lib/kobject.c:733
 put_device+0x1f/0x30 drivers/base/core.c:3733
 comedi_dev_kref_release drivers/comedi/comedi_fops.c:117 [inline]
 kref_put include/linux/kref.h:65 [inline]
 comedi_dev_put.part.0+0xae/0xe0 drivers/comedi/comedi_fops.c:136
 comedi_dev_put drivers/comedi/comedi_fops.c:135 [inline]
 comedi_free_board_dev drivers/comedi/comedi_fops.c:614 [inline]
 comedi_free_board_dev drivers/comedi/comedi_fops.c:606 [inline]
 comedi_release_hardware_device+0x1a3/0x210 drivers/comedi/comedi_fops.c:3291
 comedi_auto_config+0x1f2/0x440 drivers/comedi/drivers.c:1076
 usb_probe_interface+0x307/0x9c0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
 usb_set_configuration+0x10cb/0x1c40 drivers/usb/core/message.c:2207
 usb_generic_driver_probe+0xad/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2643
 hub_port_connect drivers/usb/core/hub.c:5512 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5652 [inline]
 port_event drivers/usb/core/hub.c:5812 [inline]
 hub_event+0x2e62/0x4f40 drivers/usb/core/hub.c:5894
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff888103efc600
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 freed 8-byte region [ffff888103efc600, ffff888103efc608)

The buggy address belongs to the physical page:
page:ffffea00040fbf00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x103efc
flags: 0x200000000000800(slab|node=0|zone=2)
page_type: 0xffffffff()
raw: 0200000000000800 ffff888100041280 ffffea000422ff80 dead000000000004
raw: 0000000000000000 00000000002a002a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 2863822057, free_ts 2708191453
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x139c/0x3470 mm/page_alloc.c:3311
 __alloc_pages+0x228/0x2250 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2190 [inline]
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2407
 ___slab_alloc+0x4b0/0x1860 mm/slub.c:3540
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3625
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x371/0x400 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 acpi_os_allocate_zeroed include/acpi/platform/aclinuxex.h:57 [inline]
 acpi_ns_internalize_name+0x149/0x220 drivers/acpi/acpica/nsutils.c:331
 acpi_ns_get_node_unlocked+0x164/0x310 drivers/acpi/acpica/nsutils.c:666
 acpi_ns_get_node+0x4c/0x70 drivers/acpi/acpica/nsutils.c:726
 acpi_get_handle+0x106/0x270 drivers/acpi/acpica/nsxfname.c:98
 acpi_has_method+0x7b/0xb0 drivers/acpi/utils.c:663
 acpi_device_setup_files+0x2f0/0x650 drivers/acpi/device_sysfs.c:570
 acpi_device_add+0x3f9/0xbc0 drivers/acpi/scan.c:736
 acpi_add_single_object+0x966/0x1b00 drivers/acpi/scan.c:1867
 acpi_bus_check_add+0x231/0xae0 drivers/acpi/scan.c:2114
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x504/0xae0 mm/page_alloc.c:2346
 free_unref_page+0x33/0x2d0 mm/page_alloc.c:2486
 __put_partials+0x14c/0x160 mm/slub.c:2922
 qlink_free mm/kasan/quarantine.c:160 [inline]
 qlist_free_all+0x58/0x150 mm/kasan/quarantine.c:176
 kasan_quarantine_remove_cache+0x167/0x180 mm/kasan/quarantine.c:375
 kmem_cache_shrink+0xd/0x20 mm/slab_common.c:514
 acpi_os_purge_cache+0x15/0x20 drivers/acpi/osl.c:1573
 acpi_purge_cached_objects+0x86/0xf0 drivers/acpi/acpica/utxface.c:239
 acpi_initialize_objects+0x47/0xa0 drivers/acpi/acpica/utxfinit.c:250
 acpi_bus_init drivers/acpi/bus.c:1345 [inline]
 acpi_init+0x169/0xb70 drivers/acpi/bus.c:1430
 do_one_initcall+0x11c/0x650 init/main.c:1236
 do_initcall_level init/main.c:1298 [inline]
 do_initcalls init/main.c:1314 [inline]
 do_basic_setup init/main.c:1333 [inline]
 kernel_init_freeable+0x682/0xc10 init/main.c:1551
 kernel_init+0x1c/0x2a0 init/main.c:1441
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff888103efc500: fc fc fc fc fc fc fc fc fa fc fc fc fc fc fc fc
 ffff888103efc580: fc fc fc fc fa fc fc fc fc fc fc fc fc fc fc fc
>ffff888103efc600: fa fc fc fc fc fc fc fc fc fc fc fc fa fc fc fc
                   ^
 ffff888103efc680: fc fc fc fc fc fc fc fc fa fc fc fc fc fc fc fc
 ffff888103efc700: fc fc fc fc fa fc fc fc fc fc fc fc fc fc fc fc
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

