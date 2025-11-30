Return-Path: <linux-fsdevel+bounces-70281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9860C951F4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 16:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67E3A3423E8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Nov 2025 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3408C278753;
	Sun, 30 Nov 2025 15:51:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2583717DE36
	for <linux-fsdevel@vger.kernel.org>; Sun, 30 Nov 2025 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764517865; cv=none; b=hp8PEKX+/hrTNLEX/l8Rzte2MVIQVgxbZPrlg6m22gp1VRNUvBlFRJ66Qfn3TT9PPyUyVyQyG/WgchFYEMFYV3QnajjfuiLsVpwGJ8vWwhny1dlG9BtUqpk/pcjkwfr1q1B5Z4jC9yIR+S9cHxXR0LauknoceKZCKVBvrHYdF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764517865; c=relaxed/simple;
	bh=My9JtOLxj2riP84dlYpqzrWrOrBwHAdgwgzehN+isPU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PEo2s7ZU71fB4KcBEAtT/+tUMGSXKsCR4qQgh4m2GSm8mpXlyP6L6tT0yOw7f5c8MJ/nputXSIrse7AGGKwHfdZsM1Ib1LobYmoVryaj1RMhDTeT+Fwp/GbacuAKQwBnbXZg5SSkrlRslknevzDmEJ6ba44U6soOX/ZycuENlFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-433199c7fb4so20804005ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Nov 2025 07:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764517863; x=1765122663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZQZPvsA+b1aEfkr/eSFp6Mc7KtxI3DMkvE2WO3Y+vA=;
        b=nnlqwknBxNo0MV2Irk0MSJFGz73ZuCFRaroXxxMBQeWTPQvPyu0EuoGjeKaGFV/iqz
         p81XBkq2WmiYi2xJHptPDzXAfGweEhvHAcBYx9qoZ9Do6WJOxfODOXlIYk5Od0dkLilr
         8uBTgky3zRYud0PS1CP4cktUkhV3X/cFcD5GNLTUfTcQTNlZUbFDWbjXe/A4fH8O4sGS
         pqn3JxMWXWCY9qc7hHcQ7mckOsQWVexqu4kXQ4jRoRr1hjGShANzu40i34sdrRTezKRs
         ydXz4VWGqEdUuQ7lFRGhd82TgyRd3D9mq94SUP3lUX+exR+MRWZcL0bvyowsJ8WFzuxf
         rH/w==
X-Forwarded-Encrypted: i=1; AJvYcCVrmfmjQf4shhoahIL64xOuuPFj/YaJdak4dSGpxofA8/DEQwBSIGsDu0iZ3QnVK7iSTk2WNDNIQuaCb9rD@vger.kernel.org
X-Gm-Message-State: AOJu0YzbixCszr9/1m0xDHxOgDrsrWed4tq/EWK7cfDeI8mtOXVFYKZY
	YkcnE4UIvUpwWOnzrfU4FvIcKATyUff9G7jXA0nA6kqxOV7smrPq7xZo/dYc3Q018B7YSm3HmVw
	Fzx6OIHp38MgoBlnvaoHX3nZ99Hni07Tggli/dm6gmopHw0Wg01BdfSoAURc=
X-Google-Smtp-Source: AGHT+IEmmk9ubAf028hrGiKPi9++Nhmn7ukhITaHj6Iks3+zKps4MCqnc1j5bumu0sk4b5fswov2N05NTj/viY/CsM1CDyCYT5wU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:433:7abd:96d0 with SMTP id
 e9e14a558f8ab-435b9851daemr263744155ab.3.1764517863270; Sun, 30 Nov 2025
 07:51:03 -0800 (PST)
Date: Sun, 30 Nov 2025 07:51:03 -0800
In-Reply-To: <ff6e08e2-a7c7-4ebf-8f93-03e5ece9b335@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692c67e7.a70a0220.d98e3.0172.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] kernel BUG in __filemap_add_folio
From: syzbot <syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, hare@suse.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mcgrof@kernel.org, ssranevjti@gmail.com, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in mpage_readahead

