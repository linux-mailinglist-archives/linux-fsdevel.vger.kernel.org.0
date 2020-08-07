Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304D923E68E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 06:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgHGEIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 00:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgHGEIU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 00:08:20 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 740D622CAF;
        Fri,  7 Aug 2020 04:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596773298;
        bh=Hq0D4k+QbxtiLSy4CiZXpiyj0wvr2hJLrKqH6BdAuKQ=;
        h=Date:From:To:Cc:Subject:From;
        b=qftLEqDkLfRhyTBkB096YCuFyd4z5idGCrqrvyyOj2Dv9ZRdEXiejKur1ee5rJW/t
         0CDLI2dVa7y2+p7A9RmoSCfLOK78XO2/0580UGMKrM77aeKEqzamayF9PaHolLfvGO
         n8VGVkitXwuly880U+UtkUwRLd+r6yrj9Y39HTuQ=
Date:   Thu, 6 Aug 2020 21:08:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.9-rc1
Message-ID: <20200807040817.GD6096@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this large pile of new xfs code for 5.9.  There are quite a
few changes in this release, the most notable of which is that we've
made inode flushing fully asynchronous, and we no longer block memory
reclaim on this.  Furthermore, we have fixed a long-standing bug in the
quota code where soft limit warnings and inode limits were never tracked
properly.  Moving further down the line, the reflink control loops have
been redesigned to behave more efficiently; and numerous small bugs have
been fixed (see below).  The xattr and quota code have been extensively
refactored in preparation for more new features coming down the line.
Finally, the behavior of DAX between ext4 and xfs has been stabilized,
which gets us a step closer to removing the experimental tag from that
feature.

We have a few new contributors this time around.  Welcome, all!

This branch merges cleanly with master as of a few minutes ago, so
please let me know if anything strange happens.  I anticipate a second
pull request next week for a few small bugfixes that have been trickling
in, but this is it for big changes.

--D

