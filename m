Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FA43A86FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 18:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhFORBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 13:01:30 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:33479 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhFORB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:01:29 -0400
Received: by mail-io1-f71.google.com with SMTP id e23-20020a6bf1170000b02904d7ff72e203so1852471iog.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 09:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rGxznhI0w7LBzj6R5sKdYvHHJscUEONUGoZbkAaKxqA=;
        b=eAAqpZSIBxd9jYXajsGIYEscJ785Myl1cyvR3+Is0ACkksmG0VCqX3lOgOOr2LjU/p
         0qaiaOj7t7u+go+f+6pXGYRi5f6SMWSyC0LvqdfHKJ5mxlcymRyVqL/iBQ7zW9whA0UT
         yD3M4XKpbTowNp310Q2GfpyoG2TpSBkeKIOBklkvDZgTJTEV3Imlz2qkIPpmrw0qsuJW
         awDeXHXAmJ3GX+R4wdu1TIsn1imac9GKeQcexq+UgCFVzVOsj4tcD/D16OdD5z27xKCK
         tcVzNZNKmi9MrUQaRhsclyvx18qwpBpG/Lfu/yQ8eZdAZ6/rYglc72IzEu9ZhZh95n5v
         a3Ng==
X-Gm-Message-State: AOAM530fk7gcjcGPDfR6biRM4qST7+JgXL/fAb3iwXr0BgtaAgTiPEO9
        RmdDrVz2AKICN5KoscrWIlO/N2vU1EJdmMVOwWYt3wulxuuN
X-Google-Smtp-Source: ABdhPJyF9BzOygF+qxBRiTJ5lg7+I/K5V93Ne4DR9E91o9QX6GEFSKkUNUURtyjlGXKplQcdkKXz6HwmnMf398XPtY4BhDl7Fg83
MIME-Version: 1.0
X-Received: by 2002:a92:ddc6:: with SMTP id d6mr326208ilr.51.1623776364578;
 Tue, 15 Jun 2021 09:59:24 -0700 (PDT)
Date:   Tue, 15 Jun 2021 09:59:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067d24205c4d0e599@google.com>
Subject: [syzbot] possible deadlock in mnt_want_write (2)
From:   syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    06af8679 coredump: Limit what can interrupt coredumps
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162f99afd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=547a5e42ca601229
dashboard link: https://syzkaller.appspot.com/bug?extid=b42fe626038981fb7bfa
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.13.0-rc5-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.1/21398 is trying to acquire lock:
ffff8881485a6460 (sb_writers#5){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:375

but task is already holding lock:
ffff888034945bc0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x75a/0x1ba0 security/integrity/ima/ima_main.c:253

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&iint->mutex){+.+.}-{3:3}:
       lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
       __mutex_lock_common+0x1bf/0x3100 kernel/locking/mutex.c:959
       __mutex_lock kernel/locking/mutex.c:1104 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
       process_measurement+0x75a/0x1ba0 security/integrity/ima/ima_main.c:253
       ima_file_check+0xe0/0x130 security/integrity/ima/ima_main.c:499
       do_open fs/namei.c:3363 [inline]
       path_openat+0x293d/0x39b0 fs/namei.c:3494
       do_filp_open+0x221/0x460 fs/namei.c:3521
       do_sys_openat2+0x124/0x460 fs/open.c:1187
       do_sys_open fs/open.c:1203 [inline]
       __do_sys_open fs/open.c:1211 [inline]
       __se_sys_open fs/open.c:1207 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1207
       do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (sb_writers#5){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:2938 [inline]
       check_prevs_add+0x4f9/0x5b60 kernel/locking/lockdep.c:3061
       validate_chain kernel/locking/lockdep.c:3676 [inline]
       __lock_acquire+0x4307/0x6040 kernel/locking/lockdep.c:4902
       lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1763 [inline]
       sb_start_write+0x4f/0x180 include/linux/fs.h:1833
       mnt_want_write+0x3b/0x80 fs/namespace.c:375
       ovl_maybe_copy_up+0x117/0x180 fs/overlayfs/copy_up.c:996
       ovl_open+0xa2/0x200 fs/overlayfs/file.c:149
       do_dentry_open+0x7cb/0x1010 fs/open.c:826
       vfs_open fs/open.c:940 [inline]
       dentry_open+0xc6/0x120 fs/open.c:956
       ima_calc_file_hash+0x157/0x1b00 security/integrity/ima/ima_crypto.c:557
       ima_collect_measurement+0x283/0x520 security/integrity/ima/ima_api.c:252
       process_measurement+0xf79/0x1ba0 security/integrity/ima/ima_main.c:330
       ima_file_check+0xe0/0x130 security/integrity/ima/ima_main.c:499
       do_open fs/namei.c:3363 [inline]
       path_openat+0x293d/0x39b0 fs/namei.c:3494
       do_filp_open+0x221/0x460 fs/namei.c:3521
       do_sys_openat2+0x124/0x460 fs/open.c:1187
       do_sys_open fs/open.c:1203 [inline]
       __do_sys_open fs/open.c:1211 [inline]
       __se_sys_open fs/open.c:1207 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1207
       do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&iint->mutex);
                               lock(sb_writers#5);
                               lock(&iint->mutex);
  lock(sb_writers#5);

 *** DEADLOCK ***

1 lock held by syz-executor.1/21398:
 #0: ffff888034945bc0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x75a/0x1ba0 security/integrity/ima/ima_main.c:253

stack backtrace:
CPU: 0 PID: 21398 Comm: syz-executor.1 Not tainted 5.13.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x202/0x31e lib/dump_stack.c:120
 print_circular_bug+0xb17/0xdc0 kernel/locking/lockdep.c:2007
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2129
 check_prev_add kernel/locking/lockdep.c:2938 [inline]
 check_prevs_add+0x4f9/0x5b60 kernel/locking/lockdep.c:3061
 validate_chain kernel/locking/lockdep.c:3676 [inline]
 __lock_acquire+0x4307/0x6040 kernel/locking/lockdep.c:4902
 lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1763 [inline]
 sb_start_write+0x4f/0x180 include/linux/fs.h:1833
 mnt_want_write+0x3b/0x80 fs/namespace.c:375
 ovl_maybe_copy_up+0x117/0x180 fs/overlayfs/copy_up.c:996
 ovl_open+0xa2/0x200 fs/overlayfs/file.c:149
 do_dentry_open+0x7cb/0x1010 fs/open.c:826
 vfs_open fs/open.c:940 [inline]
 dentry_open+0xc6/0x120 fs/open.c:956
 ima_calc_file_hash+0x157/0x1b00 security/integrity/ima/ima_crypto.c:557
 ima_collect_measurement+0x283/0x520 security/integrity/ima/ima_api.c:252
 process_measurement+0xf79/0x1ba0 security/integrity/ima/ima_main.c:330
 ima_file_check+0xe0/0x130 security/integrity/ima/ima_main.c:499
 do_open fs/namei.c:3363 [inline]
 path_openat+0x293d/0x39b0 fs/namei.c:3494
 do_filp_open+0x221/0x460 fs/namei.c:3521
 do_sys_openat2+0x124/0x460 fs/open.c:1187
 do_sys_open fs/open.c:1203 [inline]
 __do_sys_open fs/open.c:1211 [inline]
 __se_sys_open fs/open.c:1207 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1207
 do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f28cc64c188 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000020000200
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffdd1759cef R14: 00007f28cc64c300 R15: 0000000000022000
overlayfs: upperdir is in-use as upperdir/workdir of another mount, mount with '-o index=off' to override exclusive upperdir protection.


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
