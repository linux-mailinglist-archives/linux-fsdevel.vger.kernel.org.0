Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647E825EB19
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Sep 2020 23:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgIEVtX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Sep 2020 17:49:23 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:53023 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgIEVtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Sep 2020 17:49:22 -0400
Received: by mail-il1-f208.google.com with SMTP id m1so7342150iln.19
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Sep 2020 14:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=weeIe4DxO66YUuOJzm/p0aGV6L+9I3moxUH8ZlMVdk0=;
        b=NJpK99lejZ/aQz8KQszdQqSBJ/xiR8tumjCGnDdRmbAFHwZmORKoWfTcYXQ9gN0sdr
         aib4tZGucxZ4FK3DheSpewxY1DzkQDGW1sfFPfLvkyIPhhTI8mZ4MIzbE+62QSqWpWvQ
         dwDez+XVKfGFNRIVnxRh5w8PB6Pahntkt1493nT0EL7w8w86Iq4ukXFH+kh4S32Nf+Fh
         UZHv4Sn/1hzAxmjz663igIMZk9KbqIxbqLqeyfJd3Rce7OQMJ/6wYa/yzn8QTMsmkwKd
         gX+pxC48K76C9LmrLX/jTo3k6Grd6HySImLoof8lcsE2Txz+EPAfZuAhW76Q0arFAnAI
         OFVg==
X-Gm-Message-State: AOAM530yWVAk+09YPaCQm9/Ak4ABGG14giksYUnvSohVodkmyXZ4WuMo
        qOUGg5aMkSmBTnz0hmfIWJc41b737UBh69IFtDCQWaTz6Xyq
X-Google-Smtp-Source: ABdhPJx0/vz3dH5qp8QUwUYobtoI7qfEfWE3f+jtDaM01iExAdIcJGgvejXb/AmJ587qSi8ya6/g5KbXtYy29zxhp7e6K+/PzmHm
MIME-Version: 1.0
X-Received: by 2002:a92:35c8:: with SMTP id c69mr12780003ilf.244.1599342560333;
 Sat, 05 Sep 2020 14:49:20 -0700 (PDT)
Date:   Sat, 05 Sep 2020 14:49:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ed85c05ae97f519@google.com>
Subject: possible deadlock in iter_file_splice_write
From:   syzbot <syzbot+a196bb0e96837b9ae756@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b51594df Merge tag 'docs-5.9-3' of git://git.lwn.net/linux
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12bcc1c1900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1c560d0f4e121c9
dashboard link: https://syzkaller.appspot.com/bug?extid=a196bb0e96837b9ae756
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a196bb0e96837b9ae756@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.9.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.0/609 is trying to acquire lock:
ffff88804da52c68 (&pipe->mutex/1){+.+.}-{3:3}, at: iter_file_splice_write+0x1b4/0xdf0 fs/splice.c:699

