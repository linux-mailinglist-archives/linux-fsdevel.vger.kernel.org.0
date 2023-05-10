Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC226FD846
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 09:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbjEJHdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 03:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbjEJHdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 03:33:35 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918C8A5E6
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 00:32:47 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-760c58747cdso966504639f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 00:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683703879; x=1686295879;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4a8KkWz9dRbpQYxxpyag0gphM+cBkqC1Ynk92aCjLc=;
        b=OKUO7aU0jVy5s77LSeF12JBE4/rHir88AAvx2QsBPIw/aSpMOlntdhTJr0GizKLZTM
         LMCpL3zspIIHzW83ly9/qRX0DeO4Jl9xxQDnNiUJqDob9cjh5fblPCVT8DiKi6fA6KqW
         Ugg9F7pRZwzxtebnHM/dnfEf2LVUpB89uk+RgjDoGf1P5HJlrU6Bp7z9fZqsOvJeEFaX
         h1L9e/RkxsWpeVGaZtcsGkTYGZcyf8I2nmjMQWUaqCN0xEDXhf7hUuCrE9DFNmJIivGJ
         tSgJAuP1nxGpTF6508KdrhvJnse15NP5tF5ALYO1yxoCkxGbCBw9AeiqSpd0Y1ZhBrhO
         w4uw==
X-Gm-Message-State: AC+VfDyaTELvGtXk9+0G088iUpxy6eipIb84uUmQROhMNtGfKDaOQufi
        XrU8q341Pwzw9UNOWYsC9BpJ/Kf9L3Oo1ntif1egnVDBbDLW
X-Google-Smtp-Source: ACHHUZ4WQqffs93R8HeMOCc4Zmn/P+d7xYLncyiFDdkPWJ5HeuWPIkK6smLQTRaifp3h9yVSsEiOQRy3oXIVbSiC9h2+kMGuOsDj
MIME-Version: 1.0
X-Received: by 2002:a5e:a703:0:b0:766:3ffc:b5de with SMTP id
 b3-20020a5ea703000000b007663ffcb5demr8021731iod.3.1683703879174; Wed, 10 May
 2023 00:31:19 -0700 (PDT)
Date:   Wed, 10 May 2023 00:31:19 -0700
In-Reply-To: <000000000000f1a9d205f909f327@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a018e405fb51db75@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in quotactl_fd
From:   syzbot <syzbot+cdcd444e4d3a256ada13@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, brauner@kernel.org, jack@suse.com,
        jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    1dc3731daf1f Merge tag 'for-6.4-rc1-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ef9566280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bc832f563d8bf38
dashboard link: https://syzkaller.appspot.com/bug?extid=cdcd444e4d3a256ada13
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cc2a92280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dc5fa6280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c41d6364878c/disk-1dc3731d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed2d9614f1c1/vmlinux-1dc3731d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/903dc319e88d/bzImage-1dc3731d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/46ea6ec4210f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cdcd444e4d3a256ada13@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc1-syzkaller-00011-g1dc3731daf1f #0 Not tainted
------------------------------------------------------
syz-executor197/5038 is trying to acquire lock:
ffff88802b6260e0 (&type->s_umount_key#32){++++}-{3:3}, at: __do_sys_quotactl_fd+0x27e/0x3f0 fs/quota/quota.c:999

but task is already holding lock:
ffff88802b626460 (sb_writers#4){.+.+}-{0:0}, at: __do_sys_quotactl_fd+0xd3/0x3f0 fs/quota/quota.c:990

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sb_writers#4){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1494 [inline]
       sb_start_write include/linux/fs.h:1569 [inline]
       write_mmp_block+0xc4/0x820 fs/ext4/mmp.c:50
       ext4_multi_mount_protect+0x50d/0xac0 fs/ext4/mmp.c:347
       __ext4_remount fs/ext4/super.c:6578 [inline]
       ext4_reconfigure+0x242b/0x2b60 fs/ext4/super.c:6677
       reconfigure_super+0x40c/0xa30 fs/super.c:956
       vfs_fsconfig_locked fs/fsopen.c:254 [inline]
       __do_sys_fsconfig+0xa5e/0xc50 fs/fsopen.c:439
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&type->s_umount_key#32){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3108 [inline]
       check_prevs_add kernel/locking/lockdep.c:3227 [inline]
       validate_chain kernel/locking/lockdep.c:3842 [inline]
       __lock_acquire+0x2f21/0x5df0 kernel/locking/lockdep.c:5074
       lock_acquire kernel/locking/lockdep.c:5691 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
       down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
       __do_sys_quotactl_fd+0x27e/0x3f0 fs/quota/quota.c:999
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#4);
                               lock(&type->s_umount_key#32);
                               lock(sb_writers#4);
  rlock(&type->s_umount_key#32);

 *** DEADLOCK ***

1 lock held by syz-executor197/5038:
 #0: ffff88802b626460 (sb_writers#4){.+.+}-{0:0}, at: __do_sys_quotactl_fd+0xd3/0x3f0 fs/quota/quota.c:990

stack backtrace:
CPU: 1 PID: 5038 Comm: syz-executor197 Not tainted 6.4.0-rc1-syzkaller-00011-g1dc3731daf1f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3108 [inline]
 check_prevs_add kernel/locking/lockdep.c:3227 [inline]
 validate_chain kernel/locking/lockdep.c:3842 [inline]
 __lock_acquire+0x2f21/0x5df0 kernel/locking/lockdep.c:5074
 lock_acquire kernel/locking/lockdep.c:5691 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
 down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
 __do_sys_quotactl_fd+0x27e/0x3f0 fs/quota/quota.c:999
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc4ee1d7359
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc4ee1832f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001bb
RAX: ffffffffffffffda RBX: 00007fc4ee25b7a0 RCX: 00007fc4ee1d7359
RDX: 00000000ffffffff RSI: ffffffff80000802 RDI: 0000000000000003
RBP: 00007fc4ee22858c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 7272655f61746164
R13: 6974797a616c6f6e R14: 0030656c69662f2e R15: 00007fc4ee25b7a8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
