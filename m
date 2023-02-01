Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA76968668C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjBANPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjBANPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:15:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1D2646AE
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 05:15:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0B686CE2426
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 13:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035FAC433A8;
        Wed,  1 Feb 2023 13:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675257335;
        bh=xRL3CLNYMxzjNcfbgAs2TX+KhWFl4oySTDmnNTc5V2k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rST/YXAFG59TczlGpH8Vvw1ZOINsycBFd1pv+jx/e3Oaj858U1h6+tDW2F3akZUkq
         RRx9JaaubsqYpczBPJ5G7DtSEEF94/iNopNXXpcYdhCcHPpdH3gOQEtCjr2c+NgR4l
         kO5Bw6SmqESztLVO3xs1p5Wy4UvmMErBnUnGo7/DREA3D08zQcg2bl1PIfaim1X8QU
         o+ptVP+abnvWbtZ1/YayPiOSXS8anPhNC6QQucFujmvdatrwdaFQ4mOeHo2S8huiTd
         sTNdCdEPlhP3U43ON4GJ54YPsgJowzRVsuafLueI1+WPNv/n8KF9yMh/yOzjaPg/WN
         ow5gKehV4eUuw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 01 Feb 2023 14:14:52 +0100
Subject: [PATCH v3 01/10] xattr: simplify listxattr helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v3-1-f760cc58967d@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6373; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xRL3CLNYMxzjNcfbgAs2TX+KhWFl4oySTDmnNTc5V2k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTfSv34x8VzWXlZ+vQLzt2LXO7Ha50IvvPPZHmk1MEu+1OB
 S48e6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI9hyG/9HG9o7HS4OnGyWHCPKl2L
 LJJ0Tcn5MsWt91S2WuIfdcc4Y/HNHlz9U1/tlYG/Ql2r4x+Blja6B1dIPibdVTq31EdzjwAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The generic_listxattr() and simple_xattr_list() helpers list xattrs and
contain duplicated code. Add two helpers that both generic_listxattr()
and simple_xattr_list() can use.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v3:
  - Patch unchanged.

Changes in v2:
- Christoph Hellwig <hch@lst.de>:
  - Leave newline after variable declaration in xattr_list_one().
  - Move posix_acl_listxattr() into fs/posix_acl.c.
---
 fs/posix_acl.c            | 25 +++++++++++++
 fs/xattr.c                | 89 ++++++++++++++++++-----------------------------
 include/linux/posix_acl.h |  7 ++++
 include/linux/xattr.h     |  1 +
 4 files changed, 66 insertions(+), 56 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index d7bc81fc0840..c0886dc8e714 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -958,6 +958,31 @@ set_posix_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 }
 EXPORT_SYMBOL(set_posix_acl);
 
