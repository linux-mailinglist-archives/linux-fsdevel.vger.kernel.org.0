Return-Path: <linux-fsdevel+bounces-54030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77A4AFA5A1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 15:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8D03B90DF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D28213E85;
	Sun,  6 Jul 2025 13:59:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B6202998
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Jul 2025 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751810374; cv=none; b=EvOHW5YNPHylQtpZ+d5rnleBoI/O519+Mp3tjIgl9t475NeL13hRJ3ZEJ3o2KZtDeFSQdc9wAFaCceCH1kK5lkVVz9lwTB5g1rrW+0pub6K4zzd9mQkwh344oBhFGkulV2uYx7mBYAcxiAUhUCIOZBSPjFTKMiqDqQKkph0su1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751810374; c=relaxed/simple;
	bh=PmcnSiCEVQON1nfQOoP66iCD+4qemZjc8o6YYUBh8Lc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J5GVU1JjG5u10pOn8wxW80kn4F05jDyGEtH0PF977Aaj9vSB0Yk4if1vZ0YDqZgTuliSBWlIZLm7C4wuznbhX+ppFyDoM31aZGkDo9wNUjCLtvo+GKJqS0jON5YsCjVKydpEOgKBY8SX7GuLSyvEeJNi2lnhO4ZUNc+JTh7VWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3df4d2a8b5eso22751585ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Jul 2025 06:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751810371; x=1752415171;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xTEnq3Uz9tOhEg7gYohm3AHuoKWB/nrIIOeBJ/1F9qA=;
        b=ffcyN/KLbVYaAoREEw2U1DCaQtYUOhzesbLiVMwMlRwuxvbVtPljBk0CieXLJxcD9v
         bNJzzXyTKTtosHMNpKdRNfkOmtUJga8jY/uNhfJbrOBCsSHPv4lz841U8pPv7ALjqi2I
         thMFSbckzLVzAX5qMu5jFnYqamLHVbOV8WqGbMo6ZSSVbR2c5w8n0pU5tcUB/l9HBVWR
         s/SiY7qA8U6s59ZkMtfpbuPx24Dhf8n5qdArCYaTZkckCOw3HL3ptEYP7Do6mK7XK3vu
         mUlVUnnwgHXTjtnkIBr4J8Fb2/SwoszlR/V1CPzNu4VGLeQv+T3RAsof8Tkz0CFHcPI7
         dn7A==
X-Forwarded-Encrypted: i=1; AJvYcCVDyma1e/wikzXjL9jH6EnpuQrwifxcS3y5yfHI8M5frPcULMLTDy2VIrvRUlBWgbjXmKIFGZ80D+PBLXL8@vger.kernel.org
X-Gm-Message-State: AOJu0YyoDle5b2K0ErWJBdBOPddNsdo0r2zLFfso6NK0eX9W1zS9WUD+
	oMjXHrzpKwAz0DDGOfbfvTM9/lZK1gnSIbeRdR7NKj9Wa+XND5TL0yOIBqZL7gf3dz98GAyrxA6
	dgBtmkpdn3KV8jx9L7PqUUaaSrojwXKKbAzxL8qmYSSNfQgQNjYp+tIonET4=
X-Google-Smtp-Source: AGHT+IHQvmxELFKtQB8kTMwtbluGsxgKN7950SxbLnkBbz5rLj7FnXxfM90trGgjCbWB+0Yzqr3cGBjtkZ3z8yVBJvShL1qIr+8U
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f0a:b0:3dc:7fa4:823 with SMTP id
 e9e14a558f8ab-3e1371e850cmr79750425ab.16.1751810371665; Sun, 06 Jul 2025
 06:59:31 -0700 (PDT)
