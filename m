Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E13B6F9E26
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 05:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjEHDVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 23:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjEHDVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 23:21:45 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED2F9ECD
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 May 2023 20:21:43 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-33156204adcso59358485ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 May 2023 20:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683516102; x=1686108102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLW6NInX3+lOz0KcR+7ZsxHwUXVZHX3evVuHHvdzU24=;
        b=VBGUgMXxP7FdOgjETEZD8eaJ0WZa/pf7d6nbwNL76xEdSZJ7d3lCGzZS9DTzTfM8Or
         bT+YQvlJ6rO/skFoK9B3vp9nB1vIwolDp6un7jYFmtsghhqaNf/60q15hNk8S+S0rwzw
         V0ZCfFgFC4JCTeJSqDipHS3lq16E2DyiDc/J3GzSln9b5yJOCTwhLPUvwxcBD4iIubv0
         FoMcdCxeq6vABn3zDCgUma5duxgiLePITYSzi2IUB6fjegXkrVOJjAanbhASoOarTE1a
         6xvYcz3mBvkggKXqgOZ6ibQ2ruLVrH8JSNgehZadEL16FhhgNowFmVF6zMoMw4ICjoL6
         XlFw==
X-Gm-Message-State: AC+VfDzq3EKL+0GG1TINJdmVt4napglsFkYtjGZFwWjv95CqLPETLix4
        imSW/slfHTridzqc7JHepJVXKSyH//C3nATOcxoYITzVH/31
X-Google-Smtp-Source: ACHHUZ44zdqnKiu+NBbWMTMZFbnaXFu53jsdGkc1491U/8wKPDCFcECaNKh9+vwhZcH2LIdXYLICE7A5cCbkGqki4a2nVT8t8Yi4
MIME-Version: 1.0
X-Received: by 2002:a92:d202:0:b0:334:bd8a:ec8c with SMTP id
 y2-20020a92d202000000b00334bd8aec8cmr4123420ily.5.1683516102776; Sun, 07 May
 2023 20:21:42 -0700 (PDT)
Date:   Sun, 07 May 2023 20:21:42 -0700
In-Reply-To: <0000000000005937d105f24c9809@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047a15005fb262317@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_iget
From:   syzbot <syzbot+298c5d8fb4a128bc27b0@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    83e5775d7afd Add linux-next specific files for 20230505
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15a5bb4a280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c6b4b7069d73cf
dashboard link: https://syzkaller.appspot.com/bug?extid=298c5d8fb4a128bc27b0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b7c75c280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1284b832280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95513581563c/disk-83e5775d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a4e06ec61bde/vmlinux-83e5775d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ccebc2ffc0a5/bzImage-83e5775d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2abf046bc472/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+298c5d8fb4a128bc27b0@syzkaller.appspotmail.com

EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: writeback.
======================================================
WARNING: possible circular locking dependency detected
6.3.0-next-20230505-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor168/5006 is trying to acquire lock:
ffff888077185e00 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
ffff888077185e00 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: ext4_xattr_inode_iget+0x2b8/0x660 fs/ext4/xattr.c:474

