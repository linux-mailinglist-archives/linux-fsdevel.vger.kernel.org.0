Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD2675965C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 15:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjGSNRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 09:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGSNRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:17:06 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9054B1718
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 06:17:02 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6b9d320ddd4so4999584a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 06:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689772622; x=1692364622;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J+/NLVDk6pVE99eI5/RKyyNr2TfWektXWHpLNSnb2QI=;
        b=BYh/l/dxN4gNOTBR4jOv3hK9RzV792LGJDPeFwZYmHkwuU+vSIAvCSwUA7eA5zEANq
         byHl3buRx6EgHKo4OMtW5tcwN3JAPPZy76R/Yyfa9iNdMdRKTTQJAK5cRaXjbeKpiVqV
         Gvg9s5P2QuzKdKJspT56dYumEDjELPWNACPtwIlC8ezhG/7d+Bcd+n4Cm1mkBC++8bwA
         b8TrCJ68e+Mg04Yg+fQbKO9Wgpq/IqrTN+45BuOBTWSMHva8ShfkK8yynZVXixIVP/kU
         2pm7XT27Cr1d3jTMw8LXbIWjfhZMYIxMDlf4mr5zWki9NrQzfawB4tQqLT641nTL6iZO
         6yJQ==
X-Gm-Message-State: ABy/qLb5FCONLoyG3G9tomNRpSlOeAAp+8eSoVRLJ3P9qkGM5H1RQYZC
        Xgarv9gGYBPXpJo1ObDLqC7mEf5uswktLEtr0y0tiPr+v/dY
X-Google-Smtp-Source: APBJJlETVnFJ4hE14zLh3mloorKCcbm3ra9GHReJe4xoyfVRhHQRQs6xCWjpLPaNQsN+tzhlgjQ93f0RBUk5e/Xwfh8WprWnZIcx
MIME-Version: 1.0
X-Received: by 2002:a9d:5e17:0:b0:6b8:92ea:23c4 with SMTP id
 d23-20020a9d5e17000000b006b892ea23c4mr2868144oti.4.1689772621916; Wed, 19 Jul
 2023 06:17:01 -0700 (PDT)
Date:   Wed, 19 Jul 2023 06:17:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e171200600d6d8bd@google.com>
Subject: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (2)
From:   syzbot <syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fdf0eaf11452 Linux 6.5-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135aae66a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=da4f9f61f96525c62cc7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f95d243908cc/disk-fdf0eaf1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f55beab9d6de/vmlinux-fdf0eaf1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bea743a43c4f/bzImage-fdf0eaf1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.5.0-rc2-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.0/14284 is trying to acquire lock:
ffff8880870e9c30 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb2/0xd10 fs/seq_file.c:182

but task is already holding lock:
ffff88814bdc8410 (sb_writers#4){.+.+}-{0:0}, at: do_sendfile+0x600/0x1070 fs/read_write.c:1253

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (sb_writers#4){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1494 [inline]
       sb_start_write+0x4d/0x1c0 include/linux/fs.h:1569
       mnt_want_write+0x3f/0x90 fs/namespace.c:403
       ovl_create_object+0xf8/0x300 fs/overlayfs/dir.c:629
       lookup_open fs/namei.c:3492 [inline]
       open_last_lookups fs/namei.c:3560 [inline]
       path_openat+0x13e7/0x3180 fs/namei.c:3790
       do_filp_open+0x234/0x490 fs/namei.c:3820
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1407
       do_sys_open fs/open.c:1422 [inline]
       __do_sys_openat fs/open.c:1438 [inline]
       __se_sys_openat fs/open.c:1433 [inline]
       __x64_sys_openat+0x247/0x290 fs/open.c:1433
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       down_read+0x47/0x2f0 kernel/locking/rwsem.c:1520
       inode_lock_shared include/linux/fs.h:781 [inline]
       lookup_slow+0x45/0x70 fs/namei.c:1706
       walk_component+0x2d0/0x400 fs/namei.c:1998
       lookup_last fs/namei.c:2455 [inline]
       path_lookupat+0x16f/0x450 fs/namei.c:2479
       filename_lookup+0x255/0x610 fs/namei.c:2508
       kern_path+0x3b/0x180 fs/namei.c:2606
       lookup_bdev+0xc5/0x290 block/bdev.c:943
       resume_store+0x19c/0x700 kernel/power/hibernate.c:1177
       kernfs_fop_write_iter+0x3a6/0x4f0 fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:1871 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x782/0xaf0 fs/read_write.c:584
       ksys_write+0x1a0/0x2c0 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&of->mutex){+.+.}-{3:3}:
       __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
       kernfs_seq_start+0x53/0x3a0 fs/kernfs/file.c:154
       seq_read_iter+0x3d4/0xd10 fs/seq_file.c:225
       call_read_iter include/linux/fs.h:1865 [inline]
       new_sync_read fs/read_write.c:389 [inline]
       vfs_read+0x795/0xb00 fs/read_write.c:470
       ksys_read+0x1a0/0x2c0 fs/read_write.c:613
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&p->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
       __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
       seq_read_iter+0xb2/0xd10 fs/seq_file.c:182
       proc_reg_read_iter+0x1bc/0x290 fs/proc/inode.c:305
       call_read_iter include/linux/fs.h:1865 [inline]
       copy_splice_read+0x4c9/0x9c0 fs/splice.c:367
       splice_direct_to_actor+0x2c4/0x9e0 fs/splice.c:1070
       do_splice_direct+0x2ac/0x3f0 fs/splice.c:1195
       do_sendfile+0x623/0x1070 fs/read_write.c:1254
       __do_sys_sendfile64 fs/read_write.c:1322 [inline]
       __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &p->lock --> &ovl_i_mutex_dir_key[depth] --> sb_writers#4

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#4);
                               lock(&ovl_i_mutex_dir_key[depth]);
                               lock(sb_writers#4);
  lock(&p->lock);

 *** DEADLOCK ***

1 lock held by syz-executor.0/14284:
 #0: ffff88814bdc8410 (sb_writers#4){.+.+}-{0:0}, at: do_sendfile+0x600/0x1070 fs/read_write.c:1253

stack backtrace:
CPU: 1 PID: 14284 Comm: syz-executor.0 Not tainted 6.5.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x375/0x4a0 kernel/locking/lockdep.c:2195
 check_prev_add kernel/locking/lockdep.c:3142 [inline]
 check_prevs_add kernel/locking/lockdep.c:3261 [inline]
 validate_chain kernel/locking/lockdep.c:3876 [inline]
 __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
 __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 seq_read_iter+0xb2/0xd10 fs/seq_file.c:182
 proc_reg_read_iter+0x1bc/0x290 fs/proc/inode.c:305
 call_read_iter include/linux/fs.h:1865 [inline]
 copy_splice_read+0x4c9/0x9c0 fs/splice.c:367
 splice_direct_to_actor+0x2c4/0x9e0 fs/splice.c:1070
 do_splice_direct+0x2ac/0x3f0 fs/splice.c:1195
 do_sendfile+0x623/0x1070 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fed17a7cb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fed188640c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fed17b9c1f0 RCX: 00007fed17a7cb29
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 0000000000000008
RBP: 00007fed17ac847a R08: 0000000000000000 R09: 0000000000000000
R10: 4000000000010046 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fed17b9c1f0 R15: 00007fff433e8a98
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
