Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44F07AA7F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 06:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjIVEvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 00:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjIVEvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:51:52 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CABCA
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 21:51:45 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1bf2e81ce63so2909007fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 21:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695358305; x=1695963105;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qn/FrH1988scFKcjduSlmqXu2bsNtqi414x0P0dQ8I=;
        b=XzSrjNhc9+vFvHHeTDPJ7XkNDdfxBjDEh3HJApmES2Dwq6YsTfFYHSIEolLh2C+LV/
         XLppGn9vbOnQSVY6zXgxcg5e/Bggj8CczwwHmuZ+oBcGt1rly2Ie91meVJysl0zao4+Y
         3BQ5KM4y6vzrpeY9kEvhbXG/coEo35urq9AWpjMygavUS2/pcLu3PeNtoJRBc4ZP+blG
         UGwNzEzEWsDWsKlPH37gwOsOA2qstTaKk4b2sZCg6VaIhaCCQsMKiHxZF7ZEzt36zB9M
         uosAgSYOLKwLXKFn+PIt/RWYSnO0ZxUBG2qdiWqD37V7Z3cD2Kx1GbimJnmMHINvDhxh
         i3CQ==
X-Gm-Message-State: AOJu0YzySFOOkgdetXR4NXT26yWKzCf/JsHmounKswdc7LrONeIr35GZ
        BKTqUiShkn+ulDkTPgmSw1n2VDW05dByrhBVVD8Mc+MUvfCt
X-Google-Smtp-Source: AGHT+IF1lSM14uPdDSV4IGWUdgZdpHokDRGfRP8LnwwkAzngXlRvnTOjtPwMtDdNbhGGG/qt+yimh6c5iwpUHRA4oWDukobCmZrG
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3e0d:b0:1dc:7909:91fa with SMTP id
 lk13-20020a0568703e0d00b001dc790991famr724923oab.2.1695358305264; Thu, 21 Sep
 2023 21:51:45 -0700 (PDT)
Date:   Thu, 21 Sep 2023 21:51:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d6a8b0605eb5dfd@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_xattr_set_handle (4)
From:   syzbot <syzbot+ea0ba556b26f54698271@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e789286468a9 Merge tag 'x86-urgent-2023-09-17' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f3cef8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dea9a2f141d69d34
dashboard link: https://syzkaller.appspot.com/bug?extid=ea0ba556b26f54698271
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e7892864.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1429a45d2526/vmlinux-e7892864.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7b5ffe979a44/bzImage-e7892864.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea0ba556b26f54698271@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc1-syzkaller-00269-ge789286468a9 #0 Not tainted
------------------------------------------------------
syz-executor.2/16393 is trying to acquire lock:
ffff88801c2532c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
ffff88801c2532c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x159/0x1420 fs/ext4/xattr.c:2371

but task is already holding lock:
ffff8880444e0988 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x10d6/0x15e0 fs/jbd2/transaction.c:463

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0x10fc/0x15e0 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x391/0x690 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x40f/0x5c0 fs/ext4/ext4_jbd2.c:112
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_dirty_inode+0xa1/0x130 fs/ext4/inode.c:5953
       __mark_inode_dirty+0x1e0/0xd50 fs/fs-writeback.c:2430
       mark_inode_dirty_sync include/linux/fs.h:2271 [inline]
       iput.part.0+0x5b/0x7a0 fs/inode.c:1798
       iput+0x5c/0x80 fs/inode.c:1791
       dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
       __dentry_kill+0x3b8/0x640 fs/dcache.c:607
       shrink_dentry_list+0x22b/0x7d0 fs/dcache.c:1201
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1282
       super_cache_scan+0x31f/0x540 fs/super.c:228
       do_shrink_slab+0x422/0xaa0 mm/vmscan.c:900
       shrink_slab+0x17f/0x6e0 mm/vmscan.c:1060
       shrink_one+0x4f7/0x700 mm/vmscan.c:5417
       shrink_many mm/vmscan.c:5469 [inline]
       lru_gen_shrink_node mm/vmscan.c:5586 [inline]
       shrink_node+0x20d4/0x37a0 mm/vmscan.c:6526
       kswapd_shrink_node mm/vmscan.c:7331 [inline]
       balance_pgdat+0xa32/0x1b80 mm/vmscan.c:7521
       kswapd+0x5be/0xbf0 mm/vmscan.c:7781
       kthread+0x33c/0x440 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3551 [inline]
       fs_reclaim_acquire+0x100/0x150 mm/page_alloc.c:3565
       might_alloc include/linux/sched/mm.h:303 [inline]
       slab_pre_alloc_hook mm/slab.h:709 [inline]
       slab_alloc_node mm/slub.c:3460 [inline]
       __kmem_cache_alloc_node+0x51/0x340 mm/slub.c:3517
       __do_kmalloc_node mm/slab_common.c:1022 [inline]
       __kmalloc_node+0x52/0x110 mm/slab_common.c:1030
       kmalloc_node include/linux/slab.h:619 [inline]
       kvmalloc_node+0x99/0x1a0 mm/util.c:607
       kvmalloc include/linux/slab.h:737 [inline]
       ext4_xattr_inode_cache_find fs/ext4/xattr.c:1535 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1577 [inline]
       ext4_xattr_set_entry+0x1c3d/0x3ca0 fs/ext4/xattr.c:1719
       ext4_xattr_block_set+0x678/0x30e0 fs/ext4/xattr.c:1970
       ext4_xattr_move_to_block fs/ext4/xattr.c:2667 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2742 [inline]
       ext4_expand_extra_isize_ea+0x1306/0x1b20 fs/ext4/xattr.c:2834
       __ext4_expand_extra_isize+0x342/0x470 fs/ext4/inode.c:5803
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:5846 [inline]
       __ext4_mark_inode_dirty+0x52b/0x800 fs/ext4/inode.c:5924
       __ext4_unlink+0x630/0xc60 fs/ext4/namei.c:3296
       ext4_unlink+0x40d/0x580 fs/ext4/namei.c:3325
       vfs_unlink+0x2f1/0x900 fs/namei.c:4332
       do_unlinkat+0x3da/0x6d0 fs/namei.c:4398
       __do_sys_unlinkat fs/namei.c:4441 [inline]
       __se_sys_unlinkat fs/namei.c:4434 [inline]
       __ia32_sys_unlinkat+0xc1/0x130 fs/namei.c:4434
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x61/0xe0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

