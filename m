Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E8E1B300E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 21:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgDUTSZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 15:18:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:19838 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgDUTSY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:18:24 -0400
IronPort-SDR: YU+7OQEZIXKfrzygRjua9kMpZgL1zVXCHfDAvslxumuN0lpkYukO/WY2ZH+yxgIBtlhtoKzdxq
 10vHkPRHuGCA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 12:18:23 -0700
IronPort-SDR: +OjMAxDgmar/78i1djgo8FxMwbwvsDoESINy54OQVeQ6gss80DNTaqya8f6AHh5wOurPpaQOLt
 62XIg0Fot4UQ==
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="456219116"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 12:18:23 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V9 09/11] fs: Introduce DCACHE_DONTCACHE
Date:   Tue, 21 Apr 2020 12:17:51 -0700
Message-Id: <20200421191754.3372370-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200421191754.3372370-1-ira.weiny@intel.com>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

DCACHE_DONTCACHE indicates a dentry should not be cached on final
dput().

Also add a helper function to mark DCACHE_DONTCACHE on all dentries
pointing to a specific inode when that inode is being set I_DONTCACHE.

This facilitates dropping dentry references to inodes sooner which
require eviction to swap S_DAX mode.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V8:
	Update commit message
	Use mark_inode_dontcache in XFS
	Fix locking...  can't use rcu here.
	Change name to mark_inode_dontcache
---
 fs/dcache.c            |  4 ++++
 fs/inode.c             | 15 +++++++++++++++
 fs/xfs/xfs_icache.c    |  2 +-
 include/linux/dcache.h |  2 ++
 include/linux/fs.h     |  1 +
 5 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b280e07e162b..0030fabab2c4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -647,6 +647,10 @@ static inline bool retain_dentry(struct dentry *dentry)
 		if (dentry->d_op->d_delete(dentry))
 			return false;
 	}
+
+	if (unlikely(dentry->d_flags & DCACHE_DONTCACHE))
+		return false;
+
 	/* retain; LRU fodder */
 	dentry->d_lockref.count--;
 	if (unlikely(!(dentry->d_flags & DCACHE_LRU_LIST)))
diff --git a/fs/inode.c b/fs/inode.c
index 93d9252a00ab..da7f3c4926cd 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1526,6 +1526,21 @@ int generic_delete_inode(struct inode *inode)
 }
 EXPORT_SYMBOL(generic_delete_inode);
 
+void mark_inode_dontcache(struct inode *inode)
+{
+	struct dentry *de;
+
+	spin_lock(&inode->i_lock);
+	hlist_for_each_entry(de, &inode->i_dentry, d_u.d_alias) {
+		spin_lock(&de->d_lock);
+		de->d_flags |= DCACHE_DONTCACHE;
+		spin_unlock(&de->d_lock);
+	}
+	spin_unlock(&inode->i_lock);
+	inode->i_state |= I_DONTCACHE;
+}
+EXPORT_SYMBOL(mark_inode_dontcache);
+
 /*
  * Called when we're dropping the last reference
  * to an inode.
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index de76f7f60695..3c8f44477804 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -559,7 +559,7 @@ xfs_iget_cache_miss(
 	 */
 	iflags = XFS_INEW;
 	if (flags & XFS_IGET_DONTCACHE)
-		VFS_I(ip)->i_state |= I_DONTCACHE;
+		mark_inode_dontcache(VFS_I(ip));
 	ip->i_udquot = NULL;
 	ip->i_gdquot = NULL;
 	ip->i_pdquot = NULL;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c1488cc84fd9..56b1482d9223 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -177,6 +177,8 @@ struct dentry_operations {
 
 #define DCACHE_REFERENCED		0x00000040 /* Recently used, don't discard. */
 
+#define DCACHE_DONTCACHE		0x00000080 /* don't cache on final dput() */
+
 #define DCACHE_CANT_MOUNT		0x00000100
 #define DCACHE_GENOCIDE			0x00000200
 #define DCACHE_SHRINK_LIST		0x00000400
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 44bd45af760f..064168ec2e0b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3055,6 +3055,7 @@ static inline int generic_drop_inode(struct inode *inode)
 	return !inode->i_nlink || inode_unhashed(inode) ||
 		(inode->i_state & I_DONTCACHE);
 }
+extern void mark_inode_dontcache(struct inode *inode);
 
 extern struct inode *ilookup5_nowait(struct super_block *sb,
 		unsigned long hashval, int (*test)(struct inode *, void *),
-- 
2.25.1

