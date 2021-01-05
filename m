Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D342EA1C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 01:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbhAEAzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 19:55:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbhAEAzr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:55:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86D102253A;
        Tue,  5 Jan 2021 00:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609808106;
        bh=vW1bfeQdX9BhgUQwC/CMk7URLM4cDiT6xtDR+MDGdnQ=;
        h=From:To:Cc:Subject:Date:From;
        b=a/rhmmA4Es5Lzendc5wuI1ciHBAOd3gT6tF/EzCaBjP2l0zF5PZ9pojAY3DnXJva0
         DlZuSQHH92CNOdm1BG+JTmpCMMX4k0kVkV1FHaAQk/vjdhcJwrLg/4WvEw5nF8CE/U
         um4gEedPsGkVB7BgrbxccekFmgV24iTBeM7WkWN2/V0eYeepsznEHuToM9UU3qNMEo
         zp+L2h0LtaCb5rS31RmumwRxoe9N7xVg47WtRrCC7USmlmuDxPXAUIelxMCwACy0GR
         xsyQce5EFxzNpw0gczY5F3PhY2Oy33072x40R1SSLLjFCjTaX0tKIkGfigfe/iOgel
         irKjq6A7uNQiw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 00/13] lazytime fixes and cleanups
Date:   Mon,  4 Jan 2021 16:54:39 -0800
Message-Id: <20210105005452.92521-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This patchset fixes the lazytime bug which I reported last year
(https://lore.kernel.org/r/20200306004555.GB225345@gmail.com).  This bug
causes inodes with dirty timestamps to remain dirty after a sync, which
causes the inodes to be unnecessarily written again, and also causes the
FS_IOC_REMOVE_ENCRYPTION_KEY ioctl to not work properly.  This bug is
causing xfstest generic/580 to fail when lazytime is enabled.

Ted and Christoph proposed fixes for this.  Ted's fix
(https://lore.kernel.org/r/20200307020043.60118-1-tytso@mit.edu) changed
the call to mark_inode_dirty_sync(inode) in __writeback_single_inode()
to ->dirty_inode(inode, I_DIRTY_TIME_EXPIRED).  However this would have
broken XFS, which wants an I_DIRTY_SYNC notification.  Also, people
preferred a larger rework involving adding a ->lazytime_expired method.

Christoph's fix
(https://lore.kernel.org/r/20200325122825.1086872-3-hch@lst.de)
introduced ->lazytime_expired, but it wasn't correct because it didn't
consider cases in which timestamps are force-expired.

To resolve this, I propose that we first fix the bug by making
__writeback_single_inode() do an I_DIRTY_SYNC notification if the
timestamps expired (patch #1).

Then, the remaining patches introduce ->lazytime_expired and make XFS
use it.  They also clean up various things, such as improving comments.

Also, it turns out that lazytime on XFS is broken because it doesn't
actually write timestamps to disk after a sync() or after 24 hours.
This is fixed by the patch to switch XFS to use ->lazytime_expired.
I've written an xfstest which reproduces this bug.

This patchset applies to v5.11-rc2.

Eric Biggers (13):
  fs: avoid double-writing inodes on lazytime expiration
  gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()
  fs: only specify I_DIRTY_TIME when needed in generic_update_time()
  fat: only specify I_DIRTY_TIME when needed in fat_update_time()
  fs: don't call ->dirty_inode for lazytime timestamp updates
  fs: pass only I_DIRTY_INODE flags to ->dirty_inode
  fs: correctly document the inode dirty flags
  ext4: simplify i_state checks in __ext4_update_other_inode_time()
  fs: drop redundant checks from __writeback_single_inode()
  fs: clean up __mark_inode_dirty() a bit
  fs: add a lazytime_expired method
  xfs: remove a stale comment from xfs_file_aio_write_checks()
  xfs: implement lazytime_expired

 Documentation/filesystems/locking.rst |  2 +
 Documentation/filesystems/vfs.rst     | 15 ++++-
 fs/ext4/inode.c                       | 20 ++----
 fs/f2fs/super.c                       |  3 -
 fs/fat/misc.c                         | 21 +++---
 fs/fs-writeback.c                     | 94 +++++++++++++++++++--------
 fs/gfs2/file.c                        |  4 +-
 fs/gfs2/super.c                       |  2 -
 fs/inode.c                            | 40 ++++++------
 fs/sync.c                             |  2 +-
 fs/xfs/xfs_file.c                     |  6 --
 fs/xfs/xfs_super.c                    | 12 +---
 include/linux/fs.h                    | 25 +++++--
 13 files changed, 143 insertions(+), 103 deletions(-)


base-commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
-- 
2.30.0

