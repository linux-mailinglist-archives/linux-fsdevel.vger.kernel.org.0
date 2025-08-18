Return-Path: <linux-fsdevel+bounces-58128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD09B29BA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 10:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F3D189B9B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 08:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722532D7D42;
	Mon, 18 Aug 2025 08:05:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0C277C9B
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504335; cv=none; b=kTIVbiEu366qJh1cp7PXNXzcVKDDvgoiWOO/goE+MUzrBAibS0TNt5yEyhd1UwmPRRlGABBu/RdpTERTnCrtuiICwjgfCfv7eIkoWXo2aZfxDlHWWuBUJ7HssNWnPSg98gpquU0uWD5c+rFN9UUMACsMDEjM/vpGZis2ToIJzNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504335; c=relaxed/simple;
	bh=GYMD+PbGy1phmlmoytIWKdnYBzHkm2lG3DnsopYE9KQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i8kuQC8wLU1+Z/w3k+WUF5h/q+xhgMT1vEfIpnSAiEgCX57kQB6uOH3qLAmRAKL+PFftdmxRTdHf7rqB55NudzfIdnhAHNeWBhN/OCvX6RgiMYJK00MreweRTPs8DEr1TjOmGC4+QtdwFaOk8x7j7T/xVXV/wsgHEqcryguRyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88432d88f64so1167888639f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 01:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504332; x=1756109132;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhI6OqSaLXBMFcDdZkd8+biT6rzq7XESa9UcYJtZhm8=;
        b=wbJq3ill+D5f5CqDxJLlAPoV6fQLdv85uH7KtJpCyQQPXhnejLlv0wDUn8i7z+YNNf
         tUbeXz1pCPLm7A1R+ZVu+RqjBiKo77p8ycfrWDsVuuoejreRWMrm8VQhOMHVyYRQDosX
         at8Q1TPtLGnGLFU4pBn0C13kJCYtznAemmSfBRzOEgasGXLbD+0lmJYVGySPd9Ote3wS
         b1esZNQx1Ag3i3NCqBM4WPz08h/4B0kpfZO9aMX1dP6H5dlLiw2Gc2p6OOlRUh5icmTI
         s4tb1xD2HnsKgdd++4zllNjak56asmwJqO6ep+oaZcAkZZd5DFgEGNBqkrLY8flGfNjI
         lPJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvPGJ9c2mLQEf9delGCZuJ+PkTaLCfGCKE1tqtG/sE0FW7dFEkR3bcLuc5TgwOWt71Be6jjCpsI36jmgw2@vger.kernel.org
X-Gm-Message-State: AOJu0YzthiUPsNym0uVVBIaZJZNaaWjSJbfZsd4683E56oPoek1Y93VG
	Wuv13rvklyEzbY3DAGVFCQoaLq04QOfXMTruP2CIgmk7VSe3DwNxXM0pXuQTLuOK3FfhQ+txZx6
	YcmyHTs7mXMZ1i7uUl+T6YCNmyPWwGU32K6JBQNU3JNO039WFSy8Z47F5mBE=
X-Google-Smtp-Source: AGHT+IFMEgr58kHONO8OtZo+aHSFNsb0nfFocBAs1LVg6/KUrsU0rbk9oyzcFlgIfD70EGYevzrCc4lCb7ILTIkOODxotlkyyjcK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13d3:b0:87c:3d17:6608 with SMTP id
 ca18e2360f4ac-8843e22a091mr1905348539f.0.1755504332589; Mon, 18 Aug 2025
 01:05:32 -0700 (PDT)
Date: Mon, 18 Aug 2025 01:05:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a2decc.050a0220.e29e5.0098.GAE@google.com>
Subject: [syzbot] [hfs?] WARNING in hfs_find_init
From: syzbot <syzbot+6a141f31cc9495a3dcc1@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dfd4b508c8c6 Merge tag 'drm-fixes-2025-08-16' of https://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13c6f3a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98e114f4eb77e551
dashboard link: https://syzkaller.appspot.com/bug?extid=6a141f31cc9495a3dcc1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135edaf0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100ad3a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/289d8459a101/disk-dfd4b508.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/653f0f06a0ea/vmlinux-dfd4b508.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ab9bdbe6030/bzImage-dfd4b508.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/69f46f8377ed/mount_0.gz

