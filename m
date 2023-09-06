Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65D47942B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbjIFSEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 14:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbjIFSEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:04:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F93CE4;
        Wed,  6 Sep 2023 11:04:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFD8C433C7;
        Wed,  6 Sep 2023 18:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694023443;
        bh=3cmxhFoOxbwI20SxbNpIyKJxXZHBM5Gb70QIUc8X4f4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ibh34WvgSvPCcHZ8i108KmXj5I83V3oaVtfopQeMeubqTWx9I3+iTUGqyOF45LmSE
         SQim+MP+O2iaZqo9Q/jxPypSxEsPL/mEXQhycPCBs9hArSUR+GKWWFNrw+9tDkdcxT
         6GM4Tdqu6G2hujCBt+NHDsc9t3WWDb82A4g0PPcfB4CCKqB0DdRZYCJNWaHw30a3PV
         fje2Lt+ja6bjnDYDucvTu09noxBFNHVolr9xL4QEnQNOZHEOCM7IdwT6uxecdmBqhC
         gHv4VUdUcnL7d1YdvNTj+h3eBnyoTkUxp53SeXVefRFPIihkQV+gRIz0RXCMcTfUTZ
         YSC5FiHzZKYvA==
Date:   Wed, 6 Sep 2023 11:04:02 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [syzbot] [xfs?] INFO: task hung in clean_bdev_aliases
Message-ID: <20230906180402.GG28160@frogsfrogsfrogs>
References: <000000000000e534bb0604959011@google.com>
 <ZPeaH+K75a0nIyBk@dread.disaster.area>
 <CANp29Y4AK9dzmpMj4E9iz3gqTwhG=-_7DfA8knrWYaHy4QxrEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y4AK9dzmpMj4E9iz3gqTwhG=-_7DfA8knrWYaHy4QxrEg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 07:20:15PM +0200, Aleksandr Nogikh wrote:
> On Tue, Sep 5, 2023 at 11:14 PM 'Dave Chinner' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > [cc linux-block, Christoph]
> >
> > Another iomap-blockdev related issue.
> >
> > #syz set subsystems: block
> >
> > syzbot developers: Please review how you are classifying subsystems,
> > this is the third false XFS classification in 24 hours.
> 
> The reason why syzbot marked this report as xfs is that, per
> MAINTAINERS, fs/iomap/ points to linux-xfs@vger.kernel.org. I can
> adjust the rules syzbot uses so that these are routed to "block".

Huh?

MAINTAINERS tells us that fs/iomap/ maps to "IOMAP FILESYSTEM LIBRARY",
why wouldn't it tag bugs with those stacktraces as "[iomap]" ?

They're separate subsystems that just happen to share the same vger
list because iomap was lifted from xfs.

> But should MAINTAINERS actually also not relate IOMAP FILESYSTEM
> LIBRARY with xfs in this case?

Did y'all try emailing those lists to ask how they'd like the function
name -> source file -> syzbot tagging set up?

--D

