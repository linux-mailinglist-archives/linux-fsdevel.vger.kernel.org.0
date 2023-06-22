Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A359B739618
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 06:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjFVEAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 00:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjFVEAT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 00:00:19 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22041FFD
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 20:58:27 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-77d99de0e9bso613601039f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 20:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687406262; x=1689998262;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXPsR5iNV+ryJYqimaaO5q0mRVy7iYcqwvnGufr57vI=;
        b=gIA7Ypy1vhmlobQo5BNCpK2/iZyG5uZX7wlmqnPVCBL5VAmv0tD2zpx7H0FWurAvHK
         ZTl1z4gkZRYUJrtpL9j+ypsiSLQiJAZl6rJyYrxOCoFDApl/hkCRWlXgieulePfQQG+D
         FixWTb7pJ3ZzajnNSHAhbXSZIkGyJ3qjRBnwUn6HGV1g3GVnvf+KTipZyZykIenFTFYa
         aM7tWxlXTgPL1dUnF+7ZWZZz/xqWD0HbRhptJqBIOXFU0EGrKwOupzhUG+rw/oFE9LFE
         vkyWbZzsyFTFPa579VtPAyXwiSaiYMIFZ81CjIbJy3Yki8n2lRAw0TtSlH2rQp2qTvqR
         voBQ==
X-Gm-Message-State: AC+VfDxVWF7eqfei7WetIi9RLlLBLF8YHtgdjC0qJLD8XBJsvetGNN3T
        jL8UNrTnsuRC7fKtFqPeJMOT0quwnqV9u4xtNyIHPLzIzkOw
X-Google-Smtp-Source: ACHHUZ6bwQ8anqnY/DFJMbRCWVI9OVQtPnttjSpix1pdVg8C9qZcrcQ+pOd81FeZIS15gBFYezhMOZlFi7KSB2OhYyq+KbbPZAdD
MIME-Version: 1.0
X-Received: by 2002:a5e:a908:0:b0:77e:4866:5c0c with SMTP id
 c8-20020a5ea908000000b0077e48665c0cmr3656251iod.0.1687406262286; Wed, 21 Jun
 2023 20:57:42 -0700 (PDT)
Date:   Wed, 21 Jun 2023 20:57:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db02d205feafe2e1@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_ioctl
From:   syzbot <syzbot+c0f3acf145cb465426d5@syzkaller.appspotmail.com>
To:     chris@chrisdown.name, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    1b29d271614a Merge tag 'staging-6.4-rc7' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116de987280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=c0f3acf145cb465426d5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1061d897280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10109e6b280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16519d7a3fc8/disk-1b29d271.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2cd6e97f1df/vmlinux-1b29d271.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a7781abe10c9/bzImage-1b29d271.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c7b9c660b7de/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0f3acf145cb465426d5@syzkaller.appspotmail.com

assertion failed: fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED, in fs/btrfs/ioctl.c:465
------------[ cut here ]------------
kernel BUG at fs/btrfs/messages.c:259!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6823 Comm: syz-executor250 Not tainted 6.4.0-rc6-syzkaller-00269-g1b29d271614a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:btrfs_assertfail+0x2c/0x30 fs/btrfs/messages.c:259
Code: 1f 00 41 55 41 89 d5 41 54 49 89 f4 55 48 89 fd e8 99 de f6 fd 44 89 e9 4c 89 e2 48 89 ee 48 c7 c7 c0 92 97 8a e8 b4 c2 da fd <0f> 0b 66 90 66 0f 1f 00 55 48 89 fd e8 73 de f6 fd 48 89 ef 5d 48
RSP: 0018:ffffc9000ce67c10 EFLAGS: 00010286
RAX: 0000000000000066 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8168bd1c RDI: 0000000000000005
RBP: ffffffff8a9626c0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8a961a40
R13: 00000000000001d1 R14: ffff888019fcbc00 R15: ffff888014ae0678
FS:  00007fb611b0d700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb61190e000 CR3: 000000007aa80000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 btrfs_exclop_balance fs/btrfs/ioctl.c:465 [inline]
 btrfs_ioctl_balance fs/btrfs/ioctl.c:3564 [inline]
 btrfs_ioctl+0x531e/0x5b30 fs/btrfs/ioctl.c:4632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb618fa5c59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb611b0d208 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb61902f7c8 RCX: 00007fb618fa5c59
RDX: 0000000020000540 RSI: 00000000c4009420 RDI: 0000000000000004
RBP: 00007fb61902f7c0 R08: 00007fb611b0d700 R09: 0000000000000000
R10: 00007fb611b0d700 R11: 0000000000000246 R12: 00007fb61902f7cc
R13: 00007fff0865c5cf R14: 00007fb611b0d300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_assertfail+0x2c/0x30 fs/btrfs/messages.c:259
Code: 1f 00 41 55 41 89 d5 41 54 49 89 f4 55 48 89 fd e8 99 de f6 fd 44 89 e9 4c 89 e2 48 89 ee 48 c7 c7 c0 92 97 8a e8 b4 c2 da fd <0f> 0b 66 90 66 0f 1f 00 55 48 89 fd e8 73 de f6 fd 48 89 ef 5d 48
RSP: 0018:ffffc9000ce67c10 EFLAGS: 00010286
RAX: 0000000000000066 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8168bd1c RDI: 0000000000000005
RBP: ffffffff8a9626c0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8a961a40
R13: 00000000000001d1 R14: ffff888019fcbc00 R15: ffff888014ae0678
FS:  00007fb611b0d700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb61190e000 CR3: 000000007aa80000 CR4: 0000000000350ee0


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
