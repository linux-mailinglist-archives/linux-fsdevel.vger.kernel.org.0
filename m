Return-Path: <linux-fsdevel+bounces-41690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA42A35109
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 23:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19CA3A6343
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 22:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F36C26B0A0;
	Thu, 13 Feb 2025 22:14:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83F4269888
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484870; cv=none; b=ZUTSfJuKtz1Al7cAcjs8Gpy6eVfBEpuC7dzLy0bSLIxbnWfvt1geqMie8ufx5NELE5Szhx1JH9zZ+TRaC2vXOAHtAng+za4iltnIBlmaA7sRG+fmyqCqAt9Y1heXGcxyJDD1zGB3bpZ/J4BlvWlegoXn0GXcn+xi6R3XxLAcXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484870; c=relaxed/simple;
	bh=qQmmrVKod3bXQds4Y/uXH3GZLfunEBvtfmeu9i7pcZg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YRKgvSYMEvXt+ZJuUBNRCD4LNNphd2QrK0YgwLZPiVux4SQh0gHG2xU70pEa1vnQFEToEWCCAJxV97wsIa9CB9ZsGdAMJ3+JksIBh+ItVcZ6Dvm2vswWohGGwus2CbK46q+VUcyZ6JWFHkw8bVkXpjgel5kqfaAEIw/0dJo0pXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d18e28a0c1so21215005ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 14:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484868; x=1740089668;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TUvhmPawN8wBETYwgobCSF8bOQtOloFAxM6asofpf1Y=;
        b=K/oWqk48HGG6e7gIMabDHSs2g/Q2Yx1xCEcAdzrjtZjUA4aJB95NyBRlkYpiHH7GX5
         zX+q3X/8BGJDRJezfSJxp9Rt7pe4op8GZ/OYvBIs2Q+7Rdtk/HpBR+vZLVvBbQMmYbgt
         VZEwRbwsemJSV/KADYbrH81Hnr2KeffcMsY9hFW4Zyp0aOUatr6s5lngsshmmAqH2VBR
         7n7AW/XDm9gLe/TcSofd9U2WgneeQjnjWtfOw+8C/aIRPq6keubN6wO8kvwUR5GkCMja
         bsrcTBHX5H1Gx/OryPUSmb3nAkcEMXQSf9vuOMExHQn+fTSkB5QtXNCDMu/5xsfXvHPZ
         s+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr4rkc8HMR5iMM8a3CfCtFPxBHTUnniqd/u9oH5zQsNtgVHUpnfdTEi4kOF1/wE8+D0KozaVCQXc3v5e54@vger.kernel.org
X-Gm-Message-State: AOJu0YwJF7qyETGjRFu8s40kc7S+d+mz2gO2XD515lda/0DJMGkJp4rp
	lGtD6hQIrgD6S3wLzBbISB2fDZgUlI3EU4a1bZvov6ctFn/gVKTK2wf+0Rkhpl62VcO4hO9cxMT
	aDN/0mv0k1HDXDNNAU895eQZNb5vXqsiWvumf7KFSrCkY/SLCZIGts94=
X-Google-Smtp-Source: AGHT+IFFzi9wox96CFHLNr0fETzH8YGeWd71Ou8Xy6Zg6YXIE3xwL8uuT+DKV/OcY+pe7EkCmt6mH5hREQxA64vFLJpUwCYRda1Y
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1521:b0:3d0:4b3d:75ce with SMTP id
 e9e14a558f8ab-3d17d13690bmr69400955ab.17.1739484868095; Thu, 13 Feb 2025
 14:14:28 -0800 (PST)
Date: Thu, 13 Feb 2025 14:14:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ae6ec4.050a0220.21dd3.0027.GAE@google.com>
Subject: [syzbot] [iomap?] kernel BUG in folio_end_writeback (2)
From: syzbot <syzbot+29566bbfe6b64b944865@syzkaller.appspotmail.com>
To: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69b54314c975 Merge tag 'kbuild-fixes-v6.14' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1643abdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1909f2f0d8e641ce
dashboard link: https://syzkaller.appspot.com/bug?extid=29566bbfe6b64b944865
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-69b54314.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e32e396b49c9/vmlinux-69b54314.xz
kernel image: https://storage.googleapis.com/syzbot-assets/30d7fe7e4148/bzImage-69b54314.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29566bbfe6b64b944865@syzkaller.appspotmail.com

