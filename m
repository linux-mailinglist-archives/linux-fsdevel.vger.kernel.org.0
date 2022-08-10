Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0C958F4F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 01:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiHJXk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 19:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiHJXks (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:40:48 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73753E14;
        Wed, 10 Aug 2022 16:40:45 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-193-158.pa.nsw.optusnet.com.au [49.181.193.158])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C9A1E62D0EF;
        Thu, 11 Aug 2022 09:40:43 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oLvJZ-00BcME-R5; Thu, 11 Aug 2022 09:40:41 +1000
Date:   Thu, 11 Aug 2022 09:40:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     syzbot <syzbot+ed920a72fd23eb735158@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] INFO: task hung in __generic_file_fsync (3)
Message-ID: <20220810234041.GL3861211@dread.disaster.area>
References: <00000000000096592405e5dcaa9f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000096592405e5dcaa9f@google.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62f441fc
        a=SeswVvpAPK2RnNNwqI8AaA==:117 a=SeswVvpAPK2RnNNwqI8AaA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=edf1wS77AAAA:8 a=7-415B0cAAAA:8
        a=SbdPs6kyW9B9Yl0RobsA:9 a=CjuIK1q_8ugA:10 a=igBNqPyMv6gA:10
        a=DcSpbTIhAlouE1Uv7lRv:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 09, 2022 at 10:53:21PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13d08412080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
> dashboard link: https://syzkaller.appspot.com/bug?extid=ed920a72fd23eb735158
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dd033e080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dbfa46080000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.

tl;dr: Well known problem. Don't do O_DSYNC direct IO writes on vfat.

Basically, vfat uses __generic_file_sync() which takes the
inode_lock(). It's not valid to take the inode_lock() in DIO
completion callbacks  as we do for O_DSYNC/O_SYNC writes because
setattr needs to do:

	inode_lock()
	inode_dio_wait()
	  <waits for inode->i_dio_count to go to zero>

to wait for all pending direct IO to drain before it can proceed.

Hence:

	<dio holds inode->i_dio_count reference>
	dio_complete
	  generic_write_sync
	    vfs_fsync_range
	      fat_file_fsync
	        __generic_file_fsync
		  inode_lock
		    <blocks>

O_DSYNC DIO completion will attempt to lock the inode with an
elevated inode->i_dio_count (as is always the case when
dio_complete() is called) and hence we have a trivial ABBA deadlock
vector via truncate, hole punching, etc.

> INFO: task kworker/0:1:14 blocked for more than 143 seconds.
>       Not tainted 5.19.0-syzkaller-02972-g200e340f2196 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:1     state:D stack:26544 pid:   14 ppid:     2 flags:0x00004000
> Workqueue: dio/loop5 dio_aio_complete_work
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5178 [inline]
>  __schedule+0xa00/0x4c10 kernel/sched/core.c:6490
>  schedule+0xda/0x1b0 kernel/sched/core.c:6566
>  rwsem_down_write_slowpath+0x697/0x11e0 kernel/locking/rwsem.c:1182
>  __down_write_common kernel/locking/rwsem.c:1297 [inline]
>  __down_write_common kernel/locking/rwsem.c:1294 [inline]
>  __down_write kernel/locking/rwsem.c:1306 [inline]
>  down_write+0x135/0x150 kernel/locking/rwsem.c:1553
>  inode_lock include/linux/fs.h:760 [inline]
>  __generic_file_fsync+0xb0/0x1f0 fs/libfs.c:1119
>  fat_file_fsync+0x73/0x200 fs/fat/file.c:191
>  vfs_fsync_range+0x13a/0x220 fs/sync.c:188
>  generic_write_sync include/linux/fs.h:2861 [inline]
>  dio_complete+0x6dd/0x950 fs/direct-io.c:310
>  process_one_work+0x996/0x1610 kernel/workqueue.c:2289
>  worker_thread+0x665/0x1080 kernel/workqueue.c:2436
>  kthread+0x2e9/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>  </TASK>

There's dio completion.

> INFO: task syz-executor775:3664 blocked for more than 144 seconds.
>       Not tainted 5.19.0-syzkaller-02972-g200e340f2196 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor775 state:D stack:26128 pid: 3664 ppid:  3656 flags:0x00004004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5178 [inline]
>  __schedule+0xa00/0x4c10 kernel/sched/core.c:6490
>  schedule+0xda/0x1b0 kernel/sched/core.c:6566
>  __inode_dio_wait fs/inode.c:2381 [inline]
>  inode_dio_wait+0x22a/0x270 fs/inode.c:2399
>  fat_setattr+0x3de/0x13c0 fs/fat/file.c:509
>  notify_change+0xcd0/0x1440 fs/attr.c:418
>  do_truncate+0x13c/0x200 fs/open.c:65
>  do_sys_ftruncate+0x536/0x730 fs/open.c:193
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd

There's truncate waiting on dio completion holding the inode lock.

So, as expected, any filesystem that supports DIO and calls into
__generic_file_fsync() for fsync functionality can easily deadlock
truncate against O_DSYNC DIO writes...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
