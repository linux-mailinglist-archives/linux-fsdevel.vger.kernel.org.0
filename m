Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FE0302CB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 21:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbhAYUjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 15:39:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732362AbhAYUik (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:38:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91CB422583;
        Mon, 25 Jan 2021 20:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611607079;
        bh=IOywRg3GDIp5qw973MK7y5yXs1Lb3QGx/m0aTLci+8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUUf1umrvsvzEnHLD/If2qEqPV3xkaCUiDrTJ27zAd114SH+48jmUsmGHzymQiiXm
         ukYaLN4oVDgPPO2RweaQBFYPjRzT/IFsXvtbmxVSPt4QQAbKfuStOiGhS9yVa3U4rR
         Udf4CdHMI6/nsXQf5exMGG1+ALo8HK4qITS6Ff4w6XQWnxPdslzFuICvzbZR9JQN14
         jnUbHZDX4Ay9LbWSV9cEHsT3Q9gk4IWCmhjICJ4qEWjw079ITpOOhImXmLDAY3tUHq
         A5AlmoRGyqwzmoupzoeBhrtVNpcRAU63qarMfz9TCy1rnthYFYQAEAR90uxHBqqDR6
         k6NxIuWuduJiQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.14 3/3] fs: fix lazytime expiration handling in __writeback_single_inode()
Date:   Mon, 25 Jan 2021 12:37:44 -0800
Message-Id: <20210125203744.325479-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125203744.325479-1-ebiggers@kernel.org>
References: <20210125203744.325479-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 1e249cb5b7fc09ff216aa5a12f6c302e434e88f9 upstream.

When lazytime is enabled and an inode is being written due to its
in-memory updated timestamps having expired, either due to a sync() or
syncfs() system call or due to dirtytime_expire_interval having elapsed,
the VFS needs to inform the filesystem so that the filesystem can copy
the inode's timestamps out to the on-disk data structures.

This is done by __writeback_single_inode() calling
mark_inode_dirty_sync(), which then calls ->dirty_inode(I_DIRTY_SYNC).

However, this occurs after __writeback_single_inode() has already
cleared the dirty flags from ->i_state.  This causes two bugs:

- mark_inode_dirty_sync() redirties the inode, causing it to remain
  dirty.  This wastefully causes the inode to be written twice.  But
  more importantly, it breaks cases where sync_filesystem() is expected
  to clean dirty inodes.  This includes the FS_IOC_REMOVE_ENCRYPTION_KEY
  ioctl (as reported at
  https://lore.kernel.org/r/20200306004555.GB225345@gmail.com), as well
  as possibly filesystem freezing (freeze_super()).

- Since ->i_state doesn't contain I_DIRTY_TIME when ->dirty_inode() is
  called from __writeback_single_inode() for lazytime expiration,
  xfs_fs_dirty_inode() ignores the notification.  (XFS only cares about
  lazytime expirations, and it assumes that i_state will contain
  I_DIRTY_TIME during those.)  Therefore, lazy timestamps aren't
  persisted by sync(), syncfs(), or dirtytime_expire_interval on XFS.

Fix this by moving the call to mark_inode_dirty_sync() to earlier in
__writeback_single_inode(), before the dirty flags are cleared from
i_state.  This makes filesystems be properly notified of the timestamp
expiration, and it avoids incorrectly redirtying the inode.

This fixes xfstest generic/580 (which tests
FS_IOC_REMOVE_ENCRYPTION_KEY) when run on ext4 or f2fs with lazytime
enabled.  It also fixes the new lazytime xfstest I've proposed, which
reproduces the above-mentioned XFS bug
(https://lore.kernel.org/r/20210105005818.92978-1-ebiggers@kernel.org).

Alternatively, we could call ->dirty_inode(I_DIRTY_SYNC) directly.  But
due to the introduction of I_SYNC_QUEUED, mark_inode_dirty_sync() is the
right thing to do because mark_inode_dirty_sync() now knows not to move
the inode to a writeback list if it is currently queued for sync.

Fixes: 0ae45f63d4ef ("vfs: add support for a lazytime mount option")
Cc: stable@vger.kernel.org
Depends-on: 5afced3bf281 ("writeback: Avoid skipping inode writeback")
Link: https://lore.kernel.org/r/20210112190253.64307-2-ebiggers@kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index d6c05e5bdacb8..384f95e1936dd 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1390,21 +1390,25 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	}
 
 	/*
-	 * Some filesystems may redirty the inode during the writeback
-	 * due to delalloc, clear dirty metadata flags right before
-	 * write_inode()
+	 * If the inode has dirty timestamps and we need to write them, call
+	 * mark_inode_dirty_sync() to notify the filesystem about it and to
+	 * change I_DIRTY_TIME into I_DIRTY_SYNC.
 	 */
-	spin_lock(&inode->i_lock);
-
-	dirty = inode->i_state & I_DIRTY;
 	if ((inode->i_state & I_DIRTY_TIME) &&
-	    ((dirty & I_DIRTY_INODE) ||
-	     wbc->sync_mode == WB_SYNC_ALL || wbc->for_sync ||
+	    (wbc->sync_mode == WB_SYNC_ALL || wbc->for_sync ||
 	     time_after(jiffies, inode->dirtied_time_when +
 			dirtytime_expire_interval * HZ))) {
-		dirty |= I_DIRTY_TIME;
 		trace_writeback_lazytime(inode);
+		mark_inode_dirty_sync(inode);
 	}
+
+	/*
+	 * Some filesystems may redirty the inode during the writeback
+	 * due to delalloc, clear dirty metadata flags right before
+	 * write_inode()
+	 */
+	spin_lock(&inode->i_lock);
+	dirty = inode->i_state & I_DIRTY;
 	inode->i_state &= ~dirty;
 
 	/*
@@ -1425,8 +1429,6 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 
 	spin_unlock(&inode->i_lock);
 
-	if (dirty & I_DIRTY_TIME)
-		mark_inode_dirty_sync(inode);
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & ~I_DIRTY_PAGES) {
 		int err = write_inode(inode, wbc);
-- 
2.30.0

