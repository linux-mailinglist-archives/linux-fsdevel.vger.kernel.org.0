Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B8768669B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjBANQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjBANQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:16:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354DE64DA3;
        Wed,  1 Feb 2023 05:15:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99D92B82180;
        Wed,  1 Feb 2023 13:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC6AC4339C;
        Wed,  1 Feb 2023 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675257348;
        bh=KF3hJGEMiNJlxHEZI/jc8UC3mC9TH+U+u0I9wigEUms=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Po5JGMv510IkjEddDIeve9sKPxafeTdEsD0tSdRsuDDhUd8Abvrpgi0ZhoTFmzQnQ
         qALTIcscjGNMhgh2aI57cC4iAiMAzVZFh2AIpiKL1n53MbhflVlM/KYHext8C3BxnD
         8s8kPwgwu3pnHsQT5LRmDAovaNTLSOYscI4TFH0P+/CRWuObBTglpoIbgNbn/cARDQ
         qkTshVlKczLf6ZLIvYcC6NYr7X4yEt55lgPfyh7cItnwjY1HFrw0eeCj2d07+taKBK
         q3k6qBFcsfGOgsMDpGEn/5koFIcaQiZ3+dKY6q7qNw70wWDtP1Gd5w+5LlM54E8f6r
         5LdTrAN2QDvYA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 01 Feb 2023 14:14:59 +0100
Subject: [PATCH v3 08/10] reiserfs: rework priv inode handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v3-8-f760cc58967d@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        reiserfs-devel@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6477; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KF3hJGEMiNJlxHEZI/jc8UC3mC9TH+U+u0I9wigEUms=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTfSv0Urnf235kfYtc2ZGqpqDr7h3Q03I+6GDTpb5PeM4mX
 D2MVO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay5h8jwydrxj1H1RMKXti9i/Nzlh
 AXWD79tfVDfk7jzt3Pu2QvhDP803/KmHzB4eykqZK731aftOzIMxYLm3JpR43lxfbMifxHuAA=
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

Reiserfs is the only filesystem that removes IOP_XATTR without also
using a set of dedicated inode operations at the same time that nop all
xattr related inode operations. This means we need to have a IOP_XATTR
check in vfs_listxattr() instead of just being able to check for
->listxatt() being implemented.

Introduce a dedicated set of nop inode operations that are used when
IOP_XATTR is removed, allowing us to remove that check from
vfs_listxattr(). This in turn allows us to completely decouple POSIX ACLs from
IOP_XATTR.

Cc: reiserfs-devel@vger.kernel.org
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v3:
- Patch introduced.
---
 fs/reiserfs/file.c     |  7 +++++++
 fs/reiserfs/inode.c    |  6 ++----
 fs/reiserfs/namei.c    | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
 fs/reiserfs/reiserfs.h |  2 ++
 fs/reiserfs/xattr.c    |  9 +++------
 5 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/fs/reiserfs/file.c b/fs/reiserfs/file.c
index 467d13da198f..b54cc7048f02 100644
--- a/fs/reiserfs/file.c
+++ b/fs/reiserfs/file.c
@@ -261,3 +261,10 @@ const struct inode_operations reiserfs_file_inode_operations = {
 	.fileattr_get = reiserfs_fileattr_get,
 	.fileattr_set = reiserfs_fileattr_set,
 };
+
+const struct inode_operations reiserfs_priv_file_inode_operations = {
+	.setattr = reiserfs_setattr,
+	.permission = reiserfs_permission,
+	.fileattr_get = reiserfs_fileattr_get,
+	.fileattr_set = reiserfs_fileattr_set,
+};
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index c7d1fa526dea..4ec357919588 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2087,10 +2087,8 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
 	 * Mark it private if we're creating the privroot
 	 * or something under it.
 	 */
