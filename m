Return-Path: <linux-fsdevel+bounces-19951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7C78CB93A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 04:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA28B2252D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 02:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA5E58210;
	Wed, 22 May 2024 02:55:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9ED5234
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 02:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716346534; cv=none; b=DLlaSnF5u1RJMPYqGcyvdmmp4eqcfDU+pYf4ylS/yNlU7gp/k0Plr3A0uHpKb7XoXeTJvlFWBtEguVrfxHBqJe7M7xI5iQPatXlOJaVimKpFzJzw9TVLe5iohDeQzETo1d2g0eeDECG3ZPoFCPX6AEnS0fs35bnRmFzAp6TfHJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716346534; c=relaxed/simple;
	bh=Fmq4cfmTdTx1iUl4iK3aruK2b4BklXedhpLLjn/V3gg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ifo9Yfc3fpPq5NSrVfN9ALMY9QUZrE6Cd0yOOuAoyzBvNoChsck25kfgUGqc/fyq0sZvCTxacCcaSHR2uHrwnDomiNrU9Zrzf3X2bTx+eN+VQxQ9hcNbh31UEG5mp0Uzoc2zp0tJldPOKKMwnDjKku0RVf4fkaWbRt4IapTFyg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e1d1c7229aso1191312339f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 19:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716346532; x=1716951332;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Ry/8RZHi+cirGva08ioXvtiJ6dGry8jsjjnUdJmvrA=;
        b=NE4X8SB83SvKzaCKFPkxW6OPb3TjgTnIGAo7K8y4P5j2LUr8+xid7qrORNMzbxaJUz
         5AVSbQuYiaHXMia4zdS3FvvVtD554Ho3J5jp3p4WGsJo9I7RygYS7aKOZZt7owRMNcsa
         CQmRwVt1LF/ZR2qPIfbJwcG2seNDVbhlHfaVAl8SCPdL10r2wHEMF2+g8zYoPXj95PxT
         NvrOc2fjrrGJALZHFK/lDGCY03gGlkoxalBDx3QY9xhpRCxUFpqziWweuVa9qkgV75Mc
         E1IFMa05pBK0UR5IdA4ZL2UAVzCM0N2VzfudL9BgSolw1ZaZOTxiDmNDTkApZ2/Hs/Yk
         IH/A==
X-Forwarded-Encrypted: i=1; AJvYcCVvvKICf+UJNedZQSJcqQxoKhV4k2xPMtwVlJ2+O9WKOsjsnO92w8u+mXQc/JzCYHADB8tf3WR9T8yUyzNdnZ6FyJ0YnCyFeYBQRZ0CTw==
X-Gm-Message-State: AOJu0YwTp/dV/xj8y2XVw/BSS/IyKfMmZih1P1nGuRlbYvC1wwVXw+dK
	nNh/NOE00+pxBpEBlLhDptuy3Y5j+RzALWy/B7GvYhBNHTiU43ikRgugjb4Bl5BTGv9RPtp2JXN
	D3j5rl5NsRc1cMDdlsqb/fKlv9b18ZlqkrPRmTcH97WVqSzkBlnYKDAE=
X-Google-Smtp-Source: AGHT+IE8dA3Y436YSv7w4/IDzm52Ag7PNo4+j3PLSkNAq1wZDNdZDmA0MipCEBB/rcPn+CkVUest9bxdsZlwz9iQbnABinemAg3b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:36c:2ed4:8d4c with SMTP id
 e9e14a558f8ab-371f96ed3aemr617085ab.4.1716346532155; Tue, 21 May 2024
 19:55:32 -0700 (PDT)
Date: Tue, 21 May 2024 19:55:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c66ec061902110a@google.com>
Subject: [syzbot] [nilfs?] [btrfs?] WARNING in filemap_unaccount_folio
From: syzbot <syzbot+026119922c20a8915631@syzkaller.appspotmail.com>
To: brauner@kernel.org, clm@fb.com, dsterba@suse.com, jack@suse.cz, 
	josef@toxicpanda.com, konishi.ryusuke@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b6394d6f7159 Merge tag 'pull-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142a7cb2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=713476114e57eef3
dashboard link: https://syzkaller.appspot.com/bug?extid=026119922c20a8915631
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d43f84980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d4fadc980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e1377d4772/disk-b6394d6f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/19fbbb3b6dd5/vmlinux-b6394d6f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4dcce16af95d/bzImage-b6394d6f.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/e197bb1019a1/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/1c62d475ecf4/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+026119922c20a8915631@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5096 at mm/filemap.c:217 filemap_unaccount_folio+0x6be/0xe40 mm/filemap.c:216
Modules linked in:
CPU: 1 PID: 5096 Comm: syz-executor306 Not tainted 6.9.0-syzkaller-10729-gb6394d6f7159 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:filemap_unaccount_folio+0x6be/0xe40 mm/filemap.c:216
Code: 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 0f 85 e5 00 00 00 8b 6d 00 ff c5 e9 45 fa ff ff e8 c3 66 ca ff 90 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 41 80 3c 06 00 74 0a 48 8b
RSP: 0018:ffffc9000382f1f8 EFLAGS: 00010093
RAX: ffffffff81cbd3ad RBX: ffff888079ef0380 RCX: ffff88802d4f5a00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff81cbd2c9 R09: 1ffffd40000c1ec8
R10: dffffc0000000000 R11: fffff940000c1ec9 R12: 1ffffd40000c1ec8
R13: ffffea000060f640 R14: 1ffff1100f3de070 R15: ffffea000060f648
FS:  00007f13ab0c76c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002ca92000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 delete_from_page_cache_batch+0x173/0xc70 mm/filemap.c:341
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:359
 truncate_inode_pages mm/truncate.c:439 [inline]
 truncate_pagecache mm/truncate.c:732 [inline]
 truncate_setsize+0xcf/0xf0 mm/truncate.c:757
 simple_setattr+0xbe/0x110 fs/libfs.c:886
 notify_change+0xbb4/0xe70 fs/attr.c:499
 do_truncate+0x220/0x310 fs/open.c:65
 handle_truncate fs/namei.c:3308 [inline]
 do_open fs/namei.c:3654 [inline]
 path_openat+0x2a3d/0x3280 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_creat fs/open.c:1496 [inline]
 __se_sys_creat fs/open.c:1490 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1490
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f13ab131c99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f13ab0c7198 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f13ab1bf6d8 RCX: 00007f13ab131c99
RDX: 00007f13ab131c99 RSI: 0000000000000000 RDI: 00000000200001c0
RBP: 00007f13ab1bf6d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f13ab18c160
R13: 000000000000006e R14: 0030656c69662f2e R15: 00007f13ab186bc0
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

