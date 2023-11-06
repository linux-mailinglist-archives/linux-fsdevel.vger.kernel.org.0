Return-Path: <linux-fsdevel+bounces-2032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 019197E1842
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 02:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B3AB20E30
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 01:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE31E625;
	Mon,  6 Nov 2023 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="era/po9E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133C19C
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 01:15:36 +0000 (UTC)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [IPv6:2001:41d0:203:375::ae])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511BBE0
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 17:15:34 -0800 (PST)
Date: Sun, 5 Nov 2023 20:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699233332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=as1onjtxFto0vERjKm3lC5v6nA5cKq4ybDT95cE8OVY=;
	b=era/po9ELOwg2uepbSK2Z+BdxjLSWxBaJsf6k96sCHi0Mn4m8XDRRaWaUdHjkfiCSam+eJ
	7pwvrjNVAbCcfnTy49vKurb9UKezJDNBxgvvh7REKMHyJHbjfRDOxls6EkGERVHIApogk3
	WlkDgUkxLpqqcmuSz9WNX7nSu39cjoQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernell.org
Subject: [GIT PULL] bcachefs for 6.7-rc1, part 2
Message-ID: <20231106011240.26o5og36epek2ybj@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, here's the rest of the bcachefs patches for the merge window.

Cheers,
Kent

The following changes since commit cd063c8b9e1e95560e90bac7816234d8b2ee2897:

  Merge tag 'objtool-core-2023-10-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2023-10-30 13:20:02 -1000)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-11-5

for you to fetch changes up to c7046ed0cf9bb33599aa7e72e7b67bba4be42d64:

  bcachefs: Improve stripe checksum error message (2023-11-05 13:14:22 -0500)

----------------------------------------------------------------
Second bcachefs pull request for 6.7-rc1

Here's the second big bcachefs pull request. This brings your tree up to
date with my master branch, which is what existing bcachefs users are
currently running.

All but the last few patches have been in linux-next, those being small
fixes. Test results from my dashboard:
  https://evilpiepirate.org/~testdashboard/ci?commit=c7046ed0cf9bb33599aa7e72e7b67bba4be42d64

New features:
 - rebalance_work btree (and metadata version 1.3): the rebalance thread
   no longer has to scan to find extents that need processing - big
   scalability improvement.
 - sb_errors superblock section: this adds counters for each fsck error
   type, since filesystem creation, along with the date of the most
   recent error. It'll get us better bug reports (since users do not
   typically report errors that fsck was able to fix), and I might add
   telemetry for this in the future.

Fixes include:
 - multiple snapshot deletion fixes
 - members_v2 fixups
 - deleted_inodes btree fixes
 - copygc thread no longer spins when a device is full but has no
   fragmented buckets (i.e. rebalance needs to move data around instead)
 - a fix for a memory reclaim issue with the btree key cache: we're now
   careful not to hold the srcu read lock that blocks key cache reclaim
   for too long
 - an early allocator locking fix, from Brian
 - endianness fixes, from Brian
 - CONFIG_BCACHEFS_DEBUG_TRANSACTIONS no longer defaults to y, a big
   performance improvement on multithreaded workloads

----------------------------------------------------------------
Brian Foster (6):
      bcachefs: serialize on cached key in early bucket allocator
      bcachefs: update alloc cursor in early bucket allocator
      bcachefs: fix odebug warn and lockdep splat due to on-stack rhashtable
      bcachefs: allow writeback to fill bio completely
      bcachefs: byte order swap bch_alloc_v4.fragmentation_lru field
      bcachefs: use swab40 for bch_backpointer.bucket_offset bitfield

