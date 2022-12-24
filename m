Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1113D655850
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Dec 2022 05:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiLXEDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 23:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiLXEDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 23:03:44 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5181219282
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Dec 2022 20:03:43 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id e9-20020a056e020b2900b003036757d5caso3564619ilu.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Dec 2022 20:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1UQUd3vyTkUP8x8Sf6RMJ97c9ni0l2jcysvOfEmp2g=;
        b=RTNP8sMkFWOQv9SiNC+x6lfV7aKId+1yeCdk4ZSKQglEdGXjW7d6uP1F1mGLdSPQ1A
         xWgsy79l1ExMUbOLADoYmc13D+qOIiEsIfj7KAe3vEWsvhV8IQiJecFIjAJsCz7eueNH
         snQOLiuCXfOlnmztSCjhIb462c+Q0CQD6xqBeucPbz5HrUCFN3conbeNyQGWi8TRtgF9
         I93+oWaD5CaWdut0vU2e+g77yJvIuiss2nZWro9530w6zeHW/zbi40GtYCN5nhzqXEw7
         VnimIPpMi1+m9sKeKeCupPRnmXwwxkb3xonKadoUM6LFiA6L+Ls9WiO41kC/jlch9Om3
         h2vg==
X-Gm-Message-State: AFqh2kqClhCvK6JeF5QcdUDeZSFC5IhKVosBLc4RtDwLVOj8SNP5++jq
        M41nWp5vd1ZX2bAnTAe33v8QaQ3iCDc1BgX8CJJbuPJvJh5q
X-Google-Smtp-Source: AMrXdXsQ1q0MvPM0cHGlSGHLwvqXS3+yhzNedTL4nqDc2r/iD7KAr4T549QlA7/CB+uevI4qiXcIimnpxSPM/KJmSrLhewoXCyi5
MIME-Version: 1.0
X-Received: by 2002:a02:620e:0:b0:376:2324:bfe1 with SMTP id
 d14-20020a02620e000000b003762324bfe1mr1078019jac.189.1671854622694; Fri, 23
 Dec 2022 20:03:42 -0800 (PST)
Date:   Fri, 23 Dec 2022 20:03:42 -0800
In-Reply-To: <000000000000aa6d8005f04d3d00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6ec2805f08afc11@google.com>
Subject: Re: [syzbot] [gfs2?] INFO: task hung in gfs2_jhead_process_page
From:   syzbot <syzbot+b9c5afe053a08cd29468@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, akpm@linux-foundation.org, brauner@kernel.org,
        broonie@kernel.org, catalin.marinas@arm.com,
        cluster-devel@redhat.com, ebiederm@xmission.com,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com, wangkefeng.wang@huawei.com,
        will@kernel.org, willy@infradead.org
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=172de6df880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=b9c5afe053a08cd29468
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116fc088480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1756e060480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/aa84169739f7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9c5afe053a08cd29468@syzkaller.appspotmail.com

INFO: task kworker/1:2:2221 blocked for more than 143 seconds.
      Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:0     pid:2221  ppid:2      flags:0x00000008
Workqueue: gfs_recovery gfs2_recover_func
Call trace:
 __switch_to+0x180/0x298 arch/arm64/kernel/process.c:555
 context_switch kernel/sched/core.c:5209 [inline]
 __schedule+0x408/0x594 kernel/sched/core.c:6521
 schedule+0x64/0xa4 kernel/sched/core.c:6597
 io_schedule+0x38/0xbc kernel/sched/core.c:8741
 folio_wait_bit_common+0x430/0x97c mm/filemap.c:1296
 folio_wait_bit+0x30/0x40 mm/filemap.c:1440
 folio_wait_locked include/linux/pagemap.h:1022 [inline]
 gfs2_jhead_process_page+0xb4/0x40c fs/gfs2/lops.c:476
 gfs2_find_jhead+0x450/0x50c fs/gfs2/lops.c:594
 gfs2_recover_func+0x278/0xcc8 fs/gfs2/recovery.c:460
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
INFO: task syz-executor189:3110 blocked for more than 143 seconds.
      Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor189 state:D stack:0     pid:3110  ppid:3109   flags:0x00000009
Call trace:
 __switch_to+0x180/0x298 arch/arm64/kernel/process.c:555
 context_switch kernel/sched/core.c:5209 [inline]
 __schedule+0x408/0x594 kernel/sched/core.c:6521
 schedule+0x64/0xa4 kernel/sched/core.c:6597
 bit_wait+0x18/0x60 kernel/sched/wait_bit.c:199
 __wait_on_bit kernel/sched/wait_bit.c:49 [inline]
 out_of_line_wait_on_bit+0xc8/0x140 kernel/sched/wait_bit.c:64
 wait_on_bit include/linux/wait_bit.h:76 [inline]
 gfs2_recover_journal+0xc0/0x104 fs/gfs2/recovery.c:577
 init_journal+0x930/0xcbc fs/gfs2/ops_fstype.c:835
 init_inodes+0x74/0x184 fs/gfs2/ops_fstype.c:889
 gfs2_fill_super+0x630/0x874 fs/gfs2/ops_fstype.c:1247
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1324
 gfs2_get_tree+0x30/0xc0 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x890 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/11:
 #0: ffff80000d4a4768 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/12:
 #0: ffff80000d4a4db8 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/27:
 #0: ffff80000d4a4640 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:303
2 locks held by kworker/1:2/2221:
 #0: ffff0000c028d138 ((wq_completion)gfs_recovery){+.+.}-{0:0}, at: process_one_work+0x270/0x504 kernel/workqueue.c:2262
 #1: ffff800015de3d80 ((work_completion)(&jd->jd_work)){+.+.}-{0:0}, at: process_one_work+0x29c/0x504 kernel/workqueue.c:2264
2 locks held by getty/2758:
 #0: ffff0000c535f098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x58 drivers/tty/tty_ldisc.c:244
 #1: ffff80000f6be2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x19c/0x89c drivers/tty/n_tty.c:2177
1 lock held by syz-executor189/3110:
 #0: ffff0000cb5ee0e0 (&type->s_umount_key#40/1){+.+.}-{3:3}, at: alloc_super+0xf8/0x430 fs/super.c:228

=============================================


