Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A717412B0CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 04:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfL0DEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 22:04:11 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:43040 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfL0DEL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 22:04:11 -0500
Received: by mail-il1-f197.google.com with SMTP id o13so12324114ilf.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2019 19:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BKq6y82YK1MS2p1s3InIrZcquYQwYoYOimO0qr4WA+w=;
        b=PNkil/1cX3rE2KF6i5Q72hME3ZBYa+PMVIIY2LnC01aXe8MKdkIlvqN+M30I4l+Oii
         ga9FVqWmayJEXRRbX1Vst2dcQoWyx9G4UByhLFL947nLkoo5HtA5gQ8rcjUe4VcMjqpD
         QcEzT/4k+hi8JghvNLi5/ijyGJVfCOfIyfx6yAd8z6Q2oXH8mVS7ggTI62C6bC91jAJd
         IybXzl5cM4HnJCTtNKVV1+FT6rUygmZ0UUvptHOzc2B089HcEJJkqUHtoX6KH9O/U4UO
         GmDs5X1S8OUQEToY8f+ld3mnoCUx7V/lB6jkuge/Sy3+Bw8AzD0o57r/lCB0UdOVQqS6
         beYQ==
X-Gm-Message-State: APjAAAW1HftNORoJ6tEaVzYdQOaDIofAfbWjXwqamboW7hAWKHXzBmyh
        R4lg/Y1kQpeZuCco5mWiBwYF2mq/XRfqJzX0QKPJ+EFKUsTI
X-Google-Smtp-Source: APXvYqwjIlQjFRZwvrBowI52Hjrhx0tMlPPBCvetL/bbs5YOQMU8V85wM+jOipl+hQuqlTyksnX01A72kqaMzQrldzx/nfyPemW/
MIME-Version: 1.0
X-Received: by 2002:a6b:6e06:: with SMTP id d6mr31985444ioh.95.1577415849156;
 Thu, 26 Dec 2019 19:04:09 -0800 (PST)
Date:   Thu, 26 Dec 2019 19:04:09 -0800
In-Reply-To: <0000000000006233e4059aa1dfb6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a2979059aa6bf2c@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=13f30a3ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=87a1b40b8fcdc9d40bd0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176004aee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+87a1b40b8fcdc9d40bd0@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.5.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/9961 is trying to acquire lock:
ffff888097e6bc50 (&sig->cred_guard_mutex){+.+.}, at:  
do_io_accounting+0x1f4/0x820 fs/proc/base.c:2773

but task is already holding lock:
ffff88809402fd00 (&p->lock){+.+.}, at: seq_read+0x71/0x1170  
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

-> #2 (sb_writers#4){.+.+}:
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
   &sig->cred_guard_mutex --> sb_writers#4 --> &p->lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&p->lock);
                                lock(sb_writers#4);
                                lock(&p->lock);
   lock(&sig->cred_guard_mutex);

  *** DEADLOCK ***

2 locks held by syz-executor.4/9961:
  #0: ffff888098418428 (sb_writers#4){.+.+}, at: file_start_write  
include/linux/fs.h:2885 [inline]
  #0: ffff888098418428 (sb_writers#4){.+.+}, at: do_sendfile+0x9b9/0xd00  
fs/read_write.c:1463
  #1: ffff88809402fd00 (&p->lock){+.+.}, at: seq_read+0x71/0x1170  
fs/seq_file.c:161

stack backtrace:
CPU: 1 PID: 9961 Comm: syz-executor.4 Not tainted 5.5.0-rc3-syzkaller #0
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
RIP: 0033:0x45a919
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f38e0f99c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000045a919
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000006
RBP: 000000000075c070 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000209 R11: 0000000000000246 R12: 00007f38e0f9a6d4
R13: 00000000004c925e R14: 00000000004e0f88 R15: 00000000ffffffff

