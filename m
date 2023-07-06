Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B4D74A31C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 19:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjGFRb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 13:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGFRbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:31:55 -0400
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2411994
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 10:31:53 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1b8a4e947a1so27742675ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jul 2023 10:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688664713; x=1691256713;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiGTyBPtLwypnQLrO6poXWE8HNsaMeTcj1EiLqNtIak=;
        b=NuZMTKZJHtdUDJuHcLhZ0lQv6pcAX7vpsrXZxdGZ/mS2KL9d/sh4LSWrhxQJFeBXei
         vtcmloXVpNN9coYw5s061sM75k3RslP9ifc+gYLFFwLNtIZgPOXOsWOH4sjEm7SVoiUo
         Z1mP/lR6fiTsDbxIBwLy0SIltXY7eIUScZsrTOTPsZiegVhgdgUHE1wZXL32odZdrbZt
         AUCqGC3TjCeD4uyRORWVqLyUc87xNOgHYuelAalLPR/TRc/IDReB7Qn+EMgULAHnahVT
         94O/sjHup9rqwzDlKwiPf8+Ss2DRLTaik3rN7VbJgBJPrTzw1C7i3rvRJdA71Y1IBots
         gbhw==
X-Gm-Message-State: ABy/qLYgnkkTuU0x6nRg0YvSULvOnvM+wl5ViMAUP9kDchvkkh987UTl
        ryuf90EhhQeuSZLqV+BZsla9QPKBWcLXs5sEqyXGY2yL2+bs
X-Google-Smtp-Source: APBJJlGdGYWuER7dPL08sX9M7YVYlkdTtp2LZHLxB4usjFOf6PHao51vrXkPbX7cE+jDoZWAKstDhXGG1EgiUnimEdrH2Af4RSbE
MIME-Version: 1.0
X-Received: by 2002:a17:902:d2cf:b0:1b8:9b39:7cb6 with SMTP id
 n15-20020a170902d2cf00b001b89b397cb6mr2301958plc.4.1688664712899; Thu, 06 Jul
 2023 10:31:52 -0700 (PDT)
Date:   Thu, 06 Jul 2023 10:31:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b767405ffd4e4ec@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_iget (2)
From:   syzbot <syzbot+352d78bd60c8e9d6ecdc@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, elic@nvidia.com, jasowang@redhat.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, mst@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com, parav@nvidia.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    995b406c7e97 Merge tag 'csky-for-linus-6.5' of https://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=108a1a6f280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7406f415f386e786
dashboard link: https://syzkaller.appspot.com/bug?extid=352d78bd60c8e9d6ecdc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fca8b8a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c6f3dca80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf7e228b7235/disk-995b406c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c80e997d9074/vmlinux-995b406c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/826390d53480/bzImage-995b406c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/45c2258308a9/mount_0.gz

The issue was bisected to:

commit a3c06ae158dd6fa8336157c31d9234689d068d02
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:03 2021 +0000

    vdpa_sim_net: Add support for user supported devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1613da4f280000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1513da4f280000
console output: https://syzkaller.appspot.com/x/log.txt?x=1113da4f280000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+352d78bd60c8e9d6ecdc@syzkaller.appspotmail.com
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

EXT4-fs: Warning: mounting with an experimental mount option 'dioread_nolock' for blocksize < PAGE_SIZE
EXT4-fs (loop0): 1 truncate cleaned up
======================================================
WARNING: possible circular locking dependency detected
6.4.0-syzkaller-10098-g995b406c7e97 #0 Not tainted
------------------------------------------------------
syz-executor118/5116 is trying to acquire lock:
ffff888077fdc000 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
ffff888077fdc000 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: ext4_xattr_inode_iget+0x173/0x400 fs/ext4/xattr.c:461

