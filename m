Return-Path: <linux-fsdevel+bounces-37844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56C69F827B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A204E18997B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32551A9B49;
	Thu, 19 Dec 2024 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UflYTk+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B401A0B0D;
	Thu, 19 Dec 2024 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630005; cv=none; b=d5m4bkQ0A69ry4NR9cz/CpvzviifqV4mfWMN6GZlf8adHfxDI+xI1MNugjuNSEOyDVmeIadBnT0A7q0KthxUBCQLfFZz6T+Nygx7iDLRo8To4oJ6xf/nz38u+7wpQqtkfzRqrXejkKRo5T/rpt/9cdBtXEZDYz7Z5j740pbAOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630005; c=relaxed/simple;
	bh=nKL2LXtZ4EhXO1Xqu7iG/f2+/Zy7E3JCJLTixHZjSpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBDfYX5zfr2kOnbrfHTbAxLfslCbD0985hCX2rXcdW0AMoZeIrxb01ozaydxT+zaFXsj1S25U9n/Ctye/BmPNthdgmPFBKP+tX2dbLGyqS9ocpjYMUzBubjuvy81f5EfS39bGkd3kp2zfyj2c1Ua/mXND+dMqfC6D1HN69g+feE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UflYTk+B; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=svAY679EBY83UptYegZRPqJlpSpCcuguGu7w2Z2waLc=; b=UflYTk+BSgtE8bRfJYY7ZOzrZr
	oue0ej50rgBUHsqz9d8V/2Ip+wQ0dKSTJZP7YWMKbvBiYGtioxGtM1zV849ZmVV2OHRP4+f3aG0Nq
	A5mt+dvOmfzZMShXHtJADY8rv7206aSP2Vq9AnlqHcKErGq1oO+YhXsQ0eBHK+ldce3134DnGTc0I
	MlwADV6Z/+8JuzpN/+TdjL3k384hOVtqMY+LAHfRZ8f2lg2pfJzkkJiZ1LtRRxY8UHjgUNrjCO251
	cBxj7uY41xWE9Oq1IYikihSc40Uo2E85urMykHhJh1Jd6O1rrSHzVXPWNN8G5X19EZ5gmnIH3z0ow
	g1lmMqFA==;
Received: from [2001:4bb8:2ae:97bf:7b0d:9cbd:e369:c821] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOKVG-00000002aup-2Of3;
	Thu, 19 Dec 2024 17:40:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/10] iomap: allow the file system to submit the writeback bios
Date: Thu, 19 Dec 2024 17:39:06 +0000
Message-ID: <20241219173954.22546-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241219173954.22546-1-hch@lst.de>
References: <20241219173954.22546-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Change ->prepare_ioend to ->submit_ioend and require file systems that
implement it to submit the bio.  This is needed for file systems that
do their own work on the bios before submitting them to the block layer
like btrfs or zoned xfs.  To make this easier also pass the writeback
context to the method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/iomap/operations.rst | 11 +++++------
 fs/iomap/buffered-io.c                         | 10 +++++-----
 fs/xfs/xfs_aops.c                              | 13 +++++++++----
 include/linux/iomap.h                          | 12 +++++++-----
 4 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index ef082e5a4e0c..7ef39b13e65c 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -283,7 +283,7 @@ The ``ops`` structure must be specified and is as follows:
  struct iomap_writeback_ops {
      int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
                        loff_t offset, unsigned len);
-     int (*prepare_ioend)(struct iomap_ioend *ioend, int status);
+     int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
      void (*discard_folio)(struct folio *folio, loff_t pos);
  };
 
@@ -306,13 +306,12 @@ The fields are as follows:
     purpose.
     This function must be supplied by the filesystem.
 
-  - ``prepare_ioend``: Enables filesystems to transform the writeback
-    ioend or perform any other preparatory work before the writeback I/O
-    is submitted.
+  - ``submit_ioend``: Allows the file systems to hook into writeback bio
+    submission.
     This might include pre-write space accounting updates, or installing
     a custom ``->bi_end_io`` function for internal purposes, such as
     deferring the ioend completion to a workqueue to run metadata update
