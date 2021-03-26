Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3703034AD82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 18:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhCZRcw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 13:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhCZRcg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:32:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 591FD61A33;
        Fri, 26 Mar 2021 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616779952;
        bh=jTm0xmy6Fzl31LCcweWdxmUSRCnZpsuRxHjdss4eq1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVkHS4D9eukYUVDJZmW7nOC1h/2DX7Hkcwo5nrXwcYT0rPLc2SOAE7sOvvDCSfcq9
         VzlKZi5L52kfjOK3iRshla5POv4jmRIgbDkFdGYPNp9QKzNCXsWX/z5sO4A8QjBlQZ
         Ei+a0EF30ZYQGp/mjssM+hP/bGmDuk/ORylfNEobmBwI+UwNMun4sFPcC5khp9d03M
         LGG4SJk3wLbLvn+A9PTyRsovzs7W0Z5AkmRdWwiiqSG/wB589MSvQTLFUtdEKXaI1X
         0PjVDN9Z1dFxu2UBu1aAFF1d4amXP2QUhmYxk0ddHoaKqBF6Ic72UkE4SBc8MukWER
         qh2vVMXyLSmhA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v5 05/19] ceph: crypto context handling for ceph
Date:   Fri, 26 Mar 2021 13:32:13 -0400
Message-Id: <20210326173227.96363-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326173227.96363-1-jlayton@kernel.org>
References: <20210326173227.96363-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Store the fscrypt context for an inode as an encryption.ctx xattr.
When we get a new inode in a trace, set the S_ENCRYPTED bit if
the xattr blob has an encryption.ctx xattr.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/Makefile |  1 +
 fs/ceph/crypto.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h | 24 ++++++++++++++++++++++++
 fs/ceph/inode.c  | 15 +++++++++++++++
 fs/ceph/super.c  |  3 +++
 fs/ceph/super.h  |  1 +
 fs/ceph/xattr.c  | 32 ++++++++++++++++++++++++++++++++
 7 files changed, 118 insertions(+)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h

diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
index 50c635dc7f71..1f77ca04c426 100644
--- a/fs/ceph/Makefile
+++ b/fs/ceph/Makefile
@@ -12,3 +12,4 @@ ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
 
 ceph-$(CONFIG_CEPH_FSCACHE) += cache.o
 ceph-$(CONFIG_CEPH_FS_POSIX_ACL) += acl.o
+ceph-$(CONFIG_FS_ENCRYPTION) += crypto.o
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
new file mode 100644
index 000000000000..dbe8b60fd1b0
--- /dev/null
+++ b/fs/ceph/crypto.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ceph/ceph_debug.h>
+#include <linux/xattr.h>
+#include <linux/fscrypt.h>
+
+#include "super.h"
+#include "crypto.h"
+
+static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
+{
+	return __ceph_getxattr(inode, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT, ctx, len);
+}
+
+static int ceph_crypt_set_context(struct inode *inode, const void *ctx, size_t len, void *fs_data)
+{
+	int ret;
+
+	WARN_ON_ONCE(fs_data);
+	ret = __ceph_setxattr(inode, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT, ctx, len, XATTR_CREATE);
+	if (ret == 0)
+		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
+	return ret;
+}
+
+static bool ceph_crypt_empty_dir(struct inode *inode)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	return ci->i_rsubdirs + ci->i_rfiles == 1;
+}
+
+static struct fscrypt_operations ceph_fscrypt_ops = {
+	.get_context		= ceph_crypt_get_context,
+	.set_context		= ceph_crypt_set_context,
+	.empty_dir		= ceph_crypt_empty_dir,
+	.max_namelen		= NAME_MAX,
+};
+
+void ceph_fscrypt_set_ops(struct super_block *sb)
+{
+	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
+}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
new file mode 100644
index 000000000000..189bd8424284
--- /dev/null
+++ b/fs/ceph/crypto.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Ceph fscrypt functionality
+ */
+
+#ifndef _CEPH_CRYPTO_H
+#define _CEPH_CRYPTO_H
+
+#include <linux/fscrypt.h>
+
+#define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
+
+#ifdef CONFIG_FS_ENCRYPTION
+void ceph_fscrypt_set_ops(struct super_block *sb);
+
+#else /* CONFIG_FS_ENCRYPTION */
+
+static inline void ceph_fscrypt_set_ops(struct super_block *sb)
+{
+}
+
+#endif /* CONFIG_FS_ENCRYPTION */
+
+#endif
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 2c512475c170..33dda23c99e0 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -14,10 +14,12 @@
 #include <linux/random.h>
 #include <linux/sort.h>
 #include <linux/iversion.h>
