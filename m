Return-Path: <linux-fsdevel+bounces-34167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8582C9C3542
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 00:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2AD1F21579
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 23:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C38158D94;
	Sun, 10 Nov 2024 23:11:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FDD2BD11
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731280289; cv=none; b=L8Xhu8KbNleScW6Z85Ko4shY5gL1wDuF8FtuaNOSoixaAzrFttWClIPnKFI6S0+STUQ92o2boUnI5POUU46YF5kvLZZOnlZyuS/PQQh0Y5grB91Brb5WDs3kszfbsuhf4myAl8OOpPDHItRe20aB6YEJBEU+kMMh37CJm0K2V2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731280289; c=relaxed/simple;
	bh=ZA1EiqzlbXH4PoXTYn4wA9SZf3E2r2fsPwIOIh4qB1w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TwsSWCsSAqlpU6PbUTiB6RdVFqu8L5Bs5PyuF1eUGuXvAyea8aHoaplS9rT0DF36C1J2aU2u38ALvl3wPtopBZAT8w/Xu8Yzabs/xIEKejsc8OAOE1cnzbi/Mz5QuqUep+X7jbWZOPxnbOMtX/B5y6Nz34ylL2Kk/wJzQj+pAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6bf539ceaso44309835ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 15:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731280287; x=1731885087;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SeOxHKtv0FPxzGe6DXwXuUf8apOE+QGfzUkQrFjUziE=;
        b=kMVmtbN5cfb1206FU1bjbCYYHAuh2icA4HM2CBnXaZKC4W8T5D2M9UzV1epq1+Bo1i
         B1eR47h2J/hTCI9AaXZ3NHDIsnIIR8RqPfPQVmE3TjC8IxhaJAf0va3nOhlc2XyN9Hzv
         LdJm4320CI+uHwPcSsPv3gjqyPiSjQW4/y2KZqifTaIkG0h829FgWnTX6dSuY/JJDcKk
         P4vZWPVpMEEdBjujiRCXHBgPoA3C4DcdyixxpiFdgtcNEqxyHI746t9IvGQm7Tet0/fy
         XLEzZcWUhhhBF+GZwIRztYldwcCxyLzy5it6O4GVJ1Rmr6UxZDFaE+RbjVRZ3yjDXW+L
         di+g==
X-Forwarded-Encrypted: i=1; AJvYcCXWu4ho/PafWSMIPlHaoY9RhOgIvP47fyMCZfgBStITH5yZaP5a2AwW7ixjmrul70az7G7XKjovEa9tEynw@vger.kernel.org
X-Gm-Message-State: AOJu0YzfbgMM60YAV4d9Lc2LNZWaLSUGoyUL8O1/Scc+xgJI34Obo3T8
	uq7c7DB4NUQ5BZuenGS8q5R7DrN/z6WoPwJoHKMNUojr87J0DGbOGeWnCK5h8d+lO4m7uox8a9E
	xNmRkO2C1aWdnRaaVZJbAIwkYY6AWZhCDXLNzGKe3iXBJhpYYl79PMO8=
X-Google-Smtp-Source: AGHT+IGDYN+rbIWsuA/kHXYCp7QyZwB7zg/POyI27twQv24Wy5foL+LcuAgUCb0s9lAPcjjRNetRvkG4f34lLw66vgx5yWCzDol/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f94:b0:3a6:aade:5644 with SMTP id
 e9e14a558f8ab-3a6f11698a7mr95710495ab.4.1731280286825; Sun, 10 Nov 2024
 15:11:26 -0800 (PST)
Date: Sun, 10 Nov 2024 15:11:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67313d9e.050a0220.138bd5.0054.GAE@google.com>
Subject: [syzbot] [exfat?] possible deadlock in fat_count_free_clusters
From: syzbot <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1621bd87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
dashboard link: https://syzkaller.appspot.com/bug?extid=a5d8c609c02f508672cc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9705ecb6a595/disk-929beafb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dbdd1f64b9b8/vmlinux-929beafb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f70d07a929b/bzImage-929beafb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com

FAT-fs (loop3): error, invalid access to FAT (entry 0x0000616b)
======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc6-next-20241108-syzkaller #0 Not tainted
------------------------------------------------------
syz.3.2125/17744 is trying to acquire lock:
ffff8880691980b0 (&sbi->fat_lock){+.+.}-{4:4}, at: lock_fat fs/fat/fatent.c:281 [inline]
ffff8880691980b0 (&sbi->fat_lock){+.+.}-{4:4}, at: fat_count_free_clusters+0x156/0xe70 fs/fat/fatent.c:724

