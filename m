Return-Path: <linux-fsdevel+bounces-19659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F98A8C85B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 13:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554C6285354
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC073E47F;
	Fri, 17 May 2024 11:31:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE77208D1
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945490; cv=none; b=BOTeYFfDLYCq+g8W92rMGPKqqpC02s+O6OV/lSeaYVZDVBWgY7Nv0U/h9IO8UhQ13rZueygpw7Q6ufON6DijjgTKkYAjaQUbKUyvmMDp2R8hujzPR8SvXBlO3Aps4Ef5hSZa8NVrX6uP4RfyFJsiqmb9Hep6evMfR89sjBnTggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945490; c=relaxed/simple;
	bh=OZWric8mrBhkdn0L55LZVVwhwJqlYAwEdDvMHFeNQEo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aYTejhCqGbaXGZ7nDmVPn2RE/zryT76I2O+fwOAzIA98N/0on0eLScP+1TrYAmBqz4cmCREsrMzPdl4bVIDylLBdaVjb45rZCuEoeM0NmfJKF2xSj0Vh6SPVnn3cWM7AiYVFpZHKANfvE6jM0yY7Wt7Lbf4qck+exD59T1CFTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e1b65780b7so965287939f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 04:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715945488; x=1716550288;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZxUDwrr5/TxU4rBBf+NSSt/L9HH+2KztHflvEazFfU=;
        b=MkCZR+Qm1xOUAkImG79fJUyYSE2zqZ4Gu+YUdQjfHx2gD67QoQOUVdy1WjrZG+O7R3
         BOxSEAwJeY6XrBypTn3ZsYkjsdFQj8Sr6WSTXR3FUPo7cx2hF6fj+jEjE8w3rwm7qKtb
         m7VCDBmi83kTIc56TzTnSbRVlMHK7Qp/kO0iRuC12kmCfWOB3OZrI8xKFW5AH0+Q66Bc
         Ps7HVkn9x3kR3fYGNajR4NYBK7/alSptcnA0EsRWoe08mzsC9g422frnZQkkCzb2dL/h
         FzNzsTeWF56nYKkze6Lsx5bqWG2AnadsjNygp7VZKODnpxbLSEn85MBkCsNrz6hfA9ya
         eKhA==
X-Forwarded-Encrypted: i=1; AJvYcCVTslr0H3FvGS0nQCKvZGRjT1C3BXVk6Rvn9isWQZh1A3CEpQle5ijX2b/7UFlnKg1zGsxIe3kKHqR+TBCR8rwaGeeCmo2BYcpUpevEMw==
X-Gm-Message-State: AOJu0YybTHx6JtmDeQgYcMJaCbATfizPxXTvEpGhNlF6Ndfun52J/mJ1
	SPWDreyg2gASgr1R6H+72qmWNfFJB9qOQV6m7Vqs9ZvDz7YHOPbz/faXP+Op2KTMfBsc2zfK5jO
	Gi0v7i6W/WimXZuNTWoYH8zqa6/MAfG62+PVZgK1t11tf5duUocjSVt8=
X-Google-Smtp-Source: AGHT+IGJTsW6Og/gIggguEr5/fkXN/TtZz0N+aE0r7+mXy5dbh1GYM0xKwN7D6Zs61D5QDox1pl9rIOpCA3fnmjOoBNgYRh74B24
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3ca:b0:7de:e175:fd2d with SMTP id
 ca18e2360f4ac-7e1b521f29dmr178113239f.3.1715945488347; Fri, 17 May 2024
 04:31:28 -0700 (PDT)
Date: Fri, 17 May 2024 04:31:28 -0700
In-Reply-To: <000000000000b86c5e06130da9c6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049897e0618a4b1ff@google.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
From: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ea5f6ad9ad96 Merge tag 'platform-drivers-x86-v6.10-1' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17340168980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1cd4092753f97c5
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c7a495a5e466c031b6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1065b4f0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11df3084980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-ea5f6ad9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a551265cc1bb/vmlinux-ea5f6ad9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b814900d9571/bzImage-ea5f6ad9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com

