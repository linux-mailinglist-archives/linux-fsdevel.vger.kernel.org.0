Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAFA2AAC99
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 18:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgKHRWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 12:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHRWg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 12:22:36 -0500
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5344C206DC;
        Sun,  8 Nov 2020 17:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604856155;
        bh=hrkhzcP3WDPHy+13jA46SqQwjXo+5SKZT44YOaZ5TLM=;
        h=Date:From:To:Cc:Subject:From;
        b=VibmF4UIghi1HeGGzpdVzM9gW4bv/FgUw2rwq7XdJIrmXNLq9Z4NFANIsFpATtNpV
         bF39u58EL1Fu8kQHq7gPhcxkOM/NZgYDESrkCEEfYIJXXHjUAanp5Yo723TlSmotWw
         l+LhBQOIHdbJd3f0BfFdPsaunVAn4ngFiiOSyMJ8=
Date:   Sun, 8 Nov 2020 09:22:35 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.10-rc3
Message-ID: <20201108172235.GA9695@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing bug fixes for 5.10.

The branch merges cleanly with upstream as of a few minutes ago, so
please let me know if anything strange happens.

--D

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-fixes-3

for you to fetch changes up to 46afb0628b86347933b16ac966655f74eab65c8c:

  xfs: only flush the unshared range in xfs_reflink_unshare (2020-11-04 17:41:56 -0800)

----------------------------------------------------------------
Fixes for 5.10-rc3:
- Fix an uninitialized struct problem.
- Fix an iomap problem zeroing unwritten EOF blocks.
- Fix some clumsy error handling when writeback fails on
  blocksize < pagesize filesystems.
- Fix a retry loop not resetting loop variables properly.
- Fix scrub flagging rtinherit inodes on a non-rt fs, since the kernel
  actually does permit that combination.
- Fix excessive page cache flushing when unsharing part of a file.

----------------------------------------------------------------
Brian Foster (3):
      xfs: flush new eof page on truncate to avoid post-eof corruption
      iomap: support partial page discard on writeback block mapping failure
      iomap: clean up writeback state logic on writepage error

Darrick J. Wong (4):
      xfs: set xefi_discard when creating a deferred agfl free log intent item
      xfs: fix missing CoW blocks writeback conversion retry
      xfs: fix scrub flagging rtinherit even if there is no rt device
      xfs: only flush the unshared range in xfs_reflink_unshare

 fs/iomap/buffered-io.c    | 30 ++++++++++--------------------
 fs/xfs/libxfs/xfs_alloc.c |  1 +
 fs/xfs/libxfs/xfs_bmap.h  |  2 +-
 fs/xfs/scrub/inode.c      |  3 +--
 fs/xfs/xfs_aops.c         | 20 ++++++++++++--------
 fs/xfs/xfs_iops.c         | 10 ++++++++++
 fs/xfs/xfs_reflink.c      |  3 ++-
 include/linux/iomap.h     |  2 +-
 8 files changed, 38 insertions(+), 33 deletions(-)
