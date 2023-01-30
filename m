Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E715E68169F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 17:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbjA3QmT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 11:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjA3QmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:42:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340C13D0A3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 08:42:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADD356117D
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 16:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8FBC433D2;
        Mon, 30 Jan 2023 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675096931;
        bh=5piuEK6It3ZteDzDiFAkQiTKIVRODWYKqAyRPC4USAY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=h3WRu7qCv8Ba8m9EzeVayLSUE9hkREaIrw4ns6j7TAHa2Mz/yRDfUL/oXkuluRkme
         mBdZ0nAowz2u4zYMPqpHQa2Qiduyltz61lzXgzQ2I3H9FTQjYW6OP7xLxNjj5X+nZW
         yhBNhhEA2Q6os9DFnHE9JX0H4VOEGyEqDi4OfCRAbr9nvTpt0xKG2mfVHj7ZUiCF7y
         F536OJlqkPz9q5f2xVnlJwGcSMQ03md0g15SqXCrH16pmR45lIaZINfBPVGvLpvAP1
         e47P8pNaekB3hfMTZD+0bTHJ/B5uCL8R9tSLpp5ys74LJ2ePpyCiRz4NmfmyMk2BDG
         Gf+Dtyc4w2aeQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 30 Jan 2023 17:41:57 +0100
Subject: [PATCH v2 1/8] fs: don't use IOP_XATTR for posix acls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v2-1-214cfb88bb56@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7747; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5piuEK6It3ZteDzDiFAkQiTKIVRODWYKqAyRPC4USAY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRf/xwb+erftzUmezxC22ZwGnCbLtye9v2fU/Sfe9v1lx3p
 NJy8vKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiX1Yw/I/bPMfB3njakbTjJumfHu
 adSt212te63m2x4qd7xz4W9sQw/PeQiVnz0nOyYqykg9aBLWcKG1++7V011fnv7EP2f33i2LgB
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

The POSIX ACL api doesn't use the xattr handler infrastructure anymore.
If we keep relying on IOP_XATTR we will have to find a way to raise
IOP_XATTR during inode_init_always() if a filesystem doesn't implement
any xattrs other than POSIX ACLs. That's not done today but is in
principle possible. A prior version introduced SB_I_XATTR to this end.
Instead of this affecting all filesystems let those filesystems that
explicitly disable xattrs for some inodes disable POSIX ACLs by raising
IOP_NOACL.

Link: https://lore.kernel.org/linux-ext4/20230130091615.GB5178@lst.de
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v2:
- Patch introduced.
---
 fs/bad_inode.c         |  3 ++-
 fs/btrfs/inode.c       |  2 +-
 fs/libfs.c             |  3 ++-
 fs/overlayfs/copy_up.c |  4 ++--
 fs/posix_acl.c         |  4 ++--
 fs/reiserfs/inode.c    |  2 +-
 fs/reiserfs/namei.c    |  4 ++--
 fs/reiserfs/xattr.c    |  4 ++--
 fs/xattr.c             |  2 +-
 include/linux/fs.h     |  1 +
 include/linux/xattr.h  | 11 +++++++++++
 11 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 92737166203f..524e5e35b5d6 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -16,6 +16,7 @@
 #include <linux/namei.h>
 #include <linux/poll.h>
 #include <linux/fiemap.h>
