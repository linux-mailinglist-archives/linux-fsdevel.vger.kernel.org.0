Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8182ABB1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 14:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbgKINYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 08:24:25 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:42738 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387577AbgKINYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:24:25 -0500
Received: by mail-io1-f69.google.com with SMTP id p67so5584743iod.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 05:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fgNK6IoDTp7K+SNgN+daalRgnaKA+Oq/DJ1GpYsB9Dc=;
        b=bY4jpn845TT+clo7OaUQhxti1YdVs8lmWL0hwhtKrLqhwtUCk07LzszrQpNqcaJGNF
         uEMRJz3ckM/fxPwV8IEeHbcTaRhg7sXlEwAgbHj1lssf6jybCNKdy7OBgh+bRivxlljc
         Xdzkr0/MaT3x9WSPRpIi7+OJHI5BupNWCpqK/82s8HYcYYOqVKXn/ONrFTOgg+qH1n/Y
         5hy6neunJkbfui8bO7pLouokBEtYkjB5snn57IPQnNBsAHzmzqTNLFnUeO8L9ZOWrwO/
         dJCJjZGlOGTP7yPNtbfOJhJJwQygpqyOKw42vCigGcUZ7DVNdrdfU4SuXC0DIlMx9D7e
         GFjQ==
X-Gm-Message-State: AOAM532OFWdyoulJQV1//w6z37RfIkMx1CzhCAHB8dRTJ4y46bfB89Fn
        MO8twZilVLxvFCM9AKzjpNI92r306XlFjZV/QPREOzdwN9lf
X-Google-Smtp-Source: ABdhPJwRf+LLWeynIjNgtro0+TsBTph5slLzNSjXYeomUh6GB81RlI6r47zWR/i4zHM1g9FTrsGhUTOidJxVA7Mmx4DDyCNifaOZ
MIME-Version: 1.0
X-Received: by 2002:a02:6a5b:: with SMTP id m27mr11336069jaf.58.1604928262165;
 Mon, 09 Nov 2020 05:24:22 -0800 (PST)
Date:   Mon, 09 Nov 2020 05:24:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4db7805b3ac7a65@google.com>
Subject: memory leak in anon_inode_getfile
From:   syzbot <syzbot+05d57384ff3551e412be@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9dbc1c03 Merge tag 'xfs-5.10-fixes-3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14554746500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da948f64bffc0baf
dashboard link: https://syzkaller.appspot.com/bug?extid=05d57384ff3551e412be
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10db2f92500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1698d134500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+05d57384ff3551e412be@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881019e6d00 (size 256):
  comm "syz-executor550", pid 8486, jiffies 4294950527 (age 34.300s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    a0 e0 fd 40 81 88 ff ff c0 96 fc 0f 81 88 ff ff  ...@............
  backtrace:
    [<00000000e44e21fc>] kmem_cache_zalloc include/linux/slab.h:654 [inline]
    [<00000000e44e21fc>] __alloc_file+0x1f/0x130 fs/file_table.c:101
    [<00000000d4a5a020>] alloc_empty_file+0x69/0x120 fs/file_table.c:151
    [<00000000eb40cf42>] alloc_file+0x33/0x1b0 fs/file_table.c:193
    [<000000001c6c0501>] alloc_file_pseudo+0xb2/0x140 fs/file_table.c:233
    [<00000000acbecb3c>] anon_inode_getfile fs/anon_inodes.c:91 [inline]
    [<00000000acbecb3c>] anon_inode_getfile+0xaa/0x120 fs/anon_inodes.c:74
    [<0000000047c0be97>] io_uring_get_fd fs/io_uring.c:9172 [inline]
    [<0000000047c0be97>] io_uring_create fs/io_uring.c:9351 [inline]
    [<0000000047c0be97>] io_uring_setup+0x1139/0x1640 fs/io_uring.c:9385
    [<0000000079584e06>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<000000009e5ef977>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e3ce58 (size 24):
  comm "syz-executor550", pid 8486, jiffies 4294950527 (age 34.300s)
  hex dump (first 24 bytes):
    00 00 00 00 00 00 00 00 b0 4e 93 00 81 88 ff ff  .........N......
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<00000000c78e23d5>] kmem_cache_zalloc include/linux/slab.h:654 [inline]
    [<00000000c78e23d5>] lsm_file_alloc security/security.c:568 [inline]
    [<00000000c78e23d5>] security_file_alloc+0x2a/0xb0 security/security.c:1456
    [<000000000d394d00>] __alloc_file+0x5d/0x130 fs/file_table.c:106
    [<00000000d4a5a020>] alloc_empty_file+0x69/0x120 fs/file_table.c:151
    [<00000000eb40cf42>] alloc_file+0x33/0x1b0 fs/file_table.c:193
    [<000000001c6c0501>] alloc_file_pseudo+0xb2/0x140 fs/file_table.c:233
    [<00000000acbecb3c>] anon_inode_getfile fs/anon_inodes.c:91 [inline]
    [<00000000acbecb3c>] anon_inode_getfile+0xaa/0x120 fs/anon_inodes.c:74
    [<0000000047c0be97>] io_uring_get_fd fs/io_uring.c:9172 [inline]
    [<0000000047c0be97>] io_uring_create fs/io_uring.c:9351 [inline]
    [<0000000047c0be97>] io_uring_setup+0x1139/0x1640 fs/io_uring.c:9385
    [<0000000079584e06>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<000000009e5ef977>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888101abb840 (size 168):
  comm "syz-executor550", pid 8473, jiffies 4294952674 (age 12.830s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000046ab9583>] prepare_creds+0x25/0x390 kernel/cred.c:258
    [<00000000064d32d3>] copy_creds+0x3a/0x230 kernel/cred.c:358
    [<00000000d2f3a3f7>] copy_process+0x66f/0x2510 kernel/fork.c:1971
    [<00000000e82686f8>] kernel_clone+0xf3/0x670 kernel/fork.c:2456
    [<00000000bbc67aa6>] __do_sys_clone+0x76/0xa0 kernel/fork.c:2573
    [<0000000079584e06>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<000000009e5ef977>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888101716600 (size 256):
  comm "syz-executor550", pid 8502, jiffies 4294952674 (age 12.830s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    a0 e0 fd 40 81 88 ff ff 80 fd fd 0f 81 88 ff ff  ...@............
  backtrace:
    [<00000000e44e21fc>] kmem_cache_zalloc include/linux/slab.h:654 [inline]
    [<00000000e44e21fc>] __alloc_file+0x1f/0x130 fs/file_table.c:101
    [<00000000d4a5a020>] alloc_empty_file+0x69/0x120 fs/file_table.c:151
    [<00000000eb40cf42>] alloc_file+0x33/0x1b0 fs/file_table.c:193
    [<000000001c6c0501>] alloc_file_pseudo+0xb2/0x140 fs/file_table.c:233
    [<00000000acbecb3c>] anon_inode_getfile fs/anon_inodes.c:91 [inline]
    [<00000000acbecb3c>] anon_inode_getfile+0xaa/0x120 fs/anon_inodes.c:74
    [<0000000047c0be97>] io_uring_get_fd fs/io_uring.c:9172 [inline]
    [<0000000047c0be97>] io_uring_create fs/io_uring.c:9351 [inline]
    [<0000000047c0be97>] io_uring_setup+0x1139/0x1640 fs/io_uring.c:9385
    [<0000000079584e06>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<000000009e5ef977>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
