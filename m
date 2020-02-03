Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C155815105B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 20:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgBCTiN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 14:38:13 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:45562 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCTiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:38:13 -0500
Received: by mail-io1-f72.google.com with SMTP id t12so10099362iog.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2020 11:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ndasFXdu/GcMUz7FeOuI0D5JvGdHZK1Tuq1Ky4IlMOU=;
        b=gPviumkqctxAl+l+Cu8MPQBn00eQ9ThXzOBS+QJlNrvUubKK1irHOyyZKEXLYdwz2o
         qhBBK7r8IGny9CD9sLsiR6ZSxeo2N7WVMGlNGu7lFdRUy3jWnF+9T0N6JWrkx+H1Dsqd
         SPZ3LNpx2Z20X3TfBWatzHhOQ/mHTebH+j/NDHJwwJPNYXQd+JhkqIfwjnKHwn1r99ao
         dRxwH7hr+JVEMjdb4trb4b6TisemaNw10AchVuVoovvlh9CsWXM2by+tQbY+Y4fnKB8x
         Czo+v/vBcZX1v/QH5ttOHrPPQcReVxFPoW5TPHyc4asgxp+7t434WoyMTSB+UfPTri2t
         Puzw==
X-Gm-Message-State: APjAAAWhgyuEyDvn91vBTySQ4OrS5pF07CE4G6XgoGYL+MYjJJ5OfjhQ
        jXQk/OM3AWdtuZZYj7qFZxCWmtPUQElFHwxP76hghaCcYPS8
X-Google-Smtp-Source: APXvYqw7lPTCZaD8PekpXIJcvCIF5HzjkqpNkME57xW73tNFX6e06P0q3xdwc+IJ47awmg4nNNWfmvcJZnpRzNXUuLMGsxWdobu/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:a99:: with SMTP id 25mr21092079jas.37.1580758692430;
 Mon, 03 Feb 2020 11:38:12 -0800 (PST)
Date:   Mon, 03 Feb 2020 11:38:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000568bdd059db1107b@google.com>
Subject: possible deadlock in proc_tgid_io_accounting
From:   syzbot <syzbot+86a925872c5fba672f8c@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        christian@brauner.io, kent.overstreet@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    94f2630b Merge tag '5.6-rc-small-smb3-fix-for-stable' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11203a4ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6dda7ccc1e75a63f
dashboard link: https://syzkaller.appspot.com/bug?extid=86a925872c5fba672f8c
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+86a925872c5fba672f8c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.5.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/2716 is trying to acquire lock:
ffff888054af5d50 (&sig->cred_guard_mutex){+.+.}, at: do_io_accounting fs/proc/base.c:2864 [inline]
ffff888054af5d50 (&sig->cred_guard_mutex){+.+.}, at: proc_tgid_io_accounting+0x16a/0x570 fs/proc/base.c:2913

