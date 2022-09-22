Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D245E66D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 17:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiIVPTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 11:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiIVPSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:18:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BE8EF0BD
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 08:18:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2F0663610
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 15:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F61DC433C1;
        Thu, 22 Sep 2022 15:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663859886;
        bh=6aDi/+f/4/2voA3nqn+ZOwGKoT3xJj5IzVHw8AogsXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwUOZ0lFkT+dp8J9nuIqJJftmPTKNFPKVeVQLhKQx0Dg/ljYShl8+OSf3RpwLjNsS
         qlVoRU5F+9HXRJcGe/jvPl3TTyGd4RFmxxqBQjdUFLCXgwlUo8EK4p1zUR/9pziaua
         0Fk2hshmgGVtV0EiOLOOKwF9CEXfe+OnoLKh4yd0IUU1pnVY+IVgeCs+BtseSCpAym
         QrM/nXMpQqTQSLnfG/4x7cOKr36L7LY1mVejhlDoRrQp7SOCdkFTNWs/f0UFRwViFK
         8LYMpYrcTt6jgaF3XB3SbckWFWLs9q1IpCyjcmRqNI70DxJnu4CEkIEHy1UnxSQVz3
         jSz7hrWFsP1bw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 08/29] acl: add vfs_set_acl()
Date:   Thu, 22 Sep 2022 17:17:06 +0200
Message-Id: <20220922151728.1557914-9-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922151728.1557914-1-brauner@kernel.org>
References: <20220922151728.1557914-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6705; i=brauner@kernel.org; h=from:subject; bh=6aDi/+f/4/2voA3nqn+ZOwGKoT3xJj5IzVHw8AogsXI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTr1FRYCW1cPC1n/3m1yKUJ+ZV/POfuyXjRulv0xDX3K14p igxHO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTAC7Cw/BPU9mJZ+WaLa11Otv+pKtfnX BGvPeJe9TXbd8SZeZYMIcnMTL87WH7+0xGsV3biKtUQ+JyRej5cpa78UtZl/wS/lvQnsYKAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In previous patches we implemented get and set inode operations for all
non-stacking filesystems that support posix acls but didn't yet
implement get and/or set acl inode operations. This specifically
affected cifs and 9p.

Now we can build a posix acl api based solely on get and set inode
operations. We add a new vfs_set_acl() api that can be used to set posix
acls. This finally removes all type unsafety and type conversion issues
explained in detail in [1] that we aim to get rid of.

After we finished building the vfs api we can switch stacking
filesystems to rely on the new posix api and then finally switch the
xattr system calls themselves to rely on the posix acl api.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/posix_acl.c            | 107 ++++++++++++++++++++++++++++++++++++++
 fs/xattr.c                |   5 +-
 include/linux/posix_acl.h |  10 ++++
 include/linux/xattr.h     |   2 +
 4 files changed, 121 insertions(+), 3 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 73bd70cb0c26..f27e398e4de8 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -24,6 +24,7 @@
 #include <linux/user_namespace.h>
 #include <linux/namei.h>
 #include <linux/mnt_idmapping.h>
+#include <linux/fsnotify.h>
 
 static struct posix_acl **acl_by_type(struct inode *inode, int type)
 {
@@ -1253,3 +1254,109 @@ int simple_acl_create(struct inode *dir, struct inode *inode)
 		posix_acl_release(acl);
 	return 0;
 }
