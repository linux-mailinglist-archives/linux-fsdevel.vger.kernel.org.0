Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9755EAAC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiIZPYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbiIZPXv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:23:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353C4870A9;
        Mon, 26 Sep 2022 07:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88E5260DD6;
        Mon, 26 Sep 2022 14:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766BFC43470;
        Mon, 26 Sep 2022 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201364;
        bh=ckdGcSqOmPco9wesNZmadbgs62I0EVzzil/x9+ttpWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QnvRBQukargRBHCrsCOsST+ECmEceuODjiUjTOh6/Cfy24FRW+lNPMLxemODD+1+Q
         6ECcYgj7LKLbvP2m9V9N8Una0C4C+Q0M30OaEUexX0H9+xuHUakAXGRP8H47oCqhin
         xcbsuao8pMOVvu/o1hBIvl3TU3XsHGnk//wtZoj40q5Yt0i4FtJ3T04aKlIdR6mDwd
         uiIIDK9LQJVhpFwin+qVWXLMPcyNiFjnmp6WojI87XSQjccAhXbvfwaF0KtJvPWLSL
         d6DoHDMNC55veJXw9+y2CFjCxhd1tygP6ww0nSC796ogEhtVbvx4/GxD1hLQu+xcLw
         TdfuOEOXXUlrQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 16/30] acl: add vfs_get_acl()
Date:   Mon, 26 Sep 2022 16:08:13 +0200
Message-Id: <20220926140827.142806-17-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140827.142806-1-brauner@kernel.org>
References: <20220926140827.142806-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8926; i=brauner@kernel.org; h=from:subject; bh=ckdGcSqOmPco9wesNZmadbgs62I0EVzzil/x9+ttpWo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQbbnI4kaH2lesof5b1BMu7lbtNMgv442vXlGtN/PfwteG6 WhbVjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkwrWNk6FT9UHlFInzJF+N7LdZHsq 6smJ/YeOHH0rg1B8umCLkYxzP84WoSnLorLl16oV5fj+eHFIsXJpzeE5uZVsw3574UeFOYDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
operations. We add a new vfs_get_acl() api that can be used to get posix
acls. This finally removes all type unsafety and type conversion issues
explained in detail in [1] that we aim to get rid of.

After we finished building the vfs api we can switch stacking
filesystems to rely on the new posix api and then finally switch the
xattr system calls themselves to rely on the posix acl api.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged

 fs/posix_acl.c                  | 131 ++++++++++++++++++++++++++++++--
 include/linux/posix_acl.h       |   9 +++
 include/linux/posix_acl_xattr.h |  10 +++
 3 files changed, 142 insertions(+), 8 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index ef0908a4bc46..18873be583a9 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -108,7 +108,9 @@ void forget_all_cached_acls(struct inode *inode)
 }
 EXPORT_SYMBOL(forget_all_cached_acls);
 
