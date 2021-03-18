Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71967340DF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 20:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhCRTOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 15:14:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232304AbhCRTOh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:14:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C97564F01;
        Thu, 18 Mar 2021 19:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616094877;
        bh=FDvUi5y3gmbGQqDpbsgRjjzwZmNqO7cadEh1mqrBz9o=;
        h=Date:From:To:Cc:Subject:From;
        b=EsEKhmnMfPvdDh+gmHPd1L8Q3xRnLnfrB22K1XGsWoUvn4Dxiaa2oafMHGHqRQyTb
         2wJaOtNqiS+aqzAfMjl6/fsCqIQSBYU4vN+QFb3Avm8ZCqAGeUdPCHrvWW0Cw4H8jF
         fuQ7b2m1MYgjA+DSjpMCMZhIX91+pUt0daXjoNid0mycj21Me6W0F8HYgAEfGR8vHs
         V+zDMeJUrxpOIeC7ErD1+JbLQnCHe5+KujH/ghzHOYBn0awQmwQ2sfXzhFSaqBnzSA
         s2rFTvM/kasKqyJ/Rkf3ZKQLkwFqFRTtHgR7dbGcXPeSWRmaRf0ZkJn2GJAfN+pQoL
         1bQ5qxpxKWP3w==
Date:   Thu, 18 Mar 2021 12:14:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.12-rc4
Message-ID: <20210318191436.GL22100@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull the following branch containing some fixes to the xfs code
for 5.12-rc4.  There's a couple of minor corrections for the new
idmapping functionality, and a fix for a theoretical hang that could
occur if we decide to abort a mount after dirtying the quota inodes.

This branch merges cleanly with upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.

--D

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.12-fixes-3

for you to fetch changes up to 8723d5ba8bdae1c41be7a6fc8469dc9aa551e7d0:

  xfs: also reject BULKSTAT_SINGLE in a mount user namespace (2021-03-15 08:50:41 -0700)

----------------------------------------------------------------
Changes for 5.12-rc3:
 - Fix quota accounting on creat() when id mapping is enabled.
 - Actually reclaim dirty quota inodes when mount fails.
 - Typo fixes for documentation.
 - Restrict both bulkstat calls on idmapped/namespaced mounts.

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      docs: ABI: Fix the spelling oustanding to outstanding in the file sysfs-fs-xfs

Christoph Hellwig (1):
      xfs: also reject BULKSTAT_SINGLE in a mount user namespace

Darrick J. Wong (2):
      xfs: fix quota accounting when a mount is idmapped
      xfs: force log and push AIL to clear pinned inodes when aborting mount

 Documentation/ABI/testing/sysfs-fs-xfs |  2 +-
 fs/xfs/xfs_inode.c                     | 14 +++---
 fs/xfs/xfs_itable.c                    |  6 +++
 fs/xfs/xfs_mount.c                     | 90 +++++++++++++++++-----------------
 fs/xfs/xfs_symlink.c                   |  3 +-
 5 files changed, 61 insertions(+), 54 deletions(-)
