Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE42E31AAE6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 11:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhBMKjF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Feb 2021 05:39:05 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:54185 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhBMKjA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Feb 2021 05:39:00 -0500
Received: by mail-il1-f197.google.com with SMTP id s12so1870022ilh.20
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Feb 2021 02:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RZYFbsN8qP5Eq/QNYsQmM0bOQ1fzIM1OiYZbXtFQAig=;
        b=Ti1lzco76XsuKFc+S5TPHiGAuKqmHBy9LvWjI+HwpqbV6feNkI8IhY/+ypg80q8WKK
         /14vmfR7rwWQhMr/swxyzA9GQUBikW3+VL86+39kydaYYNb/tpsbMzT9Nipa88CSs2qF
         hhUMH1ZsnI7CeF4hFCyxtB0NeAT1YPOTNf/QlejHEys5uErcDTC+msDRTz0GtWSlyQm1
         OmWI4gkMZmhWtjWSkl1S1rg+cJ9bpEWJB5pc2MpvSBsL+lGa5Jbm46dJdSLOa0xbmBSP
         GRS5LwIj7Pdfm4MT3P+0f3UJSduV9o0nItKIC9Gz5CSCLixxE/ezyIou/yCQYrgpZkv+
         QVLw==
X-Gm-Message-State: AOAM532GeVL3G+eqiccZXCAKwhhW8RxlaZCkkZng0aF328SfY3lG1wHB
        rVNCrTYybhhwgAA9+7db8BkGwMHBfed2iUh8ndgZ+doMT497
X-Google-Smtp-Source: ABdhPJylMogbIUg2MJ7L7zcAHjErOhcrm2Q81aVR5NeX4tw/5teVP6b/je1DtCwQa46s4DC4gCsOPe5gFwWXU0K8UDSiUZcYrnJ8
MIME-Version: 1.0
X-Received: by 2002:a92:d0c3:: with SMTP id y3mr6146636ila.116.1613212698956;
 Sat, 13 Feb 2021 02:38:18 -0800 (PST)
Date:   Sat, 13 Feb 2021 02:38:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de58b305bb355903@google.com>
Subject: possible deadlock in evict
From:   syzbot <syzbot+1b2c6989ec12e467d65c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c6d8570e Merge tag 'io_uring-5.11-2021-02-12' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123a4be2d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bec717fd4ac4bf03
dashboard link: https://syzkaller.appspot.com/bug?extid=1b2c6989ec12e467d65c

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b2c6989ec12e467d65c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.11.0-rc7-syzkaller #0 Not tainted
------------------------------------------------------
kswapd0/2232 is trying to acquire lock:
ffff88801f552650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x6b0 fs/inode.c:577

