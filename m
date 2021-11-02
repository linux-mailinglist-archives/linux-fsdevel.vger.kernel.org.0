Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216F14435FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 19:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhKBSti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 14:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236003AbhKBStZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:49:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E35061050;
        Tue,  2 Nov 2021 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635878810;
        bh=e4mmZ1E1x7N9yMBlg1C9SEJsxmd3c5tVIwC4zmhhLbo=;
        h=Date:From:To:Cc:Subject:From;
        b=dLSz3abrhypxcuNcZWZCcViQ1nr7uhHbvS5+qrksBsADeH/shfomL4X9zcStxAx2I
         BBsv0y2YdM+wOn3BtGLqrvLigUf0OGHX/nqaYX3fAhRdtFnVs420Zh2OndumDsko7u
         84CcOnuooFIj17OBlt7rrWTC2DpZMupBwjZm0bSlsBKmcqPpjDtXHypT0Ggrf1vHBN
         iN3v4xv9U1aUOfxOkIjdpXZBgVaX1kq3dP+1ZeQTrtsytMb+JDw4cpG3AQ/uG78pBB
         lIZjkz/4ok/e9hdgR6+oVYUwR8Zy1Eh3NnfULxj/jaD2TUc0xu2FNN1/2uDGrp0qmh
         B411TWGIWMTZA==
Date:   Tue, 2 Nov 2021 11:46:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.16
Message-ID: <20211102184650.GH24307@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing new code for 5.16.  This cycle we've
worked on fixing bugs and improving XFS' memory footprint.

The most notable fixes include: fixing a corruption warning (and
free space accounting skew) if copy on write fails; fixing slab cache
misuse if SLOB is enabled, which apparently was broken for years without
anybody noticing; and fixing a potential race with online shrinkfs.

Otherwise, the bulk of the changes here involve setting up separate slab
caches for frequently used items such as btree cursors and log intent
items, and compacting the structures to reduce memory usage of those
items substantially.  This also sets us up to support larger btrees in
future kernels.  We also switch parts of online fsck to allocate scrub
context information from the heap instead of using stack space.

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.  There will probably be a second pull request next week with
a few more minor cleanups and bug fixes.

As a side note: the only iomap changes for 5.16 that I know of are
Andreas' gfs2 mmap pagefault deadlock fixes, which I think he's already
sent you separately.

--D

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-merge-4

for you to fetch changes up to 2a09b575074ff3ed23907b6f6f3da87af41f592b:

  xfs: use swap() to make code cleaner (2021-10-30 09:28:55 -0700)

----------------------------------------------------------------
New code for 5.16:
 * Bug fixes and cleanups for kernel memory allocation usage, this time
   without touching the mm code.
 * Refactor the log recovery mechanism that preserves held resources
   across a transaction roll so that it uses the exact same mechanism
   that we use for that during regular runtime.
 * Fix bugs and tighten checking around btree heights.
 * Remove more old typedefs.
 * Fix perag reference leaks when racing with growfs.
 * Remove unused fields from xfs_btree_cur.
 * Allocate various scrub structures on the heap to reduce stack usage.
 * Pack xfs_btree_cur fields and rearrange to support arbitrary heights.
 * Compute maximum possible heights for each btree height, and use that
   to set up slab caches for each btree type.
 * Finally remove kmem_zone_t, since these have always been struct
   kmem_cache on Linux.
 * Compact the structures used to coordinate work intent items.
 * Set up slab caches for each work intent item type.
 * Rename the "bmap_add_free" function to "free_extent_later", which
   more accurately describes what it does.
 * Fix corruption warning on unmount when a CoW preallocation covers a
   data fork delalloc reservation but then the CoW fails.
 * Add some more minor code improvements.

----------------------------------------------------------------
Brian Foster (5):
      xfs: fold perag loop iteration logic into helper function
      xfs: rename the next_agno perag iteration variable
      xfs: terminate perag iteration reliably on agcount
      xfs: fix perag reference leak on iteration race with growfs
      xfs: punch out data fork delalloc blocks on COW writeback failure

Changcheng Deng (1):
      xfs: use swap() to make code cleaner

Christoph Hellwig (3):
      xfs: remove the xfs_dinode_t typedef
      xfs: remove the xfs_dsb_t typedef
      xfs: remove the xfs_dqblk_t typedef

