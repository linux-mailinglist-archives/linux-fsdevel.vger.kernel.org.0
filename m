Return-Path: <linux-fsdevel+bounces-10900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE4584F2FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C85B27114
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E7867E98;
	Fri,  9 Feb 2024 10:12:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61067E84
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473541; cv=none; b=doiXPv2/g9JrPXTzOpD8UuJT5HInckK594vL6d8eD+p5kbKbtPnLcCnWoQuvaW19zKlQBVnOaDQbpUaPkvFoZFkpytfgiNd6Junn5WezYe+PE0UIlPQ5//9GSbXekvSdGPnyFzWLJCf7B+NZZ/X8gzQjhlU67Ka3gY8UxX+R5Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473541; c=relaxed/simple;
	bh=V1uwFoAuKMTQPxxhZI98r3aoMxvLgJAxwcNl79gFRJc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nnGgDnw6su7MIsbo2eEAt3hFdhTmQljckifJkRnHkkXQHms2lmfWE/LiCSjRfzIAFgOLrrSnjrLLLHHgML/BEmDmKmkAEi9mRCQPV13khxV6YFXMACY91XAn3HTo4xMzUCJRSGPN8XpmJWWXj3nuiE29owhDwBkeMaMHC55y+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363ca646a1dso6354355ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 02:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707473539; x=1708078339;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Zfviyanj+n+GMag83/XDKa0Ucf1btJFowkA8So62j8=;
        b=qbfjPDK62Cc3SORiBGInXu0CVXQWLqNlKtdh19IwdJ14MS8/L7Mdzx8eob4QG1JXPY
         PQuKnb4uwiHnDBxCreqGRs5wGG7W6Z3PWItp8mQpbAG4AVXb/kI8NvdlpT0V9zlLSu3A
         jrqSCI3xl/4WSkHLl1yBH3aZFuMPEropCmP0ArDbNdrssimSdbJq6bxsYSVs/79HTSdC
         6kcG1wGSUAHbVaAK11/rO29IkB3e88Gvm0zyzOkaJMmJXXkJkQ0tlqTPtSRCJHl2wi77
         XLZlZglggHz3feZxygkmjX7M5GFHLhZUUfDmpUL3u7xAk9zXZ8mZt/Ia/MXOWYinCFpk
         FmbQ==
X-Gm-Message-State: AOJu0YxmL2IJ1QeoEPoUEj7oopaBAfGICdI2mI17+QpdJ3Pkg2Kc+UvI
	oj+7xaoBIUs1KS7LZGPs78i64GGRv/1kgnC4vyIjH2s/1Oo697KB037OF2uFngzpuJ32hDG0Ol8
	SWEroKM7LOYPSpjXyj0iRr7VOSj0AoWepqMqQbIkrgnHfoXUBDxfBJxObMg==
X-Google-Smtp-Source: AGHT+IFJ5TU+63YYAhynzFO/S0mGmYE10rOeV1wkk7DtVwvP/05nAitkquB/nvqz1IZOiYYhftjCJkhngiXzq3vGZDlpr7Hk/G3J
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a42:b0:363:ac48:e28d with SMTP id
 u2-20020a056e021a4200b00363ac48e28dmr93372ilv.3.1707473538895; Fri, 09 Feb
 2024 02:12:18 -0800 (PST)
Date: Fri, 09 Feb 2024 02:12:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bfd4ca0610f02993@google.com>
Subject: [syzbot] [fs?] KASAN: use-after-free Read in sysv_new_inode
From: syzbot <syzbot+2e64084fa0c65e8706c9@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    23e11d031852 Add linux-next specific files for 20240205
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11933ca8180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f1d38572a4a0540
dashboard link: https://syzkaller.appspot.com/bug?extid=2e64084fa0c65e8706c9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b4e82c0f5cca/disk-23e11d03.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/018dac30c4d4/vmlinux-23e11d03.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee21a2f37a73/bzImage-23e11d03.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e64084fa0c65e8706c9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in sysv_new_inode+0xfdd/0x1170 fs/sysv/ialloc.c:153
Read of size 2 at addr ffff88803b1f61ce by task syz-executor.4/7277

CPU: 1 PID: 7277 Comm: syz-executor.4 Not tainted 6.8.0-rc3-next-20240205-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 sysv_new_inode+0xfdd/0x1170 fs/sysv/ialloc.c:153
 sysv_mknod+0x4e/0xe0 fs/sysv/namei.c:53
 lookup_open fs/namei.c:3494 [inline]
 open_last_lookups fs/namei.c:3563 [inline]
 path_openat+0x1425/0x3240 fs/namei.c:3793
 do_filp_open+0x235/0x490 fs/namei.c:3823
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_openat fs/open.c:1435 [inline]
 __se_sys_openat fs/open.c:1430 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1430
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f86a7c7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f86a8a900c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f86a7dabf80 RCX: 00007f86a7c7dda9
RDX: 000000000000275a RSI: 0000000020000040 RDI: ffffffffffffff9c
RBP: 00007f86a7cca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f86a7dabf80 R15: 00007fff47892ea8
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0000ec7d80 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x3b1f6
flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000000 dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x141cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_WRITE), pid 16881, tgid 16881 (syz-executor.3), ts 1415422682739, free_ts 1421164748730
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1539
 prep_new_page mm/page_alloc.c:1546 [inline]
 get_page_from_freelist+0x34eb/0x3680 mm/page_alloc.c:3353
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4609
 alloc_pages_mpol+0x3e8/0x680 mm/mempolicy.c:2263
 alloc_pages mm/mempolicy.c:2334 [inline]
 folio_alloc+0x12b/0x330 mm/mempolicy.c:2341
 filemap_alloc_folio+0xdf/0x500 mm/filemap.c:975
 __filemap_get_folio+0x431/0xbc0 mm/filemap.c:1919
 ext4_da_write_begin+0x5b9/0xa50 fs/ext4/inode.c:2885
 generic_perform_write+0x322/0x640 mm/filemap.c:3921
 ext4_buffered_write_iter+0xc6/0x350 fs/ext4/file.c:299
 ext4_file_write_iter+0x1de/0x1a10
 __kernel_write_iter+0x435/0x8c0 fs/read_write.c:523
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x46d/0x910 fs/coredump.c:915
 elf_core_dump+0x3d5e/0x4630 fs/binfmt_elf.c:2077
 do_coredump+0x1bab/0x2b50 fs/coredump.c:764
 get_signal+0x146b/0x1850 kernel/signal.c:2882
page last free pid 16881 tgid 16881 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2388
 free_unref_page_list+0x5a3/0x850 mm/page_alloc.c:2574
 release_pages+0x2744/0x2a80 mm/swap.c:1042
 __folio_batch_release+0x84/0x100 mm/swap.c:1062
 folio_batch_release include/linux/pagevec.h:83 [inline]
 truncate_inode_pages_range+0x457/0xf70 mm/truncate.c:362
 ext4_evict_inode+0x21c/0xf30 fs/ext4/inode.c:193
 evict+0x2a8/0x630 fs/inode.c:666
 __dentry_kill+0x20d/0x630 fs/dcache.c:603
 dput+0x19f/0x2b0 fs/dcache.c:845
 __fput+0x678/0x8a0 fs/file_table.c:384
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 get_signal+0x176e/0x1850 kernel/signal.c:2896
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x79/0x280 kernel/entry/common.c:225

Memory state around the buggy address:
 ffff88803b1f6080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88803b1f6100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88803b1f6180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                              ^
 ffff88803b1f6200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88803b1f6280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

