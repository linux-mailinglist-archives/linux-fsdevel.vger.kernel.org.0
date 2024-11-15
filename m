Return-Path: <linux-fsdevel+bounces-34898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547359CDE21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 13:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3871F22E98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DDC1BA86C;
	Fri, 15 Nov 2024 12:18:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045D41B0F1C
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731673102; cv=none; b=ZNb3oIPyzMI5CGarHz9OPAUSmnVevJ1RELz8pf5XIk+f6GUu04zajVgCXZaUhiPNm153iFQ3K/zX6ywy8Lq5yNr7JyxG3ZYAQCwY1RvGi2lhfhMB+xHQb8L3qqNCgl0XPiuBbr6v+f2f9j2s3Ug2bo06w4+j8bcnMJnDIRFhXtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731673102; c=relaxed/simple;
	bh=gu/QgsF8CP3zgp/9RFCHgqw+CwVzw7nqGrmh7Vcjc60=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PwSlw26tKHcofwQo7Rebe1a/L2OL6nasRMr7+75IVqdrema9O+gm4sCY7XBn2f7QLKq33R8dqJyPLMj15KRzwY6CVB1QnNJQrqXHfzbnt+9CfkRedJ282FoDkF3HiY7qsmE51RV//FmjToIhJbVAlI0FemYS+3UUh6h2eLHKm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so18149985ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 04:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731673100; x=1732277900;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWyIAe7Iyu79cPa4yiK4qyYvtRQUg06RByJAlqRtbP8=;
        b=K33bASN7yfkEmhOGi91BSoEB8Wo4LgHIyhbPgeRUSQzDj5R0RR0FvFt+Hj0APnoAKc
         I0Ezw3c1rlD/VtrB4hDH+g5i60QmSgJFI3hrdsO9RjLKR3YJT6RKxaNvg6I51ti1UtYg
         PSzD8RrNx0oYj+feUzZulAJwxox6YAELtez9egyPGXr29KAXvK11fxC+V8V9SavTj5iF
         aFcq5PTlcv6Fj5lDFC5GnI6V6W0KfV5TS+jzZv2yO37uDW9bt2QLMUL7eX7fh+iPYJ5A
         OrinZeZl8XkubWEv+z5MP1cVT6W4S3Vq4cx0DPUxLpwZNXrz38ZspGpV3YwOFpegNPq3
         H+TA==
X-Forwarded-Encrypted: i=1; AJvYcCWTBoNDyyWuiVfmVlhtGN7nREz99N7WPT0GI0YO4l21hEI/+zkEuwUToInyQdgLL/rDY5uGAsiBBaM6SQZn@vger.kernel.org
X-Gm-Message-State: AOJu0YxXBwLjZozXeJTDH6I0W7KkSa7gpBtDYIFOaCTvjEc9HwMjUvEI
	p5dqBON2NEwz2USHbZG6axcWDGjAlCCnozVf3pQopcL7ll3O9SDD55BddKzy1+ph6Jsvy5e8pV+
	11by5laTrgjdtnP3gxsfJcqASqwIaw2XbHKGL6ez3JOzArFWGBlrCknQ=
X-Google-Smtp-Source: AGHT+IHS83RxK07c7iu+7NBNxARqNlY4aGwLt7IOp5zWA1rimRz8w0n+4/b3UaoSpsjx6Op1sPuCWN4W6Gz4v8ZgFCtgF1iFzvnV
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:3a7:2237:1c4c with SMTP id
 e9e14a558f8ab-3a747ff8de0mr22755315ab.2.1731673100224; Fri, 15 Nov 2024
 04:18:20 -0800 (PST)
Date: Fri, 15 Nov 2024 04:18:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67373c0c.050a0220.2a2fcc.0079.GAE@google.com>
Subject: [syzbot] [iomap?] [erofs?] WARNING in iomap_iter (4)
From: syzbot <syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, djwong@kernel.org, hch@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10bee5f7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=6c0b301317aa0156f9eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b0e8c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c13ea7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a2d329b82126/disk-2d5404ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/37a04ca225dd/vmlinux-2d5404ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f837ce9d9dc/bzImage-2d5404ca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0a46612eab9b/mount_0.gz

The issue was bisected to:

commit 001b8ccd0650727e54ec16ef72bf1b8eeab7168e
Author: Gao Xiang <hsiangkao@linux.alibaba.com>
Date:   Thu Jun 1 11:23:41 2023 +0000

    erofs: fix compact 4B support for 16k block size

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=105174e8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=125174e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=145174e8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com
Fixes: 001b8ccd0650 ("erofs: fix compact 4B support for 16k block size")

=======================================================
erofs: (device loop0): mounted with root inode @ nid 36.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5826 at fs/iomap/iter.c:51 iomap_iter_done fs/iomap/iter.c:51 [inline]
WARNING: CPU: 0 PID: 5826 at fs/iomap/iter.c:51 iomap_iter+0x9db/0xf60 fs/iomap/iter.c:95
Modules linked in:
CPU: 0 UID: 0 PID: 5826 Comm: syz-executor236 Not tainted 6.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:iomap_iter_done fs/iomap/iter.c:51 [inline]
RIP: 0010:iomap_iter+0x9db/0xf60 fs/iomap/iter.c:95
Code: 0f 0b 90 e9 0a f9 ff ff e8 92 7f 65 ff 90 0f 0b 90 e9 42 fd ff ff e8 84 7f 65 ff 90 0f 0b 90 e9 71 fd ff ff e8 76 7f 65 ff 90 <0f> 0b 90 e9 d5 fd ff ff e8 68 7f 65 ff 90 0f 0b 90 43 80 3c 2e 00
RSP: 0018:ffffc90003ce76e0 EFLAGS: 00010293
RAX: ffffffff822f5a3a RBX: 0000000000670000 RCX: ffff8880490cda00
RDX: 0000000000000000 RSI: 0000000000670000 RDI: 0000000000670000
RBP: 0000000000670000 R08: ffffffff822f580a R09: 1ffffd400024b686
R10: dffffc0000000000 R11: fffff9400024b687 R12: 1ffff9200079cf05
R13: dffffc0000000000 R14: 1ffff9200079cf04 R15: ffffc90003ce7820
FS:  000055556b307380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 000000007d26e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_fiemap+0x73b/0x9b0 fs/iomap/fiemap.c:80
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x1bf8/0x2e40 fs/ioctl.c:841
 __do_sys_ioctl fs/ioctl.c:905 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f761d04b679
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc1fa5b488 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffc1fa5b658 RCX: 00007f761d04b679
RDX: 0000000020000040 RSI: 00000000c020660b RDI: 0000000000000004
RBP: 00007f761d0be610 R08: 0000000000000000 R09: 00007ffc1fa5b658
R10: 00000000000001f9 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc1fa5b648 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

