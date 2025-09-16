Return-Path: <linux-fsdevel+bounces-61696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD2FB58E37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 08:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9696A7A4913
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 06:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D82E23D7CE;
	Tue, 16 Sep 2025 06:02:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23C134AB
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758002552; cv=none; b=dNGcEFbQnJQe8YOMYiPzFw8rBc4YCeDUmcx3JU9/k5LsAbULkjZ2cdDyxikq43jMO9LmFNB76luUXsLjMJ7iqJ+rQAbgmnf20v/mZt45D8bV0F36RWocEovWE1Iu7/VN+7JZbG0Ubi2DzlvQRRoomUGRaUm5YwP5pzrjg6jjjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758002552; c=relaxed/simple;
	bh=gjPEv/Ee9CJYLVGc5FQHlQoQWm9pgt+dc7Rfnw+c/4U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MG8e3ljWbJXm4tO0E9Ljlghq5Moy+WrCH6Bri5dPD4jQHN49VhJUTnPiK+08CpikLiPFvZS5huIA2w+FZSSv2Jk71sp95bZlqDGNlwLmoR/oM0KjTOEdFm9MQkt+w/FmUQOhPNkrQznQf28IL2jNmlMlu2/rq3kWftt+3uU6G9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42412899f90so3849925ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 23:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758002549; x=1758607349;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHoQQoDNPuJvgyy5EVY3I5706DTA0AV8he9zFZIsxuo=;
        b=fAAv2IUsCMCCxOAet+rdp0WneQPAQnKvTJs7sImVe6SV55gMePojykYc1hIRITXuwN
         Ddws6XFCkhXE+l8mrO/WJQsNwncdMeBawGu64vaQKLXSNS+QVsP4NXycvYmkpdnDCDln
         /r5ljEw9E4e/Q5nl2sZA0jfHWd0KL8FtgOEtt7vEwWsg41FJ6T/NZK7JvCYQtYFK3B4o
         waq81SAYtwG2gZbAdKmmoFII+wVJwySCBnqtlY2VhECrSMGqYRnzKJZvjW+PHJKPj42m
         YlMpS5+UKjy8CqpwMirCFegp+aIaI1kov9SBOFDiO6ObPmC5aBxFmZcx2AEPQ4/aflyA
         8VwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+QKFCiK2SBfuKcJRXZT3rFAQMFzKwOOrnD393XahrNq2AAB2CI+IY9npDe5NmVdUh3qjAOk9QrVEdLQRb@vger.kernel.org
X-Gm-Message-State: AOJu0Yza93CqwdiL1759Sjyf+kxNRp1e9yEcciQDMQaQSx49dbZRWbkR
	S7Wc0un0w6LrhLQyiSUX3cSAdszrqo5rKiXYnEEOeWEpiuLtTqjtwHzOioHxC+PcnnVVe6sH788
	Gba9DJXJiQUySF7nI4lq6KS9FphqwA1uAnb5S1oVO0s3e+1ddtID5jPzF6u8=
X-Google-Smtp-Source: AGHT+IGzOMcA/obOHnSWSwAQ7aEaCSmLqVOU8ds27PyLqpwtWLvl62VXBzb8KxIFAfSP46/mh12Jg7Wjiq5Sl9aeGzfSKHnPgNzu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdac:0:b0:424:2b1:409d with SMTP id
 e9e14a558f8ab-42402b142ccmr55413305ab.28.1758002549390; Mon, 15 Sep 2025
 23:02:29 -0700 (PDT)
Date: Mon, 15 Sep 2025 23:02:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8fd75.050a0220.2ff435.03bd.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in do_writepages (2)
From: syzbot <syzbot+756f498a88797cda9299@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f83ec76bf285 Linux 6.17-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168cfb62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=927198eca77e75d9
dashboard link: https://syzkaller.appspot.com/bug?extid=756f498a88797cda9299
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c6547c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e216eec2ed81/disk-f83ec76b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/51d6e63c8c83/vmlinux-f83ec76b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/497ee77f3c79/bzImage-f83ec76b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c319c427bb4a/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=116ed762580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+756f498a88797cda9299@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 512
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/6069 is trying to acquire lock:
ffff888033c28b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x27a/0x600 mm/page-writeback.c:2634

