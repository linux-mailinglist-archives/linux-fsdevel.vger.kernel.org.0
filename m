Return-Path: <linux-fsdevel+bounces-14694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9387E294
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 04:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8933C1C210F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 03:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB71F951;
	Mon, 18 Mar 2024 03:33:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28221E894
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710732807; cv=none; b=S4X2dRA/baHGTtFgHVtLuQ7PzgB+KTAzRMc2laXG/xRS3FeVd9BuvHiPjiVMwUl9L87r3Dxg3q1lr+tQhLjiEC6gtXCvpGfhl+z6nVLubnorloRsgysH6/QEsndJlOLxq/SEVivu9TLoDfpl6B0jQdokWJKRM21Mf0/8am1JzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710732807; c=relaxed/simple;
	bh=EKX/BoqH2xh7vLFoFuFbTNxN4uqm7h9FUn62+QaYMWc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WunziS9CI/mB2aYPffaE8db2aRKsmqq2Fg/ZiUGPGZaVvWCCDwBWXauProAIRfniduVK9AWkB+BcdJnH+R/wX7ZYJIvB591CByLZROQiQcH8uvR/P4AxZBTzeGj/R/Y5XDg6qIdisEPbb4ID8RcXVkNcG4hVvw1+cFRd96VWAT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbf092a502so281900239f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 20:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710732805; x=1711337605;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZQRlhpQy04eICqIiJFN4t+eSrK3itKipVK5z5y5BB4=;
        b=ZQ5w4WodIfGUaLEzviJwf8usWIKlUaq3qLts9dg6n2EKAPv6dvEdoz8cAbzC5bf2G6
         KZp8SxV+BW5eBOOYS/3TUJoQsUBf+hAoOcEWhu89MsE1ybUtrbJOhozAV9JARvGvziIj
         /odgVPO6Cqs2xuM2pXdzkBuCFRBq7iKxyEHQXqOKFgf2Dm0BmVb18jvWiATbIMv+2Xrb
         jSo8gMihW4G9wEVKxFHBbsY6jLHnYYgjNgfSZfAIkbdP+VZk+oK9lVEXRgClz5JjQx3x
         Z6E0UdJLa6hJ3lR8PBQbMTp+iLrt0FQsg2RReYJmSgLmHxw8QmvSnCrTWL7i/7Mls++u
         snEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiQMJ+MyxRLi44BmP/eh/ZUplBMqVkmke+XecbJ55pinz4uS3Wl+X89tpZGaE//4S3WO3bFIkIpS2QmRX1A2PKZFEpZcUeibe71Tlh/w==
X-Gm-Message-State: AOJu0Yx3uxpB2QODuv59NCTjCO0TPmPhyfEQUt3sOl6gRhgPgzhbJmP8
	xFH2AjgtUlZ+SvVCt3Uo9MfkX+wAwlTAQIlRtU8zz1nsMuMUb1TwycN//QwEzkMILEeexm4KOnl
	P2qjNL5auLoVF+/B4On+KbTk00jCf3CaIxsPrcUjdbo2jmWW6cDt+pF0=
X-Google-Smtp-Source: AGHT+IElnSkGRoPKItnwHRYH64SRbKNnM/ZRhN1t08+4bYkpeWbvsSssn989Ds6UrO7W+WZ7ITnEuRpYcAYJ2q+a2GB+Isvf1uur
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1529:b0:366:3766:6c2d with SMTP id
 i9-20020a056e02152900b0036637666c2dmr493125ilu.1.1710732804866; Sun, 17 Mar
 2024 20:33:24 -0700 (PDT)
Date: Sun, 17 Mar 2024 20:33:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023d51d0613e70545@google.com>
Subject: [syzbot] [ext4?] possible deadlock in __ext4_mark_inode_dirty (3)
From: syzbot <syzbot+72c7e5a0d9f5901e864e@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e5e038b7ae9d Merge tag 'fs_for_v6.9-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14dbc646180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ce8d253b68e67fe
dashboard link: https://syzkaller.appspot.com/bug?extid=72c7e5a0d9f5901e864e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e5e038b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82ab7eda09bc/vmlinux-e5e038b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bda17336e65d/bzImage-e5e038b7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72c7e5a0d9f5901e864e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-06619-ge5e038b7ae9d #0 Not tainted
------------------------------------------------------
syz-executor.1/20321 is trying to acquire lock:
ffffffff8d92fb40 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:303 [inline]
ffffffff8d92fb40 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:3746 [inline]
ffffffff8d92fb40 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3827 [inline]
ffffffff8d92fb40 (fs_reclaim){+.+.}-{0:0}, at: __do_kmalloc_node mm/slub.c:3965 [inline]
ffffffff8d92fb40 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_node+0xbb/0x480 mm/slub.c:3973

