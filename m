Return-Path: <linux-fsdevel+bounces-75756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB39CQo4eml+4gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:23:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAA8A5881
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11F013085AF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E4A30FC3D;
	Wed, 28 Jan 2026 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WBG3LjMv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5132417C6;
	Wed, 28 Jan 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616957; cv=none; b=p8feOzfqAWG+w8MDunyt4I2ezAvDmW/OPgCqQ76GitaYoC/q9d61dNNJbCQKzXdWfub5TnotALTLp3ZQYcHYp+B+tRwSLKnkMlc9xB6yJwyX2H1ZgauxUplpAusCFz12B8dRbz1oKeua5r9lZUzUDJM3ieKxM2tWk5lDnmXG9PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616957; c=relaxed/simple;
	bh=suI/JnOg0bUVGNX0mQKAIzuhsQMCMB2aeejUGvOpmNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKcif1pxWdTUBBGIJwHEqb8nztR206FIupggsN7OM+TQzDxSoLCID+VYfiST29j93H0Z8vtwHrqMp6AhL6UBEgygRrJbtIMoBQ1ZrZhO+6vVYqpGY1aeGX4qT8QFUmn5lgtyzBRatSP3FYMDCfPS8OG3w4PrI2t3ZBAL6zBqOZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WBG3LjMv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lIVpuK4aaLDjf6kLA/+wEdjP/sq7KWclnc/O1171D/M=; b=WBG3LjMvGOILEgQNfEy8uMVIp8
	48H/MCCTM8Go8BcuVZ/7rBKFXM2ymaHRTalo9tdOiQeEHC6n7ckXcxAwyGObds/T3EWONXh0yS2y1
	NYJDjQKnAJGHUh+6B7SKORkjeaI8g2YtQty7cI2e1ANTO3eGwLIwvgDqHGMONBA3R+gDGsa+LOUbg
	8yUGomdtS3tJ3VbykkUukddqiWo1ZOzUtb80P3CWI60bZ5Zp9jTmmCnzIdkCFQ88+XPfP5KfXdAQg
	7JB07f3Z2IbpI53NIdF8OIJANLxUWNa612qZoIHEyGrzv0F/5CKYCfNFr8aB2ixEJDfCm96f/g/0u
	sEhVnSCA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl8Cw-0000000GMzf-16Qt;
	Wed, 28 Jan 2026 16:15:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 05/15] block: make max_integrity_io_size public
Date: Wed, 28 Jan 2026 17:15:00 +0100
Message-ID: <20260128161517.666412-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128161517.666412-1-hch@lst.de>
References: <20260128161517.666412-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75756-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:mid,lst.de:email,samsung.com:email]
X-Rspamd-Queue-Id: DAAA8A5881
X-Rspamd-Action: no action

File systems that generate integrity will need this, so move it out
of the block private or blk-mq specific headers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-settings.c          | 13 -------------
 include/linux/blk-integrity.h |  5 -----
 include/linux/blkdev.h        | 18 ++++++++++++++++++
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index a9e65dc090da..dabfab97fbab 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -123,19 +123,6 @@ static int blk_validate_zoned_limits(struct queue_limits *lim)
 	return 0;
 }
 
-/*
- * Maximum size of I/O that needs a block layer integrity buffer.  Limited
- * by the number of intervals for which we can fit the integrity buffer into
- * the buffer size.  Because the buffer is a single segment it is also limited
- * by the maximum segment size.
- */
-static inline unsigned int max_integrity_io_size(struct queue_limits *lim)
-{
-	return min_t(unsigned int, lim->max_segment_size,
-		(BLK_INTEGRITY_MAX_SIZE / lim->integrity.metadata_size) <<
-			lim->integrity.interval_exp);
-}
-
 static int blk_validate_integrity_limits(struct queue_limits *lim)
 {
 	struct blk_integrity *bi = &lim->integrity;
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index fd3f3c8c0fcd..ea6d7d322ae3 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -8,11 +8,6 @@
 
 struct request;
 
-/*
- * Maximum contiguous integrity buffer allocation.
- */
-#define BLK_INTEGRITY_MAX_SIZE		SZ_2M
-
 enum blk_integrity_flags {
 	BLK_INTEGRITY_NOVERIFY		= 1 << 0,
 	BLK_INTEGRITY_NOGENERATE	= 1 << 1,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed9b3777df9e..fd5f3458d0d0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1876,6 +1876,24 @@ static inline int bio_split_rw_at(struct bio *bio,
 	return bio_split_io_at(bio, lim, segs, max_bytes, lim->dma_alignment);
 }
 
+/*
+ * Maximum contiguous integrity buffer allocation.
+ */
+#define BLK_INTEGRITY_MAX_SIZE		SZ_2M
+
+/*
+ * Maximum size of I/O that needs a block layer integrity buffer.  Limited
+ * by the number of intervals for which we can fit the integrity buffer into
+ * the buffer size.  Because the buffer is a single segment it is also limited
+ * by the maximum segment size.
+ */
+static inline unsigned int max_integrity_io_size(struct queue_limits *lim)
+{
+	return min_t(unsigned int, lim->max_segment_size,
+		(BLK_INTEGRITY_MAX_SIZE / lim->integrity.metadata_size) <<
+			lim->integrity.interval_exp);
+}
+
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
 
 #endif /* _LINUX_BLKDEV_H */
-- 
2.47.3


