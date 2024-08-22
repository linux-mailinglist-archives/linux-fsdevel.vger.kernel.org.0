Return-Path: <linux-fsdevel+bounces-26688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBD195B071
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 10:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4468E1C227A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 08:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFE716A955;
	Thu, 22 Aug 2024 08:32:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E83955884
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315549; cv=none; b=g32QgQe5vUetXwbTKaMNuiH06C2ojlpnqav2TaGg3J5Cw+oMfNOhYmk2P31DxM0DHaceztiv2G0bStE0UVf1jgUYUBnWDeWWAJrUdocbEUpZ9I03Rc+t+CpEU42DTTblEZXK/R5YMzLMDu++b+s43rtYmGU1DsuNa6biOTx3WYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315549; c=relaxed/simple;
	bh=PhwET8MorGmV9omtIqma82cZcOadVe7K1vfr7Oy1XHE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nLGGvtydkG9r9hY8cJKbcabpIYB1lc4i+8BOO/8A6avg/wtgnsFb/8HVf8QoWds5CIP+Z+f/aCukQpygPCsbRoi/WF6TOiZtqoth8BC3zpm/wgEbYTsOHJ/QuQEQWNx3w7KQOLvQg43T2NOgD+mlxFQ30xpJd3fnoH6zuX/evfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d4a4e4a78so6058285ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 01:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315547; x=1724920347;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1clqBl0c8o8uNY4gpe2BS0a6L+cXSYWbuSVqKy3PZQ=;
        b=aBvgNoLL/Yh33lvBjVgLUJ0WLz3NErgecm+5YychAXXB+slQJ6MNO58RKnwKw96sbO
         OFJKSGB3VKILq2FObSxlgKq6eaL4WmvZ86qfQRVuTh5C826hFF2QxDhRJc2q+nDOWuuv
         Zn0C93ryKw1Rr9D/FCamfsUSsrH1pN+BIHrapliGC/LKd3vCzegA+alDuDYCNDTMpfyy
         DnydH3XgaN+f/OA+NKEJvCM7OX7flSvqjZQCdW3C3hurfAnKZxk2cXpPPdLfv3j/ihJ2
         hlvF4DYOia0f2omF36C2AocSoIatcGCW/V3jKqk/cKnEJxROOdsjnIiWQcpSXTm3hO6s
         2Z3g==
X-Forwarded-Encrypted: i=1; AJvYcCW0GEd+qoVtVitJuVzfmEEdxB8SS16YhWse7bEDARQduTkUa7WqHbphGEakOqQdCBt4nLD263VGs8ciF9Ub@vger.kernel.org
X-Gm-Message-State: AOJu0YwdV+kWG2t2kBax5XGlXDucPu3Dshdp7LO8yj576aCkIrjsjbvP
	rdlxp8x1EcpFt5jcRlND5tAd3t0DsGf/dM4XCT3NU7Mz0vOKHgppGBZMiudzLOrl31kX7haQxmp
	qvD3tDCFlKoIbrpAYzGRdWngFhpyrJPYxGH8mkcemRfSLSVY2Ixt+CHI=
X-Google-Smtp-Source: AGHT+IF/1gaKHJrgKi3x5LpxoIrQNpEryF7V9g0HW3NQA8/F3WLctv6nsIveMaLzTf5MXmATNd+2WDwiynGP1sgtHYwDH/jvLecC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2192:b0:39a:e800:eec9 with SMTP id
 e9e14a558f8ab-39d6c3d8505mr3550645ab.4.1724315547356; Thu, 22 Aug 2024
 01:32:27 -0700 (PDT)
Date: Thu, 22 Aug 2024 01:32:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae63710620417f67@google.com>
Subject: [syzbot] [squashfs?] possible deadlock in fsnotify_destroy_mark
From: syzbot <syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk, 
	squashfs-devel@lists.sourceforge.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b311c1b497e5 Merge tag '6.11-rc4-server-fixes' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10351047980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=c679f13773f295d2da53
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1247776b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121bb693980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-b311c1b4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1c99fa48192f/vmlinux-b311c1b4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16d5710a012a/bzImage-b311c1b4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d59520377407/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc4-syzkaller-00019-gb311c1b497e5 #0 Not tainted
------------------------------------------------------
kswapd0/78 is trying to acquire lock:
ffff88801b8d8930 (&group->mark_mutex){+.+.}-{3:3}, at: fsnotify_group_lock include/linux/fsnotify_backend.h:270 [inline]
ffff88801b8d8930 (&group->mark_mutex){+.+.}-{3:3}, at: fsnotify_destroy_mark+0x38/0x3c0 fs/notify/mark.c:578

