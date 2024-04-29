Return-Path: <linux-fsdevel+bounces-18104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B68B59B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 15:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6482F1F23119
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280B36BB28;
	Mon, 29 Apr 2024 13:18:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A30548F3
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396713; cv=none; b=jqlQ7eC1Q5vzuaTjZ5WyG93p6N6VpsRSSzvTFqR9eKypOzjxzWhFzLtfTpS+JtL+krV6Ka6WvO8qWAv7gAUpQp9MEja1DGLhxSGPWtwupfy5EsUKVL4wqMCeN10qdcWIZf4JaScTNZRGCJX/EhzVQFvSZ9TQ8noD6BpwcAHFvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396713; c=relaxed/simple;
	bh=nAUzRtyfZc+YT5p13LOMII3XWYViOuMI7MpfCz3tj4o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iROAcpyP0H0xrAnwhjn7eRrs/uRmqqRrtCmD9pRW64bBaFv4lNdwbwXgjHVSP9BN8ny9qVdOx+ZiEvKmQE3Ty11ZjSz6UsdCOSc3gM8WkhszftxDgXgecPMK73zdktc44zEPkfV4hTcsPO9eCp11/IrmVMARYXGT/Rcsw0kFwe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c10cac5f9so27020555ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 06:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714396711; x=1715001511;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cuCBf4tttiDsG5JpIj8SVgWDFkDZthGhW/tj0MoVwMg=;
        b=IkQ4GS+mY8ah6RdSewfW/H3x39KYs0JWkGWbe9ChuDxRTR8IiLf9YfYstXxkC/89TK
         NPXbVhGI7sq5iLxNepoCxHuUIDptCpH9ddr1ozngPAXGifqwbmIFrxzYZjkQrDgswll8
         7wWRBVEefYqT0ZmL+nMTMGuVqn5LxO/ecb4jyAdH2o9+g18JhvTziYHLYm064kEbob1g
         QDErvZt2zlWGoZCBtST/mUVOGYVGJFQ/GvKKCb4clnYWWBkaPjCo/8+g054r+j+lTgy8
         sFsuasKH6s/hhEYU1OPZfuXdxb7ueIUyBUit0cXYxH4qRuF+2gv4CCfKRgx3NGRIekIZ
         UA4w==
X-Forwarded-Encrypted: i=1; AJvYcCWNO4bqUZOxbQ67DeNSAva9MsI970Tu3uKB0KL2ta6wrMb5uuoYNV9/iU03bur5/aBM9CPCTTJaNs1mrQtso5GzyjmqcpkDULL7n1V7NQ==
X-Gm-Message-State: AOJu0YzNB07YwnS7JpJe3fyTLryFGhRxdVu72kd8bEG7sWkW25tXNbBx
	iR0UlemZ51sjaeDG8mUQSFiFT395JPtDg3N1HiDQLe8+/9FgwzJbOy/EugOW278z5A+G+fseWlf
	F13DYY0qnij7mnvm6PN/lcxKEkYd8yFhTr+C3dsMFIkE0NUhDsg1V4OM=
X-Google-Smtp-Source: AGHT+IEc9AYzqZHLbQbZ7KmYBDG+f4zarqd82Oo976ESfl5shCzSxxJmxbO/HTKf8LTXt1Kl8i0LgwCW43xzQav+DCEsXuEQthuM
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a43:b0:36c:5029:1925 with SMTP id
 u3-20020a056e021a4300b0036c50291925mr124207ilv.0.1714396711562; Mon, 29 Apr
 2024 06:18:31 -0700 (PDT)
Date: Mon, 29 Apr 2024 06:18:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff44c506173c1642@google.com>
Subject: [syzbot] [nilfs?] kernel BUG in nilfs_delete_entry
From: syzbot <syzbot+32c3706ebf5d95046ea1@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, konishi.ryusuke@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5eb4573ea63d Merge tag 'soc-fixes-6.9-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1591a5e8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d46aa9d7a44f40d
dashboard link: https://syzkaller.appspot.com/bug?extid=32c3706ebf5d95046ea1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1213956b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ac32ef180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7e4c1378cbb1/disk-5eb4573e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8e4487ecdd86/vmlinux-5eb4573e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d84518ee028f/bzImage-5eb4573e.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/350446baf90d/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/e66542e7352f/mount_2.gz