Kent Overstreet (64):
      closures: Better memory barriers
      closures: Fix race in closure_sync()
      six locks: Lock contended tracepoints
      bcachefs: Fix lock ordering with snapshot_create_lock
      bcachefs: Don't run bch2_delete_dead_snapshots() unnecessarily
      bcachefs: bch2_btree_id_str()
      bcachefs: Fix btree_node_type enum
      bcachefs: Fix shrinker names
      bcachefs: Fix ca->oldest_gen allocation
      bcachefs: Kill dead code extent_save()
      bcachefs: Delete duplicate time stats initialization
      bcachefs: Ensure devices are always correctly initialized
      bcachefs: Improve io option handling in data move path
      bcachefs: All triggers are BTREE_TRIGGER_WANTS_OLD_AND_NEW
      bcachefs: Split apart bch2_target_to_text(), bch2_target_to_text_sb()
      bcachefs: Split out disk_groups_types.h
      bcachefs: bch2_disk_path_to_text() no longer takes sb_lock
      bcachefs: Ensure we don't exceed encoded_extent_max
      bcachefs: Check for too-large encoded extents
      bcachefs: Fix bch2_prt_bitflags()
      bcachefs: trivial extents.c refactoring
      bcachefs: Guard against unknown compression options
      bcachefs: move.c exports, refactoring
      bcachefs: moving_context now owns a btree_trans
      bcachefs: move: convert to bbpos
      bcachefs: move: move_stats refactoring
      bcachefs: bch2_inum_opts_get()
      bcachefs: rebalance_work
      bcachefs: Fix kasan splat in members_v1_get()
      bcachefs: Fix a kasan splat in bch2_dev_add()
      bcachefs: Fix snapshot skiplists
      bcachefs: Add IO error counts to bch_member
      bcachefs: bch_sb_field_errors
      bcachefs: Enumerate fsck errors
      bcachefs: Fix error path in bch2_replicas_gc_end()
      bcachefs: Fix deleted inodes btree in snapshot deletion
      bcachefs: Don't downgrade locks on transaction restart
      bcachefs: Fix an integer overflow
      bcachefs: Skip deleted members in member_to_text()
      bcachefs: Ensure copygc does not spin
      bcachefs: Fix MEAN_AND_VARIANCE kconfig options
      bcachefs: Fix build errors with gcc 10
      bcachefs: Ensure srcu lock is not held too long
      bcachefs: Data move path now uses bch2_trans_unlock_long()
      bcachefs: Fix bch2_delete_dead_inodes()
      bcachefs: .get_parent() should return an error pointer
      bcachefs: Fix recovery when forced to use JSET_NO_FLUSH journal entry
      bcachefs: Add missing printk newlines
      bcachefs: rebalance_work btree is not a snapshots btree
      bcachefs: Add a comment for BTREE_INSERT_NOJOURNAL usage
      bcachefs: CONFIG_BCACHEFS_DEBUG_TRANSACTIONS no longer defaults to y
      bcachefs: bch2_prt_datetime()
      bcachefs: Move __bch2_members_v2_get_mut to sb-members.h
      bcachefs: Convert bch2_fs_open() to darray
      bcachefs: x-macro-ify inode flags enum
      bcachefs: bkey_copy() is no longer a macro
      bcachefs: Replace ERANGE with private error codes
      bcachefs: Break up bch2_journal_write()
      bcachefs: Don't iterate over journal entries just for btree roots
      bcachefs: bch2_stripe_to_text() now prints ptr gens
      bcachefs: bch2_ec_read_extent() now takes btree_trans
      bcachefs: kill thing_it_points_to arg to backpointer_not_found()
      bcachefs: Simplify, fix bch2_backpointer_get_key()
      bcachefs: Improve stripe checksum error message

 fs/bcachefs/Kconfig                 |   4 +-
 fs/bcachefs/Makefile                |   1 +
 fs/bcachefs/alloc_background.c      | 185 ++++++------
 fs/bcachefs/alloc_background.h      |  11 +-
 fs/bcachefs/alloc_foreground.c      |  38 ++-
 fs/bcachefs/backpointers.c          | 114 ++++----
 fs/bcachefs/backpointers.h          |  11 +-
 fs/bcachefs/bbpos.h                 |  17 +-
 fs/bcachefs/bbpos_types.h           |  18 ++
 fs/bcachefs/bcachefs.h              |  23 +-
 fs/bcachefs/bcachefs_format.h       | 122 ++++----
 fs/bcachefs/bkey.h                  |  22 +-
 fs/bcachefs/bkey_methods.c          | 169 +++++------
 fs/bcachefs/bkey_methods.h          |  15 +-
 fs/bcachefs/bkey_sort.c             |   6 +-
 fs/bcachefs/btree_cache.c           |  23 +-
 fs/bcachefs/btree_cache.h           |   5 +-
 fs/bcachefs/btree_gc.c              | 148 ++++++----
 fs/bcachefs/btree_io.c              | 221 +++++++++-----
 fs/bcachefs/btree_iter.c            |  71 +++--
 fs/bcachefs/btree_iter.h            |   8 +-
 fs/bcachefs/btree_key_cache.c       |   8 +-
 fs/bcachefs/btree_locking.c         |  44 ++-
 fs/bcachefs/btree_locking.h         |  18 +-
 fs/bcachefs/btree_trans_commit.c    |  35 +--
 fs/bcachefs/btree_types.h           |  49 ++--
 fs/bcachefs/btree_update_interior.c |  20 +-
 fs/bcachefs/btree_update_interior.h |   6 +-
 fs/bcachefs/buckets.c               | 182 ++++++++----
 fs/bcachefs/buckets.h               |  15 +
 fs/bcachefs/chardev.c               |   4 +-
 fs/bcachefs/compress.c              |  26 +-
 fs/bcachefs/compress.h              |  36 ++-
 fs/bcachefs/darray.h                |   6 +
 fs/bcachefs/data_update.c           |  33 +--
 fs/bcachefs/data_update.h           |   1 +
 fs/bcachefs/debug.c                 |   8 +-
 fs/bcachefs/dirent.c                |  76 +++--
 fs/bcachefs/dirent.h                |   2 +-
 fs/bcachefs/disk_groups.c           | 146 +++++++---
 fs/bcachefs/disk_groups.h           |   7 +-
 fs/bcachefs/disk_groups_types.h     |  18 ++
 fs/bcachefs/ec.c                    |  67 ++---
 fs/bcachefs/ec.h                    |   4 +-
 fs/bcachefs/errcode.h               |   4 +
 fs/bcachefs/error.c                 |  32 ++-
 fs/bcachefs/error.h                 |  90 ++++--
 fs/bcachefs/extents.c               | 409 ++++++++++++++++----------
 fs/bcachefs/extents.h               |  51 ++--
 fs/bcachefs/fs-common.c             |   2 +-
 fs/bcachefs/fs-io-buffered.c        |  19 +-
 fs/bcachefs/fs-io-direct.c          |   1 +
 fs/bcachefs/fs-ioctl.c              |   4 +-
 fs/bcachefs/fs-ioctl.h              |  28 +-
 fs/bcachefs/fs.c                    |   9 +-
 fs/bcachefs/fsck.c                  | 183 ++++++++----
 fs/bcachefs/fsck.h                  |   1 +
 fs/bcachefs/inode.c                 | 265 ++++++++++-------
 fs/bcachefs/inode.h                 |  28 +-
 fs/bcachefs/io_misc.c               |  15 +-
 fs/bcachefs/io_misc.h               |   2 +-
 fs/bcachefs/io_read.c               |   6 +-
 fs/bcachefs/io_write.c              |  40 +--
 fs/bcachefs/journal.c               |  19 ++
 fs/bcachefs/journal.h               |   1 +
 fs/bcachefs/journal_io.c            | 295 +++++++++++--------
 fs/bcachefs/lru.c                   |  18 +-
 fs/bcachefs/lru.h                   |   2 +-
 fs/bcachefs/move.c                  | 407 ++++++++++++++------------
 fs/bcachefs/move.h                  |  63 +++-
 fs/bcachefs/move_types.h            |   8 +-
 fs/bcachefs/movinggc.c              |  69 +++--
 fs/bcachefs/opts.c                  |  15 +-
 fs/bcachefs/opts.h                  |   4 +-
 fs/bcachefs/printbuf.c              |   4 +-
 fs/bcachefs/quota.c                 |  15 +-
 fs/bcachefs/quota.h                 |   2 +-
 fs/bcachefs/rebalance.c             | 558 +++++++++++++++++++++---------------
 fs/bcachefs/rebalance.h             |   9 +-
 fs/bcachefs/rebalance_types.h       |  31 +-
 fs/bcachefs/recovery.c              |  52 ++--
 fs/bcachefs/recovery_types.h        |   6 +-
 fs/bcachefs/reflink.c               |  61 ++--
 fs/bcachefs/reflink.h               |   6 +-
 fs/bcachefs/replicas.c              |  18 +-
 fs/bcachefs/sb-clean.c              |   5 +-
 fs/bcachefs/sb-errors.c             | 172 +++++++++++
 fs/bcachefs/sb-errors.h             | 270 +++++++++++++++++
 fs/bcachefs/sb-errors_types.h       |  16 ++
 fs/bcachefs/sb-members.c            | 159 +++++++---
 fs/bcachefs/sb-members.h            |  49 +++-
 fs/bcachefs/six.c                   |   8 +-
 fs/bcachefs/snapshot.c              | 202 +++++++------
 fs/bcachefs/snapshot.h              |   6 +-
 fs/bcachefs/subvolume.c             |  37 +--
 fs/bcachefs/subvolume.h             |   2 +-
 fs/bcachefs/super-io.c              |  20 +-
 fs/bcachefs/super-io.h              |  40 +--
 fs/bcachefs/super.c                 | 127 ++++----
 fs/bcachefs/super_types.h           |  12 -
 fs/bcachefs/sysfs.c                 |  45 +--
 fs/bcachefs/trace.c                 |   1 +
 fs/bcachefs/trace.h                 |  90 ++++--
 fs/bcachefs/util.c                  |  18 ++
 fs/bcachefs/util.h                  |  21 +-
 fs/bcachefs/xattr.c                 |  60 ++--
 fs/bcachefs/xattr.h                 |   2 +-
 include/linux/closure.h             |  12 +-
 lib/closure.c                       |   9 +-
 109 files changed, 3982 insertions(+), 2296 deletions(-)
 create mode 100644 fs/bcachefs/bbpos_types.h
 create mode 100644 fs/bcachefs/disk_groups_types.h
 create mode 100644 fs/bcachefs/sb-errors.c
 create mode 100644 fs/bcachefs/sb-errors.h
 create mode 100644 fs/bcachefs/sb-errors_types.h


