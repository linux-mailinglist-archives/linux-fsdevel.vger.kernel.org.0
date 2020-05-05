Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068551C5C05
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgEEPny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 11:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730577AbgEEPnx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 11:43:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5C2C061A0F;
        Tue,  5 May 2020 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bFhAN6JGDGHbnxbSRj5IjDsoHYOTgsMPsWxxLlLQO0w=; b=gtlEkEz8tUwonx6agLk2eKF9eE
        /c65Zj0OkIAKHmnOS/n/hTFA1XUmvglE+Jv9SiyzODq7ADycWAlogIUs46ABtY2tTrzK9SvlJ7Y1s
        mw8VgaOQ+xRoklVZvsVK+HHcK6ohwvj0jeUIbHPcvB2dJB11MpN3bSVsL1PODdZJFrdJ7W1f9kL9S
        3CYdQu/9yFwgbJulCsGeVgAoWIhq9T6OlNf2Qx0qcsv9NStn3Mzb/pfSxcPzw+Ku2icUfC+Qb6dhh
        kgVFgwSnHXDRnxZGixsoLCa2M+FQAIEI5vFuTHwNFFktjT4GYcNOepIRB1hgjSd9ixi/sf6PNa1ga
        aCv0d49g==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVzjc-00044d-Oe; Tue, 05 May 2020 15:43:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 09/11] fs: handle FIEMAP_FLAG_SYNC in fiemap_prep
Date:   Tue,  5 May 2020 17:43:22 +0200
Message-Id: <20200505154324.3226743-10-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505154324.3226743-1-hch@lst.de>
References: <20200505154324.3226743-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By moving FIEMAP_FLAG_SYNC handling to fiemap_prep we ensure it is
handled once instead of duplicated, but can still be done under fs locks,
like xfs/iomap intended with its duplicate handling.  Also make sure the
error value of filemap_write_and_wait is propagated to user space.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/btrfs/inode.c      |  4 +---
 fs/cifs/smb2ops.c     |  3 +--
 fs/ext4/extents.c     |  2 +-
 fs/ext4/ioctl.c       |  3 ---
 fs/f2fs/data.c        |  3 +--
 fs/ioctl.c            | 10 ++++++----
 fs/iomap/fiemap.c     |  8 +-------
 fs/nilfs2/inode.c     |  2 +-
 fs/ocfs2/extent_map.c |  5 +----
 fs/overlayfs/inode.c  |  4 ----
 10 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1f1ec361089b3..529ffa5e7b452 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8243,14 +8243,12 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
-#define BTRFS_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC)
-
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len)
 {
 	int	ret;
 
-	ret = fiemap_prep(inode, fieinfo, start, &len, BTRFS_FIEMAP_FLAGS);
+	ret = fiemap_prep(inode, fieinfo, start, &len, 0);
 	if (ret)
 		return ret;
 
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 828e53e795c6d..300ade2acc41e 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3408,8 +3408,7 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
 	int i, num, rc, flags, last_blob;
 	u64 next;
 
-	rc = fiemap_prep(d_inode(cfile->dentry), fei, start, &len,
-			FIEMAP_FLAG_SYNC);
+	rc = fiemap_prep(d_inode(cfile->dentry), fei, start, &len, 0);
 	if (rc)
 		return rc;
 
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 41f73dea92cac..93574e88f6543 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4908,7 +4908,7 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
 	}
 
-	error = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
+	error = fiemap_prep(inode, fieinfo, start, &len, 0);
 	if (error)
 		return error;
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 0746532ba463d..f81acbbb1b12e 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -759,9 +759,6 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
 		return -EFAULT;
 
-	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
-		filemap_write_and_wait(inode->i_mapping);
-
 	error = ext4_get_es_cache(inode, &fieinfo, fiemap.fm_start,
 			fiemap.fm_length);
 	fiemap.fm_flags = fieinfo.fi_flags;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 03faafc591b17..9de7dc476ed16 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1825,8 +1825,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			return ret;
 	}
 
-	ret = fiemap_prep(inode, fieinfo, start, &len,
-			FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
+	ret = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_XATTR);
 	if (ret)
 		return ret;
 
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 56bbf02209aef..b16e962340db6 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -166,6 +166,7 @@ int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
 {
 	u64 maxbytes = inode->i_sb->s_maxbytes;
 	u32 incompat_flags;
+	int ret = 0;
 
 	if (*len == 0)
 		return -EINVAL;
@@ -178,13 +179,17 @@ int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (*len > maxbytes || (maxbytes - *len) < start)
 		*len = maxbytes - start;
 
+	supported_flags |= FIEMAP_FLAG_SYNC;
 	supported_flags &= FIEMAP_FLAGS_COMPAT;
 	incompat_flags = fieinfo->fi_flags & ~supported_flags;
 	if (incompat_flags) {
 		fieinfo->fi_flags = incompat_flags;
 		return -EBADR;
 	}
-	return 0;
+
+	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC)
+		ret = filemap_write_and_wait(inode->i_mapping);
+	return ret;
 }
 EXPORT_SYMBOL(fiemap_prep);
 
@@ -213,9 +218,6 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
 		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
 		return -EFAULT;
 
-	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
-		filemap_write_and_wait(inode->i_mapping);
-
 	error = inode->i_op->fiemap(inode, &fieinfo, fiemap.fm_start,
 			fiemap.fm_length);
 	fiemap.fm_flags = fieinfo.fi_flags;
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index 89dca4a97e4a2..aab070df4a217 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -75,16 +75,10 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
 	ctx.fi = fi;
 	ctx.prev.type = IOMAP_HOLE;
 
-	ret = fiemap_prep(inode, fi, start, &len, FIEMAP_FLAG_SYNC);
+	ret = fiemap_prep(inode, fi, start, &len, 0);
 	if (ret)
 		return ret;
 
-	if (fi->fi_flags & FIEMAP_FLAG_SYNC) {
-		ret = filemap_write_and_wait(inode->i_mapping);
-		if (ret)
-			return ret;
-	}
-
 	while (len > 0) {
 		ret = iomap_apply(inode, start, len, IOMAP_REPORT, ops, &ctx,
 				iomap_fiemap_actor);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 052c2da11e4d7..25b0d368ecdb2 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1006,7 +1006,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	unsigned int blkbits = inode->i_blkbits;
 	int ret, n;
 
-	ret = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
+	ret = fiemap_prep(inode, fieinfo, start, &len, 0);
 	if (ret)
 		return ret;
 
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index 3744179b73fa1..a94852af5510d 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -733,8 +733,6 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
 	return 0;
 }
 
-#define OCFS2_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC)
-
 int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 map_start, u64 map_len)
 {
@@ -746,8 +744,7 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	struct buffer_head *di_bh = NULL;
 	struct ocfs2_extent_rec rec;
 
-	ret = fiemap_prep(inode, fieinfo, map_start, &map_len,
-			OCFS2_FIEMAP_FLAGS);
+	ret = fiemap_prep(inode, fieinfo, map_start, &map_len, 0);
 	if (ret)
 		return ret;
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index b5fec34105569..c7cb883c47b86 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -462,10 +462,6 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		return -EOPNOTSUPP;
 
 	old_cred = ovl_override_creds(inode->i_sb);
-
-	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC)
-		filemap_write_and_wait(realinode->i_mapping);
-
 	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
 	revert_creds(old_cred);
 
-- 
2.26.2

