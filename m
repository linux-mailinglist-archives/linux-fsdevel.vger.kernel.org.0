Return-Path: <linux-fsdevel+bounces-16893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316B18A4644
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 02:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B235F1F218A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 00:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB0B33C9;
	Mon, 15 Apr 2024 00:11:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C934632
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713139881; cv=none; b=r5l8c+6vd3bQ7yMMfDUnxvOBOJuC/WHCvOYxFaqL7Vkm5iH3rVDfbffdQEFCYEg4HjbxmDLeaMQe9bK0cUkBPz2JoMG7fMj9CeODLRhnKivXffGdWbpWYAHtvedcVua52MuHj2np6y+Nerqh+1nIRaQQqNsLDqEZiU8fBu4/K20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713139881; c=relaxed/simple;
	bh=C/Iu6C+EcnfYBh/f7HXhOOXESwUAXBibk9rsEmyREWw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kbaqcuXWiHA/D+/4urWpqCh3KQoZGwAEYF5yEWCQj9EubOT/ylGrW5nQfvicydrnql33RXYDAAGmc/+pBdbbtkcqq2j1J5C7SpDj23jEqGAxlKjRizX7AaJrsC4G2koO76SqqlpzD4DqhiEorhTyXb5WNARHh8u6eLiGEXQI1gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5e487d194so196883139f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Apr 2024 17:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713139879; x=1713744679;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EU0hVL6DfpMlcjjVDEdakS6ZSrs74/GbIpJ9Y08C8GI=;
        b=OWm8M9gr1LVmnHZaskIVdR0P6dq0MuglkpjHP2+6we04QBGDBJbuX9IfMVFKUiBUy8
         Cuhxv3uFnmDDWCX1a1TsEqD7tAJbCQ9aNz5LIfQcDQe+2dElue9nRZewreUG5f6z6N9K
         3FwiwyQTwzW1YhZv+68J9oT4VLqndpEH3kDIj9WtlZuZrrQMWyak3ioYpsT3aFmJ/omK
         CjknbEEEJJGvSpcvIft/u4k291ssjPeLMQERARjvPtzoTDCTaFrc+jxRYUWyVYoqEyTG
         MBgpqMujMt4frxjAAuNYut6VjpgH1n0b8a4rh+kiXhq/iJbLIihZ6Q6WdXITIQmRreA8
         sSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCAnYK78klSBaWtj63msId0caxLsAXF6msBYSRmhzmLdCH56n2MBpa9eqxFwX0G+ljLVgNxqrWLaF+bc0ykbbT3MvJvIoE1agLOnynow==
X-Gm-Message-State: AOJu0Yxy9MSlzHl/QO7pUxp9/2wOxyc5R+6OSBknDJZIItQj+W/6IcWl
	6TnMZymUM9OvdFPYVfk3JowKJKdwMyPKxdMrbSQnRGR0scpuecD/XjgJxx6sMZzFOOyziCMrr1o
	kPDIydzEkeiHuRxZuCilv/oLxIbWQ3uDxJ3H/HafC9S49Xt7PyTr4hO0=
X-Google-Smtp-Source: AGHT+IEUm1UkcYM/sIzxXDzHrbNcEpR3pcZf4v+sdN5pTv9AT4AiMUbEOpRb9EeYJuCnjMrfVj551rccxhb3hSmgI4DyUrvieT8s
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8504:b0:482:ead5:4f5d with SMTP id
 is4-20020a056638850400b00482ead54f5dmr321024jab.1.1713139878632; Sun, 14 Apr
 2024 17:11:18 -0700 (PDT)
Date: Sun, 14 Apr 2024 17:11:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eab13906161775e8@google.com>
Subject: [syzbot] [nilfs?] kernel BUG in submit_bh_wbc
From: syzbot <syzbot+3a841e887ad90c07541a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, konishi.ryusuke@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13f8135b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=3a841e887ad90c07541a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a7a983180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c5a29d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/12d8fad50ce0/mount_0.gz

