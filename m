Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA80215B01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgGFPm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 11:42:28 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:53706 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbgGFPm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:42:26 -0400
Received: by mail-il1-f198.google.com with SMTP id r4so28097564ilq.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2020 08:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qpfT2eKHqfkgY/gGy4mPSIZc7fHG4AXlyfPyVgf7jxs=;
        b=M8qBbcktry/0Ncr3swCBy+TcvqGHPqnuR3H1CnGTBPoqvm58RAtjYfod9p4Cpk3YOy
         fvS1G+KtgHIw/cKvuHhb4r5kRZDZwl3YoSljDj+9FIqy/SH/QnxnAu+hVwu83kMRLn0g
         IVDYHE/u73UcaoKvD9Es2WIUWQ2tK4ozAvBYaxcfnRF2TMnAvy5YKzZS/jBEo6ytg+kM
         5kmRvHGAk3Vq7PItsKVLlc9yZnJ/L1HcLI7GmTp7MmACqHCLBM92+uKjODDOy0ipGi54
         it1S7DGAYZUZ/oxWyL8ozo2NTB0wQSR0AbCaGOaWxq3jge9JmtWAlr/mUk/ay60M73a4
         RiLw==
X-Gm-Message-State: AOAM531xQYOOa6ZiQqxw52fn4Dn21J0jeIFm21pbshoazxwGrOlLSYkw
        raVlCK/W+C5wJuOIZkw3sZPtkaKvXeKoFAQ/r5iOqgDQPvuP
X-Google-Smtp-Source: ABdhPJwIredVcjpLxPPdrzhwd7FASpCIMf+45ey8uG65hp7lnr3QGhIzJ/YI7n1j22ok3bkA7t04Wnc99fUgiYck6gGoYJMe6GaV
MIME-Version: 1.0
X-Received: by 2002:a92:cd48:: with SMTP id v8mr32332884ilq.114.1594050144924;
 Mon, 06 Jul 2020 08:42:24 -0700 (PDT)
