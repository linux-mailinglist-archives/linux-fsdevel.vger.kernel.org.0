Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9337A49545C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 19:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346596AbiATSp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 13:45:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46732 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbiATSpz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:45:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE9FE6179B;
        Thu, 20 Jan 2022 18:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376E8C340E0;
        Thu, 20 Jan 2022 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642704354;
        bh=pAyzVdicLnMtpILHxx/BK3sQPou9x7BHvrW5n/p4dJA=;
        h=Date:From:To:Cc:Subject:From;
        b=kwwI7k4QT10l75iebLbF6dor+BCl7aPirIQ7LKyw1TUnaUBOU2GoKdCnCaALi0yRB
         /hyCfmYBUcTJRKegoKSbNBv5kQL6nJ4loGcYPiK5UosWkCegTwpaV5SlNB608KC/9L
         yXWy4zm9EpPn/lsnJvsF45rsNGP5zKOV7fyF/gr23aLwTMmJq5BSTuhZYX9ti0bN4H
         vttiuz3xB4xylGgq3b/i90WMD5kV7hg7CcSCoutkr4doUjJTbH6jXXNFJ8WaSThWpg
         A39YfkXnCDM4mreDxVHIayUhZf9QlsuoWRT+E4ZVqSmhKOzoEIQwD9IJPvSTk4VMio
         OeKOmYtXj+31Q==
Date:   Thu, 20 Jan 2022 10:45:53 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: legacy Irix ioctl housecleaning for 5.17-rc1, part 1
Message-ID: <20220120184553.GO13540@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

This is the second of a series of small pull requests that perform some
long overdue housecleaning of XFS ioctls.  This time, we're vacating the
implementation of all variants of the ALLOCSP and FREESP ioctls, which
are holdovers from EFS in Irix, circa 1993.  Roughly equivalent
functionality have been available for both ioctls since 2.6.25 (April
2008):

XFS_IOC_FREESP ftruncates a file.

XFS_IOC_ALLOCSP is the equivalent of fallocate.

As noted in the fix patch for CVE 2021-4155, the ALLOCSP ioctl has been
serving up stale disk blocks since 2000, and in 21 years **nobody**
noticed.  On those grounds I think it's safe to vacate the
implementation.

Note that we lose the ability to preallocate and truncate relative to
the current file position, but as nobody's ever implemented that for the
VFS, I conclude that it's not in high demand.

As usual, I did a test-merge with upstream master as of a few minutes
ago.  There's a single merge conflict due to the fixpatch that we merged
right before 5.16 that can be resolved by deleting the function.  Please
let me know if you encounter any problems.

--D

The following changes since commit 9dec0368b9640c09ef5af48214e097245e57a204:

  xfs: remove the XFS_IOC_FSSETDM definitions (2022-01-17 09:16:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-5

for you to fetch changes up to 4d1b97f9ce7c0d2af2bb85b12d48e6902172a28e:

  xfs: kill the XFS_IOC_{ALLOC,FREE}SP* ioctls (2022-01-17 09:16:41 -0800)

----------------------------------------------------------------
Remove the XFS_IOC_ALLOCSP* and XFS_IOC_FREESP* ioctl families.

Linux has always used fallocate as the space management system call,
whereas these Irix legacy ioctls only ever worked on XFS, and have been
the cause of recent stale data disclosure vulnerabilities.  As
equivalent functionality is available elsewhere, remove the code.

----------------------------------------------------------------
Darrick J. Wong (1):
      xfs: kill the XFS_IOC_{ALLOC,FREE}SP* ioctls

 fs/xfs/xfs_bmap_util.c |  7 ++--
 fs/xfs/xfs_bmap_util.h |  2 +-
 fs/xfs/xfs_file.c      |  3 +-
 fs/xfs/xfs_ioctl.c     | 92 +++-----------------------------------------------
 fs/xfs/xfs_ioctl.h     |  6 ----
 fs/xfs/xfs_ioctl32.c   | 27 ---------------
 6 files changed, 10 insertions(+), 127 deletions(-)
