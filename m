Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE531B4F2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 23:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgDVVVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 17:21:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:52984 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgDVVVk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:21:40 -0400
IronPort-SDR: JDomRbgix9iKutkNnZLHtNqsOTUrg2K7+BatWP9W5RlOqYpGqXvGKKc040L9bIUzr/k6aVUSMe
 3Y7SyU3wg5jg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 14:21:39 -0700
IronPort-SDR: 3bM60BJqr85vvJ4b/Fd5uhcvs/V6BFc/zGkBMqkRjkZdX+iNEYJLg5/uFunweShe6bKW6OFdHg
 RyZwYysMDOhw==
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="301031017"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 14:21:38 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH V10 09/11] fs: Lift XFS_IDONTCACHE to the VFS layer
Date:   Wed, 22 Apr 2020 14:21:00 -0700
Message-Id: <20200422212102.3757660-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200422212102.3757660-1-ira.weiny@intel.com>
References: <20200422212102.3757660-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

DAX effective mode (S_DAX) changes requires inode eviction.

XFS has an advisory flag (XFS_IDONTCACHE) to prevent caching of the
inode if no other additional references are taken.  We lift this flag to
the VFS layer and change the behavior slightly by allowing the flag to
remain even if multiple references are taken.

This will expedite the eviction of inodes to change S_DAX.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V9:
	Fix misspelling in commit subject
	move XFS_IEOFBLOCKS to '9'

Changes from V8:
	Remove XFS_IDONTCACHE
---
 fs/xfs/xfs_icache.c | 4 ++--
 fs/xfs/xfs_inode.h  | 3 +--
 fs/xfs/xfs_super.c  | 2 +-
 include/linux/fs.h  | 6 +++++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 17a0b86fe701..de76f7f60695 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -477,7 +477,7 @@ xfs_iget_cache_hit(
 		xfs_ilock(ip, lock_flags);
 
 	if (!(flags & XFS_IGET_INCORE))
-		xfs_iflags_clear(ip, XFS_ISTALE | XFS_IDONTCACHE);
+		xfs_iflags_clear(ip, XFS_ISTALE);
 	XFS_STATS_INC(mp, xs_ig_found);
 
 	return 0;
@@ -559,7 +559,7 @@ xfs_iget_cache_miss(
 	 */
 	iflags = XFS_INEW;
 	if (flags & XFS_IGET_DONTCACHE)
-		iflags |= XFS_IDONTCACHE;
+		VFS_I(ip)->i_state |= I_DONTCACHE;
 	ip->i_udquot = NULL;
 	ip->i_gdquot = NULL;
 	ip->i_pdquot = NULL;
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 83073c883fbf..d8ce3eaa246e 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -218,8 +218,7 @@ static inline bool xfs_inode_has_cow_data(struct xfs_inode *ip)
 #define XFS_IFLOCK		(1 << __XFS_IFLOCK_BIT)
 #define __XFS_IPINNED_BIT	8	 /* wakeup key for zero pin count */
 #define XFS_IPINNED		(1 << __XFS_IPINNED_BIT)
-#define XFS_IDONTCACHE		(1 << 9) /* don't cache the inode long term */
-#define XFS_IEOFBLOCKS		(1 << 10)/* has the preallocblocks tag set */
+#define XFS_IEOFBLOCKS		(1 << 9) /* has the preallocblocks tag set */
 /*
  * If this unlinked inode is in the middle of recovery, don't let drop_inode
  * truncate and free the inode.  This can happen if we iget the inode during
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index a4028992b789..284ab186798c 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -740,7 +740,7 @@ xfs_fs_drop_inode(
 		return 0;
 	}
 
-	return generic_drop_inode(inode) || (ip->i_flags & XFS_IDONTCACHE);
+	return generic_drop_inode(inode);
 }
 
 static void
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a87cc5845a02..44bd45af760f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2156,6 +2156,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *
  * I_CREATING		New object's inode in the middle of setting up.
  *
+ * I_DONTCACHE		Evict inode as soon as it is not used anymore.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2178,6 +2180,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_WB_SWITCH		(1 << 13)
 #define I_OVL_INUSE		(1 << 14)
 #define I_CREATING		(1 << 15)
+#define I_DONTCACHE		(1 << 16)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
@@ -3049,7 +3052,8 @@ extern int inode_needs_sync(struct inode *inode);
 extern int generic_delete_inode(struct inode *inode);
 static inline int generic_drop_inode(struct inode *inode)
 {
-	return !inode->i_nlink || inode_unhashed(inode);
+	return !inode->i_nlink || inode_unhashed(inode) ||
+		(inode->i_state & I_DONTCACHE);
 }
 
 extern struct inode *ilookup5_nowait(struct super_block *sb,
-- 
2.25.1

