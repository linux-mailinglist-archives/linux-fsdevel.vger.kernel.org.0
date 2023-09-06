Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E0B79330F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 02:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbjIFAxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 20:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjIFAxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:53:12 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158521A3
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 17:53:08 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1bf6e47b5efso32849525ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 17:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693961586; x=1694566386;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kdwrxuKw3aDgC7TsPyfzDkWDKgXCuVtFUYAIf25m1dw=;
        b=MYwP0VfiYVH03+8puufbC1D2ehRmzwEeHO0tlINMRBEoBIqK1EA5uRBmuhht69gNmD
         rR2VUIN12+PfjA1nJOuDysdSziXorv9pJizp6yLEDky5VCb+8r+TM8HnHMLhcdeZ/MTc
         xvi8VXFWuQqqpOPdCM6+SjL/pwXeeExQAHxp4QAJa8bk4ltiOLrvBUD2GGR+dxUW16KW
         ck5AojzkvOSQrLHTuOLHxR5wL6EPLnhMIx2sHXGk/Xu7NXH9z6h6NZPR4Ar20nesYZl0
         Kl0MqlTfa9MESrDdY/ndpn420EiAoGXXPFSPAILdNKlFfVLos2iKzqBeUi0G/glgf2wy
         5zTA==
X-Gm-Message-State: AOJu0Yz/Ils6L6hqd+2PGA84emnJi3IyZcD4+fQYlME8ATO7spcfKXt0
        usRpcKLP0fBoZec0rF7ht/s7riVd+CNYFd2ZEBlbfEAOJCeX
X-Google-Smtp-Source: AGHT+IGt/gmyyr1MtBbz39IpBNMgCLuXvqFPZKZJCsUwhDll6WqgzQZK3CV9ezLZYRftQtuSHkSBKMqpkwEC0WI6XQQ+CDGaVU2/
MIME-Version: 1.0
X-Received: by 2002:a17:902:e803:b0:1b9:e8e5:b0a4 with SMTP id
 u3-20020a170902e80300b001b9e8e5b0a4mr5009843plg.8.1693961586558; Tue, 05 Sep
 2023 17:53:06 -0700 (PDT)
Date:   Tue, 05 Sep 2023 17:53:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a14f020604a62a98@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in f2fs_put_super
From:   syzbot <syzbot+ebd7072191e2eddd7d6e@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e0152e7481c6 Merge tag 'riscv-for-linus-6.6-mw1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11072fdfa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30b036635ccf91ce
dashboard link: https://syzkaller.appspot.com/bug?extid=ebd7072191e2eddd7d6e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e0152e74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8159e43fa183/vmlinux-e0152e74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b0ced23e91f7/bzImage-e0152e74.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebd7072191e2eddd7d6e@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/f2fs/super.c:1639!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 15451 Comm: syz-executor.1 Not tainted 6.5.0-syzkaller-09338-ge0152e7481c6 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:f2fs_put_super+0xce1/0xed0 fs/f2fs/super.c:1639
Code: 03 0f b6 14 02 48 89 d8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 27 48 63 0b 89 ea 48 c7 c6 40 f9 ba 8a 4c 89 e7 e8 ff 77 ff ff <0f> 0b 4c 89 ee 48 c7 c7 c0 d2 18 8d e8 5e bd a1 00 eb a6 48 89 df
RSP: 0018:ffffc9000420fc00 EFLAGS: 00010282

RAX: 0000000000000000 RBX: ffff888058dd4f80 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816a3a30 RDI: 0000000000000005
RBP: 000000000000000a R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 2073662d53463246 R12: ffff888058dd4000
R13: 000000000000000a R14: dffffc0000000000 R15: 0000000000000001
FS:  00007fbbc86656c0(0000) GS:ffff88806b600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f621a85f000 CR3: 0000000111785000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 generic_shutdown_super+0x161/0x3c0 fs/super.c:693
 kill_block_super+0x3b/0x70 fs/super.c:1646
 kill_f2fs_super+0x2b7/0x3d0 fs/f2fs/super.c:4879
 deactivate_locked_super+0x9a/0x170 fs/super.c:481
 deactivate_super+0xde/0x100 fs/super.c:514
 cleanup_mnt+0x222/0x3d0 fs/namespace.c:1254
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbbc787e1ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbbc8664ee8 EFLAGS: 00000202
 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffec RBX: 00007fbbc8664f80 RCX: 00007fbbc787e1ea
RDX: 0000000020000040 RSI: 0000000020000080 RDI: 00007fbbc8664f40
RBP: 0000000020000040 R08: 00007fbbc8664f80 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000080
R13: 00007fbbc8664f40 R14: 00000000000054f4 R15: 0000000020000540
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_put_super+0xce1/0xed0 fs/f2fs/super.c:1639
Code: 03 0f b6 14 02 48 89 d8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 27 48 63 0b 89 ea 48 c7 c6 40 f9 ba 8a 4c 89 e7 e8 ff 77 ff ff <0f> 0b 4c 89 ee 48 c7 c7 c0 d2 18 8d e8 5e bd a1 00 eb a6 48 89 df
RSP: 0018:ffffc9000420fc00 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888058dd4f80 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816a3a30 RDI: 0000000000000005
RBP: 000000000000000a R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 2073662d53463246 R12: ffff888058dd4000
R13: 000000000000000a R14: dffffc0000000000 R15: 0000000000000001
FS:  00007fbbc86656c0(0000) GS:ffff88806b600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffb061dfa8 CR3: 0000000111785000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
