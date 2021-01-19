Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF2B2FC00E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 20:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbhASTcW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 14:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbhASTZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:25:40 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CACC061573;
        Tue, 19 Jan 2021 11:25:00 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id AEA2E6C0D; Tue, 19 Jan 2021 14:24:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org AEA2E6C0D
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/3] nfsd: move change attribute generation to filesystem
Date:   Tue, 19 Jan 2021 14:24:56 -0500
Message-Id: <1611084297-27352-3-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611084297-27352-1-git-send-email-bfields@redhat.com>
References: <1611084297-27352-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

After this, only filesystems lacking change attribute support will leave
the fetch_iversion export op NULL.

This seems cleaner to me, and will allow some minor optimizations in the
nfsd code.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/btrfs/export.c        |  2 ++
 fs/ext4/super.c          |  9 +++++++++
 fs/nfsd/nfsfh.h          | 25 +++----------------------
 fs/xfs/xfs_export.c      | 10 ++++++++++
 include/linux/iversion.h | 26 ++++++++++++++++++++++++++
 5 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 1d4c2397d0d6..9f9fe24b29cc 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -7,6 +7,7 @@
 #include "btrfs_inode.h"
 #include "print-tree.h"
 #include "export.h"
+#include <linux/iversion.h>
 
 #define BTRFS_FID_SIZE_NON_CONNECTABLE (offsetof(struct btrfs_fid, \
 						 parent_objectid) / 4)
@@ -278,4 +279,5 @@ const struct export_operations btrfs_export_ops = {
 	.fh_to_parent	= btrfs_fh_to_parent,
 	.get_parent	= btrfs_get_parent,
 	.get_name	= btrfs_get_name,
+	.fetch_iversion	= generic_fetch_iversion,
 };
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 21121787c874..4a37b7fc55b6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1616,11 +1616,20 @@ static const struct super_operations ext4_sops = {
 	.bdev_try_to_free_page = bdev_try_to_free_page,
 };
 
+static u64 ext4_fetch_iversion(struct inode *inode)
+{
+	if (IS_I_VERSION(inode))
+		return generic_fetch_iversion(inode);
+	else
+		return time_to_chattr(&inode->i_ctime);
+}
+
 static const struct export_operations ext4_export_ops = {
 	.fh_to_dentry = ext4_fh_to_dentry,
 	.fh_to_parent = ext4_fh_to_parent,
 	.get_parent = ext4_get_parent,
 	.commit_metadata = ext4_nfs_commit_metadata,
+	.fetch_iversion = ext4_fetch_iversion,
 };
 
 enum {
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index f58933519f38..257ba5646239 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -52,8 +52,8 @@ typedef struct svc_fh {
 	struct timespec64	fh_pre_mtime;	/* mtime before oper */
 	struct timespec64	fh_pre_ctime;	/* ctime before oper */
 	/*
-	 * pre-op nfsv4 change attr: note must check IS_I_VERSION(inode)
-	 *  to find out if it is valid.
+	 * pre-op nfsv4 change attr: note must check for fetch_iversion
+	 * op to find out if it is valid.
 	 */
 	u64			fh_pre_change;
 
@@ -251,31 +251,12 @@ fh_clear_wcc(struct svc_fh *fhp)
 	fhp->fh_pre_saved = false;
 }
 
-/*
- * We could use i_version alone as the change attribute.  However,
- * i_version can go backwards after a reboot.  On its own that doesn't
- * necessarily cause a problem, but if i_version goes backwards and then
- * is incremented again it could reuse a value that was previously used
- * before boot, and a client who queried the two values might
- * incorrectly assume nothing changed.
- *
- * By using both ctime and the i_version counter we guarantee that as
- * long as time doesn't go backwards we never reuse an old value.
- */
 static inline u64 nfsd4_change_attribute(struct kstat *stat,
 					 struct inode *inode)
 {
 	if (inode->i_sb->s_export_op->fetch_iversion)
 		return inode->i_sb->s_export_op->fetch_iversion(inode);
-	else if (IS_I_VERSION(inode)) {
-		u64 chattr;
-
-		chattr =  stat->ctime.tv_sec;
-		chattr <<= 30;
-		chattr += stat->ctime.tv_nsec;
-		chattr += inode_query_iversion(inode);
-		return chattr;
-	} else
+	else
 		return time_to_chattr(&stat->ctime);
 }
 
diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
index 465fd9e048d4..4a08b65c32aa 100644
--- a/fs/xfs/xfs_export.c
+++ b/fs/xfs/xfs_export.c
@@ -16,6 +16,7 @@
 #include "xfs_inode_item.h"
 #include "xfs_icache.h"
 #include "xfs_pnfs.h"
+#include <linux/iversion.h>
 
 /*
  * Note that we only accept fileids which are long enough rather than allow
@@ -223,6 +224,14 @@ xfs_fs_nfs_commit_metadata(
 	return xfs_log_force_inode(XFS_I(inode));
 }
 
+static u64 xfs_fetch_iversion(struct inode *inode)
+{
+	if (IS_I_VERSION(inode))
+		return generic_fetch_iversion(inode);
+	else
+		return time_to_chattr(&inode->i_ctime);
+}
+
 const struct export_operations xfs_export_operations = {
 	.encode_fh		= xfs_fs_encode_fh,
 	.fh_to_dentry		= xfs_fs_fh_to_dentry,
@@ -234,4 +243,5 @@ const struct export_operations xfs_export_operations = {
 	.map_blocks		= xfs_fs_map_blocks,
 	.commit_blocks		= xfs_fs_commit_blocks,
 #endif
+	.fetch_iversion		= xfs_fetch_iversion,
 };
diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index 3bfebde5a1a6..ded74523c8a6 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -328,6 +328,32 @@ inode_query_iversion(struct inode *inode)
 	return cur >> I_VERSION_QUERIED_SHIFT;
 }
 
+/*
+ * We could use i_version alone as the NFSv4 change attribute.  However,
+ * i_version can go backwards after a reboot.  On its own that doesn't
+ * necessarily cause a problem, but if i_version goes backwards and then
+ * is incremented again it could reuse a value that was previously used
+ * before boot, and a client who queried the two values might
+ * incorrectly assume nothing changed.
+ *
+ * By using both ctime and the i_version counter we guarantee that as
+ * long as time doesn't go backwards we never reuse an old value.
+ *
+ * A filesystem that has an on-disk boot counter or similar might prefer
+ * to use that to avoid the risk of the change attribute going backwards
+ * if system time is set backwards.
+ */
+static inline u64 generic_fetch_iversion(struct inode *inode)
+{
+	u64 chattr;
+
+	chattr =  inode->i_ctime.tv_sec;
+	chattr <<= 30;
+	chattr += inode->i_ctime.tv_nsec;
+	chattr += inode_query_iversion(inode);
+	return chattr;
+}
+
 /*
  * For filesystems without any sort of change attribute, the best we can
  * do is fake one up from the ctime:
-- 
2.29.2

