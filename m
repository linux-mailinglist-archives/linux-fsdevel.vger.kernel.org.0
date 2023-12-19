Return-Path: <linux-fsdevel+bounces-6515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F359C818F39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 19:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2931C208D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 18:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA1938F99;
	Tue, 19 Dec 2023 18:06:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66545381CA
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35f49926297so72257045ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 10:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009188; x=1703613988;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3UbpdPske9+0a0Vc1FEcrTZ1/WyUsWYEAt/9ne5SDRo=;
        b=n6ZWQ6rHr5O/kJ43Ww3luVBMBlPI287P8ny2fwpEpguD2sxE8J6BcfEK3Xz+seKGpR
         vrhvTdno+JevcutSNGyhxvydBzOpfyK9ERj0wbb+XGiKa9hDtC61ApSkiodZY0n2p95C
         7pxGsp5jKonY/Z7IT265gclEeevRYTiUouDhpIhIX6b9bON3qn5PcxTECBpsrxHHTnSH
         dUEB27jxtXnV4ukrQYgLKoT7Bjn0KefrxsriamccXXLkFKxpvecL30sEqQ5EbPL4vRu+
         tbrr0V25NdvbW0PXImGC/1S5EbS0Y+NYzgSVRa0Rsehv/seHWUew7LmHQsR3qNL4b0io
         hIxA==
X-Gm-Message-State: AOJu0YxtNj+Rco4tWdttAOWvGNdITss+3KDfU1X84rJHzb8W/ZhZ+VTL
	JymlLeSXOXBvxKxHjCzPoyv/900CBDZcqyPa1X07uh5Lbkc3VFM=
X-Google-Smtp-Source: AGHT+IE3CDj7nVBlj5XGQASnYOsOUQ3b+aTPpzcoXF820SJjjKjOaghaMz82PmSJt/AbH5rPN5jaSoVN3dI8sT91mjxQDaOFtDxO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d09:b0:35f:a338:44ae with SMTP id
 i9-20020a056e021d0900b0035fa33844aemr835304ila.3.1703009188670; Tue, 19 Dec
 2023 10:06:28 -0800 (PST)
Date: Tue, 19 Dec 2023 10:06:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd76a8060ce0b9a5@google.com>
Subject: [syzbot] [reiserfs?] kernel BUG in flush_commit_list (2)
From: syzbot <syzbot+99bd43b50bec81a1e6e3@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f7168591ebf Merge tag '6.7-rc5-smb3-client-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16940dc1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=99bd43b50bec81a1e6e3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/adeb888d7857/disk-3f716859.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a6ed44d5ad04/vmlinux-3f716859.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a04c379bea2a/bzImage-3f716859.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+99bd43b50bec81a1e6e3@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/reiserfs/journal.c:1107!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 17565 Comm: syz-executor.3 Not tainted 6.7.0-rc5-syzkaller-00134-g3f7168591ebf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:flush_commit_list+0x1c1e/0x1c50 fs/reiserfs/journal.c:1107
Code: ff 90 0f 0b e8 73 54 54 ff 90 0f 0b e8 6b 54 54 ff 90 0f 0b e8 63 54 54 ff 90 0f 0b e8 5b 54 54 ff 90 0f 0b e8 53 54 54 ff 90 <0f> 0b e8 4b 54 54 ff 90 0f 0b 44 89 f1 80 e1 07 80 c1 03 38 c1 0f
RSP: 0018:ffffc90014caf2e0 EFLAGS: 00010246
RAX: ffffffff823a28ed RBX: ffff888027da34d0 RCX: 0000000000040000
RDX: ffffc9000b8bc000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 0000000000000002 R08: ffffffff823a1d75 R09: 1ffff11006ed153f
R10: dffffc0000000000 R11: ffffed1006ed1540 R12: ffff888027da341c
R13: dffffc0000000000 R14: ffff888142a78000 R15: 1ffff11004fb469a
FS:  00007f607875e6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555a40978 CR3: 0000000012d8a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 flush_journal_list+0x2a8/0x1c80 fs/reiserfs/journal.c:1390
 flush_used_journal_lists+0x1256/0x15d0 fs/reiserfs/journal.c:1828
 do_journal_end+0x3d51/0x4b40
 do_journal_begin_r+0x970/0x1030
 journal_begin+0x14c/0x360 fs/reiserfs/journal.c:3254
 reiserfs_remount+0xf6f/0x18f0 fs/reiserfs/super.c:1559
 reconfigure_super+0x440/0x870 fs/super.c:1143
 vfs_cmd_reconfigure fs/fsopen.c:267 [inline]
 vfs_fsconfig_locked fs/fsopen.c:296 [inline]
 __do_sys_fsconfig fs/fsopen.c:476 [inline]
 __se_sys_fsconfig+0xab5/0xec0 fs/fsopen.c:349
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f6077a7cba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f607875e0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007f6077b9bf80 RCX: 00007f6077a7cba9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000004
RBP: 00007f6077ac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f6077b9bf80 R15: 00007ffcea3279c8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:flush_commit_list+0x1c1e/0x1c50 fs/reiserfs/journal.c:1107
Code: ff 90 0f 0b e8 73 54 54 ff 90 0f 0b e8 6b 54 54 ff 90 0f 0b e8 63 54 54 ff 90 0f 0b e8 5b 54 54 ff 90 0f 0b e8 53 54 54 ff 90 <0f> 0b e8 4b 54 54 ff 90 0f 0b 44 89 f1 80 e1 07 80 c1 03 38 c1 0f
RSP: 0018:ffffc90014caf2e0 EFLAGS: 00010246
RAX: ffffffff823a28ed RBX: ffff888027da34d0 RCX: 0000000000040000
RDX: ffffc9000b8bc000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 0000000000000002 R08: ffffffff823a1d75 R09: 1ffff11006ed153f
R10: dffffc0000000000 R11: ffffed1006ed1540 R12: ffff888027da341c
R13: dffffc0000000000 R14: ffff888142a78000 R15: 1ffff11004fb469a
FS:  00007f607875e6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4f92bfe000 CR3: 0000000012d8a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

