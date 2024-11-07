Return-Path: <linux-fsdevel+bounces-33876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 900509BFFB1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 09:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAEA1F2254E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 08:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602E11D0DEC;
	Thu,  7 Nov 2024 08:07:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1217DE36
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966850; cv=none; b=UOSIZfb9eNtI1kiwhg13FodkpplXeFvz+S+IiIeVwk0oA7dIQGhx2hzYPNJmZSHk0EwwBWws9yOt/G2nU2/TWGo2E0tMKNy41643hvwlABu5TayzGiAOnvIHjY6JkSEkM9nVQ8qyqzHCqHzridZ7U7zMD4lRg7vHLx4BREXTJBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966850; c=relaxed/simple;
	bh=2V47KTTKsgSskEbASEagPIL6uX+vROs65N/OXrhxkPQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZTvGLj77jAZAvDyAxvkNtbBrpqTTrZchCnKGV7xOzK8DN3BZswfpSGLDSAsaRzDvnksWqybP7l44LU9omVlIG5lyY/t1cFG8qNNabAI0rRW6SIIYswOJvMKmxgZzqoI5sJyTCR7FWTIo1EqkeLZz6URQyP2llSULgannKyKNvjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so8032315ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 00:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730966847; x=1731571647;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywJI1RizHtNoeacvYINknT2lGhzvBKSC2a9W7mPrTPM=;
        b=MkF6YX4q7UR7H8xOMDm9GeFJygmoYNH+nr0tDw9GmgqQAjOg76qY02HDW0Tfmm3aIB
         pJUmBVGr3gvkJxp5U/+p+v8VtGOJ3p9275u2t+MP9O3xjwTZcjdTzUAV+iEJyqGN/wWe
         WmIV13epltltXwUNK65APD41UJMGc90f4j3vBI+uGD1ap27dxMGKx+4MzDh6gYFngZ0O
         Bek09PVb2ZvqfCUTL/blpzq4f/1xgDzhVO/jooaSBQSueXjgHtC25h4Tro0tUkvbEgHq
         hox27/oDC1Shinv33eZiOB10SvXR0xfqAY7T86OHN736l5LIuApp2pP82R3d3j3yuWXg
         WmUQ==
X-Gm-Message-State: AOJu0YyMCufkUQI6sUx26kPQJ0aNIPjsiFGoftbdgcRTR4OwyBMv9npi
	cRobnBlLB6XEptdRBoMKo7dBsDMyEkAwHNiOH5Sjvk1sCfUJLZ7PIeMaUn2cR0TfgxXhiDkRmd0
	0CUnAPil4Gj0ENZ2AV6l4bTvIO/P5kM7ubtKbovu8E/LqRXsxnWkpr9w=
X-Google-Smtp-Source: AGHT+IEgxTDOf22PP8xGLXCGHRNIFNamlBck6mUdYtXnATlVLH8RqNQe6U5sblaKTwdz/YsZQqy/hhGd92ZMAF2xqA2tfPCsLsEI
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c249:0:b0:3a6:b0d0:ee2d with SMTP id
 e9e14a558f8ab-3a6ed0b4b99mr3107245ab.9.1730966847509; Thu, 07 Nov 2024
 00:07:27 -0800 (PST)
