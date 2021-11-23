Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9445A1C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 12:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbhKWLqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 06:46:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236363AbhKWLp7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:45:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3B1C6069B;
        Tue, 23 Nov 2021 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637667771;
        bh=IpRRSSkZ/UrBlHGoEMSC6zqvaRukzygJG16S59esV8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkRgtLYGeOv43wR+Q5Gi6THRz31EIsMlxWeQ/jkuyFAWvhXMW47xkOqsBgS9Kaltj
         MhLtptpYFtS84sK/k5qEnyJojq376p4EXRzxcsyMnvbF5j7/GbDNqSs4uRPTnXV0PJ
         tjVYsWM3hrTCgEsZbFSRQUo1dvcH8XNNpGPSeLUhRZXSrj10LhYqlEePk/AudLHFoi
         FbUB7DhjAlQ/+lGtyoNeTRJFl+1sDUtbAfa961GYOBA+3UlJGoFs6NCQRSV4L2Dca8
         zm1RD3lQemjSON+m5mx6qRiYbAHPn16y0TZlLIua05sXM/aG5bvGJ0a9n6EhRVLH9d
         Efhbkqje2jnVw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 02/10] fs: move mapping helpers
Date:   Tue, 23 Nov 2021 12:42:19 +0100
Message-Id: <20211123114227.3124056-3-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123114227.3124056-1-brauner@kernel.org>
References: <20211123114227.3124056-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8370; h=from:subject; bh=MCmibVNbOr2q/MjZn/cfH4ljQjMjIxE50K+YGoZjYj4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTOuVys9rfhwQmJNrGatt3nNz1bc4njwoRvLpdijs5zutt9 VuzYhI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJJFUxMhz41nZvU3jgk9NT7C/NWc I/pf3y/0Vtq5/I6y3QV/c/cO06I8MjC9UX/fdy9s/5GtQX/vhIeWrWSu/0ZD1OoW+GHLqVYmwA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

The low-level mapping helpers were so far crammed into fs.h. They are
out of place there. The fs.h header should just contain the higher-level
mapping helpers that interact directly with vfs objects such as struct
super_block or struct inode and not the bare mapping helpers. Similarly,
only vfs and specific fs code shall interact with low-level mapping
helpers. And so they won't be made accessible automatically through
regular {g,u}id helpers.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/fs.h          |  91 +-------------------------------
 include/linux/mnt_mapping.h | 101 ++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 90 deletions(-)
 create mode 100644 include/linux/mnt_mapping.h

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 192242476b2b..eb69e8b035fa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -41,6 +41,7 @@
 #include <linux/stddef.h>
 #include <linux/mount.h>
 #include <linux/cred.h>
+#include <linux/mnt_mapping.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1624,34 +1625,6 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
 }
 
