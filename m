Return-Path: <linux-fsdevel+bounces-22502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0318B91813D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAEB28D1E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F1D187343;
	Wed, 26 Jun 2024 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Nge5PEnO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E04A185E73;
	Wed, 26 Jun 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405805; cv=none; b=KWPlrj3gRYqPSoR1iw3VYU8UHV5LWH9hoDlmwgGNHtGD1E/s0A/7EyeSxYug0zj7BAcCngHAXKXSSEZlLYckAjvxb0K4KV50VvYGtkLzCfZL0WJ7EGPsczXaA5u1/Pz8pJ4t3XQjeWDok2fDu2weexEZDoD7rLTjXI1YYTr7UHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405805; c=relaxed/simple;
	bh=+g/2zWCXm7BcA1xf+cXDAIsTKXsvx9Oxv+5qfSCpKOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNORBbuvo3EsmDOw7a8FKQVfj16ETIH+cz+Jghs6JZLhWfqCSDfEICwoY5P5z9OfnykIvuvF+9mRIR9FWF6b1TBOGYc81dIghfWU6TMBiBxO7JXmJDvH6zw0/vBeeXC5kdyLpeLOMk86hnn1ScBv4wzPaxsZBJnEY1EBwl0mFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=Nge5PEnO; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 5CD8A217F;
	Wed, 26 Jun 2024 12:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405317;
	bh=rW3TAEwEnglaiQIxFtPJZ1pOr8ecyNizfFfffXoDox8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Nge5PEnOxEVBsW/ciJjhITiy6vZDa+SZHTj+4XwzXSPLNrOqtL38OIuIhBCr9weLA
	 722/rXjCDR4ZB0a3ru6w7zFR4PA+PefJ03nnMPygxVM0tIAGAphDnPxBECpxOsVG3l
	 bKRzljU5fIGo9GbsoPfxkn1nCaAxGC41h1DunO0Y=
Received: from ntfs3vm.paragon-software.com (192.168.211.129) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 26 Jun 2024 15:43:20 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Matthew Wilcox
	<willy@infradead.org>, Christian Brauner <brauner@kernel.org>
Subject: [PATCH 09/11] fs/ntfs3: Redesign legacy ntfs support
Date: Wed, 26 Jun 2024 15:42:56 +0300
Message-ID: <20240626124258.7264-10-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626124258.7264-1-almaz.alexandrovich@paragon-software.com>
References: <20240626124258.7264-1-almaz.alexandrovich@paragon-software.com>
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

1) Make is_legacy_ntfs static inline.
2) Put legacy file_operations under #if IS_ENABLED(CONFIG_NTFS_FS).

Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/dir.c     |  2 ++
 fs/ntfs3/file.c    |  2 ++
 fs/ntfs3/inode.c   | 28 ++++++++++++----------------
 fs/ntfs3/ntfs_fs.h |  7 +++++++
 fs/ntfs3/super.c   |  2 --
 5 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 1ec09f2fca64..fc6a8aa29e3a 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -631,10 +631,12 @@ const struct file_operations ntfs_dir_operations = {
 #endif
 };
 
+#if IS_ENABLED(CONFIG_NTFS_FS)
 const struct file_operations ntfs_legacy_dir_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= ntfs_readdir,
 	.open		= ntfs_file_open,
 };
+#endif
 // clang-format on
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 2ceb762dc679..e95e9ffe6c0f 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1242,6 +1242,7 @@ const struct file_operations ntfs_file_operations = {
 	.release	= ntfs_file_release,
 };
 
+#if IS_ENABLED(CONFIG_NTFS_FS)
 const struct file_operations ntfs_legacy_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= ntfs_file_read_iter,
@@ -1249,4 +1250,5 @@ const struct file_operations ntfs_legacy_file_operations = {
 	.open		= ntfs_file_open,
 	.release	= ntfs_file_release,
 };
+#endif
 // clang-format on
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 68dd71eed3fe..77ae0dccbd5c 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -441,10 +441,9 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		 * Usually a hard links to directories are disabled.
 		 */
 		inode->i_op = &ntfs_dir_inode_operations;
-		if (is_legacy_ntfs(inode->i_sb))
-			inode->i_fop = &ntfs_legacy_dir_operations;
-		else
-			inode->i_fop = &ntfs_dir_operations;
+		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
+				       &ntfs_legacy_dir_operations :
+				       &ntfs_dir_operations;
 		ni->i_valid = 0;
 	} else if (S_ISLNK(mode)) {
 		ni->std_fa &= ~FILE_ATTRIBUTE_DIRECTORY;
@@ -454,10 +453,9 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	} else if (S_ISREG(mode)) {
 		ni->std_fa &= ~FILE_ATTRIBUTE_DIRECTORY;
 		inode->i_op = &ntfs_file_inode_operations;
-		if (is_legacy_ntfs(inode->i_sb))
-			inode->i_fop = &ntfs_legacy_file_operations;
-		else
-			inode->i_fop = &ntfs_file_operations;
+		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
+				       &ntfs_legacy_file_operations :
+				       &ntfs_file_operations;
 		inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
 							      &ntfs_aops;
 		if (ino != MFT_REC_MFT)
@@ -1627,10 +1625,9 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 
 	if (S_ISDIR(mode)) {
 		inode->i_op = &ntfs_dir_inode_operations;
-		if (is_legacy_ntfs(inode->i_sb))
-			inode->i_fop = &ntfs_legacy_dir_operations;
-		else
-			inode->i_fop = &ntfs_dir_operations;
+		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
+				       &ntfs_legacy_dir_operations :
+				       &ntfs_dir_operations;
 	} else if (S_ISLNK(mode)) {
 		inode->i_op = &ntfs_link_inode_operations;
 		inode->i_fop = NULL;
@@ -1639,10 +1636,9 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		inode_nohighmem(inode);
 	} else if (S_ISREG(mode)) {
 		inode->i_op = &ntfs_file_inode_operations;
-		if (is_legacy_ntfs(inode->i_sb))
-			inode->i_fop = &ntfs_legacy_file_operations;
-		else
-			inode->i_fop = &ntfs_file_operations;
+		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
+				       &ntfs_legacy_file_operations :
+				       &ntfs_file_operations;
 		inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
 							      &ntfs_aops;
 		init_rwsem(&ni->file.run_lock);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 8074fc53a145..6240ed742e7b 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -1140,6 +1140,13 @@ static inline void le64_sub_cpu(__le64 *var, u64 val)
 	*var = cpu_to_le64(le64_to_cpu(*var) - val);
 }
 
+#if IS_ENABLED(CONFIG_NTFS_FS)
 bool is_legacy_ntfs(struct super_block *sb);
+#else
+static inline bool is_legacy_ntfs(struct super_block *sb)
+{
+	return false;
+}
+#endif
 
 #endif /* _LINUX_NTFS3_NTFS_FS_H */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index c39a70b93bb1..64cdb32da6c6 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1837,10 +1837,8 @@ bool is_legacy_ntfs(struct super_block *sb)
 #else
 static inline void register_as_ntfs_legacy(void) {}
 static inline void unregister_as_ntfs_legacy(void) {}
-bool is_legacy_ntfs(struct super_block *sb) { return false; }
 #endif
 
-
 // clang-format on
 
 static int __init init_ntfs_fs(void)
-- 
2.34.1


