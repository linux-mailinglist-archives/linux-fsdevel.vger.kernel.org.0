Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1542E6EB8D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Apr 2023 13:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjDVLh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Apr 2023 07:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDVLh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Apr 2023 07:37:56 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69071BFF
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Apr 2023 04:37:54 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-763646b324aso484945339f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Apr 2023 04:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682163474; x=1684755474;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uH30ZUeK2Ah27FB5OM46e7dnNRwvE0TOAvtBMEB9588=;
        b=fTZKdjhnCCWuV53JZrulheG7InS5Ohk67KBbS3QLadImaK29dvaOfYXugroIV6gPLS
         PpfvNskMMu2v/dSrkfHgHTjDuB2KRW3zufIj3CmK7qZ0a0AlYAX6aZ30VGqEl39Ugpet
         0AEJaR5vQZYfSHAvmVfVUyX5kMOxEWPuhCCLFBH/8bXSBJvv3gj+dmYNZyDcog2cI3wI
         onteLX3yXZKMoQV/c2a3iWghC0VFq7++3jb4nzvC5AZdpkQlqpKZOoYUMlncJUSUMKm6
         YDPks9um75G68QWw3xrrQUPDD7KsSvWVBy7VBL5dV0X8JZcWLuPv+1jwMFU2AqJWB5eU
         6hzw==
X-Gm-Message-State: AAQBX9f41JxEtidNiveOb310q9JRsziLcbncy3A+k2P+Ln6hrMBPotI2
        N2QSiordBDjslWxGhQkcbtbKwDuYcOCMDhS9peMfmkX53IuB
X-Google-Smtp-Source: AKy350ZzTnGild/+xCP5LBSEXqgjNrjO0MzeVrH+1jo+BlFwCKPx+O39uUyhgToQBQ5Criq3DDdtfcUmP6+Dw9QLubXCjpgpDDKR
MIME-Version: 1.0
X-Received: by 2002:a02:95c2:0:b0:411:a1e8:2916 with SMTP id
 b60-20020a0295c2000000b00411a1e82916mr1182999jai.4.1682163474058; Sat, 22 Apr
 2023 04:37:54 -0700 (PDT)
Date:   Sat, 22 Apr 2023 04:37:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053541905f9eb3439@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in add_new_free_space
From:   syzbot <syzbot+3ba856e07b7127889d8c@syzkaller.appspotmail.com>
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

HEAD commit:    327bf9bb94cf Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1543949fc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64943844c9bf6c7e
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba856e07b7127889d8c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/66410afe54f5/disk-327bf9bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2757ce5e2a55/vmlinux-327bf9bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d54ee97c182/Image-327bf9bb.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ba856e07b7127889d8c@syzkaller.appspotmail.com

 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
------------[ cut here ]------------
kernel BUG at fs/btrfs/block-group.c:537!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 12290 Comm: syz-executor.4 Not tainted 6.3.0-rc7-syzkaller-g327bf9bb94cf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : add_new_free_space+0x290/0x294 fs/btrfs/block-group.c:537
lr : add_new_free_space+0x290/0x294 fs/btrfs/block-group.c:537
sp : ffff80001e816d00
x29: ffff80001e816da0 x28: 1ffff00003d02dac x27: dfff800000000000
x26: 0000000000000001 x25: ffff0000d9f7c190 x24: ffff80001e816d60
x23: 0000000003d00000 x22: ffff80001e816d40 x21: 0000000000000000
x20: 0000000001000000 x19: 00000000fffffff4 x18: 1fffe000368519b6
x17: 0000000000000000 x16: ffff8000123165a4 x15: 0000000000000001
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000001
x11: 0000000000040000 x10: 0000000000013b46 x9 : ffff80002505a000
x8 : 0000000000013b47 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80001e816258 x4 : ffff800015d5c8c0 x3 : ffff80000acba3f8
x2 : 0000000000000001 x1 : 00000000fffffff4 x0 : 0000000000000000
Call trace:
 add_new_free_space+0x290/0x294 fs/btrfs/block-group.c:537
 btrfs_make_block_group+0x34c/0x87c fs/btrfs/block-group.c:2712
 create_chunk fs/btrfs/volumes.c:5441 [inline]
 btrfs_create_chunk+0x142c/0x1ea4 fs/btrfs/volumes.c:5527
 do_chunk_alloc fs/btrfs/block-group.c:3710 [inline]
 btrfs_chunk_alloc+0x69c/0xf00 fs/btrfs/block-group.c:4004
 find_free_extent_update_loop fs/btrfs/extent-tree.c:4024 [inline]
 find_free_extent+0x43bc/0x5334 fs/btrfs/extent-tree.c:4407
 btrfs_reserve_extent+0x35c/0x674 fs/btrfs/extent-tree.c:4500
 __btrfs_prealloc_file_range+0x2a8/0x1000 fs/btrfs/inode.c:9594
 btrfs_prealloc_file_range+0x60/0x7c fs/btrfs/inode.c:9688
 btrfs_fallocate+0x1644/0x19e4 fs/btrfs/file.c:3177
 vfs_fallocate+0x478/0x5b4 fs/open.c:324
 ksys_fallocate fs/open.c:347 [inline]
 __do_sys_fallocate fs/open.c:355 [inline]
 __se_sys_fallocate fs/open.c:353 [inline]
 __arm64_sys_fallocate+0xc0/0x110 fs/open.c:353
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: 9570392d 9787d9fb d4210000 9787d9f9 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
