Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4799342A7F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 05:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhCTEfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 00:35:46 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:58368 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhCTEfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 00:35:19 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNTIO-007ZDU-Ej; Sat, 20 Mar 2021 04:33:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-cifs@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/7] cifs: constify pathname arguments in a bunch of helpers
Date:   Sat, 20 Mar 2021 04:33:01 +0000
Message-Id: <20210320043304.1803623-4-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/cifs/cifsproto.h | 4 ++--
 fs/cifs/file.c      | 4 ++--
 fs/cifs/inode.c     | 4 ++--
 fs/cifs/readdir.c   | 4 ++--
 fs/cifs/xattr.c     | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 75ce6f742b8d..ef6bc1a80c9a 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -184,7 +184,7 @@ extern struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid,
 					      struct file *file,
 					      struct tcon_link *tlink,
 					      __u32 oplock);
-extern int cifs_posix_open(char *full_path, struct inode **inode,
+extern int cifs_posix_open(const char *full_path, struct inode **inode,
 			   struct super_block *sb, int mode,
 			   unsigned int f_flags, __u32 *oplock, __u16 *netfid,
 			   unsigned int xid);
@@ -207,7 +207,7 @@ extern int cifs_get_inode_info_unix(struct inode **pinode,
 			const unsigned char *search_path,
 			struct super_block *sb, unsigned int xid);
 extern int cifs_set_file_info(struct inode *inode, struct iattr *attrs,
-			      unsigned int xid, char *full_path, __u32 dosattr);
+			      unsigned int xid, const char *full_path, __u32 dosattr);
 extern int cifs_rename_pending_delete(const char *full_path,
 				      struct dentry *dentry,
 				      const unsigned int xid);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 26de4329d161..db0a42006995 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -112,7 +112,7 @@ static inline int cifs_get_disposition(unsigned int flags)
 		return FILE_OPEN;
 }
 
-int cifs_posix_open(char *full_path, struct inode **pinode,
+int cifs_posix_open(const char *full_path, struct inode **pinode,
 			struct super_block *sb, int mode, unsigned int f_flags,
 			__u32 *poplock, __u16 *pnetfid, unsigned int xid)
 {
@@ -174,7 +174,7 @@ int cifs_posix_open(char *full_path, struct inode **pinode,
 }
 
 static int
-cifs_nt_open(char *full_path, struct inode *inode, struct cifs_sb_info *cifs_sb,
+cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_sb_info *cifs_sb,
 	     struct cifs_tcon *tcon, unsigned int f_flags, __u32 *oplock,
 	     struct cifs_fid *fid, unsigned int xid)
 {
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 7c61bc9573c0..d61dd8b48959 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -1408,7 +1408,7 @@ struct inode *cifs_root_iget(struct super_block *sb)
 
 int
 cifs_set_file_info(struct inode *inode, struct iattr *attrs, unsigned int xid,
-		   char *full_path, __u32 dosattr)
+		   const char *full_path, __u32 dosattr)
 {
 	bool set_time = false;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
@@ -2522,7 +2522,7 @@ void cifs_setsize(struct inode *inode, loff_t offset)
 
 static int
 cifs_set_file_size(struct inode *inode, struct iattr *attrs,
-		   unsigned int xid, char *full_path)
+		   unsigned int xid, const char *full_path)
 {
 	int rc;
 	struct cifsFileInfo *open_file;
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 80bf4c6f4c7b..7225b2cae3e6 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -384,7 +384,7 @@ int get_symlink_reparse_path(char *full_path, struct cifs_sb_info *cifs_sb,
 
 static int
 initiate_cifs_search(const unsigned int xid, struct file *file,
-		     char *full_path)
+		     const char *full_path)
 {
 	__u16 search_flags;
 	int rc = 0;
@@ -704,7 +704,7 @@ static int cifs_save_resume_key(const char *current_entry,
  */
 static int
 find_cifs_entry(const unsigned int xid, struct cifs_tcon *tcon, loff_t pos,
-		struct file *file, char *full_path,
+		struct file *file, const char *full_path,
 		char **current_entry, int *num_to_ret)
 {
 	__u16 search_flags;
diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
index 41a611e76bb7..bac05dd6c5b3 100644
--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -53,7 +53,7 @@ enum { XATTR_USER, XATTR_CIFS_ACL, XATTR_ACL_ACCESS, XATTR_ACL_DEFAULT,
 	XATTR_CIFS_NTSD, XATTR_CIFS_NTSD_FULL };
 
 static int cifs_attrib_set(unsigned int xid, struct cifs_tcon *pTcon,
-			   struct inode *inode, char *full_path,
+			   struct inode *inode, const char *full_path,
 			   const void *value, size_t size)
 {
 	ssize_t rc = -EOPNOTSUPP;
@@ -77,7 +77,7 @@ static int cifs_attrib_set(unsigned int xid, struct cifs_tcon *pTcon,
 }
 
 static int cifs_creation_time_set(unsigned int xid, struct cifs_tcon *pTcon,
-				  struct inode *inode, char *full_path,
+				  struct inode *inode, const char *full_path,
 				  const void *value, size_t size)
 {
 	ssize_t rc = -EOPNOTSUPP;
-- 
2.11.0

