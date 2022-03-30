Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D224ECACF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 19:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349360AbiC3RiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 13:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349344AbiC3RiQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:38:16 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D3EB7C71
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 10:36:29 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id x16-20020a6bfe10000000b006409f03e39eso14912334ioh.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 10:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ElkwXdyBtZpqMcTtCYj/rl3uueZMI0r+f6ZIrCyGxKw=;
        b=1NwYjo8JCJNvojD70N8wcYkHg+fzA3Yal/bTflu/e/ijhVRH/8SLkzKrh2dGTEabeP
         RYJMPQ+1ZizSd3gA6NBuPVNezEPPC7CIBDZjpDw1X5dIphHL+tw+Vt09dhQKqwQtoGSA
         5YGtKg/AvYm0k57Dt3JhDcVbsrn5fD4vdH58uK5bvYM7PDqe8sAKa1fe2xIbM2JmSKij
         DS6SeEwQcf506H+VgTTCF2uol6QcTEA4zy0hABC3byRYzeSakEHqhPLynsPQSthH7ALG
         3g8MBP1Z88JmfpSDZid3AeEM80Dvfr3fAS4TCbTdu7RHUNFjPdDQwFDfkUsulkXQRy/r
         0Gkg==
X-Gm-Message-State: AOAM531sxMTbRPIpXAOBFHlbUs+xV88ruL10Sxya9k/evvfJIGCNhDQG
        HmAU15TA7unSR7yLnY+EXtOwuzh4sqVPhsx53y4VhNBxO6qE
X-Google-Smtp-Source: ABdhPJx85cE4K8421PBymS0PHNkJgFK9/jwOKP+4i1g/gFmQcemLa5buwduleP0b7Eqa5ENlBHvGgXULQpybO9gNS928xE1zlicC
MIME-Version: 1.0
X-Received: by 2002:a05:6638:260d:b0:323:8d31:d61b with SMTP id
 m13-20020a056638260d00b003238d31d61bmr477982jat.111.1648661789170; Wed, 30
 Mar 2022 10:36:29 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:36:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c66c305db72fc50@google.com>
