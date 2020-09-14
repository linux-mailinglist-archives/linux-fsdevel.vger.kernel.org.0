Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B291D26957A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 21:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgINTSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 15:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgINTRW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:17:22 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3303B21D91;
        Mon, 14 Sep 2020 19:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600111036;
        bh=btTEcRUvovo9eM8ALgUeV772dDFfWUN70APNw+oWhmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNlrjbMCLk61aB7TLVH0W3zo8vgKl2H5zNDHV1Pnt6u5Ri8kai9+wZgdmI0rNbt1F
         kJiTL7Dj12JSEIxf2BlN/lYRaa2zEoCy4SobmRp7j9fe6nlkkUorPJ4p9J6w2lFSWt
         hsJE2VgTXyH1fIQj42ND0N5d377E78mYj7612opA=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v3 10/16] ceph: add routine to create context prior to RPC
Date:   Mon, 14 Sep 2020 15:17:01 -0400
Message-Id: <20200914191707.380444-11-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914191707.380444-1-jlayton@kernel.org>
References: <20200914191707.380444-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After pre-creating a new inode, do an fscrypt prepare on it, fetch a
new encryption context and then marshal that into the security context
to be sent along with the RPC.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h |  8 +++++++
 fs/ceph/inode.c  | 10 ++++++--
 fs/ceph/super.h  |  3 +++
 4 files changed, 80 insertions(+), 2 deletions(-)

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
index b5f38ee80553..c1b6ec4b2961 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -11,6 +11,8 @@
 #define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
 
 void ceph_fscrypt_set_ops(struct super_block *sb);
+int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
+				 struct ceph_acl_sec_ctx *as);
 
 #else /* CONFIG_FS_ENCRYPTION */
 
@@ -19,6 +21,12 @@ static inline int ceph_fscrypt_set_ops(struct super_block *sb)
 	return 0;
 }
 
+static inline int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
+						struct ceph_acl_sec_ctx *as)
+{
+	return 0;
+}
+
 #endif /* CONFIG_FS_ENCRYPTION */
 
 #endif
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index f50e7873bf6e..2fda08518312 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -18,6 +18,7 @@
 #include "super.h"
 #include "mds_client.h"
 #include "cache.h"
+#include "crypto.h"
 #include <linux/ceph/decode.h>
 
 /*
@@ -73,12 +74,17 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
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
index c05ed00035ec..5d5283552c03 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1003,6 +1003,9 @@ struct ceph_acl_sec_ctx {
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
2.26.2