but task is already holding lock:
ffff888077fdc888 (&ei->i_data_sem/3){++++}-{3:3}, at: ext4_setattr+0x1988/0x2880 fs/ext4/inode.c:5397

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ei->i_data_sem/3){++++}-{3:3}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       ext4_update_i_disksize fs/ext4/ext4.h:3363 [inline]
       ext4_xattr_inode_write fs/ext4/xattr.c:1446 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1594 [inline]
       ext4_xattr_set_entry+0x3046/0x3810 fs/ext4/xattr.c:1719
       ext4_xattr_ibody_set+0x131/0x3a0 fs/ext4/xattr.c:2273
       ext4_xattr_set_handle+0x968/0x1510 fs/ext4/xattr.c:2430
       ext4_xattr_set+0x144/0x360 fs/ext4/xattr.c:2544
       ext4_xattr_user_set+0xbd/0x100 fs/ext4/xattr_user.c:41
       __vfs_setxattr+0x173/0x1e0 fs/xattr.c:201
       __vfs_setxattr_noperm+0x129/0x5f0 fs/xattr.c:235
       __vfs_setxattr_locked+0x1d3/0x260 fs/xattr.c:296
       vfs_setxattr+0x143/0x340 fs/xattr.c:322
       do_setxattr+0x147/0x190 fs/xattr.c:630
       setxattr+0x146/0x160 fs/xattr.c:653
       path_setxattr+0x197/0x1c0 fs/xattr.c:672
       __do_sys_setxattr fs/xattr.c:688 [inline]
       __se_sys_setxattr fs/xattr.c:684 [inline]
       __x64_sys_setxattr+0xc4/0x160 fs/xattr.c:684
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
       lock_acquire kernel/locking/lockdep.c:5761 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:771 [inline]
       ext4_xattr_inode_iget+0x173/0x400 fs/ext4/xattr.c:461
       ext4_xattr_inode_get+0x162/0x830 fs/ext4/xattr.c:535
       ext4_xattr_move_to_block fs/ext4/xattr.c:2626 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2728 [inline]
       ext4_expand_extra_isize_ea+0xf51/0x1810 fs/ext4/xattr.c:2820
       __ext4_expand_extra_isize+0x33e/0x470 fs/ext4/inode.c:5769
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:5812 [inline]
       __ext4_mark_inode_dirty+0x51b/0x800 fs/ext4/inode.c:5890
       ext4_setattr+0x1a02/0x2880 fs/ext4/inode.c:5400
       notify_change+0xb2c/0x1180 fs/attr.c:483
       do_truncate+0x143/0x200 fs/open.c:66
       handle_truncate fs/namei.c:3295 [inline]
       do_open fs/namei.c:3640 [inline]
       path_openat+0x2047/0x2710 fs/namei.c:3793
       do_filp_open+0x1ba/0x410 fs/namei.c:3820
       do_sys_openat2+0x160/0x1c0 fs/open.c:1407
       do_sys_open fs/open.c:1422 [inline]
       __do_sys_creat fs/open.c:1498 [inline]
       __se_sys_creat fs/open.c:1492 [inline]
       __x64_sys_creat+0xcd/0x120 fs/open.c:1492
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem/3);
                               lock(&ea_inode->i_rwsem#8/1);
                               lock(&ei->i_data_sem/3);
  lock(&ea_inode->i_rwsem#8/1);

 *** DEADLOCK ***

5 locks held by syz-executor118/5116:
 #0: ffff888078b76410 (sb_writers#4){.+.+}-{0:0}, at: do_open fs/namei.c:3629 [inline]
 #0: ffff888078b76410 (sb_writers#4){.+.+}-{0:0}, at: path_openat+0x1959/0x2710 fs/namei.c:3793
 #1: ffff888077fdca00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
 #1: ffff888077fdca00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: do_truncate+0x131/0x200 fs/open.c:64
 #2: ffff888077fdcba0 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:816 [inline]
 #2: ffff888077fdcba0 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_setattr+0x6f2/0x2880 fs/ext4/inode.c:5357
 #3: ffff888077fdc888 (&ei->i_data_sem/3){++++}-{3:3}, at: ext4_setattr+0x1988/0x2880 fs/ext4/inode.c:5397
 #4: ffff888077fdc6c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:162 [inline]
 #4: ffff888077fdc6c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:5809 [inline]
 #4: ffff888077fdc6c8 (&ei->xattr_sem){++++}-{3:3}, at: __ext4_mark_inode_dirty+0x48f/0x800 fs/ext4/inode.c:5890

stack backtrace:
CPU: 1 PID: 5116 Comm: syz-executor118 Not tainted 6.4.0-syzkaller-10098-g995b406c7e97 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x2df/0x3b0 kernel/locking/lockdep.c:2195
 check_prev_add kernel/locking/lockdep.c:3142 [inline]
 check_prevs_add kernel/locking/lockdep.c:3261 [inline]
 validate_chain kernel/locking/lockdep.c:3876 [inline]
 __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
 down_write+0x92/0x200 kernel/locking/rwsem.c:1573
 inode_lock include/linux/fs.h:771 [inline]
 ext4_xattr_inode_iget+0x173/0x400 fs/ext4/xattr.c:461
 ext4_xattr_inode_get+0x162/0x830 fs/ext4/xattr.c:535
 ext4_xattr_move_to_block fs/ext4/xattr.c:2626 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2728 [inline]
 ext4_expand_extra_isize_ea+0xf51/0x1810 fs/ext4/xattr.c:2820
 __ext4_expand_extra_isize+0x33e/0x470 fs/ext4/inode.c:5769
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5812 [inline]
 __ext4_mark_inode_dirty+0x51b/0x800 fs/ext4/inode.c:5890
 ext4_setattr+0x1a02/0x2880 fs/ext4/inode.c:5400
 notify_change+0xb2c/0x1180 fs/attr.c:483
 do_truncate+0x143/0x200 fs/open.c:66
 handle_truncate fs/namei.c:3295 [inline]
 do_open fs/namei.c:3640 [inline]
 path_openat+0x2047/0x2710 fs/namei.c:3793
 do_filp_open+0x1ba/0x410 fs/namei.c:3820
 do_sys_openat2+0x160/0x1c0 fs/open.c:1407
 do_sys_open fs/open.c:1422 [inline]
 __do_sys_creat fs/open.c:1498 [inline]
 __se_sys_creat fs/open.c:1492 [inline]
 __x64_sys_creat+0xcd/0x120 fs/open.c:1492
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f29661c09c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8f5d8168 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007f29661c09c9
RDX: 00007f29661c09c9 RSI: 0000000000000108 RDI: 0000000020000000
RBP: 0000000000000000 R08: 00007ffd8f5d8190 R09: 00007ffd8f5d8190
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd8f5d818c
R13: 00007ffd8f5d81c0 R14: 00007ffd8f5d81a0 R15: 000000000000003a
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
