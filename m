Return-Path: <linux-fsdevel+bounces-72041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0FDCDC188
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C45E3011EA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 11:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2601A301037;
	Wed, 24 Dec 2025 11:15:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F842049
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766574924; cv=none; b=iITUKaQfdQNRZeR49kGqNFNdmR26SGr2uWDhHOU7zqeNN46qxvGchiv+OST0+zCPDuXvpM1EKVQI6yKUiYACo//5Nj0SfcQSyQPXKw0+5R/1XN16A8DlWLK3xtiYrwJxVuFe5WtBg1o02LtlfwPNcJt1aNXpByUDlwC1+iQ3f+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766574924; c=relaxed/simple;
	bh=6vXejrukiiPtuISDAAVP73Zlx0RumkyhHH5TTP5Ehbk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ualy0u1+jccyGxkOCBmoCwqGJe3nbetGl7exqXeZOlO9WNNAimHq98pwVGyNRETF+3u3PmNs14pifeRt/4FxiKcHEDHLvbURSRduVn93FAvZD4JZRKa/anPrKaBUmLRHSlUEJIK69XFAXXpI7gb1yuPbQ2waLmaWQrIww+FJd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-65d0318e02eso10129217eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 03:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766574922; x=1767179722;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6po98qswVWNRMjUNUOg2lWnO5i/uPCue/6wM1LmLU4=;
        b=kjvxyXW6gZJeKYpS8dXua2Nrwg7clHn/PIB/PpuPV1mCuod2tx7b1xj34R7zZtsiYX
         qu6hGe0vsu/ENJ4qa3/h/OsKSlJOvr0d7pJcGe1Zt5tSozDrCpib4+TyrdpKIw5xK2B3
         ZUJJs5mbrkYn4XYyeCMeElR/j56qj+4v6XQmfflT662Q8DOdHsG25HjPOx/98LMhG0N8
         wOcznDm46uwiFWXLLYS/Nv7YP8DoJy+fcNG45rN/5VgoxrnkmJmgfcmoNqdRG6jOw2Az
         wZ0VbgK7Y7CkPQXfaniZh6zHPHs50gQnp4hCgNwfmDmaK7ehxQyF6qX7icgH4DtjimTJ
         C3mA==
X-Forwarded-Encrypted: i=1; AJvYcCVLwzQ40QkazpLWo0oQsdFKcpmijsKgxtSA8dUxUw4jnJAoquI2UJBBGlNNGpmUgYsMAtdOhJRVDE271jdN@vger.kernel.org
X-Gm-Message-State: AOJu0YyiBK6UALg82jsTJZHlXykAYVrIiFWHYu9sOGSIC47YIgvuN1vS
	w61wPBfRw9yhMQZ4VMjCkzBVYYX1PJTZ28i/3Xj8aaQUYxKwv/hjl3opsyNVnM1EQ9DNSBfCf6q
	HtMf+jVl9zWaYbuGM5HLr0hG7Y5vAa+nckV5FYUzLm8jnjN0aBt5DSsOeDH0=
X-Google-Smtp-Source: AGHT+IFElkOqP4pqEx+smAsw3sIRVsJLuW73HwphaX7s34u8rKYTmAuynSKKitCTO+69x9ONIAT2yFDVr/lx2S/qWZCqLAQWFSw5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f00c:b0:65d:be3:3110 with SMTP id
 006d021491bc7-65d0e99d928mr8503395eaf.23.1766574921958; Wed, 24 Dec 2025
 03:15:21 -0800 (PST)
Date: Wed, 24 Dec 2025 03:15:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694bcb49.050a0220.35954c.001a.GAE@google.com>
Subject: [syzbot] [fs?] memory leak in getname_flags
From: syzbot <syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b927546677c8 Merge tag 'dma-mapping-6.19-2025-12-22' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146fef1a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d60836e327fd6756
dashboard link: https://syzkaller.appspot.com/bug?extid=00e61c43eb5e4740438f
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153e90fc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126fef1a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c1254aadd0a/disk-b9275466.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15b98aa2b078/vmlinux-b9275466.xz
kernel image: https://storage.googleapis.com/syzbot-assets/10a68a086ef8/bzImage-b9275466.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com