-	if (IS_PRIVATE(dir) || dentry == REISERFS_SB(sb)->priv_root) {
-		inode->i_flags |= S_PRIVATE;
-		inode->i_opflags &= ~IOP_XATTR;
-	}
+	if (IS_PRIVATE(dir) || dentry == REISERFS_SB(sb)->priv_root)
+		reiserfs_init_priv_inode(inode);
 
 	if (reiserfs_posixacl(inode->i_sb)) {
 		reiserfs_write_unlock(inode->i_sb);
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 0b8aa99749f1..2f0c721c8ac9 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -378,13 +378,11 @@ static struct dentry *reiserfs_lookup(struct inode *dir, struct dentry *dentry,
 
 		/*
 		 * Propagate the private flag so we know we're
-		 * in the priv tree.  Also clear IOP_XATTR
+		 * in the priv tree.  Also clear xattr support
 		 * since we don't have xattrs on xattr files.
 		 */
-		if (IS_PRIVATE(dir)) {
-			inode->i_flags |= S_PRIVATE;
-			inode->i_opflags &= ~IOP_XATTR;
-		}
+		if (IS_PRIVATE(dir))
+			reiserfs_init_priv_inode(inode);
 	}
 	reiserfs_write_unlock(dir->i_sb);
 	if (retval == IO_ERROR) {
@@ -1649,6 +1647,48 @@ static int reiserfs_rename(struct user_namespace *mnt_userns,
 	return retval;
 }
 
+static const struct inode_operations reiserfs_priv_dir_inode_operations = {
+	.create = reiserfs_create,
+	.lookup = reiserfs_lookup,
+	.link = reiserfs_link,
+	.unlink = reiserfs_unlink,
+	.symlink = reiserfs_symlink,
+	.mkdir = reiserfs_mkdir,
+	.rmdir = reiserfs_rmdir,
+	.mknod = reiserfs_mknod,
+	.rename = reiserfs_rename,
+	.setattr = reiserfs_setattr,
+	.permission = reiserfs_permission,
+	.fileattr_get = reiserfs_fileattr_get,
+	.fileattr_set = reiserfs_fileattr_set,
+};
+
+static const struct inode_operations reiserfs_priv_symlink_inode_operations = {
+	.get_link	= page_get_link,
+	.setattr = reiserfs_setattr,
+	.permission = reiserfs_permission,
+};
+
+static const struct inode_operations reiserfs_priv_special_inode_operations = {
+	.setattr = reiserfs_setattr,
+	.permission = reiserfs_permission,
+};
+
+void reiserfs_init_priv_inode(struct inode *inode)
+{
+	inode->i_flags |= S_PRIVATE;
+	inode->i_opflags &= ~IOP_XATTR;
+
+	if (S_ISREG(inode->i_mode))
+		inode->i_op = &reiserfs_priv_file_inode_operations;
+	else if (S_ISDIR(inode->i_mode))
+		inode->i_op = &reiserfs_priv_dir_inode_operations;
+	else if (S_ISLNK(inode->i_mode))
+		inode->i_op = &reiserfs_priv_symlink_inode_operations;
+	else
+		inode->i_op = &reiserfs_priv_special_inode_operations;
+}
+
 /* directories can handle most operations...  */
 const struct inode_operations reiserfs_dir_inode_operations = {
 	.create = reiserfs_create,
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 3aa928ec527a..d4dd39a66d80 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -3106,6 +3106,7 @@ int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 int __reiserfs_write_begin(struct page *page, unsigned from, unsigned len);
 
 /* namei.c */
+void reiserfs_init_priv_inode(struct inode *inode);
 void set_de_name_and_namelen(struct reiserfs_dir_entry *de);
 int search_by_entry_key(struct super_block *sb, const struct cpu_key *key,
 			struct treepath *path, struct reiserfs_dir_entry *de);
@@ -3175,6 +3176,7 @@ void reiserfs_unmap_buffer(struct buffer_head *);
 
 /* file.c */
 extern const struct inode_operations reiserfs_file_inode_operations;
+extern const struct inode_operations reiserfs_priv_file_inode_operations;
 extern const struct file_operations reiserfs_file_operations;
 extern const struct address_space_operations reiserfs_address_space_operations;
 
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 0b949dc45484..11b32bbd656d 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -896,8 +896,7 @@ static int create_privroot(struct dentry *dentry)
 		return -EOPNOTSUPP;
 	}
 
-	d_inode(dentry)->i_flags |= S_PRIVATE;
-	d_inode(dentry)->i_opflags &= ~IOP_XATTR;
+	reiserfs_init_priv_inode(d_inode(dentry));
 	reiserfs_info(dentry->d_sb, "Created %s - reserved for xattr "
 		      "storage.\n", PRIVROOT_NAME);
 
@@ -979,10 +978,8 @@ int reiserfs_lookup_privroot(struct super_block *s)
 	if (!IS_ERR(dentry)) {
 		REISERFS_SB(s)->priv_root = dentry;
 		d_set_d_op(dentry, &xattr_lookup_poison_ops);
-		if (d_really_is_positive(dentry)) {
-			d_inode(dentry)->i_flags |= S_PRIVATE;
-			d_inode(dentry)->i_opflags &= ~IOP_XATTR;
-		}
+		if (d_really_is_positive(dentry))
+			reiserfs_init_priv_inode(d_inode(dentry));
 	} else
 		err = PTR_ERR(dentry);
 	inode_unlock(d_inode(s->s_root));

-- 
2.34.1

