Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BA275F729
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 14:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjGXMwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 08:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjGXMwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:52:07 -0400
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7C810D3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 05:49:43 -0700 (PDT)
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-1b471ee7059so8425827fac.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 05:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690202946; x=1690807746;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MsaSWM/Bh1TsxCtNJsPGaZojPuj2Crz2y/DvWlvRfQU=;
        b=H9yduwEu3yERYfw+LyEiMCr6z49bWCbMuADoCGx1+FZkwQy8WIhuvIWqEPH5vp+xs3
         jifQ80DWmJe1u1jHyMM9HocfgkN3UVdaOYIdKUECKxe08UgomEW2k55em7aLAEhunJug
         roHkZMVsu+KICvFgqxXnIacixdD+l75bPq+0WBUhPzixeU+Lu8NxJaqBLDqoZ2FUFGDN
         11gYrrDgG0hxM6Y5P3MvR+iIiL2ZSvSIu1dAFxoZBHpURZ3S5ZbCZtWCrGn5vsSr6R3M
         fnNdKGASWjeBFPwXF53eVUmzYLWy7j+0z/NW4eLcWvxnYb+eJJ4Hg4OSQu9ObAtLf6tv
         1hdg==
X-Gm-Message-State: ABy/qLZNPc6mmCMJtZy7k+ESSDVayEnWFQm378XYCzbzYYNrYeobi8tn
        JEeqYL+CBDrDlh2PVm03RCfWkWjhMc02xrh0C3MpsPBUSS55
X-Google-Smtp-Source: APBJJlExIy7YJQ07oy0pZGK+a367e5v219//xlalNXFyclOE8aN/mqlplz91GzWYUZc6wvfP2b019eifkf8qQzAaXdX+eaQRzsKC
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c7a5:b0:1bb:4d41:e924 with SMTP id
 dy37-20020a056870c7a500b001bb4d41e924mr6013625oab.8.1690202946641; Mon, 24
 Jul 2023 05:49:06 -0700 (PDT)
Date:   Mon, 24 Jul 2023 05:49:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ba9f506013b0aed@google.com>
Subject: [syzbot] [ntfs3?] INFO: task hung in ntfs_read_folio (2)
From:   syzbot <syzbot+913093197c71922e8375@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bfa3037d8280 Merge tag 'fuse-update-6.5' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ebb5aea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=913093197c71922e8375
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b8869ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149e6072a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e914a402fd63/disk-bfa3037d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/748799ee6854/vmlinux-bfa3037d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cb76e843e4b6/bzImage-bfa3037d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/864deaa2a93a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+913093197c71922e8375@syzkaller.appspotmail.com

INFO: task syz-executor236:5167 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc2-syzkaller-00052-gbfa3037d8280 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor236 state:D stack:24232 pid:5167  ppid:5059   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 __mutex_lock_common+0xe33/0x2530 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 ni_lock fs/ntfs3/ntfs_fs.h:1124 [inline]
 ntfs_read_folio+0x193/0x210 fs/ntfs3/inode.c:715
 filemap_read_folio+0x19d/0x7a0 mm/filemap.c:2389
 filemap_create_folio mm/filemap.c:2517 [inline]
 filemap_get_pages+0xdf7/0x20c0 mm/filemap.c:2570
 filemap_splice_read+0x4ce/0xcd0 mm/filemap.c:2925
 splice_direct_to_actor+0x2c4/0x9e0 fs/splice.c:1070
 do_splice_direct+0x2ac/0x3f0 fs/splice.c:1195
 do_sendfile+0x623/0x1070 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f56e8e7ad09
RSP: 002b:00007f56e8e37218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f56e8f21708 RCX: 00007f56e8e7ad09
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007f56e8f21700 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 00007f56e8f2170c
R13: 00007f56e8eee4dc R14: 00007f56e8ecf0c0 R15: 0031656c69662f2e
 </TASK>
INFO: task syz-executor236:5180 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc2-syzkaller-00052-gbfa3037d8280 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor236 state:D stack:25256 pid:5180  ppid:5059   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 io_schedule+0x8c/0x100 kernel/sched/core.c:9028
 folio_wait_bit_common+0x86c/0x12b0 mm/filemap.c:1304
 __filemap_get_folio+0x90/0xa00 mm/filemap.c:1899
 pagecache_get_page+0x2e/0x220 mm/folio-compat.c:99
 find_or_create_page include/linux/pagemap.h:639 [inline]
 ni_readpage_cmpr+0x313/0xa70 fs/ntfs3/frecord.c:2135
 ntfs_read_folio+0x19e/0x210 fs/ntfs3/inode.c:716
 filemap_read_folio+0x19d/0x7a0 mm/filemap.c:2389
 filemap_create_folio mm/filemap.c:2517 [inline]
 filemap_get_pages+0xdf7/0x20c0 mm/filemap.c:2570
 filemap_splice_read+0x4ce/0xcd0 mm/filemap.c:2925
 splice_direct_to_actor+0x2c4/0x9e0 fs/splice.c:1070
 do_splice_direct+0x2ac/0x3f0 fs/splice.c:1195
 do_sendfile+0x623/0x1070 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f56e8e7ad09