Darrick J. Wong (32):
      xfs: formalize the process of holding onto resources across a defer roll
      xfs: port the defer ops capture and continue to resource capture
      xfs: fix maxlevels comparisons in the btree staging code
      xfs: remove xfs_btree_cur_t typedef
      xfs: don't allocate scrub contexts on the stack
      xfs: stricter btree height checking when looking for errors
      xfs: stricter btree height checking when scanning for btree roots
      xfs: check that bc_nlevels never overflows
      xfs: fix incorrect decoding in xchk_btree_cur_fsbno
      xfs: remove xfs_btree_cur.bc_blocklog
      xfs: reduce the size of nr_ops for refcount btree cursors
      xfs: don't track firstrec/firstkey separately in xchk_btree
      xfs: dynamically allocate btree scrub context structure
      xfs: prepare xfs_btree_cur for dynamic cursor heights
      xfs: rearrange xfs_btree_cur fields for better packing
      xfs: refactor btree cursor allocation function
      xfs: encode the max btree height in the cursor
      xfs: dynamically allocate cursors based on maxlevels
      xfs: rename m_ag_maxlevels to m_allocbt_maxlevels
      xfs: compute maximum AG btree height for critical reservation calculation
      xfs: clean up xfs_btree_{calc_size,compute_maxlevels}
      xfs: compute the maximum height of the rmap btree when reflink enabled
      xfs: kill XFS_BTREE_MAXLEVELS
      xfs: compute absolute maximum nlevels for each btree type
      xfs: use separate btree cursor cache for each btree type
      xfs: remove kmem_zone typedef
      xfs: rename _zone variables to _cache
      xfs: compact deferred intent item structures
      xfs: create slab caches for frequently-used deferred items
      xfs: rename xfs_bmap_add_free to xfs_free_extent_later
      xfs: reduce the size of struct xfs_extent_free_item
      xfs: remove unused parameter from refcount code

Gustavo A. R. Silva (1):
      xfs: Use kvcalloc() instead of kvzalloc()

Qing Wang (1):
      xfs: replace snprintf in show functions with sysfs_emit

Rustam Kovhaev (1):
      xfs: use kmem_cache_free() for kmem_cache objects

