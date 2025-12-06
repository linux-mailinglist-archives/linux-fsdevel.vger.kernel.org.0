Return-Path: <linux-fsdevel+bounces-70935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C95CAA1F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 07:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0196317587B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 06:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D18222578;
	Sat,  6 Dec 2025 06:49:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5E42D77F1
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Dec 2025 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765003770; cv=none; b=hxcesP00OFwTawm6Y0s3Y7mynrUMBhVcxYTsttd+oRF42Jkql5oe56v/vjH+z9cxMo0lMVlyzbVPvu+/LaABfi/OR95I4dVEthuDn1zh011RRxIqhlFd3dUt4ifixqdHvhEsVzob71aZBiFCd2gLKxxeXVp7h2cVJl/g3l2hwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765003770; c=relaxed/simple;
	bh=y8zWfHfVpBQAV43gr76hJ4gWNmwple65RwrtFIzd7gs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VSK+nHzbJ0vYqGO/oKEm4obTeTBXMODrX3gnE5Zf5xOBeQoJmKq8fcTD87iMLgqtwplWr2R0lO5O77Fzovlz/sTXsbgqrPoa+nMsIVUmBhL56sCozy0s1O2LTsHT+yY1380jjjza4jHL2bqWi/8IHdH9fgtitag1J5C3KWBd1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7c79200d1a4so6656894a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 22:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765003765; x=1765608565;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53jhX6ZkfDtbSr/7nsfdTJHuLIu8j7dR1m9t5B2vy/M=;
        b=IGBXBAYmRbYXT9PYWmn4kEBEGM9hoV7gUxksvPz1Z4ummK31vA85sTzadDGMtDcCt5
         SeWC+ky9wCyJE69AQIZTCEPc/F7k9rNoLypIUKCM4lRyVKH1uiywQXZZ1SMsiO06oODe
         EZJZsQTCEEpGl39Gin4UMJdeth6MsfqWoTKOfs0TQZ45TDMn/jRrxzh6jCs5xOsYJfOx
         G5me++NrJHvycMvBzHbKsjD7d5neuT7KAelGNGSLeAEEUFC6sEcHxe8IrTavHm2FLw4U
         Z1Vidt7O5Dgs5E8AQfg6rBsDFT9YIR+RTzTUXUItnRP/157Rgb2QhZQyV8GWqN5KdzWx
         aiiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+FJHOUKrgwiI/NcDvHb5FqURZeqB6SaYjPOdAZ84vF+54+OVoYPRSx2YOtEglxXroG0ZJhrzDkBpEEth1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq7MIwuDUXZuqkYkQBvj5AnUwAYCyAGnEgkGS2dVEnDFParagW
	ikbKLMSY34xjH/JaflBHxG2IpTq3ZRVnHr8gC1sJHoE31cIOnk7B7oieu9++8icI905yMRed8pq
	/6K2QuRXJVtprexm2xMEkHR+/bTTyCw+cqLw8nNM6wpVJRX/JL5Hzw0fGNuY=
X-Google-Smtp-Source: AGHT+IHK2ZzO983I4dQNyVYMjfr7Al7eSNO8+6rayFow2cLRe5QbhFak9Yc0MuWjS1KmKTB/ngYfw/rZiRDmcKSGASi2WvaijVtk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6607:b0:659:9a49:8e2c with SMTP id
 006d021491bc7-6599a49c3d7mr682160eaf.30.1765003765128; Fri, 05 Dec 2025
 22:49:25 -0800 (PST)
Date: Fri, 05 Dec 2025 22:49:25 -0800
In-Reply-To: <68c8fd75.050a0220.2ff435.03bd.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6933d1f5.a70a0220.38f243.0016.GAE@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in do_writepages (2)
From: syzbot <syzbot+756f498a88797cda9299@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d1d36025a617 Merge tag 'probes-v6.19' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c5821a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96b1065fc3079f82
dashboard link: https://syzkaller.appspot.com/bug?extid=756f498a88797cda9299
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10133c1a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16178992580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/01358f3e734d/disk-d1d36025.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8c72ac5de2c8/vmlinux-d1d36025.xz
kernel image: https://storage.googleapis.com/syzbot-assets/44b0ffcb520c/bzImage-d1d36025.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8c26f8a66fe2/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=12bc02c2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+756f498a88797cda9299@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 512
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/6041 is trying to acquire lock:
ffff88803394eb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x27a/0x600 mm/page-writeback.c:2598

