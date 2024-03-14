Return-Path: <linux-fsdevel+bounces-14386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE65D87BA6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 10:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE121F228F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 09:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540876CDDC;
	Thu, 14 Mar 2024 09:31:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F63D6CDBD
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408687; cv=none; b=OeCYHttXYq2G45tEAX9ggExvVgYzQ7/6QhNiB7S6oy7b6vkklizVNYDWPR5CDCc5yJcKgnw6V4rAYAbI2r1FzXIIYBQuxSpcvhV9e7D6SDVVFX4CWDMGHto/0lchUt/AEy89TgQtejE3xGqhZNWsDnuiGoJdLJ4lHzMlftRdS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408687; c=relaxed/simple;
	bh=hMKxZ5S7+ZBl00klWulG1PpgRzwMfKsTjpUQ7uBdNrM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PeyCL344p/+/FnyTYG7lP9+STuDITg4pOKLcb1HAOYA3Sh2vZcIuh3cYolko4Mdf9DlE6czeghGrN/7Yr0Nig1pnvo5oun6+SPyjMYLir1NArGdEfoyEDKX6P9+URXdkLCE8seUm0You0GMzAy6MyAtMJyUqp0gjxTtgVmGLbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3663d77a143so9870535ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 02:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408684; x=1711013484;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gll4Ztt7M0UGElLQXVLWEpzqDUUYuPg1P4YvKq0ZUe4=;
        b=mL5Ab6jCNQblA5p0J4agQl5h+VSYmzwS2TpA6/zlN2WXX7Dm6o/XKFa8i4y/5VT0tk
         wO6YA78tA9bcqVljFyI1NdaBv24Mc9eruLczExV2zmIezdrmt2+6JR3LVH2vkIgIikLC
         S42PCv2lN75VjlreQC8nlHsiPFL76W/9T+PR/9A+waEhWMsPSBW5TvRTIJUWNNNCuvYg
         wAsyK2HROGsOGzHTC7UU0s+64KvOlevO/6RiPMUZV49/33VKBMLiqFJqbWAHTa2nlI/x
         6l+EAw2oNJpH04sHNpYYZlaeqLUmPG9idYSRZC24Gbkfmnxg8EJG7HUnWvixvyymDW1C
         Vr0g==
X-Forwarded-Encrypted: i=1; AJvYcCWqqVnPYPY6ukI3Efg654Y5m5tl4SdlHBFk/BgqfnHwqD1zKZWINjI7kdTOMrfkgAAAp46MWbuSBk6j+5pQcGGvkpw4fq1NN/NlKQ4+sw==
X-Gm-Message-State: AOJu0YwkGx0SmRP6QDdF12DfU4cO4G7RYLFXBK42ueBU85b65TPw80sk
	r19yffo292iNe3MregFfJoYRABjvmv3tGk7LZHP8r7R5WsnWgwPVwAUNCCRG8RpPkPPLqrQWn9E
	FuYzA2JKIA6hEfQdpNj2w+dB9wPWNxQj+golz/HolzUdi/hSj/w86K9s=
X-Google-Smtp-Source: AGHT+IFWrX0NsTpryB9bD1F2qhaXzg46a4KylBy4kxp5SE7W9VCzIsXMjDXE7FqQt8+Z7CjpAYUbV4X8T41mS8EPgv+ku+Ex28YU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e7:b0:366:725b:57a5 with SMTP id
 l7-20020a056e0212e700b00366725b57a5mr15747iln.3.1710408684433; Thu, 14 Mar
 2024 02:31:24 -0700 (PDT)
Date: Thu, 14 Mar 2024 02:31:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e826906139b8e88@google.com>
Subject: [syzbot] [xfs?] possible deadlock in xfs_ilock
From: syzbot <syzbot+d247769793ec169e4bf9@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e5e038b7ae9d Merge tag 'fs_for_v6.9-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1276d246180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ce8d253b68e67fe
dashboard link: https://syzkaller.appspot.com/bug?extid=d247769793ec169e4bf9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e5e038b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82ab7eda09bc/vmlinux-e5e038b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bda17336e65d/bzImage-e5e038b7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d247769793ec169e4bf9@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-06619-ge5e038b7ae9d #0 Not tainted
------------------------------------------------------
kswapd1/112 is trying to acquire lock:
ffff88804a8f6d98 (&xfs_dir_ilock_class){++++}-{3:3}, at: xfs_ilock+0x2ef/0x3e0 fs/xfs/xfs_inode.c:206

