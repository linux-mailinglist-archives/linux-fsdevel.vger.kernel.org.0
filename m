Return-Path: <linux-fsdevel+bounces-26802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BBF95BB49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C87B2867B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8DA1CDA00;
	Thu, 22 Aug 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="SyT41BUl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79F51CCB35;
	Thu, 22 Aug 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342491; cv=none; b=hJHJ8K8JLuLP98PBucNpjk5yCQlKmbdqMKEG1tA0Rnjr9Y0LLD+JXa8bzTpRMrlGMlwm3w0x7AlsiHy1WQsKSY7DeSQOYmQUzVk3ouOF/Zth2a48UMf9Pd+2DcyUIE+ZX3q9dvVbf6tIEl3P4lr8u5trum63LyiJkR/wCd9q/dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342491; c=relaxed/simple;
	bh=Jfq1MZlSgGGrlPD8Z3vKkb/RmId0zw2x3I5tk4DbX5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9Kk2W1YPu7J5O0u8Vr8gRxB7lFbGs539dSrEEOTMyVZrbf75d4BJVbjQjOY3x/iKIYfErOhBxbdTR5TT6K+x2jw8yX7FOAlcuaAojvrbClhrOWn4z3tCdgSedYcoZmWnX77moqo/nDrioniVRiee1vkevs3wJinXwc6UrKycZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=SyT41BUl; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6DF4821D7;
	Thu, 22 Aug 2024 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341463;
	bh=iQBbo0cE9rzhyZt5Z1w6ZWxA0nXj4w9QVoU8WkNcpxU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SyT41BUlBJgpSnGkWFYtURS/3tawhLdjSrjmG4siFrwrw3ESRE++RIX5biZsxTFrv
	 HE7fFc0faEOUalqenQXw/OqaHew0kpZs3rX8xB6aDtjBxl9R9Kguuu/CzLrQTBBgPI
	 dTrXRoEOGVwWsfAT7v9kbUBs1bgeFECyqcCPFrac=
Received: from ntfs3vm.paragon-software.com (192.168.211.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Aug 2024 18:52:19 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 03/14] fs/ntfs3: Separete common code for file_read/write iter/splice
Date: Thu, 22 Aug 2024 18:51:56 +0300
Message-ID: <20240822155207.600355-4-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
References: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
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

The common code for handling encrypted, dedup, and compressed files
has been moved to check_read_restriction() and check_write_restriction().

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 116 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 76 insertions(+), 40 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index d31eae611fe0..1cbaab1163b9 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -842,10 +842,12 @@ int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return err;
 }
 
-static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+/*
+ * check_read_restriction:
+ * common code for ntfs_file_read_iter and ntfs_file_splice_read
+ */
+static int check_read_restriction(struct inode *inode)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(inode);
 
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
@@ -856,11 +858,6 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		return -EOPNOTSUPP;
 	}
 
-	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
-		ntfs_inode_warn(inode, "direct i/o + compressed not supported");
-		return -EOPNOTSUPP;
-	}
-
 #ifndef CONFIG_NTFS3_LZX_XPRESS
 	if (ni->ni_flags & NI_FLAG_COMPRESSED_MASK) {
 		ntfs_inode_warn(
@@ -875,37 +872,44 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		return -EOPNOTSUPP;
 	}
 
-	return generic_file_read_iter(iocb, iter);
+	return 0;
 }
 
-static ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
-				     struct pipe_inode_info *pipe, size_t len,
-				     unsigned int flags)
+/*
+ * ntfs_file_read_iter - file_operations::read_iter
+ */
+static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
-	struct inode *inode = file_inode(in);
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(inode);
+	ssize_t err;
 
-	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
-		return -EIO;
+	err = check_read_restriction(inode);
+	if (err)
+		return err;
 
-	if (is_encrypted(ni)) {
-		ntfs_inode_warn(inode, "encrypted i/o not supported");
+	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
+		ntfs_inode_warn(inode, "direct i/o + compressed not supported");
 		return -EOPNOTSUPP;
 	}
 
-#ifndef CONFIG_NTFS3_LZX_XPRESS
-	if (ni->ni_flags & NI_FLAG_COMPRESSED_MASK) {
-		ntfs_inode_warn(
-			inode,
-			"activate CONFIG_NTFS3_LZX_XPRESS to read external compressed files");
-		return -EOPNOTSUPP;
-	}
-#endif
+	return generic_file_read_iter(iocb, iter);
+}
 
-	if (is_dedup(ni)) {
-		ntfs_inode_warn(inode, "read deduplicated not supported");
-		return -EOPNOTSUPP;
-	}
+/*
+ * ntfs_file_splice_read - file_operations::splice_read
+ */
+static ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
+				     struct pipe_inode_info *pipe, size_t len,
+				     unsigned int flags)
+{
+	struct inode *inode = file_inode(in);
+	ssize_t err;
+
+	err = check_read_restriction(inode);
+	if (err)
+		return err;
 
 	return filemap_splice_read(in, ppos, pipe, len, flags);
 }
@@ -1173,14 +1177,11 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 }
 
 /*
- * ntfs_file_write_iter - file_operations::write_iter
+ * check_write_restriction:
+ * common code for ntfs_file_write_iter and ntfs_file_splice_write
  */
-static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+static int check_write_restriction(struct inode *inode)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file_inode(file);
-	ssize_t ret;
-	int err;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
 	if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
@@ -1191,13 +1192,31 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		return -EOPNOTSUPP;
 	}
 
-	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
-		ntfs_inode_warn(inode, "direct i/o + compressed not supported");
+	if (is_dedup(ni)) {
+		ntfs_inode_warn(inode, "write into deduplicated not supported");
 		return -EOPNOTSUPP;
 	}
 
-	if (is_dedup(ni)) {
-		ntfs_inode_warn(inode, "write into deduplicated not supported");
+	return 0;
+}
+
+/*
+ * ntfs_file_write_iter - file_operations::write_iter
+ */
+static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct ntfs_inode *ni = ntfs_i(inode);
+	ssize_t ret;
+	int err;
+
+	err = check_write_restriction(inode);
+	if (err)
+		return err;
+
+	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
+		ntfs_inode_warn(inode, "direct i/o + compressed not supported");
 		return -EOPNOTSUPP;
 	}
 
@@ -1321,6 +1340,23 @@ int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return err;
 }
 
+/*
+ * ntfs_file_splice_write - file_operations::splice_write
+ */
+static ssize_t ntfs_file_splice_write(struct pipe_inode_info *pipe,
+				      struct file *file, loff_t *ppos,
+				      size_t len, unsigned int flags)
+{
+	ssize_t err;
+	struct inode *inode = file_inode(file);
+
+	err = check_write_restriction(inode);
+	if (err)
+		return err;
+
+	return iter_file_splice_write(pipe, file, ppos, len, flags);
+}
+
 // clang-format off
 const struct inode_operations ntfs_file_inode_operations = {
 	.getattr	= ntfs_getattr,
@@ -1342,10 +1378,10 @@ const struct file_operations ntfs_file_operations = {
 	.compat_ioctl	= ntfs_compat_ioctl,
 #endif
 	.splice_read	= ntfs_file_splice_read,
+	.splice_write	= ntfs_file_splice_write,
 	.mmap		= ntfs_file_mmap,
 	.open		= ntfs_file_open,
 	.fsync		= generic_file_fsync,
-	.splice_write	= iter_file_splice_write,
 	.fallocate	= ntfs_fallocate,
 	.release	= ntfs_file_release,
 };
-- 
2.34.1


