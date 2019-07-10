Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC4164353
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 10:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfGJIHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 04:07:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:45558 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfGJIHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:07:07 -0400
Received: by mail-io1-f72.google.com with SMTP id e20so1973290ioe.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2019 01:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uTkNIwlqLg+Tqqlx3tT41C7xZjd5ibST0QpAbYYyVuM=;
        b=fFJ3ubYdGjSYwzyoiCerUSuECx+1wMv37r+iyEiWinA38rJihYeZPVn/hBc7LqP8Wm
         q5CaSEHTe2UOUMxB4zL7mfzySHpk2EAhuBH8xMEQwXWIyLF41lGfG/3UVe+BrtAwa03j
         wBIgglpN+rhNzcoX5BIA5sJvTZCxAsN6AjUbEx/RHCmrCxZ2xzRBptCPocmarVj9OxyR
         hv1vpe9Ro0KX76ykJQrZNPKJc8GQpriO+FMXdhNXYGuocvWlrrTnOl+ytYME4wAdMoTn
         L7QE4EnAnxWnXaX/4xjxu+H0gU4Mp7+aLsJcfJfIz70Wn/hTuZNKHCKhQYuax5YPkMaD
         vPEw==
X-Gm-Message-State: APjAAAW2IAoh43jyMCA5ObCkuuLxu08L41XlrEaZuIhUiKWpKgu0jQuv
        fdSgBGfdtKPQiCsuNzRAIlwmlvRxjoAqK09HFewVNgC1l1AZ
X-Google-Smtp-Source: APXvYqw0en/LUjinM/br1+W1bL4Z0mDfE3LbfPbFaVV8GeEWuk5lDEhIfg028PsikKqfvu+naSyAPqCNr2jGv0aK+7jrNfzC2SWq
MIME-Version: 1.0
X-Received: by 2002:a6b:ef06:: with SMTP id k6mr5543565ioh.70.1562746026106;
 Wed, 10 Jul 2019 01:07:06 -0700 (PDT)
