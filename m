Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4781BAC4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 20:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgD0SUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 14:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726519AbgD0SUU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:20:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121F6C0610D5;
        Mon, 27 Apr 2020 11:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BAwGcfyQUZyMuzSXafKB4zEI5LyxoVtR82wyCRaVxTI=; b=McvteMVKKdwTDIWm44lGmfWrOm
        1ra0CMszVR0faUND8ltuM0Ya1fyHLzCkFVMqG8ApY4X+d9EexKT79ChHWmgsTVIJ8GZidxK3i775f
        93prWNfli2PxXB7MLz/9+ira1S0C+Lhdk8YVWcx1JRBijrQ3TzVjaTxZsFo09j2k3FAVHiEn4Imd/
        hxifnVRjnvPsJNrxVE5gmCD1vx7Q37rL/ArknUjIdvOehItJezCpnLceRjSBjlKoROQ9QZ/fWYQ7r
        gloug9M/ak8tRPKN3ras6gVaHFyExHJO5hFKaaYclc24QeWc0OFiDx/dR3iDR7ChTCBxmQ9yUoCZa
        e1opVn3Q==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT8Mc-0004a1-HZ; Mon, 27 Apr 2020 18:20:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 08/11] fs: move fiemap range validation into the file systems instances
Date:   Mon, 27 Apr 2020 20:19:54 +0200
Message-Id: <20200427181957.1606257-9-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200427181957.1606257-1-hch@lst.de>
References: <20200427181957.1606257-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace fiemap_check_flags with a fiemap_validate helpers that also takes
the inode and mapped range, and performs the sanity check and truncation
previously done in fiemap_check_range.  This way the validation is inside
the file system itself and thus properly works for the stacked overlayfs
case as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/fiemap.txt |  8 ++---
 fs/btrfs/inode.c                     |  2 +-
 fs/cifs/smb2ops.c                    |  6 ++--
 fs/ext4/extents.c                    |  5 +--
 fs/f2fs/data.c                       |  3 +-
 fs/ioctl.c                           | 53 +++++++++++-----------------
 fs/iomap/fiemap.c                    |  2 +-
 fs/nilfs2/inode.c                    |  2 +-
 fs/ocfs2/extent_map.c                |  3 +-
 include/linux/fiemap.h               |  3 +-
 10 files changed, 40 insertions(+), 47 deletions(-)

diff --git a/Documentation/filesystems/fiemap.txt b/Documentation/filesystems/fiemap.txt
index ac87e6fda842b..05926b7f92809 100644
--- a/Documentation/filesystems/fiemap.txt
+++ b/Documentation/filesystems/fiemap.txt
@@ -203,15 +203,13 @@ EINTR once fatal signal received.
 
 
 Flag checking should be done at the beginning of the ->fiemap callback via the
-fiemap_check_flags() helper:
-
-int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
+fiemap_prep() helper.
 
 The struct fieinfo should be passed in as received from ioctl_fiemap(). The
 set of fiemap flags which the fs understands should be passed via fs_flags. If
-fiemap_check_flags finds invalid user flags, it will place the bad values in
+fiemap_prep finds invalid user flags, it will place the bad values in
 fieinfo->fi_flags and return -EBADR. If the file system gets -EBADR, from
-fiemap_check_flags(), it should immediately exit, returning that error back to
+fiemap_prep(), it should immediately exit, returning that error back to
 ioctl_fiemap().
 
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 320d1062068d3..1f1ec361089b3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8250,7 +8250,7 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 {
 	int	ret;
 
-	ret = fiemap_check_flags(fieinfo, BTRFS_FIEMAP_FLAGS);
+	ret = fiemap_prep(inode, fieinfo, start, &len, BTRFS_FIEMAP_FLAGS);
 	if (ret)
 		return ret;
 
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 09047f1ddfb66..8a2e94931dc96 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3408,8 +3408,10 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
 	int i, num, rc, flags, last_blob;
 	u64 next;
 
-	if (fiemap_check_flags(fei, FIEMAP_FLAG_SYNC))
-		return -EBADR;
+	rc = fiemap_prep(cfile->dentry->d_inode, fei, start, &len,
+			FIEMAP_FLAG_SYNC);
+	if (rc)
+		rc;
 
 	xid = get_xid();
  again:
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a41ae7c510170..41f73dea92cac 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4908,8 +4908,9 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
 	}
 
-	if (fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC))
-		return -EBADR;
+	error = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
+	if (error)
+		return error;
 
 	error = ext4_fiemap_check_ranges(inode, start, &len);
 	if (error)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 25abbbb65ba09..03faafc591b17 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1825,7 +1825,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			return ret;
 	}
 
