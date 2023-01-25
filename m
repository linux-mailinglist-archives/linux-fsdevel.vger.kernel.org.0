Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E941F67B146
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjAYLaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbjAYL3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:29:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1540822A33
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 03:29:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A616661356
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 11:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49036C4339C;
        Wed, 25 Jan 2023 11:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646185;
        bh=6r8RQh6tLH90oDxRR8sLeViDQoVA80avbvRgVwUU3Yg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=XMDpKqbpUAVmqDTm7pZEcTXvThgRxpkDZG6NtSYWVWJcCDJ4ZYdSJG/M9J0PIOlLc
         JEQb9AObtaef/Chu2cyOPTd9p55hF5A6Krv6a8ep7zfYg8+4Onr2Lg25SX8yTVlo8b
         ThM9sd6AeyLe8T1d0aGsmiHp+3mhccXL70LA5gXUIh/fP6t6eo7cB9pah6rwDt0Vu+
         a6YucsiQOSurAeM4GvAF6GvD+uGc7qktMEXPLUsuYMT9ywpg/3D2QBNQcfjAAOsLlk
         WngOziFjEPfV+/PQYsSRgBIPxHfWj54SB/DrGNELcKMeFWoBPS/S4APE//9ciR8kMu
         0FeMmMO9MtthQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 25 Jan 2023 12:28:54 +0100
Subject: [PATCH 09/12] jffs2: drop posix acl handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v1-9-6cf155b492b6@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        linux-mtd@lists.infradead.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3423; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6r8RQh6tLH90oDxRR8sLeViDQoVA80avbvRgVwUU3Yg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfFJp05d+95bf+fmCyPWl0U6v0p6vtw/e5F6S+PJ15bNrZ
 z677eTpKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmkj6XkeFy0LJJL9/naQo/EEi2eP
 t5XYH6vCeO6g5C+ur6Bg6vwmUYGa43NLzrOTbrj6pMeecD45Ufp2hLdjwKrpin+CB9nVqSMjsA
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

Cc: <linux-mtd@lists.infradead.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/jffs2/xattr.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index da3e18503c65..40cf03dc34be 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -919,43 +919,46 @@ const struct xattr_handler *jffs2_xattr_handlers[] = {
 	&jffs2_user_xattr_handler,
 #ifdef CONFIG_JFFS2_FS_SECURITY
 	&jffs2_security_xattr_handler,
-#endif
-#ifdef CONFIG_JFFS2_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
 #endif
 	&jffs2_trusted_xattr_handler,
 	NULL
 };
 
-static const struct xattr_handler *xprefix_to_handler(int xprefix) {
-	const struct xattr_handler *ret;
+static const char *jffs2_xattr_prefix(int xprefix, struct dentry *dentry)
+{
+	const char *name = NULL;
+	const struct xattr_handler *handler = NULL;
 
 	switch (xprefix) {
 	case JFFS2_XPREFIX_USER:
-		ret = &jffs2_user_xattr_handler;
+		handler = &jffs2_user_xattr_handler;
+		break;
+	case JFFS2_XPREFIX_TRUSTED:
+		handler = &jffs2_trusted_xattr_handler;
 		break;
 #ifdef CONFIG_JFFS2_FS_SECURITY
 	case JFFS2_XPREFIX_SECURITY:
-		ret = &jffs2_security_xattr_handler;
+		handler = &jffs2_security_xattr_handler;
 		break;
 #endif
 #ifdef CONFIG_JFFS2_FS_POSIX_ACL
 	case JFFS2_XPREFIX_ACL_ACCESS:
-		ret = &posix_acl_access_xattr_handler;
+		if (posix_acl_dentry_list(dentry))
+			name = XATTR_NAME_POSIX_ACL_ACCESS;
 		break;
 	case JFFS2_XPREFIX_ACL_DEFAULT:
-		ret = &posix_acl_default_xattr_handler;
+		if (posix_acl_dentry_list(dentry))
+			name = XATTR_NAME_POSIX_ACL_DEFAULT;
 		break;
 #endif
-	case JFFS2_XPREFIX_TRUSTED:
-		ret = &jffs2_trusted_xattr_handler;
-		break;
 	default:
-		ret = NULL;
-		break;
+		return NULL;
 	}
-	return ret;
+
+	if (xattr_dentry_list(handler, dentry))
+		name = xattr_prefix(handler);
+
+	return name;
 }
 
 ssize_t jffs2_listxattr(struct dentry *dentry, char *buffer, size_t size)
@@ -966,7 +969,6 @@ ssize_t jffs2_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	struct jffs2_inode_cache *ic = f->inocache;
 	struct jffs2_xattr_ref *ref, **pref;
 	struct jffs2_xattr_datum *xd;
-	const struct xattr_handler *xhandle;
 	const char *prefix;
 	ssize_t prefix_len, len, rc;
 	int retry = 0;
@@ -998,10 +1000,10 @@ ssize_t jffs2_listxattr(struct dentry *dentry, char *buffer, size_t size)
 					goto out;
 			}
 		}
-		xhandle = xprefix_to_handler(xd->xprefix);
-		if (!xhandle || (xhandle->list && !xhandle->list(dentry)))
+
+		prefix = jffs2_xattr_prefix(xd->xprefix, dentry);
+		if (!prefix)
 			continue;
-		prefix = xhandle->prefix ?: xhandle->name;
 		prefix_len = strlen(prefix);
 		rc = prefix_len + xd->name_len + 1;
 

-- 
2.34.1