RSP: 002b:00007f56e0c16218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f56e8f21718 RCX: 00007f56e8e7ad09
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007f56e8f21710 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 00007f56e8f2171c
R13: 00007f56e8eee4dc R14: 00007f56e8ecf0c0 R15: 0031656c69662f2e
 </TASK>
INFO: task syz-executor236:5350 blocked for more than 144 seconds.
      Not tainted 6.5.0-rc2-syzkaller-00052-gbfa3037d8280 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor236 state:D stack:24648 pid:5350  ppid:5058   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 io_schedule+0x8c/0x100 kernel/sched/core.c:9028
 folio_wait_bit_common+0x86c/0x12b0 mm/filemap.c:1304
 __filemap_get_folio+0x90/0xa00 mm/filemap.c:1899
 pagecache_get_page+0x2e/0x220 mm/folio-compat.c:99
 find_or_create_page include/linux/pagemap.h:639 [inline]
 ni_readpage_cmpr+0x313/0xa70 fs/ntfs3/frecord.c:2135
 ntfs_read_folio+0x19e/0x210 fs/ntfs3/inode.c:716
 filemap_read_folio+0x19d/0x7a0 mm/filemap.c:2389
 filemap_create_folio mm/filemap.c:2517 [inline]
 filemap_get_pages+0xdf7/0x20c0 mm/filemap.c:2570
 filemap_splice_read+0x4ce/0xcd0 mm/filemap.c:2925
 splice_direct_to_actor+0x2c4/0x9e0 fs/splice.c:1070
 do_splice_direct+0x2ac/0x3f0 fs/splice.c:1195
 do_sendfile+0x623/0x1070 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f56e8e7ad09
RSP: 002b:00007f56e8e37218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f56e8f21708 RCX: 00007f56e8e7ad09
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007f56e8f21700 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 00007f56e8f2170c
R13: 00007f56e8eee4dc R14: 00007f56e8ecf0c0 R15: 0031656c69662f2e
 </TASK>
INFO: task syz-executor236:5363 blocked for more than 144 seconds.
      Not tainted 6.5.0-rc2-syzkaller-00052-gbfa3037d8280 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor236 state:D stack:25096 pid:5363  ppid:5058   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 __mutex_lock_common+0xe33/0x2530 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 ni_lock fs/ntfs3/ntfs_fs.h:1124 [inline]
 ntfs_read_folio+0x193/0x210 fs/ntfs3/inode.c:715
 filemap_read_folio+0x19d/0x7a0 mm/filemap.c:2389
 filemap_create_folio mm/filemap.c:2517 [inline]
 filemap_get_pages+0xdf7/0x20c0 mm/filemap.c:2570
 filemap_splice_read+0x4ce/0xcd0 mm/filemap.c:2925
 splice_direct_to_actor+0x2c4/0x9e0 fs/splice.c:1070
 do_splice_direct+0x2ac/0x3f0 fs/splice.c:1195
 do_sendfile+0x623/0x1070 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f56e8e7ad09
RSP: 002b:00007f56e0c16218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f56e8f21718 RCX: 00007f56e8e7ad09
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007f56e8f21710 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 00007f56e8f2171c
R13: 00007f56e8eee4dc R14: 00007f56e8ecf0c0 R15: 0031656c69662f2e
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8d328af0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8d328eb0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/28:
 #0: ffffffff8d328920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by getty/4771:
 #0: ffff888029833098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015a02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b1/0x1dc0 drivers/tty/n_tty.c:2187
3 locks held by syz-executor236/5167:
 #0: ffff88802b5e8410 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x600/0x1070 fs/read_write.c:1253
 #1: ffff888074f847a0 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:826 [inline]
 #1: ffff888074f847a0 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_create_folio mm/filemap.c:2509 [inline]
 #1: ffff888074f847a0 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_get_pages+0xb1c/0x20c0 mm/filemap.c:2570
 #2: ffff888074f84360 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1124 [inline]
 #2: ffff888074f84360 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_read_folio+0x193/0x210 fs/ntfs3/inode.c:715
3 locks held by syz-executor236/5180:
 #0: ffff88802b5e8410 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x600/0x1070 fs/read_write.c:1253
 #1: ffff888074f847a0 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:826 [inline]
 #1: ffff888074f847a0 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_create_folio mm/filemap.c:2509 [inline]
 #1: ffff888074f847a0 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_get_pages+0xb1c/0x20c0 mm/filemap.c:2570
 #2: ffff888074f84360 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1124 [inline]
 #2: ffff888074f84360 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_read_folio+0x193/0x210 fs/ntfs3/inode.c:715
3 locks held by syz-executor236/5350:
 #0: ffff888071aac410 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x600/0x1070 fs/read_write.c:1253
 #1: ffff888074f5e520 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:826 [inline]
 #1: ffff888074f5e520 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_create_folio mm/filemap.c:2509 [inline]
 #1: ffff888074f5e520 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_get_pages+0xb1c/0x20c0 mm/filemap.c:2570
 #2: ffff888074f5e0e0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1124 [inline]
 #2: ffff888074f5e0e0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_read_folio+0x193/0x210 fs/ntfs3/inode.c:715
