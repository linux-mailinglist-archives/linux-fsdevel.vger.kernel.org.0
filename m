Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D2014C37D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 00:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgA1XTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 18:19:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40859 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgA1XTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:19:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so7821300pgt.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 15:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O5l0lcjMlexvxq2pHH4hXfpP9hWkAKzOLyltTD0Bx1g=;
        b=i4E0D274elHebsCGzVN4tm8xSI3Op/2T8bX6w10zQEmkZ2Q8Q1+s02R+0w6NeBcEv2
         0/V344qeI1wiszpGcOhdlH7CybPz/ymWs2RadPMW6sExG9V9EfzAoDhnZQSs9tUtFBTX
         KRtpJMkRydSY3KFEyLx6iTOFE46mN7rKeDgSrXf4BiBt6MC0MxYUENlHxOOD/1ljCRU2
         +ADbX7fRJDjkpqpFgOaiF0Zu1ckUvsmbSd3IWr29ntjc8Lv7oPJxvuFDIuACzjRqQPiy
         g/s16XIp++yUNkHe5fIfMIMDk9+ZeVuldxdjMl6f4JX8ZU6jEbiN6pOI94hiSSsyAPtx
         z9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O5l0lcjMlexvxq2pHH4hXfpP9hWkAKzOLyltTD0Bx1g=;
        b=PzV38SzIbk/T8/1llsvEoMoNgV0mWpTDpNsjUz7BqbDQBvwlUecGL5HyQaIWL3fNaP
         mRv00G+Ua4/2uF4ri6tCVfQ6XBB1UQaTaxIJHgg/TIMoyEFDymq+l8gkzk9hMzHbAsNv
         WQmMbF/1mCSnIP1I60SD8FxJIoetNv1/f4r8P6/b5wo1rXiEkbbQYzIl3xl8qF9o0CpL
         wzIpSji1dsWvwtGYL90S0ujs0Q/a8DlFfDD57i3ajg+dzuB/fa83ROV3hndt1zFXZlbB
         KXMPt2pQtMstyz4HXH24OyQrTKylSuX7dvwz06YhJfdzmaW6h4So3vxApLZ22wL3w4V8
         QZhw==
X-Gm-Message-State: APjAAAVfboO/ibWLVVSZhq8Yt6LwbqW6/uHsaElEux5QiHj5SJO0UGzd
        F0Lkcz8zznx14CeQ5Xx7rhG8ypkUxwM=
X-Google-Smtp-Source: APXvYqxoaXlJ+I8aEi4TRu5n/IIimaXdcTBGlewzt8LcTLKnKEaspURspIMbBAOsEgnvihYs2v2uog==
X-Received: by 2002:aa7:9ab6:: with SMTP id x22mr6178159pfi.260.1580253554552;
        Tue, 28 Jan 2020 15:19:14 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:200::43a7])
        by smtp.gmail.com with ESMTPSA id p24sm156353pgk.19.2020.01.28.15.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 15:19:13 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-team@fb.com