9pnet: Found fid 3 not clunked
==================================================================
BUG: KASAN: slab-use-after-free in p9_fid_destroy+0xb5/0xd0 net/9p/client.c:885
Read of size 8 at addr ffff888023d14a00 by task syz-executor145/5220

CPU: 3 PID: 5220 Comm: syz-executor145 Not tainted 6.9.0-syzkaller-08284-gea5f6ad9ad96 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 p9_fid_destroy+0xb5/0xd0 net/9p/client.c:885
 p9_client_destroy+0x14c/0x480 net/9p/client.c:1071
 v9fs_session_close+0x49/0x2d0 fs/9p/v9fs.c:506
 v9fs_kill_super+0x4d/0xa0 fs/9p/vfs_super.c:196
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f373e54ddb7
Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe809881b8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f373e54ddb7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe80988270
RBP: 00007ffe80988270 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffe809892e0
R13: 0000555582e557c0 R14: 431bde82d7b634db R15: 00007ffe80989300
 </TASK>

Allocated by task 10647:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 p9_fid_create+0x45/0x470 net/9p/client.c:854
 p9_client_walk+0xc6/0x550 net/9p/client.c:1155
 clone_fid fs/9p/fid.h:23 [inline]
 v9fs_fid_clone fs/9p/fid.h:33 [inline]
 v9fs_file_open+0x5b5/0xae0 fs/9p/vfs_file.c:56
 do_dentry_open+0x8da/0x18c0 fs/open.c:955
 do_open fs/namei.c:3650 [inline]
 path_openat+0x1dfb/0x2990 fs/namei.c:3807
 do_filp_open+0x1dc/0x430 fs/namei.c:3834
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_creat fs/open.c:1497 [inline]
 __se_sys_creat fs/open.c:1491 [inline]
 __x64_sys_creat+0xcd/0x120 fs/open.c:1491
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1091:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4353 [inline]
 kfree+0x129/0x3a0 mm/slub.c:4463
 p9_client_clunk+0x12a/0x170 net/9p/client.c:1457
 p9_fid_put include/net/9p/client.h:280 [inline]
 v9fs_free_request+0xdc/0x110 fs/9p/vfs_addr.c:138
 netfs_free_request+0x22c/0x690 fs/netfs/objects.c:133
 netfs_put_request+0x19b/0x1f0 fs/netfs/objects.c:165
 netfs_write_collection_worker+0x19d0/0x59e0 fs/netfs/write_collect.c:701
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888023d14a00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes inside of
 freed 96-byte region [ffff888023d14a00, ffff888023d14a60)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x23d14
anon flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888015442280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 12927324375, free_ts 10880195922
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3317
 __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2190 [inline]
 allocate_slab mm/slub.c:2353 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2406
 ___slab_alloc+0xd28/0x1810 mm/slub.c:3592
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3682
 __slab_alloc_node mm/slub.c:3735 [inline]
 slab_alloc_node mm/slub.c:3908 [inline]
 kmalloc_trace+0x306/0x340 mm/slub.c:4065
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 dev_pm_qos_expose_flags+0x96/0x310 drivers/base/power/qos.c:782
 usb_hub_create_port_device+0x8fd/0xde0 drivers/usb/core/port.c:812
 hub_configure drivers/usb/core/hub.c:1710 [inline]
 hub_probe+0x1e31/0x3210 drivers/usb/core/hub.c:1965
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
page last free pid 62 tgid 62 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2487
 vfree+0x181/0x7a0 mm/vmalloc.c:3340
 delayed_vfree_work+0x56/0x70 mm/vmalloc.c:3261
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888023d14900: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff888023d14980: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
>ffff888023d14a00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                   ^
 ffff888023d14a80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff888023d14b00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