Date: Sun, 06 Jul 2025 06:59:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686a8143.a00a0220.c7b3.005b.GAE@google.com>
Subject: [syzbot] [exfat?] WARNING in bdev_getblk
From: syzbot <syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    26ffb3d6f02c Add linux-next specific files for 20250704
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=127fc28c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4f88512ae53408
dashboard link: https://syzkaller.appspot.com/bug?extid=01ef7a8da81a975e1ccd
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd5569903143/disk-26ffb3d6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1b0c9505c543/vmlinux-26ffb3d6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d864c72bed1/bzImage-26ffb3d6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com

ERROR: (device loop0): force_metapage: metapage_write_one() failed
------------[ cut here ]------------
WARNING: fs/buffer.c:1125 at __getblk_slow fs/buffer.c:1125 [inline], CPU#0: syz.0.12/6044
WARNING: fs/buffer.c:1125 at bdev_getblk+0x580/0x660 fs/buffer.c:1461, CPU#0: syz.0.12/6044
Modules linked in:
CPU: 0 UID: 0 PID: 6044 Comm: syz.0.12 Not tainted 6.16.0-rc4-next-20250704-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__getblk_slow fs/buffer.c:1125 [inline]
RIP: 0010:bdev_getblk+0x580/0x660 fs/buffer.c:1461
Code: 26 fb ff ff e8 31 e3 78 ff 48 c7 c7 a0 fd 99 8b 48 c7 c6 b8 e6 9f 8d 4c 89 fa 4c 89 e9 e8 48 d0 e0 fe eb bd e8 11 e3 78 ff 90 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 41 80 3c 07 00 74 08 48 89
RSP: 0018:ffffc90005256f18 EFLAGS: 00010287
RAX: ffffffff8246cd6f RBX: ffff888022ccc518 RCX: 0000000000080000
RDX: ffffc9000d19d000 RSI: 000000000003d82f RDI: 000000000003d830
RBP: 0000000000001000 R08: 0000000000000000 R09: ffffffff8216f9cd
R10: dffffc0000000000 R11: fffff940003e86a7 R12: ffff888022ccce68
R13: ffff888022ccc500 R14: 0000000000001000 R15: 1ffff110045998a3
FS:  00007f72617f66c0(0000) GS:ffff888125be7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000009000 CR3: 0000000075c0a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __bread_gfp+0x89/0x3c0 fs/buffer.c:1515
 sb_bread include/linux/buffer_head.h:346 [inline]
 readSuper+0xdb/0x270 fs/jfs/jfs_mount.c:461
 updateSuper+0x1cf/0x5d0 fs/jfs/jfs_mount.c:423
 jfs_handle_error fs/jfs/super.c:69 [inline]
 jfs_error+0x198/0x2c0 fs/jfs/super.c:98
 force_metapage+0x1e7/0x360 fs/jfs/jfs_metapage.c:839
 txForce fs/jfs/jfs_txnmgr.c:2215 [inline]
 txCommit+0x4c05/0x5430 fs/jfs/jfs_txnmgr.c:1315
 duplicateIXtree+0x292/0x490 fs/jfs/jfs_imap.c:3019
 diNewIAG fs/jfs/jfs_imap.c:2597 [inline]
 diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
 diAllocAG+0x17a7/0x1df0 fs/jfs/jfs_imap.c:1669
 diAlloc+0x1d5/0x1680 fs/jfs/jfs_imap.c:1590
 ialloc+0x8c/0x8f0 fs/jfs/jfs_inode.c:56
 jfs_create+0x18d/0xa80 fs/jfs/namei.c:92
 lookup_open fs/namei.c:3708 [inline]
 open_last_lookups fs/namei.c:3807 [inline]
 path_openat+0x14f1/0x3830 fs/namei.c:4043
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1434
 do_sys_open fs/open.c:1449 [inline]
 __do_sys_openat fs/open.c:1465 [inline]
 __se_sys_openat fs/open.c:1460 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1460
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f726398e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f72617f6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f7263bb6080 RCX: 00007f726398e929
RDX: 000000000000275a RSI: 0000200000000540 RDI: ffffffffffffff9c
RBP: 00007f7263a10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f7263bb6080 R15: 00007ffc735ef598
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

