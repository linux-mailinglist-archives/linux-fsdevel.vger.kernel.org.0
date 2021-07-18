Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C755E3CC9E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jul 2021 18:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhGRQmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jul 2021 12:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhGRQmb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jul 2021 12:42:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9B8A600D3;
        Sun, 18 Jul 2021 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626626372;
        bh=PcfSJqnL4nyO3nvWZC3cpvEwmt7XAIh3V/izsRLYz7o=;
        h=Date:From:To:Cc:Subject:From;
        b=qCExeGBmkA8H3dI6aiXY9olfjOPloGP/EUxi/c+/Kn/WFLnp2mqjoWSv3xoeQC07b
         aEkOFJETDS2iXtBaDPbreLGR9/Sy7BcKdXjZjMdmnJhWVn4mFkWwYHuFxJtWlVTzIg
         tpIbPjw8pFskkZwf0YvmMn4o5itTMEpLuRhyBP8TvppBvlTYBFgp0N1Ft424y+6bqe
         NbuFNn6gpS0aNFwbSdRCVnM+Bxy/IC3FcZnQA33bvAzFPvD0zYAEmu57cfnbfLKYoj
         GgfDEYQQmvVYKXY+alCYS4ib+g7qmZJLQeV9OanwP4ozgsx++oSSqvjrrX+jtVfPTU
         H4uOPpkhszfNA==
Date:   Sun, 18 Jul 2021 09:39:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: bug fixes for 5.14-rc2
Message-ID: <20210718163931.GB22402@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing a bunch of bug fixes in XFS.  There
are a few fixes for issues in the new online shrink code, additional
corrections for my recent bug-hunt w.r.t. extent size hints on realtime,
and improved input checking of the GROWFSRT ioctl.  IOWs, the usual "I
somehow got bored during the merge window and resumed auditing the
farther reaches of xfs."

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.

--D

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.14-fixes-1

for you to fetch changes up to b102a46ce16fd5550aed882c3c5b95f50da7992c:

  xfs: detect misaligned rtinherit directory extent size hints (2021-07-15 09:58:42 -0700)

----------------------------------------------------------------
Fixes for 5.14-rc:
 * Fix shrink eligibility checking when sparse inode clusters enabled.
 * Reset '..' directory entries when unlinking directories to prevent
   verifier errors if fs is shrinked later.
 * Don't report unusable extent size hints to FSGETXATTR.
 * Don't warn when extent size hints are unusable because the sysadmin
   configured them that way.
 * Fix insufficient parameter validation in GROWFSRT ioctl.
 * Fix integer overflow when adding rt volumes to filesystem.

----------------------------------------------------------------
Darrick J. Wong (7):
      xfs: check for sparse inode clusters that cross new EOAG when shrinking
      xfs: reset child dir '..' entry when unlinking child
      xfs: correct the narrative around misaligned rtinherit/extszinherit dirs
      xfs: don't expose misaligned extszinherit hints to userspace
      xfs: improve FSGROWFSRT precondition checking
      xfs: fix an integer overflow error in xfs_growfs_rt
      xfs: detect misaligned rtinherit directory extent size hints

 fs/xfs/libxfs/xfs_ag.c          |  8 ++++++
 fs/xfs/libxfs/xfs_ialloc.c      | 55 +++++++++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_ialloc.h      |  3 +++
 fs/xfs/libxfs/xfs_inode_buf.c   | 28 ++++++++++++---------
 fs/xfs/libxfs/xfs_trans_inode.c | 10 +++-----
 fs/xfs/scrub/inode.c            | 18 ++++++++++++--
 fs/xfs/xfs_inode.c              | 13 ++++++++++
 fs/xfs/xfs_ioctl.c              | 27 ++++++++++++++++----
 fs/xfs/xfs_rtalloc.c            | 49 +++++++++++++++++++++++++++---------
 9 files changed, 174 insertions(+), 37 deletions(-)
