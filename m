Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C903714ED1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjE2RN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 13:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjE2RN4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 13:13:56 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62D4C7
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 May 2023 10:13:52 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7773997237cso42638539f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 May 2023 10:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685380432; x=1687972432;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ebxk1Up7SOQpJbCMXXPHyjff+XCGPo0IXGxHF8GOp5Y=;
        b=OV/3QNsDGnjfbYsVF4lzVnEp941gseNmqqzPhn+Ny9V8OadM9wTOyTm8sVN/owchcz
         Qu7yysl08q71oiD3NomNHzTcaiDKxP1qhrsy5ruKLgJIF0CLqMGhZAOYi5m+nF7A9/Am
         x0utOsLS8lp3G1nL/beZT8xD21CAqqP67y2IEJk5iVPlTNlFGuwzD6qmMnGsqfzJR2yd
         PcTjYVMtZCVkU5AmIJPr+zZwecGXdsJ2FsfUIMaAWT5ftMT354ksp0TMTemPP3Ogtuwi
         3BPwBW+q+kzvcoBP9k1Se7swaxXkN9bws+xLQHtspMqtpEmv7ybQAkB1rwI7gHNcsyEl
         1gKQ==
X-Gm-Message-State: AC+VfDyVDLVUOXKJHnm82m5hW884le3Zd18vKehCLygfJDu9md1kFnQN
        16/AS6YrlQ3zK/TVo842Ewjl733Xx9Zi6BQx9YVPoQ8Yn9bTLiWZCw==
X-Google-Smtp-Source: ACHHUZ719JgOvsWUXMznoKZghQiAyD4AFO0DDl21J8oAwcAXIwlmKvxeoIITN21nDCTOS9J3sSTgcOfjRfbWhKoOr3HVcoZRMCtg
MIME-Version: 1.0
X-Received: by 2002:a02:2a47:0:b0:41a:bb82:ddc0 with SMTP id
 w68-20020a022a47000000b0041abb82ddc0mr2965834jaw.4.1685380432263; Mon, 29 May
 2023 10:13:52 -0700 (PDT)
Date:   Mon, 29 May 2023 10:13:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa007305fcd83579@google.com>
Subject: [syzbot] [reiserfs?] possible deadlock in do_unlinkat
From:   syzbot <syzbot+ada12d2d935bbc82aa7f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    933174ae28ba Merge tag 'spi-fix-v6.4-rc3' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=167d464d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8067683055e3f5
dashboard link: https://syzkaller.appspot.com/bug?extid=ada12d2d935bbc82aa7f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106e6d19280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cf84e5280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/189d556c105e/disk-933174ae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/498458304963/vmlinux-933174ae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68bcd9d7c04c/bzImage-933174ae.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a89e85025777/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ada12d2d935bbc82aa7f@syzkaller.appspotmail.com

REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc3-syzkaller-00032-g933174ae28ba #0 Not tainted
------------------------------------------------------
syz-executor392/4995 is trying to acquire lock:
ffff888022309090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x7a/0xd0 fs/reiserfs/lock.c:27

but task is already holding lock:
ffff8880759902e0 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
ffff8880759902e0 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: do_unlinkat+0x26a/0x950 fs/namei.c:4378

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}:
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
       down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1689
       inode_lock_nested include/linux/fs.h:810 [inline]
       do_unlinkat+0x26a/0x950 fs/namei.c:4378
       __do_sys_unlinkat fs/namei.c:4436 [inline]
       __se_sys_unlinkat fs/namei.c:4429 [inline]
       __x64_sys_unlinkat+0xce/0xf0 fs/namei.c:4429
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (sb_writers#9){.+.+}-{0:0}:
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1494 [inline]
       sb_start_write+0x4d/0x1c0 include/linux/fs.h:1569
       mnt_want_write_file+0x5e/0x1f0 fs/namespace.c:438
       reiserfs_ioctl+0x174/0x340 fs/reiserfs/ioctl.c:103
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&sbi->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3108 [inline]
       check_prevs_add kernel/locking/lockdep.c:3227 [inline]
       validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3842
       __lock_acquire+0x1295/0x2000 kernel/locking/lockdep.c:5074
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
       __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x7a/0xd0 fs/reiserfs/lock.c:27
       reiserfs_lookup+0x162/0x580 fs/reiserfs/namei.c:364
       lookup_one_qstr_excl+0x11b/0x250 fs/namei.c:1605
       do_unlinkat+0x298/0x950 fs/namei.c:4379
       __do_sys_unlinkat fs/namei.c:4436 [inline]
       __se_sys_unlinkat fs/namei.c:4429 [inline]
       __x64_sys_unlinkat+0xce/0xf0 fs/namei.c:4429
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &sbi->lock --> sb_writers#9 --> &type->i_mutex_dir_key#6/1

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->i_mutex_dir_key#6/1);
                               lock(sb_writers#9);
                               lock(&type->i_mutex_dir_key#6/1);
  lock(&sbi->lock);

 *** DEADLOCK ***

2 locks held by syz-executor392/4995:
 #0: ffff88807d18c460 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:394
 #1: ffff8880759902e0 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
 #1: ffff8880759902e0 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: do_unlinkat+0x26a/0x950 fs/namei.c:4378

stack backtrace:
CPU: 0 PID: 4995 Comm: syz-executor392 Not tainted 6.4.0-rc3-syzkaller-00032-g933174ae28ba #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x2fe/0x3b0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3108 [inline]
 check_prevs_add kernel/locking/lockdep.c:3227 [inline]
 validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3842
 __lock_acquire+0x1295/0x2000 kernel/locking/lockdep.c:5074
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
 __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x7a/0xd0 fs/reiserfs/lock.c:27
 reiserfs_lookup+0x162/0x580 fs/reiserfs/namei.c:364
 lookup_one_qstr_excl+0x11b/0x250 fs/namei.c:1605
 do_unlinkat+0x298/0x950 fs/namei.c:4379
 __do_sys_unlinkat fs/namei.c:4436 [inline]
 __se_sys_unlinkat fs/namei.c:4429 [inline]
 __x64_sys_unlinkat+0xce/0xf0 fs/namei.c:4429
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ffa0fa838f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
