Return-Path: <linux-fsdevel+bounces-1542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E807DBC29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 15:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E6E281493
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740DC18042;
	Mon, 30 Oct 2023 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WOiG5G82"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FAD179AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 14:55:52 +0000 (UTC)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bd])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB66C9
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 07:55:46 -0700 (PDT)
Date: Mon, 30 Oct 2023 10:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698677744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cl2Gs5KMW5Ds4Iqh7NUGym9N1pBpnMAl7AGMu8xy6Qo=;
	b=WOiG5G825CGMJG8J6S+e6sEbbV1KpGxvn+ZQ4koN/KbjN+lz54FNOPPt4o6gRwiq7HJ4dM
	2McEo8Hk/5uaTw3yTg2eZ18iUuDXXrC/nK/9yvxc0GY+BasjoVg+zHi3hga1039XzOIlVN
	0zV2nnmU23QKEiehref/YTkQPzeYN/0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs for v6.7
Message-ID: <20231030145540.pjkggoiddobyjicq@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-10-30

for you to fetch changes up to b827ac419721a106ae2fccaa40576b0594edad92:

  exportfs: Change bcachefs fid_type enum to avoid conflicts (2023-10-26 16:41:00 -0400)

----------------------------------------------------------------
Initial bcachefs pull request for 6.7-rc1

Here's the bcachefs filesystem pull request.

One new patch since last week: the exportfs constants ended up
conflicting with other filesystems that are also getting added to the
global enum, so switched to new constants picked by Amir.

I'll also be sending another pull request later on in the cycle bringing
things up to date my master branch that people are currently running;
that will be restricted to fs/bcachefs/, naturally.

Testing - fstests as well as the bcachefs specific tests in ktest:
  https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-for-upstream

It's also been soaking in linux-next, which resulted in a whole bunch of
smatch complaints and fixes and a patch or two from Kees.

The only new non fs/bcachefs/ patch is the objtool patch that adds
bcachefs functions to the list of noreturns. The patch that exports
osq_lock() has been dropped for now, per Ingo.

Prereq patch list:

faf1dce85275 objtool: Add bcachefs noreturns
73badee4280c lib/generic-radix-tree.c: Add peek_prev()
9492261ff246 lib/generic-radix-tree.c: Don't overflow in peek()
0fb5d567f573 MAINTAINERS: Add entry for generic-radix-tree
b414e8ecd498 closures: Add a missing include
48b7935722b8 closures: closure_nr_remaining()
ced58fc7ab9f closures: closure_wait_event()
bd0d22e41ecb MAINTAINERS: Add entry for closures
8c8d2d9670e8 bcache: move closures to lib/
957e48087dfa locking: export contention tracepoints for bcachefs six locks
21db931445d8 lib: Export errname
83feeb195592 lib/string_helpers: string_get_size() now returns characters wrote
7d672f40941a stacktrace: Export stack_trace_save_tsk
771eb4fe8b42 fs: factor out d_mark_tmpfile()
2b69987be575 sched: Add task_struct->faults_disabled_mapping

----------------------------------------------------------------
Brett Holman (9):
      bcachefs: made changes to support clang, fixed a couple bugs
      bcachefs: rewrote prefetch asm in gas syntax for clang compatibility
      bcachefs: Fix unitialized use of a value
      bcachefs: Fix 32 bit build failures
      bcachefs: add progress stats to sysfs
      bcachefs: Add a valgrind memcheck hint
      bcachefs: Fix compiler warnings
      bcachefs: Make bch_option compatible with Rust ffi
      bcachefs: Fix memleak in replicas_table_update()

Brian Foster (37):
      locking: export contention tracepoints for bcachefs six locks
      bcachefs: don't bump key cache journal seq on nojournal commits
      bcachefs: remove unused bch2_trans_log_msg()
      bcachefs: use dedicated workqueue for tasks holding write refs
      bcachefs: more aggressive fast path write buffer key flushing
      bcachefs: gracefully unwind journal res slowpath on shutdown
      bcachefs: refactor journal stuck checking into standalone helper
      bcachefs: drop unnecessary journal stuck check from space calculation
      bcachefs: use reservation for log messages during recovery
      bcachefs: fix truncate overflow if folio is beyond EOF
      bcachefs: clean up post-eof folios on -ENOSPC
      bcachefs: use u64 for folio end pos to avoid overflows
      bcachefs: folio pos to bch_folio_sector index helper
      bcachefs: fix NULL bch_dev deref when checking bucket_gens keys
      bcachefs: remove bucket_gens btree keys on device removal
      bcachefs: fix accounting corruption race between reclaim and dev add
      bcachefs: remove unused key cache coherency flag
      bcachefs: mark journal replicas before journal write submission
      bcachefs: create internal disk_groups sysfs file
      bcachefs: push rcu lock down into bch2_target_to_mask()
      bcachefs: don't spin in rebalance when background target is not usable
      bcachefs: mark active journal devices on journal replicas gc
      bcachefs: flush journal to avoid invalid dev usage entries on recovery
      MAINTAINERS: add Brian Foster as a reviewer for bcachefs
      bcachefs: remove duplicate code between backpointer update paths
      bcachefs: remove unnecessary btree_insert_key_leaf() wrapper
      bcachefs: fold bch2_trans_update_by_path_trace() into callers
      bcachefs: support btree updates of prejournaled keys
      bcachefs: use prejournaled key updates for write buffer flushes
      bcachefs: fix up wonky error handling in bch2_seek_pagecache_hole()
      bcachefs: restart journal reclaim thread on ro->rw transitions
      bcachefs: add module description to fix modpost warning
      bcachefs: refactor pin put helpers
      bcachefs: prepare journal buf put to handle pin put
      bcachefs: fix race between journal entry close and pin set
      bcachefs: initial freeze/unfreeze support
      bcachefs: fix crc32c checksum merge byte order problem

Chris Webb (1):
      bcachefs: Return -ENOKEY/EINVAL when mount decryption fails

Christophe JAILLET (3):
      bcachefs: Fix use-after-free in bch2_dev_add()
      bcachefs: Remove a redundant and harmless bch2_free_super() call
      bcachefs: Use struct_size()

Christopher James Halse Rogers (2):
      stacktrace: Export stack_trace_save_tsk
      bcachefs: Fix unused variable warning when !BCACHEFS_DEBUG

Colin Ian King (6):
      bcachefs: remove redundant initialization of pointer d
      bcachefs: remove redundant initialization of pointer dst
      bcachefs: remove redundant initializations of variables start_offset and end_offset
      bcachefs: remove duplicated assignment to variable offset_into_extent
      bcachefs: remove redundant pointer q
      bcachefs: Fix a handful of spelling mistakes in various messages

Dan Carpenter (7):
      bcachefs: chardev: return -EFAULT if copy_to_user() fails
      bcachefs: chardev: fix an integer overflow (32 bit only)
      bcachefs: fix error checking in bch2_fs_alloc()
      bcachefs: acl: Uninitialized variable in bch2_acl_chmod()
      bcachefs: acl: Add missing check in bch2_acl_chmod()
      bcachefs: fs-ioctl: Fix copy_to_user() error code
      bcachefs: snapshot: Add missing assignment in bch2_delete_dead_snapshots()

Dan Robertson (17):
      bcachefs: Fix oob write in __bch2_btree_node_write
      bcachefs: Fix error in parsing of mount options
      bcachefs: Fix possible null deref on mount
      bcachefs: Fix null deref in bch2_ioctl_read_super
      bcachefs: Fix out of bounds read in fs usage ioctl
      bcachefs: properly initialize used values
      bcachefs: statfs resports incorrect avail blocks
      bcachefs: do not compile acl mod on minimal config
      bcachefs: mount: fix null deref with null devname
      bcachefs: ensure iter->should_be_locked is set
      bcachefs: ensure iter->should_be_locked is set
      bcachefs: fix ifdef for x86_64 asm
      bcachefs: fix truncate without a size change
      bcachefs: statfs bfree and bavail should be the same
      bcachefs: Fix bch2_acl_chmod() cleanup on error
      bcachefs: set disk state should check new_state
      bcachefs: docs: add docs for bch2_trans_reset

Daniel B. Hill (1):
      bcachefs: fix security warning in pr_name_and_units

Daniel Hill (20):
      bcachefs: respect superblock discard flag.
      bcachefs: Add persistent counters
      bcachefs: Rename group to label for remaining strings.
      bcachefs: fix __dev_available().
      bcachefs: data jobs, including rebalance wait for copygc.
      bcachefs: lock time stats prep work.
      bcachefs: bch2_time_stats_to_text now indents properly
      bcachefs: added lock held time stats
      bcachefs: Mean and variance
      bcachefs: time stats now uses the mean_and_variance module.
      bcachefs: improve behaviour of btree_cache_scan()
      bcachefs: make durability a read-write sysfs option
      bcachefs: __bio_compress() fix up.
      bcachefs: fix bch2_write_extent() crc corruption.
      bcachefs: expose nocow_lock table in sysfs
      bcachefs: handle failed data_update_init cleanup
      bcachefs: don't block reads if we're promoting
      bcachefs: let __bch2_btree_insert() pass in flags
      bcachefs: Don't run triggers when repairing in __bch2_mark_reflink_p()
      bcachefs: Reimplement repair for overlapping extents

Hunter Shaffer (4):
      bcachefs: Add new helper to retrieve bch_member from sb
      bcachefs: New superblock section members_v2
      bcachefs: Rename bch_sb_field_members -> bch_sb_field_members_v1
      bcachefs: Add iops fields to bch_member

Janpieter Sollie (1):
      bcachefs: fix a possible bcachefs checksum mapping error opt-checksum enum to type-checksum enum

Jiapeng Chong (1):
      bcachefs: Remove duplicate include

Josh Poimboeuf (1):
      bcachefs: Remove undefined behavior in bch2_dev_buckets_reserved()

Joshua Ashton (4):
      bcachefs: Add btree_trans* to inode_set_fn
      bcachefs: Introduce bch2_dirent_get_name
      bcachefs: Optimize bch2_dirent_name_bytes
      bcachefs: Lower BCH_NAME_MAX to 512

Justin Husted (8):
      bcachefs: Fix uninitialized data in bch2_gc_btree()
      bcachefs: Initialize journal pad data in bch_replica_entry objects.
      bcachefs: Initialize padding space after alloc bkey
      bcachefs: Further padding fixes in bch2_journal_super_entries_add_common()
      bcachefs: Initialize btree_node flags field in bch2_btree_root_alloc.
      bcachefs: Fix uninitialized field in hash_check_init()
      bcachefs: Set lost+found mode to 0700
      bcachefs: Update directory timestamps during link

Kees Cook (1):
      bcachefs: Refactor memcpy into direct assignment

