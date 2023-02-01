Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7275E686698
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjBANQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjBANQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:16:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C85646BA
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 05:15:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A179DB82171
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 13:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EF2C4339E;
        Wed,  1 Feb 2023 13:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675257346;
        bh=hg2fr8Ft7Ei4dJ/Ao/3kUCrMOL9R+3e13PWgvGR/NBs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=TWgU1SYU/FNtGYFcK7qnEOq1ttDSG4I+iOPfa0Y61per9FI0i7eNLxjYHOmWQW9fd
         CgQcFi4uW1eihPz7kk5ys+qrXJeTXQFXJ6M4RWsL2en99jGfHeA7gDuK7Y2+gaCcvo
         eMWvQL/xmRviLdwaTSp28RAo7fmc6F744CAbp+Ch+Q1xWF2fmrvks1nBNOouVpa9UB
         tp9Nu4w2Gwd09SyG3V3nx5fLFvdUdsEWo416tyIh53vIthLOZQoqI/f98bsIzrtp3H
         YOkHNUg+UjPIZ8e5bVWQHIMFFNanc2IwLaOVm6ysDXariyaSAT7RalzJrcXzEBguN3
         X8fqjkhq8G1JQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 01 Feb 2023 14:14:58 +0100
Subject: [PATCH v3 07/10] fs: rename generic posix acl handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v3-7-f760cc58967d@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7635; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hg2fr8Ft7Ei4dJ/Ao/3kUCrMOL9R+3e13PWgvGR/NBs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTfSv10KyzsevtnG7Hnefnc66JevecKfeR0MWrh7k3nihW8
 1ref6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgI/z+Gf2qr9O+o22VFm21vXrlz2a
 qj+a9uCJfxxRy9qMkXHnsnMY3hr7jUu9CkxLvHecpeydyZebj2ovxB4fQ9fX/+S7Pvlz5bxAcA
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

Reflect in their naming and document that they are kept around for
legacy reasons and shouldn't be used anymore by new code.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v3:
  - Patch unchanged.

