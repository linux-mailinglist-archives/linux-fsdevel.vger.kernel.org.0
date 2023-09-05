Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03EF7924CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjIEP7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354864AbjIEPKF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:10:05 -0400
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FB219B
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 08:10:01 -0700 (PDT)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1c08a3f7270so35174695ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 08:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693926601; x=1694531401;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zptu25zAJQ4Aig1qjwOjOEyFmtuG8Q5eB0pDaPNvFgM=;
        b=jY9GDvMquRCA033jLr3RjQrptOWWxx7vjPU2O/BNgTVAlNomo8Qte+H6Md6uk3vyx4
         1vi41JpvjnWvCThTR2/SqKD4XMhkw3xO+9dkQwHBsq5KxzsGgCg4Lna+CqYTx4YLu9OB
         ed06/qZbz/9eBhqcmL6G5yXjbhdPp9piBCEk8FagxwFIaGZZ8DTjMmGQGGWC8ApXGxXM
         qv54sNmOhMXkSO+CWbLSZlkYUW9BA60ylr59yrZAZc3jjyB8KPcPjlr9yBFQcspTkw5L
         /intDy2TQVh3qmvcX1Hfwh2ZyP3WYyMIZ4p1X5pwjCs5PhXqGYVlJ7YeGfiDKcX2S94o
         nT+Q==
X-Gm-Message-State: AOJu0YyFOKhPGSAU0Soq2ObQy+nhyao7xVzGPZdlt6DZdpT9WFQ7TK+S
        SNOVS7XX+TbqOY70LtV8KdIotEH42dOaw/oD/8QXFokRLDBh
X-Google-Smtp-Source: AGHT+IHOaatneJIiY8Vpq/QHv5/A4HITVO5axXAoW2BTmzdBYreEy69CnddsU6RY2cwqhzAkHiAhllo50shJMAPo4h3kdY8zVUTK
MIME-Version: 1.0
X-Received: by 2002:a17:902:cec4:b0:1c1:f658:7cfa with SMTP id
 d4-20020a170902cec400b001c1f6587cfamr4546090plg.9.1693926601194; Tue, 05 Sep
 2023 08:10:01 -0700 (PDT)
Date:   Tue, 05 Sep 2023 08:10:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057049306049e0525@google.com>
Subject: [syzbot] [gfs2?] BUG: sleeping function called from invalid context
 in glock_hash_walk
From:   syzbot <syzbot+10c6178a65acf04efe47@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1346753fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead
dashboard link: https://syzkaller.appspot.com/bug?extid=10c6178a65acf04efe47
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e4ea14680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f76f10680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f4f710c5033/disk-3f86ed6e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/555548fedbdc/vmlinux-3f86ed6e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c06d7c39bbc0/bzImage-3f86ed6e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9cc536caad57/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10c6178a65acf04efe47@syzkaller.appspotmail.com

syz-executor585: attempt to access beyond end of device
loop0: rw=1, sector=3280942697285464, nr_sectors = 8 limit=32768
gfs2: fsid=syz:syz.0: Error 10 writing to journal, jid=0
gfs2: fsid=syz:syz.0: fatal: I/O error(s)
gfs2: fsid=syz:syz.0: about to withdraw this file system
BUG: sleeping function called from invalid context at fs/gfs2/glock.c:2081
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5030, name: syz-executor585
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 5030 Comm: syz-executor585 Not tainted 6.5.0-syzkaller-11704-g3f86ed6ec0b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 __might_resched+0x5cf/0x780 kernel/sched/core.c:10187
 glock_hash_walk+0x13b/0x1b0 fs/gfs2/glock.c:2081
 gfs2_flush_delete_work+0x1c/0x50 fs/gfs2/glock.c:2108
 gfs2_make_fs_ro+0x109/0x680 fs/gfs2/super.c:550
 signal_our_withdraw fs/gfs2/util.c:153 [inline]
 gfs2_withdraw+0x48a/0x11e0 fs/gfs2/util.c:334
 gfs2_ail1_empty+0x7d0/0x860 fs/gfs2/log.c:377
 gfs2_flush_revokes+0x5e/0x90 fs/gfs2/log.c:815
 revoke_lo_before_commit+0x2c/0x5f0 fs/gfs2/lops.c:868
 lops_before_commit fs/gfs2/lops.h:40 [inline]
 gfs2_log_flush+0xc93/0x25f0 fs/gfs2/log.c:1101
 gfs2_write_inode+0x20e/0x3b0 fs/gfs2/super.c:453
 write_inode fs/fs-writeback.c:1456 [inline]
 __writeback_single_inode+0x69b/0xfa0 fs/fs-writeback.c:1668
 writeback_single_inode+0x21b/0x790 fs/fs-writeback.c:1724
 sync_inode_metadata+0xcc/0x130 fs/fs-writeback.c:2786
 gfs2_fsync+0x1a7/0x340 fs/gfs2/file.c:761
 generic_write_sync include/linux/fs.h:2625 [inline]
 gfs2_file_write_iter+0xb33/0xe60 fs/gfs2/file.c:1159
 do_iter_write+0x84f/0xde0 fs/read_write.c:860
 iter_file_splice_write+0x86d/0x1010 fs/splice.c:736
 do_splice_from fs/splice.c:933 [inline]
 direct_splice_actor+0xea/0x1c0 fs/splice.c:1142
 splice_direct_to_actor+0x376/0x9e0 fs/splice.c:1088
 do_splice_direct+0x2ac/0x3f0 fs/splice.c:1194
 do_sendfile+0x623/0x1070 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb0ea97bd59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd9f19f258 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb0ea97bd59
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000007
RBP: 0000000000000246 R08: 0000000000000002 R09: 00005555571844c0
R10: 0000000080000001 R11: 0000000000000246 R12: 00007ffd9f19f280
R13: 00007fb0ea95cac4 R14: 431bde82d7b634db R15: 00007fb0ea9c503b
 </TASK>
BUG: scheduling while atomic: syz-executor585/5030/0x00000002
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