2025/12/24 09:11:05 executed programs: 5
BUG: memory leak
unreferenced object 0xffff8881098a2000 (size 4096):
  comm "syz.0.17", pid 6087, jiffies 4294944491
  hex dump (first 32 bytes):
    20 20 8a 09 81 88 ff ff 40 02 00 00 00 20 00 00    ......@.... ..
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 5d427fb2):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    getname_flags.part.0+0x26/0x280 fs/namei.c:146
    getname_flags+0x4b/0x90 include/linux/audit.h:345
    getname include/linux/fs.h:2498 [inline]
    __io_openat_prep+0x87/0x1a0 io_uring/openclose.c:70
    io_init_req io_uring/io_uring.c:2234 [inline]
    io_submit_sqe io_uring/io_uring.c:2281 [inline]
    io_submit_sqes+0x40d/0xf40 io_uring/io_uring.c:2434
    __do_sys_io_uring_enter+0x841/0xcf0 io_uring/io_uring.c:3280
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881009ea000 (size 4096):
  comm "syz.0.18", pid 6090, jiffies 4294944493
  hex dump (first 32 bytes):
    20 a0 9e 00 81 88 ff ff 40 02 00 00 00 20 00 00   .......@.... ..
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 254b05b2):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    getname_flags.part.0+0x26/0x280 fs/namei.c:146
    getname_flags+0x4b/0x90 include/linux/audit.h:345
    getname include/linux/fs.h:2498 [inline]
    __io_openat_prep+0x87/0x1a0 io_uring/openclose.c:70
    io_init_req io_uring/io_uring.c:2234 [inline]
    io_submit_sqe io_uring/io_uring.c:2281 [inline]
    io_submit_sqes+0x40d/0xf40 io_uring/io_uring.c:2434
    __do_sys_io_uring_enter+0x841/0xcf0 io_uring/io_uring.c:3280
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881009eb000 (size 4096):
  comm "syz.0.19", pid 6092, jiffies 4294944494
  hex dump (first 32 bytes):
    20 b0 9e 00 81 88 ff ff 40 02 00 00 00 20 00 00   .......@.... ..
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 9f4244d8):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    getname_flags.part.0+0x26/0x280 fs/namei.c:146
    getname_flags+0x4b/0x90 include/linux/audit.h:345
    getname include/linux/fs.h:2498 [inline]
    __io_openat_prep+0x87/0x1a0 io_uring/openclose.c:70
    io_init_req io_uring/io_uring.c:2234 [inline]
    io_submit_sqe io_uring/io_uring.c:2281 [inline]
    io_submit_sqes+0x40d/0xf40 io_uring/io_uring.c:2434
    __do_sys_io_uring_enter+0x841/0xcf0 io_uring/io_uring.c:3280
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881098a6000 (size 4096):
  comm "syz.0.20", pid 6134, jiffies 4294945094
  hex dump (first 32 bytes):
    20 60 8a 09 81 88 ff ff 40 02 00 00 00 20 00 00   `......@.... ..
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc d8f470d9):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    getname_flags.part.0+0x26/0x280 fs/namei.c:146
    getname_flags+0x4b/0x90 include/linux/audit.h:345
    getname include/linux/fs.h:2498 [inline]
    __io_openat_prep+0x87/0x1a0 io_uring/openclose.c:70
    io_init_req io_uring/io_uring.c:2234 [inline]
    io_submit_sqe io_uring/io_uring.c:2281 [inline]
    io_submit_sqes+0x40d/0xf40 io_uring/io_uring.c:2434
    __do_sys_io_uring_enter+0x841/0xcf0 io_uring/io_uring.c:3280
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881098a1000 (size 4096):
  comm "syz.0.21", pid 6135, jiffies 4294945095
  hex dump (first 32 bytes):
    20 10 8a 09 81 88 ff ff 40 02 00 00 00 20 00 00   .......@.... ..
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 4828ba4d):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    getname_flags.part.0+0x26/0x280 fs/namei.c:146
    getname_flags+0x4b/0x90 include/linux/audit.h:345
    getname include/linux/fs.h:2498 [inline]
    __io_openat_prep+0x87/0x1a0 io_uring/openclose.c:70
    io_init_req io_uring/io_uring.c:2234 [inline]
    io_submit_sqe io_uring/io_uring.c:2281 [inline]
    io_submit_sqes+0x40d/0xf40 io_uring/io_uring.c:2434
    __do_sys_io_uring_enter+0x841/0xcf0 io_uring/io_uring.c:3280
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

