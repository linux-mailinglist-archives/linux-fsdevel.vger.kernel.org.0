Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F8026556A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 01:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgIJXTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 19:19:22 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:41659 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgIJXTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:19:19 -0400
Received: by mail-il1-f208.google.com with SMTP id e23so5750106ill.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 16:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TYFfsmiitHWLZf5ffQLlTREoPYDqKroF/8qudfPAn7U=;
        b=cWUQyAJA0Ef9TcONSElJYQ3e4zDmavd6kATekURv057T8Ro9ykLt7PPoWpcyJZvdjL
         3XnbwX0ILxIJhPgzhWt51l9ZZCFB4h9ZxEDPiyBMAN+pj5bxKjkDtyXKBBesu6540OYk
         H+emfKHVa3kGvTG6Cs35Bn2eHBNBO3HNU1pBSsZ/JvoD/Vxifd5WVLIojGgpITYIUIpB
         X21KjDitb2YpcpVVztb/3RO/AIAnOceDTEEvnMmr0swMgNZ8VbPVOqn5owwmkjojoX2o
         951fKmGWqbBrnVJ+aalFSqoETP6HNHoeN6HDp3iXExpNwRyWw9YFx4KALepDL+x+Kbqp
         9nUg==
X-Gm-Message-State: AOAM530hP14svExdZlA85q0e/3l2ujaE91J1GRFYcxY4ELDaioyDlyxK
        lhBPiQlfeYs/bfntFJ0L5bskmXNzM6ShRjQngpJ3XC05wVDR
X-Google-Smtp-Source: ABdhPJyIWK1RmblnIK4ZXhTFU9rWVUvfBHy08zUsh8CLZnKD1ReL9VnVPTaw04gtz+YKA9/MCG52v3BKiql6LMJmCXCxR8NSe+C0
MIME-Version: 1.0
X-Received: by 2002:a05:6638:f07:: with SMTP id h7mr10878589jas.25.1599779957760;
 Thu, 10 Sep 2020 16:19:17 -0700 (PDT)
Date:   Thu, 10 Sep 2020 16:19:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019e9de05aefdcc17@google.com>
Subject: possible deadlock in proc_tgid_io_accounting (2)
From:   syzbot <syzbot+c8e92098d59682aeb2e3@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        christian@brauner.io, ebiederm@xmission.com,
        gladkov.alexey@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz, walken@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dd9fb9bb Merge tags 'auxdisplay-for-linus-v5.9-rc4', 'clan..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156d617d900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1c560d0f4e121c9
dashboard link: https://syzkaller.appspot.com/bug?extid=c8e92098d59682aeb2e3
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c8e92098d59682aeb2e3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.9.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.2/12039 is trying to acquire lock:
ffff888051129588 (&sig->exec_update_mutex){+.+.}-{3:3}, at: do_io_accounting fs/proc/base.c:2928 [inline]
ffff888051129588 (&sig->exec_update_mutex){+.+.}-{3:3}, at: proc_tgid_io_accounting+0x164/0x580 fs/proc/base.c:2977

