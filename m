Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB9A77CA2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 11:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjHOJPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 05:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbjHOJPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:15:18 -0400
Received: from mail-pj1-f77.google.com (mail-pj1-f77.google.com [209.85.216.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA741BC2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 02:15:16 -0700 (PDT)
Received: by mail-pj1-f77.google.com with SMTP id 98e67ed59e1d1-26b4e3a83a9so2060337a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 02:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692090916; x=1692695716;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+iGRWuefmU2hiUid4QGdYR0UnLqwkGiIEu1C3f/EfQ=;
        b=LZfTfGW6d1Hxcy1NWxhjImw6Dz31rkQmKgc+IVXAp4bW6oJdhsSejbQrGNm0A1kehV
         vLdZ6a5Kk76X8KHQdq/3gfgKTUUL4RmOSdLd/IHtJZ5MDZNIwSb2whqMRrp+HpkuklIz
         e0e5qI6iUS5QbetM71zwWU1gPHBCjuGWCHAx1G9zaVFZTbxZk2ntuolVU9+2dOQhiZak
         C41jJvm4fdSPjKDRHB5ZcGtkj4xaChFhrbgTG0G0ao6zKGSx8CZBVLzejAiGKQGpUYga
         rUlarrz3wmuzVQS0gcRWF0XRpDiiOTinmgBJWq5/YUzDfxwybpdt1BAZtsIvb7/lPgIX
         LbjQ==
X-Gm-Message-State: AOJu0YxaY2qiBc5UQvQprYI9dF6mRV5TYNMolUHHMUUoFF0xjbhNEDAq
        05mpSzQ+jNaQtWg+Sep41Tp60xTY61knXAvU1qzGvI9Qx95i
X-Google-Smtp-Source: AGHT+IH9Pz6z43oMnXdI0xY8eQPyvoGkbhYumOmSRX9gEC4UXvhJLnTswhlaJzcU5cCPpBg9a5uPT9cIokiDiBeB3fRQBdS/jRWl
MIME-Version: 1.0
X-Received: by 2002:a17:90a:f306:b0:268:2de3:e6b2 with SMTP id
 ca6-20020a17090af30600b002682de3e6b2mr2876129pjb.5.1692090915735; Tue, 15 Aug
 2023 02:15:15 -0700 (PDT)
Date:   Tue, 15 Aug 2023 02:15:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5ce160602f29dd6@google.com>
Subject: [syzbot] [btrfs?] memory leak in btrfs_ref_tree_mod
From:   syzbot <syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    25aa0bebba72 Merge tag 'net-6.5-rc6' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169577fda80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bf8962e4f7984f4
dashboard link: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148191c3a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76b0857d2814/disk-25aa0beb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a01574755257/vmlinux-25aa0beb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/262002db770e/bzImage-25aa0beb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b93cffaa6717/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888129851240 (size 64):
  comm "syz-executor.0", pid 5069, jiffies 4294977377 (age 16.480s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815545e5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1076
    [<ffffffff821731b1>] kmalloc include/linux/slab.h:582 [inline]
    [<ffffffff821731b1>] btrfs_ref_tree_mod+0x211/0xb80 fs/btrfs/ref-verify.c:768
    [<ffffffff820444f6>] btrfs_free_tree_block+0x116/0x450 fs/btrfs/extent-tree.c:3250
    [<ffffffff8202d775>] __btrfs_cow_block+0x6a5/0xa30 fs/btrfs/ctree.c:601
    [<ffffffff8202dc54>] btrfs_cow_block+0x154/0x2b0 fs/btrfs/ctree.c:712
    [<ffffffff8206013c>] commit_cowonly_roots+0x8c/0x3f0 fs/btrfs/transaction.c:1276
    [<ffffffff820647c9>] btrfs_commit_transaction+0x999/0x15c0 fs/btrfs/transaction.c:2410
    [<ffffffff8205a516>] btrfs_commit_super+0x86/0xb0 fs/btrfs/disk-io.c:4195
    [<ffffffff8205c743>] close_ctree+0x543/0x730 fs/btrfs/disk-io.c:4349
    [<ffffffff8166b44e>] generic_shutdown_super+0x9e/0x1c0 fs/super.c:499
    [<ffffffff8166b769>] kill_anon_super+0x19/0x30 fs/super.c:1110
    [<ffffffff8202357d>] btrfs_kill_super+0x1d/0x30 fs/btrfs/super.c:2138
    [<ffffffff8166ca46>] deactivate_locked_super+0x46/0xd0 fs/super.c:330
    [<ffffffff8166cb6c>] deactivate_super fs/super.c:361 [inline]
    [<ffffffff8166cb6c>] deactivate_super+0x9c/0xb0 fs/super.c:357
    [<ffffffff816a8931>] cleanup_mnt+0x121/0x210 fs/namespace.c:1254
    [<ffffffff812becaf>] task_work_run+0x8f/0xe0 kernel/task_work.c:179



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
