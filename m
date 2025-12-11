Return-Path: <linux-fsdevel+bounces-71128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C89BCB6507
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 16:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A2E630024A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E8830FF3B;
	Thu, 11 Dec 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV8/8K1O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2ED30C375;
	Thu, 11 Dec 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765466514; cv=none; b=sN2E4k4xMQhukV2Sp2QQrf+2c0YYp+ZQIpRU5Wmu0F5WRvQDV864bQRQX3ZfjiSIifpPlhfcD54hMpbUF9CtaPWckMoPF3K/ztSjQWSXXVsHq9lKMj+dK3l+jHQiEwEXpCrquKTb8rEjn5Zt/zJXTv0Bz1nPiqBoeNAsmjykp7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765466514; c=relaxed/simple;
	bh=K1wmSwwV16UCXsb+WMuc89ImO4HAvc1BlSZXGBLXsJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1LeDCXA3QfoVP/+SVXZcqxfYDzEoI/Ge0aedP8z6l1Tc7qMyG7B5F7PqKwNBajwOr0a+o+wOPFQ+nRKGRsLOl0bdoNm8jP6/TKDulDYgd32laVKF7IcKF806yF11X+8l4Ie+B2HO7FF1vplprI3a15rdiFwbQbmoWxv0LfGyNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV8/8K1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EDFC113D0;
	Thu, 11 Dec 2025 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765466514;
	bh=K1wmSwwV16UCXsb+WMuc89ImO4HAvc1BlSZXGBLXsJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pV8/8K1Og3qagDhBNXc30nTBODvLIkbwkXBr7rnTBqFxf8VExwjg6xSt6fhHlUHz6
	 7+pArY4cDEvTXcPic7jBgNrcESwmmBp2/ex4nEYisoValbTusRIcsOO7/tVVM91RrW
	 K0DzyodDCq4IumgbrBXCPAgbQRMVTdtyGIzR5ikdMofYhy+CNo1dta5pPb5gPfR7Un
	 7xg7lWMZeYkO0EPQiWRrjHdcVXn26EMMV9UZJgYS43uzDQ2tUpipKgFsxEh3YGUjWH
	 fk/OeigJQhTjwrL/xU2V/UExbjzjtG0CymxTr1M7AZrIp+qwPDdVcCvKjCv1BLP/iZ
	 MLiphy9qs+qwg==
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
Subject: [PATCH v2 2/6] fat: Implement fileattr_get for case sensitivity
Date: Thu, 11 Dec 2025 10:21:12 -0500
Message-ID: <20251211152116.480799-3-cel@kernel.org>
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

Report FAT's case sensitivity behavior via the new file_kattr
case_info field. FAT filesystems are case-insensitive and do not
preserve case at rest (stored names are uppercased).

The case folding type depends on the mount options: when utf8 is
enabled, Unicode case folding is used; otherwise ASCII case folding.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/fat/fat.h         |  3 +++
 fs/fat/file.c        | 18 ++++++++++++++++++
 fs/fat/namei_msdos.c |  1 +
 fs/fat/namei_vfat.c  |  1 +
 4 files changed, 23 insertions(+)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index d3e426de5f01..38da08d8fec4 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -10,6 +10,8 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 
+struct file_kattr;
+
 /*
  * vfat shortname flags
  */
@@ -407,6 +409,7 @@ extern void fat_truncate_blocks(struct inode *inode, loff_t offset);
 extern int fat_getattr(struct mnt_idmap *idmap,
 		       const struct path *path, struct kstat *stat,
 		       u32 request_mask, unsigned int flags);
+extern int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 extern int fat_file_fsync(struct file *file, loff_t start, loff_t end,
 			  int datasync);
 
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 4fc49a614fb8..123f4c1efdf4 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -16,6 +16,7 @@
 #include <linux/fsnotify.h>
 #include <linux/security.h>
 #include <linux/falloc.h>
+#include <linux/fileattr.h>
 #include "fat.h"
 
 static long fat_fallocate(struct file *file, int mode,
@@ -395,6 +396,22 @@ void fat_truncate_blocks(struct inode *inode, loff_t offset)
 	fat_flush_inodes(inode->i_sb, inode, NULL);
 }
 
+int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+
+	/*
+	 * FAT filesystems do not preserve case: stored names are
+	 * uppercased. They are case-insensitive, using either ASCII
+	 * or Unicode comparison depending on mount options.
+	 */
+	fa->case_info = sbi->options.utf8 ?
+		FILEATTR_CASEFOLD_UNICODE : FILEATTR_CASEFOLD_ASCII;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fat_fileattr_get);
+
 int fat_getattr(struct mnt_idmap *idmap, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int flags)
 {
@@ -574,5 +591,6 @@ EXPORT_SYMBOL_GPL(fat_setattr);
 const struct inode_operations fat_file_inode_operations = {
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
+	.fileattr_get	= fat_fileattr_get,
 	.update_time	= fat_update_time,
 };
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 0b920ee40a7f..380add5c6c66 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -640,6 +640,7 @@ static const struct inode_operations msdos_dir_inode_operations = {
 	.rename		= msdos_rename,
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
+	.fileattr_get	= fat_fileattr_get,
 	.update_time	= fat_update_time,
 };
 
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 5dbc4cbb8fce..6cf513f97afa 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1180,6 +1180,7 @@ static const struct inode_operations vfat_dir_inode_operations = {
 	.rename		= vfat_rename2,
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
+	.fileattr_get	= fat_fileattr_get,
 	.update_time	= fat_update_time,
 };
 
-- 
2.52.0


