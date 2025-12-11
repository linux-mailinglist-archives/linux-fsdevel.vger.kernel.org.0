Return-Path: <linux-fsdevel+bounces-71129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9921DCB64F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 16:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 665213001BDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551D02FE06C;
	Thu, 11 Dec 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA8LBLVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B212311971;
	Thu, 11 Dec 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765466515; cv=none; b=DrH0bd/1d/9Pi0TE0bQ7M8xOi2nWw2vkAf/B4rpHmAXg4VJkPUmbU7sskN9sioYykV54PFYSM3geeRcOjVTcFQPvmBWPR+/AwwRieSBLoORPFYkoiiu5ibCfm7Ya63HjAgAeS1ilrxl8pQ78Cmib2G8pn10r7rFKox4aLY9wUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765466515; c=relaxed/simple;
	bh=8krsME7lzQGAnvbq2w/PdMk4UoQLtKDmlNA0rgLt2ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0MyHzHvYCW50t0vikVYIzQcIB+xRJlhFZlPLeCOgIU6Ds2Mspspi6Le0+yY7Q5P5PUNa0Rdl2JpKkLW+waRbSmvShIsxDjjMmoBCyaBJ8h5X07ywhop2j4KNX9smomQVwRfkgmpPWm8YOsfKdyu3e17adfkMoQtGujnMRLLEkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA8LBLVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBC5C16AAE;
	Thu, 11 Dec 2025 15:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765466515;
	bh=8krsME7lzQGAnvbq2w/PdMk4UoQLtKDmlNA0rgLt2ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DA8LBLVPJBxAMJgmBwZ24pOvlFMXsf9ZuUhctBhmcHrThXFqDKeLZb63VjW/wrreo
	 UOLE0u/W4tAkYOcaiVaAsUYa11vbnHIEOOTchJb6aQzAd2WdqKPQdx1zqSnJYm3ZUb
	 eYsKHcAFBTn55u0takpkaA92Wkymv7TQfQSmK03wdPIMN+H3oUvfhCPWritacyRsO+
	 ws0VZabcmbQlGsg+bslT2f7OqrOmMDH2p3n510z9JW+DPIbCEeelzZo5gdPgcQOCLB
	 IGqP+Zb0/0Dq1KwfgF0YCQymRsVRczjj/8UATnrnIIpC89Ld7q/UF0Uisy7TymBOiq
	 yth3/87uuaFCw==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-ext4@vger.kernel.org,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	hirofumi@mail.parknet.co.jp,
	almaz.alexandrovich@paragon-software.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	Volker.Lendecke@sernet.de,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 3/6] ntfs3: Implement fileattr_get for case sensitivity
Date: Thu, 11 Dec 2025 10:21:13 -0500
Message-ID: <20251211152116.480799-4-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211152116.480799-1-cel@kernel.org>
References: <20251211152116.480799-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Report NTFS case sensitivity behavior via the new file_kattr
case_info field. NTFS always preserves case at rest.

Case sensitivity depends on mount options: with "nocase", NTFS
performs Unicode case-insensitive matching; otherwise it is
case-sensitive.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ntfs3/file.c    | 27 +++++++++++++++++++++++++++
 fs/ntfs3/inode.c   |  1 +
 fs/ntfs3/namei.c   |  2 ++
 fs/ntfs3/ntfs_fs.h |  1 +
 4 files changed, 31 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 4c90ec2fa2ea..35892988b788 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -104,6 +104,32 @@ long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long arg)
 }
 #endif
 
+/*
+ * ntfs_fileattr_get - inode_operations::fileattr_get
+ */
+int ntfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
+
+	/* Avoid any operation if inode is bad. */
+	if (unlikely(is_bad_ni(ntfs_i(inode))))
+		return -EINVAL;
+
+	/*
+	 * NTFS preserves case. Case sensitivity depends on mount options:
+	 * with "nocase" mount option, NTFS is case-insensitive using
+	 * Unicode case folding; otherwise it is case-sensitive.
+	 */
+	if (sbi->options && sbi->options->nocase)
+		fa->case_info = FILEATTR_CASEFOLD_UNICODE |
+				FILEATTR_CASE_PRESERVING;
+	else
+		fa->case_info = FILEATTR_CASEFOLD_NONE |
+				FILEATTR_CASE_PRESERVING;
+	return 0;
+}
+
 /*
  * ntfs_getattr - inode_operations::getattr
  */
@@ -1383,6 +1409,7 @@ const struct inode_operations ntfs_file_inode_operations = {
 	.get_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
 	.fiemap		= ntfs_fiemap,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct file_operations ntfs_file_operations = {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3959f23c487a..ecdea6d83980 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -2085,6 +2085,7 @@ const struct inode_operations ntfs_link_inode_operations = {
 	.get_link	= ntfs_get_link,
 	.setattr	= ntfs_setattr,
 	.listxattr	= ntfs_listxattr,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct address_space_operations ntfs_aops = {
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 82c8ae56beee..2094e5409e43 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -519,6 +519,7 @@ const struct inode_operations ntfs_dir_inode_operations = {
 	.getattr	= ntfs_getattr,
 	.listxattr	= ntfs_listxattr,
 	.fiemap		= ntfs_fiemap,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct inode_operations ntfs_special_inode_operations = {
@@ -527,6 +528,7 @@ const struct inode_operations ntfs_special_inode_operations = {
 	.listxattr	= ntfs_listxattr,
 	.get_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct dentry_operations ntfs_dentry_ops = {
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 630128716ea7..a178ca66e2e0 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -503,6 +503,7 @@ extern const struct file_operations ntfs_dir_operations;
 extern const struct file_operations ntfs_legacy_dir_operations;
 
 /* Globals from file.c */
+int ntfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags);
 int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
-- 
2.52.0


