Return-Path: <linux-fsdevel+bounces-37911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756E99F8A8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 04:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36D21660B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 03:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191EC7083C;
	Fri, 20 Dec 2024 03:24:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1B96F099
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 03:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734665065; cv=none; b=qbnC1Q9Na/Khq5C9+n6bdWND39gBUY67mcTb0wr/KJ8X5PXD56uD4UC+E1lzLHZCL8Q/tfxMOqtP0oUfsOxXBtSYZzGEThen6nB4o4ghYG0y67MqvGi3mRBmYsEMymi1FoFmexgIi4K6vdTHZfzqspVr7Laykac/pdkflzb1iE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734665065; c=relaxed/simple;
	bh=JYAOdO28n0V0JBCxDqsHS47ERaH00B8yJ8XFfKfki+0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q2UEvc0/3s2Uist+bka8rnRD6d1Ddqs9hYHN8fEioOnrTw/sbfZbzioU9LApU0fo4+XKWznX+rdPlC1xPmkXGVKkQvbfzP3aEdkOpfYAbm1+Jkn/m1UPQGqrY05FbjKCDI4dYkGGsbYoH+/iqswOb3v3IR+PVBoq8x8dUFPeV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so12694505ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 19:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734665063; x=1735269863;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnlpKMOawemiQfaos5vDvxofW2NHJWwAUGngpUkmglc=;
        b=hfU73nEitzWzoljs6tnjIJCENBQhwZ4NCZJJsDYR7zgApwE/jVqVVJJbWB6S+mVcJP
         9GPeqawt8ersYszTlsxC9HY39aIjrbPkJsAuyh5kcNpPcSfpoOqEgJXRvQHwr3g3+HTZ
         Qbd7k+u0KithaxsSiCvDxBHTnbp2Ha47EBNJKANCPJv8pmS+da7nf3kx1BSeTazDQ6Pg
         5MtCXuXXHg2A8ddgttFEL0FHVCEEwfiddqStTwKjMX9/4GORPVXAs29IN4RVjrAY9wQ5
         q/2oXMuJOTaHj4ozDtwrsuUV6Dd0Bfz1M2xXczEpyFz427yRTU1KMPlDqg9kSkiduU+n
         Cbbg==
X-Forwarded-Encrypted: i=1; AJvYcCWQfrjv3DFTBKZXpS6VfbHQkfWFkV/GsJ0ZLopCN6gDHvWCZtTas/d9M9BYf/+gqPq7vUG6vaTJ3OizPOpg@vger.kernel.org
X-Gm-Message-State: AOJu0YyUTmg0cQG4S6tii4diVHjLA/HIsLj8EXG870J4xQbrTS9BKkf5
	6pZXOS0ZWfX7Y6aPI+p1jn3dUMuE49f1/Re8b95oGCNh/B+pBiH5hvVi8QQxe0Srdj2fuKDd9gB
	ymXv5i+Qd6JEUIG59Pe9Y6EaTXSAuQ+j++p0hO4xYVRuDeh7QTSI7t9w=
X-Google-Smtp-Source: AGHT+IF5/APOUqDxqLUkVgxxM0YVWbUWYTKxXHmv9zLbe/iKkMmBeKpGccSAhmb3xa+TvjiWnOpYcQBram0yQfFsWBTnQA/Tt4AQ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ca:b0:3a7:7124:bd2c with SMTP id
 e9e14a558f8ab-3c2d51516b7mr15031315ab.19.1734665063036; Thu, 19 Dec 2024
 19:24:23 -0800 (PST)
Date: Thu, 19 Dec 2024 19:24:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6764e367.050a0220.1bfc9e.0005.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in u32_array_open
From: syzbot <syzbot+78520003923368329a20@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dccbe2047a5b Merge tag 'edac_urgent_for_v6.13_rc3' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1056d4f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=78520003923368329a20
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f847e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3dd2d72f8ca2/disk-dccbe204.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd47a26a25a4/vmlinux-dccbe204.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fe260578e831/bzImage-dccbe204.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78520003923368329a20@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in u32_array_open+0x242/0x280 fs/debugfs/file.c:1220
Read of size 4 at addr ffff888078a0d4f8 by task syz.2.5063/11560