The issue was bisected to:

commit d2d6422f8bd17c6bb205133e290625a564194496
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Fri Sep 6 10:59:04 2024 +0000

    x86: Allow to enable PREEMPT_RT.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119b63a2580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=139b63a2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=159b63a2580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a141f31cc9495a3dcc1@syzkaller.appspotmail.com
Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")

WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
------------[ cut here ]------------
rtmutex deadlock detected
WARNING: CPU: 1 PID: 5838 at kernel/locking/rtmutex.c:1674 rt_mutex_handle_deadlock+0x28/0xb0 kernel/locking/rtmutex.c:1674
Modules linked in:
CPU: 1 UID: 0 PID: 5838 Comm: syz-executor124 Tainted: G        W           6.17.0-rc1-syzkaller-00199-gdfd4b508c8c6 #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:rt_mutex_handle_deadlock+0x28/0xb0 kernel/locking/rtmutex.c:1674
Code: 90 90 41 57 41 56 41 55 41 54 53 83 ff dd 0f 85 8c 00 00 00 48 89 f7 e8 c6 2c 01 00 90 48 c7 c7 00 09 0b 8b e8 79 d8 8a f6 90 <0f> 0b 90 90 4c 8d 3d 00 00 00 00 65 48 8b 1c 25 08 b0 f5 91 4c 8d
RSP: 0018:ffffc90004b0ec90 EFLAGS: 00010246
RAX: 8abe693e197be100 RBX: ffffc90004b0ed20 RCX: ffff88803d511dc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004b0ee28 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1017124863 R12: 1ffff92000961da0
R13: ffffffff8af85119 R14: ffff88803d528048 R15: dffffc0000000000
FS:  000055555dc68380(0000) GS:ffff8881269c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002fe82000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x692/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 hfs_find_init+0x184/0x200 fs/hfs/bfind.c:-1
 hfs_ext_read_extent fs/hfs/extent.c:200 [inline]
 hfs_extend_file+0x2ee/0x1230 fs/hfs/extent.c:401
 hfs_bmap_reserve+0x107/0x430 fs/hfs/btree.c:269
 __hfs_ext_write_extent+0x1fa/0x470 fs/hfs/extent.c:121
 __hfs_ext_cache_extent+0x6b/0x9b0 fs/hfs/extent.c:174
 hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
 hfs_extend_file+0x316/0x1230 fs/hfs/extent.c:401
 hfs_get_block+0x3d7/0xbd0 fs/hfs/extent.c:353
 __block_write_begin_int+0x6b5/0x1900 fs/buffer.c:2145
 block_write_begin fs/buffer.c:2256 [inline]
 cont_write_begin+0x789/0xb50 fs/buffer.c:2594
 hfs_write_begin+0x66/0xb0 fs/hfs/inode.c:52
 cont_expand_zero fs/buffer.c:2522 [inline]
 cont_write_begin+0x2fd/0xb50 fs/buffer.c:2584
 hfs_write_begin+0x66/0xb0 fs/hfs/inode.c:52
 hfs_file_truncate+0x190/0x9c0 fs/hfs/extent.c:494
 hfs_inode_setattr+0x4a9/0x670 fs/hfs/inode.c:654
 notify_change+0xb31/0xe60 fs/attr.c:552
 do_truncate+0x1a4/0x220 fs/open.c:68
 vfs_truncate+0x493/0x520 fs/open.c:118
 do_sys_truncate+0xdb/0x190 fs/open.c:141
 __do_sys_truncate fs/open.c:153 [inline]
 __se_sys_truncate fs/open.c:151 [inline]
 __x64_sys_truncate+0x5b/0x70 fs/open.c:151
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa1dc925b99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff5e8c2808 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007fa1dc925b99
RDX: 00007fa1dc925b99 RSI: 0000000001001bfc RDI: 0000200000000040
RBP: 00007fa1dc9995f0 R08: 000055555dc694c0 R09: 000055555dc694c0
R10: 000055555dc694c0 R11: 0000000000000246 R12: 00007fff5e8c2830
R13: 00007fff5e8c2a58 R14: 431bde82d7b634db R15: 00007fa1dc96e03b
 </TASK>


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

