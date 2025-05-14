Return-Path: <linux-fsdevel+bounces-48964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD8AB6C16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 15:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A923ACCFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 13:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB7627979A;
	Wed, 14 May 2025 13:05:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1334F15AF6
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227933; cv=none; b=N9r4sCefZrTHL6YPDGpfPyMGXAVHtaKSneLaHHBkUApF9kVgQNQbEhJ1+y8yIuyUUDxo97qG8im2t+UmYIgaCTzlKcDqYZpkZb+csAE+3oPfnih6yz05/tWPQmCHcGE0RUdyN70vtZamAAxEByuupiLWYaAMqB8WttE7fISqMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227933; c=relaxed/simple;
	bh=cpCyTDo5beziu+utlCxkuqnuIUq75HoD01K56SLqUnM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ktAYbnjsY65BHRRplVYkW53b7ynpN06uHVaeUToQklTyv0np2vQ3QKD5m0tSc9jdMyYav9DCIDy8NHBZrRJI6KV11OppUhGCeQT2/oyKT15G47YN4nHjZ0cp9zOMd3f8EBgfgb+edir35ZIAsQ4TZnKP5KUIjZuDTi898P42jqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d6c613bd79so68224075ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 06:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747227931; x=1747832731;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IwWfYotB+0yx802A0hGzpAxpFJ2lXOkvxUwAU+FZXQ=;
        b=iE8mnSK2lO3P+DZfjY19DTZdXvjYyJDXkwH2RSLTXTXMdnDlMSGmG5s369HD1ZKFWr
         Zgt2oZkRw0V1TIbGiR5IlhGA87ay34gm5PBr0XHmKrFS2RESlvxMgdBCx1eD7pHb29P1
         ueHUfyW1XfLTcMKPYT6GTTAiJyhO+RAbFphvCroZ4RLZfb13l91UquU3YRk7nWGlmmXs
         IrmHSn2E3PvZEHecMWEZlBkITNXTZ4PGf8gn/e96DsK3jqjvu6OyoBjFvGbMx4npcsiT
         GlIOnTuyrLBLb5Tk0Za5YfrWXhgvXSjyelcSDLDw3CxsN985wBdNbVTy1fZgTjSl/pau
         H/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSM7D0dZqOWxUcrncFINHuZYKzOW58GNKWL2My1bonwSCQQeRXOH3+XeQG84syJ5FFIqFk1l1YjufKiKyn@vger.kernel.org
X-Gm-Message-State: AOJu0YybR4Goy+hqLj5naL16FEKh64GleZ/CF6nor2EzUOTfGiAG6jo0
	vDkgIHpLwFRxG3YZVVRORKGAVBO8LnXwvHz3pTZK+Nq6/2ODFMhEFiHkPwNwSqWuZope+PCDdXL
	rs2Tf9hUQlwWuDhD9UkBUDiduNo+J8MJkuXzi2JMZr83T8h7zlyNjbU4=
X-Google-Smtp-Source: AGHT+IFkA1MJSbq3wCRRYAvcd9YGL6ztb7ee4iMxOOFYZcmNLvyJXhNJsB7o2TZgdhk+YotBZYeIRSn5MooZ4KloDLSQHv5BnbLm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:3d3:eeec:89f3 with SMTP id
 e9e14a558f8ab-3db6f7b405bmr30783005ab.13.1747227931094; Wed, 14 May 2025
 06:05:31 -0700 (PDT)
Date: Wed, 14 May 2025 06:05:31 -0700
In-Reply-To: <682119bf.050a0220.f2294.0040.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6824951b.a00a0220.104b28.000d.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-out-of-bounds Read in iov_iter_revert
From: syzbot <syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9f35e33144ae x86/its: Fix build errors when CONFIG_MODULES=n
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16388e70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9b33a466dfee330
dashboard link: https://syzkaller.appspot.com/bug?extid=25b83a6f2c702075fcbc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1193a6f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16899cd4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9f35e331.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b18c4a4e3b8e/vmlinux-9f35e331.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae7ab8362f22/bzImage-9f35e331.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in iov_iter_revert lib/iov_iter.c:633 [inline]
BUG: KASAN: slab-out-of-bounds in iov_iter_revert+0x443/0x5a0 lib/iov_iter.c:611
Read of size 4 at addr ffff88802912a0b8 by task kworker/u32:7/1147

