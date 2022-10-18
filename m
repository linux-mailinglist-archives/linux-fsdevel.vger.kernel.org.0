Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD8B602AEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 14:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJRMAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 08:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJRL7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:59:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E0BE2DE;
        Tue, 18 Oct 2022 04:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DAA20CE1B86;
        Tue, 18 Oct 2022 11:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6B4C4347C;
        Tue, 18 Oct 2022 11:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666094299;
        bh=tZL6vtKQsp3fIjI49p8DTpu+oYfjQLSRHc5T+wXYxRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hct0mp6zsqmurWgQFH6p2SkPmZhh0HQnTQPRjmFWu7SjEe0aNFjEIaIuAHKgA96aw
         xrgZzHHAwEFDiiy76as5pMc4nk9LgqWOUwoN1v7XFu+ueyWkOJGZZjmRLCVhSuMwZo
         lwHTTnErOw3aJHCwvqd8Annq1lO6Y6teIoYznQ0RqHkyPg9LcL42YVttpjs9N9SQN3
         acHV+07/SyBY0tE5QIJUmOAAh2AV5esHARw3XGRM89RnbOpJCMhAwo82rFw3CpeFXj
         lmBXJvSJyVsWbiNZixuSSH+zStBRxXycsQdkT9NXQniEBL9zp5wnDltVap41/Q/u24
         cP1vFrPTaX2ug==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 23/30] ovl: use posix acl api
Date:   Tue, 18 Oct 2022 13:56:53 +0200
Message-Id: <20221018115700.166010-24-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018115700.166010-1-brauner@kernel.org>
References: <20221018115700.166010-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7214; i=brauner@kernel.org; h=from:subject; bh=tZL6vtKQsp3fIjI49p8DTpu+oYfjQLSRHc5T+wXYxRk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7TdHUqJSRnRyb+8dbf0d+5DGOTu/z0n07yjf/kayx+9gQ em5ORykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETMjBgZzsw7+Y9XchnXtY3zl3450D khVGJzWm3QDLWU+p890ZOPrWb4H7V1sfdLznebvh3a/dtBR7rnlZcjt8Eemfy4132zvi96wA8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that posix acls have a proper api us it to copy them.

All filesystems that can serve as lower or upper layers for overlayfs
have gained support for the new posix acl api in previous patches.
So switch all internal overlayfs codepaths for copying posix acls to the
new posix acl api.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Acked-by: Miklos Szeredi <miklos@szeredi.hu>
---

Notes:
    /* v2 */
    Miklos Szeredi <miklos@szeredi.hu>:
    - Move ovl_copy_acl() from util.c to copy_up.c
    - Unconditionally clone posix acls
    
    /* v3 */
    unchanged
    
    /* v4 */
    unchanged
    
    /* v5 */
    unchanged

 fs/overlayfs/copy_up.c   | 38 ++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/dir.c       | 20 ++------------------
 fs/overlayfs/inode.c     |  4 ++--
 fs/overlayfs/overlayfs.h |  8 ++++++++
 fs/overlayfs/super.c     |  6 ++----
 fs/xattr.c               |  6 ------
 include/linux/xattr.h    |  6 ++++++
 7 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index f436d8847f08..6e4e65ee050d 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -44,6 +44,35 @@ static bool ovl_must_copy_xattr(const char *name)
 	       !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN);
 }
 
+static int ovl_copy_acl(struct ovl_fs *ofs, const struct path *path,
+			struct dentry *dentry, const char *acl_name)
+{
+	int err;
+	struct posix_acl *clone, *real_acl = NULL;
+
+	real_acl = ovl_get_acl_path(path, acl_name, false);
+	if (!real_acl)
+		return 0;
+
+	if (IS_ERR(real_acl)) {
+		err = PTR_ERR(real_acl);
+		if (err == -ENODATA || err == -EOPNOTSUPP)
+			return 0;
+		return err;
+	}
+
+	clone = posix_acl_clone(real_acl, GFP_KERNEL);
+	posix_acl_release(real_acl); /* release original acl */
+	if (!clone)
+		return -ENOMEM;
+
+	err = ovl_do_set_acl(ofs, dentry, acl_name, clone);
+
+	/* release cloned acl */
+	posix_acl_release(clone);
+	return err;
+}
+
 int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct dentry *new)
 {
 	struct dentry *old = oldpath->dentry;
@@ -93,6 +122,15 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 			error = 0;
 			continue; /* Discard */
 		}
