Return-Path: <linux-fsdevel+bounces-18680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E5B8BB59C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 23:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC60F1C22AB4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 21:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A2658AA7;
	Fri,  3 May 2024 21:23:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726BF56B76
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771408; cv=none; b=MtkOCFtNmUqdccqsFlIuxtzx/YUklQTPsavu7QkHZRm8GFOAlRyDHHPXPGpKHMrHwPd+6W1tDnqIM2C5j3U1LK0T2RXvr2F7HkXCI9QN5E6BDrtccPi0K4uF/35zlXXAUKIOiQjlczv9pTbf6WAFz+bvlC6Fg0nDeyFwISaW1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771408; c=relaxed/simple;
	bh=0I9HYehUPiTbvcoZm+bi9oIqOfptahzemmvOSF8E9kQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E1P04l1D6qo5ZBwyblDH2gnGcq/FcLq6/oMlbXRR/powG2BJueTjOblRMsYU5ImtSoGpm7OyFlQRyfdpLkMTtWe6sbz76aParCS/sPJ/2qqo4kB8TS1MMQ389ZikeI9GS7Z6zW9H2orGgQpQtK8uDmX38MDH9KWGRh55ZBiYmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da42f683f7so9193539f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 14:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771405; x=1715376205;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x4GbqEKgZuUa1KrnN/Su4ZMPhtfNcJzTLzCPfurOMJw=;
        b=oatwDi0xrF80lkTEieraKInEqah/drMo+mt5sliRfHwdcIJAjor5hIKrQKwDbMMUfJ
         T3E/IuU4HryFC+nrlGFILlYsE5u0bBZ0s75TKWPJqwqvk2RFkGPAkYnxAfC2z2Jracj9
         U1Eg2rTqWrrhLH0V4TmvsCw62Sl2zlv4udUg8/4K+8ue+IQtY91aU6ALG0GfYnm6ZIDq
         +AVG55hrppJCN2O+AerQv39y8I4+LmQGOJu7V10bXX2TZdjrswOKp5bV7zV6/tuLlVwr
         /MgTo0z8nBIwsaKiiT5zHPO9T9xeu1D/KmG8OpET9V6rZ0IwLWftuWlmuqM3Q1Qe18F1
         45Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVSi0LvWltaX2E1kc/OvDfzRxErFNNVWMKfGWVIZyYjDkPDHY52JfmYv3fwg1BYZHlHSTMx+sBGJMv4azuqIKy7+T36Az0SMaWtyBePSQ==
X-Gm-Message-State: AOJu0Yyj9RDy9Etzw+9y/1k7BiFYDosrGwGUw/3qBitbAq45hR/nSC01
	pQfIReE6eT6osnXsgxTKf4DKdfW5sNsD/PA9uoAu+48rf3lqddvHQWDv6QY/KO7BqD5IOLyIPNc
	CpYW5pJdkmpjzyjycItuzmS3FDXzuGbDUVXNhsJXik0rJDf9G/dQVF64=
X-Google-Smtp-Source: AGHT+IESXSSXDGivXRyeDdWZ+LhL6+oKegoJ1a3vEN9LKW76nx/PAeBHz1CdWCfX0td7zXksEE0ZqjkBPLGM3WYb+8lhIzF59bPP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6d12:b0:487:31da:eaf1 with SMTP id
 he18-20020a0566386d1200b0048731daeaf1mr82103jab.1.1714771405656; Fri, 03 May
 2024 14:23:25 -0700 (PDT)
Date: Fri, 03 May 2024 14:23:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008160ad06179354a2@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_fs_recovery
From: syzbot <syzbot+05c1843ef85da9e52042@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d25a941ea50 Merge tag 'block-6.9-20240503' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114b39ff180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=05c1843ef85da9e52042
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13aed9df180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ac7a28980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-3d25a941.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d8ed74e49f1/vmlinux-3d25a941.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d724e9151b52/bzImage-3d25a941.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/998b7ff57836/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+05c1843ef85da9e52042@syzkaller.appspotmail.com

  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq afc6cc17f332ffe0 written 24 min_key POS_MIN durability: 0 (invalid extent entry 0000000000020040)
  invalid extent entry type (got 6, max 6), shutting down
bcachefs (loop0): inconsistency detected - emergency read only at journal seq 0
------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:23!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 2 PID: 5178 Comm: syz-executor317 Not tainted 6.9.0-rc6-syzkaller-00227-g3d25a941ea50 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__phys_addr+0x120/0x150 arch/x86/mm/physaddr.c:23
Code: 10 00 75 39 48 8b 1d 4f c8 1b 0c 48 89 ee bf ff ff ff 1f e8 72 49 4f 00 48 01 eb 48 81 fd ff ff ff 1f 76 a7 e8 51 4e 4f 00 90 <0f> 0b 48 c7 c7 bd 39 9f 8f e8 b2 99 aa 00 e9 52 ff ff ff 48 c7 c7
RSP: 0018:ffffc900032ef4a0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000007ffff75e RCX: ffffffff813e77ce
RDX: ffff888011aca440 RSI: ffffffff813e77df RDI: 0000000000000007
RBP: 000000007ffff75e R08: 0000000000000007 R09: 000000001fffffff
R10: 000000007ffff75e R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: 00000000663551f8 R15: ffffed1005ea010e
FS:  000055557a454380(0000) GS:ffff88806b400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff7a9096410 CR3: 00000000203ec000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 virt_to_folio include/linux/mm.h:1306 [inline]
 kfree+0x6c/0x390 mm/slub.c:4382
 bch2_fs_recovery+0xfe9/0x3c40 fs/bcachefs/recovery.c:905
 bch2_fs_start+0x2e9/0x600 fs/bcachefs/super.c:1043
 bch2_fs_open+0xf87/0x1110 fs/bcachefs/super.c:2102
 bch2_mount+0xdcc/0x1130 fs/bcachefs/fs.c:1903
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1779
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1ad400a8fa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd674e3108 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd674e3120 RCX: 00007f1ad400a8fa
RDX: 0000000020011a00 RSI: 0000000020000080 RDI: 00007ffd674e3120
RBP: 0000000000000004 R08: 00007ffd674e3160 R09: 00000000000119fd
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000000
R13: 00007ffd674e3160 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0x120/0x150 arch/x86/mm/physaddr.c:23
Code: 10 00 75 39 48 8b 1d 4f c8 1b 0c 48 89 ee bf ff ff ff 1f e8 72 49 4f 00 48 01 eb 48 81 fd ff ff ff 1f 76 a7 e8 51 4e 4f 00 90 <0f> 0b 48 c7 c7 bd 39 9f 8f e8 b2 99 aa 00 e9 52 ff ff ff 48 c7 c7
RSP: 0018:ffffc900032ef4a0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000007ffff75e RCX: ffffffff813e77ce
RDX: ffff888011aca440 RSI: ffffffff813e77df RDI: 0000000000000007
RBP: 000000007ffff75e R08: 0000000000000007 R09: 000000001fffffff
R10: 000000007ffff75e R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: 00000000663551f8 R15: ffffed1005ea010e
FS:  000055557a454380(0000) GS:ffff88806b400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff7a9096410 CR3: 00000000203ec000 CR4: 0000000000350ef0
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

