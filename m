Return-Path: <linux-fsdevel+bounces-77500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM1jFJdYlWnQPAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:13:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9991533EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0424B305148B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C52630B502;
	Wed, 18 Feb 2026 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3iuVNsoy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22D2DC323;
	Wed, 18 Feb 2026 06:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395176; cv=none; b=jIQRjxRF3kYJmKVehXBrtDiseY0sfPH2ZiYkHmb0GmRdS3em6OT6cDQT4WFWibxso5QBtTswxwLECfu1fcXxWzI9b126QSUmsgGx9BUbEir1TvbxmjQ7HcuyL4p5UbDeDfZcJdN6BBpYufWXC4toZbslSFv3cVicDjyTaFspPCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395176; c=relaxed/simple;
	bh=VhDHLzvjR3dRX1RgabBzA0yf+T3RznpBt3ZgxTkiffc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLD4VXoORVNw0Pjzbk72auReebt3DN0BNhvze9lv1mQNz7kwnETJhZcQTA1rnu+scblRTcRhSqJlejUhWaz46xa+uee07zMy6BKEoEv3YsOfDIKnRPvGwGG3IcxHVVBtt4VRLaDL8ouHWZWUbmZzDQYeGvmeZ71X4gqLwlZzapc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3iuVNsoy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4UqmimBgC4T4VOBTAGjhdnWrrZqSlubemuVex5yTg5w=; b=3iuVNsoyaIlsDsmbQOS64xrAmf
	j2X9noamJLv1WFiTjn9riB0vKN/xGR88Ek0/BJA8UAE2/u2Mbj+002kVg0sWjPCj3c0NrY+vtDMHD
	WXez/pfuyKpWtAp7dztPQVGEK5Tv7RelGL7W/P7HN18t0q0JB+ZJOUSgsfr50Z86SzYCQS+MTWimY
	Emh0ApTabAdQQ4jLVr7nMQLlBB7/1hNwK0agjhx+BHZeQ0B00Gneyh5OsfDvAjxp47n38ydFH+h45
	LdzY6zJAcDbc16IOLxWRVjHP2aPL5brQ8h9EdJ+dNjbEjeFTd1lhO8qUZwcdkDpNamRW4y53+X0YL
	HN7FN9zw==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsant-00000009LQo-3Mx3;
	Wed, 18 Feb 2026 06:12:54 +0000
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
Date: Wed, 18 Feb 2026 07:11:56 +0100
Message-ID: <20260218061238.3317841-3-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-77500-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,lst.de:email,infradead.org:dkim]
X-Rspamd-Queue-Id: BF9991533EA
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


