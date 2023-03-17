Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E006BEE07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 17:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCQQYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 12:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCQQYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:24:41 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0D9C5AC6
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 09:24:40 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id i2-20020a5d9e42000000b0074cfcc4ed07so2769876ioi.22
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 09:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679070279;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0y9/Ok6+vCNzIdYJxiv4jUMbvf9Rwu/ySfXsPtfW0A=;
        b=YXr1DjLSwc5PwW5d2HhLZEH9s0WI2QrIV7bKVkdBzQ/1S1jBp/ruX5tLHaU52BRErU
         U+k7JM9EbqjWzUX4gh57LtPNJOP0vpigO/k3EMUfnzt32Sol+zsJ1j4TAeoO+HY4KN1R
         MmsiGExZAxPzISkrSL7HOW9oW0rG/9GqMxm9qjXLk54H8rT3cLu4Jk1Mu19PkchZcaIj
         et94Pbd06oRYtzwOqtxyjdERTvy2Cm43GNIM64QzSB7NV+f2D0zPpDgQRHyk+8+Y6oRz
         j6u5RBI/njpvdgSwWKa7UmqfQxr5Ts/2P+r8Bmj7XGkGX6m8QlPNMzI5lKf+YVQ2d/Ei
         +sIQ==
X-Gm-Message-State: AO0yUKVjLk5ds8dUtRjS/rsutIUUrax3rVUXB3tlPZzee1iFZXLmmJCA
        6Kg8FwikVqn37PZEPqS2AUfDCWn5StVYgyQhm11jSb/4g4r4
X-Google-Smtp-Source: AK7set+OMtlyYcxWFmRQyHbPvAkJYa6PMDJgDHLpH8OVq5WotsOwW5ikDZc4bsOtz+9ed8dSigIZoQmfDWqa7g7rZHKsrH0ITRN2
MIME-Version: 1.0
X-Received: by 2002:a02:3312:0:b0:3eb:3166:9da4 with SMTP id
 c18-20020a023312000000b003eb31669da4mr47250jae.2.1679070279581; Fri, 17 Mar
 2023 09:24:39 -0700 (PDT)
Date:   Fri, 17 Mar 2023 09:24:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009146bb05f71b03a0@google.com>
Subject: [syzbot] [ntfs?] KASAN: use-after-free Read in ntfs_read_folio
From:   syzbot <syzbot+d3cd38158cd7c8d1432c@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fe15c26ee26e Linux 6.3-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=144bbde2c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7573cbcd881a88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=d3cd38158cd7c8d1432c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1314fdaec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148332bec80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89d41abd07bd/disk-fe15c26e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa75f5030ade/vmlinux-fe15c26e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/590d0f5903ee/Image-fe15c26e.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/863572f0c7ee/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d3cd38158cd7c8d1432c@syzkaller.appspotmail.com

ntfs: (device loop0): ntfs_read_locked_inode(): Failed with error code -5.  Marking corrupt inode 0xa as bad.  Run chkdsk.
ntfs: (device loop0): load_and_init_upcase(): Failed to load $UpCase from the volume. Using default.
==================================================================
BUG: KASAN: use-after-free in ntfs_read_folio+0x6d4/0x200c fs/ntfs/aops.c:489
Read of size 1 at addr ffff0000e11f617f by task syz-executor319/5946

CPU: 0 PID: 5946 Comm: syz-executor319 Not tainted 6.3.0-rc1-syzkaller-gfe15c26ee26e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call trace:
 dump_backtrace+0x1c8/0x1f4 arch/arm64/kernel/stacktrace.c:158
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:165
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:319 [inline]
 print_report+0x174/0x514 mm/kasan/report.c:430
 kasan_report+0xd4/0x130 mm/kasan/report.c:536
 kasan_check_range+0x264/0x2a4 mm/kasan/generic.c:187
 __asan_memcpy+0x48/0x90 mm/kasan/shadow.c:105
 ntfs_read_folio+0x6d4/0x200c fs/ntfs/aops.c:489
 filemap_read_folio+0x14c/0x39c mm/filemap.c:2424
 do_read_cache_folio+0x24c/0x544 mm/filemap.c:3683
 do_read_cache_page mm/filemap.c:3749 [inline]
 read_cache_page+0x6c/0x180 mm/filemap.c:3758
 read_mapping_page include/linux/pagemap.h:769 [inline]
 ntfs_map_page fs/ntfs/aops.h:75 [inline]
 load_and_init_attrdef fs/ntfs/super.c:1617 [inline]
 load_system_files+0x1e34/0x4734 fs/ntfs/super.c:1825
 ntfs_fill_super+0x14e0/0x2314 fs/ntfs/super.c:2900
 mount_bdev+0x26c/0x368 fs/super.c:1371
 ntfs_mount+0x44/0x58 fs/ntfs/super.c:3057
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:610
 vfs_get_tree+0x90/0x274 fs/super.c:1501
 do_new_mount+0x25c/0x8c8 fs/namespace.c:3042
 path_mount+0x590/0xe20 fs/namespace.c:3372
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount fs/namespace.c:3571 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3571
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

The buggy address belongs to the physical page:
page:00000000b1c79ae3 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x1211f6
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
raw: 05ffc00000000000 fffffc0003847848 fffffc0003847d48 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000e11f6000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff0000e11f6080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff0000e11f6100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                                ^
 ffff0000e11f6180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff0000e11f6200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================
ntfs: volume version 3.1.
syz-executor319: attempt to access beyond end of device
loop0: rw=0, sector=2072, nr_sectors = 8 limit=190
ntfs: (device loop0): ntfs_end_buffer_async_read(): Buffer I/O error, logical block 0x103.
syz-executor319: attempt to access beyond end of device
loop0: rw=0, sector=552, nr_sectors = 8 limit=190
syz-executor319: attempt to access beyond end of device
loop0: rw=0, sector=224, nr_sectors = 8 limit=190


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
