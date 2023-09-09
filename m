Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C997999BA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 18:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjIIQZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Sep 2023 12:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjIIPpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Sep 2023 11:45:16 -0400
Received: from mail-pf1-f206.google.com (mail-pf1-f206.google.com [209.85.210.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA5113D
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 Sep 2023 08:45:11 -0700 (PDT)
Received: by mail-pf1-f206.google.com with SMTP id d2e1a72fcca58-68bf123af64so4352106b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Sep 2023 08:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694274311; x=1694879111;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbWmtI2saoAhWc9NAmAAALAja+o02+Kc4sbFNaTcIA0=;
        b=Ylx+HYyLRUhhqrtGnOKsT0acdrunzPtA6FCLtRN2g3/+3oFQiKnwoJxqryQFVNQ3nR
         p8FK6FejLpBrVLDt1mTSJRH+75/cP5ng6lg05wUZvH66NHMts0eAKubfmDcwnxZgkebH
         +Z07L6tZICrXPXhCyOEK0618yy0fZa0wpb0RYGGWYy23o/i7cb9XELPXgmNb0Mduvu+v
         0I1V/i4SMPXfguiWeYfeAk9hdre9Lrf4ZHEhRQoZhmLAMrCNWDwbn9bnoyFJywEVGDum
         RfuR5HWZ9siqpK/CIRSRZWIObZ0VlO2WQXbVxvpuEP9uYl9n5f6smdimUz4JYZFyzP2O
         drMw==
X-Gm-Message-State: AOJu0YzmFI4byXot0/Hhgg5rcOJ6v5GNqcfVeQluPiSZXKlgkTI2JFA+
        E9HMpjNFJ8NJw6UQpHeSVKsR9tfwc363+N94JmAqCLx/J5jz
X-Google-Smtp-Source: AGHT+IGpSGhA2lWuHBjuYLtK/TINlTvWuKPB1acF3vooBe2XeFUBkESDPDNertjqPsTH1HTVryn1Kp9E7e0SNEkbOZV0Trncmeem
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1989:b0:68e:47fd:4ee9 with SMTP id
 d9-20020a056a00198900b0068e47fd4ee9mr2087283pfl.6.1694274311273; Sat, 09 Sep
 2023 08:45:11 -0700 (PDT)
Date:   Sat, 09 Sep 2023 08:45:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079c7640604eefa47@google.com>
Subject: [syzbot] [jfs?] kernel BUG in txLock
From:   syzbot <syzbot+451384fb192454e258de@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15853c0c680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead
dashboard link: https://syzkaller.appspot.com/bug?extid=451384fb192454e258de
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140b48c8680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15276fb8680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d2f8f959540a/disk-65d6e954.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f0285edec65/vmlinux-65d6e954.xz
kernel image: https://storage.googleapis.com/syzbot-assets/61d3ef608e62/bzImage-65d6e954.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4db3738411e6/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1355caa4680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10d5caa4680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1755caa4680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+451384fb192454e258de@syzkaller.appspotmail.com

Locker's tblock: ffffc900025f1300: 8b424900 ffffffff 00000200 00000000
Locker's tblock: ffffc900025f1310: 025f1310 ffffc900 025f1310 ffffc900
Locker's tblock: ffffc900025f1320: 00000004 0000001c 00000007 00000000
Tlock: ffffc900028120d8: 00010004 20208040 1cf49d90 ffff8880
Tlock: ffffc900028120e8: 76f2a930 ffff8880 03140000 05002000
Tlock: ffffc900028120f8: 06030a00 0000020d 00000000 00000000
Tlock: ffffc90002812108: 00000000 00000000 00000000 00000000
Tlock: ffffc90002812118: 00000000 00000000
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_txnmgr.c:834!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5053 Comm: syz-executor131 Not tainted 6.5.0-syzkaller-11938-g65d6e954e378 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:txLock+0x1cd4/0x1fa0 fs/jfs/jfs_txnmgr.c:834
Code: 8b 48 c7 c6 40 4f 42 8b ba 01 00 00 00 b9 10 00 00 00 41 b8 04 00 00 00 4c 8b 4c 24 20 6a 00 6a 48 e8 a0 2f 2a 01 48 83 c4 10 <0f> 0b e8 55 21 7c fe 4c 89 e7 48 c7 c6 40 57 42 8b e8 36 9f bd fe
RSP: 0018:ffffc90003a5ef98 EFLAGS: 00010282
RAX: 8c29e29eae6e2500 RBX: 1ffff9200050241b RCX: ffff88807d4ed940
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000010 R08: ffffffff8170afec R09: 1ffff9200074bd28
R10: dffffc0000000000 R11: fffff5200074bd29 R12: ffffc900028120da
R13: 0000000000000002 R14: 000000000000001b R15: 0000000000002020
FS:  00007f0a9153a6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0a8a119000 CR3: 00000000271f3000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dtSplitRoot+0x430/0x1920 fs/jfs/jfs_dtree.c:1919
 dtSplitUp fs/jfs/jfs_dtree.c:985 [inline]
 dtInsert+0x12fa/0x6b00 fs/jfs/jfs_dtree.c:863
 jfs_create+0x7b6/0xb90 fs/jfs/namei.c:137
 lookup_open fs/namei.c:3495 [inline]
 open_last_lookups fs/namei.c:3563 [inline]
 path_openat+0x13e7/0x3180 fs/namei.c:3793
 do_filp_open+0x234/0x490 fs/namei.c:3823
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_open fs/open.c:1445 [inline]
 __se_sys_open fs/open.c:1441 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0a91585949
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 1b 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0a9153a218 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f0a9160b6c8 RCX: 00007f0a91585949
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000020000400
RBP: 00007f0a9160b6c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0a915d8210
R13: 00007f0a915d204d R14: 0030656c69662f2e R15: 6573726168636f69
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:txLock+0x1cd4/0x1fa0 fs/jfs/jfs_txnmgr.c:834
Code: 8b 48 c7 c6 40 4f 42 8b ba 01 00 00 00 b9 10 00 00 00 41 b8 04 00 00 00 4c 8b 4c 24 20 6a 00 6a 48 e8 a0 2f 2a 01 48 83 c4 10 <0f> 0b e8 55 21 7c fe 4c 89 e7 48 c7 c6 40 57 42 8b e8 36 9f bd fe
RSP: 0018:ffffc90003a5ef98 EFLAGS: 00010282
RAX: 8c29e29eae6e2500 RBX: 1ffff9200050241b RCX: ffff88807d4ed940
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000010 R08: ffffffff8170afec R09: 1ffff9200074bd28
R10: dffffc0000000000 R11: fffff5200074bd29 R12: ffffc900028120da
R13: 0000000000000002 R14: 000000000000001b R15: 0000000000002020
FS:  00007f0a9153a6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0a8a119000 CR3: 00000000271f3000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
