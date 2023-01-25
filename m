Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D40467B145
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbjAYLaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbjAYL3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:29:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DD89EF8
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 03:29:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09780B8191A
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 11:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C13AC4339E;
        Wed, 25 Jan 2023 11:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646182;
        bh=xUJebQ0e9KwSrY/Cal4CAWhcfhSdz9RiiwAWxi4+KHc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cozUATMauQjoFoE5hvkPr3B8PLlGiW9MIxmWen0gF5YS0pgPqXF4Pn9S0uVbr+uYc
         p491Vbspem4g0PCceifALOTy6+qpfE5kh/4jStAxD+ZuKyYh0DxthtjJI4hQ7AWHFk
         b/fuJK+2etQRxLoSUz5B53F8exR1AtrjGyeIe12JxcWlBMZ3V+mnl/TttpVH5tUL0q
         gTwehhNG5kDIv5l9NTUrGlkxx3X4kbOtust3QDGfEIg7G3Rs+XCpIss1ACzBvsuqWS
         x1sg9/dCn9u129Cr/KNRlE3sLRhKJRlmxglFod74Z71pw0JW+wAJNfUMcilK9LdLyQ
         y2Rw4Ww0qzb/w==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 25 Jan 2023 12:28:53 +0100
Subject: [PATCH 08/12] f2fs: drop posix acl handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v1-8-6cf155b492b6@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4258; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xUJebQ0e9KwSrY/Cal4CAWhcfhSdz9RiiwAWxi4+KHc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfFJo4R/Ewy9Nf8XlH1lk8Wza9MPAK53VNoYdMX0ydX15S
 m3EqtqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi93sYGbaf/ODb2vt+zuIgaS/j00
 sL73qtV3355daEa3pPt8VtbvFlZLgVWjcxz8ixvPOexxans++qrF/uSFf4VCiod6a0MOLIOS4A
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

Cc: <linux-f2fs-devel@lists.sourceforge.net>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/f2fs/xattr.c | 63 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index dc2e8637189e..e5bd071fac8c 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -189,25 +189,8 @@ const struct xattr_handler f2fs_xattr_security_handler = {
 	.set	= f2fs_xattr_generic_set,
 };
 
-static const struct xattr_handler *f2fs_xattr_handler_map[] = {
-	[F2FS_XATTR_INDEX_USER] = &f2fs_xattr_user_handler,
-#ifdef CONFIG_F2FS_FS_POSIX_ACL
-	[F2FS_XATTR_INDEX_POSIX_ACL_ACCESS] = &posix_acl_access_xattr_handler,
-	[F2FS_XATTR_INDEX_POSIX_ACL_DEFAULT] = &posix_acl_default_xattr_handler,
-#endif
-	[F2FS_XATTR_INDEX_TRUSTED] = &f2fs_xattr_trusted_handler,
-#ifdef CONFIG_F2FS_FS_SECURITY
-	[F2FS_XATTR_INDEX_SECURITY] = &f2fs_xattr_security_handler,
-#endif
-	[F2FS_XATTR_INDEX_ADVISE] = &f2fs_xattr_advise_handler,
-};
-
 const struct xattr_handler *f2fs_xattr_handlers[] = {
 	&f2fs_xattr_user_handler,
-#ifdef CONFIG_F2FS_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 	&f2fs_xattr_trusted_handler,
 #ifdef CONFIG_F2FS_FS_SECURITY
 	&f2fs_xattr_security_handler,
@@ -216,13 +199,44 @@ const struct xattr_handler *f2fs_xattr_handlers[] = {
 	NULL,
 };
 
-static inline const struct xattr_handler *f2fs_xattr_handler(int index)
+static const char *f2fs_xattr_prefix(int xattr_index, struct dentry *dentry)
 {
+	const char *name = NULL;
 	const struct xattr_handler *handler = NULL;
 
-	if (index > 0 && index < ARRAY_SIZE(f2fs_xattr_handler_map))
-		handler = f2fs_xattr_handler_map[index];
-	return handler;
+	switch (xattr_index) {
+	case F2FS_XATTR_INDEX_USER:
+		handler = &f2fs_xattr_user_handler;
+		break;
+	case F2FS_XATTR_INDEX_TRUSTED:
+		handler = &f2fs_xattr_trusted_handler;
+		break;
+	case F2FS_XATTR_INDEX_ADVISE:
+		handler = &f2fs_xattr_advise_handler;
+		break;
+#ifdef CONFIG_F2FS_FS_SECURITY
+	case F2FS_XATTR_INDEX_SECURITY:
+		handler = &f2fs_xattr_security_handler;
+		break;
+#endif
+#ifdef CONFIG_F2FS_FS_POSIX_ACL
+	case F2FS_XATTR_INDEX_POSIX_ACL_ACCESS:
+		if (posix_acl_dentry_list(dentry))
+			name = XATTR_NAME_POSIX_ACL_ACCESS;
+		break;
+	case F2FS_XATTR_INDEX_POSIX_ACL_DEFAULT:
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
 }
 
 static struct f2fs_xattr_entry *__find_xattr(void *base_addr,
@@ -573,12 +587,12 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	last_base_addr = (void *)base_addr + XATTR_SIZE(inode);
 
 	list_for_each_xattr(entry, base_addr) {
-		const struct xattr_handler *handler =
-			f2fs_xattr_handler(entry->e_name_index);
 		const char *prefix;
 		size_t prefix_len;
 		size_t size;
 
+		prefix = f2fs_xattr_prefix(entry->e_name_index, dentry);
+
 		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
 			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
 			f2fs_err(F2FS_I_SB(inode), "inode (%lu) has corrupted xattr",
@@ -590,10 +604,9 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 			goto cleanup;
 		}
 
-		if (!handler || (handler->list && !handler->list(dentry)))
+		if (!prefix)
 			continue;
 
-		prefix = xattr_prefix(handler);
 		prefix_len = strlen(prefix);
 		size = prefix_len + entry->e_name_len + 1;
 		if (buffer) {

-- 
2.34.1

