Return-Path: <linux-fsdevel+bounces-54103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 426C7AFB3AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F951AA11C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1BA29B22C;
	Mon,  7 Jul 2025 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="YORAEkpz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773820010C;
	Mon,  7 Jul 2025 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751892946; cv=none; b=ug5VDu9GGLm53oM0l7wk2k9IxUMEgyEOlkufj439NTQPaxqZIGtHpg79zk+4c4IWc293eQUdk65TO73wM0LmIupPobkV/TGYQGlzX1mgVWoyohT7VRFpIGXCLtu+2k4POOuyfOtRNKRsFNTo1Z4vmMFsHncOpxE87ESB/4fCVdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751892946; c=relaxed/simple;
	bh=YTIe8M4ZQiDlN3xp20Cf3EDiJVLSerE+ao4k4sqwk3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JjAmFLQ1TOhPMput8Ze9n66qv+290TfcOOW+sfDOT5N2sbkj/X3RjbKTVz1d+Y/TqY2Z7kkbjy3jB1bFwOSkBiiUpi7nOBU0k/3RfyaxwUYVTc9xpVvCbd9KdY5CsBHTw5hkwDjj06bJxZYfKSL8MJRpYUqkwPxmX2yBPdrr0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=YORAEkpz; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 3342C1CC;
	Mon,  7 Jul 2025 12:45:15 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=YORAEkpz;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 9C9711E47;
	Mon,  7 Jul 2025 12:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1751892379;
	bh=4oPgktVYh3L41ssSHKTNcOyrtU94x4q3/ClqW0B0uBQ=;
	h=From:To:CC:Subject:Date;
	b=YORAEkpzzgP6QEorpPro6VDIyWfEQ0BZSPKETkfZmhHUP5BZBG8U5wQgBBAzkWP3m
	 ySsMebNgUoXE7GEulfKZii25eY8lEcK/Ua0rGv9HtfqZZV4T3IPV50DL5dU9F78F08
	 wVQRhhirWgcjojWmZCTtAdY6OIXrteuTAcG0YleY=
Received: from localhost.localdomain (172.30.20.165) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 7 Jul 2025 15:46:18 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Al Viro
	<viro@zeniv.linux.org.uk>
Subject: [PATCH] fs/ntfs3: Exclude call make_bad_inode for live nodes.
Date: Mon, 7 Jul 2025 14:46:08 +0200
Message-ID: <20250707124608.6718-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Use ntfs_inode field 'ni_bad' to mark inode as bad (if something went wrong)
and to avoid any operations

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c    | 32 ++++++++++++++++++++++++++++++++
 fs/ntfs3/frecord.c |  4 ++++
 fs/ntfs3/fsntfs.c  |  6 +++++-
 fs/ntfs3/inode.c   | 18 ++++++++++++++++++
 fs/ntfs3/namei.c   | 16 ++++++++++++++++
 fs/ntfs3/ntfs_fs.h | 12 ++++++++++++
 fs/ntfs3/xattr.c   | 16 ++++++++++++++++
 7 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 1e99a35691cd..65fb27d1e17c 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -57,6 +57,10 @@ long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
 	struct inode *inode = file_inode(filp);
 	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ntfs_i(inode))))
