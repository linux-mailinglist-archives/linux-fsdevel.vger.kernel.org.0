Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39175A2626
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 12:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbiHZKub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 06:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343976AbiHZKu3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:50:29 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264721A805
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 03:50:27 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id k22-20020a6bf716000000b0068898c0b395so712630iog.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 03:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=rxQJxaSLkQ64Mai5Sl4u4N0dOQewg9vmDMRgI+WaoW0=;
        b=Q+GQ1FcAAGiRZ/93gzdecmt+hhQRvOZvW4khdQV+Vd+R2p2xR4IETw49Z2V8zkWPND
         +O2ZA/ANeysKuoyF3vLICU7HsAfVHy8lZ3a+N+wN7xpKa19ICfRpE05gQ26ja7MNrTAI
         svCEJxrWfKQ3PdLo8XuyinKxiNGCXWDk7JejHq5Y2Fyd3izmtYHCT9vSWIql27lw97hr
         zdyZLBp6XsoKmW32IEXFIvcv5Q/Kbu2jXH1NsBMeP5PSnDCn/G7y2GfFjg7ZHLRdjabU
         5MhX4SyAd+xe6Jmwn/n4iExPHUYUD0R0VZX9p/n20X6mkpxgpKkvjsvelkcz1cw2unNQ
         35Hw==
X-Gm-Message-State: ACgBeo12q2xFYf3+2aORTkn+aBAqQLjbCIt7rmz7oXrCZY3ahcls1PJL
        Ex9O/Fi2Psj2em5q3yAJPUg658/6nKhMhbx2swAD3Ls26kb0
X-Google-Smtp-Source: AA6agR4r3KTg+bRWozquu8bzK1RTlabr6YyZ/o9noxzw3G49l/uY9Xv1MEbfySE2rITRkpIuR5IA5yGKTpPntO9JejHMuQONR47E
MIME-Version: 1.0
X-Received: by 2002:a05:6638:371f:b0:349:cfb0:89a9 with SMTP id
 k31-20020a056638371f00b00349cfb089a9mr3765261jav.151.1661511026488; Fri, 26
 Aug 2022 03:50:26 -0700 (PDT)
Date:   Fri, 26 Aug 2022 03:50:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000863a7305e722aeeb@google.com>
Subject: [syzbot] BUG: Dentry still in use in unmount
From:   syzbot <syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a41a877bc12d Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13901aad080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
dashboard link: https://syzkaller.appspot.com/bug?extid=8608bb4553edb8c78f41
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d75e95080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15440857080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com

