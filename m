Return-Path: <linux-fsdevel+bounces-17726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E128B1D64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DF028631F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 09:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93C384D3E;
	Thu, 25 Apr 2024 09:05:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037758289C
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035933; cv=none; b=DC2HeTLm43bVqS+OPFwqaPqtx36ILgFJ8rfkleeDZ2WUADoFvIhnAfguZZtz1CS1511KO48tLDfIvqz/MdqsrlJECGDm3vBDXRSm9QHECDgTmpzDUDU0dJeXaOcKbxm/4WQpdv4JcfZbP4pxRiQ61PjM9ZDPJkztHoGy6J6kKxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035933; c=relaxed/simple;
	bh=jKdDN83Sg3wKgLW0oaOTv64O6mlNERng15yOVqOGyHU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o0EJPCy9uKlIx2+Vtd4eimTtOVMHy+OT4AVeb8YYBb058hnLh51ATzCSXs3cHEQrXaGjM/B6C50bAj/m5oLeDn5XGHgE9YsA7ZgT2Vx97YS2Ghz+VDvJkx27fc+v0AoB92fiGBrPmoXrEEQYH58vXNq2un/uXoaCOP62hfJG+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a38d56655so9005215ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 02:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714035931; x=1714640731;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYYJEtGwjYtju3TSltRQOcQTw+yzoQFCs3kL+/L9Sxs=;
        b=vWkImsf3b2O3HuiHjWXl7GS/grvm+dbkqGGd0gdLBft23rw9bKhyvRCC9YNGoB8ylr
         UtrK8Bj7flRNW8SppjVJA7MxIPbHB5RcHQKjqmc3/74WHfxsS1CAzl1vBBHQPygeSUtY
         iCP+ZInk+P9vifs1J5T4idGwT00lS9oF6ciZ1s5qWKRXf26M3KoCx/ZMRci6F9tEVOY2
         ffhxpO4XFQXlzz5XujU/2y7ZbkpJODWVp8PKu32na4Zgj0+yy4x46+tfH8QYGtgSJfMe
         +Z7+OhWepaqn6Aa7iyeieSg1+colnHFg5ojBgEDHa4t1hJR6EZWrujYRlMaUamZc30wW
         L6lw==
X-Forwarded-Encrypted: i=1; AJvYcCWn0WmHCxmwFGoOiUEn+CwEs3/a7WA5rsARw5sgBeqBUV+uhRakUnwXNz1oD2MId2CLzKZG/cHg23Zyy0T7fQq5F3NmAh4cfGl02bTPew==
X-Gm-Message-State: AOJu0Yy2NaQ4BxmT1NHhUddKzahJ/CHQK3oewnHaNVwxtKXDyrIN4wNp
	XrBCksEBKqF0k7m8CPkLN9vOu22bhhYd8b8mo2ylwbC+K1zzUkN9U2ca4HnuzIbp60BIzkoE0Kc
	dCMOBEMWr10EjxcnAkp9kSTthl5vlchb/YnVMSYT2H6civw5xj7qu3k4=
X-Google-Smtp-Source: AGHT+IEAZxyA8Z966Oma0dPTuGW7/CL68U9I83mE1UlF1rHfyCrampmWNgaI0Z4cH7a5pNtwg/zN7y0yl/9GCJNYXlXW5hqprIHt
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1845:b0:36c:307b:7f08 with SMTP id
 b5-20020a056e02184500b0036c307b7f08mr24786ilv.0.1714035931214; Thu, 25 Apr
 2024 02:05:31 -0700 (PDT)
Date: Thu, 25 Apr 2024 02:05:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d006b20616e8168d@google.com>
Subject: [syzbot] [udf?] kernel BUG in submit_bh_wbc (2)
From: syzbot <syzbot+5f682cd029581f9edfd1@syzkaller.appspotmail.com>
To: VEfanov@ispras.ru, jack@suse.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, vefanov@ispras.ru
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e88c4cfcb7b8 Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10288be8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=5f682cd029581f9edfd1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e4cd6b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f27380980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/124765f3f2cd/disk-e88c4cfc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e2773bfa348/vmlinux-e88c4cfc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66c56fe803c8/bzImage-e88c4cfc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a47950266a82/mount_0.gz

