Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4391F601A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 04:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgFKCnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 22:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgFKCnC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 22:43:02 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 798A6206FA;
        Thu, 11 Jun 2020 02:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591843382;
        bh=uM3dzCIwaaLTHi9qlTTMuvqdx9nz3dpFhWZaS11i1xA=;
        h=Date:From:To:Cc:Subject:From;
        b=c9mzM4KjTrYLQdNgmyeOEQ2rmtQ6gNNP8wJVJv0rQ/lVtYlCTa+6peAb5UzKZu0XO
         x60Sm0bKJEQZUsFlS85fmoWvvkYGukWZxEcedS7NXzl0LbRjx8Hwj9qHCArhDRIz5c
         PMyqM+TPsnD5eG/YSnt1ZhlBYld8s8NHjKbb3238=
Date:   Wed, 10 Jun 2020 19:42:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, ira.weiny@intel.com
Subject: [GIT PULL] vfs: improve DAX behavior for 5.8, part 3
Message-ID: <20200611024248.GG11245@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this third part of the 5.8 DAX changes.  Now that the xfs
changes have landed, this third piece changes the FS_XFLAG_DAX ioctl
code in xfs to request that the inode be reloaded after the last program
closes the file, if doing so would make a S_DAX change happen.  This
goal here is to make dax access mode switching quicker when possible.

I did a test merge of this branch against upstream this evening and
there weren't any conflicts.  The first five patches in the series were
already in the xfs merge, so it's only the last one that should change
anything.  Please let us know if you have any complaints about pulling
this, since I can rework the branch.

--D

The following changes since commit 2c567af418e3f9380c2051aada58b4e5a4b5c2ad:

  fs: Introduce DCACHE_DONTCACHE (2020-05-13 08:44:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.8-merge-3

for you to fetch changes up to e4f9ba20d3b8c2b86ec71f326882e1a3c4e47953:

  fs/xfs: Update xfs_ioctl_setattr_dax_invalidate() (2020-05-29 20:13:20 -0700)

----------------------------------------------------------------
Third part of new DAX code for 5.8:
- Teach XFS to ask the VFS to drop an inode if the administrator changes
  the FS_XFLAG_DAX inode flag such that the S_DAX state would change.
  This can result in files changing access modes without requiring an
  unmount cycle.

----------------------------------------------------------------
Ira Weiny (6):
      fs/xfs: Remove unnecessary initialization of i_rwsem
      fs/xfs: Change XFS_MOUNT_DAX to XFS_MOUNT_DAX_ALWAYS
      fs/xfs: Make DAX mount option a tri-state
      fs/xfs: Create function xfs_inode_should_enable_dax()
      fs/xfs: Combine xfs_diflags_to_linux() and xfs_diflags_to_iflags()
      fs/xfs: Update xfs_ioctl_setattr_dax_invalidate()

 fs/xfs/xfs_icache.c |   4 +-
 fs/xfs/xfs_inode.h  |   1 +
 fs/xfs/xfs_ioctl.c  | 141 ++++++++--------------------------------------------
 fs/xfs/xfs_iops.c   |  70 +++++++++++++++++---------
 fs/xfs/xfs_mount.h  |   4 +-
 fs/xfs/xfs_super.c  |  48 ++++++++++++++++--
 6 files changed, 115 insertions(+), 153 deletions(-)
