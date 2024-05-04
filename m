Return-Path: <linux-fsdevel+bounces-18745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B212F8BBEAD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 00:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87F31C20BDD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 22:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FAC84DE9;
	Sat,  4 May 2024 22:05:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501FF83CC8
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 May 2024 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714860336; cv=none; b=PbftD+Gf37CgiSTzsKdM8Z00+I85PoZivhYJpa9mZ5bNnqUjF3DcaLnJl3VEyr86gcRClbofBjQzmRiCvbjLHHYUS7yrfWRATJpy1pKCx9Nm9kaW70jJyfia7dvnVxZm9B9IugOlGEBxQQi6tT2dZvnsllLGWME/ifqJ0kFnEn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714860336; c=relaxed/simple;
	bh=CMuFSrmFNlXUFCRIm6/MRT+EDG+h/mpKrkIIjr5g7b0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SHIrnW38TcFoBxqB2lP/CMzDtcIAwGbNk+erCec8u/LtkKqKxGtsOMwkcVYqCEP88Um9OyuBhoQM/z5q40jKAt55QF5aXnNcSbvEV6U6vrayd8iy8yzcndu/cjm+m6w409FQpO2sOp7oY/VEpCv6vVKaRiAVdLq3tNTfcyrSyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7de9c6b7a36so103381439f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 15:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714860334; x=1715465134;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6z7AisepQKp2jLpvNTL/1EZEWoPx5s5Rt9iEBRP6nY=;
        b=HnDExDs2k/AMZzCJITN5sK2WwrYMEdPOhbwoSnBlbqwqG16fd7/ERmUgxesSAJR/Nz
         7nIAX6XtP9SWg89O52eecoBUk2RKtDLSdYCglikncw+Z5Lc/WMpY04Ux2Zk0BsKSkFwf
         FcdlL/sFC9oPVrUvu4lJ7rK0Fx7Is395GUUlwa6O1Df3qStCs04kZU6cYXKtTaTZrr9/
         b7IWqA+eb/e7HOPFV3/b6wfPEaYS9DKNpB1io0NmIHePZ7T3KwR4tJfC2Pm/wPj4tsqA
         s/WICdubrEuMTtJkN+wZtqXENH2Maky8SktE4bczjx30IRLvo6KUNDEsudr2OfXElif7
         IOJA==
X-Forwarded-Encrypted: i=1; AJvYcCXQvTl4IqWOTA3EYnHMfPMQneHDRthRPB5StuG6WxNLzD5onmYgCg4pbSOF191Hcr66TcRrBWCG5AGV5ghMO/iSFPBtDFJCaXZZjYbkXA==
X-Gm-Message-State: AOJu0YwA9Gd6wzD0LQQ/4jR7Ds0kj2+dgG//+tcOwJT/zCdGfikN+1wR
	Qpv84uggSDDT/mtOTwo4EQByDaaiMMTD3r64Pw7UAD6aCVuhog5GvbOqLSXd65P5h3eecU/ssSv
	B5Olm8ho1MFfrwJcGspBonWfbCn0lO62iGwE3F5KP2o4G/GQJmrkDoJA=
X-Google-Smtp-Source: AGHT+IGkKtRMT3rv86Qv8PF7CdxrCavIuo++5NFHn/hsRDxU7023bjw4TCJ2fw5HKQDEbFFCHGAbfg1K/DvkbVcIKHRrg6WzAi4D
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c4:b0:7de:e172:3eb2 with SMTP id
 o4-20020a05660213c400b007dee1723eb2mr309586iov.1.1714860333541; Sat, 04 May
 2024 15:05:33 -0700 (PDT)
Date: Sat, 04 May 2024 15:05:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000538640617a80980@google.com>
Subject: [syzbot] [gfs2?] KASAN: stack-out-of-bounds Read in gfs2_dump_glock
From: syzbot <syzbot+7efd59a5a532c57037e6@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98369dccd2f8 Merge tag 'wq-for-6.9-rc6-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1052837f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178d4f0f180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-98369dcc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b0973ccd58a3/vmlinux-98369dcc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ce67494bf7bc/bzImage-98369dcc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5785eead10b2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7efd59a5a532c57037e6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in gfs2_dump_glock+0x18b1/0x1c80 fs/gfs2/glock.c:2406
Read of size 8 at addr ffffc9000e97fd20 by task syz-executor.3/8992