+#include <linux/fscrypt.h>
 
 #include "super.h"
 #include "mds_client.h"
 #include "cache.h"
+#include "crypto.h"
 #include <linux/ceph/decode.h>
 
 /*
@@ -566,6 +568,7 @@ void ceph_evict_inode(struct inode *inode)
 	clear_inode(inode);
 
 	ceph_fscache_unregister_inode_cookie(ci);
+	fscrypt_put_encryption_info(inode);
 
 	__ceph_remove_caps(ci);
 
@@ -944,6 +947,18 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		ceph_forget_all_cached_acls(inode);
 		ceph_security_invalidate_secctx(inode);
 		xattr_blob = NULL;
+
+		/*
+		 * Most inodes inherit the encrypted flag from their parent,
+		 * but empty directories can end up being encrypted later via
+		 * ioctl. Only check for encryption if it's not already encrypted,
+		 * and it's a new inode, or a directory.
+		 */
+		if (!IS_ENCRYPTED(inode) &&
+		    ((inode->i_state & I_NEW) || S_ISDIR(inode->i_mode))) {
+			if (ceph_inode_has_xattr(ci, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT))
+				inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
+		}
 	}
 
 	/* finally update i_version */
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 9b1b7f4cfdd4..cdac6ff675e2 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -20,6 +20,7 @@
 #include "super.h"
 #include "mds_client.h"
 #include "cache.h"
+#include "crypto.h"
 
 #include <linux/ceph/ceph_features.h>
 #include <linux/ceph/decode.h>
@@ -988,6 +989,8 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
 
+	ceph_fscrypt_set_ops(s);
+
 	ret = set_anon_super_fc(s, fc);
 	if (ret != 0)
 		fsc->sb = NULL;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 5e0e1aeee1b5..36b12e33b2bc 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1016,6 +1016,7 @@ extern ssize_t ceph_listxattr(struct dentry *, char *, size_t);
 extern struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci);
 extern void __ceph_destroy_xattrs(struct ceph_inode_info *ci);
 extern const struct xattr_handler *ceph_xattr_handlers[];
+bool ceph_inode_has_xattr(struct ceph_inode_info *ci, const char *name);
 
 struct ceph_acl_sec_ctx {
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 02f59bcb4f27..38ac2968e4a1 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1360,6 +1360,38 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
 		ceph_pagelist_release(as_ctx->pagelist);
 }
 
+/* Return true if inode's xattr blob has an xattr named "name" */
+bool ceph_inode_has_xattr(struct ceph_inode_info *ci, const char *name)
+{
+	void *p, *end;
+	u32 numattr;
+	size_t namelen;
+
+	lockdep_assert_held(&ci->i_ceph_lock);
+
+	if (!ci->i_xattrs.blob || ci->i_xattrs.blob->vec.iov_len <= 4)
+		return false;
+
+	namelen = strlen(name);
+	p = ci->i_xattrs.blob->vec.iov_base;
+	end = p + ci->i_xattrs.blob->vec.iov_len;
+	ceph_decode_32_safe(&p, end, numattr, bad);
+
+	while (numattr--) {
+		u32 len;
+
+		ceph_decode_32_safe(&p, end, len, bad);
+		ceph_decode_need(&p, end, len, bad);
+		if (len == namelen && !memcmp(p, name, len))
+			return true;
+		p += len;
+		ceph_decode_32_safe(&p, end, len, bad);
+		ceph_decode_skip_n(&p, end, len, bad);
+	}
+bad:
+	return false;
+}
+
 /*
  * List of handlers for synthetic system.* attributes. Other
  * attributes are handled directly.
-- 
2.30.2

