Return-Path: <linux-fsdevel+bounces-14275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D59F87A5C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 11:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62F02B21D62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 10:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E84E3B2AD;
	Wed, 13 Mar 2024 10:23:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AB03A1CB
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325408; cv=none; b=PvqQDfuQSVTGXYg5i12A2gq3fcFzzhdjKVWw5ATaOk5EYZNrj0lNLFzgaFP4QI509RKIda7ojVdQsj1E3ZBmUlX9/n3XBVAl3SknXyXwtnK7GQja0xVBBuM9+Ez5EfzywrTYsYnSwW1/UfXmc6af2bmc/NWpYNw0OPlTgBe/fx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325408; c=relaxed/simple;
	bh=4g6NpqxDKIAZqsfqcAVAFTYyZKeZMCms/fJDiM1DmMI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MvsOnsd/Kb6QD0vr6p40azLAH7FFgIxnu6eHfWiZDrukcP3hDMgSCVpIcx0Hm2VxsrVxbZ4+2ydfqwt3VHHubBAq4aseAboA+3Du6HwYUeUvPsyldm7sFwZH96AJ1WbnxO5ijM/Xp9tBqPQKyl4qsqieY+FQZtPVbsTn+EQxPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7e21711d0so492530539f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 03:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710325405; x=1710930205;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqUoFNSt8pQJe9OWJRSDP1Xac3QMIinGs6zqSmaMmpY=;
        b=BNfrc1zg+nTjfAIR5BUm34VFGwI1dnLGhz2rg9VHYgWreuSADEjwIU9YnUB6+0sOub
         1MmIYjSxr7NM1fMwYmDIWplgUzY1s/DAJPRWqo1fj6YWOU7MHopLaNt9zT0AD1juO5Jy
         IgfEpaluIpj7Kd9qrc5gn2pOwDjFkZPufBPHeZU4ui2segEoaM67qyO1p5zET3hkW/Pr
         DDCM2zWJA1L29Y429R7ZMcU4DwKIFVVfPQPy0/WuaCZ8T7FkCKLY3ogRzgMg9dyfnw+Z
         qp1Rrj4WdPPeRLxzhYRWF+TlFSYUA4qZgWsx9Jk7REVmMp6DqSKGg1Rgb4ZxQMQEbxVw
         Qf8g==
X-Forwarded-Encrypted: i=1; AJvYcCWlEK7J6lB/J8ksRFevUZmRkHvkeS+A+YSBd9MiPuyCVHw0luiDsCmjc34CcBHarr4CWiJ5oXjqodp8bdowSjQ78kqUr11HynSUa72ZVQ==
X-Gm-Message-State: AOJu0YxzhikPRypJjnonFP18siq8UAS7MUIYQTyiKhEywjjWL3UoL+Ww
	3TDF1ZbtWyppYrC00Rym4MpMUSc1VxWFi/0aTFvPWpW3yogbHWaN1P54KijsUd6g3gfcGro1SPg
	iyvua+KK6K+2RVA8fOLoCyUVBgWxxo4MuT5/Lga3mMtHAgBov8CkN/1Y=
X-Google-Smtp-Source: AGHT+IHypsCtXS9sd05e21LhuQFA8yALlR1TfQAfomfMr52JZ66PVFgcQNvvL/2Mh62IK4l37baIyRWF4vBbqH1RJSVWQigzQ8zX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b09:b0:474:e82a:7cec with SMTP id
 fm9-20020a0566382b0900b00474e82a7cecmr542093jab.1.1710325405487; Wed, 13 Mar
 2024 03:23:25 -0700 (PDT)
Date: Wed, 13 Mar 2024 03:23:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ea6ba0613882a96@google.com>
Subject: [syzbot] [fs?] WARNING in stashed_dentry_prune
From: syzbot <syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0f1a876682f0 Merge tag 'vfs-6.9.uuid' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1541d101180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0300fe4d5cae610
dashboard link: https://syzkaller.appspot.com/bug?extid=9b5ec5ccf7234cc6cb86
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1484d70a180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116b38d1180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9de3cd01214c/disk-0f1a8766.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af661293680e/vmlinux-0f1a8766.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a439df6ad20e/bzImage-0f1a8766.xz

The issue was bisected to:

commit 2558e3b23112adb82a558bab616890a790a38bc6
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed Feb 21 08:59:51 2024 +0000

    libfs: add stashed_dentry_prune()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108e578e180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=128e578e180000
console output: https://syzkaller.appspot.com/x/log.txt?x=148e578e180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com
Fixes: 2558e3b23112 ("libfs: add stashed_dentry_prune()")

WARNING: CPU: 0 PID: 5112 at fs/libfs.c:2117 stashed_dentry_prune+0x97/0xa0 fs/libfs.c:2117
Modules linked in:
CPU: 0 PID: 5112 Comm: syz-executor244 Not tainted 6.8.0-syzkaller-00295-g0f1a876682f0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:stashed_dentry_prune+0x97/0xa0 fs/libfs.c:2117
Code: 00 00 e8 3c cc e2 ff 31 c9 4c 89 f0 f0 49 0f b1 0f eb 05 e8 cb ac 80 ff 5b 41 5c 41 5e 41 5f c3 cc cc cc cc e8 ba ac 80 ff 90 <0f> 0b 90 eb e9 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003a97b88 EFLAGS: 00010293

RAX: ffffffff8212ba76 RBX: ffff88807e1bbe58 RCX: ffff8880786a0000
RDX: 0000000000000000 RSI: 0000000000000010 RDI: ffff88807e1bbd60
RBP: 0000000000000001 R08: ffffffff820ce514 R09: 1ffff1100fc377bf
R10: dffffc0000000000 R11: ffffffff8212b9e0 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff88807e1bbd60 R15: 0000000000000000
FS:  00007fbd2c2fc6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbd2c2dbd58 CR3: 0000000075822000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __dentry_kill+0xa9/0x630 fs/dcache.c:594
 dput+0x19f/0x2b0 fs/dcache.c:845
 prepare_anon_dentry fs/libfs.c:2018 [inline]
 path_from_stashed+0x695/0xb00 fs/libfs.c:2094
 pidfs_alloc_file+0x136/0x210 fs/pidfs.c:248
 __pidfd_prepare kernel/fork.c:2027 [inline]
 pidfd_prepare+0x7c/0x130 kernel/fork.c:2075
 pidfd_create kernel/pid.c:614 [inline]
 __do_sys_pidfd_open kernel/pid.c:650 [inline]
 __se_sys_pidfd_open+0xe4/0x280 kernel/pid.c:635
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fbd2c35c7d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbd2c2fc208 EFLAGS: 00000246 ORIG_RAX: 00000000000001b2
RAX: ffffffffffffffda RBX: 00007fbd2c3e63d8 RCX: 00007fbd2c35c7d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000013f0
RBP: 00007fbd2c3e63d0 R08: 00007fbd2c2fbfa7 R09: 0000000000000032
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbd2c3b317c
R13: 00007fbd2c2fc210 R14: 0000000000000001 R15: 00007fbd2c3b301d
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