The following changes since commit dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258:

  Linux 5.8-rc4 (2020-07-05 16:20:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.9-merge-7

for you to fetch changes up to 818d5a91559ffe1e1f2095dcbbdb96c13fdb94ec:

  fs/xfs: Support that ioctl(SETXFLAGS/GETXFLAGS) can set/get inode DAX on XFS. (2020-07-28 20:28:20 -0700)

----------------------------------------------------------------
New code for 5.9:
- Fix some btree block pingponging problems when swapping extents
- Redesign the reflink copy loop so that we only run one remapping
  operation per transaction.  This helps us avoid running out of block
  reservation on highly deduped filesystems.
- Take the MMAPLOCK around filemap_map_pages.
- Make inode reclaim fully async so that we avoid stalling processes on
  flushing inodes to disk.
- Reduce inode cluster buffer RMW cycles by attaching the buffer to
  dirty inodes so we won't let go of the cluster buffer when we know
  we're going to need it soon.
- Add some more checks to the realtime bitmap file scrubber.
- Don't trip false lockdep warnings in fs freeze.
- Remove various redundant lines of code.
- Remove unnecessary calls to xfs_perag_{get,put}.
- Preserve I_VERSION state across remounts.
- Fix an unmount hang due to AIL going to sleep with a non-empty delwri
  buffer list.
- Fix an error in the inode allocation space reservation macro that
  caused regressions in generic/531.
- Fix a potential livelock when dquot flush fails because the dquot
  buffer is locked.
- Fix a miscalculation when reserving inode quota that could cause users
  to exceed a hardlimit.
- Refactor struct xfs_dquot to use native types for incore fields
  instead of abusing the ondisk struct for this purpose.  This will
  eventually enable proper y2038+ support, but for now it merely cleans
  up the quota function declarations.
- Actually increment the quota softlimit warning counter so that soft
  failures turn into hard(er) failures when they exceed the softlimit
  warning counter limits set by the administrator.
- Split incore dquot state flags into their own field and namespace, to
  avoid mixing them with quota type flags.
- Create a new quota type flags namespace so that we can make it obvious
  when a quota function takes a quota type (user, group, project) as an
  argument.
- Rename the ondisk dquot flags field to type, as that more accurately
  represents what we store in it.
- Drop our bespoke memory allocation flags in favor of GFP_*.
- Rearrange the xattr functions so that we no longer mix metadata
  updates and transaction management (e.g. rolling complex transactions)
  in the same functions.  This work will prepare us for atomic xattr
  operations (itself a prerequisite for directory backrefs) in future
  release cycles.
- Support FS_DAX_FL (aka FS_XFLAG_DAX) via GETFLAGS/SETFLAGS.

----------------------------------------------------------------
Allison Collins (22):
      xfs: Add xfs_has_attr and subroutines
      xfs: Check for -ENOATTR or -EEXIST
      xfs: Factor out new helper functions xfs_attr_rmtval_set
      xfs: Pull up trans handling in xfs_attr3_leaf_flipflags
      xfs: Split apart xfs_attr_leaf_addname
      xfs: Refactor xfs_attr_try_sf_addname
      xfs: Pull up trans roll from xfs_attr3_leaf_setflag
      xfs: Factor out xfs_attr_rmtval_invalidate
      xfs: Pull up trans roll in xfs_attr3_leaf_clearflag
      xfs: Refactor xfs_attr_rmtval_remove
      xfs: Pull up xfs_attr_rmtval_invalidate
      xfs: Add helper function xfs_attr_node_shrink
      xfs: Remove unneeded xfs_trans_roll_inode calls
      xfs: Remove xfs_trans_roll in xfs_attr_node_removename
      xfs: Add helpers xfs_attr_is_shortform and xfs_attr_set_shortform
      xfs: Add helper function xfs_attr_leaf_mark_incomplete
      xfs: Add remote block helper functions
      xfs: Add helper function xfs_attr_node_removename_setup
      xfs: Add helper function xfs_attr_node_removename_rmt
      xfs: Simplify xfs_attr_leaf_addname
      xfs: Simplify xfs_attr_node_addname
      xfs: Lift -ENOSPC handler from xfs_attr_leaf_addname

Brian Foster (3):
      xfs: preserve rmapbt swapext block reservation from freed blocks
      xfs: drain the buf delwri queue before xfsaild idles
      xfs: fix inode allocation block res calculation precedence

Carlos Maiolino (5):
      xfs: Remove kmem_zone_alloc() usage
      xfs: Remove kmem_zone_zalloc() usage
      xfs: Modify xlog_ticket_alloc() to use kernel's MM API
      xfs: remove xfs_zone_{alloc,zalloc} helpers
      xfs: Refactor xfs_da_state_alloc() helper

Christoph Hellwig (1):
      xfs: remove SYNC_WAIT and SYNC_TRYLOCK

Darrick J. Wong (47):
      xfs: don't eat an EIO/ENOSPC writeback error when scrubbing data fork
      xfs: fix reflink quota reservation accounting error
      xfs: rename xfs_bmap_is_real_extent to is_written_extent
      xfs: redesign the reflink remap loop to fix blkres depletion crash
      xfs: only reserve quota blocks for bmbt changes if we're changing the data fork
      xfs: only reserve quota blocks if we're mapping into a hole
      xfs: reflink can skip remap existing mappings
      xfs: fix xfs_reflink_remap_prep calling conventions
      xfs: refactor locking and unlocking two inodes against userspace IO
      xfs: move helpers that lock and unlock two inodes against userspace IO
      xfs: rtbitmap scrubber should verify written extents
      xfs: rtbitmap scrubber should check inode size
      xfs: clear XFS_DQ_FREEING if we can't lock the dquot buffer to flush
      xfs: fix inode quota reservation checks
      xfs: validate ondisk/incore dquot flags
      xfs: move the flags argument of xfs_qm_scall_trunc_qfiles to XFS_QMOPT_*
      xfs: refactor quotacheck flags usage
      xfs: rename dquot incore state flags
      xfs: make XFS_DQUOT_CLUSTER_SIZE_FSB part of the ondisk format
      xfs: stop using q_core.d_flags in the quota code
      xfs: stop using q_core.d_id in the quota code
      xfs: use a per-resource struct for incore dquot data
      xfs: stop using q_core limits in the quota code
      xfs: stop using q_core counters in the quota code
      xfs: stop using q_core warning counters in the quota code
      xfs: stop using q_core timers in the quota code
      xfs: remove qcore from incore dquots
      xfs: refactor default quota limits by resource
      xfs: remove unnecessary arguments from quota adjust functions
      xfs: refactor quota exceeded test
      xfs: refactor xfs_qm_scall_setqlim
      xfs: refactor xfs_trans_dqresv
      xfs: refactor xfs_trans_apply_dquot_deltas
      xfs: assume the default quota limits are always set in xfs_qm_adjust_dqlimits
      xfs: actually bump warning counts when we send warnings
      xfs: add more dquot tracepoints
      xfs: drop the type parameter from xfs_dquot_verify
      xfs: rename XFS_DQ_{USER,GROUP,PROJ} to XFS_DQTYPE_*
      xfs: refactor testing if a particular dquot is being enforced
      xfs: remove the XFS_QM_IS[UGP]DQ macros
      xfs: refactor quota type testing
      xfs: always use xfs_dquot_type when extracting type from a dquot
      xfs: remove unnecessary quota type masking
      xfs: replace a few open-coded XFS_DQTYPE_REC_MASK uses
      xfs: create xfs_dqtype_t to represent quota types
      xfs: improve ondisk dquot flags checking
      xfs: rename the ondisk dquot d_flags to d_type

Dave Chinner (31):
      xfs: use MMAPLOCK around filemap_map_pages()
      xfs: Don't allow logging of XFS_ISTALE inodes
      xfs: remove logged flag from inode log item
      xfs: add an inode item lock
      xfs: mark inode buffers in cache
      xfs: mark dquot buffers in cache
      xfs: mark log recovery buffers for completion
      xfs: call xfs_buf_iodone directly
      xfs: clean up whacky buffer log item list reinit
      xfs: make inode IO completion buffer centric
      xfs: use direct calls for dquot IO completion
      xfs: clean up the buffer iodone callback functions
      xfs: get rid of log item callbacks
      xfs: handle buffer log item IO errors directly
      xfs: unwind log item error flagging
      xfs: move xfs_clear_li_failed out of xfs_ail_delete_one()
      xfs: pin inode backing buffer to the inode log item
      xfs: make inode reclaim almost non-blocking
      xfs: remove IO submission from xfs_reclaim_inode()
      xfs: allow multiple reclaimers per AG
      xfs: don't block inode reclaim on the ILOCK
      xfs: remove SYNC_TRYLOCK from inode reclaim
      xfs: remove SYNC_WAIT from xfs_reclaim_inodes()
      xfs: clean up inode reclaim comments
      xfs: rework stale inodes in xfs_ifree_cluster
      xfs: attach inodes to the cluster buffer when dirtied
      xfs: xfs_iflush() is no longer necessary
      xfs: rename xfs_iflush_int()
      xfs: rework xfs_iflush_cluster() dirty inode iteration
      xfs: factor xfs_iflush_done
      xfs: remove xfs_inobp_check()

Eric Sandeen (1):
      xfs: preserve inode versioning across remounts

Gao Xiang (1):
      xfs: get rid of unnecessary xfs_perag_{get,put} pairs

Keyur Patel (1):
      xfs: Couple of typo fixes in comments

Randy Dunlap (1):
      xfs: xfs_btree_staging.h: delete duplicated words

Waiman Long (1):
      xfs: Fix false positive lockdep warning with sb_internal & fs_reclaim

Xiao Yang (1):
      fs/xfs: Support that ioctl(SETXFLAGS/GETXFLAGS) can set/get inode DAX on XFS.

Yafang Shao (1):
      xfs: remove useless definitions in xfs_linux.h

YueHaibing (1):
      xfs: remove duplicated include from xfs_buf_item.c

 fs/xfs/kmem.c                      |  21 -
 fs/xfs/kmem.h                      |   8 -
 fs/xfs/libxfs/xfs_ag.c             |   4 +-
 fs/xfs/libxfs/xfs_ag_resv.h        |  12 -
 fs/xfs/libxfs/xfs_alloc.c          |  25 +-
 fs/xfs/libxfs/xfs_alloc_btree.c    |  10 +-
 fs/xfs/libxfs/xfs_attr.c           | 913 ++++++++++++++++++++++---------------
 fs/xfs/libxfs/xfs_attr.h           |   1 +
 fs/xfs/libxfs/xfs_attr_leaf.c      | 117 +++--
 fs/xfs/libxfs/xfs_attr_leaf.h      |   3 +
 fs/xfs/libxfs/xfs_attr_remote.c    | 216 ++++++---
 fs/xfs/libxfs/xfs_attr_remote.h    |   3 +-
 fs/xfs/libxfs/xfs_bmap.c           |   8 +-
 fs/xfs/libxfs/xfs_bmap.h           |  19 +-
 fs/xfs/libxfs/xfs_bmap_btree.c     |   2 +-
 fs/xfs/libxfs/xfs_btree_staging.h  |   6 +-
 fs/xfs/libxfs/xfs_da_btree.c       |  12 +-
 fs/xfs/libxfs/xfs_da_btree.h       |   2 +-
 fs/xfs/libxfs/xfs_dir2_node.c      |  17 +-
 fs/xfs/libxfs/xfs_dquot_buf.c      |  25 +-
 fs/xfs/libxfs/xfs_format.h         |  36 +-
 fs/xfs/libxfs/xfs_ialloc.c         |  28 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c   |   2 +-
 fs/xfs/libxfs/xfs_inode_buf.c      |  33 +-
 fs/xfs/libxfs/xfs_inode_buf.h      |   6 -
 fs/xfs/libxfs/xfs_inode_fork.c     |   6 +-
 fs/xfs/libxfs/xfs_quota_defs.h     |  31 +-
 fs/xfs/libxfs/xfs_refcount_btree.c |   6 +-
 fs/xfs/libxfs/xfs_rmap_btree.c     |  11 +-
 fs/xfs/libxfs/xfs_rtbitmap.c       |   2 +-
 fs/xfs/libxfs/xfs_shared.h         |   1 +
 fs/xfs/libxfs/xfs_trans_inode.c    | 110 +++--
 fs/xfs/libxfs/xfs_trans_space.h    |   2 +-
 fs/xfs/scrub/bmap.c                |  22 +-
 fs/xfs/scrub/dabtree.c             |   4 +-
 fs/xfs/scrub/quota.c               |  83 ++--
 fs/xfs/scrub/repair.c              |  10 +-
 fs/xfs/scrub/repair.h              |   4 +-
 fs/xfs/scrub/rtbitmap.c            |  47 ++
 fs/xfs/xfs_bmap_item.c             |   4 +-
 fs/xfs/xfs_bmap_util.c             |  18 +-
 fs/xfs/xfs_buf.c                   |  44 +-
 fs/xfs/xfs_buf.h                   |  48 +-
 fs/xfs/xfs_buf_item.c              | 436 +++++++++---------
 fs/xfs/xfs_buf_item.h              |   8 +-
 fs/xfs/xfs_buf_item_recover.c      |  14 +-
 fs/xfs/xfs_dquot.c                 | 415 +++++++++--------
 fs/xfs/xfs_dquot.h                 | 129 ++++--
 fs/xfs/xfs_dquot_item.c            |  26 +-
 fs/xfs/xfs_dquot_item_recover.c    |  14 +-
 fs/xfs/xfs_extfree_item.c          |   6 +-
 fs/xfs/xfs_file.c                  |  28 +-
 fs/xfs/xfs_icache.c                | 378 +++++----------
 fs/xfs/xfs_icache.h                |   5 +-
 fs/xfs/xfs_icreate_item.c          |   2 +-
 fs/xfs/xfs_inode.c                 | 702 +++++++++++++---------------
 fs/xfs/xfs_inode.h                 |   5 +-
 fs/xfs/xfs_inode_item.c            | 322 ++++++-------
 fs/xfs/xfs_inode_item.h            |  24 +-
 fs/xfs/xfs_inode_item_recover.c    |   2 +-
 fs/xfs/xfs_ioctl.c                 |  14 +-
 fs/xfs/xfs_iomap.c                 |  42 +-
 fs/xfs/xfs_linux.h                 |   4 -
 fs/xfs/xfs_log.c                   |   9 +-
 fs/xfs/xfs_log_cil.c               |   3 +-
 fs/xfs/xfs_log_priv.h              |   4 +-
 fs/xfs/xfs_log_recover.c           |   5 +-
 fs/xfs/xfs_mount.c                 |  15 +-
 fs/xfs/xfs_mount.h                 |   1 -
 fs/xfs/xfs_qm.c                    | 189 ++++----
 fs/xfs/xfs_qm.h                    | 104 ++---
 fs/xfs/xfs_qm_bhv.c                |  22 +-
 fs/xfs/xfs_qm_syscalls.c           | 250 +++++-----
 fs/xfs/xfs_quota.h                 |  19 +-
 fs/xfs/xfs_quotaops.c              |  26 +-
 fs/xfs/xfs_refcount_item.c         |   5 +-
 fs/xfs/xfs_reflink.c               | 355 +++++++-------
 fs/xfs/xfs_reflink.h               |   2 -
 fs/xfs/xfs_rmap_item.c             |   5 +-
 fs/xfs/xfs_super.c                 |  19 +-
 fs/xfs/xfs_trace.h                 | 226 ++++++---
 fs/xfs/xfs_trans.c                 |  23 +-
 fs/xfs/xfs_trans.h                 |   5 -
 fs/xfs/xfs_trans_ail.c             |  26 +-
 fs/xfs/xfs_trans_buf.c             |  15 +-
 fs/xfs/xfs_trans_dquot.c           | 369 ++++++++-------
 86 files changed, 3288 insertions(+), 2967 deletions(-)