but task is already holding lock:
ffff888059c16aa8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:164 [inline]
ffff888059c16aa8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:6389 [inline]
ffff888059c16aa8 (&ei->xattr_sem){++++}-{4:4}, at: __ext4_mark_inode_dirty+0x4ba/0x840 fs/ext4/inode.c:6470

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ei->xattr_sem){++++}-{4:4}:
       down_read+0x9b/0x460 kernel/locking/rwsem.c:1537
       ext4_setattr+0x869/0x28d0 fs/ext4/inode.c:5865
       notify_change+0x6d2/0x1290 fs/attr.c:546
       chown_common+0x549/0x680 fs/open.c:788
       do_fchownat+0x1a7/0x200 fs/open.c:819
       __do_sys_chown fs/open.c:839 [inline]
       __se_sys_chown fs/open.c:837 [inline]
       __x64_sys_chown+0x7b/0xc0 fs/open.c:837
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (jbd2_handle){++++}-{0:0}:
       wait_transaction_locked+0x191/0x230 fs/jbd2/transaction.c:151
       add_transaction_credits+0x110/0xe60 fs/jbd2/transaction.c:222
       start_this_handle+0x3e7/0x1410 fs/jbd2/transaction.c:403
       jbd2__journal_start+0x394/0x6a0 fs/jbd2/transaction.c:501
       __ext4_journal_start_sb+0x195/0x640 fs/ext4/ext4_jbd2.c:114
       __ext4_journal_start fs/ext4/ext4_jbd2.h:242 [inline]
       ext4_do_writepages+0xc23/0x3c70 fs/ext4/inode.c:2914
       ext4_writepages+0x37a/0x7d0 fs/ext4/inode.c:3026
       do_writepages+0x27a/0x600 mm/page-writeback.c:2598
       __writeback_single_inode+0x168/0x14a0 fs/fs-writeback.c:1737
       writeback_sb_inodes+0x795/0x1de0 fs/fs-writeback.c:2030
       __writeback_inodes_wb+0xf8/0x2d0 fs/fs-writeback.c:2107
       wb_writeback+0x799/0xae0 fs/fs-writeback.c:2218
       wb_check_old_data_flush fs/fs-writeback.c:2322 [inline]
       wb_do_writeback fs/fs-writeback.c:2375 [inline]
       wb_workfn+0x8a0/0xbb0 fs/fs-writeback.c:2403
       process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
       process_scheduled_works kernel/workqueue.c:3340 [inline]
       worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
       kthread+0x3c5/0x780 kernel/kthread.c:463
       ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

-> #0 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x1542/0x22f0 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       ext4_writepages_down_read fs/ext4/ext4.h:1820 [inline]
       ext4_writepages+0x224/0x7d0 fs/ext4/inode.c:3025
       do_writepages+0x27a/0x600 mm/page-writeback.c:2598
       __writeback_single_inode+0x168/0x14a0 fs/fs-writeback.c:1737
       writeback_single_inode+0x5ea/0x11f0 fs/fs-writeback.c:1858
       write_inode_now+0x170/0x1e0 fs/fs-writeback.c:2924
       iput_final fs/inode.c:1941 [inline]
       iput.part.0+0x815/0x1190 fs/inode.c:2003
       iput+0x35/0x40 fs/inode.c:1966
       ext4_xattr_block_set+0x67c/0x3640 fs/ext4/xattr.c:2203
       ext4_xattr_move_to_block fs/ext4/xattr.c:2668 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
       ext4_expand_extra_isize_ea+0x1442/0x1ab0 fs/ext4/xattr.c:2831
       __ext4_expand_extra_isize+0x346/0x480 fs/ext4/inode.c:6349
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:6392 [inline]
       __ext4_mark_inode_dirty+0x544/0x840 fs/ext4/inode.c:6470
       ext4_evict_inode+0x713/0x1730 fs/ext4/inode.c:253
       evict+0x3c2/0xad0 fs/inode.c:837
       iput_final fs/inode.c:1951 [inline]
       iput.part.0+0x621/0x1190 fs/inode.c:2003
       iput+0x35/0x40 fs/inode.c:1966
       ext4_orphan_cleanup+0x731/0x11e0 fs/ext4/orphan.c:472
       __ext4_fill_super fs/ext4/super.c:5658 [inline]
       ext4_fill_super+0x7ec1/0xb570 fs/ext4/super.c:5777
       get_tree_bdev_flags+0x38c/0x620 fs/super.c:1699
       vfs_get_tree+0x8e/0x330 fs/super.c:1759
       fc_mount fs/namespace.c:1199 [inline]
       do_new_mount_fc fs/namespace.c:3636 [inline]
       do_new_mount fs/namespace.c:3712 [inline]
       path_mount+0x7bf/0x23a0 fs/namespace.c:4022
       do_mount fs/namespace.c:4035 [inline]
       __do_sys_mount fs/namespace.c:4224 [inline]
       __se_sys_mount fs/namespace.c:4201 [inline]
       __x64_sys_mount+0x293/0x310 fs/namespace.c:4201
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
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

