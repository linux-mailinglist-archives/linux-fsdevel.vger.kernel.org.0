Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC441A39B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 20:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDISP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 14:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDISP2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:15:28 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64F4620753;
        Thu,  9 Apr 2020 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586456127;
        bh=Vh/nEZmKyunglWKfJLO8V2/jVJZeYUVc1nRZToQfYJM=;
        h=Date:From:To:Cc:Subject:From;
        b=JrnwGAzOOtbxisYagljxGCFpNA6x4T9l9xygwGEQbJFCtvdSPlHle0qjfrmp03opp
         IZDF24W/orZj3Jh5oQKgaNGkwO52y5137qoj+0MdJ2/zP79zhUw2OiVbwYZVhQc81w
         xQtozQp1PN5BTGs/B4d9iYXqHVe3Vn1ICnl7Pf60=
Date:   Thu, 9 Apr 2020 11:15:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.7, part 2
Message-ID: <20200409181526.GM6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this second batch of new changes for 5.7.  As promised last
week, this batch changes how xfs interacts with memory reclaim; how the
log batches and throttles log items; how hard writes near ENOSPC will
try to squeeze more space out of the filesystem; and hopefully fix the
last of the umount hangs after a catastrophic failure.

This branch merges cleanly with master as of a few minutes ago, so
please let me know if anything strange happens.

--D

The following changes since commit 27fb5a72f50aa770dd38b0478c07acacef97e3e7:

  xfs: prohibit fs freezing when using empty transactions (2020-03-26 08:19:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.7-merge-12

for you to fetch changes up to 5833112df7e9a306af9af09c60127b92ed723962:

  xfs: reflink should force the log out if mounted with wsync (2020-04-06 08:44:39 -0700)

----------------------------------------------------------------
(More) new code for 5.7:
- Validate the realtime geometry in the superblock when mounting
- Refactor a bunch of tricky flag handling in the log code
- Flush the CIL more judiciously so that we don't wait until there are
  millions of log items consuming a lot of memory.
- Throttle transaction commits to prevent the xfs frontend from flooding
  the CIL with too many log items.
- Account metadata buffers correctly for memory reclaim.
- Mark slabs properly for memory reclaim.  These should help reclaim run
  more effectively when XFS is using a lot of memory.
- Don't write a garbage log record at unmount time if we're trying to
  trigger summary counter recalculation at next mount.
- Don't block the AIL on locked dquot/inode buffers; instead trigger its
  backoff mechanism to give the lock holder a chance to finish up.
- Ratelimit writeback flushing when buffered writes encounter ENOSPC.
- Other minor cleanups.
- Make reflink a synchronous operation when the fs is mounted with wsync
  or sync, which means that now we force the log to disk to record the
  changes.

----------------------------------------------------------------
Brian Foster (3):
      xfs: trylock underlying buffer on dquot flush
      xfs: return locked status of inode buffer on xfsaild push
      xfs: fix inode number overflow in ifree cluster helper

Christoph Hellwig (3):
      xfs: split xlog_ticket_done
      xfs: factor out a new xfs_log_force_inode helper
      xfs: reflink should force the log out if mounted with wsync

Darrick J. Wong (3):
      xfs: validate the realtime geometry in xfs_validate_sb_common
      xfs: don't write a corrupt unmount record to force summary counter recalc
      xfs: ratelimit inode flush on buffered write ENOSPC

Dave Chinner (15):
      xfs: don't try to write a start record into every iclog
      xfs: re-order initial space accounting checks in xlog_write
      xfs: refactor and split xfs_log_done()
      xfs: kill XLOG_TIC_INITED
      xfs: merge xlog_commit_record with xlog_write_done
      xfs: refactor unmount record writing
      xfs: remove some stale comments from the log code
      xfs: Lower CIL flush limit for large logs
      xfs: Throttle commits on delayed background CIL push
      xfs: don't allow log IO to be throttled
      xfs: Improve metadata buffer reclaim accountability
      xfs: correctly acount for reclaimable slabs
      xfs: factor common AIL item deletion code
      xfs: tail updates only need to occur when LSN changes
      xfs: factor inode lookup from xfs_ifree_cluster

Kaixu Xia (2):
      xfs: remove unnecessary ternary from xfs_create
      xfs: remove redundant variable assignment in xfs_symlink()

 fs/xfs/libxfs/xfs_sb.c  |  32 +++++
 fs/xfs/xfs_buf.c        |  11 +-
 fs/xfs/xfs_dquot.c      |   6 +-
 fs/xfs/xfs_dquot_item.c |   3 +-
 fs/xfs/xfs_export.c     |  14 +-
 fs/xfs/xfs_file.c       |  16 +--
 fs/xfs/xfs_inode.c      | 174 +++++++++++++---------
 fs/xfs/xfs_inode.h      |   1 +
 fs/xfs/xfs_inode_item.c |  31 ++--
 fs/xfs/xfs_log.c        | 372 +++++++++++++++++-------------------------------
 fs/xfs/xfs_log.h        |   4 -
 fs/xfs/xfs_log_cil.c    |  55 +++++--
 fs/xfs/xfs_log_priv.h   |  75 +++++++---
 fs/xfs/xfs_mount.h      |   1 +
 fs/xfs/xfs_qm.c         |  14 +-
 fs/xfs/xfs_super.c      |  17 ++-
 fs/xfs/xfs_symlink.c    |   1 -
 fs/xfs/xfs_trace.h      |  15 +-
 fs/xfs/xfs_trans.c      |  27 ++--
 fs/xfs/xfs_trans_ail.c  |  88 +++++++-----
 fs/xfs/xfs_trans_priv.h |   6 +-
 21 files changed, 512 insertions(+), 451 deletions(-)
