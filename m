Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B057134CD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 May 2023 14:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjE0MiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 May 2023 08:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjE0MiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 May 2023 08:38:11 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3784B10A
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 May 2023 05:37:40 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7749b49ce95so116630739f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 May 2023 05:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685191007; x=1687783007;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXLeImvadCCjJrIitdWXQ/Qq5+spMjoR50QGkRnRX5k=;
        b=Gc6LlKjXN+Rxb+Iz23JVjVZpSbyMGOr1RmsqktOHj2/833OSoWubHlP+bkyhBmWt0L
         RtbTRdmCl8z1U7z4pbVsN0DeY0mPtu86Jdwkkud6NHybrBQoGEFbvyh1vaFnQyNyk9fW
         r8T/FaONIi+ANOifM0fFtCk6FHX5Ifb66NOihk794Ot7RDQwzdptk5ePCmANehNVHLTm
         4YwXHcNuQELAdkBBGj7CHJFMF+PbDy5YBWs5UiOC2mYnVSpU1dsi0NrRtwJCt+UxpaSc
         7y/i067BfClvOw/7Qp5USHBOzZu5jpVDvBVbJd8hSmxd28S7nfqfruyyp+iFqfuBrqat
         g6oA==
X-Gm-Message-State: AC+VfDx61SpeoVUxolygziuJfOSe0IeOoeb9IeDfAk32CCa94SVmf/NM
        la+SrqRYHFu1uEmN5rpBv8YwdlLVrmm3CJw10bhhgUhkKktp
X-Google-Smtp-Source: ACHHUZ4nLH293RmzQ05tAr9ipA7lfymnIlgUBq00ASiGMf/mxdaZfHrnZXY61Lfx305YikEpGGPDxX50IBh5by0nTbAS6Diys1Sf
MIME-Version: 1.0
X-Received: by 2002:a92:dc4f:0:b0:331:1846:6064 with SMTP id
 x15-20020a92dc4f000000b0033118466064mr910654ilq.5.1685191007474; Sat, 27 May
 2023 05:36:47 -0700 (PDT)
Date:   Sat, 27 May 2023 05:36:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000611acc05fcac1bf5@google.com>
Subject: [syzbot] [squashfs?] [fuse?] INFO: task hung in truncate_inode_pages_range
 (6)
From:   syzbot <syzbot+dd00076bcf1ab8165aea@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f1fcbaa18b28 Linux 6.4-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1505bb65280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3dc1cdd68141cdc3
dashboard link: https://syzkaller.appspot.com/bug?extid=dd00076bcf1ab8165aea
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110c71d9280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1222c039280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f9e1748cceea/disk-f1fcbaa1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6dea99343621/vmlinux-f1fcbaa1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f5a93f86012d/Image-f1fcbaa1.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ebeba8fb1375/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd00076bcf1ab8165aea@syzkaller.appspotmail.com

INFO: task syz-executor176:6013 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc2-syzkaller-gf1fcbaa18b28 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor176 state:D stack:0     pid:6013  ppid:6011   flags:0x00000000
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0x1368/0x23b8 kernel/sched/core.c:6669
 schedule+0xc4/0x170 kernel/sched/core.c:6745
 io_schedule+0x8c/0x12c kernel/sched/core.c:8979
 folio_wait_bit_common+0x65c/0xb90 mm/filemap.c:1301
 __folio_lock+0x2c/0x3c mm/filemap.c:1664
 folio_lock include/linux/pagemap.h:955 [inline]
 truncate_inode_pages_range+0x930/0xf74 mm/truncate.c:422
 truncate_inode_pages mm/truncate.c:449 [inline]
 truncate_inode_pages_final+0x90/0xc0 mm/truncate.c:484
 evict+0x26c/0x68c fs/inode.c:667
 dispose_list fs/inode.c:698 [inline]
 evict_inodes+0x6b4/0x74c fs/inode.c:748
 generic_shutdown_super+0x9c/0x328 fs/super.c:479
 kill_block_super+0x70/0xdc fs/super.c:1407
 deactivate_locked_super+0xac/0x124 fs/super.c:331
 deactivate_super+0xe0/0x100 fs/super.c:362
 cleanup_mnt+0x34c/0x3dc fs/namespace.c:1177
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1184
 task_work_run+0x230/0x2e0 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x2180/0x3c90 arch/arm64/kernel/signal.c:1304
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x90/0x15c arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffff8000160810d0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x44/0xcf4 kernel/rcu/tasks.h:518
1 lock held by rcu_tasks_trace/14:
 #0: ffff800016081490 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x44/0xcf4 kernel/rcu/tasks.h:518
1 lock held by khungtaskd/28:
 #0: ffff800016080f00 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:326
2 locks held by getty/5728:
 #0: ffff0000dab28098 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff80001ae462f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x414/0x1210 drivers/tty/n_tty.c:2176
1 lock held by syz-executor176/6013:
 #0: ffff0000c99160e0 (&type->s_umount_key#41){+.+.}-{3:3}, at: deactivate_super+0xd8/0x100 fs/super.c:361

=============================================



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
