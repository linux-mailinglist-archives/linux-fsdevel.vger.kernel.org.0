Return-Path: <linux-fsdevel+bounces-6762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D277581C289
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 02:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D911B21060
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 01:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17CA53A4;
	Fri, 22 Dec 2023 00:59:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3592258F
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 00:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b71b4b179aso85611339f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 16:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703206763; x=1703811563;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCgJHboiS9j0tbid535+fkMH29D8a78hCvLmshto5cE=;
        b=ZVSmXGfUPOX4ZkKjGP2Ly0sr7YO53y3Tw4Sam5mOEoslBbxxqqa5Ff3IelH4w7ZhUY
         hn6f4gnDtZFI2NtyuXFXUpeXOGSTT/UPVRheEyxhgFL7+ALte3txzItVkEIW10ItZ521
         eHxIZNJ+0BhOkV/0SsMm/nt+O60Z9dE/HPm7UkkxZiTHjVcTzgVGvAu0TjB4pFCnai+k
         xJea7XPpesHeHyNKQzvCsp/6KRZ7HFrEd1oPLhuo/DbANotODMEt6Zuvn3RvTxD6VILH
         5+EtS2t0MYqu9SPp7hwdU16sIzwLUt88xxHyjNICN5u6zNYppxVAISLY3XZskVdDcUlD
         oOSQ==
X-Gm-Message-State: AOJu0YzhO92lagOS6x8BMmsBX1jRuKSR7b+yqXs+ZajwdHxD4sAmtkRA
	v3XcbAVGh/VgtRScbkORDm1lQkvXK9ebORhKC0a5QAlIpeGY
X-Google-Smtp-Source: AGHT+IEsKZGM+gdh3bOV7ipRSlILSScvnym2zk9Pdjg6PvWsdaC/J/4cJgPKYxPydQbYFgDhXgFREw2KaoodTE/s1yYA3W9ng19g
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3888:b0:43c:ebeb:a152 with SMTP id
 b8-20020a056638388800b0043cebeba152mr60272jav.2.1703206762951; Thu, 21 Dec
 2023 16:59:22 -0800 (PST)
