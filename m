Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5A2D2F05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 18:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfJJQxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 12:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfJJQxP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 12:53:15 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22CD4218AC;
        Thu, 10 Oct 2019 16:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570726395;
        bh=nxVFzpKNnJa6eBtiEg+aozlkkMTDk8SF/QKlbfycR+Y=;
        h=Date:From:To:Cc:Subject:From;
        b=uThvuy/vCnNc2jRV+yuQxInOEGiwCdkQvb8M6+JLtpWVOPKEPK18ejWpL+XxVBB13
         6FFY0BHYjMlT864bbWDfAVNr9wU7/drA49TWU1v3PPWqlVBmmNM0mrGGrVbnFDFu3U
         3/983kViEZtaGAfktbWfaxPPq31/pDbZhfAq42oE=
Date:   Thu, 10 Oct 2019 09:53:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.4-rc3
Message-ID: <20191010165314.GP1473994@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this set of changes for 5.4-rc3.  There are a couple of
small code cleanups and bug fixes for rounding errors, metadata logging
errors, and an extra layer of safeguards against leaking memory
contents.

The branch has survived a round of xfstests runs and merges cleanly with
this morning's master.  Please let me know if anything strange happens.

--D

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.4-fixes-3

for you to fetch changes up to aeea4b75f045294e1c026acc380466daa43afc65:

  xfs: move local to extent inode logging into bmap helper (2019-10-09 08:54:30 -0700)

----------------------------------------------------------------
Changes since last update:
- Fix a rounding error in the fallocate code
- Minor code cleanups
- Make sure to zero memory buffers before formatting metadata blocks
- Fix a few places where we forgot to log an inode metadata update
- Remove broken error handling that tried to clean up after a failure
  but still got it wrong

----------------------------------------------------------------
Aliasgar Surti (1):
      xfs: removed unused error variable from xchk_refcountbt_rec

Bill O'Donnell (1):
      xfs: assure zeroed memory buffers for certain kmem allocations

Brian Foster (3):
      xfs: log the inode on directory sf to block format change
      xfs: remove broken error handling on failed attr sf to leaf change
      xfs: move local to extent inode logging into bmap helper

Eric Sandeen (1):
      xfs: remove unused flags arg from xfs_get_aghdr_buf()

Max Reitz (1):
      xfs: Fix tail rounding in xfs_alloc_file_space()

 fs/xfs/libxfs/xfs_ag.c         |  5 ++---
 fs/xfs/libxfs/xfs_attr_leaf.c  | 21 +++------------------
 fs/xfs/libxfs/xfs_bmap.c       |  6 ++++--
 fs/xfs/libxfs/xfs_bmap.h       |  3 ++-
 fs/xfs/libxfs/xfs_dir2_block.c |  2 +-
 fs/xfs/scrub/refcount.c        |  3 +--
 fs/xfs/xfs_bmap_util.c         |  4 +++-
 fs/xfs/xfs_buf.c               | 12 +++++++++++-
 fs/xfs/xfs_log.c               |  2 +-
 fs/xfs/xfs_log_recover.c       |  2 +-
 10 files changed, 29 insertions(+), 31 deletions(-)
