Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E15A3E6F88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 11:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbfJ1KML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 06:12:11 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:43632 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732895AbfJ1KMK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:12:10 -0400
Received: by mail-il1-f199.google.com with SMTP id d11so8361113ild.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 03:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rV90P3NUfhfEP+gn3d2e1CUKu6Ej75i/oXJfHf7aQ/M=;
        b=LzgjQvTmqy1aeSDlqB5XN4JFNyC+cDdhqYNYGOMt3IDtSpablZSP3SGBFMyD8dyU9L
         NJ/TsStDIt258ZMc9ojwOMVOIo5NseyF3oQsUP+CmiQac5RAjn0SKJD0et0nRmJ5tb1m
         sUqZkjaEdcw0gNM/PImx2EssFccHl4U2zR0d0um229Sad7JVtDEEUzCFzVjQvGGRAIQU
         YzN07xeebm0+iinjiJounOuIeEA2lMDBO9XvYDBofu/rqJux3+GegwjFYj6d2drPHrbL
         upxECNe3aOPDBuse9y4zLmUaOQup3+egeEZDUuzniD3SZoTQg12Jfj8J2TrphjELB+x6
         0B9w==
X-Gm-Message-State: APjAAAWBmz2C8mXTjz04+pZ/JkCk/Ri9KzVN3uvih4nDbQVDwWAY7z1Y
        sMvUdkUJnsWBv9xJBQh9Q8AkS0PanmE9zU0N7WFLrjucSnRp
X-Google-Smtp-Source: APXvYqxTRSzwHRXqTZHawePHvjza8+FfV3lzc9I6yh2q/zvzO9+rxmjNsjEo5rAe5zAGzPsnTqygLyCpKAU/ybcK2/osRsRpAZSX
MIME-Version: 1.0
X-Received: by 2002:a6b:8bcc:: with SMTP id n195mr12961106iod.135.1572257528364;
 Mon, 28 Oct 2019 03:12:08 -0700 (PDT)
Date:   Mon, 28 Oct 2019 03:12:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000794a8f0595f5bb3e@google.com>
Subject: possible deadlock in proc_tid_io_accounting
From:   syzbot <syzbot+f731ab05acff1872c48f@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        casey@schaufler-ca.com, christian@brauner.io, guro@fb.com,
        kent.overstreet@gmail.com, khlebnikov@yandex-team.ru,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    13b86bc4 Merge tag 'for-linus' of git://git.armlinux.org.u..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1658972f600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c03e4d33fa96d51
dashboard link: https://syzkaller.appspot.com/bug?extid=f731ab05acff1872c48f
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f731ab05acff1872c48f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.4.0-rc4+ #0 Not tainted
------------------------------------------------------
syz-executor.0/17400 is trying to acquire lock:
ffff88805f4450d0 (&sig->cred_guard_mutex){+.+.}, at: do_io_accounting  
fs/proc/base.c:2773 [inline]
ffff88805f4450d0 (&sig->cred_guard_mutex){+.+.}, at:  
proc_tid_io_accounting+0x156/0x200 fs/proc/base.c:2816

