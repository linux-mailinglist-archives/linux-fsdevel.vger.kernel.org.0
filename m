Return-Path: <linux-fsdevel+bounces-7746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB27E82A114
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 20:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C150B22628
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 19:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE424D5AA;
	Wed, 10 Jan 2024 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oAqcPF8/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3D22063
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 10 Jan 2024 14:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704915401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=R53hNXLAZbkL+7W5BR0a4U//WXjU54yRMDoU7GxyYhw=;
	b=oAqcPF8/Pw9B+oAdH9fQTwUezozFXLL2DlV4emh2k68j+0zpst2LSzRCUZTLNJsA+toP8O
	vWF3BfBfmeHDjmCUZxRBpmTbwxYgRoDpuihBrqmT9mPFJx+MHYtKejSHZxPilbmhKP29Ef
	OL2E1BvSxshcRfPG6oS+YVbowbRiqx0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs updates for 6.8
Message-ID: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, here's the main bcachefs updates for 6.8.

Cheers,
Kent


The following changes since commit 0d72ab35a925d66b044cb62b709e53141c3f0143:

  bcachefs: make RO snapshots actually RO (2024-01-01 11:47:07 -0500)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-01-10

for you to fetch changes up to 169de41985f53320580f3d347534966ea83343ca:

  bcachefs: eytzinger0_find() search should be const (2024-01-05 23:24:46 -0500)

----------------------------------------------------------------
bcachefs updates for 6.8:

 - btree write buffer rewrite: instead of adding keys to the btree write
   buffer at transaction commit time, we know journal them with a
   different journal entry type and copy them from the journal to the
   write buffer just prior to journal write.

   This reduces the number of atomic operations on shared cachelines
   in the transaction commit path and is a signicant performance
   improvement on some workloads: multithreaded 4k random writes went
   from ~650k iops to ~850k iops.

 - Bring back optimistic spinning for six locks: the new implementation
   doesn't use osq locks; instead we add to the lock waitlist as normal,
   and then spin on the lock_acquired bit in the waitlist entry, _not_
   the lock itself.

 - BCH_IOCTL_DEV_USAGE_V2, which allows for new data types
 - BCH_IOCTL_OFFLINE_FSCK, which runs the kernel implementation of fsck
   but without mounting: useful for transparently using the kernel
   version of fsck from 'bcachefs fsck' when the kernel version is a
   better match for the on disk filesystem.

 - BCH_IOCTL_ONLINE_FSCK: online fsck. Not all passes are supported yet,
   but the passes that are supported are fully featured - errors may be
   corrected as normal.

   The new ioctls use the new 'thread_with_file' abstraction for kicking
   off a kthread that's tied to a file descriptor returned to userspace
   via the ioctl.

 - btree_paths within a btree_trans are now dynamically growable,
   instead of being limited to 64. This is important for the
   check_directory_structure phase of fsck, and also fixes some issues
   we were having with btree path overflow in the reflink btree.

 - Trigger refactoring; prep work for the upcoming disk space accounting
   rewrite

 - Numerous bugfixes :)

----------------------------------------------------------------
Brian Foster (3):
      bcachefs: remove sb lock and flags update on explicit shutdown
      bcachefs: return from fsync on writeback error to avoid early shutdown
      bcachefs: clean up some dead fallocate code

Daniel Hill (6):
      bcachefs: add a quieter bch2_read_super
      bcachefs: remove dead bch2_evacuate_bucket()
      bcachefs: rebalance should wakeup on shutdown if disabled
      bcachefs: copygc should wakeup on shutdown if disabled
      bcachefs: copygc shouldn't try moving buckets on error
      bcachefs: remove redundant condition from data_update_index_update

Gustavo A. R. Silva (3):
      bcachefs: Replace zero-length arrays with flexible-array members
      bcachefs: Use array_size() in call to copy_from_user()
      bcachefs: Replace zero-length array with flex-array member and use __counted_by

