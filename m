Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D8674E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfGLSCG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 14:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbfGLSCG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 14:02:06 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D1CE205C9;
        Fri, 12 Jul 2019 18:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562954525;
        bh=Rdje7t9UEkoygzjugauO66Am+ytBMlguo3kFRcyi+qo=;
        h=Date:From:To:Cc:Subject:From;
        b=bbZ5pY1uxc4Kt6cui7NW6XowifKdoysTHWsceN72gMdHVQi/VQfJOkIvNTtExgGli
         NH4cazHxjXZEBg1Xm6YR5BHfsmz8R7O1isPU29yyPi4INwnBUYN+wbQnPbgySAkv+1
         inuBBI7bZVzb3m2qrvLd66+phj6nTWRvqtgv2MOA=
Date:   Fri, 12 Jul 2019 11:02:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new features for 5.3
Message-ID: <20190712180205.GA5347@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Here's all the new code for the 5.3 merge window.  In this release there
are a significant amounts of consolidations and cleanups in the log
code; restructuring of the log to issue struct bios directly; new
bulkstat ioctls to return v5 fs inode information (and fix all the
padding problems of the old ioctl); the beginnings of multithreaded
inode walks (e.g. quotacheck); and a reduction in memory usage in the
online scrub code leading to reduced runtimes.

The branch merges cleanly against this morning's HEAD and survived an
overnight run of xfstests.  The merge was completely straightforward, so
please let me know if you run into anything weird.

--D

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.3-merge-12

for you to fetch changes up to 488ca3d8d088ec4658c87aaec6a91e98acccdd54:

  xfs: chain bios the right way around in xfs_rw_bdev (2019-07-10 10:04:16 -0700)

----------------------------------------------------------------
New stuff for 5.3:
- Refactor inode geometry calculation into a single structure instead of
  open-coding pieces everywhere.
- Add online repair to build options.
- Remove unnecessary function call flags and functions.
- Claim maintainership of various loose xfs documentation and header
  files.
- Use struct bio directly for log buffer IOs instead of struct xfs_buf.
- Reduce log item boilerplate code requirements.
- Merge log item code spread across too many files.
- Further distinguish between log item commits and cancellations.
- Various small cleanups to the ag small allocator.
- Support cgroup-aware writeback
- libxfs refactoring for mkfs cleanup
- Remove unneeded #includes
- Fix a memory allocation miscalculation in the new log bio code
- Fix bisection problems
- Fix a crash in ioend processing caused by tripping over freeing of
  preallocated transactions
- Split out a generic inode walk mechanism from the bulkstat code, hook
  up all the internal users to use the walking code, then clean up
  bulkstat to serve only the bulkstat ioctls.
- Add a multithreaded iwalk implementation to speed up quotacheck on
  fast storage with many CPUs.
- Remove unnecessary return values in logging teardown functions.
- Supplement the bstat and inogrp structures with new bulkstat and
  inumbers structures that have all the fields we need for v5
  filesystem features and none of the padding problems of their
  predecessors.
- Wire up new ioctls that use the new structures with a much simpler
  bulk_ireq structure at the head instead of the pointerhappy mess we
  had before.
- Enable userspace to constrain bulkstat returns to a single AG or a
  single special inode so that we can phase out a lot of geometry
  guesswork in userspace.
- Reduce memory consumption and zeroing overhead in extended attribute
  scrub code.
- Fix some behavioral regressions in the new bulkstat backend code.
- Fix some behavioral regressions in the new log bio code.

----------------------------------------------------------------
Amir Goldstein (7):
      vfs: introduce generic_file_rw_checks()
      vfs: remove redundant checks from generic_remap_checks()
      vfs: add missing checks to copy_file_range
      vfs: introduce file_modified() helper
      xfs: use file_modified() helper
      vfs: allow copy_file_range to copy across devices
      fuse: copy_file_range needs to strip setuid bits and update timestamps

Brian Foster (4):
      xfs: clean up small allocation helper
      xfs: move small allocation helper
      xfs: skip small alloc cntbt logic on NULL cursor
      xfs: always update params on small allocation

