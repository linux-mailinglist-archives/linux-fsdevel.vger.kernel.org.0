Return-Path: <linux-fsdevel+bounces-14800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3C687F60C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 04:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281E01C21B14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 03:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C8C7BB11;
	Tue, 19 Mar 2024 03:33:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108E2F5B
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710819206; cv=none; b=Kd3eUqXVHFEs43I/HdesnSOcwbUwkksEaf4E1pLgRY0/szeXGuJdxRYz7W2aKLkR13UqKDpa68xJUnsS6TaVKowAr211Jym4hxhILhGumLjaWTFVzDYbyOo/myOCMdfnuBgnVm/pO7I+1yBZN65aAs2OEwr4Las/VJxWZhV+/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710819206; c=relaxed/simple;
	bh=foU7Dh8htpgGcaSBFSwvBOAYFXfZVzC57V6NEB1PYeI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fOgApTKxOgbVpERnxdYcid+lNoAbY3FqEtJ6n1sslxyIkh6ZKozobzgDXiw0UHjcrZzalPyyGLc5l/bbMt4WDhwAAw9JD36PL5qzi5jumOIFfc/QML8e6ktSToEujZ5Mv7OV5UpvQKScV2GpfUn4Aje04fMzGN+9Xr+fQKfPpjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36848e95617so4902425ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 20:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710819203; x=1711424003;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Csjh0lxNo0sPgq8PGq+TzcEtEY7UHn0bf829ioXWN0c=;
        b=i7gI7/FkJy3mBLnRhmMG0hPBhEEMZxTn0Yojl0HvEH98mwaQFxGrYW1hx1uM4yFcDY
         5YNbZABN5yf2VxToVGjiLRbDt2+kWTPQ69buNSg1YS9dpuJldsokIIgTpRW2yOH8A74/
         eNcdzEk3/cL4nnUg0HXNtelWBgrwWV1SegPG05V3gjcZ5rAVSrIX39bcd84ICcG7spYq
         udIcO7S+6NAyN/KqHryRnGcfPSL85+z5xWKiGX6zK5RJGXoZIGdQjgdLCK3WT/Y30wIx
         VVMxgs0f4I7pngqnTJFzVMDDGhJyyn9zHnJkkhJtkijeNQM4znAeQ9iR6i0l/VxMmtky
         KZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzukvMUsKLU1IA+ajL9m6kyY7TnioyWOQBTxIk3iCUtEhc2M3JLbh6Qx/MS31Mwn5iLIWemVUyAwaIMF3wN6u+UfuvLge1GvgRGpQFgQ==
X-Gm-Message-State: AOJu0YxZRFSg87wwP1pwUjHPnhSg3/bkT3M16l2yL191f+ZJVJ1W6IdL
	D4bZtqbztXQvBZWoPtdmiK6SFVVnrF3WolgE7kqGLQX1Kg77LmUVfnlC12y+KwJvW8nfEh8i+La
	DLvEQ4PM6mKMQUmNDo3wX6YSp6qeLP5ZXzE1krZ1x5+jzJKFjxXJaDe8=
X-Google-Smtp-Source: AGHT+IHCxtljGz0UAMsiGPWn/AccGbvldt5Q9YBlfC9M01nPa2qg+X1j8BikjRevWbkLwxSWbIWGJA2tNIdFANltpQFhwgUeAouO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d97:b0:366:97fc:b9cf with SMTP id
 h23-20020a056e021d9700b0036697fcb9cfmr91886ila.0.1710819203707; Mon, 18 Mar
 2024 20:33:23 -0700 (PDT)
Date: Mon, 18 Mar 2024 20:33:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e981c10613fb227e@google.com>
Subject: [syzbot] [xfs?] possible deadlock in xfs_qm_dqfree_one
From: syzbot <syzbot+b44399433a41aaed7a9f@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    906a93befec8 Merge tag 'efi-fixes-for-v6.9-1' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d6ea6e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5206351398500a90
dashboard link: https://syzkaller.appspot.com/bug?extid=b44399433a41aaed7a9f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-906a93be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f096ab7eaede/vmlinux-906a93be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52e0859d6157/bzImage-906a93be.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b44399433a41aaed7a9f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-11405-g906a93befec8 #0 Not tainted
------------------------------------------------------
kswapd0/109 is trying to acquire lock:
ffff888022fc0958 (&qinf->qi_tree_lock){+.+.}-{3:3}, at: xfs_qm_dqfree_one+0x6f/0x1a0 fs/xfs/xfs_qm.c:1654

