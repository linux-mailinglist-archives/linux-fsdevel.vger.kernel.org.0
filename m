Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C812ADA78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 16:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbgKJPfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 10:35:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:42398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730368AbgKJPfP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:35:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C2C6ABCC;
        Tue, 10 Nov 2020 15:35:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B0291DA7D7; Tue, 10 Nov 2020 16:33:27 +0100 (CET)
Date:   Tue, 10 Nov 2020 16:33:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Filipe Manana <fdmanana@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC] fs: Avoid to use lockdep information if it's turned off
Message-ID: <20201110153327.GL6756@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Filipe Manana <fdmanana@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@kernel.org>
References: <20201110013739.686731-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110013739.686731-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 09:37:37AM +0800, Boqun Feng wrote:
> Filipe Manana reported a warning followed by task hanging after attempts
> to freeze a filesystem[1]. The problem happened in a LOCKDEP=y kernel,
> and percpu_rwsem_is_held() provided incorrect results when
> debug_locks == 0. Although the behavior is caused by commit 4d004099a668
> ("lockdep: Fix lockdep recursion"): after that lock_is_held() and its
> friends always return true if debug_locks == 0. However, one could argue
> that querying the lock holding information regardless if the lockdep
> turn-off status is inappropriate in the first place. Therefore instead
> of reverting lock_is_held() and its friends to the previous semantics,
> add the explicit checking in fs code to avoid use the lock holding
> information if lockdpe is turned off. And since the original problem
> also happened with a silent lockdep turn-off, put a warning if
> debug_locks is 0, which will help us spot the silent lockdep turn-offs.
> 
> [1]: https://lore.kernel.org/lkml/a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com/
> 
> Reported-by: Filipe Manana <fdmanana@gmail.com>
> Fixes: 4d004099a668 ("lockdep: Fix lockdep recursion")
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Nikolay Borisov <nborisov@suse.com>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> ---
> Hi Filipe,
> 
> I use the slightly different approach to fix this problem, and I think
> it should have the similar effect with my previous fix[2], except that
> you will hit a warning if the problem happens now. The warning is added
> on purpose because I don't want to miss a silent lockdep turn-off.

Applied on current master (407ab579637ce) it explodes in btrfs/078 and
then warning appears in folowup tests. The first report seems to be mix
of two so I'm pasting it as it got stored to the serial console, it
might give you some clues.

I'll run another test on top of the development branch in case there are
unrelated lockdep warning bugs that have been fixed meanwhile.

