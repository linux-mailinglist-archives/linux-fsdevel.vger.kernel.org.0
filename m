Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6452D90F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 23:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406860AbgLMWiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 17:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgLMWiA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 17:38:00 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF235C0613D3;
        Sun, 13 Dec 2020 14:37:19 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id s6so7031409qvn.6;
        Sun, 13 Dec 2020 14:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=7Fv5yIDBV12zs3gk7bukFWaV748S1fRECil00zSxj/o=;
        b=TYYQtEQYBQagx3PN7/BMolHFGSVXClSwo+HcVBOjmM7smZX9uWuNT7TX55TH076+Pa
         WwhM+72Z+7Lup7tlPZW094L4YeYrRfIAHI1IyP51ua1D2NlhuqpYOO6Rn/vMQOF5RYwQ
         yjgDU48LgifzRXhJAYlBG6opz6MkxE6JZIzq0zb9lS6FuaEV6hlkkT/7NfoW5nb8da+P
         NmPSmVbQwKBQbt1+Jiv+UujLBQ2RDNpmBKDKSXhmy6Lv2kKHXdB7aZoXmu2RDFGcEoEZ
         pBUIoj73LnsCBEf+fMwzTC++oAxveIL85sY1NUnxGSjljAohKkExzcFMo9mEXohWvJQG
         AgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=7Fv5yIDBV12zs3gk7bukFWaV748S1fRECil00zSxj/o=;
        b=CqSx4PpEh/HFwCSOWLOwg1yf8W4gETzbv8tD4cCZoU855Al5PDa2BVzN9UoMhTxv0W
         NFFNpHITAVoyDmhxBoklofqXZWtxizACLZJiSu5gP7XoI2ov18Jt5a71ct+99m/WbheX
         O0DIJTFNBTH5v6kOdb69k0rEbmgfjlCd8PV1Z7XEfGv1RC+K0GSq4ZPjaGO200Gdjvj5
         oBXcdSOyE1iJ4Cnoj6k89xCEfKQZuwA/przitXtxwY/JTeEj+ZKRH8EtNwPugtRvdSC3
         H9TaZmLFBcie0IXDgV9J6RjXvS4O3wacYHqLmSt1v8KlrlS0AliDnie3YCv8F6/WBTRd
         aHGQ==
X-Gm-Message-State: AOAM532jTGfzGpJ6ZWf8G9NWC9dT1hL+IaEqCYx5C2qqooQSYgs2c3It
        gLgTLFR4jUjR4uA8B7gpSnkecquomg==
X-Google-Smtp-Source: ABdhPJxu++5HH7pq+0+jtLvP2Yf5VfBc72/9H5byPey2ib28qveRUl0cJ647KIGW8Kahn8NU047RUw==
X-Received: by 2002:a0c:c583:: with SMTP id a3mr3576837qvj.15.1607899038269;
        Sun, 13 Dec 2020 14:37:18 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id g26sm1026777qkl.60.2020.12.13.14.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 14:37:17 -0800 (PST)
Date:   Sun, 13 Dec 2020 17:37:12 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: bcachefs-for-review
Message-ID: <X9aXmOGz25sElqy5@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since last posting: The main change for upstreaming is that I've added deadlock
avoidance code for the page cache coherency lock, and moved all of that code
into fs/bcachefs/ for now - besides adding faults_disabled_mapping to task
struct. See
https://lore.kernel.org/linux-fsdevel/20201111191011.GE3365678@moria.home.lan/

This addresses the last known blocker.

Bcachefs status - not a lot new to report. I've been avoiding making major
changes for awhile and focusing on stabilizing and torture testing, and outside
of erasure coding almost everything is looking pretty solid.

There've been some recent performance improvements - the main one is I changed
the journalling code so that journal writes no longer have to be marked flush +
fua, so now we only issue flush/fua writes when an fsync is done, or when needed
to free up space in the journal, or after a timeout when there's dirty data in
the journal (default 1 second).