Subject: [RFC PATCH v4 1/4] fs: add flags argument to i_op->link()
Date:   Tue, 28 Jan 2020 15:19:00 -0800
Message-Id: <5b94d23baef8c2a256384f436650f4c4868915a2.1580251857.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580251857.git.osandov@fb.com>
References: <cover.1580251857.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In preparation for adding the AT_LINK_REPLACE flag, make ->link() take
and check a flags argument.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/9p/vfs_inode.c       | 5 ++++-
 fs/9p/vfs_inode_dotl.c  | 5 ++++-
 fs/affs/affs.h          | 2 +-
 fs/affs/namei.c         | 6 +++++-
 fs/afs/dir.c            | 7 +++++--
 fs/bad_inode.c          | 2 +-
 fs/bfs/dir.c            | 7 +++++--
 fs/btrfs/inode.c        | 5 ++++-
 fs/ceph/dir.c           | 5 ++++-
 fs/cifs/cifsfs.h        | 2 +-
 fs/cifs/link.c          | 5 ++++-
 fs/coda/dir.c           | 5 ++++-
 fs/ecryptfs/inode.c     | 5 ++++-
 fs/ext2/namei.c         | 5 ++++-
 fs/ext4/namei.c         | 7 +++++--
 fs/f2fs/namei.c         | 5 ++++-
 fs/fuse/dir.c           | 5 ++++-
 fs/gfs2/inode.c         | 5 ++++-
 fs/hfsplus/dir.c        | 5 ++++-
 fs/hostfs/hostfs_kern.c | 5 ++++-
 fs/jffs2/dir.c          | 8 ++++++--
 fs/jfs/namei.c          | 7 +++++--
 fs/libfs.c              | 6 +++++-
 fs/minix/namei.c        | 5 ++++-
 fs/namei.c              | 2 +-
 fs/nfs/dir.c            | 6 +++++-
 fs/nfs/internal.h       | 2 +-
 fs/nilfs2/namei.c       | 5 ++++-
 fs/ocfs2/namei.c        | 6 +++++-
 fs/overlayfs/dir.c      | 5 ++++-
 fs/reiserfs/namei.c     | 5 ++++-
 fs/sysv/namei.c         | 7 +++++--
 fs/ubifs/dir.c          | 5 ++++-
 fs/udf/namei.c          | 5 ++++-
 fs/ufs/namei.c          | 5 ++++-
 fs/xfs/xfs_iops.c       | 6 +++++-
 include/linux/fs.h      | 4 ++--
 mm/shmem.c              | 6 +++++-
 38 files changed, 148 insertions(+), 45 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index b82423a72f68..3cda7788122e 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1335,12 +1335,15 @@ v9fs_vfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
 
 static int
 v9fs_vfs_link(struct dentry *old_dentry, struct inode *dir,
-	      struct dentry *dentry)
+	      struct dentry *dentry, int flags)
 {
 	int retval;
 	char name[1 + U32_MAX_DIGITS + 2]; /* sign + number + \n + \0 */
 	struct p9_fid *oldfid;
 
+	if (flags)
+		return -EINVAL;
+
 	p9_debug(P9_DEBUG_VFS, " %lu,%pd,%pd\n",
 		 dir->i_ino, dentry, old_dentry);
 
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 60328b21c5fb..636796582f68 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -749,12 +749,15 @@ v9fs_vfs_symlink_dotl(struct inode *dir, struct dentry *dentry,
 
 static int
 v9fs_vfs_link_dotl(struct dentry *old_dentry, struct inode *dir,
-		struct dentry *dentry)
+		   struct dentry *dentry, int flags)
 {
 	int err;
 	struct p9_fid *dfid, *oldfid;
 	struct v9fs_session_info *v9ses;
 
+	if (flags)
+		return -EINVAL;
+
 	p9_debug(P9_DEBUG_VFS, "dir ino: %lu, old_name: %pd, new_name: %pd\n",
 		 dir->i_ino, old_dentry, dentry);
 
diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index a755bef7c4c7..98d70fd7ea47 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -171,7 +171,7 @@ extern int	affs_create(struct inode *dir, struct dentry *dentry, umode_t mode, b
 extern int	affs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode);
 extern int	affs_rmdir(struct inode *dir, struct dentry *dentry);
 extern int	affs_link(struct dentry *olddentry, struct inode *dir,
-			  struct dentry *dentry);
+			  struct dentry *dentry, int flags);
 extern int	affs_symlink(struct inode *dir, struct dentry *dentry,
 			     const char *symname);
 extern int	affs_rename2(struct inode *old_dir, struct dentry *old_dentry,
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index 41c5749f4db7..198f2878145d 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -388,10 +388,14 @@ affs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
 }
 
 int
-affs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
+affs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry,
+	  int flags)
 {
 	struct inode *inode = d_inode(old_dentry);
 
+	if (flags)
+		return -EINVAL;
+
 	pr_debug("%s(%lu, %lu, \"%pd\")\n", __func__, inode->i_ino, dir->i_ino,
 		 dentry);
 
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 5c794f4b051a..0a17d8d8c009 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -34,7 +34,7 @@ static int afs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode);
 static int afs_rmdir(struct inode *dir, struct dentry *dentry);
 static int afs_unlink(struct inode *dir, struct dentry *dentry);
 static int afs_link(struct dentry *from, struct inode *dir,
-		    struct dentry *dentry);
+		    struct dentry *dentry, int flags);
 static int afs_symlink(struct inode *dir, struct dentry *dentry,
 		       const char *content);
 static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
