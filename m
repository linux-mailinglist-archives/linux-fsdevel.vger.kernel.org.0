Return-Path: <linux-fsdevel+bounces-68173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E91BC55A59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 05:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D675F34B84B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 04:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840E2FF165;
	Thu, 13 Nov 2025 04:27:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278092FD7B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 04:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763008054; cv=none; b=i03LZI4x71qlmqoYr5+rUeHqT0rYFW7Ro06W6wAWe/oCGaPfkBf4M8EOFqmKVHSSrmrSSq4U/7JwT1WL6dRid3L1LM7f/Gzi6cDIkUwKMZtW3dVY64xlzyJDnT4/0DVVKi9o2znlCaT6kj/z8Vso9POsByhX2RUimqCoJy3OYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763008054; c=relaxed/simple;
	bh=e410lL0XtJhawaYXcwc+sC+bh1ZpZB82XM/advswfI8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bLhGF2sTRyeiAe6P3qfL2IIrmbZJi9kuruJY+ELGc08yoL0OjZ2ZHXQ55vKS0bcwZ4FQVTLc51KTx9YQ98GZlox5Hdob90xCgefZxd6OxR5N/m5UqTCXNWOXAgY08aC9Hze+yzpsDY0LYpPQ4pdox1owwOQ3FPIMv10dxzG0nqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-93e7b0584c9so45410239f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 20:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763008052; x=1763612852;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iuB9FyGKjr7RQqFH7KTTEBJokESm16XwCwKVflGFl9M=;
        b=PIXODzkN2JsUVSJT3KyXRWLEUv1jmL1irICJp/oMSg37gNUmWnDy0Uq77WuloA/UJr
         XPSeLJigcVwfYTE7oU8IqPZXQeJIi+C07Tj/+OvfcooePgETELJhsOfMz164+pka4pIV
         DuAq5eKC3nu3e3mYv9lytRqpL+5regrMX9XZXDjj3tTt0ux6mgOdEXH7cXkAg2DFZmKL
         obb+V75bzToggnfffBnut8aLFzSfd4cecR9Z615JJrXpirKT+pvFrXiI8OCxmIzkKcI2
         2kOepaVam9xlbk3qtevBxk+3iZrNsFmapR4QhqlG2ic9OD3t9xBcirO1+itSm9VYiJMC
         Uhnw==
X-Forwarded-Encrypted: i=1; AJvYcCUWCiTmO65Nigf6BZ7CCMSP974d/BSGwe1k4aF6j1ntH/yLgLpBpu4g+ykUapB0cDVMU8igjCa6tLjOgqvv@vger.kernel.org
X-Gm-Message-State: AOJu0YyxhR5pT/IGbAskqkFwd2NHybnrF3EDekw6ms6hVlOr9QU5onZt
	6uS2KeouPdaEohciSxYzNOf2RqIbmXOo8bpX5cn+lAR3s8sXaeYMQatSZv97JJvkvBEgpYbNdlM
	6dS3kuJBgZeaYZW2jwvmp5pLFfDZYfNHsocXQKdS6u/KnDXJkfI2Dv//bgp0=
X-Google-Smtp-Source: AGHT+IGeZ/Gg+McHtOFHUT3knOBoPtWRPAUPYSEbUGKCUvGl563WPw/+WpQpxVznIYzsX3701JzbnkImhcNuXIMIWcb2aT+Nlzrq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:601a:b0:948:7aa3:3670 with SMTP id
 ca18e2360f4ac-948c467bf13mr686625939f.13.1763008052246; Wed, 12 Nov 2025
 20:27:32 -0800 (PST)
Date: Wed, 12 Nov 2025 20:27:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69155e34.050a0220.3565dc.0019.GAE@google.com>
Subject: [syzbot] [hfs?] memory leak in hfs_init_fs_context
From: syzbot <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4ea7c1717f3f Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17346c12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143f5c12580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c9a7cd980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1f8cf51c9042/disk-4ea7c171.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f227246b5b7/vmlinux-4ea7c171.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f935766a00b3/bzImage-4ea7c171.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bee9311f4026/mount_4.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888111778c00 (size 512):
  comm "syz.0.17", pid 6092, jiffies 4294942644
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc eb1d7412):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    hfs_init_fs_context+0x24/0xd0 fs/hfs/super.c:411
    alloc_fs_context+0x214/0x430 fs/fs_context.c:315
    do_new_mount fs/namespace.c:3707 [inline]
    path_mount+0x93c/0x12e0 fs/namespace.c:4037
    do_mount fs/namespace.c:4050 [inline]
    __do_sys_mount fs/namespace.c:4238 [inline]
    __se_sys_mount fs/namespace.c:4215 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4215
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810a2e8800 (size 512):
  comm "syz.0.18", pid 6098, jiffies 4294942646
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc eb1d7412):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    hfs_init_fs_context+0x24/0xd0 fs/hfs/super.c:411
    alloc_fs_context+0x214/0x430 fs/fs_context.c:315
    do_new_mount fs/namespace.c:3707 [inline]
    path_mount+0x93c/0x12e0 fs/namespace.c:4037
    do_mount fs/namespace.c:4050 [inline]
    __do_sys_mount fs/namespace.c:4238 [inline]
    __se_sys_mount fs/namespace.c:4215 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4215
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810a2e8e00 (size 512):
  comm "syz.0.19", pid 6102, jiffies 4294942648
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc eb1d7412):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    hfs_init_fs_context+0x24/0xd0 fs/hfs/super.c:411
    alloc_fs_context+0x214/0x430 fs/fs_context.c:315
    do_new_mount fs/namespace.c:3707 [inline]
    path_mount+0x93c/0x12e0 fs/namespace.c:4037
    do_mount fs/namespace.c:4050 [inline]
    __do_sys_mount fs/namespace.c:4238 [inline]
    __se_sys_mount fs/namespace.c:4215 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4215
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881263ed600 (size 512):
  comm "syz.0.20", pid 6125, jiffies 4294943177
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc eb1d7412):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    hfs_init_fs_context+0x24/0xd0 fs/hfs/super.c:411
    alloc_fs_context+0x214/0x430 fs/fs_context.c:315
    do_new_mount fs/namespace.c:3707 [inline]
    path_mount+0x93c/0x12e0 fs/namespace.c:4037
    do_mount fs/namespace.c:4050 [inline]
    __do_sys_mount fs/namespace.c:4238 [inline]
    __se_sys_mount fs/namespace.c:4215 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4215
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810db18c00 (size 512):
  comm "syz.0.21", pid 6127, jiffies 4294943179
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc eb1d7412):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    hfs_init_fs_context+0x24/0xd0 fs/hfs/super.c:411
    alloc_fs_context+0x214/0x430 fs/fs_context.c:315
    do_new_mount fs/namespace.c:3707 [inline]
    path_mount+0x93c/0x12e0 fs/namespace.c:4037
    do_mount fs/namespace.c:4050 [inline]
    __do_sys_mount fs/namespace.c:4238 [inline]
    __se_sys_mount fs/namespace.c:4215 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4215
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
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

