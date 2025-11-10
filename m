Return-Path: <linux-fsdevel+bounces-67680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FD2C46A72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 13:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD21D18855F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 12:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEA130E83A;
	Mon, 10 Nov 2025 12:38:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9143E1DF258
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778307; cv=none; b=vBJJXzq6yC8Q7LXsL3WKOozN+oqml5H9bQqJd2KJFQxboqiKLGS/Xcm6DxOowmL7UV/YkgZCPNBAPFRuEg8Vb8ognnd78HMo00gZ2XlGW+YXtbVJBQnPWYEz0PXa49yAao9YbD9TxVEHGS1RnSb85kG4OBpSrhYVlpBWgxIYwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778307; c=relaxed/simple;
	bh=BCfvvEXeY6H6UtpuWIrt7AopHRQuvES0wL5swHqk7IU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SIAb57n/WzF5M7ZyOyBkrAxAI7lQEvv2Zh5uVnbMp3N7OFxPIA0TcSFSm9B2DEuZaBpdnfX9isk6SO9hjBCe/NdtjTuZaIgRgrZQvKFAGI9/AgLcI1xkQocTQFm6d0Ic2h1d5BupkXLLpBNA10nqAcdLxTx+jevxwD9w1A7EhTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-433770ba913so14643175ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 04:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778305; x=1763383105;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHR+NKBcK3L+aBXZ8xDlwRY8dl6XpDqfRmEc/iDSCro=;
        b=b7C+j72PtltE5Z4BvOiHW4OWsqug/IpYcdZ5VLMHcxq5/WPbKDr1t/AW1wnVSedC7E
         dEiFd5tQMx9IIZRf8Lk8yTMmHzJYj3c3W7a6c/t9H+vcOfEWqCA6rF3bB2BT5ou3mI8j
         aVe7dEQn3rsfqvQvni4Bq+d/pWoTcFzPpsMJWgfN/FvocfuHw+09Tfq+AhsVSUnft5k+
         v602sFzo/rKTGP3qixuneHB9oDJ4KP6Ht8cZfhL+CDJGHzmMIXvenYyuK8H0T7ReRGmg
         CxR5dRRuyECn/MbHuENkcsRnkR3rK4iZq7Hpc0E0XnlgxISx4C8rvVBHljg62pWmQZ0j
         2ylQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMHuNqt/GkUlr0hA1JIuOEUYBRVV0WDmSQUw5GUB20+wBL22MQQNXsGWA3iB3ST8rzddQrCXGU2maf3EjW@vger.kernel.org
X-Gm-Message-State: AOJu0YwCg8vWsBP9bYeSR17MKcOMcV2sOHuATuXIbQwD6XgeYmt6l+3o
	HAr5s8vBKt5m+vOjHbUS5DZ4rF2SxmOogdLgLJoKsAj0hT4YQLNGkp+NbIq8J0mgFnCubx3nDj9
	6LwbXGwHujhrNPdpcKKMQw+/woivzlTagkhv9gQkL5ikjMkvuc1Zc8SshV1M=
X-Google-Smtp-Source: AGHT+IFlI1SjeIah8QgfxOkQEjEn2ZZ/BPy3jVI577kmaDWdgotXOaJaP6omqG9s88pi9hMgFMpQTrQuAwBkDLjwI843DpyIskJ6
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c23:b0:433:2fa2:a55d with SMTP id
 e9e14a558f8ab-43367de53edmr133878845ab.12.1762778304716; Mon, 10 Nov 2025
 04:38:24 -0800 (PST)
Date: Mon, 10 Nov 2025 04:38:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911dcc0.a70a0220.22f260.00ed.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: null-ptr-deref Read in drop_buffers (5)
From: syzbot <syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7bb4d6512545 Merge tag 'v6.18rc4-SMB-client-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17170412580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b944b1e5afd39857
dashboard link: https://syzkaller.appspot.com/bug?extid=e07658f51ca22ab65b4e
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f75c0b0bb6c3/disk-7bb4d651.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7a1ee597ee0/vmlinux-7bb4d651.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bd9a86dba20d/bzImage-7bb4d651.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: null-ptr-deref in buffer_busy fs/buffer.c:2886 [inline]
BUG: KASAN: null-ptr-deref in drop_buffers.constprop.0+0x89/0x340 fs/buffer.c:2898
Read of size 4 at addr 0000000000000060 by task kswapd0/85

