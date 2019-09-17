Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 971B2B53D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 19:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfIQRQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 13:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfIQRQr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:16:47 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118952053B;
        Tue, 17 Sep 2019 17:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568740606;
        bh=oKB/7pmxq3fBktjA7BHg+5DX+1z1TzlwA2j+8QRb67k=;
        h=Date:From:To:Cc:Subject:From;
        b=vyz3VKjTItOo78f6nn8wqjGmZvumHbIYpYoWZ9qNQqbosOL9e6EDh0c5IzbH/zC3Q
         gC4AtH8f204YrpfywqAIQtDiyJQ4RTvw0HdiRmeuTDZaKf3fOK1qu82i+1Q/YvrK9r
         c86Ihq2j7SS9UmO7KVj9NhgSMMyG/S9dcJScgV5w=
Date:   Tue, 17 Sep 2019 10:16:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.4
Message-ID: <20190917171645.GZ568270@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull the XFS changes for 5.4.  For this cycle we have the usual
pile of cleanups and bug fixes, some performance improvements for online
metadata scrubbing, massive speedups in the directory entry creation
code, some performance improvement in the file ACL lookup code, a fix
for a logging stall during mount, and fixes for concurrency problems.

It has survived a couple of weeks of xfstests runs and merges cleanly
with this morning's master.  Please let me know if anything strange
happens.

--D

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.4-merge-7

for you to fetch changes up to 14e15f1bcd738dc13dd7c1e78e4800e8bc577980:

  xfs: push the grant head when the log head moves forward (2019-09-05 21:36:13 -0700)

----------------------------------------------------------------
New code for 5.4:
- Remove KM_SLEEP/KM_NOSLEEP.
- Ensure that memory buffers for IO are properly sector-aligned to avoid
  problems that the block layer doesn't check.
- Make the bmap scrubber more efficient in its record checking.
- Don't crash xfs_db when superblock inode geometry is corrupt.
- Fix btree key helper functions.
- Remove unneeded error returns for things that can't fail.
- Fix buffer logging bugs in repair.
- Clean up iterator return values.
- Speed up directory entry creation.
- Enable allocation of xattr value memory buffer during lookup.
- Fix readahead racing with truncate/punch hole.
- Other minor cleanups.
- Fix one AGI/AGF deadlock with RENAME_WHITEOUT.
- More BUG -> WARN whackamole.
- Fix various problems with the log failing to advance under certain
  circumstances, which results in stalls during mount.

----------------------------------------------------------------
Austin Kim (1):
      xfs: Use WARN_ON_ONCE for bailout mount-operation

Christoph Hellwig (4):
      xfs: fix the dax supported check in xfs_ioctl_setattr_dax_invalidate
      xfs: cleanup xfs_fsb_to_db
      xfs: remove the unused XFS_ALLOC_USERDATA flag
      xfs: add a xfs_valid_startblock helper

Darrick J. Wong (12):
      xfs: bmap scrub should only scrub records once
      xfs: fix maxicount division by zero error
      xfs: don't return _QUERY_ABORT from xfs_rmap_has_other_keys
      xfs: fix sign handling problem in xfs_bmbt_diff_two_keys
      xfs: remove unnecessary parameter from xfs_iext_inc_seq
      xfs: remove unnecessary int returns from deferred rmap functions
      xfs: remove unnecessary int returns from deferred refcount functions
      xfs: remove unnecessary int returns from deferred bmap functions
      xfs: reinitialize rm_flags when unpacking an offset into an rmap irec
      xfs: remove all *_ITER_ABORT values
      xfs: remove all *_ITER_CONTINUE values
      xfs: define a flags field for the AG geometry ioctl structure

Dave Chinner (20):
      xfs: add kmem allocation trace points
      xfs: get allocation alignment from the buftarg
      xfs: add kmem_alloc_io()
      xfs: move xfs_dir2_addname()
      xfs: factor data block addition from xfs_dir2_node_addname_int()
      xfs: factor free block index lookup from xfs_dir2_node_addname_int()
      xfs: speed up directory bestfree block scanning
      xfs: reverse search directory freespace indexes
      xfs: make attr lookup returns consistent
      xfs: remove unnecessary indenting from xfs_attr3_leaf_getvalue
      xfs: move remote attr retrieval into xfs_attr3_leaf_getvalue
      xfs: consolidate attribute value copying
      xfs: allocate xattr buffer on demand
      xfs: push the AIL in xlog_grant_head_wake
      xfs: prevent CIL push holdoff in log recovery
      xfs: factor debug code out of xlog_state_do_callback()
      xfs: factor callbacks out of xlog_state_do_callback()
      xfs: factor iclog state processing out of xlog_state_do_callback()
      xfs: push iclog state cleaning into xlog_state_clean_log
      xfs: push the grant head when the log head moves forward

Eric Sandeen (1):
      xfs: log proper length of btree block in scrub/repair

Jan Kara (3):
      mm: Handle MADV_WILLNEED through vfs_fadvise()
      fs: Export generic_fadvise()
      xfs: Fix stale data exposure when readahead races with hole punch

Rik van Riel (1):
      xfs: fix missed wakeup on l_flush_wait

Tetsuo Handa (1):
      fs: xfs: Remove KM_NOSLEEP and KM_SLEEP.

kaixuxia (1):
      xfs: Fix deadlock between AGI and AGF with RENAME_WHITEOUT

