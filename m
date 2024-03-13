Return-Path: <linux-fsdevel+bounces-14256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3C887A085
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 02:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10A51C2291C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 01:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B4B654;
	Wed, 13 Mar 2024 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JZCHZDAM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459B48F4E;
	Wed, 13 Mar 2024 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710292257; cv=none; b=KcIZyW8KsDUSzQY9YEbjEZyNjdR+50HZgkl3Tjopkdk7eMXt5+HYN7aY4niTNy3PH/6Ix62YthrxrEcEKEEnO+wkYDfkA5/IU2rRpoux2ZpdxYtqCMghvRlbyQDeg22Dp9surr7QDlwd2zfzq77+xBdaGg1EsehWfKN7L2KICP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710292257; c=relaxed/simple;
	bh=Pat95CPM4hk608vVa6r4zNRZb8B7a2oE8jEjcVxDKVE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B2CanQQ0ypK6vXp83Hh6NHGIyxytseiJe+CIFNOoJ9TkGqpT1GaMO1Ok8hcxU8asM1MuUFCKKAHaiCVdflKbJTy7ZFGZFCPE85cI4xG6a5rb1BKa8fhHaWTzTbMr58CPgd387gB2jQQP6cWS/BnWE+zefV+GWDAxUwextOARNg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JZCHZDAM; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Mar 2024 21:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710292252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=G4yt2iBRBgnTcL06vNJuG27KHBKJU6PMojAsYbbnCr4=;
	b=JZCHZDAMDnkX6c5Uuwm3j6Etm703LnqqO/JRc2ChPeqKceT5HZxpvCa38tBshsftojbRdS
	ERMK2PIJHkzYja+jrBSd8Y3FIUmljQkkmD0zfvjfyDHW+Zzu3r1giQbBFez/wHxrv/zj8K
	HR+IUehylQ8zap6hugMC/inx3s/K2p0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs updates for 6.9
Message-ID: <lfypw4vqq3rkohlh2iwhub3igjopdy26lfforfcjws2dfizk7d@32yk5dnemi4u>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, few patches for you - plus a simple merge conflict with VFS
changes:

Cheers,
Kent

diff --cc fs/bcachefs/super-io.c
index 010daebf987b,bd64eb68e84a..000000000000
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@@ -723,12 -715,11 +723,12 @@@ retry
  			opt_set(*opts, nochanges, true);
  	}
  
