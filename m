Return-Path: <linux-fsdevel+bounces-77506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCUiIftYlWnQPAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:15:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD05A153486
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80340306C522
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A2830B502;
	Wed, 18 Feb 2026 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JapqPyvg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C62DC323;
	Wed, 18 Feb 2026 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395206; cv=none; b=CFdacPSjr26tgZ3QZDy2pB2UPgANSB7ae+nFNjqDsAtfgUWDL2u0cnL8vPogiyXkWLZCHPL4GYUG73paJfFzc7zMSuDBMJdz+UZzvlRJOjxZUaVMTHiehtsh0gjNz9OwzUWLfzRr9BVxEVbqed0XmeweT9cWmovEiRSqiHSgo1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395206; c=relaxed/simple;
	bh=JjRpNV43+JVAZAK6UyRVt2Hmx/JIox7A/aSWfNv2vwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTUu6vS1xtaqzRONu4BSknEibuJMDC0UvQuLdYchW/FqV71MAGeP5P4MJFCZDmwBJFRYchxhKyKBmlZxGwd6D/DS+EFe8B4H0kv2cVCM036NvAWugizBVE7mwPDa+EgcgryXndH+eHQt2bO0N9dwSSJ6NhCyN8fKHDXGmGnodkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JapqPyvg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tN8SE5fjBueFX4lP2oejn9oTRT6JmDu7sB67AdEPXXo=; b=JapqPyvgPDK4feDldFzwF89Ets
	95OqQYH4sJmYukeEWHkAbl/eQhzHviFDXJpHN3pI/6EGs+ByeKLYNyrH8uxKgEo+hH7pj/k36eAnx
	SwGYrrN982PqnGY5+11seQ6uZG/8u5EztnKMWFyrDxEXry0J3wwkaX3+4AEnUrgyiIlmSfFhgAME9
	pk51WhcNAGLkHDkEMeCXiyS2wNE6pSkMqtwE/qsGpK4Fef3vYUzGcF9k7P0a+9DPOpN8Q9LTeBY34
	gXlUcxKhmyD5XVT1Z8k99Lnab4CHc7masHe9C0V4spnOsViCgszpMPjkFUFQew5epR4ASL2FNmcSQ
	tINeURlg==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsaoO-00000009LTF-09T0;
	Wed, 18 Feb 2026 06:13:24 +0000
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
Subject: [PATCH 08/15] iomap: refactor iomap_bio_read_folio_range
Date: Wed, 18 Feb 2026 07:12:02 +0100
Message-ID: <20260218061238.3317841-9-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-77506-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,infradead.org:dkim,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD05A153486
X-Rspamd-Action: no action

Split out the logic to allocate a new bio and only keep the fast path
that adds more data to an existing bio in iomap_bio_read_folio_range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/iomap/bio.c | 69 +++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
index fc045f2e4c45..578b1202e037 100644
--- a/fs/iomap/bio.c
+++ b/fs/iomap/bio.c
@@ -26,45 +26,50 @@ static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
 		submit_bio(bio);
 }
 
-static int iomap_bio_read_folio_range(const struct iomap_iter *iter,
+static void iomap_read_alloc_bio(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, size_t plen)
 {
-	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
-	loff_t pos = iter->pos;
-	size_t poff = offset_in_folio(folio, pos);
-	loff_t length = iomap_length(iter);
-	sector_t sector;
+	unsigned int nr_vecs = DIV_ROUND_UP(iomap_length(iter), PAGE_SIZE);
+	struct folio *folio = ctx->cur_folio;
+	gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
+	gfp_t orig_gfp = gfp;
 	struct bio *bio = ctx->read_ctx;
 
-	sector = iomap_sector(iomap, pos);
-	if (!bio || bio_end_sector(bio) != sector ||
-	    !bio_add_folio(bio, folio, plen, poff)) {
-		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
-		gfp_t orig_gfp = gfp;
-		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
+	if (bio)
+		submit_bio(bio);
+
+	/* Same as readahead_gfp_mask: */
+	if (ctx->rac)
+		gfp |= __GFP_NORETRY | __GFP_NOWARN;
 
-		if (bio)
-			submit_bio(bio);
+	/*
+	 * If the bio_alloc fails, try it again for a single page to avoid
+	 * having to deal with partial page reads.  This emulates what
+	 * do_mpage_read_folio does.
+	 */
+	bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ, gfp);
+	if (!bio)
+		bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
+	if (ctx->rac)
+		bio->bi_opf |= REQ_RAHEAD;
+	bio->bi_iter.bi_sector = iomap_sector(iomap, iter->pos);
+	bio->bi_end_io = iomap_read_end_io;
+	bio_add_folio_nofail(bio, folio, plen,
+			offset_in_folio(folio, iter->pos));
+	ctx->read_ctx = bio;
+}
+
+static int iomap_bio_read_folio_range(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx, size_t plen)
+{
+	struct folio *folio = ctx->cur_folio;
+	struct bio *bio = ctx->read_ctx;
 
-		if (ctx->rac) /* same as readahead_gfp_mask */
-			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
-				     gfp);
-		/*
-		 * If the bio_alloc fails, try it again for a single page to
-		 * avoid having to deal with partial page reads.  This emulates
-		 * what do_mpage_read_folio does.
-		 */
-		if (!bio)
-			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
-		if (ctx->rac)
-			bio->bi_opf |= REQ_RAHEAD;
-		bio->bi_iter.bi_sector = sector;
-		bio->bi_end_io = iomap_read_end_io;
-		bio_add_folio_nofail(bio, folio, plen, poff);
-		ctx->read_ctx = bio;
-	}
+	if (!bio ||
+	    bio_end_sector(bio) != iomap_sector(&iter->iomap, iter->pos) ||
+	    !bio_add_folio(bio, folio, plen, offset_in_folio(folio, iter->pos)))
+		iomap_read_alloc_bio(iter, ctx, plen);
 	return 0;
 }
 
-- 
2.47.3


