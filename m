Return-Path: <linux-fsdevel+bounces-75759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGAVF0s4eml+4gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:24:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1945AA5924
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A3A7309A26D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6730FC05;
	Wed, 28 Jan 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wm57KlP/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE222417C6;
	Wed, 28 Jan 2026 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616974; cv=none; b=OFOxzMoHvROBoqqSPnB/SMbU7bm2+TKlhP6jQxKpy6JEbQ/xFQ/gH68jUmuzgY+L481DIHwyIBvMlhjJHyH0m0tmI6KcKyc8OXZ+KvTQzknO8UToyAC9oX1lVeCGuJG/VkQ2WfUEHctvChmjHIzVMB4Qm7wedAZY+Aoz3cp6638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616974; c=relaxed/simple;
	bh=JjRpNV43+JVAZAK6UyRVt2Hmx/JIox7A/aSWfNv2vwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBo/RV6F2jovljx1ZLls9q9Fvw3r5D5bt5kgwQ0hiEL/v5G0gQ5wqL8OfLb37KxFu/oHIwD4Ua8wPc839jRDUQm35ik+QXWQr2jMbmfex41bz+qZwjcnWRpKSDwWq6k3AIDDeOnY4+abYenHhDJ1AwjnHp/gm3OBECuHE5UfNSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wm57KlP/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tN8SE5fjBueFX4lP2oejn9oTRT6JmDu7sB67AdEPXXo=; b=Wm57KlP/BXg9zhYIfLMzYde8jr
	m5BVssu38FcHlHj1x6FEy7nO+Qv8SFCEcjAsK63JIrBcjuKa96gQlbLcLcjIsQNF6je34rMhNn98G
	aE0fenGfwXELgv6w9+YwIyyE9nGhpBEqyr9j4ytXzbKdZnnKYWKOdWZDK+dI/Mj/AtCZR3PLdhpzJ
	o/LZpftqtFiseAX53FNPhZ26TvhigYsPvj0MaWZkShRjBB6KzqR9zqsLHsS7Q5x2Z28BSlXHYqQCG
	Z53mxVZFbXGY4LPsevIZ6x6wPVQ7ZCVBrxYeC2kftylWOWicMIVzaDBuyK28AHISl9YzirNeHsdx5
	wX+Mj8Rg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl8DD-0000000GN12-3lbt;
	Wed, 28 Jan 2026 16:16:12 +0000
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
Date: Wed, 28 Jan 2026 17:15:03 +0100
Message-ID: <20260128161517.666412-9-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75759-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim,samsung.com:email,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 1945AA5924
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


