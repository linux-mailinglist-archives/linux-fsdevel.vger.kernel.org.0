Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B34A6BF39D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 22:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCQVMf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 17:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCQVMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:12:34 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FF34D282
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 14:12:30 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id h1-20020a92d841000000b0031b4d3294dfso3037427ilq.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 14:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679087549;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eUVOzUS5o3ynrBgooZBRstZBkugFAkgwbSHpaw7MSs=;
        b=ONZbS9OtXqocts4EGwBS++3OvoKFgVL4n7sNVdPKX1ffIUqfZpCBjnNr47+B9fHlMn
         PCBRFaoBr9+C/7pJWMhhVpJ4Tv3jH9EapRzD3juXs4k3ilsFco2JNZN1mp1c0cBJgBLE
         78D0EqhQySQtIJxHzA5VWsAhvUKL7+It/MIDTvqazk+d7mxMM6oE/zWomSakAlofjc9X
         93pwbyZ3421kwZPU836wZzaU7SHw9K/2oqdo9G66vPUduKJvfGOumAb6V2nqcrv679p/
         qegZp6oRtFXyVdNDCfuA1tChoKyUo2Dj+CfUeuf76cJQRynf07LAlzshjOTkl+ogsT+M
         Ia7Q==
X-Gm-Message-State: AO0yUKXq8sxBou5TZJoL8q+r/pqFLYMhVtbw8KjKiTUrax/AgsioPCF8
        OMdN0u0YyJV74z4RT5fMGQobfDkMD2ylDqoWUXmaPbqFl/EA
X-Google-Smtp-Source: AK7set8mHQCT0vXcX2Qn2Djz/3mgNnT1D+UxvaaiYG2ygiebSAbUtsMJ5s9FL/UJu1E6NbnVjQ9dIPdC2V3lnw147cBKzi4nr1BU
MIME-Version: 1.0
X-Received: by 2002:a5e:c809:0:b0:752:a213:257a with SMTP id
 y9-20020a5ec809000000b00752a213257amr23959iol.3.1679087549803; Fri, 17 Mar
 2023 14:12:29 -0700 (PDT)
Date:   Fri, 17 Mar 2023 14:12:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3f2f305f71f0879@google.com>
Subject: [syzbot] [ext4?] WARNING: bad unlock balance in ext4_xattr_get
From:   syzbot <syzbot+ebaf26199c734bd9931d@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

HEAD commit:    2e84eedb182e Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1665c5e5480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8cf742d9a45bfb6
dashboard link: https://syzkaller.appspot.com/bug?extid=ebaf26199c734bd9931d
compiler:       Debian clang version 13.0.1-6~deb11u1, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/acdd02708d19/disk-2e84eedb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0929da006e5e/vmlinux-2e84eedb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/728c7b1a181a/Image-2e84eedb.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebaf26199c734bd9931d@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
6.2.0-rc5-syzkaller-17291-g2e84eedb182e #0 Not tainted
-------------------------------------
syz-executor.1/23387 is trying to release lock (��) at:
[<ffff800008874a1c>] ext4_xattr_get+0x2fc/0x418 fs/ext4/xattr.c:686
but there are no more locks to release!

other info that might help us debug this:
no locks held by syz-executor.1/23387.

stack backtrace:
CPU: 0 PID: 23387 Comm: syz-executor.1 Not tainted 6.2.0-rc5-syzkaller-17291-g2e84eedb182e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_unlock_imbalance_bug+0x198/0x1a0 kernel/locking/lockdep.c:5108
 lock_release+0x1f8/0x2b4 kernel/locking/lockdep.c:5688
 up_read+0x30/0x48 kernel/locking/rwsem.c:1604
 ext4_xattr_get+0x2fc/0x418 fs/ext4/xattr.c:686
 ext4_xattr_trusted_get+0x40/0x54 fs/ext4/xattr_trusted.c:27
 __vfs_getxattr+0x258/0x268 fs/xattr.c:425
 vfs_getxattr+0x1c0/0x208 fs/xattr.c:458
 do_getxattr+0xf4/0x2bc fs/xattr.c:717
 getxattr+0xdc/0x12c fs/xattr.c:751
 path_getxattr+0xa0/0x14c fs/xattr.c:767
 __do_sys_getxattr fs/xattr.c:779 [inline]
 __se_sys_getxattr fs/xattr.c:776 [inline]
 __arm64_sys_getxattr+0x28/0x38 fs/xattr.c:776
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x104 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x100, magic = 0xffff0001191985c8, owner = 0xffff0000c5881a01, curr 0xffff0000c5881a00, list not empty
WARNING: CPU: 1 PID: 23387 at kernel/locking/rwsem.c:1335 __up_read+0x198/0x2ac kernel/locking/rwsem.c:1335
Modules linked in:
CPU: 1 PID: 23387 Comm: syz-executor.1 Not tainted 6.2.0-rc5-syzkaller-17291-g2e84eedb182e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __up_read+0x198/0x2ac kernel/locking/rwsem.c:1335
lr : __up_read+0x198/0x2ac kernel/locking/rwsem.c:1335
sp : ffff800014fcb9e0
x29: ffff800014fcb9e0 x28: ffff80000d6c32f8 x27: ffff00011a409b00
x26: 00000000ffffffc3 x25: 0000000000000004 x24: ffff800014fcbc30
x23: 00000000000000ee x22: ffff0001191987b8 x21: ffff80000d52c000
x20: ffff0001191985c8 x19: ffff000119198560 x18: 000000000000011a
x17: ffff80000c16e8bc x16: 0000000000000002 x15: 0000000000000000
x14: 0000000040000002 x13: 0000000000000002 x12: 0000000000040000
x11: 000000000000e9c1 x10: ffff8000188fd000 x9 : eaec873b24b4e100
x8 : eaec873b24b4e100 x7 : 0000000000000000 x6 : ffff80000816ead8
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefdef08 x1 : 0000000100000000 x0 : 0000000000000097
Call trace:
 __up_read+0x198/0x2ac kernel/locking/rwsem.c:1335
 up_read+0x38/0x48 kernel/locking/rwsem.c:1605
 ext4_xattr_get+0x2fc/0x418 fs/ext4/xattr.c:686
 ext4_xattr_trusted_get+0x40/0x54 fs/ext4/xattr_trusted.c:27
 __vfs_getxattr+0x258/0x268 fs/xattr.c:425
 vfs_getxattr+0x1c0/0x208 fs/xattr.c:458
 do_getxattr+0xf4/0x2bc fs/xattr.c:717
 getxattr+0xdc/0x12c fs/xattr.c:751
 path_getxattr+0xa0/0x14c fs/xattr.c:767
 __do_sys_getxattr fs/xattr.c:779 [inline]
 __se_sys_getxattr fs/xattr.c:776 [inline]
 __arm64_sys_getxattr+0x28/0x38 fs/xattr.c:776
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x104 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 6175
hardirqs last  enabled at (6175): [<ffff80000c120a38>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (6175): [<ffff80000c120a38>] exit_to_kernel_mode+0xe8/0x118 arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (6174): [<ffff80000c12a184>] preempt_schedule_irq+0x80/0x110 kernel/sched/core.c:6919
softirqs last  enabled at (6120): [<ffff80000801c9f4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (6118): [<ffff80000801c9c0>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
