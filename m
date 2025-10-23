Return-Path: <linux-fsdevel+bounces-65271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2759CBFF422
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 07:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09995355DCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 05:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FF826E709;
	Thu, 23 Oct 2025 05:35:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B5265621
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 05:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761197732; cv=none; b=EfLoZOFN0m/MfHtVJOB1zhVs8aESY3sTUbUP8k9AX0F0ipzEsXpFkkIR/AV6+mBINMhtQ4G+2H9s9D9XzXRmxxfK4kmbdLVQAyDCa/cDqE5fp3TJo1eMg9R/OCWyJu5I9aH8S294r7XkwDj+hVzglXAUb/2P+IcA6aR5q/2veu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761197732; c=relaxed/simple;
	bh=5KLzgB3fOk4V9E7gteF2nHRT0WhYdiybJvJZtUHg1zQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RXAcaDUwjxJffe2AuROkaxKwG+5cKwVexLTg6gp6aRHMxSXsO83DPW1+r+WeVyUEcbocp/hichmsHdUMvEGoeDz3XdN59kDPnc8fgXPcEonbvndDZLnfUCAS3iLjShUvCRmRXQRHlROGSIIg/o4zYheBI6T4gzwJu+em8TQSRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-93e7d299abfso32720639f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 22:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761197730; x=1761802530;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sFXxINLTagmUWGqODVvrEzSLw4OsO+wL4nCUkiEGxc8=;
        b=ue82mTW52x6x0pdFN1M7F3vQzSQm6gn3a/YtYVfKewgG14zYLt/T+zLBtvqegxlpRE
         6aUj5zys+WBj4sq/tyhgGg2PcLocTb7AnByFaAaU1WHEiV69Z7vp/11uT6VQ5IUTN7Zx
         GKv9vyEnMa06K9S+RmohMHPv1dNUVAlJURG71GwOKJA2yhdf9WXxdoIJ5t/Q0hXkCiuj
         5w+amDTsZ4oSeg7Dz6mUiMSJSEd293RLutwefmoVryHNOA5CRNmNaaRdHNQUPhWs7Y+9
         Ot4wTyfY71jNAA3rAj69xbuzqfx9n7xjA9KgDlD8C66nCkdM6Sl9rhwrOnLPtrFRDNM+
         Wb1A==
X-Forwarded-Encrypted: i=1; AJvYcCU+gQX5I/AlbZyHfV+meVvoiAsYd/PHfVTnA+kMFw38Z4b2IFYjyPqvzzyudSlZ9gqaGpdocQJsi+mhL8C8@vger.kernel.org
X-Gm-Message-State: AOJu0YxjAyZVawrcV6Al+PdmsUEMpr63Nt7OE+6+k0AAmWmv7hU3NZJe
	yzvEqw64x0vHB4mAIb4NWiSyC+JmSv6QHgD66vmJAJ6s7JR8WnoDBokdKC/gOAaoairt7+jNe/N
	T5AceJp2jOAYzZKLBUMKDAqE0zbunJME+aPL3GM9ipPDb+LHrsKhe5hWdvSA=
X-Google-Smtp-Source: AGHT+IGv1iacUoMEHu746AvIgzjKBVjenIRK1K9fiPm5nQKfbhkYeeQlcAsFhBdlsAh5bdokGQtYcDgEJsViXef2LgSvgWoc2Rkl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1605:b0:430:a5e3:fd70 with SMTP id
 e9e14a558f8ab-430c5253b58mr305347795ab.9.1761197729700; Wed, 22 Oct 2025
 22:35:29 -0700 (PDT)
Date: Wed, 22 Oct 2025 22:35:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f9bea1.a70a0220.3bf6c6.0032.GAE@google.com>
Subject: [syzbot] [hfs?] kernel BUG in hfs_new_inode
From: syzbot <syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    552c50713f27 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1231d734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=216353986aa62c5d
dashboard link: https://syzkaller.appspot.com/bug?extid=17cc9bb6d8d69b4139f0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e953e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176d7c58580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/822137407e34/disk-552c5071.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c352dbdc77fe/vmlinux-552c5071.xz
kernel image: https://storage.googleapis.com/syzbot-assets/96bd9d9f8c50/bzImage-552c5071.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d008a2751bbd/mount_0.gz

The issue was bisected to:

commit a06ec283e125e334155fe13005c76c9f484ce759
Author: Viacheslav Dubeyko <slava@dubeyko.com>
Date:   Tue Jun 10 23:16:09 2025 +0000

    hfs: add logic of correcting a next unused CNID

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b4e3e2580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13b4e3e2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15b4e3e2580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
Fixes: a06ec283e125 ("hfs: add logic of correcting a next unused CNID")

loop0: detected capacity change from 0 to 64
hfs: unable to loca[  123.243188][ T5988] hfs: unable to locate alternate MDB
hfs: continuing without an alternate MDB
------------[ cut here ]------------
kernel BUG at fs/hfs/inode.c:222!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 5988 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:hfs_new_inode+0xbc4/0xbd0 fs/hfs/inode.c:222
Code: 89 f1 80 e1 07 fe c1 38 c1 0f 8c 15 fa ff ff 4c 89 f7 e8 0f 6f 8b ff e9 08 fa ff ff e8 b5 b7 29 ff 90 0f 0b e8 ad b7 29 ff 90 <0f> 0b e8 a5 b7 29 ff 90 0f 0b 66 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900040af848 EFLAGS: 00010293
RAX: ffffffff829555d3 RBX: ffff8880335088c8 RCX: ffff888026d23c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1005214608 R12: ffff8880290a3000
R13: 1ffff110073d90f3 R14: 0000000100000000 R15: ffff8880335088c8
FS:  00007f6c84dde6c0(0000) GS:ffff888126cc2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e263fff CR3: 000000003276a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 hfs_create+0x2a/0xe0 fs/hfs/dir.c:198
 lookup_open fs/namei.c:3796 [inline]
 open_last_lookups fs/namei.c:3895 [inline]
 path_openat+0x1500/0x3840 fs/namei.c:4131
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6c8576efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6c84dde038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f6c859c5fa0 RCX: 00007f6c8576efc9
RDX: 0000000000000042 RSI: 00002000000002c0 RDI: ffffffffffffff9c
RBP: 00007f6c857f1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000058 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6c859c6038 R14: 00007f6c859c5fa0 R15: 00007fffc4216518
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfs_new_inode+0xbc4/0xbd0 fs/hfs/inode.c:222
Code: 89 f1 80 e1 07 fe c1 38 c1 0f 8c 15 fa ff ff 4c 89 f7 e8 0f 6f 8b ff e9 08 fa ff ff e8 b5 b7 29 ff 90 0f 0b e8 ad b7 29 ff 90 <0f> 0b e8 a5 b7 29 ff 90 0f 0b 66 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900040af848 EFLAGS: 00010293
RAX: ffffffff829555d3 RBX: ffff8880335088c8 RCX: ffff888026d23c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1005214608 R12: ffff8880290a3000
R13: 1ffff110073d90f3 R14: 0000000100000000 R15: ffff8880335088c8
FS:  00007f6c84dde6c0(0000) GS:ffff888126cc2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e263fff CR3: 000000003276a000 CR4: 00000000003526f0


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