but task is already holding lock:
ffffffff8ea2fd60 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6841 [inline]
ffffffff8ea2fd60 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbb4/0x35a0 mm/vmscan.c:7223

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __fs_reclaim_acquire mm/page_alloc.c:3818 [inline]
       fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3832
       might_alloc include/linux/sched/mm.h:334 [inline]
       slab_pre_alloc_hook mm/slub.c:3939 [inline]
       slab_alloc_node mm/slub.c:4017 [inline]
       kmem_cache_alloc_noprof+0x3d/0x2a0 mm/slub.c:4044
       inotify_new_watch fs/notify/inotify/inotify_user.c:599 [inline]
       inotify_update_watch fs/notify/inotify/inotify_user.c:647 [inline]
       __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:786 [inline]
       __se_sys_inotify_add_watch+0x72e/0x1070 fs/notify/inotify/inotify_user.c:729
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&group->mark_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       fsnotify_group_lock include/linux/fsnotify_backend.h:270 [inline]
       fsnotify_destroy_mark+0x38/0x3c0 fs/notify/mark.c:578
       fsnotify_destroy_marks+0x14a/0x660 fs/notify/mark.c:934
       fsnotify_inoderemove include/linux/fsnotify.h:264 [inline]
       dentry_unlink_inode+0x2e0/0x430 fs/dcache.c:403
       __dentry_kill+0x20d/0x630 fs/dcache.c:610
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1055
       shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1082
       prune_dcache_sb+0x10f/0x180 fs/dcache.c:1163
       super_cache_scan+0x34f/0x4b0 fs/super.c:221
       do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
       shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
       shrink_one+0x43b/0x850 mm/vmscan.c:4815
       shrink_many mm/vmscan.c:4876 [inline]
       lru_gen_shrink_node mm/vmscan.c:4954 [inline]
       shrink_node+0x3799/0x3de0 mm/vmscan.c:5934
       kswapd_shrink_node mm/vmscan.c:6762 [inline]
       balance_pgdat mm/vmscan.c:6954 [inline]
       kswapd+0x1bcd/0x35a0 mm/vmscan.c:7223
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&group->mark_mutex);
                               lock(fs_reclaim);
  lock(&group->mark_mutex);

 *** DEADLOCK ***

2 locks held by kswapd0/78:
 #0: ffffffff8ea2fd60 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6841 [inline]
 #0: ffffffff8ea2fd60 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbb4/0x35a0 mm/vmscan.c:7223
 #1: ffff8880385580e0 (&type->s_umount_key#44){++++}-{3:3}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff8880385580e0 (&type->s_umount_key#44){++++}-{3:3}, at: super_cache_scan+0x94/0x4b0 fs/super.c:196

stack backtrace:
CPU: 0 UID: 0 PID: 78 Comm: kswapd0 Not tainted 6.11.0-rc4-syzkaller-00019-gb311c1b497e5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 fsnotify_group_lock include/linux/fsnotify_backend.h:270 [inline]
 fsnotify_destroy_mark+0x38/0x3c0 fs/notify/mark.c:578
 fsnotify_destroy_marks+0x14a/0x660 fs/notify/mark.c:934
 fsnotify_inoderemove include/linux/fsnotify.h:264 [inline]
 dentry_unlink_inode+0x2e0/0x430 fs/dcache.c:403
 __dentry_kill+0x20d/0x630 fs/dcache.c:610
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1055
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1082
 prune_dcache_sb+0x10f/0x180 fs/dcache.c:1163
 super_cache_scan+0x34f/0x4b0 fs/super.c:221
 do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
 shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
 shrink_one+0x43b/0x850 mm/vmscan.c:4815
 shrink_many mm/vmscan.c:4876 [inline]
 lru_gen_shrink_node mm/vmscan.c:4954 [inline]
 shrink_node+0x3799/0x3de0 mm/vmscan.c:5934
 kswapd_shrink_node mm/vmscan.c:6762 [inline]
 balance_pgdat mm/vmscan.c:6954 [inline]
 kswapd+0x1bcd/0x35a0 mm/vmscan.c:7223
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

