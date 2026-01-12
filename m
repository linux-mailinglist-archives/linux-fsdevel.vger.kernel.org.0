Return-Path: <linux-fsdevel+bounces-73188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA73D1101B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 08:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D798230A5986
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 07:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD5833B6EB;
	Mon, 12 Jan 2026 07:56:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6063382FD
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204590; cv=none; b=WgOafCJSKqs12JXuujoG0jD9aZRJMATXZJWK6ouhWK31qvvt5PeWpHyLUyCRSJdBTMlNFVR7r0KdjShBFrulpZH+Gq9F1cU/Q2tLazwDokTca9McicJt9BoSLlsx09o+lA2KSBtHAhLWXGnboSuCKrZZPyYc3wExCm16Sy7I6c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204590; c=relaxed/simple;
	bh=hmiPfrqHtA9MRDz+OStJmt96J9abT+qnxUk6juVoQo4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U/mpTO2mZKqXDx4q4b6ghuU8B3GPT+5Z6Gz/PbKqyqaKoC5pz+4vNqxwKw02n8tVV1e/BnR4lsgsSpg0AbK/1B0EisudhFOF9wsRoyIdUlmMN4ryTOHNZ4Zq0cuxTZFF/iJy7oRxsSF5xNUGiqjzmufHFY1cTVquTgrbFN6keV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-656c35cd5b4so8127525eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 23:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768204588; x=1768809388;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DHbo52SolRDYc7VKQ6DvhA24krT9bje640hz5kjnhos=;
        b=AoTOq0DbKjbo6cvRj/a3aVAsVMqe5AGGh+9gTS7AuKz0Gxkg8WnDooeZoS6VLYfENQ
         0Nv18oSaHK1cplxPHfEYs+39MyJhnCi9fAdBAoUWfQmKqXGxop2VPQmPIOw/f+JSfE7e
         y7EVXVOk2xqsvLOiM++mTm5tBiwRE+y5V2DMYh7+0zxKqeNFKhZR0Z0iioIogSIrY+Ml
         29lCRW7WWecPajcthF9FJAwYyzTGdgJV7IgDoDb+rdAjs6dC8b+lSVjQpt/Pc4gQ5avx
         sVW1+IDA6dTPyFrsQsIDtI224ad7OfqNQcnIUVfuvaQ8KzjTRBK9l6S9ZwrkwdnCA/by
         eE0A==
X-Forwarded-Encrypted: i=1; AJvYcCVJIo+1B47xkNXEWXr8IC9ElyEdHKpSLwKzAsvIF6uJQ9dgKUynGUQWwxIJgPgJDe10Wy9QYIIDsgCanhC5@vger.kernel.org
X-Gm-Message-State: AOJu0YwvIshCfR82b0FFtwIN14uHCc5jopoe6zaI7QBvUKIW9PI/Ref5
	syjdA9++Cv1yeUu17vv3ixnXk3gKUsji27UNt2+noLcRu7dUSy04cg3oGCR1YI0lwgYLTYBzwUQ
	Ybsoq0o0EBpXomL3tK3VtGudB9ROJ4Dp2RZuP3+Rfhwsv2RpPr4BZyeFMVp0=
X-Google-Smtp-Source: AGHT+IFmybVARW5r3S9t0aHvzSaaN2LLKQ42PWkGUZeKXngaJCx2HSQ7uziJ7FJqrBF8EvjDnDY/CKezFKGhq8kOPLHnoEi4MEgs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2203:b0:65d:697:3ae8 with SMTP id
 006d021491bc7-65f55083c6dmr8724874eaf.72.1768204587808; Sun, 11 Jan 2026
 23:56:27 -0800 (PST)
Date: Sun, 11 Jan 2026 23:56:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6964a92b.050a0220.eaf7.008a.GAE@google.com>
Subject: [syzbot] [fs?] memory leak in __shmem_file_setup
From: syzbot <syzbot+bf5de69ebb4bdf86f59f@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f0b9d8eb98df Merge tag 'nfsd-6.19-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ec819a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d60836e327fd6756
dashboard link: https://syzkaller.appspot.com/bug?extid=bf5de69ebb4bdf86f59f
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ec819a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bcc19a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aad2d47ff01d/disk-f0b9d8eb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c31e7ae85c07/vmlinux-f0b9d8eb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5525fab81561/bzImage-f0b9d8eb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf5de69ebb4bdf86f59f@syzkaller.appspotmail.com