but task is already holding lock:
ffff888077185288 (&ei->i_data_sem){++++}-{3:3}, at: ext4_setattr+0x1925/0x26c0 fs/ext4/inode.c:5397

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ei->i_data_sem){++++}-{3:3}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       ext4_update_i_disksize fs/ext4/ext4.h:3293 [inline]
       ext4_xattr_inode_write fs/ext4/xattr.c:1462 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1611 [inline]
       ext4_xattr_set_entry+0x30c5/0x39e0 fs/ext4/xattr.c:1736
       ext4_xattr_ibody_set+0x131/0x3a0 fs/ext4/xattr.c:2288
       ext4_xattr_set_handle+0x968/0x1510 fs/ext4/xattr.c:2445
       ext4_xattr_set+0x144/0x360 fs/ext4/xattr.c:2559
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
       check_prev_add kernel/locking/lockdep.c:3113 [inline]
       check_prevs_add kernel/locking/lockdep.c:3232 [inline]
       validate_chain kernel/locking/lockdep.c:3847 [inline]
       __lock_acquire+0x2fcd/0x5f30 kernel/locking/lockdep.c:5088
       lock_acquire.part.0+0x11c/0x370 kernel/locking/lockdep.c:5705
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:775 [inline]
       ext4_xattr_inode_iget+0x2b8/0x660 fs/ext4/xattr.c:474
       ext4_xattr_inode_get+0x162/0x830 fs/ext4/xattr.c:551
       ext4_xattr_move_to_block fs/ext4/xattr.c:2640 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2742 [inline]
       ext4_expand_extra_isize_ea+0xf6d/0x1880 fs/ext4/xattr.c:2834
       __ext4_expand_extra_isize+0x33e/0x470 fs/ext4/inode.c:5769
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:5812 [inline]
       __ext4_mark_inode_dirty+0x51b/0x800 fs/ext4/inode.c:5890
       ext4_setattr+0x199f/0x26c0 fs/ext4/inode.c:5400
       notify_change+0xb2c/0x1180 fs/attr.c:483
       do_truncate+0x143/0x200 fs/open.c:66
       handle_truncate fs/namei.c:3295 [inline]
       do_open fs/namei.c:3640 [inline]
       path_openat+0x2083/0x2750 fs/namei.c:3791
       do_filp_open+0x1ba/0x410 fs/namei.c:3818
       do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_creat fs/open.c:1448 [inline]
       __se_sys_creat fs/open.c:1442 [inline]
       __x64_sys_creat+0xcd/0x120 fs/open.c:1442
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem);
                               lock(&ea_inode->i_rwsem#8/1);
                               lock(&ei->i_data_sem);
  lock(&ea_inode->i_rwsem#8/1);

 *** DEADLOCK ***

5 locks held by syz-executor168/5006:
 #0: ffff88801a7b4460 (sb_writers#4){.+.+}-{0:0}, at: do_open fs/namei.c:3629 [inline]
 #0: ffff88801a7b4460 (sb_writers#4){.+.+}-{0:0}, at: path_openat+0x19a4/0x2750 fs/namei.c:3791
 #1: ffff888077185400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888077185400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: do_truncate+0x131/0x200 fs/open.c:64
 #2: ffff8880771855a0 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:820 [inline]
 #2: ffff8880771855a0 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_setattr+0x68f/0x26c0 fs/ext4/inode.c:5357
 #3: ffff888077185288 (&ei->i_data_sem){++++}-{3:3}, at: ext4_setattr+0x1925/0x26c0 fs/ext4/inode.c:5397
 #4: ffff8880771850c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:162 [inline]
 #4: ffff8880771850c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:5809 [inline]
 #4: ffff8880771850c8 (&ei->xattr_sem){++++}-{3:3}, at: __ext4_mark_inode_dirty+0x48f/0x800 fs/ext4/inode.c:5890

stack backtrace:
CPU: 0 PID: 5006 Comm: syz-executor168 Not tainted 6.3.0-next-20230505-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3113 [inline]
 check_prevs_add kernel/locking/lockdep.c:3232 [inline]
 validate_chain kernel/locking/lockdep.c:3847 [inline]
 __lock_acquire+0x2fcd/0x5f30 kernel/locking/lockdep.c:5088
 lock_acquire.part.0+0x11c/0x370 kernel/locking/lockdep.c:5705
 down_write+0x92/0x200 kernel/locking/rwsem.c:1573
 inode_lock include/linux/fs.h:775 [inline]
 ext4_xattr_inode_iget+0x2b8/0x660 fs/ext4/xattr.c:474
 ext4_xattr_inode_get+0x162/0x830 fs/ext4/xattr.c:551
 ext4_xattr_move_to_block fs/ext4/xattr.c:2640 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2742 [inline]
 ext4_expand_extra_isize_ea+0xf6d/0x1880 fs/ext4/xattr.c:2834
 __ext4_expand_extra_isize+0x33e/0x470 fs/ext4/inode.c:5769
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5812 [inline]
 __ext4_mark_inode_dirty+0x51b/0x800 fs/ext4/inode.c:5890
 ext4_setattr+0x199f/0x26c0 fs/ext4/inode.c:5400
 notify_change+0xb2c/0x1180 fs/attr.c:483
 do_truncate+0x143/0x200 fs/open.c:66
 handle_truncate fs/namei.c:3295 [inline]
 do_open fs/namei.c:3640 [inline]
 path_openat+0x2083/0x2750 fs/namei.c:3791
 do_filp_open+0x1ba/0x410 fs/namei.c:3818
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_creat fs/open.c:1448 [inline]
 __se_sys_creat fs/open.c:1442 [inline]
 __x64_sys_creat+0xcd/0x120 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efc2e57ac09
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd62b7d568 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007efc2e57ac09
RDX: 00007efc2e57ac09 RSI: 0000000000000000 RDI: 0000000020000400
RBP: 00007efc2e53a210 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
