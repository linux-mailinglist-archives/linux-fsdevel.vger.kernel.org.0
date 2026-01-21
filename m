Return-Path: <linux-fsdevel+bounces-74808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NMoFJx3cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:52:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE96F52603
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85ACD740EEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE4844DB74;
	Wed, 21 Jan 2026 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f0NXtk/i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2370E44BCBA;
	Wed, 21 Jan 2026 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977884; cv=none; b=ZY3gCrbXFiq+Qna6+wgfB7IcwVZ2YQF/zxAHqNgXq/HpQxNc3ABFTpHILAU16fPRf3Xw7LmGSU1EvA550zRJ0tcV4ic6rtqIqR678AL0lWfbN3fLZubf2UGYB2bSwqAfXxmcJlhFh7AdJfzhi+1WrXcfXkrztWuVEbWVLOMR+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977884; c=relaxed/simple;
	bh=FRRUZihouPSekDtzULgxUeCMGV2Ge2mCfapC+ujPFKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMJ853V3k0XSTzoAJDk+bjgU8kTWc+9ZwSnLqWi1DqUITgL0cxBhVf+SNR1zRMOAH9UcQ8F/2YJ1G5Z8cyk+4DCSQWbm2IX7/KwWM76n8OwaM3RCUW+thynUrj4+xo9aEcuOe4OvIZF4H612I0DBTpKoRwkJz3avyPVALz10EI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f0NXtk/i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lwoRsljM62n6PzqVgE0BnZ5cQHdymA8oC+LukSYKsz0=; b=f0NXtk/i/fimPjwxiru1QCzY/b
	RUlZlJe8++KSdw9PZY/Ndma9bgGSLgiascyzGEefQWEsW3XrXdCJWFy1CVdmjAebt5qiy65inu7Vj
	57tFVRUPYDqc7Z6iORBVc1rOhOxSkjcxhpi+44aJ/Gz4dLsoFlpvJJVdGDLOyHLkTbfarwX9a2IxA
	tuktdWHNU4PeGzF+jzh2BKxqzMiQ5JpLLty7Fce7ZeF806QxFh1Uzi43u0r4o0Ad2Phlv1I9Fum2r
	hLs3SIkURtFL0/4W6qdodckcCZ7OKkONad9+tdv7YgAc6TlpjL3Uo42nZqP1lgXi4PnnkbZlh5kT5
	5cE6WphQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viRxJ-00000004xdV-2xks;
	Wed, 21 Jan 2026 06:44:42 +0000
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
Date: Wed, 21 Jan 2026 07:43:20 +0100
Message-ID: <20260121064339.206019-13-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-74808-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,lst.de:email,lst.de:mid,suse.com:email,infradead.org:dkim]
X-Rspamd-Queue-Id: BE96F52603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Optionally allocate the bio from the bioset provided in
iomap_read_folio_ops.  If no bioset is provided, fs_bio_set is still
used, which is the standard bioset for file systems.

Based on a patch from Goldwyn Rodrigues <rgoldwyn@suse.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
index b3f545d41720..24f884b6b0c4 100644
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


