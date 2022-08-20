Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FA959AF67
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 20:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiHTSNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 14:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiHTSNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:13:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471FF40546
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
        Cc:Content-Type:Content-ID:Content-Description;
        bh=kcq1X5PcXt7i5mdc+JZmB4onQUe+FLIoAbeac6GOjx8=; b=Yah49HTXl1BoxVQOFajYlQgKWb
        /46MYMB0ENKeUspbitt8gmIvb6O52kbtHck/+8dsIknSSCotpiI9OPgDERsg8fyjbIOz+xCjLCstb
        1adANWQQKVfugeo8WLgeDAvH65C9xOuWrJIBpefeexoOKdJER4+KouCAmjPW1pvffN2rBuVvgELu9
        jQQXDOAex+hdk/tA3pUK0hOYkFa1SEz+ksa4qdSVFiNytMCr7H4odYV6V+D88OwuAro1nDlmIYEOH
        i9n+AlH0N2FMxqFoVZDqrKlvdT9r6ClFoP9UtZpJzdA4XP2j8jYatJyo5351ZwyGcuLhLT4ICEy2+
        ikgX8O4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPSxs-006RVq-Qx
        for linux-fsdevel@vger.kernel.org;
        Sat, 20 Aug 2022 18:12:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/11] overlayfs: constify path
Date:   Sat, 20 Aug 2022 19:12:50 +0100
Message-Id: <20220820181256.1535714-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
References: <YwEjnoTgi7K6iijN@ZenIV>
 <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/copy_up.c   | 12 ++++++------
 fs/overlayfs/file.c      |  2 +-
 fs/overlayfs/inode.c     |  6 +++---
 fs/overlayfs/namei.c     |  4 ++--
 fs/overlayfs/overlayfs.h | 22 +++++++++++-----------
 fs/overlayfs/readdir.c   | 16 ++++++++--------
 fs/overlayfs/super.c     |  8 ++++----
 fs/overlayfs/util.c      | 10 +++++-----
 8 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index fdde6c56cc3d..3ffea291c410 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -44,7 +44,7 @@ static bool ovl_must_copy_xattr(const char *name)
 	       !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN);
 }
 
