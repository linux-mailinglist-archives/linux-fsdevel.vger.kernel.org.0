Return-Path: <linux-fsdevel+bounces-18812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6D68BC7ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 09:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFB61C2121D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 07:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958A16BFC2;
	Mon,  6 May 2024 07:01:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D646CDBF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714978885; cv=none; b=KuPU43howymc0bGnrDHhcR9dfjE6FyrTYznkOrbfAOjmbHVHMttliw9zIFjEQZ4ceNSWQ2bEyMdiSR6Biq93briZCK9Ai+2/14kSBMM81qQ899xkZx9wVAT9iM8tmPBYgG2BLF/XeFTxYAAMvNeP4M9T76UsdUgkSrKaUwf03Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714978885; c=relaxed/simple;
	bh=ntzAHBTHzihJJQh9KHFkRcaYe+IrR8iTKx1NUJZU+vg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r20HGwd1L6jZSZfmnGU5FftE1Wc1w11fe44ELJlT238ABNsRLuX8NOq6WheFjo/MHwNccWkgx07XMhgjR5B3xZ8FSdP6cG5qLoxSftspF+37I/TKb8u6Cj+hHTrcd0DjKCsnTivzeY3YHYBjPRhwQ3HGWLuguOZdqjAWBr04GXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-36c5ed3322aso17263705ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2024 00:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714978881; x=1715583681;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFz1C31RLDJmCy8Fb6XtQ1c7k3ShK/LORjLoyX/PdIk=;
        b=EHTvwzhUTWJfpW+t4oWXYPjd9+yWNzLhDysSZfi0/DhmF8YxzQpHCktGuSzeVnuhQF
         xTaBJIVjsEtqXpvnzT7aRKyMehG8VgLptGRWfRYlR1iZA6TIPY0xXsYT4/FFXm1j09+i
         FXbrhoJV7D65ewMDWY+rGgkO6HVF8UUTbVlveD2aYetG7MCDWw75GTy7mMyeUjKlLRvq
         x65NmcNyt42lwzWExbWSG/fsY9v5Gf5m6qNIWUxPhDRgDDT7ZaSgPqVV/cJqOnI6/nUx
         3leO+vsZDSSmsdrVUOJYdiUAlnJEu1IeUTC7l3qQRMtB0MAz75NtScuEffhbz3qX1Lla
         xiKQ==
X-Gm-Message-State: AOJu0YzKGvsmHk09yTFyOKszqF4d23UdyLei3xk5TAcv4bZz8FD+BFtw
	Dfxj8hDErXFHziUjYfR6nPORsEzm4Nr1ttxBvbubjpYBCQDVpwZaddqf6Jqe7IWM7TiKuYEqPnz
	cUgkMH+gyvu8zMCyqanBxedc8fNOehhuBKwj/C7Y6SK3dlyWCLafn2jhouQ==
X-Google-Smtp-Source: AGHT+IHKqxYeGCfwGIgj7RVtDkSGtYVqdFivlbpW0T0Xj5gOlkmarF4q+dVIJe46/cOGgqcPfw5dW3B0MDHpNycaTO/Tprqx7Toy
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a22:b0:36c:2ed4:8d4c with SMTP id
 g2-20020a056e021a2200b0036c2ed48d4cmr657280ile.4.1714978881390; Mon, 06 May
 2024 00:01:21 -0700 (PDT)
Date: Mon, 06 May 2024 00:01:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005d7e10617c3a3f5@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfs_free_fork
From: syzbot <syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b9158815de52 Merge tag 'char-misc-6.9-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15154bff180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbf567496022057b
dashboard link: https://syzkaller.appspot.com/bug?extid=2e6fb1f89ce5e13cd02d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1262fb38980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1530bdc4980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7886d49e8de8/disk-b9158815.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7909f40ff65c/vmlinux-b9158815.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7641fb86043d/bzImage-b9158815.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/aeab32d02708/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
BUG: KMSAN: uninit-value in hfs_free_fork+0x6b4/0xa50 fs/hfs/extent.c:320
 __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
 hfs_free_fork+0x6b4/0xa50 fs/hfs/extent.c:320
 hfs_cat_delete+0x501/0xb90 fs/hfs/catalog.c:247
 hfs_remove+0x16a/0x2f0 fs/hfs/dir.c:262
 vfs_unlink+0x676/0xa30 fs/namei.c:4335
 do_unlinkat+0x823/0xe10 fs/namei.c:4399
 __do_sys_unlink fs/namei.c:4447 [inline]
 __se_sys_unlink fs/namei.c:4445 [inline]
 __x64_sys_unlink+0x78/0xb0 fs/namei.c:4445
 x64_sys_call+0x31c7/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:88
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc+0x6e4/0x1000 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 hfs_find_init+0x91/0x250 fs/hfs/bfind.c:21
 hfs_free_fork+0x3bb/0xa50 fs/hfs/extent.c:316
 hfs_cat_delete+0x501/0xb90 fs/hfs/catalog.c:247
 hfs_remove+0x16a/0x2f0 fs/hfs/dir.c:262
 vfs_unlink+0x676/0xa30 fs/namei.c:4335
 do_unlinkat+0x823/0xe10 fs/namei.c:4399
 __do_sys_unlink fs/namei.c:4447 [inline]
 __se_sys_unlink fs/namei.c:4445 [inline]
 __x64_sys_unlink+0x78/0xb0 fs/namei.c:4445
 x64_sys_call+0x31c7/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:88
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 5043 Comm: syz-executor323 Not tainted 6.9.0-rc6-syzkaller-00290-gb9158815de52 #0
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

