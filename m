Return-Path: <linux-fsdevel+bounces-73735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCEED1F754
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C635303B462
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AF236C0B4;
	Wed, 14 Jan 2026 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKXLxANa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F42EC0A1;
	Wed, 14 Jan 2026 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400954; cv=none; b=VsZiC+GKWFFiwXq8xb3aHgfxBa0DzaICOUz0sl8ioHxUDtr4Tn4Fdgt5HfxQmP8jKV017mpjho5rZdRcvBl2mjR96rvJeXZudDG1FAbpRMpgwLSHtaa8H/JiPYGTSFMqsg/SSx97xagGQSPVG1qwq/eMmtqu0sPIygfXntgzx88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400954; c=relaxed/simple;
	bh=Drbvp1kjRl3GUXXnG+dpA2siOvgEhucGWlPkc1hUM+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkvIL+9CRoi22PfmKhpcoDpvjg165EdpY+MeZbteOSTqwzadcIaRtZk78dlJP3VR8xktV00+aniARpKE2GXxHtG53hD8yblPNvoqtYP9uTBr18/4imBCH1mwei72RMEgg9n7jKg4zTMYsrKleC+xom8uD+qAMQTdORiCVmXbzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKXLxANa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3593FC16AAE;
	Wed, 14 Jan 2026 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768400954;
	bh=Drbvp1kjRl3GUXXnG+dpA2siOvgEhucGWlPkc1hUM+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vKXLxANaO25h+4tVdf0E/HuZ5PuXNsDQgdJXHz3c0ntTnMxMZZSu6tMoXpfWqcouJ
	 hshB+rQkSM35Zefsr9o1nciLcPcMTr0h/jYwlntInHVr9Akrupz5hHmbE9mFgMQTz1
	 /t4zKYyCdkee6HJ+fO+KDLp5cXJsmcA1AdbwKRs9R1d73CADFqXIAvhWuE9nnlda3x
	 jxB45oT6jtTkgI544iM0mnl1ZJFrawqRyXQpp9a8pF60dKxaOTdtgg3cB6E7kZld/A
	 RBsJjGwF5J/RrUoGI2cW2uQ9I3gQS2p/brq6ZWeImB1mi4dujKwfGglWRKrbbkO4Z6
	 UC8V10peut0AQ==
From: Chuck Lever <cel@kernel.org>
To: vira@web.codeaurora.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	<linux-nfs@vger.kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	cem@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	trondmy@kernel.org,
	anna@kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	hansg@kernel.org,
	senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 04/16] ntfs3: Implement fileattr_get for case sensitivity
Date: Wed, 14 Jan 2026 09:28:47 -0500
Message-ID: <20260114142900.3945054-5-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114142900.3945054-1-cel@kernel.org>
References: <20260114142900.3945054-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Report NTFS case sensitivity behavior via the file_kattr boolean
fields. NTFS always preserves case at rest.

Case sensitivity depends on mount options: with "nocase", NTFS
is case-insensitive; otherwise it is case-sensitive.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ntfs3/file.c    | 22 ++++++++++++++++++++++
 fs/ntfs3/inode.c   |  1 +
 fs/ntfs3/namei.c   |  2 ++
 fs/ntfs3/ntfs_fs.h |  1 +
 4 files changed, 26 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 2e7b2e566ebe..434a2d48db02 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -146,6 +146,27 @@ long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long arg)
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
+	 * NTFS preserves case (the default). Case sensitivity depends on
+	 * mount options: with "nocase", NTFS is case-insensitive;
+	 * otherwise it is case-sensitive.
+	 */
+	fa->case_insensitive = sbi->options && sbi->options->nocase;
+	return 0;
+}
+
 /*
  * ntfs_getattr - inode_operations::getattr
  */
@@ -1460,6 +1481,7 @@ const struct inode_operations ntfs_file_inode_operations = {
 	.get_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
 	.fiemap		= ntfs_fiemap,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct file_operations ntfs_file_operations = {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 0a9ac5efeb67..205083e8a6e0 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -2089,6 +2089,7 @@ const struct inode_operations ntfs_link_inode_operations = {
 	.get_link	= ntfs_get_link,
 	.setattr	= ntfs_setattr,
 	.listxattr	= ntfs_listxattr,
+	.fileattr_get	= ntfs_fileattr_get,
 };
 
 const struct address_space_operations ntfs_aops = {
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 3b24ca02de61..d09414711016 100644
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
index a4559c9f64e6..a578b75f31fc 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -504,6 +504,7 @@ extern const struct file_operations ntfs_dir_operations;
 extern const struct file_operations ntfs_legacy_dir_operations;
 
 /* Globals from file.c */
+int ntfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags);
 int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
-- 
2.52.0


