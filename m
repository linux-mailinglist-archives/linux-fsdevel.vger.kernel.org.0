Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC19412B45E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 12:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfL0LzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 06:55:08 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:49737 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfL0LzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 06:55:07 -0500
Received: by mail-il1-f200.google.com with SMTP id j21so18280923ilf.16
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2019 03:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9DYpBqvDsj8Xpm3NXpP6+D8e9Iugsb2NDNTFtTkXT0c=;
        b=VpH66hUMTf/qIBZkt0mz0bqTykn1wO/K85OQgQDjWmrVVi4OM9i3tyNGh356jfg0LQ
         qgHp1HiNgTjIe6v5Aw5jbNR9DxAQ+VK14pjwuSYF34aSWtgGKIJaK6u9n4oMFAX8GgFP
         Xs+NJzrHZ9FmUc3HzJbivUW7aTlYGkdzxpOBn72ae2jOhgV7y/ppwx2zozZwVH1RqKPV
         11DJjZeYHQIOUEr0mPehgvK5oQmE/vK7gR92HvYyx3zObZc5AgF4L4TL+4dX1csBEVxw
         M7TpS8hbNg8rqbGs/2RBLL0GeKR3ZO41KuAWr6r/ZROWNGlVJGazlkfuRH/WzPZY+s2F
         49Hg==
X-Gm-Message-State: APjAAAVJiXzORKc1DthtXGkPOtMHhrymfez4XCLrLpT0DJs5HgWuEerH
        neqCpJB6pFFgHAAJh7RRKP4b7QBC7RA7M8Y4SnRgIyHPXi92
X-Google-Smtp-Source: APXvYqwloHdpdphgT/di+72V/MtMyLlCC1CmolGusY4lnAeIJfdEoh9SCk6htIS5NOxmqaU/s4laVcvHCk802Y+5OZY/wb+IiEgE
MIME-Version: 1.0
X-Received: by 2002:a92:5b49:: with SMTP id p70mr42613540ilb.209.1577447705801;
 Fri, 27 Dec 2019 03:55:05 -0800 (PST)
Date:   Fri, 27 Dec 2019 03:55:05 -0800
In-Reply-To: <0000000000006233e4059aa1dfb6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027fdb7059aae2ab8@google.com>
Subject: Re: possible deadlock in do_io_accounting (3)
From:   syzbot <syzbot+87a1b40b8fcdc9d40bd0@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        casey@schaufler-ca.com, christian@brauner.io,
        kent.overstreet@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    46cf053e Linux 5.5-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1518a6e1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=87a1b40b8fcdc9d40bd0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15693866e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12847615e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+87a1b40b8fcdc9d40bd0@syzkaller.appspotmail.com

overlayfs: failed to resolve './file0': -2
======================================================
WARNING: possible circular locking dependency detected
5.5.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor763/9723 is trying to acquire lock:
ffff8880a95dfed0 (&sig->cred_guard_mutex){+.+.}, at:  
do_io_accounting+0x1f4/0x820 fs/proc/base.c:2773