page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x54600
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea000134ad48 ffffea0001518048 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5324, tgid 5323 (syz.0.0), ts 71600359556, free_ts 71965749654
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x292/0x710 mm/page_alloc.c:4739
 alloc_pages_mpol+0x311/0x660 mm/mempolicy.c:2270
 alloc_frozen_pages_noprof mm/mempolicy.c:2341 [inline]
 alloc_pages_noprof+0x121/0x190 mm/mempolicy.c:2361
 folio_alloc_noprof+0x1e/0x30 mm/mempolicy.c:2371
 filemap_alloc_folio_noprof+0xe1/0x540 mm/filemap.c:1019
 __filemap_get_folio+0x438/0xae0 mm/filemap.c:1970
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x4d3/0x1990 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x6ea/0x11c0 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2cd/0xb20 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xacf/0xd10 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5324 tgid 5323 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xe40/0x18b0 mm/page_alloc.c:2707
 folios_put_refs+0x76c/0x860 mm/swap.c:994
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0xe65/0x10e0 mm/truncate.c:387
 xfs_flush_unmap_range+0xb8/0xd0 fs/xfs/xfs_bmap_util.c:820
 xfs_reflink_remap_prep+0x5fe/0x720
 xfs_file_remap_range+0x287/0x910 fs/xfs/xfs_file.c:1210
 vfs_copy_file_range+0xc07/0x14f0 fs/read_write.c:1584
 __do_sys_copy_file_range fs/read_write.c:1670 [inline]
 __se_sys_copy_file_range+0x3fa/0x600 fs/read_write.c:1637
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
kernel BUG at ./include/linux/mm.h:1153!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 1037 Comm: kworker/u4:7 Not tainted 6.14.0-rc1-syzkaller-00276-g69b54314c975 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: loop0 loop_workfn
RIP: 0010:put_page_testzero include/linux/mm.h:1153 [inline]
RIP: 0010:folio_put_testzero include/linux/mm.h:1159 [inline]
RIP: 0010:folio_put include/linux/mm.h:1488 [inline]
RIP: 0010:folio_end_writeback+0x603/0x650 mm/filemap.c:1655
Code: 45 c7 ff 4c 89 ef 48 c7 c6 60 d7 13 8c e8 a5 5a 11 00 90 0f 0b e8 4d 45 c7 ff 4c 89 ef 48 c7 c6 a0 d6 13 8c e8 8e 5a 11 00 90 <0f> 0b e8 36 45 c7 ff 4c 89 ef 48 c7 c6 e0 d3 13 8c e8 77 5a 11 00
RSP: 0018:ffffc900025bf430 EFLAGS: 00010246
RAX: 4a021b16b8d5f700 RBX: 0000000000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8c0aa680 RDI: 0000000000000001
RBP: dffffc0000000000 R08: ffffffff942f994f R09: 1ffffffff285f329
R10: dffffc0000000000 R11: fffffbfff285f32a R12: 0000000000000000
R13: ffffea0001518000 R14: 1ffffd40002a3000 R15: ffffea0001518034
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000400000000040 CR3: 00000000124d6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_finish_folio_write fs/iomap/buffered-io.c:1533 [inline]
 iomap_finish_ioend+0x462/0x6b0 fs/iomap/buffered-io.c:1561
 blk_update_request+0x5e5/0x1160 block/blk-mq.c:983
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1145
 loop_handle_cmd drivers/block/loop.c:1946 [inline]
 loop_process_work+0x1bc8/0x21c0 drivers/block/loop.c:1964
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:put_page_testzero include/linux/mm.h:1153 [inline]
RIP: 0010:folio_put_testzero include/linux/mm.h:1159 [inline]
RIP: 0010:folio_put include/linux/mm.h:1488 [inline]
RIP: 0010:folio_end_writeback+0x603/0x650 mm/filemap.c:1655
Code: 45 c7 ff 4c 89 ef 48 c7 c6 60 d7 13 8c e8 a5 5a 11 00 90 0f 0b e8 4d 45 c7 ff 4c 89 ef 48 c7 c6 a0 d6 13 8c e8 8e 5a 11 00 90 <0f> 0b e8 36 45 c7 ff 4c 89 ef 48 c7 c6 e0 d3 13 8c e8 77 5a 11 00
RSP: 0018:ffffc900025bf430 EFLAGS: 00010246
RAX: 4a021b16b8d5f700 RBX: 0000000000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8c0aa680 RDI: 0000000000000001
RBP: dffffc0000000000 R08: ffffffff942f994f R09: 1ffffffff285f329
R10: dffffc0000000000 R11: fffffbfff285f32a R12: 0000000000000000
R13: ffffea0001518000 R14: 1ffffd40002a3000 R15: ffffea0001518034
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000400000000040 CR3: 00000000124d6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

