Return-Path: <linux-fsdevel+bounces-53143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E554AEAF92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE5D1881640
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 07:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4CF21CC63;
	Fri, 27 Jun 2025 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lqjbZvgu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D3C21B9D8;
	Fri, 27 Jun 2025 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007818; cv=none; b=eGxWkiI4skmVX1AeyK/aaljC67nNxvYBmc2HVLoHrQsHl5C0z6oZoMQEGukKjy2otjnwCfk+ByU4BgLJo+tRbrXsq4PINXEtOP+2udSIDe8XwOH866vXu83pjUWwURjkCgDMfJlZPsuMOyCJs8uHkfjnjz0qlcqJ4GfXlnBuZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007818; c=relaxed/simple;
	bh=QQd2ZYRUYBZUvF09GJjPydEoUdHjbU2ScuB1Ey+i6Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7LbmkoneS2/Q0mGjme9Enyp7WcJxBtpGoVOcg+Q39EElLm1Jm8s7SpFHR4SDfblCz01vGEbRCkhKeBmh4RGYOrft7ZecmseavN52o/d0+0IXBsJ2xfJolCYcAqYKJ92VxYKR6Tj16vlpbpTcTA+k8mVJtVOMK4fUD1Jnz4EEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lqjbZvgu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qJ+EGQSe8DBwiHDWeZzYI5g+y2hilJdlTtl7w4a0AsI=; b=lqjbZvguYM6CFznTjflwWKPijh
	Sqo7HaQTcTrcM/MLBmdjL+9uNu4QLx1vGajyFoePLjXY4E5h5GJS2LD9alquxIQ2WzCHeBIsf3Mhq
	JLeho7p9OT60eERE7Tvh6M1WilwxUQeasmlKgCaMBicfAIFTh6DrICFOcvFHo5FwKGBjSlf+sgsjB
	hOwqG4OLcOxte69BCSrTCKc06L3QJgD8GdFjEI5S+dkSxawkz2DOeBaAw7gULUeuWPmUeyBnXlT3o
	v7kgJ0CjQRI8NIGpItvE/1eGcYLLnabok5qVAibCmdo8BQUGDCv2E9EPPf6kYN1L13iMHUqdObK6n
	hc0ip3IQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV37Y-0000000Dlt9-1CeQ;
	Fri, 27 Jun 2025 07:03:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/12] iomap: cleanup the pending writeback tracking in iomap_writepage_map_blocks
Date: Fri, 27 Jun 2025 09:02:35 +0200
Message-ID: <20250627070328.975394-3-hch@lst.de>
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

We don't care about the count of outstanding ioends, just if there is one.
Replace the count variable passed to iomap_writepage_map_blocks with a
boolean to make that more clear.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: rename the variable, update the commit message]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/iomap/buffered-io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b5162e0323d0..ec2f70c6ec33 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1758,7 +1758,7 @@ static int iomap_add_to_ioend(struct iomap_writeback_ctx *wpc,
 
 static int iomap_writepage_map_blocks(struct iomap_writeback_ctx *wpc,
 		struct folio *folio, u64 pos, u64 end_pos, unsigned dirty_len,
-		unsigned *count)
+		bool *wb_pending)
 {
 	int error;
 
@@ -1786,7 +1786,7 @@ static int iomap_writepage_map_blocks(struct iomap_writeback_ctx *wpc,
 			error = iomap_add_to_ioend(wpc, folio, pos, end_pos,
 					map_len);
 			if (!error)
-				(*count)++;
+				*wb_pending = true;
 			break;
 		}
 		dirty_len -= map_len;
@@ -1873,7 +1873,7 @@ static int iomap_writepage_map(struct iomap_writeback_ctx *wpc,
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	u64 end_aligned = 0;
-	unsigned count = 0;
+	bool wb_pending = false;
 	int error = 0;
 	u32 rlen;
 
@@ -1917,13 +1917,13 @@ static int iomap_writepage_map(struct iomap_writeback_ctx *wpc,
 	end_aligned = round_up(end_pos, i_blocksize(inode));
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
 		error = iomap_writepage_map_blocks(wpc, folio, pos, end_pos,
-				rlen, &count);
+				rlen, &wb_pending);
 		if (error)
 			break;
 		pos += rlen;
 	}
 
-	if (count)
+	if (wb_pending)
 		wpc->nr_folios++;
 
 	/*
@@ -1945,7 +1945,7 @@ static int iomap_writepage_map(struct iomap_writeback_ctx *wpc,
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
 	} else {
-		if (!count)
+		if (!wb_pending)
 			folio_end_writeback(folio);
 	}
 	mapping_set_error(inode->i_mapping, error);
-- 
2.47.2