but task is already holding lock:
ffff88809e4c6498 (&p->lock){+.+.}-{3:3}, at: seq_read+0x60/0xce0 fs/seq_file.c:155

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->lock){+.+.}-{3:3}:
       lock_acquire+0x140/0x6f0 kernel/locking/lockdep.c:5006
       __mutex_lock_common+0x189/0x2fc0 kernel/locking/mutex.c:956
       __mutex_lock kernel/locking/mutex.c:1103 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1118
       seq_read+0x60/0xce0 fs/seq_file.c:155
       do_loop_readv_writev fs/read_write.c:734 [inline]
       do_iter_read+0x438/0x620 fs/read_write.c:955
       vfs_readv+0xc2/0x120 fs/read_write.c:1073
       kernel_readv fs/splice.c:355 [inline]
       default_file_splice_read+0x579/0xa40 fs/splice.c:412
       do_splice_to fs/splice.c:871 [inline]
       splice_direct_to_actor+0x3de/0xb60 fs/splice.c:950
       do_splice_direct+0x201/0x340 fs/splice.c:1059
       do_sendfile+0x86d/0x1210 fs/read_write.c:1540
       __do_sys_sendfile64 fs/read_write.c:1601 [inline]
       __se_sys_sendfile64 fs/read_write.c:1587 [inline]
       __x64_sys_sendfile64+0x164/0x1a0 fs/read_write.c:1587
       do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #2 (sb_writers#7){.+.+}-{0:0}:
       lock_acquire+0x140/0x6f0 kernel/locking/lockdep.c:5006
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write+0x14b/0x410 fs/super.c:1672
       sb_start_write include/linux/fs.h:1643 [inline]
       mnt_want_write+0x45/0x90 fs/namespace.c:354
       ovl_xattr_set+0x60/0x3f0 fs/overlayfs/inode.c:344
       ovl_posix_acl_xattr_set+0x3c4/0x7a0 fs/overlayfs/super.c:962
       __vfs_setxattr+0x3be/0x400 fs/xattr.c:177
       __vfs_setxattr_noperm+0x11e/0x4b0 fs/xattr.c:208
       vfs_setxattr+0xde/0x270 fs/xattr.c:283
       setxattr+0x167/0x350 fs/xattr.c:548
       path_setxattr+0x109/0x1c0 fs/xattr.c:567
       __do_sys_lsetxattr fs/xattr.c:589 [inline]
       __se_sys_lsetxattr fs/xattr.c:585 [inline]
       __x64_sys_lsetxattr+0xb4/0xd0 fs/xattr.c:585
       do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
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

-> #0 (&sig->exec_update_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2496 [inline]
       check_prevs_add kernel/locking/lockdep.c:2601 [inline]
       validate_chain+0x1b0c/0x88a0 kernel/locking/lockdep.c:3218
       __lock_acquire+0x110b/0x2ae0 kernel/locking/lockdep.c:4426
       lock_acquire+0x140/0x6f0 kernel/locking/lockdep.c:5006
       __mutex_lock_common+0x189/0x2fc0 kernel/locking/mutex.c:956
       __mutex_lock kernel/locking/mutex.c:1103 [inline]
       mutex_lock_killable_nested+0x1a/0x20 kernel/locking/mutex.c:1133
       do_io_accounting fs/proc/base.c:2928 [inline]
       proc_tgid_io_accounting+0x164/0x580 fs/proc/base.c:2977
       proc_single_show+0xf6/0x180 fs/proc/base.c:775
       seq_read+0x41a/0xce0 fs/seq_file.c:208
       do_loop_readv_writev fs/read_write.c:734 [inline]
       do_iter_read+0x438/0x620 fs/read_write.c:955
       vfs_readv fs/read_write.c:1073 [inline]
       do_preadv+0x17b/0x290 fs/read_write.c:1165
       do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

Chain exists of:
  &sig->exec_update_mutex --> sb_writers#7 --> &p->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&p->lock);
                               lock(sb_writers#7);
                               lock(&p->lock);
  lock(&sig->exec_update_mutex);

 *** DEADLOCK ***

1 lock held by syz-executor.2/12039:
 #0: ffff88809e4c6498 (&p->lock){+.+.}-{3:3}, at: seq_read+0x60/0xce0 fs/seq_file.c:155

stack backtrace:
CPU: 0 PID: 12039 Comm: syz-executor.2 Not tainted 5.9.0-rc3-syzkaller #0
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
 mutex_lock_killable_nested+0x1a/0x20 kernel/locking/mutex.c:1133
 do_io_accounting fs/proc/base.c:2928 [inline]
 proc_tgid_io_accounting+0x164/0x580 fs/proc/base.c:2977
 proc_single_show+0xf6/0x180 fs/proc/base.c:775
 seq_read+0x41a/0xce0 fs/seq_file.c:208
 do_loop_readv_writev fs/read_write.c:734 [inline]
 do_iter_read+0x438/0x620 fs/read_write.c:955
 vfs_readv fs/read_write.c:1073 [inline]
 do_preadv+0x17b/0x290 fs/read_write.c:1165
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2c49358c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 0000000000025880 RCX: 000000000045d5b9
RDX: 0000000000000375 RSI: 00000000200017c0 RDI: 0000000000000005
RBP: 000000000118d030 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cfec
R13: 00007ffc04a7470f R14: 00007f2c493599c0 R15: 000000000118cfec


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
