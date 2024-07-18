Return-Path: <linux-fsdevel+bounces-23891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695149345D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 03:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056EF28400A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 01:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985352868D;
	Thu, 18 Jul 2024 01:31:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949F1C680
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266287; cv=none; b=tIv2adXZzrIu/NhqpMv5RpgQoZsJq8CypV5atJDnW7YDj5OT0mXUlfiTXvNp7M3D08VybsWXoIn92IBU95ieeP2XFgrd+FVQdi4LCV+KGnVtZtKF/u3yabMnN9sA/ozmmh7QZbfXyi7x3MyMZxPP/5ZKVHOY2bTUu5Wch8RXlN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266287; c=relaxed/simple;
	bh=bSFAwrHikfHtV5XAliAhDkqUwP7BAVOT7M7B3F3e+Ro=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jSRI/TSRejHTY0Vk4jUszHFkqHgjG8dDxla6YkNLjkkNYx/BX3LJbrBg8z2npQ5GDloz6lYE4x+ysLahJnSkLUSj0AwnBR9JGE2vflIcybFzIL3ewSDvUhZJRmoBOKdeI4LbkIg5o2Zpw2Rhx+EXxcmoNFQ7o2DhM6O/DtIPAc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-804b8301480so42812139f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 18:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721266285; x=1721871085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQ1BVktSx7DAWpt9QOHqXq4RsBhsS3hDO43i4FEFpdw=;
        b=ULVHSTKPtWDHf1k7pve2bCS13KULj+1p113r6qvr5rXM5z1y7VwbxpJBQXG2HvgEgG
         /uKnd7nVE5a3AIIP9hy8zJ2DGFYVjjal2HHkd2z+VNMXuFC/+PUKSq3wRIhWbkwOJHT/
         NegLmROkDm1PxvL9a3pGvEgJ1q0/bnjDd1h9ibOmzcOblpPNr4iK6kwEyePdqwEeHlCo
         qBb5FMJjvvuFvTOr0oywaqip1+FMew/JnH4c5oyFPjleNHf66/EpCrNVihmbglhLtUFn
         HlKwuiUOQ+Y73xv+Gjbn/eBHacJwQevex1UkN8v3LjGqYNkhIVC+ZrkfDFG0Ja8aF9c2
         rAZw==
X-Forwarded-Encrypted: i=1; AJvYcCVfA4YeXks/R4b02L/J4z6+CpnKPNC48ApUo+KceXmZlMwj06K+Om3xPRBUR/SqshCgKct8HUplTq+hRwvii4AmhUhGE3Vx5EWl7Edvgw==
X-Gm-Message-State: AOJu0Yxbiq2nMntIkjY73WcmSqiQMO+YYI0Hhk049W2Q0WgbVUX0jNHv
	0IUQeuBrvTg8kcDK52h73LEO3UFVy4E20RCAHwnXvHtKRBxSjBcMn5JjzluD+weCZ2FHTBBbMEY
	PYVGvoBIrGlBOyBnpDC1SR2Y1cWDLpYDNgAzXrjSa4aw0jHwrRCmhnEk=
X-Google-Smtp-Source: AGHT+IGLAY4Nutw+38nLhIs754r866qVPKgfnCJfnldbQ06hpA+fDzuprk7mXlT0+smxSxP5sFGPtwnGtwmXJPUIYnsXyzkSJGJc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:370b:b0:4b9:ad96:2adc with SMTP id
 8926c6da1cb9f-4c215b6b706mr145762173.4.1721266284769; Wed, 17 Jul 2024
 18:31:24 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:31:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077c88b061d7b893e@google.com>
Subject: [syzbot] [fs?] WARNING: lock held when returning to user space in ns_ioctl
From: syzbot <syzbot+dd73570cf9918519e789@syzkaller.appspotmail.com>
To: aleksandr.mikhalitsyn@canonical.com, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    51835949dda3 Merge tag 'net-next-6.11' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1758d8e6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2f87f8b8afcec45
dashboard link: https://syzkaller.appspot.com/bug?extid=dd73570cf9918519e789
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1799ccb5980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ef5b4e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/67cb6b0946ba/disk-51835949.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1946faba5973/vmlinux-51835949.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc2e329875bd/bzImage-51835949.xz

The issue was bisected to:

commit ca567df74a28a9fb368c6b2d93e864113f73f5c2
Author: Christian Brauner <brauner@kernel.org>
Date:   Sun Jun 7 20:47:08 2020 +0000

    nsfs: add pid translation ioctls

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113c7b2d980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=133c7b2d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=153c7b2d980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd73570cf9918519e789@syzkaller.appspotmail.com
Fixes: ca567df74a28 ("nsfs: add pid translation ioctls")

================================================
WARNING: lock held when returning to user space!
6.10.0-syzkaller-04472-g51835949dda3 #0 Not tainted
------------------------------------------------
syz-executor257/5082 is leaving the kernel with locks still held!
1 lock held by syz-executor257/5082:
 #0: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #0: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #0: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: ns_ioctl+0x3e0/0x740 fs/nsfs.c:184
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:337
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5082, name: syz-executor257
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
CPU: 1 PID: 5082 Comm: syz-executor257 Not tainted 6.10.0-syzkaller-04472-g51835949dda3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8437
 might_alloc include/linux/sched/mm.h:337 [inline]
 prepare_alloc_pages+0x1c9/0x5d0 mm/page_alloc.c:4454
 __alloc_pages_noprof+0x166/0x6c0 mm/page_alloc.c:4672
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 vma_alloc_folio_noprof+0xf3/0x1f0 mm/mempolicy.c:2304
 folio_prealloc+0x31/0x170
 wp_page_copy mm/memory.c:3285 [inline]
 do_wp_page+0x11cc/0x52f0 mm/memory.c:3677
 handle_pte_fault+0x117e/0x7090 mm/memory.c:5397
 __handle_mm_fault mm/memory.c:5524 [inline]
 handle_mm_fault+0xfb0/0x19d0 mm/memory.c:5689
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f72e4df2de0
Code: 41 54 55 48 89 f5 53 89 fb 48 83 ec 18 48 83 3d 0d 02 0a 00 00 89 54 24 0c 74 08 84 c9 0f 85 09 02 00 00 31 c0 ba 01 00 00 00 <f0> 0f b1 15 e0 2e 0a 00 0f 85 0f 02 00 00 4c 8d 25 d3 2e 0a 00 4c
RSP: 002b:00007ffd9317a820 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 00007f72e4e93110 RDI: 0000000000000000
RBP: 00007f72e4e93110 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
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