@@ -1641,7 +1641,7 @@ static int afs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
  * create a hard link between files in an AFS filesystem
  */
 static int afs_link(struct dentry *from, struct inode *dir,
-		    struct dentry *dentry)
+		    struct dentry *dentry, int flags)
 {
 	struct afs_fs_cursor fc;
 	struct afs_status_cb *scb;
@@ -1650,6 +1650,9 @@ static int afs_link(struct dentry *from, struct inode *dir,
 	struct key *key;
 	int ret;
 
+	if (flags)
+		return -EINVAL;
+
 	_enter("{%llx:%llu},{%llx:%llu},{%pd}",
 	       vnode->fid.vid, vnode->fid.vnode,
 	       dvnode->fid.vid, dvnode->fid.vnode,
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 8035d2a44561..41caa98597d6 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -39,7 +39,7 @@ static struct dentry *bad_inode_lookup(struct inode *dir,
 }
 
 static int bad_inode_link (struct dentry *old_dentry, struct inode *dir,
-		struct dentry *dentry)
+			   struct dentry *dentry, int flags)
 {
 	return -EIO;
 }
diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index d8dfe3a0cb39..0b0ef8a59a73 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -144,13 +144,16 @@ static struct dentry *bfs_lookup(struct inode *dir, struct dentry *dentry,
 	return d_splice_alias(inode, dentry);
 }
 
-static int bfs_link(struct dentry *old, struct inode *dir,
-						struct dentry *new)
+static int bfs_link(struct dentry *old, struct inode *dir, struct dentry *new,
+		    int flags)
 {
 	struct inode *inode = d_inode(old);
 	struct bfs_sb_info *info = BFS_SB(inode->i_sb);
 	int err;
 
+	if (flags)
+		return -EINVAL;
+
 	mutex_lock(&info->bfs_lock);
 	err = bfs_add_entry(dir, &new->d_name, inode->i_ino);
 	if (err) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c70baafb2a39..bc7709c4f6eb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6759,7 +6759,7 @@ static int btrfs_create(struct inode *dir, struct dentry *dentry,
 }
 
 static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
-		      struct dentry *dentry)
+		      struct dentry *dentry, int flags)
 {
 	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
@@ -6769,6 +6769,9 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	int err;
 	int drop_inode = 0;
 
+	if (flags)
+		return -EINVAL;
+
 	/* do not allow sys_link's with other subvols of the same device */
 	if (root->root_key.objectid != BTRFS_I(inode)->root->root_key.objectid)
 		return -EXDEV;
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 2e4764fd1872..a1517be5405c 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -999,13 +999,16 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 }
 
 static int ceph_link(struct dentry *old_dentry, struct inode *dir,
-		     struct dentry *dentry)
+		     struct dentry *dentry, int flags)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	int err;
 
