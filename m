Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CA93B4509
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 15:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhFYOBQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 10:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231807AbhFYOBF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:01:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3E786197C;
        Fri, 25 Jun 2021 13:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624629524;
        bh=T3qpprX8JX/BDCa6X+vPZ8eJfX0v82bU03EWov8senA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/D0c5mxb2/8N+LA7yJOYvU2WOwdTxZxVYwMEmfjyIqy3/YeSPN6CQSOMQ3ZlyWXu
         H8kYyoEX3mSF83mseiQFKDJcQ4d+QgEi2eq9uJeliwBbDya8xSo35BU+uRf5TRABFR
         An0tRGcy79W9gt9Sxe8GWigOdwrxx7tvRpoaG3peWV8kKOncj8I8I+38GGT/O+vcT7
         7p6BSkLKhnru3XuGJ5qw7IDx7YiBgxcyXhjDxM/SaiNXgfhWfCrblyb5G5lXEBiGkS
         FjZ/cD46AGjYvaMRIX+RPh1D8QBzPA3SCu9JKweWInXZ1YOS+720LMFf3SkyotIza5
         WMzBXRrOfxGmQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: [RFC PATCH v7 11/24] ceph: add routine to create fscrypt context prior to RPC
Date:   Fri, 25 Jun 2021 09:58:21 -0400
Message-Id: <20210625135834.12934-12-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625135834.12934-1-jlayton@kernel.org>
References: <20210625135834.12934-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After pre-creating a new inode, do an fscrypt prepare on it, fetch a
new encryption context and then marshal that into the security context
to be sent along with the RPC. Call the new function from
ceph_new_inode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h | 25 +++++++++++++++++++++++++
 fs/ceph/inode.c  | 10 ++++++++--
 fs/ceph/super.h  |  5 +++++
 fs/ceph/xattr.c  |  3 +++
 5 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 997a33e1d59f..675d41fd2eb0 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -4,6 +4,7 @@
 #include <linux/fscrypt.h>
 
 #include "super.h"
+#include "mds_client.h"
 #include "crypto.h"
 
 static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
@@ -86,3 +87,44 @@ void ceph_fscrypt_set_ops(struct super_block *sb)
 {
 	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
 }
+
+int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
+				 struct ceph_acl_sec_ctx *as)
+{
+	int ret, ctxsize;
+	bool encrypted = false;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	ret = fscrypt_prepare_new_inode(dir, inode, &encrypted);
+	if (ret)
+		return ret;
+	if (!encrypted)
+		return 0;
+
+	as->fscrypt_auth = kzalloc(sizeof(*as->fscrypt_auth), GFP_KERNEL);
+	if (!as->fscrypt_auth)
+		return -ENOMEM;
+
+	ctxsize = fscrypt_context_for_new_inode(as->fscrypt_auth->cfa_blob, inode);
+	if (ctxsize < 0)
+		return ctxsize;
+
+	as->fscrypt_auth->cfa_version = cpu_to_le32(CEPH_FSCRYPT_AUTH_VERSION);
+	as->fscrypt_auth->cfa_blob_len = cpu_to_le32(ctxsize);
+
+	WARN_ON_ONCE(ci->fscrypt_auth);
+	kfree(ci->fscrypt_auth);
+	ci->fscrypt_auth_len = ceph_fscrypt_auth_size(ctxsize);
+	ci->fscrypt_auth = kmemdup(as->fscrypt_auth, ci->fscrypt_auth_len, GFP_KERNEL);
+	if (!ci->fscrypt_auth)
+		return -ENOMEM;
+
+	inode->i_flags |= S_ENCRYPTED;
+
+	return 0;
+}
+
+void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as)
+{
+	swap(req->r_fscrypt_auth, as->fscrypt_auth);
+}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index d2b1f8e7b300..bdf1ba47db16 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -11,6 +11,9 @@
 #define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
 
 #ifdef CONFIG_FS_ENCRYPTION
+struct ceph_fs_client;
+struct ceph_acl_sec_ctx;
+struct ceph_mds_request;
 
 #define CEPH_FSCRYPT_AUTH_VERSION	1
 struct ceph_fscrypt_auth {
@@ -19,10 +22,19 @@ struct ceph_fscrypt_auth {
 	u8	cfa_blob[FSCRYPT_SET_CONTEXT_MAX_SIZE];
 } __packed;
 
+static inline u32 ceph_fscrypt_auth_size(u32 ctxsize)
+{
+	return offsetof(struct ceph_fscrypt_auth, cfa_blob) + ctxsize;
+}
+
 void ceph_fscrypt_set_ops(struct super_block *sb);
 
 void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
 
+int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
+				 struct ceph_acl_sec_ctx *as);
+void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as);
+
 #else /* CONFIG_FS_ENCRYPTION */
 
 static inline void ceph_fscrypt_set_ops(struct super_block *sb)
@@ -32,6 +44,19 @@ static inline void ceph_fscrypt_set_ops(struct super_block *sb)
 static inline void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
 {
 }
+
+static inline int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
+						struct ceph_acl_sec_ctx *as)
+{
+	if (IS_ENCRYPTED(dir))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static inline void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req,
+						struct ceph_acl_sec_ctx *as_ctx)
+{
+}
 #endif /* CONFIG_FS_ENCRYPTION */
 
 #endif
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index fba139a4f57b..a0b311195e80 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -83,12 +83,17 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
 			goto out_err;
 	}
 
+	inode->i_state = 0;
+	inode->i_mode = *mode;
+
 	err = ceph_security_init_secctx(dentry, *mode, as_ctx);
 	if (err < 0)
 		goto out_err;
 
-	inode->i_state = 0;
-	inode->i_mode = *mode;
+	err = ceph_fscrypt_prepare_context(dir, inode, as_ctx);
+	if (err)
+		goto out_err;
+
 	return inode;
 out_err:
 	iput(inode);
@@ -101,6 +106,7 @@ void ceph_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *a
 		req->r_pagelist = as_ctx->pagelist;
 		as_ctx->pagelist = NULL;
 	}
+	ceph_fscrypt_as_ctx_to_req(req, as_ctx);
 }
 
 /**
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 534c2a76562d..651d7909a443 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -26,6 +26,8 @@
 #include <linux/fscache.h>
 #endif
 
+#include "crypto.h"
+
 /* f_type in struct statfs */
 #define CEPH_SUPER_MAGIC 0x00c36400
 
@@ -1068,6 +1070,9 @@ struct ceph_acl_sec_ctx {
 #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
 	void *sec_ctx;
 	u32 sec_ctxlen;
+#endif
+#ifdef CONFIG_FS_ENCRYPTION
+	struct ceph_fscrypt_auth *fscrypt_auth;
 #endif
 	struct ceph_pagelist *pagelist;
 };
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 1242db8d3444..16a62a2bd61e 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1362,6 +1362,9 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
 #endif
 #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
 	security_release_secctx(as_ctx->sec_ctx, as_ctx->sec_ctxlen);
+#endif
+#ifdef CONFIG_FS_ENCRYPTION
+	kfree(as_ctx->fscrypt_auth);
 #endif
 	if (as_ctx->pagelist)
 		ceph_pagelist_release(as_ctx->pagelist);
-- 
2.31.1

