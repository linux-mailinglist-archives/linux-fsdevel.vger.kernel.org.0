Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C975F5AA093
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 22:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiIAUA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 16:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiIAUA5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:00:57 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D8589CDD
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 13:00:55 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id b9-20020a92c569000000b002eb7fbf5ca1so25073ilj.20
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Sep 2022 13:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ENMvGocuUaeIJ7qPvFSun2TU6viauprGMRi4DnkhQXg=;
        b=3ni+xey39TVr56Z1PlYbYgJRtIJu+XUAlL69IjapZYrTRqpJfaV2YiLX4dT+YN1hPC
         cqewjlvxWz6+zCeMo+8md44XE7fwLjTeRkNH/Y6PVEv73xH45Y2kNh4R2CsiOOxCKYwl
         YOIi6Q8Ni/FgtqSAHQFg8gmn/qk72zDsmNqkVTQN2G04TQpmNElPZPOjlM8ecTqBn8OP
         chsOzpfw37zBxQeogp4oKABWzGmD+uOs1jZ+cHdXsAvn3ZEaN+A3hljV1ML8wHb26jaS
         1QUiLHXQ/bB+LrUp4GXnYTqY9PuVC7dnbkFiiNcEYcuf2AmSqxCdDyN+H+vO5GKjoSuW
         nwvQ==
X-Gm-Message-State: ACgBeo2hh4NDqyFeHe0555QPYGjyxdkr6fc2m+S5OwJfFveDGNwRxq2d
        UJ9PSjNYGXwbLy0eRQYZW3ZxYlwPdgeiPsSZqL+nq0onIp4R
X-Google-Smtp-Source: AA6agR7B7rN6SdH1mPU70qD/dSbgZUNL+1a1kETVdqyEqnY4LqP3OKaV/B6eTzLgxXnfFQv8kfTbyuj4oFvWdOD9t5TMMBKC/8Fq
MIME-Version: 1.0
X-Received: by 2002:a92:3652:0:b0:2df:4133:787 with SMTP id
 d18-20020a923652000000b002df41330787mr17285204ilf.39.1662062455203; Thu, 01
 Sep 2022 13:00:55 -0700 (PDT)
Date:   Thu, 01 Sep 2022 13:00:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003caf5b05e7a312d1@google.com>
Subject: [syzbot] WARNING: locking bug in iput
From:   syzbot <syzbot+fa40f8c8c3594994616d@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=110469db080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
dashboard link: https://syzkaller.appspot.com/bug?extid=fa40f8c8c3594994616d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13cd2133080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa40f8c8c3594994616d@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 9444 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4727 [inline]
WARNING: CPU: 0 PID: 9444 at kernel/locking/lockdep.c:231 __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
Modules linked in:
CPU: 0 PID: 9444 Comm: syz-executor.2 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
pc : __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
lr : hlock_class kernel/locking/lockdep.c:231 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
sp : ffff8000144b38c0
x29: ffff8000144b39a0 x28: 0000000000000001 x27: ffff0000d1919aa8
x26: ffff0000d08cc117 x25: ffff0000d191a4d8 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000000 x19: ffff56001244ac6e x18: 0000000000000229
x17: 0000000000000000 x16: ffff80000dbb8658 x15: ffff0000d1919a80
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d65f960
x11: ff808000081c39dc x10: ffff80000dd7a698 x9 : 767cda847edbb600
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff800008197c8c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000016
Call trace:
 check_wait_context kernel/locking/lockdep.c:4727 [inline]
 __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 _atomic_dec_and_lock+0xb0/0x104 lib/dec_and_lock.c:28
 iput+0x50/0x314 fs/inode.c:1766
 ntfs_fill_super+0x1254/0x14a4 fs/ntfs/super.c:188
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 6629
hardirqs last  enabled at (6629): [<ffff800008163d78>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
hardirqs last  enabled at (6629): [<ffff800008163d78>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
hardirqs last disabled at (6628): [<ffff80000c009400>] __schedule+0x84/0x570 kernel/sched/core.c:6393
softirqs last  enabled at (6146): [<ffff800008434d94>] spin_unlock_bh include/linux/spinlock.h:394 [inline]
softirqs last  enabled at (6146): [<ffff800008434d94>] wb_wakeup_delayed+0x80/0x94 mm/backing-dev.c:266
softirqs last disabled at (6142): [<ffff800008434d54>] spin_lock_bh include/linux/spinlock.h:354 [inline]
softirqs last disabled at (6142): [<ffff800008434d54>] wb_wakeup_delayed+0x40/0x94 mm/backing-dev.c:263
---[ end trace 0000000000000000 ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000000000000b8
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010c587000
[00000000000000b8] pgd=0800000112734003, p4d=0800000112734003, pud=08000001126ae003, pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 9444 Comm: syz-executor.2 Tainted: G        W          6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
pc : __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
lr : hlock_class kernel/locking/lockdep.c:231 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
sp : ffff8000144b38c0
x29: ffff8000144b39a0 x28: 0000000000000001 x27: ffff0000d1919aa8
x26: ffff0000d08cc117 x25: ffff0000d191a4d8 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000000 x19: ffff56001244ac6e x18: 0000000000000229
x17: 0000000000000000 x16: ffff80000dbb8658 x15: ffff0000d1919a80
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d65f960
x11: ff808000081c39dc x10: ffff80000dd7a698 x9 : 0000000000040c6e
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff800008197c8c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000016
Call trace:
 hlock_class kernel/locking/lockdep.c:222 [inline]
 check_wait_context kernel/locking/lockdep.c:4728 [inline]
 __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 _atomic_dec_and_lock+0xb0/0x104 lib/dec_and_lock.c:28
 iput+0x50/0x314 fs/inode.c:1766
 ntfs_fill_super+0x1254/0x14a4 fs/ntfs/super.c:188
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: b002deea 91196210 911a614a b9400329 (3942e114) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	b002deea 	adrp	x10, 0x5bdd000
   4:	91196210 	add	x16, x16, #0x658
   8:	911a614a 	add	x10, x10, #0x698
   c:	b9400329 	ldr	w9, [x25]
* 10:	3942e114 	ldrb	w20, [x8, #184] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
