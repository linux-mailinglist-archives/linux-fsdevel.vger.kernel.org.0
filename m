Return-Path: <linux-fsdevel+bounces-54259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40B5AFCCA6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C847ABE5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57202E0931;
	Tue,  8 Jul 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iw9q+myZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B972DF3F2;
	Tue,  8 Jul 2025 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982731; cv=none; b=rVTk3Tos5ig13f1G4ifsQ2urQrDVg89+ccewZAJB1+zPEFVXW4hzP6P/d/+EafM+vbF6HQfdAeHv2Mbo3T8kFFctW2xAtRRPmyqa+Q+xdop+T7fgsXa5nUFPA4q8XeH1hSju8N+keMmdowJ+qSjoD3znQVZuqTfrEPiEgyfpNhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982731; c=relaxed/simple;
	bh=aG/ubX3HzVJ9Xyi6IrJQIZfseNv+M3e07qGp1Wk5Rjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exnZwUcXK9lDhCG36A9jdBnVc1AoY35orYPs701lYAdUB1VMVQRoxXSQ++ZD6wzFGzDd+lrCtrfQtVkNcR3vztFI7yDrNoBYJjQDHMbtY4s+p863/BXg7+b0bTLIRXqZCcCZP9kq+pTIOR/kiivsFv1V0Z8028sVEZQ6Pc46qBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Iw9q+myZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HlgogCQftBC4HdKw5pio/naUv0LcwIEC38Af0VS3Rdc=; b=Iw9q+myZcOxu6CVlfjM8gl5APc
	1jhxRmPsBF+r5M8UU5qf+8lUbvtAMCqwxucG+aDwPWk/FbUZaE/mUXKR3dk1nwwLmoMI4RlIYTwUn
	JOybXqCtzy4wj/0WJ2BnAzfRcaKyph+oDEMTBaCMQLhIidWxKjjKVFRUlxaxacA2Dzc9yW9/zttsG
	GdsvW2W2w39OqKxJnM58djg3IC8MaaRAiVrW3+J/dpAcgJtHZ7pHYMlf4YP8yFLW79R2G5Nla4gN+
	fHsV4dOCdFNcrLVh71q/7bBGkwoySsOgpb/DN8qvg5dOWYJzjSr/0FojMITPKEOceHGkXjdhD/mt6
	RNTdFq8w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ8jx-00000005UX5-0JiY;
	Tue, 08 Jul 2025 13:52:09 +0000
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
Date: Tue,  8 Jul 2025 15:51:18 +0200
Message-ID: <20250708135132.3347932-13-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250708135132.3347932-1-hch@lst.de>
References: <20250708135132.3347932-1-hch@lst.de>
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
---
 fs/iomap/buffered-io.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b04c00dd6768..c73048062cb1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -657,22 +657,22 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
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
@@ -721,8 +721,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
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


