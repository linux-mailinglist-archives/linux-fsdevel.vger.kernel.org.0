Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B339DF78
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhFGOyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 10:54:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51640 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhFGOyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:54:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D28CC1FDD2;
        Mon,  7 Jun 2021 14:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623077557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YK8GEJCDKjq8m4s9mPl+Cr6kVFf/7XBXLx1QgmSt22Q=;
        b=ZPlrCJN1Q+nMRsgZETbRrkJxtgOotDXgTM7o/Tu5h0Gr8bAQMMOWm9ywdBWCrBwAI7CZji
        XQ89VbYq6IO3nzIgL5B3Uyh2skJ78mL6D0ufMj4PSXgd24UOChI0BchwDit/Ibjypzxjl7
        YB3X8fXTW/lTTi+z7pDiySNk0P53K8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623077557;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YK8GEJCDKjq8m4s9mPl+Cr6kVFf/7XBXLx1QgmSt22Q=;
        b=SxBYwXZ92n/WdiLGzzzCaCsIzOkITvUlxhfnTWU+AtfUWr6eqleklDVqDXiKoJuS5uohUU
        u91Krl7ddNuSAXCA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B2199A3B8E;
        Mon,  7 Jun 2021 14:52:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A28761F2CB6; Mon,  7 Jun 2021 16:52:36 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Reichl <preichl@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH 07/14] xfs: Refactor xfs_isilocked()
Date:   Mon,  7 Jun 2021 16:52:17 +0200
Message-Id: <20210607145236.31852-7-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210607144631.8717-1-jack@suse.cz>
References: <20210607144631.8717-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4097; i=jack@suse.cz; h=from:subject; bh=EyWkjLzMxBvucK3cTjl3wByc8CRPjLl12F487VSLK9k=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGBL2GS2sPKKyPeulwoHnToySDLXdc5y83cKnpbv1c6xXNbp3 WO1SJ6MxCwMjB4OsmCLL6siL2tfmGXVtDdWQgRnEygQyhYGLUwAmElzK/k99C/OZUBGvGTm+bpWfZo W7yKq6BCfnG6l6VHLy3Wp+EbSn0t6ds1F+hWD105TVc+6WbF0VtfLdzeNapxayi29dfnhaT9fJ/pnT BFMP+LPdFci78DnbR+V0RM/Tts8fpi2al+LWuPul1OtWVwPllpvT/h1/U3Xc3jciaJa0LytvV2PxJ/ fDP03yKioVHk/uteHTv5ya1WhiEJvu3axd9nmHtA7DNckdh+1NubaWqnOGrZvayXzmaa5K0+tnxnHu fsWd617V/Ij1OczrefPUAweFJtGSQrG7C3YVO65x//t5h99p7z2F/wNkfj2cvLfxp8CG7SuCXlpdqD uQdn3HYzE5Tx/jGUskWUViuRLCAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pavel Reichl <preichl@redhat.com>

Refactor xfs_isilocked() to use newly introduced __xfs_rwsem_islocked().
__xfs_rwsem_islocked() is a helper function which encapsulates checking
state of rw_semaphores hold by inode.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
Suggested-by: Dave Chinner <dchinner@redhat.com>
Suggested-by: Eric Sandeen <sandeen@redhat.com>
Suggested-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_inode.c | 39 +++++++++++++++++++++++++++++++--------
 fs/xfs/xfs_inode.h | 21 ++++++++++++++-------
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 0369eb22c1bb..6247977870bd 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -342,9 +342,34 @@ xfs_ilock_demote(
 }
 
 #if defined(DEBUG) || defined(XFS_WARN)