but task is already holding lock:
ffff88802533deb0 (&q->limits_lock){+.+.}-{4:4}, at: queue_limits_start_update include/linux/blkdev.h:944 [inline]
ffff88802533deb0 (&q->limits_lock){+.+.}-{4:4}, at: loop_reconfigure_limits+0x287/0x9f0 drivers/block/loop.c:1003

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->limits_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       queue_limits_start_update include/linux/blkdev.h:944 [inline]
       loop_reconfigure_limits+0x287/0x9f0 drivers/block/loop.c:1003
       loop_set_block_size drivers/block/loop.c:1473 [inline]
       lo_simple_ioctl drivers/block/loop.c:1496 [inline]
       lo_ioctl+0x1351/0x1f50 drivers/block/loop.c:1559
       blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#17){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1510/0x2490 block/blk-mq.c:3095
       __submit_bio+0x2c2/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bh fs/buffer.c:2819 [inline]
       __bread_slow fs/buffer.c:1264 [inline]
       __bread_gfp+0x23c/0x400 fs/buffer.c:1488
       sb_bread include/linux/buffer_head.h:346 [inline]
       fat12_ent_bread+0x155/0x540 fs/fat/fatent.c:77
       fat_ent_read_block+0x3e4/0x530 fs/fat/fatent.c:445
       fat_alloc_clusters+0x4ee/0x11c0 fs/fat/fatent.c:493
       fat_add_cluster fs/fat/inode.c:107 [inline]
       __fat_get_block fs/fat/inode.c:154 [inline]
       fat_get_block+0x4c4/0xd00 fs/fat/inode.c:189
       __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2116
       block_write_begin fs/buffer.c:2226 [inline]
       cont_write_begin+0x6e2/0x9d0 fs/buffer.c:2577
       fat_write_begin+0x76/0x140 fs/fat/inode.c:228
       generic_perform_write+0x344/0x6d0 mm/filemap.c:4055
       generic_file_write_iter+0xae/0x310 mm/filemap.c:4182
       new_sync_write fs/read_write.c:586 [inline]
       vfs_write+0xaeb/0xd30 fs/read_write.c:679
       ksys_write+0x18f/0x2b0 fs/read_write.c:731
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sbi->fat_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       lock_fat fs/fat/fatent.c:281 [inline]
       fat_count_free_clusters+0x156/0xe70 fs/fat/fatent.c:724
       fat_statfs+0x139/0x450 fs/fat/inode.c:834
       statfs_by_dentry fs/statfs.c:66 [inline]
       vfs_statfs+0x13b/0x2c0 fs/statfs.c:90
       loop_config_discard drivers/block/loop.c:798 [inline]
       loop_reconfigure_limits+0x5fe/0x9f0 drivers/block/loop.c:1012
       loop_configure+0x77e/0xeb0 drivers/block/loop.c:1093
       lo_ioctl+0x846/0x1f50
       blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &sbi->fat_lock --> &q->q_usage_counter(io)#17 --> &q->limits_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->limits_lock);
                               lock(&q->q_usage_counter(io)#17);
                               lock(&q->limits_lock);
  lock(&sbi->fat_lock);

 *** DEADLOCK ***

2 locks held by syz.3.2125/17744:
 #0: ffff88802541fb60 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_global_lock_killable drivers/block/loop.c:120 [inline]
 #0: ffff88802541fb60 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_configure+0x1f7/0xeb0 drivers/block/loop.c:1044
 #1: ffff88802533deb0 (&q->limits_lock){+.+.}-{4:4}, at: queue_limits_start_update include/linux/blkdev.h:944 [inline]
 #1: ffff88802533deb0 (&q->limits_lock){+.+.}-{4:4}, at: loop_reconfigure_limits+0x287/0x9f0 drivers/block/loop.c:1003

stack backtrace:
CPU: 0 UID: 0 PID: 17744 Comm: syz.3.2125 Not tainted 6.12.0-rc6-next-20241108-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 lock_fat fs/fat/fatent.c:281 [inline]
 fat_count_free_clusters+0x156/0xe70 fs/fat/fatent.c:724
 fat_statfs+0x139/0x450 fs/fat/inode.c:834
 statfs_by_dentry fs/statfs.c:66 [inline]
 vfs_statfs+0x13b/0x2c0 fs/statfs.c:90
 loop_config_discard drivers/block/loop.c:798 [inline]
 loop_reconfigure_limits+0x5fe/0x9f0 drivers/block/loop.c:1012
 loop_configure+0x77e/0xeb0 drivers/block/loop.c:1093
 lo_ioctl+0x846/0x1f50
 blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9752d7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9753abd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9752f36058 RCX: 00007f9752d7e719
RDX: 00000000200002c0 RSI: 0000000000004c0a RDI: 0000000000000008
RBP: 00007f9752df139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9752f36058 R15: 00007ffe36e679e8
 </TASK>


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

