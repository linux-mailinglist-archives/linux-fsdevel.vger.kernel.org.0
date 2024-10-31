Return-Path: <linux-fsdevel+bounces-33333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A09D9B7732
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 10:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186462873E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 09:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02911940B9;
	Thu, 31 Oct 2024 09:16:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411971494A3
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366190; cv=none; b=S6N+9AidOFQ1jup47NWhnHM5ahK61gvIASmK/Mby3+k1BQRxn6mlTEl9s9EmHzLq44AejvXXdO/QlOK3U/o9jMft2XxxqlVqvfwMcbaAN/Q7kb86lkxrf3p8VhTHAZooWf87qov6PmPBztukmkXQoKvcmYJGFvjNzIrERAGlEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366190; c=relaxed/simple;
	bh=/niDzxoQ163rluz+yYaFZRheMWyWIsMvN54Kk3hTs3g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gMcuH6PmyfWYSgUT7/264cDB1Wk/688CTtoXstAchDRHYYmUb30jx1eI46/QioRpx5zkOBcA3TTb7kkRyEneQba96xjB5ZSb40TFEsbZQdVtfBDiBagbQfyqmDVwNyVp7W8Ht1xVs2zJJaCT8UGwFpdFSW1X3d4YRPLf2s8nJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4e86fb603so7730305ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 02:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730366187; x=1730970987;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXoBmUUVf1tfIrgN9JNLHUGFhndx6gx1VWgsxlvC1hA=;
        b=e5MjLvPWtFfbJlnkYUdHAQuRiEkFGy8XtVcaWYo4qPErF3LDHFlLVz7iX1pGQWrJvr
         arhqgi1OvsD0V4icNRQwqHvPoLAY4YrV6YINws3GficcxHmh8x9RInbDe5+IHrXyQIuP
         upl9ajxhk1ooBg8OqUzxJ6ySqRZCoHFuY8jlwrtT+fD75L0UuKUxgSLSRWVHipzG4wmt
         B/GBwI2qJQiwV4tr1BSljT712oiUR//FxwRDruMmAp0cGhdnCTcyzZJOX/cNbzllIySi
         qrPu0CsO91nlDKxhb6EIOezn+G64tUAqv2VLo7xSNNNpz3hxl+TneKUkSfnAUbSN8gO5
         AtUA==
X-Forwarded-Encrypted: i=1; AJvYcCX0ySlehr6JZyMrUFmokZY0bde4aoVLaLxsxoH4aErUom1UpU/HD6K2wK6Xx/HreHO1suIHiBYEg8nQ4IxM@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkNRaOsnQLZw03lcJ+Ocy79fddMJt3zhWzwlTojcAQm09jRc0
	3qrDX6VSvop/5QJ9aHWxiemxRUfs3e+feW+dwrtPvP7nfwPa1NhFyMIfSAKNkUw1Rtz1/YMBrou
	qgzXU5ZgOezzpdoWK+f/j6bMnR9gKpbfdTVvMW2oi8jYzSr3K5tLlAPA=
X-Google-Smtp-Source: AGHT+IHL5f6Dpxfjkmjo3kTHo5z3ZPkDpNRDnKB6eZcJsj52EEkOTT7p7Ecre42A9KZTl+iz5r+M2HEgXUM5F121sWlSdWd7I7Wx
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216b:b0:3a3:b559:5b92 with SMTP id
 e9e14a558f8ab-3a4ed296f90mr197425345ab.14.1730366187299; Thu, 31 Oct 2024
 02:16:27 -0700 (PDT)
