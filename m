Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1412553EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 06:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgH1E50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 00:57:26 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:50699 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgH1E5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 00:57:24 -0400
Received: by mail-io1-f71.google.com with SMTP id k5so43301ion.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 21:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LgE6lJVanO3aGKaU5BWBpevjqiZZr3WyVWUmT2Inr0A=;
        b=qrMmgJJwQJHn7CagvV22Am+Gari0R0Uu5oV8fCLLcmn2FfJiOH/GZoV+x8nA6wle9n
         YTNpETTp/QyGEUZGUU3Fdbs2rVuzTRX7Qi10AWFYiBDnyVkZf7EDsmj/sL6cFlCSVaBl
         qAaFjYMcLQ7s4hLFT/1jmSabWnDCcF6vseN5/gx0ATgTYLEsY+vHwbc+6NkEIzazBjqR
         e1k41S7gE2j+HOyChbh1D0k+HllxRl5gGrqRnlQj3prn1f3VWgieEFkO4LUDiJDsIdpD
         lDOUk7GATxFsQR4IhN/zWKkbjQXtwGWOrZysGDcOqdkYzI6ODdS+SZ/rgRgcEsSXd+3Y
         U7jw==
X-Gm-Message-State: AOAM531uSzatlr1UXw+4E/0hulNfBTP8pK5YYYJZnyzQnhwbfXdaNSC2
        QXbiacpPEyWspbcXzaEDx6BrvoxoLPDV5V5Tak0dYwdZENcl
X-Google-Smtp-Source: ABdhPJwKGzJ7FC5EKbQvsE+s6PZQaLMlOkbNO8nAsujnHSQAjsejY52S4LjLBvgweGEUdjRBw22KfUgimGzK/DJ+P2Mk7VFhXuCJ
MIME-Version: 1.0
X-Received: by 2002:a5e:a512:: with SMTP id 18mr10756972iog.128.1598590642511;
 Thu, 27 Aug 2020 21:57:22 -0700 (PDT)
Date:   Thu, 27 Aug 2020 21:57:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063640c05ade8e3de@google.com>
Subject: possible deadlock in proc_pid_syscall (2)
From:   syzbot <syzbot+db9cdf3dd1f64252c6ef@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        christian@brauner.io, ebiederm@xmission.com,
        gladkov.alexey@gmail.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, walken@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15349f96900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=db9cdf3dd1f64252c6ef
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+db9cdf3dd1f64252c6ef@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.9.0-rc2-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.0/18445 is trying to acquire lock:
ffff88809f2e0dc8 (&sig->exec_update_mutex){+.+.}-{3:3}, at: lock_trace fs/proc/base.c:408 [inline]
ffff88809f2e0dc8 (&sig->exec_update_mutex){+.+.}-{3:3}, at: proc_pid_syscall+0xaa/0x2b0 fs/proc/base.c:646

