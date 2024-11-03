Return-Path: <linux-fsdevel+bounces-33584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CE29BA7C6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2024 20:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466381F219A6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2024 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2705618A937;
	Sun,  3 Nov 2024 19:56:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047AA17DFF5
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Nov 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730663789; cv=none; b=Neq3WIbBcetcsg1d9BQLsAlzmEHXBat7qM+eg4Ch4pnzCrmnGMHGPyfJEhCz8+/1SOnp0S3ceTl6aKlXriQXGvO3YNo8o32UdnGFl5qgG7QYRR9zQxDB8M0RFF/C+HML8O27894psjJDhjXVdzjxgXxr5ImvTWNvvKEDvQeCABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730663789; c=relaxed/simple;
	bh=hiH7XzfsUU4Od9Ub79vVufy6q8eJMH889c09mRpwdaM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hOT+ZQzF2pz4DLsVoXfITPIu1R8V6BCp5jNUV6q/2iSO7/bBNsyenACXFgFJuT/2lhQnp50gxv5GM02eK7MXqQwJ5mgTWmDdLn7g/0KJA3U3YI0KztpY/f35lxViOaX4eMlIrqfu5Hq9l/yW7gdNcnyZopbQCjEMMMCE58pi8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aed4f24a9so371100739f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Nov 2024 11:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730663785; x=1731268585;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0k/g1ODDrESVtcRz2qZVEfC5PlZtDJSdvf7Vif5vLNo=;
        b=rq2s7t8e3FaayvtMdSWVNeuzfk5otdAYJfACCchmWVQ5SY9uMTdvXczfd5lMVDetqX
         sViVHYDkJRCqHwOaQhvv9UZ9Hw/E1lcClicHE525FbKcsFCJsP82J9QuIMN+Y3IcVgGF
         x3SeXIirVr6E9J4toUY4tXenkDKFBIK39jdbErNjWWM29f0zlrHmt/z48Cp6TEBx7uAP
         9DTjy44rCLpqkE3XdYWLCLek3EZZUzyL10p0q72uxkJsc2Gy7DUyeFBdG+V8RMmnSq4A
         M/WhG8yLbzvJy2U9M4JaIz1PG1E8UeX6Bh0ZUZZ2jtSZTA6ZkMTEHAgzI4gMcK/wRQiF
         m0Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWc/T6KSOm51IydkcXTq21KeAZ8/wRXt8rt72FcSGT2kNIdXh8IFNR05nxsvqig2gD8re+bFsCZSJ5eO3Lh@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmnSUF4mLpsMwUOre+knDl48lnI9l8+ZliJDCLghg4+cbVOPg
	LJPO+mP7FAIYYnTVsO8Bj4klK4PpR5NFhitfTuH2uhtwY9DEwVif1+zdt6cMEQgiz6Z93l/GOXA
	ZI06FJ7WieH3fNMndBM7ZuiY0pKFIrNARQ6QWaUAV0WtpQSjS/9oWfYo=
X-Google-Smtp-Source: AGHT+IGzZgd6cL3+s7Qok0dt36QquLXFuVnz+vI5ZEqP5oK2z/5m99xL79vVKXNlXwzWAAFQcxuclmgvHnj24LPaijszggR6ClyW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e6:b0:3a3:67b1:3080 with SMTP id
 e9e14a558f8ab-3a6b0251396mr100094965ab.7.1730663783531; Sun, 03 Nov 2024
 11:56:23 -0800 (PST)
Date: Sun, 03 Nov 2024 11:56:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6727d567.050a0220.3c8d68.0a91.GAE@google.com>
Subject: [syzbot] [exfat?] possible deadlock in __generic_file_fsync (2)
From: syzbot <syzbot+625941ecc67c107ef2bd@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    86e3904dcdc7 Add linux-next specific files for 20241030
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1578a55f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=625941ecc67c107ef2bd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f584828ac0fd/disk-86e3904d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09481d17f87a/vmlinux-86e3904d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ebed9a1794c3/bzImage-86e3904d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+625941ecc67c107ef2bd@syzkaller.appspotmail.com