Date: Thu, 31 Oct 2024 02:16:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67234aeb.050a0220.35b515.015a.GAE@google.com>
Subject: [syzbot] [exfat?] KMSAN: kernel-infoleak in pipe_read
From: syzbot <syzbot+41ebd857f013384237a9@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4236f913808c Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160252a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d4311df74eee96f
dashboard link: https://syzkaller.appspot.com/bug?extid=41ebd857f013384237a9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ed9540580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/51b1dad228c5/disk-4236f913.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a7ef646b195/vmlinux-4236f913.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5231f6873f58/bzImage-4236f913.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/30f3d2299c08/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41ebd857f013384237a9@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:30 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:300 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:328 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x2f3/0x2b30 lib/iov_iter.c:185
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_ubuf include/linux/iov_iter.h:30 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:300 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 _copy_to_iter+0x2f3/0x2b30 lib/iov_iter.c:185
 copy_page_to_iter+0x419/0x880 lib/iov_iter.c:362
 pipe_read+0x88c/0x21a0 fs/pipe.c:327
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0xcdf/0xf50 fs/read_write.c:569
 ksys_read+0x24f/0x4c0 fs/read_write.c:712
 __do_sys_read fs/read_write.c:722 [inline]
 __se_sys_read fs/read_write.c:720 [inline]
 __x64_sys_read+0x93/0xe0 fs/read_write.c:720
 x64_sys_call+0x3055/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:1
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 memcpy_to_iter lib/iov_iter.c:65 [inline]
 iterate_bvec include/linux/iov_iter.h:123 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 _copy_to_iter+0xe5a/0x2b30 lib/iov_iter.c:185
 copy_page_to_iter+0x419/0x880 lib/iov_iter.c:362
 shmem_file_read_iter+0xa09/0x12b0 mm/shmem.c:3164
 do_iter_readv_writev+0x88a/0xa30
 vfs_iter_read+0x278/0x760 fs/read_write.c:923
 lo_read_simple drivers/block/loop.c:283 [inline]
 do_req_filebacked drivers/block/loop.c:516 [inline]
 loop_handle_cmd drivers/block/loop.c:1910 [inline]
 loop_process_work+0x20fc/0x3750 drivers/block/loop.c:1945
 loop_workfn+0x48/0x60 drivers/block/loop.c:1969
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_bvec include/linux/iov_iter.h:123 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 copy_page_from_iter_atomic+0x1299/0x30c0 lib/iov_iter.c:481
 copy_folio_from_iter_atomic include/linux/uio.h:201 [inline]
 generic_perform_write+0x8d1/0x1080 mm/filemap.c:4066
 shmem_file_write_iter+0x2ba/0x2f0 mm/shmem.c:3218
 do_iter_readv_writev+0x88a/0xa30
 vfs_iter_write+0x44d/0xd40 fs/read_write.c:988
 lo_write_bvec drivers/block/loop.c:243 [inline]
 lo_write_simple drivers/block/loop.c:264 [inline]
 do_req_filebacked drivers/block/loop.c:511 [inline]
 loop_handle_cmd drivers/block/loop.c:1910 [inline]
 loop_process_work+0x15e6/0x3750 drivers/block/loop.c:1945
 loop_workfn+0x48/0x60 drivers/block/loop.c:1969
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4756
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1010
 __filemap_get_folio+0xac4/0x1550 mm/filemap.c:1952
 block_write_begin+0x6e/0x2b0 fs/buffer.c:2226
 exfat_write_begin+0xfb/0x400 fs/exfat/inode.c:434
 exfat_extend_valid_size fs/exfat/file.c:553 [inline]
 exfat_file_write_iter+0x474/0xfb0 fs/exfat/file.c:588
 do_iter_readv_writev+0x88a/0xa30
 vfs_writev+0x56a/0x14f0 fs/read_write.c:1064
 do_pwritev fs/read_write.c:1165 [inline]
 __do_sys_pwritev2 fs/read_write.c:1224 [inline]
 __se_sys_pwritev2+0x280/0x470 fs/read_write.c:1215
 __x64_sys_pwritev2+0x11f/0x1a0 fs/read_write.c:1215
 x64_sys_call+0x2edb/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:329
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 0-1023 of 1024 are uninitialized
Memory access of size 1024 starts at ffff88801d942400
Data copied to user address 0000555560b53ba0

CPU: 1 UID: 0 PID: 5798 Comm: syz-executor Not tainted 6.12.0-rc5-syzkaller-00047-g4236f913808c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


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

