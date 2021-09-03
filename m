Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6C33FFB01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 09:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347769AbhICHUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 03:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhICHUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:20:43 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AE6C061575;
        Fri,  3 Sep 2021 00:19:44 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id n18so4701044pgm.12;
        Fri, 03 Sep 2021 00:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EtHM4v5k5O3KlwBMZhh8koyco/MnfcbrVJgA5dm1qn8=;
        b=F9PFlCkm33EtYjpX+K573ijdvJANomBO1wtE8R0RzBOXMHpLk3mRk9nbOt2hSmpNUw
         z8PJGz5mrdVrJRYQbnSWbRqAS8nVBYCBtl24Z0/kyBVb9ecFkYSnOBlawIqMYZNJY0B+
         QY7Wdr0Vz7W8S4fgKhtG1sSIFsNVI5c+gpJOl5uAkErHTDU87J1aL+1nc9iMtVjKPXN2
         PywU0bFjVO45nsHK84nG5KhqiXzFg2e1gi1YSlTAq+4thmdKQfpZCf2XB62g0MmzqTiU
         SVv74oc5oD86H5yVeWPlKvk6jNf2+PaIcA1TR1wdTQariXp3kh3GI6SmL/i5qV1KM/53
         70Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EtHM4v5k5O3KlwBMZhh8koyco/MnfcbrVJgA5dm1qn8=;
        b=rAF5yMikfZ6QpVrykClu/6WqDCAq2Ymxc/xbd/+LKxdFzMP9lXtE31WJ4v+QinA1o6
         6jVDkHM3hQNd8TEDc60dMAnLgPkWkiqARyRJbq/AgKBiJmu/zeT692xOytlG1exdqcdF
         ZdGBSP24vkF2qwN7NEUVyZcohJz64jgSzKgoAf6thxkLz196QbDEa/NOinFgSTL0bWLA
         4D2B72uAJ4XJhh0xK6vjJBT7bl2yE6/pLnUrd1yiw74RCZr2l69Zv1lVSsp4nBtedU28
         M/axY7CpeZlOXYxM3sBH+vWdIomQrWc3IOCEAWYj8weWexnEMMv4az22tbBJ0VVy8JUN
         Xk+w==
X-Gm-Message-State: AOAM5327Hqhh8Pxj0pxVXEwQFa6CW9cwXfH8QbecAF+ht59ulpq18dhb
        be7C3z2bOoa5hYqWV8HxE/TCY1RZFWm3hVoIOq453wMY/1x54Ok=
X-Google-Smtp-Source: ABdhPJwBJIRPqih+MTR2z3I0l3K1rAmRz8Kk/8qR523Uc9kTLyhPedhSny3S4QoRc9jylVwZZMyoeODiABxMMyX8r1s=
X-Received: by 2002:a63:3d4a:: with SMTP id k71mr2395401pga.276.1630653583232;
 Fri, 03 Sep 2021 00:19:43 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 3 Sep 2021 15:19:32 +0800
Message-ID: <CACkBjsZh7DCs+N+R=0+mnNqFZW8ck5cSgV4MpGM6ySbfenUJ+g@mail.gmail.com>
Subject: kernel BUG in block_invalidatepage
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 7d2a07b76933 Linux 5.14
git tree: upstream
console output:
https://drive.google.com/file/d/1Z-djyuwIRtlIKNHdLxoUnr8NqDu9zd9S/view?usp=sharing
kernel config: https://drive.google.com/file/d/1XD9WYDViQLSXN7RGwH8AGGDvP9JvOghx/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

------------[ cut here ]------------
kernel BUG at fs/buffer.c:1510!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8695 Comm: syz-executor Not tainted 5.14.0 #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:block_invalidatepage+0x54d/0x660 fs/buffer.c:1510
Code: ff ff e8 c6 aa 9d ff b9 02 00 00 00 be 02 00 00 00 48 89 ef 48
c7 c2 c0 5e 20 89 e8 7d 0e 49 07 e9 29 fe ff ff e8 a3 aa 9d ff <0f> 0b
e8 9c aa 9d ff 0f 0b e8 95 aa 9d ff 48 83 eb 01 e9 83 fb ff
RSP: 0018:ffffc90000a376f8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88810dd8b980
RDX: 0000000000000000 RSI: ffff88810dd8b980 RDI: 0000000000000002
RBP: 0000000000000000 R08: ffffffff81d74ddd R09: 0000000000001000
R10: 0000000000000005 R11: fffff940000b0000 R12: ffffea0000580000
R13: 0000000000000000 R14: 0000000000200000 R15: 0000000000200000
FS:  0000000000000000(0000) GS:ffff888119f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcb1d285b7 CR3: 0000000104f5d005 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 do_invalidatepage mm/truncate.c:157 [inline]
 truncate_cleanup_page+0x3e4/0x620 mm/truncate.c:176
 truncate_inode_pages_range+0x26c/0x1960 mm/truncate.c:325
 kill_bdev.isra.0+0x5f/0x80 fs/block_dev.c:86
 blkdev_flush_mapping+0xdf/0x2e0 fs/block_dev.c:1243
 blkdev_put_whole+0xe8/0x110 fs/block_dev.c:1277
 blkdev_put+0x268/0x720 fs/block_dev.c:1576
 blkdev_close+0x8c/0xb0 fs/block_dev.c:1586
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xe0/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xbe4/0x2e00 kernel/exit.c:825
 do_group_exit+0x125/0x340 kernel/exit.c:922
 get_signal+0x4d5/0x25a0 kernel/signal.c:2808
 arch_do_signal_or_restart+0x2ed/0x1c40 arch/x86/kernel/signal.c:865
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x192/0x2a0 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
Code: Unable to access opcode bytes at RIP 0x4739a3.
RSP: 002b:00007f6c0fac6218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000059c0a0 RCX: 00000000004739cd
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000059c0a8
RBP: 000000000059c0a8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c0ac
R13: 00007ffcdd11bbff R14: 00007ffcdd11bda0 R15: 00007f6c0fac6300
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 4d1faf5c7a1da2c5 ]---
RIP: 0010:block_invalidatepage+0x54d/0x660 fs/buffer.c:1510
Code: ff ff e8 c6 aa 9d ff b9 02 00 00 00 be 02 00 00 00 48 89 ef 48
c7 c2 c0 5e 20 89 e8 7d 0e 49 07 e9 29 fe ff ff e8 a3 aa 9d ff <0f> 0b
e8 9c aa 9d ff 0f 0b e8 95 aa 9d ff 48 83 eb 01 e9 83 fb ff
RSP: 0018:ffffc90000a376f8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88810dd8b980
RDX: 0000000000000000 RSI: ffff88810dd8b980 RDI: 0000000000000002
RBP: 0000000000000000 R08: ffffffff81d74ddd R09: 0000000000001000
R10: 0000000000000005 R11: fffff940000b0000 R12: ffffea0000580000
R13: 0000000000000000 R14: 0000000000200000 R15: 0000000000200000
FS:  0000000000000000(0000) GS:ffff888119f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6945606000 CR3: 000000010abb2004 CR4: 0000000000770ee0
PKRU: 55555554
