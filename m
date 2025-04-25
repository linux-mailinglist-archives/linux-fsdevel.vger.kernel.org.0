Return-Path: <linux-fsdevel+bounces-47311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC03A9BC42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 03:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05F11B847FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 01:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06035968;
	Fri, 25 Apr 2025 01:19:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39881179A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 01:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745543968; cv=none; b=n34jL50KbAJLybMQcZIHHWv5/RNlo3G1i4IQN++LDFJ1/ITG2uDFT6rMqVkThqD4Q2N/yKSAMn874ersmHtwDTFTZXRDF0gwN5paLVHUaetjGIC+A4SKaVuyqVfcXvf5YP8RDg7FkHW7CrpdIDlvd1ioSBve1QF3kJzVj7SfISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745543968; c=relaxed/simple;
	bh=9Y0c4cCk5XLOB9TPqpk0ouD8fs5c3qQNoyks5K7faQg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RdcBcpJGawFPnX7GZSHjyHsEGzL8Dgk97Sds2QVJerHwIW637fGEjH5Xns29Bntn+YglBXYY8EnMVt2tyfDnLKBCD1DBVtrQUkX9v9NgJHETMko2NvMr7QT/cPMH5t42D0LH19yjPGe3sdoS7e20gOiVECgbyc/b2eJHH/7UwrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85e4f920dacso138694739f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 18:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745543966; x=1746148766;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNdloWePwz5N2EpSscO41G0aPDOXUWyWp3FxRW5qank=;
        b=YAquAqy3qAWsGm1f69AwIvYaPcaIhiByJ7/6jQVAJq7sri28FYR7+0cbniIU8DvwZF
         IjvReU6pBNfbVRXA5SoW8o99/sCNjmzIHWMCkNeSoTrjwNMF8M6osNou+WrjYySGjTEQ
         A/6PR896pWHsiShhbeILr7IjPiwabhhTOolazHrqbk1yD891AaqsO5fwHDos1aa3hbaW
         B+XO7X8nbEJLx+z/0UeeCS4SM3ma4YXGa80YC3E19ZBkze1N642YvYLitaOplJJ6dUCy
         hzz68MfbKR6/SOpnOBmDcA6NceOblviFhDh0npTOFgEJHBzuq6QaZI6WxSBj2nBT7yC+
         07Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUS6jv2ZYNXdnXut6Gj5bYKVuTWuRQjkOC+vN5DWr4IwSp7E304LJ3qHC/ON4/YdwYdTM6vJcICkVBzM39i@vger.kernel.org
X-Gm-Message-State: AOJu0YxRBUgGFwAg/CcACGQD9rSdqqT9eca6ATmZDTRrrHJQlkCN/Trd
	ih8XpLPervfOEQ4ZF563ft2OymRhfcmIStZvx7cLpPoR/LBgnNEniQ4k7c1P+CBTHMwvJAi7liq
	b2CPk1E2Pon/PALeKtsmeQDwshVF8nl8pdCI6cALb6vXUDdXsN+ubdD8=
X-Google-Smtp-Source: AGHT+IEz8luqG7fjrdwt/uLH23QS7RtIa0ri9dCC+5NIHsHyfbhUiqIwYzoh4uPvCZALWWawg7CquuAlGILPTFlS+Lpbp/801qUR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:608b:b0:855:5e3a:e56b with SMTP id
 ca18e2360f4ac-8645cda6f2emr62023839f.12.1745543966364; Thu, 24 Apr 2025
 18:19:26 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:19:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680ae31e.050a0220.2c0118.0c72.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] kernel BUG in __filemap_add_folio
From: syzbot <syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, hare@suse.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mcgrof@kernel.org, syzkaller-bugs@googlegroups.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ac71fabf1567 gcc-15: work around sequence-point warning
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1269b204580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68d9f79fc685cd4
dashboard link: https://syzkaller.appspot.com/bug?extid=4d3cc33ef7a77041efa6
compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b2cc70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a91ccc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c03ec6447343/disk-ac71fabf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e02e7fb54511/vmlinux-ac71fabf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d53dcc94699/bzImage-ac71fabf.xz

The issue was bisected to:

