Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C265A4ECACD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 19:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349337AbiC3RiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 13:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349336AbiC3RiP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:38:15 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D42B8202
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 10:36:29 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id u18-20020a5d8712000000b0064c7a7c497aso6079385iom.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 10:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NnWQsXw1ZTIntCkZPjGnAGxTYe0oZYJwswahLRe1MQY=;
        b=qt0M/JRkjQgsmQm1P8obl6jwECzjCWCBUW2NkND1qZIPokdMzdBXc513eu22mzyjgz
         GfO5qYYwgTFmBVPMAH0BcuuKipDKGXciMkUIkgTTNqsaqaAjkqyuWbhS5z8BnlTlnUC7
         yQywFz+YDv+RPrlghhKqs3PuMJ40oo3Dz6lP4fkILs3oZROOwJvVR6Lt/Uq0PFyjJIB8
         ZupqrTqnHK5knX8UJxOvSbC3vzJDdVpJUEkLmPlLY5a/E8IY06nghFMPIPGQ4d03rXcm
         /03nZ5StzfQwJhN1cFrupjAbHFGdnpp9faEfULklgC3N94Bp30qofSUdZ88YpbEyhVAO
         yW/w==
X-Gm-Message-State: AOAM531mvnTQiISWiYuMzZlhzvm1Qx+cgfw5qmO8iYEbF+O2S5W8BsAw
        aDu7OGFdy/NgQAdaXhqcZU68kfRjzOtvsYNeeVS/vaoHfmzg
X-Google-Smtp-Source: ABdhPJxTb1MD0lsR99SUT1yPR+FFFDpANVCDQZQ76AAtWRh4rtgb2h+MDJlMAQMlhXDXpdoRHjXfek1YqlsSUnHlIgDfd7eZChTh
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1918:b0:323:a4de:296 with SMTP id
 p24-20020a056638191800b00323a4de0296mr157592jal.212.1648661788910; Wed, 30
 Mar 2022 10:36:28 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:36:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048681f05db72fc45@google.com>
Subject: [syzbot] possible deadlock in deactivate_super
From:   syzbot <syzbot+df9d057e38be100ccbbe@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=10ab1377700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=994543c31e941639
dashboard link: https://syzkaller.appspot.com/bug?extid=df9d057e38be100ccbbe
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b3d027700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159db307700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df9d057e38be100ccbbe@syzkaller.appspotmail.com

RBP: 00007ffc747c2860 R08: 00000000ffffffff R09: 00007ffc747c2640
R10: 0000555555879653 R11: 0000000000000202 R12: 00007ffc747c38d0
R13: 00005555558795f0 R14: 00007ffc747c27d0 R15: 0000000000000001
 </TASK>
======================================================
WARNING: possible circular locking dependency detected
5.17.0-next-20220330-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor314/3590 is trying to acquire lock:
ffff888010c64d38 ((wq_completion)events){+.+.}-{0:0}, at: flush_workqueue+0x135/0x1440 kernel/workqueue.c:2828

but task is already holding lock:
ffff88801df760e0 (&type->s_umount_key#32){++++}-{3:3}, at: deactivate_super+0xa5/0xd0 fs/super.c:362

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&type->s_umount_key#32){++++}-{3:3}:
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

-> #2 (sb_writers#3){.+.+}-{0:0}:
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

-> #1 ((work_completion)(&m->wq)){+.+.}-{0:0}:
       process_one_work+0x905/0x1610 kernel/workqueue.c:2265
       worker_thread+0x665/0x1080 kernel/workqueue.c:2436
       kthread+0x2e9/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

-> #0 ((wq_completion)events){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3096 [inline]
       check_prevs_add kernel/locking/lockdep.c:3219 [inline]
       validate_chain kernel/locking/lockdep.c:3834 [inline]
       __lock_acquire+0x2ac6/0x56c0 kernel/locking/lockdep.c:5060
       lock_acquire kernel/locking/lockdep.c:5672 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5637
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

other info that might help us debug this:

Chain exists of:
  (wq_completion)events --> sb_writers#3 --> &type->s_umount_key#32

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->s_umount_key#32);
                               lock(sb_writers#3);
                               lock(&type->s_umount_key#32);
  lock((wq_completion)events);

 *** DEADLOCK ***

1 lock held by syz-executor314/3590:
 #0: ffff88801df760e0 (&type->s_umount_key#32){++++}-{3:3}, at: deactivate_super+0xa5/0xd0 fs/super.c:362

stack backtrace:
CPU: 1 PID: 3590 Comm: syz-executor314 Not tainted 5.17.0-next-20220330-syzkaller #0
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
RIP: 0033:0x7f2437452687
Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc747c27a8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f2437452687
RDX: 00007ffc747c2869 RSI: 000000000000000a RDI: 00007ffc747c2860
RBP: 00007ffc747c2860 R08: 00000000ffffffff R09: 00007ffc747c2640
R10: 0000555555879653 R11: 0000000000000202 R12: 00007ffc747c38d0
R13: 00005555558795f0 R14: 00007ffc747c27d0 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