The issue was bisected to:

commit 1e0d4adf17e7ef03281d7b16555e7c1508c8ed2d
Author: Vladislav Efanov <VEfanov@ispras.ru>
Date:   Thu Feb 2 14:04:56 2023 +0000

    udf: Check consistency of Space Bitmap Descriptor

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155c96a0980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=175c96a0980000
console output: https://syzkaller.appspot.com/x/log.txt?x=135c96a0980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f682cd029581f9edfd1@syzkaller.appspotmail.com
Fixes: 1e0d4adf17e7 ("udf: Check consistency of Space Bitmap Descriptor")

UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
------------[ cut here ]------------
kernel BUG at fs/buffer.c:2768!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5075 Comm: syz-executor330 Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:submit_bh_wbc+0x546/0x560 fs/buffer.c:2768
Code: 04 7c ff be 00 10 00 00 48 c7 c7 80 ad 47 8e 4c 89 fa e8 1d 33 c6 02 e9 95 fe ff ff e8 93 04 7c ff 90 0f 0b e8 8b 04 7c ff 90 <0f> 0b e8 83 04 7c ff 90 0f 0b e8 7b 04 7c ff 90 0f 0b e8 73 04 7c
RSP: 0018:ffffc9000340f858 EFLAGS: 00010293
RAX: ffffffff8219fbe5 RBX: 0000000000000000 RCX: ffff88802f7b9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8219f743 R09: 1ffff1100ee296cb
R10: dffffc0000000000 R11: ffffed100ee296cc R12: 0000000000000000
R13: ffff88807714b658 R14: 0000000000000000 R15: 1ffff1100ee296cb
FS:  00005555792e0380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 0000000075a64000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 submit_bh fs/buffer.c:2809 [inline]
 __bh_read fs/buffer.c:3074 [inline]
 bh_read_nowait include/linux/buffer_head.h:417 [inline]
 __block_write_begin_int+0x12d0/0x1a70 fs/buffer.c:2134
 __block_write_begin fs/buffer.c:2154 [inline]
 block_write_begin+0x9b/0x1e0 fs/buffer.c:2213
 udf_write_begin+0x10d/0x1a0 fs/udf/inode.c:261
 generic_perform_write+0x322/0x640 mm/filemap.c:3974
 udf_file_write_iter+0x2fd/0x660 fs/udf/file.c:111
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa84/0xcb0 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7c2bb82679
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff23ee0518 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fff23ee06e8 RCX: 00007f7c2bb82679
RDX: 0000000000000010 RSI: 0000000020000600 RDI: 0000000000000004
RBP: 00007f7c2bbf5610 R08: 00007fff23ee06e8 R09: 00007fff23ee06e8
R10: 00007fff23ee06e8 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff23ee06d8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:submit_bh_wbc+0x546/0x560 fs/buffer.c:2768
Code: 04 7c ff be 00 10 00 00 48 c7 c7 80 ad 47 8e 4c 89 fa e8 1d 33 c6 02 e9 95 fe ff ff e8 93 04 7c ff 90 0f 0b e8 8b 04 7c ff 90 <0f> 0b e8 83 04 7c ff 90 0f 0b e8 7b 04 7c ff 90 0f 0b e8 73 04 7c
RSP: 0018:ffffc9000340f858 EFLAGS: 00010293
RAX: ffffffff8219fbe5 RBX: 0000000000000000 RCX: ffff88802f7b9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8219f743 R09: 1ffff1100ee296cb
R10: dffffc0000000000 R11: ffffed100ee296cc R12: 0000000000000000
R13: ffff88807714b658 R14: 0000000000000000 R15: 1ffff1100ee296cb
FS:  00005555792e0380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 0000000075a64000 CR4: 00000000003506f0
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

