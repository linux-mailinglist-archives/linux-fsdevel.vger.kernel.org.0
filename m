Return-Path: <linux-fsdevel+bounces-41026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D561A2A10E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA24D18878B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7514C224AF5;
	Thu,  6 Feb 2025 06:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c54e/Nwx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308EB224AEA;
	Thu,  6 Feb 2025 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824042; cv=none; b=M7SK++SO8FzBVZE3mgu+K9boo37OKt/ajqssMG9jJYBfAsIfCEvGV8DmiEzZrmW/uRpq16QzyK7N6CK06H786U0QTQM4sb6Qy3EzP076elYx1vBPAUzKRuKDOb5ryaKy4o8cFdm18gKEJe7d5M7RJjbqTIvUE+aYPIcjU0XzB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824042; c=relaxed/simple;
	bh=qPoP1anHAHxYxhZ5cSvI37/X1OooEWoUFfFxQ/QhIdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIyiuGbpjH+UwiM14II7zCq9vxempSASh5e/4jibZtXQrqcCLRSEBftGuDVcpPsszPttcPeE5+KOtpTgxvl0W9Oo6zalVMvv45Px8SvRWa94Srn3K1Dl1MgK8UJSe6M1ChSxwSDJDsG/MLaabKgyktakSf7uunYfuIubSwnFYMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c54e/Nwx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4iwMuXjBPgFGxPso4ubWwnLkIZGgBFP6ZUk3Gsb7Wg8=; b=c54e/NwxA4A3TOBOlZO3tEKKG1
	pG0pk+DYUAK6fZrD6PBp9MqswX1KY9uA1VYQgxwGEZrua8j2B1TKrYAozcJPGYlnya3hxj7KafiOd
	xJUzHpz+i23zerrPD3DJIEUaHvCiKo4OVcYoOmITvhJIlkBYm5AmDuit1JN6TtvYKh584+A2j7PYl
	arDwDuU1MRk1FjCSQw/POxz5WZ31ofRLg347e7fUED/CVJI3dd78DLb67MMEoxBlDqo2jPq5CJVr5
	sV6EfDg+uKxSXgbWYcFgD0rQPP+haUeR4LBeiuRE4kVjBQKdiXDXfp9hpBgFPhKdE8qbFmGwKfml3
	jBOdBxXQ==;
Received: from 2a02-8389-2341-5b80-9d5d-e9d2-4927-2bd6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9d5d:e9d2:4927:2bd6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfvZ1-00000005PRW-23Se;
	Thu, 06 Feb 2025 06:40:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/11] iomap: allow the file system to submit the writeback bios
Date: Thu,  6 Feb 2025 07:39:59 +0100
Message-ID: <20250206064035.2323428-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206064035.2323428-1-hch@lst.de>
References: <20250206064035.2323428-1-hch@lst.de>
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 Documentation/filesystems/iomap/operations.rst | 11 +++++------
 fs/iomap/buffered-io.c                         | 10 +++++-----
 fs/xfs/xfs_aops.c                              | 13 +++++++++----
 include/linux/iomap.h                          | 12 +++++++-----
 4 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 2c7f5df9d8b0..04fc7a49067d 100644
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
index d303e6c8900c..7952bf004bdb 100644
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
index 67877c36ed11..aa88895673d8 100644
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
index 75bf54e76f3b..dc8df4f779d4 100644
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


