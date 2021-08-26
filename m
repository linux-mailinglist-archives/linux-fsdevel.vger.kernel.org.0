Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4626D3F8BD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 18:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbhHZQVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 12:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243110AbhHZQVL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:21:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 659B3610F9;
        Thu, 26 Aug 2021 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629994824;
        bh=hg3FC0x6N0liiq6rA8UgcJN1UDK0UYmgF501hD8RvFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isR999wSX4yFDBcqKIVfy+FwXD/jycfvXL9fEE3jEcOEsXiFpwJ2J4O9wH3lxxMNi
         MYgPWn26+W9+Azjc2jBZ7tv7GQwkpfbhUVHMwFk425bwCJOebf5pm90g1hrKh+WkCE
         qn3WKRgryt2P1B2cPLN/3lW13K0h+Vl0N2gVMtC8JK37CZtI8ZMfNJVC5A0Tz96Wmk
         5HF+GQbaEdwVQaW5fbgVhDZOa+6zxlVZS4ZRjvkdvxFs0/QLemA+de/+o9d4V7PMFX
         sCQQQaeJhTrvXm+8rqNHkogXBWB4V22xGfm+2EWxJajTRipRBBE7FpbADLBBNPQun0
         b2CYSVlhjfapg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com, xiubli@redhat.com, lhenriques@suse.de,
        khiremat@redhat.com, ebiggers@kernel.org
Subject: [RFC PATCH v8 08/24] ceph: crypto context handling for ceph
Date:   Thu, 26 Aug 2021 12:19:58 -0400
Message-Id: <20210826162014.73464-9-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826162014.73464-1-jlayton@kernel.org>
References: <20210826162014.73464-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Have set_context do a setattr that sets the fscrypt_auth value, and
get_context just return the contents of that field.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/Makefile |  1 +
 fs/ceph/crypto.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h | 29 ++++++++++++++++++
 fs/ceph/inode.c  |  3 ++
 fs/ceph/super.c  |  3 ++
 5 files changed, 113 insertions(+)
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
index 000000000000..cdca7660f835
--- /dev/null
+++ b/fs/ceph/crypto.c
@@ -0,0 +1,77 @@
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
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_fscrypt_auth *cfa = (struct ceph_fscrypt_auth *)ci->fscrypt_auth;
+	u32 ctxlen;
+
+	/* Non existent or too short? */
+	if (!cfa || (ci->fscrypt_auth_len < (offsetof(struct ceph_fscrypt_auth, cfa_blob) + 1)))
+		return -ENOBUFS;
+
+	/* Some format we don't recognize? */
+	if (le32_to_cpu(cfa->cfa_version) != CEPH_FSCRYPT_AUTH_VERSION)
+		return -ENOBUFS;
+
+	ctxlen = le32_to_cpu(cfa->cfa_blob_len);
+	if (len < ctxlen)
+		return -ERANGE;
+
+	memcpy(ctx, cfa->cfa_blob, ctxlen);
+	return ctxlen;
+}
+
+static int ceph_crypt_set_context(struct inode *inode, const void *ctx, size_t len, void *fs_data)
+{
+	int ret;
+	struct iattr attr = { };
+	struct ceph_iattr cia = { };
+	struct ceph_fscrypt_auth *cfa;
+
+	WARN_ON_ONCE(fs_data);
+
+	if (len > FSCRYPT_SET_CONTEXT_MAX_SIZE)
+		return -EINVAL;
+
+	cfa = kzalloc(sizeof(*cfa), GFP_KERNEL);
+	if (!cfa)
+		return -ENOMEM;
+
+	cfa->cfa_version = cpu_to_le32(CEPH_FSCRYPT_AUTH_VERSION);
+	cfa->cfa_blob_len = cpu_to_le32(len);
+	memcpy(cfa->cfa_blob, ctx, len);
+
+	cia.fscrypt_auth = cfa;
+
+	ret = __ceph_setattr(inode, &attr, &cia);
+	if (ret == 0)
+		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
+	kfree(cia.fscrypt_auth);
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
index 000000000000..6c3831c57c8d
--- /dev/null
+++ b/fs/ceph/crypto.h
@@ -0,0 +1,29 @@
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
+struct ceph_fscrypt_auth {
+	__le32	cfa_version;
+	__le32	cfa_blob_len;
+	u8	cfa_blob[FSCRYPT_SET_CONTEXT_MAX_SIZE];
+} __packed;
+
+#ifdef CONFIG_FS_ENCRYPTION
+#define CEPH_FSCRYPT_AUTH_VERSION	1
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
index 129c62ae7141..a541f5e9c5ed 100644
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
@@ -646,6 +648,7 @@ void ceph_evict_inode(struct inode *inode)
 	clear_inode(inode);
 
 	ceph_fscache_unregister_inode_cookie(ci);
+	fscrypt_put_encryption_info(inode);
 
 	__ceph_remove_caps(ci);
 
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index f517ad9eeb26..5949f1bddeb5 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -20,6 +20,7 @@
 #include "super.h"
 #include "mds_client.h"
 #include "cache.h"
+#include "crypto.h"
 
 #include <linux/ceph/ceph_features.h>
 #include <linux/ceph/decode.h>
@@ -1109,6 +1110,8 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
 
+	ceph_fscrypt_set_ops(s);
+
 	ret = set_anon_super_fc(s, fc);
 	if (ret != 0)
 		fsc->sb = NULL;
-- 
2.31.1

