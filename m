Return-Path: <linux-fsdevel+bounces-40554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 366D7A2505A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 23:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38091883A7E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 22:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542032147F7;
	Sun,  2 Feb 2025 22:30:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DDF1D5161
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Feb 2025 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738535427; cv=none; b=Lawt15uBFUWsJb3u9MU8iRxXmuZVonUe/UX+1IZtsUaAngpYI31YQZ70RdEXbkMULikkSc+kKORrC/DFbxWYRxWq/JLlB2j8Rb3rWlFVlQreG+c/FEHgdJR2m9i28z5xAjW/pGsZmR0uFqu7+Y9dhqJpFxQ9y8aJ48sH5X8452s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738535427; c=relaxed/simple;
	bh=DVRlqbU2IQX73qyTyNH6LqlKqr3dbhV9iEuo4zXR4IU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O3YXSkqinl2vqwxPDCK+CrvwGWj+svEAr29fQ9Zd6CvZCeaKER2r/OV+gT6caNCZt4J5igAdeggkrQiK2C/ponKwQWd7w16WOizl3NQrrehgLPECaPD7vd4jKNrFK1xF5isw0gSBjPt1416GbjydGwCdbDkf2HK/NQADjYUKAAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3cffe6b867fso54145225ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Feb 2025 14:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738535424; x=1739140224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHMYTq/8IL/q0F4irK3c2pP2MZ87J7Ws8aDpEAJmlBE=;
        b=JFX9bSMhNZD/Hen8Gv8UgxKplnr53mXES8qxekgEXRgswxb49NscPPm165mG0LL6al
         UIUo8MwyDJeBKNQPAvsBa7o99Ef2CbTrO41fyezBVygZM4NIxTzttRYtk92Bbo7yUXSo
         CTOoylMN24sylrarlulz6FR3WD94O+e3DgHU+AhX23wSuWzJ261OqU1iPN6UZ2FPmg/0
         te+KpacGLUvlp/pzqh3Qzu6aAIrkdccdRUe3Uca5OwSg28ZCpIV76dFDALc+WxPLW7xs
         jmzcsB+henacahXHdb4HeXpWR92ifyL4YpZN6MZdNfkEriOHBQmeg5fnzIU2OmT+n9jH
         vNJg==
X-Forwarded-Encrypted: i=1; AJvYcCVybw6e3nh5c6/SOvIqJiokeXUg3me7pSHbJrTw26GVb9CpIXkrRN2G9ljjAcNgFI2l2czOseOcpzP16Mga@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FMjF2TjPrQGha7+1tWXIhUlnFRU2SsYlZr78el1x7LZeKunY
	iNOqwidLngo7Oi8f0iqr+8BMOTtiWy3rfK6IdmQq1g7R7YtyR4RuutL24nPsAcV6hsXzjQqNL0v
	mUYYZ8t2J4IOzyvSKSCUr4v3/ULN8vpRRoAppMIWKrfvd3+2GaCQdKmE=
X-Google-Smtp-Source: AGHT+IHy2AyX18AFGjyFnYftiSXnE7XygoUX/X7N2jK5MxPxFwZgGcCytFkaEObRiZT4fjz3QtQpf7VK/pJ/diMUfdlCHSD+WKfI
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:98:b0:3cf:b2b0:5d35 with SMTP id
 e9e14a558f8ab-3cffe3e5d8emr183226615ab.7.1738535424521; Sun, 02 Feb 2025
 14:30:24 -0800 (PST)
Date: Sun, 02 Feb 2025 14:30:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679ff200.050a0220.163cdc.0032.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_btree_node_iter_init
From: syzbot <syzbot+7b8a2c442d5a4859b680@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1148c518580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d033b14aeef39158
dashboard link: https://syzkaller.appspot.com/bug?extid=7b8a2c442d5a4859b680
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150715f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102e8b24580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-69e858e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a53b888c1f3f/vmlinux-69e858e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6b5e17edafc0/bzImage-69e858e0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6d9bc71b6ead/mount_5.gz

The issue was bisected to:

