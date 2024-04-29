Return-Path: <linux-fsdevel+bounces-18096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5078B5761
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 14:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6789B219F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 12:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8B537E0;
	Mon, 29 Apr 2024 12:03:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6B535CF
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392214; cv=none; b=gkO13Uofwkt5dd0Oai6fulmDLfgB3cPUCU7IMfP4Zk0F542PWWzaE+0cWryISCwt9N390JRkGejZDRJHdBzMHo/uBsstEtTivxhgrjeZJ+eNKCeItknAV3jhGrSpeCLFqiJgMXC1F+0lF9L5A6OLoE/dOGrpaVAQB8ewLPxbbTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392214; c=relaxed/simple;
	bh=TmG6U23KGfBsYaj/aao/woMsoLnrh1jaeFq3yegv0PY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VJOYFVIw1z1dIiPBnTMY/4z7pZepULsZt6eZGgjwbG1N+KCR4uXeghh6vKXC7mVJApn6g5B9YnfEvRGaLywashTHpkSKosm3MkXZrdMq+vx9UIyIoTgYPgCkyYOSpWtqMZ5GkwDyqUYGMAutZCwUbotGMcUaAC3RDqxlz9PR9tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da4360bbacso565005039f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 05:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714392212; x=1714997012;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPeutWuuJKgEveYJddESC9yj//vYdRdS4lh3fOUqRjw=;
        b=X53wT+klMU70KWIOvJKXOiWsFwOfOQi85pPsnoGcOr9ff0YDheDIEg0PAg738T8kRd
         RIfTQD5ixu+h6Sd7ABy5kQFXsEi/tf0qQzr1Urq1bOsRWGjTmVj0oE98Mk6Cv9/f8h59
         22HYMQQoXI7oRnno7P4JX2pWisOS7jlqlZ+g4u/7siiWWv7srm/lKNLRBVT0oiXJ6nlT
         AlvctMlB1PUsC2YSjV6P3xa6wuwh6nlJUyqc73mYLsFwJIoBCzsdM9quReV103FTejhL
         B+j0UuBoja017U33xhwlthFEoQY8gkBmImXXSjcklPJ9LVTYcsiw8J3KDfBNpozvs7ZT
         gnqw==
X-Forwarded-Encrypted: i=1; AJvYcCVybTJ2E9fT0pQuwONbZoPtbjKeNXbfYnOgia4BTq3+DUje7OLSxvUVO8H/Xb3zrKx5whrDExDCkXfK+Q4ZMEDIQdi6Gzp0dPTAS3Lvxw==
X-Gm-Message-State: AOJu0Yz9ZGnvt9KmCNcqrjmBFQAYnbM5cq78hblxwJ6hBc9ZT8JMzJZm
	EJDw09fZz8PqQ4HQzDPAnGkFxjbcHtc7doMLwq2WKNF8jeLwdifiDfAsDl3M2YGL2gJWrC/EkPQ
	HrxuozPzGh1vuYlfa3RtYcJXaNjlPP9yd5ASxwgy0jG8xdlD9IJAGvLI=
X-Google-Smtp-Source: AGHT+IERPOvG2hNrnVa3g7jlrz9NHaq8Q/ByV8zlQDBRnoCYNVgF+sPLiwUJJJyMkA8I+Xu5Xkgd/RyvgAQg6jM67jPhcGpkPhwG
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:450b:b0:487:4ad0:def3 with SMTP id
 bs11-20020a056638450b00b004874ad0def3mr437473jab.0.1714392210976; Mon, 29 Apr
 2024 05:03:30 -0700 (PDT)
