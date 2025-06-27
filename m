Return-Path: <linux-fsdevel+bounces-53152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE881AEAFB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA55C5681B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 07:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FCD219EA5;
	Fri, 27 Jun 2025 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ddK78HUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95144218589;
	Fri, 27 Jun 2025 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007846; cv=none; b=DKCYJuLdd1SUL7lhqKimajRs+rzzIjr9entOyzKdHsA5A8OGPx/a8dgnjHgY9+5fcTCUi1XL2xxWFom+ZTLanwuPzCHgb6x0+TPcU1tO0BQLqQcTVXohFO9uWd4Ultvljl+ohvxMsHR3q1SLDS5LbSU+wggC5uty2OUI77hM8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007846; c=relaxed/simple;
	bh=65BraAhI+1Wy3kY1jd5HEH9prNhMYQaJj1QE5dophLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UG0PKwZsRC+0Hm60SIlih2GtqpQ9Nc8GGfst+TD4oGxeYtHXcZ1BaRjroiQM18IMZTuDAnRA8jSZMw6RukzwJ16o703Psahdpz4kdk1KLeyD7GsW6+5citC8HR93R1f37+mdc5XMNt73wxHDtLtcEaIzPito9jQjgxp9Qz+8Q7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ddK78HUh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6HpSjMJ5x4YOsNiJEgKJg5RIoKSjnuB2p4RV8jTJK0M=; b=ddK78HUhOo8e15ST1m/IlfeoM8
	z5zqpIaJ519ekTh9tddbyEOkLojp9bonV4YBSzWrm9XilqvQrJm2tsmdrEHLfXOB8n1yjf7Gs97/s
	JaJsW57a0f4TNGAuqhbKINZ8wbmanENfF1VeSZHDxMqEz2Ihi0dJbJTOWuiBUpU02qkcUCVo66Lup
	of55pnvHvTtuMJMdq09JECX4oJkFnUldgIBETHW5zemRShh4WpqYOYPUXK5QF9TkSumhp6TYacMMq
	HDOKk88V5eubrhkHE4YUY62donxLg7yv9vle6WbOY9mZzB/BBGML9PcdslOMfvC1HDGXG4lU2q0MN
	EA8m0xgQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV37z-0000000Dm2F-2ksp;
	Fri, 27 Jun 2025 07:04:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 11/12] iomap: add read_folio_range() handler for buffered writes
Date: Fri, 27 Jun 2025 09:02:44 +0200
Message-ID: <20250627070328.975394-12-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627070328.975394-1-hch@lst.de>
References: <20250627070328.975394-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: Joanne Koong <joannelkoong@gmail.com>

Add a read_folio_range() handler for buffered writes that filesystems
may pass in if they wish to provide a custom handler for synchronously
reading in the contents of a folio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: renamed to read_folio_range, pass less arguments]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../filesystems/iomap/operations.rst          |  6 +++++
 fs/iomap/buffered-io.c                        | 25 +++++++++++--------
 include/linux/iomap.h                         | 10 ++++++++
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 167d3ca7819c..04432f40e7a2 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -68,6 +68,8 @@ The following address space operations can be wrapped easily:
      void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
                        struct folio *folio);
      bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+     int (*read_folio_range)(const struct iomap_iter *iter,
+     			struct folio *folio, loff_t pos, size_t len);
  };
 
 iomap calls these functions:
@@ -123,6 +125,10 @@ iomap calls these functions:
     ``->iomap_valid``, then the iomap should considered stale and the
     validation failed.
 
+  - ``read_folio_range``: Called to synchronously read in the range that will
+    be written to. If this function is not provided, iomap will default to
+    submitting a bio read request.
+
 These ``struct kiocb`` flags are significant for buffered I/O with iomap:
 
  * ``IOCB_NOWAIT``: Turns on ``IOMAP_NOWAIT``.
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a77686977a2e..1a9ade77aeeb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -667,22 +667,23 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 					 pos + len - 1);
 }
 
-static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
-		size_t poff, size_t plen, const struct iomap *iomap)
+static int iomap_read_folio_range(const struct iomap_iter *iter,
+		struct folio *folio, loff_t pos, size_t len)
 {
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct bio_vec bvec;
 	struct bio bio;
 
-	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
-	bio_add_folio_nofail(&bio, folio, plen, poff);
+	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
+	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
+	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
 	return submit_bio_wait(&bio);
 }
 
-static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
+static int __iomap_write_begin(const struct iomap_iter *iter,
+		const struct iomap_write_ops *write_ops, size_t len,
 		struct folio *folio)
 {
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct iomap_folio_state *ifs;
 	loff_t pos = iter->pos;
 	loff_t block_size = i_blocksize(iter->inode);
@@ -731,8 +732,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
 			if (iter->flags & IOMAP_NOWAIT)
 				return -EAGAIN;
 
-			status = iomap_read_folio_sync(block_start, folio,
-					poff, plen, srcmap);
+			if (write_ops && write_ops->read_folio_range)
+				status = write_ops->read_folio_range(iter,
+						folio, block_start, plen);
+			else
+				status = iomap_read_folio_range(iter,
+						folio, block_start, plen);
 			if (status)
 				return status;
 		}
@@ -848,7 +853,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(folio, pos, len, NULL, srcmap);
 	else
-		status = __iomap_write_begin(iter, len, folio);
+		status = __iomap_write_begin(iter, write_ops, len, folio);
 
 	if (unlikely(status))
 		goto out_unlock;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 482787013ff7..b3588dd43105 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -166,6 +166,16 @@ struct iomap_write_ops {
 	 * locked by the iomap code.
 	 */
 	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+
+	/*
+	 * Optional if the filesystem wishes to provide a custom handler for
+	 * reading in the contents of a folio, otherwise iomap will default to
+	 * submitting a bio read request.
+	 *
+	 * The read must be done synchronously.
+	 */
+	int (*read_folio_range)(const struct iomap_iter *iter,
+			struct folio *folio, loff_t pos, size_t len);
 };
 
 /*
-- 
2.47.2


