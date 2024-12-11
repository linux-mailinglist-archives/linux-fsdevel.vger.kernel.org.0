Return-Path: <linux-fsdevel+bounces-37028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11CC9EC7CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 09:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7567165E05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148921EC4E3;
	Wed, 11 Dec 2024 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j45nZ7jI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0D1E9B22;
	Wed, 11 Dec 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907269; cv=none; b=EtQwR35wlz5OF8qrJM26gzE/0la6vYVPFM26+lKbyP0P1bRnpFLAgMt13ym/wL33b8cMOu8aMaK9jIk3A4CVme6KAWWiE3Fq4ocREHVj4eAR8AV1WrcC2nS5F26XWMQEVUzHbVIrKiUVQocUqKJ9oXpezBEsTxZeNQ4i+G4mdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907269; c=relaxed/simple;
	bh=jIGjqxZwrfljsJ2IqDsJdT0YIF1tvbDSDS/bPNh9vpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hp4LW3oT11KuuNOET+6CQW8y4sXXsvb2bdb6raKvGhUzfC+u1X+xI6E+N5a+JELfKmWFGeSpAKPnFMO2JGJeDR0TuQWXjpvg9jp0jMXmTpwE6WxbeqAsklbnepaCRWhTA5ccMEwUtGWv/LetLfsgMoqQPzEeSojlxlAFWjImnPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j45nZ7jI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GMZJ1aE1TMzIm7COF1HrfqWjsuT15qgZ8FBpjzvYHEg=; b=j45nZ7jIbXztuqvrYfZEkhRLTq
	zDtDXxcxg5ZypyyBD0ssPQ0ETNox2CNFOYhJXGwoVL1hD+h5m0JH6WaRlZm6EhuD/pYohqprWt+dw
	3OGb34SZcyhjv8PusxWUuRrqKrL2zDa/RrvvTu/DcpdrfPI9xI1CxazTBRcNg7VaCmhLamLaBhFip
	Ch6QgIM1LV6expFy5yOb5w23N4f7M35UfWS9OPTVAr2Cf18R2bN0fySvYgXsb7z8QcnWBgL2IldAE
	cKZGALNrwiWbtobiv10sKP34H3UuSf38r8I7cr5OManp0pfwOORux9JxPRWGUn7bmU/U+Eudbx7Ig
	WRinhXAQ==;
Received: from [2001:4bb8:2ae:8817:935:3eb8:759c:c417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLIUF-0000000EIJi-0JtI;
	Wed, 11 Dec 2024 08:54:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/8] iomap: allow the file system to submit the writeback bios
Date: Wed, 11 Dec 2024 09:53:41 +0100
Message-ID: <20241211085420.1380396-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211085420.1380396-1-hch@lst.de>
References: <20241211085420.1380396-1-hch@lst.de>
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
 fs/iomap/buffered-io.c | 10 +++++-----
 fs/xfs/xfs_aops.c      | 13 +++++++++----
 include/linux/iomap.h  | 12 +++++++-----
 3 files changed, 21 insertions(+), 14 deletions(-)

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


