Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E82E2336E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 18:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgG3QeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 12:34:04 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58347 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbgG3QeC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:34:02 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06UGXmRn001825;
        Fri, 31 Jul 2020 01:33:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Fri, 31 Jul 2020 01:33:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06UGXlex001821
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 31 Jul 2020 01:33:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: userfaultfd: Is handle_userfault() with an uninterruptible lock held
 allowed?
To:     viro@zeniv.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>
References: <00000000000013eb8005aba19be3@google.com>
Cc:     syzbot <syzbot+2bb1411e81c5c86571b6@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-mm <linux-mm@kvack.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <45a9b2c8-d0b7-8f00-5b30-0cfe3e028b28@I-love.SAKURA.ne.jp>
Date:   Fri, 31 Jul 2020 01:33:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000013eb8005aba19be3@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot is reporting hung task at pipe_write() [1], for mutex_lock_nested() from pipe_write() by
task-A can be blocked forever waiting for handle_userfault() from copy_page_from_iter() from
pipe_write() by task-B to complete and call mutex_unlock().

Is this a problem of fs/userfaultfd.c , for otherwise we would have to avoid page fault with
uninterruptible lock held?

By the way, who should be listed in MAINTAINERS file for userfaultfd ?

[1] https://syzkaller.appspot.com/bug?id=ab3d277fa3b068651edb7171a1aa4f78e5eacf78

[  916.954313] INFO: task syz-executor.0:61593 blocked for more than 40 seconds.
[  916.954869]       Not tainted 5.8.0-rc7+ #606
[  916.955348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  916.955815] syz-executor.0  D14512 61593  54413 0x00000004
[  916.956318] Call Trace:
[  916.956781]  __schedule+0x3fe/0x8e0
[  916.957282]  schedule+0x3b/0xf0
[  916.957742]  schedule_preempt_disabled+0x13/0x20
[  916.958261]  __mutex_lock+0x280/0x9e0
[  916.958702]  ? pipe_write+0x49/0x5a0
[  916.959316]  mutex_lock_nested+0x16/0x20
[  916.959750]  ? mutex_lock_nested+0x16/0x20
[  916.960229]  pipe_write+0x49/0x5a0
[  916.960652]  do_iter_readv_writev+0x142/0x1b0
[  916.961118]  do_iter_write+0x88/0x1a0
[  916.961734]  vfs_writev+0x8d/0x120
[  916.962261]  ? iterate_fd+0x160/0x160
[  916.962857]  ? find_held_lock+0x35/0xa0
[  916.963370]  ? __fget_files+0xfa/0x1e0
[  916.963800]  do_writev+0x5c/0x130
[  916.964328]  ? do_writev+0x5c/0x130
[  916.965457]  __x64_sys_writev+0x17/0x20
[  916.965881]  do_syscall_64+0x64/0xe0
[  916.966327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  916.966732] RIP: 0033:0x42a8b1
[  916.967236] Code: Bad RIP value.
[  916.967618] RSP: 002b:00007fbb358da970 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
[  916.968016] RAX: ffffffffffffffda RBX: 00007fbb358da970 RCX: 000000000042a8b1
[  916.968526] RDX: 0000000000000005 RSI: 00007fbb358da970 RDI: 0000000000000002
[  916.969156] RBP: 00007fbb358dab50 R08: 0000000000000036 R09: 0000000000000005
[  916.969605] R10: 0000000000000005 R11: 0000000000000246 R12: 00007fbb358da970
[  916.969973] R13: 0000000000000014 R14: 0000000000000000 R15: 0000000000000030
[  916.970422]
               Showing all locks held in the system:
[  916.971169] 1 lock held by khungtaskd/213:
[  916.971516]  #0: ffffffff822507c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x17/0x1a0
[  916.972320] 1 lock held by in:imklog/3222:
[  916.972883]  #0: ffff888129f136f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x44/0x50
[  916.973452] 1 lock held by syz-executor.0/57783:
[  916.973920]  #0: ffff888122fb4a68 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x2bf/0x5a0
[  916.974935] 1 lock held by syz-executor.0/61593:
[  916.975357]  #0: ffff888122fb4a68 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x49/0x5a0

[  916.976334] =============================================

[  919.823503] syz-executor.0  S14136 57783  54413 0x00004000
[  919.823843] Call Trace:
[  919.824267]  __schedule+0x3fe/0x8e0
[  919.824615]  ? handle_userfault+0x3b0/0x8a0
[  919.824955]  schedule+0x3b/0xf0
[  919.825310]  handle_userfault+0x37d/0x8a0
[  919.825634]  ? seqcount_lockdep_reader_access+0xc0/0xc0
[  919.825957]  handle_mm_fault+0x13f8/0x15c0
[  919.826288]  ? exc_page_fault+0x15b/0x790
[  919.826615]  exc_page_fault+0x344/0x790
[  919.826934]  asm_exc_page_fault+0x1e/0x30
[  919.827286] RIP: 0010:copy_user_generic_unrolled+0x32/0xc0
[  919.827606] Code: 8c 00 00 00 89 f9 83 e1 07 74 15 83 e9 08 f7 d9 29 ca 8a 06 88 07 48 ff c6 48 ff c7 ff c9 75 f2 89 d1 83 e2 3f c1 e9 06 74 4a <4c> 8b 06 4c 8b 4e 08 4c 8b 56 10 4c 8b 5e 18 4c 89 07 4c 89 4f 08
[  919.828653] RSP: 0018:ffffc900038b3d28 EFLAGS: 00010202
[  919.829013] RAX: 00007ffffffff000 RBX: 0000000000001000 RCX: 0000000000000001
[  919.829429] RDX: 0000000000000000 RSI: 0000000020909000 RDI: ffff88812aa96fc0
[  919.829807] RBP: ffffc900038b3d30 R08: 0000000000000000 R09: 0000000000000000
[  919.830224] R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900038b3e28
[  919.830612] R13: ffff88812aa96000 R14: 0000000000001000 R15: 0000000000001000
[  919.831016]  ? copyin+0x47/0x60
[  919.831495]  copy_page_from_iter+0x1b2/0x2a0
[  919.831909]  pipe_write+0x184/0x5a0
[  919.832573]  ? finish_wait+0x90/0x90
[  919.833309]  new_sync_write+0x17c/0x190
[  919.834139]  vfs_write+0x1f9/0x220
[  919.834548]  ksys_write+0x54/0xe0
[  919.834932]  ? do_syscall_64+0x20/0xe0
[  919.835349]  __x64_sys_write+0x15/0x20
[  919.835728]  do_syscall_64+0x64/0xe0
[  919.836109]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  919.836479] RIP: 0033:0x467b19
[  919.836843] Code: Bad RIP value.
[  919.837289] RSP: 002b:00007fbb358dac58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  919.837707] RAX: ffffffffffffffda RBX: 000000000073b0c0 RCX: 0000000000467b19
[  919.838132] RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000000
[  919.838670] RBP: 00000000004c1685 R08: 0000000000000000 R09: 0000000000000000
[  919.839188] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000076bf00
[  919.839603] R13: 0000000000000000 R14: 000000000076bf00 R15: 00007ffdf5caf710