but task is already holding lock:
ffffffff8d92fb40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x15f/0x1a90 mm/vmscan.c:6774

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3692 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:3706
       might_alloc include/linux/sched/mm.h:303 [inline]
       slab_pre_alloc_hook mm/slub.c:3746 [inline]
       slab_alloc_node mm/slub.c:3827 [inline]
       kmem_cache_alloc+0x4f/0x320 mm/slub.c:3852
       radix_tree_node_alloc.constprop.0+0x7c/0x350 lib/radix-tree.c:276
       radix_tree_extend+0x1a2/0x4d0 lib/radix-tree.c:425
       __radix_tree_create lib/radix-tree.c:613 [inline]
       radix_tree_insert+0x499/0x630 lib/radix-tree.c:712
       xfs_qm_dqget_cache_insert.constprop.0+0x38/0x2c0 fs/xfs/xfs_dquot.c:826
       xfs_qm_dqget+0x182/0x4a0 fs/xfs/xfs_dquot.c:901
       xfs_qm_vop_dqalloc+0x49a/0xe10 fs/xfs/xfs_qm.c:1755
       xfs_setattr_nonsize+0x8ca/0xca0 fs/xfs/xfs_iops.c:707
       xfs_vn_setattr+0x209/0x260 fs/xfs/xfs_iops.c:1027
       notify_change+0x742/0x11c0 fs/attr.c:497
       chown_common+0x598/0x660 fs/open.c:790
       do_fchownat+0x1af/0x210 fs/open.c:821
       ksys_lchown include/linux/syscalls.h:1243 [inline]
       __do_sys_lchown16 kernel/uid16.c:30 [inline]
       __se_sys_lchown16 kernel/uid16.c:28 [inline]
       __ia32_sys_lchown16+0xe6/0x120 kernel/uid16.c:28
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x7a/0x120 arch/x86/entry/common.c:321
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:346
       entry_SYSENTER_compat_after_hwframe+0x7a/0x84

-> #1 (&qinf->qi_tree_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       xfs_qm_dqget_cache_lookup+0x66/0x820 fs/xfs/xfs_dquot.c:784
       xfs_qm_dqget_inode+0x1e7/0x6d0 fs/xfs/xfs_dquot.c:986
       xfs_qm_dqattach_one+0x26f/0x530 fs/xfs/xfs_qm.c:278
       xfs_qm_dqattach_locked+0x1c6/0x2d0 fs/xfs/xfs_qm.c:337
       xfs_qm_vop_dqalloc+0x344/0xe10 fs/xfs/xfs_qm.c:1710
       xfs_setattr_nonsize+0x8ca/0xca0 fs/xfs/xfs_iops.c:707
       xfs_vn_setattr+0x209/0x260 fs/xfs/xfs_iops.c:1027
       notify_change+0x742/0x11c0 fs/attr.c:497
       chown_common+0x598/0x660 fs/open.c:790
       do_fchownat+0x1af/0x210 fs/open.c:821
       ksys_lchown include/linux/syscalls.h:1243 [inline]
       __do_sys_lchown16 kernel/uid16.c:30 [inline]
       __se_sys_lchown16 kernel/uid16.c:28 [inline]
       __ia32_sys_lchown16+0xe6/0x120 kernel/uid16.c:28
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x7a/0x120 arch/x86/entry/common.c:321
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:346
       entry_SYSENTER_compat_after_hwframe+0x7a/0x84

-> #0 (&xfs_dir_ilock_class){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
       down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1695
       xfs_ilock+0x2ef/0x3e0 fs/xfs/xfs_inode.c:206
       xfs_reclaim_inode fs/xfs/xfs_icache.c:945 [inline]
       xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1631 [inline]
       xfs_icwalk_ag+0xca6/0x1740 fs/xfs/xfs_icache.c:1713
       xfs_icwalk+0x57/0x100 fs/xfs/xfs_icache.c:1762
       xfs_reclaim_inodes_nr+0x182/0x250 fs/xfs/xfs_icache.c:1011
       super_cache_scan+0x409/0x550 fs/super.c:227
       do_shrink_slab+0x44f/0x1160 mm/shrinker.c:435
       shrink_slab+0x18a/0x1310 mm/shrinker.c:662
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

other info that might help us debug this:

Chain exists of:
  &xfs_dir_ilock_class --> &qinf->qi_tree_lock --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&qinf->qi_tree_lock);
                               lock(fs_reclaim);
  lock(&xfs_dir_ilock_class);

 *** DEADLOCK ***

2 locks held by kswapd1/112:
 #0: ffffffff8d92fb40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x15f/0x1a90 mm/vmscan.c:6774
 #1: ffff8880680100e0 (&type->s_umount_key#81){++++}-{3:3}, at: super_trylock_shared fs/super.c:561 [inline]
 #1: ffff8880680100e0 (&type->s_umount_key#81){++++}-{3:3}, at: super_cache_scan+0x96/0x550 fs/super.c:196

stack backtrace:
CPU: 2 PID: 112 Comm: kswapd1 Not tainted 6.8.0-syzkaller-06619-ge5e038b7ae9d #0
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
 down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1695
 xfs_ilock+0x2ef/0x3e0 fs/xfs/xfs_inode.c:206
 xfs_reclaim_inode fs/xfs/xfs_icache.c:945 [inline]
 xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1631 [inline]
 xfs_icwalk_ag+0xca6/0x1740 fs/xfs/xfs_icache.c:1713
 xfs_icwalk+0x57/0x100 fs/xfs/xfs_icache.c:1762
 xfs_reclaim_inodes_nr+0x182/0x250 fs/xfs/xfs_icache.c:1011
 super_cache_scan+0x409/0x550 fs/super.c:227
 do_shrink_slab+0x44f/0x1160 mm/shrinker.c:435
 shrink_slab+0x18a/0x1310 mm/shrinker.c:662
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

