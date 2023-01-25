Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A310E67B142
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbjAYLaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbjAYL3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:29:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE8C27997
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 03:29:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C21C9B81991
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 11:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBB6C4339E;
        Wed, 25 Jan 2023 11:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646175;
        bh=MKSA4pnIEhyA1wK9ZUCK91ZgbKvksc8BYw8SfMd3xXc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QJJ9Z4WN0Il91E9PeY3JoUgIo3rpqItLB+HW8PAn6mqk1rzueejoBMJvnXTLLwcr2
         XnNjOTXls/1LFQ+ovVV/pE9q5YW5c99H1FlfG1227ZqKsu1yjQMuQejfRsHp3lQ15c
         N9iVmCDrzVPZvU+rrQ3dOE1h4LQJ34lekKR3NDfTeS/IczFi83yn7O8nCC66T5xoy4
         WQ6SFejNtnSoMNNJRKSK96N6hLOb48cbLptc19AP5YVk/vV5EIBxXznBn4NJf5Emit
         KqWeXb3Gt7x7nh13hUQkSadcYcNyThkR8MPZQc2e+a8l1o9wyo+eniKJLhGsA7FVB/
         7LfKr6EbQoujQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 25 Jan 2023 12:28:50 +0100
Subject: [PATCH 05/12] erofs: drop posix acl handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v1-5-6cf155b492b6@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        linux-erofs@lists.ozlabs.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4168; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MKSA4pnIEhyA1wK9ZUCK91ZgbKvksc8BYw8SfMd3xXc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfFJqYwrjvz0nn9CnfdzjMikjas9H8cRb/tDevlZI6di5T
 C9VY01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRDlNGhtUNKxrZNT8xzzWLOPaG/e
 bhA7v/nRH+/XfKJDPrJ/22ovsZGRZXWp/6eNc6O/mSucH+qvlrNCbeuB58ty7vqLNrzOld37kA
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

Cc: <linux-erofs@lists.ozlabs.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/erofs/xattr.c | 49 +++++++++++++++++++++++++++++++++++++++----------
 fs/erofs/xattr.h | 21 ---------------------
 2 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index a62fb8a3318a..a787e74d9a21 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -469,10 +469,6 @@ const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
 
 const struct xattr_handler *erofs_xattr_handlers[] = {
 	&erofs_xattr_user_handler,
-#ifdef CONFIG_EROFS_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	&erofs_xattr_trusted_handler,
 #ifdef CONFIG_EROFS_FS_SECURITY
 	&erofs_xattr_security_handler,
@@ -480,6 +476,43 @@ const struct xattr_handler *erofs_xattr_handlers[] = {
 	NULL,
 };
 
+static const char *erofs_xattr_prefix(int xattr_index, struct dentry *dentry)
+{
+	const char *name = NULL;
+	const struct xattr_handler *handler = NULL;
+
+	switch (xattr_index) {
+	case EROFS_XATTR_INDEX_USER:
+		handler = &erofs_xattr_user_handler;
+		break;
+	case EROFS_XATTR_INDEX_TRUSTED:
+		handler = &erofs_xattr_trusted_handler;
+		break;
+#ifdef CONFIG_EROFS_FS_SECURITY
+	case EROFS_XATTR_INDEX_SECURITY:
+		handler = &erofs_xattr_security_handler;
+		break;
+#endif
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+	case EROFS_XATTR_INDEX_POSIX_ACL_ACCESS:
+		if (posix_acl_dentry_list(dentry))
+			name = XATTR_NAME_POSIX_ACL_ACCESS;
+		break;
+	case EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT:
+		if (posix_acl_dentry_list(dentry))
+			name = XATTR_NAME_POSIX_ACL_DEFAULT;
+		break;
+#endif
+	default:
+		return NULL;
+	}
+
+	if (xattr_dentry_list(handler, dentry))
+		name = xattr_prefix(handler);
+
+	return name;
+}
+
 struct listxattr_iter {
 	struct xattr_iter it;
 
@@ -496,13 +529,9 @@ static int xattr_entrylist(struct xattr_iter *_it,
 	unsigned int prefix_len;
 	const char *prefix;
 
-	const struct xattr_handler *h =
-		erofs_xattr_handler(entry->e_name_index);
-
-	if (!h || (h->list && !h->list(it->dentry)))
+	prefix = erofs_xattr_prefix(entry->e_name_index, it->dentry);
+	if (!prefix)
 		return 1;
-
-	prefix = xattr_prefix(h);
 	prefix_len = strlen(prefix);
 
 	if (!it->buffer) {
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 0a43c9ee9f8f..9376cbdc32d8 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -40,27 +40,6 @@ static inline unsigned int xattrblock_offset(struct erofs_sb_info *sbi,
 extern const struct xattr_handler erofs_xattr_user_handler;
 extern const struct xattr_handler erofs_xattr_trusted_handler;
 extern const struct xattr_handler erofs_xattr_security_handler;
-
-static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
-{
-	static const struct xattr_handler *xattr_handler_map[] = {
-		[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
-#ifdef CONFIG_EROFS_FS_POSIX_ACL
-		[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] =
-			&posix_acl_access_xattr_handler,
-		[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] =
-			&posix_acl_default_xattr_handler,
-#endif
-		[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
-#ifdef CONFIG_EROFS_FS_SECURITY
-		[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
-#endif
-	};
-
-	return idx && idx < ARRAY_SIZE(xattr_handler_map) ?
-		xattr_handler_map[idx] : NULL;
-}
-
 extern const struct xattr_handler *erofs_xattr_handlers[];
 
 int erofs_getxattr(struct inode *, int, const char *, void *, size_t);

-- 
2.34.1