but task is already holding lock:
ffffffff8be89240 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30 mm/page_alloc.c:5195

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4326 [inline]
       fs_reclaim_acquire+0x117/0x150 mm/page_alloc.c:4340
       might_alloc include/linux/sched/mm.h:193 [inline]
       slab_pre_alloc_hook mm/slab.h:493 [inline]
       slab_alloc_node mm/slab.c:3221 [inline]
       kmem_cache_alloc_node_trace+0x48/0x520 mm/slab.c:3596
       __do_kmalloc_node mm/slab.c:3618 [inline]
       __kmalloc_node+0x38/0x60 mm/slab.c:3626
       kmalloc_node include/linux/slab.h:575 [inline]
       kvmalloc_node+0x61/0xf0 mm/util.c:587
       kvmalloc include/linux/mm.h:781 [inline]
       ext4_xattr_inode_cache_find fs/ext4/xattr.c:1465 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1508 [inline]
       ext4_xattr_set_entry+0x1ce6/0x3780 fs/ext4/xattr.c:1649
       ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2224
       ext4_xattr_set_handle+0x8f4/0x13e0 fs/ext4/xattr.c:2380
       ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2493
       __vfs_setxattr+0x10e/0x170 fs/xattr.c:177
       __vfs_setxattr_noperm+0x11a/0x4c0 fs/xattr.c:208
       __vfs_setxattr_locked+0x1bf/0x250 fs/xattr.c:266
       vfs_setxattr+0x135/0x320 fs/xattr.c:291
       setxattr+0x1ff/0x290 fs/xattr.c:553
       path_setxattr+0x170/0x190 fs/xattr.c:572
       __do_sys_setxattr fs/xattr.c:587 [inline]
       __se_sys_setxattr fs/xattr.c:583 [inline]
       __x64_sys_setxattr+0xc0/0x160 fs/xattr.c:583
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #2 (&ei->xattr_sem){++++}-{3:3}:
       down_write+0x8d/0x150 kernel/locking/rwsem.c:1406
       ext4_write_lock_xattr fs/ext4/xattr.h:142 [inline]
       ext4_xattr_set_handle+0x15c/0x13e0 fs/ext4/xattr.c:2308
       ext4_initxattrs+0xb5/0x120 fs/ext4/xattr_security.c:43
       security_inode_init_security+0x1c4/0x370 security/security.c:1054
       __ext4_new_inode+0x3963/0x5570 fs/ext4/ialloc.c:1317
       ext4_create+0x2c3/0x4c0 fs/ext4/namei.c:2613
       lookup_open.isra.0+0xf85/0x1350 fs/namei.c:3106
       open_last_lookups fs/namei.c:3180 [inline]
       path_openat+0x96d/0x2730 fs/namei.c:3368
       do_filp_open+0x17e/0x3c0 fs/namei.c:3398
       do_sys_openat2+0x16d/0x420 fs/open.c:1172
       do_sys_open fs/open.c:1188 [inline]
       __do_sys_open fs/open.c:1196 [inline]
       __se_sys_open fs/open.c:1192 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1192
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0xfb4/0x1380 fs/jbd2/transaction.c:446
       jbd2__journal_start+0x399/0x930 fs/jbd2/transaction.c:503
       __ext4_journal_start_sb+0x227/0x4a0 fs/ext4/ext4_jbd2.c:105
       ext4_sample_last_mounted fs/ext4/file.c:804 [inline]
       ext4_file_open+0x613/0xb40 fs/ext4/file.c:832
       do_dentry_open+0x4b9/0x11b0 fs/open.c:817
       do_open fs/namei.c:3254 [inline]
       path_openat+0x1b9a/0x2730 fs/namei.c:3371
       do_filp_open+0x17e/0x3c0 fs/namei.c:3398
       do_sys_openat2+0x16d/0x420 fs/open.c:1172
       do_sys_open fs/open.c:1188 [inline]
       __do_sys_open fs/open.c:1196 [inline]
       __se_sys_open fs/open.c:1192 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1192
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (sb_internal){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:2868 [inline]
       check_prevs_add kernel/locking/lockdep.c:2993 [inline]
       validate_chain kernel/locking/lockdep.c:3608 [inline]
       __lock_acquire+0x2b26/0x54f0 kernel/locking/lockdep.c:4832
       lock_acquire kernel/locking/lockdep.c:5442 [inline]
       lock_acquire+0x1a8/0x720 kernel/locking/lockdep.c:5407
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1592 [inline]
       sb_start_intwrite include/linux/fs.h:1709 [inline]
       ext4_evict_inode+0xe6f/0x1940 fs/ext4/inode.c:241
       evict+0x2ed/0x6b0 fs/inode.c:577
       iput_final fs/inode.c:1653 [inline]
       iput.part.0+0x57e/0x810 fs/inode.c:1679
       iput fs/inode.c:1669 [inline]
       inode_lru_isolate+0x301/0x4f0 fs/inode.c:778
       __list_lru_walk_one+0x178/0x5c0 mm/list_lru.c:222
       list_lru_walk_one+0x99/0xd0 mm/list_lru.c:266
       list_lru_shrink_walk include/linux/list_lru.h:195 [inline]
       prune_icache_sb+0xdc/0x140 fs/inode.c:803
       super_cache_scan+0x38d/0x590 fs/super.c:107
       do_shrink_slab+0x3e4/0x9f0 mm/vmscan.c:511
       shrink_slab+0x16f/0x5d0 mm/vmscan.c:672
       shrink_node_memcgs mm/vmscan.c:2665 [inline]
       shrink_node+0x8cc/0x1de0 mm/vmscan.c:2780
       kswapd_shrink_node mm/vmscan.c:3523 [inline]
       balance_pgdat+0x745/0x1270 mm/vmscan.c:3681
       kswapd+0x5b1/0xdb0 mm/vmscan.c:3938
       kthread+0x3b1/0x4a0 kernel/kthread.c:292
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

other info that might help us debug this:

Chain exists of:
  sb_internal --> &ei->xattr_sem --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&ei->xattr_sem);
                               lock(fs_reclaim);
  lock(sb_internal);

 *** DEADLOCK ***

3 locks held by kswapd0/2232:
 #0: ffffffff8be89240 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30 mm/page_alloc.c:5195
 #1: ffffffff8be50770 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0xc7/0x5d0 mm/vmscan.c:662
 #2: ffff88801f5520e0 (&type->s_umount_key#49){++++}-{3:3}, at: trylock_super fs/super.c:418 [inline]
 #2: ffff88801f5520e0 (&type->s_umount_key#49){++++}-{3:3}, at: super_cache_scan+0x6c/0x590 fs/super.c:80

stack backtrace:
CPU: 3 PID: 2232 Comm: kswapd0 Not tainted 5.11.0-rc7-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2117
 check_prev_add kernel/locking/lockdep.c:2868 [inline]
 check_prevs_add kernel/locking/lockdep.c:2993 [inline]
 validate_chain kernel/locking/lockdep.c:3608 [inline]
 __lock_acquire+0x2b26/0x54f0 kernel/locking/lockdep.c:4832
 lock_acquire kernel/locking/lockdep.c:5442 [inline]
 lock_acquire+0x1a8/0x720 kernel/locking/lockdep.c:5407
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1592 [inline]
 sb_start_intwrite include/linux/fs.h:1709 [inline]
 ext4_evict_inode+0xe6f/0x1940 fs/ext4/inode.c:241
 evict+0x2ed/0x6b0 fs/inode.c:577
 iput_final fs/inode.c:1653 [inline]
 iput.part.0+0x57e/0x810 fs/inode.c:1679
 iput fs/inode.c:1669 [inline]
 inode_lru_isolate+0x301/0x4f0 fs/inode.c:778
 __list_lru_walk_one+0x178/0x5c0 mm/list_lru.c:222
 list_lru_walk_one+0x99/0xd0 mm/list_lru.c:266
 list_lru_shrink_walk include/linux/list_lru.h:195 [inline]
 prune_icache_sb+0xdc/0x140 fs/inode.c:803
 super_cache_scan+0x38d/0x590 fs/super.c:107
 do_shrink_slab+0x3e4/0x9f0 mm/vmscan.c:511
 shrink_slab+0x16f/0x5d0 mm/vmscan.c:672
 shrink_node_memcgs mm/vmscan.c:2665 [inline]
 shrink_node+0x8cc/0x1de0 mm/vmscan.c:2780
 kswapd_shrink_node mm/vmscan.c:3523 [inline]
 balance_pgdat+0x745/0x1270 mm/vmscan.c:3681
 kswapd+0x5b1/0xdb0 mm/vmscan.c:3938
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
