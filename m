Return-Path: <linux-fsdevel+bounces-54510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BC4B003A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE111C401DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02319267AFC;
	Thu, 10 Jul 2025 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l2m0Z+vp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9DB259C92;
	Thu, 10 Jul 2025 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154468; cv=none; b=X4EtO4fgsjADUPqwYgo0DpMFk0NTkS6KS5dnVaTHm/YyAEUkXkxmZCU3Wa5mq36hvBmCY4F+mAtTvX5gzzaK937YCeULEZvDyztZsPB8xWXKTB8+gNQMKSdziHw89ILsfjmbGJkmjSmIRLztC8YRtGwbWR4PJcKDzAfHwr9BcYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154468; c=relaxed/simple;
	bh=CZiHK4Ct/J3X1y+Nlx4kdDqVF8OWA+IwYy+rO/QAWuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQqjplEZisS7Q08V9rPP+OscX7OkdjkfhO4LXlNkq55E0Dt6NDPsqfWlPeqUa8d+nEuA9Zo8N1MikiTkmfRKE1tdgmDRZdZ496lF/lJAXwvpnCUjTmPEQ8fDH0rWaWf4/juMVClP2Bwq7WRmvIgT7vLZtC8DZMyJceHTZbM8UPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l2m0Z+vp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MYibhmUBO3tjPnmaxT/+vVFr554rn8RJ5iOOGlI3pz0=; b=l2m0Z+vpbW6iVqWbp50gguwEz4
	p3MEonCdgrmppUlw/OjJF3pR3MtsmYboTF65Gq/cF/U8QSEEqj0CEqSP8rpFXWuJ25vGVYmFTt8In
	OMjSGg8ZqaNcj0WCDbJmWSFr2XwPl0mSAhSOvBKcZelMjis8VEB8JLhGhIO0Z5tHVNQv+VZ3cMg0j
	l7oHH6BeSE0AY3Vls2i2SRBU+Uzc0ItWrIDEcxa9oa2jXriiGU16R5O0SBTKGDhY+jWVyed9UaxBW
	Eee4I97edBBjFw5V3bC7LdyDPi036LYWqCw246Knz7qwuEtwpXDqHvY/pLbcunLXG+5UnYQKw7Oo/
	LmI7esng==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZrPu-0000000BwbL-1W70;
	Thu, 10 Jul 2025 13:34:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 12/14] iomap: improve argument passing to iomap_read_folio_sync
Date: Thu, 10 Jul 2025 15:33:36 +0200
Message-ID: <20250710133343.399917-13-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710133343.399917-1-hch@lst.de>
References: <20250710133343.399917-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass the iomap_iter and derive the map inside iomap_read_folio_sync
instead of in the caller, and use the more descriptive srcmap name for
the source iomap.  Stop passing the offset into folio argument as it
can be derived from the folio and the file offset.  Rename the
variables for the offset into the file and the length to be more
descriptive and match the rest of the code.

Rename the function itself to iomap_read_folio_range to make the use
more clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9f2cc5dd7e80..8a44f56a3a80 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -658,22 +658,22 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
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
 
 static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
 		struct folio *folio)
 {
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct iomap_folio_state *ifs;
 	loff_t pos = iter->pos;
 	loff_t block_size = i_blocksize(iter->inode);
@@ -722,8 +722,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
 			if (iter->flags & IOMAP_NOWAIT)
 				return -EAGAIN;
 
-			status = iomap_read_folio_sync(block_start, folio,
-					poff, plen, srcmap);
+			status = iomap_read_folio_range(iter, folio,
+					block_start, plen);
 			if (status)
 				return status;
 		}
-- 
2.47.2


