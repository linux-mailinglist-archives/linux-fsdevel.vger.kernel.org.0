Return-Path: <linux-fsdevel+bounces-74804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGEONs52cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:48:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8670152534
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C878E540FA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F12D44BCB4;
	Wed, 21 Jan 2026 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C6Xxj+A4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E82244BC86;
	Wed, 21 Jan 2026 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977866; cv=none; b=HBmb0WCCIUwi60pK9v1c8y77zNzusFpOtvia5UXxGbv7ihzovaoApTGzhQdVBVT8GBJdwWnH3JtwRyyof7RVtjQwk2QkQQoF2Soo/m8wKX4+S5YU+vekndQlBc4SABKcTi8V+lkxERc0p34Y62S8WmgKOrT9wtrBm+RVIiRRO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977866; c=relaxed/simple;
	bh=E7BqDIosR7eQGI/4umA/5TBtc926B7NC4jqimem8FWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyFUbDnd8nOt+sLA3DB5Llwyq9ZP+p7mCfNav/uHpWI9m9wF91H022acrQIuh4FyPijPopIyevK55RUJFaou2N/Is9BYacxJUmX7kuc7FcuTyCliEZeQf0r702/rVwgqJRof6fPY9tkPmivGoVPo4MS8Rifql5bH2T3LJPjqB2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C6Xxj+A4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2dVj85hU/rnsYGbalhRcB2Htg74Jlt0Dthx/li5pzrw=; b=C6Xxj+A4GAKqIIYPY1D6p9TJQG
	7OwHwiNtLk55ZQ5piPdRgV02n069aL4cJio15YWuASQnLB0lsg4Cqv/E/EBHrfp3bOExM/jW4ympM
	aSGvYzVwyEYBPc0C2lQ7JfznbUxGZe4EWR7EPg6OieRAICPrfmNHB77zEZUmF/3slqRSlWmyOYPJx
	KBL3OI55Eh/9CQ4TrblT4pJIn0uxPC+Xew2HZZ0nrNg9oMfVs7PfTdz1sqMeZn4w4sIVo8hANoBnO
	5RAWJ4XdF331uTLeU9oYsDZLnlJmRNgrrSbCANHAbXsyu1No7k+4rhgSXjlxOfIdDvVou5C/JdM8d
	8CLWcftw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viRx1-00000004xaR-1QdP;
	Wed, 21 Jan 2026 06:44:23 +0000
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
Date: Wed, 21 Jan 2026 07:43:16 +0100
Message-ID: <20260121064339.206019-9-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-74804-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 8670152534
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Split out the logic to allocate a new bio and only keep the fast path
that adds more data to an existing bio in iomap_bio_read_folio_range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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