but task is already holding lock:
ffff88808e9a3c30 (&p->lock){+.+.}-{3:3}, at: seq_read+0x61/0x1070 fs/seq_file.c:155

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
       seq_read+0x61/0x1070 fs/seq_file.c:155
       pde_read fs/proc/inode.c:306 [inline]
       proc_reg_read+0x221/0x300 fs/proc/inode.c:318
       do_loop_readv_writev fs/read_write.c:734 [inline]
       do_loop_readv_writev fs/read_write.c:721 [inline]
       do_iter_read+0x48e/0x6e0 fs/read_write.c:955
       vfs_readv+0xe5/0x150 fs/read_write.c:1073
       kernel_readv fs/splice.c:355 [inline]
       default_file_splice_read.constprop.0+0x4e6/0x9e0 fs/splice.c:412
       do_splice_to+0x137/0x170 fs/splice.c:871
       splice_direct_to_actor+0x307/0x980 fs/splice.c:950
       do_splice_direct+0x1b3/0x280 fs/splice.c:1059
       do_sendfile+0x55f/0xd40 fs/read_write.c:1540
       __do_sys_sendfile64 fs/read_write.c:1601 [inline]
       __se_sys_sendfile64 fs/read_write.c:1587 [inline]
       __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1587
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #2 (sb_writers#4){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write+0x234/0x470 fs/super.c:1672
       sb_start_write include/linux/fs.h:1643 [inline]
       mnt_want_write+0x3a/0xb0 fs/namespace.c:354
       ovl_setattr+0x5c/0x850 fs/overlayfs/inode.c:28
       notify_change+0xb60/0x10a0 fs/attr.c:336
       chown_common+0x4a9/0x550 fs/open.c:674
       do_fchownat+0x126/0x1e0 fs/open.c:704
       __do_sys_lchown fs/open.c:729 [inline]
       __se_sys_lchown fs/open.c:727 [inline]
       __x64_sys_lchown+0x7a/0xc0 fs/open.c:727
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       down_read+0x96/0x420 kernel/locking/rwsem.c:1492
       inode_lock_shared include/linux/fs.h:789 [inline]
       lookup_slow fs/namei.c:1560 [inline]
       walk_component+0x409/0x6a0 fs/namei.c:1860
       lookup_last fs/namei.c:2309 [inline]
       path_lookupat+0x1ba/0x830 fs/namei.c:2333
       filename_lookup+0x19f/0x560 fs/namei.c:2366
       create_local_trace_uprobe+0x87/0x4e0 kernel/trace/trace_uprobe.c:1574
       perf_uprobe_init+0x132/0x210 kernel/trace/trace_event_perf.c:323
       perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9580
       perf_try_init_event+0x12a/0x560 kernel/events/core.c:10899
       perf_init_event kernel/events/core.c:10951 [inline]
       perf_event_alloc.part.0+0xdee/0x3770 kernel/events/core.c:11229
       perf_event_alloc kernel/events/core.c:11608 [inline]
       __do_sys_perf_event_open+0x72c/0x2cb0 kernel/events/core.c:11724
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&sig->exec_update_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2496 [inline]
       check_prevs_add kernel/locking/lockdep.c:2601 [inline]
       validate_chain kernel/locking/lockdep.c:3218 [inline]
       __lock_acquire+0x2a6b/0x5640 kernel/locking/lockdep.c:4426
       lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:5005
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
       lock_trace fs/proc/base.c:408 [inline]
       proc_pid_syscall+0xaa/0x2b0 fs/proc/base.c:646
       proc_single_show+0x116/0x1e0 fs/proc/base.c:775
       seq_read+0x432/0x1070 fs/seq_file.c:208
       do_loop_readv_writev fs/read_write.c:734 [inline]
       do_loop_readv_writev fs/read_write.c:721 [inline]
       do_iter_read+0x48e/0x6e0 fs/read_write.c:955
       vfs_readv+0xe5/0x150 fs/read_write.c:1073
       do_preadv fs/read_write.c:1165 [inline]
       __do_sys_preadv fs/read_write.c:1215 [inline]
       __se_sys_preadv fs/read_write.c:1210 [inline]
       __x64_sys_preadv+0x231/0x310 fs/read_write.c:1210
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

Chain exists of:
  &sig->exec_update_mutex --> sb_writers#4 --> &p->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&p->lock);
                               lock(sb_writers#4);
                               lock(&p->lock);
  lock(&sig->exec_update_mutex);

 *** DEADLOCK ***

1 lock held by syz-executor.0/18445:
 #0: ffff88808e9a3c30 (&p->lock){+.+.}-{3:3}, at: seq_read+0x61/0x1070 fs/seq_file.c:155

stack backtrace:
CPU: 0 PID: 18445 Comm: syz-executor.0 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_noncircular+0x324/0x3e0 kernel/locking/lockdep.c:1827
 check_prev_add kernel/locking/lockdep.c:2496 [inline]
 check_prevs_add kernel/locking/lockdep.c:2601 [inline]
 validate_chain kernel/locking/lockdep.c:3218 [inline]
 __lock_acquire+0x2a6b/0x5640 kernel/locking/lockdep.c:4426
 lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:5005
 __mutex_lock_common kernel/locking/mutex.c:956 [inline]
 __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
 lock_trace fs/proc/base.c:408 [inline]
 proc_pid_syscall+0xaa/0x2b0 fs/proc/base.c:646
 proc_single_show+0x116/0x1e0 fs/proc/base.c:775
 seq_read+0x432/0x1070 fs/seq_file.c:208
 do_loop_readv_writev fs/read_write.c:734 [inline]
 do_loop_readv_writev fs/read_write.c:721 [inline]
 do_iter_read+0x48e/0x6e0 fs/read_write.c:955
 vfs_readv+0xe5/0x150 fs/read_write.c:1073
 do_preadv fs/read_write.c:1165 [inline]
 __do_sys_preadv fs/read_write.c:1215 [inline]
 __se_sys_preadv fs/read_write.c:1210 [inline]
 __x64_sys_preadv+0x231/0x310 fs/read_write.c:1210
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb613f9ec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 0000000000025740 RCX: 000000000045d5b9
RDX: 0000000000000333 RSI: 00000000200017c0 RDI: 0000000000000006
RBP: 000000000118cf90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007ffe2a82bbbf R14: 00007fb613f9f9c0 R15: 000000000118cf4c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
