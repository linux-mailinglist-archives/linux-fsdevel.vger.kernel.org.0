Return-Path: <linux-fsdevel+bounces-20944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C518FB115
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 13:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5A41C215CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A389A145B07;
	Tue,  4 Jun 2024 11:26:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB10145335;
	Tue,  4 Jun 2024 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717500402; cv=none; b=FlRkGPGbTHt7bCrlImE0sXr7aVsEiF0NmrfmkqQSgQ9ltd5XTEn/7c4vbr24BTX8aOXwWzbDSh9W/rcSA4rpKzmnf39bZyAuk0J97v9IpVjf8lDy36Z8dmJXtO1R+LhT00Xi9ItfrPrCReLQsnGk9jBwXFbzay9Jo1iQaR6kDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717500402; c=relaxed/simple;
	bh=DPAslzLeTdPCHR5P+eciFyRSr7VJxB5VKsaBTDYBaGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FV2IzyiFHGoqBy+9eWmjftd7pc1r93HSCmHZ/MhSdb4ybiFSbha4CyUmSo3RVM1QRUlFBlyVUaYkBemBAMarIK5PEpt45BpMIdui/VqGK76X0sxD2dkCnN92yA6d8siS9BBHpaTWWVXlrOSalx7V5q0r2R1b4AvH2Y4/19UPe4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VtpFf0q4Hz4f3lXJ;
	Tue,  4 Jun 2024 19:26:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5ED171A0C64;
	Tue,  4 Jun 2024 19:26:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAXKwTp+V5mJkItOg--.61165S5;
	Tue, 04 Jun 2024 19:26:35 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: dhowells@redhat.com,
	marc.dionne@auristor.com,
	raven@themaw.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	trond.myklebust@hammerspace.com,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.com,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	djwong@kernel.org
Cc: linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	zhangxiaoxu5@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH RFC 1/2] fs: pass sb_flags to submount
Date: Tue,  4 Jun 2024 19:26:35 +0800
Message-Id: <20240604112636.236517-2-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604112636.236517-1-lilingfeng@huaweicloud.com>
References: <20240604112636.236517-1-lilingfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXKwTp+V5mJkItOg--.61165S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKr4UGFW7JFy8Zr4DZr1DZFb_yoWDGFy7pF
	4xAw18Gr48Jr17WF1kAa15Zw1S9ryv9F17GryrW34Fvwnxtrs3W3Zrt3WYvry5CrW8Gry3
	XF4Ykw1UK3W7ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbm9aPUU
	UUU==
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Li Lingfeng <lilingfeng3@huawei.com>

This commit has no functional change.
Get sb_flags by nameidata, and pass it to submount.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/afs/internal.h          | 2 +-
 fs/afs/mntpt.c             | 4 ++--
 fs/autofs/root.c           | 4 ++--
 fs/debugfs/inode.c         | 2 +-
 fs/fs_context.c            | 5 +++--
 fs/fuse/dir.c              | 4 ++--
 fs/namei.c                 | 3 ++-
 fs/nfs/internal.h          | 2 +-
 fs/nfs/namespace.c         | 4 ++--
 fs/smb/client/cifsfs.h     | 2 +-
 fs/smb/client/namespace.c  | 2 +-
 include/linux/dcache.h     | 2 +-
 include/linux/fs_context.h | 3 ++-
 13 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 6e1d3c4daf72..dc07446e6378 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1295,7 +1295,7 @@ extern const struct inode_operations afs_mntpt_inode_operations;
 extern const struct inode_operations afs_autocell_inode_operations;
 extern const struct file_operations afs_mntpt_file_operations;
 
