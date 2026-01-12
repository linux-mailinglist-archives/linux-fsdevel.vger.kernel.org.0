Return-Path: <linux-fsdevel+bounces-73288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 461EAD149ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E8B03009D7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CF13815C6;
	Mon, 12 Jan 2026 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxcLkkX9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361553806C1;
	Mon, 12 Jan 2026 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240010; cv=none; b=SonGY8qPMqdZRbp6aU1vqlvfI2PNsPyrLtg2eYvOnf97EHzEkAzzBJ9Y+MnCD01DiKBQXy10XuPhKrObnvyXTFMQf/CwbOaialLv2ryVldfNQUAWcHWKPyG9BdFgf+Ychhrxvpw0gPN4pe5dvlYgwWd+aGHRJjry+chqNhWIYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240010; c=relaxed/simple;
	bh=eGTdRm6Nca3NR5YjUSVQaY+S34FxGlamkKXTnizQOqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7kIy+xevOWyGQUHQdacc3MBITf80agcBDOj9pQGqhnBhKA68t2InR+BhKleNNuL88R8QgNgVOvQEy+GNKEOjXxLgCtsyE/FukLTHwohV0lCXkfMZsnNBiIarpICUtuWeiCUJKRZTetUMhBy1q20MCUkNcCUJW44onZ21zfQ7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxcLkkX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC8FC4AF09;
	Mon, 12 Jan 2026 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768240009;
	bh=eGTdRm6Nca3NR5YjUSVQaY+S34FxGlamkKXTnizQOqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxcLkkX9mLUi5DQ4GOAyCoesZADkMDEqePwHgjkexZxvy89+IjjIkSqlcoPdiPAnx
	 9Bra+8kHYSHGnAD2UiVshoFRkdUfxKtpxTKriLYXsAu2NlF5W7iWoQyDubvmeiBxoa
	 yUDM1FObGYweleC2rdSp5UBeuvk74u7nWcExRfdkiMi42GOTjC4irdV5wgQw+1ydtG
	 94WEXmBmm469O78s9LANNw3mfmR5SzvmcPw6SSM9MJy4DATFcAKADp4SXs4Wq/P+px
	 5dSJRP28Px+YyFdb1j/VNTq2+jX65DoOHe8gcTlA/6sWGVitwnAcFrhjI2Jl4Bl9TY
	 M7cXSruQbt0zw==
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
Subject: [PATCH v3 05/16] hfs: Implement fileattr_get for case sensitivity
Date: Mon, 12 Jan 2026 12:46:18 -0500
Message-ID: <20260112174629.3729358-6-cel@kernel.org>
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

Report HFS case sensitivity behavior via the file_kattr boolean
fields. HFS is always case-insensitive (using Mac OS Roman case
folding) and always preserves case at rest.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfs/dir.c    |  1 +
 fs/hfs/hfs_fs.h |  2 ++
 fs/hfs/inode.c  | 13 +++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474..552156896105 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -321,4 +321,5 @@ const struct inode_operations hfs_dir_inode_operations = {
 	.rmdir		= hfs_remove,
 	.rename		= hfs_rename,
 	.setattr	= hfs_inode_setattr,
+	.fileattr_get	= hfs_fileattr_get,
 };
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index e94dbc04a1e4..a25cdda8ab34 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -177,6 +177,8 @@ extern int hfs_get_block(struct inode *inode, sector_t block,
 extern const struct address_space_operations hfs_aops;
 extern const struct address_space_operations hfs_btree_aops;
 
+struct file_kattr;
+int hfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int hfs_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 		    loff_t pos, unsigned int len, struct folio **foliop,
 		    void **fsdata);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 524db1389737..06429decc1d8 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -18,6 +18,7 @@
 #include <linux/uio.h>
 #include <linux/xattr.h>
 #include <linux/blkdev.h>
+#include <linux/fileattr.h>
 
 #include "hfs_fs.h"
 #include "btree.h"
@@ -698,6 +699,17 @@ static int hfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	return ret;
 }
 
+int hfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	/*
+	 * HFS is always case-insensitive (using Mac OS Roman case
+	 * folding) and always preserves case at rest.
+	 */
+	fa->case_insensitive = true;
+	fa->case_preserving = true;
+	return 0;
+}
+
 static const struct file_operations hfs_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
@@ -714,4 +726,5 @@ static const struct inode_operations hfs_file_inode_operations = {
 	.lookup		= hfs_file_lookup,
 	.setattr	= hfs_inode_setattr,
 	.listxattr	= generic_listxattr,
+	.fileattr_get	= hfs_fileattr_get,
 };
-- 
2.52.0


