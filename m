Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D21F68669E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjBANQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjBANQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:16:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA9865366
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 05:15:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 704926179F
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 13:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95951C4339E;
        Wed,  1 Feb 2023 13:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675257351;
        bh=qLfudYGUAQDp45pdZf3RO/+LRS/82K4NaAeBfHwks54=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=dN6C8A8bWJb2iq6MvXy3O0666sG5NtwPR08d2tlrUWGCfqM2yFyg7AhI7877xfywX
         kTWfsraJ2robcClkH5ol22h/H0uM1etO4VawM5eS2LB5gcOpDdteDHAKDdcFen+b0q
         nmMK/c+G0u7OoeysJYNXi9WRmsHs6At9IOZ5w3FxgVV3XqK7xaclHm2iCWYYwqQZMG
         hVqzUqsc0jHY2+1Ewt2BP+kf4LbwSQocPBKFHMXpaFDGSXXigxVFOVW5VYydStuwvy
         ckWztlcFsdlchAD3UJHfc9YsTEDpEx5Jv3mDDwtYInVQo0petwR/8jVLVYzA5Uf+ig
         zrWi6xQyboIDw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 01 Feb 2023 14:15:01 +0100
Subject: [PATCH v3 10/10] acl: don't depend on IOP_XATTR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v3-10-f760cc58967d@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3732; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qLfudYGUAQDp45pdZf3RO/+LRS/82K4NaAeBfHwks54=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTfSv3Upib6cOG9Gc1nM7t8ZvJ07Z7lvbtj/vFPil9jp+v8
 STOd31HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRNBlGhuen7zjctQxLrjZe3Vhh8/
 PQlzmzatnUm904Y8TiQv9tu8vI8PSgx4ZCLkYxCcP1mUYKyhXp7jcn2hkfzTSeI3ynpC2XAQA=
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

All codepaths that don't want to implement POSIX ACLs should simply not
implement the associated inode operations instead of relying on
IOP_XATTR. That's the case for all filesystems today.

For vfs_listxattr() all filesystems that explicitly turn of xattrs for a
given inode all set inode->i_op to a dedicated set of inode operations
that doesn't implement ->listxattr().  We can remove the dependency of
vfs_listxattr() on IOP_XATTR.

Removing this dependency will allow us to decouple POSIX ACLs from
IOP_XATTR and they can still be listed even if no other xattr handlers
are implemented. Otherwise we would have to implement elaborate schemes
to raise IOP_XATTR even if sb->s_xattr is set to NULL.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v3:
- Patch introduced.
---
 fs/posix_acl.c | 12 ++++--------
 fs/xattr.c     | 25 ++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 7a4d89897c37..881a7fd1cacb 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1132,12 +1132,10 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (error)
 		goto out_inode_unlock;
 
-	if (inode->i_opflags & IOP_XATTR)
+	if (likely(!is_bad_inode(inode)))
 		error = set_posix_acl(mnt_userns, dentry, acl_type, kacl);
-	else if (unlikely(is_bad_inode(inode)))
-		error = -EIO;
 	else
-		error = -EOPNOTSUPP;
+		error = -EIO;
 	if (!error) {
 		fsnotify_xattr(dentry);
 		evm_inode_post_set_acl(dentry, acl_name, kacl);
@@ -1242,12 +1240,10 @@ int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (error)
 		goto out_inode_unlock;
 
-	if (inode->i_opflags & IOP_XATTR)
+	if (likely(!is_bad_inode(inode)))
 		error = set_posix_acl(mnt_userns, dentry, acl_type, NULL);
-	else if (unlikely(is_bad_inode(inode)))
-		error = -EIO;
 	else
-		error = -EOPNOTSUPP;
+		error = -EIO;
 	if (!error) {
 		fsnotify_xattr(dentry);
 		evm_inode_post_remove_acl(mnt_userns, dentry, acl_name);
diff --git a/fs/xattr.c b/fs/xattr.c
index 8743402a5e8b..56e37461014e 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -457,6 +457,28 @@ vfs_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(vfs_getxattr);
 
+/**
+ * vfs_listxattr - retrieve \0 separated list of xattr names
+ * @dentry: the dentry from whose inode the xattr names are retrieved
+ * @list: buffer to store xattr names into
+ * @size: size of the buffer
+ *
+ * This function returns the names of all xattrs associated with the
+ * inode of @dentry.
+ *
+ * Note, for legacy reasons the vfs_listxattr() function lists POSIX
+ * ACLs as well. Since POSIX ACLs are decoupled from IOP_XATTR the
+ * vfs_listxattr() function doesn't check for this flag since a
+ * filesystem could implement POSIX ACLs without implementing any other
+ * xattrs.
+ *
+ * However, since all codepaths that remove IOP_XATTR also assign of
+ * inode operations that either don't implement or implement a stub
+ * ->listxattr() operation.
+ *
+ * Return: On success, the size of the buffer that was used. On error a
+ *         negative error code.
+ */
 ssize_t
 vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 {
@@ -466,7 +488,8 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 	error = security_inode_listxattr(dentry);
 	if (error)
 		return error;
-	if (inode->i_op->listxattr && (inode->i_opflags & IOP_XATTR)) {
+
+	if (inode->i_op->listxattr) {
 		error = inode->i_op->listxattr(dentry, list, size);
 	} else {
 		error = security_inode_listsecurity(inode, list, size);

-- 
2.34.1

