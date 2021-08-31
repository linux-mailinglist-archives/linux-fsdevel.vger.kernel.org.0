Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBECD3FCF07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 23:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhHaVTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 17:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230125AbhHaVTn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 17:19:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BB7261051;
        Tue, 31 Aug 2021 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630444728;
        bh=dFEDS3+0M1vTd7keLgv5QlXuXI/WLE3Zf/ksR1oquB4=;
        h=Date:From:To:Cc:Subject:From;
        b=h9G0OjLMsNoEqdUeAzrKnJ9A3krbhzmYI/qYu8E86zdpewuKEKBgsa566Fsha4exq
         8yYU7AXN4S2jxii19XxszDyNtQIxoyQe81OD64cKmcO2UTkG8Ox6p5glYKAkBapfGx
         O8R7wmR/a6XQ/cFq6vt3i2pwl+K5M70nPqNH1sC+GsEO185b4jg13/uvd8DXkH5+GU
         2P5+TXBwdLqq+b8kFFSC3sIoR20px4iMormPAoBFnSmxa6kL1R7BgabZahpPkIQymY
         2NARjUtU0WxtJaF53W6C1rdmTF5yZSMs60Rk56PpuVqnJDbU/OzL+iKnmN5EXALKZ4
         vxfQr11lEg5vg==
Date:   Tue, 31 Aug 2021 14:18:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.15
Message-ID: <20210831211847.GC9959@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing new code for 5.15.  There's a lot in
this cycle.

Starting with bug fixes: To avoid livelocks between the logging code and
the quota code, we've disabled the ability of quotaoff to turn off quota
accounting.  (Admins can still disable quota enforcement, but truly
turning off accounting requires a remount.)  We've tried to do this in a
careful enough way that there shouldn't be any user visible effects
aside from quotaoff no longer randomly hanging the system.

We've also fixed some bugs in runtime log behavior that could trip up
log recovery if (otherwise unrelated) transactions manage to start and
commit concurrently; some bugs in the GETFSMAP ioctl where we would
incorrectly restrict the range of records output if the two xfs devices
are of different sizes; a bug that resulted in fallocate funshare
failing unnecessarily; and broken behavior in the xfs inode cache when
DONTCACHE is in play.

As for new features: we now batch inode inactivations in percpu
background threads, which sharply decreases frontend thread wait time
when performing file deletions and should improve overall directory tree
deletion times.  This eliminates both the problem where closing an
unlinked file (especially on a frozen fs) can stall for a long time,
and should also ease complaints about direct reclaim bogging down on
unlinked file cleanup.

Starting with this release, we've enabled pipelining of the XFS log.  On
workloads with high rates of metadata updates to different shards of the
filesystem, multiple threads can be used to format committed log updates
into log checkpoints.

Lastly, with this release, two new features have graduated to supported
status: inode btree counters (for faster mounts), and support for dates
beyond Y2038.  Expect these to be enabled by default in a future release
of xfsprogs.

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.

--D

The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

  Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.15-merge-6

for you to fetch changes up to f38a032b165d812b0ba8378a5cd237c0888ff65f:

  xfs: fix I_DONTCACHE (2021-08-24 19:13:04 -0700)

----------------------------------------------------------------
New code for 5.15:
 - Fix a potential log livelock on busy filesystems when there's so much
   work going on that we can't finish a quotaoff before filling up the log
   by removing the ability to disable quota accounting.
 - Introduce the ability to use per-CPU data structures in XFS so that
   we can do a better job of maintaining CPU locality for certain
   operations.
 - Defer inode inactivation work to per-CPU lists, which will help us
   batch that processing.  Deletions of large sparse files will *appear*
   to run faster, but all that means is that we've moved the work to the
   backend.
 - Drop the EXPERIMENTAL warnings from the y2038+ support and the inode
   btree counters, since it's been nearly a year and no complaints have
   come in.
 - Remove more of our bespoke kmem* variants in favor of using the
   standard Linux calls.
 - Prepare for the addition of log incompat features in upcoming cycles
   by actually adding code to support this.
 - Small cleanups of the xattr code in preparation for landing support
   for full logging of extended attribute updates in a future cycle.
 - Replace the various log shutdown state and flag code all over xfs
   with a single atomic bit flag.
 - Fix a serious log recovery bug where log item replay can be skipped
   based on the start lsn of a transaction even though the transaction
   commit lsn is the key data point for that by enforcing start lsns to
   appear in the log in the same order as commit lsns.
 - Enable pipelining in the code that pushes log items to disk.
 - Drop ->writepage.
 - Fix some bugs in GETFSMAP where the last fsmap record reported for a
   device could extend beyond the end of the device, and a separate bug
   where query keys for one device could be applied to another.
 - Don't let GETFSMAP query functions edit their input parameters.
 - Small cleanups to the scrub code's handling of perag structures.
 - Small cleanups to the incore inode tree walk code.
 - Constify btree function parameters that aren't changed, so that there
   will never again be confusion about range query functions changing
   their input parameters.
 - Standardize the format and names of tracepoint data attributes.
 - Clean up all the mount state and feature flags to use wrapped bitset
   functions instead of inconsistently open-coded flag checks.
 - Fix some confusion between xfs_buf hash table key variable vs. block
   number.
 - Fix a mis-interaction with iomap where we reported shared delalloc
   cow fork extents to iomap, which would cause the iomap unshare
   operation to return IO errors unnecessarily.
 - Fix DONTCACHE behavior.

