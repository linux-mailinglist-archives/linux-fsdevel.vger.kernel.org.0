Return-Path: <linux-fsdevel+bounces-74800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCLVM4t2cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:47:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0C3524BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 025DC4E0B2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001BE44CACB;
	Wed, 21 Jan 2026 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RBhKoeDu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1644B67E;
	Wed, 21 Jan 2026 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977850; cv=none; b=TRgvesSNdIruDSCyHKWFDeTbm/3uwXkAwdAcjAg2wt9REo7to+LO13rlmUlgVun9Lpeh87C7x3of2GrhtC5cy7lUg9ekhAX+eQw13YiyrA0JvhYnKSCF8ABTImB2JbuSoXyo9snnBcpbsGR81mUKqZsHgrxs0SypfKexg/3d3LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977850; c=relaxed/simple;
	bh=Ntjyew39ErKjlsjUqzM3tKlsCNohsHmGkw9G6FyrUvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+QPV8pMuDcEjojwRCGanJiAAJYOi1zU40H2WifoNCGCCAiR3oO3uidMAApW9Tdz2CHBa+Rzuusqplo0YEgf7zByQc+hjjV7+4Rjism7oi+t4evU0onWbalAMxTQpgKNL0TzCYkj8Gcv1gaEiLS6YHm/r+O4V1G7zqecO1cr424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RBhKoeDu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kVXRZ7/O6YUcjTJT0lFFH0r13TLIIHHS9dvXLs6XMPw=; b=RBhKoeDuT20HoTwI9lsvM6gSXl
	0elSLHA3x1zS+R+hjXnQnb8tqRQrj3l2PMLLJTHVQ4f/9IuYUPiLFdCfHMnoA0ayyUIUseudFhBKl
	XxFElD+rJpl3Ko/MXrGi854EkUY+ZPqFaLUNBdQ5wNnh0wKAV6g3QERFpxSa9t/RinEAuJgW+d6gh
	k1i+UWF/+L1Lxfc9357K21/8NX6QOZsoYveq1/10XwqxyXln710jqfFVprLoj8R97yGIWK+jri+Pm
	uB3SMQA53r1ZI5oekqdU5Kn3QiFZ1UkOwIQdt5zxgL+vu5yal7sRVukS4BM+6GaHDS17LmWsO02a0
	TCsV5TBA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viRwj-00000004xZR-0qzu;
	Wed, 21 Jan 2026 06:44:05 +0000
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
Subject: [PATCH 04/15] block: prepare generation / verification helpers for fs usage
Date: Wed, 21 Jan 2026 07:43:12 +0100
Message-ID: <20260121064339.206019-5-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-74800-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,infradead.org:dkim,lst.de:email,lst.de:mid]
X-Rspamd-Queue-Id: 9C0C3524BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Return the status from verify instead of directly stashing it in the bio,
and rename the helpers to use the usual bio_ prefix for things operating
on a bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-auto.c |  4 ++--
 block/blk.h                |  6 ++++--
 block/t10-pi.c             | 12 ++++++------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 5345d55b9998..f68a17a8dbc2 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -39,7 +39,7 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 		container_of(work, struct bio_integrity_data, work);
 	struct bio *bio = bid->bio;
 
-	blk_integrity_verify_iter(bio, &bid->saved_bio_iter);
+	bio->bi_status = bio_integrity_verify(bio, &bid->saved_bio_iter);
 	bio_integrity_finish(bid);
 	bio_endio(bio);
 }
@@ -100,7 +100,7 @@ void bio_integrity_prep(struct bio *bio, unsigned int action)
 
 	/* Auto-generate integrity metadata if this is a write */
 	if (bio_data_dir(bio) == WRITE && bip_should_check(&bid->bip))
-		blk_integrity_generate(bio);
+		bio_integrity_generate(bio);
 	else
 		bid->saved_bio_iter = bio->bi_iter;
 }
diff --git a/block/blk.h b/block/blk.h
index 886238cae5f1..d222ce4b6dfc 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -695,8 +695,10 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	      const struct blk_holder_ops *hops, struct file *bdev_file);
 int bdev_permission(dev_t dev, blk_mode_t mode, void *holder);
 
-void blk_integrity_generate(struct bio *bio);
-void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter);
+void bio_integrity_generate(struct bio *bio);
+blk_status_t bio_integrity_verify(struct bio *bio,
+		struct bvec_iter *saved_iter);
+
 void blk_integrity_prepare(struct request *rq);
 void blk_integrity_complete(struct request *rq, unsigned int nr_bytes);
 
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 0c4ed9702146..d27be6041fd3 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -372,7 +372,7 @@ static void ext_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 	}
 }
 
-void blk_integrity_generate(struct bio *bio)
+void bio_integrity_generate(struct bio *bio)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
@@ -404,7 +404,7 @@ void blk_integrity_generate(struct bio *bio)
 	}
 }
 
-void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter)
+blk_status_t bio_integrity_verify(struct bio *bio, struct bvec_iter *saved_iter)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
@@ -439,11 +439,11 @@ void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter)
 		}
 		kunmap_local(kaddr);
 
-		if (ret) {
-			bio->bi_status = ret;
-			return;
-		}
+		if (ret)
+			return ret;
 	}
+
+	return BLK_STS_OK;
 }
 
 void blk_integrity_prepare(struct request *rq)
-- 
2.47.3


