Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF709342A86
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 05:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhCTEfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 00:35:46 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:58362 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhCTEfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 00:35:19 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNTIO-007ZDW-HA; Sat, 20 Mar 2021 04:33:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-cifs@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/7] cifs: make build_path_from_dentry() return const char *
Date:   Sat, 20 Mar 2021 04:33:02 +0000
Message-Id: <20210320043304.1803623-5-viro@zeniv.linux.org.uk>
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

... and adjust the callers.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/cifs/cifsproto.h |  2 +-
 fs/cifs/dir.c       |  8 ++++----
 fs/cifs/file.c      |  8 ++++----
 fs/cifs/inode.c     | 16 ++++++++--------
 fs/cifs/ioctl.c     |  2 +-
 fs/cifs/link.c      |  8 ++++----
 fs/cifs/readdir.c   |  2 +-
 fs/cifs/smb2ops.c   |  2 +-
 fs/cifs/xattr.c     |  6 +++---
 9 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index ef6bc1a80c9a..50894e576e13 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -69,7 +69,7 @@ extern int init_cifs_idmap(void);
 extern void exit_cifs_idmap(void);
 extern int init_cifs_spnego(void);
 extern void exit_cifs_spnego(void);
-extern char *build_path_from_dentry(struct dentry *);
+extern const char *build_path_from_dentry(struct dentry *);
 extern char *build_path_from_dentry_optional_prefix(struct dentry *direntry,
 						    bool prefix);
 extern char *cifs_build_path_to_root(struct smb3_fs_context *ctx,
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index a3fb81e0ba17..01e26f811885 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -78,7 +78,7 @@ cifs_build_path_to_root(struct smb3_fs_context *ctx, struct cifs_sb_info *cifs_s
 }
 
 /* Note: caller must free return buffer */
-char *
+const char *
 build_path_from_dentry(struct dentry *direntry)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(direntry->d_sb);
@@ -233,7 +233,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	int desired_access;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct cifs_tcon *tcon = tlink_tcon(tlink);
-	char *full_path = NULL;
+	const char *full_path = NULL;
 	FILE_ALL_INFO *buf = NULL;
 	struct inode *newinode = NULL;
 	int disposition;
@@ -619,7 +619,7 @@ int cifs_mknod(struct user_namespace *mnt_userns, struct inode *inode,
 	struct cifs_sb_info *cifs_sb;
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
-	char *full_path = NULL;
+	const char *full_path = NULL;
 
 	if (!old_valid_dev(device_number))
 		return -EINVAL;
@@ -660,7 +660,7 @@ cifs_lookup(struct inode *parent_dir_inode, struct dentry *direntry,
 	struct tcon_link *tlink;
 	struct cifs_tcon *pTcon;
 	struct inode *newInode = NULL;
-	char *full_path = NULL;
+	const char *full_path = NULL;
 
 	xid = get_xid();
 
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index db0a42006995..f4946c06a00c 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -529,7 +529,7 @@ int cifs_open(struct inode *inode, struct file *file)
 	struct cifs_tcon *tcon;
 	struct tcon_link *tlink;
 	struct cifsFileInfo *cfile = NULL;
-	char *full_path = NULL;
+	const char *full_path = NULL;
 	bool posix_open_ok = false;
 	struct cifs_fid fid;
 	struct cifs_pending_open open;
@@ -688,7 +688,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	struct TCP_Server_Info *server;
 	struct cifsInodeInfo *cinode;
 	struct inode *inode;
-	char *full_path = NULL;
+	const char *full_path = NULL;
 	int desired_access;
 	int disposition = FILE_OPEN;
 	int create_options = CREATE_NOT_DIR;
@@ -2071,7 +2071,7 @@ cifs_get_writable_path(struct cifs_tcon *tcon, const char *name,
 	struct list_head *tmp;
 	struct cifsFileInfo *cfile;
 	struct cifsInodeInfo *cinode;
-	char *full_path;
+	const char *full_path;
 
 	*ret_file = NULL;
 
@@ -2106,7 +2106,7 @@ cifs_get_readable_path(struct cifs_tcon *tcon, const char *name,
 	struct list_head *tmp;
 	struct cifsFileInfo *cfile;
 	struct cifsInodeInfo *cinode;
-	char *full_path;
+	const char *full_path;
 
 	*ret_file = NULL;
 
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index d61dd8b48959..a6d3b8e7ca70 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -1609,7 +1609,7 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int rc = 0;
 	unsigned int xid;
-	char *full_path = NULL;
+	const char *full_path = NULL;
 	struct inode *inode = d_inode(dentry);
 	struct cifsInodeInfo *cifs_inode;
 	struct super_block *sb = dir->i_sb;
@@ -1866,7 +1866,7 @@ int cifs_mkdir(struct user_namespace *mnt_userns, struct inode *inode,
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server;
-	char *full_path;
+	const char *full_path;
 
 	cifs_dbg(FYI, "In cifs_mkdir, mode = %04ho inode = 0x%p\n",
 		 mode, inode);
@@ -1938,7 +1938,7 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server;
-	char *full_path = NULL;
+	const char *full_path = NULL;
 	struct cifsInodeInfo *cifsInode;
 
 	cifs_dbg(FYI, "cifs_rmdir, inode = 0x%p\n", inode);
@@ -2072,8 +2072,8 @@ cifs_rename2(struct user_namespace *mnt_userns, struct inode *source_dir,
 	     struct dentry *source_dentry, struct inode *target_dir,
 	     struct dentry *target_dentry, unsigned int flags)
 {
-	char *from_name = NULL;
-	char *to_name = NULL;
+	const char *from_name = NULL;
+	const char *to_name = NULL;
 	struct cifs_sb_info *cifs_sb;
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
@@ -2317,7 +2317,7 @@ int cifs_revalidate_dentry_attr(struct dentry *dentry)
 	int rc = 0;
 	struct inode *inode = d_inode(dentry);
 	struct super_block *sb = dentry->d_sb;
-	char *full_path = NULL;
+	const char *full_path = NULL;
 	int count = 0;
 
 	if (inode == NULL)
@@ -2605,7 +2605,7 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 {
 	int rc;
 	unsigned int xid;
-	char *full_path = NULL;
+	const char *full_path = NULL;
 	struct inode *inode = d_inode(direntry);
 	struct cifsInodeInfo *cifsInode = CIFS_I(inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
@@ -2756,7 +2756,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	struct cifsInodeInfo *cifsInode = CIFS_I(inode);
 	struct cifsFileInfo *wfile;
 	struct cifs_tcon *tcon;
-	char *full_path = NULL;
+	const char *full_path = NULL;
 	int rc = -EACCES;
 	__u32 dosattr = 0;
 	__u64 mode = NO_CHANGE_64;
diff --git a/fs/cifs/ioctl.c b/fs/cifs/ioctl.c
index dcde44ff6cf9..aba573dd86ac 100644
--- a/fs/cifs/ioctl.c
+++ b/fs/cifs/ioctl.c
@@ -42,7 +42,7 @@ static long cifs_ioctl_query_info(unsigned int xid, struct file *filep,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
 	struct dentry *dentry = filep->f_path.dentry;
-	unsigned char *path;
+	const unsigned char *path;
 	__le16 *utf16_path = NULL, root_path;
 	int rc = 0;
 
diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index 7c5878a645d9..18e0e31a6d39 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -510,8 +510,8 @@ cifs_hardlink(struct dentry *old_file, struct inode *inode,
 {
 	int rc = -EACCES;
 	unsigned int xid;
-	char *from_name = NULL;
-	char *to_name = NULL;
+	const char *from_name = NULL;
+	const char *to_name = NULL;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
@@ -600,7 +600,7 @@ cifs_get_link(struct dentry *direntry, struct inode *inode,
 {
 	int rc = -ENOMEM;
 	unsigned int xid;
-	char *full_path = NULL;
+	const char *full_path = NULL;
 	char *target_path = NULL;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct tcon_link *tlink = NULL;
@@ -669,7 +669,7 @@ cifs_symlink(struct user_namespace *mnt_userns, struct inode *inode,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct tcon_link *tlink;
 	struct cifs_tcon *pTcon;
-	char *full_path = NULL;
+	const char *full_path = NULL;
 	struct inode *newinode = NULL;
 
 	xid = get_xid();
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 7225b2cae3e6..67c3177a1fda 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -942,7 +942,7 @@ int cifs_readdir(struct file *file, struct dir_context *ctx)
 	char *tmp_buf = NULL;
 	char *end_of_smb;
 	unsigned int max_len;
-	char *full_path = NULL;
+	const char *full_path = NULL;
 
 	xid = get_xid();
 
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 372ed85472b1..6a31b3dfebcd 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2209,7 +2209,7 @@ smb3_notify(const unsigned int xid, struct file *pfile,
 	struct cifs_open_parms oparms;
 	struct cifs_fid fid;
 	struct cifs_tcon *tcon;
-	unsigned char *path = NULL;
+	const unsigned char *path = NULL;
 	__le16 *utf16_path = NULL;
 	u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
 	int rc = 0;
diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
index bac05dd6c5b3..0195a9be3d28 100644
--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -112,7 +112,7 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct tcon_link *tlink;
 	struct cifs_tcon *pTcon;
-	char *full_path;
+	const char *full_path;
 
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
@@ -297,7 +297,7 @@ static int cifs_xattr_get(const struct xattr_handler *handler,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct tcon_link *tlink;
 	struct cifs_tcon *pTcon;
-	char *full_path;
+	const char *full_path;
 
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
@@ -414,7 +414,7 @@ ssize_t cifs_listxattr(struct dentry *direntry, char *data, size_t buf_size)
 	struct cifs_sb_info *cifs_sb = CIFS_SB(direntry->d_sb);
 	struct tcon_link *tlink;
 	struct cifs_tcon *pTcon;
-	char *full_path;
+	const char *full_path;
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_XATTR)
 		return -EOPNOTSUPP;
-- 
2.11.0

