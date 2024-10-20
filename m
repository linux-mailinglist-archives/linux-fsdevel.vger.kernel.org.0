Return-Path: <linux-fsdevel+bounces-32438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A42ED9A530E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 10:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCAD1C20EE0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 08:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B6438DC8;
	Sun, 20 Oct 2024 08:11:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2070514F70
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Oct 2024 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729411900; cv=none; b=ezeq1sLEhM/nIoeNRddo1fcOY70QwonUZxE6tMhPjD9O+DGDpxGJZXr5m2R3ywb2rU25WBsjpNaeszYiXDKBKbZxHcB1neItVBstIG2yH9m9jr6Z5FgRfRAScdlHpyr87WR+s5vBBwuKyXxilg2AErm5Kd1BoE6C3sDwbkMiivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729411900; c=relaxed/simple;
	bh=ZyMWFyzATpl7gRu/4GyRCbY2STjRj5U1XzquaXNCuC0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ORss+pf6PC/HGGO/dlsFHqUodyTDUTHN9AW1djsCm01O0lgYkp1ivrCztBeebKBIX23P6KJ680LLxZfuPD7K816hMecevwYNNFyZ3Tu2YWEQc3b9QhOHFVZx0oQS1FZUHu9XT4pcD5sQUpXUwcnCRKbAa3pqFvKgDoTVK9aR17o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b2aee1a3so33504765ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Oct 2024 01:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729411897; x=1730016697;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DNIoubmccZ0d+EUZGQlF8nJU3f2qCwuXExAlgMyym2o=;
        b=W2E6MmhYP/TKIN3J2kgI5fRLzNyfSOsy0B3ZtfGxsJhdeL67dxWJ8yoCPwcCIdBIwE
         DAGxNchHWhLuhUWHwCxJfb1xgvjnvDRvrHBEqr5G5OdVy3THPGuJya4RXQ8yxQF8JNN8
         Ac6igv5XOIt1FtF4hO7sOBVLXnRmYm3w3zTJQzH20CnwRlsQYWBiec7fTQwQsEZu5oMu
         lgu3N1S7qU7J8HLt3cNnGEJJy4Y0zyGoppoQi3vwslKZUzSgEwO4tTk4uPVR7nt6j+HG
         JagI8URL8cLhcXKPBHglVxyFgYOebdSBmq1hgVCz7/8hQnbKbYpxUL1voTP05QaehnQi
         bSfA==
X-Gm-Message-State: AOJu0Ywv03udW/wzb+eUjfXquGD3AzioJ+MHK1gSlbMQPDAdSiu9I7dq
	D9LfjQ9I4m9fj14yjFWztSGVWN1Ue30VngWUKRKkJA1PMWVrPH1gtZqH1hDmotTDGAvuKuT+xK6
	3oou7dKXmPzUeV+IuDYWP76FXgrWpTFgiuIi0355b/3Zl66ohtK9gTZM=
X-Google-Smtp-Source: AGHT+IH/c67AjGIAB1dGP22XRncw+0Ntb5AJHOdFGQbVgTgxbeicy0MokTm8um7LjlK0TfPhFQCnFRgo9qQC2WYMKJh3cDcvIQFs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c7:b0:3a0:480c:6ac4 with SMTP id
 e9e14a558f8ab-3a3f40b7328mr67150415ab.22.1729411897038; Sun, 20 Oct 2024
 01:11:37 -0700 (PDT)
Date: Sun, 20 Oct 2024 01:11:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6714bb39.050a0220.10f4f4.002e.GAE@google.com>
Subject: [syzbot] [fuse?] kernel BUG in fuse_dev_do_write
From: syzbot <syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    15e7d45e786a Add linux-next specific files for 20241016
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1597745f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c36416f1c54640c0
dashboard link: https://syzkaller.appspot.com/bug?extid=65d101735df4bb19d2a3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1623e830580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16582f27980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf2ad43c81cc/disk-15e7d45e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c85347a66a1c/vmlinux-15e7d45e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/648cf8e59c13/bzImage-15e7d45e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at include/linux/highmem.h:269!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5238 Comm: syz-executor755 Not tainted 6.12.0-rc3-next-20241016-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:zero_user_segments include/linux/highmem.h:269 [inline]
RIP: 0010:folio_zero_range include/linux/highmem.h:641 [inline]
RIP: 0010:fuse_notify_store fs/fuse/dev.c:1671 [inline]
RIP: 0010:fuse_notify fs/fuse/dev.c:1908 [inline]
RIP: 0010:fuse_dev_do_write+0x5d6d/0x5da0 fs/fuse/dev.c:1992
Code: c6 a0 11 41 8c e8 43 fc c9 fe 90 0f 0b e8 ab 55 7e fe 4c 89 ef 48 c7 c6 40 11 41 8c e8 2c fc c9 fe 90 0f 0b e8 94 55 7e fe 90 <0f> 0b e8 8c 55 7e fe eb 0c e8 85 55 7e fe eb c1 e8 7e 55 7e fe 4c
RSP: 0018:ffffc90003e67860 EFLAGS: 00010293
RAX: ffffffff83168cbc RBX: 0000000000001001 RCX: ffff88802178bc00
RDX: 0000000000000000 RSI: 0000000000001001 RDI: 0000000000001000
RBP: ffffc90003e67bb0 R08: ffffffff8316685c R09: 1ffffd40003defd8
R10: dffffc0000000000 R11: fffff940003defd9 R12: 0000000000001000
R13: ffffea0001ef7ec0 R14: 1ffffd40003defd8 R15: 0000000000000001
FS:  000055557fdec380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001f80 CR3: 000000007a4ca000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fuse_dev_write+0x148/0x1d0 fs/fuse/dev.c:2076
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffaa74606e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9501f418 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffaa74a9029 RCX: 00007ffaa74606e9
RDX: 000000000000002a RSI: 0000000020001f80 RDI: 0000000000000003
RBP: 00007ffaa74d3610 R08: 00007fff9501f5e8 R09: 00007fff9501f5e8
R10: 0000000020000200 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff9501f5d8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:zero_user_segments include/linux/highmem.h:269 [inline]
RIP: 0010:folio_zero_range include/linux/highmem.h:641 [inline]
RIP: 0010:fuse_notify_store fs/fuse/dev.c:1671 [inline]
RIP: 0010:fuse_notify fs/fuse/dev.c:1908 [inline]
RIP: 0010:fuse_dev_do_write+0x5d6d/0x5da0 fs/fuse/dev.c:1992
Code: c6 a0 11 41 8c e8 43 fc c9 fe 90 0f 0b e8 ab 55 7e fe 4c 89 ef 48 c7 c6 40 11 41 8c e8 2c fc c9 fe 90 0f 0b e8 94 55 7e fe 90 <0f> 0b e8 8c 55 7e fe eb 0c e8 85 55 7e fe eb c1 e8 7e 55 7e fe 4c
RSP: 0018:ffffc90003e67860 EFLAGS: 00010293
RAX: ffffffff83168cbc RBX: 0000000000001001 RCX: ffff88802178bc00
RDX: 0000000000000000 RSI: 0000000000001001 RDI: 0000000000001000
RBP: ffffc90003e67bb0 R08: ffffffff8316685c R09: 1ffffd40003defd8
R10: dffffc0000000000 R11: fffff940003defd9 R12: 0000000000001000
R13: ffffea0001ef7ec0 R14: 1ffffd40003defd8 R15: 0000000000000001
FS:  000055557fdec380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055874a56a790 CR3: 000000007a4ca000 CR4: 00000000003526f0
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

