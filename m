Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEAB74CB1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 06:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjGJEON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 00:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGJEOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:14:12 -0400
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDE6E5F
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Jul 2023 21:13:49 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-67106f598b1so4778945b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Jul 2023 21:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688962428; x=1691554428;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JBlq8U7o6+oDsoHy839/ATW+65fdJTfCb5NAT7MVVE=;
        b=F53T0huIg2VAbiR9qbtC73IXEuhWFW02xGltKAfMlAO1Kort1JuTPExx6Qj2z6z6Na
         l99gzYki/c/OgGFM+7/h5+DvgtZle+PUTPiayL/dgS/EtcPoE2f3Z+JpTw+vp2+yxTzo
         Hio200x23Q9xtwS/Id6vtCRG/BBTTZ5t1oyKIuhg1WbJQfWDVs3x67BzYGAez9kVc/TV
         tV3z8TKr7SM9wZvcw/tb1s4h5/M7HUv6jEqiLxHfk8bNganA+FjFCGVKGb75FWmL3/ws
         EZLZQ2v8rySZCdUq0zrvE2AyjF/Hgn5NgbEv97a5o/3qOzeX5K+jxon3X7e8+RJMSDuE
         IZ1A==
X-Gm-Message-State: ABy/qLbvWEnKzMbKCFUJABC/9lnrgaBHFKRx4meQf+ziZ1bKQEM3fqDt
        gQIom3Ju+VSKvg9vqUw0enVYg5/H1CfEnr4wZMr2nExbIPa8
X-Google-Smtp-Source: APBJJlEiJm0CaXSOMPCfYdtO632w3Ybbqq2RWc0P47XJmVWqpJoT5BAuS2zYQ7FFgQ6J9vWTILUPKJ0OrV4SrIUHgj34tNQ9oMmr
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d8c:b0:67a:36e3:36b6 with SMTP id
 fb12-20020a056a002d8c00b0067a36e336b6mr16162746pfb.6.1688962428465; Sun, 09
 Jul 2023 21:13:48 -0700 (PDT)
Date:   Sun, 09 Jul 2023 21:13:48 -0700
In-Reply-To: <0000000000005921ef05ffddc3b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096797d06001a359d@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_getxattr
From:   syzbot <syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    c192ac735768 MAINTAINERS 2: Electric Boogaloo
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1115adb0a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9831e2c2660aae77
dashboard link: https://syzkaller.appspot.com/bug?extid=e5600587fa9cbf8e3826
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136809b4a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1484e74ca80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a05cca457512/disk-c192ac73.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/87f55eba1b87/vmlinux-c192ac73.xz
kernel image: https://storage.googleapis.com/syzbot-assets/81e9815bafe0/bzImage-c192ac73.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/45865ba5a074/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-syzkaller-12491-gc192ac735768 #0 Not tainted
------------------------------------------------------
syz-executor225/5016 is trying to acquire lock:
ffff888072747888 (&fi->i_xattr_sem){.+.+}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2108 [inline]
ffff888072747888 (&fi->i_xattr_sem){.+.+}-{3:3}, at: f2fs_getxattr+0xb96/0xfd0 fs/f2fs/xattr.c:532