Kent Overstreet (210):
      bcachefs: Flush fsck errors before running twice
      bcachefs: Add extra verbose logging for ro path
      bcachefs: Improved backpointer messages in fsck
      bcachefs: kill INODE_LOCK, use lock_two_nondirectories()
      bcachefs: Check for unlinked inodes not on deleted list
      bcachefs: Fix locking when checking freespace btree
      bcachefs: Print old version when scanning for old metadata
      bcachefs: Fix warning when building in userspace
      bcachefs: Include average write size in sysfs journal_debug
      bcachefs: Add an assertion in bch2_journal_pin_set()
      bcachefs: Journal pins must always have a flush_fn
      bcachefs: track_event_change()
      bcachefs: Clear k->needs_whitout earlier in commit path
      bcachefs: BTREE_INSERT_JOURNAL_REPLAY now "don't init trans->journal_res"
      bcachefs: Kill BTREE_UPDATE_PREJOURNAL
      bcachefs: Go rw before journal replay
      bcachefs: Make journal replay more efficient
      bcachefs: Avoiding dropping/retaking write locks in bch2_btree_write_buffer_flush_one()
      bcachefs: Fix redundant variable initialization
      bcachefs: Kill dead BTREE_INSERT flags
      bcachefs: bch_str_hash_flags_t
      bcachefs: Rename BTREE_INSERT flags
      bcachefs: Improve btree_path_dowgrade tracepoint
      bcachefs: backpointers fsck no longer uses BTREE_ITER_ALL_LEVELS
      bcachefs: Kill BTREE_ITER_ALL_LEVELS
      bcachefs: Fix userspace bch2_prt_datetime()
      bcachefs: Don't rejournal keys in key cache flush
      bcachefs: Don't flush journal after replay
      bcachefs: Add a tracepoint for journal entry close
      bcachefs: Kill memset() in bch2_btree_iter_init()
      bcachefs: Kill btree_iter->journal_pos
      bcachefs: Rename bch_replicas_entry -> bch_replicas_entry_v1
      bcachefs: Don't use update_cached_sectors() in bch2_mark_alloc()
      bcachefs: x-macro-ify bch_data_ops enum
      bcachefs: Convert bch2_move_btree() to bbpos
      bcachefs: BCH_DATA_OP_drop_extra_replicas
      powerpc: Export kvm_guest static key, for bcachefs six locks
      bcachefs: six locks: Simplify optimistic spinning
      bcachefs: Simplify check_bucket_ref()
      bcachefs: BCH_IOCTL_DEV_USAGE_V2
      bcachefs: New bucket sector count helpers
      bcachefs: bch2_dev_usage_to_text()
      bcachefs: Kill dev_usage->buckets_ec
      bcachefs: Improve sysfs compression_stats
      bcachefs: Print durability in member_to_text()
      bcachefs: Add a rebalance, data_update tracepoints
      bcachefs: Refactor bch2_check_alloc_to_lru_ref()
      bcachefs: Kill journal_seq/gc args to bch2_dev_usage_update_m()
      bcachefs: convert bch_fs_flags to x-macro
      bcachefs: No need to allocate keys for write buffer
      bcachefs: Improve btree write buffer tracepoints
      bcachefs: kill journal->preres_wait
      bcachefs: delete useless commit_do()
      bcachefs: Clean up btree write buffer write ref handling
      bcachefs: bch2_btree_write_buffer_flush_locked()
      bcachefs: bch2_btree_write_buffer_flush() -> bch2_btree_write_buffer_tryflush()
      bcachefs: count_event()
      bcachefs: Improve trace_trans_restart_too_many_iters()
      bcachefs: Improve trace_trans_restart_would_deadlock
      bcachefs: Don't open code bch2_dev_exists2()
      bcachefs: ONLY_SPECIFIED_DEVS doesn't mean ignore durability anymore
      bcachefs: wb_flush_one_slowpath()
      bcachefs: more write buffer refactoring
      bcachefs: Explicity go RW for fsck
      bcachefs: On missing backpointer to interior node, flush interior updates
      bcachefs: Make backpointer fsck wb flush check more rigorous
      bcachefs: Include btree_trans in more tracepoints
      bcachefs: Move reflink_p triggers into reflink.c
      bcachefs: Refactor trans->paths_allocated to be standard bitmap
      bcachefs: BCH_ERR_opt_parse_error
      bcachefs: Improve error message when finding wrong btree node
      bcachefs: c->ro_ref
      bcachefs: thread_with_file
      bcachefs: Add ability to redirect log output
      bcachefs: Mark recovery passses that are safe to run online
      bcachefs: bch2_run_online_recovery_passes()
      bcachefs: BCH_IOCTL_FSCK_OFFLINE
      bcachefs: BCH_IOCTL_FSCK_ONLINE
      bcachefs: Fix open coded set_btree_iter_dontneed()
      bcachefs: Fix bch2_read_btree()
      bcachefs: continue now works in for_each_btree_key2()
      bcachefs: Kill for_each_btree_key()
      bcachefs: Rename for_each_btree_key2() -> for_each_btree_key()
      bcachefs: reserve path idx 0 for sentinal
      bcachefs: Fix snapshot.c assertion for online fsck
      bcachefs: kill btree_path->(alloc_seq|downgrade_seq)
      bcachefs; kill bch2_btree_key_cache_flush()
      bcachefs: Improve trans->extra_journal_entries
      bcachefs: bch2_trans_node_add no longer uses trans_for_each_path()
      bcachefs: Unwritten journal buffers are always dirty
      bcachefs: journal->buf_lock
      bcachefs: btree write buffer now slurps keys from journal
      bcachefs: Inline btree write buffer sort
      bcachefs: check_root() can now be run online
      bcachefs: kill btree_trans->wb_updates
      bcachefs: Drop journal entry compaction
      bcachefs: fix userspace build errors
      bcachefs: bch_err_(fn|msg) check if should print
      bcachefs: qstr_eq()
      bcachefs: drop extra semicolon
      bcachefs: Make sure allocation failure errors are logged
      MAINTAINERS: Update my email address
      bcachefs: Delete dio read alignment check
      bcachefs: Fixes for rust bindgen
      bcachefs: check for failure to downgrade
      bcachefs: Use GFP_KERNEL for promote allocations
      bcachefs: Improve the nopromote tracepoint
      bcachefs: trans_for_each_update() now declares loop iter
      bcachefs: darray_for_each() now declares loop iter
      bcachefs: simplify bch_devs_list
      bcachefs: better error message in btree_node_write_work()
      bcachefs: add more verbose logging
      bcachefs: fix warning about uninitialized time_stats
      bcachefs: use track_event_change() for allocator blocked stats
      bcachefs: bch2_trans_srcu_lock() should be static
      bcachefs: bch2_dirent_lookup() -> lockrestart_do()
      bcachefs: for_each_btree_key_upto() -> for_each_btree_key_old_upto()
      bcachefs: kill for_each_btree_key_old_upto()
      bcachefs: kill for_each_btree_key_norestart()
      bcachefs: for_each_btree_key() now declares loop iter
      bcachefs: for_each_member_device() now declares loop iter
      bcachefs: for_each_member_device_rcu() now declares loop iter
      bcachefs: vstruct_for_each() now declares loop iter
      bcachefs: fsck -> bch2_trans_run()
      bcachefs: kill __bch2_btree_iter_peek_upto_and_restart()
      bcachefs: bkey_for_each_ptr() now declares loop iter
      bcachefs: for_each_keylist_key() declares loop iter
      bcachefs: skip journal more often in key cache reclaim
      bcachefs: Convert split_devs() to darray
      bcachefs: Kill GFP_NOFAIL usage in readahead path
      bcachefs: minor bch2_btree_path_set_pos() optimization
      bcachefs: bch2_path_get() -> btree_path_idx_t
      bcachefs; bch2_path_put() -> btree_path_idx_t
      bcachefs: bch2_btree_path_set_pos() -> btree_path_idx_t
      bcachefs: bch2_btree_path_make_mut() -> btree_path_idx_t
      bcachefs: bch2_btree_path_traverse() -> btree_path_idx_t
      bcachefs: btree_path_alloc() -> btree_path_idx_t
      bcachefs: btree_iter -> btree_path_idx_t
      bcachefs: btree_insert_entry -> btree_path_idx_t
      bcachefs: struct trans_for_each_path_inorder_iter
      bcachefs: bch2_btree_path_to_text() -> btree_path_idx_t
      bcachefs: kill trans_for_each_path_from()
      bcachefs: trans_for_each_path() no longer uses path->idx
      bcachefs: trans_for_each_path_with_node() no longer uses path->idx
      bcachefs: bch2_path_get() no longer uses path->idx
      bcachefs: bch2_btree_iter_peek_prev() no longer uses path->idx
      bcachefs: get_unlocked_mut_path() -> btree_path_idx_t
      bcachefs: kill btree_path.idx
      bcachefs: Clean up btree_trans
      bcachefs: rcu protect trans->paths
      bcachefs: optimize __bch2_trans_get(), kill DEBUG_TRANSACTIONS
      bcachefs: trans->updates will also be resizable
      bcachefs: trans->nr_paths
      bcachefs: Fix interior update path btree_path uses
      bcachefs: growable btree_paths
      bcachefs: bch2_btree_trans_peek_updates
      bcachefs: bch2_btree_trans_peek_prev_updates
      bcachefs: bch2_btree_trans_peek_slot_updates
      bcachefs: Fix reattach_inode() for snapshots
      bcachefs: check_directory_structure() can now be run online
      bcachefs: Check journal entries for invalid keys in trans commit path
      bcachefs: Fix nochanges/read_only interaction
      bcachefs: bch_member->seq
      bcachefs: Split brain detection
      bcachefs: btree_trans always has stats
      bcachefs: track transaction durations
      bcachefs: wb_key_cmp -> wb_key_ref_cmp
      bcachefs: __journal_keys_sort() refactoring
      bcachefs: __bch2_journal_key_to_wb -> bch2_journal_key_to_wb_slowpath
      bcachefs: Fix printing of device durability
      bcachefs: factor out thread_with_file, thread_with_stdio
      bcachefs: Upgrading uses bch_sb.recovery_passes_required
      bcachefs: trans_mark now takes bkey_s
      bcachefs: mark now takes bkey_s
      bcachefs: Kill BTREE_TRIGGER_NOATOMIC
      bcachefs: BTREE_TRIGGER_TRANSACTIONAL
      bcachefs: kill mem_trigger_run_overwrite_then_insert()
      bcachefs: unify inode trigger
      bcachefs: unify reflink_p trigger
      bcachefs: unify reservation trigger
      bcachefs: move bch2_mark_alloc() to alloc_background.c
      bcachefs: unify alloc trigger
      bcachefs: move stripe triggers to ec.c
      bcachefs: unify stripe trigger
      bcachefs: bch2_trigger_pointer()
      bcachefs: Online fsck can now fix errors
      bcachefs: bch2_trigger_stripe_ptr()
      bcachefs: unify extent trigger
      bcachefs: Combine .trans_trigger, .atomic_trigger
      bcachefs: kill useless return ret
      bcachefs: Add an option to control btree node prefetching
      bcachefs: don't clear accessed bit in btree node fill
      bcachefs: add time_stats for btree_node_read_done()
      bcachefs: increase max_active on io_complete_wq
      bcachefs: add missing bch2_latency_acct() call
      bcachefs: Don't autofix errors we can't fix
      bcachefs: no thread_with_file in userspace
      bcachefs: Upgrades now specify errors to fix, like downgrades
      bcachefs: fsck_err()s don't need to manually check c->sb.version anymore
      bcachefs: Improve would_deadlock trace event
      bcachefs: %pg is banished
      bcachefs: __bch2_sb_field_to_text()
      bcachefs: print sb magic when relevant
      bcachefs: improve validate_bset_keys()
      bcachefs: improve checksum error messages
      bcachefs: bch2_dump_bset() doesn't choke on u64s == 0
      bcachefs: Restart recovery passes more reliably
      bcachefs: fix simulateously upgrading & downgrading
      bcachefs: move "ptrs not changing" optimization to bch2_trigger_extent()
      bcachefs: eytzinger0_find() search should be const