CPU: 1 UID: 0 PID: 1147 Comm: kworker/u32:7 Not tainted 6.15.0-rc6-syzkaller-00052-g9f35e33144ae #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 iov_iter_revert lib/iov_iter.c:633 [inline]
 iov_iter_revert+0x443/0x5a0 lib/iov_iter.c:611
 netfs_retry_write_stream fs/netfs/write_retry.c:44 [inline]
 netfs_retry_writes+0x166d/0x1a50 fs/netfs/write_retry.c:231
 netfs_collect_write_results fs/netfs/write_collect.c:352 [inline]
 netfs_write_collection_worker+0x23fd/0x3830 fs/netfs/write_collect.c:374
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5936:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x223/0x510 mm/slub.c:4339
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 tomoyo_encode2+0x100/0x3e0 security/tomoyo/realpath.c:45
 tomoyo_encode+0x29/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x18f/0x6e0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x274/0x460 security/tomoyo/file.c:822
 security_file_truncate+0x84/0x1e0 security/security.c:3146
 handle_truncate fs/namei.c:3499 [inline]
 do_open fs/namei.c:3884 [inline]
 path_openat+0xc85/0x2d40 fs/namei.c:4039
 do_filp_open+0x20b/0x470 fs/namei.c:4066
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_creat fs/open.c:1522 [inline]
 __se_sys_creat fs/open.c:1516 [inline]
 __x64_sys_creat+0xcc/0x120 fs/open.c:1516
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5936:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2380 [inline]
 slab_free mm/slub.c:4642 [inline]
 kfree+0x2b6/0x4d0 mm/slub.c:4841
 tomoyo_path_perm+0x29a/0x460 security/tomoyo/file.c:842
 security_file_truncate+0x84/0x1e0 security/security.c:3146
 handle_truncate fs/namei.c:3499 [inline]
 do_open fs/namei.c:3884 [inline]
 path_openat+0xc85/0x2d40 fs/namei.c:4039
 do_filp_open+0x20b/0x470 fs/namei.c:4066
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_creat fs/open.c:1522 [inline]
 __se_sys_creat fs/open.c:1516 [inline]
 __x64_sys_creat+0xcc/0x120 fs/open.c:1516
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802912a0a0
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 8 bytes to the right of
 allocated 16-byte region [ffff88802912a0a0, ffff88802912a0b0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2912a
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b442640 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080800080 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c00(GFP_NOIO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 13358119373, free_ts 11984335158
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab mm/slub.c:2618 [inline]
 new_slab+0x244/0x340 mm/slub.c:2672
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __do_kmalloc_node mm/slub.c:4326 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4339
 kmalloc_noprof include/linux/slab.h:909 [inline]
 usb_cache_string+0xab/0x150 drivers/usb/core/message.c:1032
 usb_enumerate_device drivers/usb/core/hub.c:2508 [inline]
 usb_new_device+0x238/0x1a20 drivers/usb/core/hub.c:2633
 register_root_hub+0x299/0x730 drivers/usb/core/hcd.c:994
 usb_add_hcd+0xaf2/0x1730 drivers/usb/core/hcd.c:2976
 dummy_hcd_probe+0x15c/0x380 drivers/usb/gadget/udc/dummy_hcd.c:2693
 platform_probe+0x102/0x1f0 drivers/base/platform.c:1404
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
page last free pid 838 tgid 838 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
 vfree+0x176/0x960 mm/vmalloc.c:3384
 delayed_vfree_work+0x56/0x70 mm/vmalloc.c:3304
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888029129f80: 00 02 fc fc 00 04 fc fc 00 04 fc fc 00 04 fc fc
 ffff88802912a000: 00 05 fc fc 00 00 fc fc 00 01 fc fc 00 01 fc fc
>ffff88802912a080: 00 01 fc fc fa fb fc fc 00 00 fc fc 00 05 fc fc
                                        ^
 ffff88802912a100: 00 01 fc fc fa fb fc fc fa fb fc fc 00 00 fc fc
 ffff88802912a180: 00 01 fc fc 00 00 fc fc 00 01 fc fc 00 01 fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