3 locks held by syz.0.17/6041:
 #0: ffff88803394c0e0 (&type->s_umount_key#27/1){+.+.}-{4:4}, at: alloc_super+0x244/0xd00 fs/super.c:344
 #1: ffff88803394c610 (sb_internal){.+.+}-{0:0}, at: evict+0x3c2/0xad0 fs/inode.c:837
 #2: ffff888059c16aa8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:164 [inline]
 #2: ffff888059c16aa8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:6389 [inline]
 #2: ffff888059c16aa8 (&ei->xattr_sem){++++}-{4:4}, at: __ext4_mark_inode_dirty+0x4ba/0x840 fs/ext4/inode.c:6470

stack backtrace:
CPU: 1 UID: 0 PID: 6041 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x2db/0x410 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x1542/0x22f0 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
 ext4_writepages_down_read fs/ext4/ext4.h:1820 [inline]
 ext4_writepages+0x224/0x7d0 fs/ext4/inode.c:3025
 do_writepages+0x27a/0x600 mm/page-writeback.c:2598
 __writeback_single_inode+0x168/0x14a0 fs/fs-writeback.c:1737
 writeback_single_inode+0x5ea/0x11f0 fs/fs-writeback.c:1858
 write_inode_now+0x170/0x1e0 fs/fs-writeback.c:2924
 iput_final fs/inode.c:1941 [inline]
 iput.part.0+0x815/0x1190 fs/inode.c:2003
 iput+0x35/0x40 fs/inode.c:1966
 ext4_xattr_block_set+0x67c/0x3640 fs/ext4/xattr.c:2203
 ext4_xattr_move_to_block fs/ext4/xattr.c:2668 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
 ext4_expand_extra_isize_ea+0x1442/0x1ab0 fs/ext4/xattr.c:2831
 __ext4_expand_extra_isize+0x346/0x480 fs/ext4/inode.c:6349
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6392 [inline]
 __ext4_mark_inode_dirty+0x544/0x840 fs/ext4/inode.c:6470
 ext4_evict_inode+0x713/0x1730 fs/ext4/inode.c:253
 evict+0x3c2/0xad0 fs/inode.c:837
 iput_final fs/inode.c:1951 [inline]
 iput.part.0+0x621/0x1190 fs/inode.c:2003
 iput+0x35/0x40 fs/inode.c:1966
 ext4_orphan_cleanup+0x731/0x11e0 fs/ext4/orphan.c:472
 __ext4_fill_super fs/ext4/super.c:5658 [inline]
 ext4_fill_super+0x7ec1/0xb570 fs/ext4/super.c:5777
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1699
 vfs_get_tree+0x8e/0x330 fs/super.c:1759
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount fs/namespace.c:3712 [inline]
 path_mount+0x7bf/0x23a0 fs/namespace.c:4022
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount fs/namespace.c:4201 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4201
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f24b8790eea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe9c113938 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe9c1139c0 RCX: 00007f24b8790eea
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007ffe9c113980
RBP: 0000200000000180 R08: 00007ffe9c1139c0 R09: 0000000000800700
R10: 0000000000800700 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007ffe9c113980 R14: 000000000000046f R15: 000000000000002c
 </TASK>
