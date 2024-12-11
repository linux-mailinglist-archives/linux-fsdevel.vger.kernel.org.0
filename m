Return-Path: <linux-fsdevel+bounces-37030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51209EC7D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 09:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC012878B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2961EC4CD;
	Wed, 11 Dec 2024 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aXJh3qiE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6BF1EC01B;
	Wed, 11 Dec 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907274; cv=none; b=CXvGkrmvGSDewuI2rz47RfOtIuSt9fP/D4aNd97bbC4DoVuAxy2OZWnzEjdsYs98NnfeciFVUrYD1owY1wbapO1J5VmRjtKFYCf/SMrpyt1AB0qPJ7vp/eXfE1vfli734mUzoGEKv9k1bYtCkmzaKhl6VEr0okPrSnJtr4mEXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907274; c=relaxed/simple;
	bh=T4UibW0qe0vhQnj7r2LrfgZm8ndx8dIHC/r6v31aVGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fM5Jh1OUqCP+H+fECHF3j9A3283VjbngMMy2fIedH7X0BW6saNK+BLLJUFL8Et7ymbVpGMGwoA4EP36OXrEnbmHid0DGABCdRkCYz63Wf2shOdYaXSiJfNui8Z2Ue1zYm1P/6KWbWsGx2FNc98HSbIjYDWAHWK4b1b7AipZDPcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aXJh3qiE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bnbpkF4LYuqAW1u0l+zaLWTOdihoIJModTvdUdFBXT0=; b=aXJh3qiEtzk3t+pLrjZhA1EWwd
	XW3KtWrdYHJw+8pXA4q9ryJI7c3Ui7qHN5y3iRVt2FEQECzvYlzpZ8+SMeh+syobRLvk6WhTtVNuT
	jmHtCEIctxpneI1h0Fy0p5gEAQC89sDr3+1MIRfPCI6s+tt25XOcwv5eOoV4D14ne/I4ZCU2gbz6i
	UE4bGuzQ1HDKFIs8TJd5w9+1A4PT4uFn7eaC4hJDBh+ZdB5AGP+Q6gA4eih5l0/9f9IjdAq21Lf0n
	DQIRQaRPLmoU7nXzQObdBx9q6fZvO4aAFqbllTdBO9kn/Sqo0fq7kuY72FW5Aw4BXsImjNNL9rVW/
	n4AYLknA==;
Received: from [2001:4bb8:2ae:8817:935:3eb8:759c:c417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLIUK-0000000EIML-0zXp;
	Wed, 11 Dec 2024 08:54:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/8] iomap: add a IOMAP_F_ZONE_APPEND flag
Date: Wed, 11 Dec 2024 09:53:43 +0100
Message-ID: <20241211085420.1380396-4-hch@lst.de>
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

This doesn't much - just always returns the start block number for each
iomap instead of increasing it.  This is because we'll keep building bios
unconstrained by the hardware limits and just split them in file system
submission handler.

Maybe we should find another name for it, because it might be useful for
btrfs compressed bio submissions as well, but I can't come up with a
good one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 19 ++++++++++++++++---
 include/linux/iomap.h  |  7 +++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3176dc996fb7..129cd96c6c96 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1744,9 +1744,22 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
 		return false;
 	if (pos != wpc->ioend->io_offset + wpc->ioend->io_size)
 		return false;
-	if (iomap_sector(&wpc->iomap, pos) !=
-	    bio_end_sector(&wpc->ioend->io_bio))
-		return false;
+	if (wpc->iomap.flags & IOMAP_F_ZONE_APPEND) {
+		/*
+		 * For Zone Append command, bi_sector points to the zone start
+		 * before submission.  We can merge all I/O for the same zone.
+		 */
+		if (iomap_sector(&wpc->iomap, pos) !=
+		    wpc->ioend->io_bio.bi_iter.bi_sector)
+			return false;
+	} else {
+		/*
+		 * For regular writes, the disk blocks needs to be contiguous.
+		 */
+		if (iomap_sector(&wpc->iomap, pos) !=
+		    bio_end_sector(&wpc->ioend->io_bio))
+			return false;
+	}
 	/*
 	 * Limit ioend bio chain lengths to minimise IO completion latency. This
 	 * also prevents long tight loops ending page writeback on all the
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 1d8658c7beb8..173d490c20ba 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -56,6 +56,10 @@ struct vm_fault;
  *
  * IOMAP_F_BOUNDARY indicates that I/O and I/O completions for this iomap must
  * never be merged with the mapping before it.
+ *
+ * IOMAP_F_ZONE_APPEND indicates that (write) I/O should be done as a zone
+ * append command for zoned devices.  Note that the file system needs to
+ * override the bi_end_io handler to record the actual written sector.
  */
 #define IOMAP_F_NEW		(1U << 0)
 #define IOMAP_F_DIRTY		(1U << 1)
@@ -68,6 +72,7 @@ struct vm_fault;
 #endif /* CONFIG_BUFFER_HEAD */
 #define IOMAP_F_XATTR		(1U << 5)
 #define IOMAP_F_BOUNDARY	(1U << 6)
+#define IOMAP_F_ZONE_APPEND	(1U << 7)
 
 /*
  * Flags set by the core iomap code during operations:
@@ -111,6 +116,8 @@ struct iomap {
 
 static inline sector_t iomap_sector(const struct iomap *iomap, loff_t pos)
 {
+	if (iomap->flags & IOMAP_F_ZONE_APPEND)
+		return iomap->addr >> SECTOR_SHIFT;
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
 
-- 
2.45.2


