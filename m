Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 756B919C74C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 18:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbgDBQp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 12:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388167AbgDBQp0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:45:26 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D86A20737;
        Thu,  2 Apr 2020 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585845925;
        bh=k2E9wWIh+hgnexGe+8mAvxMe8SqeI9i810Ao2TwEwww=;
        h=Date:From:To:Cc:Subject:From;
        b=NErzYjr6lkLxOUy04sMtFOzE0PQuQ2sszJVh/xVm7ACZ6L+WHD4uJUzK1H5M0xXRO
         5hOI9CB+25at91NO6KtM1EdA+sHi9Ei6O3Tj1K0HA49s+75yDAL4T9P22DIEcBgdRf
         RUFFG791CUK2vlD5WtYglVWg3PKC22gBCbxTtoTo=
Date:   Thu, 2 Apr 2020 09:45:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.7, part 1
Message-ID: <20200402164524.GJ80283@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this first batch of new changes for 5.7.  There's a lot
going on this cycle with cleanups in the log code, the btree code, and
the xattr code.  We're tightening of metadata validation and online fsck
checking, and introducing a common btree rebuilding library so that we
can refactor xfs_repair and introduce online repair in a future cycle.
We also fixed a few visible bugs -- most notably there's one in getdents
that we introduced in 5.6; and a fix for hangs when disabling quotas.

This series has been running fstests & other QA in the background for
over a week and looks good so far.  I just did a test merge and it seems
to go in cleanly, so please let me know if you encounter any surprises.

I anticipate sending you a second pull request next week.  That batch
will change how xfs interacts with memory reclaim; how the log batches
and throttles log items; how hard writes near ENOSPC will try to squeeze
more space out of the filesystem; and hopefully fix the last of the
umount hangs after a catastrophic failure.  That should ease a lot of
problems when running at the limits, but for now I'm leaving that in
for-next for another week to make sure we got all the subtleties right.

--D

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.7-merge-8

for you to fetch changes up to 27fb5a72f50aa770dd38b0478c07acacef97e3e7:

  xfs: prohibit fs freezing when using empty transactions (2020-03-26 08:19:24 -0700)

----------------------------------------------------------------
New code for 5.7:
 - Fix a hard to trigger race between iclog error checking and log shutdown.
 - Strengthen the AGF verifier.
 - Ratelimit some of the more spammy error messages.
 - Remove the icdinode uid/gid members and just use the ones in the vfs inode.
 - Hold ILOCK across insert/collapse range.
 - Clean up the extended attribute interfaces.
 - Clean up the attr flags mess.
 - Restore PF_MEMALLOC after exiting xfsaild thread to avoid triggering
   warnings in the process accounting code.
 - Remove the flexibly-sized array from struct xfs_agfl to eliminate
   compiler warnings about unaligned pointers and packed structures.
 - Various macro and typedef removals.
 - Stale metadata buffers if we decide they're corrupt outside of a
   verifier.
 - Check directory data/block/free block owners.
 - Fix a UAF when aborting inactivation of a corrupt xattr fork.
 - Teach online scrub to report failed directory and attr name lookups
   as a metadata corruption instead of a runtime error.
 - Avoid potential buffer overflows in sysfs files by using scnprintf.
 - Fix a regression in getdents lookups due to a mistake in pointer
   arithmetic.
 - Refactor btree cursor private data structures to use anonymous
   unions.
 - Cleanups in the log unmounting code.
 - Fix a potential mishandling of ENOMEM errors on multi-block directory
   buffer lookups.
 - Fix an incorrect test in the block allocation code.
 - Cleanups and name prefix shortening in the scrub code.
 - Introduce btree bulk loading code for online repair and scrub.
 - Fix a quotaoff log item leak (and hang) when the fs goes down midway
   through a quotaoff operation.
 - Remove di_version from the incore inode.
 - Refactor some of the log shutdown checking code.
 - Record the forcing of the log unmount records in the log force
   counters.
 - Fix a longstanding bug where quotacheck would purge the
   administrator's default quota grace interval and warning limits.
 - Reduce memory usage when scrubbing directory and xattr trees.
 - Don't let fsfreeze race with GETFSMAP or online scrub.
 - Handle bio_add_page failures more gracefully in xlog_write_iclog.

----------------------------------------------------------------
Brian Foster (7):
      xfs: fix iclog release error check race with shutdown
      xfs: open code insert range extent split helper
      xfs: rework insert range into an atomic operation
      xfs: rework collapse range into an atomic operation
      xfs: factor out quotaoff intent AIL removal and memory free
      xfs: fix unmount hang and memory leak on shutdown during quotaoff
      xfs: shutdown on failure to add page to log bio