----------------------------------------------------------------
Allison Henderson (2):
      xfs: add attr state machine tracepoints
      xfs: Rename __xfs_attr_rmtval_remove

Christoph Hellwig (5):
      xfs: remove support for disabling quota accounting on a mounted file system
      xfs: remove xfs_dqrele_all_inodes
      xfs: remove the flags argument to xfs_qm_dquot_walk
      xfs: remove the active vs running quota differentiation
      xfs: remove support for untagged lookups in xfs_icwalk*

Darrick J. Wong (51):
      xfs: move xfs_inactive call to xfs_inode_mark_reclaimable
      xfs: detach dquots from inode if we don't need to inactivate it
      xfs: queue inactivation immediately when free space is tight
      xfs: queue inactivation immediately when quota is nearing enforcement
      xfs: queue inactivation immediately when free realtime extents are tight
      xfs: inactivate inodes any time we try to free speculative preallocations
      xfs: flush inode inactivation work when compiling usage statistics
      xfs: don't run speculative preallocation gc when fs is frozen
      xfs: use background worker pool when transactions can't get free space
      xfs: avoid buffer deadlocks when walking fs inodes
      xfs: throttle inode inactivation queuing on memory reclaim
      xfs: fix silly whitespace problems with kernel libxfs
      xfs: drop experimental warnings for bigtime and inobtcount
      xfs: grab active perag ref when reading AG headers
      xfs: dump log intent items that cannot be recovered due to corruption
      xfs: allow setting and clearing of log incompat feature flags
      xfs: clear log incompat feature bits when the log is idle
      xfs: refactor xfs_iget calls from log intent recovery
      xfs: make xfs_rtalloc_query_range input parameters const
      xfs: fix off-by-one error when the last rt extent is in use
      xfs: make fsmap backend function key parameters const
      xfs: remove unnecessary agno variable from struct xchk_ag
      xfs: add trace point for fs shutdown
      xfs: make the key parameters to all btree key comparison functions const
      xfs: make the key parameters to all btree query range functions const
      xfs: make the record pointer passed to query_range functions const
      xfs: mark the record passed into btree init_key functions as const
      xfs: make the keys and records passed to btree inorder functions const
      xfs: mark the record passed into xchk_btree functions as const
      xfs: make the pointer passed to btree set_root functions const
      xfs: make the start pointer passed to btree alloc_block functions const
      xfs: make the start pointer passed to btree update_lastrec functions const
      xfs: constify btree function parameters that are not modified
      xfs: fix incorrect unit conversion in scrub tracepoint
      xfs: standardize inode number formatting in ftrace output
      xfs: standardize AG number formatting in ftrace output
      xfs: standardize AG block number formatting in ftrace output
      xfs: standardize rmap owner number formatting in ftrace output
      xfs: standardize daddr formatting in ftrace output
      xfs: disambiguate units for ftrace fields tagged "blkno", "block", or "bno"
      xfs: disambiguate units for ftrace fields tagged "offset"
      xfs: disambiguate units for ftrace fields tagged "len"
      xfs: disambiguate units for ftrace fields tagged "count"
      xfs: rename i_disk_size fields in ftrace output
      xfs: resolve fork names in trace output
      xfs: standardize remaining xfs_buf length tracepoints
      xfs: standardize inode generation formatting in ftrace output
      xfs: decode scrub flags in ftrace output
      xfs: start documenting common units and tags used in tracepoints
      xfs: fix perag structure refcounting error when scrub fails
      xfs: only set IOMAP_F_SHARED when providing a srcmap to a write

