Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0260C269577
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 21:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgINTSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 15:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgINTRW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:17:22 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77AEC21D7B;
        Mon, 14 Sep 2020 19:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600111034;
        bh=wZaFW72m7wV6vuKWPDm512n6mTr+9ntwhxrgZnIhoco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzYiCmEzIaYDRc/hxK1URE22fei46N26nmBZOs1ONOIoVPZa4T8yY6YY8e8PyhHDG
         mH/2uyuGlDh2YZ28f/nGmsLaBT10QRfhkn8ecRCOyRpv/cA0YCvtontsrq2Y69rAOK
         og89yr3KC/djSJ9rMevogIumbJs23cLpXZjuxVVs=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v3 07/16] ceph: crypto context handling for ceph
Date:   Mon, 14 Sep 2020 15:16:58 -0400
Message-Id: <20200914191707.380444-8-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914191707.380444-1-jlayton@kernel.org>
References: <20200914191707.380444-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Store the fscrypt context for an inode as an encryption.ctx xattr.
When we get a new inode in a trace, set the S_ENCRYPTED bit if
the xattr blob has an encryption.ctx xattr.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/Makefile |  1 +
 fs/ceph/crypto.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h | 24 ++++++++++++++++++++++++
 fs/ceph/inode.c  |  4 ++++
 fs/ceph/super.c  |  5 +++++
 fs/ceph/super.h  |  1 +
 fs/ceph/xattr.c  | 32 +++++++++++++++++++++++++++++++
 7 files changed, 116 insertions(+)
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
index 000000000000..74f07d44dbe9
--- /dev/null
+++ b/fs/ceph/crypto.c
@@ -0,0 +1,49 @@
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
+static const union fscrypt_context *
+ceph_get_dummy_context(struct super_block *sb)
+{
+	return ceph_sb_to_client(sb)->dummy_enc_ctx.ctx;
+}
+
+static struct fscrypt_operations ceph_fscrypt_ops = {
+	.get_context		= ceph_crypt_get_context,
+	.set_context		= ceph_crypt_set_context,
+	.get_dummy_context	= ceph_get_dummy_context,
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
index 000000000000..b5f38ee80553
--- /dev/null
+++ b/fs/ceph/crypto.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ceph fscrypt functionality
+ */
+
+#ifndef _CEPH_CRYPTO_H
+#define _CEPH_CRYPTO_H
+
+#ifdef CONFIG_FS_ENCRYPTION
+
+#define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
+
+void ceph_fscrypt_set_ops(struct super_block *sb);
+
+#else /* CONFIG_FS_ENCRYPTION */
+
+static inline int ceph_fscrypt_set_ops(struct super_block *sb)
+{
+	return 0;
+}
+
+#endif /* CONFIG_FS_ENCRYPTION */
+
+#endif
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 526faf4778ce..daae18267fd8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -549,6 +549,7 @@ void ceph_evict_inode(struct inode *inode)
 
 	percpu_counter_dec(&mdsc->metric.total_inodes);
 
+	fscrypt_put_encryption_info(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 
@@ -912,6 +913,9 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		ceph_forget_all_cached_acls(inode);
 		ceph_security_invalidate_secctx(inode);
 		xattr_blob = NULL;
+		if ((inode->i_state & I_NEW) &&
+		     ceph_inode_has_xattr(ci, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT))
+			inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
 	}
 
 	/* finally update i_version */
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index b3fc9bb61afc..055180218224 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -20,6 +20,7 @@
 #include "super.h"
 #include "mds_client.h"
 #include "cache.h"
+#include "crypto.h"
 
 #include <linux/ceph/ceph_features.h>
 #include <linux/ceph/decode.h>
@@ -984,6 +985,10 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
 
+	ret = ceph_fscrypt_set_ops(s);
+	if (ret)
+		goto out;
+
 	ret = set_anon_super_fc(s, fc);
 	if (ret != 0)
 		fsc->sb = NULL;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 483a52d281cd..cc39cc36de77 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -985,6 +985,7 @@ extern ssize_t ceph_listxattr(struct dentry *, char *, size_t);
 extern struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci);
 extern void __ceph_destroy_xattrs(struct ceph_inode_info *ci);
 extern const struct xattr_handler *ceph_xattr_handlers[];
+bool ceph_inode_has_xattr(struct ceph_inode_info *ci, char *name);
 
 struct ceph_acl_sec_ctx {
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 3a733ac33d9b..9dcb060cba9a 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1283,6 +1283,38 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
 		ceph_pagelist_release(as_ctx->pagelist);
 }
 
+/* Return true if inode's xattr blob has an xattr named "name" */
+bool ceph_inode_has_xattr(struct ceph_inode_info *ci, char *name)
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
2.26.2

