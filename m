Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B682DE7E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 18:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgLRRNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 12:13:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbgLRRNZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:13:25 -0500
Date:   Fri, 18 Dec 2020 09:12:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608311564;
        bh=bVsTLD70gj51aNdtA0DVixIH0v5Pgvp0WnWlESG1bkQ=;
        h=From:To:Cc:Subject:From;
        b=k1N5rFGcHsAdql1bqwusSaWqosoKaGCEkVlUrNqnJP71BhXlzWiaEj9hV7ITY9XA5
         tlVo4Ldv7nebt6m87AVGrgO5NoosWSxYkrFQFX482mAIzoueSyaAeGJ4xToNh6ZcPk
         24pl+5M++jV7gSoitSpEuSQEjueF678grxe+PeR9kZPllKwuSXmnRNZU28g+vxK9uw
         jyHpktv4fdRtW8uNI1uk9OGwtK4zkyd8lcan1eX98f+6a8epKqziMscREVmj4Vq5nU
         dQDeceXJNYGFx+Ro076015c8OIp+9ZvPPhEkT1sYrfeobj6E/2o5MHH059IyWUstXs
         XZ7mVnPWrUB5g==
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.11
Message-ID: <20201218171242.GH6918@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull the following branch containing all the new xfs code for
5.11.  In this release we add the ability to set a 'needsrepair' flag
indicating that we /know/ the filesystem requires xfs_repair, but other
than that, it's the usual strengthening of metadata validation and
miscellaneous cleanups.

The branch merges cleanly with your upstream head as of a few minutes
ago, so please let me know if anything strange happens.  Note also that
I will not be sending any iomap pull requests for this merge window as
there weren't any major iomap changes this cycle.

--D

The following changes since commit 418baf2c28f3473039f2f7377760bd8f6897ae18:

  Linux 5.10-rc5 (2020-11-22 15:36:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.11-merge-4

for you to fetch changes up to e82226138b20d4f638426413e83c6b5db532c6a2:

  xfs: remove xfs_buf_t typedef (2020-12-16 16:07:34 -0800)

----------------------------------------------------------------
New code for 5.11:
- Introduce a "needsrepair" "feature" to flag a filesystem as needing a
  pass through xfs_repair.  This is key to enabling filesystem upgrades
  (in xfs_db) that require xfs_repair to make minor adjustments to metadata.
- Refactor parameter checking of recovered log intent items so that we
  actually use the same validation code as them that generate the intent
  items.
- Various fixes to online scrub not reacting correctly to directory
  entries pointing to inodes that cannot be igetted.
- Refactor validation helpers for data and rt volume extents.
- Refactor XFS_TRANS_DQ_DIRTY out of existence.
- Fix a longstanding bug where mounting with "uqnoenforce" would start
  user quotas in non-enforcing mode but /proc/mounts would display
  "usrquota", implying that they are being enforced.
- Don't flag dax+reflink inodes as corruption since that is a valid (but
  not fully functional) combination right now.
- Clean up raid stripe validation functions.
- Refactor the inode allocation code to be more straightforward.
- Small prep cleanup for idmapping support.
- Get rid of the xfs_buf_t typedef.

----------------------------------------------------------------
Christoph Hellwig (2):
      xfs: remove xfs_vn_setattr_nonsize
      xfs: open code updating i_mode in xfs_set_acl

Darrick J. Wong (21):
      xfs: move kernel-specific superblock validation out of libxfs
      xfs: define a new "needrepair" feature
      xfs: enable the needsrepair feature
      xfs: hoist recovered bmap intent checks out of xfs_bui_item_recover
      xfs: improve the code that checks recovered bmap intent items
      xfs: hoist recovered rmap intent checks out of xfs_rui_item_recover
      xfs: improve the code that checks recovered rmap intent items
      xfs: hoist recovered refcount intent checks out of xfs_cui_item_recover
      xfs: improve the code that checks recovered refcount intent items
      xfs: hoist recovered extent-free intent checks out of xfs_efi_item_recover
      xfs: improve the code that checks recovered extent-free intent items
      xfs: validate feature support when recovering rmap/refcount intents
      xfs: trace log intent item recovery failures
      xfs: detect overflows in bmbt records
      xfs: fix parent pointer scrubber bailing out on unallocated inodes
      xfs: scrub should mark a directory corrupt if any entries cannot be iget'd
      xfs: refactor data device extent validation
      xfs: refactor realtime volume extent validation
      xfs: refactor file range validation
      xfs: rename xfs_fc_* back to xfs_fs_*
      xfs: fix the forward progress assertion in xfs_iwalk_run_callbacks