Christoph Hellwig (60):
      xfs: ensure that the inode uid/gid match values match the icdinode ones
      xfs: remove the icdinode di_uid/di_gid members
      xfs: remove the kuid/kgid conversion wrappers
      xfs: ratelimit xfs_buf_ioerror_alert messages
      xfs: ratelimit xfs_discard_page messages
      xfs: reject invalid flags combinations in XFS_IOC_ATTRLIST_BY_HANDLE
      xfs: remove the ATTR_INCOMPLETE flag
      xfs: merge xfs_attr_remove into xfs_attr_set
      xfs: merge xfs_attrmulti_attr_remove into xfs_attrmulti_attr_set
      xfs: use strndup_user in XFS_IOC_ATTRMULTI_BY_HANDLE
      xfs: factor out a helper for a single XFS_IOC_ATTRMULTI_BY_HANDLE op
      xfs: remove the name == NULL check from xfs_attr_args_init
      xfs: remove the MAXNAMELEN check from xfs_attr_args_init
      xfs: turn xfs_da_args.value into a void pointer
      xfs: pass an initialized xfs_da_args structure to xfs_attr_set
      xfs: pass an initialized xfs_da_args to xfs_attr_get
      xfs: remove the xfs_inode argument to xfs_attr_get_ilocked
      xfs: remove ATTR_KERNOVAL
      xfs: remove ATTR_ALLOC and XFS_DA_OP_ALLOCVAL
      xfs: replace ATTR_KERNOTIME with XFS_DA_OP_NOTIME
      xfs: factor out a xfs_attr_match helper
      xfs: cleanup struct xfs_attr_list_context
      xfs: remove the unused ATTR_ENTRY macro
      xfs: open code ATTR_ENTSIZE
      xfs: move the legacy xfs_attr_list to xfs_ioctl.c
      xfs: rename xfs_attr_list_int to xfs_attr_list
      xfs: lift common checks into xfs_ioc_attr_list
      xfs: lift buffer allocation into xfs_ioc_attr_list
      xfs: lift cursor copy in/out into xfs_ioc_attr_list
      xfs: improve xfs_forget_acl
      xfs: clean up the ATTR_REPLACE checks
      xfs: clean up the attr flag confusion
      xfs: remove XFS_DA_OP_INCOMPLETE
      xfs: embedded the attrlist cursor into struct xfs_attr_list_context
      xfs: clean up bufsize alignment in xfs_ioc_attr_list
      xfs: only allocate the buffer size actually needed in __xfs_set_acl
      xfs: switch xfs_attrmulti_attr_get to lazy attr buffer allocation
      xfs: remove the agfl_bno member from struct xfs_agfl
      xfs: remove the xfs_agfl_t typedef
      xfs: remove XFS_BUF_TO_AGI
      xfs: remove XFS_BUF_TO_AGF
      xfs: remove XFS_BUF_TO_SBP
      xfs: mark XLOG_FORCED_SHUTDOWN as unlikely
      xfs: remove the unused XLOG_UNMOUNT_REC_TYPE define
      xfs: remove the unused return value from xfs_log_unmount_write
      xfs: remove dead code from xfs_log_unmount_write
      xfs: cleanup xfs_log_unmount_write
      xfs: add a new xfs_sb_version_has_v3inode helper
      xfs: only check the superblock version for dinode size calculation
      xfs: simplify di_flags2 inheritance in xfs_ialloc
      xfs: simplify a check in xfs_ioctl_setattr_check_cowextsize
      xfs: remove the di_version field from struct icdinode
      xfs: merge xlog_cil_push into xlog_cil_push_work
      xfs: factor out a xlog_wait_on_iclog helper
      xfs: simplify the xfs_log_release_iclog calling convention
      xfs: simplify log shutdown checking in xfs_log_release_iclog
      xfs: remove the aborted parameter to xlog_state_done_syncing
      xfs: refactor xlog_state_clean_iclog
      xfs: move the ioerror check out of xlog_state_clean_iclog
      xfs: remove xlog_state_want_sync