Date: Mon, 29 Apr 2024 05:03:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bdd06e06173b0ae7@google.com>
Subject: [syzbot] [nilfs?] possible deadlock in nilfs_dirty_inode (3)
From: syzbot <syzbot+ca73f5a22aec76875d85@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e88c4cfcb7b8 Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f92380980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19891bd776e81b8b
dashboard link: https://syzkaller.appspot.com/bug?extid=ca73f5a22aec76875d85
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e88c4cfc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3d83e80db525/vmlinux-e88c4cfc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/847604848213/bzImage-e88c4cfc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca73f5a22aec76875d85@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8 #0 Not tainted
------------------------------------------------------
kswapd0/110 is trying to acquire lock:
ffff88806d060610 (sb_internal#3){.+.+}-{0:0}, at: nilfs_dirty_inode+0x1a4/0x270 fs/nilfs2/inode.c:1153

but task is already holding lock:
ffffffff8d9373c0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x1a10 mm/vmscan.c:6782

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       prepare_alloc_pages.constprop.0+0x155/0x560 mm/page_alloc.c:4346
       __alloc_pages+0x194/0x2460 mm/page_alloc.c:4564
       alloc_pages_mpol+0x275/0x610 mm/mempolicy.c:2264
       folio_alloc+0x1e/0x40 mm/mempolicy.c:2342
       filemap_alloc_folio+0x3ba/0x490 mm/filemap.c:984
       __filemap_get_folio+0x52b/0xa90 mm/filemap.c:1926
       pagecache_get_page+0x2c/0x260 mm/folio-compat.c:93
       block_write_begin+0x38/0x4a0 fs/buffer.c:2209
       nilfs_write_begin+0x9f/0x1a0 fs/nilfs2/inode.c:262
       page_symlink+0x356/0x450 fs/namei.c:5229
       nilfs_symlink+0x23c/0x3c0 fs/nilfs2/namei.c:153
       vfs_symlink fs/namei.c:4481 [inline]
       vfs_symlink+0x3e8/0x630 fs/namei.c:4465
       do_symlinkat+0x263/0x310 fs/namei.c:4507
       __do_sys_symlink fs/namei.c:4528 [inline]
       __se_sys_symlink fs/namei.c:4526 [inline]
       __ia32_sys_symlink+0x78/0xa0 fs/namei.c:4526
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (&nilfs->ns_segctor_sem){++++}-{3:3}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       nilfs_transaction_begin+0x326/0xa40 fs/nilfs2/segment.c:223
       nilfs_symlink+0x114/0x3c0 fs/nilfs2/namei.c:140
       vfs_symlink fs/namei.c:4481 [inline]
       vfs_symlink+0x3e8/0x630 fs/namei.c:4465
       do_symlinkat+0x263/0x310 fs/namei.c:4507
       __do_sys_symlink fs/namei.c:4528 [inline]
       __se_sys_symlink fs/namei.c:4526 [inline]
       __ia32_sys_symlink+0x78/0xa0 fs/namei.c:4526
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (sb_internal#3){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1664 [inline]
       sb_start_intwrite include/linux/fs.h:1847 [inline]
       nilfs_transaction_begin+0x21b/0xa40 fs/nilfs2/segment.c:220
       nilfs_dirty_inode+0x1a4/0x270 fs/nilfs2/inode.c:1153
       __mark_inode_dirty+0x1f0/0xe70 fs/fs-writeback.c:2477
       mark_inode_dirty_sync include/linux/fs.h:2410 [inline]
       iput.part.0+0x5b/0x7f0 fs/inode.c:1764
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x440 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x32a/0x550 fs/super.c:221
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7c0 mm/vmscan.c:4774
       shrink_many mm/vmscan.c:4835 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
       shrink_node mm/vmscan.c:5894 [inline]
       kswapd_shrink_node mm/vmscan.c:6704 [inline]
       balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  sb_internal#3 --> &nilfs->ns_segctor_sem --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&nilfs->ns_segctor_sem);
                               lock(fs_reclaim);
  rlock(sb_internal#3);

 *** DEADLOCK ***

2 locks held by kswapd0/110:
 #0: ffffffff8d9373c0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x1a10 mm/vmscan.c:6782
 #1: ffff88806d0600e0 (&type->s_umount_key#55){++++}-{3:3}, at: super_trylock_shared fs/super.c:561 [inline]
 #1: ffff88806d0600e0 (&type->s_umount_key#55){++++}-{3:3}, at: super_cache_scan+0x96/0x550 fs/super.c:196

stack backtrace:
CPU: 2 PID: 110 Comm: kswapd0 Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1664 [inline]
 sb_start_intwrite include/linux/fs.h:1847 [inline]
 nilfs_transaction_begin+0x21b/0xa40 fs/nilfs2/segment.c:220
 nilfs_dirty_inode+0x1a4/0x270 fs/nilfs2/inode.c:1153
 __mark_inode_dirty+0x1f0/0xe70 fs/fs-writeback.c:2477
 mark_inode_dirty_sync include/linux/fs.h:2410 [inline]
 iput.part.0+0x5b/0x7f0 fs/inode.c:1764
 iput+0x5c/0x80 fs/inode.c:1757
 dentry_unlink_inode+0x295/0x440 fs/dcache.c:400
 __dentry_kill+0x1d0/0x600 fs/dcache.c:603
 shrink_kill fs/dcache.c:1048 [inline]
 shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
 prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
 super_cache_scan+0x32a/0x550 fs/super.c:221
 do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
 shrink_slab_memcg mm/shrinker.c:548 [inline]
 shrink_slab+0xa87/0x1310 mm/shrinker.c:626
 shrink_one+0x493/0x7c0 mm/vmscan.c:4774
 shrink_many mm/vmscan.c:4835 [inline]
 lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
 shrink_node mm/vmscan.c:5894 [inline]
 kswapd_shrink_node mm/vmscan.c:6704 [inline]
 balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
 kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

