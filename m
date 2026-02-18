Return-Path: <linux-fsdevel+bounces-77510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOXHMT1ZlWnQPAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:16:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 424561535C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 07:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7B943053751
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 06:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932B630B518;
	Wed, 18 Feb 2026 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DiKH87sh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB62E1F11;
	Wed, 18 Feb 2026 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395227; cv=none; b=k5NoX7HvxraNKWw4TWGkbsTn5ob/72gz5Q3gPk7BC9T6tVnXNd9HarjGixTo5B3Ls5DIIQ/IBfVhLby7nLx6/u3uK4y+HoZe4d4gsEdycQiNX6xPNRBMRFoJoXZHyQAr0YZFDaKaYlp/IcFLt0qOYUp83xpf2ynUxzOp++WnCrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395227; c=relaxed/simple;
	bh=g3WqADB/CtExA+D419i+LM5gXM7TVsAHM55P1gOYsHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpyyfvVKBI3GBT6jVBKMfVK96jKhBzUR8BoqnCu4vEyOxr00IZjk+vlg0gFR+gDdrjYpM0KMvYCRg6MsnZaQDBzDqf1laSGvNBV1aGU24KXgGh8LpXe9V/iJ42SBO3hZexiGDykZaFSE3gvIKM3x8MVkeiUvyKrp+L8kyv9j4W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DiKH87sh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6XrF7L7e7P5ijb0BotJj+nUuBpyobj5B8774xq21L6A=; b=DiKH87shiMxsQoYVrEurQnIbfe
	BvNs5ZL2KBmIDESGtsaObYAQwWFQZe6aRx+FwF2fZeBrpKi5YVIaA2NqMEFpIYmhHtdvXmou0EFaE
	/Vz4GeUE1hzVgepzEm2gJ2O3M/ZooB5tvl36Hw8gQoMwE6hwoyapgzt+SVKqNC6oPvqzB6M40z4iA
	2URFlo4Zmn4xURl9SsP32xnEzyMT9G5569T4q/EkOoYdNzXKuiYSdzojEVs2Uqm4ckuK9uGriFiym
	3oDoafgWwB2rKFrUViHmZPPt7u3MpNMYDPPqnjD0CQ/JMTV+/pf3TXUc+OyYfT0Ujri6Jo7UKbVu+
	LXBTkFPA==;
Received: from [2001:4bb8:2dc:9863:1842:9381:9c0f:de32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsaoi-00000009LVE-2AJr;
	Wed, 18 Feb 2026 06:13:44 +0000
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
Subject: [PATCH 12/15] iomap: add a bioset pointer to iomap_read_folio_ops
Date: Wed, 18 Feb 2026 07:12:06 +0100
Message-ID: <20260218061238.3317841-13-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-77510-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,lst.de:email,infradead.org:dkim,suse.com:email,samsung.com:email]
X-Rspamd-Queue-Id: 424561535C3
X-Rspamd-Action: no action

Optionally allocate the bio from the bioset provided in
iomap_read_folio_ops.  If no bioset is provided, fs_bio_set is still
used, which is the standard bioset for file systems.

Based on a patch from Goldwyn Rodrigues <rgoldwyn@suse.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/iomap/bio.c        | 14 ++++++++++++--
 include/linux/iomap.h |  6 ++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
index 903cb9fe759e..259a2bf95a43 100644
--- a/fs/iomap/bio.c
+++ b/fs/iomap/bio.c
@@ -24,11 +24,19 @@ static void iomap_bio_submit_read(const struct iomap_iter *iter,
 	submit_bio(ctx->read_ctx);
 }
 
+static struct bio_set *iomap_read_bio_set(struct iomap_read_folio_ctx *ctx)
+{
+	if (ctx->ops && ctx->ops->bio_set)
+		return ctx->ops->bio_set;
+	return &fs_bio_set;
+}
+
 static void iomap_read_alloc_bio(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, size_t plen)
 {
 	const struct iomap *iomap = &iter->iomap;
 	unsigned int nr_vecs = DIV_ROUND_UP(iomap_length(iter), PAGE_SIZE);
+	struct bio_set *bio_set = iomap_read_bio_set(ctx);
 	struct folio *folio = ctx->cur_folio;
 	gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 	gfp_t orig_gfp = gfp;
@@ -47,9 +55,11 @@ static void iomap_read_alloc_bio(const struct iomap_iter *iter,
 	 * having to deal with partial page reads.  This emulates what
 	 * do_mpage_read_folio does.
 	 */
-	bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ, gfp);
+	bio = bio_alloc_bioset(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
+			gfp, bio_set);
 	if (!bio)
-		bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
+		bio = bio_alloc_bioset(iomap->bdev, 1, REQ_OP_READ, orig_gfp,
+				bio_set);
 	if (ctx->rac)
 		bio->bi_opf |= REQ_RAHEAD;
 	bio->bi_iter.bi_sector = iomap_sector(iomap, iter->pos);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index b2b9e649a3b8..387a1174522f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -515,6 +515,12 @@ struct iomap_read_ops {
 	 */
 	void (*submit_read)(const struct iomap_iter *iter,
 			struct iomap_read_folio_ctx *ctx);
+
+	/*
+	 * Optional, allows filesystem to specify own bio_set, so new bio's
+	 * can be allocated from the provided bio_set.
+	 */
+	struct bio_set *bio_set;
 };
 
 /*
-- 
2.47.3