The issue was bisected to:

commit 602ce7b8e1343b19c0cf93a3dd1926838ac5a1cc
Author: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri Jan 27 13:22:02 2023 +0000

    nilfs2: prevent WARNING in nilfs_dat_commit_end()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=128df913180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=118df913180000
console output: https://syzkaller.appspot.com/x/log.txt?x=168df913180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3a841e887ad90c07541a@syzkaller.appspotmail.com
Fixes: 602ce7b8e134 ("nilfs2: prevent WARNING in nilfs_dat_commit_end()")

NILFS (loop0): discard dirty block: blocknr=18446744073709551615, size=1024
NILFS (loop0): nilfs_get_block (ino=18): a race condition while inserting a data block at offset=0
------------[ cut here ]------------
kernel BUG at fs/buffer.c:2768!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 5056 Comm: syz-executor429 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:submit_bh_wbc+0x543/0x560 fs/buffer.c:2768
Code: 07 7d ff be 00 10 00 00 48 c7 c7 80 f8 26 8e 4c 89 fa e8 f0 cd be 02 e9 98 fe ff ff e8 86 07 7d ff 90 0f 0b e8 7e 07 7d ff 90 <0f> 0b e8 76 07 7d ff 90 0f 0b e8 6e 07 7d ff 90 0f 0b e8 66 07 7d
RSP: 0018:ffffc9000399f838 EFLAGS: 00010293
RAX: ffffffff8217ecd2 RBX: 0000000000000000 RCX: ffff88807cfe3c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8217e833 R09: 1ffff1100f095cae
R10: dffffc0000000000 R11: ffffed100f095caf R12: 0000000000000000
R13: ffff8880784ae570 R14: 0000000000000000 R15: 1ffff1100f095cae
FS:  00005555917ee380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 000000007f430000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 submit_bh fs/buffer.c:2809 [inline]
 __bh_read fs/buffer.c:3074 [inline]
 bh_read_nowait include/linux/buffer_head.h:417 [inline]
 __block_write_begin_int+0x12d0/0x1a70 fs/buffer.c:2134
 __block_write_begin fs/buffer.c:2154 [inline]
 block_write_begin+0x9b/0x1e0 fs/buffer.c:2213
 nilfs_write_begin+0xa0/0x110 fs/nilfs2/inode.c:262
 generic_perform_write+0x322/0x640 mm/filemap.c:3930
 __generic_file_write_iter+0x1b8/0x230 mm/filemap.c:4022
 generic_file_write_iter+0xaf/0x310 mm/filemap.c:4051
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa84/0xcb0 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f3d6ccdd9f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc74baec58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0073746e6576652e RCX: 00007f3d6ccdd9f9
RDX: 0000000000000020 RSI: 0000000020000140 RDI: 0000000000000005
RBP: 652e79726f6d656d R08: 00000000000b15f8 R09: 00000000000b15f8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc74baee28 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:submit_bh_wbc+0x543/0x560 fs/buffer.c:2768
Code: 07 7d ff be 00 10 00 00 48 c7 c7 80 f8 26 8e 4c 89 fa e8 f0 cd be 02 e9 98 fe ff ff e8 86 07 7d ff 90 0f 0b e8 7e 07 7d ff 90 <0f> 0b e8 76 07 7d ff 90 0f 0b e8 6e 07 7d ff 90 0f 0b e8 66 07 7d
RSP: 0018:ffffc9000399f838 EFLAGS: 00010293
RAX: ffffffff8217ecd2 RBX: 0000000000000000 RCX: ffff88807cfe3c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8217e833 R09: 1ffff1100f095cae
R10: dffffc0000000000 R11: ffffed100f095caf R12: 0000000000000000
R13: ffff8880784ae570 R14: 0000000000000000 R15: 1ffff1100f095cae
FS:  00005555917ee380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 000000007f430000 CR4: 00000000003506f0
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