zhengbin (1):
      xfs: remove excess function parameter description in 'xfs_btree_sblock_v5hdr_verify'

 fs/xfs/kmem.c                   |  79 +++--
 fs/xfs/kmem.h                   |  15 +-
 fs/xfs/libxfs/xfs_alloc.c       |   2 +-
 fs/xfs/libxfs/xfs_alloc.h       |   7 +-
 fs/xfs/libxfs/xfs_attr.c        |  79 +++--
 fs/xfs/libxfs/xfs_attr.h        |   6 +-
 fs/xfs/libxfs/xfs_attr_leaf.c   | 130 ++++----
 fs/xfs/libxfs/xfs_attr_remote.c |   2 +
 fs/xfs/libxfs/xfs_bmap.c        |  85 ++---
 fs/xfs/libxfs/xfs_bmap.h        |  11 +-
 fs/xfs/libxfs/xfs_bmap_btree.c  |  16 +-
 fs/xfs/libxfs/xfs_btree.c       |  14 +-
 fs/xfs/libxfs/xfs_btree.h       |  10 +-
 fs/xfs/libxfs/xfs_da_btree.c    |   6 +-
 fs/xfs/libxfs/xfs_da_btree.h    |   4 +-
 fs/xfs/libxfs/xfs_defer.c       |   2 +-
 fs/xfs/libxfs/xfs_dir2.c        |  14 +-
 fs/xfs/libxfs/xfs_dir2_block.c  |   2 +-
 fs/xfs/libxfs/xfs_dir2_node.c   | 678 +++++++++++++++++++---------------------
 fs/xfs/libxfs/xfs_dir2_sf.c     |   8 +-
 fs/xfs/libxfs/xfs_fs.h          |   2 +-
 fs/xfs/libxfs/xfs_ialloc.c      |   9 +-
 fs/xfs/libxfs/xfs_iext_tree.c   |   8 +-
 fs/xfs/libxfs/xfs_inode_fork.c  |  16 +-
 fs/xfs/libxfs/xfs_refcount.c    |  50 ++-
 fs/xfs/libxfs/xfs_refcount.h    |  12 +-
 fs/xfs/libxfs/xfs_rmap.c        |  59 ++--
 fs/xfs/libxfs/xfs_rmap.h        |  11 +-
 fs/xfs/libxfs/xfs_shared.h      |   6 -
 fs/xfs/libxfs/xfs_types.h       |   8 +
 fs/xfs/scrub/agheader.c         |   4 +-
 fs/xfs/scrub/attr.c             |   6 +-
 fs/xfs/scrub/bmap.c             |  81 +++--
 fs/xfs/scrub/fscounters.c       |   2 +-
 fs/xfs/scrub/repair.c           |   6 +-
 fs/xfs/scrub/symlink.c          |   2 +-
 fs/xfs/xfs_acl.c                |  14 +-
 fs/xfs/xfs_attr_inactive.c      |   2 +-
 fs/xfs/xfs_attr_list.c          |   2 +-
 fs/xfs/xfs_bmap_item.c          |   8 +-
 fs/xfs/xfs_bmap_util.c          |  22 +-
 fs/xfs/xfs_buf.c                |   7 +-
 fs/xfs/xfs_buf.h                |   6 +
 fs/xfs/xfs_buf_item.c           |   4 +-
 fs/xfs/xfs_dquot.c              |   4 +-
 fs/xfs/xfs_dquot_item.c         |   2 +-
 fs/xfs/xfs_error.c              |   2 +-
 fs/xfs/xfs_extent_busy.c        |   2 +-
 fs/xfs/xfs_extfree_item.c       |   8 +-
 fs/xfs/xfs_file.c               |  26 ++
 fs/xfs/xfs_fsmap.c              |  12 +-
 fs/xfs/xfs_icache.c             |   2 +-
 fs/xfs/xfs_icreate_item.c       |   2 +-
 fs/xfs/xfs_inode.c              |  85 ++---
 fs/xfs/xfs_inode_item.c         |   2 +-
 fs/xfs/xfs_ioctl.c              |  25 +-
 fs/xfs/xfs_ioctl32.c            |   2 +-
 fs/xfs/xfs_iomap.c              |   6 +-
 fs/xfs/xfs_itable.c             |  10 +-
 fs/xfs/xfs_itable.h             |  13 +-
 fs/xfs/xfs_iwalk.c              |   4 +-
 fs/xfs/xfs_iwalk.h              |  13 +-
 fs/xfs/xfs_log.c                | 466 ++++++++++++++++-----------
 fs/xfs/xfs_log_cil.c            |  10 +-
 fs/xfs/xfs_log_recover.c        |  50 +--
 fs/xfs/xfs_mount.c              |   4 +-
 fs/xfs/xfs_mount.h              |   7 -
 fs/xfs/xfs_mru_cache.c          |   4 +-
 fs/xfs/xfs_qm.c                 |   4 +-
 fs/xfs/xfs_refcount_item.c      |  16 +-
 fs/xfs/xfs_reflink.c            |  23 +-
 fs/xfs/xfs_rmap_item.c          |   6 +-
 fs/xfs/xfs_rtalloc.c            |   4 +-
 fs/xfs/xfs_super.c              |   3 +-
 fs/xfs/xfs_trace.h              |  34 ++
 fs/xfs/xfs_trans.c              |   4 +-
 fs/xfs/xfs_trans_dquot.c        |   2 +-
 fs/xfs/xfs_xattr.c              |   2 +-
 include/linux/fs.h              |   2 +
 mm/fadvise.c                    |   4 +-
 mm/madvise.c                    |  22 +-
 81 files changed, 1315 insertions(+), 1089 deletions(-)