Christoph Hellwig (54):
      xfs: merge xfs_buf_zero and xfs_buf_iomove
      xfs: remove the debug-only q_transp field from struct xfs_dquot
      xfs: remove the no-op spinlock_destroy stub
      xfs: remove the never used _XBF_COMPOUND flag
      xfs: renumber XBF_WRITE_FAIL
      xfs: make mem_to_page available outside of xfs_buf.c
      xfs: remove the l_iclog_size_log field from struct xlog
      xfs: cleanup xlog_get_iclog_buffer_size
      xfs: reformat xlog_get_lowest_lsn
      xfs: remove XLOG_STATE_IOABORT
      xfs: don't use REQ_PREFLUSH for split log writes
      xfs: factor out log buffer writing from xlog_sync
      xfs: factor out splitting of an iclog from xlog_sync
      xfs: factor out iclog size calculation from xlog_sync
      xfs: update both stat counters together in xlog_sync
      xfs: remove the syncing argument from xlog_verify_iclog
      xfs: make use of the l_targ field in struct xlog
      xfs: use bios directly to write log buffers
      xfs: move the log ioend workqueue to struct xlog
      xfs: return an offset instead of a pointer from xlog_align
      xfs: use bios directly to read and write the log recovery buffers
      xfs: stop using bp naming for log recovery buffers
      xfs: remove unused buffer cache APIs
      xfs: properly type the b_log_item field in struct xfs_buf
      xfs: remove the b_io_length field in struct xfs_buf
      xfs: add struct xfs_mount pointer to struct xfs_buf
      xfs: fix a trivial comment typo in xfs_trans_committed_bulk
      xfs: stop using XFS_LI_ABORTED as a parameter flag
      xfs: don't require log items to implement optional methods
      xfs: remove the dummy iop_push implementation for inode creation items
      xfs: don't use xfs_trans_free_items in the commit path
      xfs: split iop_unlock
      xfs: add a flag to release log items on commit
      xfs: don't cast inode_log_items to get the log_item
      xfs: remove the xfs_log_item_t typedef
      xfs: use a list_head for iclog callbacks
      xfs: remove a pointless comment duplicated above all xfs_item_ops instances
      xfs: merge xfs_efd_init into xfs_trans_get_efd
      xfs: merge xfs_cud_init into xfs_trans_get_cud
      xfs: merge xfs_rud_init into xfs_trans_get_rud
      xfs: merge xfs_bud_init into xfs_trans_get_bud
      xfs: merge xfs_trans_extfree.c into xfs_extfree_item.c
      xfs: merge xfs_trans_refcount.c into xfs_refcount_item.c
      xfs: merge xfs_trans_rmap.c into xfs_rmap_item.c
      xfs: merge xfs_trans_bmap.c into xfs_bmap_item.c
      xfs: simplify xfs_chain_bio
      xfs: implement cgroup aware writeback
      xfs: fix iclog allocation size
      xfs: remove the unused xfs_count_page_state declaration
      xfs: fix a comment typo in xfs_submit_ioend
      xfs: allow merging ioends over append boundaries
      xfs: simplify xfs_ioend_can_merge
      xfs: remove XFS_TRANS_NOFS
      xfs: chain bios the right way around in xfs_rw_bdev

Darrick J. Wong (37):
      xfs: separate inode geometry
      xfs: refactor inode geometry setup routines
      xfs: fix inode_cluster_size rounding mayhem
      xfs: finish converting to inodes_per_cluster
      xfs: claim maintainership of loose files
      xfs: move xfs_ino_geometry to xfs_shared.h
      xfs: refactor free space btree record initialization
      xfs: account for log space when formatting new AGs
      xfs: create iterator error codes
      xfs: create simplified inode walk function
      xfs: convert quotacheck to use the new iwalk functions
      xfs: bulkstat should copy lastip whenever userspace supplies one
      xfs: convert bulkstat to new iwalk infrastructure
      xfs: calculate inode walk prefetch more carefully
      xfs: move bulkstat ichunk helpers to iwalk code
      xfs: change xfs_iwalk_grab_ichunk to use startino, not lastino
      xfs: clean up long conditionals in xfs_iwalk_ichunk_ra
      xfs: refactor xfs_iwalk_grab_ichunk
      xfs: refactor iwalk code to handle walking inobt records
      xfs: refactor INUMBERS to use iwalk functions
      xfs: multithreaded iwalk implementation
      xfs: poll waiting for quotacheck
      xfs: remove various bulk request typedef usage
      xfs: rename bulkstat functions
      xfs: introduce new v5 bulkstat structure
      xfs: introduce v5 inode group structure
      xfs: wire up new v5 bulkstat ioctls
      xfs: wire up the v5 inumbers ioctl
      xfs: specify AG in bulk req
      xfs: allow single bulkstat of special inodes
      xfs: attribute scrub should use seen_enough to pass error values
      xfs: refactor extended attribute buffer pointer functions
      xfs: refactor attr scrub memory allocation function
      xfs: only allocate memory for scrubbing attributes when we need it
      xfs: online scrub needn't bother zeroing its temporary buffer
      xfs: don't update lastino for FSBULKSTAT_SINGLE
      xfs: bump INUMBERS cursor correctly in xfs_inumbers_walk

