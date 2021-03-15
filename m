Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AC033BF32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 16:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbhCOOz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 10:55:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37955 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241797AbhCOOys (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:54:48 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lLoc9-0006o5-CG; Mon, 15 Mar 2021 14:54:37 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/3] fs: introduce two little fs{u,g}id inode initialization helpers
Date:   Mon, 15 Mar 2021 15:54:19 +0100
Message-Id: <20210315145419.2612537-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210315145419.2612537-1-christian.brauner@ubuntu.com>
References: <20210315145419.2612537-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Give filesystem two little helpers so that do the right thing when
initializing the i_uid and i_gid fields on idmapped and non-idmapped
mounts. Filesystemd don't need to bother with too many details for this.

Inspired-by: Vivek Goyal <vgoyal@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/ext4/ialloc.c   |  2 +-
 fs/inode.c         |  4 ++--
 fs/xfs/xfs_inode.c |  2 +-
 include/linux/fs.h | 12 ++++++++++++
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 633ae7becd61..755a68bb7e22 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -970,7 +970,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 		i_gid_write(inode, owner[1]);
 	} else if (test_opt(sb, GRPID)) {
 		inode->i_mode = mode;
-		inode->i_uid = fsuid_into_mnt(mnt_userns);
+		inode_fsuid_set(inode, mnt_userns);
 		inode->i_gid = dir->i_gid;
 	} else
 		inode_init_owner(mnt_userns, inode, dir, mode);
diff --git a/fs/inode.c b/fs/inode.c
index a047ab306f9a..21c5a620ca89 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2148,7 +2148,7 @@ EXPORT_SYMBOL(init_special_inode);
 void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		      const struct inode *dir, umode_t mode)
 {
-	inode->i_uid = fsuid_into_mnt(mnt_userns);
+	inode_fsuid_set(inode, mnt_userns);
 	if (dir && dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;
 
@@ -2160,7 +2160,7 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 			 !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
 			mode &= ~S_ISGID;
 	} else
-		inode->i_gid = fsgid_into_mnt(mnt_userns);
+		inode_fsgid_set(inode, mnt_userns);
 	inode->i_mode = mode;
 }
 EXPORT_SYMBOL(inode_init_owner);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 8703408bd1aa..20846810f13f 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -812,7 +812,7 @@ xfs_init_new_inode(
 
 	if (dir && !(dir->i_mode & S_ISGID) &&
 	    (mp->m_flags & XFS_MOUNT_GRPID)) {
-		inode->i_uid = fsuid_into_mnt(mnt_userns);
+		inode_fsuid_set(inode, mnt_userns);
 		inode->i_gid = dir->i_gid;
 		inode->i_mode = mode;
 	} else {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 189673721726..0cde0cbc20fc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1620,6 +1620,18 @@ static inline kgid_t idmapped_fsgid(struct user_namespace *mnt_userns)
 	return kgid_from_mnt(mnt_userns, current_fsgid());
 }
 
+static inline void inode_fsuid_set(struct inode *inode,
+				   struct user_namespace *mnt_userns)
+{
+	inode->i_uid = idmapped_fsuid(mnt_userns);
+}
+
+static inline void inode_fsgid_set(struct inode *inode,
+				   struct user_namespace *mnt_userns)
+{
+	inode->i_gid = idmapped_fsgid(mnt_userns);
+}
+
 static inline bool fsuidgid_has_mapping(struct super_block *sb,
 					struct user_namespace *mnt_userns)
 {
-- 
2.27.0