The issue was bisected to:

commit 602ce7b8e1343b19c0cf93a3dd1926838ac5a1cc
Author: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri Jan 27 13:22:02 2023 +0000

    nilfs2: prevent WARNING in nilfs_dat_commit_end()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d757d8980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17d757d8980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13d757d8980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+32c3706ebf5d95046ea1@syzkaller.appspotmail.com
Fixes: 602ce7b8e134 ("nilfs2: prevent WARNING in nilfs_dat_commit_end()")

------------[ cut here ]------------
kernel BUG at fs/nilfs2/dir.c:545!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5115 Comm: syz-executor410 Not tainted 6.9.0-rc5-syzkaller-00296-g5eb4573ea63d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:nilfs_delete_entry+0x349/0x350 fs/nilfs2/dir.c:545
Code: 8d fe e9 de fd ff ff 44 89 f9 80 e1 07 fe c1 38 c1 0f 8c 20 ff ff ff 4c 89 ff e8 f2 a6 8d fe e9 13 ff ff ff e8 68 56 2c fe 90 <0f> 0b 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900036078b8 EFLAGS: 00010293
RAX: ffffffff8369aa08 RBX: 0000000000000050 RCX: ffff888018339e00
RDX: 0000000000000000 RSI: 00000000fffffffb RDI: 0000000000000000
RBP: 00000000fffffffb R08: ffffffff8369a8de R09: 1ffff1100806d722
R10: dffffc0000000000 R11: ffffed100806d723 R12: ffffea00010fed80
R13: ffff888043fb6038 R14: 0000000000000020 R15: ffff888043fb6020
FS:  00007fa2992ee6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd3dbd8b98 CR3: 0000000024b86000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_rename+0x57d/0xaf0 fs/nilfs2/namei.c:413
 vfs_rename+0xbdb/0xf00 fs/namei.c:4880
 do_renameat2+0xd94/0x13f0 fs/namei.c:5037
 __do_sys_renameat2 fs/namei.c:5071 [inline]
 __se_sys_renameat2 fs/namei.c:5068 [inline]
 __x64_sys_renameat2+0xd2/0xf0 fs/namei.c:5068
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa299358f49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa2992ee218 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007fa2993e16d8 RCX: 00007fa299358f49
RDX: 0000000000000006 RSI: 0000000020000100 RDI: 0000000000000005
RBP: 00007fa2993e16d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000580 R11: 0000000000000246 R12: 00007fa2993ade20
R13: 00007fa2993adb68 R14: 0030656c69662f2e R15: 3e2efc42dc31fca1
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:nilfs_delete_entry+0x349/0x350 fs/nilfs2/dir.c:545
Code: 8d fe e9 de fd ff ff 44 89 f9 80 e1 07 fe c1 38 c1 0f 8c 20 ff ff ff 4c 89 ff e8 f2 a6 8d fe e9 13 ff ff ff e8 68 56 2c fe 90 <0f> 0b 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900036078b8 EFLAGS: 00010293

RAX: ffffffff8369aa08 RBX: 0000000000000050 RCX: ffff888018339e00
RDX: 0000000000000000 RSI: 00000000fffffffb RDI: 0000000000000000
RBP: 00000000fffffffb R08: ffffffff8369a8de R09: 1ffff1100806d722
R10: dffffc0000000000 R11: ffffed100806d723 R12: ffffea00010fed80
R13: ffff888043fb6038 R14: 0000000000000020 R15: ffff888043fb6020
FS:  00007fa2992ee6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa2993149f0 CR3: 0000000024b86000 CR4: 00000000003506f0
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

