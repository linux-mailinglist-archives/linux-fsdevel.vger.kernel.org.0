Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E22217C87C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 23:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCFWpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 17:45:12 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:45569 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgCFWpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:45:12 -0500
Received: by mail-il1-f197.google.com with SMTP id w6so2665063ill.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 14:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4EyG5LS1WMHoTeztigt9QuS+ZW/NHsYR+ethzh9L9Uk=;
        b=Kuc002IWUxiUB01JegTpTcEbUiEzl2mL6bIvA8Nb3Z9oeenAk3BjcJ3+2QK5s2d6Ww
         JBVMMUyOTQ1zp8bPsd/i0MbWFsttD9z/5UmfmL0jhBvKM56HDqLqOnjpvJShfUMrmQfL
         B4l+b6C2nqf0WZit9clqk8YUD6NVWglZ4Qgw9lv43/j8kqdHoAkAMlvZa7HDh9Pm2G+w
         jH0YzFznnfvOv5xagtoyXHRm1v4qVmLd+p0xEFu6QBS4/+Ehh4XNAcEXCM6xvDHyoYyt
         9w3tShIDVk+wnWRt6eEp9OXoyyKoHEPvMvbs48Y9KhTyUtboQwT0Lk0pZjrKjA2O5+1Z
         O6Rg==
X-Gm-Message-State: ANhLgQ0bQqjToYJ04n0N8xvbEfe4GjeFRB0atu3Gio7drwo0HM9QuWIB
        /huA+7t74tVQ49XvAMxIyAqr1goovfgGnik8iU8prh0FBqsu
X-Google-Smtp-Source: ADFU+vtR9V4CFsqahFMA8ERdUwa0SzLd2TdXJaZKXu2eZHh5KtF943od90CvQw6S9lO1ixyTw60kwH8zAuizBR7iiHio63VKHNYi
MIME-Version: 1.0
X-Received: by 2002:a6b:7c4c:: with SMTP id b12mr4920786ioq.169.1583534711543;
 Fri, 06 Mar 2020 14:45:11 -0800 (PST)
Date:   Fri, 06 Mar 2020 14:45:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8a16405a0376780@google.com>
Subject: possible deadlock in proc_pid_personality
From:   syzbot <syzbot+d9ae59d4662c941e39c6@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        christian@brauner.io, guro@fb.com, kent.overstreet@gmail.com,
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

HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17345181e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=d9ae59d4662c941e39c6
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1374670de00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d9ae59d4662c941e39c6@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.6.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.0/9659 is trying to acquire lock:
ffff88807bd9dc90 (&sig->cred_guard_mutex){+.+.}, at: lock_trace fs/proc/base.c:408 [inline]
ffff88807bd9dc90 (&sig->cred_guard_mutex){+.+.}, at: proc_pid_personality+0x4f/0x110 fs/proc/base.c:3052

but task is already holding lock:
ffff88808b48d640 (&p->lock){+.+.}, at: seq_read+0x6b/0xdb0 fs/seq_file.c:161

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->lock){+.+.}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       __mutex_lock_common+0x16e/0x2f30 kernel/locking/mutex.c:956
       __mutex_lock kernel/locking/mutex.c:1103 [inline]
       mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:1118
       seq_read+0x6b/0xdb0 fs/seq_file.c:161
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

-> #2 (sb_writers#3){.+.+}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
       __sb_start_write+0x189/0x420 fs/super.c:1674
       sb_start_write include/linux/fs.h:1649 [inline]
       mnt_want_write+0x4a/0xa0 fs/namespace.c:354
       ovl_want_write+0x77/0x80 fs/overlayfs/util.c:21
       ovl_setattr+0x55/0x790 fs/overlayfs/inode.c:27
       notify_change+0xb6e/0xfb0 fs/attr.c:336
       do_truncate+0x194/0x230 fs/open.c:64
       handle_truncate fs/namei.c:3083 [inline]
       do_last fs/namei.c:3496 [inline]
       path_openat+0x271d/0x4380 fs/namei.c:3607
       do_filp_open+0x192/0x3d0 fs/namei.c:3637
       do_sys_openat2+0x42b/0x6f0 fs/open.c:1149
       do_sys_open fs/open.c:1165 [inline]
       ksys_open include/linux/syscalls.h:1386 [inline]
       __do_sys_creat fs/open.c:1233 [inline]
       __se_sys_creat fs/open.c:1231 [inline]
       __x64_sys_creat+0xd5/0x100 fs/open.c:1231
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&ovl_i_mutex_key[depth]){+.+.}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       down_write+0x57/0x140 kernel/locking/rwsem.c:1534
       inode_lock include/linux/fs.h:791 [inline]
       process_measurement+0x2d7/0x18d0 security/integrity/ima/ima_main.c:230
       ima_file_check+0x9b/0xe0 security/integrity/ima/ima_main.c:442
       do_last fs/namei.c:3494 [inline]
       path_openat+0x1def/0x4380 fs/namei.c:3607
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
       lock_trace fs/proc/base.c:408 [inline]
       proc_pid_personality+0x4f/0x110 fs/proc/base.c:3052
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

2 locks held by syz-executor.0/9659:
 #0: ffff88807b422428 (sb_writers#12){.+.+}, at: file_start_write include/linux/fs.h:2903 [inline]
 #0: ffff88807b422428 (sb_writers#12){.+.+}, at: do_sendfile+0x7c2/0xfd0 fs/read_write.c:1519
 #1: ffff88808b48d640 (&p->lock){+.+.}, at: seq_read+0x6b/0xdb0 fs/seq_file.c:161

stack backtrace:
CPU: 0 PID: 9659 Comm: syz-executor.0 Not tainted 5.6.0-rc3-syzkaller #0
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
 lock_trace fs/proc/base.c:408 [inline]
 proc_pid_personality+0x4f/0x110 fs/proc/base.c:3052
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
RIP: 0033:0x45c479
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f853eeaac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f853eeab6d4 RCX: 000000000045c479
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 000000000076bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000283 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000008d1 R14: 00000000004cb364 R15: 000000000076bfcc


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
