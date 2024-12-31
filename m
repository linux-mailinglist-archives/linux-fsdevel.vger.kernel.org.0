Return-Path: <linux-fsdevel+bounces-38298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CA69FEFC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 14:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160541882449
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6A919DF64;
	Tue, 31 Dec 2024 13:27:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0271C1993BD
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735651641; cv=none; b=KuKJ9h1ug2fHhEO9v6ybOIfeCHr/oX+g4h9sV2Q1HTPCw3m6vMpT7tPwflVLsoZbws0I63GD8KHpds6OjlyhQOjcJvOAfdTkVwTlv3k980oR2JtO8r5cZv0N1IrYC/XbSmEmSvGTkAIlsLb/7OdNbZVuNIG54599hnxSmguwwI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735651641; c=relaxed/simple;
	bh=OsAj1ONAvXcvEXInNEXL/KT/IbeVhriRwoFU4fzX2EU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fThPwXUnH+w/CFpuZjK50bbA7UAMoqrX/kqKik74lviOxA0lkt5cX6aCh96lz/OOrwzcClgQ20c/xvKhIAxvC1bTSL37PJF50I1QVQ3A6ZqEdFt6H7oKpTAtAeiCp05ZTwwmp53gwt3b5l8iVZQqZZ43TSLTKoNW4PC4IazLJI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7d60252cbso83875025ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 05:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735651639; x=1736256439;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wYtpb9nCWN8DNfIDHp15ZDeyy4+Nf3SbXEnOPKyYzc=;
        b=pjlQZWbSr2YDo3xAFXX5sjWxKDTl8QqJ7+TTaUKTQHRpwDVBXgfZJl1BGvNdcaGpWD
         IqfWlydDKfSqH88oKeuUijd6vrSqxtbARS4eHfjEq2McKwWCxz3UeMGPwzSa5st4ZHz+
         J97FhLFp7KP8C7DG/lSRwTxRHmI8VmSNNYELg1U3T6yFajcPRbW7tbquTb2nlPem5lCG
         DQf1zRByfB42LW/UNdGNyndu7woh2QwNgCSOsq6v5EY/73AhrHzLjAQgKinsrwZ6cveK
         MukaOGqUt85Q0sHhyj3P3V54D1aMdbRUJGcRlrgTU6o++x2k+NWtn58Id2YAzTdRNubv
         hLBw==
X-Forwarded-Encrypted: i=1; AJvYcCWi2znVZZrSJxmU9Ng6YiG5DDIPrfCmubiuOyMKAtOha0ceakwkoHDpgIHojk8PdsBDHYoQAZTQlmy7LXYq@vger.kernel.org
X-Gm-Message-State: AOJu0YwUoffIuahARePS1dv3gXrijc29fNyKvysdnsuBUDqxT5DjwEbx
	WVsLTbB/2cxyHQqu0/IebiWvzJXOlSmLUhWKiOKMPwSnivikx0SqaFfJlAXRcOIBXJdZDqFlu4F
	60B/1h+f1mMFq5smHvSIohitlKaU8zP/HvEyzJwLBG90iBLFlHb9laOs=
X-Google-Smtp-Source: AGHT+IFcDNVbZ2g8b7yw9ETK6KTG9U5hbqwoWQ+jiQRFXpAFhwAgvIom67k1eRsZ+1ou26TVAHH/I+T2jGV4r6wdz4sC+5wrtK8i
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f8f:b0:3a7:c81e:825f with SMTP id
 e9e14a558f8ab-3c3018ab111mr325724865ab.9.1735651639146; Tue, 31 Dec 2024
 05:27:19 -0800 (PST)
Date: Tue, 31 Dec 2024 05:27:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6773f137.050a0220.2f3838.04e2.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-out-of-bounds Write in __put_unused_fd
From: syzbot <syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, repnop@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8155b4ef3466 Add linux-next specific files for 20241220
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=105ba818580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c90bb7161a56c88
dashboard link: https://syzkaller.appspot.com/bug?extid=6a3aa63412255587b21b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e670b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f42ac4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98a974fc662d/disk-8155b4ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2dea9b72f624/vmlinux-8155b4ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/593a42b9eb34/bzImage-8155b4ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 00007ffd163c2680 RCX: 00007f8b75a4d669
RDX: 00007f8b75a4c8a0 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 0000000000000001 R08: 00007ffd163c2407 R09: 00000000000000a0
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
==================================================================
BUG: KASAN: use-after-free in instrument_write include/linux/instrumented.h:40 [inline]
BUG: KASAN: use-after-free in ___clear_bit include/asm-generic/bitops/instrumented-non-atomic.h:44 [inline]
BUG: KASAN: use-after-free in __clear_open_fd fs/file.c:324 [inline]
BUG: KASAN: use-after-free in __put_unused_fd+0xdb/0x2a0 fs/file.c:600
Write of size 8 at addr ffff88804952aa48 by task syz-executor128/5830

CPU: 1 UID: 0 PID: 5830 Comm: syz-executor128 Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_write include/linux/instrumented.h:40 [inline]
 ___clear_bit include/asm-generic/bitops/instrumented-non-atomic.h:44 [inline]
 __clear_open_fd fs/file.c:324 [inline]
 __put_unused_fd+0xdb/0x2a0 fs/file.c:600
 put_unused_fd+0x5c/0x70 fs/file.c:609
 __do_sys_fanotify_init fs/notify/fanotify/fanotify_user.c:1628 [inline]
 __se_sys_fanotify_init+0x800/0x970 fs/notify/fanotify/fanotify_user.c:1466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8b75a4d669
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd163c2668 EFLAGS: 00000246 ORIG_RAX: 000000000000012c
RAX: ffffffffffffffda RBX: 00007ffd163c2680 RCX: 00007f8b75a4d669
RDX: 00007f8b75a4c8a0 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 0000000000000001 R08: 00007ffd163c2407 R09: 00000000000000a0
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4952a
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xcc0(GFP_KERNEL), pid 1, tgid 1 (swapper/0), ts 21408968854, free_ts 21922910177
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1551
 split_free_pages+0xe1/0x2d0 mm/page_alloc.c:6374
 alloc_contig_range_noprof+0x10eb/0x1770 mm/page_alloc.c:6551
 __alloc_contig_pages mm/page_alloc.c:6581 [inline]
 alloc_contig_pages_noprof+0x4b3/0x5c0 mm/page_alloc.c:6663
 debug_vm_pgtable_alloc_huge_page+0xaf/0x100 mm/debug_vm_pgtable.c:1084
 init_args+0x83b/0xb20 mm/debug_vm_pgtable.c:1266
 debug_vm_pgtable+0xe0/0x550 mm/debug_vm_pgtable.c:1304
 do_one_initcall+0x248/0x870 init/main.c:1267
 do_initcall_level+0x157/0x210 init/main.c:1329
 do_initcalls+0x3f/0x80 init/main.c:1345
 kernel_init_freeable+0x435/0x5d0 init/main.c:1578
 kernel_init+0x1d/0x2b0 init/main.c:1467
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0xe0d/0x10e0 mm/page_alloc.c:2660
 free_contig_range+0x14c/0x430 mm/page_alloc.c:6697
 destroy_args+0x92/0x910 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x248/0x870 init/main.c:1267
 do_initcall_level+0x157/0x210 init/main.c:1329
 do_initcalls+0x3f/0x80 init/main.c:1345
 kernel_init_freeable+0x435/0x5d0 init/main.c:1578
 kernel_init+0x1d/0x2b0 init/main.c:1467
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88804952a900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88804952a980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88804952aa00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                              ^
 ffff88804952aa80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88804952ab00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