but task is already holding lock:
ffff8880926c4be0 (&p->lock){+.+.}, at: seq_read+0x6b/0xdb0 fs/seq_file.c:161

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&p->lock){+.+.}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       __mutex_lock_common+0x16e/0x2f30 kernel/locking/mutex.c:956
       __mutex_lock kernel/locking/mutex.c:1103 [inline]
       mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:1118
       seq_read+0x6b/0xdb0 fs/seq_file.c:161
       proc_reg_read+0x1d5/0x2e0 fs/proc/inode.c:223
       do_loop_readv_writev fs/read_write.c:714 [inline]
       do_iter_read+0x4a2/0x5b0 fs/read_write.c:935
       vfs_readv+0xc2/0x120 fs/read_write.c:997
       kernel_readv fs/splice.c:365 [inline]
       default_file_splice_read+0x579/0xa40 fs/splice.c:422
       do_splice_to fs/splice.c:892 [inline]
       splice_direct_to_actor+0x3c9/0xb90 fs/splice.c:971
       do_splice_direct+0x200/0x330 fs/splice.c:1080
       do_sendfile+0x7e4/0xfd0 fs/read_write.c:1464
       __do_sys_sendfile64 fs/read_write.c:1525 [inline]
       __se_sys_sendfile64 fs/read_write.c:1511 [inline]
       __x64_sys_sendfile64+0x176/0x1b0 fs/read_write.c:1511
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #3 (sb_writers#3){.+.+}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
       __sb_start_write+0x189/0x420 fs/super.c:1674
       sb_start_write include/linux/fs.h:1650 [inline]
       mnt_want_write+0x4a/0xa0 fs/namespace.c:354
       ovl_want_write+0x77/0x80 fs/overlayfs/util.c:21
       ovl_create_object+0xaf/0x2d0 fs/overlayfs/dir.c:596
       ovl_create+0x29/0x30 fs/overlayfs/dir.c:627
       lookup_open fs/namei.c:3309 [inline]
       do_last fs/namei.c:3401 [inline]
       path_openat+0x230c/0x4380 fs/namei.c:3607
       do_filp_open+0x192/0x3d0 fs/namei.c:3637
       do_sys_openat2+0x42b/0x6f0 fs/open.c:1149
       do_sys_open fs/open.c:1165 [inline]
       ksys_open include/linux/syscalls.h:1386 [inline]
       __do_sys_creat fs/open.c:1233 [inline]
       __se_sys_creat fs/open.c:1231 [inline]
       __x64_sys_creat+0xd5/0x100 fs/open.c:1231
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (&ovl_i_mutex_dir_key[depth]){++++}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       down_read+0x39/0x50 kernel/locking/rwsem.c:1495
       inode_lock_shared include/linux/fs.h:801 [inline]
       lookup_slow fs/namei.c:1773 [inline]
       lookup_one_len_unlocked+0xd2/0x1d0 fs/namei.c:2690
       lookup_positive_unlocked+0x25/0xb0 fs/namei.c:2706
       ovl_lookup_single+0x67/0x830 fs/overlayfs/namei.c:203
       ovl_lookup_layer+0x3b1/0x470 fs/overlayfs/namei.c:287
       ovl_lookup+0x843/0x1c60 fs/overlayfs/namei.c:902
       lookup_open fs/namei.c:3288 [inline]
       do_last fs/namei.c:3401 [inline]
       path_openat+0x1b73/0x4380 fs/namei.c:3607
       do_filp_open+0x192/0x3d0 fs/namei.c:3637
       do_open_execat+0xff/0x620 fs/exec.c:860
       __do_execve_file+0x758/0x1ca0 fs/exec.c:1765
       do_execveat_common fs/exec.c:1871 [inline]
       do_execve fs/exec.c:1888 [inline]
       __do_sys_execve fs/exec.c:1964 [inline]
       __se_sys_execve fs/exec.c:1959 [inline]
       __x64_sys_execve+0x94/0xb0 fs/exec.c:1959
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&ovl_i_mutex_dir_key[depth]#2){.+.+}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       down_read+0x39/0x50 kernel/locking/rwsem.c:1495
       inode_lock_shared include/linux/fs.h:801 [inline]
       do_last fs/namei.c:3400 [inline]
       path_openat+0xbb7/0x4380 fs/namei.c:3607
       do_filp_open+0x192/0x3d0 fs/namei.c:3637
       do_open_execat+0xff/0x620 fs/exec.c:860
       __do_execve_file+0x758/0x1ca0 fs/exec.c:1765
       do_execveat_common fs/exec.c:1871 [inline]
       do_execve fs/exec.c:1888 [inline]
       __do_sys_execve fs/exec.c:1964 [inline]
       __se_sys_execve fs/exec.c:1959 [inline]
       __x64_sys_execve+0x94/0xb0 fs/exec.c:1959
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sig->cred_guard_mutex){+.+.}:
       check_prev_add kernel/locking/lockdep.c:2475 [inline]
       check_prevs_add kernel/locking/lockdep.c:2580 [inline]
       validate_chain+0x1507/0x7be0 kernel/locking/lockdep.c:2970
       __lock_acquire+0xc5a/0x1bc0 kernel/locking/lockdep.c:3954
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       __mutex_lock_common+0x16e/0x2f30 kernel/locking/mutex.c:956
       __mutex_lock kernel/locking/mutex.c:1103 [inline]
       mutex_lock_killable_nested+0x1b/0x30 kernel/locking/mutex.c:1133
       do_io_accounting fs/proc/base.c:2864 [inline]
       proc_tgid_io_accounting+0x16a/0x570 fs/proc/base.c:2913
       proc_single_show+0xe7/0x180 fs/proc/base.c:758
       seq_read+0x4d8/0xdb0 fs/seq_file.c:229
       do_loop_readv_writev fs/read_write.c:714 [inline]
       do_iter_read+0x4a2/0x5b0 fs/read_write.c:935
       vfs_readv+0xc2/0x120 fs/read_write.c:997
       kernel_readv fs/splice.c:365 [inline]
       default_file_splice_read+0x579/0xa40 fs/splice.c:422
       do_splice_to fs/splice.c:892 [inline]
       splice_direct_to_actor+0x3c9/0xb90 fs/splice.c:971
       do_splice_direct+0x200/0x330 fs/splice.c:1080
       do_sendfile+0x7e4/0xfd0 fs/read_write.c:1464
       __do_sys_sendfile64 fs/read_write.c:1525 [inline]
       __se_sys_sendfile64 fs/read_write.c:1511 [inline]
       __x64_sys_sendfile64+0x176/0x1b0 fs/read_write.c:1511
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
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

