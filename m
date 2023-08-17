Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6669B77F7EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 15:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351546AbjHQNkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 09:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351608AbjHQNkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:40:12 -0400
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36F730E5
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 06:40:05 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1bdbd0a7929so72919775ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 06:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692279605; x=1692884405;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKM3mqTlgT079nisdnjY2RvkrLED2w8Eo9ddvQKyDq0=;
        b=OrwXdE5REURnU7rWehOhWTVOvGqhSkDPZA7VlY2rNt6i8WmKBphKEbytCuFY1kkcOG
         7Qlp6MZF4UqraPC5PS9/x17bcdp9CUGe9z/K5sLxN+c0qhnCJZuCMlValQfsRVDC+wVh
         BHWJPvGChwQgooUfERU+fmtR1KI9sniQkA9aN6m3R1Y4hE9D5RDPBnMEYMrnUKwdsYdj
         OXS+f+dXIR8e1xbFDYSpCALhklvotIgUHFoleXN/f0pZnVpcwdJ527J6LF8N05Ybfdr3
         /vuPOyrZvba4TeVzM2yLkDFfkmILqghCMeqvshKwnROtd638vlw3ED+HROqO09+ER/tf
         wBRA==
X-Gm-Message-State: AOJu0Yxd6OJjzNLAJ3YM8skQ5Qt4/WIvzOl9CuHxN6vb1Esuhog5Pb97
        W8RjWQgiEGEzrUvXDBS8JP8WJVlJ6IaCoOVb2DKr0Qr6dp5a
X-Google-Smtp-Source: AGHT+IF9XIQq87Cbj1GxerhAfoAV3YFZOXuHglz/+2osaYmfsMGyG/4fpHgKgJFEKeWolLJ/eRAJBXy9Z4DeX5goZCLPUoMR43Cc
MIME-Version: 1.0
X-Received: by 2002:a17:902:da88:b0:1b8:a555:7615 with SMTP id
 j8-20020a170902da8800b001b8a5557615mr1994144plx.9.1692279605391; Thu, 17 Aug
 2023 06:40:05 -0700 (PDT)
Date:   Thu, 17 Aug 2023 06:40:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd78e706031e8c02@google.com>
Subject: [syzbot] [ext4?] memory leak in __es_insert_extent
From:   syzbot <syzbot+f3d40299952f55df8614@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a785fd28d31f Merge tag 'for-6.5-rc5-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141ddd73a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bf8962e4f7984f4
dashboard link: https://syzkaller.appspot.com/bug?extid=f3d40299952f55df8614
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1471c04ba80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5b766dfb84ba/disk-a785fd28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c3ee7bb9fc27/vmlinux-a785fd28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ffbde03d2df8/bzImage-a785fd28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3d40299952f55df8614@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888131b41000 (size 40):
  comm "syz-executor.2", pid 17149, jiffies 4294966508 (age 33.030s)
  hex dump (first 32 bytes):
    29 ff b6 31 81 88 ff ff 00 00 00 00 00 00 00 00  )..1............
    00 00 00 00 00 00 00 00 0b 0c 00 00 09 00 00 00  ................
  backtrace:
    [<ffffffff81824c5a>] __es_alloc_extent fs/ext4/extents_status.c:467 [inline]
    [<ffffffff81824c5a>] __es_alloc_extent fs/ext4/extents_status.c:464 [inline]
    [<ffffffff81824c5a>] __es_insert_extent+0x28a/0x540 fs/ext4/extents_status.c:815
    [<ffffffff81826ef0>] ext4_es_insert_extent+0x1e0/0x890 fs/ext4/extents_status.c:882
    [<ffffffff81842145>] ext4_map_blocks+0x575/0xad0 fs/ext4/inode.c:680
    [<ffffffff81842790>] _ext4_get_block+0xf0/0x1a0 fs/ext4/inode.c:763
    [<ffffffff8183ead6>] ext4_block_write_begin+0x216/0x730 fs/ext4/inode.c:1043
    [<ffffffff8184b4e0>] ext4_write_begin+0x2a0/0x7c0 fs/ext4/inode.c:1183
    [<ffffffff8184bada>] ext4_da_write_begin+0xda/0x3c0 fs/ext4/inode.c:2867
    [<ffffffff814fcf36>] generic_perform_write+0x116/0x2e0 mm/filemap.c:3923
    [<ffffffff81829f20>] ext4_buffered_write_iter+0xa0/0x1a0 fs/ext4/file.c:299
    [<ffffffff8182a0d2>] ext4_file_write_iter+0xb2/0xde0 fs/ext4/file.c:722
    [<ffffffff81665edd>] __kernel_write_iter+0x10d/0x370 fs/read_write.c:517
    [<ffffffff8173cc81>] dump_emit_page fs/coredump.c:888 [inline]
    [<ffffffff8173cc81>] dump_user_range+0x141/0x3a0 fs/coredump.c:915
    [<ffffffff8172d344>] elf_core_dump+0x10c4/0x1570 fs/binfmt_elf.c:2142
    [<ffffffff8173c4c8>] do_coredump+0x19b8/0x2030 fs/coredump.c:764
    [<ffffffff812a2f92>] get_signal+0xf52/0xfb0 kernel/signal.c:2867
    [<ffffffff81132f69>] arch_do_signal_or_restart+0x39/0x280 arch/x86/kernel/signal.c:308



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