-/**
- * kuid_into_mnt - map a kuid down into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
- * @kuid: kuid to be mapped
- *
- * Return: @kuid mapped according to @mnt_userns.
- * If @kuid has no mapping INVALID_UID is returned.
- */
-static inline kuid_t kuid_into_mnt(struct user_namespace *mnt_userns,
-				   kuid_t kuid)
-{
-	return make_kuid(mnt_userns, __kuid_val(kuid));
-}
-
-/**
- * kgid_into_mnt - map a kgid down into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
- * @kgid: kgid to be mapped
- *
- * Return: @kgid mapped according to @mnt_userns.
- * If @kgid has no mapping INVALID_GID is returned.
- */
-static inline kgid_t kgid_into_mnt(struct user_namespace *mnt_userns,
-				   kgid_t kgid)
-{
-	return make_kgid(mnt_userns, __kgid_val(kgid));
-}
-
 /**
  * i_uid_into_mnt - map an inode's i_uid down into a mnt_userns
  * @mnt_userns: user namespace of the mount the inode was found from
@@ -1680,68 +1653,6 @@ static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
 	return kgid_into_mnt(mnt_userns, inode->i_gid);
 }
 
-/**
- * kuid_from_mnt - map a kuid up into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
- * @kuid: kuid to be mapped
- *
- * Return: @kuid mapped up according to @mnt_userns.
- * If @kuid has no mapping INVALID_UID is returned.
- */
-static inline kuid_t kuid_from_mnt(struct user_namespace *mnt_userns,
-				   kuid_t kuid)
-{
-	return KUIDT_INIT(from_kuid(mnt_userns, kuid));
-}
-
-/**
- * kgid_from_mnt - map a kgid up into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
- * @kgid: kgid to be mapped
- *
- * Return: @kgid mapped up according to @mnt_userns.
- * If @kgid has no mapping INVALID_GID is returned.
- */
-static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
-				   kgid_t kgid)
-{
-	return KGIDT_INIT(from_kgid(mnt_userns, kgid));
-}
-
-/**
- * mapped_fsuid - return caller's fsuid mapped up into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
- *
- * Use this helper to initialize a new vfs or filesystem object based on
- * the caller's fsuid. A common example is initializing the i_uid field of
- * a newly allocated inode triggered by a creation event such as mkdir or
- * O_CREAT. Other examples include the allocation of quotas for a specific
- * user.
- *
- * Return: the caller's current fsuid mapped up according to @mnt_userns.
- */
-static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns)
-{
-	return kuid_from_mnt(mnt_userns, current_fsuid());
-}
-
-/**
- * mapped_fsgid - return caller's fsgid mapped up into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
- *
- * Use this helper to initialize a new vfs or filesystem object based on
- * the caller's fsgid. A common example is initializing the i_gid field of
- * a newly allocated inode triggered by a creation event such as mkdir or
- * O_CREAT. Other examples include the allocation of quotas for a specific
- * user.
- *
- * Return: the caller's current fsgid mapped up according to @mnt_userns.
- */
-static inline kgid_t mapped_fsgid(struct user_namespace *mnt_userns)
-{
-	return kgid_from_mnt(mnt_userns, current_fsgid());
-}
-
 /**
  * inode_fsuid_set - initialize inode's i_uid field with callers fsuid
  * @inode: inode to initialize
diff --git a/include/linux/mnt_mapping.h b/include/linux/mnt_mapping.h
new file mode 100644
index 000000000000..7ff8b66b80cb
--- /dev/null
+++ b/include/linux/mnt_mapping.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MNT_MAPPING_H
+#define _LINUX_MNT_MAPPING_H
+
+#include <linux/types.h>
+#include <linux/uidgid.h>
+
+struct user_namespace;
+extern struct user_namespace init_user_ns;
+
+/**
+ * kuid_into_mnt - map a kuid down into a mnt_userns
+ * @mnt_userns: user namespace of the relevant mount
+ * @kuid: kuid to be mapped
+ *
+ * Return: @kuid mapped according to @mnt_userns.
+ * If @kuid has no mapping INVALID_UID is returned.
+ */
+static inline kuid_t kuid_into_mnt(struct user_namespace *mnt_userns,
+				   kuid_t kuid)
+{
+	return make_kuid(mnt_userns, __kuid_val(kuid));
+}
+
+/**
+ * kgid_into_mnt - map a kgid down into a mnt_userns
+ * @mnt_userns: user namespace of the relevant mount
+ * @kgid: kgid to be mapped
+ *
+ * Return: @kgid mapped according to @mnt_userns.
+ * If @kgid has no mapping INVALID_GID is returned.
+ */
+static inline kgid_t kgid_into_mnt(struct user_namespace *mnt_userns,
+				   kgid_t kgid)
+{
+	return make_kgid(mnt_userns, __kgid_val(kgid));
+}
+
+/**
+ * kuid_from_mnt - map a kuid up into a mnt_userns
+ * @mnt_userns: user namespace of the relevant mount
+ * @kuid: kuid to be mapped
+ *
+ * Return: @kuid mapped up according to @mnt_userns.
+ * If @kuid has no mapping INVALID_UID is returned.
+ */
+static inline kuid_t kuid_from_mnt(struct user_namespace *mnt_userns,
+				   kuid_t kuid)
+{
+	return KUIDT_INIT(from_kuid(mnt_userns, kuid));
+}
+
+/**
+ * kgid_from_mnt - map a kgid up into a mnt_userns
+ * @mnt_userns: user namespace of the relevant mount
+ * @kgid: kgid to be mapped
+ *
+ * Return: @kgid mapped up according to @mnt_userns.
+ * If @kgid has no mapping INVALID_GID is returned.
+ */
+static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
+				   kgid_t kgid)
+{
+	return KGIDT_INIT(from_kgid(mnt_userns, kgid));
+}
+
+/**
+ * mapped_fsuid - return caller's fsuid mapped up into a mnt_userns
+ * @mnt_userns: user namespace of the relevant mount
+ *
+ * Use this helper to initialize a new vfs or filesystem object based on
+ * the caller's fsuid. A common example is initializing the i_uid field of
+ * a newly allocated inode triggered by a creation event such as mkdir or
+ * O_CREAT. Other examples include the allocation of quotas for a specific
+ * user.
+ *
+ * Return: the caller's current fsuid mapped up according to @mnt_userns.
+ */
+static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns)
+{
+	return kuid_from_mnt(mnt_userns, current_fsuid());
+}
+
+/**
+ * mapped_fsgid - return caller's fsgid mapped up into a mnt_userns
+ * @mnt_userns: user namespace of the relevant mount
+ *
+ * Use this helper to initialize a new vfs or filesystem object based on
+ * the caller's fsgid. A common example is initializing the i_gid field of
+ * a newly allocated inode triggered by a creation event such as mkdir or
+ * O_CREAT. Other examples include the allocation of quotas for a specific
+ * user.
+ *
+ * Return: the caller's current fsgid mapped up according to @mnt_userns.
+ */
+static inline kgid_t mapped_fsgid(struct user_namespace *mnt_userns)
+{
+	return kgid_from_mnt(mnt_userns, current_fsgid());
+}
+
+#endif /* _LINUX_MNT_MAPPING_H */
-- 
2.30.2