Changes in v2:
- Patch introduced.
---
 fs/erofs/xattr.h                |  6 ++----
 fs/ext2/xattr.c                 |  4 ++--
 fs/ext4/xattr.c                 |  4 ++--
 fs/f2fs/xattr.c                 |  4 ++--
 fs/jffs2/xattr.c                |  4 ++--
 fs/ocfs2/xattr.c                | 12 +++++-------
 fs/posix_acl.c                  | 24 ++++++++++++++++++------
 include/linux/posix_acl_xattr.h |  5 +++--
 8 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 08658e414c33..97185cb649b6 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -49,10 +49,8 @@ static inline const char *erofs_xattr_prefix(unsigned int idx,
 	static const struct xattr_handler *xattr_handler_map[] = {
 		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
-		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] =
-			&posix_acl_access_xattr_handler,
-		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] =
-			&posix_acl_default_xattr_handler,
+		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] = &nop_posix_acl_access,
+		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] = &nop_posix_acl_default,
 #endif
 		[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
 #ifdef CONFIG_EROFS_FS_SECURITY
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 958976f809f5..b126af5f8b15 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -101,8 +101,8 @@ static void ext2_xattr_rehash(struct ext2_xattr_header *,
 static const struct xattr_handler *ext2_xattr_handler_map[] = {
 	[EXT2_XATTR_INDEX_USER]		     = &ext2_xattr_user_handler,
 #ifdef CONFIG_EXT2_FS_POSIX_ACL
-	[EXT2_XATTR_INDEX_POSIX_ACL_ACCESS]  = &posix_acl_access_xattr_handler,
-	[EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT] = &posix_acl_default_xattr_handler,
+	[EXT2_XATTR_INDEX_POSIX_ACL_ACCESS]  = &nop_posix_acl_access,
+	[EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT] = &nop_posix_acl_default,
 #endif
 	[EXT2_XATTR_INDEX_TRUSTED]	     = &ext2_xattr_trusted_handler,
 #ifdef CONFIG_EXT2_FS_SECURITY
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 3fbeeb00fd78..edca79a62bd9 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -88,8 +88,8 @@ static void ext4_xattr_rehash(struct ext4_xattr_header *);
 static const struct xattr_handler * const ext4_xattr_handler_map[] = {
 	[EXT4_XATTR_INDEX_USER]		     = &ext4_xattr_user_handler,
 #ifdef CONFIG_EXT4_FS_POSIX_ACL
-	[EXT4_XATTR_INDEX_POSIX_ACL_ACCESS]  = &posix_acl_access_xattr_handler,
-	[EXT4_XATTR_INDEX_POSIX_ACL_DEFAULT] = &posix_acl_default_xattr_handler,
+	[EXT4_XATTR_INDEX_POSIX_ACL_ACCESS]  = &nop_posix_acl_access,
+	[EXT4_XATTR_INDEX_POSIX_ACL_DEFAULT] = &nop_posix_acl_default,
 #endif
 	[EXT4_XATTR_INDEX_TRUSTED]	     = &ext4_xattr_trusted_handler,
 #ifdef CONFIG_EXT4_FS_SECURITY
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 9de984645253..7eb9628478c8 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -192,8 +192,8 @@ const struct xattr_handler f2fs_xattr_security_handler = {
 static const struct xattr_handler *f2fs_xattr_handler_map[] = {
 	[F2FS_XATTR_INDEX_USER] = &f2fs_xattr_user_handler,
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
-	[F2FS_XATTR_INDEX_POSIX_ACL_ACCESS] = &posix_acl_access_xattr_handler,
-	[F2FS_XATTR_INDEX_POSIX_ACL_DEFAULT] = &posix_acl_default_xattr_handler,
+	[F2FS_XATTR_INDEX_POSIX_ACL_ACCESS] = &nop_posix_acl_access,
+	[F2FS_XATTR_INDEX_POSIX_ACL_DEFAULT] = &nop_posix_acl_default,
 #endif
 	[F2FS_XATTR_INDEX_TRUSTED] = &f2fs_xattr_trusted_handler,
 #ifdef CONFIG_F2FS_FS_SECURITY
diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index 1189a70d2007..aa4048a27f31 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -939,10 +939,10 @@ static const char *jffs2_xattr_prefix(int xprefix, struct dentry *dentry)
 #endif
 #ifdef CONFIG_JFFS2_FS_POSIX_ACL
 	case JFFS2_XPREFIX_ACL_ACCESS:
-		ret = &posix_acl_access_xattr_handler;
+		ret = &nop_posix_acl_access;
 		break;
 	case JFFS2_XPREFIX_ACL_DEFAULT:
-		ret = &posix_acl_default_xattr_handler;
+		ret = &nop_posix_acl_default;
 		break;
 #endif
 	case JFFS2_XPREFIX_TRUSTED:
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 482b2ef7ca54..ff85e418d7e3 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -95,13 +95,11 @@ const struct xattr_handler *ocfs2_xattr_handlers[] = {
 };
 
 static const struct xattr_handler *ocfs2_xattr_handler_map[OCFS2_XATTR_MAX] = {
-	[OCFS2_XATTR_INDEX_USER]	= &ocfs2_xattr_user_handler,
-	[OCFS2_XATTR_INDEX_POSIX_ACL_ACCESS]
-					= &posix_acl_access_xattr_handler,
-	[OCFS2_XATTR_INDEX_POSIX_ACL_DEFAULT]
-					= &posix_acl_default_xattr_handler,
-	[OCFS2_XATTR_INDEX_TRUSTED]	= &ocfs2_xattr_trusted_handler,
-	[OCFS2_XATTR_INDEX_SECURITY]	= &ocfs2_xattr_security_handler,
+	[OCFS2_XATTR_INDEX_USER]		= &ocfs2_xattr_user_handler,
+	[OCFS2_XATTR_INDEX_POSIX_ACL_ACCESS]	= &nop_posix_acl_access,
+	[OCFS2_XATTR_INDEX_POSIX_ACL_DEFAULT]	= &nop_posix_acl_default,
+	[OCFS2_XATTR_INDEX_TRUSTED]		= &ocfs2_xattr_trusted_handler,
+	[OCFS2_XATTR_INDEX_SECURITY]		= &ocfs2_xattr_security_handler,
 };
 
 struct ocfs2_xattr_info {
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index c0886dc8e714..7a4d89897c37 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -989,19 +989,31 @@ posix_acl_xattr_list(struct dentry *dentry)
 	return IS_POSIXACL(d_backing_inode(dentry));
 }
 
-const struct xattr_handler posix_acl_access_xattr_handler = {
+/*
+ * nop_posix_acl_access - legacy xattr handler for access POSIX ACLs
+ *
+ * This is the legacy POSIX ACL access xattr handler. It is used by some
+ * filesystems to implement their ->listxattr() inode operation. New code
+ * should never use them.
+ */
+const struct xattr_handler nop_posix_acl_access = {
 	.name = XATTR_NAME_POSIX_ACL_ACCESS,
-	.flags = ACL_TYPE_ACCESS,
 	.list = posix_acl_xattr_list,
 };
-EXPORT_SYMBOL_GPL(posix_acl_access_xattr_handler);
+EXPORT_SYMBOL_GPL(nop_posix_acl_access);
 
-const struct xattr_handler posix_acl_default_xattr_handler = {
+/*
+ * nop_posix_acl_default - legacy xattr handler for default POSIX ACLs
+ *
+ * This is the legacy POSIX ACL default xattr handler. It is used by some
+ * filesystems to implement their ->listxattr() inode operation. New code
+ * should never use them.
+ */
+const struct xattr_handler nop_posix_acl_default = {
 	.name = XATTR_NAME_POSIX_ACL_DEFAULT,
-	.flags = ACL_TYPE_DEFAULT,
 	.list = posix_acl_xattr_list,
 };
-EXPORT_SYMBOL_GPL(posix_acl_default_xattr_handler);
+EXPORT_SYMBOL_GPL(nop_posix_acl_default);
 
 int simple_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		   struct posix_acl *acl, int type)
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index 54cd7a14330d..e86f3b731da2 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -68,7 +68,8 @@ static inline int posix_acl_type(const char *name)
 	return -1;
 }
 
-extern const struct xattr_handler posix_acl_access_xattr_handler;
-extern const struct xattr_handler posix_acl_default_xattr_handler;
+/* These are legacy handlers. Don't use them for new code. */
+extern const struct xattr_handler nop_posix_acl_access;
+extern const struct xattr_handler nop_posix_acl_default;
 
 #endif	/* _POSIX_ACL_XATTR_H */

-- 
2.34.1