CPU: 0 UID: 0 PID: 85 Comm: kswapd0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:194 [inline]
 kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:200
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 buffer_busy fs/buffer.c:2886 [inline]
 drop_buffers.constprop.0+0x89/0x340 fs/buffer.c:2898
 try_to_free_buffers+0x21c/0x2d0 fs/buffer.c:2952
 filemap_release_folio+0x219/0x280 mm/filemap.c:4423
 shrink_folio_list+0x28a5/0x4800 mm/vmscan.c:1519
 evict_folios+0x79c/0x1b30 mm/vmscan.c:4745
 try_to_shrink_lruvec+0x585/0x9b0 mm/vmscan.c:4908
 shrink_one+0x3e3/0x7a0 mm/vmscan.c:4953
 shrink_many mm/vmscan.c:5016 [inline]
 lru_gen_shrink_node mm/vmscan.c:5094 [inline]
 shrink_node+0x26cb/0x3d80 mm/vmscan.c:6081
 kswapd_shrink_node mm/vmscan.c:6941 [inline]
 balance_pgdat+0xbb8/0x1a50 mm/vmscan.c:7124
 kswapd+0x590/0xb90 mm/vmscan.c:7389
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
==================================================================
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 0 UID: 0 PID: 85 Comm: kswapd0 Tainted: G    B               syzkaller #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
RIP: 0010:buffer_busy fs/buffer.c:2886 [inline]
RIP: 0010:drop_buffers.constprop.0+0x90/0x340 fs/buffer.c:2898
Code: 4d 8b 76 08 4c 39 f3 0f 84 84 00 00 00 e8 f8 28 72 ff 4d 8d 66 60 be 04 00 00 00 4c 89 e7 e8 d7 cc d9 ff 4c 89 e0 48 c1 e8 03 <0f> b6 0c 28 4c 89 e0 83 e0 07 83 c0 03 38 c8 7c 08 84 c9 0f 85 2d
RSP: 0018:ffffc9000239f0b0 EFLAGS: 00010216
RAX: 000000000000000c RBX: ffff888057ccd3e0 RCX: ffffffff817b40ef
RDX: ffff88801ef18000 RSI: ffffffff82246d87 RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 3d3d3d3d3d3d3d3d R12: 0000000000000060
R13: ffffea0000a77880 R14: 0000000000000000 R15: ffffea0000a778a8
FS:  0000000000000000(0000) GS:ffff888124a07000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e34233c168 CR3: 0000000030ecb000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 try_to_free_buffers+0x21c/0x2d0 fs/buffer.c:2952
 filemap_release_folio+0x219/0x280 mm/filemap.c:4423
 shrink_folio_list+0x28a5/0x4800 mm/vmscan.c:1519
 evict_folios+0x79c/0x1b30 mm/vmscan.c:4745
 try_to_shrink_lruvec+0x585/0x9b0 mm/vmscan.c:4908
 shrink_one+0x3e3/0x7a0 mm/vmscan.c:4953
 shrink_many mm/vmscan.c:5016 [inline]
 lru_gen_shrink_node mm/vmscan.c:5094 [inline]
 shrink_node+0x26cb/0x3d80 mm/vmscan.c:6081
 kswapd_shrink_node mm/vmscan.c:6941 [inline]
 balance_pgdat+0xbb8/0x1a50 mm/vmscan.c:7124
 kswapd+0x590/0xb90 mm/vmscan.c:7389
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
RIP: 0010:buffer_busy fs/buffer.c:2886 [inline]
RIP: 0010:drop_buffers.constprop.0+0x90/0x340 fs/buffer.c:2898
Code: 4d 8b 76 08 4c 39 f3 0f 84 84 00 00 00 e8 f8 28 72 ff 4d 8d 66 60 be 04 00 00 00 4c 89 e7 e8 d7 cc d9 ff 4c 89 e0 48 c1 e8 03 <0f> b6 0c 28 4c 89 e0 83 e0 07 83 c0 03 38 c8 7c 08 84 c9 0f 85 2d
RSP: 0018:ffffc9000239f0b0 EFLAGS: 00010216
RAX: 000000000000000c RBX: ffff888057ccd3e0 RCX: ffffffff817b40ef
RDX: ffff88801ef18000 RSI: ffffffff82246d87 RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 3d3d3d3d3d3d3d3d R12: 0000000000000060
R13: ffffea0000a77880 R14: 0000000000000000 R15: ffffea0000a778a8
FS:  0000000000000000(0000) GS:ffff888124a07000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e34233c168 CR3: 0000000030ecb000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	4d 8b 76 08          	mov    0x8(%r14),%r14
   4:	4c 39 f3             	cmp    %r14,%rbx
   7:	0f 84 84 00 00 00    	je     0x91
   d:	e8 f8 28 72 ff       	call   0xff72290a
  12:	4d 8d 66 60          	lea    0x60(%r14),%r12
  16:	be 04 00 00 00       	mov    $0x4,%esi
  1b:	4c 89 e7             	mov    %r12,%rdi
  1e:	e8 d7 cc d9 ff       	call   0xffd9ccfa
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 0c 28          	movzbl (%rax,%rbp,1),%ecx <-- trapping instruction
  2e:	4c 89 e0             	mov    %r12,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 c8                	cmp    %cl,%al
  39:	7c 08                	jl     0x43
  3b:	84 c9                	test   %cl,%cl
  3d:	0f                   	.byte 0xf
  3e:	85                   	.byte 0x85
  3f:	2d                   	.byte 0x2d


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