but task is already holding lock:
ffff88802023b2c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:162 [inline]
ffff88802023b2c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:5829 [inline]
ffff88802023b2c8 (&ei->xattr_sem){++++}-{3:3}, at: __ext4_mark_inode_dirty+0x4cf/0x860 fs/ext4/inode.c:5910

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ei->xattr_sem){++++}-{3:3}:
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
       ext4_xattr_set_handle+0x159/0x1660 fs/ext4/xattr.c:2371
       __ext4_set_acl+0x366/0x5d0 fs/ext4/acl.c:217
       ext4_set_acl+0x2a0/0x5a0 fs/ext4/acl.c:259
       set_posix_acl+0x25c/0x320 fs/posix_acl.c:955
       vfs_remove_acl+0x2d1/0x630 fs/posix_acl.c:1242
       ovl_do_remove_acl fs/overlayfs/overlayfs.h:349 [inline]
       ovl_workdir_create+0x4a5/0x820 fs/overlayfs/super.c:340
       ovl_make_workdir fs/overlayfs/super.c:656 [inline]
       ovl_get_workdir fs/overlayfs/super.c:814 [inline]
       ovl_fill_super+0xe60/0x6960 fs/overlayfs/super.c:1382
       vfs_get_super fs/super.c:1268 [inline]
       get_tree_nodev+0xda/0x190 fs/super.c:1287
       vfs_get_tree+0x8f/0x380 fs/super.c:1779
       do_new_mount fs/namespace.c:3352 [inline]
       path_mount+0x6e1/0x1f10 fs/namespace.c:3679
       do_mount fs/namespace.c:3692 [inline]
       __do_sys_mount fs/namespace.c:3898 [inline]
       __se_sys_mount fs/namespace.c:3875 [inline]
       __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x7a/0x120 arch/x86/entry/common.c:321
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:346
       entry_SYSENTER_compat_after_hwframe+0x7a/0x84

-> #2 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0x114b/0x1620 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x2a6/0x8f0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x358/0x600 fs/ext4/ext4_jbd2.c:112
       ext4_sample_last_mounted fs/ext4/file.c:837 [inline]
       ext4_file_open+0x636/0xc80 fs/ext4/file.c:866
       do_dentry_open+0x8da/0x18c0 fs/open.c:955
       do_open fs/namei.c:3642 [inline]
       path_openat+0x1dfb/0x2990 fs/namei.c:3799
       do_filp_open+0x1dc/0x430 fs/namei.c:3826
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_openat fs/open.c:1437 [inline]
       __se_sys_openat fs/open.c:1432 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1432
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #1 (sb_internal){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1662 [inline]
       sb_start_intwrite include/linux/fs.h:1845 [inline]
       ext4_evict_inode+0xe3a/0x1a30 fs/ext4/inode.c:212
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x573/0x7c0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x440 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x32a/0x550 fs/super.c:221
       do_shrink_slab+0x44f/0x1160 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7b0 mm/vmscan.c:4767
       shrink_many mm/vmscan.c:4828 [inline]
       lru_gen_shrink_node mm/vmscan.c:4929 [inline]
       shrink_node+0x2191/0x3770 mm/vmscan.c:5888
       kswapd_shrink_node mm/vmscan.c:6696 [inline]
       balance_pgdat+0x9d0/0x1a90 mm/vmscan.c:6886
       kswapd+0x5c1/0xc10 mm/vmscan.c:7146
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
       __fs_reclaim_acquire mm/page_alloc.c:3692 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:3706
       might_alloc include/linux/sched/mm.h:303 [inline]
       slab_pre_alloc_hook mm/slub.c:3746 [inline]
       slab_alloc_node mm/slub.c:3827 [inline]
       __do_kmalloc_node mm/slub.c:3965 [inline]
       __kmalloc_node+0xbb/0x480 mm/slub.c:3973
       kmalloc_node include/linux/slab.h:648 [inline]
       kvmalloc_node+0x9d/0x1a0 mm/util.c:634
       kvmalloc include/linux/slab.h:766 [inline]
       ext4_xattr_inode_cache_find fs/ext4/xattr.c:1535 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1577 [inline]
       ext4_xattr_set_entry+0x193c/0x3b20 fs/ext4/xattr.c:1719
       ext4_xattr_block_set+0x69c/0x3110 fs/ext4/xattr.c:1970
       ext4_xattr_move_to_block fs/ext4/xattr.c:2667 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2742 [inline]
       ext4_expand_extra_isize_ea+0xf57/0x1990 fs/ext4/xattr.c:2834
       __ext4_expand_extra_isize+0x322/0x450 fs/ext4/inode.c:5789
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:5832 [inline]
       __ext4_mark_inode_dirty+0x55a/0x860 fs/ext4/inode.c:5910
       ext4_inline_data_truncate+0x602/0xc80 fs/ext4/inline.c:1994
       ext4_truncate+0x990/0x13a0 fs/ext4/inode.c:4102
       ext4_setattr+0x1a3a/0x29d0 fs/ext4/inode.c:5454
       notify_change+0x742/0x11c0 fs/attr.c:497
       do_truncate+0x15c/0x220 fs/open.c:65
       handle_truncate fs/namei.c:3300 [inline]
       do_open fs/namei.c:3646 [inline]
       path_openat+0x24b9/0x2990 fs/namei.c:3799
       do_filp_open+0x1dc/0x430 fs/namei.c:3826
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_creat fs/open.c:1497 [inline]
       __se_sys_creat fs/open.c:1491 [inline]
       __ia32_sys_creat+0xcc/0x120 fs/open.c:1491
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x7a/0x120 arch/x86/entry/common.c:321
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:346
       entry_SYSENTER_compat_after_hwframe+0x7a/0x84

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> jbd2_handle --> &ei->xattr_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->xattr_sem);
                               lock(jbd2_handle);
                               lock(&ei->xattr_sem);
  lock(fs_reclaim);

 *** DEADLOCK ***

