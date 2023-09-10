Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96061799CAD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 06:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbjIJEqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 00:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjIJEqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 00:46:03 -0400
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D381A5
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 Sep 2023 21:45:58 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-68bf123af64so4873273b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Sep 2023 21:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694321158; x=1694925958;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5rI+wW1D3pEQy6NkxGD/WZQotkC8/aBPOgOXgQXzWXw=;
        b=eK+ENDIExOFhTgphmgvF5V7jT0ioKePKOjUW1icFK7Vbiou16DaDYn7o9l+cWa4sjB
         7RrOxPyEx17fCxv0ANYVMlgsKwUqAFYjBEla2S7pR6uV+oXiCEeglCQ53tFRPIqfQRY/
         nK6+1TfwSH4NFo9iNdf6+M0akRPZNYJXkSjdDdhrHcYJVBKSCbzB89zEZJVQ145v7mlM
         yYujBwwfHOcP3OLQ9n0fxCQMVmn4RCJiJ9pIuQYRRAKDzfB99Kgfv3y6VVDFS4x2k/v9
         WGVxrCf+NgnpF7TT3bxRyNm2MFWuqtg4z5kFodGGEPclWZvgWF80Pi0M5sJWCHYMHUIH
         wVcQ==
X-Gm-Message-State: AOJu0YwDkAzSk7BOhnGdr3lYPzSB3ynHyUuzm8ruZEi9Xi0OLT357wvy
        DRI0EU/kcTf344+nmlupvD7K9t9iLxik4XYDe+fmWT0rp2Nj
X-Google-Smtp-Source: AGHT+IFIGCO87tTTbKFAEIALMs+fleP1/EF6ONSFquTElCD4CFDiwQXu5MlmJh31nNspuerZpEVErDj8EUikbiWlfdwhz9/Plm0+
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:b55:b0:68e:36bc:1925 with SMTP id
 p21-20020a056a000b5500b0068e36bc1925mr2639588pfo.1.1694321158463; Sat, 09 Sep
 2023 21:45:58 -0700 (PDT)
Date:   Sat, 09 Sep 2023 21:45:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c925dc0604f9e2ef@google.com>
Subject: [syzbot] [gfs2?] BUG: sleeping function called from invalid context
 in gfs2_withdraw
From:   syzbot <syzbot+577d06779fa95206ba66@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, gfs2@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10994bcc680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbf8b29a87b8a830
dashboard link: https://syzkaller.appspot.com/bug?extid=577d06779fa95206ba66
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10cd8e20680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115ddba8680000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-65d6e954.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/040b1e85a692/vmlinux-65d6e954.xz
kernel image: https://storage.googleapis.com/syzbot-assets/984f55ac441b/bzImage-65d6e954.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cd97a0244981/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+577d06779fa95206ba66@syzkaller.appspotmail.com

loop0: rw=1, sector=3280942697285464, nr_sectors = 8 limit=32768
gfs2: fsid=syz:syz.0: Error 10 writing to journal, jid=0
gfs2: fsid=syz:syz.0: fatal: I/O error(s)
gfs2: fsid=syz:syz.0: about to withdraw this file system
BUG: sleeping function called from invalid context at fs/gfs2/util.c:157
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5141, name: syz-executor200
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 5141 Comm: syz-executor200 Not tainted 6.5.0-syzkaller-11938-g65d6e954e378 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10187
 signal_our_withdraw fs/gfs2/util.c:157 [inline]
 gfs2_withdraw+0xc7d/0x1280 fs/gfs2/util.c:342
 gfs2_ail1_empty+0x8cc/0xab0 fs/gfs2/log.c:377
 gfs2_flush_revokes+0x6b/0x90 fs/gfs2/log.c:815
 revoke_lo_before_commit+0x22/0x640 fs/gfs2/lops.c:867
 lops_before_commit fs/gfs2/lops.h:40 [inline]
 gfs2_log_flush+0x105e/0x27f0 fs/gfs2/log.c:1101
 gfs2_write_inode+0x24a/0x4b0 fs/gfs2/super.c:453
 write_inode fs/fs-writeback.c:1456 [inline]
 __writeback_single_inode+0xa81/0xe70 fs/fs-writeback.c:1668
 writeback_single_inode+0x2af/0x590 fs/fs-writeback.c:1724
 sync_inode_metadata+0xa5/0xe0 fs/fs-writeback.c:2786
 gfs2_fsync+0x218/0x380 fs/gfs2/file.c:761
 vfs_fsync_range+0x141/0x220 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2625 [inline]
 gfs2_file_write_iter+0xd97/0x10c0 fs/gfs2/file.c:1150
 call_write_iter include/linux/fs.h:1985 [inline]
 do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
 do_iter_write+0x17f/0x830 fs/read_write.c:860
 vfs_iter_write+0x7a/0xb0 fs/read_write.c:901
 iter_file_splice_write+0x698/0xbf0 fs/splice.c:736
 do_splice_from fs/splice.c:933 [inline]
 direct_splice_actor+0x118/0x180 fs/splice.c:1142
 splice_direct_to_actor+0x347/0xa30 fs/splice.c:1088
 do_splice_direct+0x1af/0x280 fs/splice.c:1194
 do_sendfile+0xb88/0x1390 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f86c8957779
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef8d7a208 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007ffef8d7a3d8 RCX: 00007f86c8957779
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007f86c89dc610 R08: 00007ffef8d7a3d8 R09: 00007ffef8d7a3d8
R10: 0001000000201004 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffef8d7a3c8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
BUG: scheduling while atomic: syz-executor200/5141/0x00000002
INFO: lockdep is turned off.
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
