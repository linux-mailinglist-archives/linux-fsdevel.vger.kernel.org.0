Return-Path: <linux-fsdevel+bounces-71254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA54ACBB264
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 20:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41A4D300E7AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 19:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009F32E62DA;
	Sat, 13 Dec 2025 19:01:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2ED184540
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765652502; cv=none; b=iwnsSEi04yZfprCQrd/dOkzBE4NNYE4uFvjxasaiyiou0d3ACR3d0a62x8JHDQMJvKpu6iGwWJnK0DTe99lPWDstseypA2hemFHjoErQxmleWkES5gBQynbA0cK/g57dcvQtd5+z7s/Tln3jLjDRikQ83aFD/dVVjBnLHgpyjFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765652502; c=relaxed/simple;
	bh=Jxx+xhHc1mzY67gXgl9W/jEh3GoKiTE/j1E4M1Lpq4o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A57WwTA/zIyaqL4DE+/PAWlm9apzf7mpz6zwzSwiADOFckmlTBp+XRNGDT8v7S1hjZlj98zHlc8zaNhGr1/CDDKvHvHTi+8IXZ1QahxlJm7CS25QJsA2RFfqBRiYBmBqSgygA2AxIpR9ZrviF1UjdCLNCbpnttMINcgOG4w1BK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7c70546acd9so4232148a34.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 11:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765652499; x=1766257299;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q6LYSVEkuvknOCMIrWyuricHiIk19f4UdtIXyYs0htA=;
        b=SALY8/ONaeLgeXSDrkL6I5YoNQVWJALA7QkUUP/1lSmhmc0FWk/1h0WMSohJl378sx
         o6kQOHNfIUN4Fyr5gBx2EBSf93HM/B8bCMq1NDIXUsSPRa/P7XxEluomZPqH3TFueA1j
         qy2UARXVVOgpimTz9hkUjeviusiao8rHmcrgESVgctse3Q8dlIrd423svq9OjHX8MG7E
         /SDXaXuv0lmuFkULq0B6yPSwbuuxTgYNl9mNwuGaqOeyBdgT89nxrDuley0Tp+tZnXFR
         Ou0Bh5qL3rkVOOqUVhQx7IBA7wjKDXLkwb35xizwitqOTP63KtrgBAUN1Kd/0c3cFwR8
         HFNQ==
X-Gm-Message-State: AOJu0YweuVNvlUyzgYOtzetI+nro7J53Wv/rjIOWC4R29wwvBZhtUfIy
	NKqluoHoaWX/2x4Iu8vyJgFOI1XiXiYGeQzX4266OMomXakrLvU4VdHXjn2fltzZw8SeZXRWPap
	2zBeXAHuduPcEkchH33nD7ZicfNOap7rUOmR/G8FBglp38yWJu6AszIsP7BokMA==
X-Google-Smtp-Source: AGHT+IGXw4KYtBQk2srwLpKzFFkByGftIkvTb8uF0m2SF8pwtIln+l18dgrBndq0mPdEd0thHRhmVs2RLV/aV70L6X9R4aZKwROk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b91:b0:65b:380a:ce87 with SMTP id
 006d021491bc7-65b4527c6d5mr2945597eaf.63.1765652499433; Sat, 13 Dec 2025
 11:01:39 -0800 (PST)
Date: Sat, 13 Dec 2025 11:01:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693db813.a70a0220.104cf0.0316.GAE@google.com>
Subject: [syzbot] [fs?] memory leak in adfs_init_fs_context
From: syzbot <syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cb015814f8b6 Merge tag 'f2fs-for-6.19-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d85a1a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69400c231dedfdcf
dashboard link: https://syzkaller.appspot.com/bug?extid=1c70732df5fd4f0e4fbb
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17de9eb4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b6d992580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/59ea583a27f0/disk-cb015814.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5251b8b465ee/vmlinux-cb015814.xz
kernel image: https://storage.googleapis.com/syzbot-assets/061ac7ae9ddf/bzImage-cb015814.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888126345900 (size 64):
  comm "syz.0.18", pid 6076, jiffies 4294944529
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 c0 01 3f 00 00 00 00 00  ..........?.....
  backtrace (crc 45941a6b):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4953 [inline]
    slab_alloc_node mm/slub.c:5258 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    adfs_init_fs_context+0x26/0xe0 fs/adfs/super.c:440
    alloc_fs_context+0x2a0/0x6e0 fs/fs_context.c:315
    do_new_mount fs/namespace.c:3692 [inline]
    path_mount+0x93f/0x1320 fs/namespace.c:4022
    do_mount fs/namespace.c:4035 [inline]
    __do_sys_mount fs/namespace.c:4224 [inline]
    __se_sys_mount fs/namespace.c:4201 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4201
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888126345f40 (size 64):
  comm "syz.0.19", pid 6079, jiffies 4294944531
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 c0 01 3f 00 00 00 00 00  ..........?.....
  backtrace (crc 45941a6b):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4953 [inline]
    slab_alloc_node mm/slub.c:5258 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    adfs_init_fs_context+0x26/0xe0 fs/adfs/super.c:440
    alloc_fs_context+0x2a0/0x6e0 fs/fs_context.c:315
    do_new_mount fs/namespace.c:3692 [inline]
    path_mount+0x93f/0x1320 fs/namespace.c:4022
    do_mount fs/namespace.c:4035 [inline]
    __do_sys_mount fs/namespace.c:4224 [inline]
    __se_sys_mount fs/namespace.c:4201 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4201
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812636ad40 (size 64):
  comm "syz.0.20", pid 6128, jiffies 4294945167
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 c0 01 3f 00 00 00 00 00  ..........?.....
  backtrace (crc 45941a6b):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4953 [inline]
    slab_alloc_node mm/slub.c:5258 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    adfs_init_fs_context+0x26/0xe0 fs/adfs/super.c:440
    alloc_fs_context+0x2a0/0x6e0 fs/fs_context.c:315
    do_new_mount fs/namespace.c:3692 [inline]
    path_mount+0x93f/0x1320 fs/namespace.c:4022
    do_mount fs/namespace.c:4035 [inline]
    __do_sys_mount fs/namespace.c:4224 [inline]
    __se_sys_mount fs/namespace.c:4201 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4201
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888126345b40 (size 64):
  comm "syz.0.21", pid 6129, jiffies 4294945168
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 c0 01 3f 00 00 00 00 00  ..........?.....
  backtrace (crc 45941a6b):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4953 [inline]
    slab_alloc_node mm/slub.c:5258 [inline]
    __kmalloc_cache_noprof+0x3b2/0x570 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    adfs_init_fs_context+0x26/0xe0 fs/adfs/super.c:440
    alloc_fs_context+0x2a0/0x6e0 fs/fs_context.c:315
    do_new_mount fs/namespace.c:3692 [inline]
    path_mount+0x93f/0x1320 fs/namespace.c:4022
    do_mount fs/namespace.c:4035 [inline]
    __do_sys_mount fs/namespace.c:4224 [inline]
    __se_sys_mount fs/namespace.c:4201 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4201
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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

