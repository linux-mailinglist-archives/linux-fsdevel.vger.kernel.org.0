Return-Path: <linux-fsdevel+bounces-44892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A57EA6E2CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 19:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DE8170F3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 18:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD56266F1A;
	Mon, 24 Mar 2025 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="et3Kqe9K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B87266F1B
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842598; cv=none; b=PT9Tvx0+1eiakzGTQBRjAR7AfcgcaQ2Bu/robtu6iwOAO+lhxgwNL2OTsJScoseKiPC1o3+6fETXbMxUazQMNIW1XM12N9IGOix27MwHj19vaU0XXOS2yJpLYx4xnF7CzA31+jb6g5oec2psnnBDD5JOfndy/RWyRd52f5TjCFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842598; c=relaxed/simple;
	bh=1TcaadcY4bmVAwckhloPWacW2IbjNdzkPNnN6utmbVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UXoCc3f3Bo9fGbF52v1U8HHfHTxr1eLuMthya2NOR16CfhS6jzgvh8x/cEPz7hGuwdr7NDqB+dKexsL7KyOdGN95jtwozAszC051wiSA/3IlHhsZoqx7Y+dS6o3/hLq4zcYSWp1d/FKQnAk8sen7KOBzwTTuKbYWze36CM3hCrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=et3Kqe9K; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 24 Mar 2025 14:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742842582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=E4TdI4LLIfJIGfUlZ0Jxo34ngrv/UwkA/i5zLJYwiDA=;
	b=et3Kqe9KFMbugCaLnMFt71/Lidq3x8KQGXs1XX8pwdqjcAhawWJ0HCL7CRXZKuq6a0ukcy
	9HRdTqar7+n48jWWnEgEi1B5PI6mbP2dS+uXqF/Z8rQF1dXicqxhD0M6OsuARGzQGKok5G
	xf7cVWTC6YjecF+IBB9PVUbj/ktWvB0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs for 6.15, v2...
