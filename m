Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821513C9BD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 11:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhGOJda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 05:33:30 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37189 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233886AbhGOJd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:33:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UfsAWGW_1626341432;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UfsAWGW_1626341432)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Jul 2021 17:30:33 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bo.liu@linux.alibaba.com
Subject: [RFC PATCH 3/3] fuse: add per-file DAX flag
Date:   Thu, 15 Jul 2021 17:30:31 +0800
Message-Id: <20210715093031.55667-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210715093031.55667-1-jefflexu@linux.alibaba.com>
References: <20210715093031.55667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
this file.

When the per-file DAX flag changes for an *opened* file, the state of
the file won't be updated until this file is closed and reopened later.

Currently it is not implemented yet to change per-file DAX flag inside
guest kernel, e.g., by chattr(1).

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dax.c             | 28 ++++++++++++++++++++++++----
 fs/fuse/file.c            |  4 ++--
 fs/fuse/fuse_i.h          |  5 +++--
 fs/fuse/inode.c           |  4 +++-
 include/uapi/linux/fuse.h |  5 +++++
 5 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 4873d764cb66..ed5a430364bb 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1341,7 +1341,7 @@ static const struct address_space_operations fuse_dax_file_aops  = {
 	.invalidatepage	= noop_invalidatepage,
 };
 
-static bool fuse_should_enable_dax(struct inode *inode)
+static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	unsigned int mode;
@@ -1354,18 +1354,38 @@ static bool fuse_should_enable_dax(struct inode *inode)
 	if (mode == FUSE_DAX_MOUNT_NEVER)
 		return false;
 
-	return true;
+	if (mode == FUSE_DAX_MOUNT_ALWAYS)
+		return true;
+
+	WARN_ON(mode != FUSE_DAX_MOUNT_INODE);
+	return flags & FUSE_ATTR_DAX;
 }
 
-void fuse_dax_inode_init(struct inode *inode)
+void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
 {
-	if (!fuse_should_enable_dax(inode))
+	if (!fuse_should_enable_dax(inode, flags))
 		return;
 
 	inode->i_flags |= S_DAX;
 	inode->i_data.a_ops = &fuse_dax_file_aops;
 }
 
+void fuse_update_dax(struct inode *inode, unsigned int flags)
+{
+	bool oldstate, newstate;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (!IS_ENABLED(CONFIG_FUSE_DAX) || !fc->dax ||
+	    fc->dax->mode != FUSE_DAX_MOUNT_INODE)
+		return;
+
+	oldstate = IS_DAX(inode);
+	newstate = flags & FUSE_ATTR_DAX;
+
+	if (oldstate != newstate)
+		d_mark_dontcache(inode);
+}
+
 bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment)
 {
 	if (fc->dax && (map_alignment > FUSE_DAX_SHIFT)) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 97f860cfc195..cf42af492146 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3142,7 +3142,7 @@ static const struct address_space_operations fuse_file_aops  = {
 	.write_end	= fuse_write_end,
 };
 
-void fuse_init_file_inode(struct inode *inode)
+void fuse_init_file_inode(struct inode *inode, struct fuse_attr *attr)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
@@ -3156,5 +3156,5 @@ void fuse_init_file_inode(struct inode *inode)
 	fi->writepages = RB_ROOT;
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
-		fuse_dax_inode_init(inode);
+		fuse_dax_inode_init(inode, attr->flags);
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f29018323845..b0ecfffd0c7d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1000,7 +1000,7 @@ int fuse_notify_poll_wakeup(struct fuse_conn *fc,
 /**
  * Initialize file operations on a regular file
  */
-void fuse_init_file_inode(struct inode *inode);
+void fuse_init_file_inode(struct inode *inode, struct fuse_attr *attr);
 
 /**
  * Initialize inode operations on regular files and special files
@@ -1252,8 +1252,9 @@ int fuse_dax_conn_alloc(struct fuse_conn *fc, unsigned int mode,
 			struct dax_device *dax_dev);
 void fuse_dax_conn_free(struct fuse_conn *fc);
 bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
-void fuse_dax_inode_init(struct inode *inode);
+void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
 void fuse_dax_inode_cleanup(struct inode *inode);
+void fuse_update_dax(struct inode *inode, unsigned int flags);
 bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
 void fuse_dax_cancel_work(struct fuse_conn *fc);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f6b46395edb2..47ebb1a394d2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -269,6 +269,8 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		if (inval)
 			invalidate_inode_pages2(inode->i_mapping);
 	}
+
+	fuse_update_dax(inode, attr->flags);
 }
 
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
@@ -281,7 +283,7 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
 	inode->i_ctime.tv_nsec = attr->ctimensec;
 	if (S_ISREG(inode->i_mode)) {
 		fuse_init_common(inode);
-		fuse_init_file_inode(inode);
+		fuse_init_file_inode(inode, attr);
 	} else if (S_ISDIR(inode->i_mode))
 		fuse_init_dir(inode);
 	else if (S_ISLNK(inode->i_mode))
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 36ed092227fa..9ee088ddbe2a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -184,6 +184,9 @@
  *
  *  7.34
  *  - add FUSE_SYNCFS
+ *
+ *  7.35
+ *  - add FUSE_ATTR_DAX
  */
 
 #ifndef _LINUX_FUSE_H
@@ -449,8 +452,10 @@ struct fuse_file_lock {
  * fuse_attr flags
  *
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
+ * FUSE_ATTR_DAX: Enable DAX for this file in per-file DAX mode
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
+#define FUSE_ATTR_DAX      	(1 << 1)
 
 /**
  * Open flags
-- 
2.27.0

