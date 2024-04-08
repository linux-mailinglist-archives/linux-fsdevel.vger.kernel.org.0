Return-Path: <linux-fsdevel+bounces-16352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4924989BA5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 10:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 886E4B21AD6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 08:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E0D3BBD8;
	Mon,  8 Apr 2024 08:32:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD853BB22
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565148; cv=none; b=CWF1xrGCUc2kyM4M+HQMJyT1jBaAFU+hRQkxjqYoBtGVJETAAoDeUKytu696Mfl0yQs3lDJMn+ls8co40iLJ9mo2MH/JryAxyYgbJ0+7/ydB74tIQ+g3yw95fTqJgYH/UhQ9CQ5i2yV+dHRfHmVQbJFeK/MnBEZXNzMdpHLNDYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565148; c=relaxed/simple;
	bh=UqAO2LUQPyFwvadkyfFpqiDLjREN0tWa9oT8YkIiGdY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VHxhn8LhcwmFytkKqFj2qGgcr0QqWil3t5L7GPFJmqBTBpEXqto7aw1sXNWgz7enDE0CPxq3RMhcbYJqK8rz6j6tyt0D26VuGao4qmsmFlCn9Ch3l6D/Vo5Ic93VDPInOrhjolk+QVk4DA6apQaUmDS7BSjwVUe45mwqCE+LBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36a17a4b594so16973465ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Apr 2024 01:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565146; x=1713169946;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WfJH2s4q7q09e1Eer8rGmrCiWoTskoyYHuDh4o7vzoI=;
        b=oE4KWTqGmPtHrZPp9QONbUyjWcw+9WAgfeVGm8lEKEFrlSqGM/3/wYNTfTUi4vDibi
         Id88hmQuce8WH1gkgc64CRY6pbAUaCdhrR8jExi/R+6Rd9f9DNTOG7zwV9DGsUQyJJnr
         DPO7d/J1BRtshpwcl8YzIyUiUP4my0U54QRuHbelMXXFbYxkTwGl1Niooo2iM0R0Jpl4
         bJadr3HfjYMARETPkSdSbuK3fFQk3VyKKV35VvwkwH/8701rfHkfmzmXrbTSaqa07HH/
         6HWOeutMGIvZ+Cnk3K8Hl5UHWa2AzI5L2GhBZuNJjkilek/lcQi8blXMRQuglCJR022Z
         0HEw==
X-Forwarded-Encrypted: i=1; AJvYcCX2xrXH0H4TVtJwYDAwFE3lNQ8TQRRt16Af0/bL2xi7kaTuMlpNsPJBGDltP6QS4KTkPKAtvp5264tZcXhpjGI9WRSMe9K7BfNga+G7kA==
X-Gm-Message-State: AOJu0Yyt3ilvAiRHcxXJxg63EgoF6XUY3rIFyQq7eCv/hO0pH4620kgi
	K8WyLiRha22lh+kqE8MCFNjgVEbB0RmquxKi6WoQpWd1bj4JqM8IcJCkdTnfPtRRkZPFIcBo6WS
	6jpx0WFynhNjTjHVjGmXba/fmjuU8uhKFOGE9WKYEXxYDnmWMvuTbrY4=
X-Google-Smtp-Source: AGHT+IHtJLr6vpXB2ohsHYPwYj3NYb5ZEWY20Xm+3m5dvQPVw35FLQJgzvK38kNswk/XL+WEt13LaXo4QBkN5OoRUt5X9+gShd1I
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdae:0:b0:366:be6a:10b7 with SMTP id
 g14-20020a92cdae000000b00366be6a10b7mr723553ild.2.1712565146483; Mon, 08 Apr
 2024 01:32:26 -0700 (PDT)
Date: Mon, 08 Apr 2024 01:32:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000360ae3061591a5b0@google.com>
Subject: [syzbot] [jffs2?] KASAN: slab-use-after-free Read in jffs2_erase_pending_blocks
From: syzbot <syzbot+5a281fe8aadf8f11230d@syzkaller.appspotmail.com>
To: dwmw2@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118f139d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=5a281fe8aadf8f11230d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a281fe8aadf8f11230d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:587 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0xfe/0xd70 kernel/locking/mutex.c:752
Read of size 8 at addr ffff888057f46408 by task jffs2_gcd_mtd0/5606

CPU: 1 PID: 5606 Comm: jffs2_gcd_mtd0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __mutex_lock_common kernel/locking/mutex.c:587 [inline]
 __mutex_lock+0xfe/0xd70 kernel/locking/mutex.c:752
 jffs2_erase_pending_blocks+0x275/0x2740 fs/jffs2/erase.c:148
 jffs2_garbage_collect_pass+0x6b3/0x2120 fs/jffs2/gc.c:253
 jffs2_garbage_collect_thread+0x651/0x6e0 fs/jffs2/background.c:155
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 5603:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1db/0x360 mm/slub.c:3997
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 jffs2_init_fs_context+0x4f/0xc0 fs/jffs2/super.c:313
 alloc_fs_context+0x68a/0x800 fs/fs_context.c:318
 do_new_mount+0x160/0xb40 fs/namespace.c:3331
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Freed by task 5070:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x14a/0x380 mm/slub.c:4390
 deactivate_locked_super+0xc4/0x130 fs/super.c:472
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:108 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x168/0x360 kernel/entry/common.c:212
 do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff888057f46000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1032 bytes inside of
 freed 4096-byte region [ffff888057f46000, ffff888057f47000)

The buggy address belongs to the physical page:
page:ffffea00015fd000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x57f40
head:ffffea00015fd000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888014c42140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5142, tgid 5142 (kworker/0:6), ts 68285239191, free_ts 14204308371
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc_node_track_caller+0x2d6/0x4e0 mm/slub.c:3986
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:599
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1318 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x254/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x95d/0xa80 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6547
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1036
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1416
 do_one_initcall+0x238/0x830 init/main.c:1241
 do_initcall_level+0x157/0x210 init/main.c:1303
 do_initcalls+0x3f/0x80 init/main.c:1319
 kernel_init_freeable+0x435/0x5d0 init/main.c:1550
 kernel_init+0x1d/0x2a0 init/main.c:1439
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Memory state around the buggy address:
 ffff888057f46300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888057f46380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888057f46400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888057f46480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888057f46500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

