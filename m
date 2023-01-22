Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4BA676B38
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jan 2023 06:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjAVFWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Jan 2023 00:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVFWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Jan 2023 00:22:43 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A22A5D9
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Jan 2023 21:22:41 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id t3-20020a6bc303000000b006f7844c6298so5301547iof.23
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Jan 2023 21:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NALf3bLFQVGdbzBDnfykp+W6RD21i+P9u/V70ua/+sI=;
        b=PwNB7qRsrrQHseusMcDJAkG3G79XZe1ihzr+XT3hnUJ7UEGVUxa2gVezG9mNM4xx0+
         CECAH5naSl22WrW48NNcAJiu4r/4IDdF9Xrdy6UNjWEnMX1NkNUsDN8Stx8E8CTlkYCX
         5ReQNmriN1pkB1nKJEG73RYXU+jqLMcEfrptCXQ2ETIdEzAPoMLyDqpOofO5yO/iE+Db
         ZD18o4f+Bxfm0SJPXMUwh1ffaNVp5a7zhh4lfSgcAI4Bese/csr0YU/P9gdHzrdXfCdK
         keUjsp3N68QLrDAdO5LdDURVk7j3fXk+QT3VCFgsbDrvUQaAjFfQRywnqy6sNFtTrpkj
         1Kuw==
X-Gm-Message-State: AFqh2kpcEi8dCFxg6FGRmr/t4yeSBHDRmwarM7ysBROO2O+1iG6ZoDVz
        SWuGzBg9qCjD5t81vGD2XHslJICBLM6pBkUO4lH6hCfhdYDx
X-Google-Smtp-Source: AMrXdXu7KDDLbYQrUXFIqTms6Jv7DcW42xpnMeCCOgrlbHv2/XJJ+BCrfp+J0AH+N8XEJbHjjeFmt08m1LlXYepBCue7MVc73HGK
MIME-Version: 1.0
X-Received: by 2002:a92:d911:0:b0:30d:9b58:1f87 with SMTP id
 s17-20020a92d911000000b0030d9b581f87mr2158606iln.206.1674364960576; Sat, 21
 Jan 2023 21:22:40 -0800 (PST)
Date:   Sat, 21 Jan 2023 21:22:40 -0800
In-Reply-To: <000000000000a806c405f0c4c45b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b31ed905f2d37856@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfs_find_init (2)
From:   syzbot <syzbot+e390d66dda462b51fde1@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    edb2f0dc90f2 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12506805480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1c301efa2b11613
dashboard link: https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d841fe480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134aa8fa480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ca1677dc6969/disk-edb2f0dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/22527595a2dd/vmlinux-edb2f0dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/45308e5f6962/Image-edb2f0dc.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7b6fdf809f4c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e390d66dda462b51fde1@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.2.0-rc4-syzkaller-16807-gedb2f0dc90f2 #0 Not tainted
--------------------------------------------
kworker/u4:3/103 is trying to acquire lock:
ffff0000c7f8c0b0 (&tree->tree_lock/1){+.+.}-{3:3}, at: hfs_find_init+0xac/0xcc

but task is already holding lock:
ffff0000c7f8c0b0 (&tree->tree_lock/1){+.+.}-{3:3}, at: hfs_find_init+0xac/0xcc

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&tree->tree_lock/1);
  lock(&tree->tree_lock/1);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by kworker/u4:3/103:
 #0: ffff0000c0250138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x270/0x504 kernel/workqueue.c:2262
 #1: ffff80000f90bd80 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x29c/0x504 kernel/workqueue.c:2264
 #2: ffff0000c7f8c0b0 (&tree->tree_lock/1){+.+.}-{3:3}, at: hfs_find_init+0xac/0xcc
 #3: ffff0000cc2500f8 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0x54/0x740 fs/hfs/extent.c:397

stack backtrace:
CPU: 1 PID: 103 Comm: kworker/u4:3 Not tainted 6.2.0-rc4-syzkaller-16807-gedb2f0dc90f2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: writeback wb_workfn (flush-7:0)
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 __lock_acquire+0x808/0x3084
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 hfs_find_init+0xac/0xcc
 hfs_ext_read_extent fs/hfs/extent.c:200 [inline]
 hfs_extend_file+0x120/0x740 fs/hfs/extent.c:401
 hfs_bmap_reserve+0x44/0xe8 fs/hfs/btree.c:234
 __hfs_ext_write_extent+0xb8/0x138 fs/hfs/extent.c:121
 hfs_ext_write_extent+0x9c/0xd8 fs/hfs/extent.c:144
 hfs_write_inode+0x68/0x478 fs/hfs/inode.c:431
 write_inode fs/fs-writeback.c:1451 [inline]
 __writeback_single_inode+0x240/0x2e4 fs/fs-writeback.c:1663
 writeback_sb_inodes+0x308/0x678 fs/fs-writeback.c:1889
 wb_writeback+0x198/0x328 fs/fs-writeback.c:2063
 wb_do_writeback+0xc8/0x384 fs/fs-writeback.c:2206
 wb_workfn+0x70/0x15c fs/fs-writeback.c:2246
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863