------------[ cut here ]------------
EA inode 11 i_nlink=2
WARNING: fs/ext4/xattr.c:1056 at 0x0, CPU#0: syz.0.17/6041
Modules linked in:
CPU: 0 UID: 0 PID: 6041 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:ext4_xattr_inode_update_ref+0x4be/0x5b0 fs/ext4/xattr.c:1056
Code: 40 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f1 00 00 00 48 8d 3d 09 d6 fb 0d 48 8b 73 40 44 89 e2 <67> 48 0f b9 3a e9 06 ff ff ff e8 23 c7 2c ff 48 8d 7b 40 48 b8 00
RSP: 0018:ffffc900033c7178 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff888059d59f78 RCX: ffffffff82915db4
RDX: 0000000000000002 RSI: 000000000000000b RDI: ffffffff908d34b0
RBP: ffffc900033c7240 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000002
R13: ffffffffffffffff R14: 1ffff92000678e32 R15: ffff888059d5a168
FS:  00005555694d6500(0000) GS:ffff88812495e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005641e7f0f078 CR3: 00000000744a9000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_xattr_inode_dec_ref fs/ext4/xattr.c:1081 [inline]
 ext4_xattr_set_entry+0x158f/0x1f00 fs/ext4/xattr.c:1723
 ext4_xattr_ibody_set+0x3d6/0x5d0 fs/ext4/xattr.c:2272
 ext4_xattr_move_to_block fs/ext4/xattr.c:2675 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
 ext4_expand_extra_isize_ea+0x148c/0x1ab0 fs/ext4/xattr.c:2831
 __ext4_expand_extra_isize+0x346/0x480 fs/ext4/inode.c:6349
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6392 [inline]
 __ext4_mark_inode_dirty+0x544/0x840 fs/ext4/inode.c:6470
 ext4_evict_inode+0x713/0x1730 fs/ext4/inode.c:253
 evict+0x3c2/0xad0 fs/inode.c:837
 iput_final fs/inode.c:1951 [inline]
 iput.part.0+0x621/0x1190 fs/inode.c:2003
 iput+0x35/0x40 fs/inode.c:1966
 ext4_orphan_cleanup+0x731/0x11e0 fs/ext4/orphan.c:472
 __ext4_fill_super fs/ext4/super.c:5658 [inline]
 ext4_fill_super+0x7ec1/0xb570 fs/ext4/super.c:5777
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1699
 vfs_get_tree+0x8e/0x330 fs/super.c:1759
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount fs/namespace.c:3712 [inline]
 path_mount+0x7bf/0x23a0 fs/namespace.c:4022
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount fs/namespace.c:4201 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4201
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f24b8790eea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe9c113938 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe9c1139c0 RCX: 00007f24b8790eea
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007ffe9c113980
RBP: 0000200000000180 R08: 00007ffe9c1139c0 R09: 0000000000800700
R10: 0000000000800700 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007ffe9c113980 R14: 000000000000046f R15: 000000000000002c
 </TASK>
----------------
Code disassembly (best guess):
   0:	40                   	rex
   1:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   8:	fc ff df
   b:	48 89 fa             	mov    %rdi,%rdx
   e:	48 c1 ea 03          	shr    $0x3,%rdx
  12:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  16:	0f 85 f1 00 00 00    	jne    0x10d
  1c:	48 8d 3d 09 d6 fb 0d 	lea    0xdfbd609(%rip),%rdi        # 0xdfbd62c
  23:	48 8b 73 40          	mov    0x40(%rbx),%rsi
  27:	44 89 e2             	mov    %r12d,%edx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 06 ff ff ff       	jmp    0xffffff3a
  34:	e8 23 c7 2c ff       	call   0xff2cc75c
  39:	48 8d 7b 40          	lea    0x40(%rbx),%rdi
  3d:	48                   	rex.W
  3e:	b8                   	.byte 0xb8


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