-int ovl_copy_xattr(struct super_block *sb, struct path *oldpath, struct dentry *new)
+int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct dentry *new)
 {
 	struct dentry *old = oldpath->dentry;
 	ssize_t list_size, size, value_size = 0;
@@ -132,8 +132,8 @@ int ovl_copy_xattr(struct super_block *sb, struct path *oldpath, struct dentry *
 	return error;
 }
 
-static int ovl_copy_fileattr(struct inode *inode, struct path *old,
-			     struct path *new)
+static int ovl_copy_fileattr(struct inode *inode, const struct path *old,
+			     const struct path *new)
 {
 	struct fileattr oldfa = { .flags_valid = true };
 	struct fileattr newfa = { .flags_valid = true };
@@ -193,8 +193,8 @@ static int ovl_copy_fileattr(struct inode *inode, struct path *old,
 	return ovl_real_fileattr_set(new, &newfa);
 }
 
-static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
-			    struct path *new, loff_t len)
+static int ovl_copy_up_data(struct ovl_fs *ofs, const struct path *old,
+			    const struct path *new, loff_t len)
 {
 	struct file *old_file;
 	struct file *new_file;
@@ -872,7 +872,7 @@ static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
 	return true;
 }
 
-static ssize_t ovl_getxattr_value(struct path *path, char *name, char **value)
+static ssize_t ovl_getxattr_value(const struct path *path, char *name, char **value)
 {
 	ssize_t res;
 	char *buf;
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index daff601b5c41..a1a22f58ba18 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -38,7 +38,7 @@ static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 #define OVL_OPEN_FLAGS (O_NOATIME | FMODE_NONOTIFY)
 
 static struct file *ovl_open_realfile(const struct file *file,
-				      struct path *realpath)
+				      const struct path *realpath)
 {
 	struct inode *realinode = d_inode(realpath->dentry);
 	struct inode *inode = file_inode(file);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index b45fea69fff3..19bd9af8b8a8 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -585,7 +585,7 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  * Introducing security_inode_fileattr_get/set() hooks would solve this issue
  * properly.
  */
-static int ovl_security_fileattr(struct path *realpath, struct fileattr *fa,
+static int ovl_security_fileattr(const struct path *realpath, struct fileattr *fa,
 				 bool set)
 {
 	struct file *file;
@@ -607,7 +607,7 @@ static int ovl_security_fileattr(struct path *realpath, struct fileattr *fa,
 	return err;
 }
 
-int ovl_real_fileattr_set(struct path *realpath, struct fileattr *fa)
+int ovl_real_fileattr_set(const struct path *realpath, struct fileattr *fa)
 {
 	int err;
 
@@ -682,7 +682,7 @@ static void ovl_fileattr_prot_flags(struct inode *inode, struct fileattr *fa)
 	}
 }
 
-int ovl_real_fileattr_get(struct path *realpath, struct fileattr *fa)
+int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa)
 {
 	int err;
 
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 69dc577974f8..0fd1d5fdfc72 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -26,7 +26,7 @@ struct ovl_lookup_data {
 	bool metacopy;
 };
 
-static int ovl_check_redirect(struct path *path, struct ovl_lookup_data *d,
+static int ovl_check_redirect(const struct path *path, struct ovl_lookup_data *d,
 			      size_t prelen, const char *post)
 {
 	int res;
@@ -194,7 +194,7 @@ struct dentry *ovl_decode_real_fh(struct ovl_fs *ofs, struct ovl_fh *fh,
 	return real;
 }
 
-static bool ovl_is_opaquedir(struct ovl_fs *ofs, struct path *path)
+static bool ovl_is_opaquedir(struct ovl_fs *ofs, const struct path *path)
 {
 	return ovl_path_check_dir_xattr(ofs, path, OVL_XATTR_OPAQUE);
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 87759165d32b..1ac96eaeda54 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -208,7 +208,7 @@ static inline int ovl_do_symlink(struct ovl_fs *ofs,
 	return err;
 }
 
-static inline ssize_t ovl_do_getxattr(struct path *path, const char *name,
+static inline ssize_t ovl_do_getxattr(const struct path *path, const char *name,
 				      void *value, size_t size)
 {
 	int err, len;
@@ -238,7 +238,7 @@ static inline ssize_t ovl_getxattr_upper(struct ovl_fs *ofs,
 }
 
 static inline ssize_t ovl_path_getxattr(struct ovl_fs *ofs,
-					 struct path *path,
+					 const struct path *path,
 					 enum ovl_xattr ox, void *value,
 					 size_t size)
 {
@@ -401,13 +401,13 @@ void ovl_inode_update(struct inode *inode, struct dentry *upperdentry);
 void ovl_dir_modified(struct dentry *dentry, bool impurity);
 u64 ovl_dentry_version_get(struct dentry *dentry);
 bool ovl_is_whiteout(struct dentry *dentry);
-struct file *ovl_path_open(struct path *path, int flags);
+struct file *ovl_path_open(const struct path *path, int flags);
 int ovl_copy_up_start(struct dentry *dentry, int flags);
 void ovl_copy_up_end(struct dentry *dentry);
 bool ovl_already_copied_up(struct dentry *dentry, int flags);
-bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, struct path *path,
+bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, const struct path *path,
 			      enum ovl_xattr ox);
-bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, struct path *path);
+bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, const struct path *path);
 
 static inline bool ovl_check_origin_xattr(struct ovl_fs *ofs,
 					  struct dentry *upperdentry)
@@ -430,9 +430,9 @@ bool ovl_need_index(struct dentry *dentry);
 int ovl_nlink_start(struct dentry *dentry);
 void ovl_nlink_end(struct dentry *dentry);
 int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir);
-int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct path *path);
+int ovl_check_metacopy_xattr(struct ovl_fs *ofs, const struct path *path);
 bool ovl_is_metacopy_dentry(struct dentry *dentry);
-char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct path *path, int padding);
+char *ovl_get_redirect_xattr(struct ovl_fs *ofs, const struct path *path, int padding);
 int ovl_sync_status(struct ovl_fs *ofs);
 
 static inline void ovl_set_flag(unsigned long flag, struct inode *inode)
@@ -556,7 +556,7 @@ void ovl_cleanup_whiteouts(struct ovl_fs *ofs, struct dentry *upper,
 			   struct list_head *list);
 void ovl_cache_free(struct list_head *list);
 void ovl_dir_cache_free(struct inode *inode);
-int ovl_check_d_type_supported(struct path *realpath);
+int ovl_check_d_type_supported(const struct path *realpath);
 int ovl_workdir_cleanup(struct ovl_fs *ofs, struct inode *dir,
 			struct vfsmount *mnt, struct dentry *dentry, int level);
 int ovl_indexdir_cleanup(struct ovl_fs *ofs);
@@ -673,8 +673,8 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 extern const struct file_operations ovl_file_operations;
 int __init ovl_aio_request_cache_init(void);
 void ovl_aio_request_cache_destroy(void);
-int ovl_real_fileattr_get(struct path *realpath, struct fileattr *fa);
-int ovl_real_fileattr_set(struct path *realpath, struct fileattr *fa);
+int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa);
+int ovl_real_fileattr_set(const struct path *realpath, struct fileattr *fa);
 int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 int ovl_fileattr_set(struct user_namespace *mnt_userns,
 		     struct dentry *dentry, struct fileattr *fa);
@@ -683,7 +683,7 @@ int ovl_fileattr_set(struct user_namespace *mnt_userns,
 int ovl_copy_up(struct dentry *dentry);
 int ovl_copy_up_with_data(struct dentry *dentry);
 int ovl_maybe_copy_up(struct dentry *dentry, int flags);
-int ovl_copy_xattr(struct super_block *sb, struct path *path, struct dentry *new);
+int ovl_copy_xattr(struct super_block *sb, const struct path *path, struct dentry *new);
 int ovl_set_attr(struct ovl_fs *ofs, struct dentry *upper, struct kstat *stat);
 struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
 				  bool is_upper);
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 78f62cc1797b..268ed415577a 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -264,7 +264,7 @@ static int ovl_fill_merge(struct dir_context *ctx, const char *name,
 		return ovl_fill_lowest(rdd, name, namelen, offset, ino, d_type);
 }
 
-static int ovl_check_whiteouts(struct path *path, struct ovl_readdir_data *rdd)
+static int ovl_check_whiteouts(const struct path *path, struct ovl_readdir_data *rdd)
 {
 	int err;
 	struct ovl_cache_entry *p;
@@ -291,7 +291,7 @@ static int ovl_check_whiteouts(struct path *path, struct ovl_readdir_data *rdd)
 	return err;
 }
 
-static inline int ovl_dir_read(struct path *realpath,
+static inline int ovl_dir_read(const struct path *realpath,
 			       struct ovl_readdir_data *rdd)
 {
 	struct file *realfile;
@@ -455,7 +455,7 @@ static u64 ovl_remap_lower_ino(u64 ino, int xinobits, int fsid,
  * copy up origin, call vfs_getattr() on the overlay entry to make
  * sure that d_ino will be consistent with st_ino from stat(2).
  */
-static int ovl_cache_update_ino(struct path *path, struct ovl_cache_entry *p)
+static int ovl_cache_update_ino(const struct path *path, struct ovl_cache_entry *p)
 
 {
 	struct dentry *dir = path->dentry;
@@ -547,7 +547,7 @@ static int ovl_fill_plain(struct dir_context *ctx, const char *name,
 	return 0;
 }
 
-static int ovl_dir_read_impure(struct path *path,  struct list_head *list,
+static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 			       struct rb_root *root)
 {
 	int err;
@@ -592,7 +592,7 @@ static int ovl_dir_read_impure(struct path *path,  struct list_head *list,
 	return 0;
 }
 
-static struct ovl_dir_cache *ovl_cache_get_impure(struct path *path)
+static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *path)
 {
 	int res;
 	struct dentry *dentry = path->dentry;
@@ -834,7 +834,7 @@ static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
 }
 
 static struct file *ovl_dir_open_realfile(const struct file *file,
-					  struct path *realpath)
+					  const struct path *realpath)
 {
 	struct file *res;
 	const struct cred *old_cred;
@@ -1048,7 +1048,7 @@ static int ovl_check_d_type(struct dir_context *ctx, const char *name,
  * Returns 1 if d_type is supported, 0 not supported/unknown. Negative values
  * if error is encountered.
  */
-int ovl_check_d_type_supported(struct path *realpath)
+int ovl_check_d_type_supported(const struct path *realpath)
 {
 	int err;
 	struct ovl_readdir_data rdd = {
@@ -1065,7 +1065,7 @@ int ovl_check_d_type_supported(struct path *realpath)
 
 #define OVL_INCOMPATDIR_NAME "incompat"
 
-static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, struct path *path,
+static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, const struct path *path,
 				       int level)
 {
 	int err;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index ec746d447f1b..d51a02d555e0 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -908,7 +908,7 @@ static int ovl_mount_dir(const char *name, struct path *path)
 	return err;
 }
 
-static int ovl_check_namelen(struct path *path, struct ovl_fs *ofs,
+static int ovl_check_namelen(const struct path *path, struct ovl_fs *ofs,
 			     const char *name)
 {
 	struct kstatfs statfs;
@@ -1353,7 +1353,7 @@ static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
 }
 
 static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
-			    struct path *workpath)
+			    const struct path *workpath)
 {
 	struct vfsmount *mnt = ovl_upper_mnt(ofs);
 	struct dentry *temp, *workdir;
@@ -1482,7 +1482,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 }
 
 static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
-			   struct path *upperpath)
+			   const struct path *upperpath)
 {
 	int err;
 	struct path workpath = { };
@@ -1525,7 +1525,7 @@ static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
 }
 
 static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
-			    struct ovl_entry *oe, struct path *upperpath)
+			    struct ovl_entry *oe, const struct path *upperpath)
 {
 	struct vfsmount *mnt = ovl_upper_mnt(ofs);
 	struct dentry *indexdir;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 87f811c089e4..81a57a8d80d9 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -490,7 +490,7 @@ bool ovl_is_whiteout(struct dentry *dentry)
 	return inode && IS_WHITEOUT(inode);
 }
 
-struct file *ovl_path_open(struct path *path, int flags)
+struct file *ovl_path_open(const struct path *path, int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct user_namespace *real_mnt_userns = mnt_user_ns(path->mnt);
@@ -578,7 +578,7 @@ void ovl_copy_up_end(struct dentry *dentry)
 	ovl_inode_unlock(d_inode(dentry));
 }
 
-bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, struct path *path)
+bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, const struct path *path)
 {
 	int res;
 
@@ -591,7 +591,7 @@ bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, struct path *path)
 	return false;
 }
 
-bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, struct path *path,
+bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, const struct path *path,
 			       enum ovl_xattr ox)
 {
 	int res;
@@ -971,7 +971,7 @@ int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir)
 }
 
 /* err < 0, 0 if no metacopy xattr, 1 if metacopy xattr found */
-int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct path *path)
+int ovl_check_metacopy_xattr(struct ovl_fs *ofs, const struct path *path)
 {
 	int res;
 
@@ -1015,7 +1015,7 @@ bool ovl_is_metacopy_dentry(struct dentry *dentry)
 	return (oe->numlower > 1);
 }
 
-char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct path *path, int padding)
+char *ovl_get_redirect_xattr(struct ovl_fs *ofs, const struct path *path, int padding)
 {
 	int res;
 	char *s, *next, *buf = NULL;
-- 
2.30.2

