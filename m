Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA975949C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 13:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjGSLuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 07:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjGSLuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:50:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548221B5;
        Wed, 19 Jul 2023 04:50:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5FE1C67373; Wed, 19 Jul 2023 13:50:11 +0200 (CEST)
Date:   Wed, 19 Jul 2023 13:50:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: small writeback fixes
Message-ID: <20230719115010.GA15617@lst.de>
References: <20230713130431.4798-1-hch@lst.de> <20230718171744.GA843162@perftesting> <20230719053901.GA3241@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719053901.GA3241@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 07:39:01AM +0200, Christoph Hellwig wrote:
> My day was already over by the time you sent this, but I looked into
> it the first thing this morning.
> 
> I can't reproduce the hang, but my first thought was "why the heck do
> even end up in the fixup worker" given that there is no GUP-based
> dirtying in the thread.
> 
> I can reproduce the test case hitting the fixup worker now, while
> I can't on misc-next.  Looking into it now, but the rework of the
> fixup logic is a hot candidate.

So unfortunately even the BUG seems to trigger in a very sporadic
manner, making a bisect impossible.  This is made worse by me actually
hitting another hang (dmesg output below) way more frequently, but that
one actually reproduces on misc-next as well.  I'm also still confused
on how we hit the fixup worker, as that means we'll need to see a page
that.

  a) was dirty so that the writeback code picks it up
  b) had the delalloc bit already cleaned in the I/O tree
  c) does not have the orderd bit set

"btrfs: move the cow_fixup earlier in writepages handling" would
be the obvious candidate touching this area, even if I can't see
how it makes a difference.  Any chance you could check if it is
indeed the culprit?

