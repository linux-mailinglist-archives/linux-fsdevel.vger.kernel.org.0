Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C97451CA47
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 22:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385734AbiEEUPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 16:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385705AbiEEUPE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 16:15:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CE95F8EA;
        Thu,  5 May 2022 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Me76yjQq3T1VS7so/j4YdFeOuO3BbSiZIVa7gQnyKLs=; b=0/ikGgOjESiwheZm4E1C9xdJf3
        BKKZUI5qHSZloHemx1/QE5JceoUVj5I6AHTCCH6333xYEd8dh4cpYMAdSDQ4ouq8uOSrHbRuQJX0+
        RGAKf+YEt5y0M//1Ev9NUncaGTSzDvvX7MksSlEMc2YuNzGzwqTGsFutJnWDMHvf4YVexgrA12aJV
        9TWgSN8LwcnXjpefkFzaC9RU92B0bDmwY4XYvUkK98u/9JS3sECOd4mQ582EbXawvZUZUcri6mRlF
        lTUgDaPcwMKD3dTkCNcNvCW82km1SPxL/SG6BV2hqG+uuWXTwsk3s4wpTVANDCnq6tfU+zK+97VLy
        YIbswo8A==;
Received: from 65-114-90-19.dia.static.qwest.net ([65.114.90.19] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmhom-0006ip-A1; Thu, 05 May 2022 20:11:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/7] iomap: add per-iomap_iter private data
Date:   Thu,  5 May 2022 15:11:11 -0500
Message-Id: <20220505201115.937837-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220505201115.937837-1-hch@lst.de>
References: <20220505201115.937837-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow the file system to keep state for all iterations.  For now only
wire it up for direct I/O as there is an immediate need for it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c      | 2 +-
 fs/erofs/data.c       | 2 +-
 fs/ext4/file.c        | 4 ++--
 fs/f2fs/file.c        | 4 ++--
 fs/gfs2/file.c        | 4 ++--
 fs/iomap/direct-io.c  | 8 +++++---
 fs/xfs/xfs_file.c     | 6 +++---
 fs/zonefs/super.c     | 4 ++--
 include/linux/iomap.h | 5 +++--
 9 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cdf96a2472821..88e617e9bf5df 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8168,7 +8168,7 @@ ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		size_t done_before)
 {
 	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			   IOMAP_DIO_PARTIAL, done_before);
+			   IOMAP_DIO_PARTIAL, NULL, done_before);
 }
 
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 780db1e5f4b72..91c11d5bb9990 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -385,7 +385,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		if (!err)
 			return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
-					    NULL, 0, 0);
+					    NULL, 0, NULL, 0);
 		if (err < 0)
 			return err;
 	}
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6feb07e3e1eb5..109d07629f81f 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -76,7 +76,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return generic_file_read_iter(iocb, to);
 	}
 
-	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0, 0);
+	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0, NULL, 0);
 	inode_unlock_shared(inode);
 
 	file_accessed(iocb->ki_filp);
@@ -565,7 +565,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		iomap_ops = &ext4_iomap_overwrite_ops;
 	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
 			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,
-			   0);
+			   NULL, 0);
 	if (ret == -ENOTBLK)
 		ret = 0;
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5b89af0f27f05..04bc8709314bf 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4309,7 +4309,7 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	 */
 	inc_page_count(sbi, F2FS_DIO_READ);
 	dio = __iomap_dio_rw(iocb, to, &f2fs_iomap_ops,
-			     &f2fs_iomap_dio_read_ops, 0, 0);
+			     &f2fs_iomap_dio_read_ops, 0, NULL, 0);
 	if (IS_ERR_OR_NULL(dio)) {
 		ret = PTR_ERR_OR_ZERO(dio);
 		if (ret != -EIOCBQUEUED)
@@ -4527,7 +4527,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	if (pos + count > inode->i_size)
 		dio_flags |= IOMAP_DIO_FORCE_WAIT;
 	dio = __iomap_dio_rw(iocb, from, &f2fs_iomap_ops,
-			     &f2fs_iomap_dio_write_ops, dio_flags, 0);
+			     &f2fs_iomap_dio_write_ops, dio_flags, NULL, 0);
 	if (IS_ERR_OR_NULL(dio)) {
 		ret = PTR_ERR_OR_ZERO(dio);
 		if (ret == -ENOTBLK)
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 48f01323c37c1..76307a90bf81f 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -839,7 +839,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 	pagefault_disable();
 	to->nofault = true;
 	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
-			   IOMAP_DIO_PARTIAL, written);
+			   IOMAP_DIO_PARTIAL, NULL, written);
 	to->nofault = false;
 	pagefault_enable();
 	if (ret > 0)
