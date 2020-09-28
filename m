Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BFC27A88F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 09:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgI1H1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 03:27:25 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:40354 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1H1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:27:25 -0400
Received: by mail-il1-f205.google.com with SMTP id e9so90675ils.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2020 00:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PIz1Bses4dKq9F01ai3uy77KWW3CoQk32Q9nNmbQqgA=;
        b=FR6eRh7uBr/jaaCyj4TugARCeMkinJ0KKIwHLw7Y01VETL8zvtJfC1pemei1VxEeIA
         k5oFYY9lBHnTq38WXGSqvRuKswjkUdh72W0BNBSM1mvPgaCBy/4QLocQWDNg2VGg+s0v
         vH1N7c6nwWSeZZEdiqp3j+2Mato2Xaw6zstHQotV/k/lh+2xCRwaelp2ZBWbjkag7pBy
         hLedffb0P+5vaUD026COCIRcopsDtaJy8HlTPvCJ284XXKnNS5I8Stwl1QiPCnX69mMx
         iMbaW+N5uNDD6q5BRxFNqI6QnFeb/O+w/RDHMJx0zHOah7eF9eUNMz5RN9LVJZKQXuJ3
         84RQ==
X-Gm-Message-State: AOAM532hK1fWxOysBAGx1hTazFb/V/IyTUv+dKDKhOFjx7t6j3Fk9Cfp
        R2A1cQb2gid9rSu/PRKE1H8JcfiCe97+GlngVbqXuVM7U6us
X-Google-Smtp-Source: ABdhPJx/rlhcnsdy7WjumlfI5KdqJr9cCqiqCIYDRekk7cN+gleXg1FovPvU8xrSSAWR8ou2YYATyM72RHBPG0/n7grQcboAGxZk
MIME-Version: 1.0
X-Received: by 2002:a05:6638:25d0:: with SMTP id u16mr168578jat.0.1601278044255;
 Mon, 28 Sep 2020 00:27:24 -0700 (PDT)
Date:   Mon, 28 Sep 2020 00:27:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003bbaa05b05a9963@google.com>
Subject: INFO: trying to register non-static key in exfat_cache_inval_inode
From:   syzbot <syzbot+b91107320911a26c9a95@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        namjae.jeon@samsung.com, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    171d4ff7 Merge tag 'mmc-v5.9-rc4-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160cf3c3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6184b75aa6d48d66
dashboard link: https://syzkaller.appspot.com/bug?extid=b91107320911a26c9a95
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178b6303900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c5a039900000

Bisection is inconclusive: the first bad commit could be any of:

88ab55f1 MAINTAINERS: add exfat filesystem
1a3c0509 staging: exfat: make staging/exfat and fs/exfat mutually exclusive
b9d1e2e6 exfat: add Kconfig and Makefile
9acd0d53 exfat: update file system parameter handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151cfb03900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b91107320911a26c9a95@syzkaller.appspotmail.com

exFAT-fs (loop0): failed to load upcase table (idx : 0x00000c00, chksum : 0x00000000, utbl_chksum : 0xe619d30d)
exFAT-fs (loop0): error, invalid access to FAT free cluster (entry 0x00000005)
exFAT-fs (loop0): Filesystem has been set read-only
exFAT-fs (loop0): failed to initialize root inode
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 1 PID: 6869 Comm: syz-executor962 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 register_lock_class+0xf06/0x1520 kernel/locking/lockdep.c:893
 __lock_acquire+0xfd/0x2ae0 kernel/locking/lockdep.c:4320
 lock_acquire+0x148/0x720 kernel/locking/lockdep.c:5029
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:354 [inline]
 exfat_cache_inval_inode+0x30/0x280 fs/exfat/cache.c:226
 exfat_evict_inode+0x124/0x270 fs/exfat/inode.c:660
 evict+0x2bb/0x6d0 fs/inode.c:576
 exfat_fill_super+0x1e07/0x27d0 fs/exfat/super.c:681
 get_tree_bdev+0x3e9/0x5f0 fs/super.c:1342
 vfs_get_tree+0x88/0x270 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x179d/0x29e0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount+0x126/0x180 fs/namespace.c:3390
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44726a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffd00067218 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd00067270 RCX: 000000000044726a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd00067230
RBP: 00007ffd00067230 R08: 00007ffd00067270 R09: 00007ffd00000015
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000017
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 6869 Comm: syz-executor962 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__list_del_entry_valid+0x1f/0x100 lib/list_debug.c:42
Code: fd 0f 0b 0f 1f 84 00 00 00 00 00 41 57 41 56 41 54 53 49 89 fe 49 bc 00 00 00 00 00 fc ff df 48 83 c7 08 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 05 e8 e5 62 f2 fd 4d 8b 7e 08 4c 89 f0 48 c1 e8
RSP: 0018:ffffc90001127b58 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000008
RBP: ffff8880854a3640 R08: dffffc0000000000 R09: fffff52000224f68
R10: fffff52000224f68 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880854a36d8 R14: 0000000000000000 R15: ffff8880854a36e8
FS:  000000000211f880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043f080 CR3: 000000009fa9a000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_del_entry include/linux/list.h:132 [inline]
 list_del_init include/linux/list.h:204 [inline]
 __exfat_cache_inval_inode fs/exfat/cache.c:212 [inline]
 exfat_cache_inval_inode+0xa4/0x280 fs/exfat/cache.c:227
 exfat_evict_inode+0x124/0x270 fs/exfat/inode.c:660
 evict+0x2bb/0x6d0 fs/inode.c:576
 exfat_fill_super+0x1e07/0x27d0 fs/exfat/super.c:681
 get_tree_bdev+0x3e9/0x5f0 fs/super.c:1342
 vfs_get_tree+0x88/0x270 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x179d/0x29e0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount+0x126/0x180 fs/namespace.c:3390
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44726a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffd00067218 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd00067270 RCX: 000000000044726a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd00067230
RBP: 00007ffd00067230 R08: 00007ffd00067270 R09: 00007ffd00000015
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000017
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
Modules linked in:
---[ end trace 8a39a0f43e2bbec0 ]---
RIP: 0010:__list_del_entry_valid+0x1f/0x100 lib/list_debug.c:42
Code: fd 0f 0b 0f 1f 84 00 00 00 00 00 41 57 41 56 41 54 53 49 89 fe 49 bc 00 00 00 00 00 fc ff df 48 83 c7 08 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 05 e8 e5 62 f2 fd 4d 8b 7e 08 4c 89 f0 48 c1 e8
RSP: 0018:ffffc90001127b58 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000008
RBP: ffff8880854a3640 R08: dffffc0000000000 R09: fffff52000224f68
R10: fffff52000224f68 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880854a36d8 R14: 0000000000000000 R15: ffff8880854a36e8
FS:  000000000211f880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043f080 CR3: 000000009fa9a000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