Kent Overstreet (2635):
      sched: Add task_struct->faults_disabled_mapping
      fs: factor out d_mark_tmpfile()
      lib/string_helpers: string_get_size() now returns characters wrote
      lib: Export errname
      bcache: move closures to lib/
      MAINTAINERS: Add entry for closures
      closures: closure_wait_event()
      closures: closure_nr_remaining()
      closures: Add a missing include
      MAINTAINERS: Add entry for generic-radix-tree
      lib/generic-radix-tree.c: Don't overflow in peek()
      lib/generic-radix-tree.c: Add peek_prev()
      objtool: Add bcachefs noreturns
      MAINTAINERS: Add entry for bcachefs
      bcachefs: Initial commit
      bcachefs: Only check inode i_nlink during full fsck
      bcachefs: Convert raw uses of bch2_btree_iter_link() to new transactions
      bcachefs: trace transaction restarts
      bcachefs: Fix device add
      bcachefs: Fix a use after free in the journal code
      bcachefs: add bch_verbose() statements for shutdown
      bcachefs: Simplify bch2_write_inode_trans, fix lockdep splat
      bcachefs: Fix mtime/ctime updates
      bcachefs: bch2_trans_update() now takes struct btree_insert_entry
      bcachefs: Use ei_update_lock consistently
      bcachefs: fix rename + fsync
      bcachefs: Fix an assertion
      bcachefs: don't call bch2_bucket_seq_cleanup from journal_buf_switch
      bcachefs: kill bucket mark sector count saturation
      bcachefs: Invalidate buckets when writing to alloc btree
      bcachefs: fix nbuckets usage on device resize
      bcachefs: fix fsync after create
      bcachefs: fix mtime/ctime update on truncate
      bcachefs: fix last_seq_ondisk
      bcachefs: Assorted journal refactoring
      bcachefs: minor fsync fix
      bcachefs: fix bch2_val_to_text()
      bcachefs: Fix locking in allocator thread
      bcachefs: Fix an assertion in the btree node merge path
      bcachefs: bch2_mark_key() now takes bch_data_type
      bcachefs: kill s_alloc, use bch_data_type
      bcachefs: Account for internal fragmentation better
      bcachefs: Change how replicated data is accounted
      bcachefs: Better calculation of copygc threshold
      bcachefs: BCH_SB_RESERVE_BYTES
      bcachefs: Factor out btree_key_can_insert()
      bcachefs: improved rw_aux_tree_bsearch()
      bcachefs: bkey_written()
      bcachefs: extent unit tests
      bcachefs: lift ordering restriction on 0 size extents
      bcachefs: make struct btree_iter a bit smaller
      bcachefs: extent_squash() can no longer fail
      bcachefs: BTREE_INSERT_JOURNAL_RES_FULL is no longer possible
      bcachefs: mempoolify btree_trans
      bcachefs: bch2_extent_trim_atomic()
      bcachefs: convert bchfs_write_index_update() to bch2_extent_update()
      bcachefs: convert truncate to bch2_extent_update()
      bcachefs: convert fpunch to bch2_extent_update()
      bcachefs: convert fcollapse to bch2_extent_update()
      bcachefs: kill i_sectors_hook
      bcachefs: kill extent_insert_hook
      bcachefs: Pass around bset_tree less
      bcachefs: Prioritize fragmentation in bucket allocator
      bcachefs: Comparison function cleanups
      bcachefs: Fix a btree iter bug when iter pos == POS_MAX
      bcachefs: Dirent repair code
      bcachefs: make fsck spew less
      bcachefs: fix a divide
      bcachefs: Fix a deadlock
      bcachefs: fix bch2_acl_chmod()
      bcachefs: Fix suspend when moving data faster than ratelimit
      bcachefs: Fix failure to suspend
      bcachefs: Split out alloc_background.c
      bcachefs: Allocation code refactoring
      bcachefs: fix a spurious gcc warning
      bcachefs: fix missing include
      bcachefs: extent_ptr_decoded
      bcachefs: kill bch_extent_crc_type
      bcachefs: extent_for_each_ptr_decode()
      bcachefs: bch2_extent_drop_ptrs()
      bcachefs: bch2_extent_ptr_decoded_append()
      bcachefs: BCH_EXTENT_ENTRY_TYPES()
      bcachefs: btree gc refactoring
      bcachefs: add functionality for heaps to update backpointers
      bcachefs: kill struct bch_replicas_cpu_entry
      bcachefs: replicas: prep work for stripes
      bcachefs: more key marking refactoring
      bcachefs: new avoid mechanism for io retries
      bcachefs: fix bch2_bkey_print_bfloat
      bcachefs: Some fixes for building in userspace
      bcachefs: fix bounds checks in bch2_bio_map()
      bcachefs: Fix journal replay when replicas sb section missing
      bcachefs: Rename nofsck opt to fsck
      bcachefs: Fix an assertion when rebuilding replicas
      bcachefs: Scale down number of writepoints when low on space
      bcachefs: Assorted fixes for running on very small devices
      bcachefs: Disk usage in compressed sectors, not uncompressed
      bcachefs: fix a replicas bug
      bcachefs: delete some dead code
      bcachefs: revamp to_text methods
      bcachefs: Check for unsupported features
      bcachefs: stripe support for replicas tracking
      bcachefs: Move key marking out of extents.c
      bcachefs: Centralize marking of replicas in btree update path
      bcachefs: More btree gc refactorings
      bcachefs: Erasure coding
      bcachefs: fix typo when picking read method
      bcachefs: Fix an error path
      bcachefs: Clean up, possixly fix page disk reservation accounting
      bcachefs: start erasure coding after journal replay
      bcachefs: Don't block on journal reservation with btree locks held
      bcachefs: Journal refactoring
      bcachefs: Allocator startup improvements
      bcachefs: fix btree iterator bug when using depth > 0
      bcachefs: fix mempool double initialization
      bcachefs: gc now operates on second set of bucket marks
      bcachefs: Allow for new alloc fields
      Revert "bcachefs: start erasure coding after journal replay"
      bcachefs: shim for userspace raid library
      bcachefs: Btree locking fix, refactoring
      bcachefs: Stripes now properly subject to gc
      bcachefs: Hold usage_lock over mark_key and fs_usage_apply
      bcachefs: return errors correctly from gc
      bcachefs: fix waiting on an open journal entry
      bcachefs: Split out bkey_sort.c
      bcachefs: Fix a btree iter usage error
      bcachefs: Make bkey types globally unique
      bcachefs: Track nr_inodes with the key marking machinery
      bcachefs: drop bogus percpu_ref_tryget
      bcachefs: Deferred btree updates
      bcachefs: Add new alloc fields
      bcachefs: move dirty into bucket_mark
      bcachefs: New blockcount field for bch_stripe
      bcachefs: s/usage_lock/mark_lock
      bcachefs: propagate BCH_WRITE_CACHED
      bcachefs: Compression fixes
      bcachefs: Fix for running in degraded mode
      bcachefs: improve/clarify ptr_disk_sectors()
      bcachefs: improve extent debugcheck fn
      bcachefs: fix an incorrect bkey_debugcheck() call
      bcachefs: Switch replicas to mark_lock
      bcachefs: refactor bch_fs_usage
      bcachefs: Include summarized counts in fs_usage
      bcachefs: Fix for building in userspace
      bcachefs: use x-macros more consistently
      bcachefs: merge BCH_INODE_FIELDS_INHERIT/BCH_INODE_OPTS
      bcachefs: bch2_fs_quota_transfer
      bcachefs: Add flags to indicate if inode opts were inherited or explicitly set
      bcachefs: add bcachefs_effective xattrs
      bcachefs: rename keeps inheritable inode opts consistent
      bcachefs: bch2_ioc_reinherit_attrs()
      bcachefs: Fix duplicate ioctl nr
      bcachefs: fix device remove error path
      bcachefs: fix ja->cur_idx use while reading journal
      bcachefs: fix an rcu usage bug
      bcachefs: more project quota fixes
      bcachefs: Lots of option handling improvements
      bcachefs: fix new reinherit_attrs ioctl
      bcachefs: Minor replicas.c refactoring
      bcachefs: Factor out acc_u64s()
      bcachefs: use crc64 from lib/
      bcachefs: correctly initialize bch_extent_ptr
      bcachefs: More allocator startup improvements
      bcachefs: Fix a dio bug
      bcachefs: fixes for getting stuck flushing journal pins
      bcachefs: Fix an allocator error path
      bcachefs: Add a workqueue for journal reclaim
      bcachefs: Fix some reserve calculations
      bcachefs: dio arithmetic improvements
      bcachefs: fix error message in device remove path
      bcachefs: Fix check for if extent update is allocating
      bcachefs: Fix fifo overflow in allocator startup
      bcachefs: Persist alloc info on clean shutdown
      bcachefs: Improve c version of __bkey_cmp_bits
      bcachefs: Persist stripe blocks_used
      bcachefs: fix inode counting
      bcachefs: improve alloc_debug
      bcachefs: New journal_entry_res mechanism
      bcachefs: sysfs trigger for bch2_alloc_write
      bcachefs: percpu utility code
      bcachefs: Fix a bug when shutting down before allocator started
      bcachefs: fix for unmount hang
      bcachefs: delete a debug printk
      bcachefs: fix bch2_sb_field_resize()
      bcachefs: reserve space in journal for fs usage entries
      bcachefs: Write out fs usage
      bcachefs: journal_replay_early()
      bcachefs: initialize fs usage summary in recovery
      bcachefs: serialize persistent_reserved
      bcachefs: don't do initial gc if have alloc info feature
      bcachefs: Don't need to walk inodes on clean shutdown
      bcachefs: no need to run gc when initializing new fs
      bcachefs: Fix a lockdep splat
      bcachefs: Fix a locking bug
      bcachefs: Fix oldest_gen handling
      bcachefs: gc lock no longer needed for disk reservations
      bcachefs: Fix double counting when gc is running
      bcachefs: refactor key marking code a bit
      bcachefs: fix more locking bugs
      bcachefs: fixes for cached data accounting
      bcachefs: Convert bucket invalidation to key marking path
      bcachefs: Add a mechanism for blocking the journal
      bcachefs: fs_usage_u64s()
      bcachefs: Assorted journal refactoring
      bcachefs: force str_hash code to be inlined
      bcachefs: fix a deadlock on startup
      bcachefs: Fix gc handling of bucket gens
      bcachefs: fix integer underflow in journal code
      bcachefs: Don't get journal reservation until after we know insert will succeed
      bcachefs: Better journal debug
      bcachefs: Journal reclaim refactoring
      bcachefs: use correct wq for journal reclaim
      bcachefs: improved flush_held_btree_writes()
      bcachefs: Drop a faulty assertion
      bcachefs: Allocator startup fixes/refactoring
      bcachefs: ja->discard_idx, ja->dirty_idx
      bcachefs: Separate discards from rest of journal reclaim
      bcachefs: bch2_journal_space_available improvements
      bcachefs: Don't block on reclaim_lock from journal_res_get
      bcachefs: Add a pre-reserve mechanism for the journal
      bcachefs: Use journal preres for deferred btree updates
      bcachefs: Use deferred btree updates for inode updates
      bcachefs: Remove direct use of bch2_btree_iter_link()
      bcachefs: Don't BUG_ON() on bucket sector count overflow
      bcachefs: minor journal reclaim fixes
      bcachefs: assertion to catch outstanding bug
      bcachefs: fix a faulty assertion
      bcachefs: increase BTREE_ITER_MAX
      bcachefs: Fix for when compressed extent is split during journal replay
      bcachefs: Fix for shutting down before fs started marking it clean
      bcachefs: Make deferred inode updates a mount option
      bcachefs: fix bch2_invalidate_one_bucket2() during journal replay
      bcachefs: fix bch2_mark_bkey_replicas() call
      bcachefs: Always use bch2_extent_trim_atomic()
      bcachefs: Refactor extent insert path
      bcachefs: drop btree_insert->did_work
      bcachefs: convert bch2_btree_insert_at() usage to bch2_trans_commit()
      bcachefs: kill struct btree_insert
      bcachefs: Btree update path cleanup
      bcachefs: Allocate fs_usage in do_btree_insert_at()
      bcachefs: Fix a deadlock
      bcachefs: Add more time stats for being blocked on allocator
      bcachefs: BTREE_INSERT_ATOMIC must be used for extents now
      bcachefs: Add time stats for btree updates
      bcachefs: Fix error handling in bch2_fs_recovery()
      bcachefs: Run gc if failed to read alloc btree
      bcachefs: More debug params for testing of recovery paths
      bcachefs: Fix error handling in gc
      bcachefs: Rework error handling in btree update path
      bcachefs: Fix a deadlock
      bcachefs: Go rw lazily
      bcachefs: Verify fs hasn't been modified before going rw
      bcachefs: Btree iter improvements
      bcachefs: Only get btree iters from btree transactions
      bcachefs: Btree iterators now always have a btree_trans
      bcachefs: Better bch2_trans_copy_iter()
      bcachefs: trans_for_each_iter()
      bcachefs: Change btree_iter_traverse_error() to not use iter->next
      bcachefs: Kill btree_iter->next
      bcachefs: Add iter->idx
      bcachefs: traverse all iterators on transaction restart
      bcachefs: Unlink not-touched iters on successful transaction commit
      bcachefs: Sort updates in bch2_trans_update()
      bcachefs: move some checks to expensive_debug_checks
      bcachefs: simplify gc locking a bit
      bcachefs: Handle fsck errors at runtime better
      bcachefs: fix initial gc
      bcachefs: Write out alloc info more carefully
      bcachefs: Assorted preemption fixes
      bcachefs: (invalidate|release)_folio fixes
      bcachefs: Track whether filesystem has errors in superblock
      bcachefs: make sure to use BTREE_INSERT_LAZY_RW in fsck
      bcachefs: allow journal reply on ro mount
      bcachefs: add missing bch2_btree_iter_node_drop() call
      bcachefs: fix bch2_trans_unlock()
      bcachefs: Refactor bch2_fs_recovery()
      bcachefs: Caller now responsible for calling mark_key for gc
      bcachefs: Fsck locking improvements
      bcachefs: minor fsck fix
      bcachefs: ratelimit copygc warning
      bcachefs: Convert gc errors to fsck errors
      bcachefs: add ability to run gc on metadata only
      bcachefs: free trans->mem on commit
      bcachefs: don't lose errors from iterators that have been freed
      bcachefs: Rewrite journal_seq_blacklist machinery
      bcachefs: initial gc no longer needs to touch every node
      bcachefs: disallow ever going rw if nochanges or noreplay
      bcachefs: delete duplicated code
      bcachefs: allocate sb_read_scratch with __get_free_page
      bcachefs: Pass flags arg to bch2_alloc_write()
      bcachefs: cmp_int()
      bcachefs: Journal replay refactoring
      bcachefs: Deduplicate keys in the journal before replay
      bcachefs: Mark overwrites from journal replay in initial gc
      bcachefs: lockdep fix when going rw from bch2_alloc_write()
      bcachefs: Fix hang while shutting down
      bcachefs: use same timesource as current_time()
      bcachefs: fix triggers for stripes btree
      bcachefs: Return errors from for_each_btree_key()
      bcachefs: copy correct journal_seq to dir in create
      bcachefs: Add actual tracepoints for transaction restarts
      bcachefs: fix bch2_flags_to_text()
      bcachefs: Don't hardcode BTREE_ID_EXTENTS
      bcachefs: bch2_bkey_ptrs_invalid()
      bcachefs: Fix fsync error reporting
      bcachefs: Fix journal shutdown path
      bcachefs: fix bch2_rbio_narrow_crcs()
      bcachefs: Fix a bug with multiple iterators being traversed
      bcachefs: Avoid write lock on mark_lock
      bcachefs: Write out fs usage consistently
      bcachefs: btree_bkey_cached_common
      bcachefs: bch2_trans_mark_update()
      bcachefs: Various improvements to bch2_alloc_write()
      bcachefs: some improvements to startup messages and options
      bcachefs: Don't run fsck by default at mount time
      bcachefs: Fix return code from bch2_fs_start()
      bcachefs: Redo replicas gc mechanism
      bcachefs: Fix for the stripes mark path and gc
      bcachefs: Kill remaining bch2_btree_iter_unlock() uses
      bcachefs: Don't pass around may_drop_locks
      bcachefs: kill BTREE_ITER_NOUNLOCK
      bcachefs: Merge extents with checksums
      bcachefs: stripe creation fixes
      bcachefs: bch2_btree_delete_at_range()
      bcachefs: improved btree locking tracepoints
      bcachefs: Fix spurious inconsistency in recovery
      bcachefs: Delete duplicate code
      bcachefs: Fix a bug with spinning on the journal
      bcachefs: Ensure bch2_btree_iter_next() always advances
      bcachefs: Avoid spurious transaction restarts
      bcachefs: More work to avoid transaction restarts
      bcachefs: Rip out old hacky transaction restart tracing
      bcachefs: Don't use a fixed size buffer for fs_usage_deltas
      bcachefs: fix bch2_extent_merge()
      bcachefs: fix a mount error path
      bcachefs: better BTREE_INSERT_NO_CLEAR_REPLICAS
      bcachefs: Fix cached sectors not being updated on invalidate
      bcachefs: Improve key marking interface
      bcachefs: Fix an error path in bch2_btree_iter_traverse()
      bcachefs: Fix starting copygc when already started
      bcachefs: Don't overflow stack in bch2_extent_merge_inline()
      bcachefs: bkey_merge() now takes bkey_s
      bcachefs: Reduce BKEY_PADDED usage
      bcachefs: Don't allow bkey vals that are too big in extents btree
      bcachefs: Fix promoting to cache devices (durability = 0)
      bcachefs: use memalloc_nofs_save() for vmalloc allocation
      bcachefs: fix __bch2_xattr_bcachefs_get()
      bcachefs: Delete a spurious assertion
      bcachefs: fix kasan splat
      bcachefs: Fix array overrun with unknown btree roots
      bcachefs: add inode_generation_to_text method
      bcachefs: Update path now handles triggers that generate more triggers
      bcachefs: Refactor trans_(get|update)_key
      bcachefs: Check for key size > offset
      bcachefs: Improve bch2_lock_inodes()
      bcachefs: Fix for building with old gcc
      bcachefs: kill bch2_crc64_update
      bcachefs: Kill direct access to bi_io_vec
      bcachefs: kill bio_for_each_contig_segment()
      bcachefs: Fix moving compressed data
      bcachefs: Always touch page state with page locked
      bcachefs: Kill page_state_cmpxchg
      bcachefs: Track dirtyness at sector level, not page
      bcachefs: Don't try to delete stripes when RO
      bcachefs: Fix stripe_idx_to_delete()
      bcachefs: Fix ec_stripes_read()
      bcachefs: Convert some assertions to fsck errors
      bcachefs: Don't overflow trans with iters from triggers
      bcachefs: Print out name of bkey type
      bcachefs: Add offset_into_extent param to bch2_read_extent()
      bcachefs: add missing bch2_trans_begin() call
      bcachefs: Don't unlink iters on unsuccessful commit
      bcachefs: Dont't call bch2_trans_begin_updates() in bch2_extent_update()
      bcachefs: Refactor __bch2_cut_front()
      bcachefs: Refactor various code to not be extent specific
      bcachefs: Fix bch2_seek_data()
      bcachefs: Change __bch2_writepage() to not write to holes
      bcachefs: Change buffered write path to write to partial pages
      bcachefs: Handle partial pages in seek data/hole
      bcachefs: Count reserved extents as holes
      bcachefs: Truncate/fpunch now works on block boundaries, not page
      bcachefs: Export correct blocksize to vfs
      bcachefs: trans_get_key() now works correctly for extents
      bcachefs: fix for_each_btree_key()
      bcachefs: Ensure bch2_trans_get_iter() returns iters with correct locks
      bcachefs: Mark space as unallocated on write failure
      bcachefs: Rework calling convention for marking overwrites
      bcachefs: Improved debug checks
      bcachefs: Fix __bch2_btree_iter_peek_slot_extents()
      bcachefs: Fix bch2_btree_node_iter_prev_filter()
      bcachefs: Fix bch2_btree_node_iter_fix()
      bcachefs: Move node iterator fixup to extent_bset_insert()
      bcachefs: Refactor bch2_extent_trim_atomic() for reflink
      bcachefs: Reflink
      bcachefs: Fix bch2_sort_repack_merge()
      bcachefs: Fix bch2_bkey_narrow_crcs()
      bcachefs: Fix faulty assertion
      bcachefs: Check alignment in write path
      bcachefs: Re-enable bkey_debugcheck() in the extent update path
      bcachefs: Update more code for KEY_TYPE_reflink_v
      bcachefs: Handle ec_buf not being page aligned when allocating bio
      bcachefs: Fix a spurious gcc warning
      bcachefs: Don't flush journal from bch2_vfs_write_inode()
      bcachefs: Inline some fast paths
      bcachefs: Add a hint for allocating new stripes
      bcachefs: Optimize fiemap
      bcachefs: Trust in memory bucket mark
      bcachefs: Refactor bch2_alloc_write()
      bcachefs: Fixes for replicas tracking
      bcachefs: Reflink pointers also have to be remarked if split in journal replay
      bcachefs: Fix error message on bucket overflow
      bcachefs: Fix fiemap (again)
      bcachefs: Switch reconstruct_alloc to a mount option
      bcachefs: Improve pointer marking checks and error messages
      bcachefs: Fix BTREE_INSERT_NOMARK_OVERWRITES
      bcachefs: Kill BTREE_INSERT_NOMARK_INSERT
      bcachefs: Rebalance now adds replicas if needed
      bcachefs: Flush fsck errors when looping in btree gc
      bcachefs: Fix a null ptr deref
      bcachefs: data move path should not be trying to move reflink_p keys
      bcachefs: Drop trans arg to bch2_extent_atomic_end()
      bcachefs: Do updates in order they were queued up in
      bcachefs: __bch2_btree_node_iter_fix() improvements
      bcachefs: Improved bch2_fcollapse()
      bcachefs: Fix a typo
      bcachefs: Optimize calls to bch2_btree_iter_traverse()
      bcachefs: Add missing bch2_btree_node_iter_fix() calls
      bcachefs: Debug code improvements
      bcachefs: Improve btree_iter_pos_in_node()
      bcachefs: More btree iter improvements
      bcachefs: Avoid deadlocking on the allocator
      bcachefs: Add missing bch2_btree_node_iter_fix() call
      bcachefs: Debug assertion improvements
      bcachefs: Check for extents past eof correctly
      bcachefs: Don't write past eof
      bcachefs: bch2_btree_iter_peek_prev()
      bcachefs: Add support for FALLOC_FL_INSERT_RANGE
      bcachefs: Fix validation of replicas entries
      bcachefs: Drop unused arg to bch2_open_buckets_stop_dev()
      bcachefs: Handle bio_iov_iter_get_pages() returning unaligned bio
      bcachefs: Update path microoptimizations
      bcachefs: Drop unnecessary rcu_read_lock()
      bcachefs: Count iterators for reflink_p overwrites correctly
      bcachefs: Convert a BUG_ON() to a warning
      bcachefs: Trivial cleanup
      bcachefs: Cleanup i_nlink handling
      bcachefs: Improve error handling for for_each_btree_key_continue()
      bcachefs: BTREE_ITER_SLOTS isn't a type of btree iter
      bcachefs: Fix for partial buffered writes
      bcachefs: Kill deferred btree updates
      bcachefs: Rework btree iterator lifetimes
      bcachefs: Fix counting iterators for reflink pointers
      bcachefs: Trust inode in btree over bch_inode_info
      bcachefs: Fix __bch2_buffered_write() returning -ENOMEM
      bcachefs: Fix an error path
      bcachefs: Fix undefined behaviour
      bcachefs: bch2_inode_peek()/bch2_inode_write()
      bcachefs: Fix deref of error pointer
      bcachefs: Only look up inode io opts in extents btree
      bcachefs: Don't use sha256 for siphash str hash key
      bcachefs: Factor out fs-common.c
      bcachefs: bch2_extent_atomic_end() now traverses iter
      bcachefs: Don't allocate memory under mark_lock
      bcachefs: Can't be holding read locks while taking write locks
      bcachefs: Fix incorrect use of bch2_extent_atomic_end()
      bcachefs: Fix bch2_mark_extent()
      bcachefs: Fix bch2_extent_ptr_durability()
      bcachefs: Limit pointers to being in only one stripe
      bcachefs: Fix ec_stripes_read()
      bcachefs: Fix erasure coding disk space accounting
      bcachefs: Add a lock to bch_page_state
      bcachefs: Refactor bch2_readdir() a bit
      bcachefs: Fix bch2_btree_iter_next() after peek_slot()
      bcachefs: Check if extending inode differently
      bcachefs: Kill some dependencies on ei_inode
      bcachefs: Split out bchfs_extent_update()
      bcachefs: Convert bch2_fpunch to bch2_extent_update()
      bcachefs: Kill bchfs_extent_update()
      bcachefs: Fix a subtle race in the btree split path
      bcachefs: Fix creation of lost+found
      bcachefs: Switch to .iterate_shared for readdir
      bcachefs: Fix a debug assertion
      bcachefs: Fix iterator counting for reflink pointers (again)
      bcachefs: Fix flushing held btree writes when there's a fs error
      bcachefs: Fix an iterator counting bug
      bcachefs: Limit bios in writepages path to 256M
      bcachefs: Drop bch_write_op->io_wq
      bcachefs: Don't submit bio in write path under lock
      bcachefs: Make replicas_delta_list smaller
      bcachefs: Make btree_node_type_needs_gc() cheaper
      bcachefs: Refactor bch2_trans_commit() path
      bcachefs: Don't use FUA unnecessarily
      bcachefs: kill bch2_extent_merge_inline()
      bcachefs: Avoid calling iter_prev() in extent update path
      bcachefs: Don't use rep movsq for small memcopies
      bcachefs: Don't reuse bio in retry path
      bcachefs: Fix an error path race
      bcachefs: Add missing error checking in bch2_find_by_inum_trans()
      bcachefs: More bset.c microoptimization
      bcachefs: Trust btree alloc info at runtime
      bcachefs: Inline more of bch2_trans_commit hot path
      bcachefs: bch2_btree_iter_fix_key_modified()
      bcachefs: Don't use extent_ptr_decoded_append() in write path (fixup patch)
      bcachefs: Avoid atomics in write fast path
      bcachefs: Don't hold inode lock longer than necessary in dio write path
      bcachefs: Add pagecache_add lock to buffered IO path, fault path
      bcachefs: DIO write path only needs to shoot down pagecache once, not twice
      bcachefs: Eliminate function calls in DIO fastpaths
      bcachefs: Fix setting of attributes mask in getattr
      bcachefs: Some reflink fixes
      bcachefs: Don't BUG_ON() sector count overflow
      bcachefs: Add an option for fsck error ratelimiting
      bcachefs: Avoid calling bch2_btree_iter_relock() in bch2_btree_iter_traverse()
      bcachefs: Inline fast path of bch2_increment_clock()
      bcachefs: Make __bch2_bkey_cmp_packed() smaller
      bcachefs: Pipeline binary searches and linear searches
      bcachefs: bch2_read_extent() microoptimizations
      bcachefs: kill BFLOAT_FAILED_PREV
      bcachefs: Fall back to slowpath on exact comparison
      bcachefs: Go back to 16 bit mantissa bkey floats
      bcachefs: Remove some BKEY_PADDED uses
      bcachefs: Be slightly less tricky with union usage
      bcachefs: Fix erorr path in bch2_write()
      bcachefs: Use wbc_to_write_flags()
      bcachefs: Make memcpy_to_bio() param const
      bcachefs: bkey_on_stack
      bcachefs: kill bch2_extent_has_device()
      bcachefs: bkey noops
      bcachefs: Rework of cut_front & cut_back
      bcachefs: Split out extent_update.c
      bcachefs: Inline data extents
      bcachefs: Reorganize extents.c
      bcachefs: kill ca->freelist_lock
      bcachefs: bkey_on_stack_reassemble()
      bcachefs: Switch to macro for bkey_ops
      bcachefs: bch2_check_set_feature()
      bcachefs: Put inline data behind a mount option for now
      bcachefs: Fix bch2_verify_insert_pos()
      bcachefs: Always emit new extents on partial overwrite
      bcachefs: Whiteout changes
      bcachefs: Refactor whiteouts compaction
      bcachefs: Use one buffer for sorting whiteouts
      bcachefs: Kill btree_node_iter_large
      bcachefs: Fix a null ptr deref in btree_iter_traverse_one()
      bcachefs: Fix for an assertion on filesystem error
      bcachefs: Redo filesystem usage ioctls
      bcachefs: Fix a memory splat
      bcachefs: Make io timers less buggy
      bcachefs: Redo copygc throttling
      bcachefs: Drop a faulty assertion
      bcachefs: bch2_trans_reset() calls should be at the tops of loops
      bcachefs: Convert all bch2_trans_commit() users to BTREE_INSERT_ATOMIC
      bcachefs: Kill BTREE_INSERT_ATOMIC
      bcachefs: Don't reexecute triggers when retrying transaction commit
      bcachefs: Don't export __bch2_fs_read_write
      bcachefs: Fix a use after free
      bcachefs: Add an assertion to track down a heisenbug
      bcachefs: Convert some enums to x-macros
      bcachefs: Use KEY_TYPE_deleted whitouts for extents
      bcachefs: Use bch2_trans_reset in bch2_trans_commit()
      bcachefs: Make btree_insert_entry more private to update path
      bcachefs: Split out btree_trigger_flags
      bcachefs: Sort & deduplicate updates in bch2_trans_update()
      bcachefs: Make sure bch2_read_extent obeys BCH_READ_MUST_CLONE
      bcachefs: Fix an iterator error path
      bcachefs: Don't print anything when device doesn't have a label
      bcachefs: Hacky fixes for device removal
      bcachefs: Kill bch2_fs_bug()
      bcachefs: Fix extent_to_replicas()
      bcachefs: Ensure iterators are valid before calling trans_mark_key()
      bcachefs: Don't call trans_iter_put() on error pointer
      bcachefs: Don't lose needs_whiteout in overwrite path
      bcachefs: Rework iter->pos handling
      bcachefs: Refactor bch2_btree_bset_insert_key()
      bcachefs: Add some comments for btree iterator flags
      bcachefs: Change btree split threshold to be in u64s
      bcachefs: Fix bch2_sort_keys() to not modify src keys
      bcachefs: Don't modify existing key in place in sort_repack_merge()
      bcachefs: Add a cond_resched() to rebalance loop
      bcachefs: Improve tracepoints slightly in commit path
      bcachefs: Refactor rebalance_pred function
      bcachefs: Track incompressible data
      bcachefs: Fix an in iterator leak
      bcachefs: Fix an uninitialized field in bch_write_op
      bcachefs: Improve an insert path optimization
      bcachefs: Make sure we're releasing btree iterators
      bcachefs: btree_and_journal_iter
      bcachefs: __bch2_btree_iter_set_pos()
      bcachefs: Make BTREE_ITER_IS_EXTENTS private to iter code
      bcachefs: Fix bch2_ptr_swab for indirect extents
      bcachefs: Check for bad key version number
      bcachefs: Fix traversing to interior nodes
      bcachefs: introduce b->hash_val
      bcachefs: btree_ptr_v2
      bcachefs: Seralize btree_update operations at btree_update_nodes_written()
      bcachefs: Kill TRANS_RESET_MEM|TRANS_RESET_ITERS
      bcachefs: Issue discards when needed to allocate journal write
      bcachefs: Fix incorrect initialization of btree_node_old_extent_overwrite()
      bcachefs: Use btree_ptr_v2.mem_ptr to avoid hash table lookup
      bcachefs: fix setting btree_node_accessed()
      bcachefs: BCH_SB_FEATURES_ALL
      bcachefs: Improve an error message
      bcachefs: Fix error message on bucket sector count overflow
      bcachefs: Dont't del sysfs dir until after we go RO
      bcachefs: Journal pin cleanups
      bcachefs: Some btree iterator improvements
      bcachefs: Fix extent_sort_fix_overlapping()
      bcachefs: Fix off by one error in bch2_extent_crc_append()
      bcachefs: Fix another iterator leak
      bcachefs: Fix bch2_dump_bset()
      bcachefs: Don't log errors that are expected during shutdown
      bcachefs: Traverse iterator in journal replay
      bcachefs: Skip 0 size deleted extents in journal replay
      bcachefs: Iterator debug code improvements
      bcachefs: Simplify bch2_btree_iter_peek_slot()
      bcachefs: More btree iter invariants
      bcachefs: Fix build when CONFIG_BCACHEFS_DEBUG=n
      bcachefs: btree_iter_peek_with_updates()
      bcachefs: Move extent overwrite handling out of core btree code
      bcachefs: Drop unused export
      bcachefs: Fix a use after free in dio write path
      bcachefs: Don't use peek_filter() unnecessarily
      bcachefs: Fix another iterator leak
      bcachefs: Clear BCH_FEATURE_extents_above_btree_updates on clean shutdown
      bcachefs: BCH_FEATURE_new_extent_overwrite is now required
      bcachefs: Shut down quicker
      bcachefs: Fix an iterator bug
      bcachefs: Fix count_iters_for_insert()
      bcachefs: Fix a locking bug in fsck
      bcachefs: Disable extent merging
      bcachefs: trans_commit() path can now insert to interior nodes
      bcachefs: Replay interior node keys
      bcachefs: Journal updates to interior nodes
      bcachefs: Fix an assertion when nothing to replay
      bcachefs: Add an option for keeping journal entries after startup
      bcachefs: Improve error message in fsck
      bcachefs: Use memalloc_nofs_save()
      bcachefs: Various fixes for interior update path
      bcachefs: Read journal when keep_journal on
      bcachefs: Use kvpmalloc mempools for compression bounce
      bcachefs: Switch a BUG_ON() to a warning
      bcachefs: Kill bkey_type_successor
      bcachefs: Reduce max nr of btree iters when lockdep is on
      bcachefs: Don't allocate memory while holding journal reservation
      bcachefs: Check btree topology at startup
      bcachefs: Fix ec_stripe_update_ptrs()
      bcachefs: Fix inodes pass in fsck
      bcachefs: Fix a locking bug
      bcachefs: Fix iterating of journal keys within a btree node
      bcachefs: Fix journalling of interior node updates
      bcachefs: Add print method for bch2_btree_ptr_v2
      bcachefs: Fix fallocate FL_INSERT_RANGE
      bcachefs: Trace where btree iterators are allocated
      bcachefs: Add another mssing bch2_trans_iter_put() call
      bcachefs: Fix a null ptr deref during journal replay
      bcachefs: Fix another error path locking bug
      bcachefs: Fix a debug assertion
      bcachefs: Fix a debug mode assertion
      bcachefs: Fix a deadlock on starting an interior btree update
      bcachefs: Account for ioclock slop when throttling rebalance thread
      bcachefs: Fix a locking bug in bch2_btree_ptr_debugcheck()
      bcachefs: Fix another deadlock in the btree interior update path
      bcachefs: Fix a locking bug in bch2_journal_pin_copy()
      bcachefs: Improve lockdep annotation in journalling code
      bcachefs: Slightly reduce btree split threshold
      bcachefs: Add a few tracepoints
      bcachefs: Fix for the bkey compat path
      bcachefs: Handle -EINTR bch2_migrate_index_update()
      bcachefs: Fix a deadlock
      bcachefs: More fixes for counting extent update iterators
      bcachefs: Don't issue writes that are more than 1 MB
      bcachefs: Add some printks for error paths
      bcachefs: Fix another deadlock in btree_update_nodes_written()
      bcachefs: Fix two more deadlocks
      bcachefs: Some compression improvements
      bcachefs: Fix initialization of bounce mempools
      bcachefs: Fixes for startup on very full filesystems
      bcachefs: Validate that we read the correct btree node
      bcachefs: Fix a workqueue deadlock
      bcachefs: Fix setquota
      bcachefs: Fix another iterator counting bug
      bcachefs: Wrap vmap() in memalloc_nofs_save()/restore()
      bcachefs: Print out d_type in dirent_to_text()
      bcachefs: Add vmalloc fallback for decompress workspace
      bcachefs: Handle printing of null bkeys
      bcachefs: Be more rigorous about marking the filesystem clean
      bcachefs: Better error messages on bucket sector count overflows
      bcachefs: fix memalloc_nofs_restore() usage
      bcachefs: Fix reading of alloc info after unclean shutdown
      bcachefs: Add a mechanism for passing extra journal entries to bch2_trans_commit()
      bcachefs: Factor out bch2_fs_btree_interior_update_init()
      bcachefs: Interior btree updates are now fully transactional
      bcachefs: fsck_error_lock requires GFP_NOFS
      bcachefs: Don't require alloc btree to be updated before buckets are used
      bcachefs: Fixes for going RO
      bcachefs: Add an option to disable reflink support
      bcachefs: Set filesystem features earlier in fs init path
      bcachefs: Add debug code to print btree transactions
      bcachefs: Fix a deadlock in bch2_btree_node_get_sibling()
      bcachefs: Improve assorted error messages
      bcachefs: Kill old allocator startup code
      bcachefs: Always increment bucket gen on bucket reuse
      bcachefs: Improve warning for copygc failing to move data
      bcachefs: bch2_trans_downgrade()
      bcachefs: Call bch2_btree_iter_traverse() if necessary in commit path
      bcachefs: Check gfp_flags correctly in bch2_btree_cache_scan()
      bcachefs: btree_update_nodes_written() requires alloc reserve
      bcachefs: Make open bucket reserves more conservative
      bcachefs: Fix a linked list bug
      bcachefs: Don't allocate memory under the btree cache lock
      bcachefs: More open buckets
      bcachefs: Always give out journal pre-res if we already have one
      bcachefs: Refactor btree insert path
      bcachefs: Fix a deadlock
      bcachefs: Don't deadlock when btree node reuse changes lock ordering
      bcachefs: Add an internal option for reading entire journal
      bcachefs: Turn c->state_lock into an rwsem
      bcachefs: Implement a new gc that only recalcs oldest gen
      bcachefs: Btree key cache
      bcachefs: Use cached iterators for alloc btree
      bcachefs: Give bkey_cached_key same attributes as bpos
      bcachefs: Increase size of btree node reserve
      bcachefs: delete a slightly faulty assertion
      bcachefs: Fix lock ordering with new btree cache code
      bcachefs: Fix incorrect gfp check
      bcachefs: Fix a deadlock in the RO path
      bcachefs: Change bch2_dump_bset() to also print key values
      bcachefs: Add a kthread_should_stop() check to allocator thread
      bcachefs: Use btree reserve when appropriate
      bcachefs: Track sectors of erasure coded data
      bcachefs: Fix a null ptr deref in bch2_btree_iter_traverse_one()
      bcachefs: Fix bch2_extent_can_insert() not being called
      bcachefs: Refactor dio write code to reinit bch_write_op
      bcachefs: Don't cap ios in dio write path at 2 MB
      bcachefs: Use blk_status_to_str()
      bcachefs: Mark btree nodes as needing rewrite when not all replicas are RW
      bcachefs: Kill BTREE_TRIGGER_NOOVERWRITES
      bcachefs: Rework triggers interface
      bcachefs: Improve stripe triggers/heap code
      bcachefs: Move stripe creation to workqueue
      bcachefs: Refactor stripe creation
      bcachefs: Allow existing stripes to be updated with new data buckets
      bcachefs: Fix short buffered writes
      bcachefs: Use x-macros for data types
      bcachefs: Fix extent_ptr_durability() calculation for erasure coded data
      bcachefs: Drop extra pointers when marking data as in a stripe
      bcachefs: Make copygc thread global
      bcachefs: Add an option for rebuilding the replicas section
      bcachefs: Wrap write path in memalloc_nofs_save()
      bcachefs: Fix a faulty assertion
      bcachefs: Add bch2_blk_status_to_str()
      bcachefs: Don't restrict copygc writes to the same device
      bcachefs: Refactor replicas code
      bcachefs: Fix an error path
      bcachefs: Delete unused arguments
      bcachefs: Don't let copygc buckets be stolen by other threads
      bcachefs: Fix a race with BCH_WRITE_SKIP_CLOSURE_PUT
      bcachefs: Ensure we only allocate one EC bucket per writepoint
      bcachefs: Fix bch2_btree_node_insert_fits()
      bcachefs: Ensure we wake up threads locking node when reusing it
      bcachefs: Remove some uses of PAGE_SIZE in the btree code
      bcachefs: Convert various code to printbuf
      bcachefs: Fix maximum btree node size
      bcachefs: Don't disallow btree writes to RO devices
      bcachefs: Fix bch2_new_stripes_to_text()
      bcachefs: Fix a bug with the journal_seq_blacklist mechanism
      bcachefs: Don't block on allocations when only writing to specific device
      bcachefs: Change copygc to consider bucket fragmentation
      bcachefs: Fix disk groups not being updated when set via sysfs
      bcachefs: Fix a couple null ptr derefs when no disk groups exist
      bcachefs: Add a cond_resched() to bch2_alloc_write()
      bcachefs: Don't report inodes to statfs
      bcachefs: Some project id fixes
      bcachefs: Make sure to go rw if lazy in fsck
      bcachefs: Improvements to the journal read error paths
      bcachefs: Don't fail mount if device has been removed
      bcachefs: Fix unmount path
      bcachefs: Fix journal_seq_copy()
      bcachefs: Fix __bch2_truncate_page()
      bcachefs: Fix a lockdep splat
      bcachefs: Fix off-by-one error in ptr gen check
      bcachefs: Fix gc of stale ptr gens
      bcachefs: Copy ptr->cached when migrating data
      bcachefs: Fix errors early in the fs init process
      bcachefs: Fix another lockdep splat
      bcachefs: Fix copygc of compressed data
      bcachefs: Fix copygc dying on startup
      bcachefs: Perf improvements for bch_alloc_read()
      bcachefs: Fix assertion popping in transaction commit path
      bcachefs: Improvements to writing alloc info
      bcachefs: Start/stop io clock hands in read/write paths
      bcachefs: Fix for bad stripe pointers
      bcachefs: Account for stripe parity sectors separately
      bcachefs: Don't drop replicas when copygcing ec data
      bcachefs: Fix bch2_mark_stripe()
      bcachefs: Fix for passing target= opts as mount opts
      bcachefs: Improve some error messages
      bcachefs: Fix rare use after free in read path
      bcachefs: Indirect inline data extents
      bcachefs: Drop alloc keys from journal when -o reconstruct_alloc
      bcachefs: Always write a journal entry when stopping journal
      bcachefs: Add mode to bch2_inode_to_text
      bcachefs: Fix btree updates when mixing cached and non cached iterators
      bcachefs: fiemap fixes
      bcachefs: Use cached iterators for inode updates
      bcachefs: Fix stack corruption
      bcachefs: Improve tracing for transaction restarts
      bcachefs: Fix spurious transaction restarts
      bcachefs: Improve check for when bios are physically contiguous
      bcachefs: Inode create optimization
      bcachefs: Minor journal reclaim improvement
      bcachefs: Drop sysfs interface to debug parameters
      bcachefs: Split out debug_check_btree_accounting
      bcachefs: Don't embed btree iters in btree_trans
      bcachefs: add const annotations to bset.c
      bcachefs: Report inode counts via statfs
      bcachefs: Improved inode create optimization
      bcachefs: Build fixes for 32bit x86
      bcachefs: Add a single slot percpu buf for btree iters
      bcachefs: Fix spurious transaction restarts
      bcachefs: More inlinining in the btree key cache code
      bcachefs: Drop typechecking from bkey_cmp_packed()
      bcachefs: Fix build warning when CONFIG_BCACHEFS_DEBUG=n
      bcachefs: New varints
      bcachefs: use a radix tree for inum bitmap in fsck
      bcachefs: Inline make_bfloat() into __build_ro_aux_tree()
      bcachefs: Fix btree iterator leak
      bcachefs: Add accounting for dirty btree nodes/keys
      bcachefs: Fix btree key cache shutdown
      bcachefs: Fix missing memalloc_nofs_restore()
      bcachefs: Hack around bch2_varint_decode invalid reads
      bcachefs: Deadlock prevention for ei_pagecache_lock
      bcachefs: Improve journal entry validate code
      bcachefs: Fix a 64 bit divide
      bcachefs: Fix a btree transaction iter overflow
      bcachefs: Inode delete doesn't need to flush key cache anymore
      bcachefs: Be more careful in bch2_bkey_to_text()
      bcachefs: Improve journal error messages
      bcachefs: Delete dead journalling code
      bcachefs: Assorted journal refactoring
      bcachefs: Check for errors from register_shrinker()
      bcachefs: Take a SRCU lock in btree transactions
      bcachefs: Add a shrinker for the btree key cache
      bcachefs: Fix journal entry repair code
      bcachefs: Convert tracepoints to use %ps, not %pf
      bcachefs: Set preallocated transaction mem to avoid restarts
      bcachefs: Dont' use percpu btree_iter buf in userspace
      bcachefs: Dump journal state when the journal deadlocks
      bcachefs: Add more debug checks
      bcachefs: Add an ioctl for resizing journal on a device
      bcachefs: Add btree cache stats to sysfs
      bcachefs: Be more precise with journal error reporting
      bcachefs: Add a kmem_cache for btree_key_cache objects
      bcachefs: More debug code improvements
      bcachefs: Improve btree key cache shrinker
      bcachefs: Ensure journal reclaim runs when btree key cache is too dirty
      bcachefs: Simplify transaction commit error path
      bcachefs: Journal reclaim requires memalloc_noreclaim_save()
      bcachefs: Throttle updates when btree key cache is too dirty
      bcachefs: Move journal reclaim to a kthread
      bcachefs: Fix an rcu splat
      bcachefs: Don't use bkey cache for inode update in fsck
      bcachefs: bch2_btree_delete_range_trans()
      bcachefs: Delete dead code
      bcachefs: Optimize bch2_journal_flush_seq_async()
      bcachefs: Fix for __readahead_batch getting partial batch
      bcachefs: Fix journal reclaim spinning in recovery
      bcachefs: Fix error in filesystem initialization
      bcachefs: Change a BUG_ON() to a fatal error
      bcachefs: Ensure we always have a journal pin in interior update path
      bcachefs: Use BTREE_ITER_PREFETCH in journal+btree iter
      bcachefs: Fix for fsck spuriously finding duplicate extents
      bcachefs: Journal pin refactoring
      bcachefs: Add error handling to unit & perf tests
      bcachefs: bch2_trans_get_iter() no longer returns errors
      bcachefs: Fix journal_flush_seq()
      bcachefs: Fix some spurious gcc warnings
      bcachefs: Fix spurious alloc errors on forced shutdown
      bcachefs: Refactor filesystem usage accounting
      bcachefs: Improve some IO error messages
      bcachefs: Flag inodes that had btree update errors
      bcachefs: Check for errors in bch2_journal_reclaim()
      bcachefs: Don't issue btree writes that weren't journalled
      bcachefs: Increase journal pipelining
      bcachefs: Improve journal free space calculations
      bcachefs: Don't require flush/fua on every journal write
      bcachefs: Be more conservation about journal pre-reservations
      bcachefs: Fix btree key cache dirty checks
      bcachefs: Prevent journal reclaim from spinning
      bcachefs: Try to print full btree error message
      bcachefs: Fix rand_delete() test
      bcachefs: Fix __btree_iter_next() when all iters are in use_next() when all iters are in use
      bcachefs: Only try to get existing stripe once in stripe create path
      bcachefs: Update transactional triggers interface to pass old & new keys
      bcachefs: Always check if we need disk res in extent update path
      bcachefs: Fix btree node merge -> split operations
      bcachefs: Add some cond_rescheds() in shutdown path
      bcachefs: Check for duplicate device ptrs in bch2_bkey_ptrs_invalid()
      bcachefs: Add BCH_BKEY_PTRS_MAX
      bcachefs: Don't write bucket IO time lazily
      bcachefs: Fix race between journal_seq_copy() and journal_seq_drop()
      bcachefs: Fix for spinning in journal reclaim on startup
      bcachefs: Fix btree lock being incorrectly dropped
      bcachefs: Fix iterator overflow in move path
      bcachefs: Don't use BTREE_INSERT_USE_RESERVE so much
      bcachefs: Change when we allow overwrites
      bcachefs: Don't read existing stripes synchronously in write path
      bcachefs: Change allocations for ec stripes to blocking
      bcachefs: Use separate new stripes for copygc and non-copygc
      bcachefs: Reduce/kill BKEY_PADDED use
      bcachefs: Fix journal_buf_realloc()
      bcachefs: Don't error out of recovery process on journal read error
      bcachefs: Work around a zstd bug
      bcachefs: Reserve some open buckets for btree allocations
      bcachefs: Fix btree node split after merge operations
      bcachefs: bch2_alloc_write() should be writing for all devices
      bcachefs: Fix bch2_replicas_gc2
      bcachefs: Fix .splice_write
      bcachefs: Add cannibalize lock to btree_cache_to_text()
      bcachefs: Erasure coding fixes & refactoring
      bcachefs: Add btree node prefetching to bch2_btree_and_journal_walk()
      bcachefs: Factor out bch2_ec_stripes_heap_start()
      bcachefs: Run jset_validate in write path as well
      bcachefs: Correctly order flushes and journal writes on multi device filesystems
      bcachefs: Fix integer overflow in bch2_disk_reservation_get()
      bcachefs: Fix double counting of stripe block counts by GC
      bcachefs: Fix gc updating stripes info
      bcachefs: Kill stripe->dirty
      bcachefs: Preserve stripe blockcounts on existing stripes
      bcachefs: Verify transaction updates are sorted
      bcachefs: Rework allocating buckets for stripes
      bcachefs: Don't allocate stripes at POS_MIN
      bcachefs: Fix an assertion pop
      bcachefs: Clean up bch2_extent_can_insert
      bcachefs: Fix loopback in dio mode
      bcachefs: Switch replicas.c allocations to GFP_KERNEL
      bcachefs: Fix a faulty assertion
      bcachefs: Ensure __bch2_trans_commit() always calls bch2_trans_reset()
      bcachefs: Kill metadata only gc
      bcachefs: Refactor dev usage
      bcachefs: Kill bch2_invalidate_bucket()
      bcachefs: Mark superblocks transactionally
      bcachefs: Fix an assertion
      bcachefs: Fix build in userspace
      bcachefs: Fix BCH_REPLICAS_MAX check
      bcachefs: Improve diagnostics when journal entries are missing
      bcachefs: Refactor checking of btree topology
      bcachefs: Add BTREE_PTR_RANGE_UPDATED
      bcachefs: Add support for doing btree updates prior to journal replay
      bcachefs: Add (partial) support for fixing btree topology
      bcachefs: Repair bad data pointers
      bcachefs: Add an option for metadata_target
      bcachefs: Add an assertion to check for journal writes to same location
      bcachefs: Add missing call to bch2_replicas_entry_sort()
      bcachefs: KEY_TYPE_alloc_v2
      bcachefs: Persist 64 bit io clocks
      bcachefs: Journal updates to dev usage
      bcachefs: Include device in btree IO error messages
      bcachefs: Fixes/improvements for journal entry reservations
      bcachefs: Run fsck if BCH_FEATURE_alloc_v2 isn't set
      bcachefs: Redo checks for sufficient devices
      bcachefs: Add flushed_seq_ondisk to journal_debug_to_text()
      bcachefs: Fix for hash_redo_key() in fsck
      bcachefs: Simplify btree_iter_(next|prev)_leaf()
      bcachefs: Kill bch2_btree_iter_set_pos_same_leaf()
      bcachefs: bch2_btree_iter_advance_pos()
      bcachefs: Fix bch2_btree_iter_peek_prev()
      bcachefs: Assert that we're not trying to flush journal seq in the future
      bcachefs: Fix a shift greater than type size
      bcachefs: Fsck fixes
      bcachefs: Drop invalid stripe ptrs in fsck
      bcachefs: Ensure btree iterators are traversed in bch2_trans_commit()
      bcachefs: iter->real_pos
      bcachefs: Extents may now cross btree node boundaries
      bcachefs: Add error message for some allocation failures
      bcachefs: Fix for bch2_btree_node_get_noiter() returning -ENOMEM
      bcachefs: Create allocator threads when allocating filesystem
      bcachefs: Don't call into journal reclaim when we're not supposed to
      bcachefs: Don't use inode btree key cache in fsck code
      bcachefs: Fix a 64 bit divide on 32 bit
      bcachefs: Dump journal state when we get stuck
      bcachefs: Add code to scan for/rewite old btree nodes
      bcachefs: Scan for old btree nodes if necessary on mount
      bcachefs: Fix bkey format generation for 32 bit fields
      bcachefs: Fix an allocator startup race
      bcachefs: Fix some (spurious) warnings about uninitialized vars
      bcachefs: Use x-macros for compat feature bits
      bcachefs: Add a cond_seched() to the allocator thread
      bcachefs: Don't fail mounts due to devices that are marked as failed
      bcachefs: Fix bch2_write_super to obey very_degraded option
      bcachefs: Bring back metadata only gc
      bcachefs: Fix a use-after-free in bch2_gc_mark_key()
      bcachefs: Don't drop ptrs to btree nodes
      bcachefs: Fix copygc threshold
      bcachefs: Add copygc wait to sysfs
      bcachefs: Rip out copygc pd controller
      bcachefs: Add allocator thread state to sysfs
      bcachefs: Fix for copygc getting stuck waiting for reserve to be filled
      bcachefs: Start journal reclaim thread earlier
      bcachefs: Add a mempool for btree_trans bump allocator
      bcachefs: Add a mempool for the replicas delta list
      bcachefs: Fix bch2_btree_cache_scan()
      bcachefs: Kill support for !BTREE_NODE_NEW_EXTENT_OVERWRITE()
      bcachefs: KEY_TYPE_discard is no longer used
      bcachefs: Rename KEY_TYPE_whiteout -> KEY_TYPE_hash_whiteout
      bcachefs: Rename BTREE_ID enums for consistency with other enums
      bcachefs: Use x-macros for more enums
      bcachefs: Improve handling of extents in bch2_trans_update()
      bcachefs: btree_iter_live()
      bcachefs: Delete some dead code
      bcachefs: btree_iter_prev_slot()
      bcachefs: Use bch2_bpos_to_text() more consistently
      bcachefs: Fix bpos_diff()
      bcachefs: Fix compat code for superblock
      bcachefs: Simplify for_each_btree_key()
      bcachefs: Simplify bch2_btree_iter_peek_prev()
      bcachefs: __bch2_trans_get_iter() refactoring, BTREE_ITER_NOT_EXTENTS
      bcachefs: Fix locking in bch2_btree_iter_traverse_cached()
      bcachefs: Have fsck check for stripe pointers matching stripe
      bcachefs: Use __bch2_trans_do() in a few more places
      bcachefs: Kill ei_str_hash
      bcachefs: Consolidate bch2_read_retry and bch2_read()
      bcachefs: Fix read retry path for indirect extents
      bcachefs: Kill reflink option
      bcachefs: Fix a btree iterator leak
      bcachefs: Kill btree_iter_pos_changed()
      bcachefs: Add a print statement for when we go read-write
      bcachefs: Don't list non journal devs in journal_debug_to_text()
      bcachefs: Fix btree iterator leak in extent_handle_overwrites()
      bcachefs: Fsck code refactoring
      bcachefs: btree_iter_set_dontneed()
      bcachefs: Require all btree iterators to be freed
      bcachefs: Assert that iterators aren't being double freed
      bcachefs: Kill bkey ops->debugcheck method
      bcachefs: Don't overwrite snapshot field in bch2_cut_back()
      bcachefs: Validate bset version field against sb version fields
      bcachefs: Don't unconditially version_upgrade in initialize
      bcachefs: Fix iterator picking
      bcachefs: Optimize bch2_btree_iter_verify_level()
      bcachefs: Switch extent_handle_overwrites() to one key at a time
      bcachefs: Get disk reservation when overwriting data in old snapshot
      bcachefs: Replace bch2_btree_iter_next() calls with bch2_btree_iter_advance
      bcachefs: Have btree_iter_next_node() use btree_iter_set_search_pos()
      bcachefs: Iterators are now always consistent with iter->real_pos
      bcachefs: Kill btree_iter_peek_uptodate()
      bcachefs: Internal btree iterator renaming
      bcachefs: Improve iter->real_pos handling
      bcachefs: Consolidate bch2_btree_iter_peek() and peek_with_updates()
      bcachefs: Update iter->real_pos lazily
      bcachefs: Include snapshot field in bch2_bpos_to_text
      bcachefs: Add an .invalid method for bch2_btree_ptr_v2
      bcachefs: Improve inode deletion code
      bcachefs: Split btree_iter_traverse and bch2_btree_iter_traverse()
      bcachefs: Use pcpu mode of six locks for interior nodes
      bcachefs: Increase default journal size
      bcachefs: Drop bkey noops
      bcachefs: Generate better bkey formats when splitting nodes
      bcachefs: Fix building of aux search trees
      bcachefs: Fix packed bkey format calculation for new btree roots
      bcachefs: Fix for bch2_trans_commit() unlocking when it's not supposed to
      bcachefs: Simplify btree_node_iter_init_pack_failed()
      bcachefs: btree key cache locking improvements
      bcachefs: Add a mechanism for running callbacks at trans commit time
      bcachefs: Split out bpos_cmp() and bkey_cmp()
      bcachefs: Start using bpos.snapshot field
      bcachefs: Inode backpointers
      bcachefs: Change inode allocation code for snapshots
      bcachefs: Don't use bch2_inode_find_by_inum() in move.c
      bcachefs: Have journal reclaim thread flush more aggressively
      bcachefs: Free iterator in bch2_btree_delete_range_trans()
      bcachefs: Add repair code for out of order keys in a btree node.
      buckets.c fixups XXX squash
      bcachefs: Don't make foreground writes wait behind journal reclaim too long
      bcachefs: Move btree lock debugging to slowpath fn
      bcachefs: Improve bch2_trans_relock()
      bcachefs: Add a sysfs var for average btree write size
      bcachefs: Improve bch2_btree_update_start()
      bcachefs: Change where merging of interior btree nodes is trigger from
      bcachefs: Kill bch2_btree_node_get_sibling()
      bcachefs: bch2_foreground_maybe_merge() now correctly reports lock restarts
      bcachefs: Move btree node merging to before transaction commit
      bcachefs: Drop trans->nounlock
      bcachefs: Fix BTREE_FOREGROUND_MERGE_HYSTERESIS
      bcachefs: Increase commality between BTREE_ITER_NODES and BTREE_ITER_KEYS
      bcachefs: Fix this_cpu_ptr() usage
      bcachefs: Fix journal deadlock
      bcachefs: Be more careful about JOURNAL_RES_GET_RESERVED
      bcachefs: Fix livelock calling bch2_mark_bkey_replicas()
      bcachefs: Kill bch2_fs_usage_scratch_get()
      bcachefs: Drop some memset() calls
      bcachefs: Eliminate memory barrier from fast path of journal_preres_put()
      bcachefs: kill bset_tree->max_key
      bcachefs: Fix an uninitialized variable
      bcachefs: Fix a startup race
      bcachefs: Increase BSET_CACHELINE to 256 bytes
      bcachefs: Eliminate more PAGE_SIZE uses
      bcachefs: Don't flush btree writes more aggressively because of btree key cache
      bcachefs: Improve bset compaction
      bcachefs: Move some dirent checks to bch2_dirent_invalid()
      bcachefs: Drop bch2_fsck_inode_nlink()
      bcachefs: Don't wait for ALLOC_SCAN_BATCH buckets in allocator
      bcachefs: Make sure to kick journal reclaim when we're waiting on it
      bcachefs: Fix bch2_gc_btree_gens()
      bcachefs: Fix BTREE_ITER_NOT_EXTENTS
      bcachefs: Check inodes at start of fsck
      bcachefs: Simplify hash table checks
      bcachefs: Inode backpointers are now required
      bcachefs: Redo check_nlink fsck pass
      bcachefs: Fix bch2_trans_relock()
      bcachefs: Fix fsck to not use bch2_link_trans()
      bcachefs: Improved check_directory_structure()
      bcachefs: BCH_BEATURE_atomic_nlink is obsolete
      bcachefs: Fix heap overrun in bch2_fs_usage_read() XXX squash
      bcachefs: Add the status of bucket gen gc to sysfs
      bcachefs: Ensure bucket gen gc completes
      bcachefs: Add a perf test for multiple updates per commit
      bcachefs: Drop old style btree node coalescing
      bcachefs: Better iterator picking
      bcachefs: Don't call bch2_btree_iter_traverse() unnecessarily
      bcachefs: Fix bch2_gc_done() error messages
      bcachefs: Fix journal_reclaim_wait_done()
      bcachefs: Improve bch2_btree_iter_traverse_all()
      bcachefs: Don't downgrade iterators in bch2_trans_get_iter()
      bcachefs: Improve trans_restart_mem_realloced tracepoint
      bcachefs: Fix bch2_trans_mark_dev_sb()
      bcachefs: Simplify bch2_set_nr_journal_buckets()
      bcachefs: Fix an RCU splat
      bcachefs: Fix journal reclaim loop
      bcachefs: Fix transaction restarts due to upgrading of cloned iterators
      bcachefs: Simplify fsck remove_dirent()
      bcachefs: Fix some small memory leaks
      bcachefs: Fix an unused var warning in userspace
      bcachefs: Refactor bchfs_fallocate() to not nest btree_trans on stack
      bcachefs: gc shouldn't care about owned_by_allocator
      bcachefs: Allocator thread doesn't need gc_lock anymore
      bcachefs: Handle errors in bch2_trans_mark_update()
      bcachefs: Check that keys are in the correct btrees
      bcachefs: Always check for invalid bkeys in trans commit path
      bcachefs: Allocator refactoring
      bcachefs: Preallocate trans mem in bch2_migrate_index_update()
      bcachefs: Fix for btree_gc repairing interior btree ptrs
      bcachefs: Fix a use after free
      bcachefs: Punt btree writes to workqueue to submit
      bcachefs: Fix two btree iterator leaks
      bcachefs: Update bch2_btree_verify()
      bcachefs: Fix a deadlock on journal reclaim
      bcachefs: Don't BUG() in update_replicas
      bcachefs: Lookup/create lost+found lazily
      bcachefs: Fix repair leading to replicas not marked
      bcachefs: Don't BUG_ON() btree topology error
      bcachefs: Use mmap() instead of vmalloc_exec() in userspace
      bcachefs: Fix an out of bounds read
      bcachefs: Fix bch2_verify_keylist_sorted
      bcachefs: Rewrite btree nodes with errors
      bcachefs: New helper __bch2_btree_insert_keys_interior()
      bcachefs: Fix key cache assertion
      bcachefs: New and improved topology repair code
      bcachefs: Fix a null ptr deref
      bcachefs: New check_nlinks algorithm for snapshots
      bcachefs: Evict btree nodes we're deleting
      bcachefs: Fix __bch2_trans_get_iter()
      bcachefs: New tracepoint for bch2_trans_get_iter()
      bcachefs: Call bch2_inconsistent_error() on missing stripe/indirect extent
      bcachefs: Change bch2_btree_key_cache_count() to exclude dirty keys
      bcachefs: Change copygc wait amount to be min of per device waits
      bcachefs: Ensure that fpunch updates inode timestamps
      bcachefs: Make sure to initialize j->last_flushed
      bcachefs: Add a tracepoint for when we block on journal reclaim
      bcachefs: Fix time handling
      bcachefs: Mark newly allocated btree nodes as accessed
      bcachefs: Clean up bch2_btree_and_journal_walk()
      bcachefs: Fix usage of last_seq + encryption
      bcachefs: Fix some refcounting bugs
      bcachefs: Fix reflink trigger
      bcachefs: Fix bch2_btree_iter_peek_with_updates()
      bcachefs: Make sure to use BTREE_ITER_PREFETCH in fsck
      bcachefs: Repair code for multiple types of data in same bucket
      bcachefs: Fix locking in __bch2_set_nr_journal_buckets()
      bcachefs: Make sure to pass a disk reservation to bch2_extent_update()
      bcachefs: Fix bch2_extent_can_insert() call
      bcachefs: Fix a memcpy call
      bcachefs: Fix for bch2_bkey_pack_pos() not initializing len/version fields
      bcachefs: Ratelimiting for writeback IOs
      bcachefs: Split extents if necessary in bch2_trans_update()
      bcachefs: Make bch2_remap_range respect O_SYNC
      bcachefs: Fix inode backpointers in RENAME_OVERWRITE
      bcachefs: Fix for buffered writes getting -ENOSPC
      bcachefs: Fix an uninitialized var
      bcachefs: Don't repair btree nodes until after interior journal replay is done
      bcachefs: Add a debug mode that always reads from every btree replica
      bcachefs: Add a workqueue for btree io completions
      bcachefs: Improve FS_IOC_GOINGDOWN ioctl
      bcachefs: Fix an issue with inconsistent btree writes after unclean shutdown
      bcachefs: Fix a null ptr deref
      bcachefs: Add a cond_resched call to the copygc main loop
      bcachefs: Add a tracepoint for copygc waiting
      bcachefs: Don't use uuid in tracepoints
      bcachefs: Inline fastpath of bch2_disk_reservation_add()
      bcachefs: Kill bch_write_op.index_update_fn
      bcachefs: Don't use bch_write_op->cl for delivering completions
      bcachefs: Add an option to control sharding new inode numbers
      bcachefs: Reflink refcount fix
      bcachefs: Fix journal write error path
      bcachefs: Fix pathalogical behaviour with inode sharding by cpu ID
      bcachefs: Split out btree_error_wq
      bcachefs: Fix a deadlock
      bcachefs: Assorted endianness fixes
      bcachefs: Fsck for reflink refcounts
      bcachefs: Don't fragment extents when making them indirect
      bcachefs: Journal space calculation fix
      bcachefs; Check for allocator thread shutdown
      bcachefs: Check for errors from bch2_trans_update()
      bcachefs: Preallocate transaction mem
      bcachefs: Improve btree iterator tracepoints
      bcachefs: btree_iter->should_be_locked
      bcachefs: Fix a spurious debug mode assertion
      bcachefs: Don't mark superblocks past end of usable space
      bcachefs: Fix a buffer overrun
      bcachefs: More topology repair code
      bcachefs: Drop all btree locks when submitting btree node reads
      bcachefs: Child btree iterators
      bcachefs: BTREE_ITER_WITH_UPDATES
      bcachefs: bch2_btree_iter_peek_slot() now supports BTREE_ITER_WITH_UPDATES
      bcachefs: Kill __bch2_btree_iter_peek_slot_extents()
      bcachefs: bch2_btree_iter_peek_slot() now saves initial position when searching
      bcachefs: Move extent_handle_overwrites() to bch2_trans_update()
      bcachefs: Simplify reflink trigger
      bcachefs: Kill trans->updates2
      bcachefs: Clean up key merging
      bcachefs: Refactor extent_handle_overwrites()
      bcachefs: Re-implement extent merging in transaction commit path
      bcachefs: Improved extent merging
      bcachefs: Merging for indirect extents
      bcachefs: Always zero memory from bch2_trans_kmalloc()
      bcachefs: Fix overflow in journal_replay_entry_early
      bcachefs: Fix null ptr deref when splitting compressed extents
      bcachefs: Allow shorter JSET_ENTRY_dev_usage entries
      bcachefs: Kill bch2_btree_iter_peek_cached()
      bcachefs: Don't underflow c->sectors_available
      bcachefs: Clear iter->should_be_locked in bch2_trans_reset
      bcachefs: Fix a memory leak in dio write path
      bcachefs: Make sure bch2_trans_mark_update uses correct iter flags
      bcachefs: Kill __btree_delete_at()
      bcachefs: Improve iter->should_be_locked
      bcachefs: fix truncate with ATTR_MODE
      bcachefs: Extensive triggers cleanups
      bcachefs: Don't disable preemption unnecessarily
      bcachefs: Don't ratelimit certain fsck errors
      bcachefs: Don't loop into topology repair
      bcachefs: Fix btree_node_read_all_replicas() error handling
      bcachefs: Use memalloc_nofs_save() in bch2_read_endio()
      bcachefs: Fix shift-by-64 in bch2_bkey_format_validate()
      bcachefs: Fix bch2_btree_iter_peek_prev()
      bcachefs: Split out SPOS_MAX
      bcachefs: Fix bch2_btree_iter_peek_slot() assertion
      bcachefs: bch2_d_types[]
      bcachefs: BTREE_UPDATE_INTERNAL_SNAPSHOT_NODE
      bcachefs: Regularize argument passing of btree_trans
      bcachefs: Really don't hold btree locks while btree IOs are in flight
      bcachefs: Mask out unknown compat features when going read-write
      bcachefs: Kick off btree node writes from write completions
      bcachefs: Ensure bad d_type doesn't oops in bch2_dirent_to_text()
      bcachefs: Add open_buckets to sysfs
      bcachefs: Add safe versions of varint encode/decode
      bcachefs: Fix an allocator shutdown deadlock
      bcachefs: Add an option for whether inodes use the key cache
      bcachefs: Fix a memory leak in the dio write path
      bcachefs: Tighten up btree_iter locking assertions
      bcachefs: Improvements to fsck check_dirents()
      bcachefs: Fix bch2_btree_iter_rewind()
      bcachefs: Fixes for unit tests
      bcachefs: Improve btree_bad_header() error message
      bcachefs: Update btree ptrs after every write
      Revert "bcachefs: statfs bfree and bavail should be the same"
      bcachefs: BSET_OFFSET()
      bcachefs: Don't downgrade in traverse()
      bcachefs: Handle lock restarts in bch2_xattr_get()
      bcachefs: Use bch2_inode_find_by_inum() in truncate
      bcachefs: Don't squash return code in check_dirents()
      bcachefs: Pretty-ify bch2_bkey_val_to_text()
      bcachefs: Fix a btree iterator leak
      bcachefs: Use bch2_trans_do() in bch2_btree_key_cache_journal_flush()
      bcachefs: bch2_btree_iter_relock_intent()
      bcachefs: Minor tracepoint improvements
      bcachefs: Add an option for btree node mem ptr optimization
      bcachefs: Don't traverse iterators in __bch2_trans_commit()
      bcachefs: bch2_trans_relock() only relocks iters that should be locked
      bcachefs: traverse_all() is responsible for clearing should_be_locked
      bcachefs: Always check for transaction restarts
      bcachefs: Use bch2_trans_begin() more consistently
      bcachefs: Clean up interior update paths
      bcachefs: Change lockrestart_do() to always call bch2_trans_begin()
      bcachefs: trans->restarted
      bcachefs: bch2_btree_iter_traverse() shouldn't normally call traverse_all()
      bcachefs: Ensure btree_iter_traverse() obeys iter->should_be_locked
      bcachefs: __bch2_trans_commit() no longer calls bch2_trans_reset()
      bcachefs: Btree splits no longer automatically cause a transaction restart
      bcachefs: Kill BTREE_INSERT_NOUNLOCK
      bcachefs: traverse_all() shouldn't be restarting the transaction
      bcachefs: Don't drop read locks at transaction commit time
      bcachefs: Zero out mem_ptr field in btree ptr keys from journal replay
      bcachefs: Keep a sorted list of btree iterators
      bcachefs: Add flags field to bch2_inode_to_text()
      bcachefs: Ensure that new inodes hit underlying btree
      bcachefs: Fix an unhandled transaction restart
      bcachefs: Fix btree_trans_peek_updates()
      bcachefs: Minor btree iter refactoring
      bcachefs: Fix a valgrind conditional jump
      bcachefs: Disk space accounting fix
      bcachefs: Be sure to check ptr->dev in copygc pred function
      bcachefs: Fix unhandled transaction restart in bch2_gc_btree_gens()
      bcachefs: Free iterator if we have duplicate
      bcachefs: Add SPOS_MAX to bpos_to_text()
      bcachefs: Ensure iter->real_pos is consistent with key returned
      bcachefs: bch2_dump_trans_iters_updates()
      bcachefs: Reduce iter->trans usage
      bcachefs: Refactor bch2_trans_update_extent()
      bcachefs: Kill BTREE_ITER_SET_POS_AFTER_COMMIT
      bcachefs: Better algorithm for btree node merging in write path
      bcachefs: Further reduce iter->trans usage
      bcachefs: Clean up/rename bch2_trans_node_* fns
      bcachefs: More renaming
      bcachefs: Prefer using btree_insert_entry to btree_iter
      bcachefs: Kill BTREE_ITER_NEED_PEEK
      bcachefs: Kill BTREE_ITER_NODES
      bcachefs: Add an assertion for removing btree nodes from cache
      bcachefs: Improve an error message
      bcachefs: Fix initialization of bch_write_op.nonce
      bcachefs: btree_path
      bcachefs: Kill bpos_diff() XXX check for perf regression
      bcachefs: Add more assertions for locking btree iterators out of order
      bcachefs: Extent btree iterators are no longer special
      bcachefs: Tighten up btree locking invariants
      bcachefs: Drop some fast path tracepoints
      bcachefs: Kill retry loop in btree merge path
      bcachefs: No need to clone iterators for update
      bcachefs: Enabled shard_inode_numbers by default
      bcachefs: Add a missing btree_path_make_mut() call
      bcachefs: Optimize btree lookups in write path
      bcachefs: Consolidate intent lock code in btree_path_up_until_good_node
      bcachefs: normalize_read_intent_locks
      bcachefs: Better approach to write vs. read lock deadlocks
      bcachefs: Add missing BTREE_ITER_INTENT
      bcachefs: Fix some compiler warnings
      bcachefs: Add a missing bch2_trans_relock() call
      bcachefs: Improve btree_node_mem_ptr optimization
      Revert "bcachefs: Add more assertions for locking btree iterators out of order"
      bcachefs: Disable quota support
      bcachefs: Subvolumes, snapshots
      bcachefs: Add support for dirents that point to subvolumes
      bcachefs: Per subvolume lost+found
      bcachefs: Add subvolume to ei_inode_info
      bcachefs: BTREE_ITER_FILTER_SNAPSHOTS
      bcachefs: Plumb through subvolume id
      bcachefs: Update fsck for snapshots
      bcachefs: Convert io paths for snapshots
      bcachefs: Whiteouts for snapshots
      bcachefs: Update data move path for snapshots
      bcachefs: Fix unit & perf tests for snapshots
      bcachefs: Require snapshot id to be set
      bcachefs: Snapshot creation, deletion
      bcachefs: Fix an assertion
      bcachefs: Rev the on disk format version for snapshots
      bcachefs: Fix check_inode_update_hardlinks()
      bcachefs: Fix a spurious fsck error
      bcachefs: Fix allocator shutdown error message
      bcachefs: bch2_subvolume_get()
      bcachefs: Fix bch2_dev_remove_alloc()
      bcachefs: Ensure btree_path consistent with node iterators
      bcachefs: More btree iterator fixes
      bcachefs: Fixes for usrdata/metadata drop paths
      bcachefs: Fix bch2_move_btree()
      bcachefs: Fix a pcpu var splat
      bcachefs: Snapshot deletion fix
      bcachefs: Fix rereplicate_pred()
      bcachefs: Fix deletion in __bch2_dev_usrdata_drop()
      bcachefs: Fix implementation of KEY_TYPE_error
      bcachefs: Don't allocate too-big bios
      bcachefs: Improve bch2_dump_trans_paths_updates()
      bcachefs: Fix __bch2_dirent_read_target()
      bcachefs: Zero out reflink_p val in bch2_make_extent_indirect()
      bcachefs: Fix a cache coherency bug in bch2_subvolume_create()
      bcachefs: Fix check_path() across subvolumes
      bcachefs: Improve reflink repair code
      bcachefs: for_each_btree_node() now returns errors directly
      bcachefs: bch2_trans_exit() no longer returns errors
      bcachefs: Handle transaction restarts in bch2_blacklist_entries_gc()
      bcachefs: New on disk format to fix reflink_p pointers
      bcachefs: Fix for leaking of reflinked extents
      bcachefs: Fix check_path() for snapshots
      bcachefs: Delete dentry when deleting snapshots
      bcachefs: cached data shouldn't prevent fs from mounting
      bcachefs: Fix restart handling in for_each_btree_key()
      bcachefs: Subvol dirents are now only visible in parent subvol
      bcachefs: Fix error handling in bch2_trans_extent_merging
      bcachefs: Fix a transaction path overflow
      bcachefs: Fix dev accounting after device add
      bcachefs: Must check for errors from bch2_trans_cond_resched()
      bcachefs: Fix bch2_btree_iter_next_node()
      bcachefs: bch2_btree_node_rewrite() now returns transaction restarts
      bcachefs: Ensure we flush btree updates in evacuate path
      bcachefs: Fix fsck path for refink pointers
      bcachefs: More general fix for transaction paths overflow
      bcachefs: Don't run triggers in fix_reflink_p_key()
      bcachefs: Improve error messages in trans_mark_reflink_p()
      bcachefs: Add BCH_SUBVOLUME_UNLINKED
      bcachefs: Drop bch2_journal_meta() call when going RW
      bcachefs: Don't do upgrades in nochanges mode
      bcachefs: Move bch2_evict_subvolume_inodes() to fs.c
      bcachefs: Fix bch2_btree_iter_advance()
      bcachefs: Improve transaction restart handling in fsck code
      bcachefs: Ensure journal doesn't get stuck in nochanges mode
      bcachefs: Fix bch2_mark_update()
      bcachefs: Assorted ec fixes
      bcachefs: Convert bch2_mark_key() to take a btree_trans *
      bcachefs: BTREE_TRIGGER_INSERT now only means insert
      bcachefs: Fix faulty assertion
      bcachefs: Fix upgrade_readers()
      bcachefs: Fix trans_lock_write()
      bcachefs: Improve error message in bch2_write_super()
      bcachefs: Fix check_inodes()
      bcachefs: Fix __remove_dirent()
      bcachefs: BTREE_UPDATE_NOJOURNAL
      bcachefs: Update inode on every write
      bcachefs: Add journal_seq to inode & alloc keys
      bcachefs: Kill journal buf bloom filter
      bcachefs: Kill bucket quantiles sysfs code
      bcachefs: Switch fsync to use bi_journal_seq
      bcachefs: Fix upgrade path for reflink_p fix
      bcachefs: Clean up error reporting in the startup path
      bcachefs: path->should_be_locked fixes
      bcachefs: bch2_assert_pos_locked()
      bcachefs: Refactor bch2_fpunch_at()
      bcachefs: Fallocate fixes
      bcachefs: Inode updates should generally be BTREE_INSERT_NOFAIL
      bcachefs: Don't check for -ENOSPC in page writeback
      bcachefs: Fix infinite loop in bch2_btree_cache_scan()
      bcachefs: Fix an exiting of uninitialized iterator
      bcachefs: Tweak vfs cache shrinker behaviour
      bcachefs: More enum strings
      bcachefs: Improve bch2_reflink_p_to_text()
      bcachefs: Convert journal BUG_ON() to a warning
      bcachefs: Fix missing field initialization
      bcachefs: Refactor journal replay code
      bcachefs: Update export_operations for snapshots
      bcachefs: Also log device name in userspace
      bcachefs: Disk space accounting fix on brand-new fs
      bcachefs: Run insert triggers before overwrite triggers
      bcachefs: Fix error reporting from bch2_journal_flush_seq
      bcachefs: Add a bit of missing repair code
      bcachefs: Fix BCH_FS_ERROR flag handling
      bcachefs: Fix an i_sectors accounting bug
      bcachefs: Fix i_sectors_leak in bch2_truncate_page
      bcachefs: SECTOR_DIRTY_RESERVED
      bcachefs: Fix quota support for snapshots
      bcachefs: Apply workaround for too many btree iters to read path
      bcachefs: Kill PAGE_SECTOR_SHIFT
      bcachefs: Fix page state when reading into !PageUptodate pages
      bcachefs: Fix page state after fallocate
      bcachefs: Convert bucket_alloc_ret to negative error codes
      bcachefs: Fix reflink path for snapshots
      bcachefs: Kill bch2_replicas_delta_list_marked()
      bcachefs: Push c->mark_lock usage down to where it is needed
      bcachefs: Handle replica marking fsck errors locally
      bcachefs: Erasure coding fixes
      bcachefs: Fix btree_path leaks in bch2_trans_update()
      bcachefs: Convert journal sysfs params to regular options
      bcachefs: Fix copygc sectors_to_move calculation
      bcachefs: Specify filesystem options
      bcachefs: Make __bch2_journal_debug_to_text() more readable
      bcachefs: bch2_trans_update() is now __must_check
      bcachefs: Convert a BUG_ON() to a warning
      bcachefs: Split out struct gc_stripe from struct stripe
      bcachefs: Don't erasure code cached ptrs
      bcachefs: Fix null ptr deref in fsck_inode_rm()
      bcachefs: Print out OPT_SECTORS options in bytes
      bcachefs: Add more time_stats
      bcachefs: bch2_alloc_write()
      bcachefs: Improve alloc_mem_to_key()
      bcachefs: Add missing bch2_trans_iter_exit() call
      bcachefs: Fix debug build in userspace
      bcachefs: Fix an assertion in bch2_truncate()
      bcachefs: Split out CONFIG_BCACHEFS_DEBUG_TRANSACTIONS
      bcachefs: Kill bch2_sort_repack_merge()
      bcachefs: Don't call bch2_bkey_transform() unnecessarily
      bcachefs: Kill some obsolete sysfs code
      bcachefs: Make sure bch2_bucket_alloc_new_fs() obeys buckets_nouse
      bcachefs: Optimize memory accesses in bch2_btree_node_get()
      bcachefs: Fix some shutdown path bugs
      bcachefs: BTREE_ITER_NOPRESERVE
      bcachefs: Fix debugfs -bfloat-failed
      bcachefs: Option improvements
      bcachefs: Turn encoded_extent_max into a regular option
      bcachefs: Fix a null ptr deref in bch2_inode_delete_keys()
      bcachefs: Kill non-lru cache replacement policies
      bcachefs: Rewrite bch2_bucket_alloc_new_fs()
      bcachefs: bch2_bucket_alloc_new_fs() no longer depends on bucket marks
      bcachefs: Don't start allocator threads too early
      bcachefs: Kill ptr_bucket_mark()
      bcachefs: bch2_journal_key_insert() no longer transfers ownership
      bcachefs: Fix bch2_journal_meta()
      bcachefs: Use BTREE_ITER_NOPRESERVE in bch2_btree_iter_verify_ret()
      bcachefs: Journal initialization fixes
      bcachefs: Delete some obsolete journal_seq_blacklist code
      bcachefs: bch2_alloc_sectors_append_ptrs() now takes cached flag
      bcachefs: Refactor open_bucket code
      bcachefs: Put open_buckets in a hashtable
      bcachefs: Separate out gc_bucket()
      bcachefs: New in-memory array for bucket gens
      bcachefs: Fix allocator + journal interaction
      bcachefs: Kill bch2_ec_mem_alloc()
      bcachefs: Update sysfs compression_stats for snapshots
      bcachefs: Run scan_old_btree_nodes after version upgrade
      bcachefs: Add a tracepoint for the btree cache shrinker
      bcachefs: bch2_journal_noflush_seq()
      bcachefs: Always check for bucket reuse after read
      bcachefs: Optimize bucket reuse
      bcachefs: bch2_hprint(): don't print decimal if conversion was exact
      bcachefs: Improve error messages in device add path
      bcachefs: Fix keylist size in btree_update
      bcachefs: Add an error message for copygc spinning
      bcachefs: Add iter_flags arg to bch2_btree_delete_range()
      bcachefs: Journal replay does't resort main list of keys
      bcachefs: Add error messages for memory allocation failures
      bcachefs: BCH_JSET_ENTRY_log
      bcachefs: bch2_journal_entry_to_text()
      bcachefs: Fix race between btree updates & journal replay
      bcachefs: Log what we're doing when repairing
      bcachefs: Improve error messages in superblock write path
      bcachefs: Make sure BCH_FS_FSCK_DONE gets set
      bcachefs: Tweak journal reclaim order
      bcachefs: BTREE_ITER_WITH_JOURNAL
      fixup! bcachefs: Factor out __bch2_btree_iter_set_pos()
      bcachefs: Simplify journal replay
      bcachefs: bch_dev->dev
      bcachefs: Fix an assertion
      bcachefs: Kill bch2_bset_fix_invalidated_key()
      bcachefs: Make eytzinger size parameter more conventional
      bcachefs: Use kvmalloc() for array of sorted keys in journal replay
      bcachefs: Improved superblock-related error messages
      bcachefs: Add verbose log messages for journal read
      bcachefs: Fix bch2_journal_seq_blacklist_add()
      bcachefs: Switch to __func__for recording where btree_trans was initialized
      bcachefs: BTREE_ITER_FILTER_SNAPSHOTS is selected automatically
      bcachefs: Log & error message improvements
      Revert "bcachefs: Delete some obsolete journal_seq_blacklist code"
      bcachefs: Fix an uninitialized variable
      bcachefs: Fix bch2_check_fix_ptrs()
      bcachefs: Improve path for when btree_gc needs another pass
      bcachefs: Also print out in-memory gen on stale dirty pointer
      bcachefs: New data structure for buckets waiting on journal commit
      bcachefs: Fix check_pos_snapshot_overwritten for !snapshots
      bcachefs: Rename data_op_data_progress -> data_jobs
      bcachefs: Refactor trigger code
      bcachefs: Use BTREE_INSERT_USE_RESERVE in btree_update_key()
      bcachefs: Fix an error path in bch2_snapshot_node_create()
      bcachefs: New snapshot unit test
      bcachefs: Tracepoint improvements
      bcachefs: Refactor bch2_btree_iter()
      bcachefs: iter->update_path
      bcachefs: Simplify bch2_inode_delete_keys()
      bcachefs: Handle transaction restarts in __bch2_move_data()
      bcachefs: BTREE_INSERT_LAZY_RW is only for recovery path
      bcachefs: Kill allocator short-circuit invalidate
      bcachefs: Don't use in-memory bucket array for alloc updates
      bcachefs: Ignore cached data when calculating fragmentation
      bcachefs: Delete some dead code
      bcachefs: Log message improvements
      bcachefs: Don't keep nodes in btree_reserve locked
      bcachefs: Fix freeing in bch2_dev_buckets_resize()
      bcachefs: Improve btree_key_cache_flush_pos()
      bcachefs: btree_id_cached()
      bcachefs: bch2_btree_path_set_pos()
      bcachefs: Stash a copy of key being overwritten in btree_insert_entry
      bcachefs: run_one_trigger() now checks journal keys
      bcachefs: BTREE_ITER_WITH_KEY_CACHE
      bcachefs: Btree key cache coherency
      bcachefs: Inode create no longer needs to probe key cache
      bcachefs: btree_gc no longer uses main in-memory bucket array
      bcachefs: Copygc no longer uses bucket array
      bcachefs: bch2_gc_gens() no longer uses bucket array
      bcachefs: Fix reflink repair code
      bcachefs: Small fsck fix
      bcachefs: Print a better message for mark and sweep pass
      bcachefs: Kill bch2_bkey_debugcheck
      bcachefs: Fix locking in data move path
      bcachefs: Delete redundant tracepoint
      bcachefs: Also show when blocked on write locks
      bcachefs: Fix __bch2_btree_node_lock
      bcachefs: Kill verify_not_stale()
      bcachefs: Check for stale dirty pointer before reads
      bcachefs: Fix slow tracepoints
      bcachefs: Fix __btree_path_traverse_all
      bcachefs: Improve journal_entry_btree_keys_to_text()
      bcachefs: Stale ptr cleanup is now done by gc_gens
      bcachefs: Only allocate buckets_nouse when requested
      bcachefs: Change bch2_dev_lookup() to not use lookup_bdev()
      bcachefs: Fix failure to allocate btree node in cache
      bcachefs: Check for errors from crypto_skcipher_encrypt()
      bcachefs: Store logical location of journal entries
      bcachefs: Delete some flag bits that are no longer used
      bcachefs: Change __bch2_trans_commit() to run triggers then get RW
      bcachefs: opts.read_journal_only
      bcachefs: Don't issue discards when in nochanges mode
      bcachefs: Kill bch_scnmemcpy()
      bcachefs: Add .to_text() methods for all superblock sections
      bcachefs: Fix a use after free
      bcachefs: Add tabstops to printbufs
      bcachefs: Btree key cache optimization
      bcachefs: Drop journal_write_compact()
      bcachefs: Set BTREE_NODE_SEQ() correctly in merge path
      bcachefs: Fix for journal getting stuck
      bcachefs: Revert "Ensure journal doesn't get stuck in nochanges mode"
      bcachefs: Normal update/commit path now works before going RW
      bcachefs: Improve reflink repair code
      bcachefs: Use unlikely() in err_on() macros
      bcachefs: Improve some btree node read error messages
      bcachefs: Fix 32 bit build
      bcachefs: bch2_trans_mark_key() now takes a bkey_i *
      bcachefs: Consolidate trigger code a bit
      bcachefs: Trigger code uses stashed copy of old key
      bcachefs: Run alloc triggers last
      bcachefs: Always clear should_be_locked in bch2_trans_begin()
      bcachefs: Fix bch2_journal_pins_to_text()
      bcachefs: Improve debug assertion
      bcachefs: Convert bch2_pd_controller_print_debug() to a printbuf
      bcachefs: Heap allocate printbufs
      bcachefs: Fix journal_flush_done()
      bcachefs: Fix btree path sorting
      bcachefs: Don't spin in journal reclaim
      bcachefs: Kill BCH_FS_HOLD_BTREE_WRITES
      bcachefs: Use x-macros for btree node flags
      bcachefs: Improve struct journal layout
      bcachefs: Start moving debug info from sysfs to debugfs
      bcachefs: Fix locking in btree_node_write_done()
      bcachefs: Improve btree_node_write_if_need()
      bcachefs: Kill bch2_btree_node_write_cond()
      bcachefs: Fix race leading to btree node write getting stuck
      bcachefs: Fix a memory leak
      bcachefs: Fix a use after free
      bcachefs: Delete some dead journal code
      bcachefs: Kill JOURNAL_NEED_WRITE
      bcachefs: bch2_journal_halt() now takes journal lock
      bcachefs: Drop unneeded journal pin in bch2_btree_update_start()
      bcachefs: Journal seq now incremented at entry open, not close
      bcachefs: Refactor journal code to not use unwritten_idx
      bcachefs: __journal_entry_close() never fails
      bcachefs: Finish writing journal after journal error
      bcachefs: Make bch2_btree_cache_scan() try harder
      bcachefs: Simplify parameters to bch2_btree_update_start()
      bcachefs: Refactor bch2_btree_node_mem_alloc()
      bcachefs: Fix usage of six lock's percpu mode
      bcachefs: Fix transaction path overflow in fiemap
      bcachefs: Convert bch2_sb_to_text to master option list
      bcachefs: Don't arm journal->write_work when journal entry !open
      bcachefs: Don't keep around btree_paths unnecessarily
      bcachefs: Fix pr_tab_rjust()
      bcachefs: Check for rw before setting opts via sysfs
      bcachefs: Skip periodic wakeup of journal reclaim when journal empty
      bcachefs: Revert UUID format-specifier change
      bcachefs: Use bio_iov_vecs_to_alloc()
      bcachefs: Fix dio write path with loopback dio mode
      bcachefs: Fix error handling in traverse_all()
      bcachefs: Fix lock ordering under traverse_all()
      bcachefs: Change flags param to bch2_btree_delete_range to update_flags
      bcachefs: bch2_journal_log_msg()
      bcachefs: Allocate journal buckets sequentially
      bcachefs: Add a missing wakeup
      bcachefs: Delay setting path->should_be_locked
      bcachefs: bch2_btree_iter_peek_upto()
      bcachefs: Drop !did_work path from do_btree_insert_one()
      bcachefs: bch2_trans_inconsistent()
      bcachefs: bch2_trans_updates_to_text()
      bcachefs: Revalidate pointer to old bkey val before calling mem triggers
      bcachefs: Move trigger fns to bkey_ops
      bcachefs: Fix BTREE_TRIGGER_WANTS_OLD_AND_NEW
      bcachefs: darrays
      bcachefs: Restore journal write point at startup
      bcachefs: Convert some WARN_ONs to WARN_ON_ONCE
      bcachefs: Fix large key cache keys
      bcachefs: x-macro metadata version enum
      bcachefs: Better superblock opt validation
      bcachefs: Make minimum journal_flush_delay nonzero
      bcachefs: Change journal_io.c assertion to error message
      bcachefs: Reset journal flush delay to default value if zeroed
      bcachefs: Add printf format attribute to bch2_pr_buf()
      bcachefs: Fix an unitialized var warning in userspace
      bcachefs: Heap code fix
      bcachefs: Work around a journal self-deadlock
      bcachefs: Fix error path in bch2_snapshot_set_equiv()
      bcachefs: Add a missing btree_path_set_dirty() calls
      bcachefs: btree_path_make_mut() clears should_be_locked
      bcachefs: Use darray for extra_journal_entries
      bcachefs: bch2_trans_log_msg()
      bcachefs: Improve bch2_bkey_ptrs_to_text()
      bcachefs: Move deletion of refcount=0 indirect extents to their triggers
      bcachefs: Run overwrite triggers before insert
      bcachefs: x-macroize alloc_reserve enum
      bcachefs: Fix bch2_journal_pin_set()
      bcachefs: Copygc allocations shouldn't be nowait
      bcachefs: Introduce a separate journal watermark for copygc
      bcachefs: bch2_btree_update_start() refactoring
      bcachefs: Run btree updates after write out of write_point
      bcachefs: bch_sb_field_journal_v2
      bcachefs: KEY_TYPE_set
      bcachefs: LRU btree
      bcachefs: KEY_TYPE_alloc_v4
      bcachefs: Freespace, need_discard btrees
      bcachefs: Kill allocator threads & freelists
      bcachefs: New discard implementation
      bcachefs: New bucket invalidate path
      bcachefs: Fsck for need_discard & freespace btrees
      bcachefs: bch2_dev_usage_update() no longer depends on bucket_mark
      bcachefs: Kill main in-memory bucket array
      bcachefs: Kill struct bucket_mark
      bcachefs: Fix pr_buf() calls
      bcachefs: Use crc_is_compressed()
      bcachefs: Improve read_from_stale_dirty_pointer() message
      bcachefs: Don't write partially-initialized superblocks
      bcachefs: gc mark fn fixes, cleanups
      bcachefs: Add a tracepoint for superblock writes
      bcachefs: Don't normalize to pages in btree cache shrinker
      bcachefs: Gap buffer for journal keys
      bcachefs: Convert .key_invalid methods to printbufs
      bcachefs: Silence spurious copygc err when shutting down
      bcachefs: More improvements for alloc info checks
      bcachefs: Add rw to .key_invalid()
      bcachefs: fsck: Work around transaction restarts
      bcachefs: Check for read_time == 0 in bch2_alloc_v4_invalid()
      bcachefs: Improve btree_bad_header()
      bcachefs: Move alloc assertion to .key_invalid()
      bcachefs: Use bch2_trans_inconsistent() more
      bcachefs: Topology repair fixes
      bcachefs: Add a sysfs attr for triggering discards
      bcachefs: Fold bucket_state in to BCH_DATA_TYPES()
      bcachefs: Refactor journal_keys_sort() to return an error code
      bcachefs: Use a genradix for reading journal entries
      bcachefs: Initialize ec work structs early
      bcachefs: Don't skip triggers in fcollapse()
      bcachefs: bch2_btree_delete_extent_at()
      bcachefs: Fix a few warnings on 32 bit
      bcachefs: Minor device removal fixes
      bcachefs: Don't trigger extra assertions in journal replay
      bcachefs: Fix a null ptr deref
      bcachefs: Fix CPU usage in journal read path
      bcachefs: Improve bch2_open_buckets_to_text()
      bcachefs: Use bch2_trans_inconsistent_on() in more places
      bcachefs: Ensure buckets have io_time[READ] set
      bcachefs: Improve error message when alloc key doesn't match lru entry
      bcachefs: Introduce bch2_journal_keys_peek_(upto|slot)()
      bcachefs: Improve bch2_lru_delete() error messages
      bcachefs: Fix inode_backpointer_exists()
      bcachefs: Improve error logging in fsck.c
      bcachefs: Fix for getting stuck in journal replay
      bcachefs: In fsck, pass BTREE_UPDATE_INTERNAL_SNAPSHOT_NODE when deleting dirents
      bcachefs: Kill old rebuild_replicas option
      bcachefs: Ensure sysfs show fns print a newline
      bcachefs: Go emergency RO when i_blocks underflows
      bcachefs: Improve some fsck error messages
      bcachefs: Plumb btree_id & level to trans_mark
      bcachefs: btree_update_interior.c prep for backpointers
      bcachefs: bch2_btree_iter_peek_slot() now works on interior nodes
      bcachefs: btree_path_set_level_(up|down)
      bcachefs: bch2_btree_iter_peek_all_levels()
      bcachefs: Allocate some extra room in btree_key_cache_fill()
      bcachefs: Fix hash_check_key()
      bcachefs: Shutdown path improvements
      bcachefs: Lock ordering fix
      bcachefs: Don't kick journal reclaim unless low on space
      bcachefs: Tracepoint improvements
      bcachefs: Go RW before bch2_check_lrus()
      bcachefs: Fix journal_iters_fix()
      bcachefs: Improve invalid bkey error message
      bcachefs: Fix extent merging
      bcachefs: Put btree_trans_verify_sorted() behind debug_check_iterators
      bcachefs: Delete bch_writepage
      bcachefs: LRU repair tweaks
      bcachefs: Switch to key_type_user, not logon
      bcachefs: Fix encryption path on arm
      bcachefs: Always print when doing journal replay in fsck
      bcachefs: Fix journal_keys_search() overhead
      bcachefs: Print message on btree node read retry success
      bcachefs: Fix error checking in bch2_fs_alloc()
      bcachefs: bch2_trans_reset_updates()
      bcachefs: Fix memory corruption in encryption path
      bcachefs: Add some missing error messages
      bcachefs: Refactor journal entry adding
      bcachefs: Also log overwrites in journal
      bcachefs: Fix for cmd_list_journal
      bcachefs: Fix btree_and_journal_iter
      bcachefs: Fix btree node read error path
      bcachefs: Printbuf rework
      bcachefs: Fix freespace initialization
      bcachefs: Improved human readable integer parsing
      bcachefs: Call bch2_do_invalidates() when going read write
      bcachefs: Add a persistent counter for bucket invalidation
      bcachefs: Fix btree node read retries
      bcachefs: Add a persistent counter for bucket discards
      bcachefs: Increase max size for btree_trans bump allocator
      bcachefs: Fix assertion in bch2_dev_list_add_dev()
      bcachefs: Improve an error message
      bcachefs: Improve checksum error messages
      bcachefs: Always use percpu_ref_tryget_live() on c->writes
      bcachefs: Fix refcount leak in bch2_do_invalidates()
      bcachefs: Check for extents with too many ptrs
      bcachefs: Make IO in flight by copygc/rebalance configurable
      bcachefs: btree key cache pcpu freedlist
      bcachefs: Split out dev_buckets_free()
      bcachefs: Pull out data_update.c
      bcachefs: Improve "copygc requested to run" error message
      bcachefs: Make verbose option settable at runtime
      bcachefs: Fix assertion in topology repair
      bcachefs: Always descend to leaf nodes it btree_gc
      bcachefs: Don't BUG_ON() inode link count underflow
      bcachefs: Bucket invalidate path improvements
      bcachefs: Use BTREE_INSERT_LAZY_RW in bch2_check_alloc_info()
      bcachefs: Improve bch2_check_alloc_info
      bcachefs: Fix bch2_check_alloc_key()
      bcachefs: Redo data_update interface
      bcachefs: move.c refactoring
      bcachefs: Get ref on c->writes in move.c
      bcachefs: Fix move path when move_stats == NULL
      bcachefs: Silence unimportant tracepoints
      bcachefs: Put some repair messages behind opts->verbose
      bcachefs: Silence some fsck errors when reconstructing alloc info
      bcachefs: Rename __bch2_trans_do() -> commit_do()
      bcachefs: Fix snapshot deletion
      bcachefs: Switch data_update path to snapshot_id_list
      bcachefs: fsck_inode_rm() shouldn't delete subvols
      bcachefs: Fix subvol/snapshot deleting in recovery
      bcachefs: Improve snapshots_seen
      bcachefs: Improve fsck for subvols/snapshots
      bcachefs: When fsck finds redundant snapshot keys, trigger snapshots cleanup
      bcachefs: Fix repair for extent past end of inode
      bcachefs: for_each_btree_key2()
      bcachefs: Unlock in bch2_trans_begin() if we've held locks more than 10us
      bcachefs: bch2_mark_alloc(): Do wakeups after updating usage
      bcachefs: Improve bucket_alloc_fail tracepoint
      bcachefs: Convert bch2_do_discards_work() to for_each_btree_key2()
      bcachefs: Convert bch2_dev_freespace_init() to for_each_btree_key_commit()
      bcachefs: Convert bch2_check_lrus() to for_each_btree_key_commit()
      bcachefs: Convert more quota code to for_each_btree_key2()
      bcachefs: Convert more fsck code to for_each_btree_key2()
      bcachefs: Convert bch2_gc_done() for_each_btree_key2()
      bcachefs: bch2_trans_run()
      bcachefs: Convert bch2_do_invalidates_work() to for_each_btree_key2()
      bcachefs: Convert bch2_dev_usrdata_drop() to for_each_btree_key2()
      bcachefs: Convert subvol code to for_each_btree_key_commit()
      bcachefs: Convert alloc code to for_each_btree_key_commit()
      bcachefs: Add a counter for btree_trans restarts
      bcachefs: Convert erasure coding to for_each_btree_key_commit()
      bcachefs: ec_stripe_bkey_insert() -> for_each_btree_key_norestart()
      bcachefs: Fix should_invalidate_buckets()
      bcachefs: We can handle missing btree roots for all alloc btrees
      bcachefs: Improved errcodes
      bcachefs: Use bch2_err_str() in error messages
      bcachefs: Prevent a btree iter overflow in alloc path
      bcachefs: btree_trans_too_many_iters() is now a transaction restart
      bcachefs: EINTR -> BCH_ERR_transaction_restart
      bcachefs: Inject transaction restarts in debug mode
      bcachefs: Convert fsck errors to errcode.h
      bcachefs: for_each_btree_key_reverse()
      bcachefs: Unit test updates
      bcachefs: Convert debugfs code to for_each_btree_key2()
      bcachefs: Fix check_i_sectors()
      bcachefs: bch2_bucket_alloc_trans_early -> for_each_btree_key_norestart
      bcachefs: Tighten up btree_path assertions
      bcachefs: Add an O_DIRECT option (for userspace)
      bcachefs: fsck: Fix nested transaction handling
      bcachefs: Fix not punting to worqueue when promoting
      bcachefs: Add distinct error code for key_cache_upgrade
      bcachefs: Fix bch2_btree_trans_to_text()
      bcachefs: Fix incorrectly freeing btree_path in alloc path
      bcachefs: Tracepoint improvements
      bcachefs: Improve an error message
      bcachefs: Fix missing error handling in bch2_subvolume_delete()
      bcachefs: Don't set should_be_locked on paths that aren't locked
      bcachefs: BTREE_ITER_NO_NODE -> BCH_ERR codes
      bcachefs: six_lock_counts() is now in six.c
      bcachefs: "Snapshot deletion did not run correctly" should be a fsck err
      bcachefs: Tracepoint improvements
      bcachefs: Kill BTREE_ITER_CACHED_(NOFILL|NOCREATE)
      bcachefs: Fix duplicate paths left by bch2_path_put()
      bcachefs: Fix btree_path->uptodate inconsistency
      bcachefs: Switch bch2_btree_delete_range() to bch2_trans_run()
      bcachefs: Rename lock_held_stats -> btree_transaction_stats
      bcachefs: Track the maximum btree_paths ever allocated by each transaction
      bcachefs: Print last line in debugfs/btree_transaction_stats
      bcachefs: Fix assertion in bch2_btree_key_cache_drop()
      bcachefs: Increment restart count in bch2_trans_begin()
      bcachefs: Fix bch2_fs_check_snapshots()
      bcachefs: Debugfs cleanup
      bcachefs: Add an overflow check in set_bkey_val_u64s()
      bcachefs: Always rebuild aux search trees when node boundaries change
      bcachefs: btree_path_down() optimization
      bcachefs: Add assertions for unexpected transaction restarts
      bcachefs: bch2_bkey_packed_to_binary_text()
      bcachefs: Another should_be_locked fixup
      bcachefs: Fix bch2_btree_iter_peek_slot() error path
      bcachefs: Minor transaction restart handling fix
      bcachefs: bch2_btree_delete_range_trans() now returns -BCH_ERR_transaction_restart_nested
      bcachefs: fsck: Another transaction restart handling fix
      bcachefs: Fix adding a device with a label
      bcachefs: btree_locking.c
      bcachefs: Reorganize btree_locking.[ch]
      bcachefs: Better use of locking helpers
      bcachefs: Kill nodes_intent_locked
      six locks: Improve six_lock_count
      bcachefs: Track maximum transaction memory
      bcachefs: Switch btree locking code to struct btree_bkey_cached_common
      bcachefs: Print lock counts in debugs btree_transactions
      bcachefs: Track held write locks
      bcachefs: Correctly initialize bkey_cached->lock
      bcachefs: Make more btree_paths available
      bcachefs: Improve btree_node_relock_fail tracepoint
      bcachefs: Improve trans_restart_journal_preres_get tracepoint
      bcachefs: Improve bch2_btree_node_relock()
      bcachefs: Fix bch2_btree_update_start() to return -BCH_ERR_journal_reclaim_would_deadlock
      bcachefs: Add persistent counters for all tracepoints
      six locks: Delete six_lock_pcpu_free_rcu()
      bcachefs: Don't leak lock pcpu counts memory
      bcachefs: Delete time_stats for lock contended times
      bcachefs: Mark write locks before taking lock
      bcachefs: New locking functions
      bcachefs: bch2_btree_node_lock_write_nofail()
      bcachefs: Fix six_lock_readers_add()
      bcachefs: btree_bkey_cached_common->cached
      bcachefs: Convert more locking code to btree_bkey_cached_common
      bcachefs: Refactor bkey_cached_alloc() path
      bcachefs: Fix usage of six lock's percpu mode, key cache version
      bcachefs: Avoid using btree_node_lock_nopath()
      bcachefs: Ensure intent locks are marked before taking write locks
      bcachefs: Fix redundant transaction restart
      bcachefs: Kill journal_keys->journal_seq_base
      bcachefs: Re-enable hash_redo_key()
      bcachefs: Fix sb_field_counters formatting
      bcachefs: Add a manual trigger for lock wakeups
      bcachefs: bch2_btree_path_upgrade() now emits transaction restart
      bcachefs: All held locks must be in a btree path
      bcachefs: Make an assertion more informative
      bcachefs: Errcodes can now subtype standard error codes
      bcachefs: Add private error codes for ENOSPC
      six locks: Simplify wait lists
      six locks: six_lock_waiter()
      six locks: Add start_time to six_lock_waiter
      six locks: Enable lockdep
      six locks: Fix a lost wakeup
      six locks: Wakeup now takes lock on behalf of waiter
      bcachefs: Add a debug assert
      bcachefs: Fix bch2_btree_node_upgrade()
      bcachefs: Deadlock cycle detector
      bcachefs: Print deadlock cycle in debugfs
      bcachefs: Delete old deadlock avoidance code
      bcachefs: Ensure bch2_btree_node_lock_write_nofail() never fails
      bcachefs: Kill normalize_read_intent_locks()
      bcachefs: Improve bch2_btree_trans_to_text()
      bcachefs: Fix error handling in bch2_btree_update_start()
      bcachefs: btree_update_nodes_written() needs BTREE_INSERT_USE_RESERVE
      bcachefs: Fix blocking with locks held
      bcachefs: bch2_btree_cache_scan() improvement
      bcachefs: bch2_btree_node_relock_notrace()
      bcachefs: bch2_print_string_as_lines()
      bcachefs: Improve bch2_fsck_err()
      bcachefs: btree_err() now uses bch2_print_string_as_lines()
      bcachefs: Run bch2_fs_counters_init() earlier
      bcachefs: Inline bch2_trans_kmalloc() fast path
      bcachefs: Optimize btree_path_alloc()
      bcachefs: Improve jset_validate()
      bcachefs: Inline fast path of check_pos_snapshot_overwritten()
      bcachefs; Mark __bch2_trans_iter_init as inline
      bcachefs: Improve bucket_alloc tracepoint
      bcachefs: Kill io_in_flight semaphore
      bcachefs: Break out bch2_btree_path_traverse_cached_slowpath()
      bcachefs: Factor out bch2_write_drop_io_error_ptrs()
      bcachefs: Fix bch2_btree_path_up_until_good_node()
      bcachefs: bucket_alloc_state
      bcachefs: Fix a trans path overflow in bch2_btree_delete_range_trans()
      bcachefs: Don't quash error in bch2_bucket_alloc_set_trans()
      bcachefs: Improve btree_deadlock debugfs output
      bcachefs: bch2_trans_locked()
      bcachefs: Fix a deadlock in btree_update_nodes_written()
      bcachefs: Ensure fsck error is printed before panic
      bcachefs: Fix "multiple types of data in same bucket" with ec
      bcachefs: Use btree_type_has_ptrs() more consistently
      bcachefs: Ratelimit ec error message
      bcachefs: Handle dropping pointers in data_update path
      bcachefs: Print cycle on unrecoverable deadlock
      bcachefs: Simplify break_cycle()
      bcachefs: Write new btree nodes after parent update
      bcachefs: Add error path to btree_split()
      bcachefs: bch2_btree_insert_node() no longer uses lock_write_nofail
      bcachefs: bch2_btree_iter_peek() now works with interior nodes
      bcachefs: Btree splits now only take the locks they need
      bcachefs: Fix cached data accounting
      bcachefs: bch2_path_put_nokeep()
      bcachefs: Fix a rare path in bch2_btree_path_peek_slot()
      bcachefs: Reflink now respects quotas
      bcachefs: Call bch2_btree_update_add_new_node() before dropping write lock
      bcachefs: Initialize sb_quota with default 1 week timer
      bcachefs: Don't allow hardlinks when inherited attrs would change
      bcachefs: Support FS_XFLAG_PROJINHERIT
      bcachefs: Fix lock_graph_remove_non_waiters()
      fixup bcachefs: Deadlock cycle detector
      fixup bcachefs: Deadlock cycle detector
      bcachefs: Fix bch2_write_begin()
      bcachefs: Fix for not dropping privs in fallocate
      bcachefs: Improve journal_entry_add()
      bcachefs: Defer full journal entry validation
      bcachefs: bch2_btree_key_cache_scan() doesn't need trylock
      bcachefs: Fix btree node prefetchig
      bcachefs: Btree key cache improvements
      bcachefs: Switch to local_clock() for fastpath time source
      bcachefs: Quota fixes
      bcachefs: Btree key cache shrinker fix
      bcachefs: Split out __btree_path_up_until_good_node()
      bcachefs: Optimize bch2_trans_init()
      bcachefs: bucket_alloc_fail tracepoint should only fire when we have to block
      bcachefs: Inline bch2_inode_pack()
      bcachefs: Optimize __bkey_unpack_key_format_checked()
      bcachefs: Separate out flush_new_cached_update()
      bcachefs: Don't issue transaction restart on key cache realloc
      bcachefs: Optimize bch2_dev_usage_read()
      bcachefs: Assorted checkpatch fixes
      bcachefs: Don't touch c->flags in bch2_trans_iter_init()
      bcachefs: Optimize __bch2_btree_node_iter_advance()
      bcachefs: Move bkey bkey_unpack_key() to bkey.h
      bcachefs: bch2_bkey_cmp_packed_inlined()
      bcachefs: Convert to __packed and __aligned
      bcachefs: Make error messages more uniform
      bcachefs: Fix an out-of-bounds shift
      bcachefs: Journal keys overlay fixes
      bcachefs: Fix buffered write path for generic/275
      bcachefs: Fix a spurious warning
      bcachefs: Improve fs_usage_apply_warn() message
      bcachefs: Improved btree write statistics
      bcachefs: should_compact_all()
      bcachefs: Kill BCH_WRITE_JOURNAL_SEQ_PTR
      bcachefs: More style fixes
      bcachefs: BCH_WRITE_SYNC
      bcachefs: DIO write path optimization
      bcachefs: Inlining improvements
      bcachefs: Improve __bch2_btree_path_make_mut()
      bcachefs: Kill bch2_alloc_sectors_start()
      bcachefs: bch2_trans_commit_bkey_invalid()
      bcachefs: Kill BCH_WRITE_FLUSH
      bcachefs: Factor out two_state_shared_lock
      bcachefs: Fixes for building in userspace
      bcachefs: Delete atomic_inc_bug()
      bcachefs: Fix a use after free
      bcachefs: Quota: Don't allocate memory under lock
      bcachefs: Minor dio write path improvements
      bcachefs: Fix return code from btree_path_traverse_one()
      bcachefs: Btree split improvement
      bcachefs: Fix for_each_btree_key2()
      bcachefs: Improve a few warnings
      bcachefs: Error message improvement
      bcachefs: Fix a race with b->write_type
      bcachefs: Fix a transaction path overflow
      bcachefs: Improve journal_read() logging
      bcachefs: Handle last journal write being torn
      bcachefs: Split out __bch2_btree_node_get()
      bcachefs: Move some asserts behind CONFIG_BCACHEFS_DEBUG
      bcachefs: Tiny bch2_trans_update_by_path_trace() optimization
      bcachefs: Inline bch2_bkey_format_add_key()
      bcachefs: Better inlining in bch2_subvolume_get_snapshot()
      bcachefs: Improve bch2_inode_opts_to_opts()
      bcachefs: Kill some unneeded references to c->flags
      bcachefs: More dio inlining
      bcachefs: Optimize bch2_trans_iter_init()
      bcachefs: Better inlining in bch2_time_stats_update()
      bcachefs: Kill BCH_FEATURE_incompressible
      bcachefs: Fix an include
      bcachefs: Don't set accessed bit on btree node fill
      bcachefs: Fix BCH_IOCTL_DISK_SET_STATE
      bcachefs: extents no longer require special handling for packing
      bcachefs: New magic number
      bcachefs: New bpos_cmp(), bkey_cmp() replacements
      bcachefs: Fix __btree_trans_peek_key_cache()
      bcachefs: bch2_btree_path_peek_slot_exact()
      bcachefs: Kill __btree_trans_peek_key_cache()
      bcachefs: Bring back BTREE_ITER_CACHED_NOFILL
      bcachefs: Key cache now works for snapshots btrees
      bcachefs: Fix a livelock in key cache fill path
      bcachefs: Don't error out when just reading the journal
      bcachefs: Fix a "no journal entries found" bug
      bcachefs: Simplify journal read path
      bcachefs: Fix a btree iter assertion pop
      bcachefs: Kill btree_insert_ret enum
      bcachefs: Fix bch2_journal_keys_peek_upto()
      bcachefs: Add a missing bch2_btree_path_traverse() call
      bcachefs: Suppress -EROFS messages when shutting down
      bcachefs: More errcode cleanup
      bcachefs: bkey_min(), bkey_max()
      bcachefs: bch2_trans_revalidate_updates_in_node()
      bcachefs: Fix error path in bch2_trans_commit_write_locked()
      bcachefs: Fix btree_gc when multiple passes required
      bcachefs: Recover from blacklisted journal entries
      bcachefs: Allow for more btrees
      bcachefs: New btree helpers
      bcachefs: Add some unlikely() annotations
      bcachefs: Add a missing bch2_err_str() call
      bcachefs: Fix for long running btree transactions & key cache
      bcachefs: Fix bch2_journal_flush_device_pins()
      bcachefs: Be less restrictive when validating journal overwrite entries
      bcachefs: Fix some memcpy() warnings
      bcachefs: bch2_btree_trans_to_text(): print blocked time
      bcachefs: Log more messages in the journal
      bcachefs: Make log message at startup a bit cleaner
      bcachefs: fix fsck error
      bcachefs: Convert btree_err() to a function
      bcachefs: Plumb saw_error through to btree_err()
      bcachefs: Kill bch2_extent_trim_atomic() usage
      bcachefs: Delete a faulty assertion
      bcachefs: Fix bch2_btree_path_traverse_all()
      bcachefs: Improve bkey_cached_lock_for_evict()
      bcachefs: key cache: Don't hold btree locks while using GFP_RECLAIM
      bcachefs: btree_iter->ip_allocated
      bcachefs: bch2_trans_relock_notrace()
      bcachefs: Fix compat path for old inode formats
      bcachefs: Convert EROFS errors to private error codes
      bcachefs: Convert EAGAIN errors to private error codes
      bcachefs: debug: Fix some locking bugs
      bcachefs: Kill fs_usage_apply_warn()
      bcachefs: Dump transaction updates before panicing
      bcachefs: Fix repair path in bch2_mark_reflink_p()
      bcachefs: Fix rereplicate when we already have a cached pointer
      bcachefs: Check for lru entries with time=0
      bcachefs: Fix bch2_bucket_alloc_early()
      bcachefs: Improve btree_reserve_get_fail tracepoint
      bcachefs: Better inlining for bch2_alloc_to_v4_mut
      bcachefs: Better inlining in core write path
      bcachefs: Fix bch_alloc_to_text()
      bcachefs: bch2_inode_opts_get()
      bcachefs: Use trylock in bch2_prt_backtrace()
      bcachefs: Don't emit tracepoints for expected events
      bcachefs: Fix hash_check_key()
      bcachefs: Inline bch2_btree_path_traverse() fastpath
      bcachefs: Fix bch2_trans_reset_updates()
      bcachefs: Improve btree node read error path
      bcachefs: bch2_trans_in_restart_error()
      six locks: Expose tracepoint IP
      bcachefs: Use six_lock_ip()
      six locks: Improved optimistic spinning
      bcachefs: Don't call bch2_journal_pin_drop() under key cache lock
      bcachefs: Use for_each_btree_key_upto() more consistently
      bcachefs: Fix btree_path_alloc()
      bcachefs: Switch a BUG_ON() to a panic()
      bcachefs: Fix btree_node_write_blocked() not being cleared
      bcachefs: ec_stripe_delete_work() now takes ref on c->writes
      bcachefs: Debug mode for c->writes references
      bcachefs: trans->notrace_relock_fail
      bcachefs: Kill trans->flags
      bcachefs: Start copygc when first going read-write
      bcachefs: Go RW before check_alloc_info()
      bcachefs: Btree write buffer
      bcachefs: New on disk format: Backpointers
      bcachefs: Copygc now uses backpointers
      bcachefs: Erasure coding now uses backpointers
      bcachefs: Delete in memory ec backpointers
      bcachefs: Don't stop copygc while removing devices
      bcachefs: Run bch2_check_backpointers_to_extents() in multiple passes if necessary
      bcachefs: Run check_extents_to_backpointers() in multiple passes
      bcachefs: Don't use key cache during fsck
      fixup bcachefs: New on disk format: Backpointers
      bcachefs: Improve bch2_dev_freespace_init()
      bcachefs: Improve bch2_check_alloc_info()
      bcachefs: Start snapshots before bch2_gc()
      bcachefs: KEY_TYPE_inode_v3, metadata_version_inode_v3
      bcachefs: Drop old maybe_extending optimization
      bcachefs: Skip inode unpack/pack in bch2_extent_update()
      bcachefs: bch2_extent_fallocate()
      bcachefs: bch2_extent_update_i_size_sectors()
      bcachefs: Unwritten extents support
      bcachefs: Data update support for unwritten extents
      bcachefs: Nocow support
      bcachefs: Inline bch2_two_state_(trylock|unlock)
      bcachefs: bucket_gens btree
      bcachefs: Improved nocow locking
      bcachefs: Rework lru btree
      bcachefs: Change bkey_invalid() rw param to flags
      bcachefs: BKEY_INVALID_FROM_JOURNAL
      bcachefs: Fix deadlock on nocow locks in data move path
      bcachefs: Fix move_ctxt_wait_event()
      bcachefs: Improve invalidate_one_bucket() error messages
      bcachefs: Fix promote path leak
      bcachefs: Add an assert to bch2_bucket_nocow_unlock()
      bcachefs: Add max nr of IOs in flight to the move path
      bcachefs: Ensure btree node cache is not more than half dirty
      bcachefs: Add some logging for btree node rewrites due to errors
      bcachefs: Nocow locking fixup
      bcachefs: Handle btree node rewrites before going RW
      bcachefs: Add missing include
      bcachefs: More info on check_bucket_ref() error
      bcachefs: Improve locking in __bch2_set_nr_journal_buckets()
      bcachefs: Fix failure to read btree roots
      bcachefs: Handle sb buffer resizing in __copy_super()
      bcachefs: Fix verify_bucket_evacuated()
      bcachefs: New backtrace utility code
      bcachefs: Fix verify_update_old_key()
      six locks: Simplify six_lock_counts()
      bcachefs: Fix a 64 bit divide
      bcachefs: bch2_btree_insert_nonextent()
      bcachefs: Don't print out duplicate fsck errors
      bcachefs: Snapshot whiteout fix
      bcachefs: bch2_mark_snapshot() now called like other triggers
      bcachefs: Fix insert_snapshot_whiteouts()
      bcachefs: Fix integer overflow warnings on 32 bit
      bcachefs: Use btree write buffer for LRU btree
      bcachefs: Fragmentation LRU
      bcachefs: Don't invalidate open buckets
      bcachefs: Erasure coding now uses bch2_bucket_alloc_trans
      bcachefs: Add an assertion for using multiple btree_trans
      bcachefs: Don't block on ec_stripe_head_lock with btree locks held
      bcachefs: Fix erasure coding locking
      bcachefs: Split trans->last_begin_ip and trans->last_restarted_ip
      bcachefs: Switch ec_stripes_heap_lock to a mutex
      bcachefs: Improve c->writes refcounting for stripe create path
      bcachefs: Stripe deletion now checks what it's deleting
      bcachefs: Erasure coding: Track open stripes
      bcachefs: Simplify ec stripes heap
      bcachefs: Fix ec repair code check
      bcachefs: bch2_journal_entries_postprocess()
      bcachefs: Improve a verbose log message
      bcachefs: __bch2_btree_insert uses BTREE_INSERT_CACHED
      bcachefs: Add tracepoint & counter for btree split race
      bcachefs: Kill bch2_keylist_add_in_order()
      bcachefs: Cached pointers should not be erasure coded
      bcachefs: Check for redundant ec entries/stripe ptrs
      bcachefs: Fix buffer overrun in ec_stripe_update_extent()
      bcachefs: Fix erasure coding shutdown path
      bcachefs: get_stripe_key_trans()
      bcachefs: Don't call bch2_trans_update() unlocked
      bcachefs: Make bucket_alloc tracepoint more readable
      bcachefs: Add option for completely disabling nocow
      bcachefs: Improve bch2_stripe_to_text()
      bcachefs: Single open_bucket_partial list
      bcachefs: Fix for shared paths in write buffer flush
      bcachefs: Flush write buffer as needed in backpointers repair
      bcachefs: bch2_data_update_index_update() -> bch2_trans_run()
      bcachefs: ec: zero_out_rest_of_ec_bucket()
      bcachefs: bch2_btree_iter_peek_and_restart_outlined()
      bcachefs: Convert constants to consts
      bcachefs: ec: Ensure new stripe is closed in error path
      bcachefs: bch2_data_update_init() considers ptr durability
      bcachefs: bch2_open_bucket_to_text()
      bcachefs: ec: Improve error message for btree node in stripe
      bcachefs: bch2_write_queue()
      bcachefs: bch2_mark_key() now takes btree_id & level
      bcachefs: bch2_copygc_wait_to_text()
      bcachefs: Improve dev_alloc_debug_to_text()
      bcachefs: Plumb btree_trans through btree cache code
      bcachefs: Centralize btree node lock initialization
      bcachefs: Mark stripe buckets with correct data type
      bcachefs: Plumb alloc_reserve through stripe create path
      bcachefs: More stripe create cleanup/fixes
      bcachefs: Improve error message for stripe block sector counts wrong
      bcachefs: RESERVE_stripe
      bcachefs: moving_context->stats is allowed to be NULL
      bcachefs: BKEY_PADDED_ONSTACK()
      bcachefs: Drop some anonymous structs, unions
      bcachefs: Fix stripe reuse path
      bcachefs: Free move buffers as early as possible
      bcachefs: Improved copygc pipelining
      bcachefs: Improve bch2_new_stripes_to_text()
      bcachefs: Kill bch2_ec_bucket_written()
      bcachefs: Fix "btree node in stripe" error
      bcachefs: bch2_btree_node_to_text() const correctness
      bcachefs: bch2_btree_node_ondisk_to_text()
      bcachefs: bch2_btree_iter_peek_node_and_restart()
      bcachefs: Journal resize fixes
      six locks: be more careful about lost wakeups
      fixup bcachefs: Use for_each_btree_key_upto() more consistently
      bcachefs: Verbose on by default when CONFIG_BCACHEFS_DEBUG=y
      bcachefs: When shutting down, flush btree node writes last
      bcachefs: Rework open bucket partial list allocation
      bcachefs: Suppress transaction restart err message
      bcachefs: evacuate_bucket() no longer calls verify_bucket_evacuated()
      bcachefs: evacuate_bucket() no longer moves cached ptrs
      bcachefs: Extent helper improvements
      bcachefs: Rework __bch2_data_update_index_update()
      bcachefs: ec: fall back to creating new stripes for copygc
      bcachefs: Second layer of refcounting for new stripes
      bcachefs: Fix next_bucket()
      bcachefs: Simplify stripe_idx_to_delete
      bcachefs: Kill bch_write_op->btree_update_ready
      bcachefs: Improve bch2_new_stripes_to_text()
      bcachefs: Mark new snapshots earlier in create path
      bcachefs: Fix stripe create error path
      bcachefs: Don't use BTREE_ITER_INTENT in make_extent_indirect()
      bcachefs: bch2_bucket_is_movable() -> BTREE_ITER_CACHED
      bcachefs: Fix an assert in copygc thread shutdown path
      bcachefs: Fix bch2_check_extents_to_backpointers()
      bcachefs: Private error codes: ENOMEM
      bcachefs: bch2_fs_moving_ctxts_to_text()
      bcachefs: New erasure coding shutdown path
      bcachefs: Add error message for failing to allocate sorted journal keys
      bcachefs: Improve the backpointer to missing extent message
      bcachefs: Add a fallback when journal_keys doesn't fit in ram
      bcachefs: Don't run transaction hooks multiple times
      bcachefs: Fix for 'missing subvolume' error
      bcachefs: Improve error handling in bch2_ioctl_subvolume_destroy()
      bcachefs: Fix bch2_evict_subvolume_inodes()
      bcachefs: Add an assert in inode_write for -ENOENT
      bcachefs: Fix bch2_extent_fallocate() in nocow mode
      bcachefs: Nocow write error path fix
      bcachefs: Fix nocow write path closure bug
      bcachefs: Fix an unhandled transaction restart error
      bcachefs: Make reconstruct_alloc quieter
      bcachefs: verify_bucket_evacuated() -> set_btree_iter_dontneed()
      bcachefs: Fix bch2_verify_bucket_evacuated()
      bcachefs: Call bch2_path_put_nokeep() before bch2_path_put()
      bcachefs: Improved copygc wait debugging
      bcachefs: Run freespace init in device hot add path
      bcachefs: bch2_dev_freespace_init() Print out status every 10 seconds
      bcachefs: Check return code from need_whiteout_for_snapshot()
      bcachefs: Fix bch2_get_key_or_hole()
      bcachefs: move snapshot_t to subvolume_types.h
      bcachefs: Use BTREE_ITER_INTENT in ec_stripe_update_extent()
      bcachefs: Rhashtable based buckets_in_flight for copygc
      bcachefs: Data update path no longer leaves cached replicas
      bcachefs: Improve trans_restart_split_race tracepoint
      bcachefs: Rip out code for storing backpointers in alloc keys
      bcachefs: Add missing bch2_err_class() call
      bcachefs: Print out counters correctly
      bcachefs: Improve trace_move_extent_fail()
      bcachefs: Add a cond_resched() call to journal_keys_sort()
      bcachefs: Add a bch_page_state assert
      bcachefs: Rename bch_page_state -> bch_folio
      bcachefs: Initial folio conversion
      bcachefs: bio_for_each_segment_all() -> bio_for_each_folio_all()
      bcachefs: bch2_seek_pagecache_hole() folio conversion
      bcachefs: bch2_seek_pagecache_data() folio conversion
      bcachefs: More assorted large folio conversion
      bcachefs: bch_folio can now handle multi-order folios
      bcachefs: bch2_buffered_write large folio conversion
      bcachefs: bch2_truncate_page() large folio conversion
      bcachefs: bch_folio_sector_state improvements
      bcachefs: filemap_get_contig_folios_d()
      bcachefs: bch2_readahead() large folio conversion
      bcachefs: Check for folios that don't have bch_folio attached
      bcachefs: Enable large folios
      bcachefs: Allow answering y or n to all fsck errors of given type
      bcachefs: Fix a slab-out-of-bounds
      bcachefs: Fix a null ptr deref in fsck check_extents()
      bcachefs: Drop a redundant error message
      bcachefs: Improve move path tracepoints
      bcachefs: Kill bch2_verify_bucket_evacuated()
      bcachefs: Make sure hash info gets initialized in fsck
      bcachefs: Fix a userspace build error
      bcachefs: Always run topology error when CONFIG_BCACHEFS_DEBUG=y
      bcachefs: Delete obsolete btree ptr check
      bcachefs: Mark bch2_copygc() noinline
      bcachefs: Btree iterator, update flags no longer conflict
      bcachefs: Converting to typed bkeys is now allowed for err, null ptrs
      bcachefs: bkey_ops.min_val_size
      bcachefs: bch2_bkey_get_iter() helpers
      bcachefs: Move bch2_bkey_make_mut() to btree_update.h
      bcachefs: bch2_bkey_get_mut() improvements
      bcachefs: bch2_bkey_alloc() now calls bch2_trans_update()
      bcachefs: bch2_bkey_get_mut() now calls bch2_trans_update()
      bcachefs: bch2_bkey_make_mut() now calls bch2_trans_update()
      bcachefs: bch2_bkey_get_empty_slot()
      bcachefs: BTREE_ID_snapshot_tree
      bcachefs: Add otime, parent to bch_subvolume
      bcachefs: Fix quotas + snapshots
      bcachefs: Improved comment for bch2_replicas_gc2()
      bcachefs: Delete some dead code in bch2_replicas_gc_end()
      bcachefs: Replace a BUG_ON() with fatal error
      bcachefs: Fix check_overlapping_extents()
      bcachefs: Use memcpy_u64s_small() for copying keys
      bcachefs: Delete an incorrect bch2_trans_unlock()
      bcachefs: alloc_v4_u64s() fix
      bcachefs: Clear btree_node_just_written() when node reused or evicted
      bcachefs: Fix a buffer overrun in bch2_fs_usage_read()
      bcachefs: Don't call local_clock() twice in trans_begin()
      six locks: six_lock_readers_add()
      six locks: Kill six_lock_pcpu_(alloc|free)
      six locks: Remove hacks for percpu mode lost wakeup
      six locks: Centralize setting of waiting bit
      six locks: Simplify dispatch
      six locks: Kill six_lock_state union
      six locks: Documentation, renaming
      six locks: Improve spurious wakeup handling in pcpu reader mode
      six locks: Simplify six_relock()
      six locks: lock->state.seq no longer used for write lock held
      six_locks: Kill test_bit()/set_bit() usage
      six locks: Single instance of six_lock_vals
      six locks: Split out seq, use atomic_t instead of atomic64_t
      six locks: Seq now only incremented on unlock
      six locks: Tiny bit more tidying
      six locks: Delete redundant comment
      six locks: Fix an unitialized var
      six locks: Use atomic_try_cmpxchg_acquire()
      six locks: Disable percpu read lock mode in userspace
      mean and variance: More tests
      mean and variance: Add a missing include
      bcachefs: Don't reuse reflink btree keyspace
      bcachefs: Fix move_extent_fail counter
      bcachefs: Fix a quota read bug
      bcachefs: trans_for_each_path_safe()
      bcachefs: Convert -ENOENT to private error codes
      bcachefs: Fix corruption with writeable snapshots
      bcachefs: Avoid __GFP_NOFAIL
      bcachefs: Ensure bch2_btree_node_get() calls relock() after unlock()
      bcachefs: GFP_NOIO -> GFP_NOFS
      bcachefs: drop_locks_do()
      bcachefs: bch2_trans_kmalloc no longer allocates memory with btree locks held
      bcachefs: fs-io: Eliminate GFP_NOFS usage
      bcachefs: Fix error handling in promote path
      bcachefs: Use unlikely() in bch2_err_matches()
      bcachefs: allocate_dropping_locks()
      bcachefs: Convert acl.c to allocate_dropping_locks()
      bcachefs: replicas_deltas_realloc() uses allocate_dropping_locks()
      bcachefs: Fix bch2_fsck_ask_yn()
      bcachefs: Delete warning from promote_alloc()
      bcachefs: More drop_locks_do() conversions
      bcachefs: Improve backpointers error message
      bcachefs: Clean up tests code
      bcachefs: Fix subvol deletion deadlock
      bcachefs: ec: Fix a lost wakeup
      bcachefs: New assertions when marking filesystem clean
      bcachefs: Write buffer flush needs BTREE_INSERT_NOCHECK_RW
      bcachefs: Delete weird hacky transaction restart injection
      bcachefs: Fix try_decrease_writepoints()
      bcachefs: snapshot_to_text() includes snapshot tree
      bcachefs: bch2_extent_ptr_desired_durability()
      bcachefs: Fix bch2_btree_update_start()
      bcachefs: bch2_trans_unlock_noassert()
      bcachefs: Fix bch2_check_discard_freespace_key()
      bcachefs: Don't call lock_graph_descend() with wait lock held
      bcachefs: seqmutex; fix a lockdep splat
      bcachefs: fiemap: Fix a lockdep splat
      bcachefs: New error message helpers
      bcachefs: Check for ERR_PTR() from filemap_lock_folio()
      bcachefs: Fix lockdep splat in bch2_readdir
      bcachefs: Fix more lockdep splats in debug.c
      bcachefs: bch2_trans_mark_pointer() refactoring
      bcachefs: BCH_ERR_fsck -> EINVAL
      bcachefs: Rename enum alloc_reserve -> bch_watermark
      bcachefs: Fix check_pos_snapshot_overwritten()
      bcachefs: Improve error message for overlapping extents
      bcachefs: fsck needs BTREE_UPDATE_INTERNAL_SNAPSHOT_NODE
      bcachefs: Reduce stack frame size of bch2_check_alloc_info()
      bcachefs: Improve bch2_bkey_make_mut()
      bcachefs: Add a missing rhashtable_destroy() call
      bcachefs: unregister_shrinker() now safe on not-registered shrinker
      bcachefs: Fix leak in backpointers fsck
      bcachefs: fsck: Break walk_inode() up into multiple functions
      bcachefs: Fix btree node write error message
      bcachefs: Expand BTREE_NODE_ID
      bcachefs: struct bch_extent_rebalance
      bcachefs: BCH_WATERMARK_reclaim
      bcachefs: Kill JOURNAL_WATERMARK
      bcachefs: Fix a format string warning
      bcachefs: Fix a null ptr deref in bch2_fs_alloc() error path
      bcachefs: Kill BTREE_INSERT_USE_RESERVE
      bcachefs: bch2_version_to_text()
      bcachefs: bch2_version_compatible()
      bcachefs: Allow for unknown btree IDs
      bcachefs: Allow for unknown key types
      bcachefs: Refactor bch_sb_field_ops handling
      bcachefs: Assorted sparse fixes
      bcachefs: Change check for invalid key types
      bcachefs: Delete redundant log messages
      bcachefs: Convert more -EROFS to private error codes
      bcachefs: BCH_SB_VERSION_UPGRADE_COMPLETE()
      bcachefs: version_upgrade is now an enum
      bcachefs: Fix error path in bch2_journal_flush_device_pins()
      bcachefs: Kill bch2_bucket_gens_read()
      bcachefs: Stash journal replay params in bch_fs
      bcachefs: Enumerate recovery passes
      bcachefs: Mark as EXPERIMENTAL
      bcachefs: Fix try_decrease_writepoints()
      bcachefs: Kill bch2_xattr_get()
      bcachefs: bch2_xattr_set() now updates ctime
      bcachefs: Add new assertions for shutdown path
      bcachefs: bcachefs_metadata_version_major_minor
      bcachefs: Fix a write buffer flush deadlock
      bcachefs: bch2_sb_maybe_downgrade(), bch2_sb_upgrade()
      bcachefs: Version table now lists required recovery passes
      bcachefs: Snapshot depth, skiplist fields
      bcachefs: Fix build error on weird gcc
      bcachefs: Don't start copygc until recovery is finished
      bcachefs: Fallocate now checks page cache
      bcachefs: Add buffered IO fallback for userspace
      bcachefs: Add a race_fault() for write buffer slowpath
      bcachefs: Convert snapshot table to RCU array
      bcachefs: bch_opt_fn
      bcachefs: fix_errors option is now a proper enum
      bcachefs: bcachefs_format.h should be using __u64
      bcachefs: Extent sb compression type fields to 8 bits
      bcachefs: Compression levels
      bcachefs: is_ancestor bitmap
      bcachefs: Upgrade path fixes
      bcachefs: Inline bch2_snapshot_is_ancestor() fast path
      bcachefs: check_extents(): make sure to check i_sectors for last inode
      bcachefs: fsck: inode_walker: last_pos, seen_this_pos
      bcachefs: overlapping_extents_found()
      bcachefs: Simplify check_extent()
      bcachefs: fsck: walk_inode() now takes is_whiteout
      bcachefs: check_extent() refactoring
      bcachefs: check_extent(): don't use key_visible_in_snapshot()
      bcachefs: Refactor overlapping extent checks
      bcachefs: Improve key_visible_in_snapshot()
      bcachefs: need_snapshot_cleanup shouldn't be a fsck error
      bcachefs: Fix lookup_inode_for_snapshot()
      bcachefs: Suppresss various error messages in no_data_io mode
      bcachefs: Print version, options earlier in startup path
      bcachefs: bch2_run_explicit_recovery_pass()
      bcachefs: Make topology repair a normal recovery pass
      bcachefs: fsck: delete dead code
      bcachefs: move inode triggers to inode.c
      bcachefs: bch2_btree_bit_mod()
      bcachefs: Fix a null ptr deref in check_xattr()
      bcachefs: Fix btree iter leak in __bch2_insert_snapshot_whiteouts()
      bcachefs: Move some declarations to the correct header
      bcachefs: Fix minor memory leak on invalid bkey
      bcachefs: bch2_trans_update_extent_overwrite()
      bcachefs: Consolidate btree id properties
      bcachefs: Move fsck_inode_rm() to inode.c
      bcachefs: Assorted fixes for clang
      bcachefs: Handle weird opt string from sys_fsconfig()
      bcachefs: recovery_types.h
      bcachefs: In debug mode, run fsck again after fixing errors
      bcachefs: Fix overlapping extent repair
      bcachefs: Fix folio leak in folio_hole_offset()
      bcachefs: bcachefs_metadata_version_deleted_inodes
      bcachefs: bkey_format helper improvements
      bcachefs: Fix shift by 64 in set_inc_field()
      bcachefs: Print out required recovery passes on version upgrade
      bcachefs: Log a message when running an explicit recovery pass
      bcachefs: Ensure topology repair runs
      bcachefs: Fix btree_err() macro
      bcachefs: Convert btree_err_type to normal error codes
      bcachefs: Fix for bch2_copygc() spuriously returning -EEXIST
      bcachefs: Fix lock thrashing in __bchfs_fallocate()
      bcachefs: Add logging to bch2_inode_peek() & related
      bcachefs: kill EBUG_ON() redefinition in bkey.c
      bcachefs: BCH_COMPAT_bformat_overflow_done no longer required
      bcachefs: Improve journal_entry_err_msg()
      bcachefs: Convert journal validation to bkey_invalid_flags
      bcachefs: Fix for sb buffer being misaligned
      bcachefs: Fix assorted checkpatch nits
      bcachefs: Split up fs-io.[ch]
      bcachefs: Split up btree_update_leaf.c
      bcachefs: sb-members.c
      bcachefs: Move bch_sb_field_crypt code to checksum.c
      bcachefs: sb-clean.c
      bcachefs: btree_journal_iter.c
      bcachefs: Fix 'journal not marked as containing replicas'
      bcachefs: Fix check_version_upgrade()
      bcachefs: Improve bch2_write_points_to_text()
      bcachefs: Check for directories in deleted inodes btree
      bcachefs: six locks: Fix missing barrier on wait->lock_acquired
      bcachefs: Add a comment for should_drop_open_bucket()
      bcachefs: Fix lifetime in bch2_write_done(), add assertion
      bcachefs: Don't open code closure_nr_remaining()
      bcachefs: six locks: Guard against wakee exiting in __six_lock_wakeup()
      bcachefs: Fix 'pointer to invalid device' check
      bcachefs: Zero btree_paths on allocation
      bcachefs: Fix bch2_extent_fallocate()
      bcachefs: Fix bkey format calculation
      bcachefs: Fix swallowing of data in buffered write path
      bcachefs: stack_trace_save_tsk() depends on CONFIG_STACKTRACE
      bcachefs: Split out snapshot.c
      bcachefs: Fix divide by zero in rebalance_work()
      bcachefs: Improve btree_path_relock_fail tracepoint
      bcachefs: Delete a faulty assertion
      bcachefs: Fix bch2_mount error path
      bcachefs: move check_pos_snapshot_overwritten() to snapshot.c
      bcachefs: Fix is_ancestor bitmap
      bcachefs: Fix btree write buffer with snapshots btrees
      bcachefs: Cleanup redundant snapshot nodes
      bcachefs: bch2_propagate_key_to_snapshot_leaves()
      bcachefs: Fix a double free on invalid bkey
      bcachefs: Always check alloc data type
      bcachefs: Put bkey invalid check in commit path in a more useful place
      bcachefs: Improve bch2_moving_ctxt_to_text()
      bcachefs: Kill stripe check in bch2_alloc_v4_invalid()
      bcachefs: Fix snapshot_skiplist_good()
      bcachefs: bch2_acl_to_text()
      bcachefs: Array bounds fixes
      bcachefs: Fix silent enum conversion error
      bcachefs: Fix bch2_propagate_key_to_snapshot_leaves()
      bcachefs: Fix bch_sb_handle type
      bcachefs: Kill missing inode warnings in bch2_quota_read()
      bcachefs: Convert more code to bch_err_msg()
      bcachefs: Kill incorrect assertion
      bcachefs: __bch2_btree_insert() -> bch2_btree_insert_trans()
      bcachefs: bch2_trans_update_get_key_cache()
      bcachefs: Break up io.c
      bcachefs: New io_misc.c helpers
      bcachefs: BTREE_ID_logged_ops
      bcachefs: Log truncate operations
      bcachefs: Log finsert/fcollapse operations
      bcachefs: trace_read_nopromote()
      bcachefs: Add a missing prefetch include
      bcachefs: Fix W=12 build errors
      bcachefs: Heap allocate btree_trans
      bcachefs: Kill other unreachable() uses
      bcachefs: Change bucket_lock() to use bit_spin_lock()
      bcachefs: Fix copy_to_user() usage in flush_buf()
      bcachefs: Fix an overflow check
      bcachefs: Fix error checks in bch2_chacha_encrypt_key()
      bcachefs: bch2_ioctl_disk_resize_journal(): check for integer truncation
      bcachefs: drop journal lock before calling journal_write
      bcachefs: Fix strndup_user() error checking
      bcachefs: snapshots: Use kvfree_rcu_mightsleep()
      bcachefs: Minor bch2_btree_node_get() smatch fixes
      bcachefs: More minor smatch fixes
      bcachefs: Fix a null ptr deref in bch2_get_alloc_in_memory_pos()
      bcachefs: Make sure to initialize equiv when creating new snapshots
      bcachefs: Always check for invalid bkeys in main commit path
      bcachefs: Ignore unknown mount options
      bcachefs: Fixes for building in userspace
      bcachefs: nocow locking: Fix lock leak
      bcachefs: More assertions for nocow locking
      bcachefs: Silence transaction restart error message
      bcachefs: bch_err_msg(), bch_err_fn() now filters out transaction restart errors
      bcachefs: Fix looping around bch2_propagate_key_to_snapshot_leaves()
      bcachefs: Fall back to requesting passphrase directly
      bcachefs: Make btree root read errors recoverable
      bcachefs: Fix bch2_inode_delete_keys()
      bcachefs: bucket_lock() is now a sleepable lock
      bcachefs: Use strsep() in split_devs()
      bcachefs: Fix another smatch complaint
      bcachefs: Correctly initialize new buckets on device resize
      bcachefs: Switch to unsafe_memcpy() in a few places
      bcachefs: Fix handling of unknown bkey types
      bcachefs: KEY_TYPE_error now counts towards i_sectors
      bcachefs: bch2_sb_field_get() refactoring
      bcachefs: Fix snapshot skiplists during snapshot deletion
      bcachefs: snapshot_create_lock
      bcachefs: Fix drop_alloc_keys()
      exportfs: Change bcachefs fid_type enum to avoid conflicts

