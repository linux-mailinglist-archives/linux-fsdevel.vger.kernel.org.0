Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143F170514A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 16:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjEPOxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 10:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbjEPOxX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 10:53:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14D244AD;
        Tue, 16 May 2023 07:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FD2A61652;
        Tue, 16 May 2023 14:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E49C433EF;
        Tue, 16 May 2023 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684248799;
        bh=2Ft+FAHmPxALjpeynNQt2uBiZnkvj/wfacofA23SRK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VLvcqxFCxROjoEdxOEE4Qa6d5gz6NQMd0ST1VidNUT6SJUhggcVSXpqNMRjoZjdNk
         NcHrHmNjEilbgeEO8rNPR/+4qjZyKyOWhBgBnpNSoXQ3uSvkNWk/5rldxV59DEGbN1
         o6kNlkWDrxmUKsBTBTzqZBhI+vl40AvFeuKMyNFn+XkFIsXnUAI+UHPTFdsjyhUq7+
         y2l3fajUp4hNJap+8T9EeIPlqpXLfGx+HSI65oEHy7v461ANuOlLMIwO6R75I1P6jO
         zJhGTefxZzclRF3u1vUl8p7dIhIjvF0rt+VFnSSttx3V+efFnSTBw3rlbgaVb8m9qh
         gOQueRPKpTeCg==
Date:   Tue, 16 May 2023 07:53:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: DIO hangs in 6.4.0-rc2
Message-ID: <20230516145319.GF858791@frogsfrogsfrogs>
References: <ZGN20Hp1ho/u4uPY@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGN20Hp1ho/u4uPY@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 01:28:00PM +0100, Matthew Wilcox wrote:
> Plain 6.4.0-rc2 with a relatively minor change to the futex code that
> I cannot believe was in any way responsible for this.
> 
> kworkers blocked all over the place.  Some on XFS_ILOCK_EXCL.  Some on
> xfs_buf_lock.  One in xfs_btree_split() calling wait_for_completion.
> 
> This was an overnight test run that is now dead, so I can't get any
> more info from the locked up kernel.  I have the vmlinux if some
> decoding of offsets is useful.

It would be kinda nice to sysrq-t if that's at all possible.  I don't
see the kworker that's handling the btree split, and I wonder what that
thread is up to.

A long time ago I had a hypothesis that it's actually possible to
deadlock the filesystem if writeback completion is rolling a transaction
chain enough times to require acquisition of more log grant space while
holding an ILOCK if there are other threads that have taken all the log
grant space and are now waiting on memory reclaim pushing writeback.

Hmmm.  I only saw the above happen once or twice, and I haven't seen it
since we <cough> increased the default log size to 64MB.

Side question: I wonder if we could get the hangcheck timer to invoke a
sysrq-t automatically.  That would be useful for things like OCI where
you can't send a break over the serial console.

--D