Darrick J. Wong (28):
      xfs: improve error message when we can't allocate memory for xfs_buf
      xfs: fix use-after-free when aborting corrupt attr inactivation
      xfs: fix xfs_rmap_has_other_keys usage of ECANCELED
      xfs: add a function to deal with corrupt buffers post-verifiers
      xfs: xfs_buf_corruption_error should take __this_address
      xfs: fix buffer corruption reporting when xfs_dir3_free_header_check fails
      xfs: don't ever return a stale pointer from __xfs_dir3_free_read
      xfs: check owner of dir3 free blocks
      xfs: check owner of dir3 data blocks
      xfs: check owner of dir3 blocks
      xfs: mark dir corrupt when lookup-by-hash fails
      xfs: mark extended attr corrupt when lookup-by-hash fails
      xfs: xfs_dabuf_map should return ENOMEM when map allocation fails
      xfs: fix incorrect test in xfs_alloc_ag_vextent_lastblock
      xfs: xrep_reap_extents should not destroy the bitmap
      xfs: rename xfs_bitmap to xbitmap
      xfs: replace open-coded bitmap weight logic
      xfs: introduce fake roots for ag-rooted btrees
      xfs: introduce fake roots for inode-rooted btrees
      xfs: support bulk loading of staged btrees
      xfs: add support for free space btree staging cursors
      xfs: add support for inode btree staging cursors
      xfs: add support for refcount btree staging cursors
      xfs: add support for rmap btree staging cursors
      xfs: preserve default grace interval during quotacheck
      xfs: drop all altpath buffers at the end of the sibling check
      xfs: directory bestfree check should release buffers
      xfs: prohibit fs freezing when using empty transactions

Dave Chinner (7):
      xfs: introduce new private btree cursor names
      xfs: convert btree cursor ag-private member name
      xfs: convert btree cursor inode-private member names
      xfs: rename btree cursor private btree member flags
      xfs: make btree cursor private union anonymous
      xfs: make the btree cursor union members named structure
      xfs: make the btree ag cursor private union anonymous

Eric Biggers (1):
      xfs: clear PF_MEMALLOC before exiting xfsaild thread

Jules Irenge (1):
      xfs: Add missing annotation to xfs_ail_check()

Qian Cai (1):
      xfs: fix an undefined behaviour in _da3_path_shift

Takashi Iwai (1):
      xfs: Use scnprintf() for avoiding potential buffer overflow

Tommi Rantala (1):
      xfs: fix regression in "cleanup xfs_dir2_block_getdents"