3 locks held by syz-executor236/5363:
 #0: ffff888071aac410 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x600/0x1070 fs/read_write.c:1253
 #1: ffff888074f5e520 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:826 [inline]
 #1: ffff888074f5e520 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_create_folio mm/filemap.c:2509 [inline]
 #1: ffff888074f5e520 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_get_pages+0xb1c/0x20c0 mm/filemap.c:2570
 #2: ffff888074f5e0e0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1124 [inline]
 #2: ffff888074f5e0e0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_read_folio+0x193/0x210 fs/ntfs3/inode.c:715
3 locks held by syz-executor236/5802:
 #0: ffff8880722ea410 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x600/0x1070 fs/read_write.c:1253
 #1: ffff888071d0ec80 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:826 [inline]
 #1: ffff888071d0ec80 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_create_folio mm/filemap.c:2509 [inline]
 #1: ffff888071d0ec80 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_get_pages+0xb1c/0x20c0 mm/filemap.c:2570
 #2: ffff888071d0e840 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1124 [inline]
 #2: ffff888071d0e840 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_read_folio+0x193/0x210 fs/ntfs3/inode.c:715
2 locks held by syz-executor236/5809:
 #0: ffff8880722ea410 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x600/0x1070 fs/read_write.c:1253
 #1: ffff888071d0eae0 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: inode_trylock include/linux/fs.h:791 [inline]
 #1: ffff888071d0eae0 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: ntfs_file_write_iter+0x1cb/0x6d0 fs/ntfs3/file.c:1060
3 locks held by syz-executor236/6053:
 #0: ffff88801f8d4410 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x600/0x1070 fs/read_write.c:1253
 #1: ffff888071c43180 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:826 [inline]
 #1: ffff888071c43180 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_create_folio mm/filemap.c:2509 [inline]
 #1: ffff888071c43180 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_get_pages+0xb1c/0x20c0 mm/filemap.c:2570
 #2: ffff888071c42d40 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1124 [inline]
 #2: ffff888071c42d40 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_read_folio+0x193/0x210 fs/ntfs3/inode.c:715
2 locks held by syz-executor236/6056:
 #0: ffff88801f8d4410 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x600/0x1070 fs/read_write.c:1253
 #1: ffff888071c42fe0 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: inode_trylock include/linux/fs.h:791 [inline]
 #1: ffff888071c42fe0 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: ntfs_file_write_iter+0x1cb/0x6d0 fs/ntfs3/file.c:1060
2 locks held by syz-executor236/7056:
 #0: ffff88802b024410 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x600/0x1070 fs/read_write.c:1253
 #1: ffff888074d66380 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
 #1: ffff888074d66380 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: ntfs_file_write_iter+0x260/0x6d0 fs/ntfs3/file.c:1063
3 locks held by syz-executor236/7057:
 #0: ffff88802b024410 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x600/0x1070 fs/read_write.c:1253
 #1: ffff888074d66520 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:826 [inline]
 #1: ffff888074d66520 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_create_folio mm/filemap.c:2509 [inline]
 #1: ffff888074d66520 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_get_pages+0xb1c/0x20c0 mm/filemap.c:2570
 #2: ffff888074d660e0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1124 [inline]
 #2: ffff888074d660e0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_read_folio+0x193/0x210 fs/ntfs3/inode.c:715

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.5.0-rc2-syzkaller-00052-gbfa3037d8280 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x187/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xec2/0xf00 kernel/hung_task.c:379
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5089 Comm: kworker/u4:3 Not tainted 6.5.0-rc2-syzkaller-00052-gbfa3037d8280 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:jump_entry_key include/linux/jump_label.h:135 [inline]
RIP: 0010:__jump_label_update+0x57/0x3a0 kernel/jump_label.c:470
Code: 03 00 00 49 be 00 00 00 00 00 fc ff df 45 31 e4 48 89 5c 24 08 4a 8d 0c 23 4e 8d 6c 23 08 4d 89 ef 49 c1 ef 03 43 80 3c 37 00 <48> 89 0c 24 74 0c 4c 89 ef e8 3b 8a 29 00 48 8b 0c 24 4a 8b 6c 23
RSP: 0018:ffffc90003e5faa8 EFLAGS: 00000246
RAX: ffffffff81bb35a2 RBX: ffffffff8cd092e0 RCX: ffffffff8cd092e0
RDX: 0000000000000000 RSI: ffffffff8cd092e0 RDI: ffffffff9200d560
RBP: ffffffff8cd0b500 R08: ffffffff81bb0afe R09: 1ffffffff2401aac
R10: dffffc0000000000 R11: fffffbfff2401aad R12: 0000000000000000
R13: ffffffff8cd092e8 R14: dffffc0000000000 R15: 1ffffffff19a125d
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f56e8e38000 CR3: 000000000d130000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 static_key_disable_cpuslocked+0xce/0x1b0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate+0x1b8/0x250 mm/kfence/core.c:836
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2597
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2748
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.134 msecs


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
