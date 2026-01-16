Return-Path: <linux-fsdevel+bounces-74137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25667D32E37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55EEC31675B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132B399A70;
	Fri, 16 Jan 2026 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0rpSVil"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7F274FC1;
	Fri, 16 Jan 2026 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574792; cv=none; b=G/VJKjZbM+uA7+WZyzGi2OWgT0TqSiqKhHfvQ5mYR+K/QnFfwJYNA0ZbaxD8nJD7qZWzl4yCBZbajpQM+6OaeYwm32Yj35U4D7fH1wXSwJZ/C0vHzc+czrB2q2iPV4IX3BC4ZaLqtCg81nOtu/il+8Ydx8KKMSswAOXY/G26FuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574792; c=relaxed/simple;
	bh=gRv+sO1S3hrUFLKI3T4D9s/Q8NW2IImgEOr3ucFDdXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQIapitmS7NnWZAq8L8L19xcHt3ZG7xYLaHIfNfl7CSxP/rbqH9lldzroZmmqfeEe4R0HbaJEBNTY6rqXWUiCbujoN1FKdqy0JxOTaykJvcATzsGOYllEPmvHqwKSpINtoKEbl1p+SM6BavGdFlXqG5ahPq/rGqv3M8yGGX/vJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0rpSVil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC0BC16AAE;
	Fri, 16 Jan 2026 14:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574792;
	bh=gRv+sO1S3hrUFLKI3T4D9s/Q8NW2IImgEOr3ucFDdXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0rpSVil86wbm3ZEGIncGWvspcwjYraoydIjQN4KK2J21tJHfIh21H5q+tRiUlMIc
	 ALg8nOwf1XXQ2uuSFsfCTI+HzGaUou18b9U9qpibfUJso3O+cCEYFlVZJCoPPT8Itt
	 2CDno3IKVD+eBjZAdX+CC53JWUZTgae72Y5+jVGnHNg5yT3ZbZsOGXCf75UkQBQq2M
	 zYJh1tg+HqKTghVfIka04XN/q5Vn6dbMvHJL6/QC2ByIryxjToTlVQ65ytI9ArkAdu
	 OBlMw4feMGGa9+OxudQil+ugupIB0Wjddw7bqSdMSK7AJjr4/loa+ixLioXRkTqQ4l
	 aMUAh55hT+Shw==
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
Subject: [PATCH v5 05/16] hfs: Implement fileattr_get for case sensitivity
Date: Fri, 16 Jan 2026 09:46:04 -0500
Message-ID: <20260116144616.2098618-6-cel@kernel.org>
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

Report HFS case sensitivity behavior via the file_kattr boolean
fields. HFS is always case-insensitive (using Mac OS Roman case
folding) and always preserves case at rest.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfs/dir.c    |  1 +
 fs/hfs/hfs_fs.h |  2 ++
 fs/hfs/inode.c  | 12 ++++++++++++
 3 files changed, 15 insertions(+)

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
index 524db1389737..c52bc52712eb 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -18,6 +18,7 @@
 #include <linux/uio.h>
 #include <linux/xattr.h>
 #include <linux/blkdev.h>
+#include <linux/fileattr.h>
 
 #include "hfs_fs.h"
 #include "btree.h"
@@ -698,6 +699,16 @@ static int hfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	return ret;
 }
 
+int hfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	/*
+	 * HFS is always case-insensitive (using Mac OS Roman case
+	 * folding). Case is preserved at rest (the default).
+	 */
+	fa->case_insensitive = true;
+	return 0;
+}
+
 static const struct file_operations hfs_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
@@ -714,4 +725,5 @@ static const struct inode_operations hfs_file_inode_operations = {
 	.lookup		= hfs_file_lookup,
 	.setattr	= hfs_inode_setattr,
 	.listxattr	= generic_listxattr,
+	.fileattr_get	= hfs_fileattr_get,
 };
-- 
2.52.0


