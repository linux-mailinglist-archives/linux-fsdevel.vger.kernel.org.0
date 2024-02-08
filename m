Return-Path: <linux-fsdevel+bounces-10763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 095AA84DD47
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF341F268CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E4B6BFCB;
	Thu,  8 Feb 2024 09:52:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170B16BFBB
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385953; cv=none; b=Vb80rFjb7NoA3K8+DPgduRNQzSjq86V4qAiISgYUJCcjaxgJY85vmeBCGieQtvMBo1ziNrSF+TLhUE2/K5lsuGSEXbKC5omN9VJUYuD0EQKaBhO42j2aL/kcq6ghZAVvUHin4GNjy6CRIPSB6Hl2biOBGq2BwsrWFcPX9bEMMeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385953; c=relaxed/simple;
	bh=2w4AWd2vd+J4/iZZi2T1fGQLpqiDUh6qJPxmeFNh5rw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WbD2FCwJVKeAAbAFyWI1UzIH2YHm66Z9QqLVfsQhT7+KfmxqQtGu0tpIdLZDSAloeiVPexgiPAjOK6fuckObcGdQJQBCzHjAQwInVZnmEBINQWXCVx0dzkSHkDKNrf6vu2LwztBs04tYiL74u2Ofh4d6HUggu+cbcGXfauh31eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363c3862a93so13885215ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 01:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707385951; x=1707990751;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agQyetsj5naa/u7LOwWHOmeV9dXsFEVSAys3SKLyAf0=;
        b=IlbOFSR714glS/Pj1hwn563PMTMwAdoJ5W1LlkqHBdy76r8ae7sAmVZZcC944cEUHo
         dYniWzB9oEQ4wofYO7/V3eyDF6VwvnrE9XadKjRkyZC7awuY+7O/vyQuixMdfTaz3YRn
         uLBQZ/pYuE7zMYnKAC6BZJeTAAgRuXXHhdeg2jH3AMmTkf4Q+Md0+UF/e7e2uzRRxqYM
         S0hz+d+hOL+y4dE3+HHvzuMvO2jkjeF/h1F4SsbAZjowb17J9ZZ3/JIKdatIOHM7hPaZ
         jzcmk5ouPghzBbJRo/TnQiKYGCBfyDHVdgVBEGJ3vH8tsIVzvuMz7m0g7UahEHzUl9RO
         sCkw==
X-Gm-Message-State: AOJu0Yx2nueuj5LjO0PZ4aY5v+5GumI3ot/jgr8YYtlzIOM3/Wr6EnA4
	AKgJdiqa6IXSyfSnbHCgE+Af+Mb2BU8mSW7J52Gheu9RyLYYVjuVdlEt7T+5UbPCZ86fzdts0Ro
	5Pjf11IZPYDrEs+ljkiHSofxH56y9A2z3j2KmomdM1pqla/YsVa+gIGI=
X-Google-Smtp-Source: AGHT+IGWYxfQPLsa25LGD4+WQy0pE/USEZf+EiCyvM8r6ZTVij5TJyJaUxV0twsV1+rYk36RCsZp/nMhCkzKf5Y4ssU8fLTgCeMW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219a:b0:361:9a73:5a8f with SMTP id
 j26-20020a056e02219a00b003619a735a8fmr561612ila.5.1707385951240; Thu, 08 Feb
 2024 01:52:31 -0800 (PST)