Subject: [syzbot] possible deadlock in iterate_supers
From:   syzbot <syzbot+2289e1c10dde387e671e@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a67ba3cf9551 Add linux-next specific files for 20220330
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1636ed53700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=994543c31e941639
dashboard link: https://syzkaller.appspot.com/bug?extid=2289e1c10dde387e671e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2289e1c10dde387e671e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.17.0-next-20220330-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.2/1465 is trying to acquire lock:
ffff88807f0520e0 (&type->s_umount_key#32){++++}-{3:3}, at: iterate_supers+0xdb/0x290 fs/super.c:692

but task is already holding lock:
ffff88807f344460 (sb_writers#3){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1305 [inline]
ffff88807f344460 (sb_writers#3){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1297 [inline]
ffff88807f344460 (sb_writers#3){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x149/0x210 fs/read_write.c:1297

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (sb_writers#3){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1728 [inline]
       sb_start_write include/linux/fs.h:1798 [inline]
       file_start_write include/linux/fs.h:2815 [inline]
       kernel_write fs/read_write.c:564 [inline]
       kernel_write+0x2ac/0x540 fs/read_write.c:555
       p9_fd_write net/9p/trans_fd.c:428 [inline]
       p9_write_work+0x25e/0xca0 net/9p/trans_fd.c:479
       process_one_work+0x996/0x1610 kernel/workqueue.c:2289
       worker_thread+0x665/0x1080 kernel/workqueue.c:2436
       kthread+0x2e9/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

-> #2 ((work_completion)(&m->wq)){+.+.}-{0:0}:
       process_one_work+0x905/0x1610 kernel/workqueue.c:2265
       worker_thread+0x665/0x1080 kernel/workqueue.c:2436
       kthread+0x2e9/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

-> #1 ((wq_completion)events){+.+.}-{0:0}:
       flush_workqueue+0x164/0x1440 kernel/workqueue.c:2831
       flush_scheduled_work include/linux/workqueue.h:583 [inline]
       ext4_put_super+0x99/0x1150 fs/ext4/super.c:1202
       generic_shutdown_super+0x14c/0x400 fs/super.c:462
       kill_block_super+0x97/0xf0 fs/super.c:1394
       deactivate_locked_super+0x94/0x160 fs/super.c:332
       deactivate_super+0xad/0xd0 fs/super.c:363
       cleanup_mnt+0x3a2/0x540 fs/namespace.c:1186
       task_work_run+0xdd/0x1a0 kernel/task_work.c:164
       resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:183 [inline]
       exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:215
       __syscall_exit_to_user_mode_work kernel/entry/common.c:297 [inline]
       syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:308
       do_syscall_64+0x42/0x80 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&type->s_umount_key#32){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3096 [inline]
       check_prevs_add kernel/locking/lockdep.c:3219 [inline]
       validate_chain kernel/locking/lockdep.c:3834 [inline]
       __lock_acquire+0x2ac6/0x56c0 kernel/locking/lockdep.c:5060
       lock_acquire kernel/locking/lockdep.c:5672 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5637
       down_read+0x98/0x440 kernel/locking/rwsem.c:1461
       iterate_supers+0xdb/0x290 fs/super.c:692
       drop_caches_sysctl_handler+0xdb/0x110 fs/drop_caches.c:62
       proc_sys_call_handler+0x4a1/0x6e0 fs/proc/proc_sysctl.c:604
       call_write_iter include/linux/fs.h:2080 [inline]
       do_iter_readv_writev+0x3d1/0x640 fs/read_write.c:726
       do_iter_write+0x182/0x700 fs/read_write.c:852
       vfs_iter_write+0x70/0xa0 fs/read_write.c:893
       iter_file_splice_write+0x723/0xc70 fs/splice.c:689
       do_splice_from fs/splice.c:767 [inline]
       direct_splice_actor+0x110/0x180 fs/splice.c:936
       splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
       do_splice_direct+0x1a7/0x270 fs/splice.c:979
       do_sendfile+0xae0/0x1240 fs/read_write.c:1246
       __do_sys_sendfile64 fs/read_write.c:1305 [inline]
       __se_sys_sendfile64 fs/read_write.c:1297 [inline]
       __x64_sys_sendfile64+0x149/0x210 fs/read_write.c:1297
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  &type->s_umount_key#32 --> (work_completion)(&m->wq) --> sb_writers#3

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_writers#3);
                               lock((work_completion)(&m->wq));
                               lock(sb_writers#3);
  lock(&type->s_umount_key#32);

 *** DEADLOCK ***

1 lock held by syz-executor.2/1465:
 #0: ffff88807f344460 (sb_writers#3){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1305 [inline]
 #0: ffff88807f344460 (sb_writers#3){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1297 [inline]
 #0: ffff88807f344460 (sb_writers#3){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x149/0x210 fs/read_write.c:1297

stack backtrace:
CPU: 1 PID: 1465 Comm: syz-executor.2 Not tainted 5.17.0-next-20220330-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2176
 check_prev_add kernel/locking/lockdep.c:3096 [inline]
 check_prevs_add kernel/locking/lockdep.c:3219 [inline]
 validate_chain kernel/locking/lockdep.c:3834 [inline]
 __lock_acquire+0x2ac6/0x56c0 kernel/locking/lockdep.c:5060
 lock_acquire kernel/locking/lockdep.c:5672 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5637
 down_read+0x98/0x440 kernel/locking/rwsem.c:1461
 iterate_supers+0xdb/0x290 fs/super.c:692
 drop_caches_sysctl_handler+0xdb/0x110 fs/drop_caches.c:62
 proc_sys_call_handler+0x4a1/0x6e0 fs/proc/proc_sysctl.c:604
 call_write_iter include/linux/fs.h:2080 [inline]
 do_iter_readv_writev+0x3d1/0x640 fs/read_write.c:726
 do_iter_write+0x182/0x700 fs/read_write.c:852
 vfs_iter_write+0x70/0xa0 fs/read_write.c:893
 iter_file_splice_write+0x723/0xc70 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0x110/0x180 fs/splice.c:936
 splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
 do_splice_direct+0x1a7/0x270 fs/splice.c:979
 do_sendfile+0xae0/0x1240 fs/read_write.c:1246
 __do_sys_sendfile64 fs/read_write.c:1305 [inline]
 __se_sys_sendfile64 fs/read_write.c:1297 [inline]
 __x64_sys_sendfile64+0x149/0x210 fs/read_write.c:1297
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f88f7889049
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f88f89e1168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f88f799bf60 RCX: 00007f88f7889049
RDX: 00000000200000c0 RSI: 0000000000000003 RDI: 0000000000000004
RBP: 00007f88f78e308d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000262 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc47da187f R14: 00007f88f89e1300 R15: 0000000000022000
 </TASK>
syz-executor.2 (1465): drop_caches: 1


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