but task is already holding lock:
ffff888075bd9d78 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:164 [inline]
ffff888075bd9d78 (&ei->xattr_sem){++++}-{4:4}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:6425 [inline]
ffff888075bd9d78 (&ei->xattr_sem){++++}-{4:4}, at: __ext4_mark_inode_dirty+0x4ba/0x870 fs/ext4/inode.c:6506

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ei->xattr_sem){++++}-{4:4}:
       down_read+0x9b/0x480 kernel/locking/rwsem.c:1537
       ext4_setattr+0x875/0x2ae0 fs/ext4/inode.c:5901
       notify_change+0x6a9/0x1230 fs/attr.c:552
       chown_common+0x54e/0x680 fs/open.c:791
       do_fchownat+0x1a7/0x200 fs/open.c:822
       __do_sys_chown fs/open.c:842 [inline]
       __se_sys_chown fs/open.c:840 [inline]
       __x64_sys_chown+0x7b/0xc0 fs/open.c:840
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0x5ea/0x1410 fs/jbd2/transaction.c:444
       jbd2__journal_start+0x394/0x6a0 fs/jbd2/transaction.c:501
       __ext4_journal_start_sb+0x195/0x690 fs/ext4/ext4_jbd2.c:115
       __ext4_journal_start fs/ext4/ext4_jbd2.h:242 [inline]
       ext4_do_writepages+0xc23/0x3cf0 fs/ext4/inode.c:2913
       ext4_writepages+0x37a/0x7d0 fs/ext4/inode.c:3025
       do_writepages+0x27a/0x600 mm/page-writeback.c:2634
       __writeback_single_inode+0x160/0xfb0 fs/fs-writeback.c:1680
       writeback_sb_inodes+0x60d/0xfa0 fs/fs-writeback.c:1976
       __writeback_inodes_wb+0xf8/0x2d0 fs/fs-writeback.c:2047
       wb_writeback+0x7f3/0xb70 fs/fs-writeback.c:2158
       wb_check_old_data_flush fs/fs-writeback.c:2262 [inline]
       wb_do_writeback fs/fs-writeback.c:2315 [inline]
       wb_workfn+0x8ca/0xbe0 fs/fs-writeback.c:2343
       process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3236
       process_scheduled_works kernel/workqueue.c:3319 [inline]
       worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
       kthread+0x3c5/0x780 kernel/kthread.c:463
       ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x12a6/0x1ce0 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       ext4_writepages_down_read fs/ext4/ext4.h:1786 [inline]
       ext4_writepages+0x224/0x7d0 fs/ext4/inode.c:3024
       do_writepages+0x27a/0x600 mm/page-writeback.c:2634
       __writeback_single_inode+0x160/0xfb0 fs/fs-writeback.c:1680
       writeback_single_inode+0x2bc/0x550 fs/fs-writeback.c:1801
       write_inode_now+0x170/0x1e0 fs/fs-writeback.c:2864
       iput_final fs/inode.c:1884 [inline]
       iput fs/inode.c:1923 [inline]
       iput+0x62d/0x880 fs/inode.c:1909
       ext4_xattr_block_set+0x67c/0x3650 fs/ext4/xattr.c:2194
       ext4_xattr_move_to_block fs/ext4/xattr.c:2659 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2734 [inline]
       ext4_expand_extra_isize_ea+0x143d/0x1ab0 fs/ext4/xattr.c:2822
       __ext4_expand_extra_isize+0x346/0x480 fs/ext4/inode.c:6385
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:6428 [inline]
       __ext4_mark_inode_dirty+0x544/0x870 fs/ext4/inode.c:6506
       ext4_evict_inode+0x74e/0x18e0 fs/ext4/inode.c:254
       evict+0x3e6/0x920 fs/inode.c:810
       iput_final fs/inode.c:1897 [inline]
       iput fs/inode.c:1923 [inline]
       iput+0x521/0x880 fs/inode.c:1909
       ext4_orphan_cleanup+0x731/0x11e0 fs/ext4/orphan.c:474
       __ext4_fill_super fs/ext4/super.c:5609 [inline]
       ext4_fill_super+0x8a38/0xafa0 fs/ext4/super.c:5728
       get_tree_bdev_flags+0x38c/0x620 fs/super.c:1692
       vfs_get_tree+0x8e/0x340 fs/super.c:1815
       do_new_mount fs/namespace.c:3808 [inline]
       path_mount+0x1513/0x2000 fs/namespace.c:4123
       do_mount fs/namespace.c:4136 [inline]
       __do_sys_mount fs/namespace.c:4347 [inline]
       __se_sys_mount fs/namespace.c:4324 [inline]
       __x64_sys_mount+0x28d/0x310 fs/namespace.c:4324
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &sbi->s_writepages_rwsem --> jbd2_handle --> &ei->xattr_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->xattr_sem);
                               lock(jbd2_handle);
                               lock(&ei->xattr_sem);
  rlock(&sbi->s_writepages_rwsem);

 *** DEADLOCK ***