Date:   Wed, 10 Jul 2019 01:07:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2a97a058d4f290b@google.com>
Subject: possible deadlock in shrink_dcache_parent
From:   syzbot <syzbot+9b4ec36f6faf3ddb9102@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4608a726 Add linux-next specific files for 20190709
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1126bd28600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a02e36d356a9a17
dashboard link: https://syzkaller.appspot.com/bug?extid=9b4ec36f6faf3ddb9102
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9b4ec36f6faf3ddb9102@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.2.0-next-20190709 #34 Not tainted
------------------------------------------------------
syz-executor.1/9214 is trying to acquire lock:
00000000eb8ccf4b (rename_lock#2){+.+.}, at: shrink_dcache_parent+0xb7/0x430  
fs/dcache.c:1544

but task is already holding lock:
000000002624bc34 (&(&dentry->d_lockref.lock)->rlock){+.+.}, at: spin_lock  
include/linux/spinlock.h:338 [inline]
000000002624bc34 (&(&dentry->d_lockref.lock)->rlock){+.+.}, at:  
shrink_dcache_parent+0x134/0x430 fs/dcache.c:1558

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&(&dentry->d_lockref.lock)->rlock){+.+.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
        spin_lock include/linux/spinlock.h:338 [inline]
        d_set_mounted+0x17e/0x2e0 fs/dcache.c:1434
        get_mountpoint+0x166/0x3f0 fs/namespace.c:724
        lock_mount+0xf1/0x2e0 fs/namespace.c:2131
        do_add_mount+0x27/0x380 fs/namespace.c:2669
        do_new_mount_fc fs/namespace.c:2730 [inline]
        do_new_mount fs/namespace.c:2785 [inline]
        do_mount+0x178f/0x1c30 fs/namespace.c:3103
        ksys_mount+0xdb/0x150 fs/namespace.c:3312
        devtmpfsd+0xbd/0x130 drivers/base/devtmpfs.c:397
        kthread+0x361/0x430 kernel/kthread.c:255
        ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

-> #0 (rename_lock#2){+.+.}:
        check_prev_add kernel/locking/lockdep.c:2405 [inline]
        check_prevs_add kernel/locking/lockdep.c:2507 [inline]
        validate_chain kernel/locking/lockdep.c:2897 [inline]
        __lock_acquire+0x25a9/0x4c30 kernel/locking/lockdep.c:3880
        lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4413
        seqcount_lockdep_reader_access include/linux/seqlock.h:81 [inline]
        read_seqcount_begin include/linux/seqlock.h:164 [inline]
        read_seqbegin include/linux/seqlock.h:433 [inline]
        read_seqbegin_or_lock include/linux/seqlock.h:529 [inline]
        d_walk+0xe8/0x950 fs/dcache.c:1277
        shrink_dcache_parent+0xb7/0x430 fs/dcache.c:1544
        vfs_rmdir fs/namei.c:3882 [inline]
        vfs_rmdir+0x26f/0x4f0 fs/namei.c:3857
        do_rmdir+0x39e/0x420 fs/namei.c:3940
        __do_sys_rmdir fs/namei.c:3958 [inline]
        __se_sys_rmdir fs/namei.c:3956 [inline]
        __x64_sys_rmdir+0x36/0x40 fs/namei.c:3956
        do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&(&dentry->d_lockref.lock)->rlock);
                                lock(rename_lock#2);
                                lock(&(&dentry->d_lockref.lock)->rlock);
   lock(rename_lock#2);

  *** DEADLOCK ***

4 locks held by syz-executor.1/9214:
  #0: 000000000bbde6ea (sb_writers#3){.+.+}, at: sb_start_write  
include/linux/fs.h:1625 [inline]
  #0: 000000000bbde6ea (sb_writers#3){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:354
  #1: 00000000a93efd69 (&type->i_mutex_dir_key#3/1){+.+.}, at:  
inode_lock_nested include/linux/fs.h:813 [inline]
  #1: 00000000a93efd69 (&type->i_mutex_dir_key#3/1){+.+.}, at:  
do_rmdir+0x271/0x420 fs/namei.c:3928
  #2: 000000000cbb3019 (&type->i_mutex_dir_key#3){++++}, at: inode_lock  
include/linux/fs.h:778 [inline]
  #2: 000000000cbb3019 (&type->i_mutex_dir_key#3){++++}, at: vfs_rmdir  
fs/namei.c:3868 [inline]
  #2: 000000000cbb3019 (&type->i_mutex_dir_key#3){++++}, at:  
vfs_rmdir+0xe5/0x4f0 fs/namei.c:3857
  #3: 000000002624bc34 (&(&dentry->d_lockref.lock)->rlock){+.+.}, at:  
spin_lock include/linux/spinlock.h:338 [inline]
  #3: 000000002624bc34 (&(&dentry->d_lockref.lock)->rlock){+.+.}, at:  
shrink_dcache_parent+0x134/0x430 fs/dcache.c:1558

stack backtrace:
CPU: 0 PID: 9214 Comm: syz-executor.1 Not tainted 5.2.0-next-20190709 #34
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_circular_bug.cold+0x163/0x172 kernel/locking/lockdep.c:1617
  check_noncircular+0x345/0x3e0 kernel/locking/lockdep.c:1741
  check_prev_add kernel/locking/lockdep.c:2405 [inline]
  check_prevs_add kernel/locking/lockdep.c:2507 [inline]
  validate_chain kernel/locking/lockdep.c:2897 [inline]
  __lock_acquire+0x25a9/0x4c30 kernel/locking/lockdep.c:3880
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4413
  seqcount_lockdep_reader_access include/linux/seqlock.h:81 [inline]
  read_seqcount_begin include/linux/seqlock.h:164 [inline]
  read_seqbegin include/linux/seqlock.h:433 [inline]
  read_seqbegin_or_lock include/linux/seqlock.h:529 [inline]
  d_walk+0xe8/0x950 fs/dcache.c:1277
  shrink_dcache_parent+0xb7/0x430 fs/dcache.c:1544
  vfs_rmdir fs/namei.c:3882 [inline]
  vfs_rmdir+0x26f/0x4f0 fs/namei.c:3857
  do_rmdir+0x39e/0x420 fs/namei.c:3940
  __do_sys_rmdir fs/namei.c:3958 [inline]
  __se_sys_rmdir fs/namei.c:3956 [inline]
  __x64_sys_rmdir+0x36/0x40 fs/namei.c:3956
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459537
Code: 00 66 90 b8 57 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 7d ba fb ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 54 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffea112f078 EFLAGS: 00000207 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 0000000000459537
RDX: 0000000000000000 RSI: 0000000000714698 RDI: 00007ffea11301b0
RBP: 0000000000000555 R08: 0000000000000000 R09: 0000000000000001
R10: 000000000000000a R11: 0000000000000207 R12: 00007ffea11301b0
R13: 0000555555709940 R14: 0000000000000000 R15: 00007ffea11301b0
BUG: sleeping function called from invalid context at fs/dcache.c:1551
in_atomic(): 1, irqs_disabled(): 0, pid: 9214, name: syz-executor.1
INFO: lockdep is turned off.
Preemption disabled at:
[<ffffffff81bc3e14>] spin_lock include/linux/spinlock.h:338 [inline]
[<ffffffff81bc3e14>] shrink_dcache_parent+0x134/0x430 fs/dcache.c:1558
CPU: 0 PID: 9214 Comm: syz-executor.1 Not tainted 5.2.0-next-20190709 #34
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  ___might_sleep.cold+0x1be/0x1f7 kernel/sched/core.c:6603
  shrink_dcache_parent+0xdc/0x430 fs/dcache.c:1551
  vfs_rmdir fs/namei.c:3882 [inline]
  vfs_rmdir+0x26f/0x4f0 fs/namei.c:3857
  do_rmdir+0x39e/0x420 fs/namei.c:3940
  __do_sys_rmdir fs/namei.c:3958 [inline]
  __se_sys_rmdir fs/namei.c:3956 [inline]
  __x64_sys_rmdir+0x36/0x40 fs/namei.c:3956
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459537
Code: 00 66 90 b8 57 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 7d ba fb ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 54 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffea112f078 EFLAGS: 00000207 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 0000000000459537
RDX: 0000000000000000 RSI: 0000000000714698 RDI: 00007ffea11301b0
RBP: 0000000000000555 R08: 0000000000000000 R09: 0000000000000001
R10: 000000000000000a R11: 0000000000000207 R12: 00007ffea11301b0
R13: 0000555555709940 R14: 0000000000000000 R15: 00007ffea11301b0
BUG: scheduling while atomic: syz-executor.1/9214/0x00000002
INFO: lockdep is turned off.
Modules linked in:
Preemption disabled at:
[<ffffffff81bc3e14>] spin_lock include/linux/spinlock.h:338 [inline]
[<ffffffff81bc3e14>] shrink_dcache_parent+0x134/0x430 fs/dcache.c:1558


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
