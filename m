Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB1817516C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 01:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgCBAnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 19:43:13 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:54409 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgCBAnN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 19:43:13 -0500
Received: by mail-io1-f72.google.com with SMTP id z16so1393003ioc.21
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2020 16:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uInTjzS+4l/o6yCqkWZPEijTE7YGaDvR9aQ+4U99Rdw=;
        b=kv5bS/BrXWqewwL0WKt67uI0i3QiWDm+Iz1WTQxwpCyx1TkiGlHxcctepLYzkiaPOI
         clzIoLtDt7vZkDiasIqEOISubkpa+cmZqR7F3NG5/14K2T89mcwpk4dtsz4j98Oer85H
         7EWxQfc7nS7zdMJ1ucH03bM/dbptPZ0DF9jDYEvvXGbGIZmjZCAYLkCECpYINcha9MNx
         toXVw62VEze6azxE386dKpTnLk5NiWgB8h/mvEua5j+dXbiTy8D+nZUzjFDxuziovyt6
         ihhrNSR7HyLNZyYHmECqTDYDXy41AaLoSroBFf82lEpXlqcmF4T360ZtIBwiNLb0WIU3
         1PKA==
X-Gm-Message-State: APjAAAWiBhR1FkXIzxSSqzs+zcLBzQ5RfxJcJXTf55lAi98AODfvOQ2E
        t15tXNCVR8/EWduKbPBReyHQ4l3EXayYgv5QEEKgJ2dBpn8p
X-Google-Smtp-Source: APXvYqygF8bq38dgbkjR3p+FHeTbfmc+HO/osoGi12n5E+woyR1o6UiUv64CZSzIYEKbfco1IddCOV+0lXc9ZrAOFt+5Z7KQJH3r
MIME-Version: 1.0
X-Received: by 2002:a92:89c2:: with SMTP id w63mr14167555ilk.252.1583109792747;
 Sun, 01 Mar 2020 16:43:12 -0800 (PST)
Date:   Sun, 01 Mar 2020 16:43:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d65890059fd4787b@google.com>
Subject: possible deadlock in walk_component
From:   syzbot <syzbot+a84f8e843059b8bb50c3@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173a3529e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=a84f8e843059b8bb50c3
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a84f8e843059b8bb50c3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.6.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.3/1694 is trying to acquire lock:
ffff888025e9e220 (&ovl_i_mutex_dir_key[depth]){++++}, at: inode_lock_shared include/linux/fs.h:801 [inline]
ffff888025e9e220 (&ovl_i_mutex_dir_key[depth]){++++}, at: lookup_slow fs/namei.c:1773 [inline]
ffff888025e9e220 (&ovl_i_mutex_dir_key[depth]){++++}, at: walk_component+0x2c2/0x5f0 fs/namei.c:1915