-> #0 (&ei->xattr_sem){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
       down_write+0x93/0x200 kernel/locking/rwsem.c:1573
       ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
       ext4_xattr_set_handle+0x159/0x1420 fs/ext4/xattr.c:2371
       ext4_xattr_set+0x149/0x370 fs/ext4/xattr.c:2558
       __vfs_setxattr+0x173/0x1d0 fs/xattr.c:201
       __vfs_setxattr_noperm+0x127/0x5e0 fs/xattr.c:235
       __vfs_setxattr_locked+0x17e/0x250 fs/xattr.c:296
       vfs_setxattr+0x146/0x350 fs/xattr.c:322
       do_setxattr+0x142/0x170 fs/xattr.c:630
       setxattr+0x159/0x170 fs/xattr.c:653
       __do_sys_fsetxattr fs/xattr.c:709 [inline]
       __se_sys_fsetxattr fs/xattr.c:698 [inline]
       __ia32_sys_fsetxattr+0x25e/0x310 fs/xattr.c:698
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x61/0xe0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

other info that might help us debug this:

Chain exists of:
  &ei->xattr_sem --> fs_reclaim --> jbd2_handle

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(jbd2_handle);
                               lock(fs_reclaim);
                               lock(jbd2_handle);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

3 locks held by syz-executor.2/16393:
 #0: ffff88801a440410 (sb_writers#4){.+.+}-{0:0}, at: __do_sys_fsetxattr fs/xattr.c:707 [inline]
 #0: ffff88801a440410 (sb_writers#4){.+.+}-{0:0}, at: __se_sys_fsetxattr fs/xattr.c:698 [inline]
 #0: ffff88801a440410 (sb_writers#4){.+.+}-{0:0}, at: __ia32_sys_fsetxattr+0x17a/0x310 fs/xattr.c:698
 #1: ffff88801c253600 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #1: ffff88801c253600 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: vfs_setxattr+0x123/0x350 fs/xattr.c:321
 #2: ffff8880444e0988 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x10d6/0x15e0 fs/jbd2/transaction.c:463

stack backtrace:
CPU: 0 PID: 16393 Comm: syz-executor.2 Not tainted 6.6.0-rc1-syzkaller-00269-ge789286468a9 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 down_write+0x93/0x200 kernel/locking/rwsem.c:1573
 ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 ext4_xattr_set_handle+0x159/0x1420 fs/ext4/xattr.c:2371
 ext4_xattr_set+0x149/0x370 fs/ext4/xattr.c:2558
 __vfs_setxattr+0x173/0x1d0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x127/0x5e0 fs/xattr.c:235
 __vfs_setxattr_locked+0x17e/0x250 fs/xattr.c:296
 vfs_setxattr+0x146/0x350 fs/xattr.c:322
 do_setxattr+0x142/0x170 fs/xattr.c:630
 setxattr+0x159/0x170 fs/xattr.c:653
 __do_sys_fsetxattr fs/xattr.c:709 [inline]
 __se_sys_fsetxattr fs/xattr.c:698 [inline]
 __ia32_sys_fsetxattr+0x25e/0x310 fs/xattr.c:698
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x61/0xe0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7fbe579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7fb95ac EFLAGS: 00000292 ORIG_RAX: 00000000000000e4
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000020000140
RDX: 0000000020000180 RSI: 0000000000000015 RDI: 0000000000000003
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

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