commit 47dd67532303803a87f43195e088b3b4bcf0454d
Author: Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri Feb 21 22:38:22 2025 +0000

    block/bdev: lift block size restrictions to 64k

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d62c70580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13d62c70580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15d62c70580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com
Fixes: 47dd67532303 ("block/bdev: lift block size restrictions to 64k")

 __handle_mm_fault mm/memory.c:6140 [inline]
 handle_mm_fault+0x1129/0x1bf0 mm/memory.c:6309
 do_user_addr_fault arch/x86/mm/fault.c:1337 [inline]
 handle_page_fault arch/x86/mm/fault.c:1480 [inline]
 exc_page_fault+0x45b/0x920 arch/x86/mm/fault.c:1538
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
------------[ cut here ]------------
kernel BUG at mm/filemap.c:868!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 5909 Comm: syz-executor413 Not tainted 6.15.0-rc2-syzkaller-00493-gac71fabf1567 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:__filemap_add_folio+0x1554/0x16c0 mm/filemap.c:867
Code: e9 c5 ff 4c 89 e7 48 c7 c6 80 0e 54 8c e8 44 43 12 00 90 0f 0b e8 cc e9 c5 ff 4c 89 e7 48 c7 c6 00 05 54 8c e8 2d 43 12 00 90 <0f> 0b e8 b5 e9 c5 ff 4c 89 e7 48 c7 c6 80 0e 54 8c e8 16 43 12 00
RSP: 0018:ffffc90004087300 EFLAGS: 00010246
RAX: ba56fbab94ec7e00 RBX: 0000000000000004 RCX: ffffffff93686020
RDX: dffffc0000000000 RSI: ffffffff8e6497f7 RDI: 0000000000000001
RBP: ffffc900040874b0 R08: ffffffff905fe577 R09: 1ffffffff20bfcae
R10: dffffc0000000000 R11: fffffbfff20bfcaf R12: ffffea0001ededc0
R13: ffffc90004087400 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000555577940380(0000) GS:ffff88812509a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb2a265a1f0 CR3: 000000007eb78000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 filemap_add_folio+0x157/0x380 mm/filemap.c:969
 page_cache_ra_unbounded+0x40c/0x820 mm/readahead.c:275
 do_sync_mmap_readahead+0x3e6/0x6c0 mm/filemap.c:-1
 filemap_fault+0x763/0x13d0 mm/filemap.c:3403
 __do_fault+0x137/0x390 mm/memory.c:5098
 do_shared_fault mm/memory.c:5582 [inline]
 do_fault mm/memory.c:5656 [inline]
 do_pte_missing mm/memory.c:4160 [inline]
 handle_pte_fault+0xfcc/0x61c0 mm/memory.c:5997
 __handle_mm_fault mm/memory.c:6140 [inline]
 handle_mm_fault+0x1129/0x1bf0 mm/memory.c:6309
 do_user_addr_fault arch/x86/mm/fault.c:1337 [inline]
 handle_page_fault arch/x86/mm/fault.c:1480 [inline]
 exc_page_fault+0x45b/0x920 arch/x86/mm/fault.c:1538
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fb2a25adba4
Code: 2d 41 b8 13 00 00 00 bf 09 00 00 00 bb 03 00 00 00 e8 b0 14 03 00 ba 71 12 08 40 bf 10 00 00 00 48 b8 00 01 00 00 00 20 00 00 <48> c7 00 00 00 01 00 48 8b 35 1e 95 0a 00 48 89 c1 31 c0 e8 84 14
RSP: 002b:00007ffd9b4d3c20 EFLAGS: 00010217
RAX: 0000200000000100 RBX: 0000000000000003 RCX: 00007fb2a25df059
RDX: 0000000040081271 RSI: 0000000000b36000 RDI: 0000000000000010
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000013 R11: 0000000000000216 R12: 00007ffd9b4d3c4c
R13: 00007ffd9b4d3c60 R14: 00007ffd9b4d3ca0 R15: 0000000000000008
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__filemap_add_folio+0x1554/0x16c0 mm/filemap.c:867
Code: e9 c5 ff 4c 89 e7 48 c7 c6 80 0e 54 8c e8 44 43 12 00 90 0f 0b e8 cc e9 c5 ff 4c 89 e7 48 c7 c6 00 05 54 8c e8 2d 43 12 00 90 <0f> 0b e8 b5 e9 c5 ff 4c 89 e7 48 c7 c6 80 0e 54 8c e8 16 43 12 00
RSP: 0018:ffffc90004087300 EFLAGS: 00010246
RAX: ba56fbab94ec7e00 RBX: 0000000000000004 RCX: ffffffff93686020
RDX: dffffc0000000000 RSI: ffffffff8e6497f7 RDI: 0000000000000001
RBP: ffffc900040874b0 R08: ffffffff905fe577 R09: 1ffffffff20bfcae
R10: dffffc0000000000 R11: fffffbfff20bfcaf R12: ffffea0001ededc0
R13: ffffc90004087400 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000555577940380(0000) GS:ffff888124f9a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb2a265a1f0 CR3: 000000007eb78000 CR4: 0000000000350ef0


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