CPU: 0 UID: 0 PID: 11560 Comm: syz.2.5063 Not tainted 6.13.0-rc2-syzkaller-00382-gdccbe2047a5b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 u32_array_open+0x242/0x280 fs/debugfs/file.c:1220
 open_proxy_open+0x27a/0x3f0 fs/debugfs/file.c:298
 do_dentry_open+0xf59/0x1ea0 fs/open.c:945
 vfs_open+0x82/0x3f0 fs/open.c:1075
 do_open fs/namei.c:3828 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3987
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3daff85d19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd0d6d44c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f3db0175fa0 RCX: 00007f3daff85d19
RDX: 0000000000000082 RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007f3db0001a20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3db0175fa0 R14: 00007f3db0175fa0 R15: 0000000000000e02
 </TASK>

Allocated by task 8644:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_node_noprof+0x21f/0x520 mm/slub.c:4304
 __kvmalloc_node_noprof+0x6f/0x1a0 mm/util.c:650
 alloc_netdev_mqs+0xc9/0x1320 net/core/dev.c:11209
 nsim_create+0x98/0xb20 drivers/net/netdevsim/netdev.c:777
 __nsim_dev_port_add+0x3bf/0x700 drivers/net/netdevsim/dev.c:1393
 nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1449 [inline]
 nsim_drv_probe+0xdbf/0x1490 drivers/net/netdevsim/dev.c:1607
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3665
 nsim_bus_dev_new drivers/net/netdevsim/bus.c:442 [inline]
 new_device_store+0x41d/0x730 drivers/net/netdevsim/bus.c:173
 bus_attr_store+0x71/0xb0 drivers/base/bus.c:172
 sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 35:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4761
 kvfree+0x47/0x50 mm/util.c:693
 device_release+0xa1/0x240 drivers/base/core.c:2567
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3773
 free_netdev+0x4f1/0x6c0 net/core/dev.c:11378
 __nsim_dev_port_del+0x189/0x240 drivers/net/netdevsim/dev.c:1428
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1440 [inline]
 nsim_dev_reload_destroy+0x108/0x4d0 drivers/net/netdevsim/dev.c:1661
 nsim_dev_reload_down+0x6e/0xd0 drivers/net/netdevsim/dev.c:968
 devlink_reload+0x17f/0x760 net/devlink/dev.c:461
 devlink_pernet_pre_exit+0x1a1/0x2b0 net/devlink/core.c:509
 ops_pre_exit_list net/core/net_namespace.c:162 [inline]
 cleanup_net+0x488/0xbd0 net/core/net_namespace.c:628
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888078a0c000
 which belongs to the cache kmalloc-cg-8k of size 8192
The buggy address is located 5368 bytes inside of
 freed 8192-byte region [ffff888078a0c000, ffff888078a0e000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x78a08
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888026a1b1e1
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac4f640 ffffea0001d3de00 0000000000000002
raw: 0000000000000000 0000000000020002 00000001f5000000 ffff888026a1b1e1
head: 00fff00000000040 ffff88801ac4f640 ffffea0001d3de00 0000000000000002
head: 0000000000000000 0000000000020002 00000001f5000000 ffff888026a1b1e1
head: 00fff00000000003 ffffea0001e28201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd60c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5943, tgid 5943 (syz-executor), ts 136312827854, free_ts 136306755133
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2269
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2589 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2642
 ___slab_alloc+0xce2/0x1650 mm/slub.c:3830
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_node_noprof+0x2f0/0x520 mm/slub.c:4304
 __kvmalloc_node_noprof+0x6f/0x1a0 mm/util.c:650
 alloc_netdev_mqs+0xc9/0x1320 net/core/dev.c:11209
 rtnl_create_link+0xbed/0xf10 net/core/rtnetlink.c:3595
 rtnl_newlink_create net/core/rtnetlink.c:3771 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3896 [inline]
 rtnl_newlink+0x14e3/0x1d70 net/core/rtnetlink.c:4011
 rtnetlink_rcv_msg+0x95b/0xea0 net/core/rtnetlink.c:6921
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1891
page last free pid 973 tgid 973 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2657
 __put_partials+0x14c/0x170 mm/slub.c:3157
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 __kmalloc_cache_noprof+0x202/0x420 mm/slub.c:4324
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 nsim_fib4_rt_create drivers/net/netdevsim/fib.c:280 [inline]
 nsim_fib4_rt_insert drivers/net/netdevsim/fib.c:426 [inline]
 nsim_fib4_event drivers/net/netdevsim/fib.c:464 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:884 [inline]
 nsim_fib_event_work+0x8dd/0x3190 drivers/net/netdevsim/fib.c:1493
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888078a0d380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888078a0d400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888078a0d480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888078a0d500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888078a0d580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

