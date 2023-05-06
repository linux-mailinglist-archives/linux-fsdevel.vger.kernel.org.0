Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48886F9456
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 23:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjEFV7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 17:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjEFV7u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 17:59:50 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB37F23A0C
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 14:59:40 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-331663d8509so45450455ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 14:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683410380; x=1686002380;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PgYZjWeLjexrGnFDmI0IYPb/iqEp6EDD1WBE5yqbwfk=;
        b=S4W361qH46Bk5AIauAUUPf9TUQboQnpINz65ydXiQYsuGfinVqNsHM1y0u9bgLFyH/
         E83JcWymBr4eo/TbtFcQP2/nxyGgiJlW1GWpHPg7RRFxPKFwzwmj4JwXqAin6v1S0e5y
         zImD/sxMl/wH+DqFkdXzDsbZthi7PsPze8dBbMsv07c/1U/wBvsm5Gxmo0Rc8J62HaDq
         UxcGrRwSCgqP35ROP0WVFjdl2TPgJ0v1/HYmknU5YdlMSNrwYl6t2uDYYEJ6dtdxVkvr
         gB6nG8JNavLLvmSDThBrLtyC2iq363q2OltvfKoZGg2Y4lo4rMkh/EDqJtJrtJq4McaR
         z1/Q==
X-Gm-Message-State: AC+VfDx9CaGST+Deh2bgonufL1X7B0OPsXV9ECq+pTL9UzgolDdxP/Kt
        ORZOHDGOYEhnGCen8DwoxKS7e2bGZjIyO+nLqd82X6cighH4
X-Google-Smtp-Source: ACHHUZ79bcqBI6KLTxLPX4YDc4m+OwynPMVcrzLLhxpu5GX95K2MtFfkS7G2xtc0kDPArCkLdXOkqPxlgvbCLNiQ5+zVaQcQEaSY
MIME-Version: 1.0
X-Received: by 2002:a92:cb42:0:b0:331:e520:8631 with SMTP id
 f2-20020a92cb42000000b00331e5208631mr2917061ilq.2.1683410379943; Sat, 06 May
 2023 14:59:39 -0700 (PDT)
Date:   Sat, 06 May 2023 14:59:39 -0700
In-Reply-To: <00000000000075fe1b05f6f415f7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5386505fb0d854c@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in kvfree (2)
From:   syzbot <syzbot+64b645917ce07d89bde5@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    14f8db1c0f9a Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16b08d88280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a837a8ba7e88bb45
dashboard link: https://syzkaller.appspot.com/bug?extid=64b645917ce07d89bde5
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eb3df2280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a6af18280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad6ce516eed3/disk-14f8db1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f38c2cc7667/vmlinux-14f8db1c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d795115eee39/Image-14f8db1c.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/66c0bf3e4f09/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+64b645917ce07d89bde5@syzkaller.appspotmail.com

EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: writeback.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5931 at mm/slab_common.c:935 free_large_kmalloc+0x34/0x12c mm/slab_common.c:936
Modules linked in:
CPU: 1 PID: 5931 Comm: syz-executor235 Not tainted 6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : free_large_kmalloc+0x34/0x12c mm/slab_common.c:936
lr : kfree+0xf8/0x19c mm/slab_common.c:1013
sp : ffff80001e5a74e0
x29: ffff80001e5a74e0 x28: ffff0000deac34d8 x27: ffff0000e23195a4
x26: dfff800000000000 x25: 0000000000000020 x24: ffff0000c7a3ad00
x23: ffff0000c7a3a400 x22: 0000000000000000 x21: ffff800008809968
x20: ffff0000e23195a4 x19: fffffc000388c640 x18: ffff80001e5a6e80
x17: ffff800015d6d000 x16: ffff80001236e294 x15: ffff800008a6cf5c
x14: ffff800008a6cb2c x13: ffff800008062fb8 x12: 0000000000000003
x11: 0000000000000000 x10: 0000000000000000 x9 : 05ffc0000000202a
x8 : ffff800018986000 x7 : ffff800008063224 x6 : ffff800008063434
x5 : ffff0000d182bf38 x4 : ffff80001e5a72b0 x3 : 0000000000000000
x2 : 0000000000000006 x1 : ffff0000e23195a4 x0 : fffffc000388c640
Call trace:
 free_large_kmalloc+0x34/0x12c mm/slab_common.c:936
 kfree+0xf8/0x19c mm/slab_common.c:1013
 kvfree+0x40/0x50 mm/util.c:649
 ext4_xattr_move_to_block fs/ext4/xattr.c:2680 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
 ext4_expand_extra_isize_ea+0xcec/0x16b4 fs/ext4/xattr.c:2835
 __ext4_expand_extra_isize+0x290/0x348 fs/ext4/inode.c:5960
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6003 [inline]
 __ext4_mark_inode_dirty+0x448/0x848 fs/ext4/inode.c:6081
 __ext4_unlink+0x768/0x998 fs/ext4/namei.c:3255
 ext4_unlink+0x1b4/0x6a0 fs/ext4/namei.c:3298
 vfs_unlink+0x2f0/0x508 fs/namei.c:4250
 do_unlinkat+0x4c8/0x82c fs/namei.c:4316
 __do_sys_unlinkat fs/namei.c:4359 [inline]
 __se_sys_unlinkat fs/namei.c:4352 [inline]
 __arm64_sys_unlinkat+0xcc/0xfc fs/namei.c:4352
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 16132
hardirqs last  enabled at (16131): [<ffff80000896749c>] kasan_quarantine_put+0x1a0/0x1c8 mm/kasan/quarantine.c:242
hardirqs last disabled at (16132): [<ffff800012369e90>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (15474): [<ffff800008033374>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (15472): [<ffff800008033340>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
object pointer: 0x000000001bcaf4ec
==================================================================
BUG: KASAN: invalid-free in kfree+0xf8/0x19c mm/slab_common.c:1013
Free of addr ffff0000e23195a4 by task syz-executor235/5931

CPU: 1 PID: 5931 Comm: syz-executor235 Tainted: G        W          6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:319 [inline]
 print_report+0x174/0x514 mm/kasan/report.c:430
 kasan_report_invalid_free+0xc4/0x114 mm/kasan/report.c:501
 __kasan_kfree_large+0xa4/0xc0 mm/kasan/common.c:272
 kasan_kfree_large include/linux/kasan.h:170 [inline]
 free_large_kmalloc+0x64/0x12c mm/slab_common.c:939
 kfree+0xf8/0x19c mm/slab_common.c:1013
 kvfree+0x40/0x50 mm/util.c:649
 ext4_xattr_move_to_block fs/ext4/xattr.c:2680 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
 ext4_expand_extra_isize_ea+0xcec/0x16b4 fs/ext4/xattr.c:2835
 __ext4_expand_extra_isize+0x290/0x348 fs/ext4/inode.c:5960
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6003 [inline]
 __ext4_mark_inode_dirty+0x448/0x848 fs/ext4/inode.c:6081
 __ext4_unlink+0x768/0x998 fs/ext4/namei.c:3255
 ext4_unlink+0x1b4/0x6a0 fs/ext4/namei.c:3298
 vfs_unlink+0x2f0/0x508 fs/namei.c:4250
 do_unlinkat+0x4c8/0x82c fs/namei.c:4316
 __do_sys_unlinkat fs/namei.c:4359 [inline]
 __se_sys_unlinkat fs/namei.c:4352 [inline]
 __arm64_sys_unlinkat+0xcc/0xfc fs/namei.c:4352
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

The buggy address belongs to the physical page:
page:00000000c0a5c392 refcount:2 mapcount:0 mapping:0000000007c227a9 index:0x1 pfn:0x122319
memcg:ffff0000c1964000
aops:def_blk_aops ino:700000
flags: 0x5ffc0000002203e(referenced|uptodate|dirty|lru|active|private|mappedtodisk|node=0|zone=2|lastcpupid=0x7ff)
raw: 05ffc0000002203e fffffc00061e7788 ffff0000c0036030 ffff0000c149ca10
raw: 0000000000000001 ffff0000e1554570 00000002ffffffff ffff0000c1964000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000e2319480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000e2319500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff0000e2319580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                               ^
 ffff0000e2319600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000e2319680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