And here is the more frequent hang I see with generic/475 loops:

  135.245713] BTRFS info (device dm-0): using crc32c (crc32c-intel) checksum algorithm
  [  135.246243] BTRFS info (device dm-0): using free space tree
  [  135.252874] BTRFS info (device dm-0): bdev /dev/mapper/error-test errs: wr 0, rd 0, flush 00
  [  135.255126] BTRFS info (device dm-0): auto enabling async discard
  [  363.683264] INFO: task kworker/u4:7:4288 blocked for more than 120 seconds.
  [  363.683948]       Not tainted 6.5.0-rc2+ #1662
  [  363.684290] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  [  363.684866] task:kworker/u4:7    state:D stack:0     pid:4288  ppid:2      flags:0x00004000
  [  363.685421] Workqueue: btrfs-cache btrfs_work_helper
  [  363.685763] Call Trace:
  [  363.685926]  <TASK>
  [  363.686067]  __schedule+0x406/0xcf0
  [  363.686314]  schedule+0x5d/0xe0
  [  363.686526]  io_schedule+0x41/0x70
  [  363.686751]  bit_wait_io+0x8/0x50
  [  363.686967]  __wait_on_bit+0x43/0x140
  [  363.688362]  ? bit_wait+0x50/0x50
  [  363.688607]  out_of_line_wait_on_bit+0x8f/0xb0
  [  363.688929]  ? collect_percpu_times+0x380/0x380
  [  363.689257]  read_extent_buffer_pages+0x18b/0x1d0
  [  363.689588]  btrfs_read_extent_buffer+0x8e/0x170
  [  363.689905]  read_tree_block+0x2e/0xa0
  [  363.690153]  read_block_for_search+0x23b/0x350
  [  363.690453]  btrfs_search_slot+0x2cf/0xe30
  [  363.690723]  ? _raw_read_unlock+0x24/0x40
  [  363.690990]  caching_thread+0x348/0x9e0
  [  363.699234]  btrfs_work_helper+0xe6/0x3d0
  [  363.699543]  ? lock_is_held_type+0xe3/0x140
  [  363.699859]  process_one_work+0x255/0x4e0
  [  363.700160]  worker_thread+0x4a/0x3a0
  [  363.700433]  ? _raw_spin_unlock_irqrestore+0x3b/0x60
  [  363.700773]  ? process_one_work+0x4e0/0x4e0
  [  363.701058]  kthread+0xee/0x120
  [  363.701275]  ? kthread_complete_and_exit+0x20/0x20
  [  363.701590]  ret_from_fork+0x28/0x40
  [  363.701833]  ? kthread_complete_and_exit+0x20/0x20
  [  363.702148]  ret_from_fork_asm+0x11/0x20
  [  363.702413] RIP: 0000:0x0
  [  363.702596] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
  [  363.703028] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
  [  363.704102] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
  [  363.704592] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  [  363.705076] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
  [  363.705552] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
  [  363.706024] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  [  363.706502]  </TASK>
  [  363.706665] INFO: task btrfs-transacti:8653 blocked for more than 120 seconds.
  [  363.707141]       Not tainted 6.5.0-rc2+ #1662
  [  363.719240] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  [  363.719833] task:btrfs-transacti state:D stack:0     pid:8653  ppid:2      flags:0x00004000
  [  363.720456] Call Trace:
  [  363.720643]  <TASK>
  [  363.720812]  __schedule+0x406/0xcf0
  [  363.721089]  schedule+0x5d/0xe0
  [  363.721314]  io_schedule+0x41/0x70
  [  363.721548]  bit_wait_io+0x8/0x50
  [  363.721778]  __wait_on_bit+0x43/0x140
  [  363.722031]  ? bit_wait+0x50/0x50
  [  363.722260]  out_of_line_wait_on_bit+0x8f/0xb0
  [  363.722566]  ? collect_percpu_times+0x380/0x380
  [  363.722877]  read_extent_buffer_pages+0x18b/0x1d0
  [  363.723221]  btrfs_read_extent_buffer+0x8e/0x170
  [  363.723542]  read_tree_block+0x2e/0xa0
  [  363.723804]  read_block_for_search+0x23b/0x350
  [  363.724115]  btrfs_search_slot+0x2cf/0xe30
  [  363.724401]  ? _raw_read_unlock+0x24/0x40
  [  363.724682]  lookup_inline_extent_backref+0x16c/0x770
  [  363.725038]  ? lock_acquire+0xe4/0x2d0
  [  363.725305]  lookup_extent_backref+0x3c/0xc0
  [  363.725605]  __btrfs_free_extent+0xf2/0x1070
  [  363.725907]  ? lock_release+0x142/0x290
  [  363.726176]  __btrfs_run_delayed_refs+0x2e8/0x1280
  [  363.726514]  ? btrfs_commit_transaction+0x38/0x1290
  [  363.726852]  btrfs_run_delayed_refs+0x70/0x1e0
  [  363.727161]  ? btrfs_commit_transaction+0x38/0x1290
  [  363.735220]  btrfs_commit_transaction+0xa7/0x1290
  [  363.735598]  ? start_transaction+0xc0/0x700
  [  363.735936]  transaction_kthread+0x139/0x1a0
  [  363.736284]  ? _raw_spin_unlock_irqrestore+0x3b/0x60
  [  363.736680]  ? close_ctree+0x5a0/0x5a0
  [  363.736944]  kthread+0xee/0x120
  [  363.737176]  ? kthread_complete_and_exit+0x20/0x20
  [  363.737506]  ret_from_fork+0x28/0x40
  [  363.737757]  ? kthread_complete_and_exit+0x20/0x20
  [  363.738087]  ret_from_fork_asm+0x11/0x20
  [  363.738356] RIP: 0000:0x0
  [  363.738544] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
  [  363.738986] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
  [  363.739512] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
  [  363.740001] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  [  363.740500] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
  [  363.740995] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
  [  363.741500] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  [  363.742008]  </TASK>
  [  363.742171] INFO: task fsstress:8657 blocked for more than 120 seconds.
  [  363.742630]       Not tainted 6.5.0-rc2+ #1662
  [  363.742941] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  [  363.751221] task:fsstress        state:D stack:0     pid:8657  ppid:8655   flags:0x00004002
  [  363.751839] Call Trace:
  [  363.752017]  <TASK>
  [  363.752178]  __schedule+0x406/0xcf0
  [  363.752427]  ? _raw_spin_unlock_irqrestore+0x2b/0x60
  [  363.752771]  ? __x64_sys_tee+0xc0/0xc0
  [  363.753041]  schedule+0x5d/0xe0
  [  363.753269]  wb_wait_for_completion+0x4d/0x80
  [  363.753574]  ? this_rq_lock_irq+0xa0/0xa0
  [  363.753858]  sync_inodes_sb+0xd4/0x470
  [  363.754124]  ? __x64_sys_tee+0xc0/0xc0
  [  363.754395]  iterate_supers+0x80/0xe0
  [  363.754661]  ksys_sync+0x3b/0xa0
  [  363.754893]  __do_sys_sync+0x5/0x10
  [  363.755137]  do_syscall_64+0x34/0x80
  [  363.755403]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
  [  363.755759] RIP: 0033:0x7f6039ab2a37
  [  363.756006] RSP: 002b:00007fff79cafd78 EFLAGS: 00000206 ORIG_RAX: 00000000000000a2
  [  363.756522] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f6039ab2a37
  [  363.757009] RDX: 00000000fd69c659 RSI: 00000000029639a6 RDI: 0000000000000007
  [  363.757511] RBP: 000000000007a120 R08: 0000000000000070 R09: 00007fff79caf89c
  [  363.757994] R10: 00007f60399bd258 R11: 0000000000000206 R12: 000055b6208925e0
  [  363.758483] R13: 028f5c28f5c28f5c R14: 8f5c28f5c28f5c29 R15: 000055b62087e620
  [  363.758988]  </TASK>
  [  363.759147] INFO: task fsstress:8658 blocked for more than 120 seconds.
  [  363.767219]       Not tainted 6.5.0-rc2+ #1662
  [  363.767560] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  [  363.768135] task:fsstress        state:D stack:0     pid:8658  ppid:8655   flags:0x00004002
  [  363.768753] Call Trace:
  [  363.768942]  <TASK>
  [  363.769116]  __schedule+0x406/0xcf0
  [  363.769363]  schedule+0x5d/0xe0
  [  363.769589]  io_schedule+0x41/0x70
  [  363.769831]  folio_wait_bit_common+0x11d/0x340
  [  363.770146]  ? filemap_get_folios_tag+0x378/0x450
  [  363.770484]  ? __probestub_file_check_and_advance_wb_err+0x10/0x10
  [  363.770925]  folio_wait_writeback+0x1f/0xa0
  [  363.771240]  __filemap_fdatawait_range+0x74/0xd0
  [  363.771575]  ? _raw_spin_unlock_irqrestore+0x3b/0x60
  [  363.771929]  ? __clear_extent_bit+0x173/0x4c0
  [  363.772242]  filemap_fdatawait_range+0x9/0x20
  [  363.772551]  __btrfs_wait_marked_extents.isra.0+0xb2/0xf0
  [  363.772928]  btrfs_wait_tree_log_extents+0x28/0xa0
  [  363.773281]  btrfs_sync_log+0x4a0/0xb90
  [  363.773567]  btrfs_sync_file+0x424/0x5e0
  [  363.773854]  __x64_sys_fsync+0x32/0x60
  [  363.774123]  do_syscall_64+0x34/0x80
  [  363.774381]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
  [  363.774735] RIP: 0033:0x7f6039ab29b0
  [  363.774988] RSP: 002b:00007fff79cafd48 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
  [  363.783212] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f6039ab29b0
  [  363.783739] RDX: 0000000000000105 RSI: 000055b62088b048 RDI: 0000000000000004
  [  363.784206] RBP: 0000000000000015 R08: 00007f6039b4e4c0 R09: 00007fff79cafd5c
  [  363.784683] R10: 00007f60399cab78 R11: 0000000000000202 R12: 00007fff79cafd60
  [  363.785184] R13: 028f5c28f5c28f5c R14: 8f5c28f5c28f5c29 R15: 000055b6208867c0
  [  363.785677]  </TASK>
  [  363.785837] INFO: task fsstress:8659 blocked for more than 120 seconds.
  [  363.786296]       Not tainted 6.5.0-rc2+ #1662
  [  363.786620] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  [  363.787157] task:fsstress        state:D stack:0     pid:8659  ppid:8655   flags:0x00000002
  [  363.787755] Call Trace:
  [  363.787940]  <TASK>
  [  363.788099]  __schedule+0x406/0xcf0
  [  363.788348]  schedule+0x5d/0xe0
  [  363.788573]  io_schedule+0x41/0x70
  [  363.788816]  folio_wait_bit_common+0x11d/0x340
  [  363.789140]  ? __probestub_file_check_and_advance_wb_err+0x10/0x10
  [  363.789565]  extent_write_cache_pages+0x41e/0x7b0
  [  363.789892]  ? __kernel_text_address+0x9/0x30
  [  363.790196]  ? unwind_get_return_address+0x16/0x30
  [  363.790538]  extent_writepages+0x7e/0x100
  [  363.790823]  do_writepages+0xc5/0x180
  [  363.791087]  filemap_fdatawrite_wbc+0x56/0x80
  [  363.799222]  __filemap_fdatawrite_range+0x53/0x70
  [  363.799596]  btrfs_remap_file_range+0x132/0x620
  [  363.799944]  vfs_dedupe_file_range_one+0x177/0x1f0
  [  363.800297]  vfs_dedupe_file_range+0x186/0x1f0
  [  363.800620]  do_vfs_ioctl+0x49d/0x930
  [  363.800890]  __x64_sys_ioctl+0x64/0xc0
  [  363.801170]  do_syscall_64+0x34/0x80
  [  363.801430]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
  [  363.801784] RIP: 0033:0x7f6039ab1afb
  [  363.802038] RSP: 002b:00007fff79cafc70 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  [  363.802555] RAX: ffffffffffffffda RBX: 000055b6224398e8 RCX: 00007f6039ab1afb
  [  363.803038] RDX: 000055b6224397c0 RSI: 00000000c0189436 RDI: 0000000000000004
  [  363.803544] RBP: 000055b622439988 R08: 000055b6224399c0 R09: 000055b6224399a4
  [  363.804039] R10: 0000000000001000 R11: 0000000000000246 R12: 000055b622439820
  [  363.804520] R13: 000000000000000b R14: 0000000000000002 R15: 0000000000007000
  [  363.805015]  </TASK>
  [  363.805204] 
  [  363.805204] Showing all locks held in the system:
  [  363.805646] 1 lock held by rcu_tasks_kthre/11:
  [  363.805965]  #0: ffffffff839bf8f0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one0
  [  363.806625] 1 lock held by rcu_tasks_trace/12:
  [  363.806936]  #0: ffffffff839bf630 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tas0
  [  363.815221] 1 lock held by khungtaskd/24:
  [  363.815528]  #0: ffffffff839c0360 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0xe0
  [  363.816232] 1 lock held by in:imklog/3192:
  [  363.816570]  #0: ffff8881076fb788 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x43/0x50
  [  363.817228] 4 locks held by kworker/u4:6/4181:
  [  363.817546] 4 locks held by kworker/u4:7/4288:
  [  363.817859]  #0: ffff888113284d38 ((wq_completion)btrfs-cache){+.+.}-{0:0}, at: process_one0
  [  363.818539]  #1: ffffc90004b4fe58 ((work_completion)(&work->normal_work)){+.+.}-{0:0}, at: 0
  [  363.819289]  #2: ffff8881168d5078 (&caching_ctl->mutex){+.+.}-{3:3}, at: caching_thread+0x40
  [  363.819904]  #3: ffff88810d5acab0 (&fs_info->commit_root_sem){++++}-{3:3}, at: caching_thre0
  [  363.820560] 6 locks held by btrfs-transacti/8653:
  [  363.820888]  #0: ffff88810d5ac7d0 (&fs_info->transaction_kthread_mutex){+.+.}-{3:3}, at: tr0
  [  363.821625]  #1: ffff88810d5ae378 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transacti0
  [  363.822276]  #2: ffff88810d5ae3a0 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transa0
  [  363.822944]  #3: ffff88810d5ae3c8 (btrfs_trans_commit_start){.+.+}-{0:0}, at: btrfs_commit_0
  [  363.835223]  #4: ffff88810da5ca28 (&head_ref->mutex){+.+.}-{3:3}, at: btrfs_delayed_ref_loc0
  [  363.835936]  #5: ffff8881149c7548 (btrfs-extent-01#2){++++}-{3:3}, at: __btrfs_tree_lock+0x0
  [  363.836570] 2 locks held by fsstress/8657:
  [  363.836857]  #0: ffff88810da390e0 (&type->s_umount_key#51){++++}-{3:3}, at: iterate_supers+0
  [  363.837504]  #1: ffff88810da3c7d0 (&bdi->wb_switch_rwsem){++++}-{3:3}, at: sync_inodes_sb+00
  [  363.838126] 4 locks held by fsstress/8658:
  [  363.838408]  #0: ffff88810da395f0 (sb_internal#2){.+.+}-{0:0}, at: btrfs_sync_file+0x339/0x0
  [  363.838994]  #1: ffff88810d5ae378 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transacti0
  [  363.843228]  #2: ffff88810d5ae3a0 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transa0
  [  363.844006]  #3: ffff888115b193b0 (&root->log_mutex){+.+.}-{3:3}, at: btrfs_sync_log+0x303/0
  [  363.844690] 3 locks held by fsstress/8659:
  [  363.844973]  #0: ffff88810da39400 (sb_writers#14){.+.+}-{0:0}, at: vfs_dedupe_file_range_on0
  [  363.845612]  #1: ffff888111ef2110 (&sb->s_type->i_mutex_key#18){++++}-{3:3}, at: btrfs_inod0
  [  363.846264]  #2: ffff888111ef1f98 (&ei->i_mmap_lock){++++}-{3:3}, at: btrfs_inode_lock+0x440
  [  363.846858] 4 locks held by fsstress/8660:
  [  363.847136] 1 lock held by dmsetup/8661:
  [  363.851231]  #0: ffff88811549d068 (&md->suspend_lock/1){+.+.}-{3:3}, at: dm_suspend+0x23/0x0
  [  363.851867] 
  [  363.851993] =============================================
  [  363.851993] 
  [  484.515287] INFO: task kworker/u4:7:4288 blocked for more than 241 seconds.
  [  484.515907]       Not tainted 6.5.0-rc2+ #1662
  [  484.516254] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  [  484.516822] task:kworker/u4:7    state:D stack:0     pid:4288  ppid:2      flags:0x00004000
  [  484.517411] Workqueue: btrfs-cache btrfs_work_helper
  [  484.517772] Call Trace:
  [  484.517950]  <TASK>
  [  484.518107]  __schedule+0x406/0xcf0
  [  484.518364]  schedule+0x5d/0xe0
  [  484.518591]  io_schedule+0x41/0x70
  [  484.518839]  bit_wait_io+0x8/0x50
  [  484.519079]  __wait_on_bit+0x43/0x140
  [  484.520645]  ? bit_wait+0x50/0x50
  [  484.521078]  out_of_line_wait_on_bit+0x8f/0xb0
  [  484.521409]  ? collect_percpu_times+0x380/0x380
  [  484.521731]  read_extent_buffer_pages+0x18b/0x1d0
  [  484.522065]  btrfs_read_extent_buffer+0x8e/0x170
  [  484.522392]  read_tree_block+0x2e/0xa0
  [  484.522658]  read_block_for_search+0x23b/0x350
  [  484.522978]  btrfs_search_slot+0x2cf/0xe30
  [  484.529712]  ? _raw_read_unlock+0x24/0x40
  [  484.530361]  caching_thread+0x348/0x9e0
  [  484.530747]  btrfs_work_helper+0xe6/0x3d0
  [  484.531037]  ? lock_is_held_type+0xe3/0x140
  [  484.531510]  process_one_work+0x255/0x4e0
  [  484.531823]  worker_thread+0x4a/0x3a0
  [  484.532089]  ? _raw_spin_unlock_irqrestore+0x3b/0x60
  [  484.532530]  ? process_one_work+0x4e0/0x4e0
  [  484.532932]  kthread+0xee/0x120
  [  484.533201]  ? kthread_complete_and_exit+0x20/0x20
  [  484.533537]  ret_from_fork+0x28/0x40
  [  484.533796]  ? kthread_complete_and_exit+0x20/0x20
  [  484.534145]  ret_from_fork_asm+0x11/0x20
  [  484.534431] RIP: 0000:0x0
  [  484.534630] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
  [  484.536665] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
  [  484.537222] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
  [  484.537726] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  [  484.538245] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
  [  484.538754] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
  [  484.547221] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  [  484.547899]  </TASK>
  [  484.548073] INFO: task btrfs-transacti:8653 blocked for more than 241 seconds.
  [  484.548592]       Not tainted 6.5.0-rc2+ #1662
  [  484.548909] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  [  484.549452] task:btrfs-transacti state:D stack:0     pid:8653  ppid:2      flags:0x00004000
  [  484.550050] Call Trace:
  [  484.550243]  <TASK>
  [  484.550408]  __schedule+0x406/0xcf0
  [  484.550684]  schedule+0x5d/0xe0
  [  484.550921]  io_schedule+0x41/0x70
  [  484.551176]  bit_wait_io+0x8/0x50
  [  484.552000]  __wait_on_bit+0x43/0x140
  [  484.552295]  ? bit_wait+0x50/0x50
  [  484.552549]  out_of_line_wait_on_bit+0x8f/0xb0
  [  484.552884]  ? collect_percpu_times+0x380/0x380
  [  484.553221]  read_extent_buffer_pages+0x18b/0x1d0
  [  484.553569]  btrfs_read_extent_buffer+0x8e/0x170
  [  484.553914]  read_tree_block+0x2e/0xa0
  [  484.554194]  read_block_for_search+0x23b/0x350
  [  484.554533]  btrfs_search_slot+0x2cf/0xe30
  [  484.554846]  ? _raw_read_unlock+0x24/0x40
  [  484.555144]  lookup_inline_extent_backref+0x16c/0x770
  [  484.563223]  ? lock_acquire+0xe4/0x2d0
  [  484.563556]  lookup_extent_backref+0x3c/0xc0
  [  484.563905]  __btrfs_free_extent+0xf2/0x1070
  [  484.564234]  ? lock_release+0x142/0x290
  [  484.564533]  __btrfs_run_delayed_refs+0x2e8/0x1280
  [  484.564910]  ? btrfs_commit_transaction+0x38/0x1290
  [  484.565283]  btrfs_run_delayed_refs+0x70/0x1e0
  [  484.565629]  ? btrfs_commit_transaction+0x38/0x1290
  [  484.566007]  btrfs_commit_transaction+0xa7/0x1290
  [  484.566372]  ? start_transaction+0xc0/0x700
  [  484.566697]  transaction_kthread+0x139/0x1a0
  [  484.567033]  ? _raw_spin_unlock_irqrestore+0x3b/0x60
  [  484.567952]  ? close_ctree+0x5a0/0x5a0
  [  484.568261]  kthread+0xee/0x120
  [  484.568515]  ? kthread_complete_and_exit+0x20/0x20