-struct posix_acl *get_acl(struct inode *inode, int type)
+struct posix_acl *__get_acl(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, struct inode *inode,
+			    int type)
 {
 	void *sentinel;
 	struct posix_acl **p;
@@ -141,19 +143,21 @@ struct posix_acl *get_acl(struct inode *inode, int type)
 	cmpxchg(p, ACL_NOT_CACHED, sentinel);
 
 	/*
-	 * Normally, the ACL returned by ->get_inode_acl will be cached.
+	 * Normally, the ACL returned by ->get{_inode}_acl will be cached.
 	 * A filesystem can prevent that by calling
-	 * forget_cached_acl(inode, type) in ->get_inode_acl.
+	 * forget_cached_acl(inode, type) in ->get{_inode}_acl.
 	 *
-	 * If the filesystem doesn't have a get_acl() function at all, we'll
-	 * just create the negative cache entry.
+	 * If the filesystem doesn't have a get{_inode}_ acl() function at all,
+	 * we'll just create the negative cache entry.
 	 */
-	if (!inode->i_op->get_inode_acl) {
+	if (dentry && inode->i_op->get_acl) {
+		acl = inode->i_op->get_acl(mnt_userns, dentry, type);
+	} else if (inode->i_op->get_inode_acl) {
+		acl = inode->i_op->get_inode_acl(inode, type, false);
+	} else {
 		set_cached_acl(inode, type, NULL);
 		return NULL;
 	}
-	acl = inode->i_op->get_inode_acl(inode, type, false);
-
 	if (IS_ERR(acl)) {
 		/*
 		 * Remove our sentinel so that we don't block future attempts
@@ -171,6 +175,11 @@ struct posix_acl *get_acl(struct inode *inode, int type)
 		posix_acl_release(acl);
 	return acl;
 }
+
+struct posix_acl *get_acl(struct inode *inode, int type)
+{
+	return __get_acl(&init_user_ns, NULL, inode, type);
+}
 EXPORT_SYMBOL(get_acl);
 
 /*
@@ -1117,6 +1126,67 @@ posix_acl_to_xattr(struct user_namespace *user_ns, const struct posix_acl *acl,
 }
 EXPORT_SYMBOL (posix_acl_to_xattr);
 
+/**
+ * vfs_posix_acl_to_xattr - convert from kernel to userspace representation
+ * @mnt_userns: user namespace of the mount
+ * @inode: inode the posix acls are set on
+ * @acl: the posix acls as represented by the vfs
+ * @buffer: the buffer into which to convert @acl
+ * @size: size of @buffer
+ *
+ * This converts @acl from the VFS representation in the filesystem idmapping
+ * to the uapi form reportable to userspace. And mount and caller idmappings
+ * are handled appropriately.
+ *
+ * Return: On success, the size of the stored uapi posix acls, on error a
+ * negative errno.
+ */
+ssize_t vfs_posix_acl_to_xattr(struct user_namespace *mnt_userns,
+			       struct inode *inode, const struct posix_acl *acl,
+			       void *buffer, size_t size)
+
+{
+	struct posix_acl_xattr_header *ext_acl = buffer;
+	struct posix_acl_xattr_entry *ext_entry;
+	struct user_namespace *fs_userns, *caller_userns;
+	ssize_t real_size, n;
+	vfsuid_t vfsuid;
+	vfsgid_t vfsgid;
+
+	real_size = posix_acl_xattr_size(acl->a_count);
+	if (!buffer)
+		return real_size;
+	if (real_size > size)
+		return -ERANGE;
+
+	ext_entry = (void *)(ext_acl + 1);
+	ext_acl->a_version = cpu_to_le32(POSIX_ACL_XATTR_VERSION);
+
+	fs_userns = i_user_ns(inode);
+	caller_userns = current_user_ns();
+	for (n=0; n < acl->a_count; n++, ext_entry++) {
+		const struct posix_acl_entry *acl_e = &acl->a_entries[n];
+		ext_entry->e_tag  = cpu_to_le16(acl_e->e_tag);
+		ext_entry->e_perm = cpu_to_le16(acl_e->e_perm);
+		switch(acl_e->e_tag) {
+		case ACL_USER:
+			vfsuid = make_vfsuid(mnt_userns, fs_userns, acl_e->e_uid);
+			ext_entry->e_id = cpu_to_le32(from_kuid(
+				caller_userns, vfsuid_into_kuid(vfsuid)));
+			break;
+		case ACL_GROUP:
+			vfsgid = make_vfsgid(mnt_userns, fs_userns, acl_e->e_gid);
+			ext_entry->e_id = cpu_to_le32(from_kgid(
+				caller_userns, vfsgid_into_kgid(vfsgid)));
+			break;
+		default:
+			ext_entry->e_id = cpu_to_le32(ACL_UNDEFINED_ID);
+			break;
+		}
+	}
+	return real_size;
+}
+
 static int
 posix_acl_xattr_get(const struct xattr_handler *handler,
 		    struct dentry *unused, struct inode *inode,
@@ -1369,3 +1439,48 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	return error;
 }
 EXPORT_SYMBOL(vfs_set_acl);
+
+/**
+ * vfs_get_acl - get posix acls
+ * @mnt_userns: user namespace of the mount
+ * @dentry: the dentry based on which to retrieve the posix acls
+ * @acl_name: the name of the posix acl
+ *
+ * This function retrieves @kacl from the filesystem. The caller must all
+ * posix_acl_release() on @kacl.
+ *
+ * Return: On success POSIX ACLs in VFS format, on error negative errno.
+ */
+struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
+			      struct dentry *dentry, const char *acl_name)
+{
+	struct inode *inode = d_inode(dentry);
+	struct posix_acl *acl;
+	int acl_type, error;
+
+	acl_type = posix_acl_type(acl_name);
+	if (acl_type < 0)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * The VFS has no restrictions on reading POSIX ACLs so calling
+	 * something like xattr_permission() isn't needed. Only LSMs get a say.
+	 */
+	error = security_inode_getxattr(dentry, acl_name);
+	if (error)
+		return ERR_PTR(error);
+
+	if (!IS_POSIXACL(inode))
+		return ERR_PTR(-EOPNOTSUPP);
+	if (S_ISLNK(inode->i_mode))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	acl = __get_acl(mnt_userns, dentry, inode, acl_type);
+	if (IS_ERR(acl))
+		return acl;
+	if (!acl)
+		return ERR_PTR(-ENODATA);
+
+	return acl;
+}
+EXPORT_SYMBOL(vfs_get_acl);
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 85a5671204c4..06e65b1c6e28 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -102,6 +102,8 @@ static inline void cache_no_acl(struct inode *inode)
 
 int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		const char *acl_name, struct posix_acl *kacl);
+struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
+			      struct dentry *dentry, const char *acl_name);
 #else
 static inline int posix_acl_chmod(struct user_namespace *mnt_userns,
 				  struct dentry *dentry, umode_t mode)
@@ -136,6 +138,13 @@ static inline int vfs_set_acl(struct user_namespace *mnt_userns,
 {
 	return 0;
 }
+
+static inline struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
+					    struct dentry *dentry,
+					    const char *acl_name)
+{
+	return NULL;
+}
 #endif /* CONFIG_FS_POSIX_ACL */
 
 struct posix_acl *get_acl(struct inode *inode, int type);
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index ebfa11ac7046..3bd8fac436bc 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -38,6 +38,9 @@ void posix_acl_fix_xattr_to_user(void *value, size_t size);
 void posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
 				     const struct inode *inode,
 				     void *value, size_t size);
+ssize_t vfs_posix_acl_to_xattr(struct user_namespace *mnt_userns,
+			       struct inode *inode, const struct posix_acl *acl,
+			       void *buffer, size_t size);
 #else
 static inline void posix_acl_fix_xattr_from_user(void *value, size_t size)
 {
@@ -51,6 +54,13 @@ posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
 				size_t size)
 {
 }
+static inline ssize_t vfs_posix_acl_to_xattr(struct user_namespace *mnt_userns,
+					     struct inode *inode,
+					     const struct posix_acl *acl,
+					     void *buffer, size_t size)
+{
+	return 0;
+}
 #endif
 
 struct posix_acl *posix_acl_from_xattr(struct user_namespace *user_ns, 
-- 
2.34.1

