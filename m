Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2CC67B143
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjAYLaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbjAYL3n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:29:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033FE244B7;
        Wed, 25 Jan 2023 03:29:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 834EEB81990;
        Wed, 25 Jan 2023 11:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C0DC4339B;
        Wed, 25 Jan 2023 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646178;
        bh=/aCnVtMqRsFxCKOkrIG2QAmkVkNmJ/VxqZjQsKF8mpU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=l8PIjUpeoAhBCrIPONenXO3sNukZhJdLUwWEz9P23/doB8yRRd/4xZP4X5eSg1Li8
         drhmb5M54dknXeHwMP/LBMgnJcMN3iEKmBjGLlTw48tnilBqTQFN62jnyqFB4RQdQD
         JFhTSkVBz9At5Rw/PkZZGkDybaAM4+shzOx8NRg1Ua8zZZeq5xX0fwMwr8yCi6Dbb4
         IwmIBiBDQ3JbXlRR/S1XXEqUPG0djYve7zKgn/SAOEJAFhnKZn7J2yHJ4XabTrE3qY
         k2DdbSej0fscOVHZ6Pil43xn6JW/Zg78BIs/LWSoZ1xJaA/FnB1tk5qY/6wsD5rvYT
         XcGWQY6MY4q/g==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 25 Jan 2023 12:28:51 +0100
Subject: [PATCH 06/12] ext2: drop posix acl handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v1-6-6cf155b492b6@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3928; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/aCnVtMqRsFxCKOkrIG2QAmkVkNmJ/VxqZjQsKF8mpU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfFJp4+UPud5NDUzkv3hb8vuhwjKvegwtvl6+7+vnOtWUK
 tjwV1zpKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmErODkaH7u+Y8X6nDT8R+1Sd+fn
 xUrs9+icrd2Fk7W30+ZB78PPEQw/8IN/mj1pvCGV34+0M5FHnnMNg32wt+nHn4pkKZ2KYX/CwA
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

Cc: Jan Kara <jack@suse.com>
Cc: <linux-ext4@vger.kernel.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/ext2/xattr.c | 60 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 641abfa4b718..86ba6a33349e 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -98,25 +98,9 @@ static struct buffer_head *ext2_xattr_cache_find(struct inode *,
 static void ext2_xattr_rehash(struct ext2_xattr_header *,
 			      struct ext2_xattr_entry *);
 
-static const struct xattr_handler *ext2_xattr_handler_map[] = {
-	[EXT2_XATTR_INDEX_USER]		     = &ext2_xattr_user_handler,
-#ifdef CONFIG_EXT2_FS_POSIX_ACL
-	[EXT2_XATTR_INDEX_POSIX_ACL_ACCESS]  = &posix_acl_access_xattr_handler,
-	[EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT] = &posix_acl_default_xattr_handler,
-#endif
-	[EXT2_XATTR_INDEX_TRUSTED]	     = &ext2_xattr_trusted_handler,
-#ifdef CONFIG_EXT2_FS_SECURITY
-	[EXT2_XATTR_INDEX_SECURITY]	     = &ext2_xattr_security_handler,
-#endif
-};
-
 const struct xattr_handler *ext2_xattr_handlers[] = {
 	&ext2_xattr_user_handler,
 	&ext2_xattr_trusted_handler,
-#ifdef CONFIG_EXT2_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 #ifdef CONFIG_EXT2_FS_SECURITY
 	&ext2_xattr_security_handler,
 #endif
@@ -125,14 +109,41 @@ const struct xattr_handler *ext2_xattr_handlers[] = {
 
 #define EA_BLOCK_CACHE(inode)	(EXT2_SB(inode->i_sb)->s_ea_block_cache)
 
-static inline const struct xattr_handler *
-ext2_xattr_handler(int name_index)
+static const char *ext2_xattr_prefix(int xattr_index, struct dentry *dentry)
 {
+	const char *name = NULL;
 	const struct xattr_handler *handler = NULL;
 
-	if (name_index > 0 && name_index < ARRAY_SIZE(ext2_xattr_handler_map))
-		handler = ext2_xattr_handler_map[name_index];
-	return handler;
+	switch (xattr_index) {
+	case EXT2_XATTR_INDEX_USER:
+		handler = &ext2_xattr_user_handler;
+		break;
+	case EXT2_XATTR_INDEX_TRUSTED:
+		handler = &ext2_xattr_trusted_handler;
+		break;
+#ifdef CONFIG_EXT2_FS_SECURITY
+	case EXT2_XATTR_INDEX_SECURITY:
+		handler = &ext2_xattr_security_handler;
+		break;
+#endif
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+	case EXT2_XATTR_INDEX_POSIX_ACL_ACCESS:
+		if (posix_acl_dentry_list(dentry))
+			name = XATTR_NAME_POSIX_ACL_ACCESS;
+		break;
+	case EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT:
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
 
 static bool
@@ -333,11 +344,10 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	/* list the attribute names */
 	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
 	     entry = EXT2_XATTR_NEXT(entry)) {
-		const struct xattr_handler *handler =
-			ext2_xattr_handler(entry->e_name_index);
+		const char *prefix;
 
-		if (handler && (!handler->list || handler->list(dentry))) {
-			const char *prefix = handler->prefix ?: handler->name;
+		prefix = ext2_xattr_prefix(entry->e_name_index, dentry);
+		if (prefix) {
 			size_t prefix_len = strlen(prefix);
 			size_t size = prefix_len + entry->e_name_len + 1;
 

-- 
2.34.1