4 locks held by syz-executor.1/20321:
 #0: ffff888047dd0420 (sb_writers#4){.+.+}-{0:0}, at: do_open fs/namei.c:3635 [inline]
 #0: ffff888047dd0420 (sb_writers#4){.+.+}-{0:0}, at: path_openat+0x1fba/0x2990 fs/namei.c:3799
 #1: ffff88802023b600 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
 #1: ffff88802023b600 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: do_truncate+0x14b/0x220 fs/open.c:63
 #2: ffff88802023b7a0 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:838 [inline]
 #2: ffff88802023b7a0 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_setattr+0xdfd/0x29d0 fs/ext4/inode.c:5378
 #3: ffff88802023b2c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:162 [inline]
 #3: ffff88802023b2c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:5829 [inline]
 #3: ffff88802023b2c8 (&ei->xattr_sem){++++}-{3:3}, at: __ext4_mark_inode_dirty+0x4cf/0x860 fs/ext4/inode.c:5910

stack backtrace:
CPU: 1 PID: 20321 Comm: syz-executor.1 Not tainted 6.8.0-syzkaller-06619-ge5e038b7ae9d #0
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
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
 __fs_reclaim_acquire mm/page_alloc.c:3692 [inline]
 fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:3706
 might_alloc include/linux/sched/mm.h:303 [inline]
 slab_pre_alloc_hook mm/slub.c:3746 [inline]
 slab_alloc_node mm/slub.c:3827 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc_node+0xbb/0x480 mm/slub.c:3973
 kmalloc_node include/linux/slab.h:648 [inline]
 kvmalloc_node+0x9d/0x1a0 mm/util.c:634
 kvmalloc include/linux/slab.h:766 [inline]
 ext4_xattr_inode_cache_find fs/ext4/xattr.c:1535 [inline]
 ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1577 [inline]
 ext4_xattr_set_entry+0x193c/0x3b20 fs/ext4/xattr.c:1719
 ext4_xattr_block_set+0x69c/0x3110 fs/ext4/xattr.c:1970
 ext4_xattr_move_to_block fs/ext4/xattr.c:2667 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2742 [inline]
 ext4_expand_extra_isize_ea+0xf57/0x1990 fs/ext4/xattr.c:2834
 __ext4_expand_extra_isize+0x322/0x450 fs/ext4/inode.c:5789
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5832 [inline]
 __ext4_mark_inode_dirty+0x55a/0x860 fs/ext4/inode.c:5910
 ext4_inline_data_truncate+0x602/0xc80 fs/ext4/inline.c:1994
 ext4_truncate+0x990/0x13a0 fs/ext4/inode.c:4102
 ext4_setattr+0x1a3a/0x29d0 fs/ext4/inode.c:5454
 notify_change+0x742/0x11c0 fs/attr.c:497
 do_truncate+0x15c/0x220 fs/open.c:65
 handle_truncate fs/namei.c:3300 [inline]
 do_open fs/namei.c:3646 [inline]
 path_openat+0x24b9/0x2990 fs/namei.c:3799
 do_filp_open+0x1dc/0x430 fs/namei.c:3826
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_creat fs/open.c:1497 [inline]
 __se_sys_creat fs/open.c:1491 [inline]
 __ia32_sys_creat+0xcc/0x120 fs/open.c:1491
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x7a/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x7a/0x84
RIP: 0023:0xf734e579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5f485ac EFLAGS: 00000292 ORIG_RAX: 0000000000000008
RAX: ffffffffffffffda RBX: 0000000020000100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

