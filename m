Return-Path: <linux-fsdevel+bounces-49812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E14D5AC31EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 02:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFAC189A872
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 00:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A24919BBC;
	Sun, 25 May 2025 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DSplABVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B98273F9
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748134100; cv=none; b=dlvPl2CZ2k7B01S3Zz+E/7V6IYGJu++IizuZhaf6t4FqmsjlwOJpnYpRwG2KbZnDwOcx3KOQp6u1MeZYNiX17T0H6CLJKAM6EvyrM3Bu7XF770JZXFmdT1WGfkBw9mx5Lb4q0ScYNqgOjkkOfMoVyuQDvjx0BkKRm5fRnL6h+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748134100; c=relaxed/simple;
	bh=yqAU4BjCuVrDRNBfmsj+gyfOYC1V6x66V5Wnj/EZrsA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UwAVLZCr+90GZ2sQWKkdKRWrMZWGNfkzx3220S9ZVIqGleuRS7axQrbsyGbwY+Czj/2zYjUzp+0XD+K/FzLQekrBYuhni3y60vgKseNUyHZBEy8vdNizHB7tynXo/qB8c+mCgxEIczlQFErSfwk1O6PoT99QlHbdA5i4tM828TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DSplABVA; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 24 May 2025 20:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748134080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=hyXuIyDwkdY1bzjsiX8RFNbroW+VWReG5Ev0XoLssvE=;
	b=DSplABVAKkto+an+QZ1UnS/dUjJV+3JKEeFomMd9s3HAatZHiQkaNwyxl1NzjKxhxQCzJb
	FSSQwSu/XvMSjoomrccULkNxYz9Ln9wixBLJsM+T3gJiJ6BbGtMOLBt1PRlED6ZW3Hx1Cq
	NVSTo2lZiRyRqPgt7bbRHHe8eiK4COQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs changes for 6.16
