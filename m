Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569801A9388
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 08:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635011AbgDOGqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 02:46:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:21756 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634963AbgDOGpm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:45:42 -0400
IronPort-SDR: Ti/gLW04uzxuEDdmIfUM0pDEa/Q96hu7i9tkF/KuHtYMsTP7MuyVE1ggiGSZrAKVR2iNqs0K//
 s3FNlGwuXTXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 23:45:41 -0700
IronPort-SDR: meDbPnYHnawnM5CRSIMJnVXkGzjNZlVB1YKzuHRAQvu6g+oOQhno9/fZDNwEyJ9fUXgCcPNee4
 CjwOFm/qdXYg==
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="245617315"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 23:45:41 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V8 09/11] fs: Introduce DCACHE_DONTCACHE
Date:   Tue, 14 Apr 2020 23:45:21 -0700
Message-Id: <20200415064523.2244712-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415064523.2244712-1-ira.weiny@intel.com>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

DCACHE_DONTCACHE indicates a dentry should not be cached on final
dput().

Also add a helper function which will flag I_DONTCACHE as well ad
DCACHE_DONTCACHE on all dentries point to a specified inode.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V7:
	new patch
---
 fs/dcache.c            |  4 ++++
 fs/inode.c             | 15 +++++++++++++++
 include/linux/dcache.h |  2 ++
 include/linux/fs.h     |  1 +
 4 files changed, 22 insertions(+)

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
index 93d9252a00ab..b8b1917a324e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1526,6 +1526,21 @@ int generic_delete_inode(struct inode *inode)
 }
 EXPORT_SYMBOL(generic_delete_inode);
 
+void flag_inode_dontcache(struct inode *inode)
+{
+	struct dentry *dent;
+
+	rcu_read_lock();
+	hlist_for_each_entry(dent, &inode->i_dentry, d_u.d_alias) {
+		spin_lock(&dent->d_lock);
+		dent->d_flags |= DCACHE_DONTCACHE;
+		spin_unlock(&dent->d_lock);
+	}
+	rcu_read_unlock();
+	inode->i_state |= I_DONTCACHE;
+}
+EXPORT_SYMBOL(flag_inode_dontcache);
+
 /*
  * Called when we're dropping the last reference
  * to an inode.
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
index e2db71d150c3..f2916c99616a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3048,6 +3048,7 @@ static inline int generic_drop_inode(struct inode *inode)
 	return !inode->i_nlink || inode_unhashed(inode) ||
 		(inode->i_state & I_DONTCACHE);
 }
+extern void flag_inode_dontcache(struct inode *inode);
 
 extern struct inode *ilookup5_nowait(struct super_block *sb,
 		unsigned long hashval, int (*test)(struct inode *, void *),
-- 
2.25.1

