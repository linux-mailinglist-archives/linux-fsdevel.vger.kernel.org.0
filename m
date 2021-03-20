Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16737342A89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 05:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhCTEfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 00:35:47 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:58348 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhCTEfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 00:35:19 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNTIO-007ZDY-Jw; Sat, 20 Mar 2021 04:33:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-cifs@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/7] cifs: allocate buffer in the caller of build_path_from_dentry()
Date:   Sat, 20 Mar 2021 04:33:03 +0000
Message-Id: <20210320043304.1803623-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320043304.1803623-1-viro@zeniv.linux.org.uk>
References: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk>
 <20210320043304.1803623-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

build_path_from_dentry() open-codes dentry_path_raw().  The reason
we can't use dentry_path_raw() in there (and postprocess the
result as needed) is that the callers of build_path_from_dentry()
expect that the object to be freed on cleanup and the string to
be used are at the same address.  That's painful, since the path
is naturally built end-to-beginning - we start at the leaf and
go through the ancestors, accumulating the pathname.

Life would be easier if we left the buffer allocation to callers.
It wouldn't be exact-sized buffer, but none of the callers keep
the result for long - it's always freed before the caller returns.
So there's no need to do exact-sized allocation; better use
__getname()/__putname(), same as we do for pathname arguments
of syscalls.  What's more, there's no need to do allocation under
spinlocks, so GFP_ATOMIC is not needed.

Next patch will replace the open-coded dentry_path_raw() (in
build_path_from_dentry_optional_prefix()) with calling the real
thing.  This patch only introduces wrappers for allocating/freeing
the buffers and switches to new calling conventions:
	build_path_from_dentry(dentry, buf)
expects buf to be address of a page-sized object or NULL,
return value is a pathname built inside that buffer on success,
ERR_PTR(-ENOMEM) if buf is NULL and ERR_PTR(-ENAMETOOLONG) if
the pathname won't fit into page.  Note that we don't need to
check for failure when allocating the buffer in the caller -
build_path_from_dentry() will do the right thing.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/cifs/cifs_dfs_ref.c |  12 ++++--
 fs/cifs/cifsproto.h    |  15 ++++++-
 fs/cifs/dir.c          |  69 ++++++++++++++++----------------
 fs/cifs/file.c         |  75 +++++++++++++++++------------------
 fs/cifs/inode.c        | 104 +++++++++++++++++++++++++------------------------
 fs/cifs/ioctl.c        |  11 ++++--
 fs/cifs/link.c         |  46 +++++++++++++---------
 fs/cifs/readdir.c      |  11 +++---
 fs/cifs/smb2ops.c      |  17 ++++----
 fs/cifs/xattr.c        |  30 ++++++++------
 10 files changed, 212 insertions(+), 178 deletions(-)

diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/cifs/cifs_dfs_ref.c
index ecee2864972d..c87c37cf2914 100644
--- a/fs/cifs/cifs_dfs_ref.c
+++ b/fs/cifs/cifs_dfs_ref.c
@@ -302,6 +302,7 @@ static struct vfsmount *cifs_dfs_do_automount(struct dentry *mntpt)
 	struct cifs_sb_info *cifs_sb;
 	struct cifs_ses *ses;
 	struct cifs_tcon *tcon;
+	void *page;
 	char *full_path, *root_path;
 	unsigned int xid;
 	int rc;
@@ -324,10 +325,13 @@ static struct vfsmount *cifs_dfs_do_automount(struct dentry *mntpt)
 		goto cdda_exit;
 	}
 
+	page = alloc_dentry_path();
 	/* always use tree name prefix */
-	full_path = build_path_from_dentry_optional_prefix(mntpt, true);
-	if (full_path == NULL)
-		goto cdda_exit;
+	full_path = build_path_from_dentry_optional_prefix(mntpt, page, true);
+	if (IS_ERR(full_path)) {
+		mnt = ERR_CAST(full_path);
+		goto free_full_path;
+	}
 
 	convert_delimiter(full_path, '\\');
 
@@ -385,7 +389,7 @@ static struct vfsmount *cifs_dfs_do_automount(struct dentry *mntpt)
 free_root_path:
 	kfree(root_path);
 free_full_path:
-	kfree(full_path);
+	free_dentry_path(page);
 cdda_exit:
 	cifs_dbg(FYI, "leaving %s\n" , __func__);
 	return mnt;
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 50894e576e13..9d8ba7975753 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -69,9 +69,20 @@ extern int init_cifs_idmap(void);
 extern void exit_cifs_idmap(void);
 extern int init_cifs_spnego(void);
 extern void exit_cifs_spnego(void);
