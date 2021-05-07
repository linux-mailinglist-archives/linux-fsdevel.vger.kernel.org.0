Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A24375DE8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 02:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhEGAdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 20:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233539AbhEGAdn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 20:33:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2544E610FA;
        Fri,  7 May 2021 00:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620347564;
        bh=4gAFmIq38uaBj2IJ15SPVZYv1uvzYNSTPMlW8/M6ADI=;
        h=Date:From:To:Cc:Subject:From;
        b=mcBeHU6UlJ3QGZQhBDCTXnoqxsnoQzpvZ2Ha0LYOV4103bTyAXQNXU+Y26WqzgV86
         QkwYytbG5lGmJl8I1DnMQAx/GoveotbPL1r9kBywy8ZPWj4fSErdc9Z3wnWIQOQEAd
         xJd3EjaqsoUPTHHaOjV1GAiX/RfuyiUz/8dbGAXJMNtswK9+XRuZO1wCNM0Mc+Ly4U
         BOUj2YXTwhIsRrnIa0IUbhaReCGa1jO+EbL2fErd6mmLTEZm0He1p/LT2TCY7fZmTY
         mw0FzfNNTlf1Q7jABhKuI0Z0FF12o5xMGi4VhuNO3uhaAoT0xOWraPN1UYdaTGeB/3
         Vv6dL04A4Zc2w==
Date:   Thu, 6 May 2021 17:32:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: more new code for 5.13
Message-ID: <20210507003244.GF8582@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this second branch containing new xfs code for 5.13.  Except
for the timestamp struct renaming patches, everything else in here are
bug fixes for 5.13-rc1.

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.

--D

The following changes since commit 76adf92a30f3b92a7f91bb00b28ea80efccd0f01:

  xfs: remove xfs_quiesce_attr declaration (2021-04-16 08:28:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.13-merge-5

for you to fetch changes up to 8e9800f9f2b89e1efe2a5993361fae4d618a6c26:

  xfs: don't allow log writes if the data device is readonly (2021-05-04 08:43:27 -0700)

----------------------------------------------------------------
More new code for 5.13:
- Rename the log timestamp struct.
- Remove broken transaction counter debugging that wasn't working
  correctly on very old filesystems.
- Various fixes to make pre-lazysbcount filesystems work properly again.
- Fix a free space accounting problem where we neglected to consider
  free space btree blocks that track metadata reservation space when
  deciding whether or not to allow caller to reserve space for
  a metadata update.
- Fix incorrect pagecache clearing behavior during FUNSHARE ops.
- Don't allow log writes if the data device is readonly.

----------------------------------------------------------------
Brian Foster (3):
      xfs: unconditionally read all AGFs on mounts with perag reservation
      xfs: introduce in-core global counter of allocbt blocks
      xfs: set aside allocation btree blocks from block reservation

Christoph Hellwig (2):
      xfs: rename xfs_ictimestamp_t
      xfs: rename struct xfs_legacy_ictimestamp

Darrick J. Wong (5):
      xfs: remove obsolete AGF counter debugging
      xfs: don't check agf_btreeblks on pre-lazysbcount filesystems
      xfs: count free space btree blocks when scrubbing pre-lazysbcount fses
      xfs: fix xfs_reflink_unshare usage of filemap_write_and_wait_range
      xfs: don't allow log writes if the data device is readonly

Dave Chinner (1):
      xfs: update superblock counters correctly for !lazysbcount

 fs/xfs/libxfs/xfs_ag_resv.c     | 34 +++++++++++++++++++++++-----------
 fs/xfs/libxfs/xfs_alloc.c       | 17 ++++++++++++++---
 fs/xfs/libxfs/xfs_alloc_btree.c |  4 ++--
 fs/xfs/libxfs/xfs_log_format.h  | 12 ++++++------
 fs/xfs/libxfs/xfs_rmap_btree.c  |  2 --
 fs/xfs/libxfs/xfs_sb.c          | 16 +++++++++++++---
 fs/xfs/scrub/agheader.c         |  7 ++++++-
 fs/xfs/scrub/fscounters.c       | 40 +++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_fsops.c              |  2 --
 fs/xfs/xfs_inode_item.c         |  8 ++++----
 fs/xfs/xfs_inode_item_recover.c |  6 +++---
 fs/xfs/xfs_log.c                | 10 ++++++----
 fs/xfs/xfs_mount.c              | 15 ++++++++++++++-
 fs/xfs/xfs_mount.h              |  6 ++++++
 fs/xfs/xfs_ondisk.h             |  4 ++--
 fs/xfs/xfs_reflink.c            |  3 ++-
 fs/xfs/xfs_trans.c              | 10 +++-------
 fs/xfs/xfs_trans.h              | 15 ---------------
 18 files changed, 143 insertions(+), 68 deletions(-)
