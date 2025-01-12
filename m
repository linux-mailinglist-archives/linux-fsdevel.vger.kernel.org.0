Return-Path: <linux-fsdevel+bounces-38989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24532A0AB95
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 19:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFCB18873C4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C78B1C1F1D;
	Sun, 12 Jan 2025 18:56:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624201BB6BC
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736708186; cv=none; b=jvhPIakZQYq63fNBdgF9PTJ6SpKMLcxm3/sQZbA1zd+GhhkEJkrDNHpAp1aBtD/39NMHa5C8/AlNtJIVw4S8uupGOdXcCohUGT2NGrF5t6Gy2d4kqvwrVDipvQgQ5AvInB3+3aCLsneymnQ9Adsmww7vJzRjnbUpbBQ3mH8MNfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736708186; c=relaxed/simple;
	bh=4952sKTdMkL5AOWg6bIY1w91xb192S+O1y28dKbkZuE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bBcD+9AJTT5cK34GFvEVah4gpTNQMuVCKqkMZZ4jNZhLQ12pTNiNMEJyxPAk9BvEBbrcKzGteNSWudlb5wrV1ed2AO17Ed2FH9QQ6uV2UlGwHHcc7/WrOAuR/vQN95WXWsO/gYF/NJ7+cg5qgRaesT+9S46fd3itLlmwCRRzDZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a81684bac0so65263745ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 10:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736708184; x=1737312984;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4D38t2N5a1X+GK3JqPv9nazLgqGL66rJUmuis2XAjaA=;
        b=qqklKCLnw2VSUICjIjaelOx2p41PibICnUM6KM23kPX9ouSSwxWX6bgvYCK/8uNT6p
         xN48+M3p3ZokNGGwbgplm3QDz9kRTXvW454qsaoXsd+wWvMrzPNJCJ7gphFC9ZR6FG3+
         YxBKsPYpeInLB7Flbk7VT9EnhAOMa3jJEVyhBhsmzA67Rmz7C7NjBb5VIHm1EbcFR1ie
         BC2er6MQ/oizjBZQ0N0Jn1L+ZThS+fRSip1/HA+Ov+D+XBzYomEiaifx9bN605ptI96n
         vWTymW+CXEIPl6yWT9V+qtIsFe/ex4j3cJczpq9C1/OlIR5AS5sAqCFnhu9GgHfZqbd2
         mcGg==
X-Gm-Message-State: AOJu0YxmDmpj1n+1aCDYAhqWA01jA07XUFLd7YF746lWEElWBBUhmOxD
	CPI4YybXXIh13uFtH6WlH2KC3W7Qqbmpg0LI3FMuWtmut5JH3BVQ7vzXg00xLkY0FSUS/SEEt6a
	AD5xdd9oIN9Yp3S6vS5tfEBspMfUIkpQDVY9RA7qKxMQKqPlN6x+yrM7fOw==
X-Google-Smtp-Source: AGHT+IE0lZnLACULa/knqBizlDbyoYenwUzvlGvViLn/1XU/dqc8yo6aFkzLHZC3m6D9dTL6/QTmExtFFomlT0L0eIEGZ8SUxUe1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d86:b0:3ce:5a89:326e with SMTP id
 e9e14a558f8ab-3ce5a893465mr65812625ab.13.1736708184562; Sun, 12 Jan 2025
 10:56:24 -0800 (PST)
Date: Sun, 12 Jan 2025 10:56:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67841058.050a0220.216c54.0034.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: global-out-of-bounds Read in number
From: syzbot <syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b4b9bf203da Add linux-next specific files for 20250107
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14246bc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63fa2c9d5e12faef
dashboard link: https://syzkaller.appspot.com/bug?extid=fcee6b76cf2e261c51a4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174f0a18580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168aecb0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c179cc0c7a3c/disk-7b4b9bf2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fdea80f2ec16/vmlinux-7b4b9bf2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a277fcaff608/bzImage-7b4b9bf2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a96fcb87dd70/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in number+0x3be/0xf40 lib/vsprintf.c:494
Read of size 1 at addr ffffffff8c5fc971 by task syz-executor351/5832

CPU: 0 UID: 0 PID: 5832 Comm: syz-executor351 Not tainted 6.13.0-rc6-next-20250107-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 number+0x3be/0xf40 lib/vsprintf.c:494
 pointer+0x764/0x1210 lib/vsprintf.c:2484
 vsnprintf+0x75a/0x1220 lib/vsprintf.c:2846
 seq_vprintf fs/seq_file.c:391 [inline]
 seq_printf+0x172/0x270 fs/seq_file.c:406
 show_partition+0x29f/0x3f0 block/genhd.c:905
 seq_read_iter+0x969/0xd70 fs/seq_file.c:272
 proc_reg_read_iter+0x1c2/0x290 fs/proc/inode.c:299
 copy_splice_read+0x63a/0xb40 fs/splice.c:365
 do_splice_read fs/splice.c:985 [inline]
 splice_direct_to_actor+0x4af/0xc80 fs/splice.c:1089
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x289/0x3e0 fs/splice.c:1233
 do_sendfile+0x564/0x8a0 fs/read_write.c:1363
 __do_sys_sendfile64 fs/read_write.c:1424 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1410
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3fa8cf4c69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd536a0078 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3fa8cf4c69
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000004
RBP: 00007f3fa8d685f0 R08: 000055558679c4c0 R09: 000055558679c4c0
R10: 000000000000023b R11: 0000000000000246 R12: 00007ffd536a00a0
R13: 00007ffd536a02c8 R14: 431bde82d7b634db R15: 00007f3fa8d3d03b
 </TASK>

The buggy address belongs to the variable:
 hex_asc_upper+0x11/0x40

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xc5fc
flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002000 ffffea0000317f08 ffffea0000317f08 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff8c5fc800: 00 03 f9 f9 02 f9 f9 f9 02 f9 f9 f9 00 02 f9 f9
 ffffffff8c5fc880: 00 04 f9 f9 00 03 f9 f9 07 f9 f9 f9 00 00 04 f9
>ffffffff8c5fc900: f9 f9 f9 f9 00 00 01 f9 f9 f9 f9 f9 00 00 01 f9
                                                             ^
 ffffffff8c5fc980: f9 f9 f9 f9 00 04 f9 f9 02 f9 f9 f9 01 f9 f9 f9
 ffffffff8c5fca00: 00 f9 f9 f9 00 f9 f9 f9 00 04 f9 f9 00 06 f9 f9
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

