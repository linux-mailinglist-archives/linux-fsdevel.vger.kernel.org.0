Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CCC67B144
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjAYLaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbjAYL3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:29:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0E528D04;
        Wed, 25 Jan 2023 03:29:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4814B614C8;
        Wed, 25 Jan 2023 11:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46D2C433EF;
        Wed, 25 Jan 2023 11:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646180;
        bh=L83frKBR+KHV5qJCuYpyI67ZuEsOVDhNuZ4zqzpj91M=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZBLxtHhJZSGOwVTyvnv9aW5SxeFNAYTSaW3eYC+JaK8rDWkkqCsz+Fpa8Ypmhycv2
         mIJ3nqtsRaT3SKPHi7cvO5/kWVGt0iLdtJrUCnbpUS18PSB8RVy6a5DyyZlFTgKHEm
         m6q8UwhhsA21TcP7VjtBB5GVtHMEbUtciEE3lhUc0ESjjSU2AT2s7m3luui3xKq7jQ
         cUpwZes96SP1i4a8p9Grk4UnAW1N+o6WyfBxJ3a9SUqaZkTxlfYNsCl6hDXVC0bCCP
         1BiyvskVSBlFQW1bg1kikSvBVHF1M7GSiARctU0aqlejpSztBf3FsddisDktZjBoVu
         Osb2wZAm10X6A==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 25 Jan 2023 12:28:52 +0100
Subject: [PATCH 07/12] ext4: drop posix acl handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v1-7-6cf155b492b6@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        linux-ext4@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4272; i=brauner@kernel.org;
 h=from:subject:message-id; bh=L83frKBR+KHV5qJCuYpyI67ZuEsOVDhNuZ4zqzpj91M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfFJrYdka74MCWN9OS/fr1G74vf5pnpHR7p+D1L3nsj25I
 F0nf7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIHWuGfyo315Y+Oaxel13VsrlPKs
 GXXfFe7/qGWwEzwl93LpZaUcLIsDpKbrKxRWdBOAvPgQXmrukJ/5oj1fMY980JSWQ2E+biBQA=
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

Cc: <linux-ext4@vger.kernel.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/ext4/xattr.c | 71 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7decaaf27e82..5472b8eac672 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -83,26 +83,9 @@ static __le32 ext4_xattr_hash_entry(char *name, size_t name_len, __le32 *value,
 				    size_t value_count);
 static void ext4_xattr_rehash(struct ext4_xattr_header *);
 
-static const struct xattr_handler * const ext4_xattr_handler_map[] = {
-	[EXT4_XATTR_INDEX_USER]		     = &ext4_xattr_user_handler,
-#ifdef CONFIG_EXT4_FS_POSIX_ACL
-	[EXT4_XATTR_INDEX_POSIX_ACL_ACCESS]  = &posix_acl_access_xattr_handler,
-	[EXT4_XATTR_INDEX_POSIX_ACL_DEFAULT] = &posix_acl_default_xattr_handler,
-#endif
-	[EXT4_XATTR_INDEX_TRUSTED]	     = &ext4_xattr_trusted_handler,
-#ifdef CONFIG_EXT4_FS_SECURITY
-	[EXT4_XATTR_INDEX_SECURITY]	     = &ext4_xattr_security_handler,
-#endif
-	[EXT4_XATTR_INDEX_HURD]		     = &ext4_xattr_hurd_handler,
-};
-
 const struct xattr_handler *ext4_xattr_handlers[] = {
 	&ext4_xattr_user_handler,
 	&ext4_xattr_trusted_handler,
-#ifdef CONFIG_EXT4_FS_POSIX_ACL
-	&posix_acl_access_xattr_handler,
-	&posix_acl_default_xattr_handler,
-#endif
 #ifdef CONFIG_EXT4_FS_SECURITY
 	&ext4_xattr_security_handler,
 #endif
@@ -110,6 +93,43 @@ const struct xattr_handler *ext4_xattr_handlers[] = {
 	NULL
 };
 
+static const char *ext4_xattr_prefix(int xattr_index, struct dentry *dentry)
+{
+	const char *name = NULL;
+	const struct xattr_handler *handler = NULL;
+
+	switch (xattr_index) {
+	case EXT4_XATTR_INDEX_USER:
+		handler = &ext4_xattr_user_handler;
+		break;
+	case EXT4_XATTR_INDEX_TRUSTED:
+		handler = &ext4_xattr_trusted_handler;
+		break;
+#ifdef CONFIG_EXT4_FS_SECURITY
+	case EXT4_XATTR_INDEX_SECURITY:
+		handler = &ext4_xattr_security_handler;
+		break;
+#endif
+#ifdef CONFIG_EXT4_FS_POSIX_ACL
+	case EXT4_XATTR_INDEX_POSIX_ACL_ACCESS:
+		if (posix_acl_dentry_list(dentry))
+			name = XATTR_NAME_POSIX_ACL_ACCESS;
+		break;
+	case EXT4_XATTR_INDEX_POSIX_ACL_DEFAULT:
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
 #define EA_BLOCK_CACHE(inode)	(((struct ext4_sb_info *) \
 				inode->i_sb->s_fs_info)->s_ea_block_cache)
 
@@ -171,16 +191,6 @@ static void ext4_xattr_block_csum_set(struct inode *inode,
 						bh->b_blocknr, BHDR(bh));
 }
 
-static inline const struct xattr_handler *
-ext4_xattr_handler(int name_index)
-{
-	const struct xattr_handler *handler = NULL;
-
-	if (name_index > 0 && name_index < ARRAY_SIZE(ext4_xattr_handler_map))
-		handler = ext4_xattr_handler_map[name_index];
-	return handler;
-}
-
 static int
 ext4_xattr_check_entries(struct ext4_xattr_entry *entry, void *end,
 			 void *value_start)
@@ -679,11 +689,10 @@ ext4_xattr_list_entries(struct dentry *dentry, struct ext4_xattr_entry *entry,
 	size_t rest = buffer_size;
 
 	for (; !IS_LAST_ENTRY(entry); entry = EXT4_XATTR_NEXT(entry)) {
-		const struct xattr_handler *handler =
-			ext4_xattr_handler(entry->e_name_index);
+		const char *prefix;
 
-		if (handler && (!handler->list || handler->list(dentry))) {
-			const char *prefix = handler->prefix ?: handler->name;
+		prefix = ext4_xattr_prefix(entry->e_name_index, dentry);
+		if (prefix) {
 			size_t prefix_len = strlen(prefix);
 			size_t size = prefix_len + entry->e_name_len + 1;
 

-- 
2.34.1