Message-ID: <wg47lanrvfqkqdospive4b3ymc5snuhqdygcle33q3cxudw3xl@rkllblbmre4v>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit 1a2b74d0a2a46c219b25fdb0efcf9cd7f55cfe5e:

  bcachefs: fix build on 32 bit in get_random_u64_below() (2025-03-14 19:45:54 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-03-24

for you to fetch changes up to d8bdc8daac1d1b0a4efb1ecc69bef4eb4fc5e050:

  bcachefs: Kill unnecessary bch2_dev_usage_read() (2025-03-24 09:50:37 -0400)

----------------------------------------------------------------
bcachefs updates for 6.15

On disk format is now soft frozen: no more required/automatic are
anticipated before taking off the experimental label.

Major changes/features since 6.14:

- Scrub

- Blocksize greater than page size support

- A number of "rebalance spinning and doing no work" issues have been
  fixed; we now check if the write allocation will succeed in
  bch2_data_update_init(), before kicking off the read.

  There's still more work to do in this area. Later we may want to add
  another bitset btree, like rebalance_work, to track "extents that
  rebalance was requested to move but couldn't", e.g. due to destination
  target having insufficient online devices.

- We can now support scaling well into the petabyte range: latest
  bcachefs-tools will pick an appropriate bucket size at format time to
  ensure fsck can run in available memory (e.g. a server with 256GB of
  ram and 100PB of storage would want 16MB buckets).

On disk format changes:

- 1.21: cached backpointers (scalability improvement)

  Cached replicas now get backpointers, which means we no longer rely on
  incrementing bucket generation numbers to invalidate cached data: this
  lets us get rid of the bucket generation number garbage collection,
  which had to periodically rescan all extents to recompute bucket
  oldest_gen.

  Bucket generation numbers are now only used as a consistency check,
  but they're quite useful for that.

- 1.22: stripe backpointers

  Stripes now have backpointers: erasure coded stripes have their own
  checksums, separate from the checksums for the extents they contain
  (and stripe checksums also cover the parity blocks). This is required
  for implementing scrub for stripes.

- 1.23: stripe lru (scalability improvement)

  Persistent lru for stripes, ordered by "number of empty blocks". This
  is used by the stripe creation path, which depending on free space
  may create a new stripe out of a partially empty existing stripe
  instead of starting a brand new stripe.

  This replaces an in-memory heap, and means we no longer have to read
  in the stripes btree at startup.

- 1.24: casefolding

  Case insensitive directory support, courtesy of Valve.

  This is an incompatible feature, to enable mount with
    -o version_upgrade=incompatible

- 1.25: extent_flags

  Another incompatible feature requiring explicit opt-in to enable.

  This adds a flags entry to extents, and a flag bit that marks extents
  as poisoned.

  A poisoned extent is an extent that was unreadable due to checksum
  errors. We can't move such extents without giving them a new checksum,
  and we may have to move them (for e.g. copygc or device evacuate).
  We also don't want to delete them: in the future we'll have an API
  that lets userspace ignore checksum errors and attempt to deal with
  simple bitrot itself. Marking them as poisoned lets us continue to
  return the correct error to userspace on normal read calls.

Other changes/features:

- BCH_IOCTL_QUERY_COUNTERS: this is used by the new 'bcachefs fs top'
  command, which shows a live view of all internal filesystem counters.

- Improved journal pipelining: we can now have 16 journal writes in
  flight concurrently, up from 4. We're logging significantly more to
  the journal than we used to with all the recent disk accounting
  changes and additions, so some users should see a performance
  increase on some workloads.

- BCH_MEMBER_STATE_failed: previously, we would do no IO at all to
  devices marked as failed. Now we will attempt to read from them, but
  only if we have no better options.

- New option, write_error_timeout: devices will be kicked out of the
  filesystem if all writes have been failing for x number of seconds.

  We now also kick devices out when notified by blk_holder_ops that
  they've gone offline.

- Device option handling improvements: the discard option should now be
  working as expected (additionally, in -tools, all device options that
  can be set at format time can now be set at device add time, i.e.
  data_allowed, state).

- We now try harder to read data after a checksum error: we'll do
  additional retries if necessary to a device after after it gave us
  data with a checksum error.

- More self healing work: the full inode <-> dirent consistency checks
  that are currently run by fsck are now also run every time we do a
  lookup, meaning we'll be able to correct errors at runtime. Runtime
  self healing will be flipped on after the new changes have seen more
  testing, currently they're just checking for consistency.

- KMSAN fixes: our KMSAN builds should be nearly clean now, which will
  put a massive dent in the syzbot dashboard.

----------------------------------------------------------------
Alan Huang (5):
      bcachefs: Fix subtraction underflow
      bcachefs: Increase blacklist range
      bcachefs: Fix incorrect state count
      bcachefs: Remove spurious smp_mb()
      bcachefs: Add missing smp_rmb()

Andreas Gruenbacher (20):
      bcachefs: bch2_blacklist_entries_gc cleanup
      bcachefs: EYTZINGER_DEBUG fix
      bcachefs: eytzinger self tests: loop cleanups
      bcachefs: eytzinger self tests: missing newline termination
      bcachefs: eytzinger self tests: fix cmp_u16 typo
      bcachefs: eytzinger[01]_test improvement
      bcachefs: eytzinger0_find_test improvement
      bcachefs: add eytzinger0_for_each_prev
      bcachefs: improve eytzinger0_find_le self test
      bcachefs: convert eytzinger0_find_le to be 1-based
      bcachefs: simplify eytzinger0_find_le
      bcachefs: add eytzinger0_find_gt self test
      bcachefs: implement eytzinger0_find_gt directly
      bcachefs: implement eytzinger0_find_ge directly
      bcachefs: add eytzinger0_find_ge self test
      bcachefs: Add eytzinger0_find self test
      bcachefs: convert eytzinger0_find to be 1-based
      bcachefs: convert eytzinger sort to be 1-based (1)
      bcachefs: convert eytzinger sort to be 1-based (2)
      bcachefs: eytzinger1_{next,prev} cleanup

Bagas Sanjaya (7):
      Documentation: bcachefs: casefolding: Do not italicize NUL
      Documentation: bcachefs: casefolding: Fix dentry/dcache considerations section
      Documentation: bcachefs: casefolding: Use bullet list for dirent structure
      Documentation: bcachefs: Add casefolding toctree entry
      Documentation: bcachefs: Split index toctree
      Documentation: bcachefs: SubmittingPatches: Demote section headings
      Documentation: bcachefs: SubmittingPatches: Convert footnotes to reST syntax

Eric Biggers (2):
      bcachefs: Remove unnecessary softdeps on crc32c and crc64
      bcachefs: use sha256() instead of crypto_shash API

Joshua Ashton (2):
      bcachefs: Split out dirent alloc and name initialization
      bcachefs: bcachefs_metadata_version_casefolding

Kent Overstreet (141):
      bcachefs: bs > ps support
      bcachefs: btree_node_(rewrite|update_key) cleanup
      bcachefs: check_bp_exists() check for backpointers for stale pointers
      bcachefs: Fix missing increment of move_extent_write counter
      bcachefs: Don't inc io_(read|write) counters for moves
      bcachefs: Move write_points to debugfs
      bcachefs: Separate running/runnable in wp stats
      bcachefs: enum bch_persistent_counters_stable
      bcachefs: BCH_COUNTER_bucket_discard_fast
      bcachefs: BCH_IOCTL_QUERY_COUNTERS
      bcachefs: bch2_data_update_inflight_to_text()
      bcachefs: kill bch_read_bio.devs_have
      bcachefs: x-macroize BCH_READ flags
      bcachefs: Rename BCH_WRITE flags fer consistency with other x-macros enums
      bcachefs: rbio_init_fragment()
      bcachefs: rbio_init() cleanup
      bcachefs: data_update now embeds bch_read_bio
      bcachefs: promote_op uses embedded bch_read_bio
      bcachefs: bch2_update_unwritten_extent() no longer depends on wbio
      bcachefs: cleanup redundant code around data_update_op initialization
      bcachefs: Be stricter in bch2_read_retry_nodecode()
      bcachefs: Promotes should use BCH_WRITE_only_specified_devs
      bcachefs: Self healing writes are BCH_WRITE_alloc_nowait
      bcachefs: Rework init order in bch2_data_update_init()
      bcachefs: Bail out early on alloc_nowait data updates
      bcachefs: Don't start promotes from bch2_rbio_free()
      bcachefs: Don't self-heal if a data update is already rewriting
      bcachefs: Internal reads can now correct errors
      bcachefs: backpointer_get_key() doesn't pull in btree node
      bcachefs: bch2_btree_node_rewrite_pos()
      bcachefs: bch2_move_data_phys()
      bcachefs: __bch2_move_data_phys() now uses bch2_btree_node_rewrite_pos()
      bcachefs: bch2_bkey_pick_read_device() can now specify a device
      bcachefs: bch2_btree_node_scrub()
      bcachefs: Scrub
      bcachefs: Read/move path counter work
      bcachefs: Convert migrate to move_data_phys()
      bcachefs: bch2_indirect_extent_missing_error() prints path, not just inode number
      bcachefs: bch2_inum_offset_err_msg_trans() no longer handles transaction restarts
      bcachefs: Factor out progress.[ch]
      bcachefs: Add a progress indicator to bch2_dev_data_drop()
      bcachefs: add progress indicator to check_allocations
      bcachefs: Kill journal_res_state.unwritten_idx
      bcachefs: Kill journal_res.idx
      bcachefs: Don't touch journal_buf->data->seq in journal_res_get
      bcachefs: Free journal bufs when not in use
      bcachefs: Increase JOURNAL_BUF_NR
      bcachefs: Ignore backpointers to stripes in ec_stripe_update_extents()
      bcachefs: Add comment explaining why asserts in invalidate_one_bucket() are impossible
      bcachefs: Add time_stat for btree writes
      bcachefs: bch2_bkey_ptr_data_type() now correctly returns cached for cached ptrs
      bcachefs: metadata_target is not an inode option
      bcachefs: bch2_write_op_error() now prints info about data update
      bcachefs: minor journal errcode cleanup
      bcachefs: bch2_lru_change() checks for no-op
      bcachefs: s/BCH_LRU_FRAGMENTATION_START/BCH_LRU_BUCKET_FRAGMENTATION/
      bcachefs: decouple bch2_lru_check_set() from alloc btree
      bcachefs: Rework bch2_check_lru_key()
      bcachefs: bch2_trigger_stripe_ptr() no longer uses ec_stripes_heap_lock
      bcachefs: Better trigger ordering
      bcachefs: rework bch2_trans_commit_run_triggers()
      bcachefs: bcachefs_metadata_version_cached_backpointers
      bcachefs: Invalidate cached data by backpointers
      bcachefs: Advance bch_alloc.oldest_gen if no stale pointers
      bcachefs: bcachefs_metadata_version_stripe_backpointers
      bcachefs: bcachefs_metadata_version_stripe_lru
      bcachefs: Kill dirent_occupied_size() in rename path
      bcachefs: Kill dirent_occupied_size() in create path
      bcachefs: sysfs internal/trigger_btree_updates
      bcachefs: BCH_SB_FEATURES_ALL includes BCH_FEATURE_incompat_verison_field
      bcachefs: bch2_request_incompat_feature() now returns error code
      bcachefs: bcachefs_metadata_version_extent_flags
      bcachefs: give bch2_write_super() a proper error code
      bcachefs: data_update now checks for extents that can't be moved
      bcachefs: Fix read path io_ref handling
      bcachefs: bch2_account_io_completion()
      bcachefs: Finish bch2_account_io_completion() conversions
      bcachefs: Stash a pointer to the filesystem for blk_holder_ops
      bcachefs: Make sure c->vfs_sb is set before starting fs
      bcachefs: Implement blk_holder_ops
      bcachefs: Fix btree_node_scan io_ref handling
      bcachefs: bch2_dev_get_ioref() may now sleep
      bcachefs: Change BCH_MEMBER_STATE_failed semantics
      bcachefs: Kick devices out after too many write IO errors
      bcachefs: journal write path comment
      bcachefs: ec_stripe_delete() uses new stripe lru
      bcachefs: get_existing_stripe() uses new stripe lru
      bcachefs: trace_stripe_create
      bcachefs: We no longer read stripes into memory at startup
      bcachefs: Kill a bit of dead code
      bcachefs: Kill bch2_remount()
      bcachefs: rebalance, copygc status also print stacktrace
      bcachefs: Add a cond_resched() to btree cache teardown
      bcachefs: bch2_bkey_ptrs_rebalance_opts()
      bcachefs: Don't create bch_io_failures unless it's needed
      bcachefs: Debug params for data corruption injection
      bcachefs: Convert read path to standard error codes
      bcachefs: Fix BCH_ERR_data_read_csum_err_maybe_userspace in retry path
      bcachefs: Read error message now indicates if it was for an internal move
      bcachefs: BCH_ERR_data_read_buffer_too_small
      bcachefs: Return errors to top level bch2_rbio_retry()
      bcachefs: Print message on successful read retry
      bcachefs: Checksum errors get additional retries
      bcachefs: BCH_READ_data_update -> bch_read_bio.data_update
      bcachefs: __bch2_read() now takes a btree_trans
      bcachefs: trace_io_move_write_fail
      bcachefs: Improve can_write_extent()
      bcachefs: #if 0 out (enable|disable)_encryption()
      bcachefs: Fix offset_into_extent in data move path
      bcachefs: Better incompat version/feature error messages
      bcachefs: Add missing random.h includes
      bcachefs: bch2_sb_validate() doesn't need bch_sb_handle
      bcachefs: Validate bch_sb.offset field
      bcachefs: Fix btree iter flags in data move
      bcachefs: Kill BCH_DEV_OPT_SETTERS()
      bcachefs: Device options now use standard sysfs code
      bcachefs: Setting foreground_target at runtime now triggers rebalance
      bcachefs: Device state is now a runtime option
      bcachefs: Filesystem discard option now propagates to devices
      bcachefs: Kill JOURNAL_ERRORS()
      bcachefs: Fix block/btree node size defaults
      bcachefs: Simplify bch2_write_op_error()
      bcachefs: bch2_write_prep_encoded_data() now returns errcode
      bcachefs: EIO cleanup
      bcachefs: fs-common.c -> namei.c
      bcachefs: Move bch2_check_dirent_target() to namei.c
      bcachefs: Refactor bch2_check_dirent_target()
      bcachefs: Run bch2_check_dirent_target() at lookup time
      bcachefs: Count BCH_DATA_parity backpointers correctly
      bcachefs: Handle backpointers with unknown data types
      bcachefs: Disable asm memcpys when kmsan enabled
      bcachefs: Fix kmsan warnings in bch2_extent_crc_pack()
      bcachefs: kmsan asserts
      bcachefs: Fix a KMSAN splat in btree_update_nodes_written()
      bcachefs: Eliminate padding in move_bucket_key
      bcachefs: zero init journal bios
      bcachefs: bch2_disk_accounting_mod2()
      bcachefs: btree_trans_restart_foreign_task()
      bcachefs: Fix race in print_chain()
      bcachefs: btree node write errors now print btree node
      bcachefs: Kill unnecessary bch2_dev_usage_read()

Thorsten Blum (3):
      bcachefs: Fix error type in bch2_alloc_v3_validate()
      bcachefs: Remove unnecessary byte allocation
      bcachefs: Use max() to improve gen_after()

 .../filesystems/bcachefs/SubmittingPatches.rst     |  43 +-
 Documentation/filesystems/bcachefs/casefolding.rst |  90 +++
 Documentation/filesystems/bcachefs/index.rst       |  20 +-
 fs/bcachefs/Kconfig                                |   2 +-
 fs/bcachefs/Makefile                               |   3 +-
 fs/bcachefs/alloc_background.c                     | 190 ++++--
 fs/bcachefs/alloc_background.h                     |   2 +-
 fs/bcachefs/alloc_foreground.c                     |  31 +-
 fs/bcachefs/alloc_foreground.h                     |  19 +-
 fs/bcachefs/alloc_types.h                          |   2 +
 fs/bcachefs/backpointers.c                         | 151 ++---
 fs/bcachefs/backpointers.h                         |  26 +-
 fs/bcachefs/bcachefs.h                             |  20 +-
 fs/bcachefs/bcachefs_format.h                      |  16 +-
 fs/bcachefs/bcachefs_ioctl.h                       |  29 +-
 fs/bcachefs/btree_cache.c                          |   1 +
 fs/bcachefs/btree_gc.c                             |  18 +-
 fs/bcachefs/btree_io.c                             | 259 ++++++-
 fs/bcachefs/btree_io.h                             |   4 +
 fs/bcachefs/btree_iter.c                           |  14 -
 fs/bcachefs/btree_iter.h                           |   9 +-
 fs/bcachefs/btree_locking.c                        |   8 +-
 fs/bcachefs/btree_node_scan.c                      |  29 +-
 fs/bcachefs/btree_trans_commit.c                   | 120 ++--
 fs/bcachefs/btree_types.h                          |  13 +
 fs/bcachefs/btree_update.c                         |   5 +-
 fs/bcachefs/btree_update.h                         |   2 +
 fs/bcachefs/btree_update_interior.c                | 150 +++--
 fs/bcachefs/btree_update_interior.h                |   7 +
 fs/bcachefs/buckets.c                              |  80 +--
 fs/bcachefs/buckets.h                              |  31 +-
 fs/bcachefs/buckets_types.h                        |  27 +
 fs/bcachefs/chardev.c                              |  38 +-
 fs/bcachefs/checksum.c                             |  25 +-
 fs/bcachefs/checksum.h                             |   2 +
 fs/bcachefs/compress.c                             |  65 +-
 fs/bcachefs/data_update.c                          | 237 +++++--
 fs/bcachefs/data_update.h                          |  17 +-
 fs/bcachefs/debug.c                                |  34 +-
 fs/bcachefs/dirent.c                               | 274 +++++++-
 fs/bcachefs/dirent.h                               |  17 +-
 fs/bcachefs/dirent_format.h                        |  20 +-
 fs/bcachefs/disk_accounting.h                      |  18 +
 fs/bcachefs/disk_accounting_format.h               |  12 +-
 fs/bcachefs/ec.c                                   | 482 +++++--------
 fs/bcachefs/ec.h                                   |  46 +-
 fs/bcachefs/ec_types.h                             |  12 +-
 fs/bcachefs/errcode.h                              |  65 +-
 fs/bcachefs/error.c                                |  88 ++-
 fs/bcachefs/error.h                                |  57 +-
 fs/bcachefs/extents.c                              | 249 ++++---
 fs/bcachefs/extents.h                              |  24 +-
 fs/bcachefs/extents_format.h                       |  24 +-
 fs/bcachefs/extents_types.h                        |  11 +-
 fs/bcachefs/eytzinger.c                            |  76 ++-
 fs/bcachefs/eytzinger.h                            |  95 ++-
 fs/bcachefs/fs-io-buffered.c                       |  38 +-
 fs/bcachefs/fs-io-direct.c                         |  20 +-
 fs/bcachefs/fs-ioctl.c                             |  30 +-
 fs/bcachefs/fs-ioctl.h                             |  20 +-
 fs/bcachefs/fs.c                                   | 139 ++--
 fs/bcachefs/fsck.c                                 | 231 +------
 fs/bcachefs/inode.c                                |  24 +-
 fs/bcachefs/inode.h                                |   1 +
 fs/bcachefs/inode_format.h                         |   3 +-
 fs/bcachefs/io_misc.c                              |   3 +-
 fs/bcachefs/io_read.c                              | 747 +++++++++++----------
 fs/bcachefs/io_read.h                              |  92 ++-
 fs/bcachefs/io_write.c                             | 414 ++++++------
 fs/bcachefs/io_write.h                             |  38 +-
 fs/bcachefs/io_write_types.h                       |   2 +-
 fs/bcachefs/journal.c                              | 191 ++++--
 fs/bcachefs/journal.h                              |  42 +-
 fs/bcachefs/journal_io.c                           |  99 +--
 fs/bcachefs/journal_reclaim.c                      |  10 +-
 fs/bcachefs/journal_seq_blacklist.c                |   7 +-
 fs/bcachefs/journal_types.h                        |  37 +-
 fs/bcachefs/lru.c                                  | 100 +--
 fs/bcachefs/lru.h                                  |  22 +-
 fs/bcachefs/lru_format.h                           |   6 +-
 fs/bcachefs/migrate.c                              |  26 +-
 fs/bcachefs/move.c                                 | 456 ++++++++-----
 fs/bcachefs/move_types.h                           |  20 +-
 fs/bcachefs/movinggc.c                             |  15 +-
 fs/bcachefs/{fs-common.c => namei.c}               | 210 +++++-
 fs/bcachefs/{fs-common.h => namei.h}               |  31 +-
 fs/bcachefs/opts.c                                 | 115 ++--
 fs/bcachefs/opts.h                                 |  69 +-
 fs/bcachefs/progress.c                             |  63 ++
 fs/bcachefs/progress.h                             |  29 +
 fs/bcachefs/rebalance.c                            |  46 +-
 fs/bcachefs/recovery.c                             |   4 +-
 fs/bcachefs/recovery_passes_types.h                |   2 +-
 fs/bcachefs/reflink.c                              |  23 +-
 fs/bcachefs/sb-counters.c                          |  90 ++-
 fs/bcachefs/sb-counters.h                          |   4 +
 fs/bcachefs/sb-counters_format.h                   |  31 +-
 fs/bcachefs/sb-downgrade.c                         |   8 +-
 fs/bcachefs/sb-errors_format.h                     |   5 +-
 fs/bcachefs/sb-members.h                           |  16 +-
 fs/bcachefs/sb-members_format.h                    |   1 +
 fs/bcachefs/snapshot.c                             |   7 +-
 fs/bcachefs/snapshot.h                             |   1 +
 fs/bcachefs/str_hash.c                             |   2 +-
 fs/bcachefs/str_hash.h                             |  12 +-
 fs/bcachefs/super-io.c                             |  92 +--
 fs/bcachefs/super-io.h                             |  10 +-
 fs/bcachefs/super.c                                | 141 +++-
 fs/bcachefs/super.h                                |   2 +
 fs/bcachefs/super_types.h                          |   8 +-
 fs/bcachefs/sysfs.c                                | 141 ++--
 fs/bcachefs/sysfs.h                                |   5 +-
 fs/bcachefs/trace.h                                | 101 ++-
 fs/bcachefs/util.c                                 | 231 +++++--
 fs/bcachefs/util.h                                 |  16 +-
 fs/bcachefs/xattr.c                                |   2 +-
 116 files changed, 4816 insertions(+), 2944 deletions(-)
 create mode 100644 Documentation/filesystems/bcachefs/casefolding.rst
 rename fs/bcachefs/{fs-common.c => namei.c} (73%)
 rename fs/bcachefs/{fs-common.h => namei.h} (61%)
 create mode 100644 fs/bcachefs/progress.c
 create mode 100644 fs/bcachefs/progress.h

