Return-Path: <linux-fsdevel+bounces-31853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8074A99C1FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B203C1C25237
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 07:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A52014B95A;
	Mon, 14 Oct 2024 07:51:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2563214A4C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892267; cv=none; b=YhQNUnIp/gDPHfaeUQcgwZGkJvxzx8TPv/R00OWrG5p0GdF0ivUwRK48Z8RCWB0F4XS2Ja18T3gr4Xbzvn22m0Xr3EllS6wyOkqOkiUdIA05PrRTLYFh9Ih6W3d6uA0A4fBnB85763gKjdxxjTvL3uB6TksQs3dId67QvXf24zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892267; c=relaxed/simple;
	bh=h6XOjTLx9GsAYP2TTG7DhV+WzeICO4DTeGOEauKII/w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JZDP7rlsx8Y/Fj/lPHjdCp2u5UwA4/erD8FIEDtkEv0PDgLrVl21SfDSmlvc0XAwLGNOjBle9MFp+MpuwW4JYz0N4UGBMm2RYcBnIOc2vex4lwi8oxfQl0SLnCMRE/nfKH0ItCMTdcuYAGlilrT/pWYuFnAwUfVj9R8jleEl0+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so5587875ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 00:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892265; x=1729497065;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIjMjQapyboG58LGKBDpfcy0mY53NBlv+GOrbJsFKvg=;
        b=OsOUATKtS9X8zypItiSeG358lDg4ejBE7M9ijGHnW+OgAU/NN57HEKB7Z/F62KDMLa
         hqHx5PgekYyPo1acCwUtkLlRPX3J0+BLaIQ47zozF/+SXTkkoNxSRUkGHSTeXgEvgVBz
         S9oa/EDVMzrPcXdVzuhJXVV0mEjobzKmsLUCLb0wtct4sN8b7B5RyxkMb2vZHNfUmzhk
         CjfWGPM6H2ft7hZR76UEtBkE4raSVArT6CcfTK/fzNpAZL9HIKIzo+3wDd3tyHHYuGY2
         h2YlUssqA9Hy4mVk2rt8DC3+A0SH7mWoolp6Hz31mY19RRX2QD84Hd3UPIW/pJZAhb/T
         WV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4I9SpkpHaNJTFFU19jruZMdbv/WkUGL7JjNW/c1wZbB2TSM/F3b+U38G1wfgw/bTdP1ncCk3ixHYqmTNk@vger.kernel.org
X-Gm-Message-State: AOJu0YwgE2bd2uaRq1nyGqLDQwgTW98GNaMnxGDDxOznz5Uhz/Xff/J5
	iyzseYQ5FxdjEUeQLjMtTUagbF9VzdUJmP6ghQs0R8zY0s6Q+SxktvuX64jXjfGzcCfuS0cPFYb
	sfZx1SlVDOi4CqH7s/0MC4YABluJ9l0TBR/iLS2AgqrUfV4zlWCCG0fs=
X-Google-Smtp-Source: AGHT+IE+wOaa9Mey5x6wmJBg7zVDo8M3c8mtZRZ5QSDA9JmOzw9QepHazIGHjhr5pQUYfRB6zK8BkImUuNMjyGAm3VIHMdl2u9gS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b70d:0:b0:3a3:968b:4e3f with SMTP id
 e9e14a558f8ab-3a3bcdeeff5mr43178315ab.18.1728892265330; Mon, 14 Oct 2024
 00:51:05 -0700 (PDT)
Date: Mon, 14 Oct 2024 00:51:05 -0700
In-Reply-To: <PUZPR04MB6316D062F577B655E85385E381442@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670ccd69.050a0220.3e960.005a.GAE@google.com>
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
 __exfat_truncate+0x7f3/0xbb0 fs/exfat/file.c:211
 exfat_truncate+0xee/0x2a0 fs/exfat/file.c:257
 exfat_write_failed fs/exfat/inode.c:435 [inline]
 exfat_direct_IO+0x5a3/0x900 fs/exfat/inode.c:499
 generic_file_direct_write+0x275/0x6a0 mm/filemap.c:3977
 __generic_file_write_iter+0x242/0x460 mm/filemap.c:4141
 exfat_file_write_iter+0x894/0xfb0 fs/exfat/file.c:598
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
 exfat_write_begin+0xfb/0x400 fs/exfat/inode.c:448
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

CPU: 1 UID: 0 PID: 5987 Comm: syz.0.15 Not tainted 6.12.0-rc3-syzkaller-g6485cf5ea253-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


Tested on:

commit:         6485cf5e Merge tag 'hid-for-linus-2024101301' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1012d85f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5242e0e980477c72
dashboard link: https://syzkaller.appspot.com/bug?extid=01218003be74b5e1213a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=154ac727980000


