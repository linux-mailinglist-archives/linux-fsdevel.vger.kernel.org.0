Return-Path: <linux-fsdevel+bounces-16340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC2D89B735
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 07:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBA9B21B98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 05:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E95410942;
	Mon,  8 Apr 2024 05:37:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18EBE6F
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 05:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712554655; cv=none; b=PLqD0g67BGtfknaNhajR3AKzOFTxULeUihfhh4rGVcVuoiS3aVX5Y4sVoLDu1E4Ba+tW9j6bG2Ubu069asYWFkOlhyK4mDZ6L9LkuVZELUQ/SetNJgbsxCvL1H7EzeVz5+sVR9Qfm0EwRsP6ln93FM+3l0rw4Qc888sCAkZllnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712554655; c=relaxed/simple;
	bh=PlaoKMkkbwRopVHxjZ81zgR+BSt6yBxSGyH82WAI16g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rwE46daMTTqVJaEK0D47ien4eJdglGvh2h4jE2Q9xbKtPtrnqsOiS0q42t0bMX8yl3bmPjNNWg34QQUHcmQTip5qU6hxMJ21lwQVMBmseiMdl5x79TQNua4Uryz4iDzZ+Ol0HzamCPdsjbOgglTLxL5nUSYv/K6KOcHJRnyNOWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5d7d6b971so139635239f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Apr 2024 22:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712554653; x=1713159453;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKi95jyAR9UGqqxHndWlLAjt2KjqNn8010J0mQ3K9UQ=;
        b=vQMomN0HKK8iTPkzXXp7wf2pa/LP82e4JBgSTxNzjNUH9QTyDTzRLMF2vubKeUDIKK
         xt5llIzmQWT/6ND8oN4Gnn66iSIJ6Z2nybTuzk0LAz41QCdv4WKSPcPK9idw5LM7qLEY
         I2eAHjI8JIzxbMQM9vcEibcx0wcddJr3oaR4aAwifV7qBPk6BVSk5sq4g1d1N7n0cbya
         To3hqVlQ+yrokjERL7BbUeBYs5llat+/y2X16u8eUitrvzOuSTMeKnUTzPmRybw6WlWb
         ZZd/GbdsDMXNoBxYhrM2TSBM15mwm4G26YGQp5Zult3ZCJNYLrvsJf1CeBu03RfwRQSY
         05tg==
X-Forwarded-Encrypted: i=1; AJvYcCXG0PM8fgMLEdueHymYsfKbEOQnJgPwn4hK3QAvX0EnYzta92M+aaWRo9x2eZHvMpjrfM/qxJnIbSafoq9WgoA0wrYO3Gj5scf/dCgXwA==
X-Gm-Message-State: AOJu0YwDvckcfO+gR+rl2lsjljNS7WRwGPBCBHpT4usEmKoDMB/uWwJV
	oeCVfbXitWAalWMim3dRYGL6cQEL84anOyX9qV/+spFy0rfe00/n32DWGurFTPgilRuUUfTQIeo
	pRpkKnFBSwaW3FymudxILBHvlGQ64tKEtMGZDTGlo7VqIs9yWE+vzVPU=
X-Google-Smtp-Source: AGHT+IEHd5mSDwz8qlWZV7v1SpzIfoRT4uHkR2ekY/3S1NCd5xVfIvM29yPrBsNjRfpiszYDQhSnee5q4PhDNc+eJUGeN6trcYFE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:378d:b0:481:2592:4f5a with SMTP id
 w13-20020a056638378d00b0048125924f5amr401258jal.1.1712554653459; Sun, 07 Apr
 2024 22:37:33 -0700 (PDT)
Date: Sun, 07 Apr 2024 22:37:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7345f06158f331a@google.com>
Subject: [syzbot] [jffs2?] kernel BUG in jffs2_start_garbage_collect_thread
From: syzbot <syzbot+61a9d95630970eece39d@syzkaller.appspotmail.com>
To: arnd@arndb.de, dhowells@redhat.com, dwmw2@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16f4efc5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=61a9d95630970eece39d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ea8f4b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1754c105180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz

The issue was bisected to:

commit 9c8ad7a2ff0bfe58f019ec0abc1fb965114dde7d
Author: David Howells <dhowells@redhat.com>
Date:   Thu May 16 11:52:27 2019 +0000

    uapi, x86: Fix the syscall numbering of the mount API syscalls [ver #2]

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=168fca9d180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=158fca9d180000
console output: https://syzkaller.appspot.com/x/log.txt?x=118fca9d180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61a9d95630970eece39d@syzkaller.appspotmail.com
Fixes: 9c8ad7a2ff0b ("uapi, x86: Fix the syscall numbering of the mount API syscalls [ver #2]")

------------[ cut here ]------------
kernel BUG at fs/jffs2/background.c:40!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 5060 Comm: syz-executor108 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:jffs2_start_garbage_collect_thread+0x1f5/0x200 fs/jffs2/background.c:40
Code: 03 ff e9 1b ff ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 64 ff ff ff 48 89 df e8 76 78 03 ff e9 57 ff ff ff e8 9c 77 a3 fe 90 <0f> 0b 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000422fd00 EFLAGS: 00010293
RAX: ffffffff82f17cb4 RBX: ffff8880240a6018 RCX: ffff8880242b5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880240a6000
RBP: 0000000000000000 R08: ffffffff82f1c1c9 R09: 1ffff92000845f94
R10: dffffc0000000000 R11: fffff52000845f95 R12: ffff8880240a6000
R13: dffffc0000000000 R14: ffff8880240a6000 R15: ffff88802e7774f8
FS:  000055559415a380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f54dacad0d0 CR3: 000000007aeec000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jffs2_do_remount_fs+0x15b/0x1d0 fs/jffs2/fs.c:415
 reconfigure_super+0x445/0x880 fs/super.c:1071
 vfs_cmd_reconfigure fs/fsopen.c:267 [inline]
 vfs_fsconfig_locked fs/fsopen.c:296 [inline]
 __do_sys_fsconfig fs/fsopen.c:476 [inline]
 __se_sys_fsconfig+0xab5/0xec0 fs/fsopen.c:349
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f54dac35cf9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc9713c8d8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f54dac35cf9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000003
RBP: 0000000000010305 R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc9713c8ec
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jffs2_start_garbage_collect_thread+0x1f5/0x200 fs/jffs2/background.c:40
Code: 03 ff e9 1b ff ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 64 ff ff ff 48 89 df e8 76 78 03 ff e9 57 ff ff ff e8 9c 77 a3 fe 90 <0f> 0b 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000422fd00 EFLAGS: 00010293
RAX: ffffffff82f17cb4 RBX: ffff8880240a6018 RCX: ffff8880242b5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880240a6000
RBP: 0000000000000000 R08: ffffffff82f1c1c9 R09: 1ffff92000845f94
R10: dffffc0000000000 R11: fffff52000845f95 R12: ffff8880240a6000
R13: dffffc0000000000 R14: ffff8880240a6000 R15: ffff88802e7774f8
FS:  000055559415a380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc9713c7d8 CR3: 000000007aeec000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