-int
+static inline bool
+__xfs_rwsem_islocked(
+	struct rw_semaphore	*rwsem,
+	int			lock_flags,
+	int			shift)
+{
+	lock_flags >>= shift;
+
+	if (!debug_locks)
+		return rwsem_is_locked(rwsem);
+	/*
+	 * If the shared flag is not set, pass 0 to explicitly check for
+	 * exclusive access to the lock. If the shared flag is set, we typically
+	 * want to make sure the lock is at least held in shared mode
+	 * (i.e., shared | excl) but we don't necessarily care that it might
+	 * actually be held exclusive. Therefore, pass -1 to check whether the
+	 * lock is held in any mode rather than one of the explicit shared mode
+	 * values (1 or 2)."
+	 */
+	if (lock_flags & (1 << XFS_SHARED_LOCK_SHIFT)) {
+		return lockdep_is_held_type(rwsem, -1);
+	}
+	return lockdep_is_held_type(rwsem, 0);
+}
+
+bool
 xfs_isilocked(
-	xfs_inode_t		*ip,
+	struct xfs_inode	*ip,
 	uint			lock_flags)
 {
 	if (lock_flags & (XFS_ILOCK_EXCL|XFS_ILOCK_SHARED)) {
@@ -359,15 +384,13 @@ xfs_isilocked(
 		return rwsem_is_locked(&ip->i_mmaplock.mr_lock);
 	}
 
-	if (lock_flags & (XFS_IOLOCK_EXCL|XFS_IOLOCK_SHARED)) {
-		if (!(lock_flags & XFS_IOLOCK_SHARED))
-			return !debug_locks ||
-				lockdep_is_held_type(&VFS_I(ip)->i_rwsem, 0);
-		return rwsem_is_locked(&VFS_I(ip)->i_rwsem);
+	if (lock_flags & (XFS_IOLOCK_EXCL | XFS_IOLOCK_SHARED)) {
+		return __xfs_rwsem_islocked(&VFS_I(ip)->i_rwsem, lock_flags,
+				XFS_IOLOCK_FLAG_SHIFT);
 	}
 
 	ASSERT(0);
-	return 0;
+	return false;
 }
 #endif
 
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index ca826cfba91c..1c0e15c480bc 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -262,12 +262,19 @@ static inline bool xfs_inode_has_bigtime(struct xfs_inode *ip)
  * Bit ranges:	1<<1  - 1<<16-1 -- iolock/ilock modes (bitfield)
  *		1<<16 - 1<<32-1 -- lockdep annotation (integers)
  */
-#define	XFS_IOLOCK_EXCL		(1<<0)
-#define	XFS_IOLOCK_SHARED	(1<<1)
-#define	XFS_ILOCK_EXCL		(1<<2)
-#define	XFS_ILOCK_SHARED	(1<<3)
-#define	XFS_MMAPLOCK_EXCL	(1<<4)
-#define	XFS_MMAPLOCK_SHARED	(1<<5)
+
+#define XFS_IOLOCK_FLAG_SHIFT	0
+#define XFS_ILOCK_FLAG_SHIFT	2
+#define XFS_MMAPLOCK_FLAG_SHIFT	4
+
+#define XFS_SHARED_LOCK_SHIFT	1
+
+#define XFS_IOLOCK_EXCL		(1 << XFS_IOLOCK_FLAG_SHIFT)
+#define XFS_IOLOCK_SHARED	(XFS_IOLOCK_EXCL << XFS_SHARED_LOCK_SHIFT)
+#define XFS_ILOCK_EXCL		(1 << XFS_ILOCK_FLAG_SHIFT)
+#define XFS_ILOCK_SHARED	(XFS_ILOCK_EXCL << XFS_SHARED_LOCK_SHIFT)
+#define XFS_MMAPLOCK_EXCL	(1 << XFS_MMAPLOCK_FLAG_SHIFT)
+#define XFS_MMAPLOCK_SHARED	(XFS_MMAPLOCK_EXCL << XFS_SHARED_LOCK_SHIFT)
 
 #define XFS_LOCK_MASK		(XFS_IOLOCK_EXCL | XFS_IOLOCK_SHARED \
 				| XFS_ILOCK_EXCL | XFS_ILOCK_SHARED \
@@ -410,7 +417,7 @@ void		xfs_ilock(xfs_inode_t *, uint);
 int		xfs_ilock_nowait(xfs_inode_t *, uint);
 void		xfs_iunlock(xfs_inode_t *, uint);
 void		xfs_ilock_demote(xfs_inode_t *, uint);
-int		xfs_isilocked(xfs_inode_t *, uint);
+bool		xfs_isilocked(struct xfs_inode *, uint);
 uint		xfs_ilock_data_map_shared(struct xfs_inode *);
 uint		xfs_ilock_attr_map_shared(struct xfs_inode *);
 
-- 
2.26.2

