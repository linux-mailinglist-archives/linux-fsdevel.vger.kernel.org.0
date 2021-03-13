Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B68339BBF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 05:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhCMEk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 23:40:57 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33588 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhCMEkf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:40:35 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKw2i-005NzU-IO; Sat, 13 Mar 2021 04:38:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Richard Weinberger <richard@nod.at>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 01/15] new helper: inode_wrong_type()
Date:   Sat, 13 Mar 2021 04:38:10 +0000
Message-Id: <20210313043824.1283821-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <YExBLBEbJRXDV19F@zeniv-ca.linux.org.uk>
References: <YExBLBEbJRXDV19F@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

inode_wrong_type(inode, mode) returns true if setting inode->i_mode
to given value would've changed the inode type.  We have enough of
those checks open-coded to make a helper worthwhile.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/9p/vfs_inode.c      | 4 ++--
 fs/9p/vfs_inode_dotl.c | 4 ++--
 fs/cifs/inode.c        | 5 ++---
 fs/fuse/dir.c          | 6 +++---
 fs/fuse/inode.c        | 2 +-
 fs/fuse/readdir.c      | 2 +-
 fs/nfs/inode.c         | 6 +++---
 fs/nfsd/nfsproc.c      | 2 +-
 fs/overlayfs/namei.c   | 4 ++--
 include/linux/fs.h     | 5 +++++
 10 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 8d97f0b45e9c..795706520b5e 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -399,7 +399,7 @@ static int v9fs_test_inode(struct inode *inode, void *data)
 
 	umode = p9mode2unixmode(v9ses, st, &rdev);
 	/* don't match inode of different type */
-	if ((inode->i_mode & S_IFMT) != (umode & S_IFMT))
+	if (inode_wrong_type(inode, umode))
 		return 0;
 
 	/* compare qid details */
@@ -1390,7 +1390,7 @@ int v9fs_refresh_inode(struct p9_fid *fid, struct inode *inode)
 	 * Don't update inode if the file type is different
 	 */
 	umode = p9mode2unixmode(v9ses, st, &rdev);
-	if ((inode->i_mode & S_IFMT) != (umode & S_IFMT))
+	if (inode_wrong_type(inode, umode))
 		goto out;
 
 	/*
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 1dc7af046615..df0b87b05c42 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -59,7 +59,7 @@ static int v9fs_test_inode_dotl(struct inode *inode, void *data)
 	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
 
 	/* don't match inode of different type */
-	if ((inode->i_mode & S_IFMT) != (st->st_mode & S_IFMT))
+	if (inode_wrong_type(inode, st->st_mode))
 		return 0;
 
 	if (inode->i_generation != st->st_gen)
@@ -959,7 +959,7 @@ int v9fs_refresh_inode_dotl(struct p9_fid *fid, struct inode *inode)
 	/*
 	 * Don't update inode if the file type is different
 	 */
-	if ((inode->i_mode & S_IFMT) != (st->st_mode & S_IFMT))
+	if (inode_wrong_type(inode, st->st_mode))
 		goto out;
 
 	/*
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 7c61bc9573c0..d46b36d52211 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -426,8 +426,7 @@ int cifs_get_inode_info_unix(struct inode **pinode,
 		}
 
 		/* if filetype is different, return error */
