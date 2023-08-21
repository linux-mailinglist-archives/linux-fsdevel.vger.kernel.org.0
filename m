Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05414782E83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 18:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbjHUQhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 12:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbjHUQhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:37:01 -0400
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58855FD
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 09:36:58 -0700 (PDT)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1bf703dd1c0so17632525ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 09:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692635818; x=1693240618;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7eioG8X10phzcVb5mcEi18JC2dsf8vnTpbGQbYGNGZ8=;
        b=RkHVPmkL4yIjHXluGDzUd0QLpDThM0sMiJ3W5Aq/o1qKaMtPJ+dNAmgFuql9pwVH9a
         Y2tE5ArtIHcmO6fo8Ura4OaI+KOfv3LdY6Wv/h2ONUlwTfXZH8myPpH2KKY2cwrIsgtg
         GF4SfPqHTgBu43MCKrjBEHaO4E2PipBM8suaCYzFrJfjzqbUxL4dehMjYFMzas7cfU+k
         YLZ4i0DKAP2ajIgaIVQ9ALjAfhr1CVzVsFZCr5r6sGkMClVU/RUvjn9voYO3ZIRSMGCY
         3VHZh+e+Yjh0IePfR/0hjA0xmZZtt0VCZepH8uIiBHqRQ2lU9sIaKaDbj0ucSa4319Nq
         MvwQ==
X-Gm-Message-State: AOJu0YwLhRrUiVQcPKqpE8KNQu/a001h52jH74zau9g/IzsjtxLSZlbs
        6WcaLU/w3sJOljLBlZGHe1vqbDFrWyA7KQXSB6UxsV4x0Y47
X-Google-Smtp-Source: AGHT+IF9eCq8JhsUzlL0IgH1ngneNUWv9Rjlha+PW/FByrO32aRIc+Xkv4Q/sLgDDkmst36rHFaF+fMv6woY1D6Jw756gFmkgeTx
MIME-Version: 1.0
X-Received: by 2002:a17:902:e5cd:b0:1bf:cc5:7b57 with SMTP id
 u13-20020a170902e5cd00b001bf0cc57b57mr3379189plf.3.1692635817920; Mon, 21 Aug
 2023 09:36:57 -0700 (PDT)
Date:   Mon, 21 Aug 2023 09:36:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a958a90603717c84@google.com>
Subject: [syzbot] [ntfs3?] [squashfs?] INFO: task hung in truncate_inode_pages_final
From:   syzbot <syzbot+b6973d2babdaf51385eb@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, phillip@squashfs.org.uk,
        squashfs-devel@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c014c37159a1 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11904307a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b40c4aa62d29380a
dashboard link: https://syzkaller.appspot.com/bug?extid=b6973d2babdaf51385eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f81e5fa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d3b537a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/890b3d127b57/disk-c014c371.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/300e5c07650c/vmlinux-c014c371.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eb10f2f51203/Image-c014c371.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/03d2fd0e1068/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6973d2babdaf51385eb@syzkaller.appspotmail.com

INFO: task syz-executor142:6032 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc6-syzkaller-gc014c37159a1 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor142 state:D stack:0     pid:6032  ppid:6030   flags:0x00000004
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1364/0x23b4 kernel/sched/core.c:6710
 schedule+0xc4/0x170 kernel/sched/core.c:6786
 io_schedule+0x8c/0x12c kernel/sched/core.c:9028
 folio_wait_bit_common+0x65c/0xb90 mm/filemap.c:1304
 __folio_lock+0x2c/0x3c mm/filemap.c:1632
 folio_lock include/linux/pagemap.h:959 [inline]
 truncate_inode_pages_range+0x930/0xf74 mm/truncate.c:422
 truncate_inode_pages mm/truncate.c:449 [inline]
 truncate_inode_pages_final+0x90/0xc0 mm/truncate.c:484
 evict+0x26c/0x68c fs/inode.c:666
 dispose_list fs/inode.c:697 [inline]
 evict_inodes+0x6b4/0x74c fs/inode.c:747
 generic_shutdown_super+0x9c/0x328 fs/super.c:478
 kill_block_super+0x60/0xa0 fs/super.c:1417
 deactivate_locked_super+0xac/0x124 fs/super.c:330
 deactivate_super+0xe0/0x100 fs/super.c:361
 cleanup_mnt+0x34c/0x3dc fs/namespace.c:1254
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1261
 task_work_run+0x230/0x2e0 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x2180/0x3c90 arch/arm64/kernel/signal.c:1305
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:144 [inline]
 el0_svc+0xa0/0x16c arch/arm64/kernel/entry-common.c:679
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffff80008e2718d0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x44/0xcf4 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffff80008e271c90 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x44/0xcf4 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/29:
 #0: ffff80008e271700 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:302
2 locks held by getty/5744:
 #0: ffff0000d3f64098 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff8000959122f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x414/0x1214 drivers/tty/n_tty.c:2187
1 lock held by syz-executor142/6032:
 #0: ffff0000c77bc0e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: deactivate_super+0xd8/0x100 fs/super.c:360

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
