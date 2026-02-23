Return-Path: <linux-fsdevel+bounces-77948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAhjG2JWnGkAEQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:30:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB936176E97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AECE307DC4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C301E376C;
	Mon, 23 Feb 2026 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A2Rax5Ek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019E156661;
	Mon, 23 Feb 2026 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852984; cv=none; b=iUbf7t6DJLTTBy6uHwc7Jl11LKyyw/W4nxre6fMLi3+ae7uuvlaclfYkXfeXANdt1yU6jMzXn0ENrV4BkmsUPfLX6kIjJJ2ZQRPr34xgPXVI8+Hrz/ousHsBg+v/VDwClNujKOYkiXAZSEfnfUjSGri84tfXhRXICDi55r12ZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852984; c=relaxed/simple;
	bh=jIDMXADie7TRTgwlMG+eyzO9dzf+cRhi2YvOetwo7nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ln3QD3ro1bSfmuCuJf3HDl6ffVXackDaSO8n29jzHkuIMQ+Qw0TbZfrLPLnId4Cq2sYP4ji/pSiCRDmjFlU8Turs3xkpK4N0jvaNDX2OHAjDi732Y3s7EViRKnnfPAntyZp/1jscc+JKY15zF8SGhAjfrAPcDZ/GbFibMKF8QpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A2Rax5Ek; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xixZZv3Lav3z9UV7R1tFg9JhXKX3aDxvZuwmSPB9lOI=; b=A2Rax5EkWA1LC0llznL+a9IbHm
	iVCrJNHXIAHegSn8niufdDF1Omd+54UXMHVtEcXLF1gwJ9zUPte7Qqt1mNU4kZ9iwmYEUtZ7OJ1rB
	Y6HOaG2GTIlfb6q1cQ8c6e6GtimdmBTY6DgGjDRlwGQQ8YQHQL4qwMIk0FO8tL4bQXnJTQKrO1rr0
	ExeQ9F0BIXJrQO5dlrCApJkhCkoC/KARlxzCiygEV5T/Y45BNQtK1WxxxEOmBZTFb8YzIeB1N+ygV
	fjkOnfGZvVKpnIRFRHO5QM1siGVK+X+nBpzrOQTlObUPizu2mvOOpR7SFoQ3kV6OttWyUkTXv3Mw9
	q/3CSX9A==;
Received: from [94.156.175.41] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuVtt-00000000M4V-0VsT;
	Mon, 23 Feb 2026 13:23:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 12/16] ntfs3: remove copy and pasted iomap code
Date: Mon, 23 Feb 2026 05:20:12 -0800
Message-ID: <20260223132021.292832-13-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223132021.292832-1-hch@lst.de>
References: <20260223132021.292832-1-hch@lst.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77948-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:mid,lst.de:email,infradead.org:dkim]
X-Rspamd-Queue-Id: AB936176E97
X-Rspamd-Action: no action

ntfs3 copied the iomap code without attribution or talking to the
maintainers, to hook into the bio completion for (unexplained) zeroing.

Fix this by just overriding the bio completion handler in the submit
handler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ntfs3/inode.c | 51 +++---------------------------------------------
 1 file changed, 3 insertions(+), 48 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 7ab4e18f8013..60af9f8e0366 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -605,63 +605,18 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-/*
- * Copied from iomap/bio.c.
- */
-static int ntfs_iomap_bio_read_folio_range(const struct iomap_iter *iter,
-					   struct iomap_read_folio_ctx *ctx,
-					   size_t plen)
-{
-	struct folio *folio = ctx->cur_folio;
-	const struct iomap *iomap = &iter->iomap;
-	loff_t pos = iter->pos;
-	size_t poff = offset_in_folio(folio, pos);
-	loff_t length = iomap_length(iter);
-	sector_t sector;
-	struct bio *bio = ctx->read_ctx;
-
-	sector = iomap_sector(iomap, pos);
-	if (!bio || bio_end_sector(bio) != sector ||
-	    !bio_add_folio(bio, folio, plen, poff)) {
-		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
-		gfp_t orig_gfp = gfp;
-		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
-
-		if (bio)
-			submit_bio(bio);
-
-		if (ctx->rac) /* same as readahead_gfp_mask */
-			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
-				gfp);
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
-		bio->bi_end_io = ntfs_iomap_read_end_io;
-		bio_add_folio_nofail(bio, folio, plen, poff);
-		ctx->read_ctx = bio;
-	}
-	return 0;
-}
-
 static void ntfs_iomap_bio_submit_read(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx)
 {
 	struct bio *bio = ctx->read_ctx;
 
+	bio->bi_end_io = ntfs_iomap_read_end_io;
 	submit_bio(bio);
 }
 
 static const struct iomap_read_ops ntfs_iomap_bio_read_ops = {
-	.read_folio_range = ntfs_iomap_bio_read_folio_range,
-	.submit_read = ntfs_iomap_bio_submit_read,
+	.read_folio_range	= iomap_bio_read_folio_range,
+	.submit_read		= ntfs_iomap_bio_submit_read,
 };
 
 static int ntfs_read_folio(struct file *file, struct folio *folio)
-- 
2.47.3


