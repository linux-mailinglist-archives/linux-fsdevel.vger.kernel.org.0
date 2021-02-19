Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55B831F436
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 04:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhBSDdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 22:33:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhBSDdo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 22:33:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8EB764ECA;
        Fri, 19 Feb 2021 03:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613705583;
        bh=j5rx9nRCiYG3qpKeTXd2kCmumKSrhK+DrOLzzfUjbp0=;
        h=Date:From:To:Cc:Subject:From;
        b=cFQJOnFprE2zPmMCVvUPAwBU7xZZuIddWTs6fgCGm/G5DvxbZMYCmpL6TWbfEEigI
         BEmnQ69kEIRfR53FPtBAQvX5HvrFkxSZzl/Be4Lh+A3c0OrrxnFYOUe7iCUmhq3ngN
         /RP6j5Nq0nZhyYYlBSpH+gyiIXaqwoLgXl7Mx9kzg/hbv9qZDyX1C62CnI/Kk5mjdC
         12EaVYVveRhwQdBytsuDcD2/4q5duq1UzQCC1ChH+OuTTbttV1qJnq7vIb23PlM4fO
         WS4VWnS7Tbcdwk+MDYv6rUoNl7IeMUsOZWaAB4I5dTxXyiM5iYsGfYkyU5vGnxcP/9
         uYwGZH9XO6ZXQ==
Date:   Thu, 18 Feb 2021 19:33:02 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, linux-btrfs@vger.kernel.org,
        naohiro.aota@wdc.com
Subject: [GIT PULL] iomap: new code for 5.12-rc1
Message-ID: <20210219033302.GY7193@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull these new changes to the iomap code for 5.12.  The big
change in this cycle is some new code to make it possible for XFS to try
unaligned directio overwrites without taking locks.  If the block is
fully written and within EOF (i.e. doesn't require any further fs
intervention) then we can let the unlocked write proceed.  If not, we
fall back to synchronizing direct writes.

Note that the btrfs developers have been working on supporting zoned
block devices, and their 5.12 pull request has a single iomap patch to
adjust directio writes to support REQ_OP_APPEND.

The branch merges cleanly with 5.11 and has been soaking in for-next for
quite a while now.  Please let me know if there are any strange
problems.  It's been a pretty quiet cycle, so I don't anticipate any
more iomap pulls other than whatever new bug fixes show up.

--D (whose pull requests are delayed by last weekend's wild ride :( )

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.12-merge-2

for you to fetch changes up to ed1128c2d0c87e5ff49c40f5529f06bc35f4251b:

  xfs: reduce exclusive locking on unaligned dio (2021-02-01 09:47:19 -0800)

----------------------------------------------------------------
New code for 5.12:
- Adjust the final parameter of iomap_dio_rw.
- Add a new flag to request that iomap directio writes return EAGAIN if
  the write is not a pure overwrite within EOF; this will be used to
  reduce lock contention with unaligned direct writes on XFS.
- Amend XFS' directio code to eliminate exclusive locking for unaligned
  direct writes if the circumstances permit

----------------------------------------------------------------
Christoph Hellwig (9):
      iomap: rename the flags variable in __iomap_dio_rw
      iomap: pass a flags argument to iomap_dio_rw
      iomap: add a IOMAP_DIO_OVERWRITE_ONLY flag
      xfs: factor out a xfs_ilock_iocb helper
      xfs: make xfs_file_aio_write_checks IOCB_NOWAIT-aware
      xfs: cleanup the read/write helper naming
      xfs: remove the buffered I/O fallback assert
      xfs: simplify the read/write tracepoints
      xfs: improve the reflink_bounce_dio_write tracepoint

Dave Chinner (2):
      xfs: split the unaligned DIO write code out
      xfs: reduce exclusive locking on unaligned dio

 fs/btrfs/file.c       |   7 +-
 fs/ext4/file.c        |   5 +-
 fs/gfs2/file.c        |   7 +-
 fs/iomap/direct-io.c  |  26 ++--
 fs/xfs/xfs_file.c     | 351 ++++++++++++++++++++++++++++----------------------
 fs/xfs/xfs_iomap.c    |  29 +++--
 fs/xfs/xfs_trace.h    |  22 ++--
 fs/zonefs/super.c     |   4 +-
 include/linux/iomap.h |  18 ++-
 9 files changed, 269 insertions(+), 200 deletions(-)