but task is already holding lock:
ffffffff8d930be0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x19a0 mm/vmscan.c:6782

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       slab_pre_alloc_hook mm/slub.c:3746 [inline]
       slab_alloc_node mm/slub.c:3827 [inline]
       kmem_cache_alloc+0x4f/0x320 mm/slub.c:3852
       radix_tree_node_alloc.constprop.0+0x7c/0x350 lib/radix-tree.c:276
       radix_tree_extend+0x1a2/0x4d0 lib/radix-tree.c:425
       __radix_tree_create lib/radix-tree.c:613 [inline]
       radix_tree_insert+0x499/0x630 lib/radix-tree.c:712
       xfs_qm_dqget_cache_insert.constprop.0+0x38/0x2c0 fs/xfs/xfs_dquot.c:826
       xfs_qm_dqget+0x182/0x4a0 fs/xfs/xfs_dquot.c:901
       xfs_qm_scall_setqlim+0x172/0x1980 fs/xfs/xfs_qm_syscalls.c:300
       xfs_fs_set_dqblk+0x166/0x1e0 fs/xfs/xfs_quotaops.c:267
       quota_setquota+0x4c5/0x5f0 fs/quota/quota.c:310
       do_quotactl+0xb03/0x13e0 fs/quota/quota.c:802
       __do_sys_quotactl fs/quota/quota.c:961 [inline]
       __se_sys_quotactl fs/quota/quota.c:917 [inline]
       __x64_sys_quotactl+0x1b4/0x440 fs/quota/quota.c:917
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&qinf->qi_tree_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       xfs_qm_dqfree_one+0x6f/0x1a0 fs/xfs/xfs_qm.c:1654
       xfs_qm_shrink_scan+0x25c/0x3f0 fs/xfs/xfs_qm.c:531
       do_shrink_slab+0x44f/0x1160 mm/shrinker.c:435
       shrink_slab+0x18a/0x1310 mm/shrinker.c:662
       shrink_one+0x493/0x7c0 mm/vmscan.c:4774
       shrink_many mm/vmscan.c:4835 [inline]
       lru_gen_shrink_node mm/vmscan.c:4935 [inline]
       shrink_node+0x231f/0x3a80 mm/vmscan.c:5894
       kswapd_shrink_node mm/vmscan.c:6704 [inline]
       balance_pgdat+0x9a0/0x19a0 mm/vmscan.c:6895
       kswapd+0x5ea/0xb90 mm/vmscan.c:7164
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&qinf->qi_tree_lock);
                               lock(fs_reclaim);
  lock(&qinf->qi_tree_lock);

 *** DEADLOCK ***

1 lock held by kswapd0/109:
 #0: ffffffff8d930be0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x19a0 mm/vmscan.c:6782

stack backtrace:
CPU: 3 PID: 109 Comm: kswapd0 Not tainted 6.8.0-syzkaller-11405-g906a93befec8 #0
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
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 xfs_qm_dqfree_one+0x6f/0x1a0 fs/xfs/xfs_qm.c:1654
 xfs_qm_shrink_scan+0x25c/0x3f0 fs/xfs/xfs_qm.c:531
 do_shrink_slab+0x44f/0x1160 mm/shrinker.c:435
 shrink_slab+0x18a/0x1310 mm/shrinker.c:662
 shrink_one+0x493/0x7c0 mm/vmscan.c:4774
 shrink_many mm/vmscan.c:4835 [inline]
 lru_gen_shrink_node mm/vmscan.c:4935 [inline]
 shrink_node+0x231f/0x3a80 mm/vmscan.c:5894
 kswapd_shrink_node mm/vmscan.c:6704 [inline]
 balance_pgdat+0x9a0/0x19a0 mm/vmscan.c:6895
 kswapd+0x5ea/0xb90 mm/vmscan.c:7164
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