but task is already holding lock:
ffff88805d75a0a0 (&p->lock){+.+.}, at: seq_read+0x6e/0xd70 fs/seq_file.c:161

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->lock){+.+.}:
        lock_acquire+0x158/0x250 kernel/locking/lockdep.c:4487
        __mutex_lock_common+0x14c/0x2e20 kernel/locking/mutex.c:956
        __mutex_lock kernel/locking/mutex.c:1103 [inline]
        mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:1118
        seq_read+0x6e/0xd70 fs/seq_file.c:161
        proc_reg_read+0x1e2/0x2d0 fs/proc/inode.c:223
        do_loop_readv_writev fs/read_write.c:714 [inline]
        do_iter_read+0x4b1/0x5b0 fs/read_write.c:935
        vfs_readv+0xc2/0x120 fs/read_write.c:997
        kernel_readv fs/splice.c:359 [inline]
        default_file_splice_read+0x544/0x8d0 fs/splice.c:414
        do_splice_to fs/splice.c:877 [inline]
        splice_direct_to_actor+0x39c/0xac0 fs/splice.c:954
        do_splice_direct+0x200/0x330 fs/splice.c:1063
        do_sendfile+0x7e4/0xfd0 fs/read_write.c:1464
        __do_sys_sendfile64 fs/read_write.c:1525 [inline]
        __se_sys_sendfile64 fs/read_write.c:1511 [inline]
        __x64_sys_sendfile64+0x176/0x1b0 fs/read_write.c:1511
        do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (sb_writers#3){.+.+}:
        lock_acquire+0x158/0x250 kernel/locking/lockdep.c:4487
        percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
        __sb_start_write+0xeb/0x430 fs/super.c:1672
        sb_start_write include/linux/fs.h:1650 [inline]
        mnt_want_write+0x4a/0xa0 fs/namespace.c:354
        ovl_want_write+0x77/0x80 fs/overlayfs/util.c:21
        ovl_setattr+0x55/0x790 fs/overlayfs/inode.c:27
        notify_change+0xa27/0xe70 fs/attr.c:337
        chown_common+0x3a4/0x5f0 fs/open.c:652
        do_fchownat+0x113/0x1c0 fs/open.c:682
        __do_sys_lchown fs/open.c:707 [inline]
        __se_sys_lchown fs/open.c:705 [inline]
        __x64_sys_lchown+0x85/0x90 fs/open.c:705
        do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&ovl_i_mutex_dir_key[depth]){++++}:
        lock_acquire+0x158/0x250 kernel/locking/lockdep.c:4487
        down_read+0x39/0x50 kernel/locking/rwsem.c:1495
        inode_lock_shared include/linux/fs.h:801 [inline]
        do_last fs/namei.c:3313 [inline]
        path_openat+0xa9a/0x4420 fs/namei.c:3525
        do_filp_open+0x192/0x3d0 fs/namei.c:3555
        do_open_execat+0xff/0x610 fs/exec.c:857
        __do_execve_file+0x766/0x1cc0 fs/exec.c:1762
        do_execveat_common fs/exec.c:1868 [inline]
        do_execve fs/exec.c:1885 [inline]
        __do_sys_execve fs/exec.c:1961 [inline]
        __se_sys_execve fs/exec.c:1956 [inline]
        __x64_sys_execve+0x94/0xb0 fs/exec.c:1956
        do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sig->cred_guard_mutex){+.+.}:
        check_prev_add kernel/locking/lockdep.c:2476 [inline]
        check_prevs_add kernel/locking/lockdep.c:2581 [inline]
        validate_chain+0x161e/0x7bc0 kernel/locking/lockdep.c:2971
        __lock_acquire+0xc75/0x1be0 kernel/locking/lockdep.c:3955
        lock_acquire+0x158/0x250 kernel/locking/lockdep.c:4487
        __mutex_lock_common+0x14c/0x2e20 kernel/locking/mutex.c:956
        __mutex_lock kernel/locking/mutex.c:1103 [inline]
        mutex_lock_killable_nested+0x1b/0x30 kernel/locking/mutex.c:1133
        do_io_accounting fs/proc/base.c:2773 [inline]
        proc_tid_io_accounting+0x156/0x200 fs/proc/base.c:2816
        proc_single_show+0xd8/0x120 fs/proc/base.c:756
        seq_read+0x4cd/0xd70 fs/seq_file.c:229
        do_loop_readv_writev fs/read_write.c:714 [inline]
        do_iter_read+0x4b1/0x5b0 fs/read_write.c:935
        vfs_readv fs/read_write.c:997 [inline]
        do_preadv+0x178/0x290 fs/read_write.c:1089
        __do_sys_preadv fs/read_write.c:1139 [inline]
        __se_sys_preadv fs/read_write.c:1134 [inline]
        __x64_sys_preadv+0x9e/0xb0 fs/read_write.c:1134
        do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
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

1 lock held by syz-executor.0/17400:
  #0: ffff88805d75a0a0 (&p->lock){+.+.}, at: seq_read+0x6e/0xd70  
fs/seq_file.c:161

stack backtrace:
CPU: 1 PID: 17400 Comm: syz-executor.0 Not tainted 5.4.0-rc4+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  print_circular_bug+0xc2d/0xe60 kernel/locking/lockdep.c:1685
  check_noncircular+0x206/0x3a0 kernel/locking/lockdep.c:1809
  check_prev_add kernel/locking/lockdep.c:2476 [inline]
  check_prevs_add kernel/locking/lockdep.c:2581 [inline]
  validate_chain+0x161e/0x7bc0 kernel/locking/lockdep.c:2971
  __lock_acquire+0xc75/0x1be0 kernel/locking/lockdep.c:3955
  lock_acquire+0x158/0x250 kernel/locking/lockdep.c:4487
  __mutex_lock_common+0x14c/0x2e20 kernel/locking/mutex.c:956
  __mutex_lock kernel/locking/mutex.c:1103 [inline]
  mutex_lock_killable_nested+0x1b/0x30 kernel/locking/mutex.c:1133
  do_io_accounting fs/proc/base.c:2773 [inline]
  proc_tid_io_accounting+0x156/0x200 fs/proc/base.c:2816
  proc_single_show+0xd8/0x120 fs/proc/base.c:756
  seq_read+0x4cd/0xd70 fs/seq_file.c:229
  do_loop_readv_writev fs/read_write.c:714 [inline]
  do_iter_read+0x4b1/0x5b0 fs/read_write.c:935
  vfs_readv fs/read_write.c:997 [inline]
  do_preadv+0x178/0x290 fs/read_write.c:1089
  __do_sys_preadv fs/read_write.c:1139 [inline]
  __se_sys_preadv fs/read_write.c:1134 [inline]
  __x64_sys_preadv+0x9e/0xb0 fs/read_write.c:1134
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459ef9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffa4f49ec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000459ef9
RDX: 0000000000000001 RSI: 0000000020000980 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffa4f49f6d4
R13: 00000000004c75cc R14: 00000000004dcf78 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
