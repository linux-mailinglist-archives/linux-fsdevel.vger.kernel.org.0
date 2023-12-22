Return-Path: <linux-fsdevel+bounces-6783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B043481C865
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 11:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6142B285AA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 10:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE7C14F60;
	Fri, 22 Dec 2023 10:43:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D1911722
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7fef9ef2aso186982539f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 02:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703241799; x=1703846599;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CT53CObgRUozGFWwZUm2K0V6Jb7mE/jX/cyMGyMAkn0=;
        b=E6diKl8K6zsZRrqpraWYDKc/tfE9yBUiC4oojqkIMH1XlrVGLSY8hja3XRcOqMkgg5
         3gWTEBxv1poUMq1eZPZkyPtWVO5aXhrh1esaA9ds9zSinOhDl5SPWP6ScHVMCWG65wi8
         vYcnUjWDyZZWWv6wQ3cl73fSbCp9/ohCyPcqpU6Z9Y6vrW78Bqq2hYHbbHpKclNYjfcc
         M/lh9faGxVto2pvk04PNeuml15Fjgi0tG8uQTQ1VQJiCdr3lZDZZQL7h/yYwqOHn+642
         DUJuOQ+mrP1UkGio3P3mMTaLmIWEzYT7FP1Vyf9oELUBUtTwRlxFYvvDL2wFsnNL/5F1
         ObPw==
X-Gm-Message-State: AOJu0YyiFF+LJ7NuJPQIP8CVhjaltoIO1VQMUStSOPm18Eyf7SyQsplt
	z7m8KmiAA4SDnMj0eGao2MzOIQhUqokjJi43bUU9pQl/lV3R
X-Google-Smtp-Source: AGHT+IGaTtC/wTC1KlT5RpBgPTmplLBpwl4WlSTnt3UTbdo4aHw3HG/Cf2PtfIZctDBXrK1Tm14XwU5zadhrL5IFFumEdJzILsVI
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4bdd:b0:46d:2a2:a414 with SMTP id
 dk29-20020a0566384bdd00b0046d02a2a414mr6831jab.1.1703241799623; Fri, 22 Dec
 2023 02:43:19 -0800 (PST)
Date: Fri, 22 Dec 2023 02:43:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ee8fe060d16e2a5@google.com>
Subject: [syzbot] [ntfs3?] WARNING: kmalloc bug in ntfs_load_attr_list
From: syzbot <syzbot+f987ceaddc6bcc334cde@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9a6b294ab496 afs: Fix use-after-free due to get/remove rac..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12c1ee79e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5751b3a2226135d
dashboard link: https://syzkaller.appspot.com/bug?extid=f987ceaddc6bcc334cde
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1186ce6ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a4c431e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/de41d893a2be/disk-9a6b294a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/96edd77e193d/vmlinux-9a6b294a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1dc01d20de05/bzImage-9a6b294a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1a8ca9d17233/mount_0.gz

The issue was bisected to:

commit fc471e39e38fea6677017cbdd6d928088a59fc67
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Jun 30 12:12:58 2023 +0000

    fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=150ef3e9e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=170ef3e9e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=130ef3e9e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f987ceaddc6bcc334cde@syzkaller.appspotmail.com
Fixes: fc471e39e38f ("fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)")

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5058 at mm/util.c:632 kvmalloc_node+0x176/0x180 mm/util.c:632
Modules linked in:
CPU: 1 PID: 5058 Comm: syz-executor408 Not tainted 6.7.0-rc6-syzkaller-00168-g9a6b294ab496 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:kvmalloc_node+0x176/0x180 mm/util.c:632
Code: c3 44 89 fe 81 e6 00 20 00 00 31 ff e8 e3 d4 c1 ff 41 81 e7 00 20 00 00 74 0a e8 25 d1 c1 ff e9 3f ff ff ff e8 1b d1 c1 ff 90 <0f> 0b 90 e9 31 ff ff ff 66 90 f3 0f 1e fa 41 56 53 49 89 f6 48 89
RSP: 0018:ffffc90003c67588 EFLAGS: 00010293
RAX: ffffffff81cc9945 RBX: 0000000100000000 RCX: ffff8880246a1dc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81cc992d R09: 00000000ffffffff
R10: ffffc90003c67420 R11: fffff5200078ce89 R12: ffff888075aa1620
R13: ffff88807c8fc0a8 R14: 00000000ffffffff R15: 0000000000000000
FS:  000055555591b380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdedfd4000 CR3: 000000001c753000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvmalloc include/linux/slab.h:738 [inline]
 ntfs_load_attr_list+0x123/0x510 fs/ntfs3/attrlist.c:56
 ntfs_read_mft fs/ntfs3/inode.c:190 [inline]
 ntfs_iget5+0x10ad/0x3b70 fs/ntfs3/inode.c:534
 ntfs_loadlog_and_replay+0x17d/0x530 fs/ntfs3/fsntfs.c:297
 ntfs_fill_super+0x2cf1/0x4c60 fs/ntfs3/super.c:1268
 get_tree_bdev+0x416/0x5b0 fs/super.c:1598
 vfs_get_tree+0x8c/0x2a0 fs/super.c:1771
 do_new_mount+0x28f/0xae0 fs/namespace.c:3337
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f32f0f78d4a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdedfd3188 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffdedfd3190 RCX: 00007f32f0f78d4a
RDX: 0000000020000040 RSI: 00000000200000c0 RDI: 00007ffdedfd3190
RBP: 0000000000000004 R08: 00007ffdedfd31d0 R09: 000000000001f238
R10: 0000000000000005 R11: 0000000000000286 R12: 00007ffdedfd31d0
R13: 0000000000000003 R14: 0000000000200000 R15: 0000000000000001
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