Known bugs:
 - we see oopses with zstd compression. It looks like if you pass
   ZSTD_compressCCtx() a buffer that's not guaranteed to be big enough to fit
   the output, it sometimes writes past the end of that buffer.

 - erasure coding is not quite stable, something's funky with the management of
   our stripes heap, and my erasure coding + device removal test is hanging.

 - xfstests generic/547 just started failing after the 5.10 rebase - this is an
   fsync issue

 - some timestamps bugs - generic/258 started failing after the 5.10 rebase

Aside from that multiple devices, replication, compression, checksumming,
encryption etc. should all be pretty solid - from polling my user base they say
things have stabilized nicely over the past year.

Non fs/bcachefs/ prep patches - bcachefs now depends on some SRCU patches from
Paul McKenney that aren't in yet. Other than that, the list of non fs/bcachefs/
patches has been getting steadily smaller since last posting.

--------

And here's the pull request. It's been rebased and tested on top of 5.10-rc7,
and this is now the master branch that all the bcachefs users have been testing,
not a separate for-review branch:

The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:

  Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git 

for you to fetch changes up to b7ddbb0e20d2add011d8f5a035b04ca3ac8b34fa:

  bcachefs: Add some cond_rescheds() in shutdown path (2020-12-13 16:14:10 -0500)

----------------------------------------------------------------
Justin Husted (2):
      bcachefs: Set lost+found mode to 0700
      bcachefs: Update directory timestamps during link

Kent Overstreet (408):
      Compiler Attributes: add __flatten
      locking: SIX locks (shared/intent/exclusive)
      mm: export find_get_pages_range()
      sched: Add task_struct->faults_disabled_mapping
      mm: Bring back vmalloc_exec
      fs: factor out d_mark_tmpfile()
      block: Add some exports for bcachefs
      block: Add blk_status_to_str()
      bcache: move closures to lib/
      closures: closure_wait_event()
      bcachefs: Initial commit
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
      bcachefs: splice_write is currently busted
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
      bcachefs: Add __GFP_NOWARN to a GFP_NOWAIT allocation
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
      bcachefs: Walk btree with keys from journal
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
      bcachefs: Hacky io-in-flight throttling
      bcachefs: Fix a deadlock
      bcachefs: Don't deadlock when btree node reuse changes lock ordering
      bcachefs: Add an internal option for reading entire journal
      bcachefs: Turn c->state_lock into an rwsem
      bcachefs: Implement a new gc that only recalcs oldest gen
      bcachefs: btree_bkey_cached_common
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
      bcachefs: Disable preemption around write_seqcount() lock
      bcachefs: Perf improvements for bch_alloc_read()
      bcachefs: Don't write bucket IO time lazily
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
      bcachefs: Delete memcpy() macro
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
      bcachefs: Avoid write lock on mark_lock
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

Matthew Wilcox (Oracle) (3):
      bcachefs: Remove page_state_init_for_read
      bcachefs: Use attach_page_private and detach_page_private
      bcachefs: Convert to readahead

Paul E. McKenney (6):
      srcu: Make Tiny SRCU use multi-bit grace-period counter
      srcu: Provide internal interface to start a Tiny SRCU grace period
      srcu: Provide internal interface to start a Tree SRCU grace period
      srcu: Provide polling interfaces for Tiny SRCU grace periods
      srcu: Provide polling interfaces for Tree SRCU grace periods
      srcu: Document polling interfaces for Tree SRCU grace periods