2026/01/08 07:49:49 executed programs: 5
BUG: memory leak
unreferenced object 0xffff888112c4b240 (size 184):
  comm "syz.0.17", pid 6070, jiffies 4294944898
  hex dump (first 32 bytes):
    00 00 00 00 07 00 0e 02 00 e4 66 85 ff ff ff ff  ..........f.....
    98 38 89 09 81 88 ff ff 00 00 00 00 00 00 00 00  .8..............
  backtrace (crc 987747be):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    alloc_empty_file+0x51/0x1a0 fs/file_table.c:237
    alloc_file fs/file_table.c:354 [inline]
    alloc_file_pseudo+0xae/0x140 fs/file_table.c:383
    __shmem_file_setup+0x11a/0x210 mm/shmem.c:5846
    shmem_kernel_file_setup mm/shmem.c:5865 [inline]
    __shmem_zero_setup mm/shmem.c:5905 [inline]
    shmem_zero_setup_desc+0x33/0x90 mm/shmem.c:5936
    mmap_zero_prepare+0x4e/0x60 drivers/char/mem.c:524
    vfs_mmap_prepare include/linux/fs.h:2058 [inline]
    call_mmap_prepare mm/vma.c:2596 [inline]
    __mmap_region+0x8b8/0x13e0 mm/vma.c:2692
    mmap_region+0x19f/0x1e0 mm/vma.c:2786
    do_mmap+0x6a3/0xb60 mm/mmap.c:558
    vm_mmap_pgoff+0x1a6/0x2d0 mm/util.c:581
    ksys_mmap_pgoff+0x233/0x2d0 mm/mmap.c:604
    __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
    __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
    __x64_sys_mmap+0x6f/0xa0 arch/x86/kernel/sys_x86_64.c:82
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888101e46ca8 (size 40):
  comm "syz.0.17", pid 6070, jiffies 4294944898
  hex dump (first 32 bytes):
    ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 f8 52 86 00 81 88 ff ff  .........R......
  backtrace (crc 2d2a393c):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    lsm_file_alloc security/security.c:169 [inline]
    security_file_alloc+0x30/0x240 security/security.c:2380
    init_file+0x3e/0x160 fs/file_table.c:159
    alloc_empty_file+0x6f/0x1a0 fs/file_table.c:241
    alloc_file fs/file_table.c:354 [inline]
    alloc_file_pseudo+0xae/0x140 fs/file_table.c:383
    __shmem_file_setup+0x11a/0x210 mm/shmem.c:5846
    shmem_kernel_file_setup mm/shmem.c:5865 [inline]
    __shmem_zero_setup mm/shmem.c:5905 [inline]
    shmem_zero_setup_desc+0x33/0x90 mm/shmem.c:5936
    mmap_zero_prepare+0x4e/0x60 drivers/char/mem.c:524
    vfs_mmap_prepare include/linux/fs.h:2058 [inline]
    call_mmap_prepare mm/vma.c:2596 [inline]
    __mmap_region+0x8b8/0x13e0 mm/vma.c:2692
    mmap_region+0x19f/0x1e0 mm/vma.c:2786
    do_mmap+0x6a3/0xb60 mm/mmap.c:558
    vm_mmap_pgoff+0x1a6/0x2d0 mm/util.c:581
    ksys_mmap_pgoff+0x233/0x2d0 mm/mmap.c:604
    __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
    __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
    __x64_sys_mmap+0x6f/0xa0 arch/x86/kernel/sys_x86_64.c:82
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888108f03840 (size 184):
  comm "syz-executor", pid 5988, jiffies 4294944899
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 5869ffdf):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    prepare_creds+0x22/0x5e0 kernel/cred.c:185
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x979/0x2860 kernel/fork.c:2086
    kernel_clone+0x119/0x6c0 kernel/fork.c:2651
    __do_sys_clone+0x7b/0xb0 kernel/fork.c:2792
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888109a7b8e0 (size 32):
  comm "syz-executor", pid 5988, jiffies 4294944899
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    f8 52 86 00 81 88 ff ff 00 00 00 00 00 00 00 00  .R..............
  backtrace (crc 336e1c5f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __do_kmalloc_node mm/slub.c:5656 [inline]
    __kmalloc_noprof+0x3e0/0x660 mm/slub.c:5669
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    lsm_blob_alloc+0x4d/0x70 security/security.c:192
    lsm_cred_alloc security/security.c:209 [inline]
    security_prepare_creds+0x2f/0x270 security/security.c:2763
    prepare_creds+0x385/0x5e0 kernel/cred.c:215
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x979/0x2860 kernel/fork.c:2086
    kernel_clone+0x119/0x6c0 kernel/fork.c:2651
    __do_sys_clone+0x7b/0xb0 kernel/fork.c:2792
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888109b169c0 (size 184):
  comm "syz.0.18", pid 6072, jiffies 4294944899
  hex dump (first 32 bytes):
    00 00 00 00 07 00 0e 02 00 e4 66 85 ff ff ff ff  ..........f.....
    68 e6 05 0e 81 88 ff ff 00 00 00 00 00 00 00 00  h...............
  backtrace (crc 86e9bbaa):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    alloc_empty_file+0x51/0x1a0 fs/file_table.c:237
    alloc_file fs/file_table.c:354 [inline]
    alloc_file_pseudo+0xae/0x140 fs/file_table.c:383
    __shmem_file_setup+0x11a/0x210 mm/shmem.c:5846
    shmem_kernel_file_setup mm/shmem.c:5865 [inline]
    __shmem_zero_setup mm/shmem.c:5905 [inline]
    shmem_zero_setup_desc+0x33/0x90 mm/shmem.c:5936
    mmap_zero_prepare+0x4e/0x60 drivers/char/mem.c:524
    vfs_mmap_prepare include/linux/fs.h:2058 [inline]
    call_mmap_prepare mm/vma.c:2596 [inline]
    __mmap_region+0x8b8/0x13e0 mm/vma.c:2692
    mmap_region+0x19f/0x1e0 mm/vma.c:2786
    do_mmap+0x6a3/0xb60 mm/mmap.c:558
    vm_mmap_pgoff+0x1a6/0x2d0 mm/util.c:581
    ksys_mmap_pgoff+0x233/0x2d0 mm/mmap.c:604
    __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
    __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
    __x64_sys_mmap+0x6f/0xa0 arch/x86/kernel/sys_x86_64.c:82
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

