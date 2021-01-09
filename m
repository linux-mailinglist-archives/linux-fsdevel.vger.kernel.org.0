Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91872EFE6B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 09:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbhAIIAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 03:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbhAIIAY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:00:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4A01238E8;
        Sat,  9 Jan 2021 07:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610179183;
        bh=ACg45O7fwl+jjbSXOKOgmB8S7GJDMNFMcVb39xwXyqc=;
        h=From:To:Cc:Subject:Date:From;
        b=FUWwrKFxWbAldpKEGaeqArDF0GOisvWQyMA+9vwJkP4Bic2Uq485vNk3j8Xmtjzlu
         4w/JNw6y22kZM6y+CvSS2vYHcsLC/LJ/N3mrIpb2Q0SsiAvgn/0KYmchTVoOf6aJAq
         8vjVL2EEds2Iu/85xLzmecooyeyTMqUVpiZ/381FY3dgeNMe2M1GbuYGZp6wa0eIx6
         /e8aOB7P2P1kY2v/z4a32ovGbtqrFPUp1xeZ/NvOuu+tbD6FOvKAC920ny3Z1ky7mV
         RKnk6udMZy//aHEjWPnP6Lze4YLCscFq1/SlorEcOsou3Pl0TSpc+j2oHB51vPRerl
         BcgHHVXXR3CVw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 00/12] lazytime fix and cleanups
Date:   Fri,  8 Jan 2021 23:58:51 -0800
Message-Id: <20210109075903.208222-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Patch 1 fixes a bug in how __writeback_single_inode() handles lazytime
expirations.  I originally reported this last year
(https://lore.kernel.org/r/20200306004555.GB225345@gmail.com) because it
causes the FS_IOC_REMOVE_ENCRYPTION_KEY ioctl to not work properly, as
the bug causes inodes to remain dirty after a sync.

It also turns out that lazytime on XFS is partially broken because it
doesn't actually write timestamps to disk after a sync() or after
dirtytime_expire_interval.  This is fixed by the same fix.

This supersedes previously proposed fixes, including
https://lore.kernel.org/r/20200307020043.60118-1-tytso@mit.edu and
https://lore.kernel.org/r/20200325122825.1086872-3-hch@lst.de from last
year (which had some issues and didn't fix the XFS bug), and v1 of this
patchset which took a different approach
(https://lore.kernel.org/r/20210105005452.92521-1-ebiggers@kernel.org).

Patches 2-12 then clean up various things related to lazytime and
writeback, such as clarifying the semantics of ->dirty_inode() and the
inode dirty flags, and improving comments.  Most of these patches could
be applied independently if needed.

This patchset applies to v5.11-rc2.

Changed since v1:
  - Switched to the fix suggested by Jan Kara, and dropped the
    patches which introduced ->lazytime_expired().
  - Fixed bugs in the fat and ext4 patches.
  - Added patch "fs: improve comments for writeback_single_inode()".
  - Reordered the patches a bit.
  - Added Reviewed-by's.

Eric Biggers (12):
  fs: fix lazytime expiration handling in __writeback_single_inode()
  fs: correctly document the inode dirty flags
  fs: only specify I_DIRTY_TIME when needed in generic_update_time()
  fat: only specify I_DIRTY_TIME when needed in fat_update_time()
  fs: don't call ->dirty_inode for lazytime timestamp updates
  fs: pass only I_DIRTY_INODE flags to ->dirty_inode
  fs: clean up __mark_inode_dirty() a bit
  fs: drop redundant check from __writeback_single_inode()
  fs: improve comments for writeback_single_inode()
  gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()
  ext4: simplify i_state checks in __ext4_update_other_inode_time()
  xfs: remove a stale comment from xfs_file_aio_write_checks()

 Documentation/filesystems/vfs.rst |   5 +-
 fs/ext4/inode.c                   |  20 +----
 fs/f2fs/super.c                   |   3 -
 fs/fat/misc.c                     |  23 +++---
 fs/fs-writeback.c                 | 132 +++++++++++++++++-------------
 fs/gfs2/file.c                    |   4 +-
 fs/gfs2/super.c                   |   2 -
 fs/inode.c                        |  38 +++++----
 fs/xfs/xfs_file.c                 |   6 --
 include/linux/fs.h                |  18 ++--
 10 files changed, 132 insertions(+), 119 deletions(-)


base-commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
-- 
2.30.0

