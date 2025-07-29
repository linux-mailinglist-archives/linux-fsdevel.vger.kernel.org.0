Return-Path: <linux-fsdevel+bounces-56280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F482B154E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 23:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854DB18A08E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADC127EFE9;
	Tue, 29 Jul 2025 21:58:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D842797BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753826315; cv=none; b=CzVH+7HQxw9T8t8VC/9gc7oXvOrgJWytb68EZD6FkURmCdL89FmJX5WYqpFJngCGonJdK87CYaNfcEB+6//xFw+v4lOGE+SXwK61toJzLaewnjhd0tVM7ztj/pDV5CFxmz/g3EuP8uQlIkM6b00gP6CUZIPtFEt9BUu4eEKAdPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753826315; c=relaxed/simple;
	bh=YGlJVdwTDS4/wf/R4el6w/Jfhx67E6mQyAEfmhY06bE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CF0kWm+T0V0kC7XrDW6rVai+NGQpeS7OJ2UusCYKrJ/vX18Tb3Bbs0siZ5CBxue4oZPIwjg5JLk7UeOxrFmDCPwyS5mCnP1z6lXJ6ZgD6fc8y/scUqT1tNKJY1UcHMIDtfsd0nCQUDQ+nckrpP2gbJbpdcZGwVBWJX5Q+i/mwJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3e3cba15753so44660875ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 14:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753826313; x=1754431113;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWcHBAzXO9YXNPSjlihfmHovIVd6ArT3IkIABZmFbSc=;
        b=edVd8qGa7/9dy0lyumOwWEt3oxWuhBTujQJkUZZ4zeaw3SE/yTck87Q2hui/xhBgp1
         z5MYlsjrBn1YFco5DDiS08iwSFppAvXZd/1mSOsTCk0xc1OU9JZUy8lSUzValzCPHiHe
         THIyOAo4799N9ySueTr3dTwJcE5mMbm4/aV7sdYw06bt85Ferxt44M0xFpKC/6dqY01p
         TBacmwANbghR/ZIvD5SB/D+svbFx6yp234TK1N39aGAqtCm0UQ9vmrxPzbj3jxLVRY0a
         VEYo/VWILqAof0XAR2pUk6NbpbM/AFkOabooVpNEyVP2tWbndm9nNDu4d3uCbeVAjLrM
         2fvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+ADHg/d+N/WpMksYCxubwPKSu6xJlgJNWVn7awOjiUPqWOqSqY25S9yw36Al3BYpYHS27juyOXyOBb3sZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy47rJiBrKR6UhQJ3eTijNy6syk89r26VCAgxCMTk583QRmsgNE
	TnbQsAix8c4TwbsZ7R0NZ+LNBD9udD60jmgf2cU8tnlCfAhYvC3SwxtcjJDXHsF6BuJ9W75yji7
	NAHueUxA9xY47tzqEKmFjlcuaLuusYdi1T1nikvotCkVoNshH/qPNppKzUA4=
X-Google-Smtp-Source: AGHT+IGC4TLzjt7JTlTbuUXBTN2bx6CVEIwIXn2gVlr4RRZHaZTi7Cc+fjMOl0NFl8kf8bdmmmvmCHO9bSJQS35bkmh1JVmL2J7k
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3306:b0:3e2:9caa:7cbb with SMTP id
 e9e14a558f8ab-3e3f62021bemr17730575ab.9.1753826312989; Tue, 29 Jul 2025
 14:58:32 -0700 (PDT)
Date: Tue, 29 Jul 2025 14:58:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68894408.a00a0220.26d0e1.0013.GAE@google.com>
Subject: [syzbot] [fuse?] [block?] KASAN: slab-use-after-free Read in disk_add_events
From: syzbot <syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ced1b9e0392d Merge tag 'ata-6.17-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133b8cf0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52c12ce9080f644c
dashboard link: https://syzkaller.appspot.com/bug?extid=fa3a12519f0d3fd4ec16
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154b31bc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171a9782580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ced1b9e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c709b0d9538c/vmlinux-ced1b9e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/129af0799fa3/bzImage-ced1b9e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __list_add_valid_or_report+0x151/0x190 lib/list_debug.c:32
Read of size 8 at addr ffff888036fa1400 by task syz.2.1231/9834

