Return-Path: <linux-fsdevel+bounces-15823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7B9893A72
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 12:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF10E1C213A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311812030A;
	Mon,  1 Apr 2024 10:53:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D92200AE
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968815; cv=none; b=fuqVBR2rfT23s4wl0eleL4rRAw8AXHkgHiKsTbQFnasXhT0im8Qz/ERPKgg+rspFYQPCdCdExmq5bz8ncdIthogNz/okTHzzqEwR/sO9MzKf+L9FfyaacGTqW4s/mGVOr+2yTYieQwHcPuOEA6i3WoWV+apUS9u+/dEWc9UTpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968815; c=relaxed/simple;
	bh=kv32nsrEB7rcOUTLUaAz7OWhbcqpYMmriF0Fu4guzCo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WXd8uolurgAdbFblfh15meDf1mgfr9M0Jw3I0aJ7Pgwzh2PAYSrG8k4xjFiBJVr0bNkT8ICczQlg5XaDbJHATIxE+yvNMYnc4V4uXXhlFPHYUkobquz3UtBEr0MVF05bUg5NKb9ChGMT2j+oHN8ZRYoXiaK01r1gGkOHmA8Z8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso315546839f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Apr 2024 03:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711968813; x=1712573613;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzMWpn2yEAx3hxhRcKzUABHsr0aarEI+Mv7dA8gLSCY=;
        b=FUZkkmN82UtSKZmX7k2GBch+DNAKvgH46vAxwtEW8wH8EUTIRETH0lYt2oLTBBl2QY
         hTS5CgalzZlfwH/8c1xYGbzEuiDzH3zTQ/zMjbD8+qw8W3FtUwbkOPZWML/AI6g9r6xC
         am7I8WYi7RvObEfPVHUcAhFDXXx2k3ez4JbqOQJle92mUccYi2jFsWZgR06igituYquF
         KjpxvHC0BVzcyPujxwjyAlbyJ+mkwd3+Qlqrl28g6zhOsM7A/nnTmSvBKyUpkA7nyZJg
         oMKaPDowQAn5prLEam9nKBtnyiEvRIUZbwQi0FO7Wklb4H4f10wQj85HsM8xIC3YBCmj
         ffpA==
X-Forwarded-Encrypted: i=1; AJvYcCX8B6jig0+KRGxLJ+DKuV2ZUDSJHUt/9eb7TNQ46aXjT272PpsrucMrncXMLf1Q7r2CdEyr+4XL4un6eNu9k2nlXf3jyFEN1Jt94oTryQ==
X-Gm-Message-State: AOJu0YwSkRIX/sMe0gLH/eHNeurewxEJkRtTLpwzaLm/uWmhOmQxk7r2
	n4z+I1KzI4BKs1/5BrmbhD/eL2gC2PpMD6hPSwByEALDbsEgShrfQKJn0dC1fFpWLN83LfNBiyx
	ftJHaER+eSGW7nGIIfoM4Q7DvLwjrZBsqk7thmCvHFk+W1qBaRF8udGk=
X-Google-Smtp-Source: AGHT+IGbTbdfMY2yomlDYTHHwg4Lvh+72qLCrKXLbVchyUM+5fT8vM6ZGs53/YnUgd17ASFcAfXcrpf2v/ctPzDQ6D9SkeMDfu4q
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:272a:b0:47e:dba9:59c4 with SMTP id
 m42-20020a056638272a00b0047edba959c4mr603838jav.1.1711968813381; Mon, 01 Apr
 2024 03:53:33 -0700 (PDT)
Date: Mon, 01 Apr 2024 03:53:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd0f2a061506cc93@google.com>
Subject: [syzbot] [kernfs?] KASAN: slab-out-of-bounds Read in wb_writeback
From: syzbot <syzbot+7b219b86935220db6dd8@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a6bd6c933339 Add linux-next specific files for 20240328
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=122c4ffd180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0058bda1436e073
dashboard link: https://syzkaller.appspot.com/bug?extid=7b219b86935220db6dd8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c1618ff7d25/disk-a6bd6c93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/875519f620fe/vmlinux-a6bd6c93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad92b057fb96/bzImage-a6bd6c93.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7b219b86935220db6dd8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __lock_acquire+0x78/0x1fd0 kernel/locking/lockdep.c:5005
Read of size 8 at addr ffff888023263fa8 by task kworker/u8:0/10

CPU: 0 PID: 10 Comm: kworker/u8:0 Not tainted 6.9.0-rc1-next-20240328-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __lock_acquire+0x78/0x1fd0 kernel/locking/lockdep.c:5005
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 wb_writeback+0x66f/0xd30 fs/fs-writeback.c:2160
 wb_do_writeback fs/fs-writeback.c:2274 [inline]
 wb_workfn+0x410/0x1090 fs/fs-writeback.c:2314
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 8:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4048 [inline]
 kmalloc_node_track_caller_noprof+0x22a/0x450 mm/slub.c:4068
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:599
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1318 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x254/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Freed by task 8:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2180 [inline]
 slab_free mm/slub.c:4363 [inline]
 kfree+0x149/0x350 mm/slub.c:4484
 skb_kfree_head net/core/skbuff.c:1096 [inline]
 skb_free_head net/core/skbuff.c:1108 [inline]
 skb_release_data+0x585/0x870 net/core/skbuff.c:1136
 skb_release_all net/core/skbuff.c:1202 [inline]
 __kfree_skb net/core/skbuff.c:1216 [inline]
 consume_skb+0xb3/0x160 net/core/skbuff.c:1432
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:821 [inline]
 nsim_dev_trap_report_work+0x765/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

The buggy address belongs to the object at ffff888023262000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 4008 bytes to the right of
 allocated 4096-byte region [ffff888023262000, ffff888023263000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x23260
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000040(head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffefff(slab)
raw: 00fff80000000040 ffff888015042140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001ffffefff 0000000000000000
head: 00fff80000000040 ffff888015042140 dead000000000100 dead000000000122
head: 0000000000000000 0000000000040004 00000001ffffefff 0000000000000000
head: 00fff80000000003 ffffea00008c9801 ffffea00008c9848 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 393129986 (swapper/0), ts 1, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1487
 prep_new_page mm/page_alloc.c:1495 [inline]
 get_page_from_freelist+0x2e8a/0x2f40 mm/page_alloc.c:3454
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4712
 __alloc_pages_node_noprof include/linux/gfp.h:244 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:271 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2249
 allocate_slab+0x5a/0x2e0 mm/slub.c:2412
 new_slab mm/slub.c:2465 [inline]
 ___slab_alloc+0xea8/0x1430 mm/slub.c:3599
 __slab_alloc+0x58/0xa0 mm/slub.c:3684
 __slab_alloc_node mm/slub.c:3737 [inline]
 slab_alloc_node mm/slub.c:3915 [inline]
 kmalloc_trace_noprof+0x1d5/0x2b0 mm/slub.c:4074
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:775 [inline]
 kobject_uevent_env+0x28b/0x8e0 lib/kobject_uevent.c:525
 driver_register+0x2d6/0x320 drivers/base/driver.c:254
 do_one_initcall+0x248/0x880 init/main.c:1244
 do_initcall_level+0x157/0x210 init/main.c:1306
 do_initcalls+0x3f/0x80 init/main.c:1322
 kernel_init_freeable+0x435/0x5d0 init/main.c:1555
 kernel_init+0x1d/0x2b0 init/main.c:1444
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888023263e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888023263f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888023263f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                  ^
 ffff888023264000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888023264080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

