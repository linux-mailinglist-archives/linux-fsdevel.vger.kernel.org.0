Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4188A394D80
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 May 2021 19:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhE2RNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 May 2021 13:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhE2RNt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 May 2021 13:13:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B52961107;
        Sat, 29 May 2021 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622308332;
        bh=ylmSLyCL6LF00Vk0pDrjmwZ52LFnCSdobf7HKQl8Tec=;
        h=Date:From:To:Cc:Subject:From;
        b=gxV8/pypK+O5GF1dp+CgEtLlb7hZt1TBSe56NumWNM3VD23SSXbS4L1wQfYZK8gqL
         m6UAz6i7qceUkiVQXphvLdDqdAN3NcSp0Scv4imSC/IHfOPzLoOitZjK9SvqduQTvQ
         8pIs47hHvUTobfk5W3xUffEQx1Jadn/FtAWj+NDg1aPtohqE4Lr1q9T7h9n4FvI1Ib
         Fx8kWb0nrNn5AWVd8S7VNaEztthHUDzwJm6cyVLoNfmt8cz4eyDYY7U6bYhZ/cRCaP
         y0RK5ZckZgUyZEd+WDyluHScDxi9GfxIqu+5+VaqKcvpcxUa6gaFK72zuJVRYs5fpv
         am4tLWbbGWlmw==
Date:   Sat, 29 May 2021 10:12:12 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.13-rc4
Message-ID: <20210529171212.GQ2402049@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing bug fixes for 5.13-rc4.  This week's
pile mitigates some decades-old problems in how extent size hints
interact with realtime volumes, fixes some failures in online shrink,
and fixes a problem where directory and symlink shrinking on extremely
fragmented filesystems could fail.

The most user-notable change here is to point users at our (new) IRC
channel on OFTC.  Freedom isn't free, it costs folks like you and me;
and if you don't kowtow, they'll expel everyone and take over your
channel.  (Ok, ok, that didn't fit the song lyrics...)

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.

--D

The following changes since commit e3c2b047475b52739bcf178a9e95176c42bbcf8f:

  xfs: restore old ioctl definitions (2021-05-20 08:31:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.13-fixes-3

for you to fetch changes up to 0fe0bbe00a6fb77adf75085b7d06b71a830dd6f2:

  xfs: bunmapi has unnecessary AG lock ordering issues (2021-05-27 08:11:24 -0700)

----------------------------------------------------------------
Fixes for 5.13-rc4:
- Fix a bug where unmapping operations end earlier than expected, which
  can cause chaos on multi-block directory and symlink shrink
  operations.
- Fix an erroneous assert that can trigger if we try to transition a
  bmap structure from btree format to extents format with zero extents.
  This was exposed by xfs/538.

----------------------------------------------------------------
Darrick J. Wong (4):
      xfs: check free AG space when making per-AG reservations
      xfs: standardize extent size hint validation
      xfs: validate extsz hints against rt extent size when rtinherit is set
      xfs: add new IRC channel to MAINTAINERS

Dave Chinner (2):
      xfs: btree format inode forks can have zero extents
      xfs: bunmapi has unnecessary AG lock ordering issues

 MAINTAINERS                     |   1 +
 fs/xfs/libxfs/xfs_ag_resv.c     |  18 +++++--
 fs/xfs/libxfs/xfs_bmap.c        |  12 -----
 fs/xfs/libxfs/xfs_inode_buf.c   |  46 ++++++++++++++++--
 fs/xfs/libxfs/xfs_trans_inode.c |  17 +++++++
 fs/xfs/xfs_inode.c              |  29 ++++++++++++
 fs/xfs/xfs_ioctl.c              | 101 ++++++++++++++--------------------------
 fs/xfs/xfs_message.h            |   2 +
 8 files changed, 140 insertions(+), 86 deletions(-)
