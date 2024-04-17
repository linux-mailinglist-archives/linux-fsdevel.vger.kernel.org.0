Return-Path: <linux-fsdevel+bounces-17109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AF78A7EE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 10:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CF11C213B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D639513C9A0;
	Wed, 17 Apr 2024 08:55:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E34131BD3
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344119; cv=none; b=g5u3sajXHYNcw43EVRHxuVZQCF9CMfwGktrp7IveLrSLFJ+ZPLpNAu18jcv9rTshmyX9ajtrYDiVTu8fnIUJN8FHcN3Z2eJPEmffk1f7VPXxIJeMv7Fs9k1emKcL0/IkyoLN8/AOjmtsXeuAMckVPSgpEXAELBDqiiAtw6INpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344119; c=relaxed/simple;
	bh=H57y7Y7SnlHSeuSUqZhBHFGHI8cMySAbnqmyq0S06Ng=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VBvP/OiqJrMa1JUyMjv8b1WaPs66ybDc4CQhtbcY8eJH56rkRXThCzpUMjlHgodQ5xQAuKfwnW+4LE702pERxMBAasB85LV7j8sGD6JUYD3aKa4ROJKJhDCIXVblrl4zT52yKkbdmd4bIYofD+pu0QO1Ph9n10TwpFxQHEFboEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc764c885bso642977439f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 01:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344117; x=1713948917;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zh1HrmkMpxkFxJvtc6D3gSemQqObtNz2dVEHVmtIHrA=;
        b=O9Kx3czWKRrtk2Wa3GruaYkWZyV4MhYlS9s/3ffYQeYoLZlhGka9/BWflaGo252NMC
         dTNLIxGSxdrueeBkRut5YvFcILSmErFNh0aZfhtFhVvyGGS8FG3JZH4uKVKg9azqg9Gd
         svt4zp3ycW0W4ptem9Y3JCz7bIozXPqq/avQTtz871oEH6R5pCfP9pNEjVKM97rNV+EQ
         MoI7gf950/jukqP9PfKxH9p21/5KVBBVql4sMGqlA8fak6/4xJeqG4UQwTecS1oAEwLh
         kxXNViWSUz7oNkfZOglrhdAgA5OBnJ96SHa5xKGU7C5t/kS1rzLcJHUEvqsFJ8blSKW6
         67Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUvchRvBLWKTtmb16fA0QtENn7xXNordFcz9YE9DivKN1QvaRfgPddcs+V9riCoZKYW0EolRFPKAFXOEkdBDwv5AR9P4FdX6tPX4qRFVA==
X-Gm-Message-State: AOJu0YyDlPuyjN9F7meAGrzRkIKfK1Opjv2d6kJg7mqH0BDNmauN4FKW
	L0jFn45E5ft0HZU/rvCaXBSXnVPWT+LO4sYeyXmbVfpUW2s1LBgwpUFC580XIeJi0ao1AGcAU6M
	Ol2vha0aZXygtTe+LKo188+fgoSdSbWI+XeYI/bA4KutnYmpgFBMj+Yg=
X-Google-Smtp-Source: AGHT+IF/9ofp2ga6ea7Pm+pvk/+Urt7/h+0S2w+bfsKAYoQCWa5yhnc+eou4k2du+7yaWbUUDLDcDY5fvOCS1gtdAPZ35jfhWPOh
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411c:b0:482:f1bb:d927 with SMTP id
 ay28-20020a056638411c00b00482f1bbd927mr608210jab.3.1713344117000; Wed, 17 Apr
 2024 01:55:17 -0700 (PDT)
Date: Wed, 17 Apr 2024 01:55:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078df8c061647039e@google.com>
Subject: [syzbot] [jffs2?] possible deadlock in jffs2_read_folio
From: syzbot <syzbot+7cab786a93f00e566e5b@syzkaller.appspotmail.com>
To: dwmw2@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b5d2afe8745b Merge branches 'for-next/kbuild', 'for-next/m..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1321c40b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=560f5db1d0b3f6d0
dashboard link: https://syzkaller.appspot.com/bug?extid=7cab786a93f00e566e5b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/50bff35e1638/disk-b5d2afe8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4eeaa73e7ed1/vmlinux-b5d2afe8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e796b089aa9/Image-b5d2afe8.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7cab786a93f00e566e5b@syzkaller.appspotmail.com

jffs2: notice: (9998) jffs2_build_xattr_subsystem: complete building xattr subsystem, 1 of xdatum (0 unchecked, 0 orphan) and 2 of xref (0 dead, 0 orphan) found.
======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc3-syzkaller-gb5d2afe8745b #0 Not tainted
------------------------------------------------------
syz-executor.4/9998 is trying to acquire lock:
ffff0000efee8c18 (&f->sem){+.+.}-{3:3}, at: jffs2_read_folio+0x6c/0xd0 fs/jffs2/file.c:125