-		if (unlikely(((*pinode)->i_mode & S_IFMT) !=
-		    (fattr.cf_mode & S_IFMT))) {
+		if (unlikely(inode_wrong_type(*pinode, fattr.cf_mode))) {
 			CIFS_I(*pinode)->time = 0; /* force reval */
 			rc = -ESTALE;
 			goto cgiiu_exit;
@@ -1249,7 +1248,7 @@ cifs_find_inode(struct inode *inode, void *opaque)
 		return 0;
 
 	/* don't match inode of different type */
-	if ((inode->i_mode & S_IFMT) != (fattr->cf_mode & S_IFMT))
+	if (inode_wrong_type(inode, fattr->cf_mode))
 		return 0;
 
 	/* if it's not a directory or has no dentries, then flag it */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 06a18700a845..2400b98e8808 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -252,7 +252,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 		if (ret == -ENOMEM)
 			goto out;
 		if (ret || fuse_invalid_attr(&outarg.attr) ||
-		    (outarg.attr.mode ^ inode->i_mode) & S_IFMT)
+		    inode_wrong_type(inode, outarg.attr.mode))
 			goto invalid;
 
 		forget_all_cached_acls(inode);
@@ -1054,7 +1054,7 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 	err = fuse_simple_request(fm, &args);
 	if (!err) {
 		if (fuse_invalid_attr(&outarg.attr) ||
-		    (inode->i_mode ^ outarg.attr.mode) & S_IFMT) {
+		    inode_wrong_type(inode, outarg.attr.mode)) {
 			fuse_make_bad(inode);
 			err = -EIO;
 		} else {
@@ -1703,7 +1703,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	}
 
 	if (fuse_invalid_attr(&outarg.attr) ||
-	    (inode->i_mode ^ outarg.attr.mode) & S_IFMT) {
+	    inode_wrong_type(inode, outarg.attr.mode)) {
 		fuse_make_bad(inode);
 		err = -EIO;
 		goto error;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b0e18b470e91..b4b956da3851 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -350,7 +350,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		inode->i_generation = generation;
 		fuse_init_inode(inode, attr);
 		unlock_new_inode(inode);
-	} else if ((inode->i_mode ^ attr->mode) & S_IFMT) {
+	} else if (inode_wrong_type(inode, attr->mode)) {
 		/* Inode has changed type, any I/O on the old should fail */
 		fuse_make_bad(inode);
 		iput(inode);
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 3441ffa740f3..277f7041d55a 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -202,7 +202,7 @@ static int fuse_direntplus_link(struct file *file,
 		inode = d_inode(dentry);
 		if (!inode ||
 		    get_node_id(inode) != o->nodeid ||
-		    ((o->attr.mode ^ inode->i_mode) & S_IFMT)) {
+		    inode_wrong_type(inode, o->attr.mode)) {
 			d_invalidate(dentry);
 			dput(dentry);
 			goto retry;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 749bbea14d99..b0da2408816d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -334,7 +334,7 @@ nfs_find_actor(struct inode *inode, void *opaque)
 
 	if (NFS_FILEID(inode) != fattr->fileid)
 		return 0;
-	if ((S_IFMT & inode->i_mode) != (S_IFMT & fattr->mode))
+	if (inode_wrong_type(inode, fattr->mode))
 		return 0;
 	if (nfs_compare_fh(NFS_FH(inode), fh))
 		return 0;
@@ -1460,7 +1460,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 			return 0;
 		return -ESTALE;
 	}
-	if ((fattr->valid & NFS_ATTR_FATTR_TYPE) && (inode->i_mode & S_IFMT) != (fattr->mode & S_IFMT))
+	if ((fattr->valid & NFS_ATTR_FATTR_TYPE) && inode_wrong_type(inode, fattr->mode))
 		return -ESTALE;
 
 
@@ -1875,7 +1875,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	/*
 	 * Make sure the inode's type hasn't changed.
 	 */
-	if ((fattr->valid & NFS_ATTR_FATTR_TYPE) && (inode->i_mode & S_IFMT) != (fattr->mode & S_IFMT)) {
+	if ((fattr->valid & NFS_ATTR_FATTR_TYPE) && inode_wrong_type(inode, fattr->mode)) {
 		/*
 		* Big trouble! The inode has become a different object.
 		*/
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index a8d5449dd0e9..6d51687a0585 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -381,7 +381,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 
 		/* Make sure the type and device matches */
 		resp->status = nfserr_exist;
-		if (inode && type != (inode->i_mode & S_IFMT))
+		if (inode && inode_wrong_type(inode, type))
 			goto out_unlock;
 	}
 
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 3fe05fb5d145..1d573972ce22 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -371,7 +371,7 @@ int ovl_check_origin_fh(struct ovl_fs *ofs, struct ovl_fh *fh, bool connected,
 		return PTR_ERR(origin);
 
 	if (upperdentry && !ovl_is_whiteout(upperdentry) &&
-	    ((d_inode(origin)->i_mode ^ d_inode(upperdentry)->i_mode) & S_IFMT))
+	    inode_wrong_type(d_inode(upperdentry), d_inode(origin)->i_mode))
 		goto invalid;
 
 	if (!*stackp)
@@ -730,7 +730,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 		index = ERR_PTR(-ESTALE);
 		goto out;
 	} else if (ovl_dentry_weird(index) || ovl_is_whiteout(index) ||
-		   ((inode->i_mode ^ d_inode(origin)->i_mode) & S_IFMT)) {
+		   inode_wrong_type(inode, d_inode(origin)->i_mode)) {
 		/*
 		 * Index should always be of the same file type as origin
 		 * except for the case of a whiteout index. A whiteout
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..9e0d76a41229 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2884,6 +2884,11 @@ static inline bool execute_ok(struct inode *inode)
 	return (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode);
 }
 
+static inline bool inode_wrong_type(const struct inode *inode, umode_t mode)
+{
+	return (inode->i_mode ^ mode) & S_IFMT;
+}
+
 static inline void file_start_write(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
-- 
2.11.0