Wan Jiabing (1):
      xfs: Remove duplicated include in xfs_super

 fs/xfs/kmem.h                      |   4 -
 fs/xfs/libxfs/xfs_ag.c             |   2 +-
 fs/xfs/libxfs/xfs_ag.h             |  36 ++--
 fs/xfs/libxfs/xfs_ag_resv.c        |   3 +-
 fs/xfs/libxfs/xfs_alloc.c          | 120 ++++++++++---
 fs/xfs/libxfs/xfs_alloc.h          |  38 ++++-
 fs/xfs/libxfs/xfs_alloc_btree.c    |  63 +++++--
 fs/xfs/libxfs/xfs_alloc_btree.h    |   5 +
 fs/xfs/libxfs/xfs_attr_leaf.c      |   2 +-
 fs/xfs/libxfs/xfs_bmap.c           | 101 ++++-------
 fs/xfs/libxfs/xfs_bmap.h           |  35 +---
 fs/xfs/libxfs/xfs_bmap_btree.c     |  62 +++++--
 fs/xfs/libxfs/xfs_bmap_btree.h     |   5 +
 fs/xfs/libxfs/xfs_btree.c          | 333 +++++++++++++++++++++++--------------
 fs/xfs/libxfs/xfs_btree.h          |  99 ++++++++---
 fs/xfs/libxfs/xfs_btree_staging.c  |   8 +-
 fs/xfs/libxfs/xfs_da_btree.c       |   6 +-
 fs/xfs/libxfs/xfs_da_btree.h       |   3 +-
 fs/xfs/libxfs/xfs_defer.c          | 241 ++++++++++++++++++++-------
 fs/xfs/libxfs/xfs_defer.h          |  41 ++++-
 fs/xfs/libxfs/xfs_dquot_buf.c      |   4 +-
 fs/xfs/libxfs/xfs_format.h         |  12 +-
 fs/xfs/libxfs/xfs_fs.h             |   2 +
 fs/xfs/libxfs/xfs_ialloc.c         |   5 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c   |  90 +++++++++-
 fs/xfs/libxfs/xfs_ialloc_btree.h   |   5 +
 fs/xfs/libxfs/xfs_inode_buf.c      |   6 +-
 fs/xfs/libxfs/xfs_inode_fork.c     |  24 +--
 fs/xfs/libxfs/xfs_inode_fork.h     |   2 +-
 fs/xfs/libxfs/xfs_refcount.c       |  46 +++--
 fs/xfs/libxfs/xfs_refcount.h       |   7 +-
 fs/xfs/libxfs/xfs_refcount_btree.c |  73 ++++++--
 fs/xfs/libxfs/xfs_refcount_btree.h |   5 +
 fs/xfs/libxfs/xfs_rmap.c           |  21 ++-
 fs/xfs/libxfs/xfs_rmap.h           |   7 +-
 fs/xfs/libxfs/xfs_rmap_btree.c     | 116 ++++++++++---
 fs/xfs/libxfs/xfs_rmap_btree.h     |   5 +
 fs/xfs/libxfs/xfs_sb.c             |   4 +-
 fs/xfs/libxfs/xfs_trans_resv.c     |  18 +-
 fs/xfs/libxfs/xfs_trans_space.h    |   9 +-
 fs/xfs/scrub/agheader.c            |  13 +-
 fs/xfs/scrub/agheader_repair.c     |   8 +-
 fs/xfs/scrub/bitmap.c              |  22 +--
 fs/xfs/scrub/bmap.c                |   2 +-
 fs/xfs/scrub/btree.c               | 121 +++++++-------
 fs/xfs/scrub/btree.h               |  17 +-
 fs/xfs/scrub/dabtree.c             |  62 +++----
 fs/xfs/scrub/repair.h              |   3 +
 fs/xfs/scrub/scrub.c               |  64 +++----
 fs/xfs/scrub/trace.c               |  11 +-
 fs/xfs/scrub/trace.h               |  10 +-
 fs/xfs/xfs_aops.c                  |  15 +-
 fs/xfs/xfs_attr_inactive.c         |   2 +-
 fs/xfs/xfs_bmap_item.c             |  18 +-
 fs/xfs/xfs_bmap_item.h             |   6 +-
 fs/xfs/xfs_buf.c                   |  14 +-
 fs/xfs/xfs_buf_item.c              |   8 +-
 fs/xfs/xfs_buf_item.h              |   2 +-
 fs/xfs/xfs_buf_item_recover.c      |   2 +-
 fs/xfs/xfs_dquot.c                 |  28 ++--
 fs/xfs/xfs_extfree_item.c          |  33 ++--
 fs/xfs/xfs_extfree_item.h          |   6 +-
 fs/xfs/xfs_icache.c                |  10 +-
 fs/xfs/xfs_icreate_item.c          |   6 +-
 fs/xfs/xfs_icreate_item.h          |   2 +-
 fs/xfs/xfs_inode.c                 |  12 +-
 fs/xfs/xfs_inode.h                 |   2 +-
 fs/xfs/xfs_inode_item.c            |   6 +-
 fs/xfs/xfs_inode_item.h            |   2 +-
 fs/xfs/xfs_ioctl.c                 |   6 +-
 fs/xfs/xfs_log.c                   |   6 +-
 fs/xfs/xfs_log_priv.h              |   2 +-
 fs/xfs/xfs_log_recover.c           |  12 +-
 fs/xfs/xfs_mount.c                 |  14 ++
 fs/xfs/xfs_mount.h                 |   5 +-
 fs/xfs/xfs_mru_cache.c             |   2 +-
 fs/xfs/xfs_qm.c                    |   2 +-
 fs/xfs/xfs_qm.h                    |   2 +-
 fs/xfs/xfs_refcount_item.c         |  18 +-
 fs/xfs/xfs_refcount_item.h         |   6 +-
 fs/xfs/xfs_reflink.c               |   2 +-
 fs/xfs/xfs_rmap_item.c             |  18 +-
 fs/xfs/xfs_rmap_item.h             |   6 +-
 fs/xfs/xfs_super.c                 | 233 +++++++++++++-------------
 fs/xfs/xfs_sysfs.c                 |  24 +--
 fs/xfs/xfs_trace.h                 |   2 +-
 fs/xfs/xfs_trans.c                 |  16 +-
 fs/xfs/xfs_trans.h                 |   8 +-
 fs/xfs/xfs_trans_dquot.c           |   4 +-
 89 files changed, 1656 insertions(+), 907 deletions(-)
