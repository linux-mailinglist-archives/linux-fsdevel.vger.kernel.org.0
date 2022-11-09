Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BED6623234
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 19:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiKISQq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 13:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiKISQn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:16:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B37275DB;
        Wed,  9 Nov 2022 10:16:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E557E61C30;
        Wed,  9 Nov 2022 18:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F92C433D7;
        Wed,  9 Nov 2022 18:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668017801;
        bh=S356Z2JiSmCen6MadICxE8GLft0eSgB0DSN6jTfpxJ0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jcZpJJKnlwqvesQfbctG4c/FtbfiddyKBtzYt5+zuGP7rmI3CnyaTcdAB2ePZEM9p
         VieB7+q9oGB7W2p8hSo1xMrGv44SyxRt/r7xiLPny7KQRq0MUhnMWZa2VM4NRQFDXz
         U33N0bhNdcAsa8rELbbEvIp/6/814RcUe2am0cpcDpDPJjriYOoXKTuyHBpGbQfRYY
         uWo+fNsmbaHgkNSSQmz4gV8dA3hnUn1+LDxHaymS5Lep1oj0trDnb0HQfFWsROTmsC
         mdbADGN3cAUno0uMrlxJd6Q6SjlW51SHmMgtHbF/dsXPtDGyQHz+Z1600J55NDk26V
         2Mcz4cv3bt/ew==
Subject: [PATCH 10/14] iomap: pass a private pointer to
 iomap_file_buffered_write
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org
Date:   Wed, 09 Nov 2022 10:16:40 -0800
Message-ID: <166801780087.3992140.16981045908489138660.stgit@magnolia>
In-Reply-To: <166801774453.3992140.241667783932550826.stgit@magnolia>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Allow filesystems to pass a filesystem-private pointer into iomap for
writes into the pagecache.  This will now be accessible from
->iomap_begin implementations, which is key to being able to revalidate
mappings after taking folio locks.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/gfs2/bmap.c         |    3 ++-
 fs/gfs2/file.c         |    2 +-
 fs/iomap/buffered-io.c |   14 +++++++++-----
 fs/xfs/xfs_file.c      |    2 +-
 fs/xfs/xfs_iomap.c     |    4 ++--
 fs/xfs/xfs_reflink.c   |    2 +-
 fs/zonefs/super.c      |    3 ++-
 include/linux/iomap.h  |    8 ++++----
 8 files changed, 22 insertions(+), 16 deletions(-)


diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index f215c0735fa6..da5ccd25080b 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1295,7 +1295,8 @@ static int gfs2_block_zero_range(struct inode *inode, loff_t from,
 				 unsigned int length)
 {
 	BUG_ON(current->journal_info);
-	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops);
+	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops,
+			NULL);
 }
 
 #define GFS2_JTRUNC_REVOKES 8192
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 60c6fb91fb58..1e7dc0abe119 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1042,7 +1042,7 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 
 	current->backing_dev_info = inode_to_bdi(inode);
 	pagefault_disable();
-	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
+	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops, NULL);
 	pagefault_enable();
 	current->backing_dev_info = NULL;
 	if (ret > 0) {
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d3c565aa29f8..779244960153 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -836,13 +836,14 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 
 ssize_t
 iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
-		const struct iomap_ops *ops)
+		const struct iomap_ops *ops, void *private)
 {
 	struct iomap_iter iter = {
 		.inode		= iocb->ki_filp->f_mapping->host,
 		.pos		= iocb->ki_pos,
 		.len		= iov_iter_count(i),
 		.flags		= IOMAP_WRITE,
+		.private	= private,
 	};
 	int ret;
 
@@ -903,13 +904,14 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter,
 
 int
 iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
-		const struct iomap_ops *ops)
+		const struct iomap_ops *ops, void *private)
 {
 	struct iomap_iter iter = {
 		.inode		= inode,
 		.pos		= pos,
 		.len		= len,
 		.flags		= IOMAP_WRITE | IOMAP_UNSHARE,
+		.private	= private,
 	};
 	int ret;
 
@@ -966,13 +968,14 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter,
 
 int
 iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
-		const struct iomap_ops *ops)
+		const struct iomap_ops *ops, void *private)
 {
 	struct iomap_iter iter = {
 		.inode		= inode,
 		.pos		= pos,
 		.len		= len,
 		.flags		= IOMAP_ZERO,
+		.private	= private,
 	};
 	int ret;
 
@@ -984,7 +987,7 @@ EXPORT_SYMBOL_GPL(iomap_zero_range);
 
 int
 iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops)
+		const struct iomap_ops *ops, void *private)
 {
 	unsigned int blocksize = i_blocksize(inode);
 	unsigned int off = pos & (blocksize - 1);
@@ -992,7 +995,8 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 	/* Block boundary? Nothing to do */
 	if (!off)
 		return 0;
-	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops);
+	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops,
+			private);
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 595a5bcf46b9..f3671e22ba16 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -722,7 +722,7 @@ xfs_file_buffered_write(
 
 	trace_xfs_file_buffered_write(iocb, from);
 	ret = iomap_file_buffered_write(iocb, from,
-			&xfs_buffered_write_iomap_ops);
+			&xfs_buffered_write_iomap_ops, NULL);
 	if (likely(ret >= 0))
 		iocb->ki_pos += ret;
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 668f66ca84e4..00a4b60c97e9 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1559,7 +1559,7 @@ xfs_zero_range(
 		return dax_zero_range(inode, pos, len, did_zero,
 				      &xfs_direct_write_iomap_ops);
 	return iomap_zero_range(inode, pos, len, did_zero,
-				&xfs_buffered_write_iomap_ops);
+				&xfs_buffered_write_iomap_ops, NULL);
 }
 
 int
@@ -1574,5 +1574,5 @@ xfs_truncate_page(
 		return dax_truncate_page(inode, pos, did_zero,
 					&xfs_direct_write_iomap_ops);
 	return iomap_truncate_page(inode, pos, did_zero,
-				   &xfs_buffered_write_iomap_ops);
+				   &xfs_buffered_write_iomap_ops, NULL);
 }
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 93bdd25680bc..31b7b6e5db45 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1694,7 +1694,7 @@ xfs_reflink_unshare(
 	inode_dio_wait(inode);
 
 	error = iomap_file_unshare(inode, offset, len,
-			&xfs_buffered_write_iomap_ops);
+			&xfs_buffered_write_iomap_ops, NULL);
 	if (error)
 		goto out;
 
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 9a8e261ece8b..f4a9f21545bd 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -983,7 +983,8 @@ static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
 	if (ret <= 0)
 		goto inode_unlock;
 
-	ret = iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops);
+	ret = iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops,
+			NULL);
 	if (ret > 0)
 		iocb->ki_pos += ret;
 	else if (ret == -EIO)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 7485a5a3af17..152353164a5a 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -243,18 +243,18 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
 }
 
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
-		const struct iomap_ops *ops);
+		const struct iomap_ops *ops, void *private);
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
-		const struct iomap_ops *ops);
+		const struct iomap_ops *ops, void *private);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
-		bool *did_zero, const struct iomap_ops *ops);
+		bool *did_zero, const struct iomap_ops *ops, void *private);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops);
+		const struct iomap_ops *ops, void *private);
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
 			const struct iomap_ops *ops);
 int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,

