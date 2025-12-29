Return-Path: <linux-fsdevel+bounces-72162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF745CE6756
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 12:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB916300F313
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 11:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703782F99A8;
	Mon, 29 Dec 2025 11:09:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789222E717B
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767006563; cv=none; b=VLUCK8qb764QodMM3TXkRK0jKBLd23hGFdWexB2y7zAWs2LA3OTQ2KuQP/L/M46bsQ60mKV4MiNy+J3uqo5ioBfY2cZ1MKcgPrVpUMRGXEMWEO4vNdDbmYSqReDeqj5xSCBsSmaY91w5I+y3rJJi1QJ6jjnp3GGITb68TPJv2Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767006563; c=relaxed/simple;
	bh=zF7dMigOpvwftBQqWlTRuaCScZVOhHyo89ZvzcMAirg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DDBM8sSBntUizvuMR4vUxeaR61szg85xWBKWIPpYIySKSresSvpLgBUHNMw2xj6nIm4t7iwsIvDM7jvk9VBNk/VIEmoYZw3SHpH6MqlYuSKt5RKc7DtofSm+XM7ptdSGCvVSM+2VoRZYGrKMcWogUZM36gUbapxEe+qN7IsyqVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7cad3d056c1so17193508a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 03:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767006560; x=1767611360;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8h7ot2e/pevgjJhpsXlySYFFAyGSeroK84z95KyTt1E=;
        b=M0PQAgDNXyTpkiPiMymHTKyGVsYSgQ03yNR+iKkwaU4Zcppv+SqIPV43fkU7eljW+r
         IBuDvcsmqTgkcjM+sKcRGk05bEp4O5ptx3IdSNYJQq0ogkpYYBwlqjT6ZbwJtoNVipui
         6LMR1gq3SmU1kNtd6TbqgFaiycvT4MaA3lGL+dbpiKO1ydzpXeeFv3AXWe9K5vRIroL4
         UsLJl8djWl3EOvdMU+J25Iv2B7Dh87qg/JHgZGQsaHZdFb6fvhDj8NuYUw/+zzb1T+Dz
         LW/7ba2JpEmM7iCbE1KWjurZSXdVl12Pl0vxY2rn/JcmT1hlvmmHJ/+OxmImAA6ODYlc
         S9IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG6rKHb8UD/f7D6cSeDVCZzQFPgFfW81cI3OIahUuOU7NsP3SwwJl6mqpToNT2NBExEJw0BqJRgv3LwU1p@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6v23011hSXTwnNkQKU/pc9l1K87EzjSPGlF3g1+wnjJZNq50
	Uv+JQ2bh2BE0DcIj/7JWFGW++PcJNQR7fWwzcanTC+XCOkR/6LC2RlZ+yPpxcXqLxfBU5VpMRh+
	tcjFi+peZ42rYcaNzAxAj0u/Q1WtCbV/wTRi3RPjfd2Jwd6zOfLyydNfI0KA=
X-Google-Smtp-Source: AGHT+IGN+y2PmobodtjcjD0/btZkR+NBWBQkwG1hAMAlafJLjlGYEuuGit4WkQVMj7gZonCMfO2sSBj+WcEzWoLO4k2oz5p8sU5O
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4088:b0:659:9a49:8e26 with SMTP id
 006d021491bc7-65cfe748a32mr14373545eaf.24.1767006560351; Mon, 29 Dec 2025
 03:09:20 -0800 (PST)
Date: Mon, 29 Dec 2025 03:09:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69526160.050a0220.3b1790.0005.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in put_mnt_ns
From: syzbot <syzbot+d3005b4273499e174172@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2666975a8905 Add linux-next specific files for 20251111
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16d38914580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e82ba9dc816af74c
dashboard link: https://syzkaller.appspot.com/bug?extid=d3005b4273499e174172
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/26ac789d9bdd/disk-2666975a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fabfe7978a23/vmlinux-2666975a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/82f010d50b37/bzImage-2666975a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d3005b4273499e174172@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: ./include/linux/ns_common.h:255 at __ns_ref_put include/linux/ns_common.h:255 [inline], CPU#0: syz.1.878/9177
WARNING: ./include/linux/ns_common.h:255 at put_mnt_ns+0x152/0x190 fs/namespace.c:6048, CPU#0: syz.1.878/9177
Modules linked in:
CPU: 0 UID: 0 PID: 9177 Comm: syz.1.878 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__ns_ref_put include/linux/ns_common.h:255 [inline]
RIP: 0010:put_mnt_ns+0x152/0x190 fs/namespace.c:6048
Code: 79 00 00 bf 01 00 00 00 89 ee e8 99 15 7e ff 85 ed 7e 1f e8 50 11 7e ff 5b 41 5e 41 5f 5d c3 cc cc cc cc cc e8 3f 11 7e ff 90 <0f> 0b 90 e9 33 ff ff ff e8 31 11 7e ff 4c 89 f7 be 03 00 00 00 5b
RSP: 0018:ffffc900038bfaa8 EFLAGS: 00010293
RAX: ffffffff82434e41 RBX: ffff88807a516000 RCX: ffff88807ce9bd00
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: 00000000ffffffff R08: ffff88807a5160bb R09: 1ffff1100f4a2c17
R10: dffffc0000000000 R11: ffffed100f4a2c18 R12: dffffc0000000000
R13: 0000000000000009 R14: ffff88807a5160b8 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125a82000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc52318fb8 CR3: 0000000030cb8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 free_nsproxy+0x46/0x560 kernel/nsproxy.c:192
 do_exit+0x6b8/0x2300 kernel/exit.c:969
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1111
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x7a0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:75 [inline]
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 irqentry_exit_to_user_mode_prepare include/linux/irq-entry-common.h:270 [inline]
 irqentry_exit_to_user_mode include/linux/irq-entry-common.h:339 [inline]
 irqentry_exit+0x171/0x640 kernel/entry/common.c:196
 exc_page_fault+0xab/0x100 arch/x86/mm/fault.c:1535
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x7ff8b0654d64
Code: Unable to access opcode bytes at 0x7ff8b0654d3a.
RSP: 002b:00007ff8b15f2ff0 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007ff8b09e6090 RCX: 00007ff8b078f6c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ff8b0811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff8b09e6128 R14: 00007ff8b09e6090 R15: 00007ffc5231c618
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

