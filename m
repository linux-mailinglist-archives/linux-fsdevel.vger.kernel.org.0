Return-Path: <linux-fsdevel+bounces-33349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AF09B7B58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 14:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B742817DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 13:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0E219DF4D;
	Thu, 31 Oct 2024 13:07:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C7B1465A5
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380051; cv=none; b=WXNF5kYkldGZsqbP+8DVgnsA60VF1g+2CL/Ho4cRdeGsU/PM3NcY+uqhKcDssWMkpjiCtZlwUJGW8W7rRY2OXrZq/xMXAtDHXpa81XBDh7yvJlkCgDWYM2miHpeM+Yn2+FQQW2ylzxO55LAgLTrOx9x6Un/1ohbWF2Xeiwvi6bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380051; c=relaxed/simple;
	bh=EnCd7V7kOUgAlILZgPj5+S4HwDK/Jp6YHXgqLCvChaM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iSgkK5kNV9rRBmxCCljJtzz7IXD+fTGaeUfspcCL+e10Vh/KxEkd9EZBxfIxusXlxTDibcRE7wSab93XtJggNj2FLeIaVyQkP2/xS3Sa0PEeiIp+wHgRBko6Q5iMptCCwp5p84urKvwTsJi9oYC/WiYhmMQRbVlaWwL4dJUa1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83b567c78c3so121689939f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 06:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730380048; x=1730984848;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cjv+WqtMcy9ouAfIT1QqxvrnM8TaCDa/cxUm5K4B3rg=;
        b=G40e6QqC4xAlAoG0YgiDsoFtG6YSBDrse4JT6GuYXbzJmH7EwqiOhxEMsHJLJxIgYS
         AwxggJp7mXcRDjFveFjYlx7ygNtdA6iFZ1AAxGAaG96ZGfqW4UIRKJi3TLRASTlYoebC
         DUXRMMvEtK/ki7O/DDT56NR78B5ZVltr9V38qWEaMnloKQMgmE79F2sJRzhFLrW18sis
         2fq7S1PWimkUUgfxLHIujJkDVrOxe3cGCTyRZzyUcfG48hCtajCyWhHUZgiYjM9WfCXv
         N9CdxLzp3/jt93uLsSWgbetVIuK/EmCsPAKjo2DPWrlH0ltR4rlsJVHQP5ZgN+EVxj8F
         vtGw==
X-Forwarded-Encrypted: i=1; AJvYcCVB4VeWF9wMvVsmMwCiGHC4Lp9DLY4iuhAIkvG0bmq9F/Lpwz5MO8PqBjnjRwXOQUNzGHFGL2mVF/aE+Rs0@vger.kernel.org
X-Gm-Message-State: AOJu0YwF3Rm4VHulOiBPuVs9xaINJUU3JYrlOJjHxymFihVP6R5GS1YL
	+zKtlublykKCTzp1wLuvbuH7LgCvIA9HM2xI7e8TA3uiyK3mMlJjGZYFoBTlEsnBEKW3gwpuUU+
	+tOqzL7N8kTPgxvUnxbDC3QZvJ+XmihTWvxbzJgtw54S0Cv3cDPNCrNA=
X-Google-Smtp-Source: AGHT+IE0mtzqn8rwqpVt5b8vFi/ERneOmS9Mqd7LJA70oowZCNGdwnUMb1mIJPQuNIwZGUuAPlU84k/2fxGlkIcrHkpdCTP/q6K5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e08:b0:3a6:ad8c:9173 with SMTP id
 e9e14a558f8ab-3a6ad8c9327mr6802535ab.10.1730380048332; Thu, 31 Oct 2024
 06:07:28 -0700 (PDT)
Date: Thu, 31 Oct 2024 06:07:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67238110.050a0220.35b515.015e.GAE@google.com>
Subject: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    850925a8133c Merge tag '9p-for-6.12-rc5' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17192940580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10992940580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1503cca7980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-850925a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c831c931f29c/vmlinux-850925a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/85f584e52a7f/bzImage-850925a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com

