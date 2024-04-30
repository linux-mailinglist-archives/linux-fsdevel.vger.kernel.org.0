Return-Path: <linux-fsdevel+bounces-18304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F568B6B55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 09:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73D31C21DB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6FD3A8D2;
	Tue, 30 Apr 2024 07:19:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AE2C184
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461565; cv=none; b=pNNWzTe/VhUb5Q1B+p76PXT7WONr3lWbiwF7q53IBG1OG4zBmwTOE1Ps2vJv7+xeOMwodwjoGw0iIKk2KGxH5GYucvIJtNOHyqExgA/8eO8Ra6JR4cDDdyr4nV4iBFP2C4spkRFkyHBYjeqbnxQxv8PHQTFHF4a6XFbZO34H8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461565; c=relaxed/simple;
	bh=hxT/zLuKhrvHe7RPN8WZzTXZWdbXsb/k35ynlb8Z3Pg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ofC+GLZCl4A4nWNwKix1U2mpb6cG6CG7Vo9JPtBsRzuQn5PqK3EfFzlgE4HlTbatVRZw2UDmkbMg9yCgtO11e8jvdV4aryvrKDBRHXV6rIPWw+Z5Tdp1ewAUxSmzAXXudfcZkdbZ4cYrLWcxR4H5B5Cyr2UFsR9RgLNFqqLzA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da42114485so612968739f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 00:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714461563; x=1715066363;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MilV/OT5yB6oxIhM5AEKqTMjTfTZzcUIfcce2zIqJ1c=;
        b=D4tMkeEeUG+1ebyEAbPR/23U/XSu71p/Yu1deRo06exxmvw9fqpf1ANGiQ4wDrFmId
         SB9Z3KyhwKlmIdNeok8AW/IhpbJmmVLjRhKo0oGxntaRZKZUsL8oxtm6BoEXOsCZ+yAQ
         mM/kaiDi3B7hn+ItQMJr6ZGWWWFTA/sAOkIWwJy7mxddbIDf0XT03BJDGIs12jRyj/A3
         qdgu5lzeP6T7z0P1iVrCMDh5M4rRwaAHbtpDE6b1SZcZ48istRY/HeFPXBA6HDwzb0Zh
         pLkLxT0JbAjQVes5PbPQdXPMXqg9lrwM3rkxOj5TuXGY8JxM4kE7ICCwdcjdBXId3Hmm
         fj5A==
X-Forwarded-Encrypted: i=1; AJvYcCUEZer7o/OG3eKtaA38kuUKY2kVVJSGhoWRBLcHgPD01I4Vp3+JLIHxAMwqWqUSGxqw8YyC6Me3QXILn8NAhisq7x3y90ZWelH3fKqXWQ==
X-Gm-Message-State: AOJu0YzNtclQz4hB8EDLaG76I0AuVr1TDo8F+0SKtprFdnX/qPHEYcz0
	9SgfdGxccq5mtcnqeIvKWUMhm+Lk2HLg2kb+e7Yz8LMwTloxeWmHSkcHj0qjgAj2DT0z1gwEKvf
	QL95LO67wA8CZ+bZbLGjR4DbS6CSzGNnTMadBpbhZYgn9EM42dFRsZWE=
X-Google-Smtp-Source: AGHT+IGgQeMK7yo6qNA9ufhuJLGl26ukQfJcIw3uhyA5Onhx9759iNoff+GML/M45UsGCt5soJ+8qvuc7a8V64pq4N2jOgVdP4h0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cd4:b0:7da:b30e:df80 with SMTP id
 j20-20020a0566022cd400b007dab30edf80mr104935iow.0.1714461563073; Tue, 30 Apr
 2024 00:19:23 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:19:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072c6ba06174b30b7@google.com>
Subject: [syzbot] [ext4?] WARNING in mb_cache_destroy
From: syzbot <syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b947cc5bf6d7 Merge tag 'erofs-for-6.9-rc7-fixes' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11175d5f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=dd43bd0f7474512edc47
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d2957f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1620ca40980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7318118d629d/disk-b947cc5b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88b2ce2fc8ea/vmlinux-b947cc5b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f3ffc239871/bzImage-b947cc5b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/224b657d209f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com

loop0: detected capacity change from 512 to 64
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5075 at fs/mbcache.c:419 mb_cache_destroy+0x224/0x290 fs/mbcache.c:419
Modules linked in:
CPU: 0 PID: 5075 Comm: syz-executor199 Not tainted 6.9.0-rc6-syzkaller-00005-gb947cc5bf6d7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:mb_cache_destroy+0x224/0x290 fs/mbcache.c:419
Code: 24 08 4c 89 f6 e8 9c e6 ff ff eb 05 e8 45 3b 6e ff 4c 8b 34 24 49 39 ee 74 33 e8 37 3b 6e ff e9 6a fe ff ff e8 2d 3b 6e ff 90 <0f> 0b 90 eb 83 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 58 ff ff ff
RSP: 0018:ffffc90003677a88 EFLAGS: 00010293
RAX: ffffffff8227d393 RBX: 0000000000000002 RCX: ffff88807c9ebc00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffff88801aeb3858 R08: ffffffff8227d312 R09: 1ffff1100dd2e204
R10: dffffc0000000000 R11: ffffed100dd2e205 R12: 1ffff1100dd2e200
R13: ffff88806e971020 R14: ffff88806e971000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ec96f85460 CR3: 000000000e134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_put_super+0x6d4/0xcd0 fs/ext4/super.c:1375
 generic_shutdown_super+0x136/0x2d0 fs/super.c:641
 kill_block_super+0x44/0x90 fs/super.c:1675
 ext4_kill_sb+0x68/0xa0 fs/ext4/super.c:7327
 deactivate_locked_super+0xc4/0x130 fs/super.c:472
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4207bbec89
Code: Unable to access opcode bytes at 0x7f4207bbec5f.
RSP: 002b:00007ffd518b18c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f4207bbec89
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007f4207c3b390 R08: ffffffffffffffb8 R09: 00007ffd518b19a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4207c3b390
R13: 0000000000000000 R14: 00007f4207c3c100 R15: 00007f4207b8cf60
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

