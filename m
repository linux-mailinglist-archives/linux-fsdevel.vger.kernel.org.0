Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCFD1BA08B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 11:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD0J7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 05:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726243AbgD0J7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:59:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A7BC0610D5;
        Mon, 27 Apr 2020 02:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=14Ywug4UU4xAaFTeHUAnnbpAB8PBwYfeGeoa3aNof3g=; b=BouOAiidRdOGtJQ6QmaNIVVdqS
        MJKALesuIog2Xw53q20G3ZL3cALNAsnVHwQEZwosEW4nSrmfOU3cKAHgY424Of3g1JykfvyzGpuuc
        /RBilxIWMKyah0AH7eIKVvR2C3Mz9gnROcIYz7YIQwtZaF+8VMy+17lUiZYpCmOwZ5MKLmWQV+1R5
        +bTavTFw3MleNGLKVlksgVx5M1yirwOeLqC9Me0Pxek6X7u1y6R7P36RGYAZfBUfiVPcQPvly+g1I
        Qd7KCOKQwlg3hi6ibXu4Sgvs9sk6n61Vem1j2cFunqRlH6Ws2tiupiUiWBBF2iXQjFZ3BndXeZw8Q
        WnTU6cmg==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT0XZ-0003fS-Ku; Mon, 27 Apr 2020 09:59:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 2/8] ext4: fix fiemap size checks for bitmap files
Date:   Mon, 27 Apr 2020 11:58:52 +0200
Message-Id: <20200427095858.1440608-3-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200427095858.1440608-1-hch@lst.de>
References: <20200427095858.1440608-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an extra validation of the len parameter, as for ext4 some files
might have smaller file size limits than others.  This also means the
redundant size check in ext4_ioctl_get_es_cache can go away, as all
size checking is done in the shared fiemap handler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/extents.c | 31 +++++++++++++++++++++++++++++++
 fs/ext4/ioctl.c   | 33 ++-------------------------------
 2 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f2b577b315a09..2b4b94542e34d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4832,6 +4832,28 @@ static const struct iomap_ops ext4_iomap_xattr_ops = {
 	.iomap_begin		= ext4_iomap_xattr_begin,
 };
 
+static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
+{
+	u64 maxbytes;
+
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		maxbytes = inode->i_sb->s_maxbytes;
+	else
+		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
+
+	if (*len == 0)
+		return -EINVAL;
+	if (start > maxbytes)
+		return -EFBIG;
+
+	/*
+	 * Shrink request scope to what the fs can actually handle.
+	 */
+	if (*len > maxbytes || (maxbytes - *len) < start)
+		*len = maxbytes - start;
+	return 0;
+}
+
 static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			__u64 start, __u64 len, bool from_es_cache)
 {
@@ -4852,6 +4874,15 @@ static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (fiemap_check_flags(fieinfo, ext4_fiemap_flags))
 		return -EBADR;
 
+	/*
+	 * For bitmap files the maximum size limit could be smaller than
+	 * s_maxbytes, so check len here manually instead of just relying on the
+	 * generic check.
+	 */
+	error = ext4_fiemap_check_ranges(inode, start, &len);
+	if (error)
+		return error;
+
 	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
 		error = iomap_fiemap(inode, fieinfo, start, len,
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index bfc1281fc4cbc..0746532ba463d 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -733,29 +733,6 @@ static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 }
 
-/* copied from fs/ioctl.c */
-static int fiemap_check_ranges(struct super_block *sb,
-			       u64 start, u64 len, u64 *new_len)
-{
-	u64 maxbytes = (u64) sb->s_maxbytes;
-
-	*new_len = len;
-
-	if (len == 0)
-		return -EINVAL;
-
-	if (start > maxbytes)
-		return -EFBIG;
-
-	/*
-	 * Shrink request scope to what the fs can actually handle.
-	 */
-	if (len > maxbytes || (maxbytes - len) < start)
-		*new_len = maxbytes - start;
-
-	return 0;
-}
-
 /* So that the fiemap access checks can't overflow on 32 bit machines. */
 #define FIEMAP_MAX_EXTENTS	(UINT_MAX / sizeof(struct fiemap_extent))
 
@@ -765,8 +742,6 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	struct fiemap __user *ufiemap = (struct fiemap __user *) arg;
 	struct fiemap_extent_info fieinfo = { 0, };
 	struct inode *inode = file_inode(filp);
-	struct super_block *sb = inode->i_sb;
-	u64 len;
 	int error;
 
 	if (copy_from_user(&fiemap, ufiemap, sizeof(fiemap)))
@@ -775,11 +750,6 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
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
@@ -792,7 +762,8 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
 		filemap_write_and_wait(inode->i_mapping);
 
-	error = ext4_get_es_cache(inode, &fieinfo, fiemap.fm_start, len);
+	error = ext4_get_es_cache(inode, &fieinfo, fiemap.fm_start,
+			fiemap.fm_length);
 	fiemap.fm_flags = fieinfo.fi_flags;
 	fiemap.fm_mapped_extents = fieinfo.fi_extents_mapped;
 	if (copy_to_user(ufiemap, &fiemap, sizeof(fiemap)))
-- 
2.26.1