CPU: 3 UID: 0 PID: 9834 Comm: syz.2.1231 Not tainted 6.16.0-syzkaller-00857-gced1b9e0392d #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 __list_add_valid_or_report+0x151/0x190 lib/list_debug.c:32
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add_tail include/linux/list.h:183 [inline]
 disk_add_events+0x90/0x170 block/disk-events.c:463
 add_disk_final block/genhd.c:427 [inline]
 add_disk_fwnode+0x3c8/0x5d0 block/genhd.c:610
 add_disk include/linux/blkdev.h:773 [inline]
 md_alloc+0x3c2/0x1080 drivers/md/md.c:5981
 md_alloc_and_put drivers/md/md.c:6016 [inline]
 md_probe drivers/md/md.c:6029 [inline]
 md_probe+0x6e/0xd0 drivers/md/md.c:6024
 blk_probe_dev+0x116/0x1a0 block/genhd.c:884
 blk_request_module+0x16/0xb0 block/genhd.c:897
 blkdev_get_no_open+0x9b/0x100 block/bdev.c:825
 blkdev_open+0x141/0x3f0 block/fops.c:684
 do_dentry_open+0x744/0x1c10 fs/open.c:965
 vfs_open+0x82/0x3f0 fs/open.c:1095
 do_open fs/namei.c:3887 [inline]
 path_openat+0x1de4/0x2cb0 fs/namei.c:4046
 do_filp_open+0x20b/0x470 fs/namei.c:4073
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4ea558e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4ea645e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f4ea57b6080 RCX: 00007f4ea558e9a9
RDX: 0000000000000000 RSI: 0000200000000a80 RDI: ffffffffffffff9c
RBP: 00007f4ea5610d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4ea57b6080 R15: 00007fff25d53038
 </TASK>

Allocated by task 9822:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 disk_alloc_events+0xf0/0x3f0 block/disk-events.c:439
 __add_disk+0x475/0xf00 block/genhd.c:500
 add_disk_fwnode+0x3f8/0x5d0 block/genhd.c:601
 add_disk include/linux/blkdev.h:773 [inline]
 md_alloc+0x3c2/0x1080 drivers/md/md.c:5981
 md_alloc_and_put drivers/md/md.c:6016 [inline]
 md_probe drivers/md/md.c:6029 [inline]
 md_probe+0x6e/0xd0 drivers/md/md.c:6024
 blk_probe_dev+0x116/0x1a0 block/genhd.c:884
 blk_request_module+0x16/0xb0 block/genhd.c:897
 blkdev_get_no_open+0x9b/0x100 block/bdev.c:825
 blkdev_open+0x141/0x3f0 block/fops.c:684
 do_dentry_open+0x744/0x1c10 fs/open.c:965
 vfs_open+0x82/0x3f0 fs/open.c:1095
 do_open fs/namei.c:3887 [inline]
 path_openat+0x1de4/0x2cb0 fs/namei.c:4046
 do_filp_open+0x20b/0x470 fs/namei.c:4073
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 9817:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4842
 disk_release+0x161/0x410 block/genhd.c:1301
 device_release+0xa1/0x240 drivers/base/core.c:2568
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e7/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3800
 blkdev_release+0x15/0x20 block/fops.c:699
 __fput+0x402/0xb70 fs/file_table.c:468
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:114
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888036fa1400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
 freed 512-byte region [ffff888036fa1400, ffff888036fa1600)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x36fa0
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b842c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b842c80 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0000dbe801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2, tgid 2 (kthreadd), ts 71482349709, free_ts 68765218476
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
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4354
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 set_kthread_struct+0xcb/0x380 kernel/kthread.c:126
 copy_process+0x3107/0x7650 kernel/fork.c:2097
 kernel_clone+0xfc/0x960 kernel/fork.c:2599
 kernel_thread+0xd4/0x120 kernel/fork.c:2661
 create_kthread kernel/kthread.c:487 [inline]
 kthreadd+0x503/0x800 kernel/kthread.c:847
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page last free pid 6016 tgid 6016 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0x7fe/0x1180 mm/page_alloc.c:2706
 vfree+0x1fd/0xb50 mm/vmalloc.c:3434
 kcov_put kernel/kcov.c:439 [inline]
 kcov_put kernel/kcov.c:435 [inline]
 kcov_close+0x34/0x60 kernel/kcov.c:535
 __fput+0x402/0xb70 fs/file_table.c:468
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x86c/0x2bd0 kernel/exit.c:964
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1105
 get_signal+0x2673/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7d0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888036fa1300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888036fa1380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888036fa1400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888036fa1480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888036fa1500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

