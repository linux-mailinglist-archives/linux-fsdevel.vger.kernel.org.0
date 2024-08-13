Return-Path: <linux-fsdevel+bounces-25762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BD094FF6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 10:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C262D1F255F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 08:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED5A13A27E;
	Tue, 13 Aug 2024 08:14:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02538136354
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536866; cv=none; b=PYuCFbNktkdIVKyfFouzaJsethKuUtHkdU5r3tje+KQGoD4tE9JiaytVXmPFJloI0S+b4JD6jqu8t2U9xpX7lRsWjyh4+z+nNz97pg/gICB6TCb7BNmy+VxNJwe6U+XusaOW21BKDRP9lLeDGpG0hJPEPXWqwC+y8fkibcIJm1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536866; c=relaxed/simple;
	bh=FomqjS+QYX3iOXUn9eK+j8WW5o5T9/81V/pSIQuT21E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GMR3fohPbynDA5UXoE4b6BjAVnOfIRdsWqgEdUYfxX/iNg0VltUs7lSSZZGEDbVHrK6LfDkNPktAVZXlsfUZTYDdMB03+7CyNAOmQJCombeOnYPf2k+Yh9AHOQjSVVIPZqeuBFfopnabOI1UiTZriXIu4WKtF6Mr+Z1RtLPbgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f9504974dso610114739f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 01:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723536864; x=1724141664;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GhJ6QKXDPYK+XhTmeEEM6fSsRRxyeZJ5BW8H6AN89BE=;
        b=WVxcRFFIUX4oQ03viIWhYNVtX1GlZcgPBbufrWNeVSi7n5DWYDpueWeZmuE92O8hY+
         +f8l5WT4VdbZEiMkkfkWpqTGVES2xcTTYizLa3HMZcBaeqOH8Np9RAvn5Udomo5cbAPj
         3r63z0PAGHPkgAc07AHCPAGjOLe5OyjoDLL3+wcVSGJ27MhNRChp54jSzAr7ApOjBcJw
         zbZ9INVjSXKInTDoBQgLE1fvuyOWW6mxFe0sBOn118O5hgB7BSFxBbJlyHjxi5spKQin
         tztq24unn3LdpsoMgRxV3UALVe3qxpJ1BI1dg1H3g0KtgqmH3z6UpOvnn20KkPlJcOn9
         Cz/g==
X-Forwarded-Encrypted: i=1; AJvYcCVxNaEXv3SMmgJquoSk+ejQtKDQOeE/f+hJhN/8CxcqiHKYxJSDx+pgiOTODlAvDnjmwGuzbaVOvNuhR+unYYFhA2UZJDW4aATBCSPmeg==
X-Gm-Message-State: AOJu0Yx8dfTzFhjK/2ctY7WGm1+Bgph6GyxRtMI5LrdFpDE2Ti19Pze0
	E3RjPihj5G0IErZ9mDSAUA03mKBWdjLIWhGaXUkesPDEfXZf8VHg9DWwS9PMSzQxiIyYdLDfeBm
	8vmHcn2wJEaumJTxaZ3hhUPMRzbx8oMie0sfeNGv7LYslmITWVsyM+oY=
X-Google-Smtp-Source: AGHT+IHnDCAEuCrVymfF3bPssNiX8CsFNfas8Pk3Gce4Fl3ARBep0rxDoWq497+aQo6UosyZPAeLQBW1Bbnf9pEQTZ2UTvH/ARaR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:397:9426:e7fc with SMTP id
 e9e14a558f8ab-39c476a6361mr2018065ab.0.1723536864005; Tue, 13 Aug 2024
 01:14:24 -0700 (PDT)
Date: Tue, 13 Aug 2024 01:14:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008964f1061f8c32b6@google.com>
Subject: [syzbot] [iomap?] [xfs?] WARNING in iomap_write_begin
From: syzbot <syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com>
To: brauner@kernel.org, chandan.babu@oracle.com, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ee9a43b7cfe2 Merge tag 'net-6.11-rc3' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10b70c5d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139519d9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13deb97d980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e6062f24de48/disk-ee9a43b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5d3ec6153dbd/vmlinux-ee9a43b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/98dbabb91d02/bzImage-ee9a43b7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4d05d229907e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5222 at fs/iomap/buffered-io.c:727 __iomap_write_begin fs/iomap/buffered-io.c:727 [inline]
WARNING: CPU: 1 PID: 5222 at fs/iomap/buffered-io.c:727 iomap_write_begin+0x13f0/0x16f0 fs/iomap/buffered-io.c:830
Modules linked in:
CPU: 1 UID: 0 PID: 5222 Comm: syz-executor247 Not tainted 6.11.0-rc2-syzkaller-00111-gee9a43b7cfe2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__iomap_write_begin fs/iomap/buffered-io.c:727 [inline]
RIP: 0010:iomap_write_begin+0x13f0/0x16f0 fs/iomap/buffered-io.c:830
Code: b5 0d 01 90 48 c7 c7 a0 54 fa 8b e8 da 19 2b ff 90 0f 0b 90 90 e9 74 ef ff ff e8 5b f1 68 ff e9 4b f6 ff ff e8 51 f1 68 ff 90 <0f> 0b 90 bb fb ff ff ff e9 e9 fe ff ff e8 3e f1 68 ff 90 0f 0b 90
RSP: 0018:ffffc90003a577c0 EFLAGS: 00010293
RAX: ffffffff822a858f RBX: 0000000000000080 RCX: ffff888023080000
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000000000000
RBP: ffffc90003a57a50 R08: ffffffff822a8294 R09: 1ffff11029263f69
R10: dffffc0000000000 R11: ffffed1029263f6a R12: ffffc90003a579b0
R13: ffffc90003a57bf0 R14: ffffc90003a57990 R15: 0000000000000800
FS:  000055555f8fc480(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 0000000079b06000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_unshare_iter fs/iomap/buffered-io.c:1351 [inline]
 iomap_file_unshare+0x460/0x780 fs/iomap/buffered-io.c:1391
 xfs_reflink_unshare+0x173/0x5f0 fs/xfs/xfs_reflink.c:1681
 xfs_file_fallocate+0x6be/0xa50 fs/xfs/xfs_file.c:997
 vfs_fallocate+0x553/0x6c0 fs/open.c:334
 ksys_fallocate fs/open.c:357 [inline]
 __do_sys_fallocate fs/open.c:365 [inline]
 __se_sys_fallocate fs/open.c:363 [inline]
 __x64_sys_fallocate+0xbd/0x110 fs/open.c:363
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2d716a6899
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd620c3d18 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2d716a6899
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0700000000000000 R09: 0700000000000000
R10: 0000000000002000 R11: 0000000000000246 R12: 00007ffd620c3d60
R13: 00007ffd620c3fe8 R14: 431bde82d7b634db R15: 00007f2d716ef03b
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