CPU: 0 PID: 8992 Comm: syz-executor.3 Not tainted 6.9.0-rc6-syzkaller-00022-g98369dccd2f8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 gfs2_dump_glock+0x18b1/0x1c80 fs/gfs2/glock.c:2406
 gfs2_consist_inode_i+0x104/0x150 fs/gfs2/util.c:456
 gfs2_dirent_scan+0x2fc/0x3c0 fs/gfs2/dir.c:602
 gfs2_dirent_search+0x459/0x5c0 fs/gfs2/dir.c:850
 gfs2_dir_search+0x98/0x2e0 fs/gfs2/dir.c:1650
 gfs2_lookupi+0x4b9/0x6f0 fs/gfs2/inode.c:340
 __gfs2_lookup+0xa1/0x290 fs/gfs2/inode.c:896
 gfs2_atomic_open+0xdd/0x240 fs/gfs2/inode.c:1297
 atomic_open fs/namei.c:3360 [inline]
 lookup_open.isra.0+0xc98/0x13c0 fs/namei.c:3468
 open_last_lookups fs/namei.c:3566 [inline]
 path_openat+0x92f/0x2990 fs/namei.c:3796
 do_filp_open+0x1dc/0x430 fs/namei.c:3826
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_open fs/open.c:1429 [inline]
 __se_sys_open fs/open.c:1425 [inline]
 __x64_sys_open+0x154/0x1e0 fs/open.c:1425
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb72827dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb728fab0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fb7283ac050 RCX: 00007fb72827dea9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200025c0
RBP: 00007fb7282ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fb7283ac050 R15: 00007ffd1c875b78
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc9000e978000, ffffc9000e981000) created by:
 kernel_clone+0xfd/0x980 kernel/fork.c:2797

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x287e1
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 8982, tgid 1444384437 (syz-executor.3), ts 8982, free_ts 287764902699
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3317
 __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
 alloc_pages_mpol+0x275/0x610 mm/mempolicy.c:2264
 vm_area_alloc_pages mm/vmalloc.c:3561 [inline]
 __vmalloc_area_node mm/vmalloc.c:3637 [inline]
 __vmalloc_node_range+0xa26/0x14b0 mm/vmalloc.c:3818
 alloc_thread_stack_node kernel/fork.c:309 [inline]
 dup_task_struct kernel/fork.c:1115 [inline]
 copy_process+0xe56/0x9090 kernel/fork.c:2220
 kernel_clone+0xfd/0x980 kernel/fork.c:2797
 __do_sys_clone3+0x1f5/0x270 kernel/fork.c:3098
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 8955 tgid 8954 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_folios+0x256/0xad0 mm/page_alloc.c:2536
 folios_put_refs+0x487/0x6d0 mm/swap.c:1034
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0xd12/0xe90 mm/truncate.c:419
 kill_bdev block/bdev.c:85 [inline]
 set_blocksize+0x2a3/0x350 block/bdev.c:161
 sb_set_blocksize+0x47/0x120 block/bdev.c:170
 init_sb+0xaa9/0x10e0 fs/gfs2/ops_fstype.c:523
 gfs2_fill_super+0x1826/0x2bf0 fs/gfs2/ops_fstype.c:1230
 get_tree_bdev+0x36f/0x610 fs/super.c:1614
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1341
 vfs_get_tree+0x8f/0x380 fs/super.c:1779
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc9000e97fc00: 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 f3 f3 00
 ffffc9000e97fc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000e97fd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
                               ^
 ffffc9000e97fd80: f1 f1 04 f3 f3 f3 00 00 00 00 00 00 00 00 00 00
 ffffc9000e97fe00: 00 00 f1 f1 f1 f1 00 00 00 00 00 00 00 00 00 00
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