@@ -906,7 +906,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 
 	from->nofault = true;
 	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
-			   IOMAP_DIO_PARTIAL, read);
+			   IOMAP_DIO_PARTIAL, NULL, read);
 	from->nofault = false;
 
 	if (ret == -ENOTBLK)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 15929690d89e3..145b2668478d0 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -484,7 +484,7 @@ static loff_t iomap_dio_iter(const struct iomap_iter *iter,
 struct iomap_dio *
 __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		unsigned int dio_flags, size_t done_before)
+		unsigned int dio_flags, void *private, size_t done_before)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -493,6 +493,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		.pos		= iocb->ki_pos,
 		.len		= iov_iter_count(iter),
 		.flags		= IOMAP_DIRECT,
+		.private	= private,
 	};
 	loff_t end = iomi.pos + iomi.len - 1, ret = 0;
 	bool wait_for_completion =
@@ -684,11 +685,12 @@ EXPORT_SYMBOL_GPL(__iomap_dio_rw);
 ssize_t
 iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		unsigned int dio_flags, size_t done_before)
+		unsigned int dio_flags, void *private, size_t done_before)
 {
 	struct iomap_dio *dio;
 
-	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, done_before);
+	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, private,
+			     done_before);
 	if (IS_ERR_OR_NULL(dio))
 		return PTR_ERR_OR_ZERO(dio);
 	return iomap_dio_complete(dio);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5bddb1e9e0b3e..85c412107a100 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -225,7 +225,7 @@ xfs_file_dio_read(
 	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
 	if (ret)
 		return ret;
-	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0, 0);
+	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0, NULL, 0);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -534,7 +534,7 @@ xfs_file_dio_write_aligned(
 	}
 	trace_xfs_file_direct_write(iocb, from);
 	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
-			   &xfs_dio_write_ops, 0, 0);
+			   &xfs_dio_write_ops, 0, NULL, 0);
 out_unlock:
 	if (iolock)
 		xfs_iunlock(ip, iolock);
@@ -612,7 +612,7 @@ xfs_file_dio_write_unaligned(
 
 	trace_xfs_file_direct_write(iocb, from);
 	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
-			   &xfs_dio_write_ops, flags, 0);
+			   &xfs_dio_write_ops, flags, NULL, 0);
 
 	/*
 	 * Retry unaligned I/O with exclusive blocking semantics if the DIO
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index e20e7c8414896..777fe626c2b38 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -861,7 +861,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 		ret = zonefs_file_dio_append(iocb, from);
 	else
 		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
-				   &zonefs_write_dio_ops, 0, 0);
+				   &zonefs_write_dio_ops, 0, NULL, 0);
 	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
 	    (ret > 0 || ret == -EIOCBQUEUED)) {
 		if (ret > 0)
@@ -996,7 +996,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		}
 		file_accessed(iocb->ki_filp);
 		ret = iomap_dio_rw(iocb, to, &zonefs_iomap_ops,
-				   &zonefs_read_dio_ops, 0, 0);
+				   &zonefs_read_dio_ops, 0, NULL, 0);
 	} else {
 		ret = generic_file_read_iter(iocb, to);
 		if (ret == -EIO)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 526c9e7f2eaf8..ea72fa58c06c3 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -188,6 +188,7 @@ struct iomap_iter {
 	unsigned flags;
 	struct iomap iomap;
 	struct iomap srcmap;
+	void *private;
 };
 
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
@@ -354,10 +355,10 @@ struct iomap_dio_ops {
 
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		unsigned int dio_flags, size_t done_before);
+		unsigned int dio_flags, void *private, size_t done_before);
 struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		unsigned int dio_flags, size_t done_before);
+		unsigned int dio_flags, void *private, size_t done_before);
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
 void iomap_dio_bio_end_io(struct bio *bio);
 
-- 
2.30.2