Dave Chinner (44):
      xfs: introduce CPU hotplug infrastructure
      xfs: introduce all-mounts list for cpu hotplug notifications
      xfs: per-cpu deferred inode inactivation queues
      mm: Add kvrealloc()
      xfs: remove kmem_alloc_io()
      xfs: replace kmem_alloc_large() with kvmalloc()
      xfs: convert XLOG_FORCED_SHUTDOWN() to xlog_is_shutdown()
      xfs: XLOG_STATE_IOERROR must die
      xfs: move recovery needed state updates to xfs_log_mount_finish
      xfs: convert log flags to an operational state field
      xfs: make forced shutdown processing atomic
      xfs: rework xlog_state_do_callback()
      xfs: separate out log shutdown callback processing
      xfs: don't run shutdown callbacks on active iclogs
      xfs: log head and tail aren't reliable during shutdown
      xfs: move xlog_commit_record to xfs_log_cil.c
      xfs: pass a CIL context to xlog_write()
      xfs: factor out log write ordering from xlog_cil_push_work()
      xfs: attach iclog callbacks in xlog_cil_set_ctx_write_state()
      xfs: order CIL checkpoint start records
      xfs: AIL needs asynchronous CIL forcing
      xfs: CIL work is serialised, not pipelined
      xfs: move the CIL workqueue to the CIL
      xfs: drop ->writepage completely
      xfs: sb verifier doesn't handle uncached sb buffer
      xfs: rename xfs_has_attr()
      xfs: rework attr2 feature and mount options
      xfs: reflect sb features in xfs_mount
      xfs: replace xfs_sb_version checks with feature flag checks
      xfs: consolidate mount option features in m_features
      xfs: convert mount flags to features
      xfs: convert remaining mount flags to state flags
      xfs: replace XFS_FORCED_SHUTDOWN with xfs_is_shutdown
      xfs: convert xfs_fs_geometry to use mount feature checks
      xfs: open code sb verifier feature checks
      xfs: convert scrub to use mount-based feature checks
      xfs: convert xfs_sb_version_has checks to use mount features
      xfs: remove unused xfs_sb_version_has wrappers
      xfs: introduce xfs_sb_is_v5 helper
      xfs: kill xfs_sb_version_has_v3inode()
      xfs: introduce xfs_buf_daddr()
      xfs: convert bp->b_bn references to xfs_buf_daddr()
      xfs: rename buffer cache index variable b_bn
      xfs: fix I_DONTCACHE

