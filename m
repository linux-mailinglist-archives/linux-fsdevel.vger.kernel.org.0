Return-Path: <linux-fsdevel+bounces-74801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DdeFKh2cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:48:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B41E7524E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6921B725587
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F9E44CADD;
	Wed, 21 Jan 2026 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fsHRDkbL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10C44CAC7;
	Wed, 21 Jan 2026 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977852; cv=none; b=bva8AJb9y2lL7+dNBW5gTmCRiWgbsQRELern1qVLjkcuJ5sKu/mz9Q8L3cLPynFf4Af1TKDLnhDZCZrIy7weDFADeFgloFQdbitM06HUgrgnC56ZsJSAtSbz7iYijBkxt2v+HL9n+EO+IRjxF5gVaasLfC5XvuAATPM6JkWYmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977852; c=relaxed/simple;
	bh=pag6WWCHrJmBJB9+C0Gb5Jl5HWSCPlkfGOtWvSzdslA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRmcr8OBOGIudYkNv+5nt7BTNYlcZ8momWLnK/1QRLmBHA/qOlJg7Xi3Evt/GXWcaa9vngzR3m50j+mgaP9wO+D2ta6gGWbvLY7cwnOkGxdTt5WPLqj3cQUQlyGCq1xKL5krywnACk52WmUVMbgYAYG48v3O+qbYC2iaPewwlWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fsHRDkbL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TbujKF9GAtSiu8uHvtjxQMXyk997lVVKBOml7tb0emM=; b=fsHRDkbLQNBqty+47Kw7qWzVJM
	tNrTCRubrOR3s9C4RDn57q9kL3L3zArb2kh9bTt6j7HB1oJElOE8MQh7uabWdOfGJan2xUd1uNxWC
	UWTjRPnj06/0pGHeXARR2zM2ejp4b3hs9/Z+w0bZZHs2xTlUKOy/NwY0uOPtaZh7MWtlHYkb16gyJ
	/JxLzcYa/ra69/okgVYA5rZmGt5KWle+BwnQnlW+N84CI+HR6iyKdR6bNyxk/EzEirkbRVUN3dYC3
	VQNmfATEvlRpuxaoRibFFpkUkB/GcYLHmZKfi5wLNR3piZH6Y3XhR6bRN0w+ovGMi7ISaqUC59Nim
	z0g0uYeA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viRwn-00000004xZo-1Q0S;
	Wed, 21 Jan 2026 06:44:09 +0000
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
Date: Wed, 21 Jan 2026 07:43:13 +0100
Message-ID: <20260121064339.206019-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121064339.206019-1-hch@lst.de>
References: <20260121064339.206019-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-74801-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,lst.de:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,infradead.org:dkim]
X-Rspamd-Queue-Id: B41E7524E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

File systems that generate integrity will need this, so move it out
of the block private or blk-mq specific headers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
index 91d12610d252..b2f34f696a4f 100644
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
index c1f3e6bcc217..8d4e622c1f98 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1875,6 +1875,24 @@ static inline int bio_split_rw_at(struct bio *bio,
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


