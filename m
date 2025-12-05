Return-Path: <linux-fsdevel+bounces-70755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFE4CA6288
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 06:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAF833132977
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 05:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32A82EB5A6;
	Fri,  5 Dec 2025 05:38:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA22E9EB5
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 05:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764913106; cv=none; b=XzUCpCf7WPqxeUI93D3ldBXqO0Htf7I4DCIhYYi1kdzNI9yoysDhg2vydIh1ZXRWuaszGPUk5IQtwGcnsU1h8k8dGCKnLsIDf0uIkZd1aaoKyZQyja264y17GHa8QkuDEiVxFsFxKwmyJ32wH7RXH5UxlD77Z9jei4rDYYngQx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764913106; c=relaxed/simple;
	bh=gX5s9InP4CaxkjTUQnFtfVjpqhWdyL8e7Gu83tuJ2r8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JJraS2Y9T16WkXLGtweWMHmU8BmDY0dhy91uldQ5qUhQ9UXHxEGZOOTvsh+f6EpDk0WTM9fm0ihl/BR/qcATPdzB+Iwh9GA3V4KmK30ombECqPckpKb7Od7vCmHAcdDv3xhxeAFIZHkj2l2xEydrAC1r2pa0o0am64dAlr8RI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-450aff06525so1886349b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 21:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764913103; x=1765517903;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKNu+EyLP3ZC3mG1qmS+d+QJ4bbxooVYEaLLuBmdjRA=;
        b=S2TOl3TsgrYiXu57VtVof7Y83OQfsuk4Stvc3MeQsWoNHvHVFc62NL4wf+YCYfAZZJ
         i809+a2exUG2f4TA6ZHypRAT9KtavXF01mejpF7+2pw870XkhJfabkAdu2KlgvwJuUva
         UV47J/u5NtEFo07WJP6cuHRN1EhkXp6IQoT/KP/Zt1oQfr8Txwi9jS5rU+6Q8FPizLxi
         XGkejBw0jlXVWSrGWrt0AYB2Tx323pE+4Detpwpfg5e03X36S7+MNzgz++HLkG/Mf7g4
         CAoc8//ZIQHlrXChzJGWjTA+y7aMIt7uV8UYt7ln+sRowtsSR0LQ/S31JxHiCb1xyEKB
         d58g==
X-Forwarded-Encrypted: i=1; AJvYcCUj3bMZ/ZK01ZIkq4/NuixQCeDzzrL0Qhn41pq1cZPfOPmNN0Fmsc6MM+3CeSYDTj1jXf03+79fTcaM53Bi@vger.kernel.org
X-Gm-Message-State: AOJu0YxKWxExSXZaiJ7rENiZiOHdmUhQPItBOR/VynxvhggdLefW4uyj
	HqH6wlb0YGgCEqu9UOBb5VyjMwcO7yshWAncQwY9leUYvyxfOnXP8eZjKetAKv70vDfLr7YeAb6
	c+168NDob/gt6ujW3F6KNtjHEMzjkwL3sRWIiAtg8rikjaMTzFfLVp22vd+I=
X-Google-Smtp-Source: AGHT+IFKaFSjNA4Bbp+B5QxA0MKUZ2YayGf9kzjLEatuCLUHLZx6pTe7H3LSC8OAf/kkvjP8PDmOxRmbadT60OW42/6RI08A20ag
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:ecf:b0:43f:1d72:592 with SMTP id
 5614622812f47-4536e44b686mr4836441b6e.23.1764913103618; Thu, 04 Dec 2025
 21:38:23 -0800 (PST)
Date: Thu, 04 Dec 2025 21:38:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69326fcf.a70a0220.d98e3.01e5.GAE@google.com>
Subject: [syzbot] [hfs?] memory leak in hfsplus_init_fs_context
From: syzbot <syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e69c7c175115 Merge tag 'timers_urgent_for_v6.18_rc8' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116ffcb4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f30cc590c4f6da44
dashboard link: https://syzkaller.appspot.com/bug?extid=99f6ed51479b86ac4c41
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10eef912580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1534c192580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e1758d9b5b79/disk-e69c7c17.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/772ec0d0a545/vmlinux-e69c7c17.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d905337ef02b/bzImage-e69c7c17.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/65bc76439748/mount_4.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881287f8a00 (size 512):
  comm "syz.0.17", pid 6072, jiffies 4294944858
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc aaf4239b):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    hfsplus_init_fs_context+0x26/0x90 fs/hfsplus/super.c:678
    alloc_fs_context+0x214/0x430 fs/fs_context.c:315
    do_new_mount fs/namespace.c:3698 [inline]
    path_mount+0x93c/0x12e0 fs/namespace.c:4028
    do_mount fs/namespace.c:4041 [inline]
    __do_sys_mount fs/namespace.c:4229 [inline]
    __se_sys_mount fs/namespace.c:4206 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4206
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881287f9a00 (size 512):
  comm "syz.0.18", pid 6078, jiffies 4294944862
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc aaf4239b):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    hfsplus_init_fs_context+0x26/0x90 fs/hfsplus/super.c:678
    alloc_fs_context+0x214/0x430 fs/fs_context.c:315
    do_new_mount fs/namespace.c:3698 [inline]
    path_mount+0x93c/0x12e0 fs/namespace.c:4028
    do_mount fs/namespace.c:4041 [inline]
    __do_sys_mount fs/namespace.c:4229 [inline]
    __se_sys_mount fs/namespace.c:4206 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4206
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881287f9c00 (size 512):
  comm "syz.0.19", pid 6079, jiffies 4294944864
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc aaf4239b):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5766
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    hfsplus_init_fs_context+0x26/0x90 fs/hfsplus/super.c:678
    alloc_fs_context+0x214/0x430 fs/fs_context.c:315
    do_new_mount fs/namespace.c:3698 [inline]
    path_mount+0x93c/0x12e0 fs/namespace.c:4028
    do_mount fs/namespace.c:4041 [inline]
    __do_sys_mount fs/namespace.c:4229 [inline]
    __se_sys_mount fs/namespace.c:4206 [inline]
    __x64_sys_mount+0x1a2/0x1e0 fs/namespace.c:4206
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