3 locks held by syz.0.17/6069:
 #0: ffff888033c0e0e0 (&type->s_umount_key#27/1){+.+.}-{4:4}, at: alloc_super+0x235/0xbd0 fs/super.c:345
 #1: ffff888033c0e618 (sb_internal){.+.+}-{0:0}, at: evict+0x3e6/0x920 fs/inode.c:810
 #2: ffff888075bd9d78 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:164 [inline]
 #2: ffff888075bd9d78 (&ei->xattr_sem){++++}-{4:4}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:6425 [inline]
 #2: ffff888075bd9d78 (&ei->xattr_sem){++++}-{4:4}, at: __ext4_mark_inode_dirty+0x4ba/0x870 fs/ext4/inode.c:6506

stack backtrace:
CPU: 1 UID: 0 PID: 6069 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2043
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x12a6/0x1ce0 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
 ext4_writepages_down_read fs/ext4/ext4.h:1786 [inline]
 ext4_writepages+0x224/0x7d0 fs/ext4/inode.c:3024
 do_writepages+0x27a/0x600 mm/page-writeback.c:2634
 __writeback_single_inode+0x160/0xfb0 fs/fs-writeback.c:1680
 writeback_single_inode+0x2bc/0x550 fs/fs-writeback.c:1801
 write_inode_now+0x170/0x1e0 fs/fs-writeback.c:2864
 iput_final fs/inode.c:1884 [inline]
 iput fs/inode.c:1923 [inline]
 iput+0x62d/0x880 fs/inode.c:1909
 ext4_xattr_block_set+0x67c/0x3650 fs/ext4/xattr.c:2194
 ext4_xattr_move_to_block fs/ext4/xattr.c:2659 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2734 [inline]
 ext4_expand_extra_isize_ea+0x143d/0x1ab0 fs/ext4/xattr.c:2822
 __ext4_expand_extra_isize+0x346/0x480 fs/ext4/inode.c:6385
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6428 [inline]
 __ext4_mark_inode_dirty+0x544/0x870 fs/ext4/inode.c:6506
 ext4_evict_inode+0x74e/0x18e0 fs/ext4/inode.c:254
 evict+0x3e6/0x920 fs/inode.c:810
 iput_final fs/inode.c:1897 [inline]
 iput fs/inode.c:1923 [inline]
 iput+0x521/0x880 fs/inode.c:1909
 ext4_orphan_cleanup+0x731/0x11e0 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5609 [inline]
 ext4_fill_super+0x8a38/0xafa0 fs/ext4/super.c:5728
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1692
 vfs_get_tree+0x8e/0x340 fs/super.c:1815
 do_new_mount fs/namespace.c:3808 [inline]
 path_mount+0x1513/0x2000 fs/namespace.c:4123
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount fs/namespace.c:4324 [inline]
 __x64_sys_mount+0x28d/0x310 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f65b239034a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd57a76688 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd57a76710 RCX: 00007f65b239034a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007ffd57a766d0
