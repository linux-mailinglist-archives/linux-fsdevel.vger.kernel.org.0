Return-Path: <linux-fsdevel+bounces-77941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ni69LopUnGnJEAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:22:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9DE176B98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29E4A3035F16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641211DE4FB;
	Mon, 23 Feb 2026 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="syQ/QvWU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAAF3A1D2;
	Mon, 23 Feb 2026 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852899; cv=none; b=fgWB2CEOzszrnXMDt32w4FBBF0A3Jr42cr5A3x0a6EGZEXtgkkQhAdbFHMJncHsgjZeG+uqSDrezBGSZb7xaf8WVlOW5UTnAHirQw6WfzJXG5oJPTgdv4K8Oh6vv7T2PbLnXX7w1fnLf9eNFOZf37B+I4+Jieni4vfF2VQPDxRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852899; c=relaxed/simple;
	bh=97R6Zqk8KOTBxYiRCwkZkCl/JKRWgt3YtUldXySPWTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyRCurEWnubJTPTSYaDxryBT7k+RZQXqQlpFuup3mRbV+FO0KojF2SpjZ6QXGGmVM7MZwZaXfhQh8bK9xEiDMqmKCcO8MVMC6y1zZ29txsuG76XkXx3RK44NgWmzzNe8Rsf6sFwS2vri/sOJVUApZxk7NjFP8Mirid2Zii5TLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=syQ/QvWU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zDlZ7C5fg3guCRskb4d4VSIF3gzJs69wkUBtdcPerFk=; b=syQ/QvWUVq46hiPYMaeGgyw2fP
	xF602aNd9wcqdgBcS9yOYlD6wR5mqX4Ls61r3iwEPg9lydututPz7ADLoNjWToelwj9vuBHsIiz0f
	3L39x/es8VmI0TFydqtOPY1xuj0AjkU5GED+6Be7APmWjUgzgTrL7aNo3FYDe1WkACy5jvm9NpOmI
	9rEzNAwZbvZEGhsVobLt4YAXbqrjKLV41uPWGLZphO4t1OR8cALvjkamkIKJvwXphzmLeCIj7Utnv
	DBW0WH0dn4ika969yFqKUeufFBJhgdMmg6u/P4ARSLyCdLjuJvsAE2DZDsO8fK/RkbaG6DD+PcoTq
	vXfZX4/g==;
Received: from [94.156.175.41] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuVsV-00000000Lw8-32qH;
	Mon, 23 Feb 2026 13:21:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 05/16] block: make max_integrity_io_size public
Date: Mon, 23 Feb 2026 05:20:05 -0800
Message-ID: <20260223132021.292832-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223132021.292832-1-hch@lst.de>
References: <20260223132021.292832-1-hch@lst.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77941-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,lst.de:mid,lst.de:email,samsung.com:email,infradead.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC9DE176B98
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
index dec0acaed6e6..11857ae13d10 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1881,6 +1881,24 @@ static inline int bio_split_rw_at(struct bio *bio,
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


