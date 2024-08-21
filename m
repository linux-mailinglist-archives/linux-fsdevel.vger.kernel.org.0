Return-Path: <linux-fsdevel+bounces-26558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3814B95A6B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6631C228F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466B617BB03;
	Wed, 21 Aug 2024 21:35:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E3517B4F5
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 21:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276126; cv=none; b=RTywUiFPjakLOwz2Ta+JwnVQ3hDQ9T+GTu9DeRboGeNQmtajaLRrktfl1a1XzjwGVwdkyP4TK3Rh0RK8avWYUIlBXdtQQfO4LNkYFFk8m00hwG+Xe2EXFMHfSWRlcxTPz6U/4jbv83UpQl6qBv9GQX3dO5o9ySI9AvCL7qzarJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276126; c=relaxed/simple;
	bh=vUQaYFXndd+mdawE8raqH6T8jvvRKMCrUVqe1jhGDX0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qjZ/cgRroIkOSgvQI5RvBKca56ZdNK8cTyHX1+0eMlBHEe9T9QDByxM5X98qV1KOYOByt+jn5bQte6STG+hiNSUzgH96VYyjf+xK99buxWzqDKFQXQM4sPdAIFg0ud3ace4Wg72zTdauRDiRxERKjAU5VIgwVG0sarzdGn0uXNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-824cae49445so13663539f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 14:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724276124; x=1724880924;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQw6YJn6NdIRCVuGMUTZXwYmyfAD1/60FpmlyYMrbOw=;
        b=KPIyieoEzAe0bJbIXkAphAtS3tzc8n7PtsK224YtMd9CvqRoe2jJcl5IQLC0tWUlzG
         zAmM9trR40awrU2QNYw6dJNxt6T1OUHaV4yBLNqFkbNdRr5gir2CG39zu60D5zxYl4jI
         atmM0d/XaIm+Zq7CYkB2qW05164dP1vUbm5We93GmOTmUFr5k110toOvmPdsefkv+wHm
         l1JH89PxqfMBW1HQm+7D4JNlrucb2LXcl0Zt/LJfRPZ6M+lqVgIiMuk2zVJqH7rfH6hI
         WdZNE93uA0+Uv0kiBGqpWqonM2wVYLQGh9xIKrifJQCMY9LWVtNiTDwxuQyAq7TmZKXO
         quCw==
X-Forwarded-Encrypted: i=1; AJvYcCWalLPpuBNkbKEncLIOLF3vCM9zVGvUvMmI/QyZihQCXLDyUHjVHi/5vWGc/th6p1VN9jKQNBA0vSa4rY++@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk2tgaSKWQv+ncfR/+prPvoVsNz3E5/KQ/WYH+7KhJm+AZr63p
	TxV8S8SYAiVSGcd5YMENThwnG3OUzWZv/skpKpNGgLR9ZuK8Et341GB7ryEJNAOeXn2DJCJEQVT
	D4DxWZucecsWlbLkLN4QmDvMVqcM85y1yXOSt0KLU9/jX2V7Mb1u74MQ=
X-Google-Smtp-Source: AGHT+IH4t0PYUcLRDuAh1AaCDw0+S8L2w6bBSW31yLr/83LYvX0PMoR8OXF15wnjCXP3BLwm33/sxEvLcLUYgRBK6QKN/B9VlIhh
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2590:b0:4c0:a8a5:81dc with SMTP id
 8926c6da1cb9f-4ce6308b194mr120542173.6.1724276123880; Wed, 21 Aug 2024
 14:35:23 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:35:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbda9806203851ba@google.com>
Subject: [syzbot] [bcachefs?] [jfs?] kernel BUG in vfs_get_tree
From: syzbot <syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jfs-discussion@lists.sourceforge.net, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b311c1b497e5 Merge tag '6.11-rc4-server-fixes' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17dfa42b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=c0360e8367d6d8d04a66
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16210a7b980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-b311c1b4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1c99fa48192f/vmlinux-b311c1b4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16d5710a012a/bzImage-b311c1b4.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/bcc0f964f07d/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/8d5780313c65/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com

bcachefs: bch2_fs_get_tree() error: EPERM
Filesystem bcachefs get_tree() didn't set fc->root
------------[ cut here ]------------
kernel BUG at fs/super.c:1810!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5368 Comm: syz.0.15 Not tainted 6.11.0-rc4-syzkaller-00019-gb311c1b497e5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:vfs_get_tree+0x29c/0x2a0 fs/super.c:1810
Code: ff 49 8b 1f 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 74 95 ee ff 48 8b 33 48 c7 c7 60 93 18 8c e8 b5 82 a7 09 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
RSP: 0018:ffffc90002c0fd08 EFLAGS: 00010246
RAX: 0000000000000032 RBX: ffffffff8ef44540 RCX: 3e1a74824a3f5500
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff11007074696 R08: ffffffff8174034c R09: 1ffff1100410519a
R10: dffffc0000000000 R11: ffffed100410519b R12: 0000000000000001
R13: dffffc0000000000 R14: ffff8880383a34b0 R15: ffff8880383a3498
FS:  00007fea882896c0(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7345eec538 CR3: 0000000037c0e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fea8757b61a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fea88288e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fea88288ef0 RCX: 00007fea8757b61a
RDX: 000000002000fec0 RSI: 000000002000ff00 RDI: 00007fea88288eb0
RBP: 000000002000fec0 R08: 00007fea88288ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000002000ff00
R13: 00007fea88288eb0 R14: 000000000000fe88 R15: 0000000020000040
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vfs_get_tree+0x29c/0x2a0 fs/super.c:1810
Code: ff 49 8b 1f 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 74 95 ee ff 48 8b 33 48 c7 c7 60 93 18 8c e8 b5 82 a7 09 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
RSP: 0018:ffffc90002c0fd08 EFLAGS: 00010246
RAX: 0000000000000032 RBX: ffffffff8ef44540 RCX: 3e1a74824a3f5500
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff11007074696 R08: ffffffff8174034c R09: 1ffff1100410519a
R10: dffffc0000000000 R11: ffffed100410519b R12: 0000000000000001
R13: dffffc0000000000 R14: ffff8880383a34b0 R15: ffff8880383a3498
FS:  00007fea882896c0(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efe67e50469 CR3: 0000000037c0e000 CR4: 0000000000350ef0
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

