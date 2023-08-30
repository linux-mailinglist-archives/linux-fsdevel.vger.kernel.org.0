Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD41078E251
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 00:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbjH3WaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 18:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239640AbjH3WaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:30:07 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B4819A
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 15:29:57 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1ccbcb5034aso107809fac.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 15:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693434596; x=1694039396;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9NmXwYpj44o4xkzQIM7RGKV1c90eyLE1sEyqDfJKB/Y=;
        b=NhFwrLl/Pm1YivC8nGpL9hktYubl5a7AhdpPyyIXFLeaC35OghPzpI2Np0OB+y42Qt
         vhuudgtYNg3NLRD7CTwj8K8JNHX6VIZ3eECkcf7YVNFUdcuwsjq+RwlIKHEE8yKCJCYQ
         tkcbABNDLRRm2bEMkk3S1ThUabuQzRq7qqlAzEKtTNsT3yR1rWvv1rR3S6ZzTaC63AV2
         nzZ3vIdMQtZy93gZdDxcqXlHyq/F1gs8jeRSDO6uo/SqQO3FezgjTgJEJkRIBKztCoTG
         LRQbxrCIzPe9yQ5oSprnb5cmTZs9e2J7IztDt3eXjakulOgGYpRokIdddXubeUf8K87e
         15/A==
X-Gm-Message-State: AOJu0Yw4ddB/ZjSY23fm1X7sgQEajulqPiI3bRel/HKY7x9DVrf/TfBS
        0O3v0RsZNhfzxYjCirCW8TBQP15iZV/SX+mwyJu6HEzl4RGb
X-Google-Smtp-Source: AGHT+IHOhbEGYJ0Z2pCOv9JKJIqhnnyG451vqt7GOKovTB01jPY3MBaRzmr7TxVLh+jrRq2inBS7ic3VbfyVFAAQi1dCnj4wJGGm
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c797:b0:1bb:4593:ede7 with SMTP id
 dy23-20020a056870c79700b001bb4593ede7mr323807oab.11.1693434596449; Wed, 30
 Aug 2023 15:29:56 -0700 (PDT)
Date:   Wed, 30 Aug 2023 15:29:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092672f06042b7711@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_use_block_rsv
From:   syzbot <syzbot+10d5b62a8d7046b86d22@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3b35375f19fe Merge tag 'irq-urgent-2023-08-26' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1156791fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67db137b0441ab96
dashboard link: https://syzkaller.appspot.com/bug?extid=10d5b62a8d7046b86d22
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1767c1e0680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146903b0680000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-3b35375f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/34c4f640b690/vmlinux-3b35375f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/58c9c2459f41/bzImage-3b35375f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/501d7ead33fe/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10d5b62a8d7046b86d22@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5212 at fs/btrfs/block-rsv.c:515 btrfs_use_block_rsv+0x688/0x7f0 fs/btrfs/block-rsv.c:515
Modules linked in:
CPU: 1 PID: 5212 Comm: kworker/u17:1 Not tainted 6.5.0-rc7-syzkaller-00182-g3b35375f19fe #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: btrfs-endio-write btrfs_work_helper
RIP: 0010:btrfs_use_block_rsv+0x688/0x7f0 fs/btrfs/block-rsv.c:515
Code: 89 ea 83 e2 07 38 d0 7f 0c 84 c0 74 08 48 89 ef e8 ed 42 47 fe 0f b6 73 5a ba e4 ff ff ff 48 c7 c7 00 e4 b7 8a e8 b8 b8 ba fd <0f> 0b e9 a3 fd ff ff e8 8c f7 f3 fd 49 8d 9d 80 04 00 00 e9 1c fb
RSP: 0018:ffffc90003737030 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8880323ba608 RCX: 0000000000000000
RDX: ffff888029a1c4c0 RSI: ffffffff814be3c6 RDI: 0000000000000001
RBP: ffff8880323ba662 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000002d2d2d2d R12: 0000000000001000
R13: ffff88801fb84000 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88806b700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020d41000 CR3: 00000000219e2000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_alloc_tree_block+0x1dd/0x1420 fs/btrfs/extent-tree.c:4883
 __btrfs_cow_block+0x3ce/0x18e0 fs/btrfs/ctree.c:546
 btrfs_cow_block+0x2f1/0x820 fs/btrfs/ctree.c:712
 btrfs_search_slot+0x12a0/0x30e0 fs/btrfs/ctree.c:2194
 btrfs_lookup_file_extent+0xcb/0x110 fs/btrfs/file-item.c:270
 btrfs_drop_extents+0x433/0x2bd0 fs/btrfs/file.c:250
 insert_reserved_file_extent+0x3a8/0x940 fs/btrfs/inode.c:3057
 insert_ordered_extent_file_extent fs/btrfs/inode.c:3164 [inline]
 btrfs_finish_one_ordered+0x1443/0x2240 fs/btrfs/inode.c:3268
 btrfs_work_helper+0x20b/0xba0 fs/btrfs/async-thread.c:314
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


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
