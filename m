Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC53A76B407
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 13:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjHAL5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 07:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHAL46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:56:58 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4742E1724
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 04:56:57 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6bb31a92b44so10702767a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 04:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690891016; x=1691495816;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aw1O1Y4EWcHxyzEL75bIuduZ1/KpOZztlDrppW0Pas=;
        b=LLanRVpsapRC0PENEWKyA2GFfY+OFVtQxwsiYN8FaRBpgbbmXo/rpfi7wByKYlorK3
         B4oV6NehRmIZbaOAwdAFXdeaO1hJW2jCWlYdMs6e16I+/co2xfMLz+RI8eMLZJ10Mk+d
         zED7TO0l18y5zhfHeR16WsHoiyTkUhzLyYNaBw8Nn7M3xa4yn0MrlUyQGmPsQ8/dceOb
         m2SactbdPQwHxfENt/ctrqZr5Ew8d3q2LCewqdCiMkx6CGiq7YbqONHn60daqdZpEgkY
         GAVLCQO234GEZoNOSftA7WXD4VPV7YfywX6xHXtBgFdoIi4L+MuOP87x1sqg6QTKasAO
         PIdA==
X-Gm-Message-State: ABy/qLZSSFD9DmlTPOQ4v5m7QywxtO8VRiyTIOFBodkcaI5BvxsaKjm3
        /XVa9uOcuQz0CyZYiFEtvF1fu3QAsA2TfyiQkMUJXdUkyKfC
X-Google-Smtp-Source: APBJJlGr7qA7J0ZhcT9T82CzXInpIOtKfmQ7QVmrVI22MG7s3TV7LqJQuDMfb8el+a6sCrijJVFdMddUwQCiCUh9A0XXRYV7lDr1
MIME-Version: 1.0
X-Received: by 2002:a9d:4f15:0:b0:6bc:b5dc:7b6d with SMTP id
 d21-20020a9d4f15000000b006bcb5dc7b6dmr529715otl.2.1690891016676; Tue, 01 Aug
 2023 04:56:56 -0700 (PDT)
Date:   Tue, 01 Aug 2023 04:56:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000672c810601db3e84@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_cancel_balance
From:   syzbot <syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    57012c57536f Merge tag 'net-6.5-rc4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1413a086a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d10d93e1ae1f229
dashboard link: https://syzkaller.appspot.com/bug?extid=d6443e1f040e8d616e7b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137d82cea80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7336195c1d93/disk-57012c57.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e7a6562e4033/vmlinux-57012c57.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d66531ff83b/bzImage-57012c57.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e6f09fca3191/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/btrfs/volumes.c:4642!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5160 Comm: syz-executor.1 Not tainted 6.5.0-rc3-syzkaller-00123-g57012c57536f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:btrfs_cancel_balance+0x429/0x430 fs/btrfs/volumes.c:4641
Code: e8 1c 31 01 00 4c 89 ef 48 c7 c6 00 fd 4a 8b e8 ad 1a 24 07 e9 ef fe ff ff e8 a3 af 25 07 e8 3e 04 f5 fd 0f 0b e8 37 04 f5 fd <0f> 0b 0f 1f 44 00 00 f3 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41
RSP: 0018:ffffc90004b7fdc0 EFLAGS: 00010293
RAX: ffffffff839711d9 RBX: ffff888063844010 RCX: ffff888079498000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffffc90004b7fed0 R08: ffff8880638453d3 R09: 1ffff1100c708a7a
R10: dffffc0000000000 R11: ffffed100c708a7b R12: 1ffff9200096ffc0
R13: ffff888063845468 R14: dffffc0000000000 R15: ffff888063845460
FS:  00007fab7440b6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1c1abfe000 CR3: 000000007aa05000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_ioctl_balance_ctl+0x3f/0x70 fs/btrfs/ioctl.c:3632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fab7367cb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fab7440b0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fab7379c120 RCX: 00007fab7367cb29
RDX: 0000000000000002 RSI: 0000000040049421 RDI: 0000000000000006
RBP: 00007fab736c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fab7379c120 R15: 00007ffcf21c7038
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_cancel_balance+0x429/0x430 fs/btrfs/volumes.c:4641
Code: e8 1c 31 01 00 4c 89 ef 48 c7 c6 00 fd 4a 8b e8 ad 1a 24 07 e9 ef fe ff ff e8 a3 af 25 07 e8 3e 04 f5 fd 0f 0b e8 37 04 f5 fd <0f> 0b 0f 1f 44 00 00 f3 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41
RSP: 0018:ffffc90004b7fdc0 EFLAGS: 00010293

RAX: ffffffff839711d9 RBX: ffff888063844010 RCX: ffff888079498000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffffc90004b7fed0 R08: ffff8880638453d3 R09: 1ffff1100c708a7a
R10: dffffc0000000000 R11: ffffed100c708a7b R12: 1ffff9200096ffc0
R13: ffff888063845468 R14: dffffc0000000000 R15: ffff888063845460
FS:  00007fab7440b6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1c22cd71e5 CR3: 000000007aa05000 CR4: 00000000003506f0
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
