Return-Path: <linux-fsdevel+bounces-53757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D32AF67E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 04:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53344E4B31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 02:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4501D5173;
	Thu,  3 Jul 2025 02:18:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F1186353
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 02:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751509118; cv=none; b=Rg4V7eCqTbzUpwOOi1J24X13F93yeHdj+bPy3DDJ94swjClE/0uISEyP+07Bd32p3mTft4BSxcKeUWyOqH5d2jMAahxWOuyk/OlT6HLNiTpSCDjGsczQ2QdIVQrNJsT3GqE+j1gz8D9wAg4AyL/G8lzJ8Nom2n7vU15jFeG65YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751509118; c=relaxed/simple;
	bh=w6v4b1Sv8vHkmy0AJXwcpTK0Qw8A26XW180RA3XgmwQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N+sUy7N2MikcNl4Rxa2WCVXv2XYpY80qs3FwIzSga4HrN/1V6JTeya5Ka/A0sam+budAOjhscZRfkzOW9Vq0+aZWyqPP+96eA/en0zcloY+O1zOjIufi/UY83pDcm2bIWO5K8B7QbrwdA/TvUZEyj917gE0VW/UjAsius2q0xhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3df309d9842so127410655ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 19:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751509115; x=1752113915;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/KeYqAzhlug2cBlOAvbYyW9y7V2ttwqcW5y5zhjy80=;
        b=NQ+67oJ4nVpMv0LLtCDckT1PjF6/OpYhmLysaVKxI613qSgAl9avIEL1mpDV12wFci
         XPTq0pVHob2GkopkBm3BAl4MAvcQ4OnKoeBgyosB+ZouajJr1BV1vERJln94WUMFGSh8
         ZXXkFxGPGnx+ugsgZUNBzv2LPSozpOsAzf+ZJYGLe0aeh7kD+oNns2BMDXbLz0YhmPqS
         ZNRhcQy4GGxAblfmSUZJ+dP3HY4L0144RVMCFagsrM4InTcrpV+ODAL6YMx+9vOnY/4l
         tC5WPU6w8mNTci7rfCuPE6JLSNzQpUjo3NlCxsb9PgvHtimn/ntlcJLYqJ+Z9oYv4xyE
         ZdGg==
X-Forwarded-Encrypted: i=1; AJvYcCVg1R9GbeAQLmLbIVMN0Pfn9Lld4i5n0sGQLI4PKnP/+f4352eFVktZCKui/7ZidhjYKXJsCSK1Wkz/ZtXe@vger.kernel.org
X-Gm-Message-State: AOJu0YxlyKVnSrVP2y4E6WyBQIWj/c1wwS4xQzN7OzkwTBzqaZN/KMDy
	nWkTn6EVQEuKWVhxCGNDCcJfx355/obRMBOOJuYtpm5blJFc4csIDJYssoE0aN0LQYVEQyN5FVj
	ZY0VthU7+OsWTW8mvRZTUD21seaDYyuPFDhdrGEuQsQwvTe4lHDrZn6j+uWg=
X-Google-Smtp-Source: AGHT+IE4L9la8RyH87X3ZXX5fLSYYN9RNx7vp9JR76jrtT1rZHYYadDT1F9A+PfVZZt1hqYJ5gRRY9ebGqZvFjCbt+mCAtj2+2PD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3397:b0:3df:43d1:6a58 with SMTP id
 e9e14a558f8ab-3e05c3382f0mr26651945ab.20.1751509114831; Wed, 02 Jul 2025
 19:18:34 -0700 (PDT)
Date: Wed, 02 Jul 2025 19:18:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6865e87a.a70a0220.2b31f5.000a.GAE@google.com>
Subject: [syzbot] [exfat?] kernel BUG in folio_set_bh
From: syzbot <syzbot+f4f84b57a01d6b8364ad@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50c8770a42fa Add linux-next specific files for 20250702
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1500f982580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d831c9dfe03f77ec
dashboard link: https://syzkaller.appspot.com/bug?extid=f4f84b57a01d6b8364ad
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c93770580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1001aebc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb40fda2e0ca/disk-50c8770a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cba4d214940c/vmlinux-50c8770a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b23ed647866/bzImage-50c8770a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ef503c02b7ee/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=11c93770580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f4f84b57a01d6b8364ad@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 128
------------[ cut here ]------------
kernel BUG at fs/buffer.c:1582!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6151 Comm: syz.0.51 Not tainted 6.16.0-rc4-next-20250702-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:folio_set_bh+0x1dc/0x1e0 fs/buffer.c:1582
Code: 4c 89 e2 e8 d6 eb b6 02 e9 42 ff ff ff e8 cc 7c 79 ff 48 89 df 48 c7 c6 a0 ec 99 8b e8 ad af c1 ff 90 0f 0b e8 b5 7c 79 ff 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
RSP: 0018:ffffc90003c5f8e0 EFLAGS: 00010293
RAX: ffffffff8246582b RBX: ffffea0001840a40 RCX: ffff8880776c3c00
RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000000000001000
RBP: dffffc0000000000 R08: ffffea0001840a47 R09: 1ffffd4000308148
R10: dffffc0000000000 R11: fffff94000308149 R12: 0000000000000000
R13: 0000000000001000 R14: ffff8880744cfcb0 R15: 0000000000001000
FS:  0000555591bcd500(0000) GS:ffff888125d1d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5810d71d60 CR3: 0000000076ee0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 folio_alloc_buffers+0x3a0/0x640 fs/buffer.c:946
 grow_dev_folio fs/buffer.c:1075 [inline]
 grow_buffers fs/buffer.c:1116 [inline]
 __getblk_slow fs/buffer.c:1134 [inline]
 bdev_getblk+0x286/0x660 fs/buffer.c:1461
 __bread_gfp+0x89/0x3c0 fs/buffer.c:1515
 sb_bread include/linux/buffer_head.h:346 [inline]
 fat_fill_super+0x5e2/0x3570 fs/fat/inode.c:1598
 get_tree_bdev_flags+0x40b/0x4d0 fs/super.c:1681
 vfs_get_tree+0x92/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5810d900ca
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe6ee42248 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe6ee422d0 RCX: 00007f5810d900ca
RDX: 0000200000000240 RSI: 0000200000000280 RDI: 00007ffe6ee42290
RBP: 0000200000000240 R08: 00007ffe6ee422d0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000000280
R13: 00007ffe6ee42290 R14: 0000000000000221 R15: 0000200000000480
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_set_bh+0x1dc/0x1e0 fs/buffer.c:1582
Code: 4c 89 e2 e8 d6 eb b6 02 e9 42 ff ff ff e8 cc 7c 79 ff 48 89 df 48 c7 c6 a0 ec 99 8b e8 ad af c1 ff 90 0f 0b e8 b5 7c 79 ff 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
RSP: 0018:ffffc90003c5f8e0 EFLAGS: 00010293
RAX: ffffffff8246582b RBX: ffffea0001840a40 RCX: ffff8880776c3c00
RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000000000001000
RBP: dffffc0000000000 R08: ffffea0001840a47 R09: 1ffffd4000308148
R10: dffffc0000000000 R11: fffff94000308149 R12: 0000000000000000
R13: 0000000000001000 R14: ffff8880744cfcb0 R15: 0000000000001000
FS:  0000555591bcd500(0000) GS:ffff888125c1d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9535e0f000 CR3: 0000000076ee0000 CR4: 00000000003526f0


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

