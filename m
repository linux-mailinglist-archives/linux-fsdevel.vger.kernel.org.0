Return-Path: <linux-fsdevel+bounces-29861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF0497EE21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C952817FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EF819E804;
	Mon, 23 Sep 2024 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ayVMjlYv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB30199FC6;
	Mon, 23 Sep 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105355; cv=none; b=mcSyxfh5VZLpU3S95xbH4bS98a6dj8s9PxY3+OazqkWZrUzI9v0C/G5cckCRoIG0FwqiD0TY+SphVuwXb5iGV1GcJjv9q0n1IxLe2A6hpA5mdOAhjpKB+TrUcqxAWQ7fwaXtwo51ceQ978J2IVaUSkXAhVWyaIBHFAhO4oglb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105355; c=relaxed/simple;
	bh=tK9bAK5GkpcKf31jU2W8kdx0ZFktU8wuQVhjfD9tt0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hO35qBgsEaIiAng9ftt1fSk3Jab7n7wdzljpZB7NHQJM1/pvnSePav9o8KRVgOHHeKWPffeXvtj/M3wSNQM+Tm6vIagAXEdyYlVh87OTkhg0MDcGLIYdGKGzN5cVmR+S4j/prrue/qEHpCOmrEylCMXAcCrqbsOSWoSL94Q+FaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ayVMjlYv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6EZwtdoK8A8svjCRC2aLmFgcAruYXpKGsIOXsXbXiwc=; b=ayVMjlYvwwCG7Q/LXwRSuLT46R
	lwDjoQ3hcLOikphA13Zi/x26DMWAEQDdno7rECSrA325MaZhJ5j5IjRlY/DO2FdvG5suJl9T3zvz9
	dd8GlVBETDaPoqJDfZgA1cg9j6ajTgKcsUCt0ubzFBWh76WS0Vx0T94YnDFHeLCcwIQBpadvPs66Q
	tEXPw3ESvw8+w7CJ2S4IwIkwUPEYdB8CZJzctkHREwCGSNw4d4zou7T/ABtdLAPjZXbBubs1hqVXm
	mNERvPraa9mn6MByF8OEJHG8uhcQVDkQfRI1bvJ3UwKWXRV1YnMG4fLEw/3zLDJo76yIfoI/839I+
	nFRcGN+A==;
Received: from 2a02-8389-2341-5b80-4c13-f559-77bd-3c36.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c13:f559:77bd:3c36] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sskzw-0000000HV7T-13k9;
	Mon, 23 Sep 2024 15:29:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/10] iomap: factor out a iomap_last_written_block helper
Date: Mon, 23 Sep 2024 17:28:15 +0200
Message-ID: <20240923152904.1747117-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923152904.1747117-1-hch@lst.de>
References: <20240923152904.1747117-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Split out a pice of logic from iomap_file_buffered_write_punch_delalloc
that is useful for all iomap_end implementations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 13 ++-----------
 include/linux/iomap.h  | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 11ea747228aeec..884891ac7a226c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1280,7 +1280,6 @@ void iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 {
 	loff_t			start_byte;
 	loff_t			end_byte;
-	unsigned int		blocksize = i_blocksize(inode);
 
 	if (iomap->type != IOMAP_DELALLOC)
 		return;
@@ -1289,16 +1288,8 @@ void iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 	if (!(iomap->flags & IOMAP_F_NEW))
 		return;
 
-	/*
-	 * start_byte refers to the first unused block after a short write. If
-	 * nothing was written, round offset down to point at the first block in
-	 * the range.
-	 */
-	if (unlikely(!written))
-		start_byte = round_down(pos, blocksize);
-	else
-		start_byte = round_up(pos + written, blocksize);
-	end_byte = round_up(pos + length, blocksize);
+	start_byte = iomap_last_written_block(inode, pos, written);
+	end_byte = round_up(pos + length, i_blocksize(inode));
 
 	/* Nothing to do if we've written the entire delalloc extent */
 	if (start_byte >= end_byte)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4ad12a3c8bae22..e62df5d93f04de 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -256,6 +256,20 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
 	return &i->iomap;
 }
 
+/*
+ * Return the file offset for the first unused block after a short write.
+ *
+ * If nothing was written, round offset down to point at the first block in
+ * the range, else round up to include the partially written block.
+ */
+static inline loff_t iomap_last_written_block(struct inode *inode, loff_t pos,
+		ssize_t written)
+{
+	if (unlikely(!written))
+		return round_down(pos, i_blocksize(inode));
+	return round_up(pos + written, i_blocksize(inode));
+}
+
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops, void *private);
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
-- 
2.45.2


