Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79275467609
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 12:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351759AbhLCLU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 06:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351752AbhLCLU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:20:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4676DC06173E
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 03:17:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA5BA62A28
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 11:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481C8C53FC7;
        Fri,  3 Dec 2021 11:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638530253;
        bh=vglMzFW77UECxeyfu3fpiMb2UqoUa15m9FLT65SoBZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bwOv3EtRsi35FQzlt2UI7HCpWrPn1t/CDP6I4TCmyl4UvBHyuqwaHsblwPHCYdKz5
         y+ujlwqbIU2IdwKGpgaW5ewqLyGfh+rtxYgpM3qfgn4eP2pXKt26C6hb73C0L2vv2T
         jNx57hShIF1GrIlZxzY2YfjhHR+vwdQMhU3xA40OL8nVdDC3HZgVgSGv+eyUbfGoTp
         EG53AwQl6iZzT9FDux+YDrpdPQSACCjtTUlOEw3fY3LIKYVEZ6UJIayZMZEVFW3fNI
         VP9G69L6XujZclG8YoDYCb6UvVE1mbXZhMuUHluIsfM/j6r3w2Y7anv6eXdd6YZC7O
         hsmBBhqOIU45Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 02/10] fs: move mapping helpers
Date:   Fri,  3 Dec 2021 12:16:59 +0100
Message-Id: <20211203111707.3901969-3-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203111707.3901969-1-brauner@kernel.org>
References: <20211203111707.3901969-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11146; h=from:subject; bh=weeptqzSkkZ9pgnrUtDUmQOLJ2iYDpObRlE8MFAdkoA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSu/DN1ov2GKvXv7173BsZdK/6lopy1P+nzGw4ec8PPh2ev f/OyraOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiZ+cxMszk12R03b3n1ty/5VoTt8 VsY3p6aaEei+Q2DeuauTbbXBQZ/nucuhP5P9DHgemvwmaFHi6HtRpT2PfvmC11LHS95/PWyZwA
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

Link: https://lore.kernel.org/r/20211123114227.3124056-3-brauner@kernel.org (v1)
Link: https://lore.kernel.org/r/20211130121032.3753852-3-brauner@kernel.org (v2)
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Seth Forshee <sforshee@digitalocean.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Amir Goldstein <amir73il@gmail.com>:
  - Rename header to mnt_idmapping.h
  - Include mnt_idmapping.h header in all files where it is used to
    avoid unnecessary recompliation on header change.

/* v3 */
unchanged
---
 fs/ksmbd/smbacl.c             |   1 +
 fs/ksmbd/smbacl.h             |   1 +
 fs/open.c                     |   1 +
 fs/posix_acl.c                |   1 +
 fs/xfs/xfs_linux.h            |   1 +
 include/linux/fs.h            |  91 +-----------------------------
 include/linux/mnt_idmapping.h | 101 ++++++++++++++++++++++++++++++++++
 security/commoncap.c          |   1 +
 8 files changed, 108 insertions(+), 90 deletions(-)
 create mode 100644 include/linux/mnt_idmapping.h

diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index bd792db32623..ab8099e0fd7f 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/mnt_idmapping.h>
 
 #include "smbacl.h"
 #include "smb_common.h"
diff --git a/fs/ksmbd/smbacl.h b/fs/ksmbd/smbacl.h
index 73e08cad412b..eba1ebb9e92e 100644
--- a/fs/ksmbd/smbacl.h
+++ b/fs/ksmbd/smbacl.h
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/posix_acl.h>
+#include <linux/mnt_idmapping.h>
 
 #include "mgmt/tree_connect.h"
 
diff --git a/fs/open.c b/fs/open.c
index f732fb94600c..2450cc1a2f64 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -32,6 +32,7 @@
 #include <linux/ima.h>
 #include <linux/dnotify.h>
 #include <linux/compat.h>
+#include <linux/mnt_idmapping.h>
 
 #include "internal.h"
 
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 9323a854a60a..632bfdcf7cc0 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -23,6 +23,7 @@
 #include <linux/export.h>
 #include <linux/user_namespace.h>
 #include <linux/namei.h>
+#include <linux/mnt_idmapping.h>
 
 static struct posix_acl **acl_by_type(struct inode *inode, int type)
 {
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index c174262a074e..09a8fba84ff9 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -61,6 +61,7 @@ typedef __u32			xfs_nlink_t;
 #include <linux/ratelimit.h>
 #include <linux/rhashtable.h>
 #include <linux/xattr.h>
+#include <linux/mnt_idmapping.h>
 
 #include <asm/page.h>
 #include <asm/div64.h>
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 06cbefd76de7..b3bcb2129699 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -41,6 +41,7 @@
 #include <linux/stddef.h>
 #include <linux/mount.h>
 #include <linux/cred.h>
+#include <linux/mnt_idmapping.h>
 
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
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
new file mode 100644
index 000000000000..7ff8b66b80cb
--- /dev/null
+++ b/include/linux/mnt_idmapping.h
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
diff --git a/security/commoncap.c b/security/commoncap.c
index 3f810d37b71b..09479f71ee2e 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -24,6 +24,7 @@
 #include <linux/user_namespace.h>
 #include <linux/binfmts.h>
 #include <linux/personality.h>
+#include <linux/mnt_idmapping.h>
 
 /*
  * If a non-root user executes a setuid-root binary in
-- 
2.30.2

