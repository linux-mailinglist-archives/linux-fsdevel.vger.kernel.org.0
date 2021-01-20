Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B712FD861
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 19:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392011AbhATSeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 13:34:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404415AbhATS3t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:29:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3736223403;
        Wed, 20 Jan 2021 18:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611167332;
        bh=e2DMr4jm+tXVzAci9mV8w7acvj1g/3soPO/xk16MNjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZRUxG8cEod9D0H+iyYJS4tscDgTw/tM3Dz1Eid824gsIF6qvx3hYsMXn/AARq7TJG
         GMPIvaVOfyTLBkSOAwxAmIfmyXW/vuaA1a2txqFT4laKTjK8amcprxMh4pgQxsaDce
         SKh0IrlS7he17iR1f9qG4fDaFKWKLafpZmHEFdE5MwUOYVFdvOXwVRbza5mVCoYJ5h
         M/9z412grU01uq+Fru/ZNT3mzsANtHQEh6Zl8heyOtoHaq5pPxlTUUoSOxq5IN4eCC
         wzXJW5oHzuYfPoQ3J/C86FetLKdY6OT3OKiINRRFVZn8O6TYEBZpDP5k9wCuW3PEOJ
         lkJs/9YdAFfhA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v4 05/17] ceph: crypto context handling for ceph
Date:   Wed, 20 Jan 2021 13:28:35 -0500
Message-Id: <20210120182847.644850-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120182847.644850-1-jlayton@kernel.org>
References: <20210120182847.644850-1-jlayton@kernel.org>
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
 fs/ceph/inode.c  |  6 ++++++
 fs/ceph/super.c  |  3 +++
 fs/ceph/super.h  |  1 +
 fs/ceph/xattr.c  | 32 ++++++++++++++++++++++++++++++++
 7 files changed, 109 insertions(+)
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
index 5d20a620e96c..d465ad48ade5 100644
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
@@ -553,6 +555,7 @@ void ceph_evict_inode(struct inode *inode)
 	clear_inode(inode);
 
 	ceph_fscache_unregister_inode_cookie(ci);
+	fscrypt_put_encryption_info(inode);
 
 	__ceph_remove_caps(ci);
 
@@ -912,6 +915,9 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		ceph_forget_all_cached_acls(inode);
 		ceph_security_invalidate_secctx(inode);
 		xattr_blob = NULL;
+		if ((inode->i_state & I_NEW) &&
+		     ceph_inode_has_xattr(ci, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT))
+			inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
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
index 13b02887b085..efe2e963c631 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1013,6 +1013,7 @@ extern ssize_t ceph_listxattr(struct dentry *, char *, size_t);
 extern struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci);
 extern void __ceph_destroy_xattrs(struct ceph_inode_info *ci);
 extern const struct xattr_handler *ceph_xattr_handlers[];
+bool ceph_inode_has_xattr(struct ceph_inode_info *ci, const char *name);
 
 struct ceph_acl_sec_ctx {
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 24997982de01..d0d719b768e4 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1359,6 +1359,38 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
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
2.29.2