-extern const char *build_path_from_dentry(struct dentry *);
+extern const char *build_path_from_dentry(struct dentry *, void *);
 extern char *build_path_from_dentry_optional_prefix(struct dentry *direntry,
-						    bool prefix);
+						    void *page, bool prefix);
+static inline void *alloc_dentry_path(void)
+{
+	return __getname();
+}
+
+static inline void free_dentry_path(void *page)
+{
+	if (page)
+		__putname(page);
+}
+
 extern char *cifs_build_path_to_root(struct smb3_fs_context *ctx,
 				     struct cifs_sb_info *cifs_sb,
 				     struct cifs_tcon *tcon,
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 01e26f811885..6e855f004f50 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -79,29 +79,33 @@ cifs_build_path_to_root(struct smb3_fs_context *ctx, struct cifs_sb_info *cifs_s
 
 /* Note: caller must free return buffer */
 const char *
-build_path_from_dentry(struct dentry *direntry)
+build_path_from_dentry(struct dentry *direntry, void *page)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(direntry->d_sb);
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
 	bool prefix = tcon->Flags & SMB_SHARE_IS_IN_DFS;
 
-	return build_path_from_dentry_optional_prefix(direntry,
+	return build_path_from_dentry_optional_prefix(direntry, page,
 						      prefix);
 }
 
 char *
-build_path_from_dentry_optional_prefix(struct dentry *direntry, bool prefix)
+build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
+				       bool prefix)
 {
 	struct dentry *temp;
 	int namelen;
 	int dfsplen;
 	int pplen = 0;
-	char *full_path;
+	char *full_path = page;
 	char dirsep;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(direntry->d_sb);
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
 	unsigned seq;
 
+	if (unlikely(!page))
+		return ERR_PTR(-ENOMEM);
+
 	dirsep = CIFS_DIR_SEP(cifs_sb);
 	if (prefix)
 		dfsplen = strnlen(tcon->treeName, MAX_TREE_SIZE + 1);
@@ -118,17 +122,12 @@ build_path_from_dentry_optional_prefix(struct dentry *direntry, bool prefix)
 	for (temp = direntry; !IS_ROOT(temp);) {
 		namelen += (1 + temp->d_name.len);
 		temp = temp->d_parent;
-		if (temp == NULL) {
-			cifs_dbg(VFS, "corrupt dentry\n");
-			rcu_read_unlock();
-			return NULL;
-		}
 	}
 	rcu_read_unlock();
 
-	full_path = kmalloc(namelen+1, GFP_ATOMIC);
-	if (full_path == NULL)
-		return full_path;
+	if (namelen >= PAGE_SIZE)
+		return ERR_PTR(-ENAMETOOLONG);
+
 	full_path[namelen] = 0;	/* trailing null */
 	rcu_read_lock();
 	for (temp = direntry; !IS_ROOT(temp);) {
@@ -145,12 +144,6 @@ build_path_from_dentry_optional_prefix(struct dentry *direntry, bool prefix)
 		}
 		spin_unlock(&temp->d_lock);
 		temp = temp->d_parent;
-		if (temp == NULL) {
-			cifs_dbg(VFS, "corrupt dentry\n");
-			rcu_read_unlock();
-			kfree(full_path);
-			return NULL;
-		}
 	}
 	rcu_read_unlock();
 	if (namelen != dfsplen + pplen || read_seqretry(&rename_lock, seq)) {
@@ -159,7 +152,6 @@ build_path_from_dentry_optional_prefix(struct dentry *direntry, bool prefix)
 		/* presumably this is only possible if racing with a rename
 		of one of the parent directories  (we can not lock the dentries
 		above us to prevent this, but retrying should be harmless) */
-		kfree(full_path);
 		goto cifs_bp_rename_retry;
 	}
 	/* DIR_SEP already set for byte  0 / vs \ but not for
@@ -233,7 +225,8 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	int desired_access;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct cifs_tcon *tcon = tlink_tcon(tlink);
-	const char *full_path = NULL;
+	const char *full_path;
+	void *page = alloc_dentry_path();
 	FILE_ALL_INFO *buf = NULL;
 	struct inode *newinode = NULL;
 	int disposition;
@@ -244,9 +237,11 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	if (tcon->ses->server->oplocks)
 		*oplock = REQ_OPLOCK;
 
-	full_path = build_path_from_dentry(direntry);
-	if (!full_path)
-		return -ENOMEM;
+	full_path = build_path_from_dentry(direntry, page);
+	if (IS_ERR(full_path)) {
+		free_dentry_path(page);
+		return PTR_ERR(full_path);
+	}
 
 	if (tcon->unix_ext && cap_unix(tcon->ses) && !tcon->broken_posix_open &&
 	    (CIFS_UNIX_POSIX_PATH_OPS_CAP &
@@ -448,7 +443,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 
 out:
 	kfree(buf);
-	kfree(full_path);
+	free_dentry_path(page);
 	return rc;
 
 out_err:
@@ -619,7 +614,8 @@ int cifs_mknod(struct user_namespace *mnt_userns, struct inode *inode,
 	struct cifs_sb_info *cifs_sb;
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
-	const char *full_path = NULL;
+	const char *full_path;
+	void *page;
 
 	if (!old_valid_dev(device_number))
 		return -EINVAL;
@@ -629,13 +625,13 @@ int cifs_mknod(struct user_namespace *mnt_userns, struct inode *inode,
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
 
+	page = alloc_dentry_path();
 	tcon = tlink_tcon(tlink);
-
 	xid = get_xid();
 
-	full_path = build_path_from_dentry(direntry);
-	if (full_path == NULL) {
-		rc = -ENOMEM;
+	full_path = build_path_from_dentry(direntry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
 		goto mknod_out;
 	}
 
@@ -644,7 +640,7 @@ int cifs_mknod(struct user_namespace *mnt_userns, struct inode *inode,
 					       device_number);
 
 mknod_out:
-	kfree(full_path);
+	free_dentry_path(page);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
 	return rc;
@@ -660,7 +656,8 @@ cifs_lookup(struct inode *parent_dir_inode, struct dentry *direntry,
 	struct tcon_link *tlink;
 	struct cifs_tcon *pTcon;
 	struct inode *newInode = NULL;
-	const char *full_path = NULL;
+	const char *full_path;
+	void *page;
 
 	xid = get_xid();
 
@@ -687,11 +684,13 @@ cifs_lookup(struct inode *parent_dir_inode, struct dentry *direntry,
 	/* can not grab the rename sem here since it would
 	deadlock in the cases (beginning of sys_rename itself)
 	in which we already have the sb rename sem */
-	full_path = build_path_from_dentry(direntry);
-	if (full_path == NULL) {
+	page = alloc_dentry_path();
+	full_path = build_path_from_dentry(direntry, page);
+	if (IS_ERR(full_path)) {
 		cifs_put_tlink(tlink);
 		free_xid(xid);
-		return ERR_PTR(-ENOMEM);
+		free_dentry_path(page);
+		return ERR_CAST(full_path);
 	}
 
 	if (d_really_is_positive(direntry)) {
@@ -727,7 +726,7 @@ cifs_lookup(struct inode *parent_dir_inode, struct dentry *direntry,
 		}
 		newInode = ERR_PTR(rc);
 	}
-	kfree(full_path);
+	free_dentry_path(page);
 	cifs_put_tlink(tlink);
 	free_xid(xid);
 	return d_splice_alias(newInode, direntry);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index f4946c06a00c..16e115c4cf25 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -529,7 +529,8 @@ int cifs_open(struct inode *inode, struct file *file)
 	struct cifs_tcon *tcon;
 	struct tcon_link *tlink;
 	struct cifsFileInfo *cfile = NULL;
-	const char *full_path = NULL;
+	void *page;
+	const char *full_path;
 	bool posix_open_ok = false;
 	struct cifs_fid fid;
 	struct cifs_pending_open open;
@@ -545,9 +546,10 @@ int cifs_open(struct inode *inode, struct file *file)
 	tcon = tlink_tcon(tlink);
 	server = tcon->ses->server;
 
-	full_path = build_path_from_dentry(file_dentry(file));
-	if (full_path == NULL) {
-		rc = -ENOMEM;
+	page = alloc_dentry_path();
+	full_path = build_path_from_dentry(file_dentry(file), page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
 		goto out;
 	}
 
@@ -639,7 +641,7 @@ int cifs_open(struct inode *inode, struct file *file)
 	}
 
 out:
-	kfree(full_path);
+	free_dentry_path(page);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
 	return rc;
@@ -688,7 +690,8 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	struct TCP_Server_Info *server;
 	struct cifsInodeInfo *cinode;
 	struct inode *inode;
-	const char *full_path = NULL;
+	void *page;
+	const char *full_path;
 	int desired_access;
 	int disposition = FILE_OPEN;
 	int create_options = CREATE_NOT_DIR;
@@ -698,9 +701,8 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	mutex_lock(&cfile->fh_mutex);
 	if (!cfile->invalidHandle) {
 		mutex_unlock(&cfile->fh_mutex);
-		rc = 0;
 		free_xid(xid);
-		return rc;
+		return 0;
 	}
 
 	inode = d_inode(cfile->dentry);
@@ -714,12 +716,13 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	 * called and if the server was down that means we end up here, and we
 	 * can never tell if the caller already has the rename_sem.
 	 */
-	full_path = build_path_from_dentry(cfile->dentry);
-	if (full_path == NULL) {
-		rc = -ENOMEM;
+	page = alloc_dentry_path();
+	full_path = build_path_from_dentry(cfile->dentry, page);
+	if (IS_ERR(full_path)) {
 		mutex_unlock(&cfile->fh_mutex);
+		free_dentry_path(page);
 		free_xid(xid);
-		return rc;
+		return PTR_ERR(full_path);
 	}
 
 	cifs_dbg(FYI, "inode = 0x%p file flags 0x%x for %s\n",
@@ -837,7 +840,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 		cifs_relock_file(cfile);
 
 reopen_error_exit:
-	kfree(full_path);
+	free_dentry_path(page);
 	free_xid(xid);
 	return rc;
 }
@@ -2068,34 +2071,31 @@ cifs_get_writable_path(struct cifs_tcon *tcon, const char *name,
 		       int flags,
 		       struct cifsFileInfo **ret_file)
 {
-	struct list_head *tmp;
 	struct cifsFileInfo *cfile;
-	struct cifsInodeInfo *cinode;
-	const char *full_path;
+	void *page = alloc_dentry_path();
 
 	*ret_file = NULL;
 
 	spin_lock(&tcon->open_file_lock);
-	list_for_each(tmp, &tcon->openFileList) {
-		cfile = list_entry(tmp, struct cifsFileInfo,
-			     tlist);
-		full_path = build_path_from_dentry(cfile->dentry);
-		if (full_path == NULL) {
+	list_for_each_entry(cfile, &tcon->openFileList, tlist) {
+		struct cifsInodeInfo *cinode;
+		const char *full_path = build_path_from_dentry(cfile->dentry, page);
+		if (IS_ERR(full_path)) {
 			spin_unlock(&tcon->open_file_lock);
-			return -ENOMEM;
+			free_dentry_path(page);
+			return PTR_ERR(full_path);
 		}
-		if (strcmp(full_path, name)) {
-			kfree(full_path);
+		if (strcmp(full_path, name))
 			continue;
-		}
 
-		kfree(full_path);
 		cinode = CIFS_I(d_inode(cfile->dentry));
 		spin_unlock(&tcon->open_file_lock);
+		free_dentry_path(page);
 		return cifs_get_writable_file(cinode, flags, ret_file);
 	}
 
 	spin_unlock(&tcon->open_file_lock);
+	free_dentry_path(page);
 	return -ENOENT;
 }
 
@@ -2103,35 +2103,32 @@ int
 cifs_get_readable_path(struct cifs_tcon *tcon, const char *name,
 		       struct cifsFileInfo **ret_file)
 {
-	struct list_head *tmp;
 	struct cifsFileInfo *cfile;
-	struct cifsInodeInfo *cinode;
-	const char *full_path;
+	void *page = alloc_dentry_path();
 
 	*ret_file = NULL;
 
 	spin_lock(&tcon->open_file_lock);
-	list_for_each(tmp, &tcon->openFileList) {
-		cfile = list_entry(tmp, struct cifsFileInfo,
-			     tlist);
-		full_path = build_path_from_dentry(cfile->dentry);
-		if (full_path == NULL) {
+	list_for_each_entry(cfile, &tcon->openFileList, tlist) {
+		struct cifsInodeInfo *cinode;
+		const char *full_path = build_path_from_dentry(cfile->dentry, page);
+		if (IS_ERR(full_path)) {
 			spin_unlock(&tcon->open_file_lock);
-			return -ENOMEM;
+			free_dentry_path(page);
+			return PTR_ERR(full_path);
 		}
-		if (strcmp(full_path, name)) {
-			kfree(full_path);
+		if (strcmp(full_path, name))
 			continue;
-		}
 
-		kfree(full_path);
 		cinode = CIFS_I(d_inode(cfile->dentry));
 		spin_unlock(&tcon->open_file_lock);
+		free_dentry_path(page);
 		*ret_file = find_readable_file(cinode, 0);
 		return *ret_file ? 0 : -ENOENT;
 	}
 
 	spin_unlock(&tcon->open_file_lock);
+	free_dentry_path(page);
 	return -ENOENT;
 }
 
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index a6d3b8e7ca70..74d1a10e360b 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -1609,7 +1609,8 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int rc = 0;
 	unsigned int xid;
-	const char *full_path = NULL;
+	const char *full_path;
+	void *page;
 	struct inode *inode = d_inode(dentry);
 	struct cifsInodeInfo *cifs_inode;
 	struct super_block *sb = dir->i_sb;
@@ -1629,6 +1630,7 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 	server = tcon->ses->server;
 
 	xid = get_xid();
+	page = alloc_dentry_path();
 
 	if (tcon->nodelete) {
 		rc = -EACCES;
@@ -1637,9 +1639,9 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 
 	/* Unlink can be called from rename so we can not take the
 	 * sb->s_vfs_rename_mutex here */
-	full_path = build_path_from_dentry(dentry);
-	if (full_path == NULL) {
-		rc = -ENOMEM;
+	full_path = build_path_from_dentry(dentry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
 		goto unlink_out;
 	}
 
@@ -1713,7 +1715,7 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 	cifs_inode = CIFS_I(dir);
 	CIFS_I(dir)->time = 0;	/* force revalidate of dir as well */
 unlink_out:
-	kfree(full_path);
+	free_dentry_path(page);
 	kfree(attrs);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
@@ -1867,6 +1869,7 @@ int cifs_mkdir(struct user_namespace *mnt_userns, struct inode *inode,
 	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server;
 	const char *full_path;
+	void *page;
 
 	cifs_dbg(FYI, "In cifs_mkdir, mode = %04ho inode = 0x%p\n",
 		 mode, inode);
@@ -1879,9 +1882,10 @@ int cifs_mkdir(struct user_namespace *mnt_userns, struct inode *inode,
 
 	xid = get_xid();
 
-	full_path = build_path_from_dentry(direntry);
-	if (full_path == NULL) {
-		rc = -ENOMEM;
+	page = alloc_dentry_path();
+	full_path = build_path_from_dentry(direntry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
 		goto mkdir_out;
 	}
 
@@ -1924,7 +1928,7 @@ int cifs_mkdir(struct user_namespace *mnt_userns, struct inode *inode,
 	 * attributes are invalid now.
 	 */
 	CIFS_I(inode)->time = 0;
-	kfree(full_path);
+	free_dentry_path(page);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
 	return rc;
@@ -1938,16 +1942,17 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server;
-	const char *full_path = NULL;
+	const char *full_path;
+	void *page = alloc_dentry_path();
 	struct cifsInodeInfo *cifsInode;
 
 	cifs_dbg(FYI, "cifs_rmdir, inode = 0x%p\n", inode);
 
 	xid = get_xid();
 
-	full_path = build_path_from_dentry(direntry);
-	if (full_path == NULL) {
-		rc = -ENOMEM;
+	full_path = build_path_from_dentry(direntry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
 		goto rmdir_exit;
 	}
 
@@ -1997,7 +2002,7 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 		current_time(inode);
 
 rmdir_exit:
-	kfree(full_path);
+	free_dentry_path(page);
 	free_xid(xid);
 	return rc;
 }
@@ -2072,8 +2077,8 @@ cifs_rename2(struct user_namespace *mnt_userns, struct inode *source_dir,
 	     struct dentry *source_dentry, struct inode *target_dir,
 	     struct dentry *target_dentry, unsigned int flags)
 {
-	const char *from_name = NULL;
-	const char *to_name = NULL;
+	const char *from_name, *to_name;
+	void *page1, *page2;
 	struct cifs_sb_info *cifs_sb;
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
@@ -2091,21 +2096,19 @@ cifs_rename2(struct user_namespace *mnt_userns, struct inode *source_dir,
 		return PTR_ERR(tlink);
 	tcon = tlink_tcon(tlink);
 
+	page1 = alloc_dentry_path();
+	page2 = alloc_dentry_path();
 	xid = get_xid();
 
-	/*
-	 * we already have the rename sem so we do not need to
-	 * grab it again here to protect the path integrity
-	 */
-	from_name = build_path_from_dentry(source_dentry);
-	if (from_name == NULL) {
-		rc = -ENOMEM;
+	from_name = build_path_from_dentry(source_dentry, page1);
+	if (IS_ERR(from_name)) {
+		rc = PTR_ERR(from_name);
 		goto cifs_rename_exit;
 	}
 
-	to_name = build_path_from_dentry(target_dentry);
-	if (to_name == NULL) {
-		rc = -ENOMEM;
+	to_name = build_path_from_dentry(target_dentry, page2);
+	if (IS_ERR(to_name)) {
+		rc = PTR_ERR(to_name);
 		goto cifs_rename_exit;
 	}
 
@@ -2177,8 +2180,8 @@ cifs_rename2(struct user_namespace *mnt_userns, struct inode *source_dir,
 
 cifs_rename_exit:
 	kfree(info_buf_source);
-	kfree(from_name);
-	kfree(to_name);
+	free_dentry_path(page2);
+	free_dentry_path(page1);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
 	return rc;
@@ -2317,7 +2320,8 @@ int cifs_revalidate_dentry_attr(struct dentry *dentry)
 	int rc = 0;
 	struct inode *inode = d_inode(dentry);
 	struct super_block *sb = dentry->d_sb;
-	const char *full_path = NULL;
+	const char *full_path;
+	void *page;
 	int count = 0;
 
 	if (inode == NULL)
@@ -2328,11 +2332,10 @@ int cifs_revalidate_dentry_attr(struct dentry *dentry)
 
 	xid = get_xid();
 
-	/* can not safely grab the rename sem here if rename calls revalidate
-	   since that would deadlock */
-	full_path = build_path_from_dentry(dentry);
-	if (full_path == NULL) {
-		rc = -ENOMEM;
+	page = alloc_dentry_path();
+	full_path = build_path_from_dentry(dentry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
 		goto out;
 	}
 
@@ -2351,7 +2354,7 @@ int cifs_revalidate_dentry_attr(struct dentry *dentry)
 	if (rc == -EAGAIN && count++ < 10)
 		goto again;
 out:
-	kfree(full_path);
+	free_dentry_path(page);
 	free_xid(xid);
 
 	return rc;
@@ -2605,7 +2608,8 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 {
 	int rc;
 	unsigned int xid;
-	const char *full_path = NULL;
+	const char *full_path;
+	void *page = alloc_dentry_path();
 	struct inode *inode = d_inode(direntry);
 	struct cifsInodeInfo *cifsInode = CIFS_I(inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
@@ -2626,9 +2630,9 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 	if (rc < 0)
 		goto out;
 
-	full_path = build_path_from_dentry(direntry);
-	if (full_path == NULL) {
-		rc = -ENOMEM;
+	full_path = build_path_from_dentry(direntry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
 		goto out;
 	}
 
@@ -2740,7 +2744,7 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 		cifsInode->time = 0;
 out:
 	kfree(args);
-	kfree(full_path);
+	free_dentry_path(page);
 	free_xid(xid);
 	return rc;
 }
@@ -2756,7 +2760,8 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	struct cifsInodeInfo *cifsInode = CIFS_I(inode);
 	struct cifsFileInfo *wfile;
 	struct cifs_tcon *tcon;
-	const char *full_path = NULL;
+	const char *full_path;
+	void *page = alloc_dentry_path();
 	int rc = -EACCES;
 	__u32 dosattr = 0;
 	__u64 mode = NO_CHANGE_64;
@@ -2770,16 +2775,13 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 		attrs->ia_valid |= ATTR_FORCE;
 
 	rc = setattr_prepare(&init_user_ns, direntry, attrs);
-	if (rc < 0) {
-		free_xid(xid);
-		return rc;
-	}
+	if (rc < 0)
+		goto cifs_setattr_exit;
 
-	full_path = build_path_from_dentry(direntry);
-	if (full_path == NULL) {
-		rc = -ENOMEM;
-		free_xid(xid);
-		return rc;
+	full_path = build_path_from_dentry(direntry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
+		goto cifs_setattr_exit;
 	}
 
 	/*
@@ -2929,8 +2931,8 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	mark_inode_dirty(inode);
 
 cifs_setattr_exit:
-	kfree(full_path);
 	free_xid(xid);
+	free_dentry_path(page);
 	return rc;
 }
 
diff --git a/fs/cifs/ioctl.c b/fs/cifs/ioctl.c
index aba573dd86ac..08d99fec593e 100644
--- a/fs/cifs/ioctl.c
+++ b/fs/cifs/ioctl.c
@@ -43,12 +43,15 @@ static long cifs_ioctl_query_info(unsigned int xid, struct file *filep,
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
 	struct dentry *dentry = filep->f_path.dentry;
 	const unsigned char *path;
+	void *page = alloc_dentry_path();
 	__le16 *utf16_path = NULL, root_path;
 	int rc = 0;
 
-	path = build_path_from_dentry(dentry);
-	if (path == NULL)
-		return -ENOMEM;
+	path = build_path_from_dentry(dentry, page);
+	if (IS_ERR(path)) {
+		free_dentry_path(page);
+		return PTR_ERR(path);
+	}
 
 	cifs_dbg(FYI, "%s %s\n", __func__, path);
 
@@ -73,7 +76,7 @@ static long cifs_ioctl_query_info(unsigned int xid, struct file *filep,
  ici_exit:
 	if (utf16_path != &root_path)
 		kfree(utf16_path);
-	kfree(path);
+	free_dentry_path(page);
 	return rc;
 }
 
diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index 18e0e31a6d39..616e1bc0cc0a 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -510,8 +510,8 @@ cifs_hardlink(struct dentry *old_file, struct inode *inode,
 {
 	int rc = -EACCES;
 	unsigned int xid;
-	const char *from_name = NULL;
-	const char *to_name = NULL;
+	const char *from_name, *to_name;
+	void *page1, *page2;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
@@ -524,11 +524,17 @@ cifs_hardlink(struct dentry *old_file, struct inode *inode,
 	tcon = tlink_tcon(tlink);
 
 	xid = get_xid();
+	page1 = alloc_dentry_path();
+	page2 = alloc_dentry_path();
 
-	from_name = build_path_from_dentry(old_file);
-	to_name = build_path_from_dentry(direntry);
-	if ((from_name == NULL) || (to_name == NULL)) {
-		rc = -ENOMEM;
+	from_name = build_path_from_dentry(old_file, page1);
+	if (IS_ERR(from_name)) {
+		rc = PTR_ERR(from_name);
+		goto cifs_hl_exit;
+	}
+	to_name = build_path_from_dentry(direntry, page2);
+	if (IS_ERR(to_name)) {
+		rc = PTR_ERR(to_name);
 		goto cifs_hl_exit;
 	}
 
@@ -587,8 +593,8 @@ cifs_hardlink(struct dentry *old_file, struct inode *inode,
 	}
 
 cifs_hl_exit:
-	kfree(from_name);
-	kfree(to_name);
+	free_dentry_path(page1);
+	free_dentry_path(page2);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
 	return rc;
@@ -600,7 +606,8 @@ cifs_get_link(struct dentry *direntry, struct inode *inode,
 {
 	int rc = -ENOMEM;
 	unsigned int xid;
-	const char *full_path = NULL;
+	const char *full_path;
+	void *page;
 	char *target_path = NULL;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct tcon_link *tlink = NULL;
@@ -620,11 +627,13 @@ cifs_get_link(struct dentry *direntry, struct inode *inode,
 	tcon = tlink_tcon(tlink);
 	server = tcon->ses->server;
 
-	full_path = build_path_from_dentry(direntry);
-	if (!full_path) {
+	page = alloc_dentry_path();
+	full_path = build_path_from_dentry(direntry, page);
+	if (IS_ERR(full_path)) {
 		free_xid(xid);
 		cifs_put_tlink(tlink);
-		return ERR_PTR(-ENOMEM);
+		free_dentry_path(page);
+		return ERR_CAST(full_path);
 	}
 
 	cifs_dbg(FYI, "Full path: %s inode = 0x%p\n", full_path, inode);
@@ -649,7 +658,7 @@ cifs_get_link(struct dentry *direntry, struct inode *inode,
 						&target_path, reparse_point);
 	}
 
-	kfree(full_path);
+	free_dentry_path(page);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
 	if (rc != 0) {
@@ -669,7 +678,8 @@ cifs_symlink(struct user_namespace *mnt_userns, struct inode *inode,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct tcon_link *tlink;
 	struct cifs_tcon *pTcon;
-	const char *full_path = NULL;
+	const char *full_path;
+	void *page = alloc_dentry_path();
 	struct inode *newinode = NULL;
 
 	xid = get_xid();
@@ -681,9 +691,9 @@ cifs_symlink(struct user_namespace *mnt_userns, struct inode *inode,
 	}
 	pTcon = tlink_tcon(tlink);
 
-	full_path = build_path_from_dentry(direntry);
-	if (full_path == NULL) {
-		rc = -ENOMEM;
+	full_path = build_path_from_dentry(direntry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
 		goto symlink_exit;
 	}
 
@@ -719,7 +729,7 @@ cifs_symlink(struct user_namespace *mnt_userns, struct inode *inode,
 		}
 	}
 symlink_exit:
-	kfree(full_path);
+	free_dentry_path(page);
 	cifs_put_tlink(tlink);
 	free_xid(xid);
 	return rc;
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 67c3177a1fda..7531e8905881 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -942,13 +942,14 @@ int cifs_readdir(struct file *file, struct dir_context *ctx)
 	char *tmp_buf = NULL;
 	char *end_of_smb;
 	unsigned int max_len;
-	const char *full_path = NULL;
+	const char *full_path;
+	void *page = alloc_dentry_path();
 
 	xid = get_xid();
 
-	full_path = build_path_from_dentry(file_dentry(file));
-	if (full_path == NULL) {
-		rc = -ENOMEM;
+	full_path = build_path_from_dentry(file_dentry(file), page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
 		goto rddir2_exit;
 	}
 
@@ -1043,7 +1044,7 @@ int cifs_readdir(struct file *file, struct dir_context *ctx)
 	kfree(tmp_buf);
 
 rddir2_exit:
-	kfree(full_path);
+	free_dentry_path(page);
 	free_xid(xid);
 	return rc;
 }
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 6a31b3dfebcd..8e1cb4db4615 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2205,20 +2205,21 @@ smb3_notify(const unsigned int xid, struct file *pfile,
 	struct smb3_notify notify;
 	struct dentry *dentry = pfile->f_path.dentry;
 	struct inode *inode = file_inode(pfile);
-	struct cifs_sb_info *cifs_sb;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct cifs_open_parms oparms;
 	struct cifs_fid fid;
 	struct cifs_tcon *tcon;
-	const unsigned char *path = NULL;
+	const unsigned char *path;
+	void *page = alloc_dentry_path();
 	__le16 *utf16_path = NULL;
 	u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
 	int rc = 0;
 
-	path = build_path_from_dentry(dentry);
-	if (path == NULL)
-		return -ENOMEM;
-
-	cifs_sb = CIFS_SB(inode->i_sb);
+	path = build_path_from_dentry(dentry, page);
+	if (IS_ERR(path)) {
+		rc = PTR_ERR(path);
+		goto notify_exit;
+	}
 
 	utf16_path = cifs_convert_path_to_utf16(path + 1, cifs_sb);
 	if (utf16_path == NULL) {
@@ -2252,7 +2253,7 @@ smb3_notify(const unsigned int xid, struct file *pfile,
 	cifs_dbg(FYI, "change notify for path %s rc %d\n", path, rc);
 
 notify_exit:
-	kfree(path);
+	free_dentry_path(page);
 	kfree(utf16_path);
 	return rc;
 }
diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
index 0195a9be3d28..e351b945135b 100644
--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -113,6 +113,7 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
 	struct tcon_link *tlink;
 	struct cifs_tcon *pTcon;
 	const char *full_path;
+	void *page;
 
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
@@ -120,10 +121,11 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
 	pTcon = tlink_tcon(tlink);
 
 	xid = get_xid();
+	page = alloc_dentry_path();
 
-	full_path = build_path_from_dentry(dentry);
-	if (full_path == NULL) {
-		rc = -ENOMEM;
+	full_path = build_path_from_dentry(dentry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
 		goto out;
 	}
 	/* return dos attributes as pseudo xattr */
@@ -235,7 +237,7 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
 	}
 
 out:
-	kfree(full_path);
+	free_dentry_path(page);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
 	return rc;
@@ -298,6 +300,7 @@ static int cifs_xattr_get(const struct xattr_handler *handler,
 	struct tcon_link *tlink;
 	struct cifs_tcon *pTcon;
 	const char *full_path;
+	void *page;
 
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
@@ -305,10 +308,11 @@ static int cifs_xattr_get(const struct xattr_handler *handler,
 	pTcon = tlink_tcon(tlink);
 
 	xid = get_xid();
+	page = alloc_dentry_path();
 
-	full_path = build_path_from_dentry(dentry);
-	if (full_path == NULL) {
-		rc = -ENOMEM;
+	full_path = build_path_from_dentry(dentry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
 		goto out;
 	}
 
@@ -401,7 +405,7 @@ static int cifs_xattr_get(const struct xattr_handler *handler,
 		rc = -EOPNOTSUPP;
 
 out:
-	kfree(full_path);
+	free_dentry_path(page);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
 	return rc;
@@ -415,6 +419,7 @@ ssize_t cifs_listxattr(struct dentry *direntry, char *data, size_t buf_size)
 	struct tcon_link *tlink;
 	struct cifs_tcon *pTcon;
 	const char *full_path;
+	void *page;
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_XATTR)
 		return -EOPNOTSUPP;
@@ -425,10 +430,11 @@ ssize_t cifs_listxattr(struct dentry *direntry, char *data, size_t buf_size)
 	pTcon = tlink_tcon(tlink);
 
 	xid = get_xid();
+	page = alloc_dentry_path();
 
-	full_path = build_path_from_dentry(direntry);
-	if (full_path == NULL) {
-		rc = -ENOMEM;
+	full_path = build_path_from_dentry(direntry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
 		goto list_ea_exit;
 	}
 	/* return dos attributes as pseudo xattr */
@@ -442,7 +448,7 @@ ssize_t cifs_listxattr(struct dentry *direntry, char *data, size_t buf_size)
 		rc = pTcon->ses->server->ops->query_all_EAs(xid, pTcon,
 				full_path, NULL, data, buf_size, cifs_sb);
 list_ea_exit:
-	kfree(full_path);
+	free_dentry_path(page);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
 	return rc;
-- 
2.11.0