+		return -EINVAL;
+
 	switch (cmd) {
 	case FITRIM:
 		return ntfs_ioctl_fitrim(sbi, arg);
@@ -81,6 +85,10 @@ int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	struct inode *inode = d_inode(path->dentry);
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	stat->result_mask |= STATX_BTIME;
 	stat->btime = ni->i_crtime;
 	stat->blksize = ni->mi.sbi->cluster_size; /* 512, 1K, ..., 2M */
@@ -271,6 +279,10 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	bool rw = vma->vm_flags & VM_WRITE;
 	int err;
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
@@ -735,6 +747,10 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	umode_t mode = inode->i_mode;
 	int err;
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
@@ -795,6 +811,10 @@ static int check_read_restriction(struct inode *inode)
 {
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
@@ -1130,6 +1150,10 @@ static int check_write_restriction(struct inode *inode)
 {
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
@@ -1212,6 +1236,10 @@ int ntfs_file_open(struct inode *inode, struct file *file)
 {
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
@@ -1281,6 +1309,10 @@ int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	int err;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	err = fiemap_prep(inode, fieinfo, start, &len, ~FIEMAP_FLAG_XATTR);
 	if (err)
 		return err;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 37826288fbb0..8f9fe1d7a690 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3208,6 +3208,10 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 	if (is_bad_inode(inode) || sb_rdonly(sb))
 		return 0;
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	if (unlikely(ntfs3_forced_shutdown(sb)))
 		return -EIO;
 
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index df81f1f7330c..c7a2f191254d 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -905,9 +905,13 @@ void ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
 void ntfs_bad_inode(struct inode *inode, const char *hint)
 {
 	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
+	struct ntfs_inode *ni = ntfs_i(inode);
 
 	ntfs_inode_err(inode, "%s", hint);
-	make_bad_inode(inode);
+
+	/* Do not call make_bad_inode()! */
+	ni->ni_bad = true;
+
 	/* Avoid recursion if bad inode is $Volume. */
 	if (inode->i_ino != MFT_REC_VOL &&
 	    !(sbi->flags & NTFS_FLAGS_LOG_REPLAYING)) {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 8bfe35477654..4f9020df8912 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -878,6 +878,10 @@ static int ntfs_resident_writepage(struct folio *folio,
 	struct ntfs_inode *ni = ntfs_i(inode);
 	int ret;
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
@@ -896,6 +900,10 @@ static int ntfs_writepages(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ntfs_i(inode))))
+		return -EINVAL;
+
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
@@ -919,6 +927,10 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
@@ -1265,6 +1277,12 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		goto out1;
 	}
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(dir_ni))) {
+		err = -EINVAL;
+		goto out2;
+	}
+
 	if (unlikely(ntfs3_forced_shutdown(sb))) {
 		err = -EIO;
 		goto out2;
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 0db7ca3b64ea..82c8ae56beee 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -171,6 +171,10 @@ static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
 	struct ntfs_inode *ni = ntfs_i(dir);
 	int err;
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
 		return -EIO;
 
@@ -191,6 +195,10 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 {
 	u32 size = strlen(symname);
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ntfs_i(dir))))
+		return -EINVAL;
+
 	if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
 		return -EIO;
 
@@ -216,6 +224,10 @@ static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
 	struct ntfs_inode *ni = ntfs_i(dir);
 	int err;
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
 		return -EIO;
 
@@ -256,6 +268,10 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 		      1024);
 	static_assert(PATH_MAX >= 4 * 1024);
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	if (unlikely(ntfs3_forced_shutdown(sb)))
 		return -EIO;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 7fde06019ac6..9a25fec25f01 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -377,6 +377,13 @@ struct ntfs_inode {
 	 */
 	u8 mi_loaded;
 
+	/* 
+	 * Use this field to avoid any write(s).
+	 * If inode is bad during initialization - use make_bad_inode
+	 * If inode is bad during operations - use this field
+	 */
+	u8 ni_bad;
+
 	union {
 		struct ntfs_index dir;
 		struct {
@@ -1024,6 +1031,11 @@ static inline bool is_compressed(const struct ntfs_inode *ni)
 	       (ni->ni_flags & NI_FLAG_COMPRESSED_MASK);
 }
 
+static inline bool is_bad_ni(const struct ntfs_inode *ni)
+{
+	return ni->ni_bad;
+}
+
 static inline int ni_ext_compress_bits(const struct ntfs_inode *ni)
 {
 	return 0xb + (ni->ni_flags & NI_FLAG_COMPRESSED_MASK);
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 4bf14cff2683..e519e21596a7 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -552,6 +552,10 @@ struct posix_acl *ntfs_get_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	int err;
 	void *buf;
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return ERR_PTR(-EINVAL);
+
 	/* Allocate PATH_MAX bytes. */
 	buf = __getname();
 	if (!buf)
@@ -600,6 +604,10 @@ static noinline int ntfs_set_acl_ex(struct mnt_idmap *idmap,
 	int flags;
 	umode_t mode;
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ntfs_i(inode))))
+		return -EINVAL;
+
 	if (S_ISLNK(inode->i_mode))
 		return -EOPNOTSUPP;
 
@@ -730,6 +738,10 @@ ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	struct ntfs_inode *ni = ntfs_i(inode);
 	ssize_t ret;
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	if (!(ni->ni_flags & NI_FLAG_EA)) {
 		/* no xattr in file */
 		return 0;
@@ -751,6 +763,10 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 	int err;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ni)))
+		return -EINVAL;
+
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
-- 
2.43.0