BUG: Dentry 00000000133f9b6b{i=0,n=.reiserfs_priv}  still in use (1) [unmount of squashfs loop0]
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3045 at fs/dcache.c:1676 umount_check+0xc0/0xc8 fs/dcache.c:1667
Modules linked in:
CPU: 1 PID: 3045 Comm: syz-executor425 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : umount_check+0xc0/0xc8 fs/dcache.c:1667
lr : umount_check+0xc0/0xc8 fs/dcache.c:1667
sp : ffff800012ac3bc0
x29: ffff800012ac3bc0 x28: ffff0000c7bb05f8 x27: ffff80000d4e1e20
x26: ffff0000c7bb04e0 x25: 0000000000000001 x24: ffff0000c7bb05f8
x23: ffff0000c7bb0090 x22: ffff0000c7b9d138 x21: ffff8000085edd40
x20: 0000000000000000 x19: ffff0000c7bb0000 x18: 00000000000000c0
x17: 657375206e69206c x16: ffff80000dbb8658 x15: ffff0000c378cf80
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c378cf80
x11: ff808000081c39dc x10: 0000000000000000 x9 : 3f5cf90385ca4900
x8 : 3f5cf90385ca4900 x7 : ffff800008197c8c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcd0 x1 : 0000000100000002 x0 : 0000000000000060
Call trace:
 umount_check+0xc0/0xc8 fs/dcache.c:1667
 d_walk+0x13c/0x55c fs/dcache.c:1386
 do_one_tree fs/dcache.c:1683 [inline]
 shrink_dcache_for_umount+0x60/0x140 fs/dcache.c:1699
 generic_shutdown_super+0x30/0x190 fs/super.c:473
 kill_block_super+0x30/0x78 fs/super.c:1427
 deactivate_locked_super+0x70/0xd4 fs/super.c:332
 deactivate_super+0xb8/0xbc fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x208 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1d0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:625
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 168478
hardirqs last  enabled at (168477): [<ffff8000081c1c48>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:264
hardirqs last disabled at (168478): [<ffff80000bffe9cc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (168132): [<ffff80000801c1f4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (168130): [<ffff80000801c1c0>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
BUG: Dentry 00000000133f9b6b{i=0,n=.reiserfs_priv}  still in use (1) [unmount of squashfs loop0]
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3045 at fs/dcache.c:1676 umount_check+0xc0/0xc8 fs/dcache.c:1667
Modules linked in:
CPU: 1 PID: 3045 Comm: syz-executor425 Tainted: G        W          6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : umount_check+0xc0/0xc8 fs/dcache.c:1667
lr : umount_check+0xc0/0xc8 fs/dcache.c:1667
sp : ffff800012ac3bc0
x29: ffff800012ac3bc0 x28: ffff0000c7bb05f8 x27: ffff80000d4e1e20
x26: ffff0000c7bb04e0 x25: 0000000000000001 x24: ffff0000c7bb05f8
x23: ffff0000c7bb0090 x22: ffff0000c7b9d138 x21: ffff8000085edd40
x20: 0000000000000000 x19: ffff0000c7bb0000 x18: 00000000000000c0
x17: 657375206e69206c x16: ffff80000dbb8658 x15: ffff0000c378cf80
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c378cf80
x11: ff808000081c39dc x10: 0000000000000000 x9 : 3f5cf90385ca4900
x8 : 3f5cf90385ca4900 x7 : ffff800008197c8c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcd0 x1 : 0000000100000003 x0 : 0000000000000060
Call trace:
 umount_check+0xc0/0xc8 fs/dcache.c:1667
 d_walk+0x13c/0x55c fs/dcache.c:1386
 do_one_tree fs/dcache.c:1683 [inline]
 shrink_dcache_for_umount+0x60/0x140 fs/dcache.c:1699
 generic_shutdown_super+0x30/0x190 fs/super.c:473
 kill_block_super+0x30/0x78 fs/super.c:1427
 deactivate_locked_super+0x70/0xd4 fs/super.c:332
 deactivate_super+0xb8/0xbc fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x208 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1d0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:625
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 168928
hardirqs last  enabled at (168927): [<ffff8000081c1c48>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:264
hardirqs last disabled at (168928): [<ffff80000bffe9cc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (168922): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (168635): [<ffff800008104658>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (168635): [<ffff800008104658>] invoke_softirq+0x70/0xbc kernel/softirq.c:452
---[ end trace 0000000000000000 ]---
VFS: Busy inodes after unmount of loop0. Self-destruct in 5 seconds.  Have a nice day...
BUG: Dentry 000000005431b8af{i=0,n=.reiserfs_priv}  still in use (1) [unmount of squashfs loop0]
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3045 at fs/dcache.c:1676 umount_check+0xc0/0xc8 fs/dcache.c:1667
Modules linked in:
CPU: 0 PID: 3045 Comm: syz-executor425 Tainted: G        W          6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : umount_check+0xc0/0xc8 fs/dcache.c:1667
lr : umount_check+0xc0/0xc8 fs/dcache.c:1667
sp : ffff800012ac3bc0
x29: ffff800012ac3bc0 x28: ffff0000c7b98250 x27: ffff80000d4e1e20
x26: ffff0000c7b98138 x25: 0000000000000001 x24: ffff0000c7b98250
x23: ffff0000cc849570 x22: ffff0000cc99d750 x21: ffff8000085edd40
x20: 0000000000000000 x19: ffff0000cc8494e0 x18: 0000000000000350
x17: 657375206e69206c x16: ffff80000dbb8658 x15: ffff0000c378cf80
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c378cf80
x11: ff808000081c39dc x10: 0000000000000000 x9 : 3f5cf90385ca4900
x8 : 3f5cf90385ca4900 x7 : ffff800008197c8c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbecd0 x1 : 0000000100000002 x0 : 0000000000000060
Call trace:
 umount_check+0xc0/0xc8 fs/dcache.c:1667
 d_walk+0x13c/0x55c fs/dcache.c:1386
 do_one_tree fs/dcache.c:1683 [inline]
 shrink_dcache_for_umount+0x60/0x140 fs/dcache.c:1699
 generic_shutdown_super+0x30/0x190 fs/super.c:473
 kill_block_super+0x30/0x78 fs/super.c:1427
 deactivate_locked_super+0x70/0xd4 fs/super.c:332
 deactivate_super+0xb8/0xbc fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x208 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1d0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:625
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 257288
hardirqs last  enabled at (257287): [<ffff8000081c1c48>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:264
hardirqs last disabled at (257288): [<ffff80000bffe9cc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (256910): [<ffff80000801c1f4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (256908): [<ffff80000801c1c0>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
VFS: Busy inodes after unmount of loop0. Self-destruct in 5 seconds.  Have a nice day...
BUG: Dentry 000000005431b8af{i=0,n=.reiserfs_priv}  still in use (1) [unmount of squashfs loop0]
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3045 at fs/dcache.c:1676 umount_check+0xc0/0xc8 fs/dcache.c:1667
Modules linked in:
CPU: 1 PID: 3045 Comm: syz-executor425 Tainted: G        W          6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : umount_check+0xc0/0xc8 fs/dcache.c:1667
lr : umount_check+0xc0/0xc8 fs/dcache.c:1667
sp : ffff800012ac3bc0
x29: ffff800012ac3bc0 x28: ffff0000c7b98250 x27: ffff80000d4e1e20
x26: ffff0000c7b98138 x25: 0000000000000001 x24: ffff0000c7b98250
x23: ffff0000cc849570 x22: ffff0000cc88d138 x21: ffff8000085edd40
x20: 0000000000000000 x19: ffff0000cc8494e0 x18: 00000000000002ea
x17: 657375206e69206c x16: ffff80000dbb8658 x15: ffff0000c378cf80
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c378cf80
x11: ff808000081c39dc x10: 0000000000000000 x9 : 3f5cf90385ca4900
x8 : 3f5cf90385ca4900 x7 : ffff800008197c8c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcd0 x1 : 0000000100000002 x0 : 0000000000000060
Call trace:
 umount_check+0xc0/0xc8 fs/dcache.c:1667
 d_walk+0x13c/0x55c fs/dcache.c:1386
 do_one_tree fs/dcache.c:1683 [inline]
 shrink_dcache_for_umount+0x60/0x140 fs/dcache.c:1699
 generic_shutdown_super+0x30/0x190 fs/super.c:473
 kill_block_super+0x30/0x78 fs/super.c:1427
 deactivate_locked_super+0x70/0xd4 fs/super.c:332
 deactivate_super+0xb8/0xbc fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x208 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1d0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:625
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 283828
hardirqs last  enabled at (283827): [<ffff8000081c1c48>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:264
hardirqs last disabled at (283828): [<ffff80000bffe9cc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (283438): [<ffff80000801c1f4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (283436): [<ffff80000801c1c0>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
VFS: Busy inodes after unmount of loop0. Self-destruct in 5 seconds.  Have a nice day...
BUG: Dentry 000000005431b8af{i=0,n=.reiserfs_priv}  still in use (1) [unmount of squashfs loop0]
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3045 at fs/dcache.c:1676 umount_check+0xc0/0xc8 fs/dcache.c:1667
Modules linked in:
CPU: 1 PID: 3045 Comm: syz-executor425 Tainted: G        W          6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : umount_check+0xc0/0xc8 fs/dcache.c:1667
lr : umount_check+0xc0/0xc8 fs/dcache.c:1667
sp : ffff800012ac3bc0
x29: ffff800012ac3bc0 x28: ffff0000c7b98250 x27: ffff80000d4e1e20
x26: ffff0000c7b98138 x25: 0000000000000001 x24: ffff0000c7b98250
x23: ffff0000cc849570 x22: ffff0000cc88dc30 x21: ffff8000085edd40
x20: 0000000000000000 x19: ffff0000cc8494e0 x18: 0000000000000109
x17: 657375206e69206c x16: ffff80000dbb8658 x15: ffff0000c378cf80
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c378cf80
x11: ff808000081c39dc x10: 0000000000000000 x9 : 3f5cf90385ca4900
x8 : 3f5cf90385ca4900 x7 : ffff800008197c8c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcd0 x1 : 0000000000000002 x0 : 0000000000000060
Call trace:
 umount_check+0xc0/0xc8 fs/dcache.c:1667
 d_walk+0x13c/0x55c fs/dcache.c:1386
 do_one_tree fs/dcache.c:1683 [inline]
 shrink_dcache_for_umount+0x60/0x140 fs/dcache.c:1699
 generic_shutdown_super+0x30/0x190 fs/super.c:473
 kill_block_super+0x30/0x78 fs/super.c:1427
 deactivate_locked_super+0x70/0xd4 fs/super.c:332
 deactivate_super+0xb8/0xbc fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x208 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1d0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:625
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 335826
hardirqs last  enabled at (335825): [<ffff8000081c1c48>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:264
hardirqs last disabled at (335826): [<ffff80000bffe9cc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (335820): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (335803): [<ffff800008104658>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (335803): [<ffff800008104658>] invoke_softirq+0x70/0xbc kernel/softirq.c:452
---[ end trace 0000000000000000 ]---
VFS: Busy inodes after unmount of loop0. Self-destruct in 5 seconds.  Have a nice day...
 loop0: unable to read partition table
loop0: partition table beyond EOD, truncated
BUG: Dentry 00000000cd442007{i=0,n=.reiserfs_priv}  still in use (1) [unmount of squashfs loop0]
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3045 at fs/dcache.c:1676 umount_check+0xc0/0xc8 fs/dcache.c:1667
Modules linked in:
CPU: 1 PID: 3045 Comm: syz-executor425 Tainted: G        W          6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : umount_check+0xc0/0xc8 fs/dcache.c:1667
lr : umount_check+0xc0/0xc8 fs/dcache.c:1667
sp : ffff800012ac3bc0
x29: ffff800012ac3bc0 x28: ffff0000cc88d5f8 x27: ffff80000d4e1e20
x26: ffff0000cc88d4e0 x25: 0000000000000001 x24: ffff0000cc88d5f8
x23: ffff0000cc88d438 x22: ffff0000ca0579c0 x21: ffff8000085edd40
x20: 0000000000000000 x19: ffff0000cc88d3a8 x18: 000000000000009d
x17: 657375206e69206c x16: ffff80000dbb8658 x15: ffff0000c378cf80
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c378cf80
x11: ff808000081c39dc x10: 0000000000000000 x9 : 3f5cf90385ca4900
x8 : 3f5cf90385ca4900 x7 : ffff800008197c8c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcd0 x1 : 0000000100000002 x0 : 0000000000000060
Call trace:
 umount_check+0xc0/0xc8 fs/dcache.c:1667
 d_walk+0x13c/0x55c fs/dcache.c:1386
 do_one_tree fs/dcache.c:1683 [inline]
 shrink_dcache_for_umount+0x60/0x140 fs/dcache.c:1699
 generic_shutdown_super+0x30/0x190 fs/super.c:473
 kill_block_super+0x30/0x78 fs/super.c:1427
 deactivate_locked_super+0x70/0xd4 fs/super.c:332
 deactivate_super+0xb8/0xbc fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x208 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1d0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:625
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 366714
hardirqs last  enabled at (366713): [<ffff8000081c1c48>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:264
hardirqs last disabled at (366714): [<ffff80000bffe9cc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (366346): [<ffff80000801c1f4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (366344): [<ffff80000801c1c0>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
VFS: Busy inodes after unmount of loop0. Self-destruct in 5 seconds.  Have a nice day...
 loop0: unable to read partition table
loop0: partition table beyond EOD, truncated


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
