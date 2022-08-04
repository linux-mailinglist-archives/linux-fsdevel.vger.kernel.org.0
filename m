Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98D4589E75
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 17:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbiHDPOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 11:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiHDPOf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:14:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB84E63B2;
        Thu,  4 Aug 2022 08:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61E7F612A5;
        Thu,  4 Aug 2022 15:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA430C433C1;
        Thu,  4 Aug 2022 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659626071;
        bh=Vu+vCPv72U8albQ9qS8O5mAIYWq5Qwq7CAZxXEiPGwA=;
        h=Date:From:To:Cc:Subject:From;
        b=hiC4aUoAb+DaU8n4gUuYydaoe5mtnJFasaItMav0l91pR1PFXArHViEQjkpDxDSPf
         3GR77Iii/7m6vaqvo5swF0QRV/kYZYj6z+vzPjWJ0FOvO91eieYf/Osrzr28rhHDhl
         ocnrEnvK0RMpUa91g8J7Kc58Y/RSimhEAysp4rR8hwDx0T/epJHavlF/QLYg2JU98n
         vdWKWU9hctV5CDrCYeILcACIukXZ/K5IrCLxj8G/Q5mAr85vw2OJ157Jo0M0/7CS0B
         8RrigOlzZQZblJCpCalRT9P6RV0ivKEHZbF2bc/xqKaw++9CKFKqnQOFs8up9PqW9D
         5aMwvAIW4/0sQ==
Date:   Thu, 4 Aug 2022 08:14:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, fstests <fstests@vger.kernel.org>
Subject: [GIT PULL] xfs: new code for 6.0, part 1
Message-ID: <YuviV8ONBl1Sw5K0@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing new XFS code for 6.0.  The biggest
changes for this release are the log scalability improvements, lockless
lookups for the buffer cache, and making the attr fork a permanent part
of the incore inode in preparation for directory parent pointers.
There's also a bunch of bug fixes that have accumulated since -rc5.
I might send you a second pull request with some more bug fixes that I'm
still working on.

Once the merge window ends, I will hand maintainership back to Dave
Chinner until the 6.1-rc1 release so that I can conduct the design
review for the online fsck feature, and try to get it merged.

As usual, I did a test-merge with upstream master as of a few minutes
ago, and it completed flawlessly.  Please let me know if you encounter
any problems.  Hopefully I got the merge commits from Dave's pull
requests landed correctly, since I'm a bit rusty on that.

--D