Randy Dunlap (2):
      bcachefs: six lock: fix typos
      bcachefs: mean and variance: fix kernel-doc for function params

Richard Davies (1):
      bcachefs: Remove obsolete comment about zstd

Yang Li (1):
      bcachefs: clean up one inconsistent indenting

 MAINTAINERS                            |    2 +-
 arch/powerpc/kernel/firmware.c         |    2 +
 fs/bcachefs/Kconfig                    |   18 +-
 fs/bcachefs/Makefile                   |    1 +
 fs/bcachefs/alloc_background.c         |  484 +++++-----
 fs/bcachefs/alloc_background.h         |   39 +-
 fs/bcachefs/alloc_foreground.c         |   46 +-
 fs/bcachefs/backpointers.c             |  199 +++--
 fs/bcachefs/backpointers.h             |   27 +-
 fs/bcachefs/bcachefs.h                 |  192 +++-
 fs/bcachefs/bcachefs_format.h          |  123 ++-
 fs/bcachefs/bcachefs_ioctl.h           |   60 +-
 fs/bcachefs/bkey_methods.h             |   82 +-
 fs/bcachefs/bset.c                     |    6 +
 fs/bcachefs/btree_cache.c              |   28 +-
 fs/bcachefs/btree_cache.h              |    4 +-
 fs/bcachefs/btree_gc.c                 |  327 +++----
 fs/bcachefs/btree_io.c                 |  132 ++-
 fs/bcachefs/btree_io.h                 |    2 +-
 fs/bcachefs/btree_iter.c               |  945 ++++++++++----------
 fs/bcachefs/btree_iter.h               |  407 ++++-----
 fs/bcachefs/btree_journal_iter.c       |   25 +-
 fs/bcachefs/btree_key_cache.c          |   63 +-
 fs/bcachefs/btree_key_cache.h          |    2 -
 fs/bcachefs/btree_locking.c            |  111 ++-
 fs/bcachefs/btree_locking.h            |   16 +-
 fs/bcachefs/btree_trans_commit.c       |  313 +++----
 fs/bcachefs/btree_types.h              |  136 +--
 fs/bcachefs/btree_update.c             |  245 ++----
 fs/bcachefs/btree_update.h             |  111 ++-
 fs/bcachefs/btree_update_interior.c    |  322 +++----
 fs/bcachefs/btree_update_interior.h    |   11 +-
 fs/bcachefs/btree_write_buffer.c       |  668 +++++++++-----
 fs/bcachefs/btree_write_buffer.h       |   53 +-
 fs/bcachefs/btree_write_buffer_types.h |   63 +-
 fs/bcachefs/buckets.c                  | 1511 ++++++++------------------------
 fs/bcachefs/buckets.h                  |   45 +-
 fs/bcachefs/buckets_types.h            |    2 -
 fs/bcachefs/chardev.c                  |  363 ++++++--
 fs/bcachefs/checksum.h                 |   23 +
 fs/bcachefs/compress.c                 |    4 -
 fs/bcachefs/darray.h                   |    8 +-
 fs/bcachefs/data_update.c              |   30 +-
 fs/bcachefs/debug.c                    |  141 ++-
 fs/bcachefs/dirent.c                   |   51 +-
 fs/bcachefs/dirent.h                   |    7 +-
 fs/bcachefs/disk_groups.c              |   13 +-
 fs/bcachefs/ec.c                       |  406 +++++++--
 fs/bcachefs/ec.h                       |    5 +-
 fs/bcachefs/ec_types.h                 |    2 +-
 fs/bcachefs/errcode.h                  |    7 +-
 fs/bcachefs/error.c                    |  103 ++-
 fs/bcachefs/extent_update.c            |    2 +-
 fs/bcachefs/extents.c                  |    4 -
 fs/bcachefs/extents.h                  |   24 +-
 fs/bcachefs/eytzinger.h                |   10 +-
 fs/bcachefs/fs-common.c                |   36 +-
 fs/bcachefs/fs-io-buffered.c           |   38 +-
 fs/bcachefs/fs-io-direct.c             |    3 -
 fs/bcachefs/fs-io.c                    |   20 +-
 fs/bcachefs/fs-ioctl.c                 |   12 +-
 fs/bcachefs/fs.c                       |  100 +--
 fs/bcachefs/fs.h                       |    9 +-
 fs/bcachefs/fsck.c                     |  630 ++++++-------
 fs/bcachefs/inode.c                    |  129 ++-
 fs/bcachefs/inode.h                    |   15 +-
 fs/bcachefs/io_misc.c                  |   55 +-
 fs/bcachefs/io_read.c                  |   50 +-
 fs/bcachefs/io_write.c                 |   45 +-
 fs/bcachefs/journal.c                  |  108 ++-
 fs/bcachefs/journal.h                  |    4 +-
 fs/bcachefs/journal_io.c               |  153 ++--
 fs/bcachefs/journal_reclaim.c          |  120 ++-
 fs/bcachefs/journal_reclaim.h          |   16 +-
 fs/bcachefs/journal_seq_blacklist.c    |    2 +-
 fs/bcachefs/journal_types.h            |   16 +-
 fs/bcachefs/keylist.c                  |    2 -
 fs/bcachefs/keylist.h                  |    4 +-
 fs/bcachefs/logged_ops.c               |   18 +-
 fs/bcachefs/lru.c                      |   11 +-
 fs/bcachefs/mean_and_variance.c        |   10 +-
 fs/bcachefs/mean_and_variance.h        |    5 +-
 fs/bcachefs/migrate.c                  |    9 +-
 fs/bcachefs/move.c                     |  187 ++--
 fs/bcachefs/move.h                     |   13 +-
 fs/bcachefs/movinggc.c                 |   49 +-
 fs/bcachefs/opts.c                     |    4 +-
 fs/bcachefs/opts.h                     |   20 +-
 fs/bcachefs/quota.c                    |   28 +-
 fs/bcachefs/rebalance.c                |   38 +-
 fs/bcachefs/recovery.c                 |  291 +++---
 fs/bcachefs/recovery.h                 |    1 +
 fs/bcachefs/recovery_types.h           |   25 +-
 fs/bcachefs/reflink.c                  |  224 ++++-
 fs/bcachefs/reflink.h                  |   22 +-
 fs/bcachefs/replicas.c                 |   66 +-
 fs/bcachefs/replicas.h                 |   22 +-
 fs/bcachefs/replicas_types.h           |    6 +-
 fs/bcachefs/sb-clean.c                 |   20 +-
 fs/bcachefs/sb-downgrade.c             |   90 +-
 fs/bcachefs/sb-downgrade.h             |    1 +
 fs/bcachefs/sb-errors_types.h          |    4 +-
 fs/bcachefs/sb-members.c               |   18 +-
 fs/bcachefs/sb-members.h               |  100 ++-
 fs/bcachefs/six.c                      |  117 +--
 fs/bcachefs/six.h                      |   13 +-
 fs/bcachefs/snapshot.c                 |  174 ++--
 fs/bcachefs/snapshot.h                 |    8 +-
 fs/bcachefs/str_hash.h                 |   25 +-
 fs/bcachefs/subvolume.c                |   31 +-
 fs/bcachefs/subvolume_types.h          |    4 +
 fs/bcachefs/super-io.c                 |  168 ++--
 fs/bcachefs/super-io.h                 |    7 +-
 fs/bcachefs/super.c                    |  388 ++++----
 fs/bcachefs/super.h                    |    6 +-
 fs/bcachefs/super_types.h              |    2 +-
 fs/bcachefs/sysfs.c                    |  160 ++--
 fs/bcachefs/tests.c                    |  193 ++--
 fs/bcachefs/thread_with_file.c         |  299 +++++++
 fs/bcachefs/thread_with_file.h         |   41 +
 fs/bcachefs/thread_with_file_types.h   |   16 +
 fs/bcachefs/trace.h                    |  278 ++++--
 fs/bcachefs/util.c                     |  191 ++--
 fs/bcachefs/util.h                     |   56 +-
 fs/bcachefs/vstructs.h                 |   10 +-
 125 files changed, 7101 insertions(+), 5961 deletions(-)
 create mode 100644 fs/bcachefs/thread_with_file.c
 create mode 100644 fs/bcachefs/thread_with_file.h
 create mode 100644 fs/bcachefs/thread_with_file_types.h