but task is already holding lock:
ffff88808c28e750 (&sig->cred_guard_mutex){+.+.}, at: __do_sys_perf_event_open kernel/events/core.c:11266 [inline]
ffff88808c28e750 (&sig->cred_guard_mutex){+.+.}, at: __se_sys_perf_event_open+0xb50/0x4140 kernel/events/core.c:11160

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&sig->cred_guard_mutex){+.+.}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       __mutex_lock_common+0x16e/0x2f30 kernel/locking/mutex.c:956
       __mutex_lock kernel/locking/mutex.c:1103 [inline]
       mutex_lock_killable_nested+0x1b/0x30 kernel/locking/mutex.c:1133
       lock_trace fs/proc/base.c:408 [inline]
       proc_pid_stack+0xd9/0x200 fs/proc/base.c:452
       proc_single_show+0xe7/0x180 fs/proc/base.c:758
       seq_read+0x4d8/0xdb0 fs/seq_file.c:229
       do_loop_readv_writev fs/read_write.c:714 [inline]
       do_iter_read+0x4a2/0x5b0 fs/read_write.c:935
       vfs_readv+0xc2/0x120 fs/read_write.c:1053
       kernel_readv fs/splice.c:365 [inline]
       default_file_splice_read+0x579/0xa40 fs/splice.c:422
       do_splice_to fs/splice.c:892 [inline]
       splice_direct_to_actor+0x3c9/0xb90 fs/splice.c:971
       do_splice_direct+0x200/0x330 fs/splice.c:1080
       do_sendfile+0x7e4/0xfd0 fs/read_write.c:1520
       __do_sys_sendfile64 fs/read_write.c:1581 [inline]
       __se_sys_sendfile64 fs/read_write.c:1567 [inline]
       __x64_sys_sendfile64+0x176/0x1b0 fs/read_write.c:1567
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (&p->lock){+.+.}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       __mutex_lock_common+0x16e/0x2f30 kernel/locking/mutex.c:956
       __mutex_lock kernel/locking/mutex.c:1103 [inline]
       mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:1118
       seq_read+0x6b/0xdb0 fs/seq_file.c:161
       proc_reg_read+0x1d5/0x2e0 fs/proc/inode.c:223
       do_loop_readv_writev fs/read_write.c:714 [inline]
       do_iter_read+0x4a2/0x5b0 fs/read_write.c:935
       vfs_readv+0xc2/0x120 fs/read_write.c:1053
       kernel_readv fs/splice.c:365 [inline]
       default_file_splice_read+0x579/0xa40 fs/splice.c:422
       do_splice_to fs/splice.c:892 [inline]
       splice_direct_to_actor+0x3c9/0xb90 fs/splice.c:971
       do_splice_direct+0x200/0x330 fs/splice.c:1080
       do_sendfile+0x7e4/0xfd0 fs/read_write.c:1520
       __do_sys_sendfile64 fs/read_write.c:1581 [inline]
       __se_sys_sendfile64 fs/read_write.c:1567 [inline]
       __x64_sys_sendfile64+0x176/0x1b0 fs/read_write.c:1567
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (sb_writers#3){.+.+}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
       __sb_start_write+0x189/0x420 fs/super.c:1674
       sb_start_write include/linux/fs.h:1649 [inline]
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
       __do_sys_openat fs/open.c:1179 [inline]
       __se_sys_openat fs/open.c:1174 [inline]
       __x64_sys_openat+0x1e6/0x210 fs/open.c:1174
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&ovl_i_mutex_dir_key[depth]){++++}:
       check_prev_add kernel/locking/lockdep.c:2475 [inline]
       check_prevs_add kernel/locking/lockdep.c:2580 [inline]
       validate_chain+0x1507/0x7be0 kernel/locking/lockdep.c:2970
       __lock_acquire+0xc5a/0x1bc0 kernel/locking/lockdep.c:3954
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       down_read+0x39/0x50 kernel/locking/rwsem.c:1495
       inode_lock_shared include/linux/fs.h:801 [inline]
       lookup_slow fs/namei.c:1773 [inline]
       walk_component+0x2c2/0x5f0 fs/namei.c:1915
       lookup_last fs/namei.c:2391 [inline]
       path_lookupat+0x19f/0x680 fs/namei.c:2436
       filename_lookup+0x1d4/0x690 fs/namei.c:2466
       kern_path+0x35/0x40 fs/namei.c:2552
       create_local_trace_uprobe+0x40/0x610 kernel/trace/trace_uprobe.c:1568
       perf_uprobe_init+0x10c/0x1b0 kernel/trace/trace_event_perf.c:323
       perf_uprobe_event_init+0xe0/0x170 kernel/events/core.c:9171
       perf_try_init_event+0x14e/0x3c0 kernel/events/core.c:10471
       perf_init_event kernel/events/core.c:10523 [inline]
       perf_event_alloc+0x1032/0x2810 kernel/events/core.c:10803
       __do_sys_perf_event_open kernel/events/core.c:11286 [inline]
       __se_sys_perf_event_open+0x6cf/0x4140 kernel/events/core.c:11160
       __x64_sys_perf_event_open+0xbf/0xd0 kernel/events/core.c:11160
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  &ovl_i_mutex_dir_key[depth] --> &p->lock --> &sig->cred_guard_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sig->cred_guard_mutex);
                               lock(&p->lock);
                               lock(&sig->cred_guard_mutex);
  lock(&ovl_i_mutex_dir_key[depth]);

 *** DEADLOCK ***

2 locks held by syz-executor.3/1694:
 #0: ffff88808c28e750 (&sig->cred_guard_mutex){+.+.}, at: __do_sys_perf_event_open kernel/events/core.c:11266 [inline]
 #0: ffff88808c28e750 (&sig->cred_guard_mutex){+.+.}, at: __se_sys_perf_event_open+0xb50/0x4140 kernel/events/core.c:11160
 #1: ffffffff8a48b8f0 (&pmus_srcu){....}, at: rcu_lock_acquire+0xd/0x40 include/linux/rcupdate.h:208

stack backtrace:
CPU: 0 PID: 1694 Comm: syz-executor.3 Not tainted 5.6.0-rc3-syzkaller #0
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
 down_read+0x39/0x50 kernel/locking/rwsem.c:1495
 inode_lock_shared include/linux/fs.h:801 [inline]
 lookup_slow fs/namei.c:1773 [inline]
 walk_component+0x2c2/0x5f0 fs/namei.c:1915
 lookup_last fs/namei.c:2391 [inline]
 path_lookupat+0x19f/0x680 fs/namei.c:2436
 filename_lookup+0x1d4/0x690 fs/namei.c:2466
 kern_path+0x35/0x40 fs/namei.c:2552
 create_local_trace_uprobe+0x40/0x610 kernel/trace/trace_uprobe.c:1568
 perf_uprobe_init+0x10c/0x1b0 kernel/trace/trace_event_perf.c:323
 perf_uprobe_event_init+0xe0/0x170 kernel/events/core.c:9171
 perf_try_init_event+0x14e/0x3c0 kernel/events/core.c:10471
 perf_init_event kernel/events/core.c:10523 [inline]
 perf_event_alloc+0x1032/0x2810 kernel/events/core.c:10803
 __do_sys_perf_event_open kernel/events/core.c:11286 [inline]
 __se_sys_perf_event_open+0x6cf/0x4140 kernel/events/core.c:11160
 __x64_sys_perf_event_open+0xbf/0xd0 kernel/events/core.c:11160
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c479
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2bd4543c78 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007f2bd45446d4 RCX: 000000000045c479
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 000000000076bf20 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000813 R14: 00000000004ca8bf R15: 000000000076bf2c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