+	if (flags)
+		return -EINVAL;
+
 	if (ceph_snap(dir) != CEPH_NOSNAP)
 		return -EROFS;
 
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index b59dc7478130..9360d28255ef 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -69,7 +69,7 @@ extern int cifs_atomic_open(struct inode *, struct dentry *,
 extern struct dentry *cifs_lookup(struct inode *, struct dentry *,
 				  unsigned int);
 extern int cifs_unlink(struct inode *dir, struct dentry *dentry);
-extern int cifs_hardlink(struct dentry *, struct inode *, struct dentry *);
+extern int cifs_hardlink(struct dentry *, struct inode *, struct dentry *, int);
 extern int cifs_mknod(struct inode *, struct dentry *, umode_t, dev_t);
 extern int cifs_mkdir(struct inode *, struct dentry *, umode_t);
 extern int cifs_rmdir(struct inode *, struct dentry *);
diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index b736acd3917b..1471d4c095d7 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -516,7 +516,7 @@ smb3_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 
 int
 cifs_hardlink(struct dentry *old_file, struct inode *inode,
-	      struct dentry *direntry)
+	      struct dentry *direntry, int flags)
 {
 	int rc = -EACCES;
 	unsigned int xid;
@@ -528,6 +528,9 @@ cifs_hardlink(struct dentry *old_file, struct inode *inode,
 	struct TCP_Server_Info *server;
 	struct cifsInodeInfo *cifsInode;
 
+	if (flags)
+		return -EINVAL;
+
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index ca40c2556ba6..acdbc47948cf 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -200,13 +200,16 @@ static int coda_mkdir(struct inode *dir, struct dentry *de, umode_t mode)
 
 /* try to make de an entry in dir_inodde linked to source_de */ 
 static int coda_link(struct dentry *source_de, struct inode *dir_inode, 
-	  struct dentry *de)
+		     struct dentry *de, int flags)
 {
 	struct inode *inode = d_inode(source_de);
         const char * name = de->d_name.name;
 	int len = de->d_name.len;
 	int error;
 
+	if (flags)
+		return -EINVAL;
+
 	if (is_root_inode(dir_inode) && coda_iscontrol(name, len))
 		return -EPERM;
 
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index e23752d9a79f..eeb351b220b2 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -422,7 +422,7 @@ static struct dentry *ecryptfs_lookup(struct inode *ecryptfs_dir_inode,
 }
 
 static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
-			 struct dentry *new_dentry)
+			 struct dentry *new_dentry, int flags)
 {
 	struct dentry *lower_old_dentry;
 	struct dentry *lower_new_dentry;
@@ -430,6 +430,9 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 	u64 file_size_save;
 	int rc;
 
+	if (flags)
+		return -EINVAL;
+
 	file_size_save = i_size_read(d_inode(old_dentry));
 	lower_old_dentry = ecryptfs_dentry_to_lower(old_dentry);
 	lower_new_dentry = ecryptfs_dentry_to_lower(new_dentry);
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index ccfbbf59e2fc..9417a96f6ea8 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -196,11 +196,14 @@ static int ext2_symlink (struct inode * dir, struct dentry * dentry,
 }
 
 static int ext2_link (struct dentry * old_dentry, struct inode * dir,
-	struct dentry *dentry)
+		      struct dentry *dentry, int flags)
 {
 	struct inode *inode = d_inode(old_dentry);
 	int err;
 
+	if (flags)
+		return -EINVAL;
+
 	err = dquot_initialize(dir);
 	if (err)
 		return err;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 1cb42d940784..80e27fd907d0 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3366,13 +3366,16 @@ static int ext4_symlink(struct inode *dir,
 	return err;
 }
 
-static int ext4_link(struct dentry *old_dentry,
-		     struct inode *dir, struct dentry *dentry)
+static int ext4_link(struct dentry *old_dentry, struct inode *dir,
+		     struct dentry *dentry, int flags)
 {
 	handle_t *handle;
 	struct inode *inode = d_inode(old_dentry);
 	int err, retries = 0;
 
+	if (flags)
+		return -EINVAL;
+
 	if (inode->i_nlink >= EXT4_LINK_MAX)
 		return -EMLINK;
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a1c507b0b4ac..f7ca6fbf5aaf 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -312,12 +312,15 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 }
 
 static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
-		struct dentry *dentry)
+		     struct dentry *dentry, int flags)
 {
 	struct inode *inode = d_inode(old_dentry);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	int err;
 
+	if (flags)
+		return -EINVAL;
+
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
 	if (!f2fs_is_checkpoint_ready(sbi))
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ee190119f45c..ae0cf00fd9ec 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -842,7 +842,7 @@ static int fuse_rename2(struct inode *olddir, struct dentry *oldent,
 }
 
 static int fuse_link(struct dentry *entry, struct inode *newdir,
-		     struct dentry *newent)
+		     struct dentry *newent, int flags)
 {
 	int err;
 	struct fuse_link_in inarg;
@@ -850,6 +850,9 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	FUSE_ARGS(args);
 
+	if (flags)
+		return -EINVAL;
+
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.oldnodeid = get_node_id(inode);
 	args.opcode = FUSE_LINK;
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index dafef10b91f1..f2f97321b659 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -891,7 +891,7 @@ static struct dentry *gfs2_lookup(struct inode *dir, struct dentry *dentry,
  */
 
 static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
-		     struct dentry *dentry)
+		     struct dentry *dentry, int flags)
 {
 	struct gfs2_inode *dip = GFS2_I(dir);
 	struct gfs2_sbd *sdp = GFS2_SB(dir);
@@ -902,6 +902,9 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
 	struct gfs2_diradd da = { .bh = NULL, .save_loc = 1, };
 	int error;
 
+	if (flags)
+		return -EINVAL;
+
 	if (S_ISDIR(inode->i_mode))
 		return -EPERM;
 
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 29a9dcfbe81f..16cf85e8e51d 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -298,7 +298,7 @@ static int hfsplus_dir_release(struct inode *inode, struct file *file)
 }
 
 static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