Date: Thu, 21 Dec 2023 16:59:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015f553060d0eba97@google.com>
Subject: [syzbot] [nilfs?] possible deadlock in nilfs_dirty_inode (2)
From: syzbot <syzbot+903350d47ddb4cbb7f6f@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    55cb5f43689d Merge tag 'trace-v6.7-rc6' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1167b176e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=314e9ad033a7d3a7
dashboard link: https://syzkaller.appspot.com/bug?extid=903350d47ddb4cbb7f6f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-55cb5f43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba0e1e5966ee/vmlinux-55cb5f43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4212fc08c5ac/bzImage-55cb5f43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+903350d47ddb4cbb7f6f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc6-syzkaller-00022-g55cb5f43689d #0 Not tainted
------------------------------------------------------
kswapd0/108 is trying to acquire lock:
ffff888079954608 (sb_internal#4){.+.+}-{0:0}, at: nilfs_dirty_inode+0x1a0/0x270 fs/nilfs2/inode.c:1158

but task is already holding lock:
ffffffff8d11c740 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x160/0x1a90 mm/vmscan.c:6746

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3693 [inline]
       fs_reclaim_acquire+0x100/0x150 mm/page_alloc.c:3707
       might_alloc include/linux/sched/mm.h:303 [inline]
       prepare_alloc_pages.constprop.0+0x155/0x550 mm/page_alloc.c:4339
       __alloc_pages+0x193/0x2420 mm/page_alloc.c:4557
       alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
       folio_alloc+0x1e/0xe0 mm/mempolicy.c:2211
       filemap_alloc_folio+0x3bb/0x490 mm/filemap.c:974
       __filemap_get_folio+0x54c/0xaa0 mm/filemap.c:1918
       pagecache_get_page+0x2c/0x250 mm/folio-compat.c:99
       block_write_begin+0x38/0x490 fs/buffer.c:2223
       nilfs_write_begin+0x9f/0x1a0 fs/nilfs2/inode.c:261
       page_symlink+0x391/0x490 fs/namei.c:5187
       nilfs_symlink+0x24f/0x3e0 fs/nilfs2/namei.c:153
       vfs_symlink fs/namei.c:4464 [inline]
       vfs_symlink+0x3e4/0x620 fs/namei.c:4448
       do_symlinkat+0x25f/0x310 fs/namei.c:4490
       __do_sys_symlinkat fs/namei.c:4506 [inline]
       __se_sys_symlinkat fs/namei.c:4503 [inline]
       __ia32_sys_symlinkat+0x97/0xc0 fs/namei.c:4503
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x62/0xe0 arch/x86/entry/common.c:321
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
       entry_SYSENTER_compat_after_hwframe+0x70/0x7a

-> #1 (&nilfs->ns_segctor_sem){++++}-{3:3}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       nilfs_transaction_begin+0x329/0xa40 fs/nilfs2/segment.c:223
       nilfs_symlink+0x130/0x3e0 fs/nilfs2/namei.c:140
       vfs_symlink fs/namei.c:4464 [inline]
       vfs_symlink+0x3e4/0x620 fs/namei.c:4448
       do_symlinkat+0x25f/0x310 fs/namei.c:4490
       __do_sys_symlinkat fs/namei.c:4506 [inline]
       __se_sys_symlinkat fs/namei.c:4503 [inline]
       __ia32_sys_symlinkat+0x97/0xc0 fs/namei.c:4503
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x62/0xe0 arch/x86/entry/common.c:321
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
       entry_SYSENTER_compat_after_hwframe+0x70/0x7a

-> #0 (sb_internal#4){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2433/0x3b20 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1635 [inline]
       sb_start_intwrite include/linux/fs.h:1757 [inline]
       nilfs_transaction_begin+0x21e/0xa40 fs/nilfs2/segment.c:220
       nilfs_dirty_inode+0x1a0/0x270 fs/nilfs2/inode.c:1158
       __mark_inode_dirty+0x1e0/0xd60 fs/fs-writeback.c:2452
       mark_inode_dirty_sync include/linux/fs.h:2311 [inline]
       iput.part.0+0x5b/0x7b0 fs/inode.c:1800
       iput+0x5c/0x80 fs/inode.c:1793
       dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
       __dentry_kill+0x3b8/0x640 fs/dcache.c:607
       shrink_dentry_list+0x11e/0x4a0 fs/dcache.c:1201
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1282
       super_cache_scan+0x327/0x540 fs/super.c:228
       do_shrink_slab+0x428/0x1120 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa83/0x1310 mm/shrinker.c:626
       shrink_one+0x47d/0x7a0 mm/vmscan.c:4745
       shrink_many mm/vmscan.c:4808 [inline]
       lru_gen_shrink_node mm/vmscan.c:4923 [inline]
       shrink_node+0x211c/0x3710 mm/vmscan.c:5863
       kswapd_shrink_node mm/vmscan.c:6668 [inline]
       balance_pgdat+0x9d2/0x1a90 mm/vmscan.c:6858
       kswapd+0x5be/0xbf0 mm/vmscan.c:7118
       kthread+0x2c6/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

other info that might help us debug this:

Chain exists of:
  sb_internal#4 --> &nilfs->ns_segctor_sem --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&nilfs->ns_segctor_sem);
                               lock(fs_reclaim);
  rlock(sb_internal#4);

 *** DEADLOCK ***

2 locks held by kswapd0/108:
 #0: ffffffff8d11c740 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x160/0x1a90 mm/vmscan.c:6746
 #1: ffff8880799540e0 (&type->s_umount_key#68){++++}-{3:3}, at: super_trylock_shared fs/super.c:610 [inline]
 #1: ffff8880799540e0 (&type->s_umount_key#68){++++}-{3:3}, at: super_cache_scan+0x96/0x540 fs/super.c:203

stack backtrace:
CPU: 2 PID: 108 Comm: kswapd0 Not tainted 6.7.0-rc6-syzkaller-00022-g55cb5f43689d #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x317/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2433/0x3b20 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1635 [inline]
 sb_start_intwrite include/linux/fs.h:1757 [inline]
 nilfs_transaction_begin+0x21e/0xa40 fs/nilfs2/segment.c:220
 nilfs_dirty_inode+0x1a0/0x270 fs/nilfs2/inode.c:1158
 __mark_inode_dirty+0x1e0/0xd60 fs/fs-writeback.c:2452
 mark_inode_dirty_sync include/linux/fs.h:2311 [inline]
 iput.part.0+0x5b/0x7b0 fs/inode.c:1800
 iput+0x5c/0x80 fs/inode.c:1793
 dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
 __dentry_kill+0x3b8/0x640 fs/dcache.c:607
 shrink_dentry_list+0x11e/0x4a0 fs/dcache.c:1201
 prune_dcache_sb+0xeb/0x150 fs/dcache.c:1282
 super_cache_scan+0x327/0x540 fs/super.c:228
 do_shrink_slab+0x428/0x1120 mm/shrinker.c:435
 shrink_slab_memcg mm/shrinker.c:548 [inline]
 shrink_slab+0xa83/0x1310 mm/shrinker.c:626
 shrink_one+0x47d/0x7a0 mm/vmscan.c:4745
 shrink_many mm/vmscan.c:4808 [inline]
 lru_gen_shrink_node mm/vmscan.c:4923 [inline]
 shrink_node+0x211c/0x3710 mm/vmscan.c:5863
 kswapd_shrink_node mm/vmscan.c:6668 [inline]
 balance_pgdat+0x9d2/0x1a90 mm/vmscan.c:6858
 kswapd+0x5be/0xbf0 mm/vmscan.c:7118
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
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

