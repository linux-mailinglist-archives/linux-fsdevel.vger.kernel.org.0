Return-Path: <linux-fsdevel+bounces-17364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B22E8AC1FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 01:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709821C20B3E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Apr 2024 23:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1870345974;
	Sun, 21 Apr 2024 23:11:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473FF3CF40
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Apr 2024 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713741082; cv=none; b=C9h/iuKcznOsGk0zAOFb1xhe6EWfFXpbFkis9NaYyN2faJB8RmxTI7eXLCz+aWGm7mCTOFf3WaBc4s+v8xF/L7e2QhcwYroZgh+p7ZxFjMJPuakUy8cb6ZuRdaQzaPgJCiSz+ffLln4/XpEZJcHRBgT2uajW+MNr+EN9ZhMSg54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713741082; c=relaxed/simple;
	bh=KeJ/hkv/ADmBtwjyRjiC8mPob6I7p2+aO0XnhEs5+J4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EG/qbCXpDyNlh2sCaD2nlVRYSD/v9ce9bz6hNzUePgEJwJPWUSKlRKd3iRgYgWJiMyUcfAUaB6BY17xud4UbnRERkKgTxeVgd0/e0xX+gXVIbxSD9uCjzDAuLj9PG4Cdc5Dsw2+xDG0zxWShiLPLur1l/lzkQLBjqnZIJqkS3lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d667dd202cso471128839f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Apr 2024 16:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713741080; x=1714345880;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1vHar25Ogd48V75kwe5mhigjdoQz3FAHOecQmxlZ0I=;
        b=PgfULS2haEpRo3PgV4fOfzuQ3NIkUmalSYFCPpzMBXFtNUuoolqAagAHSaVecCgZQH
         7e0JbnmScz4ggeEmVjCxXOq/+yPYnFch5JVD2EUEAul7ibUzbGgrnzhRAgKrH14jQTxo
         SbXWyCnV8Lpo/w+5DMpbpM4m8BjcF8wgXFoFWDzHk5gRi3789JWRyOt0ClHgUVQUu0RF
         ITke4BV2mCmW00/iiuvyYAOozZPHX2nXjLMqvb2QD5q+LoEJckJMUbyozlOGcB90wimV
         98n3FdZ5/lfbGoHDBqJheNg30jhIIt7ei7Zr0AfyT5eBX1GD1v8OS+Ss02EWS3wDAoAU
         zchQ==
X-Forwarded-Encrypted: i=1; AJvYcCXegJ6/PLJrbVkDtx8UFOQe9c6bWCv/FkUb45ITEoR9+lf+yHZ0gWELn1PZlX0PyXNbFnuN5vQPx2t7eeJvR7L7zvLujyD9F2FgRxYJDQ==
X-Gm-Message-State: AOJu0YxZUwBEKIrLsPtXOmn48rzYcpFiRo9/7LvRfR7TFFKNQQHgnwCI
	LFEHrbIB56sV8YWVyJncYDajtfhZ1M64zPdpw8P0QAVwZ5USCTgNwoUseSyhHTq3ubnohHLLMFl
	XTQ2zJIYPIHzXzQCZZ4vMiaVOGwVKyZp8/iB8mo/yFYKNq280cBbXydk=
X-Google-Smtp-Source: AGHT+IFoRple7mPFvEEIYfSJNcuZ8oYmhOVat8p2dm1OioF5nSrzhC29oYHAjczu9whuWLy4Eb0hG72BktFHTiCtlpxQAMc/MVRf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8928:b0:484:e632:5b8c with SMTP id
 jc40-20020a056638892800b00484e6325b8cmr429557jab.3.1713741079704; Sun, 21 Apr
 2024 16:11:19 -0700 (PDT)