+
+static inline int posix_acl_type(const char *name)
+{
+	if (strcmp(name, XATTR_NAME_POSIX_ACL_ACCESS) == 0)
+		return ACL_TYPE_ACCESS;
+	else if (strcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT) == 0)
+		return ACL_TYPE_DEFAULT;
+
+	return -1;
+}
+
+static int vfs_set_acl_idmapped_mnt(struct user_namespace *mnt_userns,
+				    struct user_namespace *fs_userns,
+				    struct posix_acl *acl)
+{
+	for (int n = 0; n < acl->a_count; n++) {
+		struct posix_acl_entry *acl_e = &acl->a_entries[n];
+
+		switch (acl_e->e_tag) {
+		case ACL_USER:
+			acl_e->e_uid = from_vfsuid(mnt_userns, fs_userns,
+						   VFSUIDT_INIT(acl_e->e_uid));
+			break;
+		case ACL_GROUP:
+			acl_e->e_gid = from_vfsgid(mnt_userns, fs_userns,
+						   VFSGIDT_INIT(acl_e->e_gid));
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * vfs_set_acl - set posix acls
+ * @mnt_userns: user namespace of the mount
+ * @dentry: the dentry based on which to set the posix acls
+ * @acl_name: the name of the posix acl
+ * @kacl: the posix acls in the appropriate VFS format
+ *
+ * This function sets @kacl. The caller must all posix_acl_release() on @kacl
+ * afterwards.
+ *
+ * Return: On success 0, on error negative errno.
+ */
+int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		const char *acl_name, struct posix_acl *kacl)
+{
+	int acl_type;
+	int error;
+	struct inode *inode = d_inode(dentry);
+	struct inode *delegated_inode = NULL;
+
+	acl_type = posix_acl_type(acl_name);
+	if (acl_type < 0)
+		return -EINVAL;
+
+	if (kacl) {
+		/*
+		 * If we're on an idmapped mount translate from mount specific
+		 * vfs{g,u}id_t into global filesystem k{g,u}id_t so.
+		 * Afterwards we can cache the POSIX ACLs filesystem wide and -
+		 * if this is a filesystem with a backing store - translate
+		 * them to backing store values.
+		 */
+		error = vfs_set_acl_idmapped_mnt(mnt_userns, i_user_ns(inode), kacl);
+		if (error)
+			return error;
+	}
+
+retry_deleg:
+	inode_lock(inode);
+
+	/*
+	 * We only care about restrictions the inode struct itself places upon
+	 * us otherwise POSIX ACLs aren't subject to any VFS restrictions.
+	 */
+	error = xattr_permission(mnt_userns, inode, acl_name, MAY_WRITE);
+	if (error)
+		goto out_inode_unlock;
+
+	error = try_break_deleg(inode, &delegated_inode);
+	if (error)
+		goto out_inode_unlock;
+
+	if (inode->i_opflags & IOP_XATTR)
+		error = set_posix_acl(mnt_userns, dentry, acl_type, kacl);
+	else if (unlikely(is_bad_inode(inode)))
+		error = -EIO;
+	else
+		error = -EOPNOTSUPP;
+	if (!error)
+		fsnotify_xattr(dentry);
+
+out_inode_unlock:
+	inode_unlock(inode);
+
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry_deleg;
+	}
+
+	return error;
+}
+EXPORT_SYMBOL(vfs_set_acl);
diff --git a/fs/xattr.c b/fs/xattr.c
index 61107b6bbed2..e16d7bde4935 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -84,9 +84,8 @@ xattr_resolve_name(struct inode *inode, const char **name)
  * Check permissions for extended attribute access.  This is a bit complicated
  * because different namespaces have very different rules.
  */
-static int
-xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
-		 const char *name, int mask)
+int xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
+		     const char *name, int mask)
 {
 	/*
 	 * We can never set or remove an extended attribute on a read-only
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 7b389901d581..bdb87263de8b 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -99,6 +99,9 @@ static inline void cache_no_acl(struct inode *inode)
 	inode->i_acl = NULL;
 	inode->i_default_acl = NULL;
 }
+
+int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		const char *acl_name, struct posix_acl *kacl);
 #else
 static inline int posix_acl_chmod(struct user_namespace *mnt_userns,
 				  struct dentry *dentry, umode_t mode)
@@ -126,6 +129,13 @@ static inline int posix_acl_create(struct inode *inode, umode_t *mode,
 static inline void forget_all_cached_acls(struct inode *inode)
 {
 }
+
+static inline int vfs_set_acl(struct user_namespace *mnt_userns,
+			      struct dentry *dentry, const char *name,
+			      struct posix_acl *acl)
+{
+	return 0;
+}
 #endif /* CONFIG_FS_POSIX_ACL */
 
 struct posix_acl *get_acl(struct inode *inode, int type);
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 4c379d23ec6e..8267e547e631 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -73,6 +73,8 @@ ssize_t vfs_getxattr_alloc(struct user_namespace *mnt_userns,
 			   char **xattr_value, size_t size, gfp_t flags);
 
 int xattr_supported_namespace(struct inode *inode, const char *prefix);
+int xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
+		     const char *name, int mask);
 
 static inline const char *xattr_prefix(const struct xattr_handler *handler)
 {
-- 
2.34.1