-extern struct vfsmount *afs_d_automount(struct path *);
+extern struct vfsmount *afs_d_automount(struct path *, unsigned int);
 extern void afs_mntpt_kill_timer(void);
 
 /*
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 297487ee8323..3519deab514f 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -161,7 +161,7 @@ static struct vfsmount *afs_mntpt_do_automount(struct dentry *mntpt)
 
 	BUG_ON(!d_inode(mntpt));
 
-	fc = fs_context_for_submount(&afs_fs_type, mntpt);
+	fc = fs_context_for_submount(&afs_fs_type, mntpt, 0);
 	if (IS_ERR(fc))
 		return ERR_CAST(fc);
 
@@ -178,7 +178,7 @@ static struct vfsmount *afs_mntpt_do_automount(struct dentry *mntpt)
 /*
  * handle an automount point
  */
-struct vfsmount *afs_d_automount(struct path *path)
+struct vfsmount *afs_d_automount(struct path *path, unsigned int sb_flags)
 {
 	struct vfsmount *newmnt;
 
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 530d18827e35..f7294d3a089f 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -25,7 +25,7 @@ static long autofs_root_compat_ioctl(struct file *,
 static int autofs_dir_open(struct inode *inode, struct file *file);
 static struct dentry *autofs_lookup(struct inode *,
 				    struct dentry *, unsigned int);
-static struct vfsmount *autofs_d_automount(struct path *);
+static struct vfsmount *autofs_d_automount(struct path *, unsigned int);
 static int autofs_d_manage(const struct path *, bool);
 static void autofs_dentry_release(struct dentry *);
 
@@ -328,7 +328,7 @@ static struct dentry *autofs_mountpoint_changed(struct path *path)
 	return path->dentry;
 }
 
-static struct vfsmount *autofs_d_automount(struct path *path)
+static struct vfsmount *autofs_d_automount(struct path *path, unsigned int sb_flags)
 {
 	struct dentry *dentry = path->dentry;
 	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index dc51df0b118d..a2cdab95d12a 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -229,7 +229,7 @@ static void debugfs_release_dentry(struct dentry *dentry)
 	kfree(fsd);
 }
 
-static struct vfsmount *debugfs_automount(struct path *path)
+static struct vfsmount *debugfs_automount(struct path *path, unsigned int sb_flags)
 {
 	struct debugfs_fsdata *fsd = path->dentry->d_fsdata;
 
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 98589aae5208..95367dc7dc40 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -352,12 +352,13 @@ EXPORT_SYMBOL(fs_context_for_reconfigure);
  * the fc->security object is inherited from @reference (if needed).
  */
 struct fs_context *fs_context_for_submount(struct file_system_type *type,
-					   struct dentry *reference)
+					   struct dentry *reference,
+					   unsigned int sb_flags)
 {
 	struct fs_context *fc;
 	int ret;
 
-	fc = alloc_fs_context(type, reference, 0, 0, FS_CONTEXT_FOR_SUBMOUNT);
+	fc = alloc_fs_context(type, reference, sb_flags, 0, FS_CONTEXT_FOR_SUBMOUNT);
 	if (IS_ERR(fc))
 		return fc;
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2b0d4781f394..88bd5aec11e7 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -305,13 +305,13 @@ static int fuse_dentry_delete(const struct dentry *dentry)
  * as the root), and return that mount so it can be auto-mounted on
  * @path.
  */
-static struct vfsmount *fuse_dentry_automount(struct path *path)
+static struct vfsmount *fuse_dentry_automount(struct path *path, unsigned int sb_flags)
 {
 	struct fs_context *fsc;
 	struct vfsmount *mnt;
 	struct fuse_inode *mp_fi = get_fuse_inode(d_inode(path->dentry));
 
-	fsc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry);
+	fsc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry, 0);
 	if (IS_ERR(fsc))
 		return ERR_CAST(fsc);
 