Dwaipayan Ray (1):
      xfs: cleanup __FUNCTION__ usage

 fs/xfs/kmem.c                      |  64 ----
 fs/xfs/kmem.h                      |   2 -
 fs/xfs/libxfs/xfs_ag.c             |  25 +-
 fs/xfs/libxfs/xfs_alloc.c          |  56 +--
 fs/xfs/libxfs/xfs_alloc.h          |  12 +-
 fs/xfs/libxfs/xfs_alloc_btree.c    | 100 ++---
 fs/xfs/libxfs/xfs_alloc_btree.h    |   2 +-
 fs/xfs/libxfs/xfs_attr.c           |  56 ++-
 fs/xfs/libxfs/xfs_attr.h           |   1 -
 fs/xfs/libxfs/xfs_attr_leaf.c      |  57 +--
 fs/xfs/libxfs/xfs_attr_remote.c    |  21 +-
 fs/xfs/libxfs/xfs_attr_remote.h    |   2 +-
 fs/xfs/libxfs/xfs_bmap.c           |  38 +-
 fs/xfs/libxfs/xfs_bmap_btree.c     |  56 +--
 fs/xfs/libxfs/xfs_bmap_btree.h     |   9 +-
 fs/xfs/libxfs/xfs_btree.c          | 141 +++----
 fs/xfs/libxfs/xfs_btree.h          |  56 +--
 fs/xfs/libxfs/xfs_btree_staging.c  |  14 +-
 fs/xfs/libxfs/xfs_da_btree.c       |  18 +-
 fs/xfs/libxfs/xfs_da_format.h      |   2 +-
 fs/xfs/libxfs/xfs_dir2.c           |   6 +-
 fs/xfs/libxfs/xfs_dir2_block.c     |  14 +-
 fs/xfs/libxfs/xfs_dir2_data.c      |  20 +-
 fs/xfs/libxfs/xfs_dir2_leaf.c      |  14 +-
 fs/xfs/libxfs/xfs_dir2_node.c      |  20 +-
 fs/xfs/libxfs/xfs_dir2_priv.h      |   2 +-
 fs/xfs/libxfs/xfs_dir2_sf.c        |  12 +-
 fs/xfs/libxfs/xfs_dquot_buf.c      |   8 +-
 fs/xfs/libxfs/xfs_format.h         | 226 ++---------
 fs/xfs/libxfs/xfs_ialloc.c         |  69 ++--
 fs/xfs/libxfs/xfs_ialloc.h         |   3 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c   |  88 ++---
 fs/xfs/libxfs/xfs_ialloc_btree.h   |   2 +-
 fs/xfs/libxfs/xfs_inode_buf.c      |  22 +-
 fs/xfs/libxfs/xfs_inode_buf.h      |  11 +-
 fs/xfs/libxfs/xfs_log_format.h     |   6 +-
 fs/xfs/libxfs/xfs_log_recover.h    |   2 +
 fs/xfs/libxfs/xfs_log_rlimit.c     |   2 +-
 fs/xfs/libxfs/xfs_quota_defs.h     |  30 +-
 fs/xfs/libxfs/xfs_refcount.c       |  12 +-
 fs/xfs/libxfs/xfs_refcount.h       |   2 +-
 fs/xfs/libxfs/xfs_refcount_btree.c |  54 +--
 fs/xfs/libxfs/xfs_rmap.c           |  34 +-
 fs/xfs/libxfs/xfs_rmap.h           |  11 +-
 fs/xfs/libxfs/xfs_rmap_btree.c     |  72 ++--
 fs/xfs/libxfs/xfs_rmap_btree.h     |   2 +-
 fs/xfs/libxfs/xfs_rtbitmap.c       |  14 +-
 fs/xfs/libxfs/xfs_sb.c             | 263 +++++++++----
 fs/xfs/libxfs/xfs_sb.h             |   4 +-
 fs/xfs/libxfs/xfs_symlink_remote.c |  14 +-
 fs/xfs/libxfs/xfs_trans_inode.c    |   2 +-
 fs/xfs/libxfs/xfs_trans_resv.c     |  48 +--
 fs/xfs/libxfs/xfs_trans_resv.h     |   2 -
 fs/xfs/libxfs/xfs_trans_space.h    |   6 +-
 fs/xfs/libxfs/xfs_types.c          |   2 +-
 fs/xfs/libxfs/xfs_types.h          |   5 +
 fs/xfs/scrub/agheader.c            |  47 ++-
 fs/xfs/scrub/agheader_repair.c     |  66 ++--
 fs/xfs/scrub/alloc.c               |   2 +-
 fs/xfs/scrub/attr.c                |  16 +-
 fs/xfs/scrub/attr.h                |   3 -
 fs/xfs/scrub/bitmap.c              |   4 +-
 fs/xfs/scrub/bmap.c                |  41 +-
 fs/xfs/scrub/btree.c               |   9 +-
 fs/xfs/scrub/btree.h               |   4 +-
 fs/xfs/scrub/common.c              |  77 ++--
 fs/xfs/scrub/common.h              |  18 +-
 fs/xfs/scrub/dabtree.c             |   4 +-
 fs/xfs/scrub/dir.c                 |  10 +-
 fs/xfs/scrub/fscounters.c          |   6 +-
 fs/xfs/scrub/ialloc.c              |   4 +-
 fs/xfs/scrub/inode.c               |  14 +-
 fs/xfs/scrub/quota.c               |   4 +-
 fs/xfs/scrub/refcount.c            |   4 +-
 fs/xfs/scrub/repair.c              |  32 +-
 fs/xfs/scrub/rmap.c                |   2 +-
 fs/xfs/scrub/rtbitmap.c            |   2 +-
 fs/xfs/scrub/scrub.c               |  23 +-
 fs/xfs/scrub/scrub.h               |   3 +-
 fs/xfs/scrub/trace.c               |   8 +-
 fs/xfs/scrub/trace.h               |  78 ++--
 fs/xfs/xfs_acl.c                   |   2 +-
 fs/xfs/xfs_aops.c                  |  25 +-
 fs/xfs/xfs_attr_inactive.c         |   6 +-
 fs/xfs/xfs_attr_list.c             |   2 +-
 fs/xfs/xfs_bmap_item.c             |  14 +-
 fs/xfs/xfs_bmap_util.c             |  20 +-
 fs/xfs/xfs_buf.c                   |  40 +-
 fs/xfs/xfs_buf.h                   |  25 +-
 fs/xfs/xfs_buf_item.c              |   6 +-
 fs/xfs/xfs_buf_item_recover.c      |  10 +-
 fs/xfs/xfs_dir2_readdir.c          |   4 +-
 fs/xfs/xfs_discard.c               |   2 +-
 fs/xfs/xfs_dquot.c                 |  13 +-
 fs/xfs/xfs_dquot.h                 |  10 +
 fs/xfs/xfs_dquot_item.c            | 134 -------
 fs/xfs/xfs_dquot_item.h            |  17 -
 fs/xfs/xfs_dquot_item_recover.c    |   4 +-
 fs/xfs/xfs_error.c                 |   4 +-
 fs/xfs/xfs_error.h                 |  12 +
 fs/xfs/xfs_export.c                |   4 +-
 fs/xfs/xfs_extfree_item.c          |   3 +
 fs/xfs/xfs_file.c                  |  18 +-
 fs/xfs/xfs_filestream.c            |   2 +-
 fs/xfs/xfs_filestream.h            |   2 +-
 fs/xfs/xfs_fsmap.c                 |  68 ++--
 fs/xfs/xfs_fsops.c                 |  63 ++--
 fs/xfs/xfs_health.c                |   2 +-
 fs/xfs/xfs_icache.c                | 754 ++++++++++++++++++++++++++++---------
 fs/xfs/xfs_icache.h                |  14 +-
 fs/xfs/xfs_icreate_item.c          |   4 +-
 fs/xfs/xfs_inode.c                 | 102 +++--
 fs/xfs/xfs_inode.h                 |  25 +-
 fs/xfs/xfs_inode_item.c            |   2 +-
 fs/xfs/xfs_inode_item_recover.c    |   2 +-
 fs/xfs/xfs_ioctl.c                 |  33 +-
 fs/xfs/xfs_ioctl32.c               |   4 +-
 fs/xfs/xfs_iomap.c                 |  24 +-
 fs/xfs/xfs_iops.c                  |  32 +-
 fs/xfs/xfs_itable.c                |  44 ++-
 fs/xfs/xfs_iwalk.c                 |  33 +-
 fs/xfs/xfs_log.c                   | 723 ++++++++++++++++++-----------------
 fs/xfs/xfs_log.h                   |   7 +-
 fs/xfs/xfs_log_cil.c               | 450 +++++++++++++++-------
 fs/xfs/xfs_log_priv.h              |  66 ++--
 fs/xfs/xfs_log_recover.c           | 161 ++++----
 fs/xfs/xfs_mount.c                 | 233 +++++++++---
 fs/xfs/xfs_mount.h                 | 248 ++++++++++--
 fs/xfs/xfs_pnfs.c                  |   2 +-
 fs/xfs/xfs_qm.c                    |  96 +++--
 fs/xfs/xfs_qm.h                    |   3 -
 fs/xfs/xfs_qm_bhv.c                |   2 +-
 fs/xfs/xfs_qm_syscalls.c           | 253 ++-----------
 fs/xfs/xfs_quota.h                 |   2 +
 fs/xfs/xfs_quotaops.c              |  30 +-
 fs/xfs/xfs_refcount_item.c         |   5 +-
 fs/xfs/xfs_reflink.c               |   4 +-
 fs/xfs/xfs_reflink.h               |   3 +-
 fs/xfs/xfs_rmap_item.c             |   5 +-
 fs/xfs/xfs_rtalloc.c               |   6 +-
 fs/xfs/xfs_rtalloc.h               |  13 +-
 fs/xfs/xfs_super.c                 | 538 +++++++++++++++-----------
 fs/xfs/xfs_symlink.c               |  13 +-
 fs/xfs/xfs_sysfs.c                 |   1 +
 fs/xfs/xfs_trace.c                 |   2 +
 fs/xfs/xfs_trace.h                 | 386 +++++++++++++------
 fs/xfs/xfs_trans.c                 |  33 +-
 fs/xfs/xfs_trans_ail.c             |  19 +-
 fs/xfs/xfs_trans_buf.c             |   8 +-
 fs/xfs/xfs_trans_dquot.c           |  51 +--
 include/linux/cpuhotplug.h         |   1 +
 include/linux/mm.h                 |   2 +
 mm/util.c                          |  15 +
 153 files changed, 4082 insertions(+), 3201 deletions(-)
