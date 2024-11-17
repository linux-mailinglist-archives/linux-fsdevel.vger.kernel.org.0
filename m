Return-Path: <linux-fsdevel+bounces-35035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431909D0259
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 08:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D101F229AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 07:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0E5768FC;
	Sun, 17 Nov 2024 07:38:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF284204F
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Nov 2024 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731829103; cv=none; b=YR2qB13pwQALaku9rBnB6zP8gP/3AkjrQ4Q9EcG1jMXcjNAbtFzLAvXnNZGdkeRIiWXrfdPGPhRziwsOy1qkC65QnwmiHYKNrLddnfKx0igSj2uiE2qQxyaZW+nvYY56J1ss25B6em07Z8C+8T31kRT5Gjk15DmhazVK4pp3u1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731829103; c=relaxed/simple;
	bh=Bd96KkRu2mUsr86NmTv7M/pMEhNWGK4TiVGgkdw/8t4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mj560MKbmdCRiX0MUylOHTd1gknEDR/KbZgBj+uYWlnddSCmqWVoPPxFulxQWkSHLM7lgmSV/0oNcyy5imKdWxaxYpexbqvAlyy6Zg6Ee+NJ+RFXtnvAzNs/SXV0vioTRPgRD16Ozlvb5xxvOvGjJGNUL1vuTYX0QEytye2dxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abad6594fso245315739f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Nov 2024 23:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731829100; x=1732433900;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKKKIlj9Kh23bXoEQoDxs5NVCMYSors2CPzf2eGf3E4=;
        b=HrYbG1VMw57rqwM0E/J+Ui8ux4yaSAUheB9d17AowFN+REN61jk36MP/3zBVWYkghi
         jsyWJ2xxO0G2ICFDvJHtlkf/WwoO25PVIg+XtM4zQKOmTNWeGa+Y90DCBi4zhbWWLUTT
         HRFEGuf+nogLQNREp7g9BtpDwwcDZzowKbD0l/i10J1kIPaQFchtcDQcukC73KPEAiG6
         kM+Q9nS9KzZZH3w2aFOaWgZlt1mI9yOvSC65GufQu9DgSBByiyEZrwo/EZan91kZr1z+
         YEdGEyypoCQLPDq4qr+3C3sCApsxg0cOnygSwdqhDYA0Qnm0xD2/eKrKeLKwKLPMOaPG
         zZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+OqlMJoycygX7G0EXizTI0mGsqMhCg/jTEKd58npALH/6TCrBfjFlUFhIIMu78EX71wdjvfsuNV4b499v@vger.kernel.org
X-Gm-Message-State: AOJu0YzbH6fzVDlV9hNjKDHD+OpYVDNsPTzcHUIXbi0ZL76+HBUs5OoW
	eHoDe5F8/l3LQNp8CgPliHdlqcwe9wFkneb2H4A1KXR4gyo3klYDeChtT8aoYMV44mQiknTXX7p
	xzN8aFGn5LZw639EKj5EHwrbT009V/KJZYP4RpsERGE6j0rpYkBPJh/Q=
X-Google-Smtp-Source: AGHT+IE6sRALUW4ufN5B5EC5tkFPRX66B2RVZsnR0hh9k2M6Cd8AUt/4xUl3cK6M7fDNd710Bn7JpL99wFi5YXpUK7GqbCcsK8OV
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:3a6:ac4e:2659 with SMTP id
 e9e14a558f8ab-3a74800f183mr93069895ab.6.1731829100606; Sat, 16 Nov 2024
 23:38:20 -0800 (PST)
Date: Sat, 16 Nov 2024 23:38:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67399d6c.050a0220.87769.0005.GAE@google.com>
Subject: [syzbot] [exfat?] KMSAN: uninit-value in exfat_iterate
From: syzbot <syzbot+84345a1b4057358168d9@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3022e9d00ebe Merge tag 'sched_ext-for-6.12-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=177941a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcca673786a14715
dashboard link: https://syzkaller.appspot.com/bug?extid=84345a1b4057358168d9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/937339c4ba17/disk-3022e9d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/23acd73c301b/vmlinux-3022e9d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66d14471611f/bzImage-3022e9d0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84345a1b4057358168d9@syzkaller.appspotmail.com

exFAT-fs (loop1): failed to load upcase table (idx : 0x0001e4a3, chksum : 0x009ea0b8, utbl_chksum : 0x7319d30d)
=====================================================
BUG: KMSAN: uninit-value in exfat_get_entry_type fs/exfat/dir.c:348 [inline]
BUG: KMSAN: uninit-value in exfat_readdir fs/exfat/dir.c:125 [inline]
BUG: KMSAN: uninit-value in exfat_iterate+0x1346/0x3f90 fs/exfat/dir.c:261
 exfat_get_entry_type fs/exfat/dir.c:348 [inline]
 exfat_readdir fs/exfat/dir.c:125 [inline]
 exfat_iterate+0x1346/0x3f90 fs/exfat/dir.c:261
 wrap_directory_iterator+0xf3/0x190 fs/readdir.c:65
 shared_exfat_iterate+0x3c/0x50 fs/exfat/dir.c:309
 iterate_dir+0x5b3/0x9e0 fs/readdir.c:108
 __do_compat_sys_getdents fs/readdir.c:575 [inline]
 __se_compat_sys_getdents+0x171/0x550 fs/readdir.c:560
 __ia32_compat_sys_getdents+0x93/0xe0 fs/readdir.c:560
 ia32_sys_call+0x12f8/0x40d0 arch/x86/include/generated/asm/syscalls_32.h:142
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was stored to memory at:
 memcpy_to_iter lib/iov_iter.c:65 [inline]
 iterate_bvec include/linux/iov_iter.h:123 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 _copy_to_iter+0xe5a/0x2b30 lib/iov_iter.c:185
 copy_page_to_iter+0x419/0x880 lib/iov_iter.c:362
 shmem_file_read_iter+0xa09/0x12b0 mm/shmem.c:3161
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
 copy_page_from_iter_atomic+0x1299/0x30c0 lib/iov_iter.c:483
 copy_folio_from_iter_atomic include/linux/uio.h:201 [inline]
 generic_perform_write+0x8d1/0x1080 mm/filemap.c:4066
 shmem_file_write_iter+0x2ba/0x2f0 mm/shmem.c:3215
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
 __alloc_pages_noprof+0x9a7/0xe00 mm/page_alloc.c:4758
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
 __do_compat_sys_pwritev2 fs/read_write.c:1311 [inline]
 __se_compat_sys_pwritev2+0x2a8/0x490 fs/read_write.c:1303
 __ia32_compat_sys_pwritev2+0x11d/0x1a0 fs/read_write.c:1303
 ia32_sys_call+0x2f06/0x40d0 arch/x86/include/generated/asm/syscalls_32.h:380
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 1 UID: 0 PID: 6646 Comm: syz.1.260 Not tainted 6.12.0-rc7-syzkaller-00012-g3022e9d00ebe #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
=====================================================


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

