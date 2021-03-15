Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E7333BF39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 16:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhCOO71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 10:59:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37940 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbhCOOyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:54:40 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lLoc4-0006o5-SB; Mon, 15 Mar 2021 14:54:33 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/3] fs: introduce fsuidgid_has_mapping() helper
Date:   Mon, 15 Mar 2021 15:54:17 +0100
Message-Id: <20210315145419.2612537-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210315145419.2612537-1-christian.brauner@ubuntu.com>
References: <20210315145419.2612537-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't open-code the checks and instead move them into a clean little
helper we can call. This also reduces the risk that if we ever change
something we forget to change all locations.

Inspired-by: Vivek Goyal <vgoyal@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namei.c         | 11 +++--------
 include/linux/fs.h | 11 +++++++++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 216f16e74351..bc03cbc37ba7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2823,16 +2823,14 @@ static int may_delete(struct user_namespace *mnt_userns, struct inode *dir,
 static inline int may_create(struct user_namespace *mnt_userns,
 			     struct inode *dir, struct dentry *child)
 {
-	struct user_namespace *s_user_ns;
 	audit_inode_child(dir, child, AUDIT_TYPE_CHILD_CREATE);
 	if (child->d_inode)
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
-	s_user_ns = dir->i_sb->s_user_ns;
-	if (!kuid_has_mapping(s_user_ns, fsuid_into_mnt(mnt_userns)) ||
-	    !kgid_has_mapping(s_user_ns, fsgid_into_mnt(mnt_userns)))
+	if (!fsuidgid_has_mapping(dir->i_sb, mnt_userns))
 		return -EOVERFLOW;
+
 	return inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
 }
 
@@ -3034,14 +3032,11 @@ static int may_o_create(struct user_namespace *mnt_userns,
 			const struct path *dir, struct dentry *dentry,
 			umode_t mode)
 {
-	struct user_namespace *s_user_ns;
 	int error = security_path_mknod(dir, dentry, mode, 0);
 	if (error)
 		return error;
 
-	s_user_ns = dir->dentry->d_sb->s_user_ns;
-	if (!kuid_has_mapping(s_user_ns, fsuid_into_mnt(mnt_userns)) ||
-	    !kgid_has_mapping(s_user_ns, fsgid_into_mnt(mnt_userns)))
+	if (!fsuidgid_has_mapping(dir->dentry->d_sb, mnt_userns))
 		return -EOVERFLOW;
 
 	error = inode_permission(mnt_userns, dir->dentry->d_inode,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..edcb1aa99fd6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1620,6 +1620,17 @@ static inline kgid_t fsgid_into_mnt(struct user_namespace *mnt_userns)
 	return kgid_from_mnt(mnt_userns, current_fsgid());
 }
 
+static inline bool fsuidgid_has_mapping(struct super_block *sb,
+					struct user_namespace *mnt_userns)
+{
+	struct user_namespace *s_user_ns = sb->s_user_ns;
+
+	return kuid_has_mapping(s_user_ns,
+				kuid_from_mnt(mnt_userns, current_fsuid())) &&
+	       kgid_has_mapping(s_user_ns,
+				kgid_from_mnt(mnt_userns, current_fsgid()));
+}
+
 extern struct timespec64 current_time(struct inode *inode);
 
 /*
-- 
2.27.0

