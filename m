Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C605A6F9E4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 05:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjEHDnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 23:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjEHDnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 23:43:18 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D1C59D8
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 May 2023 20:42:46 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-32afe238257so27498695ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 May 2023 20:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683517365; x=1686109365;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AD/Uj1Q/goXoaqsQL8mKoMpw3all4e+dW7FDARqYfq4=;
        b=deS1KjeNIEhepdw7pzFuvQYFfMSAtGPu64ZYpA6NtLiFMAi25E3Jdus3G55bGJXBGX
         At9kXW7kShoTCXvXaazz3RtsRc/CGYp/d4U7DPTy1WRwLzrsQ8/fgTiuafk+YmE5VXkH
         jvE3i0VtEi24Xmj8kfmVf7wrL3T32ldyTz95gOrM1dq/hNHwKIRnB60l0pIz6msh0LTg
         +4Obs7yxjJcAqYfRDqCb/+RrQXIH+x2ungc4LjuXjQd4ux51M6BPO34RqOf/85Uh87Cw
         nbQdvlg/lrDipCAEidr9R9EscFYjV/ywbn2fher8dX4d5MHb/CKuLUQ8qOUCuNQtroOQ
         jp+Q==
X-Gm-Message-State: AC+VfDz5XR7Hc2orZsg+1Wzjdwx17K90OCnECL+1TE8mKm+A9MK8NoCo
        qF4FTLBA68CLAHMQx954s5vW54UJPJ4jfneUy6kh8uUgenAZ
X-Google-Smtp-Source: ACHHUZ74DD54/wnbAWiVmUxISXDc7bGPfFZmLXF0c1G5UYocjb6eO3+WHWPNBBKT/FKFwgKOhGmGsWExOBU6q8HxQNGTqDwcOXEz
MIME-Version: 1.0
X-Received: by 2002:a92:dc45:0:b0:32b:1c9f:3c48 with SMTP id
 x5-20020a92dc45000000b0032b1c9f3c48mr4933020ilq.1.1683517365516; Sun, 07 May
 2023 20:42:45 -0700 (PDT)
Date:   Sun, 07 May 2023 20:42:45 -0700
In-Reply-To: <000000000000e15c0905f8c5101b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b80c905fb266ec4@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_multi_mount_protect
From:   syzbot <syzbot+6b7df7d5506b32467149@syzkaller.appspotmail.com>
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

HEAD commit:    14f8db1c0f9a Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1168e64c280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a837a8ba7e88bb45
dashboard link: https://syzkaller.appspot.com/bug?extid=6b7df7d5506b32467149
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159b92b8280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14355e4c280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad6ce516eed3/disk-14f8db1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f38c2cc7667/vmlinux-14f8db1c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d795115eee39/Image-14f8db1c.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/36779692cd0c/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b7df7d5506b32467149@syzkaller.appspotmail.com

EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: writeback.
======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc7-syzkaller-g14f8db1c0f9a #0 Not tainted
------------------------------------------------------
syz-executor258/5925 is trying to acquire lock:
ffff0000dba3c460 (sb_writers#3){.+.+}-{0:0}, at: ext4_multi_mount_protect+0x2f8/0x8c8 fs/ext4/mmp.c:343

but task is already holding lock:
ffff0000dba3c0e0 (&type->s_umount_key#29){++++}-{3:3}, at: vfs_fsconfig_locked fs/fsopen.c:253 [inline]
ffff0000dba3c0e0 (&type->s_umount_key#29){++++}-{3:3}, at: __do_sys_fsconfig fs/fsopen.c:439 [inline]
ffff0000dba3c0e0 (&type->s_umount_key#29){++++}-{3:3}, at: __se_sys_fsconfig fs/fsopen.c:314 [inline]
ffff0000dba3c0e0 (&type->s_umount_key#29){++++}-{3:3}, at: __arm64_sys_fsconfig+0xa14/0xd18 fs/fsopen.c:314

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&type->s_umount_key#29){++++}-{3:3}:
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1573
       __do_sys_quotactl_fd fs/quota/quota.c:997 [inline]
       __se_sys_quotactl_fd fs/quota/quota.c:972 [inline]
       __arm64_sys_quotactl_fd+0x2fc/0x4a4 fs/quota/quota.c:972
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
       el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

-> #0 (sb_writers#3){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x3338/0x764c kernel/locking/lockdep.c:5056
       lock_acquire+0x238/0x718 kernel/locking/lockdep.c:5669
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1477 [inline]
       sb_start_write include/linux/fs.h:1552 [inline]
       write_mmp_block+0xe4/0xb70 fs/ext4/mmp.c:50
       ext4_multi_mount_protect+0x2f8/0x8c8 fs/ext4/mmp.c:343
       __ext4_remount fs/ext4/super.c:6543 [inline]
       ext4_reconfigure+0x2180/0x2928 fs/ext4/super.c:6642
       reconfigure_super+0x328/0x738 fs/super.c:956
       vfs_fsconfig_locked fs/fsopen.c:254 [inline]
       __do_sys_fsconfig fs/fsopen.c:439 [inline]
       __se_sys_fsconfig fs/fsopen.c:314 [inline]
       __arm64_sys_fsconfig+0xa1c/0xd18 fs/fsopen.c:314
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
  lock(&type->s_umount_key#29);
                               lock(sb_writers#3);
                               lock(&type->s_umount_key#29);
  lock(sb_writers#3);

 *** DEADLOCK ***

2 locks held by syz-executor258/5925:
 #0: ffff0000d5b8a470 (&fc->uapi_mutex){+.+.}-{3:3}, at: __do_sys_fsconfig fs/fsopen.c:437 [inline]
 #0: ffff0000d5b8a470 (&fc->uapi_mutex){+.+.}-{3:3}, at: __se_sys_fsconfig fs/fsopen.c:314 [inline]
 #0: ffff0000d5b8a470 (&fc->uapi_mutex){+.+.}-{3:3}, at: __arm64_sys_fsconfig+0x720/0xd18 fs/fsopen.c:314
 #1: ffff0000dba3c0e0 (&type->s_umount_key#29){++++}-{3:3}, at: vfs_fsconfig_locked fs/fsopen.c:253 [inline]
 #1: ffff0000dba3c0e0 (&type->s_umount_key#29){++++}-{3:3}, at: __do_sys_fsconfig fs/fsopen.c:439 [inline]
 #1: ffff0000dba3c0e0 (&type->s_umount_key#29){++++}-{3:3}, at: __se_sys_fsconfig fs/fsopen.c:314 [inline]
 #1: ffff0000dba3c0e0 (&type->s_umount_key#29){++++}-{3:3}, at: __arm64_sys_fsconfig+0xa14/0xd18 fs/fsopen.c:314

stack backtrace:
CPU: 0 PID: 5925 Comm: syz-executor258 Not tainted 6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
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
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1477 [inline]
 sb_start_write include/linux/fs.h:1552 [inline]
 write_mmp_block+0xe4/0xb70 fs/ext4/mmp.c:50
 ext4_multi_mount_protect+0x2f8/0x8c8 fs/ext4/mmp.c:343
 __ext4_remount fs/ext4/super.c:6543 [inline]
 ext4_reconfigure+0x2180/0x2928 fs/ext4/super.c:6642
 reconfigure_super+0x328/0x738 fs/super.c:956
 vfs_fsconfig_locked fs/fsopen.c:254 [inline]
 __do_sys_fsconfig fs/fsopen.c:439 [inline]
 __se_sys_fsconfig fs/fsopen.c:314 [inline]
 __arm64_sys_fsconfig+0xa1c/0xd18 fs/fsopen.c:314
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
EXT4-fs warning (device loop0): ext4_enable_quotas:7001: Failed to enable quota tracking (type=2, err=-22, ino=15). Please run e2fsck to fix.


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
