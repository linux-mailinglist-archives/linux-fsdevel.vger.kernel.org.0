Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580CB6695F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 12:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbjAMLwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 06:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241483AbjAMLwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0CE39F9A
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 03:49:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6DABB82126
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 11:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A66AC433F0;
        Fri, 13 Jan 2023 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673610585;
        bh=aED3cAh3ON0ItLY2HuOsUYaXlTZ29+SVkB3Fr0RuM9c=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=R/3sptwfeKSuwnp5IuZCQQd8dSmYgWGDQQwxoL5AGXJ9I4LBw/fcyXSfiWwCLzGGM
         xQcfaQPrn9B52VX4ELFPprer4jFdwtgGaVoYIX9Xv9TrR2h0J/u6nyqMaV4ew79+3Y
         YHrhsj2FS3jpKiZLizujPNimO0gNm2zn/+/Ur70lSqPzUbMrw3f0/JZDsuZZ/AAxa9
         0zfsFF7i8g83cqkHjbc2Ox8/pzHy+i2qlm6QYihxzFDvwEnQOiRPrDousuSXQwDv1x
         +vvtb/FVs2RtnKDIcMdq1tKAt+XFt0eQDuUAFOaY4OeYieBEeekSV1ScsJnSNG7ngI
         Zao+VVGmdB1QA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 13 Jan 2023 12:49:10 +0100
Subject: [PATCH 02/25] fs: port vfs_*() helpers to struct mnt_idmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-fs-idmapped-mnt_idmap-conversion-v1-2-fc84fa7eba67@kernel.org>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: b4 0.12-dev-5b205
X-Developer-Signature: v=1; a=openpgp-sha256; l=71187; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aED3cAh3ON0ItLY2HuOsUYaXlTZ29+SVkB3Fr0RuM9c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQfdA2s5m3UOXV12p6k2xIWRm0ND869m+iRcfHf8Zpi8/lP
 eLwZO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyuIeR4Uv9XMeVBZ+c3CI/iWyclq
 m5+trMoGu5GcsvslRcz/QQecbIcCVQakLZ3FqGG9fWV97mmv7qqn7ButdVdXOYTwova5NU5wYA
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

Convert to struct mnt_idmap.

Last cycle we merged the necessary infrastructure in
256c8aed2b42 ("fs: introduce dedicated idmap type for mounts").
This is just the conversion to struct mnt_idmap.

Currently we still pass around the plain namespace that was attached to a
mount. This is in general pretty convenient but it makes it easy to
conflate namespaces that are relevant on the filesystem with namespaces
that are relevent on the mount level. Especially for non-vfs developers
without detailed knowledge in this area this can be a potential source for
bugs.

Once the conversion to struct mnt_idmap is done all helpers down to the
really low-level helpers will take a struct mnt_idmap argument instead of
two namespace arguments. This way it becomes impossible to conflate the two
eliminating the possibility of any bugs. All of the vfs and all filesystems
only operate on struct mnt_idmap.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 drivers/base/devtmpfs.c                          |  12 +-
 fs/attr.c                                        |  13 +-
 fs/cachefiles/interface.c                        |   4 +-
 fs/cachefiles/namei.c                            |  12 +-
 fs/coredump.c                                    |   6 +-
 fs/ecryptfs/inode.c                              |  24 +--
 fs/init.c                                        |  12 +-
 fs/inode.c                                       |   6 +-
 fs/ksmbd/smb2pdu.c                               |   6 +-
 fs/ksmbd/smbacl.c                                |   5 +-
 fs/ksmbd/vfs.c                                   |  47 +++---
 fs/ksmbd/vfs.h                                   |   4 +-
 fs/ksmbd/vfs_cache.c                             |   2 +-
 fs/namei.c                                       | 193 ++++++++++++-----------
 fs/nfsd/nfs3proc.c                               |   2 +-
 fs/nfsd/nfs4recover.c                            |   6 +-
 fs/nfsd/vfs.c                                    |  23 +--
 fs/open.c                                        |  23 +--
 fs/overlayfs/overlayfs.h                         |  25 +--
 fs/overlayfs/ovl_entry.h                         |   5 +
 fs/utimes.c                                      |   2 +-
 include/linux/fs.h                               |  32 ++--
 ipc/mqueue.c                                     |   2 +-
 net/unix/af_unix.c                               |   8 +-
 tools/testing/selftests/bpf/progs/profiler.inc.h |   2 +-
 25 files changed, 255 insertions(+), 221 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index e4bffeabf344..03e8a95f1f35 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -173,7 +173,7 @@ static int dev_mkdir(const char *name, umode_t mode)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	err = vfs_mkdir(&init_user_ns, d_inode(path.dentry), dentry, mode);
+	err = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode);
 	if (!err)
 		/* mark as kernel-created inode */
 		d_inode(dentry)->i_private = &thread;