but task is already holding lock:
ffff888098062450 (sb_writers#4){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2783 [inline]
ffff888098062450 (sb_writers#4){.+.+}-{0:0}, at: do_splice+0xd4b/0x1a50 fs/splice.c:1143

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (sb_writers#4){.+.+}-{0:0}:
       lock_acquire+0x140/0x6f0 kernel/locking/lockdep.c:5006
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write+0x14b/0x410 fs/super.c:1672
       sb_start_write include/linux/fs.h:1643 [inline]
       mnt_want_write+0x45/0x90 fs/namespace.c:354
       ovl_create_object+0xb1/0x2b0 fs/overlayfs/dir.c:625
       lookup_open fs/namei.c:3103 [inline]
       open_last_lookups fs/namei.c:3177 [inline]
       path_openat+0x17e1/0x3840 fs/namei.c:3365
       do_filp_open+0x191/0x3a0 fs/namei.c:3395
       do_sys_openat2+0x463/0x830 fs/open.c:1168
       do_sys_open fs/open.c:1184 [inline]
       __do_sys_open fs/open.c:1192 [inline]
       __se_sys_open fs/open.c:1188 [inline]
       __x64_sys_open+0x1af/0x1e0 fs/open.c:1188
       do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #3 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       lock_acquire+0x140/0x6f0 kernel/locking/lockdep.c:5006
       down_read+0x36/0x50 kernel/locking/rwsem.c:1492
       inode_lock_shared include/linux/fs.h:789 [inline]
       lookup_slow fs/namei.c:1560 [inline]
       walk_component+0x435/0x680 fs/namei.c:1860
       lookup_last fs/namei.c:2309 [inline]
       path_lookupat+0x19d/0x960 fs/namei.c:2333
       filename_lookup+0x1ab/0x5d0 fs/namei.c:2366
       create_local_trace_uprobe+0x3f/0x5f0 kernel/trace/trace_uprobe.c:1574
       perf_uprobe_init+0xfe/0x1a0 kernel/trace/trace_event_perf.c:323
       perf_uprobe_event_init+0xfe/0x180 kernel/events/core.c:9580
       perf_try_init_event+0x13e/0x3a0 kernel/events/core.c:10899
       perf_init_event kernel/events/core.c:10951 [inline]
       perf_event_alloc+0xda1/0x28f0 kernel/events/core.c:11229
       __do_sys_perf_event_open kernel/events/core.c:11724 [inline]
       __se_sys_perf_event_open+0x6e7/0x3f60 kernel/events/core.c:11598
       do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #2 (&sig->exec_update_mutex){+.+.}-{3:3}:
       lock_acquire+0x140/0x6f0 kernel/locking/lockdep.c:5006
       __mutex_lock_common+0x189/0x2fc0 kernel/locking/mutex.c:956
       __mutex_lock kernel/locking/mutex.c:1103 [inline]
       mutex_lock_killable_nested+0x1a/0x20 kernel/locking/mutex.c:1133
       exec_mmap fs/exec.c:1113 [inline]
       begin_new_exec+0x66c/0x15c0 fs/exec.c:1392
       load_elf_binary+0x60f/0x48a0 fs/binfmt_elf.c:974
       search_binary_handler fs/exec.c:1819 [inline]
       exec_binprm fs/exec.c:1860 [inline]
       bprm_execve+0x919/0x1500 fs/exec.c:1931
       kernel_execve+0x871/0x970 fs/exec.c:2080
       try_to_run_init_process init/main.c:1344 [inline]
       kernel_init+0xc4/0x290 init/main.c:1453
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

-> #1 (&sig->cred_guard_mutex){+.+.}-{3:3}:
       lock_acquire+0x140/0x6f0 kernel/locking/lockdep.c:5006
       __mutex_lock_common+0x189/0x2fc0 kernel/locking/mutex.c:956
       __mutex_lock kernel/locking/mutex.c:1103 [inline]
       mutex_lock_interruptible_nested+0x1a/0x20 kernel/locking/mutex.c:1140
       proc_pid_attr_write+0x3b4/0x4a0 fs/proc/base.c:2734
       __kernel_write+0x1ac/0xac0 fs/read_write.c:528
       write_pipe_buf+0xf9/0x150 fs/splice.c:799
       splice_from_pipe_feed fs/splice.c:502 [inline]
       __splice_from_pipe+0x351/0x8b0 fs/splice.c:626
       splice_from_pipe fs/splice.c:661 [inline]
       default_file_splice_write fs/splice.c:811 [inline]
       do_splice_from fs/splice.c:847 [inline]
       do_splice+0xf1b/0x1a50 fs/splice.c:1144
       __do_sys_splice fs/splice.c:1419 [inline]
       __se_sys_splice fs/splice.c:1401 [inline]
       __x64_sys_splice+0x14f/0x1f0 fs/splice.c:1401
       do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&pipe->mutex/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2496 [inline]
       check_prevs_add kernel/locking/lockdep.c:2601 [inline]
       validate_chain+0x1b0c/0x88a0 kernel/locking/lockdep.c:3218
       __lock_acquire+0x110b/0x2ae0 kernel/locking/lockdep.c:4426
       lock_acquire+0x140/0x6f0 kernel/locking/lockdep.c:5006
       __mutex_lock_common+0x189/0x2fc0 kernel/locking/mutex.c:956
       __mutex_lock kernel/locking/mutex.c:1103 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1118
       iter_file_splice_write+0x1b4/0xdf0 fs/splice.c:699
       do_splice_from fs/splice.c:846 [inline]
       do_splice+0xdd1/0x1a50 fs/splice.c:1144
       __do_sys_splice fs/splice.c:1419 [inline]
       __se_sys_splice fs/splice.c:1401 [inline]
       __x64_sys_splice+0x14f/0x1f0 fs/splice.c:1401
       do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

Chain exists of:
  &pipe->mutex/1 --> &ovl_i_mutex_dir_key[depth] --> sb_writers#4

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_writers#4);
                               lock(&ovl_i_mutex_dir_key[depth]);
                               lock(sb_writers#4);
  lock(&pipe->mutex/1);

 *** DEADLOCK ***

1 lock held by syz-executor.0/609:
 #0: ffff888098062450 (sb_writers#4){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2783 [inline]
 #0: ffff888098062450 (sb_writers#4){.+.+}-{0:0}, at: do_splice+0xd4b/0x1a50 fs/splice.c:1143

stack backtrace:
CPU: 1 PID: 609 Comm: syz-executor.0 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 print_circular_bug+0xc72/0xea0 kernel/locking/lockdep.c:1703
 check_noncircular+0x1fb/0x3a0 kernel/locking/lockdep.c:1827
 check_prev_add kernel/locking/lockdep.c:2496 [inline]
 check_prevs_add kernel/locking/lockdep.c:2601 [inline]
 validate_chain+0x1b0c/0x88a0 kernel/locking/lockdep.c:3218
 __lock_acquire+0x110b/0x2ae0 kernel/locking/lockdep.c:4426
 lock_acquire+0x140/0x6f0 kernel/locking/lockdep.c:5006
 __mutex_lock_common+0x189/0x2fc0 kernel/locking/mutex.c:956
 __mutex_lock kernel/locking/mutex.c:1103 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1118
 iter_file_splice_write+0x1b4/0xdf0 fs/splice.c:699
 do_splice_from fs/splice.c:846 [inline]
 do_splice+0xdd1/0x1a50 fs/splice.c:1144
 __do_sys_splice fs/splice.c:1419 [inline]
 __se_sys_splice fs/splice.c:1401 [inline]
 __x64_sys_splice+0x14f/0x1f0 fs/splice.c:1401
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc20cea2c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 0000000000033980 RCX: 000000000045d5b9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 000000000118d038 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cfec
R13: 00007ffecc00982f R14: 00007fc20cea39c0 R15: 000000000118cfec


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