RBP: 0000200000000180 R08: 00007ffd57a76710 R09: 0000000000800700
R10: 0000000000800700 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007ffd57a766d0 R14: 000000000000046f R15: 0000200000000680
 </TASK>
------------[ cut here ]------------
EA inode 11 i_nlink=2
WARNING: CPU: 0 PID: 6069 at fs/ext4/xattr.c:1051 ext4_xattr_inode_update_ref+0x4a6/0x570 fs/ext4/xattr.c:1051
Modules linked in:
CPU: 0 UID: 0 PID: 6069 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ext4_xattr_inode_update_ref+0x4a6/0x570 fs/ext4/xattr.c:1051
Code: df 48 8d 7b 40 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bf 00 00 00 48 8b 73 40 44 89 e2 48 c7 c7 20 03 c8 8b e8 7b 78 f0 fe 90 <0f> 0b 90 90 e9 40 fe ff ff e8 0c d3 31 ff 44 0f b6 3d bb 35 0a 0e
RSP: 0018:ffffc90002f07198 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888075bacf18 RCX: ffffffff817a4388
RDX: ffff8880348c8000 RSI: ffffffff817a4395 RDI: 0000000000000001
RBP: ffffc90002f07258 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000002d2d2d2d R12: 0000000000000002
R13: 1ffff920005e0e36 R14: ffff888075bacff0 R15: 0000000000000000
FS:  00005555929fc500(0000) GS:ffff8881246b3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563261a05138 CR3: 000000007523b000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_xattr_inode_dec_ref fs/ext4/xattr.c:1076 [inline]
 ext4_xattr_set_entry+0x158f/0x1f00 fs/ext4/xattr.c:1714
 ext4_xattr_ibody_set+0x3d6/0x5d0 fs/ext4/xattr.c:2263
 ext4_xattr_move_to_block fs/ext4/xattr.c:2666 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2734 [inline]
 ext4_expand_extra_isize_ea+0x1487/0x1ab0 fs/ext4/xattr.c:2822
 __ext4_expand_extra_isize+0x346/0x480 fs/ext4/inode.c:6385
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6428 [inline]
 __ext4_mark_inode_dirty+0x544/0x870 fs/ext4/inode.c:6506
 ext4_evict_inode+0x74e/0x18e0 fs/ext4/inode.c:254
 evict+0x3e6/0x920 fs/inode.c:810
 iput_final fs/inode.c:1897 [inline]
 iput fs/inode.c:1923 [inline]
 iput+0x521/0x880 fs/inode.c:1909
 ext4_orphan_cleanup+0x731/0x11e0 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5609 [inline]
 ext4_fill_super+0x8a38/0xafa0 fs/ext4/super.c:5728
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1692
 vfs_get_tree+0x8e/0x340 fs/super.c:1815
 do_new_mount fs/namespace.c:3808 [inline]
 path_mount+0x1513/0x2000 fs/namespace.c:4123
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount fs/namespace.c:4324 [inline]
 __x64_sys_mount+0x28d/0x310 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f65b239034a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd57a76688 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd57a76710 RCX: 00007f65b239034a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007ffd57a766d0
RBP: 0000200000000180 R08: 00007ffd57a76710 R09: 0000000000800700
R10: 0000000000800700 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007ffd57a766d0 R14: 000000000000046f R15: 0000200000000680
 </TASK>


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