Message-ID: <oxkibsokaa3jw2flrbbzb5brx5ere724f3b2nyr2t5nsqfjw4u@23q3ardus43h>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit 010c89468134d1991b87122379f86feae23d512f:

  bcachefs: Check for casefolded dirents in non casefolded dirs (2025-05-21 20:13:14 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-05-24

for you to fetch changes up to 9caea9208fc3fbdbd4a41a2de8c6a0c969b030f9:

  bcachefs: Don't mount bs > ps without TRANSPARENT_HUGEPAGE (2025-05-23 22:00:07 -0400)

----------------------------------------------------------------
bcachefs updates for 6.16

Lots of changes:

- Poisoned extents can now be moved: this lets us handle bitrotted data
  without deleting it. For now, reading from poisoned extents only
  returns -EIO: in the future we'll have an API for specifying "read
  this data even if there were bitflips".

- Incompatible features may now be enabled at runtime, via
  "opts/version_upgrade" in sysfs. Toggle it to incompatible, and then
  toggle it back - option changes via the sysfs interface are
  persistent.

- Various changes to support deployable disk images:
  - RO mounts now use less memory
  - Images may be stripped of alloc info, particularly useful for
    slimming them down if they will primarily be mounted RO. Alloc info
    will be automatically regenerated on first RW mount, and this is
    quite fast.
  - Filesystem images generated with 'bcachefs image' will be
    automatically resized the first time they're mounted on a larger
    device.

    The images 'bcachefs image' generates with compression enabled have
    been comparable in size to those generated by squashfs and erofs -
    but you get a full RW capable filesystem.

- Major error message improvements for btree node reads, data reads,
  and elsewhere. We now build up a single error message that lists all
  the errors encountered, actions taken to repair, and success/failure
  of the IO. This extends to other error paths that may kick off other
  actions, e.g. scheduling recovery passes: actions we took because of
  an error are included in that error message, with grouping/indentation
  so we can see what caused what.

- Repair/self healing:
  - We can now kick off recovery passes and run them in the background
    if we detect errors. Currently, this is just used by code that walks
    backpointers; we now also check for missing backpointers at runtime
    and run check_extents_to_backpointers if required. The messy 6.14
    upgrade left missing backpointers for some users, and this will
    correct that automatically instead of requiring a manual fsck - some
    users noticed this as copygc spinning and not making progress.

    In the future, as more recovery passes come online, we'll be able to
    repair and recover from nearly anything - except for unreadable
    btree nodes, and that's why you're using replication, of course -
    without shutting down the filesystem.

  - There's a new recovery pass, for checking the rebalance_work btree,
    which tracks extents that rebalance will process later.

- Hardening:
  - Close the last known hole in btree iterator/btree locking
    assertions: path->should_be_locked paths must stay locked until the
    end of the transaction. This shook out a few bugs, including a
    performance issue that was causing unnecessary path_upgrade
    transaction restarts.

- Performance;
  - Faster snapshot deletion: this is an incompatible feature, as it
    requires new sentinal values, for safety. Snapshot deletion no
    longer has to do a full metadata scan, it now just scans the inodes
    btree: if an extent/dirent/xattr is present for a given snapshot ID,
    we already require that an inode be present with that same snapshot
    ID.

    If/when users hit scalability limits again (ridiculously huge
    filesystems with lots of inodes, and many sparse snapshots), let me
    know - the next step will be to add an index from snapshot ID ->
    inode number, which won't be too hard.

  - Faster device removal: the "scan for pointers to this device" no
    longer does a full metadata scan, instead it walks backpointers.
    Like fast snapshot deletion this is another incompat feature: it
    also requires a new sentinal value, because we don't want to reuse
    these device IDs until after a fsck.

  - We're now coalescing redundant accounting updates prior to
    transaction commit, taking some pressure off the journal. Shortly
    we'll also be doing multiple extent updates in a transaction in the
    main write path, which combined with the previous should drastically
    cut down on the amount of metadata updates we have to journal.

- Stack usage improvements: All allocator state has been moved off the
  stack

- Debug improvements:
  - enumerated refcounts: The debug code previously used for filesystem
    write refs is now a small library, and used for other heavily used
    refcounts. Different users of a refcount are enumerated, making it
    much easier to debug refcount issues.

  - Async object debugging: There's a new kconfig option that makes
    various async objects (different types of bios, data updates, write
    ops, etc.) visible in debugfs, and it should be fast enough to leave
    on in production.

  - Various sets of assertions no longer require CONFIG_BCACHEFS_DEBUG,
    instead they're controlled by module parameters and static keys,
    meaning users won't need to compile custom kernels as often to help
    debug issues.

  - bch2_trans_kmalloc() calls can be tracked (there's a new kconfig
    option); with it on you can check the btree_transaction_stats in
    debugfs to see the bch2_trans_kmalloc() calls a transaction did when
    it used the most memory.

----------------------------------------------------------------
Alan Huang (9):
      bcachefs: Kill bch2_trans_unlock_noassert
      bcachefs: Remove spurious +1/-1 operation
      bcachefs: Simplify logic
      bcachefs: Kill dead code
      bcachefs: Rename x_name to x_name_and_value
      bcachefs: Fix inconsistent req->ec
      bcachefs: Kill BTREE_TRIGGER_bucket_invalidate
      bcachefs: Early return to avoid unnecessary lock
      bcachefs: Remove duplicate call to bch2_trans_begin()

Gustavo A. R. Silva (1):
      bcachefs: Avoid -Wflex-array-member-not-at-end warnings

Integral (3):
      bcachefs: early return for negative values when parsing BCH_OPT_UINT
      bcachefs: split error messages of invalid compression into two lines
      bcachefs: indent error messages of invalid compression

Kent Overstreet (203):
      bcachefs: bch2_subvolume_wait_for_pagecache_and_delete() cleanup
      bcachefs: Be precise about bch_io_failures
      bcachefs: Poison extents that can't be read due to checksum errors
      bcachefs: Data move can read from poisoned extents
      bcachefs: Rebalance now skips poisoned extents
      bcachefs: trace bch2_trans_kmalloc()
      bcachefs: struct alloc_request
      bcachefs: alloc_request.data_type
      bcachefs: bch2_bucket_alloc_trans() takes alloc_request
      bcachefs: bch2_ec_stripe_head_get() takes alloc_request
      bcachefs: new_stripe_alloc_buckets() takes alloc_request
      bcachefs: alloc_request: deallocate_extra_replicas()
      bcachefs: alloc_request.usage
      bcachefs: alloc_request.counters
      bcachefs: alloc_request.ca
      bcachefs: alloc_request.ptrs2
      bcachefs: alloc_request no longer on stack
      bcachefs: reduce new_stripe_alloc_buckets() stack usage
      bcachefs: darray: provide typedefs for primitive types
      bcachefs: bch2_snapshot_table_make_room()
      bcachefs: add missing include
      bcachefs: bch2_kvmalloc() mem alloc profiling
      bcachefs: btree_io_complete_wq -> btree_write_complete_wq
      bcachefs: simplify journal pin initialization
      bcachefs: alphabetize init function calls
      bcachefs: Move various init code to _init_early()
      bcachefs: RO mounts now use less memory
      bcachefs: move_data_phys: stats are not required
      bcachefs: export bch2_chacha20
      bcachefs: Improve opts.degraded
      bcachefs: kill BTREE_CACHE_NOT_FREED_INCREMENT()
      bcachefs: __btree_node_reclaim_checks()
      bcachefs: Improve bch2_btree_cache_to_text()
      bcachefs: bch2_dev_journal_alloc() now respects data_allowed
      bcachefs: bch2_dev_allocator_set_rw()
      bcachefs: Clean up duplicated code in bch2_journal_halt()
      bcachefs: Initialize c->name earlier on single dev filesystems
      bcachefs: Single device mode
      bcachefs: Use drop_locks_do() in bch2_inode_hash_find()
      bcachefs: Clean up option pre/post hooks, small fixes
      bcachefs: Incompatible features may now be enabled at runtime
      bcachefs: bch2_run_explicit_recovery_pass_printbuf()
      bcachefs: Simplify bch2_count_fsck_err()
      bcachefs: bch2_dev_missing_bkey()
      bcachefs: print_str_as_lines() -> print_str()
      bcachefs: Flag for repair on missing subvolume
      bcachefs: Add a recovery pass for making sure root inode is readable
      bcachefs: sb_validate() no longer requires members_v1
      bcachefs: Shrink superblock downgrade table
      bcachefs: Print features on startup with -o verbose
      bcachefs: BCH_FEATURE_no_alloc_info
      bcachefs: BCH_FEATURE_small_image
      bcachefs: BCH_MEMBER_RESIZE_ON_MOUNT
      bcachefs: export bch2_move_data_phys()
      bcachefs: Plumb target parameter through btree_node_rewrite_pos()
      bcachefs: plumb btree_id through move_pred_fd
      bcachefs: bch2_move_data_btree() can move btree nodes
      bcachefs: bch2_move_data_btree() can now walk roots
      docs: bcachefs: idle work scheduling design doc
      bcachefs: Fix struct with flex member ABI warning
      bcachefs: bch2_check_rebalance_work()
      bcachefs: bch2_target_to_text() no longer depends on io_ref
      bcachefs: recalc_capacity() no longer depends on io_ref
      bcachefs: for_each_online_member_rcu()
      bcachefs: __bch2_fs_read_write() no longer depends on io_ref
      bcachefs: for_each_rw_member_rcu()
      bcachefs: enumerated_ref.c
      bcachefs: bch_fs.writes -> enumerated_refs
      bcachefs: bch_dev.io_ref -> enumerated_ref
      bcachefs: bch2_bio_to_text()
      bcachefs: bch2_read_bio_to_text
      bcachefs: fast_list
      bcachefs: Async object debugging
      bcachefs: Make various async objs visible in debugfs
      bcachefs: print_string_as_lines: avoid printing empty line
      bcachefs: bch2_io_failures_to_text()
      bcachefs: Emit a single log message on data read error
      bcachefs: Kill redundant error message in topology repair
      bcachefs: bch2_btree_lost_data() now handles snapshots tree
      bcachefs: Remove redundant calls to btree_lost_data()
      bcachefs: kill bch2_run_explicit_recovery_pass_persistent()
      bcachefs: Plumb printbuf through bch2_btree_lost_data()
      bcachefs: bch2_fsck_err_opt()
      bcachefs: bch2_mark_btree_validate_failure()
      bcachefs: Single err message for btree node reads
      bcachefs: bch2_dirent_to_text() shows casefolded dirents
      bcachefs: provide unlocked version of run_explicit_recovery_pass_persistent
      bcachefs: Run most explicit recovery passes persistent
      bcachefs: bch2_trans_update_ip()
      bcachefs: bch2_fs_open() now takes a darray
      bcachefs: bch2_dev_add() can run on a non-started fs
      bcachefs: sysfs trigger_recalc_capacity
      bcachefs: Fix setting ca->name in device add
      docs: bcachefs: add casefolding reference
      bcachefs: Improve bch2_disk_groups_to_text()
      bcachefs: Don't emit bch_sb_field_members_v1 if not required
      bcachefs: snapshot delete progress indicator
      bcachefs: Add comments for inode snapshot requirements
      bcachefs: kill inode_walker_entry.snapshot
      bcachefs: Improve bch2_request_incompat_feature() message
      bcachefs: bch2_inode_unpack() cleanup
      bcachefs: get_inodes_all_snapshots() now includes whiteouts
      bcachefs: BCH_FSCK_ERR_snapshot_key_missing_inode_snapshot
      bcachefs: Skip unrelated snapshot trees in snapshot deletion
      bcachefs: BCH_SNAPSHOT_DELETED -> BCH_SNAPSHOT_WILL_DELETE
      bcachefs: bcachefs_metadata_version_snapshot_deletion_v2
      bcachefs: delete_dead_snapshot_keys_v2()
      bcachefs: bch2_journal_write() refactoring
      bcachefs: bch2_dev_in_target() no longer takes rcu_read_lock()
      bcachefs: inline bch2_ob_ptr()
      bcachefs: improve check_inode_hash_info_matches_root() error message
      bcachefs: Improve bch2_extent_ptr_set_cached()
      bcachefs: __bch2_fs_free() cleanup
      bcachefs: opts.rebalance_on_ac_only
      bcachefs: bch2_dev_remove_stripes() respects degraded flags
      bcachefs: BCH_SB_MEMBER_DELETED_UUID
      bcachefs: bch2_dev_data_drop_by_backpointers()
      bcachefs: bcachefs_metadata_version_fast_device_removal
      bcachefs: Knob for manual snapshot deletion
      bcachefs: Add missing include
      bcachefs: bch2_copygc_dev_wait_amount()
      bcachefs: buckets_in_flight on stack
      bcachefs: kill dead code in move_data_phys()
      bcachefs: delete dead items in bch_dev
      bcachefs: "buckets with backpointer mismatches" now allocated on demand
      bcachefs: print label correctly in sb_member_to_text()
      bcachefs: recovery_passes_types.h -> recovery_passes_format.h
      bcachefs: bch_sb_field_recovery_passes
      bcachefs: online_fsck_mutex -> run_recovery_passes_lock
      bcachefs: Slim down inlined part of bch2_btree_path_upgrade()
      bcachefs: Debug params are now static_keys
      bcachefs: debug_check_btree_locking modparam
      bcachefs: debug_check_iterators no longer requires BCACHEFS_DEBUG
      bcachefs: debug_check_bset_lookups
      bcachefs: debug_check_bkey_unpack
      bcachefs: Rename fsck_running, recovery_running flags
      bcachefs: Don't rewind recovery if not in recovery
      bcachefs: add missing locking in bch2_write_point_to_text()
      bcachefs: Extra write buffer asserts
      bcachefs: bch2_fs_emergency_read_only2()
      bcachefs: kill move_bucket_in_flight
      bcachefs: Move pending buckets queue to buckets_in_flight
      bcachefs: move_buckets in rhashtable when allocated
      bcachefs: Add tracepoint, counter for io_move_created_rebalance
      bcachefs: fix can_write_extent()
      bcachefs: Fix opt hooks in sysfs for non sb option
      bcachefs: bch2_inode_find_snapshot_root()
      bcachefs: Improve bch2_repair_inode_hash_info()
      bcachefs: better error message for subvol_fs_path_parent_wrong
      bcachefs: do_rebalance_scan() now only updates bch_extent_rebalance
      bcachefs: relock_fail tracepoint now includes btree
      bcachefs: journal path now uses discard_opt_enabled()
      bcachefs: btree key cache asserts
      bcachefs: Optimize bch2_trans_start_alloc_update()
      bcachefs: kill copy in bch2_disk_accounting_mod()
      bcachefs: struct bch_fs_recovery
      bcachefs: __bch2_run_recovery_passes()
      bcachefs: Reduce usage of recovery.curr_pass
      bcachefs: bch2_recovery_pass_status_to_text()
      bcachefs: bch2_run_explicit_recovery_pass() cleanup
      bcachefs: Run recovery passes asynchronously
      bcachefs: Improve bucket_bitmap code
      bcachefs: bch2_check_bucket_backpointer_mismatch()
      bcachefs: fsck: Include loops in error messages
      bcachefs: fix bch2_debugfs_flush_buf() when tabstops are in use
      bcachefs: async objs now support bch_write_ops
      bcachefs: Make accounting mismatch errors more readable
      bcachefs: btree_trans_subbuf
      bcachefs: Split out accounting in transaction commit
      bcachefs: Coalesce accounting in trans commit
      bcachefs: Simplify bch2_extent_atomic_end()
      bcachefs: Call bch2_bkey_set_needs_rebalance() earlier in write path
      bcachefs: Don't set bi_casefold on non directories
      bcachefs: subvol_inum_eq()
      bcachefs: bch2_rename_trans() only runs rename-to-dir code if needed
      bcachefs: bch2_inum_snapshot_to_path()
      bcachefs: bch2_inode_find_by_inum_snapshot()
      bcachefs: BCH_INODE_has_case_insensitive
      bcachefs: fix duplicate printk
      bcachefs: fix bch2_inum_snapshot_to_path()
      bcachefs: Improve trace_trans_restart_upgrade
      bcachefs: Drop empty accounting updates
      bcachefs: Kill bkey_buf usage in data_update_index_update()
      bcachefs: bch2_trans_log_str()
      bcachefs: Reduce stack usage in data_update_index_update()
      bcachefs: bch2_journal_write_checksum()
      bcachefs: Kill bch2_path_put_nokeep()
      bcachefs: btree_node_locked_type_nowrite()
      bcachefs: Fix btree_path_get_locks when not doing trans restart
      bcachefs: Give out new path if upgrade fails
      bcachefs: bch2_path_get() reuses paths if upgrade_fails & !should_be_locked
      bcachefs: Clear should_be_locked before unlock in key_cache_drop()
      bcachefs: Clear trans->locked before unlock
      bcachefs: Plumb btree_trans for more locking asserts
      bcachefs: Simplify bch2_path_put()
      bcachefs: Path must be locked if trans->locked && should_be_locked
      bcachefs: Fix endianness in casefold check/repair
      bcachefs: Fix allocate -> self healing path
      bcachefs: Fix opts.recovery_pass_last
      bcachefs: Small check_fix_ptr fixes
      bcachefs: Ensure we don't use a blacklisted journal seq
      bcachefs: Fix btree_iter_next_node() for new locking asserts
      bcachefs: Don't mount bs > ps without TRANSPARENT_HUGEPAGE

Roxana Nicolescu (2):
      bcachefs: replace strncpy() with memcpy_and_pad in journal_transaction_name
      bcachefs: replace memcpy with memcpy_and_pad for jset_entry_log->d buff

 Documentation/filesystems/bcachefs/casefolding.rst |  18 +
 .../filesystems/bcachefs/future/idle_work.rst      |  78 +++
 Documentation/filesystems/bcachefs/index.rst       |   7 +
 fs/bcachefs/Kconfig                                |   8 +
 fs/bcachefs/Makefile                               |   4 +
 fs/bcachefs/alloc_background.c                     | 167 ++---
 fs/bcachefs/alloc_background.h                     |   1 +
 fs/bcachefs/alloc_foreground.c                     | 530 +++++++---------
 fs/bcachefs/alloc_foreground.h                     |  69 ++-
 fs/bcachefs/alloc_types.h                          |  16 -
 fs/bcachefs/async_objs.c                           | 132 ++++
 fs/bcachefs/async_objs.h                           |  44 ++
 fs/bcachefs/async_objs_types.h                     |  25 +
 fs/bcachefs/backpointers.c                         | 256 +++++---
 fs/bcachefs/backpointers.h                         |  14 +-
 fs/bcachefs/bcachefs.h                             | 225 +++----
 fs/bcachefs/bcachefs_format.h                      |  30 +-
 fs/bcachefs/bkey.c                                 |  47 +-
 fs/bcachefs/bkey.h                                 |   4 +-
 fs/bcachefs/bkey_methods.c                         |   2 +-
 fs/bcachefs/bset.c                                 |  64 +-
 fs/bcachefs/bset.h                                 |  22 +-
 fs/bcachefs/btree_cache.c                          | 184 +++---
 fs/bcachefs/btree_gc.c                             |  32 +-
 fs/bcachefs/btree_gc.h                             |   3 +-
 fs/bcachefs/btree_io.c                             | 346 ++++++-----
 fs/bcachefs/btree_io.h                             |  12 +-
 fs/bcachefs/btree_iter.c                           | 277 +++++----
 fs/bcachefs/btree_iter.h                           |  85 ++-
 fs/bcachefs/btree_key_cache.c                      |  36 +-
 fs/bcachefs/btree_locking.c                        | 196 +++---
 fs/bcachefs/btree_locking.h                        |  72 ++-
 fs/bcachefs/btree_node_scan.c                      |  18 +-
 fs/bcachefs/btree_trans_commit.c                   |  79 ++-
 fs/bcachefs/btree_types.h                          |  31 +-
 fs/bcachefs/btree_update.c                         |  74 ++-
 fs/bcachefs/btree_update.h                         |  68 ++-
 fs/bcachefs/btree_update_interior.c                |  50 +-
 fs/bcachefs/btree_update_interior.h                |   6 +-
 fs/bcachefs/btree_write_buffer.c                   |  20 +-
 fs/bcachefs/btree_write_buffer.h                   |   1 +
 fs/bcachefs/buckets.c                              |  69 ++-
 fs/bcachefs/chardev.c                              |   6 +-
 fs/bcachefs/checksum.c                             |   4 +-
 fs/bcachefs/checksum.h                             |   2 +
 fs/bcachefs/compress.c                             |   4 +-
 fs/bcachefs/darray.h                               |  13 +-
 fs/bcachefs/data_update.c                          | 207 ++++---
 fs/bcachefs/data_update.h                          |  15 +
 fs/bcachefs/debug.c                                |  85 +--
 fs/bcachefs/debug.h                                |  20 +-
 fs/bcachefs/dirent.c                               |  13 +-
 fs/bcachefs/disk_accounting.c                      | 111 ++--
 fs/bcachefs/disk_accounting.h                      |  12 +-
 fs/bcachefs/disk_groups.c                          | 123 ++--
 fs/bcachefs/ec.c                                   | 218 ++++---
 fs/bcachefs/ec.h                                   |   9 +-
 fs/bcachefs/ec_types.h                             |   7 +-
 fs/bcachefs/enumerated_ref.c                       | 144 +++++
 fs/bcachefs/enumerated_ref.h                       |  66 ++
 fs/bcachefs/enumerated_ref_types.h                 |  19 +
 fs/bcachefs/errcode.h                              |   7 +-
 fs/bcachefs/error.c                                | 113 ++--
 fs/bcachefs/error.h                                |  15 +-
 fs/bcachefs/extent_update.c                        |  67 +-
 fs/bcachefs/extent_update.h                        |   2 +-
 fs/bcachefs/extents.c                              | 136 ++++-
 fs/bcachefs/extents.h                              |   3 +
 fs/bcachefs/extents_types.h                        |   1 +
 fs/bcachefs/fast_list.c                            | 156 +++++
 fs/bcachefs/fast_list.h                            |  41 ++
 fs/bcachefs/fs-io-direct.c                         |   7 +-
 fs/bcachefs/fs-io.c                                |  26 +-
 fs/bcachefs/fs-ioctl.c                             |  14 +-
 fs/bcachefs/fs.c                                   |  30 +-
 fs/bcachefs/fsck.c                                 | 376 ++++++------
 fs/bcachefs/inode.c                                | 128 ++--
 fs/bcachefs/inode.h                                |  35 +-
 fs/bcachefs/inode_format.h                         |   7 +-
 fs/bcachefs/io_read.c                              | 309 +++++++---
 fs/bcachefs/io_read.h                              |  19 +-
 fs/bcachefs/io_write.c                             |  58 +-
 fs/bcachefs/io_write.h                             |  28 -
 fs/bcachefs/io_write_types.h                       |  32 +
 fs/bcachefs/journal.c                              |  86 ++-
 fs/bcachefs/journal.h                              |   3 +-
 fs/bcachefs/journal_io.c                           | 171 +++---
 fs/bcachefs/journal_reclaim.c                      |  39 +-
 fs/bcachefs/journal_seq_blacklist.c                |  10 +
 fs/bcachefs/journal_seq_blacklist.h                |   1 +
 fs/bcachefs/journal_types.h                        |   2 -
 fs/bcachefs/migrate.c                              | 117 +++-
 fs/bcachefs/migrate.h                              |   3 +-
 fs/bcachefs/move.c                                 | 201 ++++--
 fs/bcachefs/move.h                                 |  17 +-
 fs/bcachefs/move_types.h                           |   8 +-
 fs/bcachefs/movinggc.c                             | 217 +++----
 fs/bcachefs/movinggc.h                             |   2 +-
 fs/bcachefs/namei.c                                | 258 ++++++--
 fs/bcachefs/namei.h                                |   7 +
 fs/bcachefs/nocow_locking.c                        |   4 +-
 fs/bcachefs/nocow_locking.h                        |   2 +-
 fs/bcachefs/opts.c                                 | 170 +++++-
 fs/bcachefs/opts.h                                 |  38 +-
 fs/bcachefs/rebalance.c                            | 224 ++++++-
 fs/bcachefs/rebalance.h                            |   6 +-
 fs/bcachefs/rebalance_types.h                      |   5 +
 fs/bcachefs/recovery.c                             | 134 ++--
 fs/bcachefs/recovery.h                             |   3 +-
 fs/bcachefs/recovery_passes.c                      | 599 +++++++++++++-----
 fs/bcachefs/recovery_passes.h                      |  26 +-
 fs/bcachefs/recovery_passes_format.h               | 104 ++++
 fs/bcachefs/recovery_passes_types.h                |  93 +--
 fs/bcachefs/reflink.c                              |   5 +-
 fs/bcachefs/sb-counters_format.h                   |   2 +
 fs/bcachefs/sb-downgrade.c                         |   9 +-
 fs/bcachefs/sb-errors_format.h                     |   2 +-
 fs/bcachefs/sb-members.c                           |  77 ++-
 fs/bcachefs/sb-members.h                           |  62 +-
 fs/bcachefs/sb-members_format.h                    |   6 +
 fs/bcachefs/sb-members_types.h                     |   1 +
 fs/bcachefs/snapshot.c                             | 503 +++++++++++----
 fs/bcachefs/snapshot.h                             |  35 +-
 fs/bcachefs/snapshot_format.h                      |   4 +-
 fs/bcachefs/snapshot_types.h                       |  57 ++
 fs/bcachefs/str_hash.c                             | 137 +++--
 fs/bcachefs/str_hash.h                             |  10 +-
 fs/bcachefs/subvolume.c                            |  63 +-
 fs/bcachefs/subvolume.h                            |   5 +-
 fs/bcachefs/subvolume_types.h                      |  27 -
 fs/bcachefs/super-io.c                             |  63 +-
 fs/bcachefs/super-io.h                             |   1 +
 fs/bcachefs/super.c                                | 678 ++++++++++++++-------
 fs/bcachefs/super.h                                |   9 +-
 fs/bcachefs/sysfs.c                                | 108 ++--
 fs/bcachefs/trace.h                                |  58 +-
 fs/bcachefs/util.c                                 |  41 +-
 fs/bcachefs/util.h                                 |  17 +-
 fs/bcachefs/xattr.c                                |  23 +-
 fs/bcachefs/xattr.h                                |   4 +-
 fs/bcachefs/xattr_format.h                         |   4 +-
 141 files changed, 7129 insertions(+), 3542 deletions(-)
 create mode 100644 Documentation/filesystems/bcachefs/future/idle_work.rst
 create mode 100644 fs/bcachefs/async_objs.c
 create mode 100644 fs/bcachefs/async_objs.h
 create mode 100644 fs/bcachefs/async_objs_types.h
 create mode 100644 fs/bcachefs/enumerated_ref.c
 create mode 100644 fs/bcachefs/enumerated_ref.h
 create mode 100644 fs/bcachefs/enumerated_ref_types.h
 create mode 100644 fs/bcachefs/fast_list.c
 create mode 100644 fs/bcachefs/fast_list.h
 create mode 100644 fs/bcachefs/recovery_passes_format.h
 create mode 100644 fs/bcachefs/snapshot_types.h