btrfs/078		[15:15:44][ 3963.635042] run fstests btrfs/078 at 2020-11-10 15:15:44
[ 3964.301547] BTRFS info (device vda): disk space caching is enabled
[ 3964.303698] BTRFS info (device vda): has skinny extents
[ 3964.595919] BTRFS: device fsid 6652279f-2c14-4db4-9622-77d2bc7ea516 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (18614)
[ 3964.646896] BTRFS info (device vdb): turning on sync discard
[ 3964.648627] BTRFS info (device vdb): disk space caching is enabled
[ 3964.650483] BTRFS info (device vdb): has skinny extents
[ 3964.652107] BTRFS info (device vdb): flagging fs with big metadata feature
[ 3964.662211] BTRFS info (device vdb): checking UUID tree
[ 4173.535475] 
[ 4173.535670] ------------[ cut here ]------------
[ 4173.536750] ============================================
[ 4173.536754] WARNING: possible recursive locking detected
[ 4173.538755] WARNING: CPU: 2 PID: 18647 at fs/super.c:1676 __sb_start_write+0x113/0x2a0
[ 4173.541456] 5.10.0-rc3-default+ #1353 Not tainted
[ 4173.543478] Modules linked in:
[ 4173.546291] --------------------------------------------
[ 4173.547580]  dm_flakey
[ 4173.548722] btrfs/19276 is trying to acquire lock:
[ 4173.548725] ffffa19a7e420eb8
[ 4173.550243]  dm_mod xxhash_generic
[ 4173.551164]  (&eb->lock){++++}-{2:2}, at: btrfs_tree_read_lock_atomic+0x34/0x150 [btrfs]
[ 4173.551285] 
[ 4173.551285] but task is already holding lock:
[ 4173.552745]  btrfs
[ 4173.553789] ffffa19a7e4207b8 (
[ 4173.554894]  blake2b_generic
[ 4173.557288] &eb->lock){++++}-{2:2}
[ 4173.559162]  libcrc32c
[ 4173.559833] , at: btrfs_tree_read_lock_atomic+0x34/0x150 [btrfs]
[ 4173.559835] 
[ 4173.559835] other info that might help us debug this:
[ 4173.560803]  crc32c_intel
[ 4173.561735]  Possible unsafe locking scenario:
[ 4173.561735] 
[ 4173.561737]        CPU0
[ 4173.562815]  xor
[ 4173.563612]        ----
[ 4173.563615]   lock(
[ 4173.565378]  zstd_decompress
[ 4173.567138] &eb->lock);
[ 4173.567139]   lock(&eb->lock);
[ 4173.567140] 
[ 4173.567140]  *** DEADLOCK ***
[ 4173.567140] 
[ 4173.567141]  May be due to missing lock nesting notation
[ 4173.567141] 
[ 4173.567142] 4 locks held by btrfs/19276:
[ 4173.567142]  #0: ffffa19a704d4478 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write_file+0x22/0x70
[ 4173.567149]  #1: ffffa19a5901c570 (
[ 4173.567953]  zstd_compress
[ 4173.569465] &type->i_mutex_dir_key#7
[ 4173.570248]  xxhash
[ 4173.570784] /1){+.+.}-{3:3}, at: btrfs_mksubvol+0x56/0x1b0 [btrfs]
[ 4173.570810]  #2: 
[ 4173.571609]  lzo_compress
[ 4173.572203] ffffa19a62b0ccc0 (
[ 4173.573023]  lzo_decompress raid6_pq
[ 4173.573859] &fs_info->subvol_sem
[ 4173.574759]  loop
[ 4173.576320] ){++++}-{3:3}, at: btrfs_mksubvol+0xdd/0x1b0 [btrfs]
[ 4173.578167] 
[ 4173.579263]  #3: ffffa19a7e4207b8 (&eb->lock){++++}-{2:2}, at: btrfs_tree_read_lock_atomic+0x34/0x150 [btrfs]
[ 4173.579289] 
[ 4173.579289] stack backtrace:
[ 4173.581636] CPU: 2 PID: 18647 Comm: fsstress Not tainted 5.10.0-rc3-default+ #1353
[ 4173.582677] CPU: 1 PID: 19276 Comm: btrfs Not tainted 5.10.0-rc3-default+ #1353
[ 4173.582678] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 4173.582685] Call Trace:
[ 4173.582692]  dump_stack+0x77/0x97
[ 4173.583498] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 4173.584559]  validate_chain+0x367/0x780
[ 4173.585276] RIP: 0010:__sb_start_write+0x113/0x2a0
[ 4173.586929]  __lock_acquire+0x3fb/0x730
[ 4173.586931]  lock_acquire.part.0+0xac/0x1a0
[ 4173.586953]  ? btrfs_tree_read_lock_atomic+0x34/0x150 [btrfs]
[ 4173.586957]  ? rcu_read_lock_sched_held+0x3f/0x70
[ 4173.587610] Code: f3 f8 da 77 85 c0 0f 84 95 01 00 00 40 84 ed 0f 85 4c 01 00 00 45 84 e4 0f 85 75 01 00 00 5b 44 89 e8 5d 41 5c 41 5d 41 5e c3 <0f> 0b 48 89 e8 31 d2 be 31 00 00 00 48 c7 c7 7a 99 e4 88 48 c1 e0
[ 4173.588386]  ? lock_acquire+0xc4/0x150
[ 4173.589241] RSP: 0018:ffffb35a06cc7c10 EFLAGS: 00010246
[ 4173.590123]  ? btrfs_tree_read_lock_atomic+0x34/0x150 [btrfs]
[ 4173.590938] 
[ 4173.591473]  _raw_read_lock+0x40/0xa0
[ 4173.592825] RAX: 0000000000000001 RBX: ffffa19a704d4478 RCX: 0000000000000000
[ 4173.593343]  ? btrfs_tree_read_lock_atomic+0x34/0x150 [btrfs]
[ 4173.595900] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffa19a704d4478
[ 4173.597072]  btrfs_tree_read_lock_atomic+0x34/0x150 [btrfs]
[ 4173.599104] RBP: 0000000000000003 R08: 00000000000001b8 R09: ffffa19a5c24f138
[ 4173.601184]  btrfs_search_slot+0x546/0x9f0 [btrfs]
[ 4173.603798] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
[ 4173.604569]  btrfs_lookup_inode+0x3a/0xc0 [btrfs]
[ 4173.605462] R13: ffffa19a704d4398 R14: ffffa19a704d4698 R15: ffffa19a62b0c000
[ 4173.608583]  btrfs_read_locked_inode+0x519/0x640 [btrfs]
[ 4173.608599]  btrfs_iget_path+0x8d/0xd0 [btrfs]
[ 4173.609634] FS:  00007fd2627f4b80(0000) GS:ffffa19abda00000(0000) knlGS:0000000000000000
[ 4173.611006]  btrfs_lookup_dentry+0x13c/0x1f0 [btrfs]
[ 4173.611026]  create_snapshot+0x27e/0x2e0 [btrfs]
[ 4173.611925] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4173.613129]  btrfs_mksubvol+0x111/0x1b0 [btrfs]
[ 4173.614480] CR2: 0000000000729e88 CR3: 0000000022ed5001 CR4: 0000000000170ea0
[ 4173.615823]  btrfs_mksnapshot+0x7b/0xb0 [btrfs]
[ 4173.615843]  __btrfs_ioctl_snap_create+0x16f/0x1a0 [btrfs]
[ 4173.620679] Call Trace:
[ 4173.621833]  btrfs_ioctl_snap_create_v2+0xb0/0xf0 [btrfs]
[ 4173.623251]  start_transaction+0x406/0x510 [btrfs]
[ 4173.624425]  btrfs_ioctl+0x6bd/0xb50 [btrfs]
[ 4173.624929]  btrfs_dirty_inode+0x44/0xd0 [btrfs]
[ 4173.625878]  __x64_sys_ioctl+0x83/0xa0
[ 4173.627746]  touch_atime+0xb2/0x100
[ 4173.629063]  do_syscall_64+0x2d/0x70
[ 4173.630537]  generic_file_buffered_read+0x778/0x8f0
[ 4173.631650]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 4173.631652] RIP: 0033:0x7f3e367da8a7
[ 4173.631654] Code: 3c 1c 48 f7 d8 49 39 c4 72 b9 e8 24 ff ff ff 85 c0 78 be 4c 89 e0 5b 5d 41 5c c3 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 b5 0c 00 f7 d8 64 89 01 48
[ 4173.631656] RSP: 002b:00007ffeeb887c58 EFLAGS: 00000202
[ 4173.633130]  generic_file_splice_read+0xf9/0x1b0
[ 4173.634113]  ORIG_RAX: 0000000000000010
[ 4173.635515]  do_splice+0x370/0x3c0
[ 4173.636517] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f3e367da8a7
[ 4173.636519] RDX: 00007ffeeb887d30 RSI: 0000000050009417 RDI: 0000000000000003
[ 4173.637945]  __do_splice+0xde/0x160
[ 4173.639080] RBP: 00007f3e366e16a8 R08: 0000000000000010 R09: 0000000000000004
[ 4173.639081] R10: 000055969c45021c R11: 0000000000000202 R12: 00007ffeeb887d30
[ 4173.639081] R13: 000055969c5402a0 R14: 000055969c5402d0 R15: 0000000000000000
[ 4173.685866]  __x64_sys_splice+0x92/0x110
[ 4173.687427]  do_syscall_64+0x2d/0x70
[ 4173.688427]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 4173.690089] RIP: 0033:0x7fd2628f61c6
[ 4173.691699] Code: 48 c7 c0 ff ff ff ff eb b9 66 2e 0f 1f 84 00 00 00 00 00 90 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 13 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 72 c3 90 55 48 83 ec 30 44 89 4c 24 2c 4c 89
[ 4173.696840] RSP: 002b:00007ffe4fdf3748 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
[ 4173.698781] RAX: ffffffffffffffda RBX: 0000000000473421 RCX: 00007fd2628f61c6
[ 4173.700341] RDX: 0000000000000006 RSI: 00007ffe4fdf3778 RDI: 0000000000000003
[ 4173.702153] RBP: 0000000000000004 R08: 000000000001b0fa R09: 0000000000000000
[ 4173.703879] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000001779
[ 4173.705630] R13: 0000000000000003 R14: 000000000001b0fa R15: 0000000000000000
[ 4173.707398] CPU: 2 PID: 18647 Comm: fsstress Not tainted 5.10.0-rc3-default+ #1353
[ 4173.709347] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 4173.724526] Call Trace:
[ 4173.725284]  dump_stack+0x77/0x97
[ 4173.726189]  ? __sb_start_write+0x113/0x2a0
[ 4173.727327]  __warn.cold+0x24/0x83
[ 4173.728230]  ? __sb_start_write+0x113/0x2a0
[ 4173.729337]  report_bug+0x9a/0xc0
[ 4173.730255]  handle_bug+0x3c/0x60
[ 4173.731132]  exc_invalid_op+0x14/0x70
[ 4173.732057]  asm_exc_invalid_op+0x12/0x20
[ 4173.733107] RIP: 0010:__sb_start_write+0x113/0x2a0
[ 4173.734324] Code: f3 f8 da 77 85 c0 0f 84 95 01 00 00 40 84 ed 0f 85 4c 01 00 00 45 84 e4 0f 85 75 01 00 00 5b 44 89 e8 5d 41 5c 41 5d 41 5e c3 <0f> 0b 48 89 e8 31 d2 be 31 00 00 00 48 c7 c7 7a 99 e4 88 48 c1 e0
[ 4173.738687] RSP: 0018:ffffb35a06cc7c10 EFLAGS: 00010246
[ 4173.740042] RAX: 0000000000000001 RBX: ffffa19a704d4478 RCX: 0000000000000000
[ 4173.741919] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffa19a704d4478
[ 4173.744107] RBP: 0000000000000003 R08: 00000000000001b8 R09: ffffa19a5c24f138
[ 4173.746113] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
[ 4173.748296] R13: ffffa19a704d4398 R14: ffffa19a704d4698 R15: ffffa19a62b0c000
[ 4173.750518]  start_transaction+0x406/0x510 [btrfs]
[ 4173.751759]  btrfs_dirty_inode+0x44/0xd0 [btrfs]
[ 4173.752738]  touch_atime+0xb2/0x100
[ 4173.753752]  generic_file_buffered_read+0x778/0x8f0
[ 4173.754955]  generic_file_splice_read+0xf9/0x1b0
[ 4173.756098]  do_splice+0x370/0x3c0
[ 4173.757046]  __do_splice+0xde/0x160
[ 4173.757882]  __x64_sys_splice+0x92/0x110
[ 4173.758960]  do_syscall_64+0x2d/0x70
[ 4173.759885]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 4173.761016] RIP: 0033:0x7fd2628f61c6
[ 4173.761834] Code: 48 c7 c0 ff ff ff ff eb b9 66 2e 0f 1f 84 00 00 00 00 00 90 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 13 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 72 c3 90 55 48 83 ec 30 44 89 4c 24 2c 4c 89
[ 4173.766023] RSP: 002b:00007ffe4fdf3748 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
[ 4173.767748] RAX: ffffffffffffffda RBX: 0000000000473421 RCX: 00007fd2628f61c6
[ 4173.769331] RDX: 0000000000000006 RSI: 00007ffe4fdf3778 RDI: 0000000000000003
[ 4173.770809] RBP: 0000000000000004 R08: 000000000001b0fa R09: 0000000000000000
[ 4173.772335] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000001779
[ 4173.774046] R13: 0000000000000003 R14: 000000000001b0fa R15: 0000000000000000
[ 4173.775983] irq event stamp: 15494042
[ 4173.777099] hardirqs last  enabled at (15494041): [<ffffffff882498e2>] __slab_free+0x322/0x3e0
[ 4173.779317] hardirqs last disabled at (15494042): [<ffffffff8824b644>] __slab_alloc.constprop.0+0x94/0x170
[ 4173.781575] softirqs last  enabled at (15487856): [<ffffffff88a00333>] __do_softirq+0x333/0x5c2
[ 4173.783487] softirqs last disabled at (15487851): [<ffffffff88800dbf>] asm_call_irq_on_stack+0xf/0x20
[ 4173.785680] ---[ end trace 04c54d8226296c31 ]---
[ 4277.745950] BTRFS info (device vdb): turning on sync discard
[ 4277.749265] BTRFS info (device vdb): disk space caching is enabled
[ 4277.752718] BTRFS info (device vdb): has skinny extents
_check_dmesg: something found in dmesg (see /tmp/fstests/results//btrfs/078.dmesg)
 [15:20:59]
btrfs/079		[15:20:59][ 4278.696345] run fstests btrfs/079 at 2020-11-10 15:20:59
[ 4279.167520] BTRFS info (device vda): disk space caching is enabled
[ 4279.169666] BTRFS info (device vda): has skinny extents
[ 4279.347248] ------------[ cut here ]------------
[ 4279.349775] WARNING: CPU: 1 PID: 19750 at fs/super.c:1676 __sb_start_write+0x113/0x2a0
[ 4279.353817] Modules linked in: dm_flakey dm_mod xxhash_generic btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
[ 4279.357043] CPU: 1 PID: 19750 Comm: xfs_io Tainted: G        W         5.10.0-rc3-default+ #1353
[ 4279.359696] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 4279.363070] RIP: 0010:__sb_start_write+0x113/0x2a0
[ 4279.364568] Code: f3 f8 da 77 85 c0 0f 84 95 01 00 00 40 84 ed 0f 85 4c 01 00 00 45 84 e4 0f 85 75 01 00 00 5b 44 89 e8 5d 41 5c 41 5d 41 5e c3 <0f> 0b 48 89 e8 31 d2 be 31 00 00 00 48 c7 c7 7a 99 e4 88 48 c1 e0
[ 4279.370167] RSP: 0018:ffffb35a078c7b40 EFLAGS: 00010246
[ 4279.371710] RAX: 0000000000000001 RBX: ffffa19a4c764478 RCX: 0000000000000000
[ 4279.373768] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffa19a4c764478
[ 4279.375769] RBP: 0000000000000003 R08: 00000000000001b8 R09: ffffa19a5c1a34a8
[ 4279.377871] R10: 0000000000000001 R11: 9494acff9096a08c R12: 0000000000000001
[ 4279.379960] R13: ffffa19a4c764398 R14: ffffa19a4c764698 R15: ffffa19a598e0000
[ 4279.382060] FS:  00007f5cdce3fe80(0000) GS:ffffa19abd800000(0000) knlGS:0000000000000000
[ 4279.384159] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4279.385555] CR2: 00007f5cdcf57520 CR3: 0000000065e8f005 CR4: 0000000000170ea0
[ 4279.387201] Call Trace:
[ 4279.387867]  start_transaction+0x406/0x510 [btrfs]
[ 4279.389165]  btrfs_create+0x55/0x210 [btrfs]
[ 4279.390255]  lookup_open+0x24e/0x3f0
[ 4279.391151]  open_last_lookups+0xa5/0x360
[ 4279.392108]  path_openat+0x9c/0x1b0
[ 4279.392934]  ? getname_flags+0x29/0x180
[ 4279.393852]  do_filp_open+0x88/0x130
[ 4279.394706]  ? lock_release+0xb0/0x160
[ 4279.395553]  ? do_raw_spin_unlock+0x4b/0xa0
[ 4279.396515]  ? _raw_spin_unlock+0x29/0x40
[ 4279.397480]  ? __alloc_fd+0xfc/0x1e0
[ 4279.398309]  do_sys_openat2+0x97/0x150
[ 4279.399184]  __x64_sys_openat+0x54/0x90
[ 4279.400093]  do_syscall_64+0x2d/0x70
[ 4279.400953]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 4279.402062] RIP: 0033:0x7f5cdd08a047
[ 4279.402913] Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
[ 4279.407507] RSP: 002b:00007ffc1c0e7650 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[ 4279.409434] RAX: ffffffffffffffda RBX: 0000000000000042 RCX: 00007f5cdd08a047
[ 4279.411235] RDX: 0000000000000042 RSI: 00007ffc1c0ea12b RDI: 00000000ffffff9c
[ 4279.413054] RBP: 00007ffc1c0ea12b R08: 0000000000000001 R09: 0000000000000000
[ 4279.414800] R10: 0000000000000180 R11: 0000000000000246 R12: 0000000000000042
[ 4279.416190] R13: 00007ffc1c0e7a40 R14: 0000000000000180 R15: 0000000000000020
[ 4279.417752] CPU: 1 PID: 19750 Comm: xfs_io Tainted: G        W         5.10.0-rc3-default+ #1353
[ 4279.419690] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 4279.422386] Call Trace:
[ 4279.423023]  dump_stack+0x77/0x97
[ 4279.423788]  ? __sb_start_write+0x113/0x2a0
[ 4279.424716]  __warn.cold+0x24/0x83
[ 4279.425666]  ? __sb_start_write+0x113/0x2a0
[ 4279.426882]  report_bug+0x9a/0xc0
[ 4279.427895]  handle_bug+0x3c/0x60
[ 4279.428914]  exc_invalid_op+0x14/0x70
[ 4279.430005]  asm_exc_invalid_op+0x12/0x20
[ 4279.431114] RIP: 0010:__sb_start_write+0x113/0x2a0
[ 4279.432210] Code: f3 f8 da 77 85 c0 0f 84 95 01 00 00 40 84 ed 0f 85 4c 01 00 00 45 84 e4 0f 85 75 01 00 00 5b 44 89 e8 5d 41 5c 41 5d 41 5e c3 <0f> 0b 48 89 e8 31 d2 be 31 00 00 00 48 c7 c7 7a 99 e4 88 48 c1 e0
[ 4279.436059] RSP: 0018:ffffb35a078c7b40 EFLAGS: 00010246
[ 4279.437512] RAX: 0000000000000001 RBX: ffffa19a4c764478 RCX: 0000000000000000
[ 4279.439467] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffa19a4c764478
[ 4279.441477] RBP: 0000000000000003 R08: 00000000000001b8 R09: ffffa19a5c1a34a8
[ 4279.443437] R10: 0000000000000001 R11: 9494acff9096a08c R12: 0000000000000001
[ 4279.445451] R13: ffffa19a4c764398 R14: ffffa19a4c764698 R15: ffffa19a598e0000
[ 4279.447418]  start_transaction+0x406/0x510 [btrfs]
[ 4279.448808]  btrfs_create+0x55/0x210 [btrfs]
[ 4279.450031]  lookup_open+0x24e/0x3f0
[ 4279.450937]  open_last_lookups+0xa5/0x360
[ 4279.452060]  path_openat+0x9c/0x1b0
[ 4279.453066]  ? getname_flags+0x29/0x180
[ 4279.454158]  do_filp_open+0x88/0x130
[ 4279.455176]  ? lock_release+0xb0/0x160
[ 4279.456241]  ? do_raw_spin_unlock+0x4b/0xa0
[ 4279.457372]  ? _raw_spin_unlock+0x29/0x40
[ 4279.458255]  ? __alloc_fd+0xfc/0x1e0
[ 4279.459094]  do_sys_openat2+0x97/0x150
[ 4279.459990]  __x64_sys_openat+0x54/0x90
[ 4279.460866]  do_syscall_64+0x2d/0x70
[ 4279.461678]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 4279.462792] RIP: 0033:0x7f5cdd08a047
[ 4279.463576] Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
[ 4279.468060] RSP: 002b:00007ffc1c0e7650 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[ 4279.470116] RAX: ffffffffffffffda RBX: 0000000000000042 RCX: 00007f5cdd08a047
[ 4279.471992] RDX: 0000000000000042 RSI: 00007ffc1c0ea12b RDI: 00000000ffffff9c
[ 4279.473856] RBP: 00007ffc1c0ea12b R08: 0000000000000001 R09: 0000000000000000
[ 4279.475705] R10: 0000000000000180 R11: 0000000000000246 R12: 0000000000000042
[ 4279.477572] R13: 00007ffc1c0e7a40 R14: 0000000000000180 R15: 0000000000000020
[ 4279.479449] irq event stamp: 0
[ 4279.480273] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 4279.481987] hardirqs last disabled at (0): [<ffffffff8807134b>] copy_process+0x3db/0x1440
[ 4279.484109] softirqs last  enabled at (0): [<ffffffff8807134b>] copy_process+0x3db/0x1440
[ 4279.485936] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 4279.487320] ---[ end trace 04c54d8226296c32 ]---
[ 4279.612947] BTRFS: device fsid a0190661-0fb3-4ea9-a258-3564f7237753 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (19767)
[ 4279.643470] BTRFS info (device vdb): turning on sync discard
[ 4279.645293] BTRFS info (device vdb): disk space caching is enabled
[ 4279.647937] BTRFS info (device vdb): has skinny extents
[ 4279.650181] BTRFS info (device vdb): flagging fs with big metadata feature
[ 4279.657915] BTRFS info (device vdb): checking UUID tree
[ 4425.026967] BTRFS info (device vdb): turning on sync discard
[ 4425.028653] BTRFS info (device vdb): disk space caching is enabled
[ 4425.030472] BTRFS info (device vdb): has skinny extents
_check_dmesg: something found in dmesg (see /tmp/fstests/results//btrfs/079.dmesg)
 [15:23:26]
btrfs/080		[15:23:26][ 4426.585916] run fstests btrfs/080 at 2020-11-10 15:23:27
[ 4427.202665] BTRFS info (device vda): disk space caching is enabled
[ 4427.205475] BTRFS info (device vda): has skinny extents
[ 4427.538925] BTRFS: device fsid d4405e20-e03d-4d0a-a204-6b0ca9b3d543 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (6752)
[ 4427.564820] BTRFS info (device vdb): turning on sync discard
[ 4427.577312] BTRFS info (device vdb): disk space caching is enabled
[ 4427.579100] BTRFS info (device vdb): has skinny extents
[ 4427.580478] BTRFS info (device vdb): flagging fs with big metadata feature
[ 4427.586893] BTRFS info (device vdb): checking UUID tree
[ 4427.588466] ------------[ cut here ]------------
[ 4427.589606] WARNING: CPU: 2 PID: 6782 at fs/super.c:1676 __sb_start_write+0x113/0x2a0
[ 4427.591647] Modules linked in: dm_flakey dm_mod xxhash_generic btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
[ 4427.595085] CPU: 2 PID: 6782 Comm: btrfs-uuid Tainted: G        W         5.10.0-rc3-default+ #1353
[ 4427.597077] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 4427.599547] RIP: 0010:__sb_start_write+0x113/0x2a0
[ 4427.600594] Code: f3 f8 da 77 85 c0 0f 84 95 01 00 00 40 84 ed 0f 85 4c 01 00 00 45 84 e4 0f 85 75 01 00 00 5b 44 89 e8 5d 41 5c 41 5d 41 5e c3 <0f> 0b 48 89 e8 31 d2 be 31 00 00 00 48 c7 c7 7a 99 e4 88 48 c1 e0
[ 4427.606614] RSP: 0018:ffffb35a0137fc80 EFLAGS: 00010246
[ 4427.608115] RAX: 0000000000000001 RBX: ffffa19a4c9ec478 RCX: 0000000000000000
[ 4427.610056] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffa19a4c9ec478
[ 4427.611937] RBP: 0000000000000003 R08: 00000000000001b8 R09: ffffa19a5c1a3b88
[ 4427.613823] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
[ 4427.626591] R13: ffffa19a4c9ec398 R14: ffffa19a4c9ec698 R15: ffffa19a4191c000
[ 4427.628387] FS:  0000000000000000(0000) GS:ffffa19abda00000(0000) knlGS:0000000000000000
[ 4427.630470] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4427.631695] CR2: 000055d3f2f9108c CR3: 0000000002ffe003 CR4: 0000000000170ea0
[ 4427.633147] Call Trace:
[ 4427.633952]  start_transaction+0x406/0x510 [btrfs]
[ 4427.635308]  btrfs_uuid_scan_kthread+0x2d0/0x360 [btrfs]
[ 4427.636740]  ? btree_writepages+0x60/0x60 [btrfs]
[ 4427.638037]  kthread+0x151/0x170
[ 4427.650592]  ? __kthread_bind_mask+0x60/0x60
[ 4427.651775]  ret_from_fork+0x1f/0x30
[ 4427.652772] CPU: 2 PID: 6782 Comm: btrfs-uuid Tainted: G        W         5.10.0-rc3-default+ #1353
[ 4427.655090] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 4427.657860] Call Trace:
[ 4427.658485]  dump_stack+0x77/0x97
[ 4427.659266]  ? __sb_start_write+0x113/0x2a0
[ 4427.660188]  __warn.cold+0x24/0x83
[ 4427.661069]  ? __sb_start_write+0x113/0x2a0
[ 4427.662514]  report_bug+0x9a/0xc0
[ 4427.663574]  handle_bug+0x3c/0x60
[ 4427.664519]  exc_invalid_op+0x14/0x70
[ 4427.665547]  asm_exc_invalid_op+0x12/0x20
[ 4427.666632] RIP: 0010:__sb_start_write+0x113/0x2a0
[ 4427.667891] Code: f3 f8 da 77 85 c0 0f 84 95 01 00 00 40 84 ed 0f 85 4c 01 00 00 45 84 e4 0f 85 75 01 00 00 5b 44 89 e8 5d 41 5c 41 5d 41 5e c3 <0f> 0b 48 89 e8 31 d2 be 31 00 00 00 48 c7 c7 7a 99 e4 88 48 c1 e0
[ 4427.672250] RSP: 0018:ffffb35a0137fc80 EFLAGS: 00010246
[ 4427.673395] RAX: 0000000000000001 RBX: ffffa19a4c9ec478 RCX: 0000000000000000
[ 4427.675228] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffa19a4c9ec478
[ 4427.677054] RBP: 0000000000000003 R08: 00000000000001b8 R09: ffffa19a5c1a3b88
[ 4427.678861] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
[ 4427.680684] R13: ffffa19a4c9ec398 R14: ffffa19a4c9ec698 R15: ffffa19a4191c000
[ 4427.682565]  start_transaction+0x406/0x510 [btrfs]
[ 4427.683887]  btrfs_uuid_scan_kthread+0x2d0/0x360 [btrfs]
[ 4427.685357]  ? btree_writepages+0x60/0x60 [btrfs]
[ 4427.686643]  kthread+0x151/0x170
[ 4427.687595]  ? __kthread_bind_mask+0x60/0x60
[ 4427.688773]  ret_from_fork+0x1f/0x30
[ 4428.038587] irq event stamp: 0
[ 4428.039456] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 4428.040794] hardirqs last disabled at (0): [<ffffffff8807134b>] copy_process+0x3db/0x1440
[ 4428.042433] softirqs last  enabled at (0): [<ffffffff8807134b>] copy_process+0x3db/0x1440
[ 4428.150587] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 4428.152131] ---[ end trace 04c54d8226296c33 ]---
[ 4497.955015] BTRFS info (device vdb): turning on sync discard
[ 4497.957713] BTRFS info (device vdb): disk space caching is enabled
[ 4497.960776] BTRFS info (device vdb): has skinny extents
_check_dmesg: something found in dmesg (see /tmp/fstests/results//btrfs/080.dmesg)
 [15:24:41]