but task is already holding lock:
ffff0000efee8f68 (mapping.invalidate_lock#11){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:850 [inline]
ffff0000efee8f68 (mapping.invalidate_lock#11){.+.+}-{3:3}, at: filemap_fault+0x6b4/0x1004 mm/filemap.c:3296

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (mapping.invalidate_lock#11){.+.+}-{3:3}:
       down_read+0x58/0x2fc kernel/locking/rwsem.c:1526
       filemap_invalidate_lock_shared include/linux/fs.h:850 [inline]
       filemap_fault+0x6b4/0x1004 mm/filemap.c:3296
       __do_fault+0x11c/0x374 mm/memory.c:4531
       do_read_fault mm/memory.c:4894 [inline]
       do_fault mm/memory.c:5024 [inline]
       do_pte_missing mm/memory.c:3880 [inline]
       handle_pte_fault mm/memory.c:5300 [inline]
       __handle_mm_fault+0x36d0/0x5920 mm/memory.c:5441
       handle_mm_fault+0x1e8/0x63c mm/memory.c:5606
       __do_page_fault arch/arm64/mm/fault.c:505 [inline]
       do_page_fault+0x550/0xaec arch/arm64/mm/fault.c:620
       do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.c:704
       do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:840
       el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:432
       el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:492
       el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:593
       __arch_copy_from_user+0xb8/0x230 arch/arm64/lib/copy_template.S:110
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:904 [inline]
       __se_sys_ioctl fs/ioctl.c:890 [inline]
       __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:890
       __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       __might_fault+0xc4/0x124 mm/memory.c:6220
       filldir64+0x2d4/0x948 fs/readdir.c:375
       dir_emit include/linux/fs.h:3570 [inline]
       jffs2_readdir+0x314/0x42c fs/jffs2/dir.c:152
       iterate_dir+0x3f8/0x580 fs/readdir.c:110
       __do_sys_getdents64 fs/readdir.c:409 [inline]
       __se_sys_getdents64 fs/readdir.c:394 [inline]
       __arm64_sys_getdents64+0x1c4/0x4a0 fs/readdir.c:394
       __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #0 (&f->sem){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
       lock_acquire+0x248/0x73c kernel/locking/lockdep.c:5754
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
       __mutex_lock kernel/locking/mutex.c:752 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
       jffs2_read_folio+0x6c/0xd0 fs/jffs2/file.c:125
       filemap_read_folio+0x14c/0x39c mm/filemap.c:2331
       filemap_fault+0xab8/0x1004 mm/filemap.c:3381
       __do_fault+0x11c/0x374 mm/memory.c:4531
       do_read_fault mm/memory.c:4894 [inline]
       do_fault mm/memory.c:5024 [inline]
       do_pte_missing mm/memory.c:3880 [inline]
       handle_pte_fault mm/memory.c:5300 [inline]
       __handle_mm_fault+0x36d0/0x5920 mm/memory.c:5441
       handle_mm_fault+0x1e8/0x63c mm/memory.c:5606
       __do_page_fault arch/arm64/mm/fault.c:505 [inline]
       do_page_fault+0x550/0xaec arch/arm64/mm/fault.c:620
       do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.c:704
       do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:840
       el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:432
       el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:492
       el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:593
       __arch_copy_from_user+0xb8/0x230 arch/arm64/lib/copy_template.S:110
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:904 [inline]
       __se_sys_ioctl fs/ioctl.c:890 [inline]
       __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:890
       __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

other info that might help us debug this:

Chain exists of:
  &f->sem --> &mm->mmap_lock --> mapping.invalidate_lock#11

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(mapping.invalidate_lock#11);
                               lock(&mm->mmap_lock);
                               lock(mapping.invalidate_lock#11);
  lock(&f->sem);

 *** DEADLOCK ***

2 locks held by syz-executor.4/9998:
 #0: ffff0000cd860190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #0: ffff0000cd860190 (&dev->mutex){....}-{3:3}, at: usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 #0: ffff0000cd860190 (&dev->mutex){....}-{3:3}, at: usbdev_ioctl+0x24c/0x66e0 drivers/usb/core/devio.c:2824
 #1: ffff0000efee8f68 (mapping.invalidate_lock#11){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:850 [inline]
 #1: ffff0000efee8f68 (mapping.invalidate_lock#11){.+.+}-{3:3}, at: filemap_fault+0x6b4/0x1004 mm/filemap.c:3296

stack backtrace:
CPU: 1 PID: 9998 Comm: syz-executor.4 Not tainted 6.9.0-rc3-syzkaller-gb5d2afe8745b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 dump_stack+0x1c/0x28 lib/dump_stack.c:123
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2060
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
 lock_acquire+0x248/0x73c kernel/locking/lockdep.c:5754
 __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
 __mutex_lock kernel/locking/mutex.c:752 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
 jffs2_read_folio+0x6c/0xd0 fs/jffs2/file.c:125
 filemap_read_folio+0x14c/0x39c mm/filemap.c:2331
 filemap_fault+0xab8/0x1004 mm/filemap.c:3381
 __do_fault+0x11c/0x374 mm/memory.c:4531
 do_read_fault mm/memory.c:4894 [inline]
 do_fault mm/memory.c:5024 [inline]
 do_pte_missing mm/memory.c:3880 [inline]
 handle_pte_fault mm/memory.c:5300 [inline]
 __handle_mm_fault+0x36d0/0x5920 mm/memory.c:5441
 handle_mm_fault+0x1e8/0x63c mm/memory.c:5606
 __do_page_fault arch/arm64/mm/fault.c:505 [inline]
 do_page_fault+0x550/0xaec arch/arm64/mm/fault.c:620
 do_translation_fault+0xc4/0x114 arch/arm64/mm/fault.c:704
 do_mem_abort+0x74/0x200 arch/arm64/mm/fault.c:840
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:432
 el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:492
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:593
 __arch_copy_from_user+0xb8/0x230 arch/arm64/lib/copy_template.S:110
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:890
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598


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

