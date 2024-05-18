Return-Path: <linux-fsdevel+bounces-19716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C500C8C9230
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 22:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19763281DC0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADC154BEB;
	Sat, 18 May 2024 20:20:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C341DA32
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 May 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716063630; cv=none; b=Pvu2zJBxtafqbC47wsjakBSFfshPvG2cfuy0FEXewR8xkUewRiv0qm23zoosjJsNaRKPUVLdqsjCIbFN8aqTaieFMQai+ZcS/GI/jqaebI79Ad4djGXcEdavFkAiUkd2cQx0EOc6XFy/QxtVx+OII+VeiiO7kaCCLmvrgwjBGow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716063630; c=relaxed/simple;
	bh=YqDRsDv8x2OROmlWbV7478UmITYASMfvz5Wn7sUBzIg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VKn5Bc09lsQL0cI6EDtTbwmdO9J+aovn09EWaXIM486vCSa4amQdEv9YjPtxIi4fdHsvow2teYH7qujayXnhUTBzolymZEJ1KZ/HZMtThy94wqcnm5JoTZ09Zy0h3EYyVYyxuIUSJPlpy4c5kQ+a1TAeIVdtuptlfxCneuCD3iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e17a8bed9eso1020985039f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 May 2024 13:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716063628; x=1716668428;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmtCinir98gIy6rtOMfHl0Wl71cM6a+1gZIb5TIp/fo=;
        b=sB2amyjGz5mIENrN6x15i7l2BUoSyWWt65MZDJkkgM//UB0PsJsRXnGqtNbLP2rQGN
         DwXPIUCaoiDlOhV8F1VRIaEiBQpG89h5873URnrTwvttfVrUnFDJV9PvMOrsErc5qQpa
         a+GLvhoUZlaPA2cYY4pE4nWtwwtKyWXxpXZAILjfd+6NKGGJ6hk0Hq+Gcg4ojjUlb1ll
         b12x4k1sIlfgxNqJU5meSITX2t98dLaHsrGjyFpKaKkONuXYRPoj3lu8VFpjFf0m6+3w
         ieEbi+CyB8hGF07vXIIDbvaEYZpYYgckvc58adonjWaaxuimDbyuDS1xh35lw5ry/BKz
         +o8w==
X-Forwarded-Encrypted: i=1; AJvYcCVyTeWOr8BT5SmCpYK4zBW5tgLZyRoCVrapZawIkFPJqdE9GtGC6qD2YzjTK4VF7D7glf7aeXWAPcGGx6FpAnVUMnS1IRWqbNoxiH8NJg==
X-Gm-Message-State: AOJu0Yxtzj0SG6cyDAVykts9uKJJaAOJn2RGlHXoZaLrzih03N2ii3eZ
	02Y9No/mBcLKLrus9sTk2FSLlCbqF4i03DrPcOiQnHlBTevgtTW0nQ+YjbifktdXpoq7H498VG0
	bem677p9/4xYY7IVkhd+C0u2jLhDwtAF7sAchAWkLeyYyCCX54xQPuCQ=
X-Google-Smtp-Source: AGHT+IHdxmzQcsJ0w8ZisIwE3r88UrYAWXTva2Ki/AmHJtrdn767r1hao9i3C9HkpmzwMWLvPcik6Nf4f/lVULdtS85kG4BXN1ah
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:7101:b0:488:77ea:f194 with SMTP id
 8926c6da1cb9f-4895903263emr1748489173.5.1716063628615; Sat, 18 May 2024
 13:20:28 -0700 (PDT)
Date: Sat, 18 May 2024 13:20:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fef47e0618c0327f@google.com>
Subject: [syzbot] [exfat?] possible deadlock in exfat_evict_inode
From: syzbot <syzbot+412a392a2cd4a65e71db@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6bfd2d442af5 Merge tag 'irq-core-2024-05-12' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162ea96c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=395546166dcfe360
dashboard link: https://syzkaller.appspot.com/bug?extid=412a392a2cd4a65e71db
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-6bfd2d44.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ad901fe99c6/vmlinux-6bfd2d44.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8d6ef2df621f/bzImage-6bfd2d44.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+412a392a2cd4a65e71db@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-01893-g6bfd2d442af5 #0 Not tainted
------------------------------------------------------
kswapd0/112 is trying to acquire lock:
ffff88801d68c0e0 (&sbi->s_lock#2){+.+.}-{3:3}, at: exfat_evict_inode+0x25b/0x340 fs/exfat/inode.c:725

but task is already holding lock:
ffffffff8d9390c0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x1a10 mm/vmscan.c:6782

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       slab_pre_alloc_hook mm/slub.c:3819 [inline]
       slab_alloc_node mm/slub.c:3900 [inline]
       __do_kmalloc_node mm/slub.c:4038 [inline]
       __kmalloc+0xb5/0x440 mm/slub.c:4052
       kmalloc_array include/linux/slab.h:665 [inline]
       __exfat_get_dentry_set+0x81e/0xa90 fs/exfat/dir.c:816
       exfat_get_dentry_set+0x36/0x210 fs/exfat/dir.c:859
       exfat_get_uniname_from_ext_entry fs/exfat/dir.c:39 [inline]
       exfat_readdir+0x950/0x1520 fs/exfat/dir.c:155
       exfat_iterate+0x3c7/0xad0 fs/exfat/dir.c:261
       wrap_directory_iterator+0xa5/0xe0 fs/readdir.c:67
       iterate_dir+0x292/0x9e0 fs/readdir.c:110
       __do_sys_getdents64 fs/readdir.c:409 [inline]
       __se_sys_getdents64 fs/readdir.c:394 [inline]
       __ia32_sys_getdents64+0x14f/0x2e0 fs/readdir.c:394
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (&sbi->s_lock#2){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       exfat_evict_inode+0x25b/0x340 fs/exfat/inode.c:725
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
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

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&sbi->s_lock#2);
                               lock(fs_reclaim);
  lock(&sbi->s_lock#2);

 *** DEADLOCK ***

2 locks held by kswapd0/112:
 #0: ffffffff8d9390c0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x1a10 mm/vmscan.c:6782
 #1: ffff88801d6880e0 (&type->s_umount_key#87){++++}-{3:3}, at: super_trylock_shared fs/super.c:561 [inline]
 #1: ffff88801d6880e0 (&type->s_umount_key#87){++++}-{3:3}, at: super_cache_scan+0x96/0x550 fs/super.c:196

stack backtrace:
CPU: 2 PID: 112 Comm: kswapd0 Not tainted 6.9.0-syzkaller-01893-g6bfd2d442af5 #0
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
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 exfat_evict_inode+0x25b/0x340 fs/exfat/inode.c:725
 evict+0x2ed/0x6c0 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
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