@@ -223,7 +223,7 @@ static int handle_create(const char *nodename, umode_t mode, kuid_t uid,
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	err = vfs_mknod(&init_user_ns, d_inode(path.dentry), dentry, mode,
+	err = vfs_mknod(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode,
 			dev->devt);
 	if (!err) {
 		struct iattr newattrs;
@@ -233,7 +233,7 @@ static int handle_create(const char *nodename, umode_t mode, kuid_t uid,
 		newattrs.ia_gid = gid;
 		newattrs.ia_valid = ATTR_MODE|ATTR_UID|ATTR_GID;
 		inode_lock(d_inode(dentry));
-		notify_change(&init_user_ns, dentry, &newattrs, NULL);
+		notify_change(&nop_mnt_idmap, dentry, &newattrs, NULL);
 		inode_unlock(d_inode(dentry));
 
 		/* mark as kernel-created inode */
@@ -254,7 +254,7 @@ static int dev_rmdir(const char *name)
 		return PTR_ERR(dentry);
 	if (d_really_is_positive(dentry)) {
 		if (d_inode(dentry)->i_private == &thread)
-			err = vfs_rmdir(&init_user_ns, d_inode(parent.dentry),
+			err = vfs_rmdir(&nop_mnt_idmap, d_inode(parent.dentry),
 					dentry);
 		else
 			err = -EPERM;
@@ -341,9 +341,9 @@ static int handle_remove(const char *nodename, struct device *dev)
 			newattrs.ia_valid =
 				ATTR_UID|ATTR_GID|ATTR_MODE;
 			inode_lock(d_inode(dentry));
-			notify_change(&init_user_ns, dentry, &newattrs, NULL);
+			notify_change(&nop_mnt_idmap, dentry, &newattrs, NULL);
 			inode_unlock(d_inode(dentry));
-			err = vfs_unlink(&init_user_ns, d_inode(parent.dentry),
+			err = vfs_unlink(&nop_mnt_idmap, d_inode(parent.dentry),
 					 dentry, NULL);
 			if (!err || err == -ENOENT)
 				deleted = 1;
diff --git a/fs/attr.c b/fs/attr.c
index b45f30e516fa..023a3860568a 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -352,7 +352,7 @@ EXPORT_SYMBOL(may_setattr);
 
 /**
  * notify_change - modify attributes of a filesytem object
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dentry:	object affected
  * @attr:	new attributes
  * @delegated_inode: returns inode, if the inode is delegated
@@ -371,15 +371,16 @@ EXPORT_SYMBOL(may_setattr);
  * the file open for write, as there can be no conflicting delegation in
  * that case.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then
- * take care to map the inode according to @mnt_userns before checking
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then
+ * take care to map the inode according to @idmap before checking
  * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs init_user_ns.
+ * performed on the raw inode simply pass @nop_mnt_idmap.
  */
-int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
+int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr, struct inode **delegated_inode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = dentry->d_inode;
 	umode_t mode = inode->i_mode;
 	int error;
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index a69073a1d3f0..40052bdb3365 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -138,7 +138,7 @@ static int cachefiles_adjust_size(struct cachefiles_object *object)
 		newattrs.ia_size = oi_size & PAGE_MASK;
 		ret = cachefiles_inject_remove_error();
 		if (ret == 0)
-			ret = notify_change(&init_user_ns, file->f_path.dentry,
+			ret = notify_change(&nop_mnt_idmap, file->f_path.dentry,
 					    &newattrs, NULL);
 		if (ret < 0)
 			goto truncate_failed;
@@ -148,7 +148,7 @@ static int cachefiles_adjust_size(struct cachefiles_object *object)
 	newattrs.ia_size = ni_size;
 	ret = cachefiles_inject_write_error();
 	if (ret == 0)
-		ret = notify_change(&init_user_ns, file->f_path.dentry,
+		ret = notify_change(&nop_mnt_idmap, file->f_path.dentry,
 				    &newattrs, NULL);
 
 truncate_failed:
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 03ca8f2f657a..82219a8f6084 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -130,7 +130,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 			goto mkdir_error;
 		ret = cachefiles_inject_write_error();
 		if (ret == 0)
-			ret = vfs_mkdir(&init_user_ns, d_inode(dir), subdir, 0700);
+			ret = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
 		if (ret < 0) {
 			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
 						   cachefiles_trace_mkdir_error);
@@ -245,7 +245,7 @@ static int cachefiles_unlink(struct cachefiles_cache *cache,
 
 	ret = cachefiles_inject_remove_error();
 	if (ret == 0) {
-		ret = vfs_unlink(&init_user_ns, d_backing_inode(dir), dentry, NULL);
+		ret = vfs_unlink(&nop_mnt_idmap, d_backing_inode(dir), dentry, NULL);
 		if (ret == -EIO)
 			cachefiles_io_error(cache, "Unlink failed");
 	}
@@ -382,10 +382,10 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		cachefiles_io_error(cache, "Rename security error %d", ret);
 	} else {
 		struct renamedata rd = {
-			.old_mnt_userns	= &init_user_ns,
+			.old_mnt_idmap	= &nop_mnt_idmap,
 			.old_dir	= d_inode(dir),
 			.old_dentry	= rep,
-			.new_mnt_userns	= &init_user_ns,
+			.new_mnt_idmap	= &nop_mnt_idmap,
 			.new_dir	= d_inode(cache->graveyard),
 			.new_dentry	= grave,
 		};
@@ -451,7 +451,7 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 
 	ret = cachefiles_inject_write_error();
 	if (ret == 0) {
-		file = vfs_tmpfile_open(&init_user_ns, &parentpath, S_IFREG,
+		file = vfs_tmpfile_open(&nop_mnt_idmap, &parentpath, S_IFREG,
 					O_RDWR | O_LARGEFILE | O_DIRECT,
 					cache->cache_cred);
 		ret = PTR_ERR_OR_ZERO(file);
@@ -714,7 +714,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
-		ret = vfs_link(object->file->f_path.dentry, &init_user_ns,
+		ret = vfs_link(object->file->f_path.dentry, &nop_mnt_idmap,
 			       d_inode(fan), dentry, NULL);
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, d_inode(fan), ret,
diff --git a/fs/coredump.c b/fs/coredump.c
index de78bde2991b..27847d16d2b8 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -644,6 +644,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			goto close_fail;
 		}
 	} else {
+		struct mnt_idmap *idmap;
 		struct user_namespace *mnt_userns;
 		struct inode *inode;
 		int open_flags = O_CREAT | O_RDWR | O_NOFOLLOW |
@@ -722,7 +723,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 * a process dumps core while its cwd is e.g. on a vfat
 		 * filesystem.
 		 */
-		mnt_userns = file_mnt_user_ns(cprm.file);
+		idmap = file_mnt_idmap(cprm.file);
+		mnt_userns = mnt_idmap_owner(idmap);
 		if (!vfsuid_eq_kuid(i_uid_into_vfsuid(mnt_userns, inode),
 				    current_fsuid())) {
 			pr_info_ratelimited("Core dump to %s aborted: cannot preserve file owner\n",
@@ -736,7 +738,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 		if (!(cprm.file->f_mode & FMODE_CAN_WRITE))
 			goto close_fail;
-		if (do_truncate(mnt_userns, cprm.file->f_path.dentry,
+		if (do_truncate(idmap, cprm.file->f_path.dentry,
 				0, 0, cprm.file))
 			goto close_fail;
 	}
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index f3cd00fac9c3..d2c5a8c55322 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -139,7 +139,7 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
 		if (d_unhashed(lower_dentry))
 			rc = -EINVAL;
 		else
-			rc = vfs_unlink(&init_user_ns, lower_dir, lower_dentry,
+			rc = vfs_unlink(&nop_mnt_idmap, lower_dir, lower_dentry,
 					NULL);
 	}
 	if (rc) {
@@ -180,7 +180,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 
 	rc = lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
 	if (!rc)
-		rc = vfs_create(&init_user_ns, lower_dir,
+		rc = vfs_create(&nop_mnt_idmap, lower_dir,
 				lower_dentry, mode, true);
 	if (rc) {
 		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
@@ -191,7 +191,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 	inode = __ecryptfs_get_inode(d_inode(lower_dentry),
 				     directory_inode->i_sb);
 	if (IS_ERR(inode)) {
-		vfs_unlink(&init_user_ns, lower_dir, lower_dentry, NULL);
+		vfs_unlink(&nop_mnt_idmap, lower_dir, lower_dentry, NULL);
 		goto out_lock;
 	}
 	fsstack_copy_attr_times(directory_inode, lower_dir);
@@ -434,7 +434,7 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
 	rc = lock_parent(new_dentry, &lower_new_dentry, &lower_dir);
 	if (!rc)
-		rc = vfs_link(lower_old_dentry, &init_user_ns, lower_dir,
+		rc = vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_dir,
 			      lower_new_dentry, NULL);
 	if (rc || d_really_is_negative(lower_new_dentry))
 		goto out_lock;
@@ -478,7 +478,7 @@ static int ecryptfs_symlink(struct user_namespace *mnt_userns,
 						  strlen(symname));
 	if (rc)
 		goto out_lock;
-	rc = vfs_symlink(&init_user_ns, lower_dir, lower_dentry,
+	rc = vfs_symlink(&nop_mnt_idmap, lower_dir, lower_dentry,
 			 encoded_symname);
 	kfree(encoded_symname);
 	if (rc || d_really_is_negative(lower_dentry))
@@ -504,7 +504,7 @@ static int ecryptfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 
 	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
 	if (!rc)
-		rc = vfs_mkdir(&init_user_ns, lower_dir,
+		rc = vfs_mkdir(&nop_mnt_idmap, lower_dir,
 			       lower_dentry, mode);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
@@ -533,7 +533,7 @@ static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
 		if (d_unhashed(lower_dentry))
 			rc = -EINVAL;
 		else
-			rc = vfs_rmdir(&init_user_ns, lower_dir, lower_dentry);
+			rc = vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
 	}
 	if (!rc) {
 		clear_nlink(d_inode(dentry));
@@ -557,7 +557,7 @@ ecryptfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 
 	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
 	if (!rc)
-		rc = vfs_mknod(&init_user_ns, lower_dir,
+		rc = vfs_mknod(&nop_mnt_idmap, lower_dir,
 			       lower_dentry, mode, dev);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
@@ -616,10 +616,10 @@ ecryptfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		goto out_lock;
 	}
 
-	rd.old_mnt_userns	= &init_user_ns;
+	rd.old_mnt_idmap	= &nop_mnt_idmap;
 	rd.old_dir		= d_inode(lower_old_dir_dentry);
 	rd.old_dentry		= lower_old_dentry;
-	rd.new_mnt_userns	= &init_user_ns;
+	rd.new_mnt_idmap	= &nop_mnt_idmap;
 	rd.new_dir		= d_inode(lower_new_dir_dentry);
 	rd.new_dentry		= lower_new_dentry;
 	rc = vfs_rename(&rd);
@@ -856,7 +856,7 @@ int ecryptfs_truncate(struct dentry *dentry, loff_t new_length)
 		struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
 
 		inode_lock(d_inode(lower_dentry));
-		rc = notify_change(&init_user_ns, lower_dentry,
+		rc = notify_change(&nop_mnt_idmap, lower_dentry,
 				   &lower_ia, NULL);
 		inode_unlock(d_inode(lower_dentry));
 	}
@@ -965,7 +965,7 @@ static int ecryptfs_setattr(struct user_namespace *mnt_userns,
 		lower_ia.ia_valid &= ~ATTR_MODE;
 
 	inode_lock(d_inode(lower_dentry));
-	rc = notify_change(&init_user_ns, lower_dentry, &lower_ia, NULL);
+	rc = notify_change(&nop_mnt_idmap, lower_dentry, &lower_ia, NULL);
 	inode_unlock(d_inode(lower_dentry));
 out:
 	fsstack_copy_attr_all(inode, lower_inode);
diff --git a/fs/init.c b/fs/init.c
index 5c36adaa9b44..f43f1e78bf7a 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -157,7 +157,7 @@ int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 		mode &= ~current_umask();
 	error = security_path_mknod(&path, dentry, mode, dev);
 	if (!error)
-		error = vfs_mknod(mnt_user_ns(path.mnt), path.dentry->d_inode,
+		error = vfs_mknod(mnt_idmap(path.mnt), path.dentry->d_inode,
 				  dentry, mode, new_decode_dev(dev));
 	done_path_create(&path, dentry);
 	return error;
@@ -167,6 +167,7 @@ int __init init_link(const char *oldname, const char *newname)
 {
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
+	struct mnt_idmap *idmap;
 	struct user_namespace *mnt_userns;
 	int error;
 
@@ -182,14 +183,15 @@ int __init init_link(const char *oldname, const char *newname)
 	error = -EXDEV;
 	if (old_path.mnt != new_path.mnt)
 		goto out_dput;
-	mnt_userns = mnt_user_ns(new_path.mnt);
+	idmap = mnt_idmap(new_path.mnt);
+	mnt_userns = mnt_idmap_owner(idmap);
 	error = may_linkat(mnt_userns, &old_path);
 	if (unlikely(error))
 		goto out_dput;
 	error = security_path_link(old_path.dentry, &new_path, new_dentry);
 	if (error)
 		goto out_dput;
-	error = vfs_link(old_path.dentry, mnt_userns, new_path.dentry->d_inode,
+	error = vfs_link(old_path.dentry, idmap, new_path.dentry->d_inode,
 			 new_dentry, NULL);
 out_dput:
 	done_path_create(&new_path, new_dentry);
@@ -209,7 +211,7 @@ int __init init_symlink(const char *oldname, const char *newname)
 		return PTR_ERR(dentry);
 	error = security_path_symlink(&path, dentry, oldname);
 	if (!error)
-		error = vfs_symlink(mnt_user_ns(path.mnt), path.dentry->d_inode,
+		error = vfs_symlink(mnt_idmap(path.mnt), path.dentry->d_inode,
 				    dentry, oldname);
 	done_path_create(&path, dentry);
 	return error;
@@ -233,7 +235,7 @@ int __init init_mkdir(const char *pathname, umode_t mode)
 		mode &= ~current_umask();
 	error = security_path_mkdir(&path, dentry, mode);
 	if (!error)
-		error = vfs_mkdir(mnt_user_ns(path.mnt), path.dentry->d_inode,
+		error = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
 				  dentry, mode);
 	done_path_create(&path, dentry);
 	return error;
diff --git a/fs/inode.c b/fs/inode.c
index f453eb58fd03..84b5da325ee8 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1972,7 +1972,7 @@ int dentry_needs_remove_privs(struct user_namespace *mnt_userns,
 	return mask;
 }
 
-static int __remove_privs(struct user_namespace *mnt_userns,
+static int __remove_privs(struct mnt_idmap *idmap,
 			  struct dentry *dentry, int kill)
 {
 	struct iattr newattrs;
@@ -1982,7 +1982,7 @@ static int __remove_privs(struct user_namespace *mnt_userns,
 	 * Note we call this on write, so notify_change will not
 	 * encounter any conflicting delegations:
 	 */
-	return notify_change(mnt_userns, dentry, &newattrs, NULL);
+	return notify_change(idmap, dentry, &newattrs, NULL);
 }
 
 static int __file_remove_privs(struct file *file, unsigned int flags)
@@ -2003,7 +2003,7 @@ static int __file_remove_privs(struct file *file, unsigned int flags)
 		if (flags & IOCB_NOWAIT)
 			return -EAGAIN;
 
-		error = __remove_privs(file_mnt_user_ns(file), dentry, kill);
+		error = __remove_privs(file_mnt_idmap(file), dentry, kill);
 	}
 
 	if (!error)
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 14d7f3599c63..f787f66b329c 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5615,6 +5615,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 	struct iattr attrs;
 	struct file *filp;
 	struct inode *inode;
+	struct mnt_idmap *idmap;
 	struct user_namespace *user_ns;
 	int rc = 0;
 
@@ -5624,7 +5625,8 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 	attrs.ia_valid = 0;
 	filp = fp->filp;
 	inode = file_inode(filp);
-	user_ns = file_mnt_user_ns(filp);
+	idmap = file_mnt_idmap(filp);
+	user_ns = mnt_idmap_owner(idmap);
 
 	if (file_info->CreationTime)
 		fp->create_time = le64_to_cpu(file_info->CreationTime);
@@ -5686,7 +5688,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 		inode_lock(inode);
 		inode->i_ctime = attrs.ia_ctime;
 		attrs.ia_valid &= ~ATTR_CTIME;
-		rc = notify_change(user_ns, dentry, &attrs, NULL);
+		rc = notify_change(idmap, dentry, &attrs, NULL);
 		inode_unlock(inode);
 	}
 	return rc;
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index ab5c68cc0e13..6490342bbb38 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1360,7 +1360,8 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 	int rc;
 	struct smb_fattr fattr = {{0}};
 	struct inode *inode = d_inode(path->dentry);
-	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
+	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
+	struct user_namespace *user_ns = mnt_idmap_owner(idmap);
 	struct iattr newattrs;
 
 	fattr.cf_uid = INVALID_UID;
@@ -1403,7 +1404,7 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 	}
 
 	inode_lock(inode);
-	rc = notify_change(user_ns, path->dentry, &newattrs, NULL);
+	rc = notify_change(idmap, path->dentry, &newattrs, NULL);
 	inode_unlock(inode);
 	if (rc)
 		goto out;
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index ff0e7a4fcd4d..5b284dd61056 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -177,7 +177,7 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 	}
 
 	mode |= S_IFREG;
-	err = vfs_create(mnt_user_ns(path.mnt), d_inode(path.dentry),
+	err = vfs_create(mnt_idmap(path.mnt), d_inode(path.dentry),
 			 dentry, mode, true);
 	if (!err) {
 		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry),
@@ -199,6 +199,7 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
  */
 int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 {
+	struct mnt_idmap *idmap;
 	struct user_namespace *user_ns;
 	struct path path;
 	struct dentry *dentry;
@@ -215,9 +216,10 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 		return err;
 	}
 
-	user_ns = mnt_user_ns(path.mnt);
+	idmap = mnt_idmap(path.mnt);
+	user_ns = mnt_idmap_owner(idmap);
 	mode |= S_IFDIR;
-	err = vfs_mkdir(user_ns, d_inode(path.dentry), dentry, mode);
+	err = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
 	if (err) {
 		goto out;
 	} else if (d_unhashed(dentry)) {
@@ -583,6 +585,7 @@ int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id)
  */
 int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name)
 {
+	struct mnt_idmap *idmap;
 	struct user_namespace *user_ns;
 	struct path path;
 	struct dentry *parent;
@@ -598,7 +601,8 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name)
 		return err;
 	}
 
-	user_ns = mnt_user_ns(path.mnt);
+	idmap = mnt_idmap(path.mnt);
+	user_ns = mnt_idmap_owner(idmap);
 	parent = dget_parent(path.dentry);
 	err = ksmbd_vfs_lock_parent(user_ns, parent, path.dentry);
 	if (err) {
@@ -614,12 +618,12 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name)
 	}
 
 	if (S_ISDIR(d_inode(path.dentry)->i_mode)) {
-		err = vfs_rmdir(user_ns, d_inode(parent), path.dentry);
+		err = vfs_rmdir(idmap, d_inode(parent), path.dentry);
 		if (err && err != -ENOTEMPTY)
 			ksmbd_debug(VFS, "%s: rmdir failed, err %d\n", name,
 				    err);
 	} else {
-		err = vfs_unlink(user_ns, d_inode(parent), path.dentry, NULL);
+		err = vfs_unlink(idmap, d_inode(parent), path.dentry, NULL);
 		if (err)
 			ksmbd_debug(VFS, "%s: unlink failed, err %d\n", name,
 				    err);
@@ -672,7 +676,7 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 		goto out3;
 	}
 
-	err = vfs_link(oldpath.dentry, mnt_user_ns(newpath.mnt),
+	err = vfs_link(oldpath.dentry, mnt_idmap(newpath.mnt),
 		       d_inode(newpath.dentry),
 		       dentry, NULL);
 	if (err)
@@ -711,10 +715,10 @@ static int ksmbd_validate_entry_in_use(struct dentry *src_dent)
 }
 
 static int __ksmbd_vfs_rename(struct ksmbd_work *work,
-			      struct user_namespace *src_user_ns,
+			      struct mnt_idmap *src_idmap,
 			      struct dentry *src_dent_parent,
 			      struct dentry *src_dent,
-			      struct user_namespace *dst_user_ns,
+			      struct mnt_idmap *dst_idmap,
 			      struct dentry *dst_dent_parent,
 			      struct dentry *trap_dent,
 			      char *dst_name)
@@ -740,8 +744,8 @@ static int __ksmbd_vfs_rename(struct ksmbd_work *work,
 	if (ksmbd_override_fsids(work))
 		return -ENOMEM;
 
-	dst_dent = lookup_one(dst_user_ns, dst_name, dst_dent_parent,
-			      strlen(dst_name));
+	dst_dent = lookup_one(mnt_idmap_owner(dst_idmap), dst_name,
+			      dst_dent_parent, strlen(dst_name));
 	err = PTR_ERR(dst_dent);
 	if (IS_ERR(dst_dent)) {
 		pr_err("lookup failed %s [%d]\n", dst_name, err);
@@ -751,10 +755,10 @@ static int __ksmbd_vfs_rename(struct ksmbd_work *work,
 	err = -ENOTEMPTY;
 	if (dst_dent != trap_dent && !d_really_is_positive(dst_dent)) {
 		struct renamedata rd = {
-			.old_mnt_userns	= src_user_ns,
+			.old_mnt_idmap	= src_idmap,
 			.old_dir	= d_inode(src_dent_parent),
 			.old_dentry	= src_dent,
-			.new_mnt_userns	= dst_user_ns,
+			.new_mnt_idmap	= dst_idmap,
 			.new_dir	= d_inode(dst_dent_parent),
 			.new_dentry	= dst_dent,
 		};
@@ -772,6 +776,7 @@ static int __ksmbd_vfs_rename(struct ksmbd_work *work,
 int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
 			char *newname)
 {
+	struct mnt_idmap *idmap;
 	struct user_namespace *user_ns;
 	struct path dst_path;
 	struct dentry *src_dent_parent, *dst_dent_parent;
@@ -800,7 +805,8 @@ int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
 	trap_dent = lock_rename(src_dent_parent, dst_dent_parent);
 	dget(src_dent);
 	dget(dst_dent_parent);
-	user_ns = file_mnt_user_ns(fp->filp);
+	idmap = file_mnt_idmap(fp->filp);
+	user_ns = mnt_idmap_owner(idmap);
 	src_child = lookup_one(user_ns, src_dent->d_name.name, src_dent_parent,
 			       src_dent->d_name.len);
 	if (IS_ERR(src_child)) {
@@ -816,10 +822,10 @@ int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
 	dput(src_child);
 
 	err = __ksmbd_vfs_rename(work,
-				 user_ns,
+				 idmap,
 				 src_dent_parent,
 				 src_dent,
-				 mnt_user_ns(dst_path.mnt),
+				 mnt_idmap(dst_path.mnt),
 				 dst_dent_parent,
 				 trap_dent,
 				 dst_name);
@@ -1080,20 +1086,21 @@ int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
 	return vfs_removexattr(user_ns, dentry, attr_name);
 }
 
-int ksmbd_vfs_unlink(struct user_namespace *user_ns,
+int ksmbd_vfs_unlink(struct mnt_idmap *idmap,
 		     struct dentry *dir, struct dentry *dentry)
 {
 	int err = 0;
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 
-	err = ksmbd_vfs_lock_parent(user_ns, dir, dentry);
+	err = ksmbd_vfs_lock_parent(mnt_userns, dir, dentry);
 	if (err)
 		return err;
 	dget(dentry);
 
 	if (S_ISDIR(d_inode(dentry)->i_mode))
-		err = vfs_rmdir(user_ns, d_inode(dir), dentry);
+		err = vfs_rmdir(idmap, d_inode(dir), dentry);
 	else
-		err = vfs_unlink(user_ns, d_inode(dir), dentry, NULL);
+		err = vfs_unlink(idmap, d_inode(dir), dentry, NULL);
 
 	dput(dentry);
 	inode_unlock(d_inode(dir));
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 0d73d735cc39..0c9b04ae5fbf 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -131,8 +131,8 @@ struct file_allocated_range_buffer;
 int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
 			 struct file_allocated_range_buffer *ranges,
 			 unsigned int in_count, unsigned int *out_count);
-int ksmbd_vfs_unlink(struct user_namespace *user_ns,
-		     struct dentry *dir, struct dentry *dentry);
+int ksmbd_vfs_unlink(struct mnt_idmap *idmap, struct dentry *dir,
+		     struct dentry *dentry);
 void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat);
 int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 				struct user_namespace *user_ns,
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index da9163b00350..8489ff4d601a 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -266,7 +266,7 @@ static void __ksmbd_inode_close(struct ksmbd_file *fp)
 			dir = dentry->d_parent;
 			ci->m_flags &= ~(S_DEL_ON_CLS | S_DEL_PENDING);
 			write_unlock(&ci->m_lock);
-			ksmbd_vfs_unlink(file_mnt_user_ns(filp), dir, dentry);
+			ksmbd_vfs_unlink(file_mnt_idmap(filp), dir, dentry);
 			write_lock(&ci->m_lock);
 		}
 		write_unlock(&ci->m_lock);
diff --git a/fs/namei.c b/fs/namei.c
index 309ae6fc8c99..3e727efed860 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3084,7 +3084,7 @@ static inline umode_t vfs_prepare_mode(struct user_namespace *mnt_userns,
 
 /**
  * vfs_create - create new file
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dir:	inode of @dentry
  * @dentry:	pointer to dentry of the base directory
  * @mode:	mode of the new file
@@ -3092,16 +3092,19 @@ static inline umode_t vfs_prepare_mode(struct user_namespace *mnt_userns,
  *
  * Create a new file.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then take
- * care to map the inode according to @mnt_userns before checking permissions.
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs init_user_ns.
+ * raw inode simply passs @nop_mnt_idmap.
  */
-int vfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	       struct dentry *dentry, umode_t mode, bool want_excl)
 {
-	int error = may_create(mnt_userns, dir, dentry);
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+	int error;
+
+	error = may_create(mnt_userns, dir, dentry);
 	if (error)
 		return error;
 
@@ -3203,7 +3206,7 @@ static int may_open(struct user_namespace *mnt_userns, const struct path *path,
 	return 0;
 }
 
-static int handle_truncate(struct user_namespace *mnt_userns, struct file *filp)
+static int handle_truncate(struct mnt_idmap *idmap, struct file *filp)
 {
 	const struct path *path = &filp->f_path;
 	struct inode *inode = path->dentry->d_inode;
@@ -3213,7 +3216,7 @@ static int handle_truncate(struct user_namespace *mnt_userns, struct file *filp)
 
 	error = security_file_truncate(filp);
 	if (!error) {
-		error = do_truncate(mnt_userns, path->dentry, 0,
+		error = do_truncate(idmap, path->dentry, 0,
 				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
 				    filp);
 	}
@@ -3513,6 +3516,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 static int do_open(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
+	struct mnt_idmap *idmap;
 	struct user_namespace *mnt_userns;
 	int open_flag = op->open_flag;
 	bool do_truncate;
@@ -3526,7 +3530,8 @@ static int do_open(struct nameidata *nd,
 	}
 	if (!(file->f_mode & FMODE_CREATED))
 		audit_inode(nd->name, nd->path.dentry, 0);
-	mnt_userns = mnt_user_ns(nd->path.mnt);
+	idmap = mnt_idmap(nd->path.mnt);
+	mnt_userns = mnt_idmap_owner(idmap);
 	if (open_flag & O_CREAT) {
 		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
 			return -EEXIST;
@@ -3558,7 +3563,7 @@ static int do_open(struct nameidata *nd,
 	if (!error)
 		error = ima_file_check(file, op->acc_mode);
 	if (!error && do_truncate)
-		error = handle_truncate(mnt_userns, file);
+		error = handle_truncate(idmap, file);
 	if (unlikely(error > 0)) {
 		WARN_ON(1);
 		error = -EINVAL;
@@ -3570,23 +3575,24 @@ static int do_open(struct nameidata *nd,
 
 /**
  * vfs_tmpfile - create tmpfile
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dentry:	pointer to dentry of the base directory
  * @mode:	mode of the new tmpfile
  * @open_flag:	flags
  *
  * Create a temporary file.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then take
- * care to map the inode according to @mnt_userns before checking permissions.
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs init_user_ns.
+ * raw inode simply passs @nop_mnt_idmap.
  */
-static int vfs_tmpfile(struct user_namespace *mnt_userns,
+static int vfs_tmpfile(struct mnt_idmap *idmap,
 		       const struct path *parentpath,
 		       struct file *file, umode_t mode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct dentry *child;
 	struct inode *dir = d_inode(parentpath->dentry);
 	struct inode *inode;
@@ -3625,7 +3631,7 @@ static int vfs_tmpfile(struct user_namespace *mnt_userns,
 
 /**
  * vfs_tmpfile_open - open a tmpfile for kernel internal use
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @parentpath:	path of the base directory
  * @mode:	mode of the new tmpfile
  * @open_flag:	flags
@@ -3635,7 +3641,7 @@ static int vfs_tmpfile(struct user_namespace *mnt_userns,
  * hence this is only for kernel internal use, and must not be installed into
  * file tables or such.
  */
-struct file *vfs_tmpfile_open(struct user_namespace *mnt_userns,
+struct file *vfs_tmpfile_open(struct mnt_idmap *idmap,
 			  const struct path *parentpath,
 			  umode_t mode, int open_flag, const struct cred *cred)
 {
@@ -3644,7 +3650,7 @@ struct file *vfs_tmpfile_open(struct user_namespace *mnt_userns,
 
 	file = alloc_empty_file_noaccount(open_flag, cred);
 	if (!IS_ERR(file)) {
-		error = vfs_tmpfile(mnt_userns, parentpath, file, mode);
+		error = vfs_tmpfile(idmap, parentpath, file, mode);
 		if (error) {
 			fput(file);
 			file = ERR_PTR(error);
@@ -3658,7 +3664,6 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 		const struct open_flags *op,
 		struct file *file)
 {
-	struct user_namespace *mnt_userns;
 	struct path path;
 	int error = path_lookupat(nd, flags | LOOKUP_DIRECTORY, &path);
 
@@ -3667,8 +3672,7 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	error = mnt_want_write(path.mnt);
 	if (unlikely(error))
 		goto out;
-	mnt_userns = mnt_user_ns(path.mnt);
-	error = vfs_tmpfile(mnt_userns, &path, file, op->mode);
+	error = vfs_tmpfile(mnt_idmap(path.mnt), &path, file, op->mode);
 	if (error)
 		goto out2;
 	audit_inode(nd->name, file->f_path.dentry, 0);
@@ -3873,7 +3877,7 @@ EXPORT_SYMBOL(user_path_create);
 
 /**
  * vfs_mknod - create device node or file
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dir:	inode of @dentry
  * @dentry:	pointer to dentry of the base directory
  * @mode:	mode of the new device node or file
@@ -3881,15 +3885,16 @@ EXPORT_SYMBOL(user_path_create);
  *
  * Create a device node or file.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then take
- * care to map the inode according to @mnt_userns before checking permissions.
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs init_user_ns.
+ * raw inode simply passs @nop_mnt_idmap.
  */
-int vfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	      struct dentry *dentry, umode_t mode, dev_t dev)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
 	int error = may_create(mnt_userns, dir, dentry);
 
@@ -3939,6 +3944,7 @@ static int may_mknod(umode_t mode)
 static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 		unsigned int dev)
 {
+	struct mnt_idmap *idmap;
 	struct user_namespace *mnt_userns;
 	struct dentry *dentry;
 	struct path path;
@@ -3959,20 +3965,21 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	if (error)
 		goto out2;
 
-	mnt_userns = mnt_user_ns(path.mnt);
+	idmap = mnt_idmap(path.mnt);
+	mnt_userns = mnt_idmap_owner(idmap);
 	switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
-			error = vfs_create(mnt_userns, path.dentry->d_inode,
+			error = vfs_create(idmap, path.dentry->d_inode,
 					   dentry, mode, true);
 			if (!error)
 				ima_post_path_mknod(mnt_userns, dentry);
 			break;
 		case S_IFCHR: case S_IFBLK:
-			error = vfs_mknod(mnt_userns, path.dentry->d_inode,
+			error = vfs_mknod(idmap, path.dentry->d_inode,
 					  dentry, mode, new_decode_dev(dev));
 			break;
 		case S_IFIFO: case S_IFSOCK:
-			error = vfs_mknod(mnt_userns, path.dentry->d_inode,
+			error = vfs_mknod(idmap, path.dentry->d_inode,
 					  dentry, mode, 0);
 			break;
 	}
@@ -4000,25 +4007,27 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 
 /**
  * vfs_mkdir - create directory
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dir:	inode of @dentry
  * @dentry:	pointer to dentry of the base directory
  * @mode:	mode of the new directory
  *
  * Create a directory.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then take
- * care to map the inode according to @mnt_userns before checking permissions.
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs init_user_ns.
+ * raw inode simply passs @nop_mnt_idmap.
  */
-int vfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	      struct dentry *dentry, umode_t mode)
 {
-	int error = may_create(mnt_userns, dir, dentry);
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
+	int error;
 	unsigned max_links = dir->i_sb->s_max_links;
 
+	error = may_create(mnt_userns, dir, dentry);
 	if (error)
 		return error;
 
@@ -4056,10 +4065,8 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	error = security_path_mkdir(&path, dentry,
 			mode_strip_umask(path.dentry->d_inode, mode));
 	if (!error) {
-		struct user_namespace *mnt_userns;
-		mnt_userns = mnt_user_ns(path.mnt);
-		error = vfs_mkdir(mnt_userns, path.dentry->d_inode, dentry,
-				  mode);
+		error = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
+				  dentry, mode);
 	}
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
@@ -4083,21 +4090,22 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 
 /**
  * vfs_rmdir - remove directory
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dir:	inode of @dentry
  * @dentry:	pointer to dentry of the base directory
  *
  * Remove a directory.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then take
- * care to map the inode according to @mnt_userns before checking permissions.
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs init_user_ns.
+ * raw inode simply passs @nop_mnt_idmap.
  */
-int vfs_rmdir(struct user_namespace *mnt_userns, struct inode *dir,
+int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int error = may_delete(mnt_userns, dir, dentry, 1);
 
 	if (error)
@@ -4138,7 +4146,6 @@ EXPORT_SYMBOL(vfs_rmdir);
 
 int do_rmdir(int dfd, struct filename *name)
 {
-	struct user_namespace *mnt_userns;
 	int error;
 	struct dentry *dentry;
 	struct path path;
@@ -4178,8 +4185,7 @@ int do_rmdir(int dfd, struct filename *name)
 	error = security_path_rmdir(&path, dentry);
 	if (error)
 		goto exit4;
-	mnt_userns = mnt_user_ns(path.mnt);
-	error = vfs_rmdir(mnt_userns, path.dentry->d_inode, dentry);
+	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
 exit4:
 	dput(dentry);
 exit3:
@@ -4203,7 +4209,7 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
 
 /**
  * vfs_unlink - unlink a filesystem object
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dir:	parent directory
  * @dentry:	victim
  * @delegated_inode: returns victim inode, if the inode is delegated.
@@ -4220,15 +4226,16 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
  * be appropriate for callers that expect the underlying filesystem not
  * to be NFS exported.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then take
- * care to map the inode according to @mnt_userns before checking permissions.
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs init_user_ns.
+ * raw inode simply passs @nop_mnt_idmap.
  */
-int vfs_unlink(struct user_namespace *mnt_userns, struct inode *dir,
+int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 	       struct dentry *dentry, struct inode **delegated_inode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *target = dentry->d_inode;
 	int error = may_delete(mnt_userns, dir, dentry, 0);
 
@@ -4304,7 +4311,6 @@ int do_unlinkat(int dfd, struct filename *name)
 	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
-		struct user_namespace *mnt_userns;
 
 		/* Why not before? Because we want correct error value */
 		if (last.name[last.len])
@@ -4316,9 +4322,8 @@ int do_unlinkat(int dfd, struct filename *name)
 		error = security_path_unlink(&path, dentry);
 		if (error)
 			goto exit3;
-		mnt_userns = mnt_user_ns(path.mnt);
-		error = vfs_unlink(mnt_userns, path.dentry->d_inode, dentry,
-				   &delegated_inode);
+		error = vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
+				   dentry, &delegated_inode);
 exit3:
 		dput(dentry);
 	}
@@ -4370,22 +4375,23 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
 
 /**
  * vfs_symlink - create symlink
- * @mnt_userns:	user namespace of the mount the inode was found from
+ * @idmap:	idmap of the mount the inode was found from
  * @dir:	inode of @dentry
  * @dentry:	pointer to dentry of the base directory
  * @oldname:	name of the file to link to
  *
  * Create a symlink.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then take
- * care to map the inode according to @mnt_userns before checking permissions.
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs init_user_ns.
+ * raw inode simply passs @nop_mnt_idmap.
  */
-int vfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		struct dentry *dentry, const char *oldname)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int error = may_create(mnt_userns, dir, dentry);
 
 	if (error)
@@ -4423,13 +4429,9 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
 		goto out_putnames;
 
 	error = security_path_symlink(&path, dentry, from->name);
-	if (!error) {
-		struct user_namespace *mnt_userns;
-
-		mnt_userns = mnt_user_ns(path.mnt);
-		error = vfs_symlink(mnt_userns, path.dentry->d_inode, dentry,
-				    from->name);
-	}
+	if (!error)
+		error = vfs_symlink(mnt_idmap(path.mnt), path.dentry->d_inode,
+				    dentry, from->name);
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -4455,7 +4457,7 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
 /**
  * vfs_link - create a new link
  * @old_dentry:	object to be linked
- * @mnt_userns:	the user namespace of the mount
+ * @idmap:	idmap of the mount
  * @dir:	new parent
  * @new_dentry:	where to create the new link
  * @delegated_inode: returns inode needing a delegation break
@@ -4472,16 +4474,17 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
  * be appropriate for callers that expect the underlying filesystem not
  * to be NFS exported.
  *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then take
- * care to map the inode according to @mnt_userns before checking permissions.
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply passs init_user_ns.
+ * raw inode simply passs @nop_mnt_idmap.
  */
-int vfs_link(struct dentry *old_dentry, struct user_namespace *mnt_userns,
+int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	     struct inode *dir, struct dentry *new_dentry,
 	     struct inode **delegated_inode)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	struct inode *inode = old_dentry->d_inode;
 	unsigned max_links = dir->i_sb->s_max_links;
 	int error;
@@ -4553,6 +4556,7 @@ EXPORT_SYMBOL(vfs_link);
 int do_linkat(int olddfd, struct filename *old, int newdfd,
 	      struct filename *new, int flags)
 {
+	struct mnt_idmap *idmap;
 	struct user_namespace *mnt_userns;
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
@@ -4590,14 +4594,15 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	error = -EXDEV;
 	if (old_path.mnt != new_path.mnt)
 		goto out_dput;
-	mnt_userns = mnt_user_ns(new_path.mnt);
+	idmap = mnt_idmap(new_path.mnt);
+	mnt_userns = mnt_idmap_owner(idmap);
 	error = may_linkat(mnt_userns, &old_path);
 	if (unlikely(error))
 		goto out_dput;
 	error = security_path_link(old_path.dentry, &new_path, new_dentry);
 	if (error)
 		goto out_dput;
-	error = vfs_link(old_path.dentry, mnt_userns, new_path.dentry->d_inode,
+	error = vfs_link(old_path.dentry, idmap, new_path.dentry->d_inode,
 			 new_dentry, &delegated_inode);
 out_dput:
 	done_path_create(&new_path, new_dentry);
@@ -4693,24 +4698,26 @@ int vfs_rename(struct renamedata *rd)
 	bool new_is_dir = false;
 	unsigned max_links = new_dir->i_sb->s_max_links;
 	struct name_snapshot old_name;
+	struct user_namespace *old_mnt_userns = mnt_idmap_owner(rd->old_mnt_idmap),
+			      *new_mnt_userns = mnt_idmap_owner(rd->new_mnt_idmap);
 
 	if (source == target)
 		return 0;
 
-	error = may_delete(rd->old_mnt_userns, old_dir, old_dentry, is_dir);
+	error = may_delete(old_mnt_userns, old_dir, old_dentry, is_dir);
 	if (error)
 		return error;
 
 	if (!target) {
-		error = may_create(rd->new_mnt_userns, new_dir, new_dentry);
+		error = may_create(new_mnt_userns, new_dir, new_dentry);
 	} else {
 		new_is_dir = d_is_dir(new_dentry);
 
 		if (!(flags & RENAME_EXCHANGE))
-			error = may_delete(rd->new_mnt_userns, new_dir,
+			error = may_delete(new_mnt_userns, new_dir,
 					   new_dentry, is_dir);
 		else
-			error = may_delete(rd->new_mnt_userns, new_dir,
+			error = may_delete(new_mnt_userns, new_dir,
 					   new_dentry, new_is_dir);
 	}
 	if (error)
@@ -4725,13 +4732,13 @@ int vfs_rename(struct renamedata *rd)
 	 */
 	if (new_dir != old_dir) {
 		if (is_dir) {
-			error = inode_permission(rd->old_mnt_userns, source,
+			error = inode_permission(old_mnt_userns, source,
 						 MAY_WRITE);
 			if (error)
 				return error;
 		}
 		if ((flags & RENAME_EXCHANGE) && new_is_dir) {
-			error = inode_permission(rd->new_mnt_userns, target,
+			error = inode_permission(new_mnt_userns, target,
 						 MAY_WRITE);
 			if (error)
 				return error;
@@ -4776,7 +4783,7 @@ int vfs_rename(struct renamedata *rd)
 		if (error)
 			goto out;
 	}
-	error = old_dir->i_op->rename(rd->new_mnt_userns, old_dir, old_dentry,
+	error = old_dir->i_op->rename(new_mnt_userns, old_dir, old_dentry,
 				      new_dir, new_dentry, flags);
 	if (error)
 		goto out;
@@ -4921,10 +4928,10 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 
 	rd.old_dir	   = old_path.dentry->d_inode;
 	rd.old_dentry	   = old_dentry;
-	rd.old_mnt_userns  = mnt_user_ns(old_path.mnt);
+	rd.old_mnt_idmap   = mnt_idmap(old_path.mnt);
 	rd.new_dir	   = new_path.dentry->d_inode;
 	rd.new_dentry	   = new_dentry;
-	rd.new_mnt_userns  = mnt_user_ns(new_path.mnt);
+	rd.new_mnt_idmap   = mnt_idmap(new_path.mnt);
 	rd.delegated_inode = &delegated_inode;
 	rd.flags	   = flags;
 	error = vfs_rename(&rd);
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index d01b29aba662..f41992ecd0d7 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -320,7 +320,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_mode &= ~current_umask();
 
 	fh_fill_pre_attrs(fhp);
-	host_err = vfs_create(&init_user_ns, inode, child, iap->ia_mode, true);
+	host_err = vfs_create(&nop_mnt_idmap, inode, child, iap->ia_mode, true);
 	if (host_err < 0) {
 		status = nfserrno(host_err);
 		goto out;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 78b8cd9651d5..3509e73abe1f 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -233,7 +233,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		 * as well be forgiving and just succeed silently.
 		 */
 		goto out_put;
-	status = vfs_mkdir(&init_user_ns, d_inode(dir), dentry, S_IRWXU);
+	status = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
 out_put:
 	dput(dentry);
 out_unlock:
@@ -353,7 +353,7 @@ nfsd4_unlink_clid_dir(char *name, int namlen, struct nfsd_net *nn)
 	status = -ENOENT;
 	if (d_really_is_negative(dentry))
 		goto out;
-	status = vfs_rmdir(&init_user_ns, d_inode(dir), dentry);
+	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry);
 out:
 	dput(dentry);
 out_unlock:
@@ -443,7 +443,7 @@ purge_old(struct dentry *parent, struct dentry *child, struct nfsd_net *nn)
 	if (nfs4_has_reclaimed_state(name, nn))
 		goto out_free;
 
-	status = vfs_rmdir(&init_user_ns, d_inode(parent), child);
+	status = vfs_rmdir(&nop_mnt_idmap, d_inode(parent), child);
 	if (status)
 		printk("failed to remove client recovery directory %pd\n",
 				child);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4c3a0d84043c..371d7f03fe2d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -426,7 +426,7 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
 		if (iap->ia_size < 0)
 			return -EFBIG;
 
-		host_err = notify_change(&init_user_ns, dentry, &size_attr, NULL);
+		host_err = notify_change(&nop_mnt_idmap, dentry, &size_attr, NULL);
 		if (host_err)
 			return host_err;
 		iap->ia_valid &= ~ATTR_SIZE;
@@ -444,7 +444,7 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
 		return 0;
 
 	iap->ia_valid |= ATTR_CTIME;
-	return notify_change(&init_user_ns, dentry, iap, NULL);
+	return notify_change(&nop_mnt_idmap, dentry, iap, NULL);
 }
 
 /**
@@ -1363,12 +1363,13 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = 0;
 	switch (type) {
 	case S_IFREG:
-		host_err = vfs_create(&init_user_ns, dirp, dchild, iap->ia_mode, true);
+		host_err = vfs_create(&nop_mnt_idmap, dirp, dchild,
+				      iap->ia_mode, true);
 		if (!host_err)
 			nfsd_check_ignore_resizing(iap);
 		break;
 	case S_IFDIR:
-		host_err = vfs_mkdir(&init_user_ns, dirp, dchild, iap->ia_mode);
+		host_err = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
 		if (!host_err && unlikely(d_unhashed(dchild))) {
 			struct dentry *d;
 			d = lookup_one_len(dchild->d_name.name,
@@ -1396,7 +1397,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	case S_IFBLK:
 	case S_IFIFO:
 	case S_IFSOCK:
-		host_err = vfs_mknod(&init_user_ns, dirp, dchild,
+		host_err = vfs_mknod(&nop_mnt_idmap, dirp, dchild,
 				     iap->ia_mode, rdev);
 		break;
 	default:
@@ -1557,7 +1558,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out_drop_write;
 	}
 	fh_fill_pre_attrs(fhp);
-	host_err = vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
+	host_err = vfs_symlink(&nop_mnt_idmap, d_inode(dentry), dnew, path);
 	err = nfserrno(host_err);
 	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
 	if (!err)
@@ -1625,7 +1626,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	if (d_really_is_negative(dold))
 		goto out_dput;
 	fh_fill_pre_attrs(ffhp);
-	host_err = vfs_link(dold, &init_user_ns, dirp, dnew, NULL);
+	host_err = vfs_link(dold, &nop_mnt_idmap, dirp, dnew, NULL);
 	fh_fill_post_attrs(ffhp);
 	inode_unlock(dirp);
 	if (!host_err) {
@@ -1745,10 +1746,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		goto out_dput_old;
 	} else {
 		struct renamedata rd = {
-			.old_mnt_userns	= &init_user_ns,
+			.old_mnt_idmap	= &nop_mnt_idmap,
 			.old_dir	= fdir,
 			.old_dentry	= odentry,
-			.new_mnt_userns	= &init_user_ns,
+			.new_mnt_idmap	= &nop_mnt_idmap,
 			.new_dir	= tdir,
 			.new_dentry	= ndentry,
 		};
@@ -1850,14 +1851,14 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 			nfsd_close_cached_files(rdentry);
 
 		for (retries = 1;;) {
-			host_err = vfs_unlink(&init_user_ns, dirp, rdentry, NULL);
+			host_err = vfs_unlink(&nop_mnt_idmap, dirp, rdentry, NULL);
 			if (host_err != -EAGAIN || !retries--)
 				break;
 			if (!nfsd_wait_for_delegreturn(rqstp, rinode))
 				break;
 		}
 	} else {
-		host_err = vfs_rmdir(&init_user_ns, dirp, rdentry);
+		host_err = vfs_rmdir(&nop_mnt_idmap, dirp, rdentry);
 	}
 	fh_fill_post_attrs(fhp);
 
diff --git a/fs/open.c b/fs/open.c
index 82c1a28b3308..60a81db586ef 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -36,9 +36,10 @@
 
 #include "internal.h"
 
-int do_truncate(struct user_namespace *mnt_userns, struct dentry *dentry,
+int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
 		loff_t length, unsigned int time_attrs, struct file *filp)
 {
+	struct user_namespace *mnt_userns = mnt_idmap_owner(idmap);
 	int ret;
 	struct iattr newattrs;
 
@@ -62,13 +63,14 @@ int do_truncate(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 	inode_lock(dentry->d_inode);
 	/* Note any delegations or leases have already been broken: */
-	ret = notify_change(mnt_userns, dentry, &newattrs, NULL);
+	ret = notify_change(idmap, dentry, &newattrs, NULL);
 	inode_unlock(dentry->d_inode);
 	return ret;
 }
 
 long vfs_truncate(const struct path *path, loff_t length)
 {
+	struct mnt_idmap *idmap;
 	struct user_namespace *mnt_userns;
 	struct inode *inode;
 	long error;
@@ -85,7 +87,8 @@ long vfs_truncate(const struct path *path, loff_t length)
 	if (error)
 		goto out;
 
-	mnt_userns = mnt_user_ns(path->mnt);
+	idmap = mnt_idmap(path->mnt);
+	mnt_userns = mnt_idmap_owner(idmap);
 	error = inode_permission(mnt_userns, inode, MAY_WRITE);
 	if (error)
 		goto mnt_drop_write_and_out;
@@ -108,7 +111,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 
 	error = security_path_truncate(path);
 	if (!error)
-		error = do_truncate(mnt_userns, path->dentry, length, 0, NULL);
+		error = do_truncate(idmap, path->dentry, length, 0, NULL);
 
 put_write_and_out:
 	put_write_access(inode);
@@ -190,7 +193,7 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	sb_start_write(inode->i_sb);
 	error = security_file_truncate(f.file);
 	if (!error)
-		error = do_truncate(file_mnt_user_ns(f.file), dentry, length,
+		error = do_truncate(file_mnt_idmap(f.file), dentry, length,
 				    ATTR_MTIME | ATTR_CTIME, f.file);
 	sb_end_write(inode->i_sb);
 out_putf:
@@ -603,7 +606,7 @@ int chmod_common(const struct path *path, umode_t mode)
 		goto out_unlock;
 	newattrs.ia_mode = (mode & S_IALLUGO) | (inode->i_mode & ~S_IALLUGO);
 	newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-	error = notify_change(mnt_user_ns(path->mnt), path->dentry,
+	error = notify_change(mnt_idmap(path->mnt), path->dentry,
 			      &newattrs, &delegated_inode);
 out_unlock:
 	inode_unlock(inode);
@@ -701,6 +704,7 @@ static inline bool setattr_vfsgid(struct iattr *attr, kgid_t kgid)
 
 int chown_common(const struct path *path, uid_t user, gid_t group)
 {
+	struct mnt_idmap *idmap;
 	struct user_namespace *mnt_userns, *fs_userns;
 	struct inode *inode = path->dentry->d_inode;
 	struct inode *delegated_inode = NULL;
@@ -712,7 +716,8 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	uid = make_kuid(current_user_ns(), user);
 	gid = make_kgid(current_user_ns(), group);
 
-	mnt_userns = mnt_user_ns(path->mnt);
+	idmap = mnt_idmap(path->mnt);
+	mnt_userns = mnt_idmap_owner(idmap);
 	fs_userns = i_user_ns(inode);
 
 retry_deleg:
@@ -733,7 +738,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 		from_vfsuid(mnt_userns, fs_userns, newattrs.ia_vfsuid),
 		from_vfsgid(mnt_userns, fs_userns, newattrs.ia_vfsgid));
 	if (!error)
-		error = notify_change(mnt_userns, path->dentry, &newattrs,
+		error = notify_change(idmap, path->dentry, &newattrs,
 				      &delegated_inode);
 	inode_unlock(inode);
 	if (delegated_inode) {
@@ -1064,7 +1069,7 @@ struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 	if (IS_ERR(f))
 		return f;
 
-	error = vfs_create(mnt_user_ns(path->mnt),
+	error = vfs_create(mnt_idmap(path->mnt),
 			   d_inode(path->dentry->d_parent),
 			   path->dentry, mode, true);
 	if (!error)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 1df7f850ff3b..ff89454b07fc 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -141,13 +141,13 @@ static inline int ovl_do_notify_change(struct ovl_fs *ofs,
 				       struct dentry *upperdentry,
 				       struct iattr *attr)
 {
-	return notify_change(ovl_upper_mnt_userns(ofs), upperdentry, attr, NULL);
+	return notify_change(ovl_upper_mnt_idmap(ofs), upperdentry, attr, NULL);
 }
 
 static inline int ovl_do_rmdir(struct ovl_fs *ofs,
 			       struct inode *dir, struct dentry *dentry)
 {
-	int err = vfs_rmdir(ovl_upper_mnt_userns(ofs), dir, dentry);
+	int err = vfs_rmdir(ovl_upper_mnt_idmap(ofs), dir, dentry);
 
 	pr_debug("rmdir(%pd2) = %i\n", dentry, err);
 	return err;
@@ -156,7 +156,7 @@ static inline int ovl_do_rmdir(struct ovl_fs *ofs,
 static inline int ovl_do_unlink(struct ovl_fs *ofs, struct inode *dir,
 				struct dentry *dentry)
 {
-	int err = vfs_unlink(ovl_upper_mnt_userns(ofs), dir, dentry, NULL);
+	int err = vfs_unlink(ovl_upper_mnt_idmap(ofs), dir, dentry, NULL);
 
 	pr_debug("unlink(%pd2) = %i\n", dentry, err);
 	return err;
@@ -165,7 +165,8 @@ static inline int ovl_do_unlink(struct ovl_fs *ofs, struct inode *dir,
 static inline int ovl_do_link(struct ovl_fs *ofs, struct dentry *old_dentry,
 			      struct inode *dir, struct dentry *new_dentry)
 {
-	int err = vfs_link(old_dentry, ovl_upper_mnt_userns(ofs), dir, new_dentry, NULL);
+	int err = vfs_link(old_dentry, ovl_upper_mnt_idmap(ofs), dir,
+			   new_dentry, NULL);
 
 	pr_debug("link(%pd2, %pd2) = %i\n", old_dentry, new_dentry, err);
 	return err;
@@ -175,7 +176,7 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
 				struct inode *dir, struct dentry *dentry,
 				umode_t mode)
 {
-	int err = vfs_create(ovl_upper_mnt_userns(ofs), dir, dentry, mode, true);
+	int err = vfs_create(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, true);
 
 	pr_debug("create(%pd2, 0%o) = %i\n", dentry, mode, err);
 	return err;
@@ -185,7 +186,7 @@ static inline int ovl_do_mkdir(struct ovl_fs *ofs,
 			       struct inode *dir, struct dentry *dentry,
 			       umode_t mode)
 {
-	int err = vfs_mkdir(ovl_upper_mnt_userns(ofs), dir, dentry, mode);
+	int err = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
 	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, err);
 	return err;
 }
@@ -194,7 +195,7 @@ static inline int ovl_do_mknod(struct ovl_fs *ofs,
 			       struct inode *dir, struct dentry *dentry,
 			       umode_t mode, dev_t dev)
 {
-	int err = vfs_mknod(ovl_upper_mnt_userns(ofs), dir, dentry, mode, dev);
+	int err = vfs_mknod(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, dev);
 
 	pr_debug("mknod(%pd2, 0%o, 0%o) = %i\n", dentry, mode, dev, err);
 	return err;
@@ -204,7 +205,7 @@ static inline int ovl_do_symlink(struct ovl_fs *ofs,
 				 struct inode *dir, struct dentry *dentry,
 				 const char *oldname)
 {
-	int err = vfs_symlink(ovl_upper_mnt_userns(ofs), dir, dentry, oldname);
+	int err = vfs_symlink(ovl_upper_mnt_idmap(ofs), dir, dentry, oldname);
 
 	pr_debug("symlink(\"%s\", %pd2) = %i\n", oldname, dentry, err);
 	return err;
@@ -298,10 +299,10 @@ static inline int ovl_do_rename(struct ovl_fs *ofs, struct inode *olddir,
 {
 	int err;
 	struct renamedata rd = {
-		.old_mnt_userns	= ovl_upper_mnt_userns(ofs),
+		.old_mnt_idmap	= ovl_upper_mnt_idmap(ofs),
 		.old_dir 	= olddir,
 		.old_dentry 	= olddentry,
-		.new_mnt_userns	= ovl_upper_mnt_userns(ofs),
+		.new_mnt_idmap	= ovl_upper_mnt_idmap(ofs),
 		.new_dir 	= newdir,
 		.new_dentry 	= newdentry,
 		.flags 		= flags,
@@ -319,7 +320,7 @@ static inline int ovl_do_rename(struct ovl_fs *ofs, struct inode *olddir,
 static inline int ovl_do_whiteout(struct ovl_fs *ofs,
 				  struct inode *dir, struct dentry *dentry)
 {
-	int err = vfs_whiteout(ovl_upper_mnt_userns(ofs), dir, dentry);
+	int err = vfs_whiteout(ovl_upper_mnt_idmap(ofs), dir, dentry);
 	pr_debug("whiteout(%pd2) = %i\n", dentry, err);
 	return err;
 }
@@ -328,7 +329,7 @@ static inline struct file *ovl_do_tmpfile(struct ovl_fs *ofs,
 					  struct dentry *dentry, umode_t mode)
 {
 	struct path path = { .mnt = ovl_upper_mnt(ofs), .dentry = dentry };
-	struct file *file = vfs_tmpfile_open(ovl_upper_mnt_userns(ofs), &path, mode,
+	struct file *file = vfs_tmpfile_open(ovl_upper_mnt_idmap(ofs), &path, mode,
 					O_LARGEFILE | O_WRONLY, current_cred());
 	int err = PTR_ERR_OR_ZERO(file);
 
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index e1af8f660698..a6a9235c6168 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -95,6 +95,11 @@ static inline struct user_namespace *ovl_upper_mnt_userns(struct ovl_fs *ofs)
 	return mnt_user_ns(ovl_upper_mnt(ofs));
 }
 
+static inline struct mnt_idmap *ovl_upper_mnt_idmap(struct ovl_fs *ofs)
+{
+	return mnt_idmap(ovl_upper_mnt(ofs));
+}
+
 static inline struct ovl_fs *OVL_FS(struct super_block *sb)
 {
 	return (struct ovl_fs *)sb->s_fs_info;
diff --git a/fs/utimes.c b/fs/utimes.c
index 39f356017635..5f71e2209e6f 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -62,7 +62,7 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
 	}
 retry_deleg:
 	inode_lock(inode);
-	error = notify_change(mnt_user_ns(path->mnt), path->dentry, &newattrs,
+	error = notify_change(mnt_idmap(path->mnt), path->dentry, &newattrs,
 			      &delegated_inode);
 	inode_unlock(inode);
 	if (delegated_inode) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 066555ad1bf8..7aa302d2ce39 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1944,36 +1944,36 @@ bool inode_owner_or_capable(struct user_namespace *mnt_userns,
 /*
  * VFS helper functions..
  */
-int vfs_create(struct user_namespace *, struct inode *,
+int vfs_create(struct mnt_idmap *, struct inode *,
 	       struct dentry *, umode_t, bool);
-int vfs_mkdir(struct user_namespace *, struct inode *,
+int vfs_mkdir(struct mnt_idmap *, struct inode *,
 	      struct dentry *, umode_t);
-int vfs_mknod(struct user_namespace *, struct inode *, struct dentry *,
+int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
               umode_t, dev_t);
-int vfs_symlink(struct user_namespace *, struct inode *,
+int vfs_symlink(struct mnt_idmap *, struct inode *,
 		struct dentry *, const char *);
-int vfs_link(struct dentry *, struct user_namespace *, struct inode *,
+int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
 	     struct dentry *, struct inode **);
-int vfs_rmdir(struct user_namespace *, struct inode *, struct dentry *);
-int vfs_unlink(struct user_namespace *, struct inode *, struct dentry *,
+int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *);
+int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
 	       struct inode **);
 
 /**
  * struct renamedata - contains all information required for renaming
- * @old_mnt_userns:    old user namespace of the mount the inode was found from
+ * @old_mnt_idmap:     idmap of the old mount the inode was found from
  * @old_dir:           parent of source
  * @old_dentry:                source
- * @new_mnt_userns:    new user namespace of the mount the inode was found from
+ * @new_mnt_idmap:     idmap of the new mount the inode was found from
  * @new_dir:           parent of destination
  * @new_dentry:                destination
  * @delegated_inode:   returns an inode needing a delegation break
  * @flags:             rename flags
  */
 struct renamedata {
-	struct user_namespace *old_mnt_userns;
+	struct mnt_idmap *old_mnt_idmap;
 	struct inode *old_dir;
 	struct dentry *old_dentry;
-	struct user_namespace *new_mnt_userns;
+	struct mnt_idmap *new_mnt_idmap;
 	struct inode *new_dir;
 	struct dentry *new_dentry;
 	struct inode **delegated_inode;
@@ -1982,14 +1982,14 @@ struct renamedata {
 
 int vfs_rename(struct renamedata *);
 
-static inline int vfs_whiteout(struct user_namespace *mnt_userns,
+static inline int vfs_whiteout(struct mnt_idmap *idmap,
 			       struct inode *dir, struct dentry *dentry)
 {
-	return vfs_mknod(mnt_userns, dir, dentry, S_IFCHR | WHITEOUT_MODE,
+	return vfs_mknod(idmap, dir, dentry, S_IFCHR | WHITEOUT_MODE,
 			 WHITEOUT_DEV);
 }
 
-struct file *vfs_tmpfile_open(struct user_namespace *mnt_userns,
+struct file *vfs_tmpfile_open(struct mnt_idmap *idmap,
 			const struct path *parentpath,
 			umode_t mode, int open_flag, const struct cred *cred);
 
@@ -2746,7 +2746,7 @@ static inline bool is_idmapped_mnt(const struct vfsmount *mnt)
 }
 
 extern long vfs_truncate(const struct path *, loff_t);
-int do_truncate(struct user_namespace *, struct dentry *, loff_t start,
+int do_truncate(struct mnt_idmap *, struct dentry *, loff_t start,
 		unsigned int time_attrs, struct file *filp);
 extern int vfs_fallocate(struct file *file, int mode, loff_t offset,
 			loff_t len);
@@ -2901,7 +2901,7 @@ static inline int bmap(struct inode *inode,  sector_t *block)
 }
 #endif
 
-int notify_change(struct user_namespace *, struct dentry *,
+int notify_change(struct mnt_idmap *, struct dentry *,
 		  struct iattr *, struct inode **);
 int inode_permission(struct user_namespace *, struct inode *, int);
 int generic_permission(struct user_namespace *, struct inode *, int);
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index d09aa1c1e3e6..4b78095fe779 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -979,7 +979,7 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
 		err = -ENOENT;
 	} else {
 		ihold(inode);
-		err = vfs_unlink(&init_user_ns, d_inode(dentry->d_parent),
+		err = vfs_unlink(&nop_mnt_idmap, d_inode(dentry->d_parent),
 				 dentry, NULL);
 	}
 	dput(dentry);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f0c2293f1d3b..81ff98298996 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1190,7 +1190,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	unsigned int new_hash, old_hash = sk->sk_hash;
 	struct unix_sock *u = unix_sk(sk);
 	struct net *net = sock_net(sk);
-	struct user_namespace *ns; // barf...
+	struct mnt_idmap *idmap;
 	struct unix_address *addr;
 	struct dentry *dentry;
 	struct path parent;
@@ -1217,10 +1217,10 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	/*
 	 * All right, let's create it.
 	 */
-	ns = mnt_user_ns(parent.mnt);
+	idmap = mnt_idmap(parent.mnt);
 	err = security_path_mknod(&parent, dentry, mode, 0);
 	if (!err)
-		err = vfs_mknod(ns, d_inode(parent.dentry), dentry, mode, 0);
+		err = vfs_mknod(idmap, d_inode(parent.dentry), dentry, mode, 0);
 	if (err)
 		goto out_path;
 	err = mutex_lock_interruptible(&u->bindlock);
@@ -1245,7 +1245,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	err = -EINVAL;
 out_unlink:
 	/* failed after successful mknod?  unlink what we'd created... */
-	vfs_unlink(ns, d_inode(parent.dentry), dentry, NULL);
+	vfs_unlink(idmap, d_inode(parent.dentry), dentry, NULL);
 out_path:
 	done_path_create(&parent, dentry);
 out:
diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index 92331053dba3..7bd76b9e0f98 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -826,7 +826,7 @@ int kprobe_ret__do_filp_open(struct pt_regs* ctx)
 
 SEC("kprobe/vfs_link")
 int BPF_KPROBE(kprobe__vfs_link,
-	       struct dentry* old_dentry, struct user_namespace *mnt_userns,
+	       struct dentry* old_dentry, struct mnt_idmap *idmap,
 	       struct inode* dir, struct dentry* new_dentry,
 	       struct inode** delegated_inode)
 {

-- 
2.34.1

