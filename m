Return-Path: <linux-fsdevel+bounces-74136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36890D32E31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0B02321297B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F493393DE8;
	Fri, 16 Jan 2026 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6JMWwfe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A892623EA85;
	Fri, 16 Jan 2026 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574790; cv=none; b=s7GMe6HlqEvRTnMy4MlhMyN1qtfXUSgUmftfbbjs7OFFMjyBN2YDbRAMl7gi8awJBGhoE0l5egP/N7bjdVKWApkvDtheHKku1fe0H1R5fywU5f02rGeQz6GEy6Y3yX7h3LgKSxZdO/X0N7xHDgqJ6DaFPEYpKxMlHghrLTENgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574790; c=relaxed/simple;
	bh=Drbvp1kjRl3GUXXnG+dpA2siOvgEhucGWlPkc1hUM+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jr/fhYPMMpTF3dHTHsv0tp72zORnQ0iL7B2zg+SLRioY3bF/M/F70YYYrnq5VolsJGx4Z73u+iY77w+8cVvq1OBnTcpE+TvtYgLcp3Pj5Fyzy7Mhd8OO1V9AdhEmv1NHHS8uToRAcV0K6yvH0pKTpNZgVfwoX7PUGL3ZA4BqvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6JMWwfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20611C116C6;
	Fri, 16 Jan 2026 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574790;
	bh=Drbvp1kjRl3GUXXnG+dpA2siOvgEhucGWlPkc1hUM+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o6JMWwfe1798MTWrTjY1mWPVpGbqmiStWiAX0gsnDGaOCTtujWca0yoJMZj8QfduY
	 F6R0/Ym7m4wc92GfMh0Sf194+N/0qsqw4gZRoPEHjGjqtkBASsZDR6wMM+IHFZDTAI
	 FA3pCczbHE8U2xfnU1CDQNZRhBTm46sLGJhsrP0gYN8DJkU/yTET7zZ7vhpRAMXOcn
	 7X+U+AHcgaFmPrkKt1koAj+NnO30z4mi5BePYRwaRZSTmW8+/uBP4X5NzKlCuvm4bS
	 yPkEx1f5idIAn2bvQ2+EJLKBR857oECH0pe+IYI3iNHD/PLTSAZR1gYiyDKxiE5+lp
	 h4F5TzWGXDMvw==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
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
Subject: [PATCH v5 04/16] ntfs3: Implement fileattr_get for case sensitivity
Date: Fri, 16 Jan 2026 09:46:03 -0500
Message-ID: <20260116144616.2098618-5-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116144616.2098618-1-cel@kernel.org>
References: <20260116144616.2098618-1-cel@kernel.org>
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


