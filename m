Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C6E7BE272
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 16:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377647AbjJIOTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377628AbjJIOTq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:19:46 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A9FED
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 07:19:40 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3ae3d83145cso6919839b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 07:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696861180; x=1697465980;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TGWQAlp8UuYQhA52ZWaujZvCAShLjeIRZ1glRL7WKI=;
        b=UqIy6/p92qsofZD6SzcHTLLmI+d7nJ/0IRQRQoap3Evkzykq++N2px9QKHobNijU1v
         8VobnorEv7KgyVZ6VZ4SXazHcI8a9+Hr73zk+frRj/e4gHgSvTKXjio3kQO5AGE8Y/yn
         ZvBwNu3S4ClBvjGLpKWq3l/EU+3dOUtxdsxTo021HbLFmW0h0Zyup9Ic/l/rGjLkpUS5
         RkD46quNr+UvjmuVxJGPpnkVLfhRSCQri8jRjz7bgQ0IGApn4IhlKDgXOvyPWbY8CcYP
         o6zwSJrs/fx7sUk0fZL1Wx4g/yuECLGPjuQL+NBGnuI0bTXc1qiPczxxIhum3MOAzD6P
         8cWA==
X-Gm-Message-State: AOJu0YyRSlCoX6v3sbu29gu7kJ5XWZNZYt82MTphF+Dd8GJEHvrON4ZW
        MSxc1U4yUSVhkXs0xqwgkFuOrz9f479HjD2P6PaSJgdqrTdu
X-Google-Smtp-Source: AGHT+IF8k7g0eSiSkI0Ync143FSHXVQo54adV+KV5FBCMFaXl+hqfgqHiK68ktgDtgtIhiy6neQ2zCz/2mSRkRXFkrZ/R/d9uXLc
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2190:b0:3a8:45f0:b83a with SMTP id
 be16-20020a056808219000b003a845f0b83amr6406561oib.5.1696861179851; Mon, 09
 Oct 2023 07:19:39 -0700 (PDT)
Date:   Mon, 09 Oct 2023 07:19:39 -0700
In-Reply-To: <20231009-leihgabe-abseilen-26e86d03f787@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbce480607494722@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
From:   syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, brauner@kernel.org, chao@kernel.org,
        daniel.vetter@ffwll.ch, hdanton@sina.com, jack@suse.cz,
        jaegeuk@kernel.org, jinpu.wang@ionos.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mairacanal@riseup.net, mcanal@igalia.com,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        terrelln@fb.com, willy@infradead.org, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in blkdev_put

