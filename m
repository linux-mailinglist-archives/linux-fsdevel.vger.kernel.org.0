Return-Path: <linux-fsdevel+bounces-35029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C95A9D017A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 00:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562A3281E66
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 23:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F261AA7AF;
	Sat, 16 Nov 2024 23:40:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED15838DE1
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731800431; cv=none; b=T/ffZ6wwrNZR04Iu4NVZy+p1rhTsaTIhhBydXA8TwdnTCLGZmOuL6HbC6RE1eVdr89O6Llz39AMEuqlT0ytRtLlZbRpyzaqT5iRHNgORA411a44bvAxDN3hhZLosvauyKIuNqlTAEg01Z7blyJU0mHrh8tuJrgoehV0N299CTPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731800431; c=relaxed/simple;
	bh=0ox60d0tY9xN9C+7OwmiAYuJ18xlV8NQVygfCBYJ5oI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R0yiGxWqAImVi0fJQXCNPQ0RDJpEaA9+ZyACh5wLujpWujLz8f8/lLKR+iX8yf7KN36o5YoIpwA/s5byTSsDuPSjJT6H3JHSxjr1/2Yvi5v5NxURpPcKs6eBkaj3+kDCj6HwqUoC4w5TNWFlmDTpZjheHaZkJcmuPVdIOfCxUUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so7472465ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 15:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731800429; x=1732405229;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H/O2GpCEAvsHvmB5TwXYPuJj++JFWLv4bXVKE8bL8gQ=;
        b=LuKMkEjOwhoBXi5YkqVl/aDmihv/Xt3n/3LfqcywC/VvT1X5sQXv/bWXn27Ytjpj9m
         eVFQ76+3TjYtJ0BicYaj1yjq9MmPwcs+KtU1vw9kILJJNZTi62I3UMD1FgroNQkM+Xeu
         be/v1eZnzECaSnEHO3uF0eyggMZeb47l/iiHRA9IR22jAP67NWIy1paAmHg1zw5KwHiC
         jfVJEEzYloZ7P7ynv6TENEZK0UPptwR2aV0fo0Zc2lFKTbGTae7f8wusY55hkXhOc3yB
         I6t744MCpAiqEy77Y2z5/QUo2LRGzdD6x/6QgRFLB9oyeuAhFLJapjFelBT2mS9uqgKW
         aPqQ==
X-Gm-Message-State: AOJu0YxMYC+fVWaALr0B/ngxmOAjzYngEGdhG9+XuiX2mt1YZaoMtLdi
	Fgi3BRwUGV8X7XsMpO7BanwFo7ZOPMaBzs06D1EG9HpPxaJZji6BSOrWOw7qyK/mOtlsHMT/JVO
	G3E4DdHtjCFa9VoZx5rJHrkz7Vrted87XKtAerd32IwPC74JQK4ic59w=
X-Google-Smtp-Source: AGHT+IGqhH1oUAVO2vqm+OC3dAw54MV8T875v0LgzsjFxJO3o2Zu7R5t7S7DD8Ku9IDW2FFNP8xtREJWuz2DI7b1JDkykMJcVbUK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b21:b0:3a5:e1f5:1572 with SMTP id
 e9e14a558f8ab-3a7480d4ademr53874245ab.22.1731800429129; Sat, 16 Nov 2024
 15:40:29 -0800 (PST)
Date: Sat, 16 Nov 2024 15:40:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67392d6d.050a0220.e1c64.000a.GAE@google.com>
Subject: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer dereference
 in filemap_read_folio (4)
From: syzbot <syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3022e9d00ebe Merge tag 'sched_ext-for-6.12-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119f8ce8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=327b6119dd928cbc
dashboard link: https://syzkaller.appspot.com/bug?extid=09b7d050e4806540153d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1656a4c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159f8ce8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-3022e9d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6539389f3983/vmlinux-3022e9d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9ee2dbf68ed6/bzImage-3022e9d0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 32263067 P4D 32263067 PUD 32264067 PMD 0 
Oops: Oops: 0010 [#1] PREEMPT SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 5935 Comm: syz-executor262 Not tainted 6.12.0-rc7-syzkaller-00012-g3022e9d00ebe #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc900036a79c8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81c26c1f
RDX: ffff8880289da440 RSI: ffffea0000e995c0 RDI: ffff888029a421c0
RBP: ffffea0000e995c0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff961d8908 R12: 1ffff920006d4f3a
R13: ffff888029a421c0 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055557e035380(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000031818000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 filemap_read_folio+0xc6/0x2a0 mm/filemap.c:2367
 do_read_cache_folio+0x263/0x5c0 mm/filemap.c:3825
 freader_get_folio+0x337/0x8e0 lib/buildid.c:77
 freader_fetch+0xc2/0x5f0 lib/buildid.c:120
 __build_id_parse.isra.0+0xed/0x7a0 lib/buildid.c:305
 do_procmap_query+0xd62/0x1030 fs/proc/task_mmu.c:534
 procfs_procmap_ioctl+0x7d/0xb0 fs/proc/task_mmu.c:613
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f4c4436e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffde11efd68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffde11efd70 RCX: 00007f5f4c4436e9
RDX: 0000000020000180 RSI: 00000000c0686611 RDI: 0000000000000004
RBP: 00007f5f4c4b6610 R08: 0000000000000000 R09: 65732f636f72702f
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffde11effa8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc900036a79c8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81c26c1f
RDX: ffff8880289da440 RSI: ffffea0000e995c0 RDI: ffff888029a421c0
RBP: ffffea0000e995c0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff961d8908 R12: 1ffff920006d4f3a
R13: ffff888029a421c0 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055557e035380(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000031818000 CR4: 0000000000352ef0
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

