Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C9A72AB92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjFJM55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jun 2023 08:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjFJM5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:57:55 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357B91A4
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jun 2023 05:57:52 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-777ab76f328so264952439f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jun 2023 05:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686401871; x=1688993871;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cgHCjAuH4DjYI9d8JVOK367/nLP8kHy5aJE3jwS5Mn4=;
        b=Lgd4BJdDVPbO1uhLoJcx8gCAqQqcJQk4C5J503K3TgHqjLaFi2XDSnRf5EXJbW9J1i
         u3wKHsRBoRfJZaB9+gr10/FoXH7gnmbLH9l9Bht6Vtncy5RGoHd7WEE75sFq9P/p6ZPI
         kWJe4cRJxNPQDJUCN2Ee1PYPWfWoPwwvWHw0E87jjpCe+EVremRvzy071y/Pn4sgrQPd
         ZgBzv1J/gfLk0ZKraPieXmowwM5bgn65lUshhhkPKOD14a58yVckmBH+eng95CsWbC7v
         Je7OnHEpQ5mFqcffuJ7sKfLnwMwqLA2bOvE2fMbG7/e/QnKq27ZnZUqVUdTGq/Ihuua8
         w9Tg==
X-Gm-Message-State: AC+VfDz+RgkGLnS6CaRVQ4jXHK1t7YVvCQoYRjOuIsZ3kwgIe5vn6td0
        vdgyPji4Mmn7h7GcU6+cFZ70oUYehvz68YRPr3vFrnrP0W7r
X-Google-Smtp-Source: ACHHUZ7Xd5V6//Vsj2DvVFxC+DKmJbyezyhA0icnL6gRGmyUcXzqX2HY0hOP2ioFuRd3ynTQ9VghGeHPlTiD9YItF6inLS55q+SW
MIME-Version: 1.0
X-Received: by 2002:a5e:c10c:0:b0:77a:c494:b4b8 with SMTP id
 v12-20020a5ec10c000000b0077ac494b4b8mr1883005iol.1.1686401871501; Sat, 10 Jun
 2023 05:57:51 -0700 (PDT)
