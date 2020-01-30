Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A702614DEAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 17:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgA3QNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 11:13:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgA3QNk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:13:40 -0500
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E4220CC7;
        Thu, 30 Jan 2020 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580400819;
        bh=y4LBdyNzad+FYy/0/jvCYzeA/hoqHIJ23g5XmjtmHmc=;
        h=Date:From:To:Cc:Subject:From;
        b=u54hoVK5cla26Fm6lwxRF3kHM4Mr3otCKEToeqgwzWW3F5FT2uh1+saXT3Ku6lOji
         A5X7HbquEMdxMHcW/Tl8DgHFCwK3O9SqFySvQ0ug3rJbqUsFZy5hNbSH/XormOBxcE
         Vve76VqcUywa1XY3opfVr3w97gEs5j1cfbVMjPLY=
Date:   Thu, 30 Jan 2020 08:13:38 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.6
Message-ID: <20200130161338.GX3447196@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this first batch of new changes for 5.6-rc1.  In this
release we clean out the last of the old 32-bit timestamp code, fix a
number of bugs and memory corruptions on 32-bit platforms, and a
refactoring of some of the extended attribute code.

I think I'll be back next week with some refactoring of how the XFS
buffer code returns error codes, however I prefer to hold onto that for
another week to let it soak a while longer.

--D

The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.6-merge-6

for you to fetch changes up to b3531f5fc16d4df2b12567bce48cd9f3ab5f9131:

  xfs: remove unused variable 'done' (2020-01-23 21:24:50 -0800)

----------------------------------------------------------------
New code for 5.6:
- Get rid of compat_time_t
- Convert time_t to time64_t in quota code
- Remove shadow variables
- Prevent ATTR_ flag misuse in the attrmulti ioctls
- Clean out strlen in the attr code
- Remove some bogus asserts
- Fix various file size limit calculation errors with 32-bit kernels
- Pack xfs_dir2_sf_entry_t to fix build errors on arm oabi
- Fix nowait inode locking calls for directio aio reads.
- Fix memory corruption bugs when invalidating remote xattr value
  buffers.
- Streamline remote attr value removal.
- Make the buffer log format size consistent across platforms.
- Strengthen buffer log format size checking.
- Fix messed up return types of xfs_inode_need_cow.
- Fix some unused variable warnings.

----------------------------------------------------------------
Allison Henderson (1):
      xfs: Remove all strlen in all xfs_attr_* functions for attr names.

Arnd Bergmann (2):
      xfs: rename compat_time_t to old_time32_t
      xfs: quota: move to time64_t interfaces

Christoph Hellwig (5):
      xfs: clear kernel only flags in XFS_IOC_ATTRMULTI_BY_HANDLE
      xfs: reject invalid flags combinations in XFS_IOC_ATTRMULTI_BY_HANDLE
      xfs: also remove cached ACLs when removing the underlying attr
      xfs: fix misuse of the XFS_ATTR_INCOMPLETE flag
      xfs: fix IOCB_NOWAIT handling in xfs_file_dio_aio_read

Darrick J. Wong (12):
      xfs: remove bogus assertion when online repair isn't enabled
      xfs: introduce XFS_MAX_FILEOFF
      xfs: truncate should remove all blocks, not just to the end of the page cache
      xfs: fix s_maxbytes computation on 32-bit kernels
      xfs: refactor remote attr value buffer invalidation
      xfs: fix memory corruption during remote attr value buffer invalidation
      xfs: streamline xfs_attr3_leaf_inactive
      xfs: clean up xfs_buf_item_get_format return value
      xfs: complain if anyone tries to create a too-large buffer log item
      xfs: make struct xfs_buf_log_format have a consistent size
      xfs: check log iovec size to make sure it's plausibly a buffer log format
      xfs: fix uninitialized variable in xfs_attr3_leaf_inactive

Eric Sandeen (1):
      xfs: remove shadow variable in xfs_btree_lshift

Vincenzo Frascino (1):
      xfs: Add __packed to xfs_dir2_sf_entry_t definition

YueHaibing (1):
      xfs: remove unused variable 'done'

zhengbin (1):
      xfs: change return value of xfs_inode_need_cow to int

 fs/xfs/libxfs/xfs_attr.c        |  14 ++--
 fs/xfs/libxfs/xfs_attr.h        |  15 ++--
 fs/xfs/libxfs/xfs_attr_leaf.c   |   4 +-
 fs/xfs/libxfs/xfs_attr_leaf.h   |   9 ---
 fs/xfs/libxfs/xfs_attr_remote.c |  89 +++++++++++++++++-------
 fs/xfs/libxfs/xfs_attr_remote.h |   2 +
 fs/xfs/libxfs/xfs_btree.c       |   2 -
 fs/xfs/libxfs/xfs_da_btree.h    |   4 +-
 fs/xfs/libxfs/xfs_da_format.h   |   4 +-
 fs/xfs/libxfs/xfs_format.h      |   7 ++
 fs/xfs/libxfs/xfs_log_format.h  |  19 +++--
 fs/xfs/scrub/repair.h           |   1 -
 fs/xfs/xfs_acl.c                |  11 +--
 fs/xfs/xfs_attr_inactive.c      | 149 ++++++++++++----------------------------
 fs/xfs/xfs_buf_item.c           |  45 ++++++++----
 fs/xfs/xfs_buf_item.h           |   1 +
 fs/xfs/xfs_dquot.c              |   6 +-
 fs/xfs/xfs_file.c               |   7 +-
 fs/xfs/xfs_inode.c              |  25 ++++---
 fs/xfs/xfs_ioctl.c              |  20 +++++-
 fs/xfs/xfs_ioctl32.c            |   9 ++-
 fs/xfs/xfs_ioctl32.h            |   2 +-
 fs/xfs/xfs_iomap.c              |   2 +-
 fs/xfs/xfs_iops.c               |   6 +-
 fs/xfs/xfs_log_recover.c        |   6 ++
 fs/xfs/xfs_ondisk.h             |   1 +
 fs/xfs/xfs_qm.h                 |   6 +-
 fs/xfs/xfs_quotaops.c           |   6 +-
 fs/xfs/xfs_reflink.c            |   9 +--
 fs/xfs/xfs_reflink.h            |   2 +-
 fs/xfs/xfs_super.c              |  48 ++++++-------
 fs/xfs/xfs_trans_dquot.c        |   8 ++-
 fs/xfs/xfs_xattr.c              |  14 ++--
 33 files changed, 300 insertions(+), 253 deletions(-)