-			struct dentry *dst_dentry)
+			struct dentry *dst_dentry, int flags)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(dst_dir->i_sb);
 	struct inode *inode = d_inode(src_dentry);
@@ -308,6 +308,9 @@ static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
 	u32 cnid, id;
 	int res;
 
+	if (flags)
+		return -EINVAL;
+
 	if (HFSPLUS_IS_RSRC(inode))
 		return -EPERM;
 	if (!S_ISREG(inode->i_mode))
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 5a7eb0c79839..f2bd0e42075b 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -622,11 +622,14 @@ static struct dentry *hostfs_lookup(struct inode *ino, struct dentry *dentry,
 }
 
 static int hostfs_link(struct dentry *to, struct inode *ino,
-		       struct dentry *from)
+		       struct dentry *from, int flags)
 {
 	char *from_name, *to_name;
 	int err;
 
+	if (flags)
+		return -EOPNOTSUPP;
+
 	if ((from_name = dentry_name(from)) == NULL)
 		return -ENOMEM;
 	to_name = dentry_name(to);
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index f20cff1194bb..c4ec9202ca8e 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -28,7 +28,7 @@ static int jffs2_create (struct inode *,struct dentry *,umode_t,
 			 bool);
 static struct dentry *jffs2_lookup (struct inode *,struct dentry *,
 				    unsigned int);
-static int jffs2_link (struct dentry *,struct inode *,struct dentry *);
+static int jffs2_link (struct dentry *,struct inode *,struct dentry *, int);
 static int jffs2_unlink (struct inode *,struct dentry *);
 static int jffs2_symlink (struct inode *,struct dentry *,const char *);
 static int jffs2_mkdir (struct inode *,struct dentry *,umode_t);
@@ -240,7 +240,8 @@ static int jffs2_unlink(struct inode *dir_i, struct dentry *dentry)
 /***********************************************************************/
 
 
-static int jffs2_link (struct dentry *old_dentry, struct inode *dir_i, struct dentry *dentry)
+static int jffs2_link (struct dentry *old_dentry, struct inode *dir_i,
+		       struct dentry *dentry, int flags)
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(old_dentry->d_sb);
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(d_inode(old_dentry));
@@ -249,6 +250,9 @@ static int jffs2_link (struct dentry *old_dentry, struct inode *dir_i, struct de
 	uint8_t type;
 	uint32_t now;
 
+	if (flags)
+		return -EINVAL;
+
 	/* Don't let people make hard links to bad inodes. */
 	if (!f->inocache)
 		return -EIO;
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 7a55d14cc1af..45447fca1fdb 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -781,8 +781,8 @@ void jfs_free_zero_link(struct inode *ip)
  * EXDEV: target object and new link are on different file systems and
  * implementation does not support links between file systems [XPG4.2].
  */
-static int jfs_link(struct dentry *old_dentry,
-	     struct inode *dir, struct dentry *dentry)
+static int jfs_link(struct dentry *old_dentry, struct inode *dir,
+		    struct dentry *dentry, int flags)
 {
 	int rc;
 	tid_t tid;
@@ -792,6 +792,9 @@ static int jfs_link(struct dentry *old_dentry,
 	struct btstack btstack;
 	struct inode *iplist[2];
 
+	if (flags)
+		return -EINVAL;
+
 	jfs_info("jfs_link: %pd %pd", old_dentry, dentry);
 
 	rc = dquot_initialize(dir);
diff --git a/fs/libfs.c b/fs/libfs.c
index 1463b038ffc4..1894d6b202f2 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -318,10 +318,14 @@ int simple_open(struct inode *inode, struct file *file)
 }
 EXPORT_SYMBOL(simple_open);
 
-int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
+int simple_link(struct dentry *old_dentry, struct inode *dir,
+		struct dentry *dentry, int flags)
 {
 	struct inode *inode = d_inode(old_dentry);
 
+	if (flags)
+		return -EINVAL;
+
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	inc_nlink(inode);
 	ihold(inode);
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 1a6084d2b02e..6dc1c4fd4dd6 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -99,10 +99,13 @@ static int minix_symlink(struct inode * dir, struct dentry *dentry,
 }
 
 static int minix_link(struct dentry * old_dentry, struct inode * dir,
-	struct dentry *dentry)
+		      struct dentry *dentry, int flags)
 {
 	struct inode *inode = d_inode(old_dentry);
 
+	if (flags)
+		return -EINVAL;
+
 	inode->i_ctime = current_time(inode);
 	inode_inc_link_count(inode);
 	ihold(inode);
diff --git a/fs/namei.c b/fs/namei.c
index 4fb61e0754ed..9d690df17aed 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4181,7 +4181,7 @@ int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_de
 	else {
 		error = try_break_deleg(inode, delegated_inode);
 		if (!error)
-			error = dir->i_op->link(old_dentry, dir, new_dentry);
+			error = dir->i_op->link(old_dentry, dir, new_dentry, 0);
 	}
 
 	if (!error && (inode->i_state & I_LINKABLE)) {
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e180033e35cf..2497d0287043 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1991,11 +1991,15 @@ int nfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
 EXPORT_SYMBOL_GPL(nfs_symlink);
 
 int
-nfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
+nfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry,
+	 int flags)
 {
 	struct inode *inode = d_inode(old_dentry);
 	int error;
 
+	if (flags)
+		return -EINVAL;
+
 	dfprintk(VFS, "NFS: link(%pd2 -> %pd2)\n",
 		old_dentry, dentry);
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 24a65da58aa9..4f446465ed7b 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -356,7 +356,7 @@ int nfs_mkdir(struct inode *, struct dentry *, umode_t);
 int nfs_rmdir(struct inode *, struct dentry *);
 int nfs_unlink(struct inode *, struct dentry *);
 int nfs_symlink(struct inode *, struct dentry *, const char *);
-int nfs_link(struct dentry *, struct inode *, struct dentry *);
+int nfs_link(struct dentry *, struct inode *, struct dentry *, int);
 int nfs_mknod(struct inode *, struct dentry *, umode_t, dev_t);
 int nfs_rename(struct inode *, struct dentry *,
 	       struct inode *, struct dentry *, unsigned int);
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 9fe6d4ab74f0..bcbca3f9d947 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -174,12 +174,15 @@ static int nilfs_symlink(struct inode *dir, struct dentry *dentry,
 }
 
 static int nilfs_link(struct dentry *old_dentry, struct inode *dir,
-		      struct dentry *dentry)
+		      struct dentry *dentry, int flags)
 {
 	struct inode *inode = d_inode(old_dentry);
 	struct nilfs_transaction_info ti;
 	int err;
 
+	if (flags)
+		return -EINVAL;
+
 	err = nilfs_transaction_begin(dir->i_sb, &ti, 1);
 	if (err)
 		return err;
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 8ea51cf27b97..c228e7bcb51b 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -672,7 +672,8 @@ static int ocfs2_create(struct inode *dir,
 
 static int ocfs2_link(struct dentry *old_dentry,
 		      struct inode *dir,
-		      struct dentry *dentry)
+		      struct dentry *dentry,
+		      int flags)
 {
 	handle_t *handle;
 	struct inode *inode = d_inode(old_dentry);
@@ -687,6 +688,9 @@ static int ocfs2_link(struct dentry *old_dentry,
 	sigset_t oldset;
 	u64 old_de_ino;
 
+	if (flags)
+		return -EINVAL;
+
 	trace_ocfs2_link((unsigned long long)OCFS2_I(inode)->ip_blkno,
 			 old_dentry->d_name.len, old_dentry->d_name.name,
 			 dentry->d_name.len, dentry->d_name.name);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 29abdb1d3b5c..923d1c93f570 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -661,11 +661,14 @@ static int ovl_set_link_redirect(struct dentry *dentry)
 }
 
 static int ovl_link(struct dentry *old, struct inode *newdir,
-		    struct dentry *new)
+		    struct dentry *new, int flags)
 {
 	int err;
 	struct inode *inode;
 
+	if (flags)
+		return -EINVAL;
+
 	err = ovl_want_write(old);
 	if (err)
 		goto out;
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 959a066b7bb0..4ff94931f350 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -1195,7 +1195,7 @@ static int reiserfs_symlink(struct inode *parent_dir,
 }
 
 static int reiserfs_link(struct dentry *old_dentry, struct inode *dir,
-			 struct dentry *dentry)
+			 struct dentry *dentry, int flags)
 {
 	int retval;
 	struct inode *inode = d_inode(old_dentry);
@@ -1208,6 +1208,9 @@ static int reiserfs_link(struct dentry *old_dentry, struct inode *dir,
 	    JOURNAL_PER_BALANCE_CNT * 3 +
 	    2 * REISERFS_QUOTA_TRANS_BLOCKS(dir->i_sb);
 
+	if (flags)
+		return -EINVAL;
+
 	retval = dquot_initialize(dir);
 	if (retval)
 		return retval;
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index ea2414b385ec..a202feb6ad89 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -96,11 +96,14 @@ static int sysv_symlink(struct inode * dir, struct dentry * dentry,
 	goto out;
 }
 
-static int sysv_link(struct dentry * old_dentry, struct inode * dir, 
-	struct dentry * dentry)
+static int sysv_link(struct dentry *old_dentry, struct inode *dir,
+		     struct dentry *dentry, int flags)
 {
 	struct inode *inode = d_inode(old_dentry);
 
+	if (flags)
+		return -EINVAL;
+
 	inode->i_ctime = current_time(inode);
 	inode_inc_link_count(inode);
 	ihold(inode);
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 0b98e3c8b461..1fc180266338 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -683,7 +683,7 @@ static void unlock_2_inodes(struct inode *inode1, struct inode *inode2)
 }
 
 static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
-		      struct dentry *dentry)
+		      struct dentry *dentry, int flags)
 {
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
 	struct inode *inode = d_inode(old_dentry);
@@ -694,6 +694,9 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 				.dirtied_ino_d = ALIGN(ui->data_len, 8) };
 	struct fscrypt_name nm;
 
+	if (flags)
+		return -EINVAL;
+
 	/*
 	 * Budget request settings: new direntry, changing the target inode,
 	 * changing the parent inode.
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 77b6d89b9bcd..263c9daf6aad 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1028,13 +1028,16 @@ static int udf_symlink(struct inode *dir, struct dentry *dentry,
 }
 
 static int udf_link(struct dentry *old_dentry, struct inode *dir,
-		    struct dentry *dentry)
+		    struct dentry *dentry, int flags)
 {
 	struct inode *inode = d_inode(old_dentry);
 	struct udf_fileident_bh fibh;
 	struct fileIdentDesc cfi, *fi;
 	int err;
 
+	if (flags)
+		return -EINVAL;
+
 	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
 	if (!fi) {
 		return err;
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 9ef40f100415..7f8d2e4eac8c 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -146,11 +146,14 @@ static int ufs_symlink (struct inode * dir, struct dentry * dentry,
 }
 
 static int ufs_link (struct dentry * old_dentry, struct inode * dir,
-	struct dentry *dentry)
+		     struct dentry *dentry, int flags)
 {
 	struct inode *inode = d_inode(old_dentry);
 	int error;
 
+	if (flags)
+		return -EINVAL;
+
 	inode->i_ctime = current_time(inode);
 	inode_inc_link_count(inode);
 	ihold(inode);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 8afe69ca188b..62ecb726fa41 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -311,12 +311,16 @@ STATIC int
 xfs_vn_link(
 	struct dentry	*old_dentry,
 	struct inode	*dir,
-	struct dentry	*dentry)
+	struct dentry	*dentry,
+	int	flags)
 {
 	struct inode	*inode = d_inode(old_dentry);
 	struct xfs_name	name;
 	int		error;
 
+	if (flags)
+		return -EINVAL;
+
 	error = xfs_dentry_mode_to_name(&name, dentry, inode->i_mode);
 	if (unlikely(error))
 		return error;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..3bdb71c97e8f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1869,7 +1869,7 @@ struct inode_operations {
 	int (*readlink) (struct dentry *, char __user *,int);
 
 	int (*create) (struct inode *,struct dentry *, umode_t, bool);
-	int (*link) (struct dentry *,struct inode *,struct dentry *);
+	int (*link) (struct dentry *,struct inode *,struct dentry *, int);
 	int (*unlink) (struct inode *,struct dentry *);
 	int (*symlink) (struct inode *,struct dentry *,const char *);
 	int (*mkdir) (struct inode *,struct dentry *,umode_t);
@@ -3298,7 +3298,7 @@ extern int simple_setattr(struct dentry *, struct iattr *);
 extern int simple_getattr(const struct path *, struct kstat *, u32, unsigned int);
 extern int simple_statfs(struct dentry *, struct kstatfs *);
 extern int simple_open(struct inode *inode, struct file *file);
-extern int simple_link(struct dentry *, struct inode *, struct dentry *);
+extern int simple_link(struct dentry *, struct inode *, struct dentry *, int);
 extern int simple_unlink(struct inode *, struct dentry *);
 extern int simple_rmdir(struct inode *, struct dentry *);
 extern int simple_rename(struct inode *, struct dentry *,
diff --git a/mm/shmem.c b/mm/shmem.c
index 8793e8cc1a48..ff7c976e19b9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2948,11 +2948,15 @@ static int shmem_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 /*
  * Link a file..
  */
-static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
+static int shmem_link(struct dentry *old_dentry, struct inode *dir,
+		      struct dentry *dentry, int flags)
 {
 	struct inode *inode = d_inode(old_dentry);
 	int ret = 0;
 
+	if (flags)
+		return -EINVAL;
+
 	/*
 	 * No ordinary (disk based) filesystem counts links as inodes;
 	 * but each new link needs a new dentry, pinning lowmem, and
-- 
2.25.0