Zheng Bin (1):
      xfs: add agf freeblocks verify in xfs_agf_verify

 fs/xfs/Makefile                    |   1 +
 fs/xfs/libxfs/xfs_ag.c             |  16 +-
 fs/xfs/libxfs/xfs_alloc.c          |  99 +++--
 fs/xfs/libxfs/xfs_alloc.h          |   9 +
 fs/xfs/libxfs/xfs_alloc_btree.c    | 119 +++--
 fs/xfs/libxfs/xfs_alloc_btree.h    |   7 +
 fs/xfs/libxfs/xfs_attr.c           | 351 +++++----------
 fs/xfs/libxfs/xfs_attr.h           | 114 +----
 fs/xfs/libxfs/xfs_attr_leaf.c      | 130 +++---
 fs/xfs/libxfs/xfs_attr_leaf.h      |   1 -
 fs/xfs/libxfs/xfs_attr_remote.c    |   2 +-
 fs/xfs/libxfs/xfs_bmap.c           |  88 ++--
 fs/xfs/libxfs/xfs_bmap.h           |   3 +-
 fs/xfs/libxfs/xfs_bmap_btree.c     |  50 +--
 fs/xfs/libxfs/xfs_btree.c          |  93 ++--
 fs/xfs/libxfs/xfs_btree.h          |  82 +++-
 fs/xfs/libxfs/xfs_btree_staging.c  | 879 +++++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_btree_staging.h  | 123 ++++++
 fs/xfs/libxfs/xfs_da_btree.c       |  17 +-
 fs/xfs/libxfs/xfs_da_btree.h       |  11 +-
 fs/xfs/libxfs/xfs_da_format.h      |  12 -
 fs/xfs/libxfs/xfs_dir2_block.c     |  33 +-
 fs/xfs/libxfs/xfs_dir2_data.c      |  32 +-
 fs/xfs/libxfs/xfs_dir2_leaf.c      |   2 +-
 fs/xfs/libxfs/xfs_dir2_node.c      |  11 +-
 fs/xfs/libxfs/xfs_format.h         |  48 +-
 fs/xfs/libxfs/xfs_fs.h             |  32 +-
 fs/xfs/libxfs/xfs_ialloc.c         |  35 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c   | 104 ++++-
 fs/xfs/libxfs/xfs_ialloc_btree.h   |   6 +
 fs/xfs/libxfs/xfs_inode_buf.c      |  43 +-
 fs/xfs/libxfs/xfs_inode_buf.h      |   5 -
 fs/xfs/libxfs/xfs_inode_fork.c     |   2 +-
 fs/xfs/libxfs/xfs_inode_fork.h     |   9 +-
 fs/xfs/libxfs/xfs_log_format.h     |  10 +-
 fs/xfs/libxfs/xfs_refcount.c       | 110 ++---
 fs/xfs/libxfs/xfs_refcount_btree.c | 104 +++--
 fs/xfs/libxfs/xfs_refcount_btree.h |   6 +
 fs/xfs/libxfs/xfs_rmap.c           | 123 +++---
 fs/xfs/libxfs/xfs_rmap_btree.c     |  99 +++--
 fs/xfs/libxfs/xfs_rmap_btree.h     |   5 +
 fs/xfs/libxfs/xfs_sb.c             |  17 +-
 fs/xfs/libxfs/xfs_trans_resv.c     |   2 +-
 fs/xfs/scrub/agheader.c            |  20 +-
 fs/xfs/scrub/agheader_repair.c     |  78 ++--
 fs/xfs/scrub/alloc.c               |   2 +-
 fs/xfs/scrub/attr.c                |  20 +-
 fs/xfs/scrub/bitmap.c              |  87 ++--
 fs/xfs/scrub/bitmap.h              |  23 +-
 fs/xfs/scrub/bmap.c                |   4 +-
 fs/xfs/scrub/dabtree.c             |  42 +-
 fs/xfs/scrub/dir.c                 |  13 +-
 fs/xfs/scrub/ialloc.c              |   8 +-
 fs/xfs/scrub/refcount.c            |   2 +-
 fs/xfs/scrub/repair.c              |  28 +-
 fs/xfs/scrub/repair.h              |   6 +-
 fs/xfs/scrub/rmap.c                |   2 +-
 fs/xfs/scrub/scrub.c               |   9 +
 fs/xfs/scrub/trace.c               |   4 +-
 fs/xfs/scrub/trace.h               |   4 +-
 fs/xfs/xfs_acl.c                   | 132 +++---
 fs/xfs/xfs_acl.h                   |   6 +-
 fs/xfs/xfs_aops.c                  |   2 +-
 fs/xfs/xfs_attr_inactive.c         |   6 +-
 fs/xfs/xfs_attr_list.c             | 169 +------
 fs/xfs/xfs_bmap_util.c             |  73 +--
 fs/xfs/xfs_buf.c                   |  29 +-
 fs/xfs/xfs_buf.h                   |   2 +
 fs/xfs/xfs_buf_item.c              |   2 +-
 fs/xfs/xfs_dir2_readdir.c          |  12 +-
 fs/xfs/xfs_discard.c               |   7 +-
 fs/xfs/xfs_dquot.c                 |   4 +-
 fs/xfs/xfs_dquot_item.c            |  44 +-
 fs/xfs/xfs_dquot_item.h            |   1 +
 fs/xfs/xfs_error.c                 |   7 +-
 fs/xfs/xfs_error.h                 |   2 +-
 fs/xfs/xfs_fsmap.c                 |  13 +-
 fs/xfs/xfs_icache.c                |   4 +
 fs/xfs/xfs_inode.c                 |  57 +--
 fs/xfs/xfs_inode_item.c            |  16 +-
 fs/xfs/xfs_ioctl.c                 | 355 +++++++++------
 fs/xfs/xfs_ioctl.h                 |  35 +-
 fs/xfs/xfs_ioctl32.c               |  99 +----
 fs/xfs/xfs_iops.c                  |  25 +-
 fs/xfs/xfs_itable.c                |   6 +-
 fs/xfs/xfs_linux.h                 |  27 +-
 fs/xfs/xfs_log.c                   | 472 +++++++++-----------
 fs/xfs/xfs_log.h                   |   5 +-
 fs/xfs/xfs_log_cil.c               |  58 +--
 fs/xfs/xfs_log_priv.h              |   9 +-
 fs/xfs/xfs_log_recover.c           |  18 +-
 fs/xfs/xfs_mount.c                 |   2 +-
 fs/xfs/xfs_qm.c                    |  55 ++-
 fs/xfs/xfs_qm_syscalls.c           |  13 +-
 fs/xfs/xfs_quota.h                 |   4 +-
 fs/xfs/xfs_stats.c                 |  10 +-
 fs/xfs/xfs_symlink.c               |   6 +-
 fs/xfs/xfs_trace.c                 |   2 +
 fs/xfs/xfs_trace.h                 | 209 +++++++--
 fs/xfs/xfs_trans.c                 |   7 +-
 fs/xfs/xfs_trans_ail.c             |   5 +-
 fs/xfs/xfs_xattr.c                 |  92 ++--
 102 files changed, 3313 insertions(+), 2186 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_btree_staging.c
 create mode 100644 fs/xfs/libxfs/xfs_btree_staging.h