INFO: task syz-executor.1:6676 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc5-syzkaller-gb6ab131813c2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:0     pid:6676  ppid:6383   flags:0x00000005
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1364/0x23b4 kernel/sched/core.c:6695
 schedule+0xc4/0x170 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6830
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 blkdev_put+0xec/0x740 block/bdev.c:884
 blkdev_release+0x84/0x9c block/fops.c:604
 __fput+0x324/0x7f8 fs/file_table.c:384
 __fput_sync+0x60/0x9c fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __arm64_sys_close+0x150/0x1e0 fs/open.c:1557
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
INFO: task syz-executor.2:6678 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc5-syzkaller-gb6ab131813c2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:0     pid:6678  ppid:6377   flags:0x00000005
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1364/0x23b4 kernel/sched/core.c:6695
 schedule+0xc4/0x170 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6830
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 blkdev_put+0xec/0x740 block/bdev.c:884
 blkdev_release+0x84/0x9c block/fops.c:604
 __fput+0x324/0x7f8 fs/file_table.c:384
 __fput_sync+0x60/0x9c fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __arm64_sys_close+0x150/0x1e0 fs/open.c:1557
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
INFO: task syz-executor.0:6682 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc5-syzkaller-gb6ab131813c2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:0     pid:6682  ppid:6389   flags:0x0000000d
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1364/0x23b4 kernel/sched/core.c:6695
 schedule+0xc4/0x170 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6830
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 bd_finish_claiming+0x218/0x3dc block/bdev.c:566
 blkdev_get_by_dev+0x3f4/0x55c block/bdev.c:799
 journal_init_dev fs/reiserfs/journal.c:2616 [inline]
 journal_init+0xb08/0x1e68 fs/reiserfs/journal.c:2783
 reiserfs_fill_super+0xd58/0x2058 fs/reiserfs/super.c:2029
 mount_bdev+0x1e8/0x2b4 fs/super.c:1629
 get_super_block+0x44/0x58 fs/reiserfs/super.c:2605
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:638
 vfs_get_tree+0x90/0x288 fs/super.c:1750
 do_new_mount+0x25c/0x8c8 fs/namespace.c:3335
 path_mount+0x590/0xe04 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3861
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
INFO: task syz-executor.3:6690 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc5-syzkaller-gb6ab131813c2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:0     pid:6690  ppid:6373   flags:0x0000000d
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1364/0x23b4 kernel/sched/core.c:6695
 schedule+0xc4/0x170 kernel/sched/core.c:6771
 super_lock+0x23c/0x328 fs/super.c:134
 super_lock_shared fs/super.c:146 [inline]
 super_lock_shared_active fs/super.c:1431 [inline]
 fs_bdev_sync+0xa4/0x168 fs/super.c:1466
 blkdev_flushbuf block/ioctl.c:372 [inline]
 blkdev_common_ioctl+0x848/0x2884 block/ioctl.c:502
 blkdev_ioctl+0x35c/0xae4 block/ioctl.c:624
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
INFO: task syz-executor.3:6695 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc5-syzkaller-gb6ab131813c2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:0     pid:6695  ppid:6373   flags:0x00000005
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1364/0x23b4 kernel/sched/core.c:6695
 schedule+0xc4/0x170 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6830
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
 loop_configure+0x15c/0xfd4 drivers/block/loop.c:1018
 lo_ioctl+0xc70/0x1d04
 blkdev_ioctl+0x3e4/0xae4 block/ioctl.c:630
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
INFO: task syz-executor.5:6696 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc5-syzkaller-gb6ab131813c2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:0     pid:6696  ppid:6381   flags:0x00000005
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1364/0x23b4 kernel/sched/core.c:6695
 schedule+0xc4/0x170 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6830
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
 blkdev_open+0x128/0x2b0 block/fops.c:589
 do_dentry_open+0x6fc/0x118c fs/open.c:929
 vfs_open+0x7c/0x90 fs/open.c:1063
 do_open fs/namei.c:3639 [inline]
 path_openat+0x1f2c/0x27f8 fs/namei.c:3796
 do_filp_open+0x1bc/0x3cc fs/namei.c:3823
 do_sys_openat2+0x124/0x1b8 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1448
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
INFO: task syz-executor.5:6703 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc5-syzkaller-gb6ab131813c2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:0     pid:6703  ppid:6381   flags:0x00000005
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1364/0x23b4 kernel/sched/core.c:6695
 schedule+0xc4/0x170 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6830
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
 loop_configure+0x15c/0xfd4 drivers/block/loop.c:1018
 lo_ioctl+0xc70/0x1d04
 blkdev_ioctl+0x3e4/0xae4 block/ioctl.c:630
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
INFO: task syz-executor.4:6698 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc5-syzkaller-gb6ab131813c2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:0     pid:6698  ppid:6384   flags:0x00000005
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1364/0x23b4 kernel/sched/core.c:6695
 schedule+0xc4/0x170 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6830
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
 blkdev_open+0x128/0x2b0 block/fops.c:589
 do_dentry_open+0x6fc/0x118c fs/open.c:929
 vfs_open+0x7c/0x90 fs/open.c:1063
 do_open fs/namei.c:3639 [inline]
 path_openat+0x1f2c/0x27f8 fs/namei.c:3796
 do_filp_open+0x1bc/0x3cc fs/namei.c:3823
 do_sys_openat2+0x124/0x1b8 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1448
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
INFO: task syz-executor.4:6704 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc5-syzkaller-gb6ab131813c2 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:0     pid:6704  ppid:6384   flags:0x00000005
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1364/0x23b4 kernel/sched/core.c:6695
 schedule+0xc4/0x170 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6830
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
 loop_configure+0x15c/0xfd4 drivers/block/loop.c:1018
 lo_ioctl+0xc70/0x1d04
 blkdev_ioctl+0x3e4/0xae4 block/ioctl.c:630
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffff80008e3739c0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:302
2 locks held by kworker/u4:6/235:
2 locks held by getty/5770:
 #0: ffff0000d6cf20a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff8000959f02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x414/0x1214 drivers/tty/n_tty.c:2206