-	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
+	ret = fiemap_prep(inode, fieinfo, start, &len,
+			FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
 	if (ret)
 		return ret;
 
diff --git a/fs/ioctl.c b/fs/ioctl.c
index cbc84e23d00bd..4d94c20c9596b 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -141,9 +141,12 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 EXPORT_SYMBOL(fiemap_fill_next_extent);
 
 /**
- * fiemap_check_flags - check validity of requested flags for fiemap
+ * fiemap_prep - check validity of requested flags for fiemap
+ * @inode:	Inode to operate on
  * @fieinfo:	Fiemap context passed into ->fiemap
- * @fs_flags:	Set of fiemap flags that the file system understands
+ * @start:	Start of the mapped range
+ * @len:	Length of the mapped range, can be truncated by this function.
+ * @supported_flags:	Set of fiemap flags that the file system understands
  *
  * Called from file system ->fiemap callback. This will compute the
  * intersection of valid fiemap flags and those that the fs supports. That
@@ -154,48 +157,38 @@ EXPORT_SYMBOL(fiemap_fill_next_extent);
  *
  * Returns 0 on success, -EBADR on bad flags.
  */
-int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags)
+int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		u64 start, u64 *len, u32 supported_flags)
 {
+	u64 maxbytes = inode->i_sb->s_maxbytes;
 	u32 incompat_flags;
 
-	incompat_flags = fieinfo->fi_flags & ~(FIEMAP_FLAGS_COMPAT & fs_flags);
-	if (incompat_flags) {
-		fieinfo->fi_flags = incompat_flags;
-		return -EBADR;
-	}
-	return 0;
-}
-EXPORT_SYMBOL(fiemap_check_flags);
-
-static int fiemap_check_ranges(struct super_block *sb,
-			       u64 start, u64 len, u64 *new_len)
-{
-	u64 maxbytes = (u64) sb->s_maxbytes;
-
-	*new_len = len;
-
-	if (len == 0)
+	if (*len == 0)
 		return -EINVAL;
-
 	if (start > maxbytes)
 		return -EFBIG;
 
 	/*
 	 * Shrink request scope to what the fs can actually handle.
 	 */
-	if (len > maxbytes || (maxbytes - len) < start)
-		*new_len = maxbytes - start;
+	if (*len > maxbytes || (maxbytes - *len) < start)
+		*len = maxbytes - start;
 
+	supported_flags &= FIEMAP_FLAGS_COMPAT;
+	incompat_flags = fieinfo->fi_flags & ~supported_flags;
+	if (incompat_flags) {
+		fieinfo->fi_flags = incompat_flags;
+		return -EBADR;
+	}
 	return 0;
 }
+EXPORT_SYMBOL(fiemap_prep);
 
 static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
 {
 	struct fiemap fiemap;
 	struct fiemap_extent_info fieinfo = { 0, };
 	struct inode *inode = file_inode(filp);
-	struct super_block *sb = inode->i_sb;
-	u64 len;
 	int error;
 
 	if (!inode->i_op->fiemap)
@@ -207,11 +200,6 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
 	if (fiemap.fm_extent_count > FIEMAP_MAX_EXTENTS)
 		return -EINVAL;
 
-	error = fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
-				    &len);
-	if (error)
-		return error;
-
 	fieinfo.fi_flags = fiemap.fm_flags;
 	fieinfo.fi_extents_max = fiemap.fm_extent_count;
 	fieinfo.fi_extents_start = ufiemap->fm_extents;
@@ -224,7 +212,8 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
 	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
 		filemap_write_and_wait(inode->i_mapping);
 
-	error = inode->i_op->fiemap(inode, &fieinfo, fiemap.fm_start, len);
+	error = inode->i_op->fiemap(inode, &fieinfo, fiemap.fm_start,
+			fiemap.fm_length);
 	fiemap.fm_flags = fieinfo.fi_flags;
 	fiemap.fm_mapped_extents = fieinfo.fi_extents_mapped;
 	if (copy_to_user(ufiemap, &fiemap, sizeof(fiemap)))
@@ -312,7 +301,7 @@ static int __generic_block_fiemap(struct inode *inode,
 	bool past_eof = false, whole_file = false;
 	int ret = 0;
 
-	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC);
+	ret = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
 	if (ret)
 		return ret;
 
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index dd04e4added15..5e4e3520424da 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -75,7 +75,7 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
 	ctx.fi = fi;
 	ctx.prev.type = IOMAP_HOLE;
 
-	ret = fiemap_check_flags(fi, FIEMAP_FLAG_SYNC);
+	ret = fiemap_prep(inode, fi, start, &len, FIEMAP_FLAG_SYNC);
 	if (ret)
 		return ret;
 
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 6e1aca38931f3..052c2da11e4d7 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1006,7 +1006,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	unsigned int blkbits = inode->i_blkbits;
 	int ret, n;
 
-	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC);
+	ret = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
 	if (ret)
 		return ret;
 
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index e3e2d1b2af51a..3744179b73fa1 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -746,7 +746,8 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	struct buffer_head *di_bh = NULL;
 	struct ocfs2_extent_rec rec;
 
-	ret = fiemap_check_flags(fieinfo, OCFS2_FIEMAP_FLAGS);
+	ret = fiemap_prep(inode, fieinfo, map_start, &map_len,
+			OCFS2_FIEMAP_FLAGS);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/fiemap.h b/include/linux/fiemap.h
index 240d4f7d9116a..4e624c4665837 100644
--- a/include/linux/fiemap.h
+++ b/include/linux/fiemap.h
@@ -13,9 +13,10 @@ struct fiemap_extent_info {
 							fiemap_extent array */
 };
 
+int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		u64 start, u64 *len, u32 supported_flags);
 int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
 			    u64 phys, u64 len, u32 flags);
-int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
 
 int generic_block_fiemap(struct inode *inode,
 		struct fiemap_extent_info *fieinfo, u64 start, u64 len,
-- 
2.26.1

