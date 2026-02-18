Return-Path: <linux-fsdevel+bounces-77503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGFQGMlYlWnePAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:14:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B4515343E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE988305F65F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F148C30B518;
	Wed, 18 Feb 2026 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MFMC65ct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F932E1F11;
	Wed, 18 Feb 2026 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395191; cv=none; b=axYMJKyn1AcqBl3XN0/93ZSgwz0Q+1IuFvBLCrzI0Dl9OAmK2G+aRUJVTJL/SMTNbWtFsze7tLq+xO98Lcq8RJanReiN+8kmWBCAfNR7q7QDSs0kWPzpMIRnOK0k87yn2zEL0hu3u0QEgpj8dDLeaK6XAi9QHDIOVTUbuoM0Idg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395191; c=relaxed/simple;
	bh=97R6Zqk8KOTBxYiRCwkZkCl/JKRWgt3YtUldXySPWTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJICB6XQy728IAiDyB1UMi+MvtYeBBgtIkzOh1oLegSVWRzsxxyAa9T+HFiXSdEgcdnWaa+AugN4iBrq3pbLSxTMfvmjiWjp+lfw0dcMEwK1Fa2hyh3pq9BucXxwDvskZN+l3M1w1MzRoLn+LFbwBUsd8ZpfY0Q0c+5Et7X2ipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MFMC65ct; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zDlZ7C5fg3guCRskb4d4VSIF3gzJs69wkUBtdcPerFk=; b=MFMC65ctM98lbN9l29Lf4ZbUUh
	q8m62lDW7DV3A+PnGDaP+emUKnQN3Ftgt/E/mnPcFejhlGY75x4xLa5HN+8Tk7t/4bPafDvpeHvPs
	i0jgHKRuyvn4gdWXadhYZh+X871PkJtEdpCBNzpa/6ffCUmN7REzRNxqD6YhIQnj1VY+UL9MXlsAm
	6Szb1grL0e+jWEp7rGfuBozFr/bbmD327IdaUeXP5sigbFitL/KjganMUsFkJZ81zfb6fNfRl7lFS
	KlQLJga/vw/wy/uJC18CD/PO6AWyBKUn8+q2wifL+rO9c43fgGsL3ozJ13BhoyvIreLxqiS5yNgkc
	Sr3vUb5w==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsao9-00000009LRV-0seS;
	Wed, 18 Feb 2026 06:13:09 +0000
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
Date: Wed, 18 Feb 2026 07:11:59 +0100
Message-ID: <20260218061238.3317841-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218061238.3317841-1-hch@lst.de>
References: <20260218061238.3317841-1-hch@lst.de>
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
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77503-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,samsung.com:email]
X-Rspamd-Queue-Id: 00B4515343E
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


