Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234AC747E7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 09:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjGEHsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 03:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjGEHr5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:47:57 -0400
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8052110F5
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 00:47:56 -0700 (PDT)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-262c77ffb9dso8814210a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jul 2023 00:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688543276; x=1691135276;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ksxuF98/9I1+2GaTPM9459hTAjCKV1tw7C+LZwLkD6s=;
        b=d5hogg78YjQFxvOW2uazMEejIS1FtaoA4Tv7xC6pJzsZJ3F1HQrufLu2A8bCV3f2Wm
         MAgxfh04TEIJ8WogUkhLbXnsENQ2/8887OC4OoPHMdGKkeRfvUrH5QBQrCRRmcX22eVl
         ZlfW88irEwXhyCv57YdlfCJC1MwNnznv88gcu2zV4fKGFwhvKLNWahTBtX3Hbjo94yT2
         zmvNhuE3O7xEo/+OWsPX4azFZ+lSAEkQTIWDgyZ8NsTINGk4iJioA+0nu1eB+yqJtiyz
         6dMr9T3D8gA1Lk7s98G933MUhDMxIpgwcSU/VgFD/Mit4eijODVTywZ3mPujWU/Eop/+
         ZbAg==
X-Gm-Message-State: ABy/qLYb4hpM9jhY4UzUUXwI9zLpEmH4XhNCgi6CW5ginH6JAfolHQgQ
        4KvOxEv1bO7JkQKFmcUwWTatH/+vBBeQc7Sp85BgNBtj4din
X-Google-Smtp-Source: APBJJlHLWerl9bexKU9f+tdHq6hOYsbpgUIpuf91rK1Yrg7yKTLvXOSTrP3eAnFMJ6YLNsiYOhQakHZ7fePYjespkbxjywOZfDTJ
MIME-Version: 1.0
X-Received: by 2002:a17:90a:fe15:b0:262:ffae:56cf with SMTP id
 ck21-20020a17090afe1500b00262ffae56cfmr11920115pjb.8.1688543276038; Wed, 05
 Jul 2023 00:47:56 -0700 (PDT)
Date:   Wed, 05 Jul 2023 00:47:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027fff505ffb89e4d@google.com>
Subject: [syzbot] [btrfs?] inconsistent lock state in btrfs_add_delayed_iput
From:   syzbot <syzbot+9786684f27757c60b3cc@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a507db1d8fdc Merge tag '6.5-rc-smb3-client-fixes-part1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a12fcb280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f27fb02fc20d955
dashboard link: https://syzkaller.appspot.com/bug?extid=9786684f27757c60b3cc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a507db1d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e3b240f6b5a8/vmlinux-a507db1d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b78f45d88875/bzImage-a507db1d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9786684f27757c60b3cc@syzkaller.appspotmail.com

WARNING: inconsistent lock state
6.4.0-syzkaller-09904-ga507db1d8fdc #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
ksoftirqd/3/32 [HC0[0]:SC1[1]:HE1:SE0] takes:
ffff888025dd0d20 (&fs_info->delayed_iput_lock){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:350 [inline]
ffff888025dd0d20 (&fs_info->delayed_iput_lock){+.?.}-{2:2}, at: btrfs_add_delayed_iput+0x128/0x390 fs/btrfs/inode.c:3490
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5761 [inline]
  lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:350 [inline]
  btrfs_run_delayed_iputs+0x28/0xe0 fs/btrfs/inode.c:3523
  close_ctree+0x217/0xf70 fs/btrfs/disk-io.c:4315
  generic_shutdown_super+0x158/0x480 fs/super.c:499
  kill_anon_super+0x3a/0x60 fs/super.c:1110
  btrfs_kill_super+0x3c/0x50 fs/btrfs/super.c:2138
  deactivate_locked_super+0x98/0x160 fs/super.c:330
  deactivate_super+0xb1/0xd0 fs/super.c:361
  cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1254
  task_work_run+0x16f/0x270 kernel/task_work.c:179
  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
  exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
  exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
  __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
  syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
  do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
irq event stamp: 215394
hardirqs last  enabled at (215394): [<ffffffff81d5ebc4>] __do_kmem_cache_free mm/slab.c:3558 [inline]
hardirqs last  enabled at (215394): [<ffffffff81d5ebc4>] kmem_cache_free mm/slab.c:3582 [inline]
hardirqs last  enabled at (215394): [<ffffffff81d5ebc4>] kmem_cache_free+0x244/0x370 mm/slab.c:3575
hardirqs last disabled at (215393): [<ffffffff81d5eb5e>] __do_kmem_cache_free mm/slab.c:3553 [inline]
hardirqs last disabled at (215393): [<ffffffff81d5eb5e>] kmem_cache_free mm/slab.c:3582 [inline]
hardirqs last disabled at (215393): [<ffffffff81d5eb5e>] kmem_cache_free+0x1de/0x370 mm/slab.c:3575
softirqs last  enabled at (215364): [<ffffffff814d1a81>] run_ksoftirqd kernel/softirq.c:921 [inline]
softirqs last  enabled at (215364): [<ffffffff814d1a81>] run_ksoftirqd+0x31/0x60 kernel/softirq.c:913
softirqs last disabled at (215369): [<ffffffff814d1a81>] run_ksoftirqd kernel/softirq.c:921 [inline]
softirqs last disabled at (215369): [<ffffffff814d1a81>] run_ksoftirqd+0x31/0x60 kernel/softirq.c:913

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&fs_info->delayed_iput_lock);
  <Interrupt>
    lock(&fs_info->delayed_iput_lock);

 *** DEADLOCK ***

no locks held by ksoftirqd/3/32.

stack backtrace:
CPU: 3 PID: 32 Comm: ksoftirqd/3 Not tainted 6.4.0-syzkaller-09904-ga507db1d8fdc #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_usage_bug kernel/locking/lockdep.c:3978 [inline]
 valid_state kernel/locking/lockdep.c:4020 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4223 [inline]
 mark_lock.part.0+0x1102/0x1960 kernel/locking/lockdep.c:4685
 mark_lock kernel/locking/lockdep.c:4649 [inline]
 mark_usage kernel/locking/lockdep.c:4574 [inline]
 __lock_acquire+0x1231/0x5e20 kernel/locking/lockdep.c:5098
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 btrfs_add_delayed_iput+0x128/0x390 fs/btrfs/inode.c:3490
 btrfs_put_ordered_extent fs/btrfs/ordered-data.c:559 [inline]
 btrfs_put_ordered_extent+0x2f6/0x610 fs/btrfs/ordered-data.c:547
 __btrfs_bio_end_io fs/btrfs/bio.c:118 [inline]
 __btrfs_bio_end_io+0x136/0x180 fs/btrfs/bio.c:112
 btrfs_orig_bbio_end_io+0x86/0x2b0 fs/btrfs/bio.c:163
 btrfs_simple_end_io+0x105/0x380 fs/btrfs/bio.c:378
 bio_endio+0x589/0x690 block/bio.c:1617
 req_bio_endio block/blk-mq.c:766 [inline]
 blk_update_request+0x5c5/0x1620 block/blk-mq.c:911
 blk_mq_end_request+0x59/0x680 block/blk-mq.c:1032
 lo_complete_rq+0x1c6/0x280 drivers/block/loop.c:370
 blk_complete_reqs+0xb3/0xf0 block/blk-mq.c:1110
 __do_softirq+0x1d4/0x905 kernel/softirq.c:553
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x31/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
