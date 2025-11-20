Return-Path: <linux-fsdevel+bounces-69253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF2EC756CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 17:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id F3AA22B770
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A43369221;
	Thu, 20 Nov 2025 16:41:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A435CBD8
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656894; cv=none; b=Nlfo/2ESjq6bF6qcJBz7fmstqpIqN8dNJ0Q/OGBkOB20FHajnAPwu6sKJaRnc4egZQlC9eYitecNCzX8GHuMQb2vgCK8/FRKku8mDWsfDWj3apmbxCA0/iysuwx0ydJwpf5SVvxL3qTI9NcBedSev99lgu7VfbsEIBQqo7bLJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656894; c=relaxed/simple;
	bh=XyGpul2OWvhI+rCGkTNeYwTat2pe/iJLCkf4H5bLkr0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ByCDi8H1ymrWN38BOmCGIT5SyqwHE9XTSemcrdyZ5kteg6LndKw87+Bkza8pccXdPX1W1GX4xqhwCvV8P7uMh2yvmUQxbnaXUchmt3o8a/nqOeO/yQw7hxLvBYZcOmAFduGAInm0/7Oiq8xOhYVA1S1M4IQXtdHSZAZwgg2Scj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-43322fcfae7so11621935ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 08:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763656891; x=1764261691;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7iRowFGRjjOjAPTye6nCdxrnXCPwf6zOpBlOyrSH6Y=;
        b=ffXH253K35aZ2A/gaI3PGRAyJl0klgEBwyyBknJboIHYRaVAzqnC1TX5OprytycX5t
         qnfTLhoSelH+PU3CneqMcmFzA9TwKKivlJeoIJpsg8l6MExAneo6l4J7k1DnL21WcdNS
         W9dF43MTnnDcN1FbdoiL28xsmY7NvYHWowWMxxmh1z45UKfI2ossLjKfNukJgbubypMw
         AzdqGYGOWC/qXNeahek9zST8w7UoMjPHMfuBssb+aIxEGJ3V2hSs9HNh0MMeL5beH8gB
         D+L4wpeWzJCeM1fSFfvp1lebVVPLn0FXiJ077RmqtPtkq/UPH/EcvwSaJ9P7iS30dJKP
         mSHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNuczuQlhgeP5gjpt7TTVr6RXqzo83+VVhSAUGT8RWt3XcTvUXSiygZO+pgyJWBDPF9Z2sirgx0TmcRCN0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+GeAOOB6e8Uo2SeCG9awdYskozSbLCyL58/iIJJl9tLP59WEg
	fZWxrRm2kZkB8fF1Hm01YixHbXqPrP+eHjwXfoo+9CRuXTI1cz0YbLmhYsxGXYVpg83vnr9RdR4
	4yAefvKse0IrKNiCKPhxkuTo664W5mLyrPW7Xcv548aFS9yaVeVT4rHEp3hM=
X-Google-Smtp-Source: AGHT+IHomvNmuHjgaEEmUek0xiXlaU4iCMkSx4FQrkEX2c0/bL9WA4OeZT3a6ENP0aquXhKZqb1EkyKpSBLYaq23iYJvj5sdZ+ME
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3789:b0:433:29a9:32db with SMTP id
 e9e14a558f8ab-435a9073140mr31086985ab.24.1763656891668; Thu, 20 Nov 2025
 08:41:31 -0800 (PST)
Date: Thu, 20 Nov 2025 08:41:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691f44bb.a70a0220.2ea503.0032.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING in __folio_mark_dirty (3)
From: syzbot <syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    23cb64fb7625 Merge tag 'soc-fixes-6.18-3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1287997c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38a0c4cddc846161
dashboard link: https://syzkaller.appspot.com/bug?extid=b0a0670332b6b3230a0a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172cd658580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15378484580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a14ebce6c664/disk-23cb64fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7703c3032e2f/vmlinux-23cb64fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a16c5b94924d/bzImage-23cb64fb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4fa9525269b6/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=11d42a12580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com

EXT4-fs error (device loop0): ext4_ext_remove_space:2955: inode #15: comm syz.0.51: pblk 0 bad header/extent: invalid extent entries - magic f30a, entries 2, max 4(4), depth 0(0)
EXT4-fs error (device loop0) in ext4_setattr:6050: Corrupt filesystem
EXT4-fs error (device loop0): ext4_validate_block_bitmap:441: comm syz.0.51: bg 0: block 112: padding at end of block bitmap is not set
EXT4-fs error (device loop0): ext4_map_blocks:778: inode #15: block 3: comm syz.0.51: lblock 3 mapped to illegal pblock 3 (length 1)
EXT4-fs error (device loop0): ext4_ext_remove_space:2955: inode #15: comm syz.0.51: pblk 0 bad header/extent: invalid extent entries - magic f30a, entries 2, max 4(4), depth 0(0)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6107 at mm/page-writeback.c:2716 __folio_mark_dirty+0x1fb/0xe20 mm/page-writeback.c:2716
Modules linked in:
CPU: 0 UID: 0 PID: 6107 Comm: syz.0.51 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__folio_mark_dirty+0x1fb/0xe20 mm/page-writeback.c:2716
Code: 3c 38 00 74 08 48 89 df e8 52 a7 26 00 4c 8b 33 4c 89 f6 48 83 e6 08 31 ff e8 d1 ed c4 ff 49 83 e6 08 75 1c e8 66 e8 c4 ff 90 <0f> 0b 90 eb 16 e8 5b e8 c4 ff e9 7e 07 00 00 e8 51 e8 c4 ff eb 05
RSP: 0018:ffffc90003a079d0 EFLAGS: 00010293
RAX: ffffffff81f9c4ea RBX: ffffea0001213400 RCX: ffff888025260000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff94000242681 R12: ffff8880416cb4f0
R13: ffff8880416cb4e8 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000555587ebe500(0000) GS:ffff888126df7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000440 CR3: 000000002e288000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 block_dirty_folio+0x17a/0x1d0 fs/buffer.c:754
 fault_dirty_shared_page+0x103/0x570 mm/memory.c:3519
 wp_page_shared mm/memory.c:3906 [inline]
 do_wp_page+0x263e/0x4930 mm/memory.c:4109
 handle_pte_fault mm/memory.c:6211 [inline]
 __handle_mm_fault mm/memory.c:6336 [inline]
 handle_mm_fault+0x97c/0x3400 mm/memory.c:6505
 do_user_addr_fault+0xa7c/0x1380 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x7f385fe87398
Code: fc 89 37 c3 c5 fa 6f 06 c5 fa 6f 4c 16 f0 c5 fa 7f 07 c5 fa 7f 4c 17 f0 c3 66 0f 1f 84 00 00 00 00 00 48 8b 4c 16 f8 48 8b 36 <48> 89 37 48 89 4c 17 f8 c3 c5 fe 6f 54 16 e0 c5 fe 6f 5c 16 c0 c5
RSP: 002b:00007ffd3b8738f8 EFLAGS: 00010246
RAX: 0000200000000440 RBX: 0000000000000004 RCX: 0030656c69662f2e
RDX: 0000000000000008 RSI: 0030656c69662f2e RDI: 0000200000000440
RBP: 0000000000000000 R08: 0000001b2d820000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000009 R12: 00007f3860115fac
R13: 00007f3860115fa0 R14: fffffffffffffffe R15: 0000000000000004
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