Date: Sun, 21 Apr 2024 16:11:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b08ca0616a37065@google.com>
Subject: [syzbot] [gfs2?] KMSAN: uninit-value in inode_go_dump (4)
From: syzbot <syzbot+bec528924d6c98923e5d@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    96fca68c4fbf Merge tag 'nfsd-6.9-3' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104a186f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=bec528924d6c98923e5d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e9cf2979b8c2/disk-96fca68c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8c31261f0d8c/vmlinux-96fca68c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/86f7ecfba229/bzImage-96fca68c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bec528924d6c98923e5d@syzkaller.appspotmail.com

gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: fatal: filesystem consistency error
  inode = 3 2074
  function = gfs2_dinode_in, file = fs/gfs2/glops.c, line = 470
gfs2: fsid=syz:syz.0: G:  s:SH n:2/81a f:qobnN t:SH d:EX/0 a:0 v:0 r:3 m:20 p:1
gfs2: fsid=syz:syz.0:  H: s:SH f:H e:0 p:20593 [syz-executor.0] init_inodes+0x125/0x510 fs/gfs2/ops_fstype.c:884
=====================================================
BUG: KMSAN: uninit-value in inode_go_dump+0x475/0x4b0 fs/gfs2/glops.c:549
 inode_go_dump+0x475/0x4b0 fs/gfs2/glops.c:549
 gfs2_dump_glock+0x221c/0x2340 fs/gfs2/glock.c:2410
 gfs2_consist_inode_i+0x19f/0x230 fs/gfs2/util.c:456
 gfs2_dinode_in fs/gfs2/glops.c:470 [inline]
 gfs2_inode_refresh+0x12c7/0x1560 fs/gfs2/glops.c:490
 inode_go_instantiate+0x6e/0xc0 fs/gfs2/glops.c:509
 gfs2_instantiate+0x272/0x4c0 fs/gfs2/glock.c:454
 gfs2_glock_holder_ready fs/gfs2/glock.c:1336 [inline]
 gfs2_glock_wait+0x2a4/0x3e0 fs/gfs2/glock.c:1356
 gfs2_glock_nq+0x288b/0x3a20 fs/gfs2/glock.c:1616
 gfs2_glock_nq_init fs/gfs2/glock.h:238 [inline]
 gfs2_jindex_hold fs/gfs2/ops_fstype.c:580 [inline]
 init_journal+0x315/0x3a40 fs/gfs2/ops_fstype.c:749
 init_inodes+0x125/0x510 fs/gfs2/ops_fstype.c:884
 gfs2_fill_super+0x3c15/0x42b0 fs/gfs2/ops_fstype.c:1263
 get_tree_bdev+0x681/0x890 fs/super.c:1614
 gfs2_get_tree+0x5c/0x340 fs/gfs2/ops_fstype.c:1341
 vfs_get_tree+0xa7/0x570 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:3875
 ia32_sys_call+0x3a9a/0x40a0 arch/x86/include/generated/asm/syscalls_32.h:22
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb4/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc_lru+0x6d7/0xbe0 mm/slub.c:3864
 alloc_inode_sb include/linux/fs.h:3091 [inline]
 gfs2_alloc_inode+0x66/0x210 fs/gfs2/super.c:1537
 alloc_inode+0x86/0x460 fs/inode.c:261
 iget5_locked+0xa9/0x210 fs/inode.c:1235
 gfs2_inode_lookup+0xbe/0x1450 fs/gfs2/inode.c:124
 gfs2_lookup_root fs/gfs2/ops_fstype.c:460 [inline]
 init_sb+0xe63/0x1880 fs/gfs2/ops_fstype.c:527
 gfs2_fill_super+0x3288/0x42b0 fs/gfs2/ops_fstype.c:1230
 get_tree_bdev+0x681/0x890 fs/super.c:1614
 gfs2_get_tree+0x5c/0x340 fs/gfs2/ops_fstype.c:1341
 vfs_get_tree+0xa7/0x570 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:3875
 ia32_sys_call+0x3a9a/0x40a0 arch/x86/include/generated/asm/syscalls_32.h:22
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb4/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 0 PID: 20593 Comm: syz-executor.0 Tainted: G        W          6.9.0-rc4-syzkaller-00031-g96fca68c4fbf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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

