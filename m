Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C676F257F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 19:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjD2Rgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Apr 2023 13:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjD2Rgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Apr 2023 13:36:37 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDBA1BD4
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Apr 2023 10:36:36 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-32a8c155f24so13637605ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Apr 2023 10:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682789796; x=1685381796;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwzvF6SYS9Tx8bMji/qzNUXlj5HTA1UyRbsI+z+pCvk=;
        b=DuW0Se41tyjlT/Q1iZaG9Z7ZYZp91Z5gL52QSIFFZLUIQL4e3ksiDWzIMD6IN13Are
         QRzMdNx/1cDwUt/nMRkOuaoUNHS7+LltDYOC0fSYogbrelzXRGbaxc7A5y6J2rziPFPc
         ktalhiV2fHs1+31nnTWIfAfKxekj8KbCG/Bu5YL+/Ebqe9caVKDbl5wq5yi+nC+D45A7
         ZCFx4LWoX+KU7fVV1qZ3BkHXWGgZqLJY/aEkhCUSteS5O0BA4ESh7cq8lAEO9U9DnUr2
         6mVn9cZPMn8ASV3rzYLomiZkcS14FXLrWxIwUVcMc/xJw2hpl+5GkL90QiS8gAIZPv/o
         PnPA==
X-Gm-Message-State: AC+VfDyIew7kZ73CHsoAVCadhyo0OzvcvXx2Kd+PxAw7zGTBe5ZCw7ix
        ZruzJG0PG2Gfd6sjVV9iYLEYoXsahUx4/gs04SQBK5KOfgeA
X-Google-Smtp-Source: ACHHUZ7GYYTDdJKrqiS+DQdzc0hrvTs/MfBwJ4MKstsUTl4THiXhP3OrF24eRdsGiFD5RhRvzaWg+iPKS6/Y3yNFeh5opO7GTMKg
MIME-Version: 1.0
X-Received: by 2002:a92:c90e:0:b0:329:4c5e:15d8 with SMTP id
 t14-20020a92c90e000000b003294c5e15d8mr4891717ilp.2.1682789796011; Sat, 29 Apr
 2023 10:36:36 -0700 (PDT)
Date:   Sat, 29 Apr 2023 10:36:35 -0700
In-Reply-To: <000000000000ee3a3005f909f30a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005e6fc05fa7d0881@google.com>
Subject: Re: [syzbot] [ext4?] [fat?] possible deadlock in sys_quotactl_fd
From:   syzbot <syzbot+aacb82fca60873422114@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, brauner@kernel.org, jack@suse.com,
        jack@suse.cz, linkinjeon@kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    14f8db1c0f9a Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=115bdcf8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a837a8ba7e88bb45
dashboard link: https://syzkaller.appspot.com/bug?extid=aacb82fca60873422114
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1405a2b4280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bd276fc80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad6ce516eed3/disk-14f8db1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f38c2cc7667/vmlinux-14f8db1c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d795115eee39/Image-14f8db1c.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b9312932adf4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aacb82fca60873422114@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc7-syzkaller-g14f8db1c0f9a #0 Not tainted
------------------------------------------------------
syz-executor396/5961 is trying to acquire lock:
ffff0000d9e5c0e0 (&type->s_umount_key#29){++++}-{3:3}, at: __do_sys_quotactl_fd fs/quota/quota.c:999 [inline]
ffff0000d9e5c0e0 (&type->s_umount_key#29){++++}-{3:3}, at: __se_sys_quotactl_fd fs/quota/quota.c:972 [inline]
ffff0000d9e5c0e0 (&type->s_umount_key#29){++++}-{3:3}, at: __arm64_sys_quotactl_fd+0x30c/0x4a4 fs/quota/quota.c:972

but task is already holding lock:
ffff0000d9e5c460 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x44/0x9c fs/namespace.c:394

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sb_writers#3){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1477 [inline]
       sb_start_write include/linux/fs.h:1552 [inline]
       write_mmp_block+0xe4/0xb70 fs/ext4/mmp.c:50
       ext4_multi_mount_protect+0x2f8/0x8c8 fs/ext4/mmp.c:343
       __ext4_remount fs/ext4/super.c:6543 [inline]
       ext4_reconfigure+0x2180/0x2928 fs/ext4/super.c:6642
       reconfigure_super+0x328/0x738 fs/super.c:956
       do_remount fs/namespace.c:2704 [inline]
       path_mount+0xc0c/0xe04 fs/namespace.c:3364
       do_mount fs/namespace.c:3385 [inline]
       __do_sys_mount fs/namespace.c:3594 [inline]
       __se_sys_mount fs/namespace.c:3571 [inline]
       __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3571
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
       el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

-> #0 (&type->s_umount_key#29){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x3338/0x764c kernel/locking/lockdep.c:5056
       lock_acquire+0x238/0x718 kernel/locking/lockdep.c:5669
       down_read+0x50/0x6c kernel/locking/rwsem.c:1520
       __do_sys_quotactl_fd fs/quota/quota.c:999 [inline]
       __se_sys_quotactl_fd fs/quota/quota.c:972 [inline]
       __arm64_sys_quotactl_fd+0x30c/0x4a4 fs/quota/quota.c:972
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
       el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_writers#3);
                               lock(&type->s_umount_key#29);
                               lock(sb_writers#3);
  lock(&type->s_umount_key#29);

 *** DEADLOCK ***

1 lock held by syz-executor396/5961:
 #0: ffff0000d9e5c460 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x44/0x9c fs/namespace.c:394

stack backtrace:
CPU: 0 PID: 5961 Comm: syz-executor396 Not tainted 6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2056
 check_noncircular+0x2cc/0x378 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3098 [inline]
 check_prevs_add kernel/locking/lockdep.c:3217 [inline]
 validate_chain kernel/locking/lockdep.c:3832 [inline]
 __lock_acquire+0x3338/0x764c kernel/locking/lockdep.c:5056
 lock_acquire+0x238/0x718 kernel/locking/lockdep.c:5669
 down_read+0x50/0x6c kernel/locking/rwsem.c:1520
 __do_sys_quotactl_fd fs/quota/quota.c:999 [inline]
 __se_sys_quotactl_fd fs/quota/quota.c:972 [inline]
 __arm64_sys_quotactl_fd+0x30c/0x4a4 fs/quota/quota.c:972
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
