Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA912FD86D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 19:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392069AbhATSfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 13:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404592AbhATSam (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:30:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6349A23437;
        Wed, 20 Jan 2021 18:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611167334;
        bh=aopFZIIswBol5CqEKZCzp+gBPQnJp+CRdIrCyaLN8qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jKwVZNu1j+eMUTuvq+m4z1R1M0YEjCBZsVOw8rFGEyXsTEFyqguncJ0v549ovFDK8
         EbmOaG+mCoSdstmvYZLdybSBN6RjeEiNT2UsISSU1pCI/yUlFBb6O/6vb5VtI+8baD
         658k9bSMr6U4Yq5np3/GRiy979aU3JlJndorIBWi+osNS424456YPWnKu++K2bTetW
         SPe9XfhuFdznjvaKKPB3USZmQjzHa9dtkpAPTtdecp8KnN3N6YNCQrViTwIPFad20n
         595BtBk0eYEwOVAG8tP9wY7leo7IZrfM1iwTTqUrRfaxBs/HaFuyuiwjzpCI0SjXvV
         9PdejO+eLTRZw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v4 08/17] ceph: add routine to create fscrypt context prior to RPC
Date:   Wed, 20 Jan 2021 13:28:38 -0500
Message-Id: <20210120182847.644850-9-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120182847.644850-1-jlayton@kernel.org>
References: <20210120182847.644850-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After pre-creating a new inode, do an fscrypt prepare on it, fetch a
new encryption context and then marshal that into the security context
to be sent along with the RPC.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h | 12 ++++++++++
 fs/ceph/inode.c  |  9 +++++--
 fs/ceph/super.h  |  3 +++
 4 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 879d9a0d3751..f037a4939026 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -46,3 +46,64 @@ void ceph_fscrypt_set_ops(struct super_block *sb)
 {
 	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
 }
+
+int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
+				 struct ceph_acl_sec_ctx *as)
+{
+	int ret, ctxsize;
+	size_t name_len;
+	char *name;
+	struct ceph_pagelist *pagelist = as->pagelist;
+	bool encrypted = false;
+
+	ret = fscrypt_prepare_new_inode(dir, inode, &encrypted);
+	if (ret)
+		return ret;
+	if (!encrypted)
+		return 0;
+
+	inode->i_flags |= S_ENCRYPTED;
+
+	ctxsize = fscrypt_context_for_new_inode(&as->fscrypt, inode);
+	if (ctxsize < 0)
+		return ctxsize;
+
+	/* marshal it in page array */
+	if (!pagelist) {
+		pagelist = ceph_pagelist_alloc(GFP_KERNEL);
+		if (!pagelist)
+			return -ENOMEM;
+		ret = ceph_pagelist_reserve(pagelist, PAGE_SIZE);
+		if (ret)
+			goto out;
+		ceph_pagelist_encode_32(pagelist, 1);
+	}
+
+	name = CEPH_XATTR_NAME_ENCRYPTION_CONTEXT;
+	name_len = strlen(name);
+	ret = ceph_pagelist_reserve(pagelist, 4 * 2 + name_len + ctxsize);
+	if (ret)
+		goto out;
+
+	if (as->pagelist) {
+		BUG_ON(pagelist->length <= sizeof(__le32));
+		if (list_is_singular(&pagelist->head)) {
+			le32_add_cpu((__le32*)pagelist->mapped_tail, 1);
+		} else {
+			struct page *page = list_first_entry(&pagelist->head,
+							     struct page, lru);
+			void *addr = kmap_atomic(page);
+			le32_add_cpu((__le32*)addr, 1);
+			kunmap_atomic(addr);
+		}
+	}
+
+	ceph_pagelist_encode_32(pagelist, name_len);
+	ceph_pagelist_append(pagelist, name, name_len);
+	ceph_pagelist_encode_32(pagelist, ctxsize);
+	ceph_pagelist_append(pagelist, as->fscrypt, ctxsize);
+out:
+	if (pagelist && !as->pagelist)
+		ceph_pagelist_release(pagelist);
+	return ret;
+}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 0dd043b56096..cc4e481bf13a 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -18,6 +18,9 @@ static inline void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
 	fscrypt_free_dummy_policy(&fsc->dummy_enc_policy);
 }
 
+int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
+				 struct ceph_acl_sec_ctx *as);
+
 #else /* CONFIG_FS_ENCRYPTION */
 
 static inline void ceph_fscrypt_set_ops(struct super_block *sb)
@@ -27,6 +30,15 @@ static inline void ceph_fscrypt_set_ops(struct super_block *sb)
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
 #endif /* CONFIG_FS_ENCRYPTION */
 
 #endif
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d004f294a256..2854711e8988 100644
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
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 7a022c7c38b6..2411813ab552 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1031,6 +1031,9 @@ struct ceph_acl_sec_ctx {
 #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
 	void *sec_ctx;
 	u32 sec_ctxlen;
+#endif
+#ifdef CONFIG_FS_ENCRYPTION
+	u8	fscrypt[FSCRYPT_SET_CONTEXT_MAX_SIZE];
 #endif
 	struct ceph_pagelist *pagelist;
 };
-- 
2.29.2

