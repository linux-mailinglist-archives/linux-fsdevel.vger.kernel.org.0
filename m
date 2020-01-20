Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC7D14227A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 05:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgATEs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 23:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729064AbgATEs6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 23:48:58 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17AD12073D;
        Mon, 20 Jan 2020 04:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579495737;
        bh=v2IOamtEHR2AceXQ2i+GCO37/2hpui4sIXfA+tBcEXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=caYznpiyRE09Z5jprf6wPliiMJ/puPGcB+9+PbpHbhHD+J2nFGO0qqnCs1IGKpVZm
         9BPh3qWiUhuJoSpy2Joua7BsPcaNPW7/qt+s+/f5yjG6f3dMXJV4VhbTcVvIsH3sRn
         IxqVlMVSdl1hBcnUD5IWDg9c6vt0gqA2md00kepg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Daniel Rosenberg <drosen@google.com>
Subject: [PATCH v4 1/4] fscrypt: don't allow v1 policies with casefolding
Date:   Sun, 19 Jan 2020 20:43:58 -0800
Message-Id: <20200120044401.325453-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120044401.325453-1-ebiggers@kernel.org>
References: <20200120044401.325453-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Daniel Rosenberg <drosen@google.com>

Casefolded encrypted directories will use a new dirhash method that
requires a secret key.  If the directory uses a v2 encryption policy,
it's easy to derive this key from the master key using HKDF.  However,
v1 encryption policies don't provide a way to derive additional keys.

Therefore, don't allow casefolding on directories that use a v1 policy.
Specifically, make it so that trying to enable casefolding on a
directory that has a v1 policy fails, trying to set a v1 policy on a
casefolded directory fails, and trying to open a casefolded directory
that has a v1 policy (if one somehow exists on-disk) fails.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
[EB: improved commit message, updated fscrypt.rst, and other cleanups]
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst |  4 +++-
 fs/crypto/hooks.c                     | 28 +++++++++++++++++++++++++++
 fs/crypto/policy.c                    |  7 +++++++
 fs/inode.c                            |  3 ++-
 include/linux/fscrypt.h               |  9 +++++++++
 5 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 9c53336d06a43..380a1be9550e1 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -513,7 +513,9 @@ FS_IOC_SET_ENCRYPTION_POLICY can fail with the following errors:
 - ``EEXIST``: the file is already encrypted with an encryption policy
   different from the one specified
 - ``EINVAL``: an invalid encryption policy was specified (invalid
-  version, mode(s), or flags; or reserved bits were set)
+  version, mode(s), or flags; or reserved bits were set); or a v1
+  encryption policy was specified but the directory has the casefold
+  flag enabled (casefolding is incompatible with v1 policies).
 - ``ENOKEY``: a v2 encryption policy was specified, but the key with
   the specified ``master_key_identifier`` has not been added, nor does
   the process have the CAP_FOWNER capability in the initial user
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index bb3b7fcfdd48a..d96a58f11d2b0 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -122,6 +122,34 @@ int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(__fscrypt_prepare_lookup);
 
+/**
+ * fscrypt_prepare_setflags() - prepare to change flags with FS_IOC_SETFLAGS
+ * @inode: the inode on which flags are being changed
+ * @oldflags: the old flags
+ * @flags: the new flags
+ *
+ * The caller should be holding i_rwsem for write.
+ *
+ * Return: 0 on success; -errno if the flags change isn't allowed or if
+ *	   another error occurs.
+ */
+int fscrypt_prepare_setflags(struct inode *inode,
+			     unsigned int oldflags, unsigned int flags)
+{
+	struct fscrypt_info *ci;
+	int err;
+
+	if (IS_ENCRYPTED(inode) && (flags & ~oldflags & FS_CASEFOLD_FL)) {
+		err = fscrypt_require_key(inode);
+		if (err)
+			return err;
+		ci = inode->i_crypt_info;
+		if (ci->ci_policy.version != FSCRYPT_POLICY_V2)
+			return -EINVAL;
+	}
+	return 0;
+}
+
 int __fscrypt_prepare_symlink(struct inode *dir, unsigned int len,
 			      unsigned int max_len,
 			      struct fscrypt_str *disk_link)
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index f1cff83c151ac..cf2a9d26ef7da 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -124,6 +124,13 @@ static bool fscrypt_supported_v1_policy(const struct fscrypt_policy_v1 *policy,
 					policy->filenames_encryption_mode))
 		return false;
 
+	if (IS_CASEFOLDED(inode)) {
+		/* With v1, there's no way to derive dirhash keys. */
+		fscrypt_warn(inode,
+			     "v1 policies can't be used on casefolded directories");
+		return false;
+	}
+
 	return true;
 }
 
diff --git a/fs/inode.c b/fs/inode.c
index 96d62d97694ef..ea15c6d9f2742 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/cdev.h>
 #include <linux/memblock.h>
+#include <linux/fscrypt.h>
 #include <linux/fsnotify.h>
 #include <linux/mount.h>
 #include <linux/posix_acl.h>
@@ -2252,7 +2253,7 @@ int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
 	    !capable(CAP_LINUX_IMMUTABLE))
 		return -EPERM;
 
-	return 0;
+	return fscrypt_prepare_setflags(inode, oldflags, flags);
 }
 EXPORT_SYMBOL(vfs_ioc_setflags_prepare);
 
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 6fe8d0f96a4ac..3984eadd7023f 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -263,6 +263,8 @@ extern int __fscrypt_prepare_rename(struct inode *old_dir,
 				    unsigned int flags);
 extern int __fscrypt_prepare_lookup(struct inode *dir, struct dentry *dentry,
 				    struct fscrypt_name *fname);
+extern int fscrypt_prepare_setflags(struct inode *inode,
+				    unsigned int oldflags, unsigned int flags);
 extern int __fscrypt_prepare_symlink(struct inode *dir, unsigned int len,
 				     unsigned int max_len,
 				     struct fscrypt_str *disk_link);
@@ -519,6 +521,13 @@ static inline int __fscrypt_prepare_lookup(struct inode *dir,
 	return -EOPNOTSUPP;
 }
 
+static inline int fscrypt_prepare_setflags(struct inode *inode,
+					   unsigned int oldflags,
+					   unsigned int flags)
+{
+	return 0;
+}
+
 static inline int __fscrypt_prepare_symlink(struct inode *dir,
 					    unsigned int len,
 					    unsigned int max_len,
-- 
2.25.0

