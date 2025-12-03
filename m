Return-Path: <linux-fsdevel+bounces-70538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC307C9DC96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 06:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64E4434A3B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 05:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E353280018;
	Wed,  3 Dec 2025 05:15:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887DA1A285
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 05:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764738937; cv=none; b=LEpNN8+1jVQs5LAgwUx9pyZaNd5qYPIm54KT0k2pKN5bO9LBQ4IXz+nFy8Dpl8PRPcUj27T/S+N17AYucNBBxG1nFpsEPv+oqSxNZaAPEr03gfP7dGX0jfVwculInsalBiY4lzKcNx21gumIVDOB6qfzJCECCixrRnck343VAOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764738937; c=relaxed/simple;
	bh=6K3F95mJ0x2faVA5G7lr1g2dePIfm3MejtMm+4lsdUs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UcVo7PFKWCVYYA6ai2yloCkXij9G69apR9xDwvjPEp5+pCwKKy37CZN62bcutTngaH+CBKTqzwBIA12WY6q4T4N3JDK6qymZDvO1sk2DgR/1QIKachOnDI7Fc5sat2dMiTHTWSl+lCxvX45o/94K5eA8FvDq8aRqbLfX3EN3nAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-44ffa9f293bso5899505b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 21:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764738934; x=1765343734;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jpaUZOOq7cavjUJv5Xb6gMlLaSFoTX0r4WXny4bi0Q=;
        b=cfMFvV4KO16N7BopeNGI7PF5wbhfJNJV8uv+Q1hkNhIafZORg/I/ywq4xWhFZSH4nZ
         geMyNXCPa2uesduuxmfWRXN6WL9DSXVf/bprLJn2lpxcdMlAyuzHsBxFSTvfXJ4eP/di
         /DA5Dgcacrs+tYpPQLF76Fi8sHauig2Ijnkp19UuNYsX/BSK35pPakIRU1KE6Pbcin6x
         pMw582DHSo+KJ3/dYR8Dzex6zO7ffdf1aVpJeIfb8J1l5/aIKoJREJiU4dm291Fge1Nh
         n+TUSQ1eauK4X6FNyig7RdCwu9uBl8a6176a8D1A4hjXKyZsXDiRc/FqqAa4UNnHMyd3
         8Tlg==
X-Forwarded-Encrypted: i=1; AJvYcCXTXQYkPkJa4+2hACojyFP62muzugojuK+rj7puLR+4zXP35/LfOZcZvRa3k2N4bkjREKnFFc5ExnJ4pOw0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32UFIFWPDh9UIptZfjablSuRNWs8Cp7PniIkMDSnqL9rdmshq
	YG64Fml2Y4Dgjmaq19VUXA4lbvfbgIwjp1LUQr3CSympMMTF5FPau/kF9u9L9u08SYUEXO/lJaw
	/PDyx/7Q7RufZFlyNfP33pQev53YMMURkcBi/THETvRsL5QTMNfzz5gIo6sE=
X-Google-Smtp-Source: AGHT+IF8D/UvaWUn6H7GvPv1bXNJ1X3AibKG8Cy+1t4joLdEtbwXVCmVaZitPZkA0w7Bkl1Vt91KoswX9J9S+1NDGFzdz0xDqe2F
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:191a:b0:450:1f44:da5c with SMTP id
 5614622812f47-4536e56ea7amr479647b6e.45.1764738934684; Tue, 02 Dec 2025
 21:15:34 -0800 (PST)
Date: Tue, 02 Dec 2025 21:15:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692fc776.a70a0220.2ea503.00cb.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] WARNING in sched_mm_cid_fork
From: syzbot <syzbot+9ca2c6e6b098bf5ae60a@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7d31f578f323 Add linux-next specific files for 20251128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=165b14b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6336d8e94a7c517d
dashboard link: https://syzkaller.appspot.com/bug?extid=9ca2c6e6b098bf5ae60a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104a30c2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b49d8ad90de/disk-7d31f578.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dbe2d4988ca7/vmlinux-7d31f578.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc0448ab2411/bzImage-7d31f578.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ca2c6e6b098bf5ae60a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: kernel/sched/core.c:10573 at sched_mm_cid_fork+0x66/0xc30 kernel/sched/core.c:10573, CPU#0: kworker/u8:4/6077
Modules linked in:
CPU: 0 UID: 0 PID: 6077 Comm: kworker/u8:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:sched_mm_cid_fork+0x66/0xc30 kernel/sched/core.c:10573
Code: 4c 8b 3b 4d 85 ff 74 21 49 8d 9d d4 15 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 30 84 c0 0f 85 13 0a 00 00 31 c0 3b 03 70 04 90 <0f> 0b 90 49 8d 9f 00 01 00 00 49 8d bf c0 01 00 00 48 89 7c 24 20
RSP: 0018:ffffc90003167bd8 EFLAGS: 00010246
RAX: 1ffff1100584e853 RBX: ffff88802c274298 RCX: ffff88802c273d00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88802c273d00
RBP: ffffc90003167d68 R08: ffffffff8e093e83 R09: 1ffffffff1c127d0
R10: dffffc0000000000 R11: fffffbfff1c127d1 R12: ffff88802c273d00
R13: ffff88802c273d00 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125e4f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc18973e9c CR3: 000000003470a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 bprm_execve+0xd88/0x1400 fs/exec.c:1776
 kernel_execve+0x8f0/0x9f0 fs/exec.c:1919
 call_usermodehelper_exec_async+0x210/0x360 kernel/umh.c:109
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
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

