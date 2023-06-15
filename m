Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EFE731268
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 10:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbjFOIj1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbjFOIjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:39:14 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AFE296B
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 01:39:09 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-77ac656cae6so808814539f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 01:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686818348; x=1689410348;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aM+Phr1An1GIiImzmdxTCUrcwlJ97syswvKcfB+xT2c=;
        b=EiVBBiQbFZaq2NooS2YkrT6t2aNE+MNaXJnOrNPo4J3kkA5JHmN1VuH5z8lpP9pSZ5
         s9LwIGwwzCLRZnYj3dPcE2hlcfozxWnK5Jtry2yQViq9zBmWTy/d2kVbtAwctqPSb28u
         cZEVv4RqbYqADo+FlylAkkqLmrFsMr0OJFgpPrxQBcOYRUENTgBxeHuiZ4xj+xs6JOSv
         awTvpsSfrs8GBvx/No8yGLlHfHLP+24iG2eDJfAgsJ/roZZPw0DjCIw+tYYdI8KIkoqQ
         S3nFbc4Dz6hKVSyaCMBpO+d1lRBEOhZ1NR1IAzrstLVkW8iRi/DUkezf1+Rxt/GeKXpm
         s+Bg==
X-Gm-Message-State: AC+VfDyC9WSOqJFl77M7b4hodO3bzHjw8pwhW3ijkDc9EFtj3pBQaYFY
        Ev/iFvm7c+OXRpdKyL+g7GOur+CPWzB5LjXde7ZN6+JdirfE
X-Google-Smtp-Source: ACHHUZ7XYj2xat4zS17Sbt9bRcr5SaxkDqlPIN162EqFbB3AYNU3wgjlFOxUMG9aUDVsUdfLY7hrKbCq0uAQO8rAOFcKH8z397p1
MIME-Version: 1.0
X-Received: by 2002:a02:94c1:0:b0:423:1093:c805 with SMTP id
 x59-20020a0294c1000000b004231093c805mr731017jah.3.1686818348544; Thu, 15 Jun
 2023 01:39:08 -0700 (PDT)
Date:   Thu, 15 Jun 2023 01:39:08 -0700
In-Reply-To: <000000000000cbb5f505faa4d920@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000773bb005fe270004@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_release_file
From:   syzbot <syzbot+e5b81eaab292e00e7d98@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    b6dad5178cea Merge tag 'nios2_fix_v6.4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12510203280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5bcee04c3b2a8237
dashboard link: https://syzkaller.appspot.com/bug?extid=e5b81eaab292e00e7d98
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10db66f7280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14577753280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ae77e66553b/disk-b6dad517.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b2da4d23e74/vmlinux-b6dad517.xz
kernel image: https://storage.googleapis.com/syzbot-assets/23130b8e7a8a/bzImage-b6dad517.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/70b8358ae62a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e5b81eaab292e00e7d98@syzkaller.appspotmail.com

loop4: rw=2049, sector=77824, nr_sectors = 3048 limit=63271
syz-executor110: attempt to access beyond end of device
loop4: rw=2049, sector=80872, nr_sectors = 1048 limit=63271
======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc6-syzkaller-00037-gb6dad5178cea #0 Not tainted
------------------------------------------------------
syz-executor110/5218 is trying to acquire lock:
ffff88806676b660 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
ffff88806676b660 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: f2fs_release_file fs/f2fs/file.c:1866 [inline]
ffff88806676b660 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: f2fs_release_file+0xca/0x100 fs/f2fs/file.c:1856