exfat: Deprecated parameter 'namecase'
exfat: Deprecated parameter 'utf8'
exFAT-fs (loop1): failed to load upcase table (idx : 0x00012153, chksum : 0x822ffc2e, utbl_chksum : 0xe619d30d)
======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc5-next-20241030-syzkaller #0 Not tainted
------------------------------------------------------
syz.1.67/6116 is trying to acquire lock:
ffff888063a215f0 (&sb->s_type->i_mutex_key#21){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:816 [inline]
ffff888063a215f0 (&sb->s_type->i_mutex_key#21){+.+.}-{4:4}, at: __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1536

but task is already holding lock:
ffff8880253d1db8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: blk_freeze_queue block/blk-mq.c:177 [inline]
ffff8880253d1db8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:187

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->q_usage_counter(io)
#17){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1510/0x2490 block/blk-mq.c:3069
       __submit_bio+0x2c2/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bh fs/buffer.c:2819 [inline]
       __sync_dirty_buffer+0x23d/0x390 fs/buffer.c:2857
       exfat_set_volume_dirty+0x5d/0x80 fs/exfat/super.c:124
       exfat_create+0x1aa/0x5a0 fs/exfat/namei.c:554
       lookup_open fs/namei.c:3595 [inline]
       open_last_lookups fs/namei.c:3694 [inline]
       path_openat+0x1c03/0x3590 fs/namei.c:3930
       do_filp_open+0x235/0x490 fs/namei.c:3960
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1419
       do_sys_open fs/open.c:1434 [inline]
       __do_sys_open fs/open.c:1442 [inline]
       __se_sys_open fs/open.c:1438 [inline]
       __x64_sys_open+0x225/0x270 fs/open.c:1438
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&sbi->s_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       exfat_lookup+0x140/0x18f0 fs/exfat/namei.c:701
       lookup_open fs/namei.c:3573 [inline]
       open_last_lookups fs/namei.c:3694 [inline]
       path_openat+0x11a7/0x3590 fs/namei.c:3930
       do_filp_open+0x235/0x490 fs/namei.c:3960
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1419
       do_sys_open fs/open.c:1434 [inline]
       __do_sys_open fs/open.c:1442 [inline]
       __se_sys_open fs/open.c:1438 [inline]
       __x64_sys_open+0x225/0x270 fs/open.c:1438
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sb->s_type->i_mutex_key#21){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:816 [inline]
       __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1536
       exfat_file_fsync+0xf9/0x1d0 fs/exfat/file.c:524
       __loop_update_dio+0x1a4/0x500 drivers/block/loop.c:204
       loop_set_status+0x62b/0x8f0 drivers/block/loop.c:1290
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
  &sb->s_type->i_mutex_key#21 --> &sbi->s_lock --> &q->q_usage_counter(io)#17

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#17);
                               lock(&sbi->s_lock);
                               lock(&q->q_usage_counter(io)#17);
  lock(&sb->s_type->i_mutex_key#21);

 *** DEADLOCK ***

3 locks held by syz.1.67/6116:
 #0: ffff888020f07360 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_set_status+0x2a/0x8f0 drivers/block/loop.c:1252
 #1: ffff8880253d1db8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: blk_freeze_queue block/blk-mq.c:177 [inline]
 #1: ffff8880253d1db8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:187
 #2: ffff8880253d1df0 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: blk_freeze_queue block/blk-mq.c:177 [inline]
 #2: ffff8880253d1df0 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:187

stack backtrace:
CPU: 0 UID: 0 PID: 6116 Comm: syz.1.67 Not tainted 6.12.0-rc5-next-20241030-syzkaller #0
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
 inode_lock include/linux/fs.h:816 [inline]
 __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1536
 exfat_file_fsync+0xf9/0x1d0 fs/exfat/file.c:524
 __loop_update_dio+0x1a4/0x500 drivers/block/loop.c:204
 loop_set_status+0x62b/0x8f0 drivers/block/loop.c:1290
 lo_ioctl+0xcbc/0x1f50
 blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9dbcd7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9dbdb6a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9dbcf35f80 RCX: 00007f9dbcd7e719
RDX: 0000000020001300 RSI: 0000000000004c04 RDI: 0000000000000005
RBP: 00007f9dbcdf132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9dbcf35f80 R15: 00007ffee1d5a118
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

