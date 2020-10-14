Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05328E816
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 22:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgJNUvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 16:51:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgJNUvB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:51:01 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98822224E;
        Wed, 14 Oct 2020 20:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602708660;
        bh=gIJuVn5VLk23rh14WsqZJraDhWixLPkJxKD/i75CdQw=;
        h=Date:From:To:Cc:Subject:From;
        b=K4cm4DLnpVJ0loJDg1Fu9/xk8Za3+5kkHXqNXarpU/WvJ9tCHrqE+wvv27NWd8QFs
         pqtFq6MZn/+r4TXfKZ0RFDd4Czv7EI8/KbmLIOJbQayoBfZ/7e3sIyLnnIP+xb9zAb
         t3a8bYUvpL0eaBjXjAM+OyF7ynGihQ6YRzlu8Gno=
Date:   Wed, 14 Oct 2020 13:50:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.10, part 1
Message-ID: <20201014205059.GD9837@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this first large pile of new stuff for 5.10.  The biggest
changes are two new features for the ondisk metadata: one to record the
sizes of the inode btrees in the AG to increase redundancy checks and to
improve mount times; and a second new feature to support timestamps
until the year 2486.  We also fixed a problem where reflinking into a
file that requires synchronous writes wouldn't actually flush the
updates to disk; clean up a fair amount of cruft; and started fixing
some bugs in the realtime volume code.

I anticipate sending a second pull request in a few days to add some
scalability improvements, to schedule deprecation of old features, and
to add fixes for the realtime code.

The branch merges cleanly with upstream as of a few minutes ago, so
please let me know if anything strange happens.

--D