------------[ cut here ]------------
kernel BUG at ./include/linux/pagemap.h:1408!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 18176 Comm: syz-executor317 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__readahead_folio include/linux/pagemap.h:1408 [inline]
RIP: 0010:readahead_folio include/linux/pagemap.h:1434 [inline]
RIP: 0010:mpage_readahead+0x4ad/0x5a0 fs/mpage.c:367
Code: 5e 41 5f c3 cc cc cc cc e8 b0 19 70 ff 48 89 ef e8 48 06 ad ff e9 54 fe ff ff 4c 8b 6c 24 18 e9 43 ff ff ff e8 94 19 70 ff 90 <0f> 0b e8 8c 19 70 ff 48 c7 c6 00 b6 80 8b 48 89 ef e8 1d 39 ba ff
RSP: 0018:ffffc9000d92f620 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000d92fae8 RCX: ffffffff824c7d14
RDX: ffff88802fe68000 RSI: ffffffff824c809c RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000000000000004 R09: 0000000000000004
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: fffff52001b25f61 R14: 0000000000000001 R15: 1ffff92001b25f61
FS:  0000555564bcd380(0000) GS:ffff888124f53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f08297b0130 CR3: 0000000030a16000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 read_pages+0x1c4/0xc70 mm/readahead.c:163
 page_cache_ra_unbounded+0x66a/0xa10 mm/readahead.c:269
 do_page_cache_ra mm/readahead.c:332 [inline]
 page_cache_ra_order+0xc0b/0xf20 mm/readahead.c:542
 do_sync_mmap_readahead mm/filemap.c:3340 [inline]
 filemap_fault+0x1583/0x29a0 mm/filemap.c:3489
 __do_fault+0x10d/0x490 mm/memory.c:5281
 do_shared_fault mm/memory.c:5780 [inline]
 do_fault mm/memory.c:5854 [inline]
 do_pte_missing+0x1a6/0x3ba0 mm/memory.c:4362
 handle_pte_fault mm/memory.c:6195 [inline]
 __handle_mm_fault+0x1556/0x2aa0 mm/memory.c:6336
 handle_mm_fault+0x589/0xd10 mm/memory.c:6505
 do_user_addr_fault+0x60c/0x1370 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x64/0xc0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x7f082970586d
Code: 03 00 b9 03 10 12 00 45 31 c0 48 ba 80 00 00 00 00 20 00 00 48 b8 2f 64 65 76 2f 6e 75 6c 48 c7 c6 9c ff ff ff bf 01 01 00 00 <48> 89 02 48 b8 88 00 00 00 00 20 00 00 c7 00 6c 62 30 00 31 c0 e8
RSP: 002b:00007ffff735c180 EFLAGS: 00010246
RAX: 6c756e2f7665642f RBX: 0000000000000000 RCX: 0000000000121003
RDX: 0000200000000080 RSI: ffffffffffffff9c RDI: 0000000000000101
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000002000
R10: 0000000000000013 R11: 0000000000000206 R12: 0000000000079470
R13: 00007ffff735c19c R14: 00007ffff735c1b0 R15: 00007ffff735c1a0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__readahead_folio include/linux/pagemap.h:1408 [inline]
RIP: 0010:readahead_folio include/linux/pagemap.h:1434 [inline]
RIP: 0010:mpage_readahead+0x4ad/0x5a0 fs/mpage.c:367
Code: 5e 41 5f c3 cc cc cc cc e8 b0 19 70 ff 48 89 ef e8 48 06 ad ff e9 54 fe ff ff 4c 8b 6c 24 18 e9 43 ff ff ff e8 94 19 70 ff 90 <0f> 0b e8 8c 19 70 ff 48 c7 c6 00 b6 80 8b 48 89 ef e8 1d 39 ba ff
RSP: 0018:ffffc9000d92f620 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000d92fae8 RCX: ffffffff824c7d14
RDX: ffff88802fe68000 RSI: ffffffff824c809c RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000000000000004 R09: 0000000000000004
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: fffff52001b25f61 R14: 0000000000000001 R15: 1ffff92001b25f61
FS:  0000555564bcd380(0000) GS:ffff888124f53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f08297b0130 CR3: 0000000030a16000 CR4: 00000000003526f0


Tested on:

commit:         6bda50f4 Merge tag 'mips-fixes_6.18_2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11857514580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4a1ecf59be91960
dashboard link: https://syzkaller.appspot.com/bug?extid=4d3cc33ef7a77041efa6
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10dc7cb4580000