Dave Chinner (5):
      xfs: introduce xfs_dialloc_roll()
      xfs: move on-disk inode allocation out of xfs_ialloc()
      xfs: move xfs_dialloc_roll() into xfs_dialloc()
      xfs: spilt xfs_dialloc() into 2 functions
      xfs: remove xfs_buf_t typedef

Eric Sandeen (1):
      xfs: don't catch dax+reflink inodes as corruption in verifier

Gao Xiang (3):
      xfs: introduce xfs_validate_stripe_geometry()
      xfs: convert noroom, okalloc in xfs_dialloc() to bool
      xfs: kill ialloced in xfs_dialloc()

Joseph Qi (1):
      xfs: remove unneeded return value check for *init_cursor()

Kaixu Xia (6):
      xfs: delete duplicated tp->t_dqinfo null check and allocation
      xfs: check tp->t_dqinfo value instead of the XFS_TRANS_DQ_DIRTY flag
      xfs: directly return if the delta equal to zero
      xfs: remove unnecessary null check in xfs_generic_create
      xfs: remove the unused XFS_B_FSB_OFFSET macro
      xfs: show the proper user quota options

Zheng Yongjun (1):
      fs/xfs: convert comma to semicolon

 fs/xfs/libxfs/xfs_alloc.c        |  16 +--
 fs/xfs/libxfs/xfs_bmap.c         |  28 ++---
 fs/xfs/libxfs/xfs_bmap_btree.c   |   2 -
 fs/xfs/libxfs/xfs_btree.c        |  12 +-
 fs/xfs/libxfs/xfs_format.h       |  11 +-
 fs/xfs/libxfs/xfs_ialloc.c       | 170 ++++++++++++++-------------
 fs/xfs/libxfs/xfs_ialloc.h       |  36 +++---
 fs/xfs/libxfs/xfs_ialloc_btree.c |   5 -
 fs/xfs/libxfs/xfs_inode_buf.c    |   4 -
 fs/xfs/libxfs/xfs_refcount.c     |   9 --
 fs/xfs/libxfs/xfs_rmap.c         |   9 --
 fs/xfs/libxfs/xfs_rtbitmap.c     |  22 ++--
 fs/xfs/libxfs/xfs_sb.c           | 104 +++++++++++------
 fs/xfs/libxfs/xfs_sb.h           |   3 +
 fs/xfs/libxfs/xfs_shared.h       |   1 -
 fs/xfs/libxfs/xfs_types.c        |  64 +++++++++++
 fs/xfs/libxfs/xfs_types.h        |   7 ++
 fs/xfs/scrub/agheader_repair.c   |   2 -
 fs/xfs/scrub/bmap.c              |  22 +---
 fs/xfs/scrub/common.c            |  14 ---
 fs/xfs/scrub/dir.c               |  21 +++-
 fs/xfs/scrub/inode.c             |   4 -
 fs/xfs/scrub/parent.c            |  10 +-
 fs/xfs/scrub/rtbitmap.c          |   4 +-
 fs/xfs/xfs_acl.c                 |  40 ++++---
 fs/xfs/xfs_bmap_item.c           |  65 ++++++-----
 fs/xfs/xfs_buf.c                 |  24 ++--
 fs/xfs/xfs_buf.h                 |  14 +--
 fs/xfs/xfs_buf_item.c            |   4 +-
 fs/xfs/xfs_extfree_item.c        |  23 ++--
 fs/xfs/xfs_fsops.c               |   2 +-
 fs/xfs/xfs_inode.c               | 243 +++++++++------------------------------
 fs/xfs/xfs_inode.h               |   6 +-
 fs/xfs/xfs_iops.c                |  41 +++----
 fs/xfs/xfs_iops.h                |   8 --
 fs/xfs/xfs_iwalk.c               |   2 +-
 fs/xfs/xfs_log_recover.c         |  13 ++-
 fs/xfs/xfs_qm.c                  |  26 ++---
 fs/xfs/xfs_refcount_item.c       |  52 +++++----
 fs/xfs/xfs_rmap_item.c           |  67 +++++++----
 fs/xfs/xfs_rtalloc.c             |  20 ++--
 fs/xfs/xfs_rtalloc.h             |   4 +-
 fs/xfs/xfs_super.c               |  77 ++++++++++---
 fs/xfs/xfs_symlink.c             |   4 +-
 fs/xfs/xfs_trace.h               |  18 +++
 fs/xfs/xfs_trans.c               |   2 +-
 fs/xfs/xfs_trans_buf.c           |  16 +--
 fs/xfs/xfs_trans_dquot.c         |  43 ++-----
 48 files changed, 692 insertions(+), 702 deletions(-)
