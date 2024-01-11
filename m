Return-Path: <linux-fsdevel+bounces-7813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1C482B5B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 21:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441DEB24868
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 20:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529456777;
	Thu, 11 Jan 2024 20:06:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19056767
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bb0af58117so731473339f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 12:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705003588; x=1705608388;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=znm2gwyWocE0SyT1+yWxpHNmQurOYh5H30hbOrF7BmA=;
        b=vtJdHKnuo2sedUw9f+jAPtdVHdWpPQVGppYS0ovDIxtHCLhcpmonaQqRMWc4ov+JEd
         NCqSt+qWOmS8tePyM2r3/D6N0O7ISuW6RwTVORf4cH7UgpMOE4MnbPOKQ4nLimxhpYQE
         xoWIxbK8Sdbe5tHOq3eES7NqZlp0NQWlyjsw3k/gS2S+5vAMMEDZIuGM5AzIKAYFJbbE
         9EZvBaA6/umXEtk/ydW+5mlg9CUVfwuM9DCXG5wazKRdprgH3WXUz+pVpEvMx6GH0aT8
         rHA+H/6PahyoTuMo4eB6AYs3Uog0esNIVDuOQHy/PTw0sKG2qB3EO4OtZhoOD5frPeuF
         gZHw==
X-Gm-Message-State: AOJu0YyToD+umVXpqEhl355PdisldK5L08yMfCv+RD5CKFUSPNN0/rjR
	Ci7dlk2vDcIcw6N84glpq6eISv5OhGb3l70hHp+z+gdB1Lfj
X-Google-Smtp-Source: AGHT+IHzE9vzoBADqva8JxjZp7itZuusRaJWFoFt7QqVkfmX39escRu2Y0MTvIxglW4mhRCelpDAp934jjToIAFkZADK60/BbCcY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3782:b0:46e:50ab:6a35 with SMTP id
 w2-20020a056638378200b0046e50ab6a35mr8933jal.3.1705003588212; Thu, 11 Jan
 2024 12:06:28 -0800 (PST)
Date: Thu, 11 Jan 2024 12:06:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000375f00060eb11585@google.com>
Subject: [syzbot] [nilfs?] KASAN: use-after-free Read in nilfs_set_link
From: syzbot <syzbot+4936b06b07f365af31cc@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    52b1853b080a Merge tag 'i2c-for-6.7-final' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10027331e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
dashboard link: https://syzkaller.appspot.com/bug?extid=4936b06b07f365af31cc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d62025e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c38055e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf8c17cb6cda/disk-52b1853b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7aa7b6d00e92/vmlinux-52b1853b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dbc54614504d/bzImage-52b1853b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/25a961b83aac/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=172c038de80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14ac038de80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10ac038de80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4936b06b07f365af31cc@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
==================================================================
BUG: KASAN: out-of-bounds in nilfs_set_link+0x24d/0x2e0 fs/nilfs2/dir.c:421
Read of size 2 at addr ffff888078f08008 by task syz-executor397/5051

CPU: 1 PID: 5051 Comm: syz-executor397 Not tainted 6.7.0-rc8-syzkaller-00177-g52b1853b080a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 nilfs_set_link+0x24d/0x2e0 fs/nilfs2/dir.c:421
 nilfs_rename+0x5d8/0x6b0 fs/nilfs2/namei.c:414
 vfs_rename+0xaba/0xde0 fs/namei.c:4844
 do_renameat2+0xd5a/0x1390 fs/namei.c:4996
 __do_sys_rename fs/namei.c:5042 [inline]
 __se_sys_rename fs/namei.c:5040 [inline]
 __x64_sys_rename+0x86/0x90 fs/namei.c:5040
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fb7b8290669
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd4bb0238 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fb7b8290669
RDX: 00007fb7b8290669 RSI: 0000000020000040 RDI: 0000000020000180
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000f69 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 431bde82d7b634db R15: 00007fffd4bb02a0
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001e3c200 refcount:1 mapcount:1 mapping:0000000000000000 index:0x55b79e908 pfn:0x78f08
memcg:ffff888141652000
anon flags: 0xfff000000a0028(uptodate|lru|mappedtodisk|swapbacked|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0x0()
raw: 00fff000000a0028 ffffea0001391e88 ffffea00013f1b48 ffff888029cbb001
raw: 000000055b79e908 0000000000000000 0000000100000000 ffff888141652000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5052, tgid 5052 (udevd), ts 58139256944, free_ts 52307690585
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0x33ea/0x3570 mm/page_alloc.c:3312
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4568
 alloc_pages_mpol+0x3de/0x640 mm/mempolicy.c:2133
 vma_alloc_folio+0xf3/0x3f0 mm/mempolicy.c:2172
 wp_page_copy mm/memory.c:3120 [inline]
 do_wp_page+0x125e/0x4d40 mm/memory.c:3511
 handle_pte_fault mm/memory.c:5055 [inline]
 __handle_mm_fault mm/memory.c:5180 [inline]
 handle_mm_fault+0x1b1c/0x6680 mm/memory.c:5345
 do_user_addr_fault arch/x86/mm/fault.c:1364 [inline]
 handle_page_fault arch/x86/mm/fault.c:1507 [inline]
 exc_page_fault+0x456/0x870 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x931/0xa60 mm/page_alloc.c:2347
 free_unref_page_list+0x5a0/0x840 mm/page_alloc.c:2533
 release_pages+0x2117/0x2400 mm/swap.c:1042
 tlb_batch_pages_flush mm/mmu_gather.c:98 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
 tlb_flush_mmu+0x34c/0x4e0 mm/mmu_gather.c:300
 tlb_finish_mmu+0xd4/0x1f0 mm/mmu_gather.c:392
 exit_mmap+0x4d3/0xc60 mm/mmap.c:3324
 __mmput+0x115/0x3c0 kernel/fork.c:1349
 exit_mm+0x21f/0x300 kernel/exit.c:567
 do_exit+0x9af/0x2740 kernel/exit.c:856
 do_group_exit+0x206/0x2c0 kernel/exit.c:1018
 __do_sys_exit_group kernel/exit.c:1029 [inline]
 __se_sys_exit_group kernel/exit.c:1027 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1027
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Memory state around the buggy address:
 ffff888078f07f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888078f07f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888078f08000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                         ^
 ffff888078f08080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888078f08100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

