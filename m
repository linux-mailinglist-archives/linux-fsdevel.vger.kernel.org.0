Return-Path: <linux-fsdevel+bounces-73285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 864E0D147F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 076763015AF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748037E2FE;
	Mon, 12 Jan 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4ozSu6P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C037F724;
	Mon, 12 Jan 2026 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240002; cv=none; b=llpXbn9EzF/+4nMVtUwnNLq4GNVPeQP92GyViz136SkfDo1yvxKCxQ1oGEFkiA7fF9hLv5bsnTrXkFiixH9vMKz8xIXNKdssDmygzyoAc111FAfjs1Ut9cKuIWwnDfOTFS7zt2V6IRxdr9QKi2o8mSLW8RkF13NiBEbAeC8A2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240002; c=relaxed/simple;
	bh=VGLtz3ng7N2hDrsXpu5xqwabJ5hM20loNzopsi5kxR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlTjx2U4KtMUZoBDlE9PeYwoiTLVw4z58r4WZwhqY8Go7RN2wMzbe3K1/8TPDSJ1j7CZgjmzGFQzq1r367rJJSUKsjTs4cCbyvxPxh2v99Bq2qVr2hhImeyI+VPhq0r3NXyzKZPmKypkx+Qhtxaw8E/CGsjU4FEA8LDaBzRS+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4ozSu6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AE2C2BCC9;
	Mon, 12 Jan 2026 17:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768240002;
	bh=VGLtz3ng7N2hDrsXpu5xqwabJ5hM20loNzopsi5kxR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4ozSu6P9lbOLpeQoBMMJpU5kTHiLq3wlZy6zItCzG0UHGCHRMFCD0E3BBUsX7dbu
	 TY3PPGWxN0mHVzlvR6SinmbODUN3x2+HBUxnixzZni1Qfmk6joDiAH+27iaQo88bNn
	 8ITeAuJ7yt6mgXvUMM8nmUeSkDB3ujAh98rgAcQyopKXHcfEO65tZ8PYQ7t4G54S5w
	 tz9/Qk1IaN8xwvJlyDz0hGeJzm3a46KZfjI3q3QtytBmip3p4mMFhHIZaDs3MrWXiC
	 Y/5Mbp6Mj5eG8bLawHoN7K6vBbIKcbDbQUb4xhfM8BzihRKkxTcsgPN50aU/hFo3kc
	 x8qFglImcZa1g==
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
Subject: [PATCH v3 02/16] fat: Implement fileattr_get for case sensitivity
Date: Mon, 12 Jan 2026 12:46:15 -0500
Message-ID: <20260112174629.3729358-3-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112174629.3729358-1-cel@kernel.org>
References: <20260112174629.3729358-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Report FAT's case sensitivity behavior via the file_kattr boolean
fields. FAT filesystems are case-insensitive by default and do not
preserve case at rest (stored names are uppercased).

MSDOS supports a 'nocase' mount option that enables case-sensitive
behavior; check this option when reporting case sensitivity.

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
index 4fc49a614fb8..d26dc792611a 100644
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
+	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
+
+	/*
+	 * FAT filesystems do not preserve case: stored names are
+	 * uppercased. They are case-insensitive by default, but
+	 * MSDOS supports a 'nocase' mount option for case-sensitive
+	 * behavior.
+	 */
+	fa->case_insensitive = !sbi->options.nocase;
+	fa->case_preserving = false;
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


