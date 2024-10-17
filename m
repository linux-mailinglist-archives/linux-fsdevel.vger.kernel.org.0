Return-Path: <linux-fsdevel+bounces-32183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A59A1F86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 12:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DA81F27FFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 10:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7421DA618;
	Thu, 17 Oct 2024 10:11:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4521D9665
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159866; cv=none; b=U1phNKWM2SWfT+bUDbKC6mHyVulDF6eMaC/cVtR6TSyRSPq0ihQ0vqMg516CGTOaRLulIG/zDXVC294kr+cDsu/MN/kevauxJmsUK5xM4qOvgvPHqKzs18lIbWDMy9owoWZFwJ0CWbrwdz9lUvA1jGFcIhmWU6V5cMH16Q/dRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159866; c=relaxed/simple;
	bh=iuYmvJgF15YExjzwdkzqIiKIbBQ8Gp11W+K8Lb8mNWs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oeEUSZaDCMJfIcwE9OMHriPyLKy2PF7l8YhGov9AHfv8xYKCFFVE8uCJodcn6jbQMxS1mvKE3DDMBhWtiNIHMGusShAtF1P5G5tnmwfLeNs6S/7dWnS+rImSZRJiLb9mHfcg8QwNCOpocb4QqWVlPL8dIZCgB1fT26MCRV3qPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3ae775193so8414675ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 03:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729159862; x=1729764662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Whp6+MTaFW0tvVxMkmr3RbvLDJ9nvd1vmB5cbDS7Rgc=;
        b=UapmMIfwkM6z4BESAJX2s598S/SZ/PGE0BfS+A0mwjR9Eeq9T082BXf51YJZNGjpUs
         MuL4RiIJYQr6O5UiLQgQ3EmPtTQmbxmG2jpINvLmEhjWxP2dzUkVEFXpCvYrOXO9Ymd0
         KJqkXpwJUZaO8LGkgokK08TrpfDJCREjACA3F1IqmV/WbMPWCMCRdC6z7TZsTcuaGNlh
         YyGrOimRzJGNSzwiymX2tQvPa2lkIS4ocOoSCecUixXiu9moCbNAw3HFITu/keG9bqTD
         0FwM+aMVej5aXxubzgeeZmowmPaHm5z/9L5y/8Yn3yvRmHGRcvz5L6HDSQvvkvdNE4FQ
         1esA==
X-Forwarded-Encrypted: i=1; AJvYcCVYAOEZPCVDA5BeJpwilvWgbyHmWSFcajneBGcoGrt1PA28bp62bKCJheK16NegYtyfrN0OAK1aVmDh6iSs@vger.kernel.org
X-Gm-Message-State: AOJu0YyUOUJP2fZgIrqPaIZwqHvs5IEU3P3Nbn+mnbbw8Wrv48Re7xtm
	A1G03RTzE5lzRhaWTdRojBhxH3vqsBce3AuMBxc1p/R7qymsJAxXhAS91WZv4E0Pk3qtVPuHhM0
	neeIl4pTmiJJ+BpoWZd121g7OEx6DZ/MdyqS2E8o1kFeDFqX6d6ofr54=
X-Google-Smtp-Source: AGHT+IFa3x4q0FVm/rFcrbKk3msIyKyxouLqcmyBRDL1zu78XFZ5+M/Ef0xldwW8+zMcyhqByLkm67R0fSVva/nakglF372ciGHP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2167:b0:3a3:983a:874f with SMTP id
 e9e14a558f8ab-3a3bcdc6bfamr166934485ab.12.1729159862225; Thu, 17 Oct 2024
 03:11:02 -0700 (PDT)
Date: Thu, 17 Oct 2024 03:11:02 -0700
In-Reply-To: <PUZPR04MB6316617EE9168BBA47A4810181472@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6710e2b6.050a0220.d5849.0027.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
From: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in __exfat_get_dentry_set

loop0: detected capacity change from 0 to 256
exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0x726052d3, utbl_chksum : 0xe619d30d)
=====================================================
BUG: KMSAN: uninit-value in __exfat_get_dentry_set+0x10ca/0x14d0 fs/exfat/dir.c:804
 __exfat_get_dentry_set+0x10ca/0x14d0 fs/exfat/dir.c:804
 exfat_get_dentry_set+0x58/0xec0 fs/exfat/dir.c:859
 __exfat_write_inode+0x3c1/0xe30 fs/exfat/inode.c:46
 exfat_write_inode+0x15f/0x250 fs/exfat/inode.c:109
 write_inode fs/fs-writeback.c:1503 [inline]
 __writeback_single_inode+0x8da/0x1290 fs/fs-writeback.c:1723
 writeback_single_inode+0x32f/0x9c0 fs/fs-writeback.c:1779
 sync_inode_metadata+0xa4/0xe0 fs/fs-writeback.c:2849
 exfat_truncate+0x839/0xd00 fs/exfat/file.c:212
 exfat_write_failed fs/exfat/inode.c:421 [inline]
 exfat_direct_IO+0x5ae/0x910 fs/exfat/inode.c:485
 generic_file_direct_write+0x275/0x6a0 mm/filemap.c:3977
 __generic_file_write_iter+0x242/0x460 mm/filemap.c:4141
 exfat_file_write_iter+0x894/0xfb0 fs/exfat/file.c:576
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

Uninit was stored to memory at:
 memcpy_to_iter lib/iov_iter.c:65 [inline]
 iterate_bvec include/linux/iov_iter.h:123 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 _copy_to_iter+0xe53/0x2b30 lib/iov_iter.c:185
 copy_page_to_iter+0x419/0x880 lib/iov_iter.c:362
 shmem_file_read_iter+0xa09/0x12b0 mm/shmem.c:3167
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
 copy_page_from_iter_atomic+0x12b7/0x3100 lib/iov_iter.c:481
 copy_folio_from_iter_atomic include/linux/uio.h:201 [inline]
 generic_perform_write+0x8d1/0x1080 mm/filemap.c:4066
 shmem_file_write_iter+0x2ba/0x2f0 mm/shmem.c:3221
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
 exfat_write_begin+0xfb/0x410 fs/exfat/inode.c:434
 exfat_extend_valid_size fs/exfat/file.c:531 [inline]
 exfat_file_write_iter+0x474/0xfb0 fs/exfat/file.c:566
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

CPU: 1 UID: 0 PID: 5994 Comm: syz.0.15 Not tainted 6.12.0-rc3-syzkaller-gc964ced77262-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


Tested on:

commit:         c964ced7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ab745f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5242e0e980477c72
dashboard link: https://syzkaller.appspot.com/bug?extid=01218003be74b5e1213a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1615e830580000


