Return-Path: <linux-fsdevel+bounces-6760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0870881C283
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 01:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093201C2477B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 00:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34D133DD;
	Fri, 22 Dec 2023 00:59:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B9723AD
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 00:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fc6d9af8bso13498915ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 16:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703206762; x=1703811562;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bVVahx3BMbe/+Cn6wS8S3q4MRh8dlbUkemq4XFsim4=;
        b=vHb79xrwLhW/jPzK4JNIoxMKIn4a3kxrKBnt80JsqVMVQU3b5Uv+Ojqlzto8eN/f3n
         5wuVw8YkcVMLNViCLk7HwFStaY8l/GkO2arbEvQMS0E55iEDm+ZgkymsJmdpn6YOXx+w
         uZNQ9ZdcvhN0sSkWqfY6vEWGR1BRGF5UjE9HEwGaZ+r8Kni8P/YU+XdR5JGjPfb/8c5n
         6NMMeFP1NBMHBW6nk0iX7cZ8mv8H7lJO4Uhsg6q/Qr/SSo53Ncf0T1CasOl6AmhMdvw7
         b+ndQ9GB6wD1Yof2Qqk7SfzndQRtuMIyeCcIxhTYM9JMtOpmSLnP4KG+++y6ehRy4oZH
         wGDg==
X-Gm-Message-State: AOJu0YyEWv7Oo03cxZVYSicLmnNKOoOHnn18uhb8vZ1hKR3LWQ8OBIwQ
	wmjQ4Lg4roAQBthjzA3LtbllGUHmGToeeKsuHV739oUyqc3L
X-Google-Smtp-Source: AGHT+IFZ82OCEBJtKQA3ZLJfA/92RKp4nRaY8BQx9Tx5kq6EIuMQmyeuWA8Jo4zhoTWTcyvb4dir9h0CMjPoLHuYN7V8dzmBvzEl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b89:b0:35f:d4dc:1b26 with SMTP id
 h9-20020a056e021b8900b0035fd4dc1b26mr39021ili.4.1703206762382; Thu, 21 Dec
 2023 16:59:22 -0800 (PST)
Date: Thu, 21 Dec 2023 16:59:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d0c82060d0eba14@google.com>
Subject: [syzbot] [udf?] WARNING in udf_free_blocks (2)
From: syzbot <syzbot+f98c5f7049564fe07d91@syzkaller.appspotmail.com>
To: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    55cb5f43689d Merge tag 'trace-v6.7-rc6' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15291f69e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5751b3a2226135d
dashboard link: https://syzkaller.appspot.com/bug?extid=f98c5f7049564fe07d91
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae263e8abe20/disk-55cb5f43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69616b96179e/vmlinux-55cb5f43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7f052dde6379/bzImage-55cb5f43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f98c5f7049564fe07d91@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 31925 at fs/udf/udfdecl.h:123 udf_updated_lvid fs/udf/udfdecl.h:121 [inline]
WARNING: CPU: 0 PID: 31925 at fs/udf/udfdecl.h:123 udf_add_free_space fs/udf/balloc.c:121 [inline]
WARNING: CPU: 0 PID: 31925 at fs/udf/udfdecl.h:123 udf_table_free_blocks fs/udf/balloc.c:403 [inline]
WARNING: CPU: 0 PID: 31925 at fs/udf/udfdecl.h:123 udf_free_blocks+0x1d59/0x23c0 fs/udf/balloc.c:681
Modules linked in:
CPU: 0 PID: 31925 Comm: syz-executor.3 Not tainted 6.7.0-rc6-syzkaller-00022-g55cb5f43689d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:udf_updated_lvid fs/udf/udfdecl.h:121 [inline]
RIP: 0010:udf_add_free_space fs/udf/balloc.c:121 [inline]
RIP: 0010:udf_table_free_blocks fs/udf/balloc.c:403 [inline]
RIP: 0010:udf_free_blocks+0x1d59/0x23c0 fs/udf/balloc.c:681
Code: 00 e8 4b b6 e1 fe 48 8b 9c 24 70 01 00 00 48 85 db 74 07 e8 29 b1 85 fe eb b7 e8 22 b1 85 fe e9 48 e7 ff ff e8 18 b1 85 fe 90 <0f> 0b 90 e9 45 ef ff ff 89 d9 80 e1 07 fe c1 38 c1 0f 8c 70 e3 ff
RSP: 0018:ffffc900032575e0 EFLAGS: 00010287
RAX: ffffffff8308b648 RBX: 0000000000000d36 RCX: 0000000000040000
RDX: ffffc90010d7a000 RSI: 0000000000001426 RDI: 0000000000001427
RBP: ffffc900032577f0 R08: ffffffff8308a589 R09: 1ffffffff1e017ad
R10: dffffc0000000000 R11: fffffbfff1e017ae R12: ffff888029e898c0
R13: dffffc0000000000 R14: ffff88803f1f701c R15: ffff88807b818000
FS:  00007fb4fbde66c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb4fbde6d58 CR3: 0000000038a3b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 extent_trunc+0x390/0x4a0 fs/udf/truncate.c:52
 udf_truncate_extents+0x627/0x12d0 fs/udf/truncate.c:251
 udf_setsize+0x1015/0x1470 fs/udf/inode.c:1293
 udf_setattr+0x370/0x540 fs/udf/file.c:235
 notify_change+0xb99/0xe60 fs/attr.c:499
 do_truncate+0x220/0x300 fs/open.c:66
 do_sys_ftruncate+0x2f3/0x390 fs/open.c:194
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fb4fb07cbe9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb4fbde60c8 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007fb4fb19c050 RCX: 00007fb4fb07cbe9
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000005
RBP: 00007fb4fb0c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fb4fb19c050 R15: 00007ffc4effc388
 </TASK>


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