- 	if (IS_ERR(sb->bdev_handle)) {
- 		ret = PTR_ERR(sb->bdev_handle);
+ 	if (IS_ERR(sb->s_bdev_file)) {
+ 		ret = PTR_ERR(sb->s_bdev_file);
 +		prt_printf(&err, "error opening %s: %s", path, bch2_err_str(ret));
  		goto err;
  	}
- 	sb->bdev = sb->bdev_handle->bdev;
+ 	sb->bdev = file_bdev(sb->s_bdev_file);
  
  	ret = bch2_sb_realloc(sb, 0);
  	if (ret) {

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-20240312

for you to fetch changes up to 243c934566b7b0f9103201e259f5373ba38126c6:

  bcachefs: reconstruct_alloc cleanup (2024-03-12 02:19:54 -0400)

----------------------------------------------------------------
bcachefs updates for 6.9

 - Subvolume children btree; this is needed for providing a userspace
   interface for walking subvolumes, which will come later
 - Lots of improvements to directory structure checking
 - Improved journal pipelining, significantly improving performance on
   high iodepth write workloads
 - Discard path improvements: the discard path is more efficient, and no
   longer flushes the journal unnecessarily
 - Buffered write path can now avoid taking the inode lock
 - Pull out various library code for use in XFS: time stats,
   mean_and_variance, darray, eytzinger, thread_with_file
 - new mm helper: memalloc_flags_{save|restore}
 - mempool now does kvmalloc mempools

----------------------------------------------------------------
Brian Foster (1):
      bcachefs: fix lost journal buf wakeup due to improved pipelining

Calvin Owens (1):
      bcachefs: Silence gcc warnings about arm arch ABI drift

Colin Ian King (1):
      bcachefs: remove redundant assignment to variable ret

Daniel Hill (1):
      bcachefs: rebalance_status now shows correct units

Darrick J. Wong (13):
      time_stats: report lifetime of the stats object
      time_stats: split stats-with-quantiles into a separate structure
      time_stats: fix struct layout bloat
      time_stats: add larger units
      time_stats: don't print any output if event count is zero
      time_stats: allow custom epoch names
      mean_and_variance: put struct mean_and_variance_weighted on a diet
      time_stats: shrink time_stat_buffer for better alignment
      time_stats: report information in json format
      thread_with_file: allow creation of readonly files
      thread_with_file: fix various printf problems
      thread_with_file: create ops structure for thread_with_stdio
      thread_with_file: allow ioctls against these files

Erick Archer (1):
      bcachefs: Prefer struct_size over open coded arithmetic

Guoyu Ou (1):
      bcachefs: skip invisible entries in empty subvolume checking

Hongbo Li (3):
      bcachefs: fix the error code when mounting with incorrect options.
      bcachefs: avoid returning private error code in bch2_xattr_bcachefs_set
      bcachefs: intercept mountoption value for bool type

Kent Overstreet (116):
      bcachefs: journal_seq_blacklist_add() now handles entries being added out of order
      bcachefs: extent_entry_next_safe()
      bcachefs: no_splitbrain_check option
      bcachefs: fix check_inode_deleted_list()
      bcachefs: Fix journal replay with unreadable btree roots
      bcachefs: Fix degraded mode fsck
      bcachefs: Correctly validate k->u64s in btree node read path
      bcachefs: Set path->uptodate when no node at level
      bcachefs: fix split brain message
      bcachefs: Kill unnecessary wakeups in journal reclaim
      bcachefs: Split out journal workqueue
      bcachefs: Avoid setting j->write_work unnecessarily
      bcachefs: Journal writes should be REQ_SYNC|REQ_META
      bcachefs: Avoid taking journal lock unnecessarily
      bcachefs: fixup for building in userspace
      bcachefs: Improve bch2_dirent_to_text()
      bcachefs: Workqueues should be WQ_HIGHPRI
      bcachefs: bch2_hash_set_snapshot() -> bch2_hash_set_in_snapshot()
      bcachefs: Cleanup bch2_dirent_lookup_trans()
      bcachefs: convert journal replay ptrs to darray
      bcachefs: improve journal entry read fsck error messages
      bcachefs: jset_entry_datetime
      bcachefs: bio per journal buf
      bcachefs: closure per journal buf
      bcachefs: better journal pipelining
      bcachefs: btree_and_journal_iter.trans
      bcachefs: btree node prefetching in check_topology
      bcachefs: Subvolumes may now be renamed
      bcachefs: Switch to uuid_to_fsid()
      bcachefs: Initialize super_block->s_uuid
      bcachefs: move fsck_write_inode() to inode.c
      bcachefs: bump max_active on btree_interior_update_worker
      bcachefs: Kill some -EINVALs
      bcachefs: Factor out check_subvol_dirent()
      bcachefs: factor out check_inode_backpointer()
      mm: introduce memalloc_flags_{save,restore}
      mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN
      bcachefs: bch2_inode_insert()
      bcachefs: bch2_lookup() gives better error message on inode not found
      mean and variance: Promote to lib/math
      eytzinger: Promote to include/linux/
      bcachefs: bch2_time_stats_to_seq_buf()
      time_stats: Promote to lib/
      bcache: Convert to lib/time_stats
      time_stats: Kill TIME_STATS_HAVE_QUANTILES
      mempool: kvmalloc pool
      bcachefs: kill kvpmalloc()
      bcachefs: thread_with_stdio: eliminate double buffering
      bcachefs: thread_with_stdio: convert to darray
      bcachefs: thread_with_stdio: kill thread_with_stdio_done()
      bcachefs: thread_with_stdio: fix bch2_stdio_redirect_readline()
      bcachefs: Thread with file documentation
      darray: lift from bcachefs
      thread_with_file: Lift from bcachefs
      thread_with_stdio: Mark completed in ->release()
      kernel/hung_task.c: export sysctl_hung_task_timeout_secs
      thread_with_stdio: suppress hung task warning
      bcachefs: Kill more -EIO error codes
      bcachefs: Check subvol <-> inode pointers in check_subvol()
      bcachefs: Check subvol <-> inode pointers in check_inode()
      bcachefs: check_inode_dirent_inode()
      bcachefs: better log message in lookup_inode_for_snapshot()
      bcachefs: check bi_parent_subvol in check_inode()
      bcachefs: simplify check_dirent_inode_dirent()
      bcachefs: delete duplicated checks in check_dirent_to_subvol()
      bcachefs: check inode->bi_parent_subvol against dirent
      bcachefs: check dirent->d_parent_subvol
      bcachefs: Repair subvol dirents that point to non subvols
      bcachefs: bch_subvolume::parent -> creation_parent
      bcachefs: Fix path where dirent -> subvol missing and we don't fix
      bcachefs: Pass inode bkey to check_path()
      bcachefs: check_path() now prints full inode when reattaching
      bcachefs: Correctly reattach subvolumes
      bcachefs: bch2_btree_bit_mod -> bch2_btree_bit_mod_buffered
      bcachefs: bch2_btree_bit_mod()
      bcachefs: bch_subvolume::fs_path_parent
      bcachefs: BTREE_ID_subvolume_children
      bcachefs: Check for subvolume children when deleting subvolumes
      bcachefs: Pin btree cache in ram for random access in fsck
      bcachefs: Save key_cache_path in peek_slot()
      bcachefs: Track iter->ip_allocated at bch2_trans_copy_iter()
      bcachefs: Use kvzalloc() when dynamically allocating btree paths
      bcachefs: Improve error messages in device remove path
      bcachefs: bch2_print_opts()
      thread_with_file: Fix missing va_end()
      bcachefs: bch2_trigger_alloc() handles state changes better
      bcachefs: bch2_check_subvolume_structure()
      bcachefs: check_path() now only needs to walk up to subvolume root
      bcachefs: more informative write path error message
      bcachefs: Drop redundant btree_path_downgrade()s
      bcachefs: improve bch2_journal_buf_to_text()
      bcachefs: Split out discard fastpath
      bcachefs: Fix journal_buf bitfield accesses
      bcachefs: Add journal.blocked to journal_debug_to_text()
      thread_with_file: add f_ops.flush
      bcachefs: Errcode tracepoint, documentation
      bcachefs: jset_entry for loops declare loop iter
      bcachefs: Rename journal_keys.d -> journal_keys.data
      bcachefs: journal_keys now uses darray helpers
      bcachefs: improve move_gap()
      bcachefs: split out ignore_blacklisted, ignore_not_dirty
      bcachefs: Fix bch2_journal_noflush_seq()
      fs: file_remove_privs_flags()
      bcachefs: Buffered write path now can avoid the inode lock
      bcachefs: Split out bkey_types.h
      bcachefs: copy_(to|from)_user_errcode()
      lib/generic-radix-tree.c: Make nodes more reasonably sized
      bcachefs: fix bch2_journal_buf_to_text()
      bcachefs: Check for writing superblocks with nonsense member seq fields
      bcachefs: Kill unused flags argument to btree_split()
      bcachefs: fix deletion of indirect extents in btree_gc
      bcachefs: Fix order of gc_done passes
      bcachefs: Always flush write buffer in delete_dead_inodes()
      bcachefs: Fix btree key cache coherency during replay
      bcachefs: fix bch_folio_sector padding
      bcachefs: reconstruct_alloc cleanup

Li Zetao (1):
      bcachefs: Fix null-ptr-deref in bch2_fs_alloc()

Lukas Bulwahn (1):
      MAINTAINERS: repair file entries in THREAD WITH FILE

Thomas Bertschinger (1):
      bcachefs: omit alignment attribute on big endian struct bkey

 Documentation/filesystems/bcachefs/errorcodes.rst  |  30 +
 MAINTAINERS                                        |  39 +
 drivers/md/bcache/Kconfig                          |   1 +
 drivers/md/bcache/bcache.h                         |   1 +
 drivers/md/bcache/bset.c                           |   6 +-
 drivers/md/bcache/bset.h                           |   1 +
 drivers/md/bcache/btree.c                          |   6 +-
 drivers/md/bcache/super.c                          |   7 +
 drivers/md/bcache/sysfs.c                          |  25 +-
 drivers/md/bcache/util.c                           |  30 -
 drivers/md/bcache/util.h                           |  52 +-
 fs/bcachefs/Kconfig                                |  11 +-
 fs/bcachefs/Makefile                               |   6 +-
 fs/bcachefs/alloc_background.c                     | 219 +++++-
 fs/bcachefs/alloc_background.h                     |   1 +
 fs/bcachefs/alloc_foreground.c                     |  13 +-
 fs/bcachefs/backpointers.c                         | 143 ++--
 fs/bcachefs/bbpos_types.h                          |   2 +-
 fs/bcachefs/bcachefs.h                             |  29 +-
 fs/bcachefs/bcachefs_format.h                      |  53 +-
 fs/bcachefs/bkey.h                                 | 207 +----
 fs/bcachefs/bkey_types.h                           | 213 ++++++
 fs/bcachefs/bset.c                                 |   2 +-
 fs/bcachefs/btree_cache.c                          |  39 +-
 fs/bcachefs/btree_gc.c                             | 153 ++--
 fs/bcachefs/btree_io.c                             |  30 +-
 fs/bcachefs/btree_iter.c                           |  28 +-
 fs/bcachefs/btree_journal_iter.c                   | 180 +++--
 fs/bcachefs/btree_journal_iter.h                   |  14 +-
 fs/bcachefs/btree_key_cache.c                      |   8 +-
 fs/bcachefs/btree_locking.c                        |   3 +-
 fs/bcachefs/btree_locking.h                        |   2 +-
 fs/bcachefs/btree_types.h                          |  11 +-
 fs/bcachefs/btree_update.c                         |  25 +-
 fs/bcachefs/btree_update.h                         |   3 +-
 fs/bcachefs/btree_update_interior.c                |  91 ++-
 fs/bcachefs/btree_update_interior.h                |   2 +
 fs/bcachefs/btree_write_buffer.c                   |   4 +-
 fs/bcachefs/btree_write_buffer_types.h             |   2 +-
 fs/bcachefs/buckets.c                              |  32 +-
 fs/bcachefs/chardev.c                              |  63 +-
 fs/bcachefs/checksum.c                             |   2 +-
 fs/bcachefs/compress.c                             |  14 +-
 fs/bcachefs/debug.c                                |   6 +-
 fs/bcachefs/dirent.c                               | 143 ++--
 fs/bcachefs/dirent.h                               |   6 +-
 fs/bcachefs/ec.c                                   |   4 +-
 fs/bcachefs/errcode.c                              |  15 +-
 fs/bcachefs/errcode.h                              |  18 +-
 fs/bcachefs/error.c                                |  14 +-
 fs/bcachefs/error.h                                |   2 +-
 fs/bcachefs/extents.h                              |  11 +-
 fs/bcachefs/fifo.h                                 |   4 +-
 fs/bcachefs/fs-common.c                            |  74 +-
 fs/bcachefs/fs-io-buffered.c                       | 149 +++-
 fs/bcachefs/fs-io-pagecache.h                      |   9 +-
 fs/bcachefs/fs.c                                   | 222 ++++--
 fs/bcachefs/fsck.c                                 | 849 ++++++++++++++-------
 fs/bcachefs/fsck.h                                 |   1 +
 fs/bcachefs/inode.c                                |  55 +-
 fs/bcachefs/inode.h                                |  19 +
 fs/bcachefs/io_read.c                              |   6 +-
 fs/bcachefs/io_write.c                             |  20 +-
 fs/bcachefs/journal.c                              | 282 ++++---
 fs/bcachefs/journal.h                              |   7 +-
 fs/bcachefs/journal_io.c                           | 409 +++++-----
 fs/bcachefs/journal_io.h                           |  47 +-
 fs/bcachefs/journal_reclaim.c                      |  29 +-
 fs/bcachefs/journal_sb.c                           |   2 +-
 fs/bcachefs/journal_seq_blacklist.c                |  75 +-
 fs/bcachefs/journal_types.h                        |  36 +-
 fs/bcachefs/lru.c                                  |   7 +-
 fs/bcachefs/migrate.c                              |   8 +-
 fs/bcachefs/nocow_locking.c                        |   2 +-
 fs/bcachefs/opts.c                                 |   8 +-
 fs/bcachefs/opts.h                                 |  10 +
 fs/bcachefs/rebalance.c                            |   4 +-
 fs/bcachefs/recovery.c                             |  88 ++-
 fs/bcachefs/recovery_types.h                       |   2 +
 fs/bcachefs/replicas.c                             |  19 +-
 fs/bcachefs/replicas.h                             |   3 +-
 fs/bcachefs/sb-clean.c                             |  16 -
 fs/bcachefs/sb-downgrade.c                         |  13 +-
 fs/bcachefs/sb-errors_types.h                      |  21 +-
 fs/bcachefs/sb-members.h                           |   2 +-
 fs/bcachefs/str_hash.h                             |  15 +-
 fs/bcachefs/subvolume.c                            | 187 ++++-
 fs/bcachefs/subvolume.h                            |   9 +-
 fs/bcachefs/subvolume_format.h                     |   4 +-
 fs/bcachefs/subvolume_types.h                      |   2 +-
 fs/bcachefs/super-io.c                             |  22 +-
 fs/bcachefs/super-io.h                             |   2 +-
 fs/bcachefs/super.c                                |  97 ++-
 fs/bcachefs/sysfs.c                                |   4 +-
 fs/bcachefs/thread_with_file.c                     | 299 --------
 fs/bcachefs/thread_with_file.h                     |  41 -
 fs/bcachefs/thread_with_file_types.h               |  16 -
 fs/bcachefs/trace.h                                |  19 +
 fs/bcachefs/util.c                                 | 374 +--------
 fs/bcachefs/util.h                                 | 180 +----
 fs/bcachefs/xattr.c                                |   5 +-
 fs/inode.c                                         |   7 +-
 {fs/bcachefs => include/linux}/darray.h            |  59 +-
 include/linux/darray_types.h                       |  22 +
 {fs/bcachefs => include/linux}/eytzinger.h         |  58 +-
 include/linux/fs.h                                 |   1 +
 include/linux/generic-radix-tree.h                 |  29 +-
 {fs/bcachefs => include/linux}/mean_and_variance.h |  14 +-
 include/linux/mempool.h                            |  13 +
 include/linux/sched.h                              |   4 +-
 include/linux/sched/mm.h                           |  60 +-
 include/linux/thread_with_file.h                   |  79 ++
 include/linux/thread_with_file_types.h             |  25 +
 include/linux/time_stats.h                         | 167 ++++
 kernel/hung_task.c                                 |   1 +
 lib/Kconfig                                        |   7 +
 lib/Kconfig.debug                                  |   9 +
 lib/Makefile                                       |   5 +-
 {fs/bcachefs => lib}/darray.c                      |  12 +-
 lib/generic-radix-tree.c                           |  35 +-
 lib/math/Kconfig                                   |   3 +
 lib/math/Makefile                                  |   2 +
 {fs/bcachefs => lib/math}/mean_and_variance.c      |  31 +-
 {fs/bcachefs => lib/math}/mean_and_variance_test.c |  83 +-
 lib/sort.c                                         |  89 +++
 lib/thread_with_file.c                             | 454 +++++++++++
 lib/time_stats.c                                   | 373 +++++++++
 mm/mempool.c                                       |  13 +
 128 files changed, 4583 insertions(+), 2868 deletions(-)
 create mode 100644 Documentation/filesystems/bcachefs/errorcodes.rst
 create mode 100644 fs/bcachefs/bkey_types.h
 delete mode 100644 fs/bcachefs/thread_with_file.c
 delete mode 100644 fs/bcachefs/thread_with_file.h
 delete mode 100644 fs/bcachefs/thread_with_file_types.h
 rename {fs/bcachefs => include/linux}/darray.h (66%)
 create mode 100644 include/linux/darray_types.h
 rename {fs/bcachefs => include/linux}/eytzinger.h (77%)
 rename {fs/bcachefs => include/linux}/mean_and_variance.h (96%)
 create mode 100644 include/linux/thread_with_file.h
 create mode 100644 include/linux/thread_with_file_types.h
 create mode 100644 include/linux/time_stats.h
 rename {fs/bcachefs => lib}/darray.c (56%)
 rename {fs/bcachefs => lib/math}/mean_and_variance.c (90%)
 rename {fs/bcachefs => lib/math}/mean_and_variance_test.c (78%)
 create mode 100644 lib/thread_with_file.c
 create mode 100644 lib/time_stats.c