-    transactions from process context.
+    transactions from process context before submitting the bio.
     This function is optional.
 
   - ``discard_folio``: iomap calls this function after ``->map_blocks``
@@ -341,7 +340,7 @@ This can happen in interrupt or process context, depending on the
 storage device.
 
 Filesystems that need to update internal bookkeeping (e.g. unwritten
-extent conversions) should provide a ``->prepare_ioend`` function to
+extent conversions) should provide a ``->submit_ioend`` function to
 set ``struct iomap_end::bio::bi_end_io`` to its own function.
 This function should call ``iomap_finish_ioends`` after finishing its
 own work (e.g. unwritten extent conversion).
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 955f19e27e47..cdccf11bb3be 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1675,7 +1675,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
 }
 
 /*
- * Submit the final bio for an ioend.
+ * Submit an ioend.
  *
  * If @error is non-zero, it means that we have a situation where some part of
  * the submission process has failed after we've marked pages for writeback.
@@ -1694,14 +1694,14 @@ static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 	 * failure happened so that the file system end I/O handler gets called
 	 * to clean up.
 	 */
-	if (wpc->ops->prepare_ioend)
-		error = wpc->ops->prepare_ioend(wpc->ioend, error);
+	if (wpc->ops->submit_ioend)
+		error = wpc->ops->submit_ioend(wpc, error);
+	else if (!error)
+		submit_bio(&wpc->ioend->io_bio);
 
 	if (error) {
 		wpc->ioend->io_bio.bi_status = errno_to_blk_status(error);
 		bio_endio(&wpc->ioend->io_bio);
-	} else {
-		submit_bio(&wpc->ioend->io_bio);
 	}
 
 	wpc->ioend = NULL;
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 559a3a577097..d175853da5ae 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -395,10 +395,11 @@ xfs_map_blocks(
 }
 
 static int
-xfs_prepare_ioend(
-	struct iomap_ioend	*ioend,
+xfs_submit_ioend(
+	struct iomap_writepage_ctx *wpc,
 	int			status)
 {
+	struct iomap_ioend	*ioend = wpc->ioend;
 	unsigned int		nofs_flag;
 
 	/*
@@ -420,7 +421,11 @@ xfs_prepare_ioend(
 	if (xfs_ioend_is_append(ioend) || ioend->io_type == IOMAP_UNWRITTEN ||
 	    (ioend->io_flags & IOMAP_F_SHARED))
 		ioend->io_bio.bi_end_io = xfs_end_bio;
-	return status;
+
+	if (status)
+		return status;
+	submit_bio(&ioend->io_bio);
+	return 0;
 }
 
 /*
@@ -462,7 +467,7 @@ xfs_discard_folio(
 
 static const struct iomap_writeback_ops xfs_writeback_ops = {
 	.map_blocks		= xfs_map_blocks,
-	.prepare_ioend		= xfs_prepare_ioend,
+	.submit_ioend		= xfs_submit_ioend,
 	.discard_folio		= xfs_discard_folio,
 };
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5675af6b740c..c0339678d798 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -362,12 +362,14 @@ struct iomap_writeback_ops {
 			  loff_t offset, unsigned len);
 
 	/*
-	 * Optional, allows the file systems to perform actions just before
-	 * submitting the bio and/or override the bio end_io handler for complex
-	 * operations like copy on write extent manipulation or unwritten extent
-	 * conversions.
+	 * Optional, allows the file systems to hook into bio submission,
+	 * including overriding the bi_end_io handler.
+	 *
+	 * Returns 0 if the bio was successfully submitted, or a negative
+	 * error code if status was non-zero or another error happened and
+	 * the bio could not be submitted.
 	 */
-	int (*prepare_ioend)(struct iomap_ioend *ioend, int status);
+	int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
 
 	/*
 	 * Optional, allows the file system to discard state on a page where
-- 
2.45.2