but task is already holding lock:
ffff88807274b668 (&fi->i_sem){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2133 [inline]
ffff88807274b668 (&fi->i_sem){+.+.}-{3:3}, at: f2fs_do_tmpfile+0x24/0x1d0 fs/f2fs/dir.c:838

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&fi->i_sem){+.+.}-{3:3}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       f2fs_down_write fs/f2fs/f2fs.h:2133 [inline]
       f2fs_add_inline_entry+0x2c4/0x6c0 fs/f2fs/inline.c:644
       f2fs_add_dentry+0xa6/0x240 fs/f2fs/dir.c:784
       f2fs_do_add_link+0x183/0x270 fs/f2fs/dir.c:827
       f2fs_add_link fs/f2fs/f2fs.h:3554 [inline]
       f2fs_create+0x3c1/0x670 fs/f2fs/namei.c:377
       lookup_open.isra.0+0x1050/0x1400 fs/namei.c:3492
       open_last_lookups fs/namei.c:3560 [inline]
       path_openat+0x969/0x2710 fs/namei.c:3790
       do_filp_open+0x1ba/0x410 fs/namei.c:3820
       do_sys_openat2+0x160/0x1c0 fs/open.c:1407
       do_sys_open fs/open.c:1422 [inline]
       __do_sys_openat fs/open.c:1438 [inline]
       __se_sys_openat fs/open.c:1433 [inline]
       __x64_sys_openat+0x143/0x1f0 fs/open.c:1433
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&fi->i_xattr_sem){.+.+}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
       lock_acquire kernel/locking/lockdep.c:5761 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
       down_read+0x9c/0x480 kernel/locking/rwsem.c:1520
       f2fs_down_read fs/f2fs/f2fs.h:2108 [inline]
       f2fs_getxattr+0xb96/0xfd0 fs/f2fs/xattr.c:532
       __f2fs_get_acl+0x59/0x610 fs/f2fs/acl.c:179
       f2fs_acl_create fs/f2fs/acl.c:377 [inline]
       f2fs_init_acl+0x152/0xb40 fs/f2fs/acl.c:420
       f2fs_init_inode_metadata+0x15d/0x1260 fs/f2fs/dir.c:558
       f2fs_do_tmpfile+0x33/0x1d0 fs/f2fs/dir.c:839
       __f2fs_tmpfile+0x1db/0x440 fs/f2fs/namei.c:884
       f2fs_ioc_start_atomic_write+0xcf4/0x1330 fs/f2fs/file.c:2099
       __f2fs_ioctl+0x317f/0xa5f0 fs/f2fs/file.c:4195
       f2fs_ioctl+0x194/0x220 fs/f2fs/file.c:4287
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x19d/0x210 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fi->i_sem);
                               lock(&fi->i_xattr_sem);
                               lock(&fi->i_sem);
  rlock(&fi->i_xattr_sem);

 *** DEADLOCK ***

5 locks held by syz-executor225/5016:
 #0: ffff88807a306410 (sb_writers#10){.+.+}-{0:0}, at: f2fs_ioc_start_atomic_write+0x1a7/0x1330 fs/f2fs/file.c:2056
 #1: ffff888072749250 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
 #1: ffff888072749250 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: f2fs_ioc_start_atomic_write+0x1e3/0x1330 fs/f2fs/file.c:2060
 #2: ffff888072749830 (&fi->i_gc_rwsem[WRITE]){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2133 [inline]
 #2: ffff888072749830 (&fi->i_gc_rwsem[WRITE]){+.+.}-{3:3}, at: f2fs_ioc_start_atomic_write+0x2e6/0x1330 fs/f2fs/file.c:2074
 #3: ffff88807ba403b0 (&sbi->cp_rwsem){.+.+}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2108 [inline]
 #3: ffff88807ba403b0 (&sbi->cp_rwsem){.+.+}-{3:3}, at: f2fs_lock_op fs/f2fs/f2fs.h:2151 [inline]
 #3: ffff88807ba403b0 (&sbi->cp_rwsem){.+.+}-{3:3}, at: __f2fs_tmpfile+0x1ae/0x440 fs/f2fs/namei.c:879
 #4: ffff88807274b668 (&fi->i_sem){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2133 [inline]
 #4: ffff88807274b668 (&fi->i_sem){+.+.}-{3:3}, at: f2fs_do_tmpfile+0x24/0x1d0 fs/f2fs/dir.c:838

stack backtrace:
CPU: 1 PID: 5016 Comm: syz-executor225 Not tainted 6.4.0-syzkaller-12491-gc192ac735768 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
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
 down_read+0x9c/0x480 kernel/locking/rwsem.c:1520
 f2fs_down_read fs/f2fs/f2fs.h:2108 [inline]
 f2fs_getxattr+0xb96/0xfd0 fs/f2fs/xattr.c:532
 __f2fs_get_acl+0x59/0x610 fs/f2fs/acl.c:179
 f2fs_acl_create fs/f2fs/acl.c:377 [inline]
 f2fs_init_acl+0x152/0xb40 fs/f2fs/acl.c:420
 f2fs_init_inode_metadata+0x15d/0x1260 fs/f2fs/dir.c:558
 f2fs_do_tmpfile+0x33/0x1d0 fs/f2fs/dir.c:839
 __f2fs_tmpfile+0x1db/0x440 fs/f2fs/namei.c:884
 f2fs_ioc_start_atomic_write+0xcf4/0x1330 fs/f2fs/file.c:2099
 __f2fs_ioctl+0x317f/0xa5f0 fs/f2fs/file.c:4195
 f2fs_ioctl+0x194/0x220 fs/f2fs/file.c:4287
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x19d/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe30f74c969
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc55cdfb78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe30f74c969
RDX: 0000000000000000 RSI: 000000000000f501 RDI: 0000000000000004
RBP: 00007fe30f70c200 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
