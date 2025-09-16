Return-Path: <linux-fsdevel+bounces-61517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC09B58983
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8BF1AA1CC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8426D1E98F3;
	Tue, 16 Sep 2025 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0xU7VKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D535E1C5F23;
	Tue, 16 Sep 2025 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982635; cv=none; b=CpxHTplaDLXytKIoIXKhMBWUFEykv4dlva6n467VPh6hoZ4e6f/G+YrEc5owm7b+FKpKi6Aq3D31shf9GarOMPKQ5RLtRdW5UFebep98ukelR3/WHbt3r0pwHVlbDGGb6A+KB2uolmilOyP7KzTDwGhySPjGP+FJ0hpKO9PNIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982635; c=relaxed/simple;
	bh=5WvmibCCgPCMVgKIi5s9NEcXBt2duC3mef6nE0xpq8E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jshtxFd7wcM1fiCVpsSW2FYIYyyVZ05yJ+tPZB2R+4FGixLskh7q/u8XeYaxSAkB2dl5lgGikxGGpIUxGrQ5XEIOYbfsQ6JkqHWzq7p/OPCVp0jYMpYsb+Gu1ltW9HPiqA5qIDR+xKvIfrCdctiLbQoZWBPhCRGd/51YJt1f64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0xU7VKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA51C4CEF1;
	Tue, 16 Sep 2025 00:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982635;
	bh=5WvmibCCgPCMVgKIi5s9NEcXBt2duC3mef6nE0xpq8E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Y0xU7VKu454xMK6NkyoO0CDFpbsVtz98bVDO/1Iy1O8+WF8Zmhj93c80M30oPHgGz
	 brnd/tgPCB/S79bCTRGi34mCQTs4Ls1JCjWFGzDZmcBhnzMJvNy7aVPpPLpkgApgVh
	 dU9JKbIXWPU9pYLwygjNlWoswWZW3RWrx0aOTkDd0xDowJ0Lg19tOv5ItCVki2LbAa
	 rZdPEBNk0fd2+vnoxzI2wYMGF2alP3N0OiifQ1fAd0+0e12GK6riLbQTwAXsLiGmrK
	 R/3+1MQo+yhMo9sQi7bwdbTuMF3dkt8Qt+XF+/unTXlzb2Avxs9X+VVXlgmL8pDnZ9
	 PDma40tPHaqzQ==
Date: Mon, 15 Sep 2025 17:30:34 -0700
Subject: [PATCH 10/28] fuse: implement basic iomap reporting such as FIEMAP
 and SEEK_{DATA,HOLE}
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151481.382724.13770799322378262701.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
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
index 791e868e568cc5..ea879b45e904c5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1727,6 +1727,11 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
 
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
@@ -1735,6 +1740,9 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
 # define fuse_iomap_init_inode(...)		((void)0)
 # define fuse_iomap_evict_inode(...)		((void)0)
 # define fuse_inode_has_iomap(...)		(false)
+# define fuse_iomap_fiemap			NULL
+# define fuse_iomap_lseek(...)			(-ENOSYS)
+# define fuse_iomap_bmap(...)			(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 6dbce975dc96b7..467ea2f46798ba 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2303,6 +2303,7 @@ static const struct inode_operations fuse_common_inode_operations = {
 	.set_acl	= fuse_set_acl,
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
+	.fiemap		= fuse_iomap_fiemap,
 };
 
 static const struct inode_operations fuse_symlink_inode_operations = {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0f253837b57fdc..1941dd7846f12a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2522,6 +2522,12 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
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
 
@@ -2557,6 +2563,13 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
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
index 0759704847598b..29603eec939589 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -4,6 +4,7 @@
  * Author: Darrick J. Wong <djwong@kernel.org>
  */
 #include <linux/iomap.h>
+#include <linux/fiemap.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "iomap_priv.h"
@@ -561,7 +562,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 	return err;
 }
 
-const struct iomap_ops fuse_iomap_ops = {
+static const struct iomap_ops fuse_iomap_ops = {
 	.iomap_begin		= fuse_iomap_begin,
 	.iomap_end		= fuse_iomap_end,
 };
@@ -669,3 +670,68 @@ void fuse_iomap_evict_inode(struct inode *inode)
 	if (fuse_inode_has_iomap(inode))
 		fuse_inode_clear_iomap(inode);
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