1 lock held by syz-executor.4/2716:
 #0: ffff8880926c4be0 (&p->lock){+.+.}, at: seq_read+0x6b/0xdb0 fs/seq_file.c:161

stack backtrace:
CPU: 1 PID: 2716 Comm: syz-executor.4 Not tainted 5.5.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 print_circular_bug+0xc3f/0xe70 kernel/locking/lockdep.c:1684
 check_noncircular+0x206/0x3a0 kernel/locking/lockdep.c:1808
 check_prev_add kernel/locking/lockdep.c:2475 [inline]
 check_prevs_add kernel/locking/lockdep.c:2580 [inline]
 validate_chain+0x1507/0x7be0 kernel/locking/lockdep.c:2970
 __lock_acquire+0xc5a/0x1bc0 kernel/locking/lockdep.c:3954
 lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
 __mutex_lock_common+0x16e/0x2f30 kernel/locking/mutex.c:956
 __mutex_lock kernel/locking/mutex.c:1103 [inline]
 mutex_lock_killable_nested+0x1b/0x30 kernel/locking/mutex.c:1133
 do_io_accounting fs/proc/base.c:2864 [inline]
 proc_tgid_io_accounting+0x16a/0x570 fs/proc/base.c:2913
 proc_single_show+0xe7/0x180 fs/proc/base.c:758
 seq_read+0x4d8/0xdb0 fs/seq_file.c:229
 do_loop_readv_writev fs/read_write.c:714 [inline]
 do_iter_read+0x4a2/0x5b0 fs/read_write.c:935
 vfs_readv+0xc2/0x120 fs/read_write.c:997
 kernel_readv fs/splice.c:365 [inline]
 default_file_splice_read+0x579/0xa40 fs/splice.c:422
 do_splice_to fs/splice.c:892 [inline]
 splice_direct_to_actor+0x3c9/0xb90 fs/splice.c:971
 do_splice_direct+0x200/0x330 fs/splice.c:1080
 do_sendfile+0x7e4/0xfd0 fs/read_write.c:1464
 __do_sys_sendfile64 fs/read_write.c:1525 [inline]
 __se_sys_sendfile64 fs/read_write.c:1511 [inline]
 __x64_sys_sendfile64+0x176/0x1b0 fs/read_write.c:1511
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45b399
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0c198b1c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f0c198b26d4 RCX: 000000000045b399
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000005
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000010001ff R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000008ca R14: 00000000004ca24d R15: 000000000075bf2c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