but task is already holding lock:
ffff88802100c448 (&sbi->node_write){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2087 [inline]
ffff88802100c448 (&sbi->node_write){++++}-{3:3}, at: f2fs_write_single_data_page+0x166e/0x19d0 fs/f2fs/data.c:2842

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->node_write){++++}-{3:3}:
       __lock_release kernel/locking/lockdep.c:5419 [inline]
       lock_release+0x33c/0x670 kernel/locking/lockdep.c:5725
       up_write+0x2a/0x520 kernel/locking/rwsem.c:1625
       f2fs_up_write fs/f2fs/f2fs.h:2122 [inline]
       block_operations+0xca4/0xe80 fs/f2fs/checkpoint.c:1288
       f2fs_write_checkpoint+0x5fa/0x4b40 fs/f2fs/checkpoint.c:1651
       __write_checkpoint_sync fs/f2fs/checkpoint.c:1768 [inline]
       __checkpoint_and_complete_reqs+0xea/0x350 fs/f2fs/checkpoint.c:1787
       issue_checkpoint_thread+0xe3/0x250 fs/f2fs/checkpoint.c:1818
       kthread+0x344/0x440 kernel/kthread.c:379
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #1 (&sbi->cp_rwsem){++++}-{3:3}:
       down_read+0x9c/0x480 kernel/locking/rwsem.c:1520
       f2fs_down_read fs/f2fs/f2fs.h:2087 [inline]
       f2fs_lock_op fs/f2fs/f2fs.h:2130 [inline]
       f2fs_convert_inline_inode+0x47b/0x8e0 fs/f2fs/inline.c:218
       f2fs_preallocate_blocks fs/f2fs/file.c:4480 [inline]
       f2fs_file_write_iter+0x1a1f/0x24d0 fs/f2fs/file.c:4712
       call_write_iter include/linux/fs.h:1868 [inline]
       do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
       do_iter_write+0x185/0x7e0 fs/read_write.c:860
       vfs_writev+0x1aa/0x670 fs/read_write.c:933
       do_pwritev+0x1b6/0x270 fs/read_write.c:1030
       __do_sys_pwritev2 fs/read_write.c:1089 [inline]
       __se_sys_pwritev2 fs/read_write.c:1080 [inline]
       __x64_sys_pwritev2+0xef/0x150 fs/read_write.c:1080
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3113 [inline]
       check_prevs_add kernel/locking/lockdep.c:3232 [inline]
       validate_chain kernel/locking/lockdep.c:3847 [inline]
       __lock_acquire+0x2fcd/0x5f30 kernel/locking/lockdep.c:5088
       lock_acquire kernel/locking/lockdep.c:5705 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:775 [inline]
       f2fs_release_file fs/f2fs/file.c:1866 [inline]
       f2fs_release_file+0xca/0x100 fs/f2fs/file.c:1856
       __fput+0x27c/0xa90 fs/file_table.c:321
       task_work_run+0x16f/0x270 kernel/task_work.c:179
       get_signal+0x1c7/0x25b0 kernel/signal.c:2652
       arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
       exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
       exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
       __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
       syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
       do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &sb->s_type->i_mutex_key#17 --> &sbi->cp_rwsem --> &sbi->node_write

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&sbi->node_write);
                               lock(&sbi->cp_rwsem);
                               lock(&sbi->node_write);
  lock(&sb->s_type->i_mutex_key#17);

 *** DEADLOCK ***

1 lock held by syz-executor110/5218:
 #0: ffff88802100c448 (&sbi->node_write){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2087 [inline]
 #0: ffff88802100c448 (&sbi->node_write){++++}-{3:3}, at: f2fs_write_single_data_page+0x166e/0x19d0 fs/f2fs/data.c:2842

stack backtrace:
CPU: 1 PID: 5218 Comm: syz-executor110 Not tainted 6.4.0-rc6-syzkaller-00037-gb6dad5178cea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3113 [inline]
 check_prevs_add kernel/locking/lockdep.c:3232 [inline]
 validate_chain kernel/locking/lockdep.c:3847 [inline]
 __lock_acquire+0x2fcd/0x5f30 kernel/locking/lockdep.c:5088
 lock_acquire kernel/locking/lockdep.c:5705 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
 down_write+0x92/0x200 kernel/locking/rwsem.c:1573
 inode_lock include/linux/fs.h:775 [inline]
 f2fs_release_file fs/f2fs/file.c:1866 [inline]
 f2fs_release_file+0xca/0x100 fs/f2fs/file.c:1856
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 get_signal+0x1c7/0x25b0 kernel/signal.c:2652
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6b9a0179b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6b99fc32f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: fffffffffffffffb RBX: 00007f6b9a0a47a8 RCX: 00007f6b9a0179b9
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00007f6b9a0a47a0 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000001400 R11: 0000000000000246 R12: 00007f6b9a0a47ac
R13: 00007f6b9a071008 R14: 6f6f6c2f7665642f R15: 0000000000022000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
