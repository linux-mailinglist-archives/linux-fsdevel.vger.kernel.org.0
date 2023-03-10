Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F666B3798
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 08:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCJHmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 02:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjCJHmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:42:11 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B54810C72E
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 23:40:39 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id i14-20020a056e0212ce00b0031d17f33e9aso2189790ilm.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Mar 2023 23:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678434037;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nJfyPakHYE9kTDMLkuRc4t+DYY4gH0qdvBeHT8GXbQ=;
        b=1vI7pcrmR8AeeGXMNa1hLmifI3S6lGyu4dG6pf77A1qaKOP1YJ43KcT5xq7jP2D59l
         y1fQ+APYNL7/51qJi4cNblu6k1fhti+IX2GIgZj99y/pVLIOZyNApun67XLcfk5hjzqq
         exm/6dPIwYThV2OlzVcMviizRHvKFBGsItkqw4N1+OSW1BXQKKd2gxm1Za0Nurb0Q61f
         G7/jnAWx87Sl6f1nfzHalKZAagxtpnQfFPlmg/VMszn90TXTDNNWAH3fVc0iZtlWo+q9
         6vipqeZt2YeHq3Rr1TQI6A78oQS4OajxfhVS0U5z0z95kIwvdAomIfCRfDQijmEpgUYL
         h4Bg==
X-Gm-Message-State: AO0yUKXzsUYCD6TMCeeQC5UmG5wABEvuLUnK8JAh+3KxPVZLbPFdvI19
        fHVXv+Qfh5Jfh+D+7JBtQjBXyOhRzpamK1v71E+RXA2U4PZO
X-Google-Smtp-Source: AK7set+pa58mbWkG1BAHWu6B+XkE6aF23TCxl016pIwmQ6iljeAmoBRZGSlg1OU9l4B7qM7qMrqP1vlxPEq4brbfL+tGdkr9P2dE
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ca7:b0:316:fcbe:522d with SMTP id
 7-20020a056e020ca700b00316fcbe522dmr11001504ilg.4.1678434037601; Thu, 09 Mar
 2023 23:40:37 -0800 (PST)
Date:   Thu, 09 Mar 2023 23:40:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097201305f686e06a@google.com>
Subject: [syzbot] [ext4?] KMSAN: uninit-value in mb_find_extent
From:   syzbot <syzbot+b6451edec162751aba49@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, glider@google.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e919e2b1bc1c Revert "kmsan: disallow CONFIG_KMSAN with CON..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1199a6ea480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b63e082c4fda2e77
dashboard link: https://syzkaller.appspot.com/bug?extid=b6451edec162751aba49
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5676c9771994/disk-e919e2b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f53a1472ca4/vmlinux-e919e2b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eb021c0a44de/bzImage-e919e2b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6451edec162751aba49@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
---[ end trace 0000000000000000 ]---
=====================================================
BUG: KMSAN: uninit-value in mb_find_extent+0x1603/0x1640 fs/ext4/mballoc.c:1870
 mb_find_extent+0x1603/0x1640 fs/ext4/mballoc.c:1870
 ext4_mb_complex_scan_group+0x456/0x1760 fs/ext4/mballoc.c:2307
 ext4_mb_regular_allocator+0x2e60/0x5c30 fs/ext4/mballoc.c:2735
 ext4_mb_new_blocks+0x1708/0x2fe0 fs/ext4/mballoc.c:5605
 ext4_ext_map_blocks+0x2fb5/0x5a60 fs/ext4/extents.c:4286
 ext4_map_blocks+0x13ae/0x2d70 fs/ext4/inode.c:651
 ext4_getblk+0x228/0xd10 fs/ext4/inode.c:864
 ext4_bread+0x46/0x370 fs/ext4/inode.c:920
 ext4_quota_write+0x2f5/0x9c0 fs/ext4/super.c:7105
 write_blk fs/quota/quota_tree.c:64 [inline]
 get_free_dqblk+0x46e/0x910 fs/quota/quota_tree.c:130
 do_insert_tree+0x300/0x3190 fs/quota/quota_tree.c:340
 do_insert_tree+0xd42/0x3190 fs/quota/quota_tree.c:375
 do_insert_tree+0xd42/0x3190 fs/quota/quota_tree.c:375
 dq_insert_tree fs/quota/quota_tree.c:401 [inline]
 qtree_write_dquot+0x616/0x730 fs/quota/quota_tree.c:420
 v2_write_dquot+0x14e/0x220 fs/quota/quota_v2.c:358
 dquot_acquire+0x450/0x700 fs/quota/dquot.c:444
 ext4_acquire_dquot+0x44d/0x540 fs/ext4/super.c:6740
 dqget+0x12db/0x1a90 fs/quota/dquot.c:914
 __dquot_initialize+0x67a/0x1730 fs/quota/dquot.c:1492
 dquot_initialize+0x2e/0x40 fs/quota/dquot.c:1550
 ext4_process_orphan+0x56/0x4f0 fs/ext4/orphan.c:329
 ext4_orphan_cleanup+0x1160/0x1c60 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5516 [inline]
 ext4_fill_super+0xd0dc/0xd7f0 fs/ext4/super.c:5644
 get_tree_bdev+0x8a3/0xd30 fs/super.c:1282
 ext4_get_tree+0x30/0x40 fs/ext4/super.c:5675
 vfs_get_tree+0xa1/0x500 fs/super.c:1489
 do_new_mount+0x694/0x1580 fs/namespace.c:3145
 path_mount+0x71a/0x1eb0 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x734/0x840 fs/namespace.c:3674
 __ia32_sys_mount+0xdf/0x140 fs/namespace.c:3674
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Local variable ex created at:
 ext4_mb_complex_scan_group+0xa3/0x1760 fs/ext4/mballoc.c:2279
 ext4_mb_regular_allocator+0x2e60/0x5c30 fs/ext4/mballoc.c:2735

CPU: 1 PID: 6514 Comm: syz-executor.3 Tainted: G        W          6.2.0-rc3-syzkaller-79343-ge919e2b1bc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
