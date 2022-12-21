Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C272652DBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 09:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiLUIPH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 03:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiLUIOo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:14:44 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A879021886
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 00:14:41 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id l3-20020a056e021aa300b00304be32e9e5so9712529ilv.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 00:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7+8fuqPbIIauDX75GlkNV66FuhTqueE+eYRZ4kmpgo=;
        b=MUfCSPOb6NoFGI6yEQMnSRb1Xnmt5f2+DHSyuzg/1ApDa4HMTne6XTeYc7OxBxgpVk
         XIKpbdsWpU7RndFe15PL3b9jCdE/uA2i2IDbytbxRSIADFJMya1/vswlLKwDhkIJPY3u
         Bs5yRBM1td7tvAekcfiyvWJ4y9VHyXh8cXNLIqZFHPG7XdmQ5Hcc2YNx2DlzdmTDAEyI
         ls0J2BMEJhvLE4X+qU//6rMWWjWlGFWBvErVTnwJZbeu7uVM9/PAhFBIJ4Qj3DZg2vOq
         eSajl7mrw/mKvLRAPlY4xShVqcVP0br0o2Mv2LBBMjlEwT/OPnbfFVtTRe/pT7F3we3O
         MR0w==
X-Gm-Message-State: AFqh2kpmeeMbyyWsqGlKRGr28kG40zq4qH/oy0Jv2vzO0m+drcN6JkiJ
        CUl5Bi9OwPjX/WP+J59KlBcbdB3P6FigEOraJ9r6TjA5AVky
X-Google-Smtp-Source: AMrXdXupwWn7ThN+0DC+oN0Jgz8FQ2+SYhQnb2YaIdKCjtpr7VtKkMb0ZcHkelzjW9Gypy+7024Cj0HmUL/p40wDZcBnzKwGnaE1
MIME-Version: 1.0
X-Received: by 2002:a92:4442:0:b0:303:c52:274a with SMTP id
 a2-20020a924442000000b003030c52274amr90595ilm.171.1671610481055; Wed, 21 Dec
 2022 00:14:41 -0800 (PST)
Date:   Wed, 21 Dec 2022 00:14:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed1df405f05224aa@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state
From:   syzbot <syzbot+f91c29a5d5a01ada051a@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, bvanassche@acm.org,
        hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        viro@zeniv.linux.org.uk, yanaijie@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    aeba12b26c79 Merge tag 'nfsd-6.2-1' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1655e690480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d348fc1e0f483c9
dashboard link: https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15332c9b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16647dc8480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/661fe33f851b/disk-aeba12b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c938bdcf3ad0/vmlinux-aeba12b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7f738de30b7/bzImage-aeba12b2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b4ed1012076c/mount_0.gz

The issue was bisected to:

commit d9a434fa0c12ed5f7afe1e9dd30003ab5d059b85
Author: Jason Yan <yanaijie@huawei.com>
Date:   Wed Jul 20 02:51:20 2022 +0000

    scsi: core: Fix warning in scsi_alloc_sgtables()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a1c453880000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a1c453880000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a1c453880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f91c29a5d5a01ada051a@syzkaller.appspotmail.com
Fixes: d9a434fa0c12 ("scsi: core: Fix warning in scsi_alloc_sgtables()")

ntfs3: loop0: ino=5, ntfs_iget5
============================================
WARNING: possible recursive locking detected
6.1.0-syzkaller-13781-gaeba12b26c79 #0 Not tainted
--------------------------------------------
kworker/u4:6/3799 is trying to acquire lock:
ffff888076a40100 (&ni->ni_lock){+.+.}-{3:3}, at: ntfs_set_state+0x1da/0x680 fs/ntfs3/fsntfs.c:920

but task is already holding lock:
ffff888076a46fa0 (&ni->ni_lock){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1123 [inline]
ffff888076a46fa0 (&ni->ni_lock){+.+.}-{3:3}, at: ni_write_inode+0x14d/0x11e0 fs/ntfs3/frecord.c:3226

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ni->ni_lock);
  lock(&ni->ni_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/u4:6/3799:
 #0: ffff88814514c138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc9000ecc7d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
 #2: ffff888076a46fa0 (&ni->ni_lock){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1123 [inline]
 #2: ffff888076a46fa0 (&ni->ni_lock){+.+.}-{3:3}, at: ni_write_inode+0x14d/0x11e0 fs/ntfs3/frecord.c:3226

stack backtrace:
CPU: 0 PID: 3799 Comm: kworker/u4:6 Not tainted 6.1.0-syzkaller-13781-gaeba12b26c79 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2990 [inline]
 check_deadlock kernel/locking/lockdep.c:3033 [inline]
 validate_chain+0x4843/0x6ae0 kernel/locking/lockdep.c:3818
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 ntfs_set_state+0x1da/0x680 fs/ntfs3/fsntfs.c:920
 ntfs_iget5+0x34c/0x36f0 fs/ntfs3/inode.c:504
 ni_update_parent+0x7ea/0xc60 fs/ntfs3/frecord.c:3182
 ni_write_inode+0xe30/0x11e0 fs/ntfs3/frecord.c:3277
 write_inode fs/fs-writeback.c:1451 [inline]
 __writeback_single_inode+0x4d6/0x670 fs/fs-writeback.c:1663
 writeback_sb_inodes+0x812/0x1050 fs/fs-writeback.c:1889
 wb_writeback+0x41f/0x7b0 fs/fs-writeback.c:2063
 wb_do_writeback fs/fs-writeback.c:2206 [inline]
 wb_workfn+0x3cb/0xef0 fs/fs-writeback.c:2246
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