Date:   Sat, 10 Jun 2023 05:57:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fe09705fdc6086c@google.com>
Subject: [syzbot] [btrfs?] memory leak in add_block_entry
From:   syzbot <syzbot+c563a3c79927971f950f@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f8dba31b0a82 Merge tag 'asym-keys-fix-for-linus-v6.4-rc5' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11aa7b15280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee975febba574924
dashboard link: https://syzkaller.appspot.com/bug?extid=c563a3c79927971f950f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173fab79280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b4622d280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4a6b265f7061/disk-f8dba31b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/430b37c501c8/vmlinux-f8dba31b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/112fa4e51bb8/bzImage-f8dba31b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/11e3e386cf39/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c563a3c79927971f950f@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888109b51580 (size 96):
  comm "syz-executor154", pid 5193, jiffies 4294972644 (age 19.050s)
  hex dump (first 32 bytes):
    00 10 10 00 00 00 00 00 00 10 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff81545a34>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff8213b65e>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff8213b65e>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff8213b65e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff8213bcfe>] add_tree_block+0x9e/0x220 fs/btrfs/ref-verify.c:332
    [<ffffffff8213d245>] btrfs_build_ref_tree+0x535/0x7c0 fs/btrfs/ref-verify.c:474
    [<ffffffff8202b2f1>] open_ctree+0x12d1/0x2360 fs/btrfs/disk-io.c:3710
    [<ffffffff81ff2e53>] btrfs_fill_super fs/btrfs/super.c:1156 [inline]
    [<ffffffff81ff2e53>] btrfs_mount_root+0x583/0x710 fs/btrfs/super.c:1524
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff81698e91>] fc_mount fs/namespace.c:1035 [inline]
    [<ffffffff81698e91>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1065
    [<ffffffff81698f20>] vfs_kern_mount+0x40/0x60 fs/namespace.c:1052
    [<ffffffff81ff6e8d>] btrfs_mount+0x19d/0x620 fs/btrfs/super.c:1584
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff816a0ac3>] do_new_mount fs/namespace.c:3039 [inline]
    [<ffffffff816a0ac3>] path_mount+0xc53/0x10f0 fs/namespace.c:3369
    [<ffffffff816a1702>] do_mount fs/namespace.c:3382 [inline]
    [<ffffffff816a1702>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff816a1702>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff816a1702>] __x64_sys_mount+0x192/0x1e0 fs/namespace.c:3568
    [<ffffffff84a16749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a16749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

BUG: memory leak
unreferenced object 0xffff888109b51500 (size 96):
  comm "syz-executor154", pid 5193, jiffies 4294972644 (age 19.050s)
  hex dump (first 32 bytes):
    00 30 50 00 00 00 00 00 00 10 00 00 00 00 00 00  .0P.............
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff81545a34>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff8213b65e>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff8213b65e>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff8213b65e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff8213bcfe>] add_tree_block+0x9e/0x220 fs/btrfs/ref-verify.c:332
    [<ffffffff8213d245>] btrfs_build_ref_tree+0x535/0x7c0 fs/btrfs/ref-verify.c:474
    [<ffffffff8202b2f1>] open_ctree+0x12d1/0x2360 fs/btrfs/disk-io.c:3710
    [<ffffffff81ff2e53>] btrfs_fill_super fs/btrfs/super.c:1156 [inline]
    [<ffffffff81ff2e53>] btrfs_mount_root+0x583/0x710 fs/btrfs/super.c:1524
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff81698e91>] fc_mount fs/namespace.c:1035 [inline]
    [<ffffffff81698e91>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1065
    [<ffffffff81698f20>] vfs_kern_mount+0x40/0x60 fs/namespace.c:1052
    [<ffffffff81ff6e8d>] btrfs_mount+0x19d/0x620 fs/btrfs/super.c:1584
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff816a0ac3>] do_new_mount fs/namespace.c:3039 [inline]
    [<ffffffff816a0ac3>] path_mount+0xc53/0x10f0 fs/namespace.c:3369
    [<ffffffff816a1702>] do_mount fs/namespace.c:3382 [inline]
    [<ffffffff816a1702>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff816a1702>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff816a1702>] __x64_sys_mount+0x192/0x1e0 fs/namespace.c:3568
    [<ffffffff84a16749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a16749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

BUG: memory leak
unreferenced object 0xffff888109b51480 (size 96):
  comm "syz-executor154", pid 5193, jiffies 4294972644 (age 19.050s)
  hex dump (first 32 bytes):
    00 60 50 00 00 00 00 00 00 10 00 00 00 00 00 00  .`P.............
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff81545a34>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff8213b65e>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff8213b65e>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff8213b65e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff8213bcfe>] add_tree_block+0x9e/0x220 fs/btrfs/ref-verify.c:332
    [<ffffffff8213d245>] btrfs_build_ref_tree+0x535/0x7c0 fs/btrfs/ref-verify.c:474
    [<ffffffff8202b2f1>] open_ctree+0x12d1/0x2360 fs/btrfs/disk-io.c:3710
    [<ffffffff81ff2e53>] btrfs_fill_super fs/btrfs/super.c:1156 [inline]
    [<ffffffff81ff2e53>] btrfs_mount_root+0x583/0x710 fs/btrfs/super.c:1524
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff81698e91>] fc_mount fs/namespace.c:1035 [inline]
    [<ffffffff81698e91>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1065
    [<ffffffff81698f20>] vfs_kern_mount+0x40/0x60 fs/namespace.c:1052
    [<ffffffff81ff6e8d>] btrfs_mount+0x19d/0x620 fs/btrfs/super.c:1584
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff816a0ac3>] do_new_mount fs/namespace.c:3039 [inline]
    [<ffffffff816a0ac3>] path_mount+0xc53/0x10f0 fs/namespace.c:3369
    [<ffffffff816a1702>] do_mount fs/namespace.c:3382 [inline]
    [<ffffffff816a1702>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff816a1702>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff816a1702>] __x64_sys_mount+0x192/0x1e0 fs/namespace.c:3568
    [<ffffffff84a16749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a16749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

BUG: memory leak
unreferenced object 0xffff888109b51580 (size 96):
  comm "syz-executor154", pid 5193, jiffies 4294972644 (age 20.200s)
  hex dump (first 32 bytes):
    00 10 10 00 00 00 00 00 00 10 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff81545a34>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff8213b65e>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff8213b65e>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff8213b65e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff8213bcfe>] add_tree_block+0x9e/0x220 fs/btrfs/ref-verify.c:332
    [<ffffffff8213d245>] btrfs_build_ref_tree+0x535/0x7c0 fs/btrfs/ref-verify.c:474
    [<ffffffff8202b2f1>] open_ctree+0x12d1/0x2360 fs/btrfs/disk-io.c:3710
    [<ffffffff81ff2e53>] btrfs_fill_super fs/btrfs/super.c:1156 [inline]
    [<ffffffff81ff2e53>] btrfs_mount_root+0x583/0x710 fs/btrfs/super.c:1524
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff81698e91>] fc_mount fs/namespace.c:1035 [inline]
    [<ffffffff81698e91>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1065
    [<ffffffff81698f20>] vfs_kern_mount+0x40/0x60 fs/namespace.c:1052
    [<ffffffff81ff6e8d>] btrfs_mount+0x19d/0x620 fs/btrfs/super.c:1584
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff816a0ac3>] do_new_mount fs/namespace.c:3039 [inline]
    [<ffffffff816a0ac3>] path_mount+0xc53/0x10f0 fs/namespace.c:3369
    [<ffffffff816a1702>] do_mount fs/namespace.c:3382 [inline]
    [<ffffffff816a1702>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff816a1702>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff816a1702>] __x64_sys_mount+0x192/0x1e0 fs/namespace.c:3568
    [<ffffffff84a16749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a16749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

BUG: memory leak
unreferenced object 0xffff888109b51500 (size 96):
  comm "syz-executor154", pid 5193, jiffies 4294972644 (age 20.200s)
  hex dump (first 32 bytes):
    00 30 50 00 00 00 00 00 00 10 00 00 00 00 00 00  .0P.............
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff81545a34>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff8213b65e>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff8213b65e>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff8213b65e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff8213bcfe>] add_tree_block+0x9e/0x220 fs/btrfs/ref-verify.c:332
    [<ffffffff8213d245>] btrfs_build_ref_tree+0x535/0x7c0 fs/btrfs/ref-verify.c:474
    [<ffffffff8202b2f1>] open_ctree+0x12d1/0x2360 fs/btrfs/disk-io.c:3710
    [<ffffffff81ff2e53>] btrfs_fill_super fs/btrfs/super.c:1156 [inline]
    [<ffffffff81ff2e53>] btrfs_mount_root+0x583/0x710 fs/btrfs/super.c:1524
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff81698e91>] fc_mount fs/namespace.c:1035 [inline]
    [<ffffffff81698e91>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1065
    [<ffffffff81698f20>] vfs_kern_mount+0x40/0x60 fs/namespace.c:1052
    [<ffffffff81ff6e8d>] btrfs_mount+0x19d/0x620 fs/btrfs/super.c:1584
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff816a0ac3>] do_new_mount fs/namespace.c:3039 [inline]
    [<ffffffff816a0ac3>] path_mount+0xc53/0x10f0 fs/namespace.c:3369
    [<ffffffff816a1702>] do_mount fs/namespace.c:3382 [inline]
    [<ffffffff816a1702>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff816a1702>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff816a1702>] __x64_sys_mount+0x192/0x1e0 fs/namespace.c:3568
    [<ffffffff84a16749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a16749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

BUG: memory leak
unreferenced object 0xffff888109b51480 (size 96):
  comm "syz-executor154", pid 5193, jiffies 4294972644 (age 20.200s)
  hex dump (first 32 bytes):
    00 60 50 00 00 00 00 00 00 10 00 00 00 00 00 00  .`P.............
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff81545a34>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff8213b65e>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff8213b65e>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff8213b65e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff8213bcfe>] add_tree_block+0x9e/0x220 fs/btrfs/ref-verify.c:332
    [<ffffffff8213d245>] btrfs_build_ref_tree+0x535/0x7c0 fs/btrfs/ref-verify.c:474
    [<ffffffff8202b2f1>] open_ctree+0x12d1/0x2360 fs/btrfs/disk-io.c:3710
    [<ffffffff81ff2e53>] btrfs_fill_super fs/btrfs/super.c:1156 [inline]
    [<ffffffff81ff2e53>] btrfs_mount_root+0x583/0x710 fs/btrfs/super.c:1524
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff81698e91>] fc_mount fs/namespace.c:1035 [inline]
    [<ffffffff81698e91>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1065
    [<ffffffff81698f20>] vfs_kern_mount+0x40/0x60 fs/namespace.c:1052
    [<ffffffff81ff6e8d>] btrfs_mount+0x19d/0x620 fs/btrfs/super.c:1584
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff816a0ac3>] do_new_mount fs/namespace.c:3039 [inline]
    [<ffffffff816a0ac3>] path_mount+0xc53/0x10f0 fs/namespace.c:3369
    [<ffffffff816a1702>] do_mount fs/namespace.c:3382 [inline]
    [<ffffffff816a1702>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff816a1702>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff816a1702>] __x64_sys_mount+0x192/0x1e0 fs/namespace.c:3568
    [<ffffffff84a16749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a16749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

BUG: memory leak
unreferenced object 0xffff888109b51580 (size 96):
  comm "syz-executor154", pid 5193, jiffies 4294972644 (age 22.400s)
  hex dump (first 32 bytes):
    00 10 10 00 00 00 00 00 00 10 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff81545a34>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff8213b65e>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff8213b65e>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff8213b65e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff8213bcfe>] add_tree_block+0x9e/0x220 fs/btrfs/ref-verify.c:332
    [<ffffffff8213d245>] btrfs_build_ref_tree+0x535/0x7c0 fs/btrfs/ref-verify.c:474
    [<ffffffff8202b2f1>] open_ctree+0x12d1/0x2360 fs/btrfs/disk-io.c:3710
    [<ffffffff81ff2e53>] btrfs_fill_super fs/btrfs/super.c:1156 [inline]
    [<ffffffff81ff2e53>] btrfs_mount_root+0x583/0x710 fs/btrfs/super.c:1524
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff81698e91>] fc_mount fs/namespace.c:1035 [inline]
    [<ffffffff81698e91>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1065
    [<ffffffff81698f20>] vfs_kern_mount+0x40/0x60 fs/namespace.c:1052
    [<ffffffff81ff6e8d>] btrfs_mount+0x19d/0x620 fs/btrfs/super.c:1584
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff816a0ac3>] do_new_mount fs/namespace.c:3039 [inline]
    [<ffffffff816a0ac3>] path_mount+0xc53/0x10f0 fs/namespace.c:3369
    [<ffffffff816a1702>] do_mount fs/namespace.c:3382 [inline]
    [<ffffffff816a1702>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff816a1702>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff816a1702>] __x64_sys_mount+0x192/0x1e0 fs/namespace.c:3568
    [<ffffffff84a16749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a16749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

BUG: memory leak
unreferenced object 0xffff888109b51500 (size 96):
  comm "syz-executor154", pid 5193, jiffies 4294972644 (age 22.400s)
  hex dump (first 32 bytes):
    00 30 50 00 00 00 00 00 00 10 00 00 00 00 00 00  .0P.............
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff81545a34>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff8213b65e>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff8213b65e>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff8213b65e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff8213bcfe>] add_tree_block+0x9e/0x220 fs/btrfs/ref-verify.c:332
    [<ffffffff8213d245>] btrfs_build_ref_tree+0x535/0x7c0 fs/btrfs/ref-verify.c:474
    [<ffffffff8202b2f1>] open_ctree+0x12d1/0x2360 fs/btrfs/disk-io.c:3710
    [<ffffffff81ff2e53>] btrfs_fill_super fs/btrfs/super.c:1156 [inline]
    [<ffffffff81ff2e53>] btrfs_mount_root+0x583/0x710 fs/btrfs/super.c:1524
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff81698e91>] fc_mount fs/namespace.c:1035 [inline]
    [<ffffffff81698e91>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1065
    [<ffffffff81698f20>] vfs_kern_mount+0x40/0x60 fs/namespace.c:1052
    [<ffffffff81ff6e8d>] btrfs_mount+0x19d/0x620 fs/btrfs/super.c:1584
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff816a0ac3>] do_new_mount fs/namespace.c:3039 [inline]
    [<ffffffff816a0ac3>] path_mount+0xc53/0x10f0 fs/namespace.c:3369
    [<ffffffff816a1702>] do_mount fs/namespace.c:3382 [inline]
    [<ffffffff816a1702>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff816a1702>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff816a1702>] __x64_sys_mount+0x192/0x1e0 fs/namespace.c:3568
    [<ffffffff84a16749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a16749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

BUG: memory leak
unreferenced object 0xffff888109b51480 (size 96):
  comm "syz-executor154", pid 5193, jiffies 4294972644 (age 22.400s)
  hex dump (first 32 bytes):
    00 60 50 00 00 00 00 00 00 10 00 00 00 00 00 00  .`P.............
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff81545a34>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff8213b65e>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff8213b65e>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff8213b65e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff8213bcfe>] add_tree_block+0x9e/0x220 fs/btrfs/ref-verify.c:332
    [<ffffffff8213d245>] btrfs_build_ref_tree+0x535/0x7c0 fs/btrfs/ref-verify.c:474
    [<ffffffff8202b2f1>] open_ctree+0x12d1/0x2360 fs/btrfs/disk-io.c:3710
    [<ffffffff81ff2e53>] btrfs_fill_super fs/btrfs/super.c:1156 [inline]
    [<ffffffff81ff2e53>] btrfs_mount_root+0x583/0x710 fs/btrfs/super.c:1524
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff81698e91>] fc_mount fs/namespace.c:1035 [inline]
    [<ffffffff81698e91>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1065
    [<ffffffff81698f20>] vfs_kern_mount+0x40/0x60 fs/namespace.c:1052
    [<ffffffff81ff6e8d>] btrfs_mount+0x19d/0x620 fs/btrfs/super.c:1584
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff816a0ac3>] do_new_mount fs/namespace.c:3039 [inline]
    [<ffffffff816a0ac3>] path_mount+0xc53/0x10f0 fs/namespace.c:3369
    [<ffffffff816a1702>] do_mount fs/namespace.c:3382 [inline]
    [<ffffffff816a1702>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff816a1702>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff816a1702>] __x64_sys_mount+0x192/0x1e0 fs/namespace.c:3568
    [<ffffffff84a16749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a16749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

BUG: memory leak
unreferenced object 0xffff888109b51580 (size 96):
  comm "syz-executor154", pid 5193, jiffies 4294972644 (age 22.440s)
  hex dump (first 32 bytes):
    00 10 10 00 00 00 00 00 00 10 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff81545a34>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff8213b65e>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff8213b65e>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff8213b65e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff8213bcfe>] add_tree_block+0x9e/0x220 fs/btrfs/ref-verify.c:332
    [<ffffffff8213d245>] btrfs_build_ref_tree+0x535/0x7c0 fs/btrfs/ref-verify.c:474
    [<ffffffff8202b2f1>] open_ctree+0x12d1/0x2360 fs/btrfs/disk-io.c:3710
    [<ffffffff81ff2e53>] btrfs_fill_super fs/btrfs/super.c:1156 [inline]
    [<ffffffff81ff2e53>] btrfs_mount_root+0x583/0x710 fs/btrfs/super.c:1524
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff81698e91>] fc_mount fs/namespace.c:1035 [inline]
    [<ffffffff81698e91>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1065
    [<ffffffff81698f20>] vfs_kern_mount+0x40/0x60 fs/namespace.c:1052
    [<ffffffff81ff6e8d>] btrfs_mount+0x19d/0x620 fs/btrfs/super.c:1584
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff816a0ac3>] do_new_mount fs/namespace.c:3039 [inline]
    [<ffffffff816a0ac3>] path_mount+0xc53/0x10f0 fs/namespace.c:3369
    [<ffffffff816a1702>] do_mount fs/namespace.c:3382 [inline]
    [<ffffffff816a1702>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff816a1702>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff816a1702>] __x64_sys_mount+0x192/0x1e0 fs/namespace.c:3568
    [<ffffffff84a16749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a16749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

BUG: memory leak
unreferenced object 0xffff888109b51500 (size 96):
  comm "syz-executor154", pid 5193, jiffies 4294972644 (age 22.440s)
  hex dump (first 32 bytes):
    00 30 50 00 00 00 00 00 00 10 00 00 00 00 00 00  .0P.............
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff81545a34>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff8213b65e>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff8213b65e>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff8213b65e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff8213bcfe>] add_tree_block+0x9e/0x220 fs/btrfs/ref-verify.c:332
    [<ffffffff8213d245>] btrfs_build_ref_tree+0x535/0x7c0 fs/btrfs/ref-verify.c:474
    [<ffffffff8202b2f1>] open_ctree+0x12d1/0x2360 fs/btrfs/disk-io.c:3710
    [<ffffffff81ff2e53>] btrfs_fill_super fs/btrfs/super.c:1156 [inline]
    [<ffffffff81ff2e53>] btrfs_mount_root+0x583/0x710 fs/btrfs/super.c:1524
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff81698e91>] fc_mount fs/namespace.c:1035 [inline]
    [<ffffffff81698e91>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1065
    [<ffffffff81698f20>] vfs_kern_mount+0x40/0x60 fs/namespace.c:1052
    [<ffffffff81ff6e8d>] btrfs_mount+0x19d/0x620 fs/btrfs/super.c:1584
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff816a0ac3>] do_new_mount fs/namespace.c:3039 [inline]
    [<ffffffff816a0ac3>] path_mount+0xc53/0x10f0 fs/namespace.c:3369
    [<ffffffff816a1702>] do_mount fs/namespace.c:3382 [inline]
    [<ffffffff816a1702>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff816a1702>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff816a1702>] __x64_sys_mount+0x192/0x1e0 fs/namespace.c:3568
    [<ffffffff84a16749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a16749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

BUG: memory leak
unreferenced object 0xffff888109b51480 (size 96):
  comm "syz-executor154", pid 5193, jiffies 4294972644 (age 22.440s)
  hex dump (first 32 bytes):
    00 60 50 00 00 00 00 00 00 10 00 00 00 00 00 00  .`P.............
    01 00 00 00 00 00 00 00 01 00 00 00 01 00 00 00  ................
  backtrace:
    [<ffffffff81545a34>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff8213b65e>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff8213b65e>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff8213b65e>] add_block_entry+0x4e/0x320 fs/btrfs/ref-verify.c:271
    [<ffffffff8213bcfe>] add_tree_block+0x9e/0x220 fs/btrfs/ref-verify.c:332
    [<ffffffff8213d245>] btrfs_build_ref_tree+0x535/0x7c0 fs/btrfs/ref-verify.c:474
    [<ffffffff8202b2f1>] open_ctree+0x12d1/0x2360 fs/btrfs/disk-io.c:3710
    [<ffffffff81ff2e53>] btrfs_fill_super fs/btrfs/super.c:1156 [inline]
    [<ffffffff81ff2e53>] btrfs_mount_root+0x583/0x710 fs/btrfs/super.c:1524
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff81698e91>] fc_mount fs/namespace.c:1035 [inline]
    [<ffffffff81698e91>] vfs_kern_mount.part.0+0xd1/0x120 fs/namespace.c:1065
    [<ffffffff81698f20>] vfs_kern_mount+0x40/0x60 fs/namespace.c:1052
    [<ffffffff81ff6e8d>] btrfs_mount+0x19d/0x620 fs/btrfs/super.c:1584
    [<ffffffff816c406f>] legacy_get_tree+0x2f/0x90 fs/fs_context.c:610
    [<ffffffff8165d7ac>] vfs_get_tree+0x2c/0x110 fs/super.c:1510
    [<ffffffff816a0ac3>] do_new_mount fs/namespace.c:3039 [inline]
    [<ffffffff816a0ac3>] path_mount+0xc53/0x10f0 fs/namespace.c:3369
    [<ffffffff816a1702>] do_mount fs/namespace.c:3382 [inline]
    [<ffffffff816a1702>] __do_sys_mount fs/namespace.c:3591 [inline]
    [<ffffffff816a1702>] __se_sys_mount fs/namespace.c:3568 [inline]
    [<ffffffff816a1702>] __x64_sys_mount+0x192/0x1e0 fs/namespace.c:3568
    [<ffffffff84a16749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a16749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

executing program
executing program
executing program


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