Date: Thu, 07 Nov 2024 00:07:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672c753f.050a0220.31356.0003.GAE@google.com>
Subject: [syzbot] [hfs?] possible deadlock in hfsplus_file_fsync
From: syzbot <syzbot+44707a660bc78e5dc95c@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1ffec08567f4 Add linux-next specific files for 20241104
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13b23587980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfea72efa3e2aef2
dashboard link: https://syzkaller.appspot.com/bug?extid=44707a660bc78e5dc95c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f67fb217f30/disk-1ffec085.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/73c0895ed6c3/vmlinux-1ffec085.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80c6f613afd1/bzImage-1ffec085.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44707a660bc78e5dc95c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc5-next-20241104-syzkaller #0 Not tainted
------------------------------------------------------
syz.3.810/9889 is trying to acquire lock:
ffff888024cf09b8 (&sb->s_type->i_mutex_key#23){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:817 [inline]
ffff888024cf09b8 (&sb->s_type->i_mutex_key#23){+.+.}-{4:4}, at: hfsplus_file_fsync+0xe8/0x4d0 fs/hfsplus/inode.c:311

but task is already holding lock:
ffff8881423fbac8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: blk_freeze_queue block/blk-mq.c:177 [inline]
ffff8881423fbac8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:187

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&q->q_usage_counter(io)#17){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1510/0x2490 block/blk-mq.c:3069
       __submit_bio+0x2c2/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bh fs/buffer.c:2819 [inline]
       block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2446
       filemap_read_folio+0x14b/0x630 mm/filemap.c:2366
       do_read_cache_folio+0x3f5/0x850 mm/filemap.c:3826
       do_read_cache_page+0x30/0x200 mm/filemap.c:3892
       read_mapping_page include/linux/pagemap.h:1005 [inline]
       __hfs_bnode_create+0x487/0x770 fs/hfsplus/bnode.c:440
       hfsplus_bnode_find+0x237/0x10c0 fs/hfsplus/bnode.c:486
       hfsplus_brec_find+0x183/0x570 fs/hfsplus/bfind.c:172
       hfsplus_brec_read+0x2b/0x110 fs/hfsplus/bfind.c:211
       hfsplus_find_cat+0x17f/0x5d0 fs/hfsplus/catalog.c:202
       hfsplus_iget+0x483/0x680 fs/hfsplus/super.c:83
       hfsplus_fill_super+0xc4d/0x1be0 fs/hfsplus/super.c:504
       get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
       vfs_get_tree+0x90/0x2b0 fs/super.c:1814
       do_new_mount+0x2be/0xb40 fs/namespace.c:3507
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4057 [inline]
       __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&tree->tree_lock#2){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       hfsplus_find_init+0x14a/0x1c0 fs/hfsplus/bfind.c:28
       hfsplus_rename_cat+0x157/0x1090 fs/hfsplus/catalog.c:447
       hfsplus_rename+0x12e/0x1c0 fs/hfsplus/dir.c:552
       vfs_rename+0xbdb/0xf00 fs/namei.c:5054
       do_renameat2+0xd94/0x13f0 fs/namei.c:5211
       __do_sys_rename fs/namei.c:5258 [inline]
       __se_sys_rename fs/namei.c:5256 [inline]
       __x64_sys_rename+0x82/0x90 fs/namei.c:5256
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&sb->s_type->i_mutex_key#23/4){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1693
       vfs_rename+0x6a2/0xf00 fs/namei.c:5025
       do_renameat2+0xd94/0x13f0 fs/namei.c:5211
       __do_sys_rename fs/namei.c:5258 [inline]
       __se_sys_rename fs/namei.c:5256 [inline]
       __x64_sys_rename+0x82/0x90 fs/namei.c:5256
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sb->s_type->i_mutex_key#23){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:817 [inline]
       hfsplus_file_fsync+0xe8/0x4d0 fs/hfsplus/inode.c:311
       __loop_update_dio+0x1a4/0x500 drivers/block/loop.c:204
       loop_set_status+0x62b/0x8f0 drivers/block/loop.c:1289
       lo_ioctl+0xcbc/0x1f50
       blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &sb->s_type->i_mutex_key#23 --> &tree->tree_lock#2 --> &q->q_usage_counter(io)#17

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#17);
                               lock(&tree->tree_lock#2);
                               lock(&q->q_usage_counter(io)#17);
  lock(&sb->s_type->i_mutex_key#23);

 *** DEADLOCK ***

3 locks held by syz.3.810/9889:
 #0: ffff88801efacb60 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_set_status+0x2a/0x8f0 drivers/block/loop.c:1251
 #1: ffff8881423fbac8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: blk_freeze_queue block/blk-mq.c:177 [inline]
 #1: ffff8881423fbac8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:187
 #2: ffff8881423fbb00 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: blk_freeze_queue block/blk-mq.c:177 [inline]
 #2: ffff8881423fbb00 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:187

stack backtrace:
CPU: 0 UID: 0 PID: 9889 Comm: syz.3.810 Not tainted 6.12.0-rc5-next-20241104-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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
 down_write+0x99/0x220 kernel/locking/rwsem.c:1577
 inode_lock include/linux/fs.h:817 [inline]
 hfsplus_file_fsync+0xe8/0x4d0 fs/hfsplus/inode.c:311
 __loop_update_dio+0x1a4/0x500 drivers/block/loop.c:204
 loop_set_status+0x62b/0x8f0 drivers/block/loop.c:1289
 lo_ioctl+0xcbc/0x1f50
 blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f89dbd7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f89dcaf0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f89dbf35f80 RCX: 00007f89dbd7e719
RDX: 0000000020001300 RSI: 0000000000004c04 RDI: 0000000000000004
RBP: 00007f89dbdf139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f89dbf35f80 R15: 00007ffdb32a6ed8
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