> 03112 generic/299       run fstests generic/299 at 2023-05-15 21:57:47
> 03112 XFS (sdb): Mounting V5 Filesystem f0c30f98-050d-46ac-a75c-da4c48421e16
> 03112 XFS (sdb): Ending clean mount
> 03113 XFS (sdc): Mounting V5 Filesystem 0aa26d2f-31a3-47f9-b264-1654bf262ef4
> 03113 XFS (sdc): Ending clean mount
> 03253 kworker/dying (1180190) used greatest stack depth: 10648 bytes left
> 03384 INFO: task kworker/0:55:1617125 blocked for more than 120 seconds.
> 03384       Not tainted 6.4.0-rc2-dirty #347
> 03384 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 03384 task:kworker/0:55    state:D stack:12936 pid:1617125 ppid:2      flags:0x00004000
> 03384 Workqueue: dio/sdc iomap_dio_complete_work
> 03384 Call Trace:
> 03384  <TASK>
> 03384  __schedule+0x274/0x740
> 03384  schedule+0x5d/0xd0
> 03384  schedule_preempt_disabled+0x13/0x20
> 03384  rwsem_down_write_slowpath+0x26d/0x5e0
> 03384  down_write+0x5a/0x70
> 03384  xfs_ilock+0x71/0x100
> 03384  xfs_trans_alloc_inode+0x70/0x130
> 03384  xfs_iomap_write_unwritten+0x118/0x2c0
> 03384  xfs_dio_write_end_io+0x1d3/0x1f0
> 03384  iomap_dio_complete+0x43/0x1c0
> 03384  ? aio_fsync_work+0x90/0x90
> 03384  iomap_dio_complete_work+0x17/0x30
> 03384  process_one_work+0x1a9/0x3a0
> 03384  worker_thread+0x4e/0x3a0
> 03384  ? process_one_work+0x3a0/0x3a0
> 03384  kthread+0xf9/0x130
> 03384  ? kthread_complete_and_exit+0x20/0x20
> 03384  ret_from_fork+0x1f/0x30
> 03384  </TASK>
> 03384 INFO: task kworker/0:68:1617702 blocked for more than 120 seconds.
> 03384       Not tainted 6.4.0-rc2-dirty #347
> 03384 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 03384 task:kworker/0:68    state:D stack:12536 pid:1617702 ppid:2      flags:0x00004000
> 03384 Workqueue: dio/sdc iomap_dio_complete_work
> 03384 Call Trace:
> 03384  <TASK>
> 03384  __schedule+0x274/0x740
> 03384  schedule+0x5d/0xd0
> 03384  schedule_preempt_disabled+0x13/0x20
> 03384  rwsem_down_write_slowpath+0x26d/0x5e0
> 03384  down_write+0x5a/0x70
> 03384  xfs_ilock+0x71/0x100
> 03384  xfs_trans_alloc_inode+0x70/0x130
> 03384  xfs_iomap_write_unwritten+0x118/0x2c0
> 03384  ? iocb_put.part.0+0x1f8/0x270
> 03384  xfs_dio_write_end_io+0x1d3/0x1f0
> 03384  ? iocb_put.part.0+0x1f8/0x270
> 03384  iomap_dio_complete+0x43/0x1c0
> 03384  ? aio_fsync_work+0x90/0x90
> 03384  iomap_dio_complete_work+0x17/0x30
> 03384  process_one_work+0x1a9/0x3a0
> 03384  worker_thread+0x4e/0x3a0
> 03384  ? process_one_work+0x3a0/0x3a0
> 03384  kthread+0xf9/0x130
> 03384  ? kthread_complete_and_exit+0x20/0x20
> 03384  ret_from_fork+0x1f/0x30
> 03384  </TASK>
> 03384 INFO: task kworker/0:126:1621285 blocked for more than 120 seconds.
> 03384       Not tainted 6.4.0-rc2-dirty #347
> 03384 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 03384 task:kworker/0:126   state:D stack:12584 pid:1621285 ppid:2      flags:0x00004000
> 03384 Workqueue: dio/sdc iomap_dio_complete_work
> 03384 Call Trace:
> 03384  <TASK>
> 03384  __schedule+0x274/0x740
> 03384  schedule+0x5d/0xd0
> 03384  schedule_preempt_disabled+0x13/0x20
> 03384  rwsem_down_write_slowpath+0x26d/0x5e0
> 03384  down_write+0x5a/0x70
> 03384  xfs_ilock+0x71/0x100
> 03384  xfs_trans_alloc_inode+0x70/0x130
> 03384  xfs_iomap_write_unwritten+0x118/0x2c0
> 03384  ? update_load_avg+0x61/0x300
> 03384  ? update_load_avg+0x61/0x300
> 03384  xfs_dio_write_end_io+0x1d3/0x1f0
> 03384  iomap_dio_complete+0x43/0x1c0
> 03384  ? aio_fsync_work+0x90/0x90
> 03384  iomap_dio_complete_work+0x17/0x30
> 03384  process_one_work+0x1a9/0x3a0
> 03384  worker_thread+0x4e/0x3a0
> 03384  ? process_one_work+0x3a0/0x3a0
> 03384  kthread+0xf9/0x130
> 03384  ? kthread_complete_and_exit+0x20/0x20
> 03384  ret_from_fork+0x1f/0x30
> 03384  </TASK>
> 03384 INFO: task kworker/0:129:1621288 blocked for more than 120 seconds.
> 03384       Not tainted 6.4.0-rc2-dirty #347
> 03384 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 03384 task:kworker/0:129   state:D stack:12536 pid:1621288 ppid:2      flags:0x00004000
> 03384 Workqueue: dio/sdc iomap_dio_complete_work
> 03384 Call Trace:
> 03384  <TASK>
> 03384  __schedule+0x274/0x740
> 03384  schedule+0x5d/0xd0
> 03384  schedule_timeout+0x11d/0x130
> 03384  ? ___slab_alloc+0x4f2/0x990
> 03384  ? preempt_count_add+0x6f/0xb0
> 03384  __down_common+0xe6/0x1d0
> 03384  __down+0x18/0x20
> 03384  down+0x43/0x60
> 03384  xfs_buf_lock+0x2b/0xe0
> 03384  xfs_buf_find_lock+0x2d/0xf0
> 03384  xfs_buf_get_map+0x170/0x9f0
> 03384  xfs_buf_read_map+0x36/0x290
> 03384  xfs_trans_read_buf_map+0xea/0x2a0
> 03384  ? xfs_read_agf+0x78/0x100
> 03384  xfs_read_agf+0x78/0x100
> 03384  xfs_alloc_read_agf+0x41/0x1d0
> 03384  xfs_alloc_fix_freelist+0x446/0x590
> 03384  ? xfs_buf_rele+0x10e/0x460
> 03384  ? up+0x2d/0x60
> 03384  ? xfs_buf_item_release+0x6a/0xc0
> 03384  ? preempt_count_add+0x45/0xb0
> 03384  ? up_read+0x36/0x70
> 03384  ? xlog_cil_commit+0x8d0/0xc00
> 03384  xfs_free_extent_fix_freelist+0x55/0x70
> 03384  xfs_rmap_finish_one+0x63/0x290
> 03384  ? xfs_defer_restore_resources+0x34/0xa0
> 03384  ? kmem_cache_alloc+0xdd/0x200
> 03384  xfs_rmap_update_finish_item+0x1f/0x60
> 03384  xfs_defer_finish_noroll+0x171/0x690
> 03384  __xfs_trans_commit+0x2bf/0x3d0
> 03384  xfs_trans_commit+0xb/0x10
> 03384  xfs_iomap_write_unwritten+0xbe/0x2c0
> 03384  xfs_dio_write_end_io+0x1d3/0x1f0
> 03384  iomap_dio_complete+0x43/0x1c0
> 03384  ? aio_fsync_work+0x90/0x90
> 03384  iomap_dio_complete_work+0x17/0x30
> 03384  process_one_work+0x1a9/0x3a0
> 03384  worker_thread+0x4e/0x3a0
> 03384  ? process_one_work+0x3a0/0x3a0
> 03384  kthread+0xf9/0x130
> 03384  ? kthread_complete_and_exit+0x20/0x20
> 03384  ret_from_fork+0x1f/0x30
> 03384  </TASK>
> 03384 INFO: task kworker/u2:8:1670277 blocked for more than 120 seconds.
> 03384       Not tainted 6.4.0-rc2-dirty #347
> 03384 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 03384 task:kworker/u2:8    state:D stack:10648 pid:1670277 ppid:2      flags:0x00004000
> 03384 Workqueue: writeback wb_workfn (flush-8:32)
> 03384 Call Trace:
> 03384  <TASK>
> 03384  __schedule+0x274/0x740
> 03384  schedule+0x5d/0xd0
> 03384  schedule_timeout+0x11d/0x130
> 03384  ? _raw_spin_lock_irqsave+0x18/0x40
> 03384  ? _raw_spin_unlock_irqrestore+0x1a/0x30
> 03384  __down_common+0xe6/0x1d0
> 03384  ? xfs_buf_lock+0x2b/0xe0
> 03384  ? xfs_buf_get_map+0x1d0/0x9f0
> 03384  __down+0x18/0x20
> 03384  down+0x43/0x60
> 03384  xfs_buf_lock+0x2b/0xe0
> 03384  xfs_buf_find_lock+0x2d/0xf0
> 03384  xfs_buf_get_map+0x170/0x9f0
> 03384  xfs_buf_read_map+0x36/0x290
> 03384  ? resched_curr+0x21/0x110
> 03384  xfs_trans_read_buf_map+0xea/0x2a0
> 03384  ? xfs_read_agf+0x78/0x100
> 03384  xfs_read_agf+0x78/0x100
> 03384  xfs_alloc_read_agf+0x41/0x1d0
> 03384  xfs_alloc_fix_freelist+0x446/0x590
> 03384  ? xfs_buf_rele+0x10e/0x460
> 03384  ? xfs_buf_item_release+0x6a/0xc0
> 03384  ? preempt_count_add+0x45/0xb0
> 03384  ? up_read+0x36/0x70
> 03384  ? xlog_cil_commit+0x8d0/0xc00
> 03384  xfs_free_extent_fix_freelist+0x55/0x70
> 03384  xfs_rmap_finish_one+0x63/0x290
> 03384  ? kmem_cache_alloc+0xdd/0x200
> 03384  xfs_rmap_update_finish_item+0x1f/0x60
> 03384  xfs_defer_finish_noroll+0x171/0x690
> 03384  __xfs_trans_commit+0x2bf/0x3d0
> 03384  xfs_trans_commit+0xb/0x10
> 03384  xfs_bmapi_convert_delalloc+0x373/0x4b0
> 03384  xfs_map_blocks+0x1b8/0x3e0
> 03384  iomap_do_writepage+0x23e/0x820
> 03384  ? __this_cpu_preempt_check+0x13/0x20
> 03384  ? percpu_counter_add_batch+0x2a/0xa0
> 03384  write_cache_pages+0x16a/0x3e0
> 03384  ? iomap_page_mkwrite+0x2d0/0x2d0
> 03384  iomap_writepages+0x1b/0x40
> 03384  xfs_vm_writepages+0x6f/0xa0
> 03384  do_writepages+0xa9/0x150
> 03384  ? __schedule+0x27c/0x740
> 03384  __writeback_single_inode+0x3f/0x350
> 03384  writeback_sb_inodes+0x1b3/0x460
> 03384  __writeback_inodes_wb+0x4f/0xe0
> 03384  wb_writeback+0x1d4/0x2b0
> 03384  wb_workfn+0x2a8/0x440
> 03384  ? _raw_spin_unlock+0x11/0x30
> 03384  ? finish_task_switch.isra.0+0x89/0x250
> 03384  ? __switch_to+0x12a/0x480
> 03384  process_one_work+0x1a9/0x3a0
> 03384  worker_thread+0x4e/0x3a0
> 03384  ? process_one_work+0x3a0/0x3a0
> 03384  kthread+0xf9/0x130
> 03384  ? kthread_complete_and_exit+0x20/0x20
> 03384  ret_from_fork+0x1f/0x30
> 03384  </TASK>
> 03384 INFO: task fio:1714564 blocked for more than 120 seconds.
> 03384       Not tainted 6.4.0-rc2-dirty #347
> 03384 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 03384 task:fio             state:D stack:11032 pid:1714564 ppid:1714547 flags:0x00000002
> 03384 Call Trace:
> 03384  <TASK>
> 03384  __schedule+0x274/0x740
> 03384  schedule+0x5d/0xd0
> 03384  schedule_timeout+0x11d/0x130
> 03384  ? wake_up_process+0x10/0x20
> 03384  ? insert_work+0xa9/0xd0
> 03384  ? preempt_count_add+0x6f/0xb0
> 03384  wait_for_completion+0x74/0x140
> 03384  xfs_btree_split+0xa9/0xc0
> 03384  ? xfs_btree_split+0xc0/0xc0
> 03384  xfs_btree_make_block_unfull+0x11f/0x150
> 03384  xfs_btree_insrec+0x4ab/0x590
> 03384  xfs_btree_insert+0x8a/0x1c0
> 03384  xfs_bmap_add_extent_hole_real+0x1a4/0x9b0
> 03384  ? xfs_bmap_add_extent_hole_real+0x1a4/0x9b0
> 03384  ? xfs_bmbt_init_cursor+0x5d/0x190
> 03384  xfs_bmapi_allocate+0x26b/0x2f0
> 03384  xfs_bmapi_write+0x3f9/0x4f0
> 03384  xfs_iomap_write_direct+0x133/0x1e0
> 03384  xfs_direct_write_iomap_begin+0x3a0/0x5d0
> 03384  ? __kmem_cache_alloc_node+0x3b/0x190
> 03384  iomap_iter+0x132/0x2f0
> 03384  __iomap_dio_rw+0x1e5/0x8c0
> 03384  iomap_dio_rw+0xc/0x30
> 03384  xfs_file_dio_write_aligned+0x84/0x130
> 03384  xfs_file_write_iter+0xcb/0x110
> 03384  aio_write+0xf7/0x200
> 03384  ? update_load_avg+0x61/0x300
> 03384  io_submit_one+0x460/0x6c0
> 03384  ? io_submit_one+0x460/0x6c0
> 03384  ? __this_cpu_preempt_check+0x13/0x20
> 03384  ? xfd_validate_state+0x1e/0x80
> 03384  __x64_sys_io_submit+0x6b/0x130
> 03384  ? exit_to_user_mode_prepare+0xe9/0x100
> 03384  ? irqentry_exit_to_user_mode+0x9/0x20
> 03384  do_syscall_64+0x34/0x80
> 03384  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 03384 RIP: 0033:0x7f4d776cb5a9
> 03384 RSP: 002b:00007fff729a72d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
> 03384 RAX: ffffffffffffffda RBX: 00007f4d6d141da8 RCX: 00007f4d776cb5a9
> 03384 RDX: 000055c01bef4980 RSI: 0000000000000001 RDI: 00007f4d6d11c000
> 03384 RBP: 00007f4d6d11c000 R08: 0000000000000000 R09: 00000000000001e0
> 03384 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> 03384 R13: 0000000000000000 R14: 000055c01bef4980 R15: 00007f4d62d57018
> 03384  </TASK>
> 03384 INFO: task fio:1714565 blocked for more than 120 seconds.
> 03384       Not tainted 6.4.0-rc2-dirty #347
> 03384 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 03384 task:fio             state:D stack:11400 pid:1714565 ppid:1714547 flags:0x00000002
> 03384 Call Trace:
> 03384  <TASK>
> 03384  __schedule+0x274/0x740
> 03384  schedule+0x5d/0xd0
> 03384  schedule_timeout+0x11d/0x130
> 03384  ? preempt_count_add+0x6f/0xb0
> 03384  ? preempt_count_add+0x6f/0xb0
> 03384  ? _raw_spin_lock_irqsave+0x18/0x40
> 03384  __down_common+0xe6/0x1d0
> 03384  ? __down_common+0x140/0x1d0
> 03384  __down+0x18/0x20
> 03384  down+0x43/0x60
> 03384  xfs_buf_lock+0x2b/0xe0
> 03384  xfs_buf_find_lock+0x2d/0xf0
> 03384  xfs_buf_get_map+0x170/0x9f0
> 03384  xfs_buf_read_map+0x36/0x290
> 03384  ? preempt_count_add+0x6f/0xb0
> 03384  xfs_trans_read_buf_map+0xea/0x2a0
> 03384  ? xfs_read_agf+0x78/0x100
> 03384  xfs_read_agf+0x78/0x100
> 03384  xfs_alloc_read_agf+0x41/0x1d0
> 03384  xfs_alloc_fix_freelist+0x446/0x590
> 03384  ? xfs_trans_log_buf+0x29/0x80
> 03384  ? xfs_btree_insrec+0x339/0x590
> 03384  xfs_alloc_vextent_prepare_ag+0x2b/0x120
> 03384  xfs_alloc_vextent_iterate_ags+0x56/0x1f0
> 03384  xfs_alloc_vextent_start_ag+0x94/0x190
> 03384  xfs_bmap_btalloc+0x522/0x760
> 03384  xfs_bmapi_allocate+0xe2/0x2f0
> 03384  xfs_bmapi_write+0x3f9/0x4f0
> 03384  xfs_iomap_write_direct+0x133/0x1e0
> 03384  xfs_direct_write_iomap_begin+0x3a0/0x5d0
> 03384  ? __kmem_cache_alloc_node+0x3b/0x190
> 03384  iomap_iter+0x132/0x2f0
> 03384  __iomap_dio_rw+0x1e5/0x8c0
> 03384  iomap_dio_rw+0xc/0x30
> 03384  xfs_file_dio_write_aligned+0x84/0x130
> 03384  xfs_file_write_iter+0xcb/0x110
> 03384  aio_write+0xf7/0x200
> 03384  ? preempt_count_add+0x45/0xb0
> 03384  ? aio_read_events_ring+0x1f6/0x230
> 03384  io_submit_one+0x460/0x6c0
> 03384  ? io_submit_one+0x460/0x6c0
> 03384  ? _raw_spin_unlock+0x11/0x30
> 03384  __x64_sys_io_submit+0x6b/0x130
> 03384  ? fpregs_assert_state_consistent+0x21/0x50
> 03384  ? exit_to_user_mode_prepare+0x2b/0x100
> 03384  do_syscall_64+0x34/0x80
> 03384  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 03384 RIP: 0033:0x7f4d776cb5a9
> 03384 RSP: 002b:00007fff729a72d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
> 03384 RAX: ffffffffffffffda RBX: 00007f4d6d141da8 RCX: 00007f4d776cb5a9
> 03384 RDX: 000055c01bef4a20 RSI: 0000000000000001 RDI: 00007f4d6d11b000
> 03384 RBP: 00007f4d6d11b000 R08: 0000000000000000 R09: 0000000000000280
> 03384 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> 03384 R13: 0000000000000000 R14: 000055c01bef4a20 R15: 00007f4d62d85e50
> 03384  </TASK>
> 03384 INFO: task fio:1714566 blocked for more than 120 seconds.
> 03384       Not tainted 6.4.0-rc2-dirty #347
> 03384 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 03384 task:fio             state:D stack:11032 pid:1714566 ppid:1714547 flags:0x00000002
> 03384 Call Trace:
> 03384  <TASK>
> 03384  __schedule+0x274/0x740
> 03384  schedule+0x5d/0xd0
> 03384  schedule_preempt_disabled+0x13/0x20
> 03384  rwsem_down_read_slowpath+0x264/0x4b0
> 03384  down_read+0x46/0xb0
> 03384  xfs_ilock+0x83/0x100
> 03384  xfs_file_dio_write_aligned+0x9c/0x130
> 03384  xfs_file_write_iter+0xcb/0x110
> 03384  aio_write+0xf7/0x200
> 03384  ? preempt_count_add+0x45/0xb0
> 03384  ? aio_read_events_ring+0x1f6/0x230
> 03384  io_submit_one+0x460/0x6c0
> 03384  ? io_submit_one+0x460/0x6c0
> 03384  ? _raw_spin_unlock+0x11/0x30
> 03384  __x64_sys_io_submit+0x6b/0x130
> 03384  ? fpregs_assert_state_consistent+0x21/0x50
> 03384  ? exit_to_user_mode_prepare+0x2b/0x100
> 03384  do_syscall_64+0x34/0x80
> 03384  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 03384 RIP: 0033:0x7f4d776cb5a9
> 03384 RSP: 002b:00007fff729a72d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
> 03384 RAX: ffffffffffffffda RBX: 00007f4d6d141da8 RCX: 00007f4d776cb5a9
> 03384 RDX: 000055c01bef4a80 RSI: 0000000000000001 RDI: 00007f4d6d11a000
> 03384 RBP: 00007f4d6d11a000 R08: 0000000000000000 R09: 00000000000002e0
> 03384 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> 03384 R13: 0000000000000000 R14: 000055c01bef4a80 R15: 00007f4d62db4c88
> 03384  </TASK>
> 03384 INFO: task fio:1714567 blocked for more than 120 seconds.
> 03384       Not tainted 6.4.0-rc2-dirty #347
> 03384 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 03384 task:fio             state:D stack:11400 pid:1714567 ppid:1714547 flags:0x00000002
> 03384 Call Trace:
> 03384  <TASK>
> 03384  __schedule+0x274/0x740
> 03384  schedule+0x5d/0xd0
> 03384  schedule_preempt_disabled+0x13/0x20
> 03384  rwsem_down_write_slowpath+0x26d/0x5e0
> 03384  down_write+0x5a/0x70
> 03384  xfs_ilock+0x71/0x100
> 03384  xfs_vn_update_time+0x8f/0x190
> 03384  file_modified_flags+0x9c/0xd0
> 03384  kiocb_modified+0xf/0x20
> 03384  xfs_file_write_checks+0x1d4/0x270
> 03384  xfs_file_dio_write_aligned+0x52/0x130
> 03384  xfs_file_write_iter+0xcb/0x110
> 03384  aio_write+0xf7/0x200
> 03384  ? update_load_avg+0x61/0x300
> 03384  io_submit_one+0x460/0x6c0
> 03384  ? io_submit_one+0x460/0x6c0
> 03384  ? __schedule+0x27c/0x740
> 03384  ? __rseq_handle_notify_resume+0x358/0x4a0
> 03384  __x64_sys_io_submit+0x6b/0x130
> 03384  ? exit_to_user_mode_prepare+0xe9/0x100
> 03384  ? irqentry_exit_to_user_mode+0x9/0x20
> 03384  do_syscall_64+0x34/0x80
> 03384  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 03384 RIP: 0033:0x7f4d776cb5a9
> 03384 RSP: 002b:00007fff729a72d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
> 03384 RAX: ffffffffffffffda RBX: 00007f4d6d141da8 RCX: 00007f4d776cb5a9
> 03384 RDX: 000055c01bef4980 RSI: 0000000000000001 RDI: 00007f4d6d119000
> 03384 RBP: 00007f4d6d119000 R08: 0000000000000000 R09: 00000000000001e0
> 03384 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> 03384 R13: 0000000000000000 R14: 000055c01bef4980 R15: 00007f4d62de3ac0
> 03384  </TASK>
> 03384 INFO: task fio:1714568 blocked for more than 120 seconds.
> 03384       Not tainted 6.4.0-rc2-dirty #347
> 03384 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 03384 task:fio             state:D stack:11400 pid:1714568 ppid:1714547 flags:0x00004002
> 03384 Call Trace:
> 03384  <TASK>
> 03384  __schedule+0x274/0x740
> 03384  ? __switch_to+0x12a/0x480
> 03384  schedule+0x5d/0xd0
> 03384  schedule_timeout+0x11d/0x130
> 03384  ? schedule+0x67/0xd0
> 03384  __down_common+0xe6/0x1d0
> 03384  __down+0x18/0x20
> 03384  down+0x43/0x60
> 03384  xfs_buf_lock+0x2b/0xe0
> 03384  xfs_buf_find_lock+0x2d/0xf0
> 03384  xfs_buf_get_map+0x170/0x9f0
> 03384  ? update_load_avg+0x61/0x300
> 03384  xfs_buf_read_map+0x36/0x290
> 03384  ? enqueue_task_fair+0x233/0x4e0
> 03384  xfs_trans_read_buf_map+0xea/0x2a0
> 03384  ? xfs_read_agf+0x78/0x100
> 03384  xfs_read_agf+0x78/0x100
> 03384  xfs_alloc_read_agf+0x41/0x1d0
> 03384  xfs_alloc_fix_freelist+0x446/0x590
> 03384  ? xfs_buf_rele+0x6d/0x460
> 03384  ? up+0x2d/0x60
> 03384  ? xfs_buf_item_release+0x6a/0xc0
> 03384  ? preempt_count_add+0x45/0xb0
> 03384  ? up_read+0x36/0x70
> 03384  ? xlog_cil_commit+0x8d0/0xc00
> 03384  xfs_free_extent_fix_freelist+0x55/0x70
> 03384  xfs_rmap_finish_one+0x63/0x290
> 03384  ? xfs_defer_restore_resources+0x34/0xa0
> 03384  ? kmem_cache_alloc+0xdd/0x200
> 03384  xfs_rmap_update_finish_item+0x1f/0x60
> 03384  xfs_defer_finish_noroll+0x171/0x690
> 03384  __xfs_trans_commit+0x2bf/0x3d0
> 03384  xfs_trans_commit+0xb/0x10
> 03384  xfs_iomap_write_direct+0x142/0x1e0
> 03384  xfs_direct_write_iomap_begin+0x3a0/0x5d0
> 03384  ? xfs_read_iomap_begin+0x151/0x260
> 03384  ? iov_iter_zero+0x64/0x4c0
> 03384  ? __kmem_cache_alloc_node+0x3b/0x190
> 03384  iomap_iter+0x132/0x2f0
> 03384  __iomap_dio_rw+0x1e5/0x8c0
> 03384  iomap_dio_rw+0xc/0x30
> 03384  xfs_file_dio_write_aligned+0x84/0x130
> 03384  ? xfs_file_dio_read+0xcf/0x100
> 03384  xfs_file_write_iter+0xcb/0x110
> 03384  aio_write+0xf7/0x200
> 03384  ? check_preempt_curr+0x52/0x60
> 03384  ? try_to_wake_up+0x87/0x4c0
> 03384  ? preempt_count_add+0x45/0xb0
> 03384  ? aio_read_events_ring+0x1f6/0x230
> 03384  io_submit_one+0x460/0x6c0
> 03384  ? io_submit_one+0x460/0x6c0
> 03384  ? _raw_spin_unlock+0x11/0x30
> 03384  __x64_sys_io_submit+0x6b/0x130
> 03384  ? fpregs_assert_state_consistent+0x21/0x50
> 03384  ? exit_to_user_mode_prepare+0x2b/0x100
> 03384  do_syscall_64+0x34/0x80
> 03384  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 03384 RIP: 0033:0x7f4d776cb5a9
> 03384 RSP: 002b:00007fff729a72d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
> 03384 RAX: ffffffffffffffda RBX: 00007f4d6d141da8 RCX: 00007f4d776cb5a9
> 03384 RDX: 000055c01bef48a0 RSI: 0000000000000001 RDI: 00007f4d6d118000
> 03384 RBP: 00007f4d6d118000 R08: 0000000000000000 R09: 0000000000000100
> 03384 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> 03384 R13: 0000000000000000 R14: 000055c01bef48a0 R15: 00007f4d62e128f8
> 03384  </TASK>
> 03384 Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
> 
> 
