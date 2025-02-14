Return-Path: <linux-fsdevel+bounces-41708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF13A35740
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 07:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD58216E45A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 06:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159B0204085;
	Fri, 14 Feb 2025 06:39:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B917E
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515167; cv=none; b=mcRGAbWeQ0FX9qWzMCHoIq1u9Km3cvJenyaet8K6MQFw2UpuqTvFuq8uwOzvofrOSSyLFE7k2ZPHjooNhfyCPNAajWYUTImZ6FMBo9yC3krP0Oqg3/o4McB2/X2EBMPdCdXM4I0qb+tZbtP/6SsEsXtxwQfYmeiK3/X+AsTNaxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515167; c=relaxed/simple;
	bh=RPRcBdYTiyPNkll2YVDappoe1ToG6ZsC+q9BYPD/0KM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K/XZVznJXhY7NhXc8oRaU2OycYVqTCE/Dy3M1VNblk0nvRTFVAUlEmNSCG6WAgdbu0XhRPhvaMuPmS4v8w27F3Fl+ri45MZ89jH1RVpzxBDufkbNYKUrYNjKjR2EPqMkROfMaYZr31dn3Eqkd52PoF+UDnBmv7Aki9H19hrKJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d158477b5fso10722265ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 22:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739515165; x=1740119965;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHhZV9Csomr8XUspDhbBmbn5Y6J59ZTrAZNyV8CqFaE=;
        b=EqQb1ZT3r3hndRHUWmci1RcOEpoQgVcq6vCtim5rUOUdtH2kFMZne7d3HSwJaeqBDv
         Jezm+O6/4Zx4eZjh2Z/DpH5nJ46tlRrfLlU/Mc/vFeScUn4ewg7Ta757BjXeJ2fmWXnA
         c97/DuPDeChuFI4hsJqIZNDDUofPPv0C90SeNFIAEHyQYux/I7yN4P5TtAgk1Eo3HVG0
         EF1TDiZDXJ0E6cAcEBYbDvn6OsqjMTwpPKHT6Nv8EBNKDh3jYk7KwHYpYaNXOPO/bDhY
         0FEHTW39G3G88Y0U4ZF5sgcqTJfWafZAfjfTVCXbpOpQ9A+rL9KjPaF+gue75nzp3tQt
         K7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcJONJSprJyhJmNuGC4CSmcjoq2mOyik88BTSBk2pnTynCokvHspd9qbincMuTgM+abDTntslx7J5te17U@vger.kernel.org
X-Gm-Message-State: AOJu0YxDXshApBCo6qB7A2dtuA8rwQYON7Pfx6XKOA4t/lUpQs4yZhH4
	LiaSIi7k9bbJNcH51Na9E3Wfa8XKyCnQjQ037PaRxpCPt+LlPY81vBw0Z/HUi1nJ2/EOrUEukFa
	FbGSYf+QODvs99/bW4yMcJBR6BWHkswN3yu1xw0sdzyD/CrvWDyEcxR4=
X-Google-Smtp-Source: AGHT+IF/Hv/mD9dUCycNVAxCnDojNZtBwU1TsxPI3uWgYvdBobM+POkLBFJq1PuAq/ogiC5/7/BSp0H9LhxEj11P/yyJn+ZlrKo4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2168:b0:3d0:255e:fdc with SMTP id
 e9e14a558f8ab-3d17bfde1f2mr94773195ab.15.1739515165127; Thu, 13 Feb 2025
 22:39:25 -0800 (PST)
Date: Thu, 13 Feb 2025 22:39:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67aee51d.050a0220.21dd3.002f.GAE@google.com>
Subject: [syzbot] [netfs?] WARNING: refcount bug in netfs_put_subrequest
From: syzbot <syzbot+d9890527385ab9767e03@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69b54314c975 Merge tag 'kbuild-fixes-v6.14' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106d6bdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7ddf49cf33ba213
dashboard link: https://syzkaller.appspot.com/bug?extid=d9890527385ab9767e03
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13aafdf8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-69b54314.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d0a58d1d655/vmlinux-69b54314.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b99949b40299/bzImage-69b54314.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d9890527385ab9767e03@syzkaller.appspotmail.com

netfs: Couldn't get user pages (rc=-14)
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 3 PID: 6306 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 3 UID: 0 PID: 6306 Comm: syz.2.100 Not tainted 6.14.0-rc1-syzkaller-00276-g69b54314c975 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 78 71 f5 fc 84 db 0f 85 66 ff ff ff e8 cb 76 f5 fc c6 05 e5 68 86 0b 01 90 48 c7 c7 00 fb d2 8b e8 97 b2 b5 fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 a8 76 f5 fc 0f b6 1d c0 68 86 0b 31
RSP: 0018:ffffc900030d7750 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817a1159
RDX: ffff88805135c880 RSI: ffffffff817a1166 RDI: 0000000000000001
RBP: ffff88802d916fa0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000005
R13: 000000000000006f R14: 0000000000000001 R15: ffff88802d916fa0
FS:  00007fee79bce6c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fee79bad000 CR3: 00000000233ec000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 netfs_put_subrequest+0x2c1/0x4d0 fs/netfs/objects.c:230
 netfs_collect_read_results fs/netfs/read_collect.c:300 [inline]
 netfs_read_collection+0x25af/0x3cb0 fs/netfs/read_collect.c:417
 netfs_wait_for_pause+0x31c/0x3e0 fs/netfs/read_collect.c:689
 netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:106 [inline]
 netfs_unbuffered_read fs/netfs/direct_read.c:144 [inline]
 netfs_unbuffered_read_iter_locked+0xb50/0x1610 fs/netfs/direct_read.c:229
 netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:264
 v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
 aio_read+0x313/0x4e0 fs/aio.c:1602
 __io_submit_one fs/aio.c:2003 [inline]
 io_submit_one+0x1580/0x1da0 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit fs/aio.c:2081 [inline]
 __x64_sys_io_submit+0x1b2/0x340 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fee78d8cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fee79bce038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007fee78fa5fa0 RCX: 00007fee78d8cde9
RDX: 00004000000002c0 RSI: 0000000000000001 RDI: 00007fee79bad000
RBP: 00007fee78e0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fee78fa5fa0 R15: 00007ffe1e525b98
 </TASK>


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

