Return-Path: <linux-fsdevel+bounces-31950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31A799E21D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B3CB25F94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F0E1E202D;
	Tue, 15 Oct 2024 09:03:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14311C8787
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983011; cv=none; b=TiKKFGmek9pKyV8so3h9beIK1fZTLXJLRqUOqW10fCpBjrwIXzq5St0VkgRTzlrnJb59Z0TiHyaJCeep/XynymbYeFncd5TwEizUPV2y8Pu9JxjcSgbpJzgzUBfJray2niYQgFKG8dtgQgirvHjhl05cVcSYsp0UfTAC212BEXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983011; c=relaxed/simple;
	bh=qVQFFuzNBQ30wmWuiudOVggx8+ryyd5OC87w1cQkeyA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NKGOPl346Y8I3aAGtbV9bFPM/C9QBVbcOyYEGXClHB1dSpSvTH3BcewZPZBrHZ2wfAqqMmlqYJ3iIZ7wMQvppkRLXOQ+kMUnFYmZPKWhqDeKRojkRyAcmD395ufZGwzjQfMo69Pmmg7XbW+7qj5swZOR9vKlHC4sYz5R9Tay8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c4ed972bso12766835ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 02:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983009; x=1729587809;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIgyvK2789ssuMdmTWMqyL5nugwz4pmlemR7A0aasco=;
        b=G4XRUwg8l/kGS40F/cgqzsFm4JDtsMg4C102/X30lFhsR4TCCYViECsQOhIaZDFUNi
         RsCfuzbV9Zrunj0OQv69GHrH46iW9SGDmYrRoZR8z22qrxualLoWuXZ4HNTDuqVnIWMB
         m3o53tohgP62BpL3H2LXHrZacY8cyuK3zSpvG6EKFkKZJRv8dAGHQON1xCFgpyq3hPUe
         hBn9+FVcDJFAPRj83uEW1aYaU5j65epuMCUozmFF55apaMaO7NUXjQexquzplBHnI39M
         4txjn3WLI273Uk6uxfDc56aa1caWwqryd6oxzwXr66bzil8KvkKdwzoIqklU/O439Mm4
         WFJw==
X-Forwarded-Encrypted: i=1; AJvYcCXmTN9vLvUgGWulRMNy2HWHn/70Kdgt674nwjyNkoDBzdEfdwW4OtsMwRHbKx5GCLlUpXIWWrH1+kdAAJ11@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi44rY4xkYryiANqNSfQ1lev3oX46Pq24qyAiba7kaiQ+AXbdY
	HgTdwFFNX7a+CGZS1Q+n274kGSdUU5AFgQBSF94yIE2VPqwxcZcQagyN008TZasAH+BG/jEOOv4
	RBBS/DSMNqBvuDzTgkbaY08xZ6/Bb9m8awhih3jGTUJMEw84fdiXLXZc=
X-Google-Smtp-Source: AGHT+IFFYZyrAGS/UzyHNKkwU7tGU7x9vGFAB4+n1gb4UKvA5/dsCXYHlEr8ggOao+F3qH4Y7BPYqMXRdvPY0z9Sva+IDAm93akU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cb:b0:3a2:463f:fd9e with SMTP id
 e9e14a558f8ab-3a3bcdbb642mr87105465ab.6.1728983009102; Tue, 15 Oct 2024
 02:03:29 -0700 (PDT)
Date: Tue, 15 Oct 2024 02:03:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e2fe1.050a0220.d5849.0004.GAE@google.com>
Subject: [syzbot] [iomap?] WARNING in iomap_iter (3)
From: syzbot <syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, dhavale@google.com, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, huyue2@coolpad.com, jefflexu@linux.alibaba.com, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d61a00525464 Add linux-next specific files for 20241011
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=175a3b27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8554528c7f4bf3fb
dashboard link: https://syzkaller.appspot.com/bug?extid=74cc7d98ae5484c2744d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1513b840580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1313b840580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f615720e9964/disk-d61a0052.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4a45c7583c6/vmlinux-d61a0052.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d767ab86d0d0/bzImage-d61a0052.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fce276498eea/mount_0.gz

The issue was bisected to:

commit 56bd565ea59192bbc7d5bbcea155e861a20393f4
Author: Gao Xiang <hsiangkao@linux.alibaba.com>
Date:   Thu Oct 10 09:04:20 2024 +0000

    erofs: get rid of kaddr in `struct z_erofs_maprecorder`

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fd305f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13fd305f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15fd305f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com
Fixes: 56bd565ea591 ("erofs: get rid of kaddr in `struct z_erofs_maprecorder`")

erofs: (device loop0): mounted with root inode @ nid 36.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5233 at fs/iomap/iter.c:51 iomap_iter_done fs/iomap/iter.c:51 [inline]
WARNING: CPU: 1 PID: 5233 at fs/iomap/iter.c:51 iomap_iter+0x9db/0xf60 fs/iomap/iter.c:95
Modules linked in:
CPU: 1 UID: 0 PID: 5233 Comm: syz-executor323 Not tainted 6.12.0-rc2-next-20241011-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:iomap_iter_done fs/iomap/iter.c:51 [inline]
RIP: 0010:iomap_iter+0x9db/0xf60 fs/iomap/iter.c:95
Code: 0f 0b 90 e9 0a f9 ff ff e8 d2 10 62 ff 90 0f 0b 90 e9 42 fd ff ff e8 c4 10 62 ff 90 0f 0b 90 e9 71 fd ff ff e8 b6 10 62 ff 90 <0f> 0b 90 e9 d5 fd ff ff e8 a8 10 62 ff 90 0f 0b 90 43 80 3c 2e 00
RSP: 0018:ffffc900036af6e0 EFLAGS: 00010293
RAX: ffffffff8232e26a RBX: 0000000000004000 RCX: ffff88802b559e00
RDX: 0000000000000000 RSI: 0000000000018057 RDI: 0000000000004000
RBP: 0000000000018057 R08: ffffffff8232e03a R09: 1ffffd40001490be
R10: dffffc0000000000 R11: fffff940001490bf R12: 1ffff920006d5f05
R13: dffffc0000000000 R14: 1ffff920006d5f04 R15: ffffc900036af820
FS:  000055556b120380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 000000007edfe000 CR4: 00000000003526f0
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
RIP: 0033:0x7f5ca9685679
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8eaa5b98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffd8eaa5d68 RCX: 00007f5ca9685679
RDX: 0000000020000040 RSI: 00000000c020660b RDI: 0000000000000004
RBP: 00007f5ca96f8610 R08: 0000000000000000 R09: 00007ffd8eaa5d68
R10: 00000000000001e1 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd8eaa5d58 R14: 0000000000000001 R15: 0000000000000001
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