but task is already holding lock:
ffff8880a24999a0 (&p->lock){+.+.}, at: seq_read+0x71/0x1170  
fs/seq_file.c:161

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->lock){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:956 [inline]
        __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
        seq_read+0x71/0x1170 fs/seq_file.c:161
        do_loop_readv_writev fs/read_write.c:714 [inline]
        do_loop_readv_writev fs/read_write.c:701 [inline]
        do_iter_read+0x4a4/0x660 fs/read_write.c:935
        vfs_readv+0xf0/0x160 fs/read_write.c:997
        kernel_readv fs/splice.c:365 [inline]
        default_file_splice_read+0x4fb/0xa20 fs/splice.c:422
        do_splice_to+0x127/0x180 fs/splice.c:892
        splice_direct_to_actor+0x320/0xa30 fs/splice.c:971
        do_splice_direct+0x1da/0x2a0 fs/splice.c:1080
        do_sendfile+0x597/0xd00 fs/read_write.c:1464
        __do_sys_sendfile64 fs/read_write.c:1525 [inline]
        __se_sys_sendfile64 fs/read_write.c:1511 [inline]
        __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1511
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (sb_writers#3){.+.+}:
        percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
        __sb_start_write+0x241/0x460 fs/super.c:1674
        sb_start_write include/linux/fs.h:1650 [inline]
        mnt_want_write+0x3f/0xc0 fs/namespace.c:354
        ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:21
        ovl_create_object+0xb3/0x2c0 fs/overlayfs/dir.c:596
        ovl_create+0x28/0x30 fs/overlayfs/dir.c:627
        lookup_open+0x12d5/0x1a90 fs/namei.c:3241
        do_last fs/namei.c:3331 [inline]
        path_openat+0x14a2/0x4500 fs/namei.c:3537
        do_filp_open+0x1a1/0x280 fs/namei.c:3567
        do_sys_open+0x3fe/0x5d0 fs/open.c:1097
        __do_sys_open fs/open.c:1115 [inline]
        __se_sys_open fs/open.c:1110 [inline]
        __x64_sys_open+0x7e/0xc0 fs/open.c:1110
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&ovl_i_mutex_dir_key[depth]){++++}:
        down_read+0x95/0x430 kernel/locking/rwsem.c:1495
        inode_lock_shared include/linux/fs.h:801 [inline]
        do_last fs/namei.c:3330 [inline]
        path_openat+0x1e37/0x4500 fs/namei.c:3537
        do_filp_open+0x1a1/0x280 fs/namei.c:3567
        do_open_execat+0x137/0x690 fs/exec.c:856
        __do_execve_file.isra.0+0x1702/0x22b0 fs/exec.c:1761
        do_execveat_common fs/exec.c:1867 [inline]
        do_execve fs/exec.c:1884 [inline]
        __do_sys_execve fs/exec.c:1960 [inline]
        __se_sys_execve fs/exec.c:1955 [inline]
        __x64_sys_execve+0x8f/0xc0 fs/exec.c:1955
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sig->cred_guard_mutex){+.+.}:
        check_prev_add kernel/locking/lockdep.c:2476 [inline]
        check_prevs_add kernel/locking/lockdep.c:2581 [inline]
        validate_chain kernel/locking/lockdep.c:2971 [inline]
        __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
        lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
        __mutex_lock_common kernel/locking/mutex.c:956 [inline]
        __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
        mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:1133
        do_io_accounting+0x1f4/0x820 fs/proc/base.c:2773
        proc_tgid_io_accounting+0x23/0x30 fs/proc/base.c:2822
        proc_single_show+0xfd/0x1c0 fs/proc/base.c:756
        seq_read+0x4ca/0x1170 fs/seq_file.c:229
        do_loop_readv_writev fs/read_write.c:714 [inline]
        do_loop_readv_writev fs/read_write.c:701 [inline]
        do_iter_read+0x4a4/0x660 fs/read_write.c:935
        vfs_readv+0xf0/0x160 fs/read_write.c:997
        kernel_readv fs/splice.c:365 [inline]
        default_file_splice_read+0x4fb/0xa20 fs/splice.c:422
        do_splice_to+0x127/0x180 fs/splice.c:892
        splice_direct_to_actor+0x320/0xa30 fs/splice.c:971
        do_splice_direct+0x1da/0x2a0 fs/splice.c:1080
        do_sendfile+0x597/0xd00 fs/read_write.c:1464
        __do_sys_sendfile64 fs/read_write.c:1525 [inline]
        __se_sys_sendfile64 fs/read_write.c:1511 [inline]
        __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1511
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   &sig->cred_guard_mutex --> sb_writers#3 --> &p->lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&p->lock);
                                lock(sb_writers#3);
                                lock(&p->lock);
   lock(&sig->cred_guard_mutex);

  *** DEADLOCK ***

2 locks held by syz-executor763/9723:
  #0: ffff888098910428 (sb_writers#9){.+.+}, at: file_start_write  
include/linux/fs.h:2885 [inline]
  #0: ffff888098910428 (sb_writers#9){.+.+}, at: do_sendfile+0x9b9/0xd00  
fs/read_write.c:1463
  #1: ffff8880a24999a0 (&p->lock){+.+.}, at: seq_read+0x71/0x1170  
fs/seq_file.c:161

stack backtrace:
CPU: 0 PID: 9723 Comm: syz-executor763 Not tainted 5.5.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_circular_bug.isra.0.cold+0x163/0x172 kernel/locking/lockdep.c:1685
  check_noncircular+0x32e/0x3e0 kernel/locking/lockdep.c:1809
  check_prev_add kernel/locking/lockdep.c:2476 [inline]
  check_prevs_add kernel/locking/lockdep.c:2581 [inline]
  validate_chain kernel/locking/lockdep.c:2971 [inline]
  __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
  __mutex_lock_common kernel/locking/mutex.c:956 [inline]
  __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
  mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:1133
  do_io_accounting+0x1f4/0x820 fs/proc/base.c:2773
  proc_tgid_io_accounting+0x23/0x30 fs/proc/base.c:2822
  proc_single_show+0xfd/0x1c0 fs/proc/base.c:756
  seq_read+0x4ca/0x1170 fs/seq_file.c:229
  do_loop_readv_writev fs/read_write.c:714 [inline]
  do_loop_readv_writev fs/read_write.c:701 [inline]
  do_iter_read+0x4a4/0x660 fs/read_write.c:935
  vfs_readv+0xf0/0x160 fs/read_write.c:997
  kernel_readv fs/splice.c:365 [inline]
  default_file_splice_read+0x4fb/0xa20 fs/splice.c:422
  do_splice_to+0x127/0x180 fs/splice.c:892
  splice_direct_to_actor+0x320/0xa30 fs/splice.c:971
  do_splice_direct+0x1da/0x2a0 fs/splice.c:1080
  do_sendfile+0x597/0xd00 fs/read_write.c:1464
  __do_sys_sendfile64 fs/read_write.c:1525 [inline]
  __se_sys_sendfile64 fs/read_write.c:1511 [inline]
  __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1511
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4496d9
Code: e8 9c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b 05 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f91dddd5db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000006e5a18 RCX: 00000000004496d9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 00000000006e5a10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000209 R11: 0000000000000246 R12: 00000000006e5a1c
R13: 00007ffc82ca42cf R14: 00007f91dddd69c0 R15: 20c49ba5e353f7cf

