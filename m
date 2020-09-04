Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411D825DF29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgIDQG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 12:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbgIDQFt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:49 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA4572083B;
        Fri,  4 Sep 2020 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599235549;
        bh=BQfNQlXBWGlmek8meSrqiCDPcJzfLmLuww5iCSFHPlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xv0l7EAOyfs0KUTbSLd1j3ELpP1Q6yxaWBl9Bu0mbQYvynqXexJjTXsSTYd1rvLjn
         Lz/FVgNipDkSuXBEDvGs6A5j0g/gYZiYLyEQnJQlGzdAjndhc05QL2R63ngP9aDITY
         tz0vJlggOp84rreNIWfT1GXMsDoM35q5ZWkQdpvc=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        ebiggers@kernel.org
Subject: [RFC PATCH v2 12/18] ceph: set S_ENCRYPTED bit if new inode has encryption.ctx xattr
Date:   Fri,  4 Sep 2020 12:05:31 -0400
Message-Id: <20200904160537.76663-13-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904160537.76663-1-jlayton@kernel.org>
References: <20200904160537.76663-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This hack fixes a chicken-and-egg problem when fetching inodes from the
server. Once we move to a dedicated field in the inode, then this should
be able to go away.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.h |  4 ++++
 fs/ceph/inode.c  |  4 ++++
 fs/ceph/super.h  |  1 +
 fs/ceph/xattr.c  | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index bf893bd215c3..1b11e9af165e 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -10,12 +10,16 @@
 
 #define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
 
+#define DUMMY_ENCRYPTION_ENABLED(fsc) ((fsc)->dummy_enc_ctx.ctx != NULL)
+
 int ceph_fscrypt_set_ops(struct super_block *sb);
 int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
 				 struct ceph_acl_sec_ctx *as);
 
 #else /* CONFIG_FS_ENCRYPTION */
 
+#define DUMMY_ENCRYPTION_ENABLED(fsc) (0)
+
 static inline int ceph_fscrypt_set_ops(struct super_block *sb)
 {
 	return 0;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 651148194316..c1c1fe2547f9 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -964,6 +964,10 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		ceph_forget_all_cached_acls(inode);
 		ceph_security_invalidate_secctx(inode);
 		xattr_blob = NULL;
+		if ((inode->i_state & I_NEW) &&
+		    (DUMMY_ENCRYPTION_ENABLED(mdsc->fsc) ||
+		     ceph_inode_has_xattr(ci, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT)))
+			inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
 	}
 
 	/* finally update i_version */
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index cf04fcd3de69..7c859824f64c 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -986,6 +986,7 @@ extern ssize_t ceph_listxattr(struct dentry *, char *, size_t);
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

