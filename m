Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BFE3C9FBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 15:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbhGONnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 09:43:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55808 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbhGONnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:43:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C7E422A7C;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626356433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UrWJRrmmZoeFsiXlatgXAwopNmimQ93wkzrLwvaNN0=;
        b=Vq6zyVi+TmKxjG4E2bDVHqilU05s3T3gkdYPFN9QWrpWbR+GxR6RlxitkuKJ3wa9JjXBuW
        B4Yb9uaFht7dlYpcJNWLyjXhvkw+6KOQKSuP6DeYLOKvo1MNYISBdsLoRQdzI81/UdPhqM
        I2TTzsRXYlE9ba20mfbsmM5cP1F37sQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626356433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UrWJRrmmZoeFsiXlatgXAwopNmimQ93wkzrLwvaNN0=;
        b=vPvQaBLdn4nF8xM+5K5KEGC/ouomYZFRiTn6m+gZfuSx9Er+5mBus+S5jB9AEbFudY6Ula
        sWwkbcKSe2BV1QBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 680CEA3B9D;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1B42A1E0C05; Thu, 15 Jul 2021 15:40:33 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Pavel Reichl <preichl@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH 07/14] xfs: Refactor xfs_isilocked()
Date:   Thu, 15 Jul 2021 15:40:17 +0200
Message-Id: <20210715134032.24868-7-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210715133202.5975-1-jack@suse.cz>
References: <20210715133202.5975-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2663; i=jack@suse.cz; h=from:subject; bh=YmQSkQse9NO9b0qrNLfWFR/SLfIwnVnRgr/nYQ5R0lY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg8DrBhJIq6dexPtRN0mRaJPDIgpTC8p8HxaHKF5yv BEL61CyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYPA6wQAKCRCcnaoHP2RA2UAQB/ 9rg5NL72FfnXClKh6c0yAIPqCwy+FeNY+kyI9sfxL6MLpfwdAKEG051FlsOzEbC57n9xult0L9NK+a SKIpZNIXKtzDo1mJnXVzFit3q9KrWSykWOR2A6XKyL5yrPuZOQbSj9//39Vukg1Xi9tKW0rln8dsKl DlCCZLnN/Tqou0F0alPiI5z8Ydvx8yvtmYqYg4v+IwtaPWIClc9Cye80/06rUdQ6x12dW0niqMs6zh BJy9iasKMKa4aQ57hQGrUMn05CUfnZVD9qSJnCAMDnJ2aj/BtR1MSwl+UelmZE8EN0xnhbB9RfyV41 3mXYwJHybMymKmoj5OERJOjQ2/asDD
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pavel Reichl <preichl@redhat.com>

Introduce a new __xfs_rwsem_islocked predicate to encapsulate checking
the state of a rw_semaphore, then refactor xfs_isilocked to use it.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
Suggested-by: Dave Chinner <dchinner@redhat.com>
Suggested-by: Eric Sandeen <sandeen@redhat.com>
Suggested-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_inode.c | 34 ++++++++++++++++++++++++++--------
 fs/xfs/xfs_inode.h |  2 +-
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index a835ceb79ba5..359e2cd44ad7 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -343,9 +343,29 @@ xfs_ilock_demote(
 }
 
 #if defined(DEBUG) || defined(XFS_WARN)
-int
+static inline bool
+__xfs_rwsem_islocked(
+	struct rw_semaphore	*rwsem,
+	bool			shared)
+{
+	if (!debug_locks)
+		return rwsem_is_locked(rwsem);
+
+	if (!shared)
+		return lockdep_is_held_type(rwsem, 0);
+
+	/*
+	 * We are checking that the lock is held at least in shared
+	 * mode but don't care that it might be held exclusively
+	 * (i.e. shared | excl). Hence we check if the lock is held
+	 * in any mode rather than an explicit shared mode.
+	 */
+	return lockdep_is_held_type(rwsem, -1);
+}
+
+bool
 xfs_isilocked(
-	xfs_inode_t		*ip,
+	struct xfs_inode	*ip,
 	uint			lock_flags)
 {
 	if (lock_flags & (XFS_ILOCK_EXCL|XFS_ILOCK_SHARED)) {
@@ -360,15 +380,13 @@ xfs_isilocked(
 		return rwsem_is_locked(&ip->i_mmaplock.mr_lock);
 	}
 
-	if (lock_flags & (XFS_IOLOCK_EXCL|XFS_IOLOCK_SHARED)) {
-		if (!(lock_flags & XFS_IOLOCK_SHARED))
-			return !debug_locks ||
-				lockdep_is_held_type(&VFS_I(ip)->i_rwsem, 0);
-		return rwsem_is_locked(&VFS_I(ip)->i_rwsem);
+	if (lock_flags & (XFS_IOLOCK_EXCL | XFS_IOLOCK_SHARED)) {
+		return __xfs_rwsem_islocked(&VFS_I(ip)->i_rwsem,
+				(lock_flags & XFS_IOLOCK_SHARED));
 	}
 
 	ASSERT(0);
-	return 0;
+	return false;
 }
 #endif
 
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 4b6703dbffb8..4b5202ae8ebb 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -410,7 +410,7 @@ void		xfs_ilock(xfs_inode_t *, uint);
 int		xfs_ilock_nowait(xfs_inode_t *, uint);
 void		xfs_iunlock(xfs_inode_t *, uint);
 void		xfs_ilock_demote(xfs_inode_t *, uint);
-int		xfs_isilocked(xfs_inode_t *, uint);
+bool		xfs_isilocked(struct xfs_inode *, uint);
 uint		xfs_ilock_data_map_shared(struct xfs_inode *);
 uint		xfs_ilock_attr_map_shared(struct xfs_inode *);
 
-- 
2.26.2