Matthew Wilcox (Oracle) (2):
      bcachefs: Remove page_state_init_for_read
      bcachefs: Use attach_page_private and detach_page_private

Mikulas Patocka (2):
      bcachefs: fix NULL pointer dereference in try_alloc_bucket
      bcachefs: mark bch_inode_info and bkey_cached as reclaimable

Nathan Chancellor (7):
      bcachefs: Fix -Wformat in bch2_set_bucket_needs_journal_commit()
      bcachefs: Fix -Wformat in bch2_btree_key_cache_to_text()
      bcachefs: Fix -Wformat in bch2_alloc_v4_invalid()
      bcachefs: Fix -Wformat in bch2_bucket_gens_invalid()
      bcachefs: Fix -Wincompatible-function-pointer-types-strict from key_invalid callbacks
      bcachefs: Fix -Wcompare-distinct-pointer-types in do_encrypt()
      bcachefs: Fix -Wcompare-distinct-pointer-types in bch2_copygc_get_buckets()

Nick Desaulniers (1):
      bcachefs: Fix -Wself-assign

Olexa Bilaniuk (1):
      bcachefs: remove dead whiteout_u64s argument.

Robbie Litchfield (1):
      bcachefs: Fix unnecessary read amplificaiton when allocating ec stripes

Stijn Tintel (1):
      bcachefs: avoid out-of-bounds in split_devs

