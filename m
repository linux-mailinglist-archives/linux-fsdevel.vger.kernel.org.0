Return-Path: <linux-fsdevel+bounces-8405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C41E835EA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 10:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0741F21E06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 09:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0343BB33;
	Mon, 22 Jan 2024 09:48:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419273A8CC
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916912; cv=none; b=suJ4ZYyy5E3AhHS1WVuIufSFfZeNjpX08dxyEGig47l65JCDNyGGsaAAprFnZcZQ/DXY3e8suITaa72KvtCZ2Y1yCxWTO8RIRsVFujmJkA7Ovzsn0OiRNTJKIkuNg03gLteY9T9s1gunSZV6tXtOU04SZD6BhnYdtFnRGy4JbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916912; c=relaxed/simple;
	bh=GHXNHGnWBoujjSR/eQtHQpeS/SHwk5cxAZOS/b+R4yk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HMe3BMw/knsAn1F+rupZjRFx6OJzywz9n0cK2Ocn3bIUHGpvM2Uij4rnduLTHBn7RKUvMjXBCHkxSL04Ly2BYVkseZ38a2ykQq2FddbSUABFqNptApkaLlgbZn5elbx4L4O4hW2VfSvMV5Kuk1DI8XD8LLIOiHVLjdxEtH8a/rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-360c3346ecbso24220665ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 01:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705916910; x=1706521710;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ct1ERqM8hnJD4Wmb1AvKYZCdcYP1ircWk6jl9QOBlUM=;
        b=ZaPCQgY8qWU+8+k49/9jPw++vrJ57PgG9o5pRO1V4lBV9pYGvGVSzlWV7UnZmJy2Zy
         iaW8e9TRvYckieKY1+W0anUO0pz6rwJVW0Rmy9Hngi53V5oaTw4s4YP3HOJxm/Ur9OTE
         Ej1sdE2PYdhnSqaOxAP2mVZvsLXqx+i+bDVqc3nctfXeA1KiLt65iKquIwRXKhqLyqFj
         l/mUNJDk4XOVYIYyKg96pk1/7ubVuaQfjcR71aQcWktYH6FqkWuMcm8Kc2noB93mOC4m
         xZCagKz18vVr3GdTfXLOSbLkHvY+C9SRrZma3FVEo2x0gDwIWpDmWB81JoWrz4ww5CAm
         Hlmg==
X-Gm-Message-State: AOJu0YztBEGJ69rKnSSzWoXuaFsNqSHnnSpZQpeAY9I78NUirldj4Us0
	P6ANly8lZmCjQrnlmxxzt7D0Iu1ls9LYqoEiOkM91t+xvkP++A1m5+VP/aAV1fZvuP8pdPiEBbM
	yHtLOl3N7q6K2foEfdYphoLSxB2G+q1FysNcTAGbQxnHWjZ+nlLVaHkeZjg==
X-Google-Smtp-Source: AGHT+IH8TuX8cwVVjuo3CoDWJuKdvUSncWtuq/VFUP0Ae7/9BbYzaAotqyQkpwfuiM4kae7O87pK9NHVaAS6qUpahWdHjJr7hvms
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8e:b0:360:968d:bfb9 with SMTP id
 h14-20020a056e021d8e00b00360968dbfb9mr282113ila.5.1705916910039; Mon, 22 Jan
 2024 01:48:30 -0800 (PST)
Date: Mon, 22 Jan 2024 01:48:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000707b50060f85bb0e@google.com>
Subject: [syzbot] [hfs?] KASAN: out-of-bounds Read in hfsplus_bnode_move
From: syzbot <syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    125514880ddd Merge tag 'sh-for-v6.8-tag1' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15edd643e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a6ff9d9d5d2dc4a
dashboard link: https://syzkaller.appspot.com/bug?extid=6df204b70bf3261691c5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169c2d57e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11109193e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/86a8a3ee9ef1/disk-12551488.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b73f0ed65615/vmlinux-12551488.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7aa088345217/bzImage-12551488.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3a894fc3d764/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12fdd643e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11fdd643e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16fdd643e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
==================================================================
BUG: KASAN: out-of-bounds in hfsplus_bnode_move+0x5f3/0x910 fs/hfsplus/bnode.c:228
Read of size 18446744073709551602 at addr 000508800000104e by task syz-executor353/5048

CPU: 0 PID: 5048 Comm: syz-executor353 Not tainted 6.7.0-syzkaller-12829-g125514880ddd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_report+0xe6/0x540 mm/kasan/report.c:491
 kasan_report+0x142/0x170 mm/kasan/report.c:601
 kasan_check_range+0x27e/0x290 mm/kasan/generic.c:189
 __asan_memmove+0x29/0x70 mm/kasan/shadow.c:94
 hfsplus_bnode_move+0x5f3/0x910 fs/hfsplus/bnode.c:228
 hfsplus_brec_insert+0x61c/0xdd0 fs/hfsplus/brec.c:128
 hfsplus_create_attr+0x49e/0x630 fs/hfsplus/attributes.c:252
 __hfsplus_setxattr+0x6fe/0x22d0 fs/hfsplus/xattr.c:354
 hfsplus_initxattrs+0x158/0x220 fs/hfsplus/xattr_security.c:59
 security_inode_init_security+0x2a7/0x470 security/security.c:1752
 hfsplus_fill_super+0x14d3/0x1c90 fs/hfsplus/super.c:567
 mount_bdev+0x206/0x2d0 fs/super.c:1663
 legacy_get_tree+0xef/0x190 fs/fs_context.c:662
 vfs_get_tree+0x8c/0x2a0 fs/super.c:1784
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fd7936b4d3a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff572a70a8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff572a70c0 RCX: 00007fd7936b4d3a
RDX: 0000000020000040 RSI: 0000000020000240 RDI: 00007fff572a70c0
RBP: 0000000000000004 R08: 00007fff572a7100 R09: 00000000000006c8
R10: 0000000000800000 R11: 0000000000000286 R12: 0000000000800000
R13: 00007fff572a7100 R14: 0000000000000003 R15: 0000000000080000
 </TASK>
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