Date:   Mon, 06 Jul 2020 08:42:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a47ace05a9c7b825@google.com>
Subject: memory leak in inotify_update_watch
From:   syzbot <syzbot+dec34b033b3479b9ef13@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17644c05100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ee23b9caef4e07a
dashboard link: https://syzkaller.appspot.com/bug?extid=dec34b033b3479b9ef13
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1478a67b100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dec34b033b3479b9ef13@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888115db8480 (size 576):
  comm "systemd-udevd", pid 11037, jiffies 4295104591 (age 56.960s)
  hex dump (first 32 bytes):
    00 04 00 00 00 00 00 00 80 fd e8 15 81 88 ff ff  ................
    a0 02 dd 20 81 88 ff ff b0 81 d0 09 81 88 ff ff  ... ............
  backtrace:
    [<00000000288c0066>] radix_tree_node_alloc.constprop.0+0xc1/0x140 lib/radix-tree.c:252
    [<00000000f80ba6a7>] idr_get_free+0x231/0x3b0 lib/radix-tree.c:1505
    [<00000000ec9ab938>] idr_alloc_u32+0x91/0x120 lib/idr.c:46
    [<00000000aea98d29>] idr_alloc_cyclic+0x84/0x110 lib/idr.c:125
    [<00000000dbad44a4>] inotify_add_to_idr fs/notify/inotify/inotify_user.c:365 [inline]
    [<00000000dbad44a4>] inotify_new_watch fs/notify/inotify/inotify_user.c:578 [inline]
    [<00000000dbad44a4>] inotify_update_watch+0x1af/0x2d0 fs/notify/inotify/inotify_user.c:617
    [<00000000e141890d>] __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:755 [inline]
    [<00000000e141890d>] __se_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:698 [inline]
    [<00000000e141890d>] __x64_sys_inotify_add_watch+0x12f/0x180 fs/notify/inotify/inotify_user.c:698
    [<00000000d872d7cc>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:359
    [<000000005c62d8da>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811fb8c180 (size 192):
  comm "systemd-udevd", pid 11486, jiffies 4295108810 (age 14.770s)
  hex dump (first 32 bytes):
    08 80 00 00 06 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 89 13 1a 81 88 ff ff  ................
  backtrace:
    [<000000009fe0803b>] __d_alloc+0x2a/0x260 fs/dcache.c:1709
    [<000000005a828803>] d_alloc+0x21/0xb0 fs/dcache.c:1788
    [<00000000e0349988>] __lookup_hash+0x67/0xc0 fs/namei.c:1441
    [<00000000907d6c36>] filename_create+0xa5/0x1c0 fs/namei.c:3459
    [<0000000025ebf47f>] user_path_create fs/namei.c:3516 [inline]
    [<0000000025ebf47f>] do_symlinkat+0x70/0x180 fs/namei.c:3973
    [<00000000d872d7cc>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:359
    [<000000005c62d8da>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888107962b00 (size 704):
  comm "systemd-udevd", pid 11486, jiffies 4295108810 (age 14.770s)
  hex dump (first 32 bytes):
    00 00 00 00 01 00 00 00 00 00 20 00 00 00 00 00  .......... .....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000001bbffdf0>] shmem_alloc_inode+0x18/0x40 mm/shmem.c:3701
    [<000000008bdb5db7>] alloc_inode+0x27/0xf0 fs/inode.c:232
    [<00000000b322bd08>] new_inode_pseudo fs/inode.c:928 [inline]
    [<00000000b322bd08>] new_inode+0x21/0xf0 fs/inode.c:957
    [<0000000090aa6bc7>] shmem_get_inode+0x47/0x2b0 mm/shmem.c:2229
    [<00000000d46b8299>] shmem_symlink+0x6b/0x290 mm/shmem.c:3080
    [<00000000edfa50df>] vfs_symlink fs/namei.c:3953 [inline]
    [<00000000edfa50df>] vfs_symlink+0x15a/0x230 fs/namei.c:3939
    [<00000000a8f2bfa3>] do_symlinkat+0x14f/0x180 fs/namei.c:3980
    [<00000000d872d7cc>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:359
    [<000000005c62d8da>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811952fa80 (size 56):
  comm "systemd-udevd", pid 11486, jiffies 4295108810 (age 14.770s)
  hex dump (first 32 bytes):
    a8 2c 96 07 81 88 ff ff e0 18 b9 81 ff ff ff ff  .,..............
    70 2b 96 07 81 88 ff ff 98 fa 52 19 81 88 ff ff  p+........R.....
  backtrace:
    [<00000000369fbe38>] kmem_cache_zalloc include/linux/slab.h:659 [inline]
    [<00000000369fbe38>] lsm_inode_alloc security/security.c:588 [inline]
    [<00000000369fbe38>] security_inode_alloc+0x2e/0xb0 security/security.c:971
    [<000000005b4a8c5f>] inode_init_always+0x10c/0x200 fs/inode.c:171
    [<0000000022ebc8f1>] alloc_inode+0x44/0xf0 fs/inode.c:239
    [<00000000b322bd08>] new_inode_pseudo fs/inode.c:928 [inline]
    [<00000000b322bd08>] new_inode+0x21/0xf0 fs/inode.c:957
    [<0000000090aa6bc7>] shmem_get_inode+0x47/0x2b0 mm/shmem.c:2229
    [<00000000d46b8299>] shmem_symlink+0x6b/0x290 mm/shmem.c:3080
    [<00000000edfa50df>] vfs_symlink fs/namei.c:3953 [inline]
    [<00000000edfa50df>] vfs_symlink+0x15a/0x230 fs/namei.c:3939
    [<00000000a8f2bfa3>] do_symlinkat+0x14f/0x180 fs/namei.c:3980
    [<00000000d872d7cc>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:359
    [<000000005c62d8da>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811f95dcc0 (size 192):
  comm "systemd-udevd", pid 11488, jiffies 4295108822 (age 14.650s)
  hex dump (first 32 bytes):
    08 80 00 00 06 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 89 13 1a 81 88 ff ff  ................
  backtrace:
    [<000000009fe0803b>] __d_alloc+0x2a/0x260 fs/dcache.c:1709
    [<000000005a828803>] d_alloc+0x21/0xb0 fs/dcache.c:1788
    [<00000000e0349988>] __lookup_hash+0x67/0xc0 fs/namei.c:1441
    [<00000000907d6c36>] filename_create+0xa5/0x1c0 fs/namei.c:3459
    [<0000000025ebf47f>] user_path_create fs/namei.c:3516 [inline]
    [<0000000025ebf47f>] do_symlinkat+0x70/0x180 fs/namei.c:3973
    [<00000000d872d7cc>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:359
    [<000000005c62d8da>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
