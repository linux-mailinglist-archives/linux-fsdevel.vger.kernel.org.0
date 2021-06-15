Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E283A7A37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 11:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhFOJUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 05:20:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54674 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhFOJUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:20:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3C982219D0;
        Tue, 15 Jun 2021 09:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623748695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJPcNasQsdD4alraw2ySNp9CvXcKAD7eZsBqJbvJG/E=;
        b=mNYsE3Moem4CPgipCoJBVW3pKbWM/RieHW2msBIFTGhF0DkZcz1nTEkMIpUU6UjabKdm0W
        M6mVM1MuYXexKl9goxJrYVfD+Tj4mmSH179+L8f9whj6gJTW9LfV41g3sQXs+Pcg/O4WWi
        7FgLS7vOukNIO2t4r3TRkcs19pHiAsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623748695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJPcNasQsdD4alraw2ySNp9CvXcKAD7eZsBqJbvJG/E=;
        b=diw0cB6TtQrkCRKrb/BOoRn14gZQ/b0qj0myLemQdccLwtuT7qpBMKRtuoiLaD5N0Be4IC
        3HLDqaJki5AW9ODA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 19077A3B84;
        Tue, 15 Jun 2021 09:18:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3D26D1F2CC0; Tue, 15 Jun 2021 11:18:14 +0200 (CEST)
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
        Eric Sandeen <sandeen@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 07/14] xfs: Refactor xfs_isilocked()
Date:   Tue, 15 Jun 2021 11:17:57 +0200
Message-Id: <20210615091814.28626-7-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210615090844.6045-1-jack@suse.cz>
References: <20210615090844.6045-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=jack@suse.cz; h=from:subject; bh=U+bbQrzY4NRNf6bjNug/8v3gG53d1tZPwGQTBPmqTzM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgyHBGb6DDZ1XROYQY0WKzslcvTC5Zc+A/26r5bbgz 3WGOnWOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYMhwRgAKCRCcnaoHP2RA2aRdB/ 9ARdUkK0QlTWiC/gWPnxKJ8Av4wBT4lrAPdR1a5S0uvs+LB+14MAWG84ZF9HIOr0LFDOMd282bJoaJ IseWFk4fqZdzNu3cYmvZzy4dyFh4eGr+1caf0RtF0InMJoGmONPMk/b5o7/Of1f8V1mUn9qDynxzBU wlSqOKQ4+bvxwZ6oJR2Q8PYRCbiS+qwNDWa8t1PFEl1l4ds/PPt0JyhEt11F2sblY2y2RB7/uYWCLv MEpWPPohHUJyO2cUxiHMTfOnJc31j92fbjJ72x/LASoZUIStAazqwBX2/Rx9nUvSddiRuGfZnMdOZJ T06WayHXGk7uGywNCl05BBOH3cZn62
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
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_inode.c | 34 ++++++++++++++++++++++++++--------
 fs/xfs/xfs_inode.h |  2 +-
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index e4c2da4566f1..ffd47217a8fa 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -342,9 +342,29 @@ xfs_ilock_demote(
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
@@ -359,15 +379,13 @@ xfs_isilocked(
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
index ca826cfba91c..4659e1568966 100644
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