+int posix_acl_listxattr(struct inode *inode, char **buffer,
+			ssize_t *remaining_size)
+{
+	int err;
+
+	if (!IS_POSIXACL(inode))
+		return 0;
+
+	if (inode->i_acl) {
+		err = xattr_list_one(buffer, remaining_size,
+				     XATTR_NAME_POSIX_ACL_ACCESS);
+		if (err)
+			return err;
+	}
+
+	if (inode->i_default_acl) {
+		err = xattr_list_one(buffer, remaining_size,
+				     XATTR_NAME_POSIX_ACL_DEFAULT);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static bool
 posix_acl_xattr_list(struct dentry *dentry)
 {
diff --git a/fs/xattr.c b/fs/xattr.c
index adab9a70b536..20a562d431fe 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -949,6 +949,21 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 	return error;
 }
 
+int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name)
+{
+	size_t len;
+
+	len = strlen(name) + 1;
+	if (*buffer) {
+		if (*remaining_size < len)
+			return -ERANGE;
+		memcpy(*buffer, name, len);
+		*buffer += len;
+	}
+	*remaining_size -= len;
+	return 0;
+}
+
 /*
  * Combine the results of the list() operation from every xattr_handler in the
  * list.
@@ -957,33 +972,22 @@ ssize_t
 generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
 	const struct xattr_handler *handler, **handlers = dentry->d_sb->s_xattr;
-	unsigned int size = 0;
-
-	if (!buffer) {
-		for_each_xattr_handler(handlers, handler) {
-			if (!handler->name ||
-			    (handler->list && !handler->list(dentry)))
-				continue;
-			size += strlen(handler->name) + 1;
-		}
-	} else {
-		char *buf = buffer;
-		size_t len;
-
-		for_each_xattr_handler(handlers, handler) {
-			if (!handler->name ||
-			    (handler->list && !handler->list(dentry)))
-				continue;
-			len = strlen(handler->name);
-			if (len + 1 > buffer_size)
-				return -ERANGE;
-			memcpy(buf, handler->name, len + 1);
-			buf += len + 1;
-			buffer_size -= len + 1;
-		}
-		size = buf - buffer;
+	ssize_t remaining_size = buffer_size;
+	int err = 0;
+
+	err = posix_acl_listxattr(d_inode(dentry), &buffer, &remaining_size);
+	if (err)
+		return err;
+
+	for_each_xattr_handler(handlers, handler) {
+		if (!handler->name || (handler->list && !handler->list(dentry)))
+			continue;
+		err = xattr_list_one(&buffer, &remaining_size, handler->name);
+		if (err)
+			return err;
 	}
-	return size;
+
+	return err ? err : buffer_size - remaining_size;
 }
 EXPORT_SYMBOL(generic_listxattr);
 
@@ -1245,20 +1249,6 @@ static bool xattr_is_trusted(const char *name)
 	return !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN);
 }
 
-static int xattr_list_one(char **buffer, ssize_t *remaining_size,
-			  const char *name)
-{
-	size_t len = strlen(name) + 1;
-	if (*buffer) {
-		if (*remaining_size < len)
-			return -ERANGE;
-		memcpy(*buffer, name, len);
-		*buffer += len;
-	}
-	*remaining_size -= len;
-	return 0;
-}
-
 /**
  * simple_xattr_list - list all xattr objects
  * @inode: inode from which to get the xattrs
@@ -1287,22 +1277,9 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	ssize_t remaining_size = size;
 	int err = 0;
 
-#ifdef CONFIG_FS_POSIX_ACL
-	if (IS_POSIXACL(inode)) {
-		if (inode->i_acl) {
-			err = xattr_list_one(&buffer, &remaining_size,
-					     XATTR_NAME_POSIX_ACL_ACCESS);
-			if (err)
-				return err;
-		}
-		if (inode->i_default_acl) {
-			err = xattr_list_one(&buffer, &remaining_size,
-					     XATTR_NAME_POSIX_ACL_DEFAULT);
-			if (err)
-				return err;
-		}
-	}
-#endif
+	err = posix_acl_listxattr(inode, &buffer, &remaining_size);
+	if (err)
+		return err;
 
 	read_lock(&xattrs->lock);
 	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index ee608d22ecb9..e7995c68f641 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -106,6 +106,8 @@ struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
 			      struct dentry *dentry, const char *acl_name);
 int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		   const char *acl_name);
+int posix_acl_listxattr(struct inode *inode, char **buffer,
+			ssize_t *remaining_size);
 #else
 static inline int posix_acl_chmod(struct user_namespace *mnt_userns,
 				  struct dentry *dentry, umode_t mode)
@@ -153,6 +155,11 @@ static inline int vfs_remove_acl(struct user_namespace *mnt_userns,
 {
 	return -EOPNOTSUPP;
 }
+static inline int posix_acl_listxattr(struct inode *inode, char **buffer,
+				      ssize_t *remaining_size)
+{
+	return 0;
+}
 #endif /* CONFIG_FS_POSIX_ACL */
 
 struct posix_acl *get_inode_acl(struct inode *inode, int type);
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 2e7dd44926e4..74b7770880a7 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -109,5 +109,6 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 			  char *buffer, size_t size);
 void simple_xattr_add(struct simple_xattrs *xattrs,
 		      struct simple_xattr *new_xattr);
+int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name);
 
 #endif	/* _LINUX_XATTR_H */

-- 
2.34.1