The following changes since commit f4d51dffc6c01a9e94650d95ce0104964f8ae822:

  Linux 5.9-rc4 (2020-09-06 17:11:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-merge-2

for you to fetch changes up to fe341eb151ec0ba80fb74edd6201fc78e5232b6b:

  xfs: ensure that fpunch, fcollapse, and finsert operations are aligned to rt extent size (2020-09-15 20:52:42 -0700)

----------------------------------------------------------------
New code for 5.10:
- Clean up the buffer ioend calling path so that the retry strategy
  isn't quite so scattered everywhere.
- Clean up m_sb_bp handling.
- New feature: storing inode btree counts in the AGI to speed up certain
  mount time per-AG block reservation operatoins and add a little more
  metadata redundancy.
- New feature: Widen inode timestamps and quota grace expiration
  timestamps to support dates through the year 2486.
- Get rid of more of our custom buffer allocation API wrappers.
- Use a proper VLA for shortform xattr structure namevals.
- Force the log after reflinking or deduping into a file that is opened
  with O_SYNC or O_DSYNC.
- Fix some math errors in the realtime allocator.

----------------------------------------------------------------
Carlos Maiolino (6):
      xfs: remove kmem_realloc()
      xfs: Remove kmem_zalloc_large()
      xfs: remove typedef xfs_attr_sf_entry_t
      xfs: Remove typedef xfs_attr_shortform_t
      xfs: Use variable-size array for nameval in xfs_attr_sf_entry
      xfs: Convert xfs_attr_sf macros to inline functions

Christoph Hellwig (15):
      xfs: refactor the buf ioend disposition code
      xfs: mark xfs_buf_ioend static
      xfs: refactor xfs_buf_ioend
      xfs: move the buffer retry logic to xfs_buf.c
      xfs: fold xfs_buf_ioend_finish into xfs_ioend
      xfs: refactor xfs_buf_ioerror_fail_without_retry
      xfs: remove xfs_buf_ioerror_retry
      xfs: lift the XBF_IOEND_FAIL handling into xfs_buf_ioend_disposition
      xfs: simplify the xfs_buf_ioend_disposition calling convention
      xfs: use xfs_buf_item_relse in xfs_buf_item_done
      xfs: clear the read/write flags later in xfs_buf_ioend
      xfs: remove xlog_recover_iodone
      xfs: simplify xfs_trans_getsb
      xfs: remove xfs_getsb
      xfs: reuse _xfs_buf_read for re-reading the superblock

Darrick J. Wong (19):
      xfs: store inode btree block counts in AGI header
      xfs: use the finobt block counts to speed up mount times
      xfs: support inode btree blockcounts in online scrub
      xfs: support inode btree blockcounts in online repair
      xfs: enable new inode btree counters feature
      xfs: explicitly define inode timestamp range
      xfs: refactor quota expiration timer modification
      xfs: refactor default quota grace period setting code
      xfs: refactor quota timestamp coding
      xfs: move xfs_log_dinode_to_disk to the log recovery code
      xfs: redefine xfs_timestamp_t
      xfs: redefine xfs_ictimestamp_t
      xfs: widen ondisk inode timestamps to deal with y2038+
      xfs: widen ondisk quota expiration timestamps to handle y2038+
      xfs: trace timestamp limits
      xfs: enable big timestamps
      xfs: force the log after remapping a synchronous-writes file
      xfs: make sure the rt allocator doesn't run off the end
      xfs: ensure that fpunch, fcollapse, and finsert operations are aligned to rt extent size

Dave Chinner (1):
      xfs: xfs_iflock is no longer a completion

Zheng Bin (1):
      xfs: Remove unneeded semicolon

 fs/xfs/kmem.c                    |  22 ----
 fs/xfs/kmem.h                    |   7 --
 fs/xfs/libxfs/xfs_ag.c           |   5 +
 fs/xfs/libxfs/xfs_attr.c         |  14 ++-
 fs/xfs/libxfs/xfs_attr_leaf.c    |  43 ++++---
 fs/xfs/libxfs/xfs_attr_sf.h      |  29 +++--
 fs/xfs/libxfs/xfs_da_format.h    |   6 +-
 fs/xfs/libxfs/xfs_dquot_buf.c    |  35 ++++++
 fs/xfs/libxfs/xfs_format.h       | 211 +++++++++++++++++++++++++++++--
 fs/xfs/libxfs/xfs_fs.h           |   1 +
 fs/xfs/libxfs/xfs_ialloc.c       |   5 +
 fs/xfs/libxfs/xfs_ialloc_btree.c |  65 +++++++++-
 fs/xfs/libxfs/xfs_iext_tree.c    |   2 +-
 fs/xfs/libxfs/xfs_inode_buf.c    | 130 +++++++++----------
 fs/xfs/libxfs/xfs_inode_buf.h    |  15 ++-
 fs/xfs/libxfs/xfs_inode_fork.c   |   8 +-
 fs/xfs/libxfs/xfs_log_format.h   |   7 +-
 fs/xfs/libxfs/xfs_log_recover.h  |   1 -
 fs/xfs/libxfs/xfs_quota_defs.h   |   8 +-
 fs/xfs/libxfs/xfs_sb.c           |   6 +-
 fs/xfs/libxfs/xfs_shared.h       |   3 +
 fs/xfs/libxfs/xfs_trans_inode.c  |  17 ++-
 fs/xfs/scrub/agheader.c          |  30 +++++
 fs/xfs/scrub/agheader_repair.c   |  24 ++++
 fs/xfs/scrub/inode.c             |  31 +++--
 fs/xfs/scrub/symlink.c           |   2 +-
 fs/xfs/xfs_acl.c                 |   2 +-
 fs/xfs/xfs_attr_list.c           |   6 +-
 fs/xfs/xfs_bmap_util.c           |  16 +++
 fs/xfs/xfs_buf.c                 | 208 +++++++++++++++++++++++++-----
 fs/xfs/xfs_buf.h                 |  17 +--
 fs/xfs/xfs_buf_item.c            | 264 ++-------------------------------------
 fs/xfs/xfs_buf_item.h            |  12 ++
 fs/xfs/xfs_buf_item_recover.c    |   2 +-
 fs/xfs/xfs_dquot.c               |  66 ++++++++--
 fs/xfs/xfs_dquot.h               |   3 +
 fs/xfs/xfs_file.c                |  17 ++-
 fs/xfs/xfs_icache.c              |  19 ++-
 fs/xfs/xfs_inode.c               |  83 +++++-------
 fs/xfs/xfs_inode.h               |  38 +-----
 fs/xfs/xfs_inode_item.c          |  61 ++++++---
 fs/xfs/xfs_inode_item.h          |   5 +-
 fs/xfs/xfs_inode_item_recover.c  |  76 +++++++++++
 fs/xfs/xfs_ioctl.c               |   7 +-
 fs/xfs/xfs_log_recover.c         |  60 +++------
 fs/xfs/xfs_mount.c               |  32 ++---
 fs/xfs/xfs_mount.h               |   1 -
 fs/xfs/xfs_ondisk.h              |  38 ++++--
 fs/xfs/xfs_qm.c                  |  13 ++
 fs/xfs/xfs_qm.h                  |   4 +
 fs/xfs/xfs_qm_syscalls.c         |  18 ++-
 fs/xfs/xfs_quota.h               |   8 --
 fs/xfs/xfs_rtalloc.c             |  13 +-
 fs/xfs/xfs_super.c               |  28 +++--
 fs/xfs/xfs_trace.h               |  29 ++++-
 fs/xfs/xfs_trans.c               |   2 +-
 fs/xfs/xfs_trans.h               |   2 +-
 fs/xfs/xfs_trans_buf.c           |  46 +++----
 fs/xfs/xfs_trans_dquot.c         |   6 +
 59 files changed, 1183 insertions(+), 746 deletions(-)
