Return-Path: <linux-fsdevel+bounces-66012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAB1C17A09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D17784F4F2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1199B2D3EF6;
	Wed, 29 Oct 2025 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fpyf6o4v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D41DE8B5;
	Wed, 29 Oct 2025 00:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698854; cv=none; b=T9gfAAoMJU66Gx/0K1pFBYIleWjICxOxwtdilMYpgVArUU2QNmn0yGpnvf5NJ12XD3tr6XX6nTJrCxZ2ZJFoRgSCRWvcK3F4ZnbOZ7jtMtSY2u5xskxD/OTV8A4xtrBF5vbbDbclaYCpyycDPii8ApzRg7I8kgek/KvOg4GkBMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698854; c=relaxed/simple;
	bh=RfO5YcoH36+MCp9xmK/xaJ4jidmDTp+g6zCu1mVPRSM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfmXCWWa7n3+UAfzA7qH8cagpvqfJuctX1krhf8PBNUvusGZ6Q0EXU4vemXfXuPyBUnBWMpGyEf8pWTSKicFb6vpbP4o99Vw3NxgHwxL9QwAHwdmkDtW9YQrAprVgaSOdXsoDG3Id5OM09h4Mf6G1WgiGI3f46SDoRaerRCwmPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fpyf6o4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E611C4CEE7;
	Wed, 29 Oct 2025 00:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698854;
	bh=RfO5YcoH36+MCp9xmK/xaJ4jidmDTp+g6zCu1mVPRSM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Fpyf6o4vKQArhHCpLKuumTLRZoyWg4pilclSNamcih7d/ZxnrSOT7mKHIQmckPvrB
	 EOHjamaVL0EfSYCNyQPqZ3/f8UX68ZKqayCDbx1ysIcJMRB1gk1Q0bDzYDNJDbMjiO
	 jTGbqinCsk3egkrKK9Dxk6bdBGjQwzVDlENNrMdpUb/9x6RhCQhqX1P+S4zxGSAmmt
	 s2M1MU/WxeAqYb/i+Wf6UGB9QOPJT10ePK7lEBMZ/WZ4BGDYZGEgm19MM9i6U8XWnL
	 MHSYSPuE77l/UZoIEnXyEvCAt/t9uTOuV+Y2lTCTXlOmb0fTVbtEcff1l1mHe48SGO
	 q/YHlLHwSePwg==
Date: Tue, 28 Oct 2025 17:47:33 -0700
Subject: [PATCH 10/31] fuse: implement basic iomap reporting such as FIEMAP
 and SEEK_{DATA,HOLE}
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810568.1424854.4073875923015322741.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement the basic file mapping reporting functions like FIEMAP, BMAP,
and SEEK_DATA/HOLE.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h     |    8 ++++++
 fs/fuse/dir.c        |    1 +
 fs/fuse/file.c       |   13 ++++++++++
 fs/fuse/file_iomap.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 89 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c7aeb324fe599e..6fe8aa1845b98d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1730,6 +1730,11 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
 
 	return test_bit(FUSE_I_IOMAP, &fi->state);
 }
+
+int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		      u64 start, u64 length);
+loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
+sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1739,6 +1744,9 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
 # define fuse_iomap_init_nonreg_inode(...)	((void)0)
 # define fuse_iomap_evict_inode(...)		((void)0)
 # define fuse_inode_has_iomap(...)		(false)
+# define fuse_iomap_fiemap			NULL
+# define fuse_iomap_lseek(...)			(-ENOSYS)
+# define fuse_iomap_bmap(...)			(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 18eb1bb192bb58..bafc386f2f4d3a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2296,6 +2296,7 @@ static const struct inode_operations fuse_common_inode_operations = {
 	.set_acl	= fuse_set_acl,
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
+	.fiemap		= fuse_iomap_fiemap,
 };
 
 static const struct inode_operations fuse_symlink_inode_operations = {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index bd9c208a46c78d..8a981f41b1dbd0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2512,6 +2512,12 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 	struct fuse_bmap_out outarg;
 	int err;
 
+	if (fuse_inode_has_iomap(inode)) {
+		sector_t alt_sec = fuse_iomap_bmap(mapping, block);
+		if (alt_sec > 0)
+			return alt_sec;
+	}
+
 	if (!inode->i_sb->s_bdev || fm->fc->no_bmap)
 		return 0;
 
@@ -2547,6 +2553,13 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
 	struct fuse_lseek_out outarg;
 	int err;
 
+	if (fuse_inode_has_iomap(inode)) {
+		loff_t alt_pos = fuse_iomap_lseek(file, offset, whence);
+
+		if (alt_pos >= 0 || (alt_pos < 0 && alt_pos != -ENOSYS))
+			return alt_pos;
+	}
+
 	if (fm->fc->no_lseek)
 		goto fallback;
 
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 66a7b8faa31ac2..ce64e7c4860ef8 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -4,6 +4,7 @@
  * Author: Darrick J. Wong <djwong@kernel.org>
  */
 #include <linux/iomap.h>
+#include <linux/fiemap.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "iomap_i.h"
@@ -561,7 +562,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 	return err;
 }
 
-const struct iomap_ops fuse_iomap_ops = {
+static const struct iomap_ops fuse_iomap_ops = {
 	.iomap_begin		= fuse_iomap_begin,
 	.iomap_end		= fuse_iomap_end,
 };
@@ -690,3 +691,68 @@ void fuse_iomap_evict_inode(struct inode *inode)
 	if (conn->iomap && fuse_inode_is_exclusive(inode))
 		clear_bit(FUSE_I_EXCLUSIVE, &fi->state);
 }
+
+int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		      u64 start, u64 count)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	int error;
+
+	/*
+	 * We are called directly from the vfs so we need to check per-inode
+	 * support here explicitly.
+	 */
+	if (!fuse_inode_has_iomap(inode))
+		return -EOPNOTSUPP;
+
+	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR)
+		return -EOPNOTSUPP;
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	if (!fuse_allow_current_process(fc))
+		return -EACCES;
+
+	inode_lock_shared(inode);
+	error = iomap_fiemap(inode, fieinfo, start, count, &fuse_iomap_ops);
+	inode_unlock_shared(inode);
+
+	return error;
+}
+
+sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block)
+{
+	ASSERT(fuse_inode_has_iomap(mapping->host));
+
+	return iomap_bmap(mapping, block, &fuse_iomap_ops);
+}
+
+loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	if (!fuse_allow_current_process(fc))
+		return -EACCES;
+
+	switch (whence) {
+	case SEEK_HOLE:
+		offset = iomap_seek_hole(inode, offset, &fuse_iomap_ops);
+		break;
+	case SEEK_DATA:
+		offset = iomap_seek_data(inode, offset, &fuse_iomap_ops);
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	if (offset < 0)
+		return offset;
+	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
+}