Dave Chinner (2):
      vfs: introduce generic_copy_file_range()
      vfs: no fallback for ->copy_file_range

Eric Sandeen (4):
      xfs: include WARN, REPAIR build options in XFS_BUILD_OPTIONS
      xfs: remove unused flags arg from getsb interfaces
      xfs: remove unused flag arguments
      xfs: remove unused header files

Hariprasad Kelam (1):
      fs: xfs: xfs_log: Change return type from int to void

 .../filesystems/xfs-self-describing-metadata.txt   |   8 +-
 MAINTAINERS                                        |   6 +
 fs/ceph/file.c                                     |  23 +-
 fs/cifs/cifsfs.c                                   |   4 +
 fs/fuse/file.c                                     |  29 +-
 fs/inode.c                                         |  20 +
 fs/nfs/nfs4file.c                                  |  23 +-
 fs/read_write.c                                    | 124 ++--
 fs/xfs/Makefile                                    |   9 +-
 fs/xfs/kmem.c                                      |   5 -
 fs/xfs/kmem.h                                      |   8 +
 fs/xfs/libxfs/xfs_ag.c                             | 100 ++-
 fs/xfs/libxfs/xfs_ag_resv.c                        |   8 -
 fs/xfs/libxfs/xfs_alloc.c                          | 227 +++----
 fs/xfs/libxfs/xfs_alloc_btree.c                    |   3 +-
 fs/xfs/libxfs/xfs_attr.c                           |   5 -
 fs/xfs/libxfs/xfs_attr.h                           |   8 +-
 fs/xfs/libxfs/xfs_attr_leaf.c                      |  15 +-
 fs/xfs/libxfs/xfs_attr_remote.c                    |  14 +-
 fs/xfs/libxfs/xfs_bit.c                            |   1 -
 fs/xfs/libxfs/xfs_bmap.c                           |  19 +-
 fs/xfs/libxfs/xfs_bmap_btree.c                     |   5 +-
 fs/xfs/libxfs/xfs_btree.c                          |  49 +-
 fs/xfs/libxfs/xfs_btree.h                          |  14 +-
 fs/xfs/libxfs/xfs_da_btree.c                       |  12 +-
 fs/xfs/libxfs/xfs_da_format.c                      |   3 -
 fs/xfs/libxfs/xfs_defer.c                          |   2 -
 fs/xfs/libxfs/xfs_dir2.c                           |   6 +-
 fs/xfs/libxfs/xfs_dir2_block.c                     |  11 +-
 fs/xfs/libxfs/xfs_dir2_data.c                      |  14 +-
 fs/xfs/libxfs/xfs_dir2_leaf.c                      |  11 +-
 fs/xfs/libxfs/xfs_dir2_node.c                      |  10 +-
 fs/xfs/libxfs/xfs_dir2_sf.c                        |   5 +-
 fs/xfs/libxfs/xfs_dquot_buf.c                      |  10 +-
 fs/xfs/libxfs/xfs_format.h                         |   2 +-
 fs/xfs/libxfs/xfs_fs.h                             | 124 +++-
 fs/xfs/libxfs/xfs_health.h                         |   2 +-
 fs/xfs/libxfs/xfs_ialloc.c                         | 245 ++++---
 fs/xfs/libxfs/xfs_ialloc.h                         |  18 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c                   |  56 +-
 fs/xfs/libxfs/xfs_ialloc_btree.h                   |   3 +
 fs/xfs/libxfs/xfs_iext_tree.c                      |   6 +-
 fs/xfs/libxfs/xfs_inode_buf.c                      |   9 +-
 fs/xfs/libxfs/xfs_inode_fork.c                     |   4 +-
 fs/xfs/libxfs/xfs_log_rlimit.c                     |   2 -
 fs/xfs/libxfs/xfs_refcount.c                       |   2 -
 fs/xfs/libxfs/xfs_refcount_btree.c                 |   4 +-
 fs/xfs/libxfs/xfs_rmap.c                           |   7 -
 fs/xfs/libxfs/xfs_rmap_btree.c                     |   6 +-
 fs/xfs/libxfs/xfs_rtbitmap.c                       |   8 -
 fs/xfs/libxfs/xfs_sb.c                             |  39 +-
 fs/xfs/libxfs/xfs_shared.h                         |  49 +-
 fs/xfs/libxfs/xfs_symlink_remote.c                 |  10 +-
 fs/xfs/libxfs/xfs_trans_resv.c                     |  17 +-
 fs/xfs/libxfs/xfs_trans_space.h                    |   7 +-
 fs/xfs/libxfs/xfs_types.c                          |  13 +-
 fs/xfs/scrub/agheader.c                            |  11 +-
 fs/xfs/scrub/agheader_repair.c                     |   5 -
 fs/xfs/scrub/alloc.c                               |   7 -
 fs/xfs/scrub/attr.c                                | 122 +++-
 fs/xfs/scrub/attr.h                                |  71 ++
 fs/xfs/scrub/bitmap.c                              |   5 -
 fs/xfs/scrub/bmap.c                                |   8 -
 fs/xfs/scrub/btree.c                               |   7 -
 fs/xfs/scrub/common.c                              |   8 -
 fs/xfs/scrub/dabtree.c                             |   8 -
 fs/xfs/scrub/dir.c                                 |  10 -
 fs/xfs/scrub/fscounters.c                          |  12 -
 fs/xfs/scrub/health.c                              |   8 -
 fs/xfs/scrub/ialloc.c                              |  28 +-
 fs/xfs/scrub/inode.c                               |  10 -
 fs/xfs/scrub/parent.c                              |   8 -
 fs/xfs/scrub/quota.c                               |  13 +-
 fs/xfs/scrub/refcount.c                            |  10 -
 fs/xfs/scrub/repair.c                              |  14 +-
 fs/xfs/scrub/rmap.c                                |   9 -
 fs/xfs/scrub/rtbitmap.c                            |   7 -
 fs/xfs/scrub/scrub.c                               |  20 -
 fs/xfs/scrub/symlink.c                             |   8 -
 fs/xfs/scrub/trace.c                               |   6 -
 fs/xfs/xfs_acl.c                                   |   4 +-
 fs/xfs/xfs_aops.c                                  | 121 ++--
 fs/xfs/xfs_aops.h                                  |   1 -
 fs/xfs/xfs_attr_inactive.c                         |   7 +-
 fs/xfs/xfs_attr_list.c                             |   7 +-
 fs/xfs/xfs_bio_io.c                                |  61 ++
 fs/xfs/xfs_bmap_item.c                             | 350 ++++++----
 fs/xfs/xfs_bmap_item.h                             |   2 -
 fs/xfs/xfs_bmap_util.c                             |  11 +-
 fs/xfs/xfs_buf.c                                   | 171 +----
 fs/xfs/xfs_buf.h                                   |  53 +-
 fs/xfs/xfs_buf_item.c                              |  40 +-
 fs/xfs/xfs_buf_item.h                              |   6 +-
 fs/xfs/xfs_dir2_readdir.c                          |   5 +-
 fs/xfs/xfs_discard.c                               |   4 +-
 fs/xfs/xfs_dquot.c                                 |   6 +-
 fs/xfs/xfs_dquot.h                                 |   1 -
 fs/xfs/xfs_dquot_item.c                            | 118 +---
 fs/xfs/xfs_dquot_item.h                            |   4 +-
 fs/xfs/xfs_error.c                                 |   3 +-
 fs/xfs/xfs_export.c                                |   4 +-
 fs/xfs/xfs_extfree_item.c                          | 410 ++++++-----
 fs/xfs/xfs_extfree_item.h                          |   6 +-
 fs/xfs/xfs_file.c                                  |  38 +-
 fs/xfs/xfs_filestream.c                            |   5 +-
 fs/xfs/xfs_fsmap.c                                 |   4 -
 fs/xfs/xfs_fsops.c                                 |   8 +-
 fs/xfs/xfs_globals.c                               |   4 +-
 fs/xfs/xfs_health.c                                |   6 +-
 fs/xfs/xfs_icache.c                                |   4 +-
 fs/xfs/xfs_icreate_item.c                          |  75 +--
 fs/xfs/xfs_inode.c                                 |  42 +-
 fs/xfs/xfs_inode_item.c                            |  16 +-
 fs/xfs/xfs_inode_item.h                            |   2 +-
 fs/xfs/xfs_ioctl.c                                 | 294 +++++++-
 fs/xfs/xfs_ioctl.h                                 |   8 +
 fs/xfs/xfs_ioctl32.c                               | 161 +++--
 fs/xfs/xfs_ioctl32.h                               |  14 +-
 fs/xfs/xfs_iomap.c                                 |   5 +-
 fs/xfs/xfs_iops.c                                  |  10 -
 fs/xfs/xfs_itable.c                                | 749 +++++++--------------
 fs/xfs/xfs_itable.h                                | 106 ++-
 fs/xfs/xfs_iwalk.c                                 | 720 ++++++++++++++++++++
 fs/xfs/xfs_iwalk.h                                 |  46 ++
 fs/xfs/xfs_linux.h                                 |   5 +-
 fs/xfs/xfs_log.c                                   | 644 ++++++++----------
 fs/xfs/xfs_log.h                                   |  17 +-
 fs/xfs/xfs_log_cil.c                               |  51 +-
 fs/xfs/xfs_log_priv.h                              |  36 +-
 fs/xfs/xfs_log_recover.c                           | 463 ++++++-------
 fs/xfs/xfs_message.c                               |   2 +-
 fs/xfs/xfs_mount.c                                 | 102 +--
 fs/xfs/xfs_mount.h                                 |  22 +-
 fs/xfs/xfs_ondisk.h                                |   5 +
 fs/xfs/xfs_pnfs.c                                  |   9 +-
 fs/xfs/xfs_pwork.c                                 | 136 ++++
 fs/xfs/xfs_pwork.h                                 |  61 ++
 fs/xfs/xfs_qm.c                                    |  68 +-
 fs/xfs/xfs_qm_bhv.c                                |   2 +-
 fs/xfs/xfs_qm_syscalls.c                           |   5 -
 fs/xfs/xfs_quotaops.c                              |   3 +-
 fs/xfs/xfs_refcount_item.c                         | 357 ++++++----
 fs/xfs/xfs_refcount_item.h                         |   2 -
 fs/xfs/xfs_reflink.c                               |  15 +-
 fs/xfs/xfs_rmap_item.c                             | 380 +++++++----
 fs/xfs/xfs_rmap_item.h                             |   2 -
 fs/xfs/xfs_rtalloc.c                               |   6 -
 fs/xfs/xfs_stats.c                                 |   1 -
 fs/xfs/xfs_super.c                                 |  32 +-
 fs/xfs/xfs_super.h                                 |  14 +
 fs/xfs/xfs_symlink.c                               |   9 -
 fs/xfs/xfs_sysctl.c                                |   3 -
 fs/xfs/xfs_sysctl.h                                |   3 +
 fs/xfs/xfs_sysfs.c                                 |  42 +-
 fs/xfs/xfs_trace.c                                 |   8 -
 fs/xfs/xfs_trace.h                                 |  61 +-
 fs/xfs/xfs_trans.c                                 |  43 +-
 fs/xfs/xfs_trans.h                                 |  70 +-
 fs/xfs/xfs_trans_ail.c                             |  53 +-
 fs/xfs/xfs_trans_bmap.c                            | 232 -------
 fs/xfs/xfs_trans_buf.c                             |  11 +-
 fs/xfs/xfs_trans_dquot.c                           |  11 -
 fs/xfs/xfs_trans_extfree.c                         | 286 --------
 fs/xfs/xfs_trans_inode.c                           |   3 -
 fs/xfs/xfs_trans_priv.h                            |   4 +-
 fs/xfs/xfs_trans_refcount.c                        | 240 -------
 fs/xfs/xfs_trans_rmap.c                            | 257 -------
 fs/xfs/xfs_xattr.c                                 |   5 +-
 include/linux/fs.h                                 |   9 +
 mm/filemap.c                                       | 110 ++-
 170 files changed, 4664 insertions(+), 4807 deletions(-)
 create mode 100644 fs/xfs/scrub/attr.h
 create mode 100644 fs/xfs/xfs_bio_io.c
 create mode 100644 fs/xfs/xfs_iwalk.c
 create mode 100644 fs/xfs/xfs_iwalk.h
 create mode 100644 fs/xfs/xfs_pwork.c
 create mode 100644 fs/xfs/xfs_pwork.h
 delete mode 100644 fs/xfs/xfs_trans_bmap.c
 delete mode 100644 fs/xfs/xfs_trans_extfree.c
 delete mode 100644 fs/xfs/xfs_trans_refcount.c
 delete mode 100644 fs/xfs/xfs_trans_rmap.c
