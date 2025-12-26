Return-Path: <linux-fsdevel+bounces-72114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBA2CDEDD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 18:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51D1D300981A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 17:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA995258CE9;
	Fri, 26 Dec 2025 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="j+CJt0SS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD26255F5E;
	Fri, 26 Dec 2025 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766771186; cv=none; b=EJS2HYmaThgoopG6Uk4C8WVoVQ+TowgZs6b+kKoszZE1kzhwuzKBEEtp6kLeCx+smdD8h1LdNXetvWUVv6MqrsbspFR5yVXcwA9OqMJLvdizKGz0AcuSVhc7CM7jXz7C/byUD9r957pJPQC87wErvDdtxRuzQPMBtaWKvk2UTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766771186; c=relaxed/simple;
	bh=U6IZy/6HwEdWEznNPof+Ap+iqlkNiflcWrvawemh9Vg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vAATvuGhXvgmUbFWM1rHbtMsEAu7Wy87TalJjE5MqQYOIp0DSL+q1fqxj5dn1/4r/tK0thmrsRoAt3fJR7Y2YjbHUqwSLeyj+1lWCicrVWmx+TgecRIoeGDCTmtYkRT+LXM3MtLEfgdfMhFFXIRybVKuaqBlkPxtq2W09wu2Tnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=j+CJt0SS; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 05922454;
	Fri, 26 Dec 2025 17:36:37 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=j+CJt0SS;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 381E22267;
	Fri, 26 Dec 2025 17:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1766770785;
	bh=XcUIFYnmcb5hi/UIKOWaIrm2E6Q3PJz2ZZDCboiNq1A=;
	h=From:To:CC:Subject:Date;
	b=j+CJt0SSOHWZ1H6S5z786D+fw7e+3j9MPkTBHUrIw0jUetM3u7KcZXsiDJBENW1K2
	 1v3zNoIffrmBUVySCLpeL3lI7aGgocqZCZgpGc4hfjq6uBu9lDUV/EyNoPvE54lZyB
	 KF798yLeHy9//WupTD/++zvOpvt11pSKH/rqRp5E=
Received: from localhost.localdomain (172.30.20.178) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 26 Dec 2025 20:39:44 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: fsync files by syncing parent inodes
Date: Fri, 26 Dec 2025 18:39:35 +0100
Message-ID: <20251226173935.15695-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Some xfstests expect fsync() on a file or directory to also persist
directory metadata up the parent chain. Using generic_file_fsync() is not
sufficient for ntfs, because parent directories are not explicitly
written out.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/dir.c     |  2 +-
 fs/ntfs3/file.c    | 30 ++++++++++++++++++++++++---
 fs/ntfs3/frecord.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/ntfs_fs.h |  2 ++
 4 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 24cb64d5521a..001773b4514b 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -668,7 +668,7 @@ const struct file_operations ntfs_dir_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= ntfs_readdir,
-	.fsync		= generic_file_fsync,
+	.fsync		= ntfs_file_fsync,
 	.open		= ntfs_file_open,
 	.unlocked_ioctl = ntfs_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 732260087066..b48cdd77efae 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1443,13 +1443,37 @@ static ssize_t ntfs_file_splice_write(struct pipe_inode_info *pipe,
 /*
  * ntfs_file_fsync - file_operations::fsync
  */
-static int ntfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
+int ntfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = file_inode(file);
-	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
+	struct super_block *sb = inode->i_sb;
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+	int err, ret;
+
+	if (unlikely(ntfs3_forced_shutdown(sb)))
 		return -EIO;
 
-	return generic_file_fsync(file, start, end, datasync);
+	ret = file_write_and_wait_range(file, start, end);
+	if (ret)
+		return ret;
+
+	ret = write_inode_now(inode, !datasync);
+
+	if (!ret) {
+		ret = ni_write_parents(ntfs_i(inode), !datasync);
+	}
+
+	if (!ret) {
+		ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
+		ntfs_update_mftmirr(sbi, false);
+	}
+
+	err = sync_blockdev(sb->s_bdev);
+	if (unlikely(err && !ret))
+		ret = err;
+	if (!ret)
+		blkdev_issue_flush(sb->s_bdev);
+	return ret;
 }
 
 // clang-format off
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 7e3d61de2f8f..a123e3f0acde 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3001,6 +3001,57 @@ bool ni_is_dirty(struct inode *inode)
 	return false;
 }
 
+/*
+ * ni_write_parents
+ *
+ * Helper function for ntfs_file_fsync.
+ */
+int ni_write_parents(struct ntfs_inode *ni, int sync)
+{
+	int err = 0;
+	struct ATTRIB *attr = NULL;
+	struct ATTR_LIST_ENTRY *le = NULL;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+	struct super_block *sb = sbi->sb;
+
+	while ((attr = ni_find_attr(ni, attr, &le, ATTR_NAME, NULL, 0, NULL,
+				    NULL))) {
+		struct inode *dir;
+		struct ATTR_FILE_NAME *fname;
+
+		fname = resident_data_ex(attr, SIZEOF_ATTRIBUTE_FILENAME);
+		if (!fname)
+			continue;
+
+		/* Check simple case when parent inode equals current inode. */
+		if (ino_get(&fname->home) == ni->vfs_inode.i_ino) {
+			if (MFT_REC_ROOT != ni->vfs_inode.i_ino) {
+				ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+				err = -EINVAL;
+			}
+			continue;
+		}
+
+		dir = ntfs_iget5(sb, &fname->home, NULL);
+		if (IS_ERR(dir)) {
+			ntfs_inode_warn(
+				&ni->vfs_inode,
+				"failed to open parent directory r=%lx to write",
+				(long)ino_get(&fname->home));
+			continue;
+		}
+
+		if (!is_bad_inode(dir)) {
+			int err2 = write_inode_now(dir, sync);
+			if (!err)
+				err = err2;
+		}
+		iput(dir);
+	}
+
+	return err;
+}
+
 /*
  * ni_update_parent
  *
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index cee7b73b9670..482722438bd9 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -512,6 +512,7 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 int ntfs_file_open(struct inode *inode, struct file *file);
 int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len);
+int ntfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg);
 long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long arg);
 extern const struct inode_operations ntfs_special_inode_operations;
@@ -590,6 +591,7 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
 	      struct NTFS_DE *new_de);
 
 bool ni_is_dirty(struct inode *inode);
+int ni_write_parents(struct ntfs_inode *ni, int sync);
 
 /* Globals from fslog.c */
 bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes);
-- 
2.43.0