The following changes since commit 88084a3df1672e131ddc1b4e39eeacfd39864acf:

  Linux 5.19-rc5 (2022-07-03 15:39:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.20-merge-6

for you to fetch changes up to 5e9466a5d0604e20082d828008047b3165592caf:

  xfs: delete extra space and tab in blank line (2022-07-31 09:21:27 -0700)

----------------------------------------------------------------
New code for 5.20:
- Improve scalability of the XFS log by removing spinlocks and global
  synchronization points.
- Add security labels to whiteout inodes to match the other filesystems.
- Clean up per-ag pointer passing to simplify call sites.
- Reduce verifier overhead by precalculating more AG geometry.
- Implement fast-path lockless lookups in the buffer cache to reduce
  spinlock hammering.
- Make attr forks a permanent part of the inode structure to fix a UAF
  bug and because most files these days tend to have security labels and
  soon will have parent pointers too.
- Clean up XFS_IFORK_Q usage and give it a better name.
- Fix more UAF bugs in the xattr code.
- SOB my tags.
- Fix some typos in the timestamp range documentation.
- Fix a few more memory leaks.
- Code cleanups and typo fixes.
- Fix an unlocked inode fork pointer access in getbmap.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Andrey Strachuk (1):
      xfs: removed useless condition in function xfs_attr_node_get

ChenXiaoSong (1):
      xfs: fix NULL pointer dereference in xfs_getbmap()

Dan Carpenter (1):
      xfs: delete unnecessary NULL checks

Darrick J. Wong (12):
      Merge tag 'xfs-cil-scale-5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-5.20-mergeA
      Merge tag 'xfs-perag-conv-5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-5.20-mergeA
      xfs: convert XFS_IFORK_PTR to a static inline helper
      xfs: make inode attribute forks a permanent part of struct xfs_inode
      xfs: use XFS_IFORK_Q to determine the presence of an xattr fork
      xfs: replace XFS_IFORK_Q with a proper predicate function
      xfs: replace inode fork size macros with functions
      Merge tag 'xfs-iunlink-item-5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-5.20-mergeB
      Merge tag 'xfs-buf-lockless-lookup-5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-5.20-mergeB
      Merge tag 'make-attr-fork-permanent-5.20_2022-07-14' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-5.20-mergeB
      xfs: fix use-after-free in xattr node block inactivation
      xfs: don't leak memory when attr fork loading fails

Dave Chinner (44):
      xfs: use the CIL space used counter for emptiness checks
      xfs: lift init CIL reservation out of xc_cil_lock
      xfs: rework per-iclog header CIL reservation
      xfs: introduce per-cpu CIL tracking structure
      xfs: implement percpu cil space used calculation
      xfs: track CIL ticket reservation in percpu structure
      xfs: convert CIL busy extents to per-cpu
      xfs: Add order IDs to log items in CIL
      xfs: convert CIL to unordered per cpu lists
      xfs: convert log vector chain to use list heads
      xfs: move CIL ordering to the logvec chain
      xfs: avoid cil push lock if possible
      xfs: xlog_sync() manually adjusts grant head space
      xfs: expanding delayed logging design with background material
      xfs: make last AG grow/shrink perag centric
      xfs: kill xfs_ialloc_pagi_init()
      xfs: pass perag to xfs_ialloc_read_agi()
      xfs: kill xfs_alloc_pagf_init()
      xfs: pass perag to xfs_alloc_read_agf()
      xfs: pass perag to xfs_read_agi
      xfs: pass perag to xfs_read_agf
      xfs: pass perag to xfs_alloc_get_freelist
      xfs: pass perag to xfs_alloc_put_freelist
      xfs: pass perag to xfs_alloc_read_agfl
      xfs: Pre-calculate per-AG agbno geometry
      xfs: Pre-calculate per-AG agino geometry
      xfs: replace xfs_ag_block_count() with perag accesses
      xfs: make is_log_ag() a first class helper
      xfs: rework xfs_buf_incore() API
      xfs: factor the xfs_iunlink functions
      xfs: track the iunlink list pointer in the xfs_inode
      xfs: refactor xlog_recover_process_iunlinks()
      xfs: introduce xfs_iunlink_lookup
      xfs: double link the unlinked inode list
      xfs: clean up xfs_iunlink_update_inode()
      xfs: combine iunlink inode update functions
      xfs: add log item precommit operation
      xfs: add in-memory iunlink log item
      xfs: break up xfs_buf_find() into individual pieces
      xfs: merge xfs_buf_find() and xfs_buf_get_map()
      xfs: reduce the number of atomic when locking a buffer after lookup
      xfs: remove a superflous hash lookup when inserting new buffers
      xfs: lockless buffer lookup
      xfs: xfs_buf cache destroy isn't RCU safe

Eric Sandeen (1):
      xfs: add selinux labels to whiteout inodes

Slark Xiao (1):
      xfs: Fix typo 'the the' in comment

Xiaole He (1):
      xfs: fix comment for start time value of inode with bigtime enabled

Xie Shaowen (1):
      xfs: delete extra space and tab in blank line

Xin Gao (1):
      xfs: Fix comment typo

Zhang Yi (1):
      xfs: flush inode gc workqueue before clearing agi bucket

sunliming (1):
      xfs: fix for variable set but not used warning

 .../filesystems/xfs-delayed-logging-design.rst     | 361 ++++++++++--
 fs/xfs/Makefile                                    |   1 +
 fs/xfs/libxfs/xfs_ag.c                             | 173 ++++--
 fs/xfs/libxfs/xfs_ag.h                             |  75 ++-
 fs/xfs/libxfs/xfs_ag_resv.c                        |   2 +-
 fs/xfs/libxfs/xfs_alloc.c                          | 145 ++---
 fs/xfs/libxfs/xfs_alloc.h                          |  58 +-
 fs/xfs/libxfs/xfs_alloc_btree.c                    |   9 +-
 fs/xfs/libxfs/xfs_attr.c                           |  22 +-
 fs/xfs/libxfs/xfs_attr.h                           |  10 +-
 fs/xfs/libxfs/xfs_attr_leaf.c                      |  28 +-
 fs/xfs/libxfs/xfs_attr_remote.c                    |  15 +-
 fs/xfs/libxfs/xfs_bmap.c                           |  84 +--
 fs/xfs/libxfs/xfs_bmap_btree.c                     |  10 +-
 fs/xfs/libxfs/xfs_btree.c                          |  29 +-
 fs/xfs/libxfs/xfs_dir2.c                           |   2 +-
 fs/xfs/libxfs/xfs_dir2_block.c                     |   6 +-
 fs/xfs/libxfs/xfs_dir2_sf.c                        |   8 +-
 fs/xfs/libxfs/xfs_format.h                         |   2 +-
 fs/xfs/libxfs/xfs_ialloc.c                         |  86 ++-
 fs/xfs/libxfs/xfs_ialloc.h                         |  25 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c                   |  20 +-
 fs/xfs/libxfs/xfs_inode_buf.c                      |  15 +-
 fs/xfs/libxfs/xfs_inode_fork.c                     |  65 ++-
 fs/xfs/libxfs/xfs_inode_fork.h                     |  27 +-
 fs/xfs/libxfs/xfs_refcount.c                       |  19 +-
 fs/xfs/libxfs/xfs_refcount_btree.c                 |   5 +-
 fs/xfs/libxfs/xfs_rmap.c                           |   8 +-
 fs/xfs/libxfs/xfs_rmap_btree.c                     |   9 +-
 fs/xfs/libxfs/xfs_symlink_remote.c                 |   2 +-
 fs/xfs/libxfs/xfs_types.c                          |  73 +--
 fs/xfs/libxfs/xfs_types.h                          |   9 -
 fs/xfs/scrub/agheader.c                            |  25 +-
 fs/xfs/scrub/agheader_repair.c                     |  21 +-
 fs/xfs/scrub/alloc.c                               |   7 +-
 fs/xfs/scrub/bmap.c                                |  16 +-
 fs/xfs/scrub/btree.c                               |   2 +-
 fs/xfs/scrub/common.c                              |   6 +-
 fs/xfs/scrub/dabtree.c                             |   2 +-
 fs/xfs/scrub/dir.c                                 |   2 +-
 fs/xfs/scrub/fscounters.c                          |   4 +-
 fs/xfs/scrub/health.c                              |   2 +
 fs/xfs/scrub/ialloc.c                              |  12 +-
 fs/xfs/scrub/quota.c                               |   2 +-
 fs/xfs/scrub/refcount.c                            |   9 +-
 fs/xfs/scrub/repair.c                              |  49 +-
 fs/xfs/scrub/rmap.c                                |   6 +-
 fs/xfs/scrub/symlink.c                             |   6 +-
 fs/xfs/xfs_attr_inactive.c                         |  23 +-
 fs/xfs/xfs_attr_list.c                             |   9 +-
 fs/xfs/xfs_bmap_util.c                             |  47 +-
 fs/xfs/xfs_buf.c                                   | 294 +++++-----
 fs/xfs/xfs_buf.h                                   |  27 +-
 fs/xfs/xfs_dir2_readdir.c                          |   2 +-
 fs/xfs/xfs_discard.c                               |   2 +-
 fs/xfs/xfs_dquot.c                                 |   2 +-
 fs/xfs/xfs_extfree_item.c                          |  18 +-
 fs/xfs/xfs_filestream.c                            |   4 +-
 fs/xfs/xfs_fsmap.c                                 |   3 +-
 fs/xfs/xfs_fsops.c                                 |  13 +-
 fs/xfs/xfs_icache.c                                |  14 +-
 fs/xfs/xfs_inode.c                                 | 648 ++++++---------------
 fs/xfs/xfs_inode.h                                 |  69 ++-
 fs/xfs/xfs_inode_item.c                            |  58 +-
 fs/xfs/xfs_ioctl.c                                 |  10 +-
 fs/xfs/xfs_iomap.c                                 |   8 +-
 fs/xfs/xfs_iops.c                                  |  13 +-
 fs/xfs/xfs_iops.h                                  |   3 +
 fs/xfs/xfs_itable.c                                |   4 +-
 fs/xfs/xfs_iunlink_item.c                          | 180 ++++++
 fs/xfs/xfs_iunlink_item.h                          |  27 +
 fs/xfs/xfs_log.c                                   |  57 +-
 fs/xfs/xfs_log.h                                   |   3 +-
 fs/xfs/xfs_log_cil.c                               | 474 +++++++++++----
 fs/xfs/xfs_log_priv.h                              |  58 +-
 fs/xfs/xfs_log_recover.c                           | 204 ++++---
 fs/xfs/xfs_mount.c                                 |   3 +-
 fs/xfs/xfs_qm.c                                    |  11 +-
 fs/xfs/xfs_reflink.c                               |  46 +-
 fs/xfs/xfs_reflink.h                               |   3 -
 fs/xfs/xfs_super.c                                 |  33 +-
 fs/xfs/xfs_symlink.c                               |   2 +-
 fs/xfs/xfs_trace.h                                 |   3 +-
 fs/xfs/xfs_trans.c                                 |  95 ++-
 fs/xfs/xfs_trans.h                                 |   7 +-
 fs/xfs/xfs_trans_priv.h                            |   3 +-
 86 files changed, 2332 insertions(+), 1722 deletions(-)
 create mode 100644 fs/xfs/xfs_iunlink_item.c
 create mode 100644 fs/xfs/xfs_iunlink_item.h
