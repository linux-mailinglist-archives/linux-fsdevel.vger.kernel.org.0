Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEE5128EE2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2019 17:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfLVQcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Dec 2019 11:32:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfLVQcT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Dec 2019 11:32:19 -0500
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2394420684;
        Sun, 22 Dec 2019 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577032339;
        bh=5SW2T5Nijt/qrSRhZFyckkiMkH+dLeo4Zi67LBsr0f4=;
        h=Date:From:To:Cc:Subject:From;
        b=NJkL977ZRx9WCtyHT3E9czhX/VOPXFAu8NmnyX0V9FI04+SV0DIP0BMFa9o59lzxX
         0UrJL72ytloM63TWWcx2NkymUCN25IVXBNjS89BhcykFJ8BB6MNh/lGliQSasX4dPD
         Q7cU5gaMbFRNJgMZ+5hP5MP+85X3MrvB9J8wSlss=
Date:   Sun, 22 Dec 2019 08:32:18 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.5-rc3
Message-ID: <20191222163218.GR7489@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull these bug fixes for 5.5-rc3, which fix a few bugs that could
lead to corrupt files, fsck complaints, and filesystem crashes.

The branch has survived a couple of days of xfstests runs and merges
cleanly with this morning's master.  Please let me know if anything
strange happens.

--D

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.5-fixes-2

for you to fetch changes up to 5084bf6b2006fcd46f1e44e3c51b687507b362e2:

  xfs: Make the symbol 'xfs_rtalloc_log_count' static (2019-12-20 08:07:31 -0800)

----------------------------------------------------------------
Fixes for 5.5:
- Minor documentation fixes
- Fix a file corruption due to read racing with an insert range
operation.
- Fix log reservation overflows when allocating large rt extents
- Fix a buffer log item flags check
- Don't allow administrators to mount with sunit= options that will
cause later xfs_repair complaints about the root directory being
suspicious because the fs geometry appeared inconsistent
- Fix a non-static helper that should have been static

----------------------------------------------------------------
Brian Foster (2):
      xfs: stabilize insert range start boundary to avoid COW writeback race
      xfs: use bitops interface for buf log item AIL flag check

Chen Wandun (1):
      xfs: Make the symbol 'xfs_rtalloc_log_count' static

Darrick J. Wong (5):
      xfs: fix log reservation overflows when allocating large rt extents
      libxfs: resync with the userspace libxfs
      xfs: refactor agfl length computation function
      xfs: split the sunit parameter update into two parts
      xfs: don't commit sunit/swidth updates to disk if that would cause repair failures

Randy Dunlap (1):
      xfs: fix Sphinx documentation warning

 Documentation/admin-guide/xfs.rst |   2 +-
 fs/xfs/libxfs/xfs_alloc.c         |  18 ++--
 fs/xfs/libxfs/xfs_bmap.c          |   5 +-
 fs/xfs/libxfs/xfs_dir2.c          |  21 +++++
 fs/xfs/libxfs/xfs_dir2_priv.h     |  29 ++-----
 fs/xfs/libxfs/xfs_dir2_sf.c       |   6 +-
 fs/xfs/libxfs/xfs_ialloc.c        |  64 +++++++++++++++
 fs/xfs/libxfs/xfs_ialloc.h        |   1 +
 fs/xfs/libxfs/xfs_trans_resv.c    |  96 +++++++++++++++++-----
 fs/xfs/xfs_bmap_util.c            |  12 +++
 fs/xfs/xfs_buf_item.c             |   2 +-
 fs/xfs/xfs_mount.c                | 168 ++++++++++++++++++++++++++------------
 fs/xfs/xfs_trace.h                |  21 +++++
 13 files changed, 341 insertions(+), 104 deletions(-)
