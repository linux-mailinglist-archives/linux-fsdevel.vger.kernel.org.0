Return-Path: <linux-fsdevel+bounces-58756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1930EB314D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED6A4BA04AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ADC2C11CA;
	Fri, 22 Aug 2025 10:09:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588242C029D
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857370; cv=none; b=YdUfCuH6M/oqCsB/lffozs5q4jQ6ijHnnkr797Qa2fLFY+EiZO5TrWsy9kd+UXJriFMaD0fgz0Pu3YEZwYY69sLWAF/MyqUIJ821zq9FUHowmJLXPmYlo1dZcjJ+DZxGQTsaL9ukSBvEUcsRERDyZxFm6p7T/lSzYyKpyuaobVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857370; c=relaxed/simple;
	bh=lTIPtZ/FQiu+wxGIVysw/XvafV7SUmZ7l1qW2Z9KJuc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SfuP9eTQbe0RZd5ArpR7lXjtgEluONuyOQUWtFgAyOiWODjIk39da/nEwhBhPPBHJvfPavDPRquKwzSJmUaG5+K12xtg8FI6eeH/hubEriilBhMyQg1WVp+4yZMqLrOyw4BHq49PEZQZ8W61oA3msMpB6uDozlzHrsxNE4MpHi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e6688959easo16875075ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 03:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857367; x=1756462167;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VRc3xIFCTnSdLY/FderHjqmKE6fBYoDej+8lK7B2w/Y=;
        b=CnvNWF4TD3isDyAf7u0xDv8rpxnaMLf/O1J171+2oM5c0erFK56xx+4aU6PAycVtz8
         cVemgs5N3QYyXekfQOQS+huGDx2iIBwyGULAtji18BcWJXAZGfBzm3NNVt7Ve+GZdOrM
         m2yVKmBy6d86ok7MIF4rNMZA3OxDajlyswuO0KQhwXNETHqZPhIFGUIZ+CetIdCiiw3C
         pXwDxu7dpUa13U49/wYiviIGojrYImGZuEv0uP7HFg7Yb/pHC2LH0bzdIO9iAQu/sKPd
         xSJCiTdZUfkc40+uFz8avmZHPr8gbNES+98eN5a2/N3yIbx1ndX6ptpJpjHo/D+hkcKH
         Y8qg==
X-Forwarded-Encrypted: i=1; AJvYcCWbaYFMJk86pTCfYal6Vze8zen0M6zVfDs0141O4mhkXCW/eNwyVO+30KlLDvnwm0ad6RmrEe9eeYigeTOr@vger.kernel.org
X-Gm-Message-State: AOJu0YyE2rIvOupfN4Of/cZNKPVyQPTI8Y9i3+oXolC7YNLct6+lRSsM
	XECv4W7JthqtfpxHAE6hw2co7PbwtofXc9Sqbt4sNsy2cjOvJ8RmyTqTQqgJKMbA1v6ZEbE1PIJ
	1QZJSebsNa/P9292UGP+NONkIt1rh3SosiZnmMntYr4dAR2nG9DsReaHAbIU=
X-Google-Smtp-Source: AGHT+IEMLm27wvZOVdNUPQaksCYCLLv5JHT+qmWWsl120o7UXyJbn/3MaL4zxA8MZvdeNNKsO1umGhqr7ga7N23ZAe1QhU0QLrqE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c5:b0:3e5:4db8:2f1a with SMTP id
 e9e14a558f8ab-3e921a5cce4mr36780815ab.11.1755857367275; Fri, 22 Aug 2025
 03:09:27 -0700 (PDT)
Date: Fri, 22 Aug 2025 03:09:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a841d7.050a0220.37038e.0051.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] linux-next test error: WARNING in __folio_start_writeback
From: syzbot <syzbot+0630e71306742d4b2aea@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-next@vger.kernel.org, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0f4c93f7eb86 Add linux-next specific files for 20250822
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=172c07bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=21eed27c0deadb92
dashboard link: https://syzkaller.appspot.com/bug?extid=0630e71306742d4b2aea
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/669ede8f5d66/disk-0f4c93f7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50feda89fe89/vmlinux-0f4c93f7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/317a0d3516fb/bzImage-0f4c93f7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0630e71306742d4b2aea@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: ./include/linux/backing-dev.h:243 at inode_to_wb include/linux/backing-dev.h:239 [inline], CPU#1: kworker/u8:6/2949
WARNING: ./include/linux/backing-dev.h:243 at __folio_start_writeback+0x9d5/0xb70 mm/page-writeback.c:3027, CPU#1: kworker/u8:6/2949
Modules linked in:
CPU: 1 UID: 0 PID: 2949 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:inode_to_wb include/linux/backing-dev.h:239 [inline]
RIP: 0010:__folio_start_writeback+0x9d5/0xb70 mm/page-writeback.c:3027
Code: 28 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 ff e8 ce a2 29 00 49 8b 07 25 ff 3f 00 00 e9 1b fa ff ff e8 7c 04 c6 ff 90 <0f> 0b 90 e9 d6 fb ff ff e8 6e 04 c6 ff 48 c7 c7 a0 f8 5f 8e 4c 89
RSP: 0018:ffffc9000bb06ea0 EFLAGS: 00010293
RAX: ffffffff81fad344 RBX: ffffea00050de8c0 RCX: ffff88802ee29e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000bb07010 R08: ffffc9000bb06f97 R09: 0000000000000000
R10: ffffc9000bb06f80 R11: fffff52001760df3 R12: ffffea00050de8c8
R13: 0000000000000000 R14: ffff888023060880 R15: ffff888023060660
FS:  0000000000000000(0000) GS:ffff8881258c3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7354907000 CR3: 000000000e338000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __block_write_full_folio+0x75f/0xe10 fs/buffer.c:1928
 blkdev_writepages+0xd1/0x170 block/fops.c:484
 do_writepages+0x32e/0x550 mm/page-writeback.c:2604
 __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1680
 writeback_sb_inodes+0x6c7/0x1010 fs/fs-writeback.c:1976
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2047
 wb_writeback+0x44f/0xaf0 fs/fs-writeback.c:2158
 wb_check_old_data_flush fs/fs-writeback.c:2262 [inline]
 wb_do_writeback fs/fs-writeback.c:2315 [inline]
 wb_workfn+0xaef/0xef0 fs/fs-writeback.c:2343
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