+
+		if (is_posix_acl_xattr(name)) {
+			error = ovl_copy_acl(OVL_FS(sb), oldpath, new, name);
+			if (!error)
+				continue;
+			/* POSIX ACLs must be copied. */
+			break;
+		}
+
 retry:
 		size = ovl_do_getxattr(oldpath, name, value, value_size);
 		if (size == -ERANGE)
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0e817ebce92c..cbb569d5d234 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -435,28 +435,12 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 }
 
 static int ovl_set_upper_acl(struct ovl_fs *ofs, struct dentry *upperdentry,
-			     const char *name, const struct posix_acl *acl)
+			     const char *acl_name, struct posix_acl *acl)
 {
-	void *buffer;
-	size_t size;
-	int err;
-
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !acl)
 		return 0;
 
-	size = posix_acl_xattr_size(acl->a_count);
-	buffer = kmalloc(size, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
-	err = posix_acl_to_xattr(&init_user_ns, acl, buffer, size);
-	if (err < 0)
-		goto out_free;
-
-	err = ovl_do_setxattr(ofs, upperdentry, name, buffer, size, XATTR_CREATE);
-out_free:
-	kfree(buffer);
-	return err;
+	return ovl_do_set_acl(ofs, upperdentry, acl_name, acl);
 }
 
 static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 304a6dbb852a..77a77fd7a77b 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -510,8 +510,8 @@ static void ovl_idmap_posix_acl(const struct inode *realinode,
  * Until we have made a decision allow this helper to take the @noperm
  * argument. We should hopefully be able to remove it soon.
  */
-static struct posix_acl *ovl_get_acl_path(const struct path *path,
-					  const char *acl_name, bool noperm)
+struct posix_acl *ovl_get_acl_path(const struct path *path,
+				   const char *acl_name, bool noperm)
 {
 	struct posix_acl *real_acl, *clone;
 	struct user_namespace *mnt_userns;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index ab5061c9aa2a..480e6aabef27 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -623,10 +623,18 @@ static inline struct posix_acl *ovl_get_acl(struct user_namespace *mnt_userns,
 }
 int ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct posix_acl *acl, int type);
+struct posix_acl *ovl_get_acl_path(const struct path *path,
+				   const char *acl_name, bool noperm);
 #else
 #define ovl_get_inode_acl	NULL
 #define ovl_get_acl		NULL
 #define ovl_set_acl		NULL
+static inline struct posix_acl *ovl_get_acl_path(const struct path *path,
+						 const char *acl_name,
+						 bool noperm)
+{
+	return NULL;
+}
 #endif
 
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index a29a8afe9b26..5c1b7971a9b3 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -813,13 +813,11 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		 * allowed as upper are limited to "normal" ones, where checking
 		 * for the above two errors is sufficient.
 		 */
-		err = ovl_do_removexattr(ofs, work,
-					 XATTR_NAME_POSIX_ACL_DEFAULT);
+		err = ovl_do_remove_acl(ofs, work, XATTR_NAME_POSIX_ACL_DEFAULT);
 		if (err && err != -ENODATA && err != -EOPNOTSUPP)
 			goto out_dput;
 
-		err = ovl_do_removexattr(ofs, work,
-					 XATTR_NAME_POSIX_ACL_ACCESS);
+		err = ovl_do_remove_acl(ofs, work, XATTR_NAME_POSIX_ACL_ACCESS);
 		if (err && err != -ENODATA && err != -EOPNOTSUPP)
 			goto out_dput;
 
diff --git a/fs/xattr.c b/fs/xattr.c
index 31b5ac65ca34..9ed9eea4d1b9 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -299,12 +299,6 @@ __vfs_setxattr_locked(struct user_namespace *mnt_userns, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(__vfs_setxattr_locked);
 
-static inline bool is_posix_acl_xattr(const char *name)
-{
-	return (strcmp(name, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
-	       (strcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT) == 0);
-}
-
 int
 vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	     const char *name, const void *value, size_t size, int flags)
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 4c379d23ec6e..c5238744bab9 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -22,6 +22,12 @@
 struct inode;
 struct dentry;
 
+static inline bool is_posix_acl_xattr(const char *name)
+{
+	return (strcmp(name, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
+	       (strcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT) == 0);
+}
+
 /*
  * struct xattr_handler: When @name is set, match attributes with exactly that
  * name.  When @prefix is set instead, match attributes with that prefix and
-- 
2.34.1