R10: 0000000000000002 R11: 0000000000000246 R12: 00007f40bfa2741c
R13: 00007ffe565206f0 R14: 00007f40bfa2a5a1 R15: 0000000000000001
 </TASK>
------------[ cut here ]------------
kernel BUG at lib/iov_iter.c:624!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5311 Comm: syz-executor145 Not tainted 6.12.0-rc4-syzkaller-00261-g850925a8133c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:iov_iter_revert+0x420/0x590 lib/iov_iter.c:624
Code: 42 80 3c 20 00 48 8b 1c 24 74 08 48 89 df e8 17 07 43 fd 4c 89 2b e9 04 01 00 00 45 85 ed 48 8b 3c 24 75 16 e8 41 48 d9 fc 90 <0f> 0b 41 83 fd 05 48 8b 3c 24 0f 84 58 01 00 00 48 89 f8 48 c1 e8
RSP: 0018:ffffc9000d09f740 EFLAGS: 00010293
RAX: ffffffff84bba22f RBX: 000000000001e098 RCX: ffff88801f03a440
RDX: 0000000000000000 RSI: ffffffff8f098180 RDI: ffff888048077cf0
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff84bb9f14
R10: 0000000000000004 R11: ffff88801f03a440 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff888048077ce0 R15: fffffffffffe1f68
FS:  000055556a75b380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555bd33aafa0 CR3: 0000000041784000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_reset_iter+0xce/0x130 fs/netfs/misc.c:133
 netfs_clear_unread fs/netfs/read_collect.c:22 [inline]
 netfs_read_subreq_terminated+0x1fe/0xad0 fs/netfs/read_collect.c:491
 netfs_read_to_pagecache+0x628/0x900 fs/netfs/buffered_read.c:306
 netfs_readahead+0x7e9/0x9d0 fs/netfs/buffered_read.c:421
 read_pages+0x17e/0x840 mm/readahead.c:160
 page_cache_ra_unbounded+0x774/0x8a0 mm/readahead.c:290
 do_page_cache_ra mm/readahead.c:320 [inline]
 force_page_cache_ra+0x280/0x2f0 mm/readahead.c:349
 force_page_cache_readahead mm/internal.h:357 [inline]
 generic_fadvise+0x522/0x830 mm/fadvise.c:106
 ksys_readahead mm/readahead.c:695 [inline]
 __do_sys_readahead mm/readahead.c:703 [inline]
 __se_sys_readahead mm/readahead.c:701 [inline]
 __x64_sys_readahead+0x1ac/0x230 mm/readahead.c:701
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f40bf9e5689
Code: 48 83 c4 28 c3 e8 17 1a 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe565206c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000bb
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f40bf9e5689
RDX: 000800000000000d RSI: 0000000000000005 RDI: 0000000000000006
RBP: 00007f40bfa273ee R08: 00007ffe56520466 R09: 0000550032313335
R10: 0000000000000002 R11: 0000000000000246 R12: 00007f40bfa2741c
R13: 00007ffe565206f0 R14: 00007f40bfa2a5a1 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iov_iter_revert+0x420/0x590 lib/iov_iter.c:624
Code: 42 80 3c 20 00 48 8b 1c 24 74 08 48 89 df e8 17 07 43 fd 4c 89 2b e9 04 01 00 00 45 85 ed 48 8b 3c 24 75 16 e8 41 48 d9 fc 90 <0f> 0b 41 83 fd 05 48 8b 3c 24 0f 84 58 01 00 00 48 89 f8 48 c1 e8
RSP: 0018:ffffc9000d09f740 EFLAGS: 00010293
RAX: ffffffff84bba22f RBX: 000000000001e098 RCX: ffff88801f03a440
RDX: 0000000000000000 RSI: ffffffff8f098180 RDI: ffff888048077cf0
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff84bb9f14
R10: 0000000000000004 R11: ffff88801f03a440 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff888048077ce0 R15: fffffffffffe1f68
FS:  000055556a75b380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555bd33aafa0 CR3: 0000000041784000 CR4: 0000000000352ef0
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

