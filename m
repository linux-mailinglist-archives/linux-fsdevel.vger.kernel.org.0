Return-Path: <linux-fsdevel+bounces-36217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A1D9DF78D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 02:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7B01629D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 01:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AE010A3E;
	Mon,  2 Dec 2024 01:05:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1C3D81
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733101530; cv=none; b=iqly1TTL9siLZN4ZpLD6f8EXDlIKd6cPM9VSS1xFgsuEFk2ifd6zWW+UA8FycrATR28jJfpHnJ/2CUjNST4nVdg6uQw1KduGt60M/Cr3VE1Be9lLsNzXvT6gtiCtB3yalagfOZIoOzwfJGoZgdjF++4y9IDrd/D+cW5WDJnfTsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733101530; c=relaxed/simple;
	bh=ayvb5VSMhLWGhFEYk9sAyHoNKijFyuBCKVo9njMvBTw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HdU1U4SKZyUpyPBLhgtOSDY5IyIUs+Jo5TGjYytr9MWMMf/IlGVugJKnx3bK0H9Zt+o94dN+pPId2V3s5aWjGuUvGb/OWfk7fyF2zp6p/sSHoXbeIOWmff/LpGrj5MF6YyhHPR+gM6z8iKy/fRzWpXqmNaHT9CmS432rgxm4gT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7c8259214so37673715ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Dec 2024 17:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733101526; x=1733706326;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+NBA3cSHRoEnXkJH9br5XKoQtNBWJygrejEDmNiKwc=;
        b=R8TyfpCTGxiUNRdnmMmYW31lkeDfqAHHPyr4A4BBjRHHLTi3IfSRiX2A+JFFZdTvnx
         BL/yDbpm9Qzs5H61EGrfy0TzbWWgW9UJ28OMSIUsaPPPmvOSiZqhBRrHhQJeSaUYWXsp
         nz5NXDFMRTL7X88y8qvk3Wf4Aksy73R5XT0KhZSNOuz9k1ZOrH59LEtQGBH3cI+7aERC
         XhkKKJJETrpKaRIw4F+/SyQHYbyCkpZWchxlI75f83mHBSoEtN1Fw7hmd4nrAokQlu8s
         GPCG5YoZVyMJkQ//qgJhbI+SBqiBz2y37H2Mo3bUCAJ8W5GHt0FhqgZ5TwbYC4qGzoy9
         m1RA==
X-Gm-Message-State: AOJu0YxhwmCqhe4rrdpyquddiWSt4ySJL0lN3JrVIG4Dl9VFEPlSLpI2
	pqKc1wXo3xfhYUFNcNFgtdlUUnnrvcLCH1z/8O15f289H7/1J84QylP6tsXlR0DwGwhi/+gyg4l
	2QubPs/zoD9BHPb/cIhPySG8buoULdQ6f8JTkl/sO/o76rCMQ8f4HGkKD+Q==
X-Google-Smtp-Source: AGHT+IElKtGqK2Sz1z+Jz+bU0XT7VBm/Bjaq6HS1EPIbjgM2nlEDcz8w1i4cbwXzrDsf8Tt9sDuAtMCcNYCUnykuNlMCtmaC5lMC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0f:0:b0:3a7:98c4:86a9 with SMTP id
 e9e14a558f8ab-3a7c55ec83amr239656195ab.20.1733101526657; Sun, 01 Dec 2024
 17:05:26 -0800 (PST)
Date: Sun, 01 Dec 2024 17:05:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674d07d6.050a0220.ad585.0040.GAE@google.com>
Subject: [syzbot] [fuse?] KASAN: null-ptr-deref Read in fuse_copy_args
From: syzbot <syzbot+63ba511937b4080e2ff3@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bcc8eda6d349 Merge tag 'turbostat-2024.11.30' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ad15e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ebff8e07a0ee6f
dashboard link: https://syzkaller.appspot.com/bug?extid=63ba511937b4080e2ff3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63b4b090e8f0/disk-bcc8eda6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1f37f73b54c/vmlinux-bcc8eda6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c076d69bc6d/bzImage-bcc8eda6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63ba511937b4080e2ff3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in fuse_copy_one fs/fuse/dev.c:1065 [inline]
BUG: KASAN: null-ptr-deref in fuse_copy_args+0x2d8/0x9c0 fs/fuse/dev.c:1083
Read of size 1 at addr 0000000000000000 by task syz.4.900/10122

CPU: 1 UID: 0 PID: 10122 Comm: syz.4.900 Not tainted 6.12.0-syzkaller-12113-gbcc8eda6d349 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_report+0xe8/0x550 mm/kasan/report.c:492
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 fuse_copy_one fs/fuse/dev.c:1065 [inline]
 fuse_copy_args+0x2d8/0x9c0 fs/fuse/dev.c:1083
 fuse_dev_do_read+0xcbd/0x11e0 fs/fuse/dev.c:1357
 fuse_dev_read+0x170/0x220 fs/fuse/dev.c:1424
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff6ba57f25c
Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 99 8e 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 ef 8e 02 00 48
RSP: 002b:00007ff6bb396fd0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000020002100 RCX: 00007ff6ba57f25c
RDX: 0000000000002000 RSI: 0000000020002100 RDI: 0000000000000003
RBP: 00007ff6ba5f3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000020000c80 R14: 00007ff6ba745fa0 R15: 00007ffecabbe838
 </TASK>
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