diff --git a/fs/namei.c b/fs/namei.c
index 37fb0a8aa09a..445de9fcef38 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1345,6 +1345,7 @@ static bool choose_mountpoint(struct mount *m, const struct path *root,
 static int follow_automount(struct path *path, int *count, unsigned lookup_flags)
 {
 	struct dentry *dentry = path->dentry;
+	struct nameidata *nd = container_of(count, struct nameidata, total_link_count);
 
 	/* We don't want to mount if someone's just doing a stat -
 	 * unless they're stat'ing a directory and appended a '/' to
@@ -1365,7 +1366,7 @@ static int follow_automount(struct path *path, int *count, unsigned lookup_flags
 	if (count && (*count)++ >= MAXSYMLINKS)
 		return -ELOOP;
 
-	return finish_automount(dentry->d_op->d_automount(path), path);
+	return finish_automount(dentry->d_op->d_automount(path, nd->root.mnt->mnt_sb->s_flags), path);
 }
 
 /*
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9f0f4534744b..f0e35e0d05c9 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -484,7 +484,7 @@ static inline bool nfs_file_io_is_buffered(struct nfs_inode *nfsi)
 #define NFS_PATH_CANONICAL 1
 extern char *nfs_path(char **p, struct dentry *dentry,
 		      char *buffer, ssize_t buflen, unsigned flags);
-extern struct vfsmount *nfs_d_automount(struct path *path);
+extern struct vfsmount *nfs_d_automount(struct path *path, unsigned int);
 int nfs_submount(struct fs_context *, struct nfs_server *);
 int nfs_do_submount(struct fs_context *);
 
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index e7494cdd957e..887aeacedebd 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -142,7 +142,7 @@ EXPORT_SYMBOL_GPL(nfs_path);
  * situation, and that different filesystems may want to use
  * different security flavours.
  */
-struct vfsmount *nfs_d_automount(struct path *path)
+struct vfsmount *nfs_d_automount(struct path *path, unsigned int sb_flags)
 {
 	struct nfs_fs_context *ctx;
 	struct fs_context *fc;
@@ -158,7 +158,7 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	/* Open a new filesystem context, transferring parameters from the
 	 * parent superblock, including the network namespace.
 	 */
-	fc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry);
+	fc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry, 0);
 	if (IS_ERR(fc))
 		return ERR_CAST(fc);
 
diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 62d5fee3e5eb..eec5d5fa42a5 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -113,7 +113,7 @@ extern int cifs_readdir(struct file *file, struct dir_context *ctx);
 extern const struct dentry_operations cifs_dentry_ops;
 extern const struct dentry_operations cifs_ci_dentry_ops;
 
-extern struct vfsmount *cifs_d_automount(struct path *path);
+extern struct vfsmount *cifs_d_automount(struct path *path, unsigned int sb_flags);
 
 /* Functions related to symlinks */
 extern const char *cifs_get_link(struct dentry *, struct inode *,
diff --git a/fs/smb/client/namespace.c b/fs/smb/client/namespace.c
index 4a517b280f2b..81640e6b2d3f 100644
--- a/fs/smb/client/namespace.c
+++ b/fs/smb/client/namespace.c
@@ -254,7 +254,7 @@ static struct vfsmount *cifs_do_automount(struct path *path)
 /*
  * Attempt to automount the referral
  */
-struct vfsmount *cifs_d_automount(struct path *path)
+struct vfsmount *cifs_d_automount(struct path *path, unsigned int sb_flags)
 {
 	struct vfsmount *newmnt;
 
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index bf53e3894aae..864b0cd1c0c9 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -142,7 +142,7 @@ struct dentry_operations {
 	void (*d_prune)(struct dentry *);
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
-	struct vfsmount *(*d_automount)(struct path *);
+	struct vfsmount *(*d_automount)(struct path *, unsigned int sb_flags);
 	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, enum d_real_type type);
 } ____cacheline_aligned;
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index c13e99cbbf81..920bcbfaff2e 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -130,7 +130,8 @@ extern struct fs_context *fs_context_for_reconfigure(struct dentry *dentry,
 						unsigned int sb_flags,
 						unsigned int sb_flags_mask);
 extern struct fs_context *fs_context_for_submount(struct file_system_type *fs_type,
-						struct dentry *reference);
+						struct dentry *reference,
+						unsigned int sb_flags);
 
 extern struct fs_context *vfs_dup_fs_context(struct fs_context *fc);
 extern int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param);
-- 
2.39.2