commit 14152654805256d760315ec24e414363bfa19a06
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Nov 25 05:21:27 2024 +0000

    bcachefs: Bad btree roots are now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16492d18580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15492d18580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11492d18580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7b8a2c442d5a4859b680@syzkaller.appspotmail.com
Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")

bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
bcachefs (loop0): check_allocations...
------------[ cut here ]------------
kernel BUG at fs/bcachefs/bset.c:1308!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5524 Comm: syz-executor285 Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bch2_btree_node_iter_init+0x4272/0x4280 fs/bcachefs/bset.c:1308
Code: fd 90 0f 0b e8 bf 9e 84 fd 90 0f 0b e8 b7 9e 84 fd 90 0f 0b e8 af 9e 84 fd 90 0f 0b e8 a7 9e 84 fd 90 0f 0b e8 9f 9e 84 fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90
RSP: 0000:ffffc9000d7b5de0 EFLAGS: 00010293
RAX: ffffffff843ace21 RBX: 0000000000000001 RCX: ffff88803ebb8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000d7b6050 R08: ffffffff843a8fc6 R09: 0000000000000000
R10: ffffc9000d7b5f70 R11: fffff52001af6bf1 R12: ffff888056900040
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007f13e240b6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f13dadff000 CR3: 00000000441be000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __btree_path_level_init fs/bcachefs/btree_iter.c:617 [inline]
 bch2_btree_path_level_init+0x4d2/0x9f0 fs/bcachefs/btree_iter.c:637
 btree_path_lock_root fs/bcachefs/btree_iter.c:787 [inline]
 bch2_btree_path_traverse_one+0x108b/0x2930 fs/bcachefs/btree_iter.c:1203
 bch2_btree_path_traverse fs/bcachefs/btree_iter.h:249 [inline]
 __bch2_btree_iter_peek fs/bcachefs/btree_iter.c:2270 [inline]
 bch2_btree_iter_peek_max+0xc06/0x6320 fs/bcachefs/btree_iter.c:2367
 bch2_btree_iter_peek_max_type fs/bcachefs/btree_iter.h:681 [inline]
 bch2_gc_reflink_start+0x461/0xa50 fs/bcachefs/reflink.c:828
 bch2_check_allocations+0x680/0x6aa0 fs/bcachefs/btree_gc.c:1027
 bch2_run_recovery_pass+0xf0/0x1e0 fs/bcachefs/recovery_passes.c:226
 bch2_run_recovery_passes+0x2ad/0xa90 fs/bcachefs/recovery_passes.c:291
 bch2_fs_recovery+0x265a/0x3de0 fs/bcachefs/recovery.c:937
 bch2_fs_start+0x37c/0x610 fs/bcachefs/super.c:1030
 bch2_fs_get_tree+0xd8d/0x1740 fs/bcachefs/fs.c:2203
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f13e2460cba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 4e 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f13e240afa8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f13e240afc0 RCX: 00007f13e2460cba
RDX: 0000000020000000 RSI: 0000000020000040 RDI: 00007f13e240afc0
RBP: 0000000000000006 R08: 00007f13e240b000 R09: 0000000000005939
R10: 0000000000000000 R11: 0000000000000282 R12: 00007f13e240b000
R13: 0000000000000000 R14: 0000000000000004 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_btree_node_iter_init+0x4272/0x4280 fs/bcachefs/bset.c:1308
Code: fd 90 0f 0b e8 bf 9e 84 fd 90 0f 0b e8 b7 9e 84 fd 90 0f 0b e8 af 9e 84 fd 90 0f 0b e8 a7 9e 84 fd 90 0f 0b e8 9f 9e 84 fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90
RSP: 0000:ffffc9000d7b5de0 EFLAGS: 00010293
RAX: ffffffff843ace21 RBX: 0000000000000001 RCX: ffff88803ebb8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000d7b6050 R08: ffffffff843a8fc6 R09: 0000000000000000
R10: ffffc9000d7b5f70 R11: fffff52001af6bf1 R12: ffff888056900040
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007f13e240b6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f13dadff000 CR3: 00000000441be000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