> -- 
> Aleksandr
> 
> >
> > -Dave.
> >
> > On Mon, Sep 04, 2023 at 10:04:47PM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    92901222f83d Merge tag 'f2fs-for-6-6-rc1' of git://git.ker..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1485e78fa80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3bd57a1ac08277b0
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=1fa947e7f09e136925b8
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fcf738680000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/ee486d884228/disk-92901222.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/b5187db0b1d1/vmlinux-92901222.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/82c4e42d693e/bzImage-92901222.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
> > >
> > > INFO: task syz-executor.5:10017 blocked for more than 143 seconds.
> > >       Not tainted 6.5.0-syzkaller-11075-g92901222f83d #0
> > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > task:syz-executor.5  state:D stack:27624 pid:10017 ppid:5071   flags:0x00004006
> > > Call Trace:
> > >  <TASK>
> > >  context_switch kernel/sched/core.c:5382 [inline]
> > >  __schedule+0xee1/0x59f0 kernel/sched/core.c:6695
> > >  schedule+0xe7/0x1b0 kernel/sched/core.c:6771
> > >  io_schedule+0xbe/0x130 kernel/sched/core.c:9026
> > >  folio_wait_bit_common+0x3d2/0x9b0 mm/filemap.c:1304
> > >  folio_lock include/linux/pagemap.h:1042 [inline]
> > >  clean_bdev_aliases+0x56b/0x610 fs/buffer.c:1725
> > >  clean_bdev_bh_alias include/linux/buffer_head.h:219 [inline]
> > >  __block_write_begin_int+0x8d6/0x1470 fs/buffer.c:2115
> > >  iomap_write_begin+0x5be/0x17b0 fs/iomap/buffered-io.c:772
> > >  iomap_write_iter fs/iomap/buffered-io.c:907 [inline]
> > >  iomap_file_buffered_write+0x3d6/0x9a0 fs/iomap/buffered-io.c:968
> > >  blkdev_buffered_write block/fops.c:634 [inline]
> > >  blkdev_write_iter+0x572/0xca0 block/fops.c:688
> > >  call_write_iter include/linux/fs.h:1985 [inline]
> > >  do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
> > >  do_iter_write+0x17f/0x830 fs/read_write.c:860
> > >  vfs_iter_write+0x7a/0xb0 fs/read_write.c:901
> > >  iter_file_splice_write+0x698/0xbf0 fs/splice.c:736
> > >  do_splice_from fs/splice.c:933 [inline]
> > >  direct_splice_actor+0x118/0x180 fs/splice.c:1142
> > >  splice_direct_to_actor+0x347/0xa30 fs/splice.c:1088
> > >  do_splice_direct+0x1af/0x280 fs/splice.c:1194
> > >  do_sendfile+0xb88/0x1390 fs/read_write.c:1254
> > >  __do_sys_sendfile64 fs/read_write.c:1322 [inline]
> > >  __se_sys_sendfile64 fs/read_write.c:1308 [inline]
> > >  __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > RIP: 0033:0x7fdb8ca7cae9
> > > RSP: 002b:00007ffcd642da18 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> > > RAX: ffffffffffffffda RBX: 00007fdb8cb9bf80 RCX: 00007fdb8ca7cae9
> > > RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
> > > RBP: 00007fdb8cac847a R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0100000000000042 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 0000000000000be7 R14: 00007fdb8cb9bf80 R15: 00007fdb8cb9bf80
> > >  </TASK>
> > > INFO: lockdep is turned off.
> > > NMI backtrace for cpu 1
> > > CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.5.0-syzkaller-11075-g92901222f83d #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
> > >  nmi_cpu_backtrace+0x277/0x380 lib/nmi_backtrace.c:113
> > >  nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
> > >  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
> > >  check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
> > >  watchdog+0xfac/0x1230 kernel/hung_task.c:379
> > >  kthread+0x33a/0x430 kernel/kthread.c:388
> > >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> > >  </TASK>
> > > Sending NMI from CPU 1 to CPUs 0:
> > > NMI backtrace for cpu 0
> > > CPU: 0 PID: 17 Comm: rcu_preempt Not tainted 6.5.0-syzkaller-11075-g92901222f83d #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> > > RIP: 0010:load_balance+0x10a/0x3130 kernel/sched/fair.c:10983
> > > Code: 4a 8d 3c f5 40 aa 5c 8c 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 11 00 0f 85 2f 2e 00 00 31 c0 b9 0c 00 00 00 <4e> 8b 1c f5 40 aa 5c 8c 4c 89 94 24 f8 00 00 00 48 8d bc 24 00 01
> > > RSP: 0018:ffffc900001676c8 EFLAGS: 00000046
> > > RAX: 0000000000000000 RBX: ffff8880b983c700 RCX: 000000000000000c
> > > RDX: dffffc0000000000 RSI: ffffffff8ae90360 RDI: ffffffff8c5caa40
> > > RBP: ffffc90000167898 R08: ffffc90000167960 R09: 0000000000000000
> > > R10: ffff88801525ac00 R11: 0000000000000000 R12: 00000000000287d8
> > > R13: ffffc90000167960 R14: 0000000000000000 R15: 0000000100004d48
> > > FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000020000240 CR3: 000000000c976000 CR4: 0000000000350ef0
> > > Call Trace:
> > >  <NMI>
> > >  </NMI>
> > >  <TASK>
> > >  newidle_balance+0x710/0x1210 kernel/sched/fair.c:12059
> > >  pick_next_task_fair+0x87/0x1200 kernel/sched/fair.c:8234
> > >  __pick_next_task kernel/sched/core.c:6004 [inline]
> > >  pick_next_task kernel/sched/core.c:6079 [inline]
> > >  __schedule+0x493/0x59f0 kernel/sched/core.c:6659
> > >  schedule+0xe7/0x1b0 kernel/sched/core.c:6771
> > >  schedule_timeout+0x157/0x2c0 kernel/time/timer.c:2167
> > >  rcu_gp_fqs_loop+0x1ec/0xa50 kernel/rcu/tree.c:1613
> > >  rcu_gp_kthread+0x249/0x380 kernel/rcu/tree.c:1812
> > >  kthread+0x33a/0x430 kernel/kthread.c:388
> > >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> > >  </TASK>
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >
> > > If the bug is already fixed, let syzbot know by replying with:
> > > #syz fix: exact-commit-title
> > >
> > > If you want syzbot to run the reproducer, reply with:
> > > #syz test: git://repo/address.git branch-or-commit-hash
> > > If you attach or paste a git patch, syzbot will apply it before testing.
> > >
> > > If you want to overwrite bug's subsystems, reply with:
> > > #syz set subsystems: new-subsystem
> > > (See the list of subsystem names on the web dashboard)
> > >
> > > If the bug is a duplicate of another bug, reply with:
> > > #syz dup: exact-subject-of-another-report
> > >
> > > If you want to undo deduplication, reply with:
> > > #syz undup
> > >
> >
> > --
> > Dave Chinner
> > david@fromorbit.com
> >
