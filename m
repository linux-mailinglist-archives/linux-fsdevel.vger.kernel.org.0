Return-Path: <linux-fsdevel+bounces-73192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5FBD11554
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EF7530119C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F69345722;
	Mon, 12 Jan 2026 08:51:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A634404A
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207896; cv=none; b=X/ZyWm6kbWr1pAJC159VKRAK+RMbt3643ZoLAAeEesTQqLy7W9JRG7PSlNXpNtHmvJqKgiVPxc+BHKoDZtS9buEQabWA21ykM8rIji+1LHHz3I3e4elfOPkUXCNjy7aQ2g+Um58xO92ClDlfEloqA7cMh/L2MIljVA5PRni4AYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207896; c=relaxed/simple;
	bh=JsgcLBNPW/PItZNrVPTFDQ6Prc1mr2KW/nv3ZrhshsM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DlEITp83lMfjcGUTbNYCB+tTAq3Adud9me6Qf5ZUYohNuXQGIy6VGaWmb5qkenKVzsix0w7Hof3trovrPuAJ/DG2fBApL5iAyvjCBQaQzOJAPW95wFmWlfH4uDQsUOFJMvvWVHPiHbcoo9by2tBKIX29wiOBQSoQoQqbmig69qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-656b3efc41aso12691770eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 00:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768207893; x=1768812693;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HBXMlFLP+KHcFyP7DGlHIsjGobJ+WayPWzJFy4cutSo=;
        b=ociTxcyb/n1eSZT1vKaanVZp+L6K6VQW1SPV2MvuISaXG0alLP97dMSiSUanfF3Fad
         dQ8Z9CHHpUtcVaT2/j8e0Z/xvKFGjw7P2pBsV/0dSWNhDWJ37MwzwqhryHor7+URVBU1
         GeDAP3uYjRN6o5XIIqa/bya+EgxxWC3eUkcvSEUhp8hk6OWrSfftEV1YD3cuo3HmUi9a
         qvq63gMjnXQ/Q95+PIev2xIqKh8pNk6lFwRKY6JHXYbRWJ29AkrmT3uRdZJyj9hvf/A0
         LqU7Ckh8PR6EPgKm+91XYnAzGJeObCS0xGgzfNLrUedIKCT0qj+dewwqFApZehqmolt2
         DW0g==
X-Forwarded-Encrypted: i=1; AJvYcCUq9D78n2Thw4R7tz0dGHk4Ehn7NXQW++hzLcCmTF4kssS3/yEudKXl5n3synJuFltx9X821u0IOC+y5tqP@vger.kernel.org
X-Gm-Message-State: AOJu0YzZN8Jh4zqkcpxhPEPiWpaZ7ay3dVkkL/YdVx5ZdFoFbT4v8v4w
	9hiEmpYTqqfrsAA821zdbOJEqwtb2KySa4awKkcli0SFwOXszY3aPAVNRfS8wEoLa0KGP/EANUV
	g0L20ykxB+m/qBedjsi/NJvt83puAr08ChDv9+ULb/4vfxacwUVKPIglsZp4=
X-Google-Smtp-Source: AGHT+IF9xPghMJmrcwnSd8q7qpWXjQClrec2iT5Xa+5w1VLma8L+g7USymW0EB/L+yTwP0qBQvBf+rrQv0UT+QEN8E/nclOoJN9B
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a0:b0:65f:7009:d713 with SMTP id
 006d021491bc7-65f7009dd76mr3224819eaf.3.1768207893673; Mon, 12 Jan 2026
 00:51:33 -0800 (PST)
Date: Mon, 12 Jan 2026 00:51:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6964b615.050a0220.eaf7.0093.GAE@google.com>
Subject: [syzbot] [hfs?] kernel BUG in may_open (3)
From: syzbot <syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b6151c4e60e5 Merge tag 'erofs-for-6.19-rc5-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d45922580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7b058fb1d7dbe6b1
dashboard link: https://syzkaller.appspot.com/bug?extid=f98189ed18c1f5f32e00
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a7d19a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a2f19a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6eb5179ada01/disk-b6151c4e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc48d1a68ed0/vmlinux-b6151c4e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/061d4fb696a7/bzImage-b6151c4e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/df739de73585/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
VFS_BUG_ON_INODE(!IS_ANON_FILE(inode)) encountered for inode ffff8880384b01e0
fs hfsplus mode 0 opflags 0x4 flags 0x0 state 0x70 count 2
------------[ cut here ]------------
kernel BUG at fs/namei.c:4210!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6062 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:may_open+0x4b1/0x4c0 fs/namei.c:4210
Code: 38 c1 0f 8c 1e fd ff ff 4c 89 e7 e8 c9 ec ef ff e9 11 fd ff ff e8 df b3 8d ff 4c 89 f7 48 c7 c6 80 53 f9 8a e8 10 eb f5 fe 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90003ba78e0 EFLAGS: 00010282
RAX: 0000000000000088 RBX: dffffc0000000000 RCX: b41eda36b1e3ff00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000008241 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff52000774ec1 R12: 0000000000000000
R13: ffffffff8d709d80 R14: ffff8880384b01e0 R15: 0000000000000002
FS:  000055557d7cd500(0000) GS:ffff888126def000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f01916a5890 CR3: 0000000040598000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 do_open fs/namei.c:4635 [inline]
 path_openat+0x32a8/0x3df0 fs/namei.c:4796
 do_filp_open+0x1fa/0x410 fs/namei.c:4823
 do_sys_openat2+0x121/0x200 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_creat fs/open.c:1514 [inline]
 __se_sys_creat fs/open.c:1508 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1508
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f739c0cf749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd4aa21ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f739c325fa0 RCX: 00007f739c0cf749
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000200000000140
RBP: 00007f739c153f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f739c325fa0 R14: 00007f739c325fa0 R15: 0000000000000002
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:may_open+0x4b1/0x4c0 fs/namei.c:4210
Code: 38 c1 0f 8c 1e fd ff ff 4c 89 e7 e8 c9 ec ef ff e9 11 fd ff ff e8 df b3 8d ff 4c 89 f7 48 c7 c6 80 53 f9 8a e8 10 eb f5 fe 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90003ba78e0 EFLAGS: 00010282
RAX: 0000000000000088 RBX: dffffc0000000000 RCX: b41eda36b1e3ff00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000008241 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff52000774ec1 R12: 0000000000000000
R13: ffffffff8d709d80 R14: ffff8880384b01e0 R15: 0000000000000002
FS:  000055557d7cd500(0000) GS:ffff888126def000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f01916a5890 CR3: 0000000040598000 CR4: 00000000003526f0


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

