Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600925641DA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 19:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiGBR1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Jul 2022 13:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiGBR1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Jul 2022 13:27:32 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3325FE012
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Jul 2022 10:27:31 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id k10-20020a056e021a8a00b002dacb91b6ebso2614149ilv.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Jul 2022 10:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dTAC6yIXCZBxw+p2OErqKUaqKTzBG5E7gPda2WRrS70=;
        b=N6rlmRAgrrbaTop/KNqkDE47XMBJ/8kMhkJkopHzFQMaH3u+2LY27UJlvMVHVjPDEv
         VoTwwzM49SjbTAMN1Ih1/LMBCs9hYFhHlzYueKoZo1CQKhqk6bcS6zcpvj4oAV6AP48P
         PJgdS3wfK/dc8gbJyVFEA5E3x1WFrwenz+DDEAov+SJjbHeMR8GLIjcPHhZJpT/U6Acu
         t2IS+ITonbEzPC4mweoLk3/1Wtq2ZTMMjogplZ02DKA3wY/IjfeJ37/CRe9z1rNcEBKB
         +++OUr8zd7a4DmXP5gIWeM8cuw4dMyTUfngaleiObUGL40bfdQjyomiQtPmX/OrygV1m
         H1QQ==
X-Gm-Message-State: AJIora/5v8A68U8BwmIWnE5sneFK0YP5b+ro32idL3Rt2HjS9ceHS+1w
        9DHSq/qf32p3vogdNZQgMt8EvGBlf6REaz9FQoF/nzq8tnIC
X-Google-Smtp-Source: AGRyM1upGQbN8M2U3E6dSGQcI8Sf0xsGM0IyEwcytHdaebO/6yBNpoAlUFJ8z0B8bOXAtCESh6FexaFKMm1MdyphULXdYZGq0uld
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1562:b0:2d9:434d:25b4 with SMTP id
 k2-20020a056e02156200b002d9434d25b4mr12384635ilu.59.1656782850516; Sat, 02
 Jul 2022 10:27:30 -0700 (PDT)
Date:   Sat, 02 Jul 2022 10:27:30 -0700
In-Reply-To: <00000000000067d24205c4d0e599@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000466f0d05e2d5d1d1@google.com>
Subject: Re: [syzbot] possible deadlock in mnt_want_write (2)
From:   syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, zohar@us.ibm.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    089866061428 Merge tag 'libnvdimm-fixes-5.19-rc5' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11dd91f0080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75c9ff14e1db87c0
dashboard link: https://syzkaller.appspot.com/bug?extid=b42fe626038981fb7bfa
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167bafc0080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aad3e0080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.19.0-rc4-syzkaller-00187-g089866061428 #0 Not tainted
------------------------------------------------------
syz-executor450/3829 is trying to acquire lock:
ffff88807e574460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:393

but task is already holding lock:
ffff888074de91a0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x7d2/0x1c10 security/integrity/ima/ima_main.c:260

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&iint->mutex){+.+.}-{3:3}:
       lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5665
       __mutex_lock_common+0x1de/0x26c0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       process_measurement+0x7d2/0x1c10 security/integrity/ima/ima_main.c:260
       ima_file_check+0xe7/0x160 security/integrity/ima/ima_main.c:517
       do_open fs/namei.c:3522 [inline]
       path_openat+0x2705/0x2ec0 fs/namei.c:3653
       do_filp_open+0x277/0x4f0 fs/namei.c:3680
       do_sys_openat2+0x13b/0x500 fs/open.c:1278
       do_sys_open fs/open.c:1294 [inline]
       __do_sys_open fs/open.c:1302 [inline]
       __se_sys_open fs/open.c:1298 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1298
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

-> #0 (sb_writers#4){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain+0x185c/0x65c0 kernel/locking/lockdep.c:3829
       __lock_acquire+0x129a/0x1f80 kernel/locking/lockdep.c:5053
       lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5665
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1699 [inline]
       sb_start_write+0x4d/0x1a0 include/linux/fs.h:1774
       mnt_want_write+0x3b/0x80 fs/namespace.c:393
       ovl_maybe_copy_up+0x124/0x190 fs/overlayfs/copy_up.c:1078
       ovl_open+0x106/0x2a0 fs/overlayfs/file.c:152
       do_dentry_open+0x789/0x1040 fs/open.c:848
       vfs_open fs/open.c:981 [inline]
       dentry_open+0xc1/0x120 fs/open.c:997
       ima_calc_file_hash+0x157/0x1cb0 security/integrity/ima/ima_crypto.c:557
       ima_collect_measurement+0x3de/0x850 security/integrity/ima/ima_api.c:292
       process_measurement+0xf87/0x1c10 security/integrity/ima/ima_main.c:337
       ima_file_check+0xe7/0x160 security/integrity/ima/ima_main.c:517
       do_open fs/namei.c:3522 [inline]
       path_openat+0x2705/0x2ec0 fs/namei.c:3653
       do_filp_open+0x277/0x4f0 fs/namei.c:3680
       do_sys_openat2+0x13b/0x500 fs/open.c:1278
       do_sys_open fs/open.c:1294 [inline]
       __do_sys_open fs/open.c:1302 [inline]
       __se_sys_open fs/open.c:1298 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1298
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&iint->mutex);
                               lock(sb_writers#4);
                               lock(&iint->mutex);
  lock(sb_writers#4);

 *** DEADLOCK ***

1 lock held by syz-executor450/3829:
 #0: ffff888074de91a0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x7d2/0x1c10 security/integrity/ima/ima_main.c:260

stack backtrace:
CPU: 1 PID: 3829 Comm: syz-executor450 Not tainted 5.19.0-rc4-syzkaller-00187-g089866061428 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 check_noncircular+0x2f7/0x3b0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain+0x185c/0x65c0 kernel/locking/lockdep.c:3829
 __lock_acquire+0x129a/0x1f80 kernel/locking/lockdep.c:5053
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5665
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1699 [inline]
 sb_start_write+0x4d/0x1a0 include/linux/fs.h:1774
 mnt_want_write+0x3b/0x80 fs/namespace.c:393
 ovl_maybe_copy_up+0x124/0x190 fs/overlayfs/copy_up.c:1078
 ovl_open+0x106/0x2a0 fs/overlayfs/file.c:152
 do_dentry_open+0x789/0x1040 fs/open.c:848
 vfs_open fs/open.c:981 [inline]
 dentry_open+0xc1/0x120 fs/open.c:997
 ima_calc_file_hash+0x157/0x1cb0 security/integrity/ima/ima_crypto.c:557
 ima_collect_measurement+0x3de/0x850 security/integrity/ima/ima_api.c:292
 process_measurement+0xf87/0x1c10 security/integrity/ima/ima_main.c:337
 ima_file_check+0xe7/0x160 security/integrity/ima/ima_main.c:517
 do_open fs/namei.c:3522 [inline]
 path_openat+0x2705/0x2ec0 fs/namei.c:3653
 do_filp_open+0x277/0x4f0 fs/namei.c:3680
 do_sys_openat2+0x13b/0x500 fs/open.c:1278
 do_sys_open fs/open.c:1294 [inline]
 __do_sys_open fs/open.c:1302 [inline]
 __se_sys_open fs/open.c:1298 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1298
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7faf98402749
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 16 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faf9838e2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007faf98491270 RCX: 00007faf98402749
RDX: 0000000000000000 RSI: 000000000000000b RDI: 00000000200000c0
RBP: 00007faf98458504 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 3d7269647265776f R14: 0079616c7265766f R15: 00007faf98491278
 </TASK>