Tim Schlueter (2):
      bcachefs: Set the last mount time using the realtime clock
      bcachefs: Fix bkey_method compilation on gcc 7.3.0

Tobias Geerinckx-Rice (1):
      bcachefs: Enforce SYS_CAP_ADMIN within ioctls

Torge Matthies (1):
      bcachefs: Fix changing durability using sysfs

Yang Li (1):
      bcachefs: Remove unneeded semicolon

Yuxuan Shui (1):
      bcachefs: fix stack corruption

jpsollie (2):
      bcachefs: Prepare checksums for more advanced algorithms
      bcachefs: add bcachefs xxhash support

 MAINTAINERS                                     |   23 +
 drivers/md/bcache/Kconfig                       |   10 +-
 drivers/md/bcache/Makefile                      |    4 +-
 drivers/md/bcache/bcache.h                      |    2 +-
 drivers/md/bcache/super.c                       |    1 -
 drivers/md/bcache/util.h                        |    3 +-
 fs/Kconfig                                      |    1 +
 fs/Makefile                                     |    1 +
 fs/bcachefs/Kconfig                             |   85 +
 fs/bcachefs/Makefile                            |   88 +
 fs/bcachefs/acl.c                               |  463 ++++
 fs/bcachefs/acl.h                               |   60 +
 fs/bcachefs/alloc_background.c                  | 2146 +++++++++++++++
 fs/bcachefs/alloc_background.h                  |  258 ++
 fs/bcachefs/alloc_foreground.c                  | 1576 +++++++++++
 fs/bcachefs/alloc_foreground.h                  |  224 ++
 fs/bcachefs/alloc_types.h                       |  126 +
 fs/bcachefs/backpointers.c                      |  868 ++++++
 fs/bcachefs/backpointers.h                      |  131 +
 fs/bcachefs/bbpos.h                             |   48 +
 fs/bcachefs/bcachefs.h                          | 1156 ++++++++
 fs/bcachefs/bcachefs_format.h                   | 2413 +++++++++++++++++
 fs/bcachefs/bcachefs_ioctl.h                    |  368 +++
 fs/bcachefs/bkey.c                              | 1120 ++++++++
 fs/bcachefs/bkey.h                              |  782 ++++++
 fs/bcachefs/bkey_buf.h                          |   61 +
 fs/bcachefs/bkey_cmp.h                          |  129 +
 fs/bcachefs/bkey_methods.c                      |  458 ++++
 fs/bcachefs/bkey_methods.h                      |  188 ++
 fs/bcachefs/bkey_sort.c                         |  201 ++
 fs/bcachefs/bkey_sort.h                         |   54 +
 fs/bcachefs/bset.c                              | 1592 +++++++++++
 fs/bcachefs/bset.h                              |  541 ++++
 fs/bcachefs/btree_cache.c                       | 1202 +++++++++
 fs/bcachefs/btree_cache.h                       |  130 +
 fs/bcachefs/btree_gc.c                          | 2111 +++++++++++++++
 fs/bcachefs/btree_gc.h                          |  114 +
 fs/bcachefs/btree_io.c                          | 2223 ++++++++++++++++
 fs/bcachefs/btree_io.h                          |  228 ++
 fs/bcachefs/btree_iter.c                        | 3215 +++++++++++++++++++++++
 fs/bcachefs/btree_iter.h                        |  939 +++++++
 fs/bcachefs/btree_journal_iter.c                |  531 ++++
 fs/bcachefs/btree_journal_iter.h                |   57 +
 fs/bcachefs/btree_key_cache.c                   | 1072 ++++++++
 fs/bcachefs/btree_key_cache.h                   |   48 +
 fs/bcachefs/btree_locking.c                     |  791 ++++++
 fs/bcachefs/btree_locking.h                     |  423 +++
 fs/bcachefs/btree_trans_commit.c                | 1150 ++++++++
 fs/bcachefs/btree_types.h                       |  739 ++++++
 fs/bcachefs/btree_update.c                      |  933 +++++++
 fs/bcachefs/btree_update.h                      |  340 +++
 fs/bcachefs/btree_update_interior.c             | 2480 +++++++++++++++++
 fs/bcachefs/btree_update_interior.h             |  337 +++
 fs/bcachefs/btree_write_buffer.c                |  375 +++
 fs/bcachefs/btree_write_buffer.h                |   14 +
 fs/bcachefs/btree_write_buffer_types.h          |   44 +
 fs/bcachefs/buckets.c                           | 2106 +++++++++++++++
 fs/bcachefs/buckets.h                           |  443 ++++
 fs/bcachefs/buckets_types.h                     |   92 +
 fs/bcachefs/buckets_waiting_for_journal.c       |  166 ++
 fs/bcachefs/buckets_waiting_for_journal.h       |   15 +
 fs/bcachefs/buckets_waiting_for_journal_types.h |   23 +
 fs/bcachefs/chardev.c                           |  784 ++++++
 fs/bcachefs/chardev.h                           |   31 +
 fs/bcachefs/checksum.c                          |  804 ++++++
 fs/bcachefs/checksum.h                          |  213 ++
 fs/bcachefs/clock.c                             |  193 ++
 fs/bcachefs/clock.h                             |   38 +
 fs/bcachefs/clock_types.h                       |   37 +
 fs/bcachefs/compress.c                          |  710 +++++
 fs/bcachefs/compress.h                          |   55 +
 fs/bcachefs/counters.c                          |  107 +
 fs/bcachefs/counters.h                          |   17 +
 fs/bcachefs/darray.h                            |   87 +
 fs/bcachefs/data_update.c                       |  558 ++++
 fs/bcachefs/data_update.h                       |   43 +
 fs/bcachefs/debug.c                             |  954 +++++++
 fs/bcachefs/debug.h                             |   32 +
 fs/bcachefs/dirent.c                            |  587 +++++
 fs/bcachefs/dirent.h                            |   70 +
 fs/bcachefs/disk_groups.c                       |  550 ++++
 fs/bcachefs/disk_groups.h                       |  106 +
 fs/bcachefs/ec.c                                | 1966 ++++++++++++++
 fs/bcachefs/ec.h                                |  260 ++
 fs/bcachefs/ec_types.h                          |   41 +
 fs/bcachefs/errcode.c                           |   68 +
 fs/bcachefs/errcode.h                           |  265 ++
 fs/bcachefs/error.c                             |  293 +++
 fs/bcachefs/error.h                             |  206 ++
 fs/bcachefs/extent_update.c                     |  173 ++
 fs/bcachefs/extent_update.h                     |   12 +
 fs/bcachefs/extents.c                           | 1403 ++++++++++
 fs/bcachefs/extents.h                           |  758 ++++++
 fs/bcachefs/extents_types.h                     |   40 +
 fs/bcachefs/eytzinger.h                         |  281 ++
 fs/bcachefs/fifo.h                              |  127 +
 fs/bcachefs/fs-common.c                         |  501 ++++
 fs/bcachefs/fs-common.h                         |   43 +
 fs/bcachefs/fs-io-buffered.c                    | 1093 ++++++++
 fs/bcachefs/fs-io-buffered.h                    |   27 +
 fs/bcachefs/fs-io-direct.c                      |  679 +++++
 fs/bcachefs/fs-io-direct.h                      |   16 +
 fs/bcachefs/fs-io-pagecache.c                   |  791 ++++++
 fs/bcachefs/fs-io-pagecache.h                   |  176 ++
 fs/bcachefs/fs-io.c                             | 1072 ++++++++
 fs/bcachefs/fs-io.h                             |  184 ++
 fs/bcachefs/fs-ioctl.c                          |  572 ++++
 fs/bcachefs/fs-ioctl.h                          |   81 +
 fs/bcachefs/fs.c                                | 1980 ++++++++++++++
 fs/bcachefs/fs.h                                |  209 ++
 fs/bcachefs/fsck.c                              | 2417 +++++++++++++++++
 fs/bcachefs/fsck.h                              |   14 +
 fs/bcachefs/inode.c                             | 1133 ++++++++
 fs/bcachefs/inode.h                             |  207 ++
 fs/bcachefs/io_misc.c                           |  515 ++++
 fs/bcachefs/io_misc.h                           |   34 +
 fs/bcachefs/io_read.c                           | 1210 +++++++++
 fs/bcachefs/io_read.h                           |  158 ++
 fs/bcachefs/io_write.c                          | 1671 ++++++++++++
 fs/bcachefs/io_write.h                          |  110 +
 fs/bcachefs/io_write_types.h                    |   96 +
 fs/bcachefs/journal.c                           | 1449 ++++++++++
 fs/bcachefs/journal.h                           |  548 ++++
 fs/bcachefs/journal_io.c                        | 1894 +++++++++++++
 fs/bcachefs/journal_io.h                        |   65 +
 fs/bcachefs/journal_reclaim.c                   |  876 ++++++
 fs/bcachefs/journal_reclaim.h                   |   87 +
 fs/bcachefs/journal_sb.c                        |  219 ++
 fs/bcachefs/journal_sb.h                        |   24 +
 fs/bcachefs/journal_seq_blacklist.c             |  320 +++
 fs/bcachefs/journal_seq_blacklist.h             |   22 +
 fs/bcachefs/journal_types.h                     |  345 +++
 fs/bcachefs/keylist.c                           |   52 +
 fs/bcachefs/keylist.h                           |   74 +
 fs/bcachefs/keylist_types.h                     |   16 +
 fs/bcachefs/logged_ops.c                        |  112 +
 fs/bcachefs/logged_ops.h                        |   20 +
 fs/bcachefs/lru.c                               |  162 ++
 fs/bcachefs/lru.h                               |   69 +
 fs/bcachefs/mean_and_variance.c                 |  159 ++
 fs/bcachefs/mean_and_variance.h                 |  198 ++
 fs/bcachefs/mean_and_variance_test.c            |  240 ++
 fs/bcachefs/migrate.c                           |  179 ++
 fs/bcachefs/migrate.h                           |    7 +
 fs/bcachefs/move.c                              | 1159 ++++++++
 fs/bcachefs/move.h                              |   96 +
 fs/bcachefs/move_types.h                        |   36 +
 fs/bcachefs/movinggc.c                          |  414 +++
 fs/bcachefs/movinggc.h                          |   12 +
 fs/bcachefs/nocow_locking.c                     |  144 +
 fs/bcachefs/nocow_locking.h                     |   50 +
 fs/bcachefs/nocow_locking_types.h               |   20 +
 fs/bcachefs/opts.c                              |  605 +++++
 fs/bcachefs/opts.h                              |  564 ++++
 fs/bcachefs/printbuf.c                          |  425 +++
 fs/bcachefs/printbuf.h                          |  284 ++
 fs/bcachefs/quota.c                             |  978 +++++++
 fs/bcachefs/quota.h                             |   74 +
 fs/bcachefs/quota_types.h                       |   43 +
 fs/bcachefs/rebalance.c                         |  366 +++
 fs/bcachefs/rebalance.h                         |   28 +
 fs/bcachefs/rebalance_types.h                   |   26 +
 fs/bcachefs/recovery.c                          | 1049 ++++++++
 fs/bcachefs/recovery.h                          |   33 +
 fs/bcachefs/recovery_types.h                    |   49 +
 fs/bcachefs/reflink.c                           |  405 +++
 fs/bcachefs/reflink.h                           |   81 +
 fs/bcachefs/replicas.c                          | 1058 ++++++++
 fs/bcachefs/replicas.h                          |   91 +
 fs/bcachefs/replicas_types.h                    |   27 +
 fs/bcachefs/sb-clean.c                          |  395 +++
 fs/bcachefs/sb-clean.h                          |   16 +
 fs/bcachefs/sb-members.c                        |  339 +++
 fs/bcachefs/sb-members.h                        |  182 ++
 fs/bcachefs/seqmutex.h                          |   48 +
 fs/bcachefs/siphash.c                           |  173 ++
 fs/bcachefs/siphash.h                           |   87 +
 fs/bcachefs/six.c                               |  913 +++++++
 fs/bcachefs/six.h                               |  393 +++
 fs/bcachefs/snapshot.c                          | 1689 ++++++++++++
 fs/bcachefs/snapshot.h                          |  270 ++
 fs/bcachefs/str_hash.h                          |  370 +++
 fs/bcachefs/subvolume.c                         |  450 ++++
 fs/bcachefs/subvolume.h                         |   35 +
 fs/bcachefs/subvolume_types.h                   |   31 +
 fs/bcachefs/super-io.c                          | 1258 +++++++++
 fs/bcachefs/super-io.h                          |  124 +
 fs/bcachefs/super.c                             | 2022 ++++++++++++++
 fs/bcachefs/super.h                             |   52 +
 fs/bcachefs/super_types.h                       |   52 +
 fs/bcachefs/sysfs.c                             | 1031 ++++++++
 fs/bcachefs/sysfs.h                             |   48 +
 fs/bcachefs/tests.c                             |  919 +++++++
 fs/bcachefs/tests.h                             |   15 +
 fs/bcachefs/trace.c                             |   16 +
 fs/bcachefs/trace.h                             | 1284 +++++++++
 fs/bcachefs/two_state_shared_lock.c             |    8 +
 fs/bcachefs/two_state_shared_lock.h             |   59 +
 fs/bcachefs/util.c                              | 1141 ++++++++
 fs/bcachefs/util.h                              |  852 ++++++
 fs/bcachefs/varint.c                            |  129 +
 fs/bcachefs/varint.h                            |   11 +
 fs/bcachefs/vstructs.h                          |   63 +
 fs/bcachefs/xattr.c                             |  651 +++++
 fs/bcachefs/xattr.h                             |   50 +
 fs/dcache.c                                     |   12 +-
 {drivers/md/bcache => include/linux}/closure.h  |   46 +-
 include/linux/dcache.h                          |    1 +
 include/linux/exportfs.h                        |    6 +
 include/linux/generic-radix-tree.h              |   68 +-
 include/linux/sched.h                           |    1 +
 include/linux/string_helpers.h                  |    4 +-
 init/init_task.c                                |    1 +
 kernel/locking/mutex.c                          |    3 +
 kernel/stacktrace.c                             |    2 +
 lib/Kconfig                                     |    3 +
 lib/Kconfig.debug                               |    9 +
 lib/Makefile                                    |    2 +
 {drivers/md/bcache => lib}/closure.c            |   36 +-
 lib/errname.c                                   |    1 +
 lib/generic-radix-tree.c                        |   76 +-
 lib/string_helpers.c                            |   10 +-
 tools/objtool/noreturns.h                       |    2 +
 223 files changed, 95037 insertions(+), 56 deletions(-)
 create mode 100644 fs/bcachefs/Kconfig
 create mode 100644 fs/bcachefs/Makefile
 create mode 100644 fs/bcachefs/acl.c
 create mode 100644 fs/bcachefs/acl.h
 create mode 100644 fs/bcachefs/alloc_background.c
 create mode 100644 fs/bcachefs/alloc_background.h
 create mode 100644 fs/bcachefs/alloc_foreground.c
 create mode 100644 fs/bcachefs/alloc_foreground.h
 create mode 100644 fs/bcachefs/alloc_types.h
 create mode 100644 fs/bcachefs/backpointers.c
 create mode 100644 fs/bcachefs/backpointers.h
 create mode 100644 fs/bcachefs/bbpos.h
 create mode 100644 fs/bcachefs/bcachefs.h
 create mode 100644 fs/bcachefs/bcachefs_format.h
 create mode 100644 fs/bcachefs/bcachefs_ioctl.h
 create mode 100644 fs/bcachefs/bkey.c
 create mode 100644 fs/bcachefs/bkey.h
 create mode 100644 fs/bcachefs/bkey_buf.h
 create mode 100644 fs/bcachefs/bkey_cmp.h
 create mode 100644 fs/bcachefs/bkey_methods.c
 create mode 100644 fs/bcachefs/bkey_methods.h
 create mode 100644 fs/bcachefs/bkey_sort.c
 create mode 100644 fs/bcachefs/bkey_sort.h
 create mode 100644 fs/bcachefs/bset.c
 create mode 100644 fs/bcachefs/bset.h
 create mode 100644 fs/bcachefs/btree_cache.c
 create mode 100644 fs/bcachefs/btree_cache.h
 create mode 100644 fs/bcachefs/btree_gc.c
 create mode 100644 fs/bcachefs/btree_gc.h
 create mode 100644 fs/bcachefs/btree_io.c
 create mode 100644 fs/bcachefs/btree_io.h
 create mode 100644 fs/bcachefs/btree_iter.c
 create mode 100644 fs/bcachefs/btree_iter.h
 create mode 100644 fs/bcachefs/btree_journal_iter.c
 create mode 100644 fs/bcachefs/btree_journal_iter.h
 create mode 100644 fs/bcachefs/btree_key_cache.c
 create mode 100644 fs/bcachefs/btree_key_cache.h
 create mode 100644 fs/bcachefs/btree_locking.c
 create mode 100644 fs/bcachefs/btree_locking.h
 create mode 100644 fs/bcachefs/btree_trans_commit.c
 create mode 100644 fs/bcachefs/btree_types.h
 create mode 100644 fs/bcachefs/btree_update.c
 create mode 100644 fs/bcachefs/btree_update.h
 create mode 100644 fs/bcachefs/btree_update_interior.c
 create mode 100644 fs/bcachefs/btree_update_interior.h
 create mode 100644 fs/bcachefs/btree_write_buffer.c
 create mode 100644 fs/bcachefs/btree_write_buffer.h
 create mode 100644 fs/bcachefs/btree_write_buffer_types.h
 create mode 100644 fs/bcachefs/buckets.c
 create mode 100644 fs/bcachefs/buckets.h
 create mode 100644 fs/bcachefs/buckets_types.h
 create mode 100644 fs/bcachefs/buckets_waiting_for_journal.c
 create mode 100644 fs/bcachefs/buckets_waiting_for_journal.h
 create mode 100644 fs/bcachefs/buckets_waiting_for_journal_types.h
 create mode 100644 fs/bcachefs/chardev.c
 create mode 100644 fs/bcachefs/chardev.h
 create mode 100644 fs/bcachefs/checksum.c
 create mode 100644 fs/bcachefs/checksum.h
 create mode 100644 fs/bcachefs/clock.c
 create mode 100644 fs/bcachefs/clock.h
 create mode 100644 fs/bcachefs/clock_types.h
 create mode 100644 fs/bcachefs/compress.c
 create mode 100644 fs/bcachefs/compress.h
 create mode 100644 fs/bcachefs/counters.c
 create mode 100644 fs/bcachefs/counters.h
 create mode 100644 fs/bcachefs/darray.h
 create mode 100644 fs/bcachefs/data_update.c
 create mode 100644 fs/bcachefs/data_update.h
 create mode 100644 fs/bcachefs/debug.c
 create mode 100644 fs/bcachefs/debug.h
 create mode 100644 fs/bcachefs/dirent.c
 create mode 100644 fs/bcachefs/dirent.h
 create mode 100644 fs/bcachefs/disk_groups.c
 create mode 100644 fs/bcachefs/disk_groups.h
 create mode 100644 fs/bcachefs/ec.c
 create mode 100644 fs/bcachefs/ec.h
 create mode 100644 fs/bcachefs/ec_types.h
 create mode 100644 fs/bcachefs/errcode.c
 create mode 100644 fs/bcachefs/errcode.h
 create mode 100644 fs/bcachefs/error.c
 create mode 100644 fs/bcachefs/error.h
 create mode 100644 fs/bcachefs/extent_update.c
 create mode 100644 fs/bcachefs/extent_update.h
 create mode 100644 fs/bcachefs/extents.c
 create mode 100644 fs/bcachefs/extents.h
 create mode 100644 fs/bcachefs/extents_types.h
 create mode 100644 fs/bcachefs/eytzinger.h
 create mode 100644 fs/bcachefs/fifo.h
 create mode 100644 fs/bcachefs/fs-common.c
 create mode 100644 fs/bcachefs/fs-common.h
 create mode 100644 fs/bcachefs/fs-io-buffered.c
 create mode 100644 fs/bcachefs/fs-io-buffered.h
 create mode 100644 fs/bcachefs/fs-io-direct.c
 create mode 100644 fs/bcachefs/fs-io-direct.h
 create mode 100644 fs/bcachefs/fs-io-pagecache.c
 create mode 100644 fs/bcachefs/fs-io-pagecache.h
 create mode 100644 fs/bcachefs/fs-io.c
 create mode 100644 fs/bcachefs/fs-io.h
 create mode 100644 fs/bcachefs/fs-ioctl.c
 create mode 100644 fs/bcachefs/fs-ioctl.h
 create mode 100644 fs/bcachefs/fs.c
 create mode 100644 fs/bcachefs/fs.h
 create mode 100644 fs/bcachefs/fsck.c
 create mode 100644 fs/bcachefs/fsck.h
 create mode 100644 fs/bcachefs/inode.c
 create mode 100644 fs/bcachefs/inode.h
 create mode 100644 fs/bcachefs/io_misc.c
 create mode 100644 fs/bcachefs/io_misc.h
 create mode 100644 fs/bcachefs/io_read.c
 create mode 100644 fs/bcachefs/io_read.h
 create mode 100644 fs/bcachefs/io_write.c
 create mode 100644 fs/bcachefs/io_write.h
 create mode 100644 fs/bcachefs/io_write_types.h
 create mode 100644 fs/bcachefs/journal.c
 create mode 100644 fs/bcachefs/journal.h
 create mode 100644 fs/bcachefs/journal_io.c
 create mode 100644 fs/bcachefs/journal_io.h
 create mode 100644 fs/bcachefs/journal_reclaim.c
 create mode 100644 fs/bcachefs/journal_reclaim.h
 create mode 100644 fs/bcachefs/journal_sb.c
 create mode 100644 fs/bcachefs/journal_sb.h
 create mode 100644 fs/bcachefs/journal_seq_blacklist.c
 create mode 100644 fs/bcachefs/journal_seq_blacklist.h
 create mode 100644 fs/bcachefs/journal_types.h
 create mode 100644 fs/bcachefs/keylist.c
 create mode 100644 fs/bcachefs/keylist.h
 create mode 100644 fs/bcachefs/keylist_types.h
 create mode 100644 fs/bcachefs/logged_ops.c
 create mode 100644 fs/bcachefs/logged_ops.h
 create mode 100644 fs/bcachefs/lru.c
 create mode 100644 fs/bcachefs/lru.h
 create mode 100644 fs/bcachefs/mean_and_variance.c
 create mode 100644 fs/bcachefs/mean_and_variance.h
 create mode 100644 fs/bcachefs/mean_and_variance_test.c
 create mode 100644 fs/bcachefs/migrate.c
 create mode 100644 fs/bcachefs/migrate.h
 create mode 100644 fs/bcachefs/move.c
 create mode 100644 fs/bcachefs/move.h
 create mode 100644 fs/bcachefs/move_types.h
 create mode 100644 fs/bcachefs/movinggc.c
 create mode 100644 fs/bcachefs/movinggc.h
 create mode 100644 fs/bcachefs/nocow_locking.c
 create mode 100644 fs/bcachefs/nocow_locking.h
 create mode 100644 fs/bcachefs/nocow_locking_types.h
 create mode 100644 fs/bcachefs/opts.c
 create mode 100644 fs/bcachefs/opts.h
 create mode 100644 fs/bcachefs/printbuf.c
 create mode 100644 fs/bcachefs/printbuf.h
 create mode 100644 fs/bcachefs/quota.c
 create mode 100644 fs/bcachefs/quota.h
 create mode 100644 fs/bcachefs/quota_types.h
 create mode 100644 fs/bcachefs/rebalance.c
 create mode 100644 fs/bcachefs/rebalance.h
 create mode 100644 fs/bcachefs/rebalance_types.h
 create mode 100644 fs/bcachefs/recovery.c
 create mode 100644 fs/bcachefs/recovery.h
 create mode 100644 fs/bcachefs/recovery_types.h
 create mode 100644 fs/bcachefs/reflink.c
 create mode 100644 fs/bcachefs/reflink.h
 create mode 100644 fs/bcachefs/replicas.c
 create mode 100644 fs/bcachefs/replicas.h
 create mode 100644 fs/bcachefs/replicas_types.h
 create mode 100644 fs/bcachefs/sb-clean.c
 create mode 100644 fs/bcachefs/sb-clean.h
 create mode 100644 fs/bcachefs/sb-members.c
 create mode 100644 fs/bcachefs/sb-members.h
 create mode 100644 fs/bcachefs/seqmutex.h
 create mode 100644 fs/bcachefs/siphash.c
 create mode 100644 fs/bcachefs/siphash.h
 create mode 100644 fs/bcachefs/six.c
 create mode 100644 fs/bcachefs/six.h
 create mode 100644 fs/bcachefs/snapshot.c
 create mode 100644 fs/bcachefs/snapshot.h
 create mode 100644 fs/bcachefs/str_hash.h
 create mode 100644 fs/bcachefs/subvolume.c
 create mode 100644 fs/bcachefs/subvolume.h
 create mode 100644 fs/bcachefs/subvolume_types.h
 create mode 100644 fs/bcachefs/super-io.c
 create mode 100644 fs/bcachefs/super-io.h
 create mode 100644 fs/bcachefs/super.c
 create mode 100644 fs/bcachefs/super.h
 create mode 100644 fs/bcachefs/super_types.h
 create mode 100644 fs/bcachefs/sysfs.c
 create mode 100644 fs/bcachefs/sysfs.h
 create mode 100644 fs/bcachefs/tests.c
 create mode 100644 fs/bcachefs/tests.h
 create mode 100644 fs/bcachefs/trace.c
 create mode 100644 fs/bcachefs/trace.h
 create mode 100644 fs/bcachefs/two_state_shared_lock.c
 create mode 100644 fs/bcachefs/two_state_shared_lock.h
 create mode 100644 fs/bcachefs/util.c
 create mode 100644 fs/bcachefs/util.h
 create mode 100644 fs/bcachefs/varint.c
 create mode 100644 fs/bcachefs/varint.h
 create mode 100644 fs/bcachefs/vstructs.h
 create mode 100644 fs/bcachefs/xattr.c
 create mode 100644 fs/bcachefs/xattr.h
 rename {drivers/md/bcache => include/linux}/closure.h (93%)
 rename {drivers/md/bcache => lib}/closure.c (88%)

