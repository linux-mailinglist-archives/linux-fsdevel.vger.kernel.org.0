Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E484567B149
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjAYLaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbjAYL3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:29:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E313022A33;
        Wed, 25 Jan 2023 03:29:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E8BE614C0;
        Wed, 25 Jan 2023 11:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6C2C4339E;
        Wed, 25 Jan 2023 11:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646189;
        bh=AoICruiO1fmkjMmVCbtvYwyBOmjeAS6gY4YyaNR8wz0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=dF4D8bF47RsyStOaLuvZJIgd6MZaGTgdo5DoiqntT3BlbSbqElPDUPL5cWz6gZT+U
         HyHGVef2rEGo8gGG41m3i8nc8sJqNS1wc6q1Lit5U2iAF2zpdVj46Chd53+jEKiIY0
         9lr+Wg8ErLBAt3M06dVdXmK9gzWxM2M+TZQm2EwHB/fOxiDHw94yHCfgcts9Vcaw9u
         8/7rUzcCg+dUvKBRCmRgkjnk5CS6OJW9K8GE/WnIFGGKIGQvRW0ETscc2SuebUaQxS
         pLgCTwJPYfY1UzxMPEr2vsBXVWfoyMKjmXo3mTGa1B4uY5se67DKY4pxce4LdYy/DY
         zTwvrANTf6PdA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 25 Jan 2023 12:28:56 +0100
Subject: [PATCH 11/12] reiserfs: drop posix acl handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v1-11-6cf155b492b6@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        reiserfs-devel@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3133; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AoICruiO1fmkjMmVCbtvYwyBOmjeAS6gY4YyaNR8wz0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfFJpknfH6FsONWq05LiZuKbdZ9TPV65bNe3A/IVT5Os+p
 7as5OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZiYsfIsGn6vXfqejUrQnScqv9pcG
 5wCJi1aH7rG5PEDdNT1908yM3I8OF1kaT0a2b5s+t/Xub0LG5he8il8C59B5fubMnf06YU8AAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Last cycle we introduced a new posix acl api. Filesystems now only need
to implement the inode operations for posix acls. The generic xattr
handlers aren't used anymore by the vfs and will be completely removed.
Keeping the handler around is confusing and gives the false impression
that the xattr infrastructure of the vfs is used to interact with posix
acls when it really isn't anymore.

For this to work we simply rework the ->listxattr() inode operation to
not rely on the generix posix acl handlers anymore.

Cc: <reiserfs-devel@vger.kernel.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/reiserfs/xattr.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 8b2d52443f41..cc6f42128031 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -52,6 +52,7 @@
 #include <linux/quotaops.h>
 #include <linux/security.h>
 #include <linux/posix_acl_xattr.h>
+#include <linux/xattr.h>
 
 #define PRIVROOT_NAME ".reiserfs_priv"
 #define XAROOT_NAME   "xattrs"
@@ -771,22 +772,26 @@ reiserfs_xattr_get(struct inode *inode, const char *name, void *buffer,
 			(handler) = *(handlers)++)
 
 /* This is the implementation for the xattr plugin infrastructure */
-static inline const struct xattr_handler *
-find_xattr_handler_prefix(const struct xattr_handler **handlers,
-			   const char *name)
+static inline bool reiserfs_xattr_list(const struct xattr_handler **handlers,
+				       const char *name, struct dentry *dentry)
 {
-	const struct xattr_handler *xah;
+	const struct xattr_handler *xah = NULL;
 
-	if (!handlers)
-		return NULL;
+	if (handlers) {
+		for_each_xattr_handler(handlers, xah) {
+			const char *prefix = xattr_prefix(xah);
 
-	for_each_xattr_handler(handlers, xah) {
-		const char *prefix = xattr_prefix(xah);
-		if (strncmp(prefix, name, strlen(prefix)) == 0)
-			break;
+			if (strncmp(prefix, name, strlen(prefix)))
+				continue;
+
+			if (!xattr_dentry_list(xah, dentry))
+				return false;
+
+			return true;
+		}
 	}
 
-	return xah;
+	return (posix_acl_type(name) >= 0) && posix_acl_dentry_list(dentry);
 }
 
 struct listxattr_buf {
@@ -807,12 +812,7 @@ static bool listxattr_filler(struct dir_context *ctx, const char *name,
 
 	if (name[0] != '.' ||
 	    (namelen != 1 && (name[1] != '.' || namelen != 2))) {
-		const struct xattr_handler *handler;
-
-		handler = find_xattr_handler_prefix(b->dentry->d_sb->s_xattr,
-						    name);
-		if (!handler /* Unsupported xattr name */ ||
-		    (handler->list && !handler->list(b->dentry)))
+		if (!reiserfs_xattr_list(b->dentry->d_sb->s_xattr, name, b->dentry))
 			return true;
 		size = namelen + 1;
 		if (b->buf) {
@@ -910,10 +910,6 @@ const struct xattr_handler *reiserfs_xattr_handlers[] = {
 #endif
 #ifdef CONFIG_REISERFS_FS_SECURITY
 	&reiserfs_xattr_security_handler,
-#endif
-#ifdef CONFIG_REISERFS_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
 #endif
 	NULL
 };

-- 
2.34.1

