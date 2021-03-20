Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00D1342CCA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 13:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhCTM1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 08:27:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48209 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhCTM1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 08:27:01 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lNagm-0004Pf-Om; Sat, 20 Mar 2021 12:26:44 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 4/4] fs: introduce two inode i_{u,g}id initialization helpers
Date:   Sat, 20 Mar 2021 13:26:24 +0100
Message-Id: <20210320122623.599086-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210320122623.599086-1-christian.brauner@ubuntu.com>
References: <20210320122623.599086-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Give filesystem two little helpers that do the right thing when
initializing the i_uid and i_gid fields on idmapped and non-idmapped
mounts. Filesystems shouldn't have to be concerned with too many
details.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Inspired-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Add kernel docs to helpers.
---
 fs/ext4/ialloc.c   |  2 +-
 fs/inode.c         |  4 ++--
 fs/xfs/xfs_inode.c |  2 +-
 include/linux/fs.h | 28 ++++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index d0dc12197346..755a68bb7e22 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -970,7 +970,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 		i_gid_write(inode, owner[1]);
 	} else if (test_opt(sb, GRPID)) {
 		inode->i_mode = mode;
-		inode->i_uid = mapped_fsuid(mnt_userns);
+		inode_fsuid_set(inode, mnt_userns);
 		inode->i_gid = dir->i_gid;
 	} else
 		inode_init_owner(mnt_userns, inode, dir, mode);
diff --git a/fs/inode.c b/fs/inode.c
index 81a6a59b7dd3..21c5a620ca89 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2148,7 +2148,7 @@ EXPORT_SYMBOL(init_special_inode);
 void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		      const struct inode *dir, umode_t mode)
 {
-	inode->i_uid = mapped_fsuid(mnt_userns);
+	inode_fsuid_set(inode, mnt_userns);
 	if (dir && dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;
 
@@ -2160,7 +2160,7 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 			 !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
 			mode &= ~S_ISGID;
 	} else
-		inode->i_gid = mapped_fsgid(mnt_userns);
+		inode_fsgid_set(inode, mnt_userns);
 	inode->i_mode = mode;
 }
 EXPORT_SYMBOL(inode_init_owner);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index dc91f8c34d35..2a8bdf33e6c4 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -812,7 +812,7 @@ xfs_init_new_inode(
 
 	if (dir && !(dir->i_mode & S_ISGID) &&
 	    (mp->m_flags & XFS_MOUNT_GRPID)) {
-		inode->i_uid = mapped_fsuid(mnt_userns);
+		inode_fsuid_set(inode, mnt_userns);
 		inode->i_gid = dir->i_gid;
 		inode->i_mode = mode;
 	} else {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0e2ce21b2552..4a4af6c26a01 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1692,6 +1692,34 @@ static inline kgid_t mapped_fsgid(struct user_namespace *mnt_userns)
 	return kgid_from_mnt(mnt_userns, current_fsgid());
 }
 
+/**
+ * inode_fsuid_set - initialize inode's i_uid field with callers fsuid
+ * @inode: inode to initialize
+ * @mnt_userns: user namespace of the mount the inode was found from
+ *
+ * Initialize the i_uid field of @inode. If the inode was found/created via
+ * an idmapped mount map the caller's fsuid according to @mnt_users.
+ */
+static inline void inode_fsuid_set(struct inode *inode,
+				   struct user_namespace *mnt_userns)
+{
+	inode->i_uid = mapped_fsuid(mnt_userns);
+}
+
+/**
+ * inode_fsgid_set - initialize inode's i_gid field with callers fsgid
+ * @inode: inode to initialize
+ * @mnt_userns: user namespace of the mount the inode was found from
+ *
+ * Initialize the i_gid field of @inode. If the inode was found/created via
+ * an idmapped mount map the caller's fsgid according to @mnt_users.
+ */
+static inline void inode_fsgid_set(struct inode *inode,
+				   struct user_namespace *mnt_userns)
+{
+	inode->i_gid = mapped_fsgid(mnt_userns);
+}
+
 /**
  * fsuidgid_has_mapping() - check whether caller's fsuid/fsgid is mapped
  * @sb: the superblock we want a mapping in
-- 
2.27.0