1 lock held by syz-executor.1/6676:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0xec/0x740 block/bdev.c:884
1 lock held by syz-executor.2/6678:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0xec/0x740 block/bdev.c:884
3 locks held by syz-executor.0/6682:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
 #1: ffff80008e1748a8 (bdev_lock){+.+.}-{3:3}, at: bd_finish_claiming+0x84/0x3dc block/bdev.c:557
 #2: ffff0000c1543a88 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: bd_finish_claiming+0x218/0x3dc block/bdev.c:566
1 lock held by syz-executor.3/6690:
 #0: ffff0000c1543a88 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: blkdev_flushbuf block/ioctl.c:370 [inline]
 #0: ffff0000c1543a88 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: blkdev_common_ioctl+0x7fc/0x2884 block/ioctl.c:502
1 lock held by syz-executor.3/6695:
 #0: ffff80008e1748a8 (bdev_lock){+.+.}-{3:3}, at: bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
1 lock held by syz-executor.5/6696:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
1 lock held by syz-executor.5/6703:
 #0: ffff80008e1748a8 (bdev_lock){+.+.}-{3:3}, at: bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
1 lock held by syz-executor.4/6698:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
1 lock held by syz-executor.4/6704:
 #0: ffff80008e1748a8 (bdev_lock){+.+.}-{3:3}, at: bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
1 lock held by syz-executor.0/6872:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
1 lock held by syz-executor.1/6939:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
1 lock held by syz-executor.1/6940:
 #0: ffff80008e1748a8 (bdev_lock){+.+.}-{3:3}, at: bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
1 lock held by syz-executor.2/6956:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
1 lock held by syz-executor.2/6957:
 #0: ffff80008e1748a8 (bdev_lock){+.+.}-{3:3}, at: bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
1 lock held by syz-executor.5/6959:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
1 lock held by syz-executor.5/6960:
 #0: ffff80008e1748a8 (bdev_lock){+.+.}-{3:3}, at: bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
1 lock held by syz-executor.3/6976:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
1 lock held by syz-executor.3/6977:
 #0: ffff80008e1748a8 (bdev_lock){+.+.}-{3:3}, at: bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
1 lock held by syz-executor.4/6979:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
1 lock held by syz-executor.4/6980:
 #0: ffff80008e1748a8 (bdev_lock){+.+.}-{3:3}, at: bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
1 lock held by syz-executor.1/6999:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
1 lock held by syz-executor.1/7000:
 #0: ffff80008e1748a8 (bdev_lock){+.+.}-{3:3}, at: bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
1 lock held by syz-executor.2/7054:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
1 lock held by syz-executor.2/7055:
 #0: ffff80008e1748a8 (bdev_lock){+.+.}-{3:3}, at: bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
1 lock held by syz-executor.5/7067:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
1 lock held by syz-executor.5/7068:
 #0: ffff80008e1748a8 (bdev_lock){+.+.}-{3:3}, at: bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
1 lock held by syz-executor.3/7075:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
1 lock held by syz-executor.3/7078:
 #0: ffff80008e1748a8 (bdev_lock){+.+.}-{3:3}, at: bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508
1 lock held by syz-executor.4/7083:
 #0: ffff0000c9ce34c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
1 lock held by syz-executor.4/7084:
 #0: ffff80008e1748a8 (bdev_lock){+.+.}-{3:3}, at: bd_prepare_to_claim+0x1a4/0x49c block/bdev.c:508

=============================================



Tested on:

commit:         b6ab1318 reiserfs: fix journal device opening
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git b4/vfs-fixes-reiserfs
console output: https://syzkaller.appspot.com/x/log.txt?x=125bdcde680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b8c825e0d5f3f72
dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