+#include <linux/xattr.h>
 
 static int bad_file_open(struct inode *inode, struct file *filp)
 {
@@ -212,7 +213,7 @@ void make_bad_inode(struct inode *inode)
 	inode->i_atime = inode->i_mtime = inode->i_ctime =
 		current_time(inode);
 	inode->i_op = &bad_inode_ops;	
-	inode->i_opflags &= ~IOP_XATTR;
+	inode_xattr_disable(inode);
 	inode->i_fop = &bad_file_ops;	
 }
 EXPORT_SYMBOL(make_bad_inode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 98a800b8bd43..c015e554d186 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5840,7 +5840,7 @@ static struct inode *new_simple_dir(struct super_block *s,
 	 * associated with the dentry
 	 */
 	inode->i_op = &simple_dir_inode_operations;
-	inode->i_opflags &= ~IOP_XATTR;
+	inode_xattr_disable(inode);
 	inode->i_fop = &simple_dir_operations;
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
 	inode->i_mtime = current_time(inode);
diff --git a/fs/libfs.c b/fs/libfs.c
index aada4e7c8713..78052d91d60f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -23,6 +23,7 @@
 #include <linux/fsnotify.h>
 #include <linux/unicode.h>
 #include <linux/fscrypt.h>
+#include <linux/xattr.h>
 
 #include <linux/uaccess.h>
 
@@ -1375,7 +1376,7 @@ void make_empty_dir_inode(struct inode *inode)
 	inode->i_blocks = 0;
 
 	inode->i_op = &empty_dir_inode_operations;
-	inode->i_opflags &= ~IOP_XATTR;
+	inode_xattr_disable(inode);
 	inode->i_fop = &empty_dir_operations;
 }
 
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index c14e90764e35..0b48f0aa9558 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -81,8 +81,8 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 	int error = 0;
 	size_t slen;
 
-	if (!(old->d_inode->i_opflags & IOP_XATTR) ||
-	    !(new->d_inode->i_opflags & IOP_XATTR))
+	if (inode_xattr_disabled(old->d_inode) ||
+	    inode_xattr_disabled(new->d_inode))
 		return 0;
 
 	list_size = vfs_listxattr(old, NULL, 0);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index d7bc81fc0840..315d3926a13a 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1095,7 +1095,7 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (error)
 		goto out_inode_unlock;
 
-	if (inode->i_opflags & IOP_XATTR)
+	if (!(inode->i_opflags & IOP_NOACL))
 		error = set_posix_acl(mnt_userns, dentry, acl_type, kacl);
 	else if (unlikely(is_bad_inode(inode)))
 		error = -EIO;
@@ -1205,7 +1205,7 @@ int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (error)
 		goto out_inode_unlock;
 
-	if (inode->i_opflags & IOP_XATTR)
+	if (!(inode->i_opflags & IOP_NOACL))
 		error = set_posix_acl(mnt_userns, dentry, acl_type, NULL);
 	else if (unlikely(is_bad_inode(inode)))
 		error = -EIO;
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index c7d1fa526dea..2a7037b165f0 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2089,7 +2089,7 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
 	 */
 	if (IS_PRIVATE(dir) || dentry == REISERFS_SB(sb)->priv_root) {
 		inode->i_flags |= S_PRIVATE;
-		inode->i_opflags &= ~IOP_XATTR;
+		inode_xattr_disable(inode);
 	}
 
 	if (reiserfs_posixacl(inode->i_sb)) {
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 0b8aa99749f1..4e2f121d6819 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -378,12 +378,12 @@ static struct dentry *reiserfs_lookup(struct inode *dir, struct dentry *dentry,
 
 		/*
 		 * Propagate the private flag so we know we're
-		 * in the priv tree.  Also clear IOP_XATTR
+		 * in the priv tree.  Also clear xattrs
 		 * since we don't have xattrs on xattr files.
 		 */
 		if (IS_PRIVATE(dir)) {
 			inode->i_flags |= S_PRIVATE;
-			inode->i_opflags &= ~IOP_XATTR;
+			inode_xattr_disable(inode);
 		}
 	}
 	reiserfs_write_unlock(dir->i_sb);
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 8b2d52443f41..2c326b57d4bc 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -889,7 +889,7 @@ static int create_privroot(struct dentry *dentry)
 	}
 
 	d_inode(dentry)->i_flags |= S_PRIVATE;
-	d_inode(dentry)->i_opflags &= ~IOP_XATTR;
+	inode_xattr_disable(d_inode(dentry));
 	reiserfs_info(dentry->d_sb, "Created %s - reserved for xattr "
 		      "storage.\n", PRIVROOT_NAME);
 
@@ -977,7 +977,7 @@ int reiserfs_lookup_privroot(struct super_block *s)
 		d_set_d_op(dentry, &xattr_lookup_poison_ops);
 		if (d_really_is_positive(dentry)) {
 			d_inode(dentry)->i_flags |= S_PRIVATE;
-			d_inode(dentry)->i_opflags &= ~IOP_XATTR;
+			inode_xattr_disable(d_inode(dentry));
 		}
 	} else
 		err = PTR_ERR(dentry);
diff --git a/fs/xattr.c b/fs/xattr.c
index adab9a70b536..89b6c122056d 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -468,7 +468,7 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 	error = security_inode_listxattr(dentry);
 	if (error)
 		return error;
-	if (inode->i_op->listxattr && (inode->i_opflags & IOP_XATTR)) {
+	if (inode->i_op->listxattr && !inode_xattr_disabled(inode)) {
 		error = inode->i_op->listxattr(dentry, list, size);
 	} else {
 		error = security_inode_listsecurity(inode, list, size);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c1769a2c5d70..f4cbac68598a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -582,6 +582,7 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_NOFOLLOW	0x0004
 #define IOP_XATTR	0x0008
 #define IOP_DEFAULT_READLINK	0x0010
+#define IOP_NOACL	0x0020
 
 struct fsnotify_mark_connector;
 
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 2e7dd44926e4..23bbe98cfc16 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -109,5 +109,16 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 			  char *buffer, size_t size);
 void simple_xattr_add(struct simple_xattrs *xattrs,
 		      struct simple_xattr *new_xattr);
+static inline void inode_xattr_disable(struct inode *inode)
+{
+	inode->i_opflags &= ~IOP_XATTR;
+	inode->i_opflags |= IOP_NOACL;
+}
+
+static inline bool inode_xattr_disabled(struct inode *inode)
+{
+	return !(inode->i_opflags & IOP_XATTR) &&
+	       (inode->i_opflags & IOP_NOACL);
+}
 
 #endif	/* _LINUX_XATTR_H */

-- 
2.34.1

