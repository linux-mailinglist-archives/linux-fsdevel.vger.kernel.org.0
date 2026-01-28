Return-Path: <linux-fsdevel+bounces-75753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM/OHoo+emlB4wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:51:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCECA640E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03E6831319AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F09310627;
	Wed, 28 Jan 2026 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g1Twsj2p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846AF30F7FA;
	Wed, 28 Jan 2026 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616935; cv=none; b=PL1hZVOw091NVg0P43AqdzQcHBnMQr4W4qjn21MSPnee8OPqwZ6Yw3TxUQEI7ymfPCYk7Ofz9UI2+8s61Mx2vFdxRN9xjBq4MbU7BcUJvcqv+9cqMcWH/4BRydUXeA4rPI6Vgubtclm0rLzzMhDtXceD/Tefs/+7hx55lE4nb4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616935; c=relaxed/simple;
	bh=VhDHLzvjR3dRX1RgabBzA0yf+T3RznpBt3ZgxTkiffc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/AWuOTIlguvnEj5PeO+XoCz1bRG7PsuHdld4UKgXXLaei7o9XZG7R6Y/bh6xdyxy6hJaeFdiCylPgXyg80TiHRayNE5/4Q2hrpUtkjmcY1femnD01qdDUh5yo2/8nJqp0awU9byp6xtb0cM0OWrhNMjInDB2Pu1LJ4y2KbqCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g1Twsj2p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4UqmimBgC4T4VOBTAGjhdnWrrZqSlubemuVex5yTg5w=; b=g1Twsj2pYM4Wbm/vssMP9LhLPy
	2rJscyQCPJGEvM7fbiJ0M0Ti7YYKtePg31FopnA0/LjtkXhWTFIUyaIslyMmA9ar/pFYPGJZRHxqN
	y6BcP/KFS8Zs+4QqdRVhZYPhl4HyT0FxhZlhEpcsfjtKYZ0UtfyJKfOBp23/AsGFABU5/oqVYgWJt
	12v1RceRGQ7lDjxKAH88REfOHHpRVqzIeyjZNp70CxRhksjZUWQdkgJq/FWG5X11klcnpayzk+8bh
	cTcmBreHmUElGBe3eBmOIOON8Hb80hKeXn6u904U5LRw+1LVu+W09GUmFsmqItxWXvCmy+yjrkQHS
	6JeGMopg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl8Ca-0000000GMyV-1sig;
	Wed, 28 Jan 2026 16:15:33 +0000
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
Subject: [PATCH 02/15] block: factor out a bio_integrity_setup_default helper
Date: Wed, 28 Jan 2026 17:14:57 +0100
Message-ID: <20260128161517.666412-3-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75753-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,oracle.com:email,infradead.org:dkim,lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDCECA640E
X-Rspamd-Action: no action

Add a helper to set the seed and check flag based on useful defaults
from the profile.

Note that this includes a small behavior change, as we now only set the
seed if any action is set, which is fine as nothing will look at it
otherwise.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/bio-integrity-auto.c    | 14 ++------------
 block/bio-integrity.c         | 16 ++++++++++++++++
 include/linux/bio-integrity.h |  1 +
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index e16f669dbf1e..b64c71a7fc82 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -88,7 +88,6 @@ bool __bio_integrity_endio(struct bio *bio)
  */
 void bio_integrity_prep(struct bio *bio, unsigned int action)
 {
-	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_data *bid;
 
 	bid = mempool_alloc(&bid_pool, GFP_NOIO);
@@ -96,17 +95,8 @@ void bio_integrity_prep(struct bio *bio, unsigned int action)
 	bid->bio = bio;
 	bid->bip.bip_flags |= BIP_BLOCK_INTEGRITY;
 	bio_integrity_alloc_buf(bio, action & BI_ACT_ZERO);
-
-	bip_set_seed(&bid->bip, bio->bi_iter.bi_sector);
-
-	if (action & BI_ACT_CHECK) {
-		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
-			bid->bip.bip_flags |= BIP_IP_CHECKSUM;
-		if (bi->csum_type)
-			bid->bip.bip_flags |= BIP_CHECK_GUARD;
-		if (bi->flags & BLK_INTEGRITY_REF_TAG)
-			bid->bip.bip_flags |= BIP_CHECK_REFTAG;
-	}
+	if (action & BI_ACT_CHECK)
+		bio_integrity_setup_default(bio);
 
 	/* Auto-generate integrity metadata if this is a write */
 	if (bio_data_dir(bio) == WRITE && bip_should_check(&bid->bip))
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6bdbb4ed2d1a..0e8ebe84846e 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -101,6 +101,22 @@ void bio_integrity_free_buf(struct bio_integrity_payload *bip)
 		kfree(bvec_virt(bv));
 }
 
+void bio_integrity_setup_default(struct bio *bio)
+{
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	struct bio_integrity_payload *bip = bio_integrity(bio);
+
+	bip_set_seed(bip, bio->bi_iter.bi_sector);
+
+	if (bi->csum_type) {
+		bip->bip_flags |= BIP_CHECK_GUARD;
+		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
+			bip->bip_flags |= BIP_IP_CHECKSUM;
+	}
+	if (bi->flags & BLK_INTEGRITY_REF_TAG)
+		bip->bip_flags |= BIP_CHECK_REFTAG;
+}
+
 /**
  * bio_integrity_free - Free bio integrity payload
  * @bio:	bio containing bip to be freed
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 276cbbdd2c9d..232b86b9bbcb 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -143,5 +143,6 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 
 void bio_integrity_alloc_buf(struct bio *bio, bool zero_buffer);
 void bio_integrity_free_buf(struct bio_integrity_payload *bip);
+void bio_integrity_setup_default(struct bio *bio);
 
 #endif /* _LINUX_BIO_INTEGRITY_H */
-- 
2.47.3