Yuxuan Shui (1):
      bcachefs: fix stack corruption

 .../RCU/Design/Requirements/Requirements.rst       |   18 +
 block/bio.c                                        |    2 +
 block/blk-core.c                                   |   13 +-
 drivers/md/bcache/Kconfig                          |   10 +-
 drivers/md/bcache/Makefile                         |    4 +-
 drivers/md/bcache/bcache.h                         |    2 +-
 drivers/md/bcache/super.c                          |    1 -
 drivers/md/bcache/util.h                           |    3 +-
 fs/Kconfig                                         |    1 +
 fs/Makefile                                        |    1 +
 fs/bcachefs/Kconfig                                |   51 +
 fs/bcachefs/Makefile                               |   60 +
 fs/bcachefs/acl.c                                  |  388 +++
 fs/bcachefs/acl.h                                  |   59 +
 fs/bcachefs/alloc_background.c                     | 1474 +++++++++
 fs/bcachefs/alloc_background.h                     |  105 +
 fs/bcachefs/alloc_foreground.c                     |  990 ++++++
 fs/bcachefs/alloc_foreground.h                     |  138 +
 fs/bcachefs/alloc_types.h                          |  113 +
 fs/bcachefs/bcachefs.h                             |  904 ++++++
 fs/bcachefs/bcachefs_format.h                      | 1686 +++++++++++
 fs/bcachefs/bcachefs_ioctl.h                       |  346 +++
 fs/bcachefs/bkey.c                                 | 1154 +++++++
 fs/bcachefs/bkey.h                                 |  565 ++++
 fs/bcachefs/bkey_methods.c                         |  365 +++
 fs/bcachefs/bkey_methods.h                         |   82 +
 fs/bcachefs/bkey_on_stack.h                        |   43 +
 fs/bcachefs/bkey_sort.c                            |  515 ++++
 fs/bcachefs/bkey_sort.h                            |   57 +
 fs/bcachefs/bset.c                                 | 1738 +++++++++++
 fs/bcachefs/bset.h                                 |  650 ++++
 fs/bcachefs/btree_cache.c                          | 1072 +++++++
 fs/bcachefs/btree_cache.h                          |  105 +
 fs/bcachefs/btree_gc.c                             | 1437 +++++++++
 fs/bcachefs/btree_gc.h                             |  121 +
 fs/bcachefs/btree_io.c                             | 1868 ++++++++++++
 fs/bcachefs/btree_io.h                             |  237 ++
 fs/bcachefs/btree_iter.c                           | 2443 +++++++++++++++
 fs/bcachefs/btree_iter.h                           |  311 ++
 fs/bcachefs/btree_key_cache.c                      |  657 ++++
 fs/bcachefs/btree_key_cache.h                      |   49 +
 fs/bcachefs/btree_locking.h                        |  259 ++
 fs/bcachefs/btree_types.h                          |  670 +++++
 fs/bcachefs/btree_update.h                         |  144 +
 fs/bcachefs/btree_update_interior.c                | 2131 +++++++++++++
 fs/bcachefs/btree_update_interior.h                |  333 +++
 fs/bcachefs/btree_update_leaf.c                    | 1158 +++++++
 fs/bcachefs/buckets.c                              | 2308 ++++++++++++++
 fs/bcachefs/buckets.h                              |  318 ++
 fs/bcachefs/buckets_types.h                        |  137 +
 fs/bcachefs/chardev.c                              |  728 +++++
 fs/bcachefs/chardev.h                              |   31 +
 fs/bcachefs/checksum.c                             |  618 ++++
 fs/bcachefs/checksum.h                             |  202 ++
 fs/bcachefs/clock.c                                |  191 ++
 fs/bcachefs/clock.h                                |   38 +
 fs/bcachefs/clock_types.h                          |   37 +
 fs/bcachefs/compress.c                             |  629 ++++
 fs/bcachefs/compress.h                             |   18 +
 fs/bcachefs/debug.c                                |  432 +++
 fs/bcachefs/debug.h                                |   34 +
 fs/bcachefs/dirent.c                               |  385 +++
 fs/bcachefs/dirent.h                               |   63 +
 fs/bcachefs/disk_groups.c                          |  486 +++
 fs/bcachefs/disk_groups.h                          |   91 +
 fs/bcachefs/ec.c                                   | 1661 ++++++++++
 fs/bcachefs/ec.h                                   |  171 ++
 fs/bcachefs/ec_types.h                             |   39 +
 fs/bcachefs/error.c                                |  172 ++
 fs/bcachefs/error.h                                |  214 ++
 fs/bcachefs/extent_update.c                        |  229 ++
 fs/bcachefs/extent_update.h                        |   16 +
 fs/bcachefs/extents.c                              | 1260 ++++++++
 fs/bcachefs/extents.h                              |  629 ++++
 fs/bcachefs/extents_types.h                        |   40 +
 fs/bcachefs/eytzinger.h                            |  285 ++
 fs/bcachefs/fifo.h                                 |  127 +
 fs/bcachefs/fs-common.c                            |  315 ++
 fs/bcachefs/fs-common.h                            |   37 +
 fs/bcachefs/fs-io.c                                | 3161 ++++++++++++++++++++
 fs/bcachefs/fs-io.h                                |   56 +
 fs/bcachefs/fs-ioctl.c                             |  312 ++
 fs/bcachefs/fs-ioctl.h                             |   81 +
 fs/bcachefs/fs.c                                   | 1659 ++++++++++
 fs/bcachefs/fs.h                                   |  182 ++
 fs/bcachefs/fsck.c                                 | 1487 +++++++++
 fs/bcachefs/fsck.h                                 |    9 +
 fs/bcachefs/inode.c                                |  658 ++++
 fs/bcachefs/inode.h                                |  178 ++
 fs/bcachefs/io.c                                   | 2411 +++++++++++++++
 fs/bcachefs/io.h                                   |  169 ++
 fs/bcachefs/io_types.h                             |  148 +
 fs/bcachefs/journal.c                              | 1266 ++++++++
 fs/bcachefs/journal.h                              |  529 ++++
 fs/bcachefs/journal_io.c                           | 1351 +++++++++
 fs/bcachefs/journal_io.h                           |   45 +
 fs/bcachefs/journal_reclaim.c                      |  780 +++++
 fs/bcachefs/journal_reclaim.h                      |   85 +
 fs/bcachefs/journal_seq_blacklist.c                |  308 ++
 fs/bcachefs/journal_seq_blacklist.h                |   22 +
 fs/bcachefs/journal_types.h                        |  317 ++
 fs/bcachefs/keylist.c                              |   67 +
 fs/bcachefs/keylist.h                              |   76 +
 fs/bcachefs/keylist_types.h                        |   16 +
 fs/bcachefs/migrate.c                              |  170 ++
 fs/bcachefs/migrate.h                              |    7 +
 fs/bcachefs/move.c                                 |  828 +++++
 fs/bcachefs/move.h                                 |   65 +
 fs/bcachefs/move_types.h                           |   17 +
 fs/bcachefs/movinggc.c                             |  364 +++
 fs/bcachefs/movinggc.h                             |    9 +
 fs/bcachefs/opts.c                                 |  438 +++
 fs/bcachefs/opts.h                                 |  440 +++
 fs/bcachefs/quota.c                                |  783 +++++
 fs/bcachefs/quota.h                                |   71 +
 fs/bcachefs/quota_types.h                          |   43 +
 fs/bcachefs/rebalance.c                            |  332 ++
 fs/bcachefs/rebalance.h                            |   28 +
 fs/bcachefs/rebalance_types.h                      |   27 +
 fs/bcachefs/recovery.c                             | 1340 +++++++++
 fs/bcachefs/recovery.h                             |   60 +
 fs/bcachefs/reflink.c                              |  341 +++
 fs/bcachefs/reflink.h                              |   40 +
 fs/bcachefs/replicas.c                             | 1073 +++++++
 fs/bcachefs/replicas.h                             |   91 +
 fs/bcachefs/replicas_types.h                       |   10 +
 fs/bcachefs/siphash.c                              |  173 ++
 fs/bcachefs/siphash.h                              |   87 +
 fs/bcachefs/str_hash.h                             |  331 ++
 fs/bcachefs/super-io.c                             | 1155 +++++++
 fs/bcachefs/super-io.h                             |  137 +
 fs/bcachefs/super.c                                | 2051 +++++++++++++
 fs/bcachefs/super.h                                |  241 ++
 fs/bcachefs/super_types.h                          |   51 +
 fs/bcachefs/sysfs.c                                | 1063 +++++++
 fs/bcachefs/sysfs.h                                |   44 +
 fs/bcachefs/tests.c                                |  805 +++++
 fs/bcachefs/tests.h                                |   15 +
 fs/bcachefs/trace.c                                |   12 +
 fs/bcachefs/util.c                                 |  907 ++++++
 fs/bcachefs/util.h                                 |  750 +++++
 fs/bcachefs/varint.c                               |   42 +
 fs/bcachefs/varint.h                               |    8 +
 fs/bcachefs/vstructs.h                             |   63 +
 fs/bcachefs/xattr.c                                |  586 ++++
 fs/bcachefs/xattr.h                                |   49 +
 fs/dcache.c                                        |   10 +-
 include/linux/blkdev.h                             |    1 +
 {drivers/md/bcache => include/linux}/closure.h     |   39 +-
 include/linux/compiler_attributes.h                |    5 +
 include/linux/dcache.h                             |    1 +
 include/linux/rcupdate.h                           |    2 +
 include/linux/sched.h                              |    1 +
 include/linux/six.h                                |  197 ++
 include/linux/srcu.h                               |    3 +
 include/linux/srcutiny.h                           |    7 +-
 include/linux/vmalloc.h                            |    1 +
 include/trace/events/bcachefs.h                    |  760 +++++
 init/init_task.c                                   |    1 +
 kernel/Kconfig.locks                               |    3 +
 kernel/locking/Makefile                            |    1 +
 kernel/locking/six.c                               |  553 ++++
 kernel/module.c                                    |    4 +-
 kernel/rcu/srcutiny.c                              |   77 +-
 kernel/rcu/srcutree.c                              |  127 +-
 lib/Kconfig                                        |    3 +
 lib/Kconfig.debug                                  |    9 +
 lib/Makefile                                       |    2 +
 {drivers/md/bcache => lib}/closure.c               |   35 +-
 mm/filemap.c                                       |    1 +
 mm/nommu.c                                         |   18 +
 mm/vmalloc.c                                       |   21 +
 172 files changed, 68781 insertions(+), 95 deletions(-)
 create mode 100644 fs/bcachefs/Kconfig
 create mode 100644 fs/bcachefs/Makefile
 create mode 100644 fs/bcachefs/acl.c
 create mode 100644 fs/bcachefs/acl.h
 create mode 100644 fs/bcachefs/alloc_background.c
 create mode 100644 fs/bcachefs/alloc_background.h
 create mode 100644 fs/bcachefs/alloc_foreground.c
 create mode 100644 fs/bcachefs/alloc_foreground.h
 create mode 100644 fs/bcachefs/alloc_types.h
 create mode 100644 fs/bcachefs/bcachefs.h
 create mode 100644 fs/bcachefs/bcachefs_format.h
 create mode 100644 fs/bcachefs/bcachefs_ioctl.h
 create mode 100644 fs/bcachefs/bkey.c
 create mode 100644 fs/bcachefs/bkey.h
 create mode 100644 fs/bcachefs/bkey_methods.c
 create mode 100644 fs/bcachefs/bkey_methods.h
 create mode 100644 fs/bcachefs/bkey_on_stack.h
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
 create mode 100644 fs/bcachefs/btree_key_cache.c
 create mode 100644 fs/bcachefs/btree_key_cache.h
 create mode 100644 fs/bcachefs/btree_locking.h
 create mode 100644 fs/bcachefs/btree_types.h
 create mode 100644 fs/bcachefs/btree_update.h
 create mode 100644 fs/bcachefs/btree_update_interior.c
 create mode 100644 fs/bcachefs/btree_update_interior.h
 create mode 100644 fs/bcachefs/btree_update_leaf.c
 create mode 100644 fs/bcachefs/buckets.c
 create mode 100644 fs/bcachefs/buckets.h
 create mode 100644 fs/bcachefs/buckets_types.h
 create mode 100644 fs/bcachefs/chardev.c
 create mode 100644 fs/bcachefs/chardev.h
 create mode 100644 fs/bcachefs/checksum.c
 create mode 100644 fs/bcachefs/checksum.h
 create mode 100644 fs/bcachefs/clock.c
 create mode 100644 fs/bcachefs/clock.h
 create mode 100644 fs/bcachefs/clock_types.h
 create mode 100644 fs/bcachefs/compress.c
 create mode 100644 fs/bcachefs/compress.h
 create mode 100644 fs/bcachefs/debug.c
 create mode 100644 fs/bcachefs/debug.h
 create mode 100644 fs/bcachefs/dirent.c
 create mode 100644 fs/bcachefs/dirent.h
 create mode 100644 fs/bcachefs/disk_groups.c
 create mode 100644 fs/bcachefs/disk_groups.h
 create mode 100644 fs/bcachefs/ec.c
 create mode 100644 fs/bcachefs/ec.h
 create mode 100644 fs/bcachefs/ec_types.h
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
 create mode 100644 fs/bcachefs/io.c
 create mode 100644 fs/bcachefs/io.h
 create mode 100644 fs/bcachefs/io_types.h
 create mode 100644 fs/bcachefs/journal.c
 create mode 100644 fs/bcachefs/journal.h
 create mode 100644 fs/bcachefs/journal_io.c
 create mode 100644 fs/bcachefs/journal_io.h
 create mode 100644 fs/bcachefs/journal_reclaim.c
 create mode 100644 fs/bcachefs/journal_reclaim.h
 create mode 100644 fs/bcachefs/journal_seq_blacklist.c
 create mode 100644 fs/bcachefs/journal_seq_blacklist.h
 create mode 100644 fs/bcachefs/journal_types.h
 create mode 100644 fs/bcachefs/keylist.c
 create mode 100644 fs/bcachefs/keylist.h
 create mode 100644 fs/bcachefs/keylist_types.h
 create mode 100644 fs/bcachefs/migrate.c
 create mode 100644 fs/bcachefs/migrate.h
 create mode 100644 fs/bcachefs/move.c
 create mode 100644 fs/bcachefs/move.h
 create mode 100644 fs/bcachefs/move_types.h
 create mode 100644 fs/bcachefs/movinggc.c
 create mode 100644 fs/bcachefs/movinggc.h
 create mode 100644 fs/bcachefs/opts.c
 create mode 100644 fs/bcachefs/opts.h
 create mode 100644 fs/bcachefs/quota.c
 create mode 100644 fs/bcachefs/quota.h
 create mode 100644 fs/bcachefs/quota_types.h
 create mode 100644 fs/bcachefs/rebalance.c
 create mode 100644 fs/bcachefs/rebalance.h
 create mode 100644 fs/bcachefs/rebalance_types.h
 create mode 100644 fs/bcachefs/recovery.c
 create mode 100644 fs/bcachefs/recovery.h
 create mode 100644 fs/bcachefs/reflink.c
 create mode 100644 fs/bcachefs/reflink.h
 create mode 100644 fs/bcachefs/replicas.c
 create mode 100644 fs/bcachefs/replicas.h
 create mode 100644 fs/bcachefs/replicas_types.h
 create mode 100644 fs/bcachefs/siphash.c
 create mode 100644 fs/bcachefs/siphash.h
 create mode 100644 fs/bcachefs/str_hash.h
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
 create mode 100644 fs/bcachefs/util.c
 create mode 100644 fs/bcachefs/util.h
 create mode 100644 fs/bcachefs/varint.c
 create mode 100644 fs/bcachefs/varint.h
 create mode 100644 fs/bcachefs/vstructs.h
 create mode 100644 fs/bcachefs/xattr.c
 create mode 100644 fs/bcachefs/xattr.h
 rename {drivers/md/bcache => include/linux}/closure.h (94%)
 create mode 100644 include/linux/six.h
 create mode 100644 include/trace/events/bcachefs.h
 create mode 100644 kernel/locking/six.c
 rename {drivers/md/bcache => lib}/closure.c (88%)