Date: Thu, 08 Feb 2024 01:52:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e48350610dbc5c5@google.com>
Subject: [syzbot] [gfs2?] general protection fault in gfs2_rindex_update
From: syzbot <syzbot+74edb1a3ea8f1c65a086@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    547ab8fc4cb0 Merge tag 'loongarch-fixes-6.8-2' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1461a16c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89a5d896b14c4565
dashboard link: https://syzkaller.appspot.com/bug?extid=74edb1a3ea8f1c65a086
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a8d318be4c39/disk-547ab8fc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8178462cbfb5/vmlinux-547ab8fc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/62939e7c5fbb/bzImage-547ab8fc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74edb1a3ea8f1c65a086@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000097: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000004b8-0x00000000000004bf]
CPU: 1 PID: 10382 Comm: syz-executor.0 Not tainted 6.8.0-rc3-syzkaller-00041-g547ab8fc4cb0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:gfs2_rindex_update+0xbc/0x3d0 fs/gfs2/rgrp.c:1037
Code: e8 f9 65 1d fe 4c 8d 74 24 60 48 8b 03 48 89 44 24 38 48 8d 98 b8 04 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 c6 65 1d fe 48 8b 03 48 89 44 24 20
RSP: 0018:ffffc900030af1a0 EFLAGS: 00010202
RAX: 0000000000000097 RBX: 00000000000004b8 RCX: dffffc0000000000
RDX: ffffc90004a81000 RSI: 0000000000029498 RDI: 0000000000029499
RBP: ffffc900030af2b0 R08: ffffffff83cb50d7 R09: 1ffff110078e74f8
R10: dffffc0000000000 R11: ffffed10078e74f9 R12: 1ffff92000615e3c
R13: ffff8880110c8000 R14: ffffc900030af200 R15: 0000000000000001
FS:  00007f9d475ff6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f81d7dff000 CR3: 0000000045cb6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 punch_hole+0xe7b/0x3a30 fs/gfs2/bmap.c:1809
 gfs2_truncatei_resume+0x3c/0x70 fs/gfs2/bmap.c:2159
 gfs2_glock_holder_ready fs/gfs2/glock.c:1336 [inline]
 gfs2_glock_wait+0x1df/0x2b0 fs/gfs2/glock.c:1356
 gfs2_glock_nq_init fs/gfs2/glock.h:238 [inline]
 init_statfs fs/gfs2/ops_fstype.c:694 [inline]
 init_journal+0x1680/0x23f0 fs/gfs2/ops_fstype.c:816
 init_inodes+0xdc/0x320 fs/gfs2/ops_fstype.c:884
 gfs2_fill_super+0x1edb/0x26c0 fs/gfs2/ops_fstype.c:1263
 get_tree_bdev+0x3f7/0x570 fs/super.c:1619
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1341
 vfs_get_tree+0x90/0x2a0 fs/super.c:1784
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f9d4827f4aa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9d475feef8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f9d475fef80 RCX: 00007f9d4827f4aa
RDX: 0000000020000040 RSI: 0000000020000100 RDI: 00007f9d475fef40
RBP: 0000000020000040 R08: 00007f9d475fef80 R09: 0000000000008c1b
R10: 0000000000008c1b R11: 0000000000000202 R12: 0000000020000100
R13: 00007f9d475fef40 R14: 0000000000012789 R15: 0000000020000140
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_rindex_update+0xbc/0x3d0 fs/gfs2/rgrp.c:1037
Code: e8 f9 65 1d fe 4c 8d 74 24 60 48 8b 03 48 89 44 24 38 48 8d 98 b8 04 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 c6 65 1d fe 48 8b 03 48 89 44 24 20
RSP: 0018:ffffc900030af1a0 EFLAGS: 00010202
RAX: 0000000000000097 RBX: 00000000000004b8 RCX: dffffc0000000000
RDX: ffffc90004a81000 RSI: 0000000000029498 RDI: 0000000000029499
RBP: ffffc900030af2b0 R08: ffffffff83cb50d7 R09: 1ffff110078e74f8
R10: dffffc0000000000 R11: ffffed10078e74f9 R12: 1ffff92000615e3c
R13: ffff8880110c8000 R14: ffffc900030af200 R15: 0000000000000001
FS:  00007f9d475ff6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb3c42d56c6 CR3: 0000000045cb6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 f9 65 1d fe       	call   0xfe1d65fe
   5:	4c 8d 74 24 60       	lea    0x60(%rsp),%r14
   a:	48 8b 03             	mov    (%rbx),%rax
   d:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
  12:	48 8d 98 b8 04 00 00 	lea    0x4b8(%rax),%rbx
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 c6 65 1d fe       	call   0xfe1d65fe
  38:	48 8b 03             	mov    (%rbx),%rax
  3b:	48 89 44 24 20       	mov    %rax,0x20(%rsp)


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

